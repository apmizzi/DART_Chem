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
! TROPOMI_O3_COLUMN, QTY_O3
! END DART PREPROCESS KIND LIST
!
! BEGIN DART PREPROCESS USE OF SPECIAL OBS_DEF MODULE
!   use obs_def_tropomi_o3_mod, only : write_tropomi_o3, read_tropomi_o3, &
!                               interactive_tropomi_o3, get_expected_tropomi_o3, &
!                               set_obs_def_tropomi_o3
! END DART PREPROCESS USE OF SPECIAL OBS_DEF MODULE
!
! BEGIN DART PREPROCESS GET_EXPECTED_OBS_FROM_DEF
!         case(TROPOMI_O3_COLUMN)                                                           
!            call get_expected_tropomi_o3(state_handle, ens_size, location, obs_def%key, expected_obs, istatus)  
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
! BEGIN DART PREPROCESS SET_OBS_DEF_TROPOMI_O3
!      case(TROPOMI_O3_COLUMN)
!         call set_obs_def_tropomi_o3(obs_def%key)
! END DART PREPROCESS SET_OBS_DEF
!
! BEGIN DART PREPROCESS MODULE CODE
module obs_def_tropomi_o3_mod
   use        types_mod, only              : r8,missing_r8
   use    utilities_mod, only              : register_module, error_handler, E_ERR, E_MSG, &
                                             nmlfileunit, check_namelist_read, &
                                             find_namelist_in_file, do_nml_file, do_nml_term, &
                                             ascii_file_format
   use     location_mod, only              : location_type, set_location, get_location, &
                                             VERTISPRESSURE, VERTISSURFACE, VERTISLEVEL, &
                                             VERTISUNDEF
   use  assim_model_mod, only              : interpolate
   use    obs_kind_mod, only               : QTY_O3,QTY_TEMPERATURE,QTY_PRESSURE, &
                                             QTY_VAPOR_MIXING_RATIO
   use  ensemble_manager_mod, only         : ensemble_type
   use obs_def_utilities_mod, only         : track_status
!
   implicit none
   private
   public :: write_tropomi_o3, &
             read_tropomi_o3, &
             interactive_tropomi_o3, &
             get_expected_tropomi_o3, &
             set_obs_def_tropomi_o3
!
! Storage for the special information required for observations of this type
   integer, parameter                     :: max_tropomi_o3_obs = 10000000
   integer, parameter                     :: tropomi_dim = 80
   integer                                :: num_tropomi_o3_obs = 0
   integer                                :: nlayer_model,nlayer_tropomi_o3
   integer, allocatable, dimension(:)     :: nlayer
   real(r8), allocatable, dimension(:,:)  :: pressure
   real(r8), allocatable, dimension(:,:)  :: avg_kernel
   real(r8), allocatable, dimension(:,:)  :: prior
!
! version controlled file description for error handling, do not edit
   character(len=*), parameter            :: source   = 'obs_def_tropomi_o3_mod.f90'
   character(len=*), parameter            :: revision = ''
   character(len=*), parameter            :: revdate  = ''
!
   character(len=512)                     :: string1, string2, string3
!
   logical, save                          :: module_initialized = .false.
   integer                                :: counts1 = 0
   logical                                :: use_log_o3
!
   namelist /obs_def_TROPOMI_O3_nml/use_log_o3,nlayer_model,nlayer_tropomi_o3
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
      allocate(nlayer(max_tropomi_o3_obs))
      allocate(pressure(max_tropomi_o3_obs,tropomi_dim+1))
      allocate(avg_kernel(max_tropomi_o3_obs,tropomi_dim))
!
! Read namelist values
      use_log_o3=.false.
      call find_namelist_in_file("input.nml", "obs_def_TROPOMI_O3_nml", iunit)
      read(iunit, nml = obs_def_TROPOMI_O3_nml, iostat = rc)
      call check_namelist_read(iunit, rc, "obs_def_TROPOMI_O3_nml")
!
! Record the namelist values
     if (do_nml_file()) write(nmlfileunit, nml=obs_def_TROPOMI_O3_nml)
     if (do_nml_term()) write(     *     , nml=obs_def_TROPOMI_O3_nml)
   end subroutine initialize_module
!
   subroutine read_tropomi_o3(key, ifile, fform)
      integer, intent(out)                   :: key
      integer, intent(in)                    :: ifile
      character(len=*), intent(in), optional :: fform
!
      integer                                :: keyin
      integer                                :: nlayer_1
      real(r8), dimension(tropomi_dim+1)     :: pressure_1
      real(r8), dimension(tropomi_dim)       :: avg_kernel_1
      real(r8), dimension(tropomi_dim)       :: prior_1
      character(len=32)                      :: fileformat
!
      if ( .not. module_initialized ) call initialize_module
!
      fileformat = "ascii" 
      if(present(fform)) fileformat = trim(adjustl(fform))
!
      nlayer_1 = 0
      pressure_1(:) = 0.0_r8
      avg_kernel_1(:) = 0.0_r8
      prior_1(:) = 0.0_r8
!
      SELECT CASE (fileformat)
         CASE ("unf", "UNF", "unformatted", "UNFORMATTED")
            nlayer_1 = read_tropomi_nlayer(ifile, fileformat)
            pressure_1(1:nlayer_1+1) = read_tropomi_pressure(ifile, nlayer_1+1, fileformat)
            avg_kernel_1(1:nlayer_1) = read_tropomi_avg_kernel(ifile, nlayer_1, fileformat)
            prior_1(1:nlayer_1) = read_tropomi_prior(ifile, nlayer_1, fileformat)
            read(ifile) keyin
         CASE DEFAULT
            nlayer_1 = read_tropomi_nlayer(ifile, fileformat)
            pressure_1(1:nlayer_1+1) = read_tropomi_pressure(ifile, nlayer_1+1, fileformat)
            avg_kernel_1(1:nlayer_1) = read_tropomi_avg_kernel(ifile, nlayer_1, fileformat)
            prior_1(1:nlayer_1) = read_tropomi_prior(ifile, nlayer_1, fileformat)
            read(ifile, *) keyin
      END SELECT
!
      counts1 = counts1 + 1
      key = counts1
      call set_obs_def_tropomi_o3(key, pressure_1, avg_kernel_1, prior_1, nlayer_1)
   end subroutine read_tropomi_o3
!
   subroutine write_tropomi_o3(key, ifile, fform)
      integer, intent(in)                    :: key
      integer, intent(in)                    :: ifile
      character(len=*), intent(in), optional :: fform
!
      integer                                :: nlayer_tmp
      real(r8), dimension(tropomi_dim+1)     :: pressure_tmp
      real(r8), dimension(tropomi_dim)       :: avg_kernel_tmp
      real(r8), dimension(tropomi_dim)       :: prior_tmp
      character(len=32)                      :: fileformat
!
      if ( .not. module_initialized ) call initialize_module
!
      fileformat = "ascii"
      if(present(fform)) fileformat = trim(adjustl(fform))
!
      nlayer_tmp=nlayer(key)
      pressure_tmp=pressure(key,:)
      avg_kernel_tmp=avg_kernel(key,:)
      prior_tmp=prior(key,:)
!
      SELECT CASE (fileformat)
         CASE ("unf", "UNF", "unformatted", "UNFORMATTED")
         call write_tropomi_nlayer(ifile, nlayer_tmp, fileformat)
         call write_tropomi_pressure(ifile, pressure_tmp, nlayer_tmp+1, fileformat)
         call write_tropomi_avg_kernel(ifile, avg_kernel_tmp, nlayer_tmp, fileformat)
         call write_tropomi_prior(ifile, prior_tmp, nlayer_tmp, fileformat)
         write(ifile) key
      CASE DEFAULT
         call write_tropomi_nlayer(ifile, nlayer_tmp, fileformat)
         call write_tropomi_pressure(ifile, pressure_tmp, nlayer_tmp+1, fileformat)
         call write_tropomi_avg_kernel(ifile, avg_kernel_tmp, nlayer_tmp, fileformat)
         call write_tropomi_prior(ifile, prior_tmp, nlayer_tmp, fileformat)
         write(ifile, *) key
      END SELECT 
   end subroutine write_tropomi_o3
!
   subroutine interactive_tropomi_o3(key)
      integer, intent(out) :: key
!
      if ( .not. module_initialized ) call initialize_module
!
      if(num_tropomi_o3_obs >= max_tropomi_o3_obs) then
         write(string1, *)'Not enough space for an tropomi o3 obs.'
         write(string2, *)'Can only have max_tropomi_o3_obs (currently ',max_tropomi_o3_obs,')'
         call error_handler(E_ERR,'interactive_tropomi_o3',string1,source,revision,revdate,text2=string2)
      endif
!
! Increment the index
      num_tropomi_o3_obs = num_tropomi_o3_obs + 1
      key = num_tropomi_o3_obs
!
! Otherwise, prompt for input for the three required beasts
      write(*, *) 'Creating an interactive_tropomi_o3 observation'
      write(*, *) 'This featue is not setup '
   end subroutine interactive_tropomi_o3
!
   subroutine get_expected_tropomi_o3(state_handle, ens_size, location, key, val, istatus)
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
      real*8                                 :: o3_min,mg 
      real*8,dimension(3)                    :: mloc
      real*8,dimension(ens_size)             :: obs_val,wrf_psf,tropomi_psf,tropomi_psf_save
      real*8,dimension(ens_size,tropomi_dim)     :: o3_vmr
      logical                                :: return_now
!
! Initialize DART
      if ( .not. module_initialized ) call initialize_module
!
      o3_min=1.e-6
      missing=-1.2676506e30
      mg=4.716046511627907e-21  
      level   = 1.0_r8
!
! Get tropomi nlayer
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
! Interpolate WRF O3 data to TROPOMI pressure level midpoint
      obs_val = 0.0_r8
      istatus = 0
      call interpolate(state_handle, ens_size, loc2, QTY_O3, obs_val, this_istatus)  
      call track_status(ens_size, this_istatus, obs_val, istatus, return_now)
      if (istatus(imem) .ne. 0 .and. istatus(imem) .ne. 2) then
         write(string1, *)'APM ERROR: istatus,kstr,obs_val ',istatus,kstr,obs_val 
         call error_handler(E_MSG, 'set_obs_def_tropomi_o3', string1, source, revision, revdate, &
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
   end subroutine get_expected_tropomi_o3
!
   subroutine set_obs_def_tropomi_o3(key, o3_pressure, o3_avgker, o3_prior, o3_nlayer)
      integer,intent(in)                       :: key, o3_nlayer
      real*8,dimension(o3_nlayer+1),intent(in) :: o3_pressure
      real*8,dimension(o3_nlayer),intent(in)   :: o3_avgker
      real*8,dimension(o3_nlayer),intent(in)   :: o3_prior
!
      if ( .not. module_initialized ) call initialize_module
!
      if(num_tropomi_o3_obs >= max_tropomi_o3_obs) then
         write(string1, *)'Not enough space for tropomi o3 obs.'
         write(string2, *)'Can only have max_tropomi_o3_obs (currently ',max_tropomi_o3_obs,')'
         call error_handler(E_ERR,'set_obs_def_tropomi_o3',string1,source,revision,revdate,text2=string2)
      endif
!
      nlayer(key) = o3_nlayer
      pressure(key,:) = o3_pressure(:)
      avg_kernel(key,:) = o3_avgker(:)
      prior(key,:) = o3_prior(:)
   end subroutine set_obs_def_tropomi_o3
!
   function read_tropomi_nlayer(ifile, fform)
      integer                                :: read_tropomi_nlayer
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
            read(ifile) read_tropomi_nlayer
         CASE DEFAULT
            read(ifile, *) read_tropomi_nlayer
      END SELECT
   end function read_tropomi_nlayer
!
   subroutine write_tropomi_nlayer(ifile, nlayer_tmp, fform)
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
   end subroutine write_tropomi_nlayer
!
   function read_tropomi_pressure(ifile, nlevel, fform)
      real(r8)                               :: read_tropomi_pressure(nlevel)
      integer,intent(in)                     :: ifile, nlevel
      character(len=*),intent(in),optional   :: fform
      character(len=32)                      :: fileformat
!
      if ( .not. module_initialized ) call initialize_module
      read_tropomi_pressure(:) = 0.0_r8
!
      fileformat = "ascii"
      if(present(fform)) fileformat = trim(adjustl(fform))
!
      SELECT CASE (fileformat)
         CASE("unf", "UNF", "unformatted", "UNFORMATTED")
            read(ifile) read_tropomi_pressure(1:nlevel)
         CASE DEFAULT
            read(ifile, *) read_tropomi_pressure(1:nlevel)
      END SELECT
   end function read_tropomi_pressure
!
   subroutine write_tropomi_pressure(ifile, pressure_tmp, nlevel_tmp, fform)
      integer,intent(in)                         :: ifile,nlevel_tmp
      real*8,dimension(nlevel_tmp),intent(in)    :: pressure_tmp
      character(len=*),intent(in),optional       :: fform
      character(len=32)                          :: fileformat
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
   end subroutine write_tropomi_pressure
!
   function read_tropomi_avg_kernel(ifile, nlayer, fform)
      real(r8)                               :: read_tropomi_avg_kernel(nlayer)
      integer,intent(in)                     :: ifile, nlayer
      character(len=*),intent(in),optional   :: fform
      character(len=32)                      :: fileformat
!
      if ( .not. module_initialized ) call initialize_module
      read_tropomi_avg_kernel(:) = 0.0_r8
!
      fileformat = "ascii"
      if(present(fform)) fileformat = trim(adjustl(fform))
!
      SELECT CASE (fileformat)
         CASE("unf", "UNF", "unformatted", "UNFORMATTED")
            read(ifile) read_tropomi_avg_kernel(1:nlayer)
         CASE DEFAULT
            read(ifile, *) read_tropomi_avg_kernel(1:nlayer)
      END SELECT
   end function read_tropomi_avg_kernel
!
   subroutine write_tropomi_avg_kernel(ifile, avg_kernel_tmp, nlayer_tmp, fform)
      integer,intent(in)                        :: ifile,nlayer_tmp
      real*8,dimension(nlayer_tmp),intent(in)   :: avg_kernel_tmp
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
            write(ifile) avg_kernel_tmp(1:nlayer_tmp)
         CASE DEFAULT
            write(ifile, *) avg_kernel_tmp(1:nlayer_tmp)
      END SELECT
   end subroutine write_tropomi_avg_kernel
!
   function read_tropomi_prior(ifile, nlayer, fform)
      real*8                                 :: read_tropomi_prior(nlayer)
      integer,intent(in)                     :: ifile,nlayer
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
            read(ifile) read_tropomi_prior(1:nlayer)
         CASE DEFAULT
            read(ifile, *) read_tropomi_prior(1:nlayer)
      END SELECT
   end function read_tropomi_prior
!
   subroutine write_tropomi_prior(ifile, tropomi_prior_tmp, nlayer_tmp, fform)
      integer,intent(in)                         :: ifile,nlayer_tmp
      real*8,dimension(nlayer_tmp),intent(in)    :: tropomi_prior_tmp
      character(len=*),intent(in),optional       :: fform
      character(len=32)                          :: fileformat
!
      if ( .not. module_initialized ) call initialize_module
!
      fileformat = "ascii"
      if(present(fform)) fileformat = trim(adjustl(fform))
!
      SELECT CASE (fileformat)
         CASE("unf", "UNF", "unformatted", "UNFORMATTED")
            write(ifile) tropomi_prior_tmp(1:nlayer_tmp)
         CASE DEFAULT
            write(ifile, *) tropomi_prior_tmp(1:nlayer_tmp)
      END SELECT
   end subroutine write_tropomi_prior
end module obs_def_tropomi_o3_mod
! END DART PREPROCESS MODULE CODE
