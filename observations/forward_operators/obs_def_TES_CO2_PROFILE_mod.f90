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
! TES_CO2_PROFILE, QTY_CO2
! END DART PREPROCESS TYPE DEFINITIONS
!
! BEGIN DART PREPROCESS USE OF SPECIAL OBS_DEF MODULE
!   use obs_def_tes_co2_profile_mod, only : get_expected_tes_co2_profile, &
!                                  read_tes_co2_profile, &
!                                  write_tes_co2_profile, &
!                                  interactive_tes_co2_profile
! END DART PREPROCESS USE OF SPECIAL OBS_DEF MODULE
!
! BEGIN DART PREPROCESS GET_EXPECTED_OBS_FROM_DEF
!      case(TES_CO2_PROFILE)                                                           
!         call get_expected_tes_co2_profile(state_handle, ens_size, location, obs_def%key, obs_time, expected_obs, istatus)  
! END DART PREPROCESS GET_EXPECTED_OBS_FROM_DEF
!
! BEGIN DART PREPROCESS READ_OBS_DEF
!      case(TES_CO2_PROFILE)
!         call read_tes_co2_profile(obs_def%key, ifile, fileformat)
! END DART PREPROCESS READ_OBS_DEF
!
! BEGIN DART PREPROCESS WRITE_OBS_DEF
!      case(TES_CO2_PROFILE)
!         call write_tes_co2_profile(obs_def%key, ifile, fileformat)
! END DART PREPROCESS WRITE_OBS_DEF
!
! BEGIN DART PREPROCESS INTERACTIVE_OBS_DEF
!      case(TES_CO2_PROFILE)
!         call interactive_tes_co2_profile(obs_def%key)
! END DART PREPROCESS INTERACTIVE_OBS_DEF
!
! BEGIN DART PREPROCESS MODULE CODE

module obs_def_tes_co2_profile_mod

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
                                     read_r8_array, &
                                     write_r8_array
   
   use          location_mod, only : location_type, set_location, get_location, &
                                     VERTISPRESSURE, VERTISSURFACE, VERTISLEVEL, &
                                     VERTISUNDEF
   
   use       assim_model_mod, only : interpolate
   
   use          obs_kind_mod, only : QTY_CO2, QTY_TEMPERATURE, QTY_SURFACE_PRESSURE, &
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

   public :: write_tes_co2_profile, &
             read_tes_co2_profile, &
          interactive_tes_co2_profile, &
          get_expected_tes_co2_profile, &
          set_obs_def_tes_co2_profile

! Storage for the special information required for observations of this type
   integer, parameter    :: max_tes_co2_obs = 10000000
   integer               :: num_tes_co2_obs = 0
   integer,  allocatable :: nlayer(:)
   integer,  allocatable :: klev(:)
   integer,  allocatable :: kend(:)
   real(r8), allocatable :: pressure(:,:)
   real(r8), allocatable :: avg_kernel(:,:)
   real(r8), allocatable :: prior(:,:)

! version controlled file description for error handling, do not edit
   character(len=*), parameter :: source   = 'obs_def_tes_co2_profile_mod.f90'
   character(len=*), parameter :: revision = ''
   character(len=*), parameter :: revdate  = ''
   
   character(len=512) :: string1, string2
   character(len=200) :: upper_data_file
   character(len=200) :: upper_data_model
   character(len=200) :: model
   integer            :: ls_chem_dx, ls_chem_dy, ls_chem_dz, ls_chem_dt
   
   logical, save :: module_initialized = .false.

! Namelist with default values
   logical :: use_log_co2   = .false.
   integer :: nlayer_model = -9999
   integer :: nlayer_tes = -9999
   integer :: nlayer_tes_co2_total_col = -9999
   integer :: nlayer_tes_co2_trop_col = -9999
   integer :: nlayer_tes_co2_profile = -9999
   
   namelist /obs_def_TES_CO2_nml/ upper_data_file, use_log_co2, nlayer_model, &
   nlayer_tes_co2_total_col, nlayer_tes_co2_trop_col, nlayer_tes_co2_profile, &
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
   call find_namelist_in_file("input.nml", "obs_def_TES_CO2_nml", iunit)
   read(iunit, nml = obs_def_TES_CO2_nml, iostat = rc)
   call check_namelist_read(iunit, rc, "obs_def_TES_CO2_nml")

! Record the namelist values
   if (do_nml_file()) write(nmlfileunit, nml=obs_def_TES_CO2_nml)
   if (do_nml_term()) write(     *     , nml=obs_def_TES_CO2_nml)

! Check for valid values
   nlayer_tes=nlayer_tes_co2_profile

   if (nlayer_model < 1) then
      write(string1,*)'obs_def_TES_CO2_nml:nlayer_model must be > 0, it is ',nlayer_model
      call error_handler(E_ERR,'initialize_module',string1,source)
   endif
   
   if (nlayer_tes < 1) then
      write(string1,*)'obs_def_TES_CO2_nml:nlayer_tes must be > 0, it is ',nlayer_tes
      call error_handler(E_ERR,'initialize_module',string1,source)
   endif
   
   allocate(    nlayer(max_tes_co2_obs))
   allocate(    klev(max_tes_co2_obs))
   allocate(    kend(max_tes_co2_obs))
   allocate(  pressure(max_tes_co2_obs,nlayer_tes))
   allocate(avg_kernel(max_tes_co2_obs,nlayer_tes))
   allocate(     prior(max_tes_co2_obs,nlayer_tes))
   
end subroutine initialize_module

!-------------------------------------------------------------------------------

subroutine read_tes_co2_profile(key, ifile, fform)

   integer,          intent(out)          :: key
   integer,          intent(in)           :: ifile
   character(len=*), intent(in), optional :: fform

! tesrary arrays to hold buffer till we decide if we have enough room

   integer               :: keyin
   integer               :: nlayer_1
   integer               :: klev_1
   integer               :: kend_1
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
   klev_1 = read_int_scalar( ifile, fileformat, 'klev_1')
   kend_1 = read_int_scalar( ifile, fileformat, 'kend_1')
   
   allocate(  pressure_1(nlayer_1))
   allocate(avg_kernel_1(nlayer_1))
   allocate(prior_1(nlayer_1))
   
   call read_r8_array(ifile, nlayer_1, pressure_1,   fileformat, 'pressure_1')
   call read_r8_array(ifile, nlayer_1,   avg_kernel_1, fileformat, 'avg_kernel_1')
   call read_r8_array(ifile, nlayer_1,   prior_1,      fileformat, 'prior_1')
   keyin = read_int_scalar(ifile, fileformat, 'keyin')
   
   counts1 = counts1 + 1
   key     = counts1
   
   if(counts1 > max_tes_co2_obs) then
      write(string1, *)'Not enough space for tes co2 obs.'
      write(string2, *)'Can only have max_tes_co2_obs (currently ',max_tes_co2_obs,')'
      call error_handler(E_ERR,'read_tes_co2_profile',string1,source,text2=string2)
   endif
   
   call set_obs_def_tes_co2_profile(key, pressure_1(1:nlayer_1), avg_kernel_1(1:nlayer_1), &
   prior_1(1:nlayer_1), nlayer_1, klev_1, kend_1)
   
   deallocate(pressure_1, avg_kernel_1, prior_1)
   
end subroutine read_tes_co2_profile

!-------------------------------------------------------------------------------

subroutine write_tes_co2_profile(key, ifile, fform)

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
   call write_int_scalar(ifile,                     klev(key), fileformat,'klev')
   call write_int_scalar(ifile,                     kend(key), fileformat,'kend')
   call write_r8_array(  ifile, nlayer(key),  pressure(key,:), fileformat,'pressure')
   call write_r8_array(  ifile, nlayer(key),  avg_kernel(key,:), fileformat,'avg_kernel')
   call write_r8_array(  ifile, nlayer(key),       prior(key,:), fileformat,'prior')
   call write_int_scalar(ifile,                             key, fileformat,'key')
   
end subroutine write_tes_co2_profile

!-------------------------------------------------------------------------------

subroutine interactive_tes_co2_profile(key)

   integer, intent(out) :: key
   
   if ( .not. module_initialized ) call initialize_module

! STOP because routine is not finished.
   write(string1,*)'interactive_tes_co2_profile not yet working.'
   call error_handler(E_ERR, 'interactive_tes_co2_profile', string1, source)
   
   if(num_tes_co2_obs >= max_tes_co2_obs) then
      write(string1, *)'Not enough space for an tes co obs.'
      write(string2, *)'Can only have max_tes_co2_obs (currently ',max_tes_co2_obs,')'
      call error_handler(E_ERR, 'interactive_tes_co2_profile', string1, &
                 source, text2=string2)
   endif
   
! Increment the index
   num_tes_co2_obs = num_tes_co2_obs + 1
   key            = num_tes_co2_obs

! Otherwise, prompt for input for the three required beasts

   write(*, *) 'Creating an interactive_tes_co2_profile observation'
   write(*, *) 'This featue is not setup '

end subroutine interactive_tes_co2_profile

!-------------------------------------------------------------------------------

subroutine get_expected_tes_co2_profile(state_handle, ens_size, location, key, obs_time, expct_val, istatus)

   type(ensemble_type), intent(in)  :: state_handle
   type(location_type), intent(in)  :: location
   integer,             intent(in)  :: ens_size
   integer,             intent(in)  :: key
   type(time_type),     intent(in)  :: obs_time
   integer,             intent(out) :: istatus(:)
   real(r8),            intent(out) :: expct_val(:)
   
   character(len=*), parameter :: routine = 'get_expected_tes_co2_profile'
   character(len=120)          :: data_file
   character(len=*),parameter  :: fld = 'CO2_VMR_inst'
   type(location_type) :: loc2
   
   integer :: layer_tes,level_tes, klev_tes, kend_tes
   integer :: layer_mdl,level_mdl
   integer :: k,kk,imem,imemm
   integer :: interp_new
   integer :: icnt
   integer :: date_obs,datesec_obs
   integer, dimension(ens_size) :: zstatus,kbnd_1,kbnd_n
   
   real(r8) :: eps, AvogN, Rd, Ru, Cp, grav, msq2cmsq
   real(r8) :: missing,co2_min,tmp_max
   real(r8) :: level,del_prs,prior_term
   real(r8) :: tmp_vir_k, tmp_vir_kp
   real(r8) :: mloc(3),obs_prs
   real(r8) :: co2_val_conv, VMR_conv
   real(r8) :: up_wt,dw_wt,tl_wt,lnpr_mid

   real(r8), dimension(ens_size) :: co2_mdl_1, tmp_mdl_1, qmr_mdl_1, prs_mdl_1
   real(r8), dimension(ens_size) :: co2_mdl_n, tmp_mdl_n, qmr_mdl_n, prs_mdl_n
   real(r8), dimension(ens_size) :: prs_sfc
   
   real(r8), allocatable, dimension(:)   :: thick, prs_tes, prs_tes_mem
   real(r8), allocatable, dimension(:,:) :: co2_val, tmp_val, qmr_val
   logical  :: return_now,co2_return_now,tmp_return_now,qmr_return_now
!
! Upper BC variables
   integer  :: ncnt,kstart,flg
   real(r8) :: lon_obs,lat_obs,pi,rad2deg
   real     :: prs_del,delta,bdy_coef
   real     :: co2_bot,prs_bot,tmp_bot,qmr_bot
   real     :: co2_top,prs_top,tmp_top,qmr_top
   real(r8), allocatable, dimension(:)   :: co2_prf_mdl,tmp_prf_mdl,qmr_prf_mdl
   real(r8), allocatable, dimension(:)   :: prs_tes_top
   
   if ( .not. module_initialized ) call initialize_module
   
   pi       = 4.*atan(1.)
   rad2deg  = 360./(2.*pi)
   eps      = 0.61_r8
   Rd       = 287.05_r8     ! J/(mole-kg)
   Ru       = 8.316_r8      ! J/(mole-kg)
   Cp       = 1006.0        ! J/kg/K
   grav     = 9.8_r8        ! m/s^2
   co2_min  = 1.e-6_r8
   msq2cmsq = 1.e4_r8
   AvogN    = 6.02214e23_r8
   missing  = -888888_r8
   tmp_max  = 600.
   del_prs  = 5000.
   VMR_conv = 28.9644/47.9982
   bdy_coef = 0.95
   prs_del  = 1000.         ! Pa  
! 
! WACCM - MMR
! WRFChem - VMR ppmv
! TES CO - DU   
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
   if(use_log_co2) then
      co2_min = log(co2_min)
   endif
   
! Assign vertical grid information (TES CO grid is top to bottom)

   layer_tes   = nlayer(key)
   level_tes   = nlayer(key)+1
   klev_tes    = klev(key)
   kend_tes    = kend(key)
   layer_mdl   = nlayer_model
   level_mdl   = nlayer_model+1

   allocate(prs_tes(layer_tes))
   allocate(prs_tes_mem(layer_tes))
   prs_tes(1:layer_tes)=pressure(key,1:layer_tes)

! Get location infomation

   mloc = get_location(location)
   
   if (mloc(2) >  90.0_r8) then
      mloc(2) =  90.0_r8
   elseif (mloc(2) < -90.0_r8) then
      mloc(2) = -90.0_r8
   endif
   obs_prs=mloc(3)
!
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

   co2_mdl_1(:)=missing_r8
   tmp_mdl_1(:)=missing_r8
   qmr_mdl_1(:)=missing_r8
   prs_mdl_1(:)=missing_r8

   do k=1,layer_mdl
      level=real(k)
      zstatus(:)=0
      loc2 = set_location(mloc(1), mloc(2), level, VERTISLEVEL)
      call interpolate(state_handle, ens_size, loc2, QTY_CO2, co2_mdl_1, zstatus) ! ppmv 
      zstatus(:)=0
      call interpolate(state_handle, ens_size, loc2, QTY_TEMPERATURE, tmp_mdl_1, zstatus) ! K 
      zstatus(:)=0
      call interpolate(state_handle, ens_size, loc2, QTY_VAPOR_MIXING_RATIO, qmr_mdl_1, zstatus) ! kg / kg 
      zstatus(:)=0
      call interpolate(state_handle, ens_size, loc2, QTY_PRESSURE, prs_mdl_1, zstatus) ! Pa
!
      interp_new=0
      do imem=1,ens_size
         if(co2_mdl_1(imem).eq.missing_r8 .or. tmp_mdl_1(imem).eq.missing_r8 .or. &
         qmr_mdl_1(imem).eq.missing_r8 .or. prs_mdl_1(imem).eq.missing_r8) then
            interp_new=1
            exit
         endif
      enddo
      if(interp_new.eq.0) then
         exit
      endif    
   enddo

   write(string1, *)'APM: co2 lower bound 1 ',level,co2_mdl_1
   call error_handler(E_MSG, routine, string1, source)
   write(string1, *)'APM: tmp lower bound 1 ',level,tmp_mdl_1
   call error_handler(E_MSG, routine, string1, source)
   write(string1, *)'APM: qmr lower bound 1 ',level,qmr_mdl_1
   call error_handler(E_MSG, routine, string1, source)
   write(string1, *)'APM: prs lower bound 1 ',level,prs_mdl_1
   call error_handler(E_MSG, routine, string1, source)

   co2_mdl_n(:)=missing_r8
   tmp_mdl_n(:)=missing_r8
   qmr_mdl_n(:)=missing_r8
   prs_mdl_n(:)=missing_r8

   do k=layer_mdl,1,-1
      level=real(k)
      zstatus(:)=0
      loc2 = set_location(mloc(1), mloc(2), level, VERTISLEVEL)
      call interpolate(state_handle, ens_size, loc2, QTY_CO2, co2_mdl_n, zstatus) ! ppmv
      zstatus(:)=0
      call interpolate(state_handle, ens_size, loc2, QTY_TEMPERATURE, tmp_mdl_n, zstatus) ! K 
      zstatus(:)=0
      call interpolate(state_handle, ens_size, loc2, QTY_VAPOR_MIXING_RATIO, qmr_mdl_n, zstatus) ! kg / kg 
      zstatus(:)=0
      call interpolate(state_handle, ens_size, loc2, QTY_PRESSURE, prs_mdl_n, zstatus) ! Pa
!
      interp_new=0
      do imem=1,ens_size
         if(co2_mdl_n(imem).eq.missing_r8 .or. tmp_mdl_n(imem).eq.missing_r8 .or. &
         qmr_mdl_n(imem).eq.missing_r8 .or. prs_mdl_n(imem).eq.missing_r8) then
            interp_new=1
            exit
         endif
      enddo
      if(interp_new.eq.0) then
         exit
      endif    
   enddo

   write(string1, *)'APM: co2 upper bound n ',level,co2_mdl_n
   call error_handler(E_MSG, routine, string1, source)
   write(string1, *)'APM: tmp upper bound n ',level,tmp_mdl_n
   call error_handler(E_MSG, routine, string1, source)
   write(string1, *)'APM: qmr upper bound n ',level,qmr_mdl_n
   call error_handler(E_MSG, routine, string1, source)
   write(string1, *)'APM: prs upper bound n ',level,prs_mdl_n
   call error_handler(E_MSG, routine, string1, source)


 return  

! Get profiles at TES pressure levels

   allocate(co2_val(ens_size,layer_tes))
   allocate(tmp_val(ens_size,layer_tes))
   allocate(qmr_val(ens_size,layer_tes))

   do k=1,layer_tes
      zstatus=0
      loc2 = set_location(mloc(1), mloc(2), prs_tes(k), VERTISPRESSURE)
      call interpolate(state_handle, ens_size, loc2, QTY_CO2, co2_val(:,k), zstatus)  
      zstatus=0
      call interpolate(state_handle, ens_size, loc2, QTY_TEMPERATURE, tmp_val(:,k), zstatus)  
      zstatus=0
      call interpolate(state_handle, ens_size, loc2, QTY_VAPOR_MIXING_RATIO, qmr_val(:,k), zstatus)  
!
! Correcting for expected failures near the surface
      do imem=1,ens_size
         if (prs_tes(k).ge.prs_mdl_1(imem)) then
            co2_val(imem,k) = co2_mdl_1(imem)
            tmp_val(imem,k) = tmp_mdl_1(imem)
            qmr_val(imem,k) = qmr_mdl_1(imem)
         endif
!
! Correcting for expected failures near the top
         if (prs_tes(k).le.prs_mdl_n(imem)) then
            co2_val(imem,k) = co2_mdl_n(imem)
            tmp_val(imem,k) = tmp_mdl_n(imem)
            qmr_val(imem,k) = qmr_mdl_n(imem)
         endif
      enddo

!      write(string1, *)'APM: co2 ',key,k,co2_val(1,k)
!      call error_handler(E_MSG, routine, string1, source)
!      write(string1, *)'APM: tmp ',key,k,tmp_val(1,k)
!      call error_handler(E_MSG, routine, string1, source)
!      write(string1, *)'APM: qmr ',key,k,qmr_val(1,k)
!      call error_handler(E_MSG, routine, string1, source)

! Check data for missing values      
      do imem=1,ens_size
         if(co2_val(imem,k).eq.missing_r8 .or. tmp_val(imem,k).eq.missing_r8 .or. &
         qmr_val(imem,k).eq.missing_r8) then
            zstatus(:)=20
            expct_val(:)=missing_r8
!            write(string1, *) 'APM: Model profile data has missing values for obs, level ',key,k
!            call error_handler(E_ALLMSG, routine, string1, source)
!            call track_status(ens_size, zstatus, expct_val, istatus, return_now)
            do imemm=1,ens_size
               write(string1, *) &
               'APM: Model profile values: co2,tmp,qmr',key,imem,k,co2_val(imemm,k), &
               tmp_val(imemm,k),qmr_val(imemm,k)     
               call error_handler(E_ALLMSG, routine, string1, source)
            enddo
            return
         endif
      enddo
!
! Convert units for co2 from ppmv
      co2_val(:,k) = co2_val(:,k) * 1.e-6_r8
      co2_mdl_1(:) = co2_mdl_1(:) * 1.e-6_r8
      co2_mdl_n(:) = co2_mdl_n(:) * 1.e-6_r8
   enddo
!
! Use large scale co2 data above the regional model top
! TES vertical is from bottom to top   
   do imem=1,ens_size
      kstart=-1
      if (prs_tes(layer_tes).lt.prs_mdl_n(imem)) then
         do k=1,layer_tes
            if (prs_tes(k).lt.prs_mdl_n(imem)) then
               kstart=k
               exit
            endif
         enddo
         ncnt=layer_tes-kstart+1
         allocate(prs_tes_top(ncnt))
         allocate(co2_prf_mdl(ncnt),tmp_prf_mdl(ncnt),qmr_prf_mdl(ncnt))
         do k=kstart,layer_tes
            kk=k-kstart+1
            prs_tes_top(kk)=prs_tes(k)
         enddo
         prs_tes_top(:)=prs_tes_top(:)/100.
!
         lon_obs=mloc(1)/rad2deg
         lat_obs=mloc(2)/rad2deg
         call get_time(obs_time,datesec_obs,date_obs)
!
         data_file=trim(upper_data_file)
         model=trim(upper_data_model)
         call get_upper_bdy_fld(fld,model,data_file,ls_chem_dx,ls_chem_dy, &
         ls_chem_dz,ls_chem_dt,lon_obs,lat_obs,prs_tes_top, &
         ncnt,co2_prf_mdl,tmp_prf_mdl,qmr_prf_mdl,date_obs,datesec_obs)
!
! Impose ensemble perturbations from level kstart(imem)-1      
         co2_prf_mdl(:)=co2_prf_mdl(:)*VMR_conv
         do k=kstart,layer_tes
            kk=k-kstart+1
            co2_val(imem,k)=co2_prf_mdl(kk)*co2_val(imem,kstart-1)/ &
            (sum(co2_val(:,kstart-1))/real(ens_size))
            tmp_val(imem,k)=tmp_prf_mdl(kk)*tmp_val(imem,kstart-1)/ &
            (sum(tmp_val(:,kstart-1))/real(ens_size))
            qmr_val(imem,k)=qmr_prf_mdl(kk)*qmr_val(imem,kstart-1)/ &
            (sum(qmr_val(:,kstart-1))/real(ens_size))
         enddo
         deallocate(prs_tes_top)
         deallocate(co2_prf_mdl,tmp_prf_mdl,qmr_prf_mdl)
      endif             
   enddo
!
! Check full profile for negative values
   do imem=1,ens_size
      flg=0
      do k=1,layer_tes   

!         if(key.eq.1 .and. imem.eq.1) then
!            write(string1, *) &
!            'APM: co2 values: imem,k,co2 ',imem,k,co2_val(imem,k)
!            call error_handler(E_MSG, routine, string1, source)
!         endif

         if(co2_val(imem,k).lt.0. .or. tmp_val(imem,k).lt.0. .or. &
         qmr_val(imem,k).lt.0.) then
            flg=1   
            write(string1, *) &
            'APM: Recentered full profile has negative values for key,imem ',key,imem
            call error_handler(E_ALLMSG, routine, string1, source)
            call track_status(ens_size, zstatus, expct_val, istatus, return_now)
         endif
      enddo
      if(flg.eq.1) exit
   enddo

   istatus(:)=0
   zstatus(:)=0.
   expct_val(:)=0.0
   allocate(thick(layer_tes))

   do imem=1,ens_size
! Define upper and lower values for layer grid
! (TES CO2 grid is bottom to top) prs is in Pa
      prs_tes_mem(:)=prs_tes(:)      
! Definitions for k=1 or k=layer_tes
      prs_bot=prs_sfc(imem)
      if (prs_bot.le.prs_tes_mem(1)) then
         prs_bot=prs_tes_mem(1)+prs_del
      endif   
! Bottom terms
      co2_bot=co2_val(imem,1)
      tmp_bot=tmp_val(imem,1)
      qmr_bot=qmr_val(imem,1)
! Top terms
      prs_top=prs_tes(layer_tes)+(prs_tes(layer_tes)-prs_tes(layer_tes-1))/2.
      if(prs_top.le.0.) prs_top=bdy_coef*prs_tes(layer_tes)
! co2
      delta=(co2_val(imem,layer_tes)-co2_val(imem,layer_tes-1))/ &
      (prs_tes(layer_tes)-prs_tes(layer_tes-1))
      co2_top=co2_val(imem,layer_tes) + delta*(prs_top-prs_tes(layer_tes))
      if(co2_top.le.0.) then
         if(delta.le.0.) co2_top=bdy_coef*co2_val(imem,layer_tes)
         if(delta.gt.0.) co2_top=(2.-bdy_coef)*co2_val(imem,layer_tes)
      endif
! tmp
      delta=(tmp_val(imem,layer_tes)-tmp_val(imem,layer_tes-1))/ &
      (prs_tes(layer_tes)-prs_tes(layer_tes-1))
      tmp_top=tmp_val(imem,layer_tes) + delta*(prs_top-prs_tes(layer_tes))
      if(tmp_top.le.0.) then
         if(delta.le.0.) tmp_top=bdy_coef*tmp_val(imem,layer_tes)
         if(delta.gt.0.) tmp_top=(2.-bdy_coef)*tmp_val(imem,layer_tes)
      endif
! qmr
      delta=(qmr_val(imem,layer_tes)-qmr_val(imem,layer_tes-1))/ &
      (prs_tes(layer_tes)-prs_tes(layer_tes-1))
      qmr_top=qmr_val(imem,layer_tes) + delta*(prs_top-prs_tes(layer_tes))
      if(qmr_top.le.0.) then
         if(delta.le.0.) qmr_top=bdy_coef*qmr_val(imem,layer_tes)
         if(delta.gt.0.) qmr_top=(2.-bdy_coef)*qmr_val(imem,layer_tes)
      endif
!
! VERTICAL SUMMATION
! k=1 term      
      k=1
! co2 term (Units are VMR, calculate layer average)
         lnpr_mid=(log(prs_tes_mem(k+1))+log(prs_bot))/2.
         up_wt=log(prs_bot)-lnpr_mid
         dw_wt=lnpr_mid-log(prs_tes_mem(k+1))
         tl_wt=up_wt+dw_wt
         if(use_log_co2) then
            co2_val_conv = (dw_wt*exp(co2_bot)+up_wt*exp(co2_val(imem,k+1)))/tl_wt
         else
            co2_val_conv = (dw_wt*co2_bot+up_wt*co2_val(imem,k+1))/tl_wt
         endif
         prior_term=avg_kernel(key,k)
         if(k.eq.klev_tes) prior_term=1.-prior_term
! expected retrieval sum
         expct_val(imem) = expct_val(imem) + co2_val_conv * &
         avg_kernel(key,k) + prior_term*prior(key,k)

!         if(key.eq.1 .and. imem.eq.1) then
!            write(string1, *)'APM: expected retr ',k,expct_val(imem), &
!            avg_kernel(key,k), co2_val_conv, prior(key,k)
!            call error_handler(E_MSG, routine, string1, source)
!         endif
!
! k=layer_tes term
      k=layer_tes
         lnpr_mid=(log(prs_top)+log(prs_tes_mem(k)))/2.
         up_wt=log(prs_tes_mem(k))-lnpr_mid
         dw_wt=lnpr_mid-log(prs_top)
         tl_wt=up_wt+dw_wt
! CO2 term (Units are VMR, calculate layer average)
         if(use_log_co2) then
            co2_val_conv = (dw_wt*exp(co2_val(imem,k))+up_wt*exp(co2_top))/tl_wt
         else
            co2_val_conv = (dw_wt*co2_val(imem,k)+up_wt*co2_top)/tl_wt
         endif
         prior_term=avg_kernel(key,k)
         if(k.eq.klev_tes) prior_term=1.-prior_term
! expected retrieval sum
         expct_val(imem) = expct_val(imem) + co2_val_conv * &
         avg_kernel(key,k) + prior_term*prior(key,k)

!         if(key.eq.1 .and. imem.eq.1) then
!            write(string1, *)'APM: expected retr ',k,expct_val(imem), &
!            avg_kernel(key,k), co2_val_conv, prior(key,k)
!            call error_handler(E_MSG, routine, string1, source)
!         endif
!      
! remaining terms
      do k=2,layer_tes-1
         prs_bot=(prs_tes_mem(k-1)+prs_tes_mem(k))/2.
         prs_top=(prs_tes_mem(k)+prs_tes_mem(k+1))/2.
         co2_bot=(co2_val(imem,k-1)+co2_val(imem,k))/2.
         co2_top=(co2_val(imem,k)+co2_val(imem,k+1))/2.
         tmp_bot=(tmp_val(imem,k-1)+tmp_val(imem,k))/2.
         tmp_top=(tmp_val(imem,k)+tmp_val(imem,k+1))/2.
         qmr_bot=(qmr_val(imem,k-1)+qmr_val(imem,k))/2.
         qmr_top=(qmr_val(imem,k)+qmr_val(imem,k+1))/2.
         lnpr_mid=(log(prs_top)+log(prs_tes_mem(k)))/2.
         up_wt=log(prs_bot)-lnpr_mid
         dw_wt=lnpr_mid-log(prs_tes_mem(k+1))
         tl_wt=up_wt+dw_wt
! co2 term (Units are VMR, calculate layer average)
         if(use_log_co2) then
            co2_val_conv = (dw_wt*exp(co2_bot)+up_wt*exp(co2_top))/tl_wt
         else
            co2_val_conv = (dw_wt*co2_bot+up_wt*co2_top)/tl_wt
         endif
         prior_term=avg_kernel(key,k)
         if(k.eq.klev_tes) prior_term=1.-prior_term
! expected retrieval
         expct_val(imem) = expct_val(imem) + co2_val_conv * &
         avg_kernel(key,k) + prior_term*prior(key,k)

!         if(key.eq.1 .and. imem.eq.1) then
!            write(string1, *)'APM: expected retr ',k,expct_val(imem), &
!            avg_kernel(key,k), co2_val_conv, prior(key,k)
!            call error_handler(E_MSG, routine, string1, source)
!         endif

      enddo
!      write(string1, *)'APM: FINAL EXPECTED VALUE ',expct_val(imem)
!      call error_handler(E_MSG, routine, string1, source)
!      write(string1, *)'  '
      call error_handler(E_MSG, routine, string1, source)
      if(expct_val(imem).lt.0) then
         zstatus(imem)=20
         expct_val(:)=missing_r8
         write(string1, *) 'APM NOTICE: TES CO2 expected value is negative '
         call error_handler(E_MSG, routine, string1, source)
         call track_status(ens_size, zstatus, expct_val, istatus, return_now)
         return
      endif
   enddo

! Clean up and return
   deallocate(co2_val, tmp_val, qmr_val)
   deallocate(thick)
   deallocate(prs_tes, prs_tes_mem)

end subroutine get_expected_tes_co2_profile

!-------------------------------------------------------------------------------

subroutine set_obs_def_tes_co2_profile(key, co2_pressure, co2_avg_kernel, co2_prior, &
co2_nlayer, co2_klev, co2_kend)

   integer,                           intent(in)   :: key, co2_nlayer, co2_klev, co2_kend
   real(r8), dimension(co2_nlayer),    intent(in)   :: co2_pressure
   real(r8), dimension(co2_nlayer),    intent(in)   :: co2_avg_kernel
   real(r8), dimension(co2_nlayer),    intent(in)   :: co2_prior
   
   if ( .not. module_initialized ) call initialize_module
   
   if(num_tes_co2_obs >= max_tes_co2_obs) then
      write(string1, *)'Not enough space for tes co2 obs.'
      write(string2, *)'Can only have max_tes_co2_obs (currently ',max_tes_co2_obs,')'
      call error_handler(E_ERR,'set_obs_def_tes_co2_profile',string1,source,revision, &
      revdate,text2=string2)
   endif
   
   nlayer(key) = co2_nlayer
   klev(key) = co2_klev
   kend(key) = co2_kend
   pressure(key,1:co2_nlayer)   = co2_pressure(1:co2_nlayer)
   avg_kernel(key,1:co2_nlayer) = co2_avg_kernel(1:co2_nlayer)
   prior(key,1:co2_nlayer)      = co2_prior(1:co2_nlayer)
   
end subroutine set_obs_def_tes_co2_profile

end module obs_def_tes_co2_profile_mod

! END DART PREPROCESS MODULE CODE
