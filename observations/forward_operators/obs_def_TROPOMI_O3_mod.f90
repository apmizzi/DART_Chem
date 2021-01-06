  `! Copyright 2019 University Corporation for Atmospheric Research and 
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
! TROPOMI_O3_COLUMN, QTY_O3
! END DART PREPROCESS KIND LIST
!
! BEGIN DART PREPROCESS USE OF SPECIAL OBS_DEF MODULE
!   use obs_def_tropomi_o3_mod, only : get_expected_tropomi_o3, &
!                                  read_tropomi_o3, &
!                                  write_tropomi_o3, &
!                                  interactive_tropomi_o3
! END DART PREPROCESS USE OF SPECIAL OBS_DEF MODULE
!
! BEGIN DART PREPROCESS GET_EXPECTED_OBS_FROM_DEF
!      case(TROPOMI_O3_COLUMN)                                                           
!         call get_expected_tropomi_o3(state_handle, ens_size, location, obs_def%key, expected_obs, istatus)  
! END DART PREPROCESS GET_EXPECTED_OBS_FROM_DEF
!
! BEGIN DART PREPROCESS READ_OBS_DEF
!      case(TROPOMI_O3_COLUMN)
!         call read_tropomi_o3(obs_def%key, ifile, fileformat)
! END DART PREPROCESS READ_OBS_DEF
!
! BEGIN DART PREPROCESS WRITE_OBS_DEF
!      case(TROPOMI_O3_COLUMN)
!         call write_tropomi_o3(obs_def%key, ifile, fileformat)
! END DART PREPROCESS WRITE_OBS_DEF
!
! BEGIN DART PREPROCESS INTERACTIVE_OBS_DEF
!      case(TROPOMI_O3_COLUMN)
!         call interactive_tropomi_o3(obs_def%key)
! END DART PREPROCESS INTERACTIVE_OBS_DEF
!
! BEGIN DART PREPROCESS MODULE CODE

module obs_def_tropomi_o3_mod

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

implicit none
private

public :: write_tropomi_o3, &
          read_tropomi_o3, &
          interactive_tropomi_o3, &
          get_expected_tropomi_o3, &
          set_obs_def_tropomi_o3

! Storage for the special information required for observations of this type
integer, parameter    :: max_tropomi_o3_obs = 10000000
integer               :: num_tropomi_o3_obs = 0
integer,  allocatable :: nlayer(:)
real(r8), allocatable :: pressure(:,:)
real(r8), allocatable :: avg_kernel(:,:)
real(r8), allocatable :: prior(:,:)

! version controlled file description for error handling, do not edit
character(len=*), parameter :: source   = 'obs_def_tropomi_o3_mod.f90'
character(len=*), parameter :: revision = ''
character(len=*), parameter :: revdate  = ''

character(len=512) :: string1, string2

logical, save :: module_initialized = .false.

! Namelist with default values
logical :: use_log_o3   = .false.
integer :: nlayer_model = -9999
integer :: nlayer_tropomi_o3 = -9999

namelist /obs_def_TROPOMI_O3_nml/ use_log_o3, nlayer_model, nlayer_tropomi_o3

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

! Check for valid values

if (nlayer_model < 1) then
   write(string1,*)'obs_def_TROPOMI_O3_nml:nlayer_model must be > 0, it is ',nlayer_model
   call error_handler(E_ERR,'initialize_module',string1,source)
endif

if (nlayer_tropomi_o3 < 1) then
   write(string1,*)'obs_def_TROPOMI_O3_nml:nlayer_tropomi_o3 must be > 0, it is ',nlayer_tropomi_o3
   call error_handler(E_ERR,'initialize_module',string1,source)
endif

allocate(    nlayer(max_tropomi_o3_obs))
allocate(  pressure(max_tropomi_o3_obs,nlayer_tropomi_o3+1))
allocate(avg_kernel(max_tropomi_o3_obs,nlayer_tropomi_o3))
allocate(     prior(max_tropomi_o3_obs,nlayer_tropomi_o3))

end subroutine initialize_module

!-------------------------------------------------------------------------------

subroutine read_tropomi_o3(key, ifile, fform)

integer,          intent(out)          :: key
integer,          intent(in)           :: ifile
character(len=*), intent(in), optional :: fform

! temporary arrays to hold buffer till we decide if we have enough room

integer               :: keyin
integer               :: nlayer_1
real(r8), allocatable ::   pressure_1(:)
real(r8), allocatable :: avg_kernel_1(:)
real(r8), allocatable ::      prior_1(:)
character(len=32)     :: fileformat

integer, SAVE :: counts1 = 0

if ( .not. module_initialized ) call initialize_module

fileformat = "ascii" 
if(present(fform)) fileformat = adjustl(fform)

! Need to know how many layers for this one
nlayer_1 = read_int_scalar( ifile, fileformat, 'nlayer_1')

allocate(  pressure_1(nlayer_1+1))
allocate(avg_kernel_1(nlayer_1))
allocate(     prior_1(nlayer_1))

call read_r8_array(ifile, nlayer_1+1, pressure_1,   fileformat, 'pressure_1')
call read_r8_array(ifile, nlayer_1,   avg_kernel_1, fileformat, 'avg_kernel_1')
call read_r8_array(ifile, nlayer_1,   prior_1,      fileformat, 'prior_1')
keyin = read_int_scalar(ifile, fileformat, 'nlayer_1')

counts1 = counts1 + 1
key     = counts1

if(counts1 > max_tropomi_o3_obs) then
   write(string1, *)'Not enough space for tropomi o3 obs.'
   write(string2, *)'Can only have max_tropomi_o3_obs (currently ',max_tropomi_o3_obs,')'
   call error_handler(E_ERR,'read_tropomi_o3',string1,source,text2=string2)
endif

call set_obs_def_tropomi_o3(key, pressure_1, avg_kernel_1,prior_1, nlayer_1)

deallocate(pressure_1, avg_kernel_1, prior_1)

end subroutine read_tropomi_o3

!-------------------------------------------------------------------------------

subroutine write_tropomi_o3(key, ifile, fform)

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
call write_r8_array(  ifile, nlayer(key)+1,  pressure(key,:), fileformat,'pressure')
call write_r8_array(  ifile, nlayer(key),  avg_kernel(key,:), fileformat,'avg_kernel')
call write_r8_array(  ifile, nlayer(key),       prior(key,:), fileformat,'prior')
call write_int_scalar(ifile,                             key, fileformat,'key')

end subroutine write_tropomi_o3

!-------------------------------------------------------------------------------

subroutine interactive_tropomi_o3(key)

integer, intent(out) :: key

if ( .not. module_initialized ) call initialize_module

! STOP because routine is not finished.
write(string1,*)'interactive_tropomi_o3 not yet working.'
call error_handler(E_ERR, 'interactive_tropomi_o3', string1, source)

if(num_tropomi_o3_obs >= max_tropomi_o3_obs) then
   write(string1, *)'Not enough space for an tropomi o3 obs.'
   write(string2, *)'Can only have max_tropomi_o3_obs (currently ',max_tropomi_o3_obs,')'
   call error_handler(E_ERR, 'interactive_tropomi_o3', string1, &
              source, text2=string2)
endif

! Increment the index
num_tropomi_o3_obs = num_tropomi_o3_obs + 1
key            = num_tropomi_o3_obs

! Otherwise, prompt for input for the three required beasts

write(*, *) 'Creating an interactive_tropomi_o3 observation'
write(*, *) 'This featue is not setup '

end subroutine interactive_tropomi_o3

!-------------------------------------------------------------------------------

subroutine get_expected_tropomi_o3(state_handle, ens_size, location, key, expct_val, istatus)

type(ensemble_type), intent(in)  :: state_handle
type(location_type), intent(in)  :: location
integer,             intent(in)  :: ens_size
integer,             intent(in)  :: key
integer,             intent(out) :: istatus(:)
real(r8),            intent(out) :: expct_val(:)

character(len=*), parameter :: routine = 'get_expected_tropomi_o3'
type(location_type) :: loc2

integer :: layer_tropomi,level_tropomi
integer :: layer_mdl,level_mdl
integer :: k,imem
integer :: o3_istatus(ens_size)
integer, dimension(ens_size) :: tmp_istatus, qmr_istatus, prs_istatus

real(r8) :: eps, AvogN, Rd, Ru, grav, msq2cmsq
real(r8) :: o3_min
real(r8) :: level
real(r8) :: tmp_vir_k, tmp_vir_kp
real(r8) :: mloc(3)
real(r8) :: o3_val_conv
real(r8) :: up_wt,dw_wt,tl_wt,lnpr_mid
real(r8), dimension(ens_size) :: o3_mdl_1, tmp_mdl_1, qmr_mdl_1, prs_mdl_1
real(r8), dimension(ens_size) :: o3_mdl_n, tmp_mdl_n, qmr_mdl_n, prs_mdl_n
real(r8), dimension(ens_size) :: o3_temp, tmp_temp, qmr_temp, prs_sfc

real(r8), allocatable, dimension(:)   :: thick, prs_tropomi, prs_tropomi_mem
real(r8), allocatable, dimension(:,:) :: o3_val, tmp_val, qmr_val
logical  :: return_now,o3_return_now,tmp_return_now,qmr_return_now

if ( .not. module_initialized ) call initialize_module

eps    =  0.61_r8
Rd     = 286.9_r8
Ru     = 8.316_r8
grav   =   9.8_r8
o3_min = 1.e-6_r8
msq2cmsq = 1.e4_r8
AvogN = 6.02214e23_r8

if(use_log_o3) then
   o3_min = log(o3_min)
endif

! Assign vertical grid information

layer_tropomi = nlayer(key)
level_tropomi = nlayer(key)+1
layer_mdl=nlayer_model
level_mdl=nlayer_model+1
!write(string1, *) 'APM: layer_omi ',key,layer_omi
!call error_handler(E_MSG, routine, string1, source)
!write(string1, *) 'APM: layer_mdl ',key,layer_mdl
!call error_handler(E_MSG, routine, string1, source)

allocate(prs_tropomi(level_tropomi))
allocate(prs_tropomi_mem(level_tropomi))
prs_tropomi(1:level_tropomi)=pressure(key,1:level_tropomi)*100.

! Get location infomation

mloc = get_location(location)

if (    mloc(2) >  90.0_r8) then
        mloc(2) =  90.0_r8
elseif (mloc(2) < -90.0_r8) then
        mloc(2) = -90.0_r8
endif

! You could set a unique error code for each condition and then just return
! without having to issue a warning message. The error codes would then
! show up in the report from 'output_forward_op_errors'

istatus(:) = 0  ! set this once at the beginning

! pressure at model surface (Pa)

level=0.0_r8
loc2 = set_location(mloc(1), mloc(2), level, VERTISSURFACE)
istatus(:) = 0
prs_istatus(:) = 0
return_now=.false.
call interpolate(state_handle, ens_size, loc2, QTY_SURFACE_PRESSURE, prs_sfc, prs_istatus) 
if(any(prs_istatus /= 0)) then
   write(string1, *)'APM NOTICE: MDL prs_sfc is bad '
   call error_handler(E_MSG, routine, string1, source)
endif
call track_status(ens_size, prs_istatus, prs_sfc, istatus, return_now)
if(return_now) return
!write(string1, *) 'APM: prs_sfc ',key,prs_sfc(1)
!call error_handler(E_MSG, routine, string1, source)

! ozone at first model layer (ppmv)

level = 1.0_r8
loc2 = set_location(mloc(1), mloc(2), level, VERTISLEVEL)
istatus(:) = 0
o3_istatus(:) = 0
return_now=.false.
call interpolate(state_handle, ens_size, loc2, QTY_O3, o3_mdl_1, o3_istatus) 
if(any(o3_istatus /= 0)) then
   write(string1, *)'APM NOTICE: MDL o3_mdl_1 is bad '
   call error_handler(E_MSG, routine, string1, source)
endif
call track_status(ens_size, o3_istatus, o3_mdl_1, istatus, return_now)
if(return_now) return
!write(string1, *) 'APM: o3_mdl_1 ',key,o3_mdl_1(1)
!call error_handler(E_MSG, routine, string1, source)

! temperature at first model layer (K)

level=1.0_r8
loc2 = set_location(mloc(1), mloc(2), level, VERTISLEVEL)
istatus(:) = 0
tmp_istatus(:) = 0
return_now=.false.
call interpolate(state_handle, ens_size, loc2, QTY_TEMPERATURE, tmp_mdl_1, tmp_istatus) 
if(any(tmp_istatus /= 0)) then
   write(string1, *)'APM NOTICE: MDL tmp_mdl_1 is bad '
   call error_handler(E_MSG, routine, string1, source)
endif
call track_status(ens_size, tmp_istatus, tmp_mdl_1, istatus, return_now)
if(return_now) return
!write(string1, *) 'APM: tmp_mdl_1 ',key,tmp_mdl_1(1)
!call error_handler(E_MSG, routine, string1, source)

! vapor mixing ratio at first model layer (Kg/Kg)

level=1.0_r8
loc2 = set_location(mloc(1), mloc(2), level, VERTISLEVEL)
istatus(:) = 0
qmr_istatus(:) = 0
return_now=.false.
call interpolate(state_handle, ens_size, loc2, QTY_VAPOR_MIXING_RATIO, qmr_mdl_1, qmr_istatus) 
if(any(qmr_istatus /= 0)) then
   write(string1, *)'APM NOTICE: MDL qmr_mdl_1 is bad '
   call error_handler(E_MSG, routine, string1, source)
endif
call track_status(ens_size, qmr_istatus, qmr_mdl_1, istatus, return_now)
if(return_now) return
!write(string1, *) 'APM: qmr_mdl_1 ',key,qmr_mdl_1(1)
!call error_handler(E_MSG, routine, string1, source)

! pressure at first model layer (Pa)

level=1.0_r8
loc2 = set_location(mloc(1), mloc(2), level, VERTISLEVEL)
istatus(:) = 0
prs_istatus(:) = 0
return_now=.false.
call interpolate(state_handle, ens_size, loc2, QTY_PRESSURE, prs_mdl_1, prs_istatus) 
if(any(prs_istatus /= 0)) then
   write(string1, *)'APM NOTICE: MDL prs_mdl_1 is bad '
   call error_handler(E_MSG, routine, string1, source)
endif
call track_status(ens_size, prs_istatus, prs_mdl_1, istatus, return_now)
if(return_now) return
!write(string1, *) 'APM: prs_mdl_1 ',key,prs_mdl_1(1)
!call error_handler(E_MSG, routine, string1, source)

! ozone at last model layer (ppmv)

level=real(layer_mdl-1)
loc2 = set_location(mloc(1), mloc(2), level, VERTISLEVEL)
istatus(:) = 0
o3_istatus(:) = 0
return_now=.false.
call interpolate(state_handle, ens_size, loc2, QTY_O3, o3_mdl_n, o3_istatus) 
if(any(o3_istatus /= 0)) then
   write(string1, *)'APM NOTICE: MDL o3_mdl_n is bad '
   call error_handler(E_MSG, routine, string1, source)
endif
call track_status(ens_size, o3_istatus, o3_mdl_n, istatus, return_now)
if(return_now) return
!write(string1, *) 'APM: o3_mdl_n ',key,o3_mdl_n(1)
!call error_handler(E_MSG, routine, string1, source)

! temperature at last layer (K)

level=real(layer_mdl-1)
loc2 = set_location(mloc(1), mloc(2), level, VERTISLEVEL)
istatus(:) = 0
tmp_istatus(:) = 0
return_now=.false.
call interpolate(state_handle, ens_size, loc2, QTY_TEMPERATURE, tmp_mdl_n, tmp_istatus) 
if(any(tmp_istatus /= 0)) then
   write(string1, *)'APM NOTICE: MDL tmp_mdl_n is bad '
   call error_handler(E_MSG, routine, string1, source)
endif
call track_status(ens_size, tmp_istatus, tmp_mdl_n, istatus, return_now)
if(return_now) return
!write(string1, *) 'APM: tmp_mdl_n ',key,tmp_mdl_n(1)
!call error_handler(E_MSG, routine, string1, source)

! vapor mixing ratio at last model layer (Kg/Kg)

level=real(layer_mdl-1)
loc2 = set_location(mloc(1), mloc(2), level, VERTISLEVEL)
istatus(:) = 0
qmr_istatus(:) = 0
return_now=.false.
call interpolate(state_handle, ens_size, loc2, QTY_VAPOR_MIXING_RATIO, qmr_mdl_n, qmr_istatus) 
if(any(qmr_istatus /= 0)) then
   write(string1, *)'APM NOTICE: MDL qmr_mdl_n is bad '
   call error_handler(E_MSG, routine, string1, source)
endif
call track_status(ens_size, qmr_istatus, qmr_mdl_n, istatus, return_now)
if(return_now) return
!write(string1, *) 'APM: qmr_mdl_n ',key,qmr_mdl_n(1)
!call error_handler(E_MSG, routine, string1, source)

! pressure at last model layer (Pa)

level=real(layer_mdl-1)
loc2 = set_location(mloc(1), mloc(2), level, VERTISLEVEL)
istatus(:) = 0
prs_istatus(:) = 0
return_now=.false.
call interpolate(state_handle, ens_size, loc2, QTY_PRESSURE, &
prs_mdl_n, prs_istatus) 
if(any(prs_istatus /= 0)) then
   write(string1, *)'APM NOTICE: MDL prs_mdl_n is bad '
   call error_handler(E_MSG, routine, string1, source)
endif
call track_status(ens_size, prs_istatus, prs_mdl_n, istatus, return_now)
if(return_now) return
!write(string1, *) 'APM: prs_mdl_n ',key,prs_mdl_n(1)
!call error_handler(E_MSG, routine, string1, source)

! Get profiles at TROPOMI levels

allocate( o3_val(ens_size,level_tropomi))
allocate(tmp_val(ens_size,level_tropomi))
allocate(qmr_val(ens_size,level_tropomi))

do k=1,level_tropomi
   o3_istatus(:) = 0
   tmp_istatus(:) = 0
   qmr_istatus(:) = 0

   loc2 = set_location(mloc(1), mloc(2), prs_tropomi(k), VERTISPRESSURE)

   ! taking a different approach here ... interpolate all the required pieces
   ! for this level and then account for known special cases before determining
   ! if there is an error or not
   call interpolate(state_handle, ens_size, loc2, QTY_O3, o3_temp, o3_istatus)  
   call interpolate(state_handle, ens_size, loc2, QTY_TEMPERATURE, tmp_temp, tmp_istatus)  
   call interpolate(state_handle, ens_size, loc2, QTY_VAPOR_MIXING_RATIO, qmr_temp, qmr_istatus)  

   ! Correcting for expected failures near the surface
   where(prs_tropomi(k).ge.prs_mdl_1)
      o3_istatus  = 0
      tmp_istatus = 0
      qmr_istatus = 0
      o3_temp     = o3_mdl_1
      tmp_temp    = tmp_mdl_1
      qmr_temp    = qmr_mdl_1
   endwhere

   ! Correcting for expected failures near the top
   where(prs_tropomi(k).le.prs_mdl_n) 
      o3_istatus  = 0
      tmp_istatus = 0
      qmr_istatus = 0
      o3_temp     = o3_mdl_n
      tmp_temp    = tmp_mdl_n
      qmr_temp    = qmr_mdl_n
   endwhere

   ! Report all issue before returning (when E_MSG is being used)
   o3_return_now=.false.
   if(any(o3_istatus /= 0)) then
      write(string1,*) &
      'APM NOTICE: model O3 obs value on TROPOMI grid has a bad value '
      call error_handler(E_MSG, routine, string1, source)
      call track_status(ens_size, o3_istatus, o3_temp, istatus, return_now)
   endif
   
   tmp_return_now=.false.
   if(any(tmp_istatus/=0)) then
      write(string1, *) &
      'APM NOTICE: model TMP obs value on TROPOMI grid has a bad value'
      call error_handler(E_MSG, routine, string1, source)
      call track_status(ens_size, tmp_istatus, tmp_temp, istatus, return_now)
   endif
  
   qmr_return_now=.false.
   if(any(qmr_istatus/=0)) then
      write(string1, *) &
      'APM NOTICE: model QMR obs value on TROPOMI grid has a bad value '
      call error_handler(E_MSG, routine, string1, source)
      call track_status(ens_size, qmr_istatus, qmr_temp, istatus, return_now)
   endif
   if(o3_return_now .or. tmp_return_now .or. qmr_return_now) return

   o3_val(:,k) = o3_temp(:)  
   tmp_val(:,k) = tmp_temp(:)  
   qmr_val(:,k) = qmr_temp(:)

   ! Convert units for o3 from ppmv
   o3_val(:,k) = o3_val(:,k) * 1.e-6_r8

enddo
!write(string1, *) 'APM: o3_val mem=1 ',key,o3_val(1,:)
!call error_handler(E_MSG, routine, string1, source)
!write(string1, *) 'APM: tmp_val mem=1 ',key,tmp_val(1,:)
!call error_handler(E_MSG, routine, string1, source)
!write(string1, *) 'APM: qmr_val mem=1 ',key,qmr_val(1,:)
!call error_handler(E_MSG, routine, string1, source)

expct_val(:)=0.0
allocate(thick(layer_tropomi))
do imem=1,ens_size

   ! Adjust the TROPOMI pressure for WRF-Chem lower/upper boudary pressure
   ! (TROPOMI O3 vertical grid is bottom to top)

   prs_tropomi_mem(:)=prs_tropomi(:)
   if (prs_sfc(imem).gt.prs_tropomi_mem(1)) then
      prs_tropomi_mem(1)=prs_sfc(imem)
   endif   

   ! Calculate the thicknesses

   thick(:)=0.
   do k=1,layer_tropomi
      lnpr_mid=(log(prs_tropomi_mem(k+1))+log(prs_tropomi_mem(k)))/2.
      up_wt=log(prs_tropomi_mem(k))-lnpr_mid
      dw_wt=log(lnpr_mid)-log(prs_tropomi_mem(k+1))
      tl_wt=up_wt+dw_wt
      
      tmp_vir_k  = (1.0_r8 + eps*qmr_val(imem,k))*tmp_val(imem,k)
      tmp_vir_kp = (1.0_r8 + eps*qmr_val(imem,k+1))*tmp_val(imem,k+1)
      thick(k)   = Rd*(dw_wt*tmp_vir_k + up_wt*tmp_vir_kp)/tl_wt/grav* &
                   log(prs_tropomi_mem(k)/prs_tropomi_mem(k+1))
   enddo

!   if(imem.eq.1) then
!      write(string1, *) 'APM: thick mem=1 ',key,thick(:)
!      call error_handler(E_MSG, routine, string1, source)
!   endif
   ! Process the vertical summation

   expct_val(imem)=0.0_r8
   do k=1,layer_tropomi
      lnpr_mid=(log(prs_tropomi_mem(k+1))+log(prs_tropomi_mem(k)))/2.
      up_wt=log(prs_tropomi_mem(k))-lnpr_mid
      dw_wt=log(lnpr_mid)-log(prs_tropomi_mem(k+1))
      tl_wt=up_wt+dw_wt

      ! Convert from VMR to molar density (mol/m^3)
      if(use_log_o3) then
         o3_val_conv = (dw_wt*exp(o3_val(imem,k))+up_wt*exp(o3_val(imem,k+1)))/tl_wt * &
                        (dw_wt*prs_tropomi_mem(k)+up_wt*prs_tropomi_mem(k+1)) / &
                        (Ru*(dw_wt*tmp_val(imem,k)+up_wt*tmp_val(imem,k+1)))
      else
         o3_val_conv = (dw_wt*o3_val(imem,k)+up_wt*o3_val(imem,k+1))/tl_wt * &
                        (dw_wt*prs_tropomi_mem(k)+up_wt*prs_tropomi_mem(k+1)) / &
                        (Ru*(dw_wt*tmp_val(imem,k)+up_wt*tmp_val(imem,k+1)))
      endif
 
      ! Get expected observation

      expct_val(imem) = expct_val(imem) + thick(k) * o3_val_conv * &
                        avg_kernel(key,k) + (1.0_r8 - avg_kernel(key,k)) * &
                        prior(key,k)
   enddo
enddo
!write(string1, *) 'APM: expct_val (all mems) ',key,expct_val(:)
!call error_handler(E_MSG, routine, string1, source)

! Clean up and return
deallocate(o3_val, tmp_val, qmr_val)
deallocate(thick)
deallocate(prs_tropomi, prs_tropomi_mem)

end subroutine get_expected_tropomi_o3

!-------------------------------------------------------------------------------

subroutine set_obs_def_tropomi_o3(key, o3_pressure, o3_avg_kernel, o3_prior, o3_nlayer)

integer,                           intent(in)   :: key, o3_nlayer
real(r8), dimension(o3_nlayer+1),  intent(in)   :: o3_pressure
real(r8), dimension(o3_nlayer),    intent(in)   :: o3_avg_kernel
real(r8), dimension(o3_nlayer),    intent(in)   :: o3_prior

if ( .not. module_initialized ) call initialize_module

if(num_tropomi_o3_obs >= max_tropomi_o3_obs) then
   write(string1, *)'Not enough space for tropomi o3 obs.'
   write(string2, *)'Can only have max_tropomi_o3_obs (currently ',max_tropomi_o3_obs,')'
   call error_handler(E_ERR,'set_obs_def_tropomi_o3',string1,source,revision, &
   revdate,text2=string2)
endif

nlayer(key) = o3_nlayer
pressure(key,1:o3_nlayer+1) = o3_pressure(1:o3_nlayer+1)
avg_kernel(key,1:o3_nlayer) = o3_avg_kernel(1:o3_nlayer)
prior(key,1:o3_nlayer) = o3_prior(1:o3_nlayer)

end subroutine set_obs_def_tropomi_o3

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




end module obs_def_tropomi_o3_mod

! END DART PREPROCESS MODULE CODE
