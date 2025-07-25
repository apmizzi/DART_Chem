! Copyright 2019 University Corporation for Atmospheric Research and 
! Colorado Department of Public Health and Environment.
!
! Licensed under the Apache License, Version 2.0 (the "License"); you may not use 
! this file except in compliance with the License. You may obtain a copy of the 
! License at      http://www.apache.org/licenses/LICENSE-2.0
!
! Unless required by applicable law or agreed to in writing, software distributed
! under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR 
! CONDITIONS OF ANY KIND, either express or implied. See the License for the 
! specific language governing permissions and limitations under the License.
!
! Development of this code utilized the RMACC Summit supercomputer, which is 
! supported by the National Science Foundation (awards ACI-1532235 and ACI-1532236),
! the University of Colorado Boulder, and Colorado State University.
! The Summit supercomputer is a joint effort of the University of Colorado Boulder
! and Colorado State University.
!
! BEGIN DART PREPROCESS TYPE DEFINITIONS
! MOPITT_V8_CO_PROFILE, QTY_CO
! END DART PREPROCESS TYPE DEFINITIONS
!
! BEGIN DART PREPROCESS USE OF SPECIAL OBS_DEF MODULE
!   use obs_def_mopitt_v8_co_profile_mod, only : get_expected_mopitt_v8_co_profile, &
!                                  read_mopitt_v8_co_profile, &
!                                  write_mopitt_v8_co_profile, &
!                                  interactive_mopitt_v8_co_profile
! END DART PREPROCESS USE OF SPECIAL OBS_DEF MODULE
!
! BEGIN DART PREPROCESS GET_EXPECTED_OBS_FROM_DEF
!      case(MOPITT_V8_CO_PROFILE)                                                           
!         call get_expected_mopitt_v8_co_profile(state_handle, ens_size, location, obs_def%key, obs_time, expected_obs, istatus)  
! END DART PREPROCESS GET_EXPECTED_OBS_FROM_DEF
!
! BEGIN DART PREPROCESS READ_OBS_DEF
!      case(MOPITT_V8_CO_PROFILE)
!         call read_mopitt_v8_co_profile(obs_def%key, ifile, fileformat)
! END DART PREPROCESS READ_OBS_DEF
!
! BEGIN DART PREPROCESS WRITE_OBS_DEF
!      case(MOPITT_V8_CO_PROFILE)
!         call write_mopitt_v8_co_profile(obs_def%key, ifile, fileformat)
! END DART PREPROCESS WRITE_OBS_DEF
!
! BEGIN DART PREPROCESS INTERACTIVE_OBS_DEF
!      case(MOPITT_V8_CO_PROFILE)
!         call interactive_mopitt_v8_co_profile(obs_def%key)
! END DART PREPROCESS INTERACTIVE_OBS_DEF
!
! BEGIN DART PREPROCESS MODULE CODE

module obs_def_mopitt_v8_co_profile_mod

   use         apm_upper_bdy_mod, only :get_upper_bdy_fld, &
                                        get_MOZART_INT_DATA, &
                                        get_MOZART_REAL_DATA, &
                                        wrf_dart_ubval_interp, &
                                        apm_get_exo_coldens, &
                                        apm_get_upvals, &
                                        apm_interpolate

   use             types_mod, only : r8, MISSING_R8

   use         utilities_mod, only : register_module, error_handler, E_ERR, E_MSG, E_ALLMSG, &
                                  nmlfileunit, check_namelist_read, &
                                  find_namelist_in_file, do_nml_file, do_nml_term, &
                                  ascii_file_format, &
                                  read_int_scalar, &
                                  write_int_scalar, &       
                                  read_r8_scalar, &
                                  write_r8_scalar, &
                                  read_int_array, &
                                  write_int_array, &
                                  read_r8_array, &
                                  write_r8_array

   use          location_mod, only : location_type, set_location, get_location, &
                                  VERTISPRESSURE, VERTISSURFACE, VERTISLEVEL, &
                                  VERTISUNDEF

   use       assim_model_mod, only : interpolate

   use          obs_kind_mod, only : QTY_CO, QTY_TEMPERATURE, QTY_SURFACE_PRESSURE, &
                                  QTY_PRESSURE, QTY_VAPOR_MIXING_RATIO

   use  ensemble_manager_mod, only : ensemble_type

   use obs_def_utilities_mod, only : track_status

   use mpi_utilities_mod,     only : my_task_id

   use      time_manager_mod, only : time_type, get_date, set_date, get_time, set_time

   ! get_date gets year, month, day, hour, minute, second from time_type
! get_time gets julian day and seconds from time_type
! set_date sets time_type from year, month, day, hour, minute, second
! set_time sets time_type from julian day and seconds

   implicit none
   private

   public :: write_mopitt_v8_co_profile, &
          read_mopitt_v8_co_profile, &
          interactive_mopitt_v8_co_profile, &
          get_expected_mopitt_v8_co_profile, &
          set_obs_def_mopitt_v8_co_profile

! Storage for the special information required for observations of this type
   integer, parameter    :: max_mopitt_co_obs = 10000000
   integer               :: num_mopitt_co_obs = 0
   integer,  allocatable :: kobs(:,:)
   integer,  allocatable :: nlayer(:)
   integer,  allocatable :: nlevel(:)
   real(r8), allocatable :: pressure(:,:)
   real(r8), allocatable :: avg_kernel(:,:)
   real(r8), allocatable :: prior(:,:)

! version controlled file description for error handling, do not edit
   character(len=*), parameter :: source   = 'obs_def_mopitt_v8_co_profile_mod.f90'
   character(len=*), parameter :: revision = ''
   character(len=*), parameter :: revdate  = ''

   character(len=512) :: string1, string2
   character(len=200) :: upper_data_file
   character(len=200) :: upper_data_model
   character(len=200) :: model
   integer            :: ls_chem_dx, ls_chem_dy, ls_chem_dz, ls_chem_dt

   logical, save :: module_initialized = .false.

! Namelist with default values
   character(len=129)  :: MOPITT_CO_retrieval_type
   logical :: use_log_co    = .false.
   integer :: nlayer_model  = -9999
   integer :: nlayer_mopitt = -9999
   integer :: nlayer_mopitt_co_total_col = -9999
   integer :: nlayer_mopitt_co_trop_col  = -9999
   integer :: nlayer_mopitt_co_profile   = -9999
   
   namelist /obs_def_MOPITT_CO_nml/ upper_data_file, use_log_co, nlayer_model, &
   nlayer_mopitt_co_total_col, nlayer_mopitt_co_trop_col, nlayer_mopitt_co_profile, &
   ls_chem_dx, ls_chem_dy, ls_chem_dz, ls_chem_dt, upper_data_model

!-------------------------------------------------------------------------------
contains
!-------------------------------------------------------------------------------

subroutine initialize_module

   integer :: iunit, rc

! Prevent multiple calls from executing this code more than once.

   if (module_initialized) return

   call register_module(source, revision, revdate)
   module_initialized = .true.

! Read namelist values
   call find_namelist_in_file("input.nml", "obs_def_MOPITT_CO_nml", iunit)
   read(iunit, nml = obs_def_MOPITT_CO_nml, iostat = rc)
   call check_namelist_read(iunit, rc, "obs_def_MOPITT_CO_nml")

! Record the namelist values
   if (do_nml_file()) write(nmlfileunit, nml=obs_def_MOPITT_CO_nml)
   if (do_nml_term()) write(     *     , nml=obs_def_MOPITT_CO_nml)

! Check for valid values
   nlayer_mopitt=nlayer_mopitt_co_profile
   
   if (nlayer_model < 1) then
      write(string1,*) 'obs_def_MOPITT_CO_nml:nlayer_model must be > 0, it is ',nlayer_model
      call error_handler(E_ERR,'initialize_module',string1,source)
   endif

   if (nlayer_mopitt < 1) then
      write(string1,*) 'obs_def_MOPITT_CO_nml:nlayer_mopitt must be > 0, it is ',nlayer_mopitt
      call error_handler(E_ERR,'initialize_module',string1,source)
   endif

   allocate(    kobs(max_mopitt_co_obs,2))
   allocate(    nlayer(max_mopitt_co_obs))
   allocate(    nlevel(max_mopitt_co_obs))
   allocate(  pressure(max_mopitt_co_obs,nlayer_mopitt+1))
   allocate(avg_kernel(max_mopitt_co_obs,nlayer_mopitt))
   allocate(     prior(max_mopitt_co_obs,nlayer_mopitt))

end subroutine initialize_module

!-------------------------------------------------------------------------------

subroutine read_mopitt_v8_co_profile(key, ifile, fform)

   integer,          intent(out)          :: key
   integer,          intent(in)           :: ifile
   character(len=*), intent(in), optional :: fform
   
! temporary arrays to hold buffer till we decide if we have enough room

   integer               :: keyin
   integer               :: nlayer_1
   integer               :: nlevel_1
   integer, allocatable  :: kobs_1(:)
   real(r8), allocatable :: pressure_1(:)
   real(r8), allocatable :: avg_kernel_1(:)
   real(r8), allocatable :: prior_1(:)
   character(len=32)     :: fileformat
   
   integer, SAVE :: counts1 = 0
   
   if ( .not. module_initialized ) call initialize_module
   
   fileformat = "ascii" 
   if(present(fform)) fileformat = adjustl(fform)
   
! Need to know how many layers for this one
   nlayer_1 = read_int_scalar( ifile, fileformat, 'nlayer_1')
   nlevel_1 = read_int_scalar( ifile, fileformat, 'nlevel_1')
   
   allocate(  kobs_1(2))
   allocate(  pressure_1(nlayer_1+1))
   allocate(avg_kernel_1(nlayer_1))
   allocate(     prior_1(nlayer_1))
   
   call read_int_array(ifile, 2,         kobs_1,       fileformat, 'kobs_1')
   call read_r8_array(ifile, nlayer_1+1, pressure_1,   fileformat, 'pressure_1')
   call read_r8_array(ifile, nlayer_1,   avg_kernel_1, fileformat, 'avg_kernel_1')
   call read_r8_array(ifile, nlayer_1,   prior_1,      fileformat, 'prior_1')
   keyin = read_int_scalar(ifile, fileformat, 'keyin')
   
   counts1 = counts1 + 1
   key     = counts1
   
   if(counts1 > max_mopitt_co_obs) then
      write(string1, *) 'Not enough space for mopitt co profile obs.'
      write(string2, *) 'Can only have max_mopitt_co_obs (currently ',max_mopitt_co_obs,')'
      call error_handler(E_ERR,'read_mopitt_v8_co_profile',string1,source,text2=string2)
   endif
   
   call set_obs_def_mopitt_v8_co_profile(key, pressure_1, avg_kernel_1, prior_1, kobs_1, nlayer_1, nlevel_1)
   
   deallocate(kobs_1, pressure_1, avg_kernel_1, prior_1)
   
end subroutine read_mopitt_v8_co_profile

!-------------------------------------------------------------------------------

subroutine write_mopitt_v8_co_profile(key, ifile, fform)

   integer,          intent(in)           :: key
   integer,          intent(in)           :: ifile
   character(len=*), intent(in), optional :: fform
   
   character(len=32) :: fileformat
   
   if ( .not. module_initialized ) call initialize_module
   
   fileformat = "ascii"
   if(present(fform)) fileformat = adjustl(fform)
   
! nlayer, pressure, avg_kernel, and prior are all scoped in this module
! you can come extend the context strings to include the key if desired.

   call write_int_scalar(ifile,                     nlayer(key), fileformat,'nlayer')
   call write_int_scalar(ifile,                     nlevel(key), fileformat,'klevel')
   call write_int_array( ifile, 2,                  kobs(key,:), fileformat,'kobs')
   call write_r8_array(  ifile, nlayer(key)+1,  pressure(key,:), fileformat,'pressure')
   call write_r8_array(  ifile, nlayer(key),  avg_kernel(key,:), fileformat,'avg_kernel')
   call write_r8_array(  ifile, nlayer(key),       prior(key,:), fileformat,'prior')
   call write_int_scalar(ifile,                             key, fileformat,'key')
   
end subroutine write_mopitt_v8_co_profile

!-------------------------------------------------------------------------------

subroutine interactive_mopitt_v8_co_profile(key)

   integer, intent(out) :: key
   
   if ( .not. module_initialized ) call initialize_module
   
! STOP because routine is not finished.
   write(string1,*) 'interactive_mopitt_v8_co_profile not yet working.'
   call error_handler(E_ERR, 'interactive_mopitt_v8_co_profile', string1, source)
   
   if(num_mopitt_co_obs >= max_mopitt_co_obs) then
      write(string1, *) 'Not enough space for an mopitt co obs.'
      write(string2, *) 'Can only have max_mopitt_co_obs (currently ',max_mopitt_co_obs,')'
      call error_handler(E_ERR, 'interactive_mopitt_v8_co_profile', string1, &
                 source, text2=string2)
   endif
   
! Increment the index
   num_mopitt_co_obs = num_mopitt_co_obs + 1
   key            = num_mopitt_co_obs

! Otherwise, prompt for input for the three required beasts

   write(*, *) 'Creating an interactive_mopitt_v8_co_profile observation'
   write(*, *) 'This featue is not setup '

end subroutine interactive_mopitt_v8_co_profile

!-------------------------------------------------------------------------------

subroutine get_expected_mopitt_v8_co_profile(state_handle, ens_size, location, key, obs_time, expct_val, istatus)

   type(ensemble_type), intent(in)  :: state_handle
   type(location_type), intent(in)  :: location
   integer,             intent(in)  :: ens_size
   integer,             intent(in)  :: key
   type(time_type),     intent(in)  :: obs_time
   integer,             intent(out) :: istatus(:)
   real(r8),            intent(out) :: expct_val(:)
   
   character(len=*), parameter :: routine = 'get_expected_mopitt_v8_co_profile'
   character(len=120)          :: data_file
   character(len=*),parameter  :: fld = 'CO_VMR_inst'
   type(location_type) :: loc2
   
   integer :: layer_mopitt,level_mopitt,profile_mopitt,klay_mopitt
   integer :: layer_mdl,level_mdl
   integer :: k,kk,imem,imemm,flg
   integer :: interp_new
   integer :: icnt,ncnt,kstart
   integer :: date_obs,datesec_obs
   integer, dimension(ens_size) :: zstatus,kbnd_1,kbnd_n
   
   real(r8) :: eps, AvogN, Rd, Ru, Cp, grav, msq2cmsq
   real(r8) :: missing,co_min,tmp_max
   real(r8) :: level,del_prs,prior_term
   real(r8) :: tmp_vir_k, tmp_vir_kp
   real(r8) :: mloc(3),obs_prs
   real(r8) :: co_val_conv, VMR_conv
   real(r8) :: up_wt,dw_wt,tl_wt,lnpr_mid
   real(r8) :: lon_obs,lat_obs,pi,rad2deg
   
   real(r8), dimension(ens_size) :: co_mdl_1, tmp_mdl_1, qmr_mdl_1, prs_mdl_1
   real(r8), dimension(ens_size) :: co_mdl_n, tmp_mdl_n, qmr_mdl_n, prs_mdl_n
   real(r8), dimension(ens_size) :: prs_sfc
   
   real(r8), allocatable, dimension(:)   :: thick, prs_mopitt, prs_mopitt_mem
   real(r8), allocatable, dimension(:,:) :: co_val, tmp_val, qmr_val
   logical  :: return_now,co_return_now,tmp_return_now,qmr_return_now
!
! Upper BC variables   
   real(r8), allocatable, dimension(:)   :: co_prf_mdl,tmp_prf_mdl,qmr_prf_mdl
   real(r8), allocatable, dimension(:)   :: prs_mopitt_top
   
   if ( .not. module_initialized ) call initialize_module

   pi       = 4.*atan(1.)
   rad2deg  = 360./(2.*pi)
   eps      = 0.61_r8
   Rd       = 287.058_r8    ! J/(mole-kg)
   Ru       = 8.3145_r8     ! J/(mole-kg)
   Cp       = 1006.0        ! J/kg/K
   grav     = 9.8_r8        ! m/s^2
   co_min   = 1.e-6_r8
   msq2cmsq = 1.e4_r8
   AvogN    = 6.02214e23_r8
   missing  = -888888_r8
   tmp_max  = 600.
   del_prs  = 5000.
   VMR_conv = 28.9644/47.9982
! 
! WACCM - MMR
! WRFChem - VMR ppmv
!
! to convert from mass mixing ratio (MMR) to volume mixing ratio (VMR) multiply by
! the molar mass of dry air (28.9644 g) and divide by the molar mass of the constituent
! O3 - 47.9982 g
! CO - 28.0101 g
! NO2 - 46.0055 g
! SO2 - 64.0638 g
! CO2 - 44.0096 g
! CH4 - 16.0425 g
!
! to get VMR in ppb multiply by 1e9
! to get VMR in ppm multiply by 1e6   
!
   if(use_log_co) then
      co_min = log(co_min)
   endif
   
! Assign vertical grid information (MOPITT CO is bottom to top)

   layer_mopitt = nlayer(key)
   level_mopitt = nlevel(key)
   profile_mopitt  = kobs(key,1)
   klay_mopitt  = kobs(key,2)
   layer_mdl = nlayer_model
   level_mdl = nlayer_model+1
   allocate(prs_mopitt(level_mopitt))
   allocate(prs_mopitt_mem(level_mopitt))
   prs_mopitt(1:level_mopitt)=pressure(key,1:level_mopitt)*100.

! Get location infomation

   mloc = get_location(location)
!   print *, 'APM: key        ',key,profile_mopitt,klay_mopitt,nlayer(key),nlevel(key)
!   print *, 'APM: location   ',mloc(1),mloc(2),mloc(3)
!   print *, 'APM: pressure   ',pressure(key,1:level_mopitt)
!   print *, 'APM: avg_kernel ',avg_kernel(key,1:layer_mopitt)
!   print *, 'APM: prior      ',prior(key,1:layer_mopitt)
!   call exit_all(-77)

   if (mloc(2) >  90.0_r8) then
      mloc(2) =  90.0_r8
   elseif (mloc(2) < -90.0_r8) then
      mloc(2) = -90.0_r8
   endif

! You could set a unique error code for each condition and then just return
! without having to issue a warning message. The error codes would then
! show up in the report from 'output_forward_op_errors'

   istatus(:) = 0  ! set this once at the beginning
   return_now=.false.

! pressure at model surface (Pa)

   zstatus=0
   level=0.0_r8
   loc2 = set_location(mloc(1), mloc(2), level, VERTISSURFACE)
   call interpolate(state_handle, ens_size, loc2, QTY_SURFACE_PRESSURE, prs_sfc, zstatus) 

   co_mdl_1(:)=missing_r8
   tmp_mdl_1(:)=missing_r8
   qmr_mdl_1(:)=missing_r8
   prs_mdl_1(:)=missing_r8

   kbnd_1(:)=1
   do k=1,layer_mdl
      level=real(k)
      zstatus(:)=0
      loc2 = set_location(mloc(1), mloc(2), level, VERTISLEVEL)
      call interpolate(state_handle, ens_size, loc2, QTY_CO, co_mdl_1, zstatus) ! ppmv 
      zstatus(:)=0
      call interpolate(state_handle, ens_size, loc2, QTY_TEMPERATURE, tmp_mdl_1, zstatus) ! K 
      zstatus(:)=0
      call interpolate(state_handle, ens_size, loc2, QTY_VAPOR_MIXING_RATIO, qmr_mdl_1, zstatus) ! kg / kg 
      zstatus(:)=0
      call interpolate(state_handle, ens_size, loc2, QTY_PRESSURE, prs_mdl_1, zstatus) ! Pa
!
      interp_new=0
      do imem=1,ens_size
!         if(co_mdl_1(imem).eq.missing_r8 .or. tmp_mdl_1(imem).eq.missing_r8 .or. &
!         qmr_mdl_1(imem).eq.missing_r8 .or. prs_mdl_1(imem).eq.missing_r8) then
         if(co_mdl_1(imem).lt.0. .or. tmp_mdl_1(imem).lt.0. .or. &
         qmr_mdl_1(imem).lt.0. .or. prs_mdl_1(imem).lt.0.) then
            interp_new=1
            exit
         endif
      enddo
      if(interp_new.eq.0) then
         exit
      endif
   enddo

!   write(string1, *) 'APM: co lower bound ',key,co_mdl_1
!   call error_handler(E_MSG, routine, string1, source)
!   write(string1, *) 'APM: tmp lower bound ',key,tmp_mdl_1
!   call error_handler(E_MSG, routine, string1, source)
!   write(string1, *) 'APM: qmr lower bound ',key,qmr_mdl_1
!   call error_handler(E_MSG, routine, string1, source)
!   write(string1, *) 'APM: prs lower bound ',key,prs_mdl_1
!   call error_handler(E_MSG, routine, string1, source)

   co_mdl_n(:)=missing_r8
   tmp_mdl_n(:)=missing_r8
   qmr_mdl_n(:)=missing_r8
   prs_mdl_n(:)=missing_r8

   do k=layer_mdl,1,-1
      level=real(k)
      zstatus(:)=0
      loc2 = set_location(mloc(1), mloc(2), level, VERTISLEVEL)
      call interpolate(state_handle, ens_size, loc2, QTY_CO, co_mdl_n, zstatus) 
      zstatus(:)=0
      call interpolate(state_handle, ens_size, loc2, QTY_TEMPERATURE, tmp_mdl_n, &
      zstatus) 
      zstatus(:)=0
      call interpolate(state_handle, ens_size, loc2, QTY_VAPOR_MIXING_RATIO, qmr_mdl_n, &
      zstatus) 
      zstatus(:)=0
      call interpolate(state_handle, ens_size, loc2, QTY_PRESSURE, prs_mdl_n, &
      zstatus) 
!
      interp_new=0
      do imem=1,ens_size
!         if(co_mdl_n(imem).eq.missing_r8 .or. tmp_mdl_n(imem).eq.missing_r8 .or. &
!         qmr_mdl_n(imem).eq.missing_r8 .or. prs_mdl_n(imem).eq.missing_r8) then
         if(co_mdl_n(imem).lt.0. .or. tmp_mdl_n(imem).lt.0. .or. &
         qmr_mdl_n(imem).lt.0. .or. prs_mdl_n(imem).lt.0.) then
            interp_new=1
            exit
         endif
      enddo
      if(interp_new.eq.0) then
         exit
      endif
   enddo

!   write(string1, *) 'APM: co upper bound ',key,co_mdl_n
!   call error_handler(E_MSG, routine, string1, source)
!   write(string1, *) 'APM: tmp upper bound ',key,tmp_mdl_n
!   call error_handler(E_MSG, routine, string1, source)
!   write(string1, *) 'APM: qmr upper bound ',key,qmr_mdl_n
!   call error_handler(E_MSG, routine, string1, source)
!   write(string1, *) 'APM: prs upper bound ',key,prs_mdl_n
!   call error_handler(E_MSG, routine, string1, source)

! Get profiles at MOPITT pressure levels (Pa)

   allocate(co_val(ens_size,level_mopitt))
   allocate(tmp_val(ens_size,level_mopitt))
   allocate(qmr_val(ens_size,level_mopitt))

   do k=1,level_mopitt
      zstatus=0
      loc2 = set_location(mloc(1), mloc(2), prs_mopitt(k), VERTISPRESSURE)
      call interpolate(state_handle, ens_size, loc2, QTY_CO, co_val(:,k), zstatus)  
      zstatus=0
      call interpolate(state_handle, ens_size, loc2, QTY_TEMPERATURE, tmp_val(:,k), zstatus)  
      zstatus=0
      call interpolate(state_handle, ens_size, loc2, QTY_VAPOR_MIXING_RATIO, qmr_val(:,k), zstatus)  
!
! Correcting for expected failures near the surface
      do imem=1,ens_size
         if (prs_mopitt(k).ge.prs_mdl_1(imem)) then
            co_val(imem,k) = co_mdl_1(imem)
            tmp_val(imem,k) = tmp_mdl_1(imem)
            qmr_val(imem,k) = qmr_mdl_1(imem)
         endif
!
! Correcting for expected failures near the top
         if (prs_mopitt(k).le.prs_mdl_n(imem)) then
            co_val(imem,k) = co_mdl_n(imem)
            tmp_val(imem,k) = tmp_mdl_n(imem)
            qmr_val(imem,k) = qmr_mdl_n(imem)
         endif
      enddo
!
!      write(string1, *)'APM: co ',k,co_val(1,k)
!      call error_handler(E_MSG, routine, string1, source)
!      write(string1, *)'APM: tmp ',k,tmp_val(1,k)
!      call error_handler(E_MSG, routine, string1, source)
!      write(string1, *)'APM: qmr ',k,qmr_val(1,k)
!      call error_handler(E_MSG, routine, string1, source)
!
! Convert units for co from ppmv
      co_val(:,k) = co_val(:,k) * 1.e-6_r8
   enddo
   co_mdl_1(:) = co_mdl_1(:) * 1.e-6_r8
   co_mdl_n(:) = co_mdl_n(:) * 1.e-6_r8
!
! Use large scale carbon monoxide data above the regional model top
! APM: Modified to use retrieval prior above the regional model top   
! MOPITT vertical grid is from bottom to top   
!
! APM: Before oLd code         
!   kstart=-1
!   do imem=1,ens_size
!      write(string1, *)'APM: imem,prs_mopitt,prs_model ',imem,prs_mopitt(level_mopitt),prs_mdl_n(imem)
!      call error_handler(E_MSG, routine, string1, source)
!      if (prs_mopitt(level_mopitt).lt.prs_mdl_n(imem)) then
!         do k=level_mopitt,1,-1
!            if (prs_mopitt(k).gt.prs_mdl_n(imem)) then
!               kstart=k
!               exit
!            endif
!         enddo
!         ncnt=level_mopitt-kstart
!         allocate(prs_mopitt_top(ncnt))
!         allocate(co_prf_mdl(ncnt),tmp_prf_mdl(ncnt),qmr_prf_mdl(ncnt))
!         do k=kstart+1,level_mopitt
!            prs_mopitt_top(k)=prs_mopitt(k)
!         enddo
!         prs_mopitt_top(:)=prs_mopitt_top(:)/100.
!
!         lon_obs=mloc(1)/rad2deg
!         lat_obs=mloc(2)/rad2deg
!         call get_time(obs_time,datesec_obs,date_obs)
!
!         data_file=trim(upper_data_file)
!         model=trim(upper_data_model)
!
!         write(string1, *)'APM: kstart ',kstart
!         call error_handler(E_MSG, routine, string1, source)
!         do k=1,ncnt
!            write(string1, *)'APM: k,prs ',prs_mopitt_top(k)
!            call error_handler(E_MSG, routine, string1, source)
!         enddo
!            
!         call get_upper_bdy_fld(fld,model,data_file,ls_chem_dx,ls_chem_dy, &
!         ls_chem_dz,ls_chem_dt,lon_obs,lat_obs,prs_mopitt_top, &
!         ncnt,co_prf_mdl,tmp_prf_mdl,qmr_prf_mdl,date_obs,datesec_obs)
!
!         do k=1,ncnt
!            write(string1, *)'APM: k,co,prs ',co_prf_mdl(k),prs_mopitt_top(k)
!            call error_handler(E_MSG, routine, string1, source)
!         enddo
!
! Impose ensemble perturbations from level kstart+1      
!         do k=kstart+1,level_mopitt
!            co_val(imem,k)=co_prf_mdl(k)*co_val(imem,kstart)/ &
!            (sum(co_val(:,kstart))/real(ens_size))
!            tmp_val(imem,k)=tmp_prf_mdl(k)*tmp_val(imem,kstart)/ &
!            (sum(tmp_val(:,kstart))/real(ens_size))
!            qmr_val(imem,k)=qmr_prf_mdl(k)*qmr_val(imem,kstart)/ &
!            (sum(qmr_val(:,kstart))/real(ens_size))
!         enddo
!
!         do k=kstart+1,level_mopitt
!            write(string1, *)'APM: k,co,prs ',co_prf_mdl(k),prs_mopitt_top(k)
!            call error_handler(E_MSG, routine, string1, source)
!         enddo
!
!         deallocate(prs_mopitt_top)
!         deallocate(co_prf_mdl,tmp_prf_mdl,qmr_prf_mdl)
!      endif
!   enddo
! APM: After old code         
!
! Check full profile for negative values
   do imem=1,ens_size
      do k=1,level_mopitt
         if(co_val(imem,k).lt.0. .or. tmp_val(imem,k).lt.0. .or. &
         qmr_val(imem,k).lt.0. .or. prs_mopitt(k).lt.0.) then
            write(string1, *) &
            'APM: Recentered full profile has negative values for key,imem ',key,imem
            call error_handler(E_MSG, routine, string1, source)
            zstatus(:)=20
            expct_val(:)=missing_r8
            call track_status(ens_size, zstatus, expct_val, istatus, return_now)
            return
         endif
      enddo
   enddo
!
! Calculate the expected retrievals   
   istatus(:)=0
   zstatus(:)=0.
   expct_val(:)=0.0
   allocate(thick(layer_mopitt))
   prs_mopitt_mem(:)=prs_mopitt(:)
!
! Find MOPITT index for first layer above top of regional model      
! MOPITT vertical grid is from bottom to top   
   do imem=1,ens_size
      kstart=-1
!      write(string1, *) &
!      'APM: imem,prs_mopitt,prs_mdl ',imem,prs_mopitt(level_mopitt),prs_mopitt(level_mopitt-1), &
!      prs_mdl_n(imem)
!      call error_handler(E_ALLMSG, routine, string1, source)
      if ((prs_mopitt(level_mopitt)+prs_mopitt(level_mopitt-1))/2..lt.prs_mdl_n(imem)) then
         do k=level_mopitt,1,-1
            if ((prs_mopitt(k)+prs_mopitt(k-1))/2..gt.prs_mdl_n(imem)) then
               kstart=k
               write(string1, *) &
               'APM: imem,kstart,prs_mopitt,prs_mdl ',imem,kstart,prs_mopitt(k),prs_mopitt(k-1), &
               prs_mdl_n(imem)
               call error_handler(E_ALLMSG, routine, string1, source)
               exit
            endif
         enddo
      endif
!      
! Calculate the thicknesses
!      thick(:)=0.
!      do k=1,layer_mopitt
!         lnpr_mid=(log(prs_mopitt_mem(k))+log(prs_mopitt_mem(k+1)))/2.
!         up_wt=log(prs_mopitt_mem(k))-lnpr_mid
!         dw_wt=lnpr_mid-log(prs_mopitt_mem(k+1))
!         tl_wt=up_wt+dw_wt 
!         tmp_vir_k  = (1.0_r8 + eps*qmr_val(imem,k))*tmp_val(imem,k)
!         tmp_vir_kp = (1.0_r8 + eps*qmr_val(imem,k+1))*tmp_val(imem,k+1)
!         thick(k)   = Rd*(dw_wt*tmp_vir_k + up_wt*tmp_vir_kp)/tl_wt/grav* &
!         log(prs_mopitt_mem(k)/prs_mopitt_mem(k+1))
!      enddo
!      
! Process the vertical summation      
      do k=1,layer_mopitt
         if(prior(key,k).lt.0.) then
            write(string1, *) &
            'APM: MOPITT Prior is negative. Key,Layer: ',key,k
            call error_handler(E_ALLMSG, routine, string1, source)
            zstatus(:)=20
            expct_val(:)=missing_r8
            call track_status(ens_size, zstatus, expct_val, istatus, return_now)
            return
         endif
!         
         lnpr_mid=(log(prs_mopitt_mem(k))+log(prs_mopitt_mem(k+1)))/2.
         up_wt=log(prs_mopitt_mem(k))-lnpr_mid
         dw_wt=lnpr_mid-log(prs_mopitt_mem(k+1))
         tl_wt=up_wt+dw_wt

! Convert from VMR to molar density (mol/m^3) (MOPITT retrieval is VMR ppbv)
         if(use_log_co) then
!            co_val_conv = (dw_wt*exp(co_val(imem,k))+up_wt*exp(co_val(imem,k+1)))/tl_wt * &
!            (dw_wt*prs_mopitt_mem(k)+up_wt*prs_mopitt_mem(k+1)) / &
!            (Ru*(dw_wt*tmp_val(imem,k)+up_wt*tmp_val(imem,k+1)))
            co_val_conv=(dw_wt*exp(co_val(imem,k))+up_wt*exp(co_val(imem,k+1)))/tl_wt*1.e9_r8
         else
!            co_val_conv = (dw_wt*co_val(imem,k)+up_wt*co_val(imem,k+1))/tl_wt * &
!            (dw_wt*prs_mopitt_mem(k)+up_wt*prs_mopitt_mem(k+1)) / &
!            (Ru*(dw_wt*tmp_val(imem,k)+up_wt*tmp_val(imem,k+1)))
            co_val_conv = (dw_wt*co_val(imem,k)+up_wt*co_val(imem,k+1))/tl_wt*1.e9_r8
         endif
!
! Use retrieval prior above regional model top         
         if(k.ge.kstart .and. kstart.gt.0) co_val_conv=prior(key,k)
 
! Get expected observation (MOPITT prior is VMR ppbv)

         prior_term=-1.*avg_kernel(key,k)
         if(k.eq.klay_mopitt) prior_term=(1.0_r8 - avg_kernel(key,k)) 

         if(use_log_co) then
            expct_val(imem) = expct_val(imem) + log10(exp(co_val_conv)) * &
            avg_kernel(key,k) + prior_term * log10(prior(key,k))
         else
            expct_val(imem) = expct_val(imem) + log10(co_val_conv) * &
            avg_kernel(key,k) + prior_term * log10(prior(key,k))
         endif

!         write(string1, *) &
!         'APM: K,expct_val,avgk_trm,prior_trm ',k,expct_val(imem), &
!         log10(co_val_conv)*avg_kernel(key,k),prior_term*log10(prior(key,k))
!         call error_handler(E_ALLMSG, routine, string1, source)
         
      enddo
!
! Convert expected observation from log10(ppbv) to ppbv         
      expct_val(imem)=10.**expct_val(imem)

      if(isnan(expct_val(imem))) then
         zstatus(:)=20
         expct_val(:)=missing_r8
         write(string1, *) &
         'APM NOTICE: MOPITT CO expected value is NaN '
         call error_handler(E_ALLMSG, routine, string1, source)
         call track_status(ens_size, zstatus, expct_val, istatus, return_now)
         return
      endif
!
      if(expct_val(imem).lt.0) then
         zstatus(:)=20
         expct_val(:)=missing_r8
         write(string1, *) &
         'APM NOTICE: MOPITT CO expected value is negative'
         call error_handler(E_ALLMSG, routine, string1, source)
         call track_status(ens_size, zstatus, expct_val, istatus, return_now)
         return
      endif
   enddo
!   call exit_all(-77)
!
! Clean up and return
   deallocate(co_val, tmp_val, qmr_val)
   deallocate(thick)
   deallocate(prs_mopitt, prs_mopitt_mem)
end subroutine get_expected_mopitt_v8_co_profile

!-------------------------------------------------------------------------------

subroutine set_obs_def_mopitt_v8_co_profile(key, co_pressure, co_avg_kernel, co_prior, &
co_kobs, co_nlayer, co_nlevel)

   integer,                           intent(in)   :: key, co_nlayer, co_nlevel
   integer, dimension(2),             intent(in)   :: co_kobs
   real(r8), dimension(co_nlayer+1),  intent(in)   :: co_pressure
   real(r8), dimension(co_nlayer),    intent(in)   :: co_avg_kernel
   real(r8), dimension(co_nlayer),    intent(in)   :: co_prior
   
   if ( .not. module_initialized ) call initialize_module
   
   if(num_mopitt_co_obs >= max_mopitt_co_obs) then
      write(string1, *) 'Not enough space for mopitt co profile obs.'
      write(string2, *) 'Can only have max_mopitt_co_obs (currently ',max_mopitt_co_obs,')'
      call error_handler(E_ERR,'set_obs_def_mopitt_v8_co_profile',string1,source,revision, &
      revdate,text2=string2)
   endif
   nlayer(key) = co_nlayer
   nlevel(key) = co_nlevel
   kobs(key,1:2) = co_kobs(1:2)
   pressure(key,1:co_nlayer+1) = co_pressure(1:co_nlayer+1)
   avg_kernel(key,1:co_nlayer) = co_avg_kernel(1:co_nlayer)
   prior(key,1:co_nlayer) = co_prior(1:co_nlayer)
   
end subroutine set_obs_def_mopitt_v8_co_profile

end module obs_def_mopitt_v8_co_profile_mod

! END DART PREPROCESS MODULE CODE
