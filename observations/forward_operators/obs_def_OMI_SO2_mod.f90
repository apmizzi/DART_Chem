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
! OMI_SO2_COLUMN, QTY_SO2
! END DART PREPROCESS KIND LIST
!
! BEGIN DART PREPROCESS USE OF SPECIAL OBS_DEF MODULE
!   use obs_def_omi_so2_mod, only : get_expected_omi_so2, &
!                                   read_omi_so2, &
!                                   write_omi_so2, &
!                                   interactive_omi_so2
! END DART PREPROCESS USE OF SPECIAL OBS_DEF MODULE
!
! BEGIN DART PREPROCESS GET_EXPECTED_OBS_FROM_DEF
!      case(OMI_SO2_COLUMN)                                                           
!         call get_expected_omi_so2(state_handle, ens_size, location, obs_def%key, expected_obs, istatus)  
! END DART PREPROCESS GET_EXPECTED_OBS_FROM_DEF
!
! BEGIN DART PREPROCESS READ_OBS_DEF
!      case(OMI_SO2_COLUMN)
!         call read_omi_so2(obs_def%key, ifile, fileformat)
! END DART PREPROCESS READ_OBS_DEF
!
! BEGIN DART PREPROCESS WRITE_OBS_DEF
!      case(OMI_SO2_COLUMN)
!         call write_omi_so2(obs_def%key, ifile, fileformat)
! END DART PREPROCESS WRITE_OBS_DEF
!
! BEGIN DART PREPROCESS INTERACTIVE_OBS_DEF
!      case(OMI_SO2_COLUMN)
!         call interactive_omi_so2(obs_def%key)
! END DART PREPROCESS INTERACTIVE_OBS_DEF
!
! BEGIN DART PREPROCESS MODULE CODE

module obs_def_omi_so2_mod

use             types_mod, only : r8, MISSING_R8

use         utilities_mod, only : register_module, error_handler, E_ERR, E_MSG, &
                                  nmlfileunit, check_namelist_read, &
                                  find_namelist_in_file, do_nml_file, do_nml_term, &
                                  ascii_file_format

use          location_mod, only : location_type, set_location, get_location, &
                                  VERTISPRESSURE, VERTISSURFACE, VERTISLEVEL, &
                                  VERTISUNDEF

use       assim_model_mod, only : interpolate

use          obs_kind_mod, only : QTY_SO2, QTY_TEMPERATURE, QTY_SURFACE_PRESSURE, &
                                  QTY_PRESSURE, QTY_VAPOR_MIXING_RATIO

use  ensemble_manager_mod, only : ensemble_type

use obs_def_utilities_mod, only : track_status

implicit none
private

public :: write_omi_so2, &
          read_omi_so2, &
          interactive_omi_so2, &
          get_expected_omi_so2, &
          set_obs_def_omi_so2

! Storage for the special information required for observations of this type
integer, parameter    :: max_omi_so2_obs = 10000000
integer               :: num_omi_so2_obs = 0
integer,  allocatable :: nlayer(:)
integer,  allocatable :: kend(:)
real(r8), allocatable :: pressure(:,:)
real(r8), allocatable :: scat_wt(:,:)

! version controlled file description for error handling, do not edit
character(len=*), parameter :: source   = 'obs_def_omi_so2_mod.f90'
character(len=*), parameter :: revision = ''
character(len=*), parameter :: revdate  = ''

character(len=512) :: string1, string2

logical, save :: module_initialized = .false.

! Namelist with default values
logical :: use_log_so2   = .false.
integer :: nlayer_model = -9999
integer :: nlayer_omi_so2 = -9999

namelist /obs_def_OMI_SO2_nml/ use_log_so2, nlayer_model, nlayer_omi_so2

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
call find_namelist_in_file("input.nml", "obs_def_OMI_SO2_nml", iunit)
read(iunit, nml = obs_def_OMI_SO2_nml, iostat = rc)
call check_namelist_read(iunit, rc, "obs_def_OMI_SO2_nml")

! Record the namelist values
if (do_nml_file()) write(nmlfileunit, nml=obs_def_OMI_SO2_nml)
if (do_nml_term()) write(     *     , nml=obs_def_OMI_SO2_nml)

! Check for valid values

if (nlayer_model < 1) then
   write(string1,*)'obs_def_OMI_SO2_nml:nlayer_model must be > 0, it is ',nlayer_model
   call error_handler(E_ERR,'initialize_module',string1,source)
endif

if (nlayer_omi_so2 < 1) then
   write(string1,*)'obs_def_OMI_SO2_nml:nlayer_omi_so2 must be > 0, it is ',nlayer_omi_so2
   call error_handler(E_ERR,'initialize_module',string1,source)
endif

allocate(   nlayer(max_omi_so2_obs))
allocate(   kend(max_omi_so2_obs))
allocate( pressure(max_omi_so2_obs,nlayer_omi_so2+1))
allocate(  scat_wt(max_omi_so2_obs,nlayer_omi_so2))

end subroutine initialize_module

!-------------------------------------------------------------------------------

subroutine read_omi_so2(key, ifile, fform)

integer,          intent(out)          :: key
integer,          intent(in)           :: ifile
character(len=*), intent(in), optional :: fform

! temporary arrays to hold buffer till we decide if we have enough room

integer               :: keyin
integer               :: nlayer_1
integer               :: kend_1
real(r8), allocatable :: pressure_1(:)
real(r8), allocatable :: scat_wt_1(:)
character(len=32)     :: fileformat

integer, SAVE :: counts1 = 0

if ( .not. module_initialized ) call initialize_module

fileformat = "ascii" 
if(present(fform)) fileformat = adjustl(fform)

! Need to know how many layers for this one
nlayer_1   = read_int_scalar( ifile, fileformat, 'nlayer_1')
kend_1   = read_int_scalar( ifile, fileformat, 'kend_1')

allocate( pressure_1(nlayer_1+1))
allocate(  scat_wt_1(nlayer_1))

call read_r8_array(ifile, nlayer_1+1, pressure_1,   fileformat, 'pressure_1')
call read_r8_array(ifile, nlayer_1,   scat_wt_1, fileformat, 'scat_wt_1')
keyin = read_int_scalar(ifile, fileformat, 'keyin')

counts1 = counts1 + 1
key     = counts1

if(counts1 > max_omi_so2_obs) then
   write(string1, *)'Not enough space for omi so2 obs.'
   write(string2, *)'Can only have max_omi_so2_obs (currently ',max_omi_so2_obs,')'
   call error_handler(E_ERR,'read_omi_so2',string1,source,text2=string2)
endif

call set_obs_def_omi_so2(key, pressure_1, scat_wt_1, nlayer_1, kend_1)

deallocate(pressure_1, scat_wt_1)

end subroutine read_omi_so2

!-------------------------------------------------------------------------------

subroutine write_omi_so2(key, ifile, fform)

integer,          intent(in)           :: key
integer,          intent(in)           :: ifile
character(len=*), intent(in), optional :: fform

character(len=32) :: fileformat

if ( .not. module_initialized ) call initialize_module

fileformat = "ascii"
if(present(fform)) fileformat = adjustl(fform)

! nlayer, pressure, and scat_wt are all scoped in this module
! you can come extend the context strings to include the key if desired.

call write_int_scalar(ifile,                     nlayer(key), fileformat,'nlayer')
call write_int_scalar(ifile,                     kend(key), fileformat,'kend')
call write_r8_array(  ifile, nlayer(key)+1,  pressure(key,:), fileformat,'pressure')
call write_r8_array(  ifile, nlayer(key),  scat_wt(key,:), fileformat,'scat_wt')
call write_int_scalar(ifile,                             key, fileformat,'key')

end subroutine write_omi_so2

!-------------------------------------------------------------------------------

subroutine interactive_omi_so2(key)

integer, intent(out) :: key

if ( .not. module_initialized ) call initialize_module

! STOP because routine is not finished.
write(string1,*)'interactive_omi_so2 not yet working.'
call error_handler(E_ERR, 'interactive_omi_so2', string1, source)

if(num_omi_so2_obs >= max_omi_so2_obs) then
   write(string1, *)'Not enough space for an omi so2 obs.'
   write(string2, *)'Can only have max_omi_so2_obs (currently ',max_omi_so2_obs,')'
   call error_handler(E_ERR, 'interactive_omi_so2', string1, &
              source, text2=string2)
endif

! Increment the index
num_omi_so2_obs = num_omi_so2_obs + 1
key            = num_omi_so2_obs

! Otherwise, prompt for input for the three required beasts

write(*, *) 'Creating an interactive_omi_so2 observation'
write(*, *) 'This featue is not setup '

end subroutine interactive_omi_so2

!-------------------------------------------------------------------------------

subroutine get_expected_omi_so2(state_handle, ens_size, location, key, expct_val, istatus)

type(ensemble_type), intent(in)  :: state_handle
type(location_type), intent(in)  :: location
integer,             intent(in)  :: ens_size
integer,             intent(in)  :: key
integer,             intent(out) :: istatus(:)
real(r8),            intent(out) :: expct_val(:)

character(len=*), parameter :: routine = 'get_expected_omi_so2'
type(location_type) :: loc2

integer :: layer_omi,level_omi
integer :: layer_mdl,level_mdl
integer :: k,kk,imem,kend_omi
integer, dimension(ens_size) :: var1_istatus,var2_istatus,var3_istatus,var4_istatus,val_istatus
integer, dimension(ens_size) :: var1p_istatus,var2p_istatus,var3p_istatus,var4p_istatus

real(r8) :: eps, AvogN, Rd, Ru, Cp, grav, msq2cmsq
real(r8) :: so2_min, tmp_max
real(r8) :: level, del_prs
real(r8) :: tmp_vir_k, tmp_vir_kp
real(r8) :: mloc(3)
real(r8) :: missing, so2_val_conv
real(r8) :: up_wt,dw_wt,tl_wt,lnpr_mid
real(r8), dimension(ens_size) :: so2_mdl_1, tmp_mdl_1, qmr_mdl_1, prs_mdl_1
real(r8), dimension(ens_size) :: so2_mdl_1p, tmp_mdl_1p, qmr_mdl_1p, prs_mdl_1p
real(r8), dimension(ens_size) :: so2_mdl_n, tmp_mdl_n, qmr_mdl_n, prs_mdl_n
real(r8), dimension(ens_size) :: so2_mdl_nm, tmp_mdl_nm, qmr_mdl_nm, prs_mdl_nm
real(r8), dimension(ens_size) :: so2_temp, tmp_temp, qmr_temp, prs_sfc

real(r8), allocatable, dimension(:)   :: thick, prs_omi, prs_omi_mem
real(r8), allocatable, dimension(:,:) :: so2_val, tmp_val, qmr_val
logical  :: return_now,so2_return_now,tmp_return_now,qmr_return_now

if ( .not. module_initialized ) call initialize_module

eps      =  0.61_r8
Rd       = 287.05_r8     ! J/kg
Ru       = 8.316_r8      ! J/kg
Cp       = 1006.0        ! J/kg/K
grav     =   9.8_r8
so2_min  = 1.e-6_r8
msq2cmsq = 1.e4_r8
AvogN    = 6.02214e23_r8
missing  = -888888_r8
tmp_max  = 600.
del_prs  = 5000.

if(use_log_so2) then
   so2_min = log(so2_min)
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

if (    mloc(2) >  90.0_r8) then
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

var1_istatus=0
level=0.0_r8
loc2 = set_location(mloc(1), mloc(2), level, VERTISSURFACE)
call interpolate(state_handle, ens_size, loc2, QTY_SURFACE_PRESSURE, prs_sfc, var1_istatus) 
if(any(prs_sfc.lt.0) .or. any(var1_istatus.ne.0)) then
   istatus=20
   expct_val=missing
   write(string1, *)'APM NOTICE: MDL prs_sfc is bad ',key
   call error_handler(E_MSG, routine, string1, source)
   return
endif
write(string1, *)'APM: prs_sfc ',prs_sfc
call error_handler(E_MSG, routine, string1, source)

var1_istatus=0
var2_istatus=0
var3_istatus=0
var4_istatus=0
level = 1.0_r8
loc2 = set_location(mloc(1), mloc(2), level, VERTISLEVEL)
call interpolate(state_handle, ens_size, loc2, QTY_SO2, so2_mdl_1, var1_istatus) ! ppmv 
call interpolate(state_handle, ens_size, loc2, QTY_TEMPERATURE, tmp_mdl_1, var2_istatus) ! K 
call interpolate(state_handle, ens_size, loc2, QTY_VAPOR_MIXING_RATIO, qmr_mdl_1, var3_istatus) ! kg / kg 
call interpolate(state_handle, ens_size, loc2, QTY_PRESSURE, prs_mdl_1, var4_istatus) ! Pa

write(string1, *)'APM: so2 lower bound 1 ',so2_mdl_1
call error_handler(E_MSG, routine, string1, source)
write(string1, *)'APM: tmp lower bound 1 ',tmp_mdl_1
call error_handler(E_MSG, routine, string1, source)
write(string1, *)'APM: qmr lower bound 1 ',qmr_mdl_1
call error_handler(E_MSG, routine, string1, source)
write(string1, *)'APM: prs lower bound 1 ',prs_mdl_1
call error_handler(E_MSG, routine, string1, source)

level=1.
do imem=1,ens_size
   do while (so2_mdl_1(imem).lt.0 .or. var1_istatus(imem).ne.0 .or. &
   tmp_mdl_1(imem).lt.0 .or. var2_istatus(imem).ne.0 .or. &
   qmr_mdl_1(imem).lt.0 .or. var3_istatus(imem).ne.0 .or. &
   prs_mdl_1(imem).lt.0 .or. var4_istatus(imem).ne.0)

      level = level + 1.
      if(level.gt.15) then
         istatus=20
         expct_val=missing
         write(string1, *)'APM: no so2_mdl_1 found (too high) ',level
         call error_handler(E_MSG, routine, string1, source)
         return
      endif

      var1p_istatus=0
      var2p_istatus=0
      var3p_istatus=0
      var4p_istatus=0
      loc2 = set_location(mloc(1), mloc(2), level, VERTISLEVEL)
      call interpolate(state_handle, ens_size, loc2, QTY_SO2, so2_mdl_1p, var1p_istatus) 
      call interpolate(state_handle, ens_size, loc2, QTY_TEMPERATURE, tmp_mdl_1p, &
      var2p_istatus) 
      call interpolate(state_handle, ens_size, loc2, QTY_VAPOR_MIXING_RATIO, qmr_mdl_1p, &
      var3p_istatus) 
      call interpolate(state_handle, ens_size, loc2, QTY_PRESSURE, prs_mdl_1p, &
      var4p_istatus) 
   
      var1_istatus(imem) = var1p_istatus(imem)
      var2_istatus(imem) = var2p_istatus(imem)
      var3_istatus(imem) = var3p_istatus(imem)
      var4_istatus(imem) = var4p_istatus(imem)
      so2_mdl_1(imem) = so2_mdl_1p(imem)
      tmp_mdl_1(imem) = tmp_mdl_1p(imem)
      qmr_mdl_1(imem) = qmr_mdl_1p(imem)
      prs_mdl_1(imem) = prs_mdl_1p(imem)
   enddo
enddo

write(string1, *)'APM: so2 lower bound 2 ',so2_mdl_1
call error_handler(E_MSG, routine, string1, source)
write(string1, *)'APM: tmp lower bound 2 ',tmp_mdl_1
call error_handler(E_MSG, routine, string1, source)
write(string1, *)'APM: qmr lower bound 2 ',qmr_mdl_1
call error_handler(E_MSG, routine, string1, source)
write(string1, *)'APM: prs lower bound 2 ',prs_mdl_1
call error_handler(E_MSG, routine, string1, source)

var1_istatus=0
var2_istatus=0
var3_istatus=0
var4_istatus=0
level=real(layer_mdl)
loc2 = set_location(mloc(1), mloc(2), level, VERTISLEVEL)
call interpolate(state_handle, ens_size, loc2, QTY_SO2, so2_mdl_n, var1_istatus) ! ppmv
call interpolate(state_handle, ens_size, loc2, QTY_TEMPERATURE, tmp_mdl_n, var2_istatus) ! K 
call interpolate(state_handle, ens_size, loc2, QTY_VAPOR_MIXING_RATIO, qmr_mdl_n, var3_istatus) ! kg / kg 
call interpolate(state_handle, ens_size, loc2, QTY_PRESSURE, prs_mdl_n, var4_istatus) ! Pa

write(string1, *)'APM: so2 upper bound 1 ',so2_mdl_n
call error_handler(E_MSG, routine, string1, source)
write(string1, *)'APM: tmp upper bound 1 ',tmp_mdl_n
call error_handler(E_MSG, routine, string1, source)
write(string1, *)'APM: qmr upper bound 1 ',qmr_mdl_n
call error_handler(E_MSG, routine, string1, source)
write(string1, *)'APM: prs upper bound 1 ',prs_mdl_n
call error_handler(E_MSG, routine, string1, source)

do imem=1,ens_size
   level=real(layer_mdl)
   do while (so2_mdl_n(imem).lt.0 .or. var1_istatus(imem).ne.0 .or. &
   tmp_mdl_n(imem).lt.0 .or. var2_istatus(imem).ne.0 .or. &
   qmr_mdl_n(imem).lt.0 .or. var3_istatus(imem).ne.0 .or. &
   prs_mdl_n(imem).lt.0 .or. var4_istatus(imem).ne.0)

      level = level - 1
      if(level.le.layer_mdl/2) then
         istatus=20
         expct_val=missing         
         write(string1, *)'APM FATAL ERROR: no so2_mdl_n found (too low) ',level
         call error_handler(E_MSG, routine, string1, source)
         return
      endif   

      var1p_istatus=0
      var2p_istatus=0
      var3p_istatus=0
      var4p_istatus=0
      loc2 = set_location(mloc(1), mloc(2), level, VERTISLEVEL)
      call interpolate(state_handle, ens_size, loc2, QTY_SO2, so2_mdl_nm, var1p_istatus) 
      call interpolate(state_handle, ens_size, loc2, QTY_TEMPERATURE, tmp_mdl_nm, var2p_istatus) 
      call interpolate(state_handle, ens_size, loc2, QTY_VAPOR_MIXING_RATIO, qmr_mdl_nm, var3p_istatus) 
      call interpolate(state_handle, ens_size, loc2, QTY_PRESSURE, prs_mdl_nm, var4p_istatus) 
      var1_istatus(imem) = var1p_istatus(imem)
      var2_istatus(imem) = var2p_istatus(imem)
      var3_istatus(imem) = var3p_istatus(imem)
      var4_istatus(imem) = var4p_istatus(imem)
      so2_mdl_n(imem) = so2_mdl_nm(imem)
      tmp_mdl_n(imem) = tmp_mdl_nm(imem)
      qmr_mdl_n(imem) = qmr_mdl_nm(imem)
      prs_mdl_n(imem) = prs_mdl_nm(imem)
   enddo
enddo

write(string1, *)'APM: so2 upper bound 2 ',so2_mdl_n
call error_handler(E_MSG, routine, string1, source)
write(string1, *)'APM: tmp upper bound 2 ',tmp_mdl_n
call error_handler(E_MSG, routine, string1, source)
write(string1, *)'APM: qmr upper bound 2 ',qmr_mdl_n
call error_handler(E_MSG, routine, string1, source)
write(string1, *)'APM: prs upper bound 2 ',prs_mdl_n
call error_handler(E_MSG, routine, string1, source)

! Get profiles at OMI pressure levels

allocate(so2_val(ens_size,level_omi))
allocate(tmp_val(ens_size,level_omi))
allocate(qmr_val(ens_size,level_omi))

do k=1,level_omi
   var1_istatus=0
   var2_istatus=0
   var3_istatus=0
   loc2 = set_location(mloc(1), mloc(2), prs_omi(k), VERTISPRESSURE)
   call interpolate(state_handle, ens_size, loc2, QTY_SO2, so2_val(:,k), var1_istatus)  
   call interpolate(state_handle, ens_size, loc2, QTY_TEMPERATURE, tmp_val(:,k), var2_istatus)  
   call interpolate(state_handle, ens_size, loc2, QTY_VAPOR_MIXING_RATIO, qmr_val(:,k), var3_istatus)  

   ! Correcting for expected failures near the surface
   do imem=1,ens_size
      if (prs_omi(k).ge.prs_mdl_1(imem)) then
         so2_val(imem,k) = so2_mdl_1(imem)
         tmp_val(imem,k) = tmp_mdl_1(imem)
         qmr_val(imem,k) = qmr_mdl_1(imem)
         cycle
      endif

   ! Correcting for expected failures near the top
      if (prs_omi(k).le.prs_mdl_n(imem)) then
         so2_val(imem,k) = so2_mdl_n(imem)
         tmp_val(imem,k) = tmp_mdl_n(imem)
         qmr_val(imem,k) = qmr_mdl_n(imem)
         cycle
      endif

   ! Correct other bad values

      if((prs_omi(k).lt.prs_mdl_1(imem) .and. prs_omi(k).ge. &
      (prs_mdl_1(imem)-del_prs)) .and. (so2_val(imem,k).lt.0 .or. &
      tmp_val(imem,k).lt.0 .or. qmr_val(imem,k).lt.0 .or. &
      var1_istatus(imem).ne.0 .or. var2_istatus(imem).ne.0 .or. &
      var3_istatus(imem).ne.0)) then
         so2_val(imem,k)=so2_mdl_1(imem)
         tmp_val(imem,k)=tmp_mdl_1(imem)
         qmr_val(imem,k)=qmr_mdl_1(imem)
         cycle
      endif
      
      if((prs_omi(k).gt.prs_mdl_n(imem) .and. prs_omi(k).le. &
      (prs_mdl_n(imem)+del_prs)) .and. (so2_val(imem,k).lt.0 .or. &
      tmp_val(imem,k).lt.0 .or. qmr_val(imem,k).lt.0 .or. &
      var1_istatus(imem).ne.0 .or. var2_istatus(imem).ne.0 .or. &
      var3_istatus(imem).ne.0)) then
         so2_val(imem,k)=so2_mdl_n(imem)
         tmp_val(imem,k)=tmp_mdl_n(imem)
         qmr_val(imem,k)=qmr_mdl_n(imem)
         cycle
      endif
      
      if(so2_val(imem,k).lt.0 .or. tmp_val(imem,k).lt.0 .or. &
      qmr_val(imem,k).lt.0 .or. var1_istatus(imem).ne.0 .or. &
      var2_istatus(imem).ne.0 .or. var3_istatus(imem).ne.0) then
         istatus=20
         expct_val=missing         
         write(string1, *)'APM: so2, tmp, or qmr on OMI grid is bad ', &
         so2_val(imem,k),tmp_val(imem,k),qmr_val(imem,k)
         call error_handler(E_MSG, routine, string1, source)
         return
      endif
      write(string1, *)'APM: imem, k, so2 ',imem,k,so2_val(imem,k)
      call error_handler(E_MSG, routine, string1, source)
      write(string1, *)'APM: imem, k, tmp ',imem,k,tmp_val(imem,k)
      call error_handler(E_MSG, routine, string1, source)
      write(string1, *)'APM: imem, k, qmr ',imem,k,qmr_val(imem,k)
      call error_handler(E_MSG, routine, string1, source)
   enddo
   ! Convert units for so2 from ppmv
   so2_val(:,k) = so2_val(:,k) * 1.e-6_r8
!   tmp_val(:,k) = (tmp_val(:,k) + 300.)/(1000000./prs_omi(k))**(Rd/Cp)
enddo

istatus=0
val_istatus(:)=0.
expct_val(:)=0.0
allocate(thick(layer_omi))
return_now=.false.
do imem=1,ens_size
   ! Adjust the OMI pressure for WRF-Chem lower/upper boudary pressure
   ! (OMI SO2 vertical grid is top to bottom)

   prs_omi_mem(:)=prs_omi(:)

   ! Calculate the thicknesses

   thick(:)=0.
   do k=1,layer_omi
      kk=level_omi-k+1
      lnpr_mid=(log(prs_omi_mem(kk))+log(prs_omi_mem(kk-1)))/2.
      up_wt=log(prs_omi_mem(kk))-lnpr_mid
      dw_wt=lnpr_mid-log(prs_omi_mem(kk-1))
      tl_wt=up_wt+dw_wt
      
      tmp_vir_k  = (1.0_r8 + eps*qmr_val(imem,kk))*tmp_val(imem,kk)
      tmp_vir_kp = (1.0_r8 + eps*qmr_val(imem,kk-1))*tmp_val(imem,kk-1)
      thick(kk)   = Rd*(dw_wt*tmp_vir_k + up_wt*tmp_vir_kp)/tl_wt/grav* &
                   log(prs_omi_mem(kk)/prs_omi_mem(kk-1))
   enddo

   ! Process the vertical summation

   expct_val(imem)=0.0_r8
   do k=1,layer_omi
      kk=level_omi-k+1
      lnpr_mid=(log(prs_omi_mem(kk))+log(prs_omi_mem(kk-1)))/2.
      up_wt=log(prs_omi_mem(kk))-lnpr_mid
      dw_wt=lnpr_mid-log(prs_omi_mem(kk-1))
      tl_wt=up_wt+dw_wt

      ! Convert from VMR to molar density (mol/m^3)
      if(use_log_so2) then
         so2_val_conv = (dw_wt*exp(so2_val(imem,kk))+up_wt*exp(so2_val(imem,kk-1)))/tl_wt * &
                        (dw_wt*prs_omi(kk)+up_wt*prs_omi(kk-1)) / &
                        (Ru*(dw_wt*tmp_val(imem,kk)+up_wt*tmp_val(imem,kk-1)))
      else
         so2_val_conv = (dw_wt*so2_val(imem,kk)+up_wt*so2_val(imem,kk-1))/tl_wt * &
                        (dw_wt*prs_omi(kk)+up_wt*prs_omi(kk-1)) / &
                        (Ru*(dw_wt*tmp_val(imem,kk)+up_wt*tmp_val(imem,kk-1)))
      endif
 
      ! Get expected observation

      expct_val(imem) = expct_val(imem) + thick(kk-1) * so2_val_conv * &
                        AvogN/msq2cmsq * scat_wt(key,kk-1) 

      write(string1, *) 'APM: kk,imem,exp_val,thick,so2_val,sct_wt ',kk-1,imem, &
      expct_val(imem),thick(kk-1),so2_val_conv,scat_wt(key,kk-1)
      call error_handler(E_MSG, routine, string1, source)
   enddo
   if(expct_val(imem).lt.0) then
      val_istatus(imem)=20
      return_now=.true.
      write(string1, *) &
      'APM NOTICE: OMI SO2 expected value is negative '
      call error_handler(E_MSG, routine, string1, source)
      call track_status(ens_size, val_istatus, expct_val, istatus, return_now)
      return
   endif
enddo

! Clean up and return
deallocate(so2_val, tmp_val, qmr_val)
deallocate(thick)
deallocate(prs_omi, prs_omi_mem)

end subroutine get_expected_omi_so2

!-------------------------------------------------------------------------------

subroutine set_obs_def_omi_so2(key, so2_pressure, so2_scat_wt, so2_nlayer, so2_kend)

integer,                            intent(in)   :: key, so2_nlayer, so2_kend
real(r8), dimension(so2_nlayer+1),  intent(in)   :: so2_pressure
real(r8), dimension(so2_nlayer),    intent(in)   :: so2_scat_wt

if ( .not. module_initialized ) call initialize_module

if(num_omi_so2_obs >= max_omi_so2_obs) then
   write(string1, *)'Not enough space for omi so2 obs.'
   write(string2, *)'Can only have max_omi_so2_obs (currently ',max_omi_so2_obs,')'
   call error_handler(E_ERR,'set_obs_def_omi_so2',string1,source,revision, &
   revdate,text2=string2)
endif

nlayer(key) = so2_nlayer
kend(key) = so2_kend
pressure(key,1:so2_nlayer+1) = so2_pressure(1:so2_nlayer+1)
scat_wt(key,1:so2_nlayer) = so2_scat_wt(1:so2_nlayer)

end subroutine set_obs_def_omi_so2

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

function read_r8_scalar(ifile, fform, context)

real(r8)                     :: read_r8_scalar
integer,          intent(in) :: ifile
character(len=*), intent(in) :: fform
character(len=*), intent(in) :: context

integer :: io

if (ascii_file_format(fform)) then
   read(ifile, *, iostat = io) read_r8_scalar
else
   read(ifile, iostat = io) read_r8_scalar
endif
if ( io /= 0 ) then
   call error_handler(E_ERR,'read_r8_scalar', context, source)
endif

end function read_r8_scalar

!-------------------------------------------------------------------------------

subroutine write_r8_scalar(ifile, my_scalar, fform, context)

integer,          intent(in) :: ifile
real(r8),         intent(in) :: my_scalar
character(len=*), intent(in) :: fform
character(len=*), intent(in) :: context

integer :: io

if (ascii_file_format(fform)) then
   write(ifile, *, iostat=io) my_scalar
else
   write(ifile, iostat=io) my_scalar
endif
if ( io /= 0 ) then
   call error_handler(E_ERR, 'write_r8_scalar', context, source)
endif

end subroutine write_r8_scalar

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




end module obs_def_omi_so2_mod

! END DART PREPROCESS MODULE CODE
