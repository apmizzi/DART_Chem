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

! BEGIN DART PREPROCESS KIND LIST
! MODIS_AOD_RETRIEVAL, QTY_AOD
! END DART PREPROCESS KIND LIST

! BEGIN DART PREPROCESS USE OF SPECIAL OBS_DEF MODULE
!   use obs_def_MODIS_AOD_mod, only : get_expected_modis_aod
! END DART PREPROCESS USE OF SPECIAL OBS_DEF MODULE

! BEGIN DART PREPROCESS GET_EXPECTED_OBS_FROM_DEF
!         case(MODIS_AOD_RETRIEVAL)                                                           
!            call get_expected_modis_aod(state_handle, ens_size, location, expected_obs, istatus)  
! END DART PREPROCESS GET_EXPECTED_OBS_FROM_DEF

! BEGIN DART PREPROCESS READ_OBS_DEF
!      case(MODIS_AOD_RETRIEVAL)
!         continue
! END DART PREPROCESS READ_OBS_DEF

! BEGIN DART PREPROCESS WRITE_OBS_DEF
!      case(MODIS_AOD_RETRIEVAL)
!         continue
! END DART PREPROCESS WRITE_OBS_DEF

! BEGIN DART PREPROCESS INTERACTIVE_OBS_DEF
!      case(MODIS_AOD_RETRIEVAL)
!         continue
! END DART PREPROCESS INTERACTIVE_OBS_DEF

! BEGIN DART PREPROCESS MODULE CODE
module obs_def_MODIS_AOD_mod

use        types_mod, only : r8, missing_r8
use    utilities_mod, only : register_module, error_handler, E_ERR, E_MSG, &
                             nmlfileunit, check_namelist_read, &
                             find_namelist_in_file, do_nml_file, do_nml_term, &
                             ascii_file_format
use     location_mod, only : location_type, set_location, get_location, VERTISPRESSURE, VERTISLEVEL, VERTISSURFACE, VERTISUNDEF

use  assim_model_mod, only : interpolate
use    obs_kind_mod
use ensemble_manager_mod,  only : ensemble_type
use obs_def_utilities_mod, only : track_status

implicit none
private

public :: get_expected_modis_aod

! Storage for the special information required for observations of this type
integer, parameter               :: MAX_MODIS_AOD_OBS = 10000000
integer                          :: num_modis_aod_obs = 0

! version controlled file description for error handling, do not edit
character(len=*), parameter :: source   = 'obs_def_MODIS_AOD_mod.f90'
character(len=*), parameter :: revision = ''
character(len=*), parameter :: revdate  = ''

character(len=512) :: string1, string2

logical, save :: module_initialized = .false.
logical       :: use_log_aod
namelist /obs_def_MODIS_AOD_nml/ use_log_aod

contains

!----------------------------------------------------------------------

subroutine initialize_module

integer :: iunit, rc

! Prevent multiple calls from executing this code more than once.
if (module_initialized) return

call register_module(source, revision, revdate)
module_initialized = .true.
use_log_aod=.false.
! Read the namelist entry.
call find_namelist_in_file("input.nml", "obs_def_MODIS_AOD_nml", iunit)
read(iunit, nml = obs_def_MODIS_AOD_nml, iostat = rc)
call check_namelist_read(iunit, rc, "obs_def_MODIS_AOD_nml")

! Record the namelist values used for the run ... 
if (do_nml_file()) write(nmlfileunit, nml=obs_def_MODIS_AOD_nml)
if (do_nml_term()) write(     *     , nml=obs_def_MODIS_AOD_nml)
end subroutine initialize_module
!
subroutine get_expected_modis_aod(state_handle, ens_size, location, val, istatus)
!----------------------------------------------------------------------
!subroutine get_expected_modis_aod(state, location, val, istatus)
   type(ensemble_type), intent(in)  :: state_handle
   integer,             intent(in)  :: ens_size
   type(location_type), intent(in)  :: location
   real(r8),            intent(out) :: val(ens_size)
   integer,             intent(out) :: istatus(ens_size)
   integer                          :: qmr_istatus(ens_size)
   integer                          :: p25_istatus(ens_size)
   integer                          :: sulf_istatus(ens_size)
   integer                          :: bc1_istatus(ens_size)
   integer                          :: bc2_istatus(ens_size)
   integer                          :: oc1_istatus(ens_size)
   integer                          :: oc2_istatus(ens_size)
   integer                          :: dst1_istatus(ens_size)
   integer                          :: dst2_istatus(ens_size)
   integer                          :: dst3_istatus(ens_size)
   integer                          :: dst4_istatus(ens_size)
   integer                          :: dst5_istatus(ens_size)
   integer                          :: ss1_istatus(ens_size)
   integer                          :: ss2_istatus(ens_size)
   integer                          :: ss3_istatus(ens_size)
   integer                          :: ss4_istatus(ens_size)
   integer                          :: tmp_istatus(ens_size)
   integer                          :: prs_istatus(ens_size)
   integer                          :: phd_istatus(ens_size)
   integer                          :: phu_istatus(ens_size)
   logical                          :: return_now
!
   integer,parameter   :: wrf_nlev=33
   integer,parameter   :: aod_nlev=wrf_nlev-1

! Forward operator for MODIS AOD.  The argument list to this routine
! must match the call in the GET_EXPECTED_OBS_FROM_DEF section above.

   type(location_type)  :: nloc,nploc
   integer  :: ilev
   real(r8) :: qvapor(ens_size)   ! water vapor mixing ratio
   real(r8) :: p25(ens_size)      ! p25 
   real(r8) :: sulf(ens_size)     ! Sulphate 
   real(r8) :: BC1(ens_size)      ! Hydrophobic Black Carbon 
   real(r8) :: BC2(ens_size)      ! Hydrophilic Black Carbon 
   real(r8) :: OC1(ens_size)      ! Hydrophobic Organic Carbon
   real(r8) :: OC2(ens_size)      ! Hydrophilic Organic Carbon 
   real(r8) :: DUST1(ens_size)    ! Dust 1
   real(r8) :: DUST2(ens_size)    ! Dust 2
   real(r8) :: DUST3(ens_size)    ! Dust 3
   real(r8) :: DUST4(ens_size)    ! Dust 4
   real(r8) :: DUST5(ens_size)    ! Dust 5
   real(r8) :: SS1(ens_size)      ! Sea Salt 1
   real(r8) :: SS2(ens_size)      ! Sea Salt 2
   real(r8) :: SS3(ens_size)      ! Sea Salt 3
   real(r8) :: SS4(ens_size)      ! Sea Salt 4
   real(r8) :: Theta(ens_size)    ! perturbation potential temperature
   real(r8) :: T(ens_size)        ! temperature
   real(r8) :: Tv(ens_size)       ! virtual temperature
   real(r8) :: P(ens_size)        ! perturbation pressure
   real(r8) :: PH_dn(ens_size)    ! perturbation geopotential
   real(r8) :: PH_up(ens_size)    ! perturbation geopotential
   real(r8) :: rho_d(ens_size)    ! density dry air
   real(r8) :: rho_m(ens_size)    ! density moist air
   real(r8) :: Rd                 ! gas constant dry air
   real(r8) :: Cp                 ! heat capacity dry air
   real(r8) :: Pa_to_torr         ! convert Pa to torr
   real(r8) :: grav               ! gravity
   real(r8) :: fac                ! units conversion factor
   real(r8) :: mloc(3)
!
   namelist /obs_def_MODIS_AOD_nml/ use_log_aod
!
! Initialize DART
   if ( .not. module_initialized ) call initialize_module
!
   fac = 1.e-6
   grav = 9.8      ! m/s^2
   Rd = 287.05     ! J/kg
   Cp = 1006.0     ! J/kg/K
   Pa_to_torr = 133.322
   val(:) = 0.     ! dimensionless

   mloc = get_location(location)
   if (mloc(2)>90.0_r8) then
      mloc(2)=90.0_r8
   elseif (mloc(2)<-90.0_r8) then
      mloc(2)=-90.0_r8
   endif

   do ilev=1,aod_nlev
      mloc(3)=real(ilev)
      nloc = set_location(mloc(1), mloc(2), mloc(3), VERTISLEVEL)
      mloc(3)=real(ilev+1)
      nploc = set_location(mloc(1), mloc(2), mloc(3), VERTISLEVEL)
!
! water vapor mixing ratio (kg/kg) at this location - this calls the model_mod code.
     istatus(:)=0.
     qmr_istatus(:)=0.
     call interpolate(state_handle, ens_size, location, QTY_VAPOR_MIXING_RATIO, qvapor, qmr_istatus)
     call track_status(ens_size, qmr_istatus, qvapor, istatus, return_now)
     if(return_now) return
!
! sulfate (kg/kg) at this location - this calls the model_mod code.
     istatus(:)=0.
     sulf_istatus(:)=0.
     call interpolate(state_handle, ens_size, location, QTY_SO4, sulf, sulf_istatus)
     call track_status(ens_size, sulf_istatus, sulf, istatus, return_now)
     if(return_now) return
!
! dust (ug/kg - dry air) at this location - this calls the model_mod code.
     istatus(:)=0.
     dst1_istatus(:)=0.
     call interpolate(state_handle, ens_size, location, QTY_DST01, DUST1, dst1_istatus)
     call track_status(ens_size, dst1_istatus, DUST1, istatus, return_now)
     if(return_now) return
!
! dust (ug/kg - dry air) at this location - this calls the model_mod code.
     istatus(:)=0.
     dst2_istatus(:)=0.
     call interpolate(state_handle, ens_size, location, QTY_DST02, DUST2, dst2_istatus)
     call track_status(ens_size, dst2_istatus, DUST2, istatus, return_now)
     if(return_now) return
!
! dust (ug/kg - dry air) at this location - this calls the model_mod code.
     istatus(:)=0.
     dst3_istatus(:)=0.
     call interpolate(state_handle, ens_size, location, QTY_DST03, DUST3, dst3_istatus)
     call track_status(ens_size, dst3_istatus, DUST3, istatus, return_now)
     if(return_now) return
!
! dust (ug/kg - dry air) at this location - this calls the model_mod code.
     istatus(:)=0.
     dst4_istatus(:)=0.
     call interpolate(state_handle, ens_size, location, QTY_DST04, DUST4, dst4_istatus)
     call track_status(ens_size, dst4_istatus, DUST4, istatus, return_now)
     if(return_now) return
!
! dust (ug/kg - dry air) at this location - this calls the model_mod code.
     istatus(:)=0.
     dst5_istatus(:)=0.
     call interpolate(state_handle, ens_size, location, QTY_DST05, DUST5, dst5_istatus)
     call track_status(ens_size, dst5_istatus, DUST5, istatus, return_now)
     if(return_now) return
!
! hydrophilic black carbon (ug/kg - dry air) at this location - this calls the model_mod code.
     istatus(:)=0.
     bc1_istatus(:)=0.
     call interpolate(state_handle, ens_size, location, QTY_BC1, BC1, bc1_istatus)
     call track_status(ens_size, bc1_istatus, BC1, istatus, return_now)
     if(return_now) return
!
! hydrophilic black carbon (ug/kg - dry air) at this location - this calls the model_mod code.
     istatus(:)=0.
     bc2_istatus(:)=0.
     call interpolate(state_handle, ens_size, location, QTY_BC2, BC2, bc2_istatus)
     call track_status(ens_size, bc2_istatus, BC2, istatus, return_now)
     if(return_now) return
!
! hydrophilic organic carbon (ug/kg - dry air) at this location - this calls the model_mod code.
     istatus(:)=0.
     oc1_istatus(:)=0.
     call interpolate(state_handle, ens_size, location, QTY_OC1, OC1, oc1_istatus)
     call track_status(ens_size, oc1_istatus, OC1, istatus, return_now)
     if(return_now) return
!
! hydrophilic organic carbon (ug/kg - dry air) at this location - this calls the model_mod code.
     istatus(:)=0.
     oc2_istatus(:)=0.
     call interpolate(state_handle, ens_size, location, QTY_OC2, OC2, oc2_istatus)
     call track_status(ens_size, oc2_istatus, OC2, istatus, return_now)
     if(return_now) return
!
! sea salt (ug/kg - dry air) at this location - this calls the model_mod code.
     istatus(:)=0.
     ss1_istatus(:)=0.
     call interpolate(state_handle, ens_size, location, QTY_SSLT01, SS1, ss1_istatus)
     call track_status(ens_size, ss1_istatus, SS1, istatus, return_now)
     if(return_now) return
!
! sea salt (ug/kg - dry air) at this location - this calls the model_mod code.
     istatus(:)=0.
     ss2_istatus(:)=0.
     call interpolate(state_handle, ens_size, location, QTY_SSLT02, SS2, ss2_istatus)
     call track_status(ens_size, ss2_istatus, SS2, istatus, return_now)
     if(return_now) return
!
! sea salt (ug/kg - dry air) at this location - this calls the model_mod code.
     istatus(:)=0.
     ss3_istatus(:)=0.
     call interpolate(state_handle, ens_size, location, QTY_SSLT03, SS3, ss3_istatus)
     call track_status(ens_size, ss3_istatus, SS3, istatus, return_now)
     if(return_now) return
!
! sea salt (ug/kg - dry air) at this location - this calls the model_mod code.
     istatus(:)=0.
     ss4_istatus(:)=0.
     call interpolate(state_handle, ens_size, location, QTY_SSLT04, SS4, ss4_istatus)
     call track_status(ens_size, ss4_istatus, SS4, istatus, return_now)
     if(return_now) return
!
! perturbation theta (K) at this location - this calls the model_mod code.
     istatus(:)=0.
     tmp_istatus(:)=0.
     call interpolate(state_handle, ens_size, location, QTY_POTENTIAL_TEMPERATURE, Theta, tmp_istatus)
     call track_status(ens_size, tmp_istatus, Theta, istatus, return_now)
     if(return_now) return
!
! perturbation pressure (Pa) at this location - this calls the model_mod code.
     istatus(:)=0.
     prs_istatus(:)=0.
     call interpolate(state_handle, ens_size, location, QTY_PRESSURE, P, prs_istatus)
     call track_status(ens_size, prs_istatus, P, istatus, return_now)
     if(return_now) return
!
! geopotential height (m) below this location - this calls the model_mod code.
     istatus(:)=0.
     phd_istatus(:)=0.
     call interpolate(state_handle, ens_size, location, QTY_GEOPOTENTIAL_HEIGHT, PH_dn, phd_istatus)
     call track_status(ens_size, phd_istatus, PH_dn, istatus, return_now)
     if(return_now) return
!
! geopotential height (m) above this location - this calls the model_mod code.
     istatus(:)=0.
     phu_istatus(:)=0.
     call interpolate(state_handle, ens_size, location, QTY_GEOPOTENTIAL_HEIGHT, PH_up, phu_istatus)
     call track_status(ens_size, phu_istatus, PH_up, istatus, return_now)
     if(return_now) return
!
! p25 at this location - this calls the model_mod code.
     istatus(:)=0.
     p25_istatus(:)=0.
     call interpolate(state_handle, ens_size, location, QTY_P25, p25, p25_istatus)
     call track_status(ens_size, p25_istatus, p25, istatus, return_now)
     if(return_now) return
!
! The actual forward operator computation.  This is the value that
! will be returned.  istatus (the return code) of 0 is good,
! return any value > 0 for error.  (values < 0 reserved for
! system use.)
!
     T = Theta / (100000./P)**(Rd/Cp)
     Tv = Theta / (100000./P)**(Rd/Cp) * qvapor/(1.+qvapor)
     rho_d = P/(Rd*T)
     rho_m = P/(Rd*Tv)
!
! Expected Modis AOD
     if (use_log_aod) then
        val = val + (3.673*exp(sulf) + 2.473*(exp(OC1)+exp(OC2)) + 8.99*(exp(BC1)+exp(BC2)) + &
        2.548*exp(SS1) + .889*exp(SS2) + .227*exp(SS3) + .096*exp(SS4) + 1.596*exp(DUST1) + &
        .507*exp(DUST2) + .275*exp(DUST3) + .140*exp(DUST4) + .078*exp(DUST5)) * &
        rho_d * (PH_up-PH_dn) * fac
     else
        val = val + (3.673*sulf + 2.473*(OC1+OC2) + 8.99*(BC1+BC2) + &
        2.548*SS1 + .889*SS2 + .227*SS3 + .096*SS4 + 1.596*DUST1 + &
        .507*DUST2 + .275*DUST3 + .140*DUST4 + .078*DUST5) * &
        rho_d * (PH_up-PH_dn) * fac
     endif 
 enddo

 istatus(:) = 0
!
end subroutine get_expected_modis_aod
!
!----------------------------------------------------------------------
!
end module obs_def_MODIS_AOD_mod
! END DART PREPROCESS MODULE CODE
