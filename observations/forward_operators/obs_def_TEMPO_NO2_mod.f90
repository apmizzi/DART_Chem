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
! TEMPO_NO2_COLUMN, QTY_NO2
! END DART PREPROCESS KIND LIST
!
! BEGIN DART PREPROCESS USE OF SPECIAL OBS_DEF MODULE
!   use obs_def_tempo_no2_mod, only : write_tempo_no2, read_tempo_no2, &
!                               interactive_tempo_no2, get_expected_tempo_no2, &
!                               set_obs_def_tempo_no2
! END DART PREPROCESS USE OF SPECIAL OBS_DEF MODULE
!
! BEGIN DART PREPROCESS GET_EXPECTED_OBS_FROM_DEF
!         case(TEMPO_NO2_COLUMN)                                                           
!            call get_expected_tempo_no2(state_handle, ens_size, location, obs_def%key, expected_obs, istatus)  
! END DART PREPROCESS GET_EXPECTED_OBS_FROM_DEF
!
! BEGIN DART PREPROCESS READ_OBS_DEF
!      case(TEMPO_NO2_COLUMN)
!         call read_tempo_no2(obs_def%key, ifile, fileformat)
! END DART PREPROCESS READ_OBS_DEF
!
! BEGIN DART PREPROCESS WRITE_OBS_DEF
!      case(TEMPO_NO2_COLUMN)
!         call write_tempo_no2(obs_def%key, ifile, fileformat)
! END DART PREPROCESS WRITE_OBS_DEF
!
! BEGIN DART PREPROCESS INTERACTIVE_OBS_DEF
!      case(TEMPO_NO2_COLUMN)
!         call interactive_tempo_no2(obs_def%key)
! END DART PREPROCESS INTERACTIVE_OBS_DEF
!
! BEGIN DART PREPROCESS SET_OBS_DEF_TEMPO_NO2
!      case(TEMPO_NO2_COLUMN)
!         call set_obs_def_tempo_no2(obs_def%key)
! END DART PREPROCESS SET_OBS_DEF
!
! BEGIN DART PREPROCESS MODULE CODE
module obs_def_tempo_no2_mod
   use        types_mod, only              : r8,missing_r8
   use    utilities_mod, only              : register_module, error_handler, E_ERR, E_MSG, &
                                             nmlfileunit, check_namelist_read, &
                                             find_namelist_in_file, do_nml_file, do_nml_term, &
                                             ascii_file_format
   use     location_mod, only              : location_type, set_location, get_location, &
                                             VERTISPRESSURE, VERTISSURFACE, VERTISLEVEL, &
                                             VERTISUNDEF
   use  assim_model_mod, only              : interpolate
   use    obs_kind_mod, only               : QTY_NO2,QTY_TEMPERATURE,QTY_SURFACE_PRESSURE, &
                                             QTY_PRESSURE, QTY_VAPOR_MIXING_RATIO
   use  ensemble_manager_mod, only         : ensemble_type
   use obs_def_utilities_mod, only         : track_status
!
   implicit none
   private
   public :: write_tempo_no2, &
             read_tempo_no2, &
             interactive_tempo_no2, &
             get_expected_tempo_no2, &
             set_obs_def_tempo_no2
!
! Storage for the special information required for observations of this type
   integer, parameter                     :: max_tempo_no2_obs = 10000000
   integer, parameter                     :: tempo_dim = 60
   integer                                :: num_tempo_no2_obs = 0
   integer, allocatable, dimension(:)     :: nlayer
   integer                                :: nlayer_model,nlayer_tempo_no2
   real(r8), allocatable, dimension(:)    :: prs_trop,amf_trop
   real(r8), allocatable, dimension(:,:)  :: pressure
   real(r8), allocatable, dimension(:,:)  :: scat_wts
!
! version controlled file description for error handling, do not edit
   character(len=*), parameter            :: source   = 'obs_def_tempo_no2_mod.f90'
   character(len=*), parameter            :: revision = ''
   character(len=*), parameter            :: revdate  = ''
!
   character(len=512)                     :: string1, string2, string3
!
   logical, save                          :: module_initialized = .false.
   integer                                :: counts1 = 0
   logical                                :: use_log_no2
!
   namelist /obs_def_TEMPO_NO2_nml/use_log_no2,nlayer_model,nlayer_tempo_no2
!
   contains
!
   subroutine initialize_module
      integer           :: iunit, rc
!
! Prevent multiple calls from executing this code more than once.
      if (module_initialized) return
      call register_module(source, revision, revdate)
      module_initialized = .true.
!
      allocate(nlayer(max_tempo_no2_obs))
      allocate(pressure(max_tempo_no2_obs,tempo_dim+1))
      allocate(scat_wts(max_tempo_no2_obs,tempo_dim))
      allocate(prs_trop(max_tempo_no2_obs))
      allocate(amf_trop(max_tempo_no2_obs))
!
! Read namelist values
      use_log_no2=.false.
      call find_namelist_in_file("input.nml", "obs_def_TEMPO_NO2_nml", iunit)
      read(iunit, nml = obs_def_TEMPO_NO2_nml, iostat = rc)
      call check_namelist_read(iunit, rc, "obs_def_TEMPO_NO2_nml")
!
! Record the namelist values
     if (do_nml_file()) write(nmlfileunit, nml=obs_def_TEMPO_NO2_nml)
     if (do_nml_term()) write(     *     , nml=obs_def_TEMPO_NO2_nml)
   end subroutine initialize_module
!
   subroutine read_tempo_no2(key, ifile, fform)
      integer, intent(out)                   :: key
      integer, intent(in)                    :: ifile
      character(len=*), intent(in), optional :: fform
!
      integer                                  :: keyin
      integer                                  :: nlayer_1
      real(r8), dimension(tempo_dim+1)         :: pressure_1
      real(r8), dimension(tempo_dim)           :: scat_wts_1
      real(r8)                                 :: prs_trop_1
      real(r8)                                 :: amf_trop_1
      character(len=32)                        :: fileformat
!
      if ( .not. module_initialized ) call initialize_module
!
      fileformat = "ascii" 
      if(present(fform)) fileformat = trim(adjustl(fform))
!
      nlayer_1 = 0
      pressure_1(:) = 0.0_r8
      scat_wts_1(:) = 0.0_r8
      prs_trop_1    = 0.0_r8
      amf_trop_1    = 0.0_r8
!
      SELECT CASE (fileformat)
         CASE ("unf", "UNF", "unformatted", "UNFORMATTED")
            nlayer_1 = read_tempo_nlayer(ifile, fileformat)
            pressure_1(1:nlayer_1+1) = read_tempo_pressure(ifile, nlayer_1+1, fileformat)
            scat_wts_1(1:nlayer_1) = read_tempo_scat_wts(ifile, nlayer_1, fileformat)
            prs_trop = read_tempo_prs_trop(ifile, fileformat)
            amf_trop = read_tempo_amf_trop(ifile, fileformat)
            read(ifile) keyin
         CASE DEFAULT
            nlayer_1 = read_tempo_nlayer(ifile, fileformat)
            pressure_1(1:nlayer_1+1) = read_tempo_pressure(ifile, nlayer_1+1, fileformat)
            scat_wts_1(1:nlayer_1) = read_tempo_scat_wts(ifile, nlayer_1, fileformat)
            prs_trop = read_tempo_prs_trop(ifile, fileformat)
            amf_trop = read_tempo_amf_trop(ifile, fileformat)
            read(ifile, *) keyin
      END SELECT
!
      counts1 = counts1 + 1
      key = counts1
      call set_obs_def_tempo_no2(key, pressure_1, scat_wts_1, prs_trop_1, &
      amf_trop_1, nlayer_1)
   end subroutine read_tempo_no2
!
   subroutine write_tempo_no2(key, ifile, fform)
      integer, intent(in)                    :: key
      integer, intent(in)                    :: ifile
      character(len=*), intent(in), optional :: fform
!
      integer                                  :: nlayer_tmp
      real(r8), dimension(tempo_dim+1)         :: pressure_tmp
      real(r8), dimension(tempo_dim)           :: scat_wts_tmp
      real(r8)                                 :: prs_trop_tmp
      real(r8)                                 :: amf_trop_tmp
      character(len=32)                        :: fileformat
!
      if ( .not. module_initialized ) call initialize_module
!
      fileformat = "ascii"
      if(present(fform)) fileformat = trim(adjustl(fform))
!
      nlayer_tmp=nlayer(key)
      pressure_tmp=pressure(key,:)
      scat_wts_tmp=scat_wts(key,:)
      prs_trop_tmp=prs_trop(key)
      amf_trop_tmp=amf_trop(key)
!
      SELECT CASE (fileformat)
         CASE ("unf", "UNF", "unformatted", "UNFORMATTED")
         call write_tempo_nlayer(ifile, nlayer_tmp, fileformat)
         call write_tempo_pressure(ifile, pressure_tmp, nlayer_tmp+1, fileformat)
         call write_tempo_scat_wts(ifile, scat_wts_tmp, nlayer_tmp, fileformat)
         call write_tempo_prs_trop(ifile, prs_trop_tmp, fileformat)
         call write_tempo_amf_trop(ifile, amf_trop_tmp, fileformat)
         write(ifile) key
      CASE DEFAULT
         call write_tempo_nlayer(ifile, nlayer_tmp, fileformat)
         call write_tempo_pressure(ifile, pressure_tmp, nlayer_tmp+1, fileformat)
         call write_tempo_scat_wts(ifile, scat_wts_tmp, nlayer_tmp, fileformat)
         call write_tempo_prs_trop(ifile, prs_trop_tmp, fileformat)
         call write_tempo_amf_trop(ifile, amf_trop_tmp, fileformat)
         write(ifile, *) key
      END SELECT 
   end subroutine write_tempo_no2
!
   subroutine interactive_tempo_no2(key)
      integer, intent(out) :: key
!
      if ( .not. module_initialized ) call initialize_module
!
      if(num_tempo_no2_obs >= max_tempo_no2_obs) then
         write(string1, *)'Not enough space for an tempo no2 obs.'
         write(string2, *)'Can only have max_tempo_no2_obs (currently ',max_tempo_no2_obs,')'
         call error_handler(E_ERR,'interactive_tempo_no2',string1,source,revision,revdate,text2=string2)
      endif
!
! Increment the index
      num_tempo_no2_obs = num_tempo_no2_obs + 1
      key = num_tempo_no2_obs
!
! Otherwise, prompt for input for the three required beasts
      write(*, *) 'Creating an interactive_tempo_no2 observation'
      write(*, *) 'This featue is not setup '
   end subroutine interactive_tempo_no2
!
   subroutine get_expected_tempo_no2(state_handle, ens_size, location, key, val, istatus)
      type(ensemble_type),intent(in)              :: state_handle
      type(location_type),intent(in)              :: location
      integer,intent(in)                          :: ens_size
      integer,intent(in)                          :: key
!
      integer,dimension(ens_size),intent(out)     :: istatus
      real*8,dimension(ens_size),intent(out)      :: val
!
      type(location_type)                    :: loc2
      integer                                :: i,kend,imem
      integer                                :: nnlayer
      integer,dimension(ens_size)            :: kstr,nnlevels,this_istatus
      real*8	                          :: level,missing
      real*8                                 :: no2_min,mg 
      real*8,dimension(3)                    :: mloc
      real*8,dimension(ens_size)             :: obs_val,wrf_psf,tempo_psf,tempo_psf_save
      real*8,dimension(ens_size,tempo_dim)     :: no2_vmr
      logical                                :: return_now
!
! Initialize DART
      if ( .not. module_initialized ) call initialize_module
!
      no2_min=1.e-6
      missing=-1.2676506e30
      mg=4.716046511627907e-21  
      level   = 1.0_r8
!
! Get tempo nlayer
      nnlayer = nlayer(key)
!
! Get location infomation
      mloc = get_location(location)
      if (mloc(2)>90.0_r8) then
         mloc(2)=90.0_r8
      elseif (mloc(2)<-90.0_r8) then
         mloc(2)=-90.0_r8
      endif
!
! Interpolate WRF NO2 data to TEMPO pressure level midpoint
      obs_val = 0.0_r8
      istatus = 0
      call interpolate(state_handle, ens_size, loc2, QTY_NO2, obs_val, this_istatus)  
      call track_status(ens_size, this_istatus, obs_val, istatus, return_now)
      if (istatus(imem) .ne. 0 .and. istatus(imem) .ne. 2) then
         write(string1, *)'APM ERROR: istatus,kstr,obs_val ',istatus,kstr,obs_val 
         call error_handler(E_MSG, 'set_obs_def_tempo_no2', string1, source, revision, revdate, &
         text2=string2, text3=string3)
         call abort
      endif
!
      val(:) = 0.0_r8
      do imem = 1, ens_size
         do i=1,nnlayer
            if (i .eq. 1) then 
               val(:) = val(:) + 0.5
            else
               val(:) = val(:) + 0.5
            endif
         enddo
      enddo
   end subroutine get_expected_tempo_no2
!
   subroutine set_obs_def_tempo_no2(key, no2_pressure, no2_scat_wts, &
   no2_prs_trop, no2_amf_trop, no2_nlayer)
      integer,intent(in)                       :: key, no2_nlayer
      real*8,dimension(tempo_dim+1),intent(in) :: no2_pressure
      real*8,dimension(tempo_dim),intent(in)   :: no2_scat_wts
      real*8,intent(in)                        :: no2_prs_trop
      real*8,intent(in)                        :: no2_amf_trop
!
      if ( .not. module_initialized ) call initialize_module
!
      if(num_tempo_no2_obs >= max_tempo_no2_obs) then
         write(string1, *)'Not enough space for tempo no2 obs.'
         write(string2, *)'Can only have max_tempo_no2_obs (currently ',max_tempo_no2_obs,')'
         call error_handler(E_ERR,'set_obs_def_tempo_no2',string1,source,revision,revdate,text2=string2)
      endif
!
      nlayer(key) = no2_nlayer
      pressure(key,:) = no2_pressure(:)
      scat_wts(key,:) = no2_scat_wts(:)
      prs_trop(key) = no2_prs_trop
      amf_trop(key) = no2_amf_trop
   end subroutine set_obs_def_tempo_no2
!
   function read_tempo_nlayer(ifile, fform)
      integer                                :: read_tempo_nlayer
      integer,intent(in)                     :: ifile
      character(len=*),intent(in),optional   :: fform
      character(len=32)                      :: fileformat
!
      if ( .not. module_initialized ) call initialize_module
!
      fileformat = "ascii"
      if(present(fform)) fileformat = trim(adjustl(fform))
!
      SELECT CASE (fileformat)
         CASE("unf", "UNF", "unformatted", "UNFORMATTED")
            read(ifile) read_tempo_nlayer
         CASE DEFAULT
            read(ifile, *) read_tempo_nlayer
      END SELECT
   end function read_tempo_nlayer
!
   subroutine write_tempo_nlayer(ifile, nlayer_tmp, fform)
      integer,intent(in)                     :: ifile
      integer,intent(in)                     :: nlayer_tmp
      character(len=*),intent(in),optional   :: fform
      character(len=32)                      :: fileformat
!
      if ( .not. module_initialized ) call initialize_module
!
      fileformat = "ascii"
      if(present(fform)) fileformat = trim(adjustl(fform))
!
      SELECT CASE (fileformat)
         CASE("unf", "UNF", "unformatted", "UNFORMATTED")
            write(ifile) nlayer_tmp
         CASE DEFAULT
            write(ifile, *) nlayer_tmp
      END SELECT
   end subroutine write_tempo_nlayer
!
   function read_tempo_pressure(ifile, nlevel, fform)
      real(r8)                               :: read_tempo_pressure(nlevel)
      integer,intent(in)                     :: ifile, nlevel
      character(len=*),intent(in),optional   :: fform
      character(len=32)                      :: fileformat
!
      if ( .not. module_initialized ) call initialize_module
      read_tempo_pressure(:) = 0.0_r8
!
      fileformat = "ascii"
      if(present(fform)) fileformat = trim(adjustl(fform))
!
      SELECT CASE (fileformat)
         CASE("unf", "UNF", "unformatted", "UNFORMATTED")
            read(ifile) read_tempo_pressure(1:nlevel)
         CASE DEFAULT
            read(ifile, *) read_tempo_pressure(1:nlevel)
      END SELECT
   end function read_tempo_pressure
!
   subroutine write_tempo_pressure(ifile, pressure_tmp, nlevel_tmp, fform)
      integer,intent(in)                        :: ifile,nlevel_tmp
      real*8,dimension(nlevel_tmp),intent(in)   :: pressure_tmp
      character(len=*),intent(in),optional      :: fform
      character(len=32)                         :: fileformat
!
      if ( .not. module_initialized ) call initialize_module
!
      fileformat = "ascii"
      if(present(fform)) fileformat = trim(adjustl(fform))
!
      SELECT CASE (fileformat)
         CASE("unf", "UNF", "unformatted", "UNFORMATTED")
            write(ifile) pressure_tmp(1:nlevel_tmp)
         CASE DEFAULT
            write(ifile, *) pressure_tmp(1:nlevel_tmp)
      END SELECT
   end subroutine write_tempo_pressure
!
   function read_tempo_scat_wts(ifile, nlayer, fform)
      real(r8)                               :: read_tempo_scat_wts(nlayer)
      integer,intent(in)                     :: ifile, nlayer
      character(len=*),intent(in),optional   :: fform
      character(len=32)                      :: fileformat
!
      if ( .not. module_initialized ) call initialize_module
      read_tempo_scat_wts(:) = 0.0_r8
!
      fileformat = "ascii"
      if(present(fform)) fileformat = trim(adjustl(fform))
!
      SELECT CASE (fileformat)
         CASE("unf", "UNF", "unformatted", "UNFORMATTED")
            read(ifile) read_tempo_scat_wts(1:nlayer)
         CASE DEFAULT
            read(ifile, *) read_tempo_scat_wts(1:nlayer)
      END SELECT
   end function read_tempo_scat_wts
!
   subroutine write_tempo_scat_wts(ifile, scat_wts_tmp, nlayer_tmp, fform)
      integer,intent(in)                        :: ifile,nlayer_tmp
      real*8,dimension(nlayer_tmp),intent(in)   :: scat_wts_tmp
      character(len=*),intent(in),optional      :: fform
      character(len=32)                         :: fileformat
!
      if ( .not. module_initialized ) call initialize_module
!
      fileformat = "ascii"
      if(present(fform)) fileformat = trim(adjustl(fform))
!
      SELECT CASE (fileformat)
         CASE("unf", "UNF", "unformatted", "UNFORMATTED")
            write(ifile) scat_wts_tmp(1:nlayer_tmp)
         CASE DEFAULT
            write(ifile, *) scat_wts_tmp(1:nlayer_tmp)
      END SELECT
   end subroutine write_tempo_scat_wts
!
   function read_tempo_prs_trop(ifile, fform)
      real*8                                 :: read_tempo_prs_trop
      integer,intent(in)                     :: ifile
      character(len=*),intent(in),optional   :: fform
      character(len=32)                      :: fileformat
!
      if ( .not. module_initialized ) call initialize_module
!
      fileformat = "ascii"
      if(present(fform)) fileformat = trim(adjustl(fform))
!
      SELECT CASE (fileformat)
         CASE("unf", "UNF", "unformatted", "UNFORMATTED")
            read(ifile) read_tempo_prs_trop
         CASE DEFAULT
            read(ifile, *) read_tempo_prs_trop
      END SELECT
   end function read_tempo_prs_trop
!
   subroutine write_tempo_prs_trop(ifile, prs_trop_tmp, fform)
      integer,intent(in)                     :: ifile
      real*8,intent(in)                      :: prs_trop_tmp
      character(len=*),intent(in),optional   :: fform
      character(len=32)                      :: fileformat
!
      if ( .not. module_initialized ) call initialize_module
!
      fileformat = "ascii"
      if(present(fform)) fileformat = trim(adjustl(fform))
!
      SELECT CASE (fileformat)
         CASE("unf", "UNF", "unformatted", "UNFORMATTED")
            write(ifile) prs_trop_tmp
         CASE DEFAULT
            write(ifile, *) prs_trop_tmp
      END SELECT
   end subroutine write_tempo_prs_trop
!
   function read_tempo_amf_trop(ifile, fform)
      real*8                                 :: read_tempo_amf_trop
      integer,intent(in)                     :: ifile
      character(len=*),intent(in),optional   :: fform
      character(len=32)                      :: fileformat
!
      if ( .not. module_initialized ) call initialize_module
!
      fileformat = "ascii"
      if(present(fform)) fileformat = trim(adjustl(fform))
!
      SELECT CASE (fileformat)
         CASE("unf", "UNF", "unformatted", "UNFORMATTED")
            read(ifile) read_tempo_amf_trop
         CASE DEFAULT
            read(ifile, *) read_tempo_amf_trop
      END SELECT
   end function read_tempo_amf_trop
!
   subroutine write_tempo_amf_trop(ifile, amf_trop_tmp, fform)
      integer,intent(in)                     :: ifile
      real*8,intent(in)                      :: amf_trop_tmp
      character(len=*),intent(in),optional   :: fform
      character(len=32)                      :: fileformat
!
      if ( .not. module_initialized ) call initialize_module
!
      fileformat = "ascii"
      if(present(fform)) fileformat = trim(adjustl(fform))
!
      SELECT CASE (fileformat)
         CASE("unf", "UNF", "unformatted", "UNFORMATTED")
            write(ifile) amf_trop_tmp
         CASE DEFAULT
            write(ifile, *) amf_trop_tmp
      END SELECT
   end subroutine write_tempo_amf_trop
end module obs_def_tempo_no2_mod
! END DART PREPROCESS MODULE CODE
