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
! IASI_O3_RETRIEVAL, QTY_O3
! END DART PREPROCESS KIND LIST
!
! BEGIN DART PREPROCESS USE OF SPECIAL OBS_DEF MODULE
!   use obs_def_iasi_O3_mod, only : write_iasi_o3, read_iasi_o3, &
!                                  interactive_iasi_o3, get_expected_iasi_o3, &
!                                  set_obs_def_iasi_o3
! END DART PREPROCESS USE OF SPECIAL OBS_DEF MODULE
!
! BEGIN DART PREPROCESS GET_EXPECTED_OBS_FROM_DEF
!         case(IASI_O3_RETRIEVAL)                                                           
!            call get_expected_iasi_o3(state_handle, ens_size, location, obs_def%key, expected_obs, istatus)  
! END DART PREPROCESS GET_EXPECTED_OBS_FROM_DEF
!
! BEGIN DART PREPROCESS READ_OBS_DEF
!      case(IASI_O3_RETRIEVAL)
!         call read_iasi_o3(obs_def%key, ifile, fileformat)
! END DART PREPROCESS READ_OBS_DEF
!
! BEGIN DART PREPROCESS WRITE_OBS_DEF
!      case(IASI_O3_RETRIEVAL)
!         call write_iasi_o3(obs_def%key, ifile, fileformat)
! END DART PREPROCESS WRITE_OBS_DEF
!
! BEGIN DART PREPROCESS INTERACTIVE_OBS_DEF
!      case(IASI_O3_RETRIEVAL)
!         call interactive_iasi_o3(obs_def%key)
! END DART PREPROCESS INTERACTIVE_OBS_DEF
!
! BEGIN DART PREPROCESS SET_OBS_DEF_IASI_O3
!      case(IASI_O3_RETRIEVAL)
!         call set_obs_def_iasi_o3(obs_def%key)
! END DART PREPROCESS SET_OBS_DEF_IASI_O3
!
! BEGIN DART PREPROCESS MODULE CODE

module obs_def_iasi_O3_mod

use         apm_upper_bdy_mod, only :get_upper_bdy_fld, &
                                     get_MOZART_INT_DATA, &
                                     get_MOZART_REAL_DATA, &
                                     wrf_dart_ubval_interp, &
                                     apm_get_exo_coldens, &
                                     apm_get_upvals, &
                                     apm_interpolate
use types_mod,only          : r8
use utilities_mod,only      : register_module, error_handler, E_ERR, E_MSG, &
                             nmlfileunit, check_namelist_read, &
                             find_namelist_in_file, do_nml_file, do_nml_term, &
                             ascii_file_format, &
                             read_int_scalar, &
                             write_int_scalar, &       
                             read_r8_scalar, &
                             write_r8_scalar, &
                             read_r8_array, &
                             write_r8_array
                             
use location_mod,only       : location_type, set_location, get_location, VERTISHEIGHT,&
                              VERTISPRESSURE, VERTISLEVEL, VERTISSURFACE
use assim_model_mod,only    : interpolate
use obs_kind_mod,only       : QTY_O3, QTY_SURFACE_PRESSURE, QTY_PRESSURE
use mpi_utilities_mod,only  : my_task_id  
use obs_def_utilities_mod, only : track_status

implicit none 
private

public :: write_iasi_o3,        &
          read_iasi_o3,         &
          interactive_iasi_o3,  &
          get_expected_iasi_o3, &
          set_obs_def_iasi_o3
!
! Storage for the special information required for observations of this type
integer, parameter          :: MAX_IASI_O3_OBS = 6000000
integer, parameter          :: IASI_DIM = 41
integer                     :: num_iasi_o3_obs = 0

real(r8), allocatable, dimension(:,:)  :: avg_kernel
real(r8), allocatable, dimension(:,:)  :: pressure
real(r8), allocatable, dimension(:)    :: iasi_prior_trm
real(r8), allocatable, dimension(:)    :: iasi_psurf
real(r8), allocatable, dimension(:,:)  :: iasi_altitude
real(r8), allocatable, dimension(:,:)  :: iasi_air_column
real(r8), allocatable, dimension(:,:)  :: iasi_prior
integer, allocatable, dimension(:)     :: iasi_nlevels
!
! nominal iasi height levels in m
real(r8)                    :: iasi_altitude_ref(IASI_DIM) =(/ &
                               0.,1000.,2000.,3000.,4000., &
                               5000.,6000.,7000.,8000.,9000., &
                               10000.,11000.,12000.,13000.,14000., &
                               15000.,16000.,17000.,18000.,19000., &
                               20000.,21000.,22000.,23000.,24000., &
                               25000.,26000.,27000.,28000.,29000., &
                               30000.,31000.,32000.,33000.,34000., &
                               35000.,36000.,37000.,38000.,39000., &
                               40000. /) 
!
! version controlled file description for error handling, do not edit
character(len=*), parameter :: source   = 'obs_def_IASI_O3_partition_mod.f90'
character(len=*), parameter :: revision = ''
character(len=*), parameter :: revdate  = ''

character(len=512) :: string1, string2

logical, save       :: module_initialized = .false.
integer             :: counts1 = 0

character(len=129)  :: IASI_O3_retrieval_type
logical             :: use_log_o3 =.false.
!
! IASI_O3_retrieval_type:
!     RAWR - retrievals in VMR (ppb) units
!     QOR  - quasi-optimal retrievals
!     CPSR - compact phase space retrievals
namelist /obs_def_IASI_O3_nml/ IASI_O3_retrieval_type, use_log_o3

contains

!----------------------------------------------------------------------

subroutine initialize_module

integer :: iunit, rc

! Prevent multiple calls from executing this code more than once.
if (module_initialized) return

call register_module(source, revision, revdate)
module_initialized = .true.

allocate(avg_kernel(     MAX_IASI_O3_OBS,IASI_DIM))
allocate(pressure(       MAX_IASI_O3_OBS,IASI_DIM))
allocate(iasi_prior_trm( MAX_IASI_O3_OBS))
allocate(iasi_psurf(     MAX_IASI_O3_OBS))
allocate(iasi_altitude(  MAX_IASI_O3_OBS,IASI_DIM))
allocate(iasi_air_column(MAX_IASI_O3_OBS,IASI_DIM))
allocate(iasi_prior     (MAX_IASI_O3_OBS,IASI_DIM))
allocate(iasi_nlevels(   MAX_IASI_O3_OBS))

! Read the namelist entry.
IASI_O3_retrieval_type='RAWR'
use_log_o3=.false.
call find_namelist_in_file("input.nml", "obs_def_IASI_O3_nml", iunit)
read(iunit, nml = obs_def_IASI_O3_nml, iostat = rc)
call check_namelist_read(iunit, rc, "obs_def_IASI_O3_nml")

! Record the namelist values used for the run ... 
if (do_nml_file()) write(nmlfileunit, nml=obs_def_IASI_O3_nml)
if (do_nml_term()) write(     *     , nml=obs_def_IASI_O3_nml)

end subroutine initialize_module

!----------------------------------------------------------------------
!>

subroutine read_iasi_o3(key, ifile, fform)

integer,                    intent(out) :: key
integer,                    intent(in)  :: ifile
character(len=*), optional, intent(in)  :: fform

character(len=32)               :: fileformat
integer                         :: iasi_nlevels_1
real(r8)                        :: iasi_prior_trm_1
real(r8)                        :: iasi_psurf_1
real(r8),  dimension(IASI_DIM)  :: iasi_altitude_1
real(r8),  dimension(IASI_DIM)  :: iasi_air_column_1
real(r8),  dimension(IASI_DIM)  :: iasi_prior_1
real(r8),  dimension(IASI_DIM)  :: avg_kernel_1
real(r8),  dimension(IASI_DIM)  :: pressure_1
integer                         :: keyin

if ( .not. module_initialized ) call initialize_module

fileformat = "ascii"   ! supply default
if(present(fform)) fileformat = trim(adjustl(fform))
!
! Philosophy, read ALL information about this special obs_type at once???
! For now, this means you can only read ONCE (that's all we're doing 3 June 05)
! Toggle the flag to control this reading
!
iasi_altitude_1(:) = 0.0_r8
iasi_air_column_1(:) = 0.0_r8
iasi_prior_1(:) = 0.0_r8
avg_kernel_1(:) = 0.0_r8
pressure_1(:) = 0.0_r8

SELECT CASE (fileformat)
   CASE ("unf", "UNF", "unformatted", "UNFORMATTED")
   iasi_nlevels_1 = read_iasi_nlevels(ifile, fileformat)
   iasi_prior_trm_1  = read_iasi_prior_trm(ifile, fileformat)
   iasi_psurf_1  = read_iasi_psurf(ifile, fileformat)
   iasi_altitude_1 = read_iasi_altitude(ifile, iasi_nlevels_1, fileformat)
   iasi_air_column_1  = read_iasi_air_column(ifile, iasi_nlevels_1, fileformat)
   iasi_prior_1  = read_iasi_prior(ifile, iasi_nlevels_1, fileformat)
   avg_kernel_1 = read_iasi_avg_kernel(ifile, iasi_nlevels_1, fileformat) 
   pressure_1 = read_iasi_pressure(ifile, iasi_nlevels_1, fileformat)
   read(ifile) keyin
   CASE DEFAULT
   iasi_nlevels_1 = read_iasi_nlevels(ifile, fileformat)
   iasi_prior_trm_1  = read_iasi_prior_trm(ifile, fileformat)
   iasi_psurf_1  = read_iasi_psurf(ifile, fileformat)
   iasi_altitude_1 = read_iasi_altitude(ifile, iasi_nlevels_1, fileformat)
   iasi_air_column_1  = read_iasi_air_column(ifile, iasi_nlevels_1, fileformat)
   iasi_prior_1  = read_iasi_prior(ifile, iasi_nlevels_1, fileformat)
   avg_kernel_1 = read_iasi_avg_kernel(ifile, iasi_nlevels_1, fileformat) 
   pressure_1 = read_iasi_pressure(ifile, iasi_nlevels_1, fileformat)
   read(ifile, *) keyin
END SELECT
counts1 = counts1 + 1
key = counts1
call set_obs_def_iasi_o3(key, avg_kernel_1, pressure_1, iasi_prior_trm_1, &
   iasi_psurf_1, iasi_altitude_1, iasi_air_column_1, iasi_prior_1, iasi_nlevels_1)

end subroutine read_iasi_o3

!----------------------------------------------------------------------

subroutine write_iasi_o3(key, ifile, fform)

integer,          intent(in)           :: key
integer,          intent(in)           :: ifile
character(len=*), intent(in), optional :: fform

real(r8),  dimension(IASI_DIM)  :: altitude_temp
real(r8),  dimension(IASI_DIM)  :: air_column_temp
real(r8),  dimension(IASI_DIM)  :: prior_temp
real(r8),  dimension(IASI_DIM)  :: avg_kernel_temp
real(r8),  dimension(IASI_DIM)  :: pressure_temp

character(len=32)               :: fileformat
if ( .not. module_initialized ) call initialize_module
fileformat = "ascii"   ! supply default
if(present(fform)) fileformat = trim(adjustl(fform))
!
! Philosophy, read ALL information about this special obs_type at once???
! For now, this means you can only read ONCE (that's all we're doing 3 June 05)
! Toggle the flag to control this reading
!
altitude_temp=iasi_altitude(key,:)
air_column_temp=iasi_air_column(key,:)
prior_temp=iasi_prior(key,:)
avg_kernel_temp=avg_kernel(key,:)
pressure_temp=pressure(key,:)
!
SELECT CASE (fileformat)
   CASE ("unf", "UNF", "unformatted", "UNFORMATTED")
   call write_iasi_nlevels(ifile, iasi_nlevels(key), fileformat)
   call write_iasi_prior_trm(ifile, iasi_prior_trm(key), fileformat)
   call write_iasi_psurf(ifile, iasi_psurf(key), fileformat)
   call write_iasi_altitude(ifile, altitude_temp, iasi_nlevels(key), fileformat)
   call write_iasi_air_column(ifile, air_column_temp, iasi_nlevels(key), fileformat)
   call write_iasi_prior(ifile, prior_temp, iasi_nlevels(key), fileformat)
   call write_iasi_avg_kernel(ifile, avg_kernel_temp, iasi_nlevels(key), fileformat)
   call write_iasi_pressure(ifile, pressure_temp, iasi_nlevels(key), fileformat)
   write(ifile) key
   CASE DEFAULT
   call write_iasi_nlevels(ifile, iasi_nlevels(key), fileformat)
   call write_iasi_prior_trm(ifile, iasi_prior_trm(key), fileformat)
   call write_iasi_psurf(ifile, iasi_psurf(key), fileformat)
   call write_iasi_altitude(ifile, altitude_temp, iasi_nlevels(key), fileformat)
   call write_iasi_air_column(ifile, air_column_temp, iasi_nlevels(key), fileformat)
   call write_iasi_prior(ifile, prior_temp, iasi_nlevels(key), fileformat)
   call write_iasi_avg_kernel(ifile, avg_kernel_temp, iasi_nlevels(key), fileformat)
   call write_iasi_pressure(ifile, pressure_temp, iasi_nlevels(key), fileformat)
   write(ifile, *) key
END SELECT 
end subroutine write_iasi_o3
!
subroutine interactive_iasi_o3(key)
!----------------------------------------------------------------------
! subroutine interactive_iasi_o3(key)
!
! Initializes the specialized part of a IASI observation
! Passes back up the key for this one
!
integer, intent(out) :: key
!
if ( .not. module_initialized ) call initialize_module
!
! Make sure there's enough space, if not die for now (clean later)
if(num_iasi_o3_obs >= MAX_IASI_O3_OBS) then
   write(string1, *)'Not enough space for a iasi O3 obs.'
   write(string2, *)'Can only have MAX_IASI_O3_OBS (currently ',MAX_IASI_O3_OBS,')'
   call error_handler(E_ERR,'interactive_iasi_o3',string1,source,revision,revdate,text2=string2)
endif
!
! Increment the index
num_iasi_o3_obs = num_iasi_o3_obs + 1
key = num_iasi_o3_obs
!
! Otherwise, prompt for input for the three required beasts
write(*, *) 'Creating an interactive_iasi_o3 observation'
write(*, *) 'Input the IASI nlevels '
read(*, *) iasi_nlevels
write(*, *) 'Input the IASI O3 Prior Term ' 
read(*, *) iasi_prior_trm
write(*, *) 'Input the IASI O3 Surface Pressure '
read(*, *) iasi_psurf
write(*, *) 'Input IASI O3 41 Altitudes '
read(*, *) iasi_altitude(num_iasi_o3_obs,:)
write(*, *) 'Input IASI O3 41 Air Columns '
read(*, *) iasi_air_column(num_iasi_o3_obs,:)
write(*, *) 'Input IASI O3 41 Priors '
read(*, *) iasi_prior(num_iasi_o3_obs,:)
write(*, *) 'Input IASI O3 41 Averaging Kernel '
read(*, *) avg_kernel(num_iasi_o3_obs,:)
write(*, *) 'Input IASI O3 41 Pressure '
read(*, *) pressure(num_iasi_o3_obs,:)
end subroutine interactive_iasi_o3
!
!----------------------------------------------------------------------
subroutine get_expected_iasi_o3(state_handle, ens_size, location, key, val, istatus)

   type(ensemble_type), intent(in)  :: state_handle
   integer,             intent(in)  :: ens_size
   type(location_type), intent(in)  :: location
   integer,             intent(in)  :: key
   real(r8),            intent(out) :: val(ens_size)
   integer,             intent(out) :: istatus(ens_size)
!
   integer, parameter  :: wrf_nlev=32
   integer             :: i, kstr, ilev, istrat
   integer             :: apm_dom, apm_mm
   type(location_type) :: loc2
   real(r8)            :: mloc(3), prs_wrf(wrf_nlev)
   real(r8)            :: obs_val(ens_size), obs_val_fnl(ens_size), o3_min, o3_min_str
   real(r8)            :: o3_min_log, level, missing
   real(r8)            :: o3_wrf_sfc(ens_size), o3_wrf_1(ens_size), o3_wrf_top(ens_size)
   real(r8)            :: prs_wrf_sfc(ens_size), prs_wrf_1(ens_size), prs_wrf_nlev(ens_size)
   real(r8)            :: prs_iasi_sfc
     
   real(r8)            :: ylon, ylat, ubv_obs_val, ubv_delt_prs
   real(r8)            :: prs_top, prs_bot, wt_dw, wt_up
   real(r8)            :: term, prior_term
   integer             :: nlevels
   character(len=130)  :: apm_spec

   real(r8)            :: vert_mode_filt
   logical :: return_now
   integer :: sfcp_istatus(ens_size)
   integer :: plev1_istatus(ens_size)
   integer :: ptop_istatus(ens_size)
   integer :: o31_istatus(ens_size)
   integer :: o3top_istatus(ens_size)
!
! Initialize DART
   if ( .not. module_initialized ) call initialize_module
! 
! Initialize variables
   prs_bot=200.*1.e2
   o3_min      = 0.004 * 1.e-3
   o3_min_log  = log10(o3_min)
   o3_min_str  = 0.00414 * 1.e-3
   missing     = -888888.0_r8
   nlevels     = iasi_nlevels(key)    
   if ( use_log_o3 ) then
      o3_min=o3_min_log
      o3_min_str=log10(o3_min_str)
   endif
!
! Get location information
   mloc=get_location(location)
   if (mloc(2) .gt. 90.0_r8) then
      mloc(2)=90.0_r8
   elseif (mloc(2) .lt. -90.0_r8) then
      mloc(2)=-90.0_r8
   endif
!
! IASI surface pressure
   prs_iasi_sfc=iasi_psurf(key)
!
! WRF surface pressure
   istatus(:)=0
   level=0.0_r8
   loc2 = set_location(mloc(1), mloc(2), level, VERTISSURFACE)
   call interpolate(state_handle, ens_size, loc2, QTY_SURFACE_PRESSURE, prs_wrf_sfc, sfcp_istatus)
   call track_status(ens_size, sfcp_istatus, prs_wrf_sfc, istatus, return_now)
   if(return_now) return

!
! WRF pressure first level
   istatus(:)=0
   level=real(1)
   loc2 = set_location(mloc(1), mloc(2), level, VERTISLEVEL)
   call interpolate(state_handle, ens_size, loc2, QTY_PRESSURE, prs_wrf_1, plev1_istatus)
   call track_status(ens_size, plev1_istatus, prs_wrf_1, istatus, return_now)
   if(return_now) return

!
! WRF pressure top level
   istatus(:)=0
   level=real(wrf_nlev)
   loc2 = set_location(mloc(1), mloc(2), level, VERTISLEVEL)
   call interpolate(state_handle, ens_size, loc2, QTY_PRESSURE, prs_wrf_nlev, ptop_istatus)
   call track_status(ens_size, ptop_istatus, prs_wrf_nlev, istatus, return_now)
   prs_top=prs_wrf_nlev
   if(return_now) return
!
! WRF ozone at surface
!   istatus = 0
!   loc2 = set_location(mloc(1), mloc(2), prs_wrf_sfc, VERTISSURFACE)
!   call interpolate(state, loc2, KIND_O3, o3_wrf_sfc, istatus) 
!   if(istatus/=0) then
!      write(string1, *)'APM NOTICE: WRF o3 at surface is bad ',istatus
!      call error_handler(E_MSG,'set_obs_def_iasi_o3',string1,source,revision,revdate)
!      stop
!   endif              
!
! WRF ozone at first level
   istatus(:) = 0
   loc2 = set_location(mloc(1), mloc(2), prs_wrf_1, VERTISPRESSURE)
   call interpolate(state_handle, ens_size, loc2, QTY_O3, o3_wrf_1, o31_istatus)
   call track_status(ens_size, o31_istatus, o3_wrf_1, istatus, return_now)
   if(return_now) return
!
! WRF ozone at top
   istatus(:) = 0
   loc2 = set_location(mloc(1), mloc(2), prs_wrf_nlev, VERTISPRESSURE)
   call interpolate(state_handle, ens_size, loc2, QTY_O3, o3_wrf_top, o3top_istatus)
   call track_status(ens_size, o3top_istatus, o3_wrf_top, istatus, return_now)
   if(return_now) return
!
! Apply IASI Averaging kernel A and IASI Prior (I-A)xa
! x = Axm + (I-A)xa , where x is a 41-element vector !
!
! loop through IASI levels
   val = 0.0_r8
   do ilev = 1, nlevels
!
! get location of obs
      istrat=0
!
! point at model surface
!      if(pressure(key,ilev).ge.prs_wrf_sfc) then
!         obs_val=o3_wrf_sfc
!      endif
! point between surface and first level
      where ( prs_wrf_1 <= pressure(key,ilev) )
         obs_val=o3_wrf_1
      endwhere
     !if(pressure(key,ilev).ge.prs_wrf_1) then
     !   obs_val=o3_wrf_1
     !endif
!
! point in model interior      
      where ( prs_wrf_1 > pressure(key,ilev) .and. prs_wrf_nlev <= pressure(key,ilev))
         istatus(:) = 0
         loc2 = set_location(mloc(1),mloc(2), pressure(key,ilev), VERTISPRESSURE)
         call interpolate(state_handle, ens_size, loc2, QTY_O3, obs_val, istatus)
         if(any(istatus.ne.0)) then
            write(string1, *)'ilev obs_val,ias_pr ',ilev,obs_val,pressure(key,ilev)/100.
            call error_handler(E_MSG,'set_obs_def_iasi_o3',string1,source,revision,revdate)
            write(string1, *)'key, ilev ',key,ilev,pressure(key,ilev),prs_wrf_1
            call error_handler(E_MSG,'set_obs_def_iasi_o3',string1,source,revision,revdate)
            stop
         endif
       endwhere

!     if(pressure(key,ilev).lt.prs_wrf_1 .and. pressure(key,ilev).ge.prs_wrf_nlev) then
!        istatus = 0
 !       loc2 = set_location(mloc(1),mloc(2), pressure(key,ilev), VERTISPRESSURE)
 !       call interpolate(state, loc2, KIND_O3, obs_val, istatus) 
 !       if(istatus.ne.0) then
 !          write(string1, *)'ilev obs_val,ias_pr ',ilev,obs_val,pressure(key,ilev)/100.
 !          call error_handler(E_MSG,'set_obs_def_iasi_o3',string1,source,revision,revdate)
 !          write(string1, *)'key, ilev ',key,ilev,pressure(key,ilev),prs_wrf_1
 !          call error_handler(E_MSG,'set_obs_def_iasi_o3',string1,source,revision,revdate)
 !          stop
 !       endif      
 !    endif
!
! point above model top
      where ( prs_wrf_nlev > pressure(key,ilev) )
         istrat=1
         obs_val=iasi_prior(key,ilev)
      endwhere
     !if(pressure(key,ilev).lt.prs_wrf_nlev) then
     !   istrat=1
     !   obs_val=iasi_prior(key,ilev)
     !endif
!
! scale to ppb
      if (istrat.eq.0) then
         if ( use_log_o3 ) then
            obs_val=obs_val + 3.0
         else
            obs_val = obs_val * 1.e3
         endif
      endif
!
! blend upper tropospnere with the prior (WRF O3 biased relative to IASI).
      obs_val_fnl=obs_val
      where ( prs_bot >= pressure(key,ilev) .and. prs_top <= pressure(key,ilev) )
     !if(pressure(key,ilev).le.prs_bot .and. pressure(key,ilev).ge.prs_top) then
         wt_dw=pressure(key,ilev)-prs_top
         wt_up=prs_bot-pressure(key,ilev)
         obs_val_fnl=(wt_dw*obs_val + wt_up*iasi_prior(key,ilev))/(wt_dw+wt_up)
     !endif
      endwhere
     where (prs_top > pressure(key,ilev) )
         obs_val_fnl=iasi_prior(key,ilev)
     endwhere
     !if(pressure(key,ilev).lt.prs_top) then 
     !   obs_val_fnl=iasi_prior(key,ilev)
     !endif
!
! apply averaging kernel
      if( use_log_o3 ) then
         val = val + avg_kernel(key,ilev) * 10.**obs_val_fnl
      else
         val = val + avg_kernel(key,ilev) * obs_val_fnl
      endif
   enddo
!
   val = val + iasi_prior_trm(key)
   if( use_log_o3 ) then
      val=log10(val)
   endif
end subroutine get_expected_iasi_o3

!----------------------------------------------------------------------

subroutine set_obs_def_iasi_o3(key, o3_avgker, o3_press, o3_prior_trm, o3_psurf, o3_altitude, &
   o3_air_column, o3_prior, o3_nlevels)

!> Allows passing of obs_def special information 


integer,                 intent(in) :: key
integer,                 intent(in) :: o3_nlevels
real(r8), dimension(41), intent(in) :: o3_avgker
real(r8), dimension(41), intent(in) :: o3_press
real(r8),                intent(in) :: o3_prior_trm
real(r8),                intent(in) :: o3_psurf
real(r8), dimension(41), intent(in) :: o3_altitude
real(r8), dimension(41), intent(in) :: o3_air_column
real(r8), dimension(41), intent(in) :: o3_prior

if ( .not. module_initialized ) call initialize_module

! Check for sufficient space
if(num_iasi_o3_obs >= MAX_IASI_O3_OBS) then
   write(string1, *)'Not enough space for a iasi O3 obs.'
   write(string2, *)'Can only have MAX_IASI_O3_OBS (currently ',MAX_IASI_O3_OBS,')'
   call error_handler(E_ERR,'set_obs_def_iasi_o3',string1,source,revision,revdate,text2=string2)
endif

avg_kernel(key,:)         = o3_avgker(:)
pressure(key,:)           = o3_press(:)
iasi_prior_trm(key)       = o3_prior_trm
iasi_psurf(key)           = o3_psurf
iasi_altitude(key,:)      = o3_altitude(:)
iasi_air_column(key,:)    = o3_air_column(:)
iasi_prior(key,:)         = o3_prior(:)
iasi_nlevels(key)         = o3_nlevels

end subroutine set_obs_def_iasi_o3

!=================================
! other functions and subroutines
!=================================
!
function read_iasi_prior_trm(ifile, fform)
integer,          intent(in)           :: ifile
character(len=*), intent(in), optional :: fform
real(r8)                               :: read_iasi_prior_trm
!
character(len=32)  :: fileformat
!
if ( .not. module_initialized ) call initialize_module
!
fileformat = "ascii"    ! supply default
if(present(fform)) fileformat = trim(adjustl(fform))
!
SELECT CASE (fileformat)
   CASE("unf", "UNF", "unformatted", "UNFORMATTED")
   read(ifile) read_iasi_prior_trm
   CASE DEFAULT
   read(ifile, *) read_iasi_prior_trm
END SELECT
end function read_iasi_prior_trm
!
subroutine write_iasi_prior_trm(ifile, iasi_prior_trm_temp, fform)
integer,          intent(in) :: ifile
real(r8),         intent(in) :: iasi_prior_trm_temp
character(len=*), intent(in) :: fform
!
character(len=32)  :: fileformat
!
if ( .not. module_initialized ) call initialize_module
!
fileformat = trim(adjustl(fform))
SELECT CASE (fileformat)
   CASE("unf", "UNF", "unformatted", "UNFORMATTED")
   write(ifile) iasi_prior_trm_temp
   CASE DEFAULT
   write(ifile, *) iasi_prior_trm_temp
END SELECT
end subroutine write_iasi_prior_trm
!
function read_iasi_psurf(ifile, fform)
integer,          intent(in)           :: ifile
character(len=*), intent(in), optional :: fform
real(r8)                               :: read_iasi_psurf
!
character(len=32)  :: fileformat
!
if ( .not. module_initialized ) call initialize_module
!
fileformat = "ascii"    ! supply default
if(present(fform)) fileformat = trim(adjustl(fform))
!
SELECT CASE (fileformat)
   CASE("unf", "UNF", "unformatted", "UNFORMATTED")
   read(ifile) read_iasi_psurf
   CASE DEFAULT
   read(ifile, *) read_iasi_psurf
END SELECT
end function read_iasi_psurf
!
subroutine write_iasi_psurf(ifile, iasi_psurf_temp, fform)
integer,          intent(in) :: ifile
real(r8),         intent(in) :: iasi_psurf_temp
character(len=*), intent(in) :: fform
!
character(len=32)  :: fileformat
!
if ( .not. module_initialized ) call initialize_module
!
fileformat = trim(adjustl(fform))
SELECT CASE (fileformat)
   CASE("unf", "UNF", "unformatted", "UNFORMATTED")
   write(ifile) iasi_psurf_temp
   CASE DEFAULT
   write(ifile, *) iasi_psurf_temp
END SELECT
end subroutine write_iasi_psurf
!
function read_iasi_nlevels(ifile, fform)
integer,          intent(in)           :: ifile
character(len=*), intent(in), optional :: fform
integer                                :: read_iasi_nlevels
!
character(len=32)  :: fileformat
!
if ( .not. module_initialized ) call initialize_module
!
fileformat = "ascii"    ! supply default
if(present(fform)) fileformat = trim(adjustl(fform))
!
SELECT CASE (fileformat)
   CASE("unf", "UNF", "unformatted", "UNFORMATTED")
   read(ifile) read_iasi_nlevels
   CASE DEFAULT
   read(ifile, *) read_iasi_nlevels
END SELECT
end function read_iasi_nlevels
!
subroutine write_iasi_nlevels(ifile, iasi_nlevels_temp, fform)
integer,          intent(in) :: ifile
integer,          intent(in) :: iasi_nlevels_temp
character(len=*), intent(in) :: fform
!
character(len=32)  :: fileformat
!
if ( .not. module_initialized ) call initialize_module
!
fileformat = trim(adjustl(fform))
SELECT CASE (fileformat)
   CASE("unf", "UNF", "unformatted", "UNFORMATTED")
   write(ifile) iasi_nlevels_temp
   CASE DEFAULT
   write(ifile, *) iasi_nlevels_temp
END SELECT
end subroutine write_iasi_nlevels
!
function read_iasi_avg_kernel(ifile, nlevels, fform)
integer,          intent(in)           :: ifile, nlevels
character(len=*), intent(in), optional :: fform
real(r8), dimension(41)                :: read_iasi_avg_kernel
!
character(len=32)  :: fileformat
read_iasi_avg_kernel(:) = 0.0_r8
!
if ( .not. module_initialized ) call initialize_module
!
fileformat = "ascii"    ! supply default
if(present(fform)) fileformat = trim(adjustl(fform))
SELECT CASE (fileformat)
   CASE("unf", "UNF", "unformatted", "UNFORMATTED")
   read(ifile) read_iasi_avg_kernel(1:nlevels)
   CASE DEFAULT
   read(ifile, *) read_iasi_avg_kernel(1:nlevels)
END SELECT
end function read_iasi_avg_kernel
!
function read_iasi_altitude(ifile, nlevels, fform)
integer,          intent(in)           :: ifile, nlevels
character(len=*), intent(in), optional :: fform
real(r8), dimension(41)                :: read_iasi_altitude
!
character(len=32)  :: fileformat
read_iasi_altitude(:) = 0.0_r8
!
if ( .not. module_initialized ) call initialize_module
!
fileformat = "ascii"    ! supply default
if(present(fform)) fileformat = trim(adjustl(fform))
SELECT CASE (fileformat)
   CASE("unf", "UNF", "unformatted", "UNFORMATTED")
   read(ifile) read_iasi_altitude(1:nlevels)
   CASE DEFAULT
   read(ifile, *) read_iasi_altitude(1:nlevels)
END SELECT
end function read_iasi_altitude
!
function read_iasi_pressure(ifile, nlevels, fform)
integer,          intent(in)           :: ifile, nlevels
character(len=*), intent(in), optional :: fform
real(r8), dimension(41)                :: read_iasi_pressure
!
character(len=32)  :: fileformat
read_iasi_pressure(:) = 0.0_r8
!
if ( .not. module_initialized ) call initialize_module
!
fileformat = "ascii"    ! supply default
if(present(fform)) fileformat = trim(adjustl(fform))
SELECT CASE (fileformat)
   CASE("unf", "UNF", "unformatted", "UNFORMATTED")
   read(ifile) read_iasi_pressure(1:nlevels)
   CASE DEFAULT
   read(ifile, *) read_iasi_pressure(1:nlevels)
END SELECT
end function read_iasi_pressure
!
function read_iasi_air_column(ifile, nlevels, fform)
integer,          intent(in)           :: ifile, nlevels
character(len=*), intent(in), optional :: fform
real(r8), dimension(41)                :: read_iasi_air_column
!
character(len=32)  :: fileformat
read_iasi_air_column(:) = 0.0_r8
!
if ( .not. module_initialized ) call initialize_module
!
fileformat = "ascii"    ! supply default
if(present(fform)) fileformat = trim(adjustl(fform))
SELECT CASE (fileformat)
   CASE("unf", "UNF", "unformatted", "UNFORMATTED")
   read(ifile) read_iasi_air_column(1:nlevels)
   CASE DEFAULT
   read(ifile, *) read_iasi_air_column(1:nlevels)
END SELECT 
end function read_iasi_air_column
!
function read_iasi_prior(ifile, nlevels, fform)
integer,          intent(in)           :: ifile, nlevels
character(len=*), intent(in), optional :: fform
real(r8), dimension(41)                :: read_iasi_prior
!
character(len=32)  :: fileformat
read_iasi_prior(:) = 0.0_r8
!
if ( .not. module_initialized ) call initialize_module
!
fileformat = "ascii"    ! supply default
if(present(fform)) fileformat = trim(adjustl(fform))
SELECT CASE (fileformat)
   CASE("unf", "UNF", "unformatted", "UNFORMATTED")
   read(ifile) read_iasi_prior(1:nlevels)
   CASE DEFAULT
   read(ifile, *) read_iasi_prior(1:nlevels)
END SELECT 
end function read_iasi_prior
!
subroutine write_iasi_avg_kernel(ifile, avg_kernel_temp, nlevels_temp, fform)
integer,                 intent(in) :: ifile, nlevels_temp
real(r8), dimension(41), intent(in) :: avg_kernel_temp
character(len=*),        intent(in) :: fform
!
character(len=32)  :: fileformat
!
if ( .not. module_initialized ) call initialize_module
!
fileformat = trim(adjustl(fform))
SELECT CASE (fileformat)
   CASE("unf", "UNF", "unformatted", "UNFORMATTED")
   write(ifile) avg_kernel_temp(1:nlevels_temp)
   CASE DEFAULT
   write(ifile, *) avg_kernel_temp(1:nlevels_temp)
END SELECT
end subroutine write_iasi_avg_kernel
!
subroutine write_iasi_altitude(ifile, altitude_temp, nlevels_temp, fform)
integer,                 intent(in) :: ifile, nlevels_temp
real(r8), dimension(41), intent(in) :: altitude_temp
character(len=*),        intent(in) :: fform
!
character(len=32)  :: fileformat
!
if ( .not. module_initialized ) call initialize_module
!
fileformat = trim(adjustl(fform))
SELECT CASE (fileformat)
   CASE("unf", "UNF", "unformatted", "UNFORMATTED")
   write(ifile) altitude_temp(1:nlevels_temp)
   CASE DEFAULT
   write(ifile, *) altitude_temp(1:nlevels_temp)
END SELECT
end subroutine write_iasi_altitude
!
subroutine write_iasi_pressure(ifile, pressure_temp, nlevels_temp, fform)
integer,                 intent(in) :: ifile, nlevels_temp
real(r8), dimension(41), intent(in) :: pressure_temp
character(len=*),        intent(in) :: fform
!
character(len=32)  :: fileformat
!
if ( .not. module_initialized ) call initialize_module
!
fileformat = trim(adjustl(fform))
SELECT CASE (fileformat)
   CASE("unf", "UNF", "unformatted", "UNFORMATTED")
   write(ifile) pressure_temp(1:nlevels_temp)
   CASE DEFAULT
   write(ifile, *) pressure_temp(1:nlevels_temp)
END SELECT
end subroutine write_iasi_pressure
!
subroutine write_iasi_air_column(ifile, air_column_temp, nlevels_temp, fform)
integer,                 intent(in) :: ifile, nlevels_temp
real(r8), dimension(41), intent(in) :: air_column_temp
character(len=*),        intent(in) :: fform
!
character(len=32)  :: fileformat
!
if ( .not. module_initialized ) call initialize_module
!
fileformat = trim(adjustl(fform))
SELECT CASE (fileformat)
   CASE("unf", "UNF", "unformatted", "UNFORMATTED")
   write(ifile) air_column_temp(1:nlevels_temp)
   CASE DEFAULT
   write(ifile, *) air_column_temp(1:nlevels_temp)
END SELECT
end subroutine write_iasi_air_column
!
subroutine write_iasi_prior(ifile, prior_temp, nlevels_temp, fform)
integer,                 intent(in) :: ifile, nlevels_temp
real(r8), dimension(41), intent(in) :: prior_temp
character(len=*),        intent(in) :: fform
!
character(len=32)  :: fileformat
!
if ( .not. module_initialized ) call initialize_module
!
fileformat = trim(adjustl(fform))
SELECT CASE (fileformat)
   CASE("unf", "UNF", "unformatted", "UNFORMATTED")
   write(ifile) prior_temp(1:nlevels_temp)
   CASE DEFAULT
   write(ifile, *) prior_temp(1:nlevels_temp)
END SELECT
end subroutine write_iasi_prior

end module obs_def_iasi_O3_mod

! END DART PREPROCESS MODULE CODE

