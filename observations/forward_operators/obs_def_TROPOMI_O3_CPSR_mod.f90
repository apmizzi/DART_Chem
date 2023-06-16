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
! TROPOMI_O3_CPSR, QTY_O3
! END DART PREPROCESS TYPE DEFINITIONS
!
! BEGIN DART PREPROCESS USE OF SPECIAL OBS_DEF MODULE
!   use obs_def_tropomi_o3_cpsr_mod, only : get_expected_tropomi_o3_cpsr, &
!                                  read_tropomi_o3_cpsr, &
!                                  write_tropomi_o3_cpsr, &
!                                  interactive_tropomi_o3_cpsr
! END DART PREPROCESS USE OF SPECIAL OBS_DEF MODULE
!
! BEGIN DART PREPROCESS GET_EXPECTED_OBS_FROM_DEF
!      case(TROPOMI_O3_CPSR)                                                           
!         call get_expected_tropomi_o3_cpsr(state_handle, ens_size, location, obs_def%key, obs_time, expected_obs, istatus)  
! END DART PREPROCESS GET_EXPECTED_OBS_FROM_DEF
!
! BEGIN DART PREPROCESS READ_OBS_DEF
!      case(TROPOMI_O3_CPSR)
!         call read_tropomi_o3_cpsr(obs_def%key, ifile, fileformat)
! END DART PREPROCESS READ_OBS_DEF
!
! BEGIN DART PREPROCESS WRITE_OBS_DEF
!      case(TROPOMI_O3_CPSR)
!         call write_tropomi_o3_cpsr(obs_def%key, ifile, fileformat)
! END DART PREPROCESS WRITE_OBS_DEF
!
! BEGIN DART PREPROCESS INTERACTIVE_OBS_DEF
!      case(TROPOMI_O3_CPSR)
!         call interactive_tropomi_o3_cpsr(obs_def%key)
! END DART PREPROCESS INTERACTIVE_OBS_DEF
!
! BEGIN DART PREPROCESS MODULE CODE

module obs_def_tropomi_o3_cpsr_mod

   use             types_mod, only : r8, MISSING_R8
   
   use         utilities_mod, only : register_module, error_handler, E_ERR, E_MSG, &
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
   
   use          obs_kind_mod, only : QTY_O3, QTY_TEMPERATURE, QTY_SURFACE_PRESSURE, &
                                     QTY_PRESSURE, QTY_VAPOR_MIXING_RATIO
   
   use  ensemble_manager_mod, only : ensemble_type
   
   use obs_def_utilities_mod, only : track_status
   
   use      time_manager_mod, only : time_type, get_date, set_date, get_time, set_time
! get_date gets year, month, day, hour, minute, second from time_type
! get_time gets julian day and seconds from time_type
! set_date sets time_type from year, month, day, hour, minute, second
! set_time sets time_type from julian day and seconds
   implicit none
   private

   public :: write_tropomi_o3_cpsr, &
             read_tropomi_o3_cpsr, &
          interactive_tropomi_o3_cpsr, &
          get_expected_tropomi_o3_cpsr, &
          set_obs_def_tropomi_o3_cpsr

! Storage for the special information required for observations of this type
   integer, parameter    :: max_tropomi_o3_obs = 10000000
   integer               :: num_tropomi_o3_obs = 0
   integer,  allocatable :: nlayer(:)
   real(r8), allocatable :: pressure(:,:)
   real(r8), allocatable :: avg_kernel(:,:)
   real(r8), allocatable :: prior(:)

! version controlled file description for error handling, do not edit
   character(len=*), parameter :: source   = 'obs_def_tropomi_o3_cpsr_mod.f90'
   character(len=*), parameter :: revision = ''
   character(len=*), parameter :: revdate  = ''
   
   character(len=512) :: string1, string2
   
   logical, save :: module_initialized = .false.

! Namelist with default values
   logical :: use_log_o3   = .false.
   integer :: nlayer_model = -9999
   integer :: nlayer_tropomi = -9999
   integer :: nlayer_tropomi_o3_total_col = -9999
   integer :: nlayer_tropomi_o3_trop_col = -9999
   integer :: nlayer_tropomi_o3_profile = -9999
   
   namelist /obs_def_TROPOMI_O3_nml/ use_log_o3, nlayer_model, nlayer_tropomi_o3_total_col, &
   nlayer_tropomi_o3_trop_col, nlayer_tropomi_o3_profile
   
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
   call find_namelist_in_file("input.nml", "obs_def_TROPOMI_O3_nml", iunit)
   read(iunit, nml = obs_def_TROPOMI_O3_nml, iostat = rc)
   call check_namelist_read(iunit, rc, "obs_def_TROPOMI_O3_nml")

! Record the namelist values
   if (do_nml_file()) write(nmlfileunit, nml=obs_def_TROPOMI_O3_nml)
   if (do_nml_term()) write(     *     , nml=obs_def_TROPOMI_O3_nml)
   nlayer_tropomi=nlayer_tropomi_o3_profile
   
! Check for valid values

   if (nlayer_model < 1) then
      write(string1,*)'obs_def_TROPOMI_O3_nml:nlayer_model must be > 0, it is ',nlayer_model
      call error_handler(E_ERR,'initialize_module',string1,source)
   endif
   
   if (nlayer_tropomi < 1) then
      write(string1,*)'obs_def_TROPOMI_O3_nml:nlayer_tropomi must be > 0, it is ',nlayer_tropomi
      call error_handler(E_ERR,'initialize_module',string1,source)
   endif
   
   allocate(    nlayer(max_tropomi_o3_obs))
   allocate(  pressure(max_tropomi_o3_obs,nlayer_tropomi+1))
   allocate(avg_kernel(max_tropomi_o3_obs,nlayer_tropomi))
   allocate(     prior(max_tropomi_o3_obs))
   
end subroutine initialize_module

!-------------------------------------------------------------------------------

subroutine read_tropomi_o3_cpsr(key, ifile, fform)

   integer,          intent(out)          :: key
   integer,          intent(in)           :: ifile
   character(len=*), intent(in), optional :: fform

! tropomirary arrays to hold buffer till we decide if we have enough room

   integer               :: keyin
   integer               :: nlayer_1
   real(r8)              :: prior_1
   real(r8), allocatable :: pressure_1(:)
   real(r8), allocatable :: avg_kernel_1(:)
   character(len=32)     :: fileformat
   
   integer, SAVE :: counts1 = 0
   
   if ( .not. module_initialized ) call initialize_module
   
   fileformat = "ascii" 
   if(present(fform)) fileformat = adjustl(fform)
   
! Need to know how many layers for this one
   nlayer_1 = read_int_scalar( ifile, fileformat, 'nlayer_1')
   prior_1 = read_r8_scalar( ifile, fileformat, 'prior_1')
   
   allocate(  pressure_1(nlayer_1+1))
   allocate(avg_kernel_1(nlayer_1))   

   call read_r8_array(ifile, nlayer_1+1, pressure_1,   fileformat, 'pressure_1')
   call read_r8_array(ifile, nlayer_1,   avg_kernel_1, fileformat, 'avg_kernel_1')
   keyin = read_int_scalar(ifile, fileformat, 'nlayer_1')
   
   counts1 = counts1 + 1
   key     = counts1
   
   if(counts1 > max_tropomi_o3_obs) then
      write(string1, *)'Not enough space for tropomi o3 obs.'
      write(string2, *)'Can only have max_tropomi_o3_obs (currently ',max_tropomi_o3_obs,')'
      call error_handler(E_ERR,'read_tropomi_o3_cpsr',string1,source,text2=string2)
   endif
   
   call set_obs_def_tropomi_o3_cpsr(key, pressure_1, avg_kernel_1, prior_1, nlayer_1)
   
   deallocate(pressure_1, avg_kernel_1)
   
end subroutine read_tropomi_o3_cpsr

!-------------------------------------------------------------------------------

subroutine write_tropomi_o3_cpsr(key, ifile, fform)

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
   call write_r8_scalar(ifile,                     prior(key), fileformat,'prior')
   call write_r8_array(  ifile, nlayer(key)+1,  pressure(key,:), fileformat,'pressure')
   call write_r8_array(  ifile, nlayer(key),  avg_kernel(key,:), fileformat,'avg_kernel')
   call write_int_scalar(ifile,                             key, fileformat,'key')
   
end subroutine write_tropomi_o3_cpsr

!-------------------------------------------------------------------------------

subroutine interactive_tropomi_o3_cpsr(key)

   integer, intent(out) :: key
   
   if ( .not. module_initialized ) call initialize_module

! STOP because routine is not finished.
   write(string1,*)'interactive_tropomi_o3_cpsr not yet working.'
   call error_handler(E_ERR, 'interactive_tropomi_o3_cpsr', string1, source)
   
   if(num_tropomi_o3_obs >= max_tropomi_o3_obs) then
      write(string1, *)'Not enough space for an tropomi o3 obs.'
      write(string2, *)'Can only have max_tropomi_o3_obs (currently ',max_tropomi_o3_obs,')'
      call error_handler(E_ERR, 'interactive_tropomi_o3_cpsr', string1, &
                 source, text2=string2)
   endif
   
! Increment the index
   num_tropomi_o3_obs = num_tropomi_o3_obs + 1
   key            = num_tropomi_o3_obs

! Otherwise, prompt for input for the three required beasts

   write(*, *) 'Creating an interactive_tropomi_o3_cpsr observation'
   write(*, *) 'This featue is not setup '

end subroutine interactive_tropomi_o3_cpsr

!-------------------------------------------------------------------------------

subroutine get_expected_tropomi_o3_cpsr(state_handle, ens_size, location, key, obs_time, expct_val, istatus)

   type(ensemble_type), intent(in)  :: state_handle
   type(location_type), intent(in)  :: location
   integer,             intent(in)  :: ens_size
   integer,             intent(in)  :: key
   type(time_type),     intent(in)  :: obs_time
   integer,             intent(out) :: istatus(:)
   real(r8),            intent(out) :: expct_val(:)
   
   character(len=*), parameter :: routine = 'get_expected_tropomi_o3_cpsr'
   type(location_type) :: loc2
   
   integer :: layer_tropomi,level_tropomi, kend_tropomi
   integer :: layer_mdl,level_mdl
   integer :: k,kk,imem
   integer :: interp_new
   integer :: icnt,ncnt
   integer :: date_obs,datesec_obs
   integer, dimension(ens_size) :: zstatus, kstart
   
   real(r8) :: eps, AvogN, Rd, Ru, Cp, grav, msq2cmsq, molec2du
   real(r8) :: missing,o3_min,tmp_max
   real(r8) :: level,del_prs
   real(r8) :: tmp_vir_k, tmp_vir_kp
   real(r8) :: mloc(3)
   real(r8) :: o3_val_conv, VMR_conv
   real(r8) :: up_wt,dw_wt,tl_wt,lnpr_mid
   real(r8) :: lon_obs,lat_obs,pi,rad2deg
   real(r8) :: ensavg_o3,ensavg_tmp,ensavg_qmr
   real(r8) :: fac_o3,fac_tmp,fac_qmr

   real(r8), dimension(ens_size) :: o3_mdl_1, tmp_mdl_1, qmr_mdl_1, prs_mdl_1
   real(r8), dimension(ens_size) :: o3_mdl_n, tmp_mdl_n, qmr_mdl_n, prs_mdl_n
   real(r8), dimension(ens_size) :: prs_sfc
   
   real(r8), allocatable, dimension(:)   :: thick, prs_tropomi, prs_tropomi_mem
   real(r8), allocatable, dimension(:,:) :: o3_val, tmp_val, qmr_val
   real(r8), allocatable, dimension(:)   :: o3_prf_mdl,tmp_prf_mdl,qmr_prf_mdl
   real(r8), allocatable, dimension(:)   :: prs_tropomi_top   
   logical  :: return_now,o3_return_now,tmp_return_now,qmr_return_now
   
   if ( .not. module_initialized ) call initialize_module
   
   pi       = 4.*atan(1.)
   rad2deg  = 360./(2.*pi)
   eps      =  0.61_r8
   Rd       = 287.05_r8     ! J/kg
   Ru       = 8.316_r8      ! J/kg
   Cp       = 1006.0        ! J/kg/K
   grav     =   9.8_r8
   o3_min   = 1.e-6_r8
   msq2cmsq = 1.e4_r8
   AvogN    = 6.02214e23_r8
   missing  =-888888_r8
   tmp_max  = 600.
   del_prs  = 5000.
   VMR_conv = 28.9644/47.9982
   molec2du = 1. / 2.6867e20
! 
! WACCM - MMR
! WRFChem - VMR ppmv
! TROPOMI O3 - DU   
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
   if(use_log_o3) then
      o3_min = log(o3_min)
   endif
   
! Assign vertical grid information

   layer_tropomi = nlayer(key)
   level_tropomi = nlayer(key)+1
!   kend_tropomi  = kend(key)
   layer_mdl=nlayer_model
   level_mdl=nlayer_model+1

   allocate(prs_tropomi(level_tropomi))
   allocate(prs_tropomi_mem(level_tropomi))
   prs_tropomi(1:level_tropomi)=pressure(key,1:level_tropomi)

! Get location infomation

   mloc = get_location(location)
   
   if (    mloc(2) >  90.0_r8) then
           mloc(2) =  90.0_r8
   elseif (mloc(2) < -90.0_r8) then
           mloc(2) = -90.0_r8
   endif
!   write(string1, *) 'APM: observation ',key, ' lon ',mloc(1),' lat ',mloc(2)
!   call error_handler(E_MSG, routine, string1, source)
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

   o3_mdl_1(:)=missing_r8
   tmp_mdl_1(:)=missing_r8
   qmr_mdl_1(:)=missing_r8
   prs_mdl_1(:)=missing_r8

   do k=1,layer_mdl
      level=real(k)
      zstatus(:)=0
      loc2 = set_location(mloc(1), mloc(2), level, VERTISLEVEL)
      call interpolate(state_handle, ens_size, loc2, QTY_O3, o3_mdl_1, zstatus) ! ppmv 
      zstatus(:)=0
      call interpolate(state_handle, ens_size, loc2, QTY_TEMPERATURE, tmp_mdl_1, zstatus) ! K 
      zstatus(:)=0
      call interpolate(state_handle, ens_size, loc2, QTY_VAPOR_MIXING_RATIO, qmr_mdl_1, zstatus) ! kg / kg 
      zstatus(:)=0
      call interpolate(state_handle, ens_size, loc2, QTY_PRESSURE, prs_mdl_1, zstatus) ! Pa
!
      interp_new=0
      do imem=1,ens_size
         if(o3_mdl_1(imem).eq.missing_r8 .or. tmp_mdl_1(imem).eq.missing_r8 .or. &
         qmr_mdl_1(imem).eq.missing_r8 .or. prs_mdl_1(imem).eq.missing_r8) then
            interp_new=1
            exit
         endif
      enddo
      if(interp_new.eq.0) then
         exit
      endif    
   enddo
      
!   write(string1, *) 'APM: o3 lower bound ',o3_mdl_1
!   call error_handler(E_MSG, routine, string1, source)
!   write(string1, *) 'APM: tmp lower bound ',tmp_mdl_1
!   call error_handler(E_MSG, routine, string1, source)
!   write(string1, *) 'APM: qmr lower bound ',qmr_mdl_1
!   call error_handler(E_MSG, routine, string1, source)
!   write(string1, *) 'APM: prs lower bound ',prs_mdl_1
!   call error_handler(E_MSG, routine, string1, source)

   o3_mdl_n(:)=missing_r8
   tmp_mdl_n(:)=missing_r8
   qmr_mdl_n(:)=missing_r8
   prs_mdl_n(:)=missing_r8

   do k=layer_mdl,1,-1
      level=real(k)
      zstatus(:)=0
      loc2 = set_location(mloc(1), mloc(2), level, VERTISLEVEL)
      call interpolate(state_handle, ens_size, loc2, QTY_O3, o3_mdl_n, zstatus) 
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
         if(o3_mdl_n(imem).eq.missing_r8 .or. tmp_mdl_n(imem).eq.missing_r8 .or. &
         qmr_mdl_n(imem).eq.missing_r8 .or. prs_mdl_n(imem).eq.missing_r8) then
            interp_new=1
            exit
         endif
      enddo
      if(interp_new.eq.0) then
         exit
      endif    
   enddo

!   write(string1, *) 'APM: o3 upper bound ',o3_mdl_n
!   call error_handler(E_MSG, routine, string1, source)
!   write(string1, *) 'APM: tmp upper bound ',tmp_mdl_n
!   call error_handler(E_MSG, routine, string1, source)
!   write(string1, *) 'APM: qmr upper bound ',qmr_mdl_n
!   call error_handler(E_MSG, routine, string1, source)
!   write(string1, *) 'APM: prs upper bound ',prs_mdl_n
!   call error_handler(E_MSG, routine, string1, source)

! Get cpsrs at TROPOMI pressure levels

   allocate( o3_val(ens_size,level_tropomi))
   allocate(tmp_val(ens_size,level_tropomi))
   allocate(qmr_val(ens_size,level_tropomi))

   do k=1,level_tropomi
      zstatus=0
      loc2 = set_location(mloc(1), mloc(2), prs_tropomi(k), VERTISPRESSURE)
      call interpolate(state_handle, ens_size, loc2, QTY_O3, o3_val(:,k), zstatus)  
      zstatus=0
      call interpolate(state_handle, ens_size, loc2, QTY_TEMPERATURE, tmp_val(:,k), zstatus)  
      zstatus=0
      call interpolate(state_handle, ens_size, loc2, QTY_VAPOR_MIXING_RATIO, qmr_val(:,k), zstatus)  
!
! Correcting for expected failures near the surface
      do imem=1,ens_size
         if (prs_tropomi(k).ge.prs_mdl_1(imem)) then
            o3_val(imem,k) = o3_mdl_1(imem)
            tmp_val(imem,k) = tmp_mdl_1(imem)
            qmr_val(imem,k) = qmr_mdl_1(imem)
            cycle
         endif
!
! Correcting for expected failures near the top
         if (prs_tropomi(k).le.prs_mdl_n(imem)) then
            o3_val(imem,k) = o3_mdl_n(imem)
            tmp_val(imem,k) = tmp_mdl_n(imem)
            qmr_val(imem,k) = qmr_mdl_n(imem)
            cycle
         endif
      enddo

!      write(string1, *)'APM: o3 ',k,o3_val(1,k)
!      call error_handler(E_MSG, routine, string1, source)
!      write(string1, *)'APM: tmp ',k,tmp_val(1,k)
!      call error_handler(E_MSG, routine, string1, source)
!      write(string1, *)'APM: qmr ',k,qmr_val(1,k)
!      call error_handler(E_MSG, routine, string1, source)

! Check data for missing values      
      do imem=1,ens_size
         if(o3_val(imem,k).eq.missing_r8 .or. tmp_val(imem,k).eq.missing_r8 .or. &
         qmr_val(imem,k).eq.missing_r8) then
            zstatus(:)=20
            expct_val(:)=missing_r8
            write(string1, *) 'APM: Input data has missing values ',o3_val(imem,k), &
            tmp_val(imem,k),qmr_val(imem,k)
            call error_handler(E_MSG, routine, string1, source)
            call track_status(ens_size, zstatus, expct_val, istatus, return_now)
            return
         endif
      enddo
!
! Convert units for o3 from ppmv
      o3_val(:,k) = o3_val(:,k) * 1.e-6_r8
   enddo
!
! Use large scale ozone data above the regional model top
   kstart(:)=-1
   do imem=1,ens_size
      do k=1,level_tropomi
         if (prs_tropomi(k).ge.prs_mdl_n(imem)) then
            kstart(imem)=k-1
!            write(string1, *) 'APM: imem,k-1,prs,mdl_n ',imem,k-1,prs_tropomi(k-1), &
!            prs_mdl_n(imem),prs_tropomi(k)
!            call error_handler(E_MSG, routine, string1, source)
            exit
         endif
      enddo
      if(kstart(imem).lt.0.) then
         write(string1, *) 'APM: Member ',imem,' kstart less than zero'
         call error_handler(E_MSG, routine, string1, source)
      endif   
      ncnt=kstart(imem)
      allocate(prs_tropomi_top(ncnt))
      allocate(o3_prf_mdl(ncnt),tmp_prf_mdl(ncnt),qmr_prf_mdl(ncnt))
      do k=1,kstart(imem)
         prs_tropomi_top(k)=prs_tropomi(k)
      enddo
      prs_tropomi_top(:)=prs_tropomi_top(:)/100.
!
      lon_obs=mloc(1)/rad2deg
      lat_obs=mloc(2)/rad2deg
      call get_time(obs_time,datesec_obs,date_obs)
!
      call get_upper_bdy_o3(lon_obs,lat_obs,prs_tropomi_top,ncnt, &
      o3_prf_mdl,tmp_prf_mdl,qmr_prf_mdl,date_obs,datesec_obs)

      o3_prf_mdl(:)=o3_prf_mdl(:)*VMR_conv
!
! Save upper BC data in the cpsrs   
      do k=1,kstart(imem)
         o3_val(imem,k)=o3_prf_mdl(k)
         tmp_val(imem,k)=tmp_prf_mdl(k)
         qmr_val(imem,k)=qmr_prf_mdl(k)
      enddo
      deallocate(prs_tropomi_top)
      deallocate(o3_prf_mdl,tmp_prf_mdl,qmr_prf_mdl)
!      do k=1,level_tropomi
!         write(string1, *) 'APM: imem,k,prs,o3,tmp,qmr ',imem,k,prs_tropomi(k), &
!         o3_val(imem,k),tmp_val(imem,k),qmr_val(imem,k)
!         call error_handler(E_MSG, routine, string1, source)
!      enddo
   enddo
!
! Impose ensemble perturbations from level kstart+1   
   do imem=1,ens_size
      ensavg_o3=0.
      ensavg_tmp=0.
      ensavg_qmr=0.
      do k=1,ens_size
         ensavg_o3=ensavg_o3+o3_val(k,kstart(imem)+1)/real(ens_size)
         ensavg_tmp=ensavg_tmp+tmp_val(k,kstart(imem)+1)/real(ens_size)
         ensavg_qmr=ensavg_qmr+qmr_val(k,kstart(imem)+1)/real(ens_size)
!         write(string1, *) 'APM: imem,k,kstart,ensavg,o3_val ', &
!         imem,k,kstart(imem),ensavg_o3,o3_val(k,kstart(imem)-1)
!         call error_handler(E_MSG, routine, string1, source)
      enddo
!      write(string1, *) 'APM: o3, tmp, qmr ',imem,ensavg_o3,ensavg_tmp,ensavg_qmr 
!      call error_handler(E_MSG, routine, string1, source)
!
      fac_o3=o3_val(imem,kstart(imem)+1)/ensavg_o3
      fac_tmp=tmp_val(imem,kstart(imem)+1)/ensavg_tmp
      fac_qmr=qmr_val(imem,kstart(imem)+1)/ensavg_qmr      
      do k=1,kstart(imem)
         o3_val(imem,k)=o3_val(imem,k)*fac_o3
         tmp_val(imem,k)=tmp_val(imem,k)*fac_tmp
         qmr_val(imem,k)=qmr_val(imem,k)*fac_qmr
      enddo
   enddo
!   do k=1,level_tropomi
!      write(string1, *) 'APM: o3 ',k,o3_val(1,k),o3_val(int(ens_size/2),k), &
!      o3_val(ens_size,k)
!      call error_handler(E_MSG, routine, string1, source)
!   enddo
   istatus=0
   zstatus(:)=0.
   expct_val(:)=0.0
   allocate(thick(layer_tropomi))

   do imem=1,ens_size
! Adjust the TROPOMI pressure for WRF-Chem lower/upper boudary pressure
! (TROPOMI O3 vertical grid is top to bottom)
      prs_tropomi_mem(:)=prs_tropomi(:)
      if (prs_sfc(imem).gt.prs_tropomi_mem(level_tropomi)) then
         prs_tropomi_mem(level_tropomi)=prs_sfc(imem)
      endif   

! Calculate the thicknesses

      thick(:)=0.
      do k=1,layer_tropomi
         lnpr_mid=(log(prs_tropomi_mem(k))+log(prs_tropomi_mem(k+1)))/2.
         up_wt=log(prs_tropomi_mem(k+1))-lnpr_mid
         dw_wt=log(lnpr_mid)-log(prs_tropomi_mem(k))
         tl_wt=up_wt+dw_wt
         tmp_vir_k  = (1.0_r8 + eps*qmr_val(imem,k))*tmp_val(imem,k)
         tmp_vir_kp = (1.0_r8 + eps*qmr_val(imem,k+1))*tmp_val(imem,k+1)
         thick(k)   = Rd*(dw_wt*tmp_vir_kp + up_wt*tmp_vir_k)/tl_wt/grav* &
         log(prs_tropomi_mem(k+1)/prs_tropomi_mem(k))
      enddo

! Process the vertical summation
   
      do k=1,layer_tropomi
         lnpr_mid=(log(prs_tropomi_mem(k))+log(prs_tropomi_mem(k+1)))/2.
         up_wt=log(prs_tropomi_mem(k+1))-lnpr_mid
         dw_wt=log(lnpr_mid)-log(prs_tropomi_mem(k))
         tl_wt=up_wt+dw_wt
   
! Convert from VMR to molar density (mol/m^3)
         if(use_log_o3) then
            o3_val_conv = (dw_wt*exp(o3_val(imem,k+1))+up_wt*exp(o3_val(imem,k)))/tl_wt * &
            (dw_wt*prs_tropomi_mem(k+1)+up_wt*prs_tropomi_mem(k)) / &
            (Ru*(dw_wt*tmp_val(imem,k+1)+up_wt*tmp_val(imem,k)))
         else
            o3_val_conv = (dw_wt*o3_val(imem,k+1)+up_wt*o3_val(imem,k))/tl_wt * &
            (dw_wt*prs_tropomi_mem(k+1)+up_wt*prs_tropomi_mem(k)) / &
            (Ru*(dw_wt*tmp_val(imem,k+1)+up_wt*tmp_val(imem,k)))
         endif
!
! Convert from mol/m^2 to DU 
         o3_val_conv=o3_val_conv*AvogN*molec2du
 
! Get expected observation
         expct_val(imem) = expct_val(imem) + thick(k) * o3_val_conv * &
         avg_kernel(key,k)
         if(imem.eq.1) then         
            write(string1, *) 'APM Summation : ', &
            k,expct_val(imem),(prs_tropomi_mem(k)+prs_tropomi_mem(k+1))/2., &
            thick(k), o3_val_conv, avg_kernel(key,k)
            call error_handler(E_MSG, routine, string1, source)
         endif
         expct_val(imem)=expct_val(imem)
      enddo
!
      if(imem.eq.1) then         
         write(string1, *) &
         'APM: Member ',imem,'Expected Value ',expct_val(imem)
         call error_handler(E_MSG, routine, string1, source)
      endif
!      
      if(isnan(expct_val(imem))) then
         zstatus(imem)=20
         expct_val(:)=missing_r8
         write(string1, *) &
         'APM NOTICE: TROPOMI O3 expected value is NaN '
         call error_handler(E_MSG, routine, string1, source)
         call track_status(ens_size, zstatus, expct_val, istatus, return_now)
         return
      endif
!
      if(expct_val(imem).lt.0) then
         zstatus(imem)=20
         expct_val(:)=missing_r8
         write(string1, *) &
         'APM NOTICE: TROPOMI O3 expected value is negative '
         call error_handler(E_MSG, routine, string1, source)
         call track_status(ens_size, zstatus, expct_val, istatus, return_now)
         return
      endif
   enddo

! Clean up and return
   deallocate(o3_val, tmp_val, qmr_val)
   deallocate(thick)
   deallocate(prs_tropomi, prs_tropomi_mem)

end subroutine get_expected_tropomi_o3_cpsr

!-------------------------------------------------------------------------------

subroutine get_upper_bdy_o3(lon_obs,lat_obs,prs_obs,nprs_obs, &
o3_prf_mdl,tmp_prf_mdl,qmr_prf_mdl,date_obs,datesec_obs)
  
   implicit none
! mozart
!   integer,parameter                                :: nx=17
!   integer,parameter                                :: ny=13
!   integer,parameter                                :: nz=56
!   integer,parameter                                :: ntim=368
! mozart
   integer,parameter                                :: nx=17
   integer,parameter                                :: ny=16
   integer,parameter                                :: nz=88
   integer,parameter                                :: ntim=69

   integer,                           intent(in)    :: nprs_obs
   real(r8),                          intent(in)    :: lon_obs,lat_obs
   real(r8),dimension(nprs_obs),      intent(in)    :: prs_obs
   real(r8),dimension(nprs_obs),      intent(out)   :: o3_prf_mdl,tmp_prf_mdl,qmr_prf_mdl
   integer                                          :: i,j,k,kk,itim
   integer                                          :: indx,jndx,kndx
   integer                                          :: date_obs,datesec_obs
   integer                                          :: itim_sav,year,month,day,hour,minute,second
   type(time_type)                                  :: time_var
   integer                                          :: jdate_obs,jdate_bck,jdate_fwd,yrleft,jday
   integer,dimension(ntim)                          :: date,datesec
   real                                             :: pi,rad2deg
   real                                             :: bck_xwt,fwd_xwt
   real                                             :: bck_ywt,fwd_ywt
   real                                             :: zwt_up,zwt_dw
   real                                             :: twtx,twty,twt
   real                                             :: ztrp_jbck,ztrp_jfwd
   real                                             :: wt_bck,wt_fwd   
   real,dimension(nx)                               :: lon_glb
   real,dimension(ny)                               :: lat_glb
   real,dimension(nz)                               :: prs_glb,ztrp_o3,ztrp_tmp,ztrp_qmr
   real,dimension(nz)                               :: o3_glb_xmym,o3_glb_xpym,o3_glb_xmyp,o3_glb_xpyp
   real,dimension(nz)                               :: tmp_glb_xmym,tmp_glb_xpym,tmp_glb_xmyp,tmp_glb_xpyp
   real,dimension(nz)                               :: qmr_glb_xmym,qmr_glb_xpym,qmr_glb_xmyp,qmr_glb_xpyp
   real,dimension(nx,ny,nz,ntim)                    :: o3_glb,tmp_glb,qmr_glb
   character(len=120)                               :: data_file
   character(len=*), parameter                      :: routine = 'get_upper_bdy_o3'
!
!______________________________________________________________________________________________   
!
! Read the upper boundary large scale data (do this once)
!______________________________________________________________________________________________   
!
   pi=4.*atan(1.)
   rad2deg=360./(2.*pi)
   data_file='/nobackupp11/amizzi/INPUT_DATA/FRAPPE_REAL_TIME_DATA/mozart_forecasts/h0004.nc'
   data_file='/nobackupp11/amizzi/INPUT_DATA/FIREX_REAL_TIME_DATA/cam_chem_forecasts/waccm_0001.nc'
   o3_prf_mdl(:)=0.
   tmp_prf_mdl(:)=0.
   qmr_prf_mdl(:)=0.
!
   call get_MOZART_INT_DATA(data_file,'date',ntim,1,1,1,date)
   call get_MOZART_INT_DATA(data_file,'datesec',ntim,1,1,1,datesec)
   call get_MOZART_REAL_DATA(data_file,'lev',nz,1,1,1,prs_glb)
   call get_MOZART_REAL_DATA(data_file,'lat',ny,1,1,1,lat_glb)
   call get_MOZART_REAL_DATA(data_file,'lon',nx,1,1,1,lon_glb)
! mozart
!   call get_MOZART_REAL_DATA(data_file,'O3_VMR_inst',nx,ny,nz,ntim,o3_glb)
! waccm
   call get_MOZART_REAL_DATA(data_file,'O3',nx,ny,nz,ntim,o3_glb)
   call get_MOZART_REAL_DATA(data_file,'T',nx,ny,nz,ntim,tmp_glb)
   call get_MOZART_REAL_DATA(data_file,'Q',nx,ny,nz,ntim,qmr_glb)
   lon_glb(:)=lon_glb(:)/rad2deg
   lat_glb(:)=lat_glb(:)/rad2deg
!
!______________________________________________________________________________________________   
!
! Find large scale data correspondeing to the observation time
!______________________________________________________________________________________________   
!
   jdate_obs=date_obs*24*60*60+datesec_obs   
   year=date(1)/10000
   yrleft=mod(date(1),10000)
   month=yrleft/100
   day=mod(yrleft,100)
   time_var=set_date(year,month,day,0,0,0)
   call get_time(time_var,second,jday)
   jdate_bck=jday*24*60*60+datesec(1)
!
   year=date(2)/10000
   yrleft=mod(date(2),10000)
   month=yrleft/100
   day=mod(yrleft,100)
   time_var=set_date(year,month,day,0,0,0)
   call get_time(time_var,second,jday)
   jdate_fwd=jday*24*60*60+datesec(2)
!   
   wt_bck=0
   wt_fwd=0
   itim_sav=0
   do itim=1,ntim-1
      if(jdate_obs.gt.jdate_bck .and. jdate_obs.le.jdate_fwd) then
         wt_bck=real(jdate_fwd-jdate_obs)
         wt_fwd=real(jdate_obs-jdate_bck)
         itim_sav=itim
         exit
      endif
      jdate_bck=jdate_fwd
      year=date(itim+1)/10000
      yrleft=mod(date(itim+1),10000)
      month=yrleft/100
      day=mod(yrleft,100)
      time_var=set_date(year,month,day,0,0,0)
      call get_time(time_var,second,jday)
      jdate_fwd=jday*24*60*60+datesec(itim+1)
   enddo
   if(itim_sav.eq.0) then
      write(string1, *) 'APM: upper bdy data not found for this time '
      call error_handler(E_MSG, routine, string1, source)
      call exit_all(-77)
   endif
!______________________________________________________________________________________________   
!
! Find large scale grid box containing the observation location
!______________________________________________________________________________________________   
!
   indx=-9999   
   do i=1,nx-1
      if(lon_obs .le. lon_glb(1)) then
         indx=1
         bck_xwt=1.
         fwd_xwt=0.
         twtx=bck_xwt+fwd_xwt
         exit
      elseif(lon_obs .ge. lon_glb(nx)) then
         indx=nx-1
         bck_xwt=0.
         fwd_xwt=1.
         twtx=bck_xwt+fwd_xwt
         exit
      elseif(lon_obs.gt.lon_glb(i) .and. &
         lon_obs.le.lon_glb(i+1)) then
         indx=i
         bck_xwt=lon_glb(i+1)-lon_obs
         fwd_xwt=lon_obs-lon_glb(i)
         twtx=bck_xwt+fwd_xwt
         exit
      endif
   enddo
   if(indx.lt.0) then
      write(string1, *) 'APM: Obs E/W location outside large scale domain'
      call error_handler(E_MSG, routine, string1, source)
      call exit_all(-77)
   endif
!
   jndx=-9999   
   do j=1,ny-1
      if(lat_obs .le. lat_glb(1)) then
         jndx=1
         bck_ywt=1.
         fwd_ywt=0.
         twty=bck_ywt+fwd_ywt
         exit
      elseif(lat_obs .ge. lat_glb(ny)) then
         jndx=ny-1
         bck_ywt=0.
         fwd_ywt=1.
         twty=bck_ywt+fwd_ywt
         exit
      elseif(lat_obs.gt.lat_glb(j) .and. &
         lat_obs.le.lat_glb(j+1)) then
         jndx=j
         bck_ywt=lat_glb(j+1)-lat_obs
         fwd_ywt=lat_obs-lat_glb(j)
         twty=bck_ywt+fwd_ywt
         exit
      endif
   enddo
   if(jndx.lt.0) then
      write(string1, *) 'APM: Obs N/S location outside large scale domain'
      call error_handler(E_MSG, routine, string1, source)
      call exit_all(-77)
   endif
!
!______________________________________________________________________________________________   
!
! Interpolate large scale field to observation location
!______________________________________________________________________________________________   
!
! Tropomiral
   do k=1,nz
      o3_glb_xmym(k)=(wt_bck*o3_glb(indx,jndx,k,itim_sav) + &
      wt_fwd*o3_glb(indx,jndx,k,itim_sav+1))/(wt_bck+wt_fwd)
      o3_glb_xpym(k)=(wt_bck*o3_glb(indx+1,jndx,k,itim_sav) + &
      wt_fwd*o3_glb(indx+1,jndx,k,itim_sav+1))/(wt_bck+wt_fwd)
      o3_glb_xmyp(k)=(wt_bck*o3_glb(indx,jndx+1,k,itim_sav) + &
      wt_fwd*o3_glb(indx,jndx+1,k,itim_sav+1))/(wt_bck+wt_fwd)
      o3_glb_xpyp(k)=(wt_bck*o3_glb(indx+1,jndx+1,k,itim_sav) + &
      wt_fwd*o3_glb(indx+1,jndx+1,k,itim_sav+1))/(wt_bck+wt_fwd)
!
      tmp_glb_xmym(k)=(wt_bck*tmp_glb(indx,jndx,k,itim_sav) + &
      wt_fwd*tmp_glb(indx,jndx,k,itim_sav+1))/(wt_bck+wt_fwd)
      tmp_glb_xpym(k)=(wt_bck*tmp_glb(indx+1,jndx,k,itim_sav) + &
      wt_fwd*tmp_glb(indx+1,jndx,k,itim_sav+1))/(wt_bck+wt_fwd)
      tmp_glb_xmyp(k)=(wt_bck*tmp_glb(indx,jndx+1,k,itim_sav) + &
      wt_fwd*tmp_glb(indx,jndx+1,k,itim_sav+1))/(wt_bck+wt_fwd)
      tmp_glb_xpyp(k)=(wt_bck*tmp_glb(indx+1,jndx+1,k,itim_sav) + &
      wt_fwd*tmp_glb(indx+1,jndx+1,k,itim_sav+1))/(wt_bck+wt_fwd)
!
      qmr_glb_xmym(k)=(wt_bck*qmr_glb(indx,jndx,k,itim_sav) + &
      wt_fwd*qmr_glb(indx,jndx,k,itim_sav+1))/(wt_bck+wt_fwd)
      qmr_glb_xpym(k)=(wt_bck*qmr_glb(indx+1,jndx,k,itim_sav) + &
      wt_fwd*qmr_glb(indx+1,jndx,k,itim_sav+1))/(wt_bck+wt_fwd)
      qmr_glb_xmyp(k)=(wt_bck*qmr_glb(indx,jndx+1,k,itim_sav) + &
      wt_fwd*qmr_glb(indx,jndx+1,k,itim_sav+1))/(wt_bck+wt_fwd)
      qmr_glb_xpyp(k)=(wt_bck*qmr_glb(indx+1,jndx+1,k,itim_sav) + &
      wt_fwd*qmr_glb(indx+1,jndx+1,k,itim_sav+1))/(wt_bck+wt_fwd)
   enddo
!
! Horizontal   
   do k=1,nz
      ztrp_jbck=(bck_xwt*o3_glb_xmym(k) + fwd_xwt*o3_glb_xpym(k))/twtx
      ztrp_jfwd=(bck_xwt*o3_glb_xmyp(k) + fwd_xwt*o3_glb_xpyp(k))/twtx
      ztrp_o3(k)=(bck_ywt*ztrp_jbck + fwd_ywt*ztrp_jfwd)/twty
!      
      ztrp_jbck=(bck_xwt*tmp_glb_xmym(k) + fwd_xwt*tmp_glb_xpym(k))/twtx
      ztrp_jfwd=(bck_xwt*tmp_glb_xmyp(k) + fwd_xwt*tmp_glb_xpyp(k))/twtx
      ztrp_tmp(k)=(bck_ywt*ztrp_jbck + fwd_ywt*ztrp_jfwd)/twty
!      
      ztrp_jbck=(bck_xwt*qmr_glb_xmym(k) + fwd_xwt*qmr_glb_xmyp(k))/twtx
      ztrp_jfwd=(bck_xwt*qmr_glb_xmyp(k) + fwd_xwt*qmr_glb_xpyp(k))/twtx
      ztrp_qmr(k)=(bck_ywt*ztrp_jbck + fwd_ywt*ztrp_jfwd)/twty      
   enddo
!
! Vertical   
   do k=1,nprs_obs
      kndx=-9999
      do kk=1,nz-1
         if(prs_obs(k).le.prs_glb(kk)) then
            kndx=1
            zwt_up=1.            
            zwt_dw=0.            
            twt=zwt_up+zwt_dw
            exit
         elseif(prs_obs(k).ge.prs_glb(nz)) then
            kndx=nz-1
            zwt_up=0.            
            zwt_dw=1.            
            twt=zwt_up+zwt_dw
            exit
         elseif(prs_obs(k).gt.prs_glb(kk) .and. &
         prs_obs(k).le.prs_glb(kk+1)) then
            kndx=kk
            zwt_up=prs_glb(kk+1)-prs_obs(k)            
            zwt_dw=prs_obs(k)-prs_glb(kk)
            twt=zwt_up+zwt_dw
            exit
         endif
      enddo
      if(kndx.le.0) then
         write(string1, *) 'APM: Obs vertical location outside large scale domain' 
         call error_handler(E_MSG, routine, string1, source)
         call exit_all(-77)
      endif
      o3_prf_mdl(k)=(zwt_up*ztrp_o3(kndx) + zwt_dw*ztrp_o3(kndx+1))/twt
      tmp_prf_mdl(k)=(zwt_up*ztrp_tmp(kndx) + zwt_dw*ztrp_tmp(kndx+1))/twt
      qmr_prf_mdl(k)=(zwt_up*ztrp_qmr(kndx) + zwt_dw*ztrp_qmr(kndx+1))/twt
   enddo
 end subroutine get_upper_bdy_o3

!-------------------------------------------------------------------------------

subroutine get_MOZART_INT_DATA(file,name,nx,ny,nz,ntim,fld)
   implicit none
   include 'netcdf.inc'
   integer,parameter                                :: maxdim=7000
   integer                                          :: nx,ny,nz,ntim
   integer                                          :: i,rc
   integer                                          :: f_id
   integer                                          :: v_id,v_ndim,typ,natts
   integer,dimension(maxdim)                        :: one
   integer,dimension(maxdim)                        :: v_dimid
   integer,dimension(maxdim)                        :: v_dim
   integer,dimension(ntim)                          :: fld
   character(len=*)                                 :: file
   character(len=*)                                 :: name
   character(len=120)                               :: v_nam
!
! open netcdf data file
   rc = nf_open(trim(file),NF_NOWRITE,f_id)
!
   if(rc.ne.0) then
      print *, 'nf_open error ',trim(file)
      stop
   endif
!
! get variables identifiers
   rc = nf_inq_varid(f_id,trim(name),v_id)
!   print *, v_id
   if(rc.ne.0) then
      print *, 'nf_inq_varid error ', v_id
      stop
   endif
!
! get dimension identifiers
   v_dimid=0
   rc = nf_inq_var(f_id,v_id,v_nam,typ,v_ndim,v_dimid,natts)
!   print *, v_dimid
   if(rc.ne.0) then
      print *, 'nf_inq_var error ', v_dimid
      stop
   endif
!
! get dimensions
   v_dim(:)=1
   do i=1,v_ndim
      rc = nf_inq_dimlen(f_id,v_dimid(i),v_dim(i))
   enddo
!   print *, v_dim
   if(rc.ne.0) then
      print *, 'nf_inq_dimlen error ', v_dim
      stop
   endif
!
! check dimensions
   if(nx.ne.v_dim(1)) then
      print *, 'ERROR: nx dimension conflict ',nx,v_dim(1)
      stop
   else if(ny.ne.v_dim(2)) then
      print *, 'ERROR: ny dimension conflict ',ny,v_dim(2)
      stop
   else if(nz.ne.v_dim(3)) then             
      print *, 'ERROR: nz dimension conflict ','1',v_dim(3)
      stop
   else if(ntim.ne.v_dim(4)) then             
      print *, 'ERROR: time dimension conflict ',1,v_dim(4)
      stop
   endif
!
! get data
   one(:)=1
   rc = nf_get_vara_int(f_id,v_id,one,v_dim,fld)
   if(rc.ne.0) then
      print *, 'nf_get_vara_real ', fld(1)
      stop
   endif
   rc = nf_close(f_id)
   return
     
end subroutine get_MOZART_INT_DATA

!-------------------------------------------------------------------------------

subroutine get_MOZART_REAL_DATA(file,name,nx,ny,nz,ntim,fld)
   implicit none
   include 'netcdf.inc'   
   integer,parameter                                :: maxdim=7000
   integer                                          :: nx,ny,nz,ntim
   integer                                          :: i,rc
   integer                                          :: f_id
   integer                                          :: v_id,v_ndim,typ,natts
   integer,dimension(maxdim)                        :: one
   integer,dimension(maxdim)                        :: v_dimid
   integer,dimension(maxdim)                        :: v_dim
   real,dimension(nx,ny,nz,ntim)                    :: fld
   character(len=*)                                 :: file
   character(len=*)                                 :: name
   character(len=120)                               :: v_nam
!
! open netcdf data file
   rc = nf_open(trim(file),NF_NOWRITE,f_id)
!   print *, 'f_id ',f_id
!
   if(rc.ne.0) then
      print *, 'nf_open error ',trim(file)
      stop
   endif
!
! get variables identifiers
   rc = nf_inq_varid(f_id,trim(name),v_id)
!   print *, 'v_id ',v_id
!
   if(rc.ne.0) then
      print *, 'nf_inq_varid error ', v_id
      stop
   endif
   !
! get dimension identifiers
   v_dimid=0
   rc = nf_inq_var(f_id,v_id,v_nam,typ,v_ndim,v_dimid,natts)
!   print *, 'v_dimid ',v_dimid
!
   if(rc.ne.0) then
      print *, 'nf_inq_var error ', v_dimid
      stop
   endif
!
! get dimensions
   v_dim(:)=1
   do i=1,v_ndim
      rc = nf_inq_dimlen(f_id,v_dimid(i),v_dim(i))
   enddo
!   print *, 'v_dim ',v_dim
!
   if(rc.ne.0) then
      print *, 'nf_inq_dimlen error ', v_dim
      stop
   endif
!
! check dimensions
   if(nx.ne.v_dim(1)) then
      print *, 'ERROR: nx dimension conflict ',nx,v_dim(1)
      stop
   else if(ny.ne.v_dim(2)) then
      print *, 'ERROR: ny dimension conflict ',ny,v_dim(2)
      stop
   else if(nz.ne.v_dim(3)) then             
      print *, 'ERROR: nz dimension conflict ','1',v_dim(3)
      stop
   else if(ntim.ne.v_dim(4)) then             
      print *, 'ERROR: time dimension conflict ',1,v_dim(4)
      stop
   endif
!
! get data
   one(:)=1
   rc = nf_get_vara_real(f_id,v_id,one,v_dim,fld)
!   print *, 'fld ', fld(1,1,1,1),fld(nx/2,ny/2,nz/2,ntim/2),fld(nx,ny,nz,ntim)
!
   if(rc.ne.0) then
      print *, 'nf_get_vara_real ', fld(1,1,1,1)
      stop
   endif
   rc = nf_close(f_id)
   return
     
end subroutine get_MOZART_REAL_DATA

!-------------------------------------------------------------------------------

subroutine set_obs_def_tropomi_o3_cpsr(key, o3_pressure, o3_avg_kernel, o3_prior, o3_nlayer)

   integer,                           intent(in)   :: key, o3_nlayer
   real(r8),                          intent(in)   :: o3_prior
   real(r8), dimension(o3_nlayer+1),  intent(in)   :: o3_pressure
   real(r8), dimension(o3_nlayer),    intent(in)   :: o3_avg_kernel
   
   if ( .not. module_initialized ) call initialize_module
   
   if(num_tropomi_o3_obs >= max_tropomi_o3_obs) then
      write(string1, *)'Not enough space for tropomi o3 obs.'
      write(string2, *)'Can only have max_tropomi_o3_obs (currently ',max_tropomi_o3_obs,')'
      call error_handler(E_ERR,'set_obs_def_tropomi_o3_cpsr',string1,source,revision, &
      revdate,text2=string2)
   endif
   
   nlayer(key) = o3_nlayer
   prior(key)  = o3_prior
   pressure(key,1:o3_nlayer+1) = o3_pressure(1:o3_nlayer+1)
   avg_kernel(key,1:o3_nlayer) = o3_avg_kernel(1:o3_nlayer)
   
end subroutine set_obs_def_tropomi_o3_cpsr

end module obs_def_tropomi_o3_cpsr_mod

! END DART PREPROCESS MODULE CODE
