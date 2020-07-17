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
! AIRNOW_PM10,         QTY_PM10
! END DART PREPROCESS KIND LIST

! BEGIN DART PREPROCESS USE OF SPECIAL OBS_DEF MODULE
!   use obs_def_AIRNOW_PM10_mod, only : get_expected_airnow_pm10
! END DART PREPROCESS USE OF SPECIAL OBS_DEF MODULE

! BEGIN DART PREPROCESS GET_EXPECTED_OBS_FROM_DEF
!   case(AIRNOW_PM10)
!        call get_expected_airnow_pm10(state_handle, ens_size, location, expected_obs, istatus) 
! END DART PREPROCESS GET_EXPECTED_OBS_FROM_DEF

! BEGIN DART PREPROCESS READ_OBS_DEF
!   case(AIRNOW_PM10)
!     continue
! END DART PREPROCESS READ_OBS_DEF

! BEGIN DART PREPROCESS WRITE_OBS_DEF
!   case(AIRNOW_PM10)
!     continue
! END DART PREPROCESS WRITE_OBS_DEF

! BEGIN DART PREPROCESS INTERACTIVE_OBS_DEF
!   case(AIRNOW_PM10)
!     continue
! END DART PREPROCESS INTERACTIVE_OBS_DEF


! BEGIN DART PREPROCESS MODULE CODE
module obs_def_AIRNOW_PM10_mod

use        types_mod, only : r8, missing_r8
use    utilities_mod, only : register_module, error_handler, E_ERR, E_MSG, &
                             nmlfileunit, check_namelist_read, &
                             find_namelist_in_file, do_nml_file, do_nml_term, &
                             ascii_file_format
use     location_mod, only : location_type
use  assim_model_mod, only : interpolate
use     obs_kind_mod
use ensemble_manager_mod,  only : ensemble_type
use obs_def_utilities_mod, only : track_status
implicit none
private

public :: get_expected_airnow_pm10

! version controlled file description for error handling, do not edit
character(len=*), parameter :: source   = 'obs_def_AIRNOW_PM10_mod.f90'
character(len=*), parameter :: revision = ''
character(len=*), parameter :: revdate  = ''

logical, save :: module_initialized = .false.
logical       :: use_log_pm10
namelist /obs_def_AIRNOW_PM10_nml/ use_log_pm10

contains

! ---------------------------------------------------

subroutine initialize_module

integer :: iunit, rc

! Prevent multiple calls frm executing this code more than once.
if (module_initialized) return

call register_module(source, revision, revdate)
module_initialized = .true.

! Read the namelist entry.
use_log_pm10=.false.
call find_namelist_in_file("input.nml", "obs_def_AIRNOW_PM10_nml", iunit)
read(iunit, nml = obs_def_AIRNOW_PM10_nml, iostat = rc)
call check_namelist_read(iunit, rc, "obs_def_AIRNOW_PM10_nml")

! Record the namelist values used for the run ... 
if (do_nml_file()) write(nmlfileunit, nml=obs_def_AIRNOW_PM10_nml)
if (do_nml_term()) write(     *     , nml=obs_def_AIRNOW_PM10_nml)
end subroutine initialize_module
!
subroutine get_expected_airnow_pm10(state_handle, ens_size, location, val, istatus)  
!------------------------------------------------------------------------
 type(ensemble_type), intent(in)  :: state_handle
 integer,             intent(in)  :: ens_size
 type(location_type), intent(in)  :: location
 real(r8),            intent(out) :: val(ens_size) ! (ug/m^3 dry air)
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
 logical                          :: return_now
!
! Forward operator for PM10.  The argument list to this routine
! must match the call in the GET_EXPECTED_OBS_FROM_DEF section above.
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
 real(r8) :: rho_d(ens_size)    ! density dry air
 real(r8) :: rho_m(ens_size)    ! density moist air
 real(r8) :: Rd                 ! gas constant dry air
 real(r8) :: Cp                 ! heat capacity dry air
 real(r8) :: Pa_to_torr         ! convert Pa to torr
!
 namelist /obs_def_AIRNOW_PM10_nml/ use_log_pm10
!
! Initialize DART
 if ( .not. module_initialized ) call initialize_module
!
! water vapor mixing ratio at this location - this calls the model_mod code.
 istatus(:)=0.
 qmr_istatus(:)=0.
 call interpolate(state_handle, ens_size, location, QTY_VAPOR_MIXING_RATIO, qvapor, qmr_istatus)
 call track_status(ens_size, qmr_istatus, qvapor, istatus, return_now)
 if(return_now) return
!
! sulfate at this location - this calls the model_mod code.
 istatus(:)=0.
 sulf_istatus(:)=0.
 call interpolate(state_handle, ens_size, location, QTY_SO4, sulf, sulf_istatus)
 call track_status(ens_size, sulf_istatus, sulf, istatus, return_now)
 if(return_now) return
!
! dust at this location - this calls the model_mod code.
 istatus(:)=0.
 dst1_istatus(:)=0.
 call interpolate(state_handle, ens_size, location, QTY_DST01, DUST1, dst1_istatus)
 call track_status(ens_size, dst1_istatus, DUST1, istatus, return_now)
 if(return_now) return
!
! dust at this location - this calls the model_mod code.
 istatus(:)=0.
 dst2_istatus(:)=0.
 call interpolate(state_handle, ens_size, location, QTY_DST02, DUST2, dst2_istatus)
 call track_status(ens_size, dst2_istatus, DUST2, istatus, return_now)
 if(return_now) return
!
! dust at this location - this calls the model_mod code.
 istatus(:)=0.
 dst3_istatus(:)=0.
 call interpolate(state_handle, ens_size, location, QTY_DST03, DUST3, dst3_istatus)
 call track_status(ens_size, dst3_istatus, DUST3, istatus, return_now)
 if(return_now) return
!
! dust at this location - this calls the model_mod code.
 istatus(:)=0.
 dst4_istatus(:)=0.
 call interpolate(state_handle, ens_size, location, QTY_DST04, DUST4, dst4_istatus)
 call track_status(ens_size, dst4_istatus, DUST4, istatus, return_now)
 if(return_now) return
!
! dust at this location - this calls the model_mod code.
 istatus(:)=0.
 dst5_istatus(:)=0.
 call interpolate(state_handle, ens_size, location, QTY_DST05, DUST5, dst5_istatus)
 call track_status(ens_size, dst5_istatus, DUST5, istatus, return_now)
 if(return_now) return
!
! hydrophilic black carbon at this location - this calls the model_mod code.
 istatus(:)=0.
 bc1_istatus(:)=0.
 call interpolate(state_handle, ens_size, location, QTY_BC1, BC1, bc1_istatus)
 call track_status(ens_size, bc1_istatus, BC1, istatus, return_now)
 if(return_now) return
!
! hydrophilic black carbon at this location - this calls the model_mod code.
 istatus(:)=0.
 bc2_istatus(:)=0.
 call interpolate(state_handle, ens_size, location, QTY_BC2, BC2, bc2_istatus)
 call track_status(ens_size, bc2_istatus, BC2, istatus, return_now)
 if(return_now) return
!
! hydrophilic organic carbon at this location - this calls the model_mod code.
 istatus(:)=0.
 oc1_istatus(:)=0.
 call interpolate(state_handle, ens_size, location, QTY_OC1, OC1, oc1_istatus)
 call track_status(ens_size, oc1_istatus, OC1, istatus, return_now)
 if(return_now) return
!
! hydrophilic organic carbon at this location - this calls the model_mod code.
 istatus(:)=0.
 oc2_istatus(:)=0.
 call interpolate(state_handle, ens_size, location, QTY_OC2, OC2, oc2_istatus)
 call track_status(ens_size, oc2_istatus, OC2, istatus, return_now)
 if(return_now) return
!
! sea salt at this location - this calls the model_mod code.
 istatus(:)=0.
 ss1_istatus(:)=0.
 call interpolate(state_handle, ens_size, location, QTY_SSLT01, SS1, ss1_istatus)
 call track_status(ens_size, ss1_istatus, SS1, istatus, return_now)
 if(return_now) return
!
! sea salt at this location - this calls the model_mod code.
 istatus(:)=0.
 ss2_istatus(:)=0.
 call interpolate(state_handle, ens_size, location, QTY_SSLT02, SS2, ss2_istatus)
 call track_status(ens_size, ss2_istatus, SS2, istatus, return_now)
 if(return_now) return
!
! sea salt at this location - this calls the model_mod code.
 istatus(:)=0.
 ss3_istatus(:)=0.
 call interpolate(state_handle, ens_size, location, QTY_SSLT03, SS3, ss3_istatus)
 call track_status(ens_size, ss3_istatus, SS3, istatus, return_now)
 if(return_now) return
!
! sea salt at this location - this calls the model_mod code.
 istatus(:)=0.
 ss4_istatus(:)=0.
 call interpolate(state_handle, ens_size, location, QTY_SSLT04, SS4, ss4_istatus)
 call track_status(ens_size, ss4_istatus, SS4, istatus, return_now)
 if(return_now) return
!
! perturbation theta at this location - this calls the model_mod code.
 istatus(:)=0.
 tmp_istatus(:)=0.
 call interpolate(state_handle, ens_size, location, QTY_POTENTIAL_TEMPERATURE, Theta, tmp_istatus)
 call track_status(ens_size, tmp_istatus, Theta, istatus, return_now)
 if(return_now) return
!
! perturbation pressure at this location - this calls the model_mod code.
 istatus(:)=0.
 prs_istatus(:)=0.
 call interpolate(state_handle, ens_size, location, QTY_PRESSURE, P, prs_istatus)
 call track_status(ens_size, prs_istatus, P, istatus, return_now)
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
 Rd = 287.05
 Cp = 1006.0
 T = Theta / (100000./P)**(Rd/Cp)
 Tv = Theta / (100000./P)**(Rd/Cp) * qvapor/(1.+qvapor)
 rho_d = P/(Rd*T)
 rho_m = P/(Rd*Tv)
 Pa_to_torr = 133.322
 val(:) = 0.
!
! Expected pm10 (ug/kg)
 if (use_log_pm10) then
    val = (exp(p25) + 1.375*exp(sulf) + exp(BC1) + exp(BC2) + 1.8*(exp(OC1)+exp(OC2)) + &
    exp(DUST1) + exp(DUST2) + exp(DUST3) + .87*exp(DUST4) + exp(SS1) + exp(SS2) +exp(SS3))
 else
    val = (p25 + 1.375*sulf + BC1 + BC2 + 1.8*(OC1+OC2) + &
    DUST1 + DUST2 + DUST3 + .87*DUST4 + SS1 + SS2 +SS3)
 endif
!
! Expected pm10 (ug/m^3) (LC)
 val = val*rho_d
!
! Expected pm10 (STP) Should be this
 val = val * T/298.15 * 760./P*Pa_to_torr

 istatus(:) = 0
    
end subroutine get_expected_airnow_pm10

!------------------------------------------------------------------------

end module obs_def_AIRNOW_PM10_mod
! END DART PREPROCESS MODULE CODE

