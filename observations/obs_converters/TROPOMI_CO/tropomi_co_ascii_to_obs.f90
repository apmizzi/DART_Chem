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
program tropomi_co_ascii_to_obs
!
!=============================================
! TROPOMI CO column obs
!=============================================
   use utilities_mod, only          : timestamp,                  &
                                      register_module,            &
                                      open_file,                  &
                                      close_file,                 &
                                      initialize_utilities,       &
                                      find_namelist_in_file,      &
                                      check_namelist_read,        &
                                      error_handler,              &
                                      E_ERR,                      & 
                                      E_WARN,                     & 
                                      E_MSG,                      &
                                      E_DBG

   use obs_sequence_mod, only       : obs_sequence_type,          &
                                      interactive_obs,            &
                                      write_obs_seq,              &
                                      interactive_obs_sequence,   &
                                      static_init_obs_sequence,   &
                                      init_obs_sequence,          &
                                      init_obs,                   &
                                      set_obs_values,             &
                                      set_obs_def,                &
                                      set_qc,                     &
                                      set_qc_meta_data,           &
                                      set_copy_meta_data,         &
                                      insert_obs_in_seq,          &
                                      obs_type

   use obs_def_mod, only            : set_obs_def_location,       &
                                      set_obs_def_time,           &
                                      set_obs_def_key,            &
                                      set_obs_def_error_variance, &
                                      obs_def_type,               &
                                      set_obs_def_type_of_obs

   use obs_def_tropomi_co_mod, only     : set_obs_def_tropomi_co

   use assim_model_mod, only        : static_init_assim_model

   use location_mod, only           : location_type,              &
                                      set_location

   use time_manager_mod, only       : set_date,                   &
                                      set_calendar_type,          &
                                      time_type,                  &
                                      get_time

   use obs_kind_mod, only           : QTY_CO,                     &
                                      TROPOMI_CO_COLUMN,              &
                                      get_type_of_obs_from_menu

   use random_seq_mod, only         : random_seq_type,            &
                                      init_random_seq,            &
                                      random_uniform

   use sort_mod, only               : index_sort
   implicit none
!
! version controlled file description for error handling, do not edit
   character(len=*), parameter     :: source   = 'tropomi_co_ascii_to_obs.f90'
   character(len=*), parameter     :: revision = ''
   character(len=*), parameter     :: revdate  = ''
!
   integer,parameter               :: num_copies=1, num_qc=1
   integer,parameter               :: max_num_obs=1000000
   type(obs_sequence_type)         :: seq
   type(obs_type)                  :: obs
   type(obs_type)                  :: obs_old
   type(obs_def_type)              :: obs_def
   type(location_type)             :: obs_location
   type(time_type)                 :: obs_time
!
   integer                         :: obs_kind
   integer                         :: obs_key
   integer                         :: year,month,day,hour,sec
   integer                         :: iunit,io,ios,icopy,old_ob
   integer                         :: calendar_type,qc_count
   integer                         :: line_count,fileid,nlevels
   integer                         :: obs_id,yr_obs,mn_obs,dy_obs,hh_obs,mm_obs,ss_obs
   integer                         :: nlay_obs,nlev_obs,ilv
   integer                         :: seconds,days,which_vert
   integer                         :: seconds_last,days_last
!
   integer,dimension(12)           :: days_in_month=(/ &
                                      31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31  /)
!
   real*8                          :: bin_beg_sec,bin_end_sec
   real*8                          :: lon_min,lon_max,lat_min,lat_max
   real*8                          :: fac_obs_error,fac
   real*8                          :: pi,rad2deg,re,level
   real*8                          :: lat,lon,dofs,prs_loc
   real*8                          :: lat_obs,lon_obs
   real*8                          :: obs_err_var
!
   real*8,dimension(num_qc)        :: tropomi_qc
   real*8,dimension(num_copies)    :: obs_val
   real*8,allocatable,dimension(:) :: prs_obs
!
   character*129                   :: filedir,filename,fileout
   character*129                   :: copy_meta_data
   character*129                   :: qc_meta_data='TROPOMI CO QC index'
   character*129                   :: chr_year,chr_month,chr_day
   character*129                   :: file_name='tropomi_co_obs_seq'
   character*129                   :: data_type,cmd
!
   logical                         :: use_log_co,use_log_o3,use_log_no2,use_log_so2
!
! Species-specific variables
   real*8                          :: col_amt_obs, col_amt_err_obs
   real*8,allocatable,dimension(:) :: avgk_obs
!
   namelist /create_tropomi_obs_nml/filedir,filename,fileout, &
   bin_beg_sec,bin_end_sec,fac_obs_error,use_log_co,use_log_o3,use_log_no2,use_log_so2, &
   lon_min,lon_max,lat_min,lat_max
!
! Set constants
   pi=4.*atan(1.)
   rad2deg=360./(2.*pi)
   re=6371000.
   days_last=-9999.
   seconds_last=-9999.
!
! Record the current time, date, etc. to the logfile
   call initialize_utilities(source)
   call register_module(source,revision,revdate)
!
! Initialize the obs_sequence module
   call static_init_obs_sequence()
!
   call find_namelist_in_file("input.nml", "create_tropomi_obs_nml", iunit)
   read(iunit, nml = create_tropomi_obs_nml, iostat = io)
   call check_namelist_read(iunit, io, "create_tropomi_obs_nml")
!
! Record the namelist values used for the run ...
   call error_handler(E_MSG,'init_create_tropomi_obs','create_tropomi_obs_nml values are',' ',' ',' ')
   write(     *     , nml=create_tropomi_obs_nml)
!
! Initialize an obs_sequence structure
   call init_obs_sequence(seq, num_copies, num_qc, max_num_obs)
!
! Initialize the obs variable
   call init_obs(obs, num_copies, num_qc)
!
   do icopy =1, num_copies
      if (icopy == 1) then
         copy_meta_data='TROPOMI CO observation'
      else
         copy_meta_data='Truth'
      endif
      call set_copy_meta_data(seq, icopy, copy_meta_data)
   enddo
   call set_qc_meta_data(seq, 1, qc_meta_data)
!
! assign obs error scale factor
   fac=fac_obs_error
!
!-------------------------------------------------------
! Read TROPOMI CO data
!-------------------------------------------------------
!
! Set dates and initialize qc_count
   qc_count=0
   calendar_type=3                          !Gregorian
   call set_calendar_type(calendar_type)
!
! Open TROPOMI CO binary file
   fileid=100
   write(6,*)'opening ',TRIM(filedir)//TRIM(filename)
   open(fileid,file=TRIM(filedir)//TRIM(filename),                     &
   form='formatted', status='old', iostat=ios)
!
! Read TROPOMI CO
   read(fileid,*,iostat=ios) data_type, obs_id
   do while (ios == 0)
      read(fileid,*,iostat=ios) yr_obs, mn_obs, &
      dy_obs, hh_obs, mm_obs, ss_obs
      read(fileid,*,iostat=ios) lat_obs,lon_obs
      if(lon_obs.lt.0.) lon_obs=lon_obs+360.
      read(fileid,*,iostat=ios) nlay_obs,nlev_obs
      allocate(prs_obs(nlev_obs))
      allocate(avgk_obs(nlay_obs))
      read(fileid,*,iostat=ios) prs_obs(1:nlev_obs)
      read(fileid,*,iostat=ios) avgk_obs(1:nlay_obs)
      read(fileid,*,iostat=ios) col_amt_obs, col_amt_err_obs
!
!      print *, trim(data_type), obs_id
!      print *, yr_obs,mn_obs,dy_obs
!      print *, hh_obs,mm_obs,ss_obs
!      print *, lat_obs,lon_obs
!      print *, nlay_obs,nlev_obs
!      print *, ' '
!      print *, prs_obs(1:nlev_obs)
!      print *, ' '
!      print *, avgk_obs(1:nlay_obs) 
!      print *, col_amt_obs
!      print *, col_amt_err_obs
!
! Set data for writing obs_sequence file
      qc_count=qc_count+1
      obs_val(:)=col_amt_obs
      obs_err_var=(col_amt_err_obs)**2.
      tropomi_qc(:)=0
      obs_time=set_date(yr_obs,mn_obs,dy_obs,hh_obs,mm_obs,ss_obs)
      call get_time(obs_time, seconds, days)
!
!--------------------------------------------------------
! Find vertical location
!--------------------------------------------------------
!
      call vertical_locate(prs_loc,prs_obs,nlev_obs,avgk_obs,nlay_obs)
      level=prs_loc*100.
      which_vert=2       ! pressure surface
!
      obs_kind = TROPOMI_CO_COLUMN
! (0 <= lon_obs <= 360); (-90 <= lat_obs <= 90) 
      obs_location=set_location(lon_obs, lat_obs, level, which_vert)
!
      call set_obs_def_type_of_obs(obs_def, obs_kind)
      call set_obs_def_location(obs_def, obs_location)
      call set_obs_def_time(obs_def, obs_time)
      call set_obs_def_error_variance(obs_def, obs_err_var)
      call set_obs_def_tropomi_co(qc_count, prs_obs, avgk_obs, nlay_obs)
      call set_obs_def_key(obs_def, qc_count)
      call set_obs_values(obs, obs_val, 1)
      call set_qc(obs, tropomi_qc, num_qc)
      call set_obs_def(obs, obs_def)
!
      old_ob=0
      if(days.lt.days_last) then
         old_ob=1
      elseif(days.eq.days_last .and. seconds.lt.seconds_last) then
         old_ob=1
      endif
      if(old_ob.eq.0) then
         days_last=days
         seconds_last=seconds
      endif
      if ( qc_count == 1 .or. old_ob.eq.1) then
         call insert_obs_in_seq(seq, obs)
      else
         call insert_obs_in_seq(seq, obs, obs_old )
      endif
      obs_old=obs
      deallocate(prs_obs)
      deallocate(avgk_obs) 
      read(fileid,*,iostat=ios) data_type, obs_id
   enddo   
!
!----------------------------------------------------------------------
! Write the sequence to a file
!----------------------------------------------------------------------
   call timestamp(string1=source,string2=revision,string3=revdate,pos='end')
   call write_obs_seq(seq, trim(fileout))
   close(fileid)
!
! Remove obs_seq if empty
   cmd='rm -rf '//trim(fileout)
   if(qc_count.eq.0) then
      call execute_command_line(trim(cmd))
   endif   
!
end program tropomi_co_ascii_to_obs
!
subroutine vertical_locate(prs_loc,prs,nlev,avgk,nlay)
!
! This subroutine identifies a vertical location for 
! vertical positioning/localization 
! 
   implicit none
   integer                         :: nlay,nlev
   integer                         :: k,kstr,kmax
   real*8                          :: prs_loc
   real*8                          :: wt_ctr,wt_end
   real*8                          :: zmax
   real*8,dimension(nlev)          :: prs
   real*8,dimension(nlay)          :: avgk,avgk_sm
!
! apply vertical smoother
   wt_ctr=2.
   wt_end=1.
   avgk_sm(:)=0.
   do k=1,nlay
      if(k.eq.1) then
         avgk_sm(k)=(wt_ctr*avgk(k)+wt_end*avgk(k+1))/(wt_ctr+wt_end)
         cycle
      elseif(k.eq.nlay) then
         avgk_sm(k)=(wt_end*avgk(k-1)+wt_ctr*avgk(k))/(wt_ctr+wt_end)
         cycle
      else
         avgk_sm(k)=(wt_end*avgk(k-1)+wt_ctr*avgk(k)+wt_end*avgk(k+1))/(wt_ctr+2.*wt_end)
      endif
   enddo
!
! locate the three-point maximum
   zmax=-1.e10
   kmax=0
   kstr=1
   do k=kstr,nlay
      if(abs(avgk_sm(k)).gt.zmax) then
         zmax=abs(avgk_sm(k))
         kmax=k
      endif
   enddo
   prs_loc=(prs(kmax)+prs(kmax+1))/2.
end subroutine vertical_locate
