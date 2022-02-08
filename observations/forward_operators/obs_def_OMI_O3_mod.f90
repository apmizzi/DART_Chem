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
! BEGIN DART PREPROCESS KIND LIST
! OMI_O3_COLUMN, QTY_O3
! END DART PREPROCESS KIND LIST
!
! BEGIN DART PREPROCESS USE OF SPECIAL OBS_DEF MODULE
!   use obs_def_omi_o3_mod, only : get_expected_omi_o3, &
!                                  read_omi_o3, &
!                                  write_omi_o3, &
!                                  interactive_omi_o3
! END DART PREPROCESS USE OF SPECIAL OBS_DEF MODULE
!
! BEGIN DART PREPROCESS GET_EXPECTED_OBS_FROM_DEF
!      case(OMI_O3_COLUMN)                                                           
!         call get_expected_omi_o3(state_handle, ens_size, location, obs_def%key, obs_time, expected_obs, istatus)  
! END DART PREPROCESS GET_EXPECTED_OBS_FROM_DEF
!
! BEGIN DART PREPROCESS READ_OBS_DEF
!      case(OMI_O3_COLUMN)
!         call read_omi_o3(obs_def%key, ifile, fileformat)
! END DART PREPROCESS READ_OBS_DEF
!
! BEGIN DART PREPROCESS WRITE_OBS_DEF
!      case(OMI_O3_COLUMN)
!         call write_omi_o3(obs_def%key, ifile, fileformat)
! END DART PREPROCESS WRITE_OBS_DEF
!
! BEGIN DART PREPROCESS INTERACTIVE_OBS_DEF
!      case(OMI_O3_COLUMN)
!         call interactive_omi_o3(obs_def%key)
! END DART PREPROCESS INTERACTIVE_OBS_DEF
!
! BEGIN DART PREPROCESS MODULE CODE

module obs_def_omi_o3_mod

   use             types_mod, only : r8, MISSING_R8

   use         utilities_mod, only : register_module, error_handler, E_ERR, E_MSG, &
                                  nmlfileunit, check_namelist_read, &
                                  find_namelist_in_file, do_nml_file, do_nml_term, &
                                  ascii_file_format

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

   public :: write_omi_o3, &
          read_omi_o3, &
          interactive_omi_o3, &
          get_expected_omi_o3, &
          set_obs_def_omi_o3

! Storage for the special information required for observations of this type
   integer, parameter    :: max_omi_o3_obs = 10000000
   integer               :: num_omi_o3_obs = 0
   integer,  allocatable :: nlayer(:)
   integer,  allocatable :: kend(:)
   real(r8), allocatable :: pressure(:,:)
   real(r8), allocatable :: avg_kernel(:,:)
   real(r8), allocatable :: prior(:,:)

! version controlled file description for error handling, do not edit
   character(len=*), parameter :: source   = 'obs_def_omi_o3_mod.f90'
   character(len=*), parameter :: revision = ''
   character(len=*), parameter :: revdate  = ''

   character(len=512) :: string1, string2

   logical, save :: module_initialized = .false.

! Namelist with default values
   logical :: use_log_o3   = .false.
   integer :: nlayer_model = -9999
   integer :: nlayer_omi_o3 = -9999

   namelist /obs_def_OMI_O3_nml/ use_log_o3, nlayer_model, nlayer_omi_o3

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
   call find_namelist_in_file("input.nml", "obs_def_OMI_O3_nml", iunit)
   read(iunit, nml = obs_def_OMI_O3_nml, iostat = rc)
   call check_namelist_read(iunit, rc, "obs_def_OMI_O3_nml")

! Record the namelist values
   if (do_nml_file()) write(nmlfileunit, nml=obs_def_OMI_O3_nml)
   if (do_nml_term()) write(     *     , nml=obs_def_OMI_O3_nml)

! Check for valid values

   if (nlayer_model < 1) then
      write(string1,*) 'obs_def_OMI_O3_nml:nlayer_model must be > 0, it is ',nlayer_model
      call error_handler(E_ERR,'initialize_module',string1,source)
   endif

   if (nlayer_omi_o3 < 1) then
      write(string1,*) 'obs_def_OMI_O3_nml:nlayer_omi_o3 must be > 0, it is ',nlayer_omi_o3
      call error_handler(E_ERR,'initialize_module',string1,source)
   endif

   allocate(    nlayer(max_omi_o3_obs))
   allocate(    kend(max_omi_o3_obs))
   allocate(  pressure(max_omi_o3_obs,nlayer_omi_o3+1))
   allocate(avg_kernel(max_omi_o3_obs,nlayer_omi_o3))
   allocate(     prior(max_omi_o3_obs,nlayer_omi_o3))

end subroutine initialize_module

!-------------------------------------------------------------------------------

subroutine read_omi_o3(key, ifile, fform)

integer,          intent(out)          :: key
integer,          intent(in)           :: ifile
character(len=*), intent(in), optional :: fform

! temporary arrays to hold buffer till we decide if we have enough room

integer               :: keyin
integer               :: nlayer_1
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
kend_1 = read_int_scalar( ifile, fileformat, 'kend_1')

allocate(  pressure_1(nlayer_1+1))
allocate(avg_kernel_1(nlayer_1))
allocate(     prior_1(nlayer_1))

call read_r8_array(ifile, nlayer_1+1, pressure_1,   fileformat, 'pressure_1')
call read_r8_array(ifile, nlayer_1,   avg_kernel_1, fileformat, 'avg_kernel_1')
call read_r8_array(ifile, nlayer_1,   prior_1,      fileformat, 'prior_1')
keyin = read_int_scalar(ifile, fileformat, 'keyin')

counts1 = counts1 + 1
key     = counts1

if(counts1 > max_omi_o3_obs) then
   write(string1, *) 'Not enough space for omi o3 obs.'
   write(string2, *) 'Can only have max_omi_o3_obs (currently ',max_omi_o3_obs,')'
   call error_handler(E_ERR,'read_omi_o3',string1,source,text2=string2)
endif

call set_obs_def_omi_o3(key, pressure_1, avg_kernel_1,prior_1, nlayer_1, kend_1)

deallocate(pressure_1, avg_kernel_1, prior_1)

end subroutine read_omi_o3

!-------------------------------------------------------------------------------

subroutine write_omi_o3(key, ifile, fform)

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
call write_int_scalar(ifile,                     kend(key), fileformat,'kend')
call write_r8_array(  ifile, nlayer(key)+1,  pressure(key,:), fileformat,'pressure')
call write_r8_array(  ifile, nlayer(key),  avg_kernel(key,:), fileformat,'avg_kernel')
call write_r8_array(  ifile, nlayer(key),       prior(key,:), fileformat,'prior')
call write_int_scalar(ifile,                             key, fileformat,'key')

end subroutine write_omi_o3

!-------------------------------------------------------------------------------

subroutine interactive_omi_o3(key)

integer, intent(out) :: key

if ( .not. module_initialized ) call initialize_module

! STOP because routine is not finished.
write(string1,*) 'interactive_omi_o3 not yet working.'
call error_handler(E_ERR, 'interactive_omi_o3', string1, source)

if(num_omi_o3_obs >= max_omi_o3_obs) then
   write(string1, *) 'Not enough space for an omi o3 obs.'
   write(string2, *) 'Can only have max_omi_o3_obs (currently ',max_omi_o3_obs,')'
   call error_handler(E_ERR, 'interactive_omi_o3', string1, &
              source, text2=string2)
endif

! Increment the index
num_omi_o3_obs = num_omi_o3_obs + 1
key            = num_omi_o3_obs

! Otherwise, prompt for input for the three required beasts

write(*, *) 'Creating an interactive_omi_o3 observation'
write(*, *) 'This featue is not setup '

end subroutine interactive_omi_o3

!-------------------------------------------------------------------------------

subroutine get_expected_omi_o3(state_handle, ens_size, location, key, obs_time, expct_val, istatus)

   type(ensemble_type), intent(in)  :: state_handle
   type(location_type), intent(in)  :: location
   integer,             intent(in)  :: ens_size
   integer,             intent(in)  :: key
   type(time_type),     intent(in)  :: obs_time
   integer,             intent(out) :: istatus(:)
   real(r8),            intent(out) :: expct_val(:)
   
   character(len=*), parameter :: routine = 'get_expected_omi_o3'
   type(location_type) :: loc2
   
   integer :: layer_omi,level_omi
   integer :: layer_mdl,level_mdl
   integer :: k,imem,kend_omi
   integer :: interp_new
   integer :: icnt,ncnt,kstart
   integer :: date_obs,datesec_obs
   integer, dimension(ens_size) :: zstatus
   
   real(r8) :: eps, AvogN, Rd, Ru, Cp, grav, msq2cmsq
   real(r8) :: missing,o3_min,tmp_max
   real(r8) :: level,del_prs
   real(r8) :: tmp_vir_k, tmp_vir_kp
   real(r8) :: mloc(3)
   real(r8) :: o3_val_conv
   real(r8) :: up_wt,dw_wt,tl_wt,lnpr_mid
   real(r8) :: lon_obs,lat_obs,pi,rad2deg
   
   real(r8), dimension(ens_size) :: o3_mdl_1, tmp_mdl_1, qmr_mdl_1, prs_mdl_1
   real(r8), dimension(ens_size) :: o3_mdl_n, tmp_mdl_n, qmr_mdl_n, prs_mdl_n
   real(r8), dimension(ens_size) :: prs_sfc
   
   real(r8), allocatable, dimension(:,:) :: o3_val, tmp_val, qmr_val
   real(r8), allocatable, dimension(:)   :: thick, prs_omi, prs_omi_mem
   real(r8), allocatable, dimension(:)   :: o3_prf_mdl,tmp_prf_mdl,qmr_prf_mdl
   real(r8), allocatable, dimension(:)   :: prs_omi_top
   logical  :: return_now,o3_return_now,tmp_return_now,qmr_return_now
   
   if ( .not. module_initialized ) call initialize_module
   
   eps      =  0.61_r8
   Rd       = 287.05_r8     ! J/kg
   Ru       = 8.316_r8      ! J/kg
   Cp       = 1006.0        ! J/kg/K
   grav     =   9.8_r8
   o3_min  = 1.e-6_r8
   msq2cmsq = 1.e4_r8
   AvogN    = 6.02214e23_r8
   missing  = -888888_r8
   tmp_max  = 600.
   del_prs  = 5000.
   pi=4.*atan(1.)
   rad2deg=360./(2.*pi)
   date_obs=0
   datesec_obs=0
   
   if(use_log_o3) then
      o3_min = log(o3_min)
   endif
   
! Assign vertical grid information

   layer_omi = nlayer(key)
   level_omi = nlayer(key)+1
   kend_omi  = kend(key)
   layer_mdl = nlayer_model
   level_mdl = nlayer_model+1
   
   allocate(prs_omi(level_omi))
   allocate(prs_omi_mem(level_omi))
   prs_omi(1:level_omi)=pressure(key,1:level_omi)*100.

! Get location infomation

   mloc = get_location(location)

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
      
   !write(string1, *) 'APM: o3 lower bound ',o3_mdl_1
   !call error_handler(E_MSG, routine, string1, source)
   !write(string1, *) 'APM: tmp lower bound ',tmp_mdl_1
   !call error_handler(E_MSG, routine, string1, source)
   !write(string1, *) 'APM: qmr lower bound ',qmr_mdl_1
   !call error_handler(E_MSG, routine, string1, source)
   !write(string1, *) 'APM: prs lower bound ',prs_mdl_1
   !call error_handler(E_MSG, routine, string1, source)

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

   !write(string1, *) 'APM: o3 upper bound ',o3_mdl_n
   !call error_handler(E_MSG, routine, string1, source)
   !write(string1, *) 'APM: tmp upper bound ',tmp_mdl_n
   !call error_handler(E_MSG, routine, string1, source)
   !write(string1, *) 'APM: qmr upper bound ',qmr_mdl_n
   !call error_handler(E_MSG, routine, string1, source)
   !write(string1, *) 'APM: prs upper bound ',prs_mdl_n
   !call error_handler(E_MSG, routine, string1, source)

! Get profiles at OMI pressure levels

   allocate(o3_val(ens_size,level_omi))
   allocate(tmp_val(ens_size,level_omi))
   allocate(qmr_val(ens_size,level_omi))

   do k=1,level_omi
      zstatus=0
      loc2 = set_location(mloc(1), mloc(2), prs_omi(k), VERTISPRESSURE)
      call interpolate(state_handle, ens_size, loc2, QTY_O3, o3_val(:,k), zstatus)  
      zstatus=0
      call interpolate(state_handle, ens_size, loc2, QTY_TEMPERATURE, tmp_val(:,k), zstatus)  
      zstatus=0
      call interpolate(state_handle, ens_size, loc2, QTY_VAPOR_MIXING_RATIO, qmr_val(:,k), zstatus)  
!
! Correcting for expected failures near the surface
      do imem=1,ens_size
         if (prs_omi(k).ge.prs_mdl_1(imem)) then
            o3_val(imem,k) = o3_mdl_1(imem)
            tmp_val(imem,k) = tmp_mdl_1(imem)
            qmr_val(imem,k) = qmr_mdl_1(imem)
            cycle
         endif
!
! Correcting for expected failures near the top
         if (prs_omi(k).le.prs_mdl_n(imem)) then
            o3_val(imem,k) = o3_mdl_n(imem)
            tmp_val(imem,k) = tmp_mdl_n(imem)
            qmr_val(imem,k) = qmr_mdl_n(imem)
            cycle
         endif
      enddo
!
!      write(string1, *)'APM: o3 ',k,o3_val(1,k)
!      call error_handler(E_MSG, routine, string1, source)
!      write(string1, *)'APM: tmp ',k,tmp_val(1,k)
!      call error_handler(E_MSG, routine, string1, source)
!      write(string1, *)'APM: qmr ',k,qmr_val(1,k)
!      call error_handler(E_MSG, routine, string1, source)
!
! Check data for missing values      
      do imem=1,ens_size
         if(o3_val(imem,k).eq.missing_r8 .or. tmp_val(imem,k).eq.missing_r8 .or. &
         qmr_val(imem,k).eq.missing_r8) then
            zstatus(:)=20
            expct_val(:)=missing_r8
            write(string1, *) &
            'APM: Input data has missing values '
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
   do imem=1,ens_size
      do k=1,level_omi
         if (prs_omi(k).le.prs_mdl_n(imem)) then
            kstart=k
            exit
         endif
      enddo
      ncnt=level_omi-kstart+1
      allocate(prs_omi_top(ncnt))
      allocate(o3_prf_mdl(ncnt),tmp_prf_mdl(ncnt),qmr_prf_mdl(ncnt))
      do k=kstart,level_omi
         prs_omi_top(k-kstart+1)=prs_omi(k)
      enddo
      prs_omi_top(:)=prs_omi_top(:)/100.
!
      lon_obs=mloc(1)/rad2deg
      lat_obs=mloc(2)/rad2deg
      call get_time(obs_time,datesec_obs,date_obs)
!
      call get_upper_bdy_o3(lon_obs,lat_obs,prs_omi_top,ncnt, &
      o3_prf_mdl,tmp_prf_mdl,qmr_prf_mdl,date_obs,datesec_obs)
!
!      do k=kstart,level_omi 
!         o3_val(imem,k)=o3_prf_mdl(k-kstart+1)
!         tmp_val(imem,k)=tmp_prf_mdl(k-kstart+1)
!         qmr_val(imem,k)=qmr_prf_mdl(k-kstart+1)
!      enddo
      deallocate(prs_omi_top)
      deallocate(o3_prf_mdl,tmp_prf_mdl,qmr_prf_mdl)
   enddo
!
   istatus(:)=0
   zstatus(:)=0.
   expct_val(:)=0.0
   allocate(thick(layer_omi))

   do imem=1,ens_size
! Adjust the OMI pressure for WRF-Chem lower/upper boudary pressure
! (OMI O3 vertical grid is bottom to top)
      prs_omi_mem(:)=prs_omi(:)
      if (prs_sfc(imem).gt.prs_omi_mem(1)) then
         prs_omi_mem(1)=prs_sfc(imem)
      endif   

! Calculate the thicknesses

      do k=1,layer_omi
         lnpr_mid=(log(prs_omi_mem(k+1))+log(prs_omi_mem(k)))/2.
         up_wt=log(prs_omi_mem(k))-lnpr_mid
         dw_wt=lnpr_mid-log(prs_omi_mem(k+1))
         tl_wt=up_wt+dw_wt 
         tmp_vir_k  = (1.0_r8 + eps*qmr_val(imem,k))*tmp_val(imem,k)
         tmp_vir_kp = (1.0_r8 + eps*qmr_val(imem,k+1))*tmp_val(imem,k+1)
         thick(k)   = Rd*(dw_wt*tmp_vir_k + up_wt*tmp_vir_kp)/tl_wt/grav* &
         log(prs_omi_mem(k)/prs_omi_mem(k+1))
      enddo
      
! Process the vertical summation

      do k=1,layer_omi
         lnpr_mid=(log(prs_omi_mem(k+1))+log(prs_omi_mem(k)))/2.
         up_wt=log(prs_omi_mem(k))-lnpr_mid
         dw_wt=lnpr_mid-log(prs_omi_mem(k+1))
         tl_wt=up_wt+dw_wt

! Convert from VMR to molar density (mol/m^3)
         if(use_log_o3) then
            o3_val_conv = (dw_wt*exp(o3_val(imem,k))+up_wt*exp(o3_val(imem,k+1)))/tl_wt * &
            (dw_wt*prs_omi_mem(k)+up_wt*prs_omi_mem(k+1)) / &
            (Ru*(dw_wt*tmp_val(imem,k)+up_wt*tmp_val(imem,k+1)))
         else
            o3_val_conv = (dw_wt*o3_val(imem,k)+up_wt*o3_val(imem,k+1))/tl_wt * &
            (dw_wt*prs_omi_mem(k)+up_wt*prs_omi_mem(k+1)) / &
            (Ru*(dw_wt*tmp_val(imem,k)+up_wt*tmp_val(imem,k+1)))
         endif
 
! Get expected observation

         expct_val(imem) = expct_val(imem) + thick(k) * o3_val_conv * &
         avg_kernel(key,k) + (1.0_r8 - avg_kernel(key,k)) * prior(key,k)
      enddo
      
      if(expct_val(imem).lt. 0) then
         zstatus(imem)=20
         expct_val(:)=missing_r8
         write(string1, *) &
         'APM NOTICE: OMI O3 expected value is negative '
         call error_handler(E_MSG, routine, string1, source)
         call track_status(ens_size, zstatus, expct_val, istatus, return_now)
         return
      endif
   enddo

! Clean up and return
   deallocate(o3_val, tmp_val, qmr_val)
   deallocate(thick)
   deallocate(prs_omi, prs_omi_mem)

end subroutine get_expected_omi_o3

!-------------------------------------------------------------------------------

subroutine get_upper_bdy_o3(lon_obs,lat_obs,prs_obs,nprs_obs, &
o3_prf_mdl,tmp_prf_mdl,qmr_prf_mdl,date_obs,datesec_obs)
  
implicit none

integer,parameter                                :: nx=17
integer,parameter                                :: ny=13
integer,parameter                                :: nz=56
integer,parameter                                :: ntim=368

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
   o3_prf_mdl(:)=0.
   tmp_prf_mdl(:)=0.
   qmr_prf_mdl(:)=0.
!
   call get_MOZART_INT_DATA(data_file,'date',ntim,1,1,1,date)
   call get_MOZART_INT_DATA(data_file,'datesec',ntim,1,1,1,datesec)
   call get_MOZART_REAL_DATA(data_file,'lev',nz,1,1,1,prs_glb)
   call get_MOZART_REAL_DATA(data_file,'lat',ny,1,1,1,lat_glb)
   call get_MOZART_REAL_DATA(data_file,'lon',nx,1,1,1,lon_glb)
   call get_MOZART_REAL_DATA(data_file,'O3_VMR_inst',nx,ny,nz,ntim,o3_glb)
   call get_MOZART_REAL_DATA(data_file,'T',nx,ny,nz,ntim,tmp_glb)
   call get_MOZART_REAL_DATA(data_file,'Q',nx,ny,nz,ntim,qmr_glb)
   lon_glb(:)=lon_glb(:)/rad2deg
   lat_glb(:)=lat_glb(:)/rad2deg

!   write(string1, *) 'APM: Completed read of MOZART data '
!   call error_handler(E_MSG, routine, string1, source)
!   write(string1, *) 'APM: lon_obs, lon_glb(1) ',lon_obs,lon_glb(1)
!   call error_handler(E_MSG, routine, string1, source)
!   write(string1, *) 'APM: lat_obs, lat_glb(1) ',lat_obs,lat_glb(1)
!   call error_handler(E_MSG, routine, string1, source)
!   write(string1, *) 'APM: datesec_obs, date_obs ',datesec_obs,date_obs
!   call error_handler(E_MSG, routine, string1, source)
!   write(string1, *) 'APM: prs_glb(1), prs_glb(nz) ',prs_glb(1),prs_glb(nz)
!   call error_handler(E_MSG, routine, string1, source)
!   write(string1, *) 'APM: prs_obs(1), prs_obs(nprs_obs) ',prs_obs(1),prs_obs(nprs_obs)
!   call error_handler(E_MSG, routine, string1, source)
!
!______________________________________________________________________________________________   
!
! Find large scale data correspondeing to the observation time
!______________________________________________________________________________________________   
!
!   write(string1, *) 'APM: date(1), datesec(1) ',date(1),datesec(1)
!   call error_handler(E_MSG, routine, string1, source)
!   write(string1, *) 'APM: date(2), datesec(2) ',date(2),datesec(2)
!   call error_handler(E_MSG, routine, string1, source)
!
   jdate_obs=date_obs*24*60*60+datesec_obs   
   year=date(1)/10000
   yrleft=mod(date(1),10000)
   month=yrleft/100
   day=mod(yrleft,100)
   time_var=set_date(year,month,day,0,0,0)
   call get_time(time_var,second,jday)
   jdate_bck=jday*24*60*60+datesec(1)
!   write(string1, *) 'APM: yrleft,year,month,day ',yrleft,year,month,day
!   call error_handler(E_MSG, routine, string1, source)
!   write(string1, *) 'APM: jday,second ',jday,second
!   call error_handler(E_MSG, routine, string1, source)
!
   year=date(2)/10000
   yrleft=mod(date(2),10000)
   month=yrleft/100
   day=mod(yrleft,100)
   time_var=set_date(year,month,day,0,0,0)
   call get_time(time_var,second,jday)
   jdate_fwd=jday*24*60*60+datesec(2)
!   
!   write(string1, *) 'APM: jdate_bck ',jdate_bck
!   call error_handler(E_MSG, routine, string1, source)
!   write(string1, *) 'APM: jdate_obs ',jdate_obs
!   call error_handler(E_MSG, routine, string1, source)
!   write(string1, *) 'APM: jdate_fwd ',jdate_fwd
!   call error_handler(E_MSG, routine, string1, source)
!   write(string1, *) 'APM: jday,second ',jday,second
!   call error_handler(E_MSG, routine, string1, source)

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
         indx=nx
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
         jndx=ny
         bck_ywt=0.
         fwd_ywt=1.
         twty=bck_ywt+fwd_ywt
         exit
      elseif(lat_obs.gt.lat_glb(J) .and. &
         lat_obs.le.lat_glb(j+1)) then
         jndx=j
         bck_ywt=lat_glb(i+1)-lat_obs
         fwd_ywt=lat_obs-lat_glb(i)
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
! Temporal
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
!print *, v_id
if(rc.ne.0) then
   print *, 'nf_inq_varid error ', v_id
   stop
endif
!
! get dimension identifiers
v_dimid=0
rc = nf_inq_var(f_id,v_id,v_nam,typ,v_ndim,v_dimid,natts)
!print *, v_dimid
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
!print *, v_dim
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
!print *, 'f_id ',f_id
!
if(rc.ne.0) then
   print *, 'nf_open error ',trim(file)
   stop
endif
!
! get variables identifiers
rc = nf_inq_varid(f_id,trim(name),v_id)
!print *, 'v_id ',v_id
!
if(rc.ne.0) then
   print *, 'nf_inq_varid error ', v_id
   stop
endif
!
! get dimension identifiers
v_dimid=0
rc = nf_inq_var(f_id,v_id,v_nam,typ,v_ndim,v_dimid,natts)
!print *, 'v_dimid ',v_dimid
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
!print *, 'v_dim ',v_dim
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
!print *, 'fld ', fld(1,1,1,1),fld(nx/2,ny/2,nz/2,ntim/2),fld(nx,ny,nz,ntim)
!
if(rc.ne.0) then
   print *, 'nf_get_vara_real ', fld(1,1,1,1)
   stop
endif
rc = nf_close(f_id)
return
  
end subroutine get_MOZART_REAL_DATA

!-------------------------------------------------------------------------------

subroutine set_obs_def_omi_o3(key, o3_pressure, o3_avg_kernel, o3_prior, o3_nlayer, o3_kend)

integer,                           intent(in)   :: key, o3_nlayer, o3_kend
real(r8), dimension(o3_nlayer+1),  intent(in)   :: o3_pressure
real(r8), dimension(o3_nlayer),    intent(in)   :: o3_avg_kernel
real(r8), dimension(o3_nlayer),    intent(in)   :: o3_prior

if ( .not. module_initialized ) call initialize_module

if(num_omi_o3_obs >= max_omi_o3_obs) then
   write(string1, *) 'Not enough space for omi o3 obs.'
   write(string2, *) 'Can only have max_omi_o3_obs (currently ',max_omi_o3_obs,')'
   call error_handler(E_ERR,'set_obs_def_omi_o3',string1,source,revision, &
   revdate,text2=string2)
endif

nlayer(key) = o3_nlayer
kend(key) = o3_kend
pressure(key,1:o3_nlayer+1) = o3_pressure(1:o3_nlayer+1)
avg_kernel(key,1:o3_nlayer) = o3_avg_kernel(1:o3_nlayer)
prior(key,1:o3_nlayer) = o3_prior(1:o3_nlayer)

end subroutine set_obs_def_omi_o3

!-------------------------------------------------------------------------------

function read_int_scalar(ifile, fform, context)

integer                      :: read_int_scalar
integer,          intent(in) :: ifile
character(len=*), intent(in) :: fform
character(len=*), intent(in) :: context

integer :: io

if (ascii_file_format(fform)) then
   read(ifile, *, iostat = io) read_int_scalar
else
   read(ifile, iostat = io) read_int_scalar
endif
if ( io /= 0 ) then
   call error_handler(E_ERR,'read_int_scalar', context, source)
endif

end function read_int_scalar

!-------------------------------------------------------------------------------

subroutine write_int_scalar(ifile, my_scalar, fform, context)

integer,          intent(in) :: ifile
integer,          intent(in) :: my_scalar
character(len=*), intent(in) :: fform
character(len=*), intent(in) :: context

integer :: io

if (ascii_file_format(fform)) then
   write(ifile, *, iostat=io) my_scalar
else
   write(ifile, iostat=io) my_scalar
endif
if ( io /= 0 ) then
   call error_handler(E_ERR, 'write_int_scalar', context, source)
endif

end subroutine write_int_scalar

!-------------------------------------------------------------------------------

subroutine read_r8_array(ifile, num_items, r8_array, fform, context)

integer,          intent(in)  :: ifile, num_items
real(r8),         intent(out) :: r8_array(:)
character(len=*), intent(in)  :: fform
character(len=*), intent(in)  :: context

integer :: io

if (ascii_file_format(fform)) then
   read(ifile, *, iostat = io) r8_array(1:num_items)
else
   read(ifile, iostat = io) r8_array(1:num_items)
endif
if ( io /= 0 ) then
   call error_handler(E_ERR, 'read_r8_array', context, source)
endif

end subroutine read_r8_array

!-------------------------------------------------------------------------------

subroutine write_r8_array(ifile, num_items, array, fform, context)

integer,          intent(in) :: ifile, num_items
real(r8),         intent(in) :: array(:)
character(len=*), intent(in) :: fform
character(len=*), intent(in) :: context

integer :: io

if (ascii_file_format(fform)) then
   write(ifile, *, iostat = io) array(1:num_items)
else
   write(ifile, iostat = io) array(1:num_items)
endif
if ( io /= 0 ) then
   call error_handler(E_ERR, 'write_r8_array', context, source)
endif

end subroutine write_r8_array

!-------------------------------------------------------------------------------




end module obs_def_omi_o3_mod

! END DART PREPROCESS MODULE CODE
