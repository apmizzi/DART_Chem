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
program tropomi_o3_ascii_to_obs
!
!=============================================
! TROPOMI O3 column obs
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

   use obs_def_tropomi_o3_mod, only     : set_obs_def_tropomi_o3

   use assim_model_mod, only        : static_init_assim_model

   use location_mod, only           : location_type,              &
                                      set_location

   use time_manager_mod, only       : set_date,                   &
                                      set_calendar_type,          &
                                      time_type,                  &
                                      get_time

   use obs_kind_mod, only           : QTY_O3,                     &
                                      TROPOMI_O3_COLUMN,              &
                                      get_type_of_obs_from_menu

   use random_seq_mod, only         : random_seq_type,            &
                                      init_random_seq,            &
                                      random_uniform

   use sort_mod, only               : index_sort
   implicit none
!
! version controlled file description for error handling, do not edit
   character(len=*), parameter     :: source   = 'tropomi_o3_ascii_to_obs.f90'
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
   integer                         :: nx_model,ny_model,nz_model
   integer                         :: reject,k,kend
   integer                         :: i_min,j_min
   integer                         :: sum_reject,sum_accept,sum_total
!
   integer,dimension(12)           :: days_in_month=(/ &
                                      31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31  /)
!
   real                            :: bin_beg_sec,bin_end_sec
   real                            :: lon_min,lon_max,lat_min,lat_max
   real                            :: fac_obs_error,fac
   real                            :: pi,rad2deg,re,level_crit
   real                            :: x_observ,y_observ,dofs
   real                            :: prs_loc
   real*8                          :: obs_err_var,level
!
   real*8,dimension(num_qc)        :: tropomi_qc
   real*8,dimension(num_copies)    :: obs_val
!
   character*129                   :: filedir,filename,fileout
   character*129                   :: copy_meta_data
   character*129                   :: qc_meta_data='TROPOMI O3 QC index'
   character*129                   :: chr_year,chr_month,chr_day
   character*129                   :: file_name='tropomi_o3_obs_seq'
   character*129                   :: data_type,cmd
   character*129                   :: path_model,file_model,file_in
!
   logical                         :: use_log_co,use_log_o3,use_log_no2,use_log_so2
!
! Species-specific variables
   real                            :: col_amt_obs,col_amt_err_obs
   real                            :: lat_obs,lon_obs
   real*8                          :: lat_obs_r8,lon_obs_r8
   real,allocatable,dimension(:)   :: avgk_obs,prior_obs
   real*8,allocatable,dimension(:) :: avgk_obs_r8,prior_obs_r8
   real,allocatable,dimension(:)   :: prs_obs
   real*8,allocatable,dimension(:) :: prs_obs_r8
   real,allocatable,dimension(:)   :: prf_model
   real,allocatable,dimension(:,:)     :: lon,lat
   real,allocatable,dimension(:,:,:)   :: prs_prt,prs_bas,prs_fld
   real,allocatable,dimension(:,:,:)   :: tmp_prt,tmp_fld,vtmp_fld
   real,allocatable,dimension(:,:,:)   :: o3_fld,qmr_fld
!
   namelist /create_tropomi_obs_nml/filedir,filename,fileout, &
   bin_beg_sec,bin_end_sec,fac_obs_error,use_log_co,use_log_o3,use_log_no2,use_log_so2, &
   lon_min,lon_max,lat_min,lat_max, &
   path_model,file_model,nx_model,ny_model,nz_model
!
! Set constants
   pi=4.*atan(1.)
   rad2deg=360./(2.*pi)
   re=6371000.
   days_last=-9999.
   seconds_last=-9999.
   level_crit=500.
   sum_reject=0
   sum_accept=0
   sum_total=0
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
         copy_meta_data='TROPOMI O3 observation'
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
! Read TROPOMI O3 data
!-------------------------------------------------------
!
! Set dates and initialize qc_count
   qc_count=0
   calendar_type=3                          !Gregorian
   call set_calendar_type(calendar_type)
!
! Read model data
   allocate(lon(nx_model,ny_model))
   allocate(lat(nx_model,ny_model))
   allocate(prs_prt(nx_model,ny_model,nz_model))
   allocate(prs_bas(nx_model,ny_model,nz_model))
   allocate(prs_fld(nx_model,ny_model,nz_model))
   allocate(tmp_prt(nx_model,ny_model,nz_model))
   allocate(tmp_fld(nx_model,ny_model,nz_model))
   allocate(qmr_fld(nx_model,ny_model,nz_model))
   allocate(o3_fld(nx_model,ny_model,nz_model))
   file_in=trim(path_model)//'/'//trim(file_model)
   call get_DART_diag_data(trim(file_in),'XLONG',lon,nx_model,ny_model,1,1)
   call get_DART_diag_data(trim(file_in),'XLAT',lat,nx_model,ny_model,1,1)
   call get_DART_diag_data(trim(file_in),'P',prs_prt,nx_model,ny_model,nz_model,1)
   call get_DART_diag_data(trim(file_in),'PB',prs_bas,nx_model,ny_model,nz_model,1)
   call get_DART_diag_data(trim(file_in),'T',tmp_prt,nx_model,ny_model,nz_model,1)
   call get_DART_diag_data(trim(file_in),'QVAPOR',qmr_fld,nx_model,ny_model,nz_model,1)
   call get_DART_diag_data(file_in,'o3',o3_fld,nx_model,ny_model,nz_model,1)
   prs_fld(:,:,:)=prs_bas(:,:,:)+prs_prt(:,:,:)
   tmp_fld(:,:,:)=300.+tmp_prt(:,:,:)
   o3_fld(:,:,:)=o3_fld(:,:,:)*1.e-6
!
! Open TROPOMI O3 binary file
   fileid=100
   write(6,*)'opening ',TRIM(filedir)//TRIM(filename)
   open(fileid,file=TRIM(filedir)//TRIM(filename),                     &
   form='formatted', status='old', iostat=ios)
!
! Read TROPOMI O3
   read(fileid,*,iostat=ios) data_type, obs_id, i_min, j_min
   do while (ios == 0)
      read(fileid,*,iostat=ios) yr_obs, mn_obs, &
      dy_obs, hh_obs, mm_obs, ss_obs
      read(fileid,*,iostat=ios) lat_obs,lon_obs
      if(lon_obs.lt.0.) lon_obs=lon_obs+360.
      read(fileid,*,iostat=ios) nlay_obs,nlev_obs
      allocate(prs_obs(nlev_obs))
      allocate(avgk_obs(nlay_obs))
      allocate(prior_obs(nlay_obs))
      allocate(prs_obs_r8(nlev_obs))
      allocate(avgk_obs_r8(nlay_obs))
      allocate(prior_obs_r8(nlay_obs))
      allocate(prf_model(nlay_obs))
      read(fileid,*,iostat=ios) prs_obs(1:nlev_obs)
      read(fileid,*,iostat=ios) avgk_obs(1:nlay_obs)
      read(fileid,*,iostat=ios) prior_obs(1:nlay_obs)
      read(fileid,*,iostat=ios) col_amt_obs, col_amt_err_obs
      prs_obs_r8(:)=prs_obs(:)
      avgk_obs_r8(:)=avgk_obs(:)
      prior_obs_r8(:)=prior_obs(:)
      lon_obs_r8=lon_obs
      lat_obs_r8=lat_obs
!
!      print *, trim(data_type), obs_id
!      print *, yr_obs,mn_obs,dy_obs
!      print *, hh_obs,mm_obs,ss_obs
!      print *, lat_obs,lon_obs
!      print *, obs_id,nlay_obs,nlev_obs
!      print *, prs_obs(1:nlev_obs)
!      print *, avgk_obs(1:nlay_obs) 
!      print *, prior_obs(1:nlay_obs) 
!      print *, col_amt_obs
!      print *, col_amt_err_obs
!
!--------------------------------------------------------
! Find model O3 profile corresponding to the observation
! TROPOMI O3 and WRF-Chem vertical grids are bottom to top        
!--------------------------------------------------------
      reject=0
      call get_model_profile(prf_model,nz_model, &
      prs_obs*100.,prs_fld(i_min,j_min,:),tmp_fld(i_min,j_min,:), &
      qmr_fld(i_min,j_min,:),o3_fld(i_min,j_min,:), &
      nlev_obs,avgk_obs,prior_obs,kend)
!
!--------------------------------------------------------
! Find vertical location
!--------------------------------------------------------
!
      call vertical_locate(prs_loc,prs_obs,nlev_obs,prf_model,nlay_obs,kend)
      level=prs_loc*100.
!
! Check for maximum localization height
!      if(level/100..lt.level_crit) then
!         reject=1
!         sum_reject=sum_reject+1
!         read(fileid,*,iostat=ios) data_type, obs_id, i_min, j_min
!!         print *, trim(data_type), obs_id
!         deallocate(prs_obs) 
!         deallocate(avgk_obs)
!         deallocate(prior_obs)
!         deallocate(prs_obs_r8) 
!         deallocate(avgk_obs_r8)
!         deallocate(prior_obs_r8)
!         deallocate(prf_model) 
!         cycle
!      endif
!      
! Process accepted observations
      print *, 'localization pressure level (hPa) ',level/100.
      sum_accept=sum_accept+1
!
! Set data for writing obs_sequence file
      qc_count=qc_count+1
!
! Obs value is the tropospheric vertical column
!
      obs_val(:)=col_amt_obs
      obs_err_var=(col_amt_err_obs)**2.
      tropomi_qc(:)=0

      obs_time=set_date(yr_obs,mn_obs,dy_obs,hh_obs,mm_obs,ss_obs)
      call get_time(obs_time, seconds, days)
!
      which_vert=-2      ! undefined
!      which_vert=-1      ! surface
!      which_vert=1       ! level
!      which_vert=2       ! pressure surface
!
      obs_kind = TROPOMI_O3_COLUMN
! (0 <= lon_obs <= 360); (-90 <= lat_obs <= 90)
      obs_location=set_location(lon_obs_r8, lat_obs_r8, level, which_vert)
!
      call set_obs_def_type_of_obs(obs_def, obs_kind)
      call set_obs_def_location(obs_def, obs_location)
      call set_obs_def_time(obs_def, obs_time)
      call set_obs_def_error_variance(obs_def, obs_err_var)
      call set_obs_def_tropomi_o3(qc_count, prs_obs_r8, avgk_obs_r8, prior_obs_r8, nlay_obs)
      call set_obs_def_key(obs_def, qc_count)
      call set_obs_values(obs, obs_val, 1)
      call set_qc(obs, tropomi_qc, num_qc)
      call set_obs_def(obs, obs_def)
!
      old_ob=0
!      print *, 'days, days_last ',days,days_last
!      print *, 'secs, secs_last ',seconds,seconds_last
      if(days.lt.days_last) then
         old_ob=1
      elseif(days.eq.days_last .and. seconds.lt.seconds_last) then
         old_ob=1
      endif
      if(old_ob.eq.0) then
         days_last=days
         seconds_last=seconds
      endif
!      print *, 'APM: ',qc_count,days,seconds
      if ( qc_count == 1 .or. old_ob.eq.1) then
         call insert_obs_in_seq(seq, obs)
      else
         call insert_obs_in_seq(seq, obs, obs_old )
      endif
      obs_old=obs
      deallocate(prs_obs) 
      deallocate(avgk_obs)
      deallocate(prior_obs)
      deallocate(prs_obs_r8) 
      deallocate(avgk_obs_r8)
      deallocate(prior_obs_r8)
      deallocate(prf_model) 
      read(fileid,*,iostat=ios) data_type, obs_id, i_min, j_min
!      print *, trim(data_type), obs_id
   enddo   
!
!----------------------------------------------------------------------
! Write the sequence to a file
!----------------------------------------------------------------------
   deallocate(lon)
   deallocate(lat)
   deallocate(prs_prt)
   deallocate(prs_bas)
   deallocate(prs_fld)
   deallocate(tmp_prt)
   deallocate(tmp_fld)
   deallocate(qmr_fld)
   deallocate(o3_fld)
!
   print *, 'total obs ',sum_total
   print *, 'accepted ',sum_accept
   print *, 'rejected ',sum_reject
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
end program tropomi_o3_ascii_to_obs
!
subroutine vertical_locate(prs_loc,prs_obs,nlev_obs,locl_prf,nlay_obs,kend)
!
! This subroutine identifies a vertical location for 
! vertical positioning/localization 
! 
   implicit none
   integer                         :: nlay_obs,nlev_obs
   integer                         :: k,kstr,kmax,kend
   real                            :: prs_loc
   real                            :: wt_ctr,wt_end
   real                            :: zmax
   real,dimension(nlev_obs)        :: prs_obs
   real,dimension(nlay_obs)        :: locl_prf,locl_prf_sm
!
! apply vertical smoother
!   wt_ctr=2.
!   wt_end=1.
!   avgk_sm(:)=0.
!   do k=1,nlay
!      if(k.eq.1) then
!         avgk_sm(k)=(wt_ctr*avgk(k)+wt_end*avgk(k+1))/(wt_ctr+wt_end)
!         cycle
!      elseif(k.eq.nlay) then
!         avgk_sm(k)=(wt_end*avgk(k-1)+wt_ctr*avgk(k))/(wt_ctr+wt_end)
!         cycle
!      else
!         avgk_sm(k)=(wt_end*avgk(k-1)+wt_ctr*avgk(k)+wt_end*avgk(k+1))/(wt_ctr+2.*wt_end)
!      endif
!   enddo
!
   locl_prf_sm(:)=locl_prf(:)   
! locate maximum
   zmax=-1.e10
   kmax=0
   do k=1,kend
      if(abs(locl_prf_sm(k)).gt.zmax) then
         zmax=abs(locl_prf_sm(k))
         kmax=k
      endif
   enddo
   if(kmax.eq.1) kmax=kmax+1
   prs_loc=(prs_obs(kmax)+prs_obs(kmax+1))/2.
end subroutine vertical_locate
!
subroutine get_model_profile(prf_mdl,nz_mdl,prs_obs,prs_mdl, &
   tmp_mdl,qmr_mdl,o3_mdl,nlev_obs,v_wgts,prior,kend)
   implicit none
   integer                                :: nz_mdl
   integer                                :: nlev_obs
   integer                                :: i,j,k,kend
   real                                   :: Ru,Rd,cp,eps,AvogN,msq2cmsq,grav
   real,dimension(nz_mdl)                 :: prs_mdl,tmp_mdl,qmr_mdl,o3_mdl
   real,dimension(nz_mdl)                 :: tmp_prf,vtmp_prf,o3_prf
   real,dimension(nlev_obs-1)             :: thick,v_wgts,prior,prf_mdl
   real,dimension(nlev_obs)               :: o3_prf_mdl,vtmp_prf_mdl,prs_obs
!
! Constants (mks units)
   Ru=8.316
   Rd=286.9
   cp=1004.
   eps=0.61
   AvogN=6.02214e23
   msq2cmsq=1.e4
   grav=9.8
!
! calculate temperature from potential temperature
   do k=1,nz_mdl
      tmp_prf(k)=tmp_mdl(k)*((prs_mdl(k)/ &
      100000.)**(Rd/cp))
   enddo         
! calculate virtual temperature
   do k=1,nz_mdl
      vtmp_prf(k)=tmp_prf(k)*(1.+eps*qmr_mdl(k))
   enddo         
! convert to molar density         
   do k=1,nz_mdl
      o3_prf(k)=o3_mdl(k)*prs_mdl(k)/Ru/tmp_prf(k)
   enddo
! Vertical interpolation
   o3_prf_mdl(:)=-9999.  
   vtmp_prf_mdl(:)=-9999.   
   call interp_to_obs(o3_prf_mdl,o3_prf,prs_mdl,prs_obs,nz_mdl,nlev_obs,kend)
   call interp_to_obs(vtmp_prf_mdl,vtmp_prf,prs_mdl,prs_obs,nz_mdl,nlev_obs,kend)
!   
! calculate number density times vertical weighting
   prf_mdl(:)=-9999.
   do k=1,nlev_obs-1
      thick(k)=Rd*(vtmp_prf_mdl(k)+vtmp_prf_mdl(k+1))/2./grav* &
      log(prs_obs(k)/prs_obs(k+1))     
   enddo
!
! convert to molecules/cm^2 and apply scattering weights
   do k=1,nlev_obs-1
      prf_mdl(k)=thick(k)*(o3_prf_mdl(k)+o3_prf_mdl(k+1))/2.* &
      AvogN/msq2cmsq*v_wgts(k) + (1.-v_wgts(k))*prior(k)
   enddo
!   print *, 'prf_mdl  ',prf_model(:)
!   print *, 'o3 fld   ',o3_prf_mdl(:)
!   print *, 'avgk_obs ',v_wgts(:)
end subroutine get_model_profile
!
subroutine get_DART_diag_data(file_in,name,data,nx,ny,nz,nc)
   use netcdf
   implicit none
   integer, parameter                    :: maxdim=6
!
   integer                               :: i,icycle,rc,fid,typ,natts
   integer                               :: v_id
   integer                               :: v_ndim
   integer                               :: nx,ny,nz,nc
   integer,dimension(maxdim)             :: one
   integer,dimension(maxdim)             :: v_dimid
   integer,dimension(maxdim)             :: v_dim
!
   character(len=180)                    :: vnam
   character*(*)                         :: name
   character*(*)                         :: file_in
!
   real,dimension(nx,ny,nz,nc)           :: data
!
   ! open netcdf file
   rc = nf90_open(trim(file_in),NF90_NOWRITE,fid)
   if(rc.ne.nf90_noerr) call handle_err(rc,'nf90_open')
!
! get variables identifiers
   rc = nf90_inq_varid(fid,trim(name),v_id)
   if(rc.ne.nf90_noerr) call handle_err(rc,'nf90_inq_varid')
!
! get dimension identifiers
   v_dimid(:)=0
   rc = nf90_inquire_variable(fid,v_id,vnam,typ,v_ndim,v_dimid,natts)
   if(rc.ne.nf90_noerr) call handle_err(rc,'nf90_inquire_variable')
   if(maxdim.lt.v_ndim) then
      print *, 'ERROR: maxdim is too small ',maxdim,v_ndim
      call abort
   endif            
!
! get dimensions
   v_dim(:)=1
   do i=1,v_ndim
      rc = nf90_inquire_dimension(fid,v_dimid(i),len = v_dim(i))
   if(rc.ne.nf90_noerr) call handle_err(rc,'nf90_inquire_dimension')
   enddo
!
! check dimensions
   if(nx.ne.v_dim(1)) then
      print *, 'ERROR: nx dimension conflict ',nx,v_dim(1)
      call abort
   else if(ny.ne.v_dim(2)) then             
      print *, 'ERROR: ny dimension conflict ',ny,v_dim(2)
      call abort
   else if(nz.ne.v_dim(3)) then             
      print *, 'ERROR: nz dimension conflict ',nz,v_dim(3)
      call abort
   else if(nc.ne.v_dim(4)) then             
      print *, 'ERROR: nc dimension conflict ',nc,v_dim(4)
      call abort
   endif
!
! get data
   one(:)=1
   rc = nf90_get_var(fid,v_id,data,one,v_dim)
   if(rc.ne.nf90_noerr) call handle_err(rc,'nf90_get_var')
   rc = nf90_close(fid)
   if(rc.ne.nf90_noerr) call handle_err(rc,'nf90_close')
   return
end subroutine get_DART_diag_data
!
subroutine handle_err(rc,text)
   implicit none
   integer         :: rc
   character*(*)   :: text
   print *, 'APM: NETCDF ERROR ',trim(text),' ',rc
   call abort
end subroutine handle_err
!
subroutine interp_hori_vert(fld1_prf,fld2_prf,fld1_mdl,fld2_mdl,x_mdl,y_mdl, &
   x_obs,y_obs,prs_mdl,prs_obs,nx_mdl,ny_mdl,nz_mdl,nlev_obs,reject,kend)
   implicit none
   integer                                :: nx_mdl,ny_mdl,nz_mdl,nlev_obs
   integer                                :: i,j,k,i_min,j_min,kend
   integer                                :: im,ip,jm,jp,quad,reject
   real                                   :: re,pi,rad2deg
   real                                   :: rad,rad_crit,rad_min,mdl_x,mdl_y,obs_x,obs_y
   real                                   :: dx_dis,dy_dis
   real                                   :: x_obs,y_obs,x_obs_temp
   real                                   :: x_obser,y_obser
   real                                   :: w_q1,w_q2,w_q3,w_q4,wt
   real,dimension(nlev_obs)               :: fld1_prf,fld2_prf,prs_obs
   real,dimension(nz_mdl)                 :: fld1_prf_mdl,fld2_prf_mdl,prs_prf_mdl
   real,dimension(nx_mdl,ny_mdl)          :: x_mdl,y_mdl
   real,dimension(nx_mdl,ny_mdl,nz_mdl)   :: fld1_mdl,fld2_mdl,prs_mdl
   real                                   :: cone_fac,cen_lat,cen_lon,truelat1, &
                                             truelat2,moad_cen_lat,stand_lon, &
                                             pole_lat,pole_lon,xi,xj,zi,zj,zlon,zlat
   integer                                :: ierr
!
! Set constants
   pi=4.*atan(1.)
   rad2deg=360./(2.*pi)
   re=6371000.
   rad_crit=10000.
   reject=0.
!
   cone_fac=.715567   
   cen_lat=40.
   cen_lon=-97.
   truelat1=33.
   truelat2=45.
   moad_cen_lat=40.0000
   stand_lon=-97.
   pole_lat=90.
   pole_lon=0.
!
! Code to test projection and inverse projection
!   zi=nx_mdl
!   zj=ny_mdl
!   call w3fb13(real(y_mdl(zi,zj)),real(x_mdl(zi,zj)+360.), &
!   real(y_mdl(1,1)),real(x_mdl(1,1)+360.),12000.,cen_lon+360.,truelat1,truelat2,xi,xj)
!   print *,'i,j ',zi,zj
!   print *,'lon lat ',x_mdl(zi,zj)+360.,y_mdl(zi,zj)
!   print *, 'xi,xj ',xi,xj
!
!   call w3fb14(xi,xj,real(y_mdl(1,1)),real(x_mdl(1,1)+360.),12000.,cen_lon+360.,truelat1, &
!   truelat2,zlat,zlon,ierr)
!   print *, 'zlon,zlat ',zlon,zlat
!   print *, 'ierr ',ierr
!
! The input grids need to be in degrees
   x_obser=x_obs
   y_obser=y_obs
   if(x_obser.lt.0.) x_obser=(360.+x_obser)
   call w3fb13(y_obser,x_obser,real(y_mdl(1,1)),real(x_mdl(1,1)+360.), &
   12000.,cen_lon+360.,truelat1,truelat2,xi,xj)
   i_min = nint(xi)
   j_min = nint(xj)
!   print *,' '
!   print *,'i_min,j_min ',i_min,j_min
!   print *,'i_max,j_max ',nx_mdl,ny_mdl
!   x_obs_temp=x_obs
!   if(x_obs.gt.180.) x_obs_temp=x_obs-360.
!   print *,'x_obs,y_obs ',x_obs_temp,y_obs
!   print *,'x_mdl(1,1),x_mdl(1,ny_mdl),x_mdl(nx_mdl,1),x_mdl(nx_mdl,ny_mdl) ', &
!   x_mdl(1,1),x_mdl(1,ny_mdl),x_mdl(nx_mdl,1),x_mdl(nx_mdl,ny_mdl)
!   print *,'y_mdl(1,1),y_mdl(1,ny_mdl),y_mdl(nx_mdl,1),y_mdl(nx_mdl,ny_mdl) ', &
!   y_mdl(1,1),y_mdl(1,ny_mdl),y_mdl(nx_mdl,1),y_mdl(nx_mdl,ny_mdl)
!
! Check lower bounds
   if(i_min.lt.1 .and. int(xi).eq.0) then
      i_min=1
   elseif (i_min.lt.1 .and. int(xi).lt.0) then
      i_min=-9999
      j_min=-9999
      reject=1
   endif
   if(j_min.lt.1 .and. int(xj).eq.0) then
      j_min=1
   elseif (j_min.lt.1 .and. int(xj).lt.0) then
      i_min=-9999
      j_min=-9999
      reject=1
   endif
!
! Check upper bounds
   if(i_min.gt.nx_mdl .and. int(xi).eq.nx_mdl) then
      i_min=nx_mdl
   elseif (i_min.gt.nx_mdl .and. int(xi).gt.nx_mdl) then
      i_min=-9999
      j_min=-9999
      reject=1
   endif
   if(j_min.gt.ny_mdl .and. int(xj).eq.ny_mdl) then
      j_min=ny_mdl
   elseif (j_min.gt.ny_mdl .and. int(xj).gt.ny_mdl) then
      i_min=-9999
      j_min=-9999
      reject=1
   endif
!   print *,'i_min,j_min,reject ',i_min,j_min,reject
   if(reject.eq.1) return  
!
! Use model point closest to the observatkon   
   fld1_prf(:)=-9999.
   fld1_prf_mdl(:)=fld1_mdl(i_min,j_min,:)
   fld2_prf_mdl(:)=fld2_mdl(i_min,j_min,:)
   prs_prf_mdl(:)=prs_mdl(i_min,j_min,:)
!
! Vertical interpolation
   call interp_to_obs(fld1_prf,fld1_prf_mdl,prs_prf_mdl,prs_obs,nz_mdl,nlev_obs,kend)
   call interp_to_obs(fld2_prf,fld2_prf_mdl,prs_prf_mdl,prs_obs,nz_mdl,nlev_obs,kend)
   return
!
! This part of subroutine is not used  
! Do horizontal interpolation
   im=i_min-1
   if(im.eq.0) im=1
   ip=i_min+1
   if(ip.eq.nx_mdl+1) ip=nx_mdl
   jm=j_min-1
   if(jm.eq.0) jm=1
   jp=j_min+1
   if(jp.eq.ny_mdl+1) jp=ny_mdl
!
! Find quadrant
   quad=0
   mdl_x=x_mdl(i_min,j_min)
   if(x_mdl(i_min,j_min).lt.0.) mdl_x=360.+x_mdl(i_min,j_min)
   mdl_y=y_mdl(i_min,j_min)
   if(mdl_x.ge.x_obser.and.mdl_y.ge.y_obser) quad=1 
   if(mdl_x.le.x_obser.and.mdl_y.ge.y_obser) quad=2 
   if(mdl_x.le.x_obser.and.mdl_y.le.y_obser) quad=3 
   if(mdl_x.ge.x_obser.and.mdl_y.le.y_obser) quad=4
   if(quad.eq.0) then
      print *, 'APM:ERROR IN PROCEDURE INTERP_HORIONTAL quad = 0 '
      stop
   endif
!
! Quad 1
   if (quad.eq.1) then
      mdl_x=x_mdl(i_min,j_min)
      if(x_mdl(i_min,j_min).lt.0.) mdl_x=360.+x_mdl(i_min,j_min) 
      dx_dis=abs(x_obser-mdl_x)/rad2deg*cos((y_obser+y_mdl(i_min,j_min))/rad2deg/2.)*re
      dy_dis=abs(y_obser-y_mdl(i_min,j_min))/rad2deg*re
      w_q1=sqrt(dx_dis*dx_dis + dy_dis*dy_dis)
      mdl_x=x_mdl(im,j_min)
      if(x_mdl(im,j_min).lt.0.) mdl_x=360.+x_mdl(im,j_min) 
      dx_dis=abs(x_obser-mdl_x)/rad2deg*cos((y_obser+y_mdl(im,j_min))/rad2deg/2.)*re
      dy_dis=abs(y_obser-y_mdl(im,j_min))/rad2deg*re
      w_q2=sqrt(dx_dis*dx_dis + dy_dis*dy_dis)
      mdl_x=x_mdl(im,jm)
      if(x_mdl(im,jm).lt.0.) mdl_x=360.+x_mdl(im,jm) 
      dx_dis=abs(x_obser-mdl_x)/rad2deg*cos((y_obser+y_mdl(im,jm))/rad2deg/2.)*re
      dy_dis=abs(y_obser-y_mdl(im,jm))/rad2deg*re
      w_q3=sqrt(dx_dis*dx_dis + dy_dis*dy_dis)
      mdl_x=x_mdl(i_min,jm)
      if(x_mdl(i_min,jm).lt.0.) mdl_x=360.+x_mdl(i_min,jm) 
      dx_dis=abs(x_obser-mdl_x)/rad2deg*cos((y_obser+y_mdl(i_min,jm))/rad2deg/2.)*re
      dy_dis=abs(y_obser-y_mdl(i_min,jm))/rad2deg*re
      w_q4=sqrt(dx_dis*dx_dis + dy_dis*dy_dis)
! Quad 2
   else if (quad.eq.2) then
      mdl_x=x_mdl(ip,j_min)
      if(x_mdl(ip,j_min).lt.0.) mdl_x=360.+x_mdl(ip,j_min) 
      dx_dis=abs(x_obser-mdl_x)/rad2deg*cos((y_obser+y_mdl(ip,j_min))/rad2deg/2.)*re
      dy_dis=abs(y_obser-y_mdl(ip,j_min))/rad2deg*re
      w_q1=sqrt(dx_dis*dx_dis + dy_dis*dy_dis)
      mdl_x=x_mdl(i_min,j_min)
      if(x_mdl(i_min,j_min).lt.0.) mdl_x=360.+x_mdl(i_min,j_min) 
      dx_dis=abs(x_obser-mdl_x)/rad2deg*cos((y_obser+y_mdl(i_min,j_min))/rad2deg/2.)*re
      dy_dis=abs(y_obser-y_mdl(i_min,j_min))/rad2deg*re
      w_q2=sqrt(dx_dis*dx_dis + dy_dis*dy_dis)
      mdl_x=x_mdl(i_min,jm)
      if(x_mdl(i_min,jm).lt.0.) mdl_x=360.+x_mdl(i_min,jm) 
      dx_dis=abs(x_obser-mdl_x)/rad2deg*cos((y_obser+y_mdl(i_min,jm))/rad2deg/2.)*re
      dy_dis=abs(y_obser-y_mdl(i_min,jm))/rad2deg*re
      w_q3=sqrt(dx_dis*dx_dis + dy_dis*dy_dis)
      mdl_x=x_mdl(ip,jm)
      if(x_mdl(ip,jm).lt.0.) mdl_x=360.+x_mdl(ip,jm) 
      dx_dis=abs(x_obser-mdl_x)/rad2deg*cos((y_obser+y_mdl(ip,jm))/rad2deg/2.)*re
      dy_dis=abs(y_obser-y_mdl(ip,jm))/rad2deg*re
      w_q4=sqrt(dx_dis*dx_dis + dy_dis*dy_dis)
! Quad 3
   else if (quad.eq.3) then
      mdl_x=x_mdl(ip,jp)
      if(x_mdl(ip,jp).lt.0.) mdl_x=360.+x_mdl(ip,jp) 
      dx_dis=abs(x_obser-mdl_x)/rad2deg*cos((y_obser+y_mdl(ip,jp))/rad2deg/2.)*re
      dy_dis=abs(y_obser-y_mdl(ip,jp))/rad2deg*re
      w_q1=sqrt(dx_dis*dx_dis + dy_dis*dy_dis)
      mdl_x=x_mdl(i_min,jp)
      if(x_mdl(i_min,jp).lt.0.) mdl_x=360.+x_mdl(i_min,jp) 
      dx_dis=abs(x_obser-mdl_x)/rad2deg*cos((y_obser+y_mdl(i_min,jp))/rad2deg/2.)*re
      dy_dis=abs(y_obser-y_mdl(i_min,jp))/rad2deg*re
      w_q2=sqrt(dx_dis*dx_dis + dy_dis*dy_dis)
      mdl_x=x_mdl(i_min,j_min)
      if(x_mdl(i_min,j_min).lt.0.) mdl_x=360.+x_mdl(i_min,j_min) 
      dx_dis=abs(x_obser-mdl_x)/rad2deg*cos((y_obser+y_mdl(i_min,j_min))/rad2deg/2.)*re
      dy_dis=abs(y_obser-y_mdl(i_min,j_min))/rad2deg*re
      w_q3=sqrt(dx_dis*dx_dis + dy_dis*dy_dis)
      mdl_x=x_mdl(ip,j_min)
      if(x_mdl(ip,j_min).lt.0.) mdl_x=360.+x_mdl(ip,j_min) 
      dx_dis=abs(x_obser-mdl_x)/rad2deg*cos((y_obser+y_mdl(ip,j_min))/rad2deg/2.)*re
      dy_dis=abs(y_obser-y_mdl(ip,j_min))/rad2deg*re
      w_q4=sqrt(dx_dis*dx_dis + dy_dis*dy_dis)
! Quad 4
   else if (quad.eq.4) then
      mdl_x=x_mdl(i_min,jp)
      if(x_mdl(i_min,jp).lt.0.) mdl_x=360.+x_mdl(i_min,jp) 
      dx_dis=abs(x_obser-mdl_x)/rad2deg*cos((y_obser+y_mdl(i_min,jp))/rad2deg/2.)*re
      dy_dis=abs(y_obser-y_mdl(i_min,jp))/rad2deg*re
      w_q1=sqrt(dx_dis*dx_dis + dy_dis*dy_dis)
      mdl_x=x_mdl(im,jp)
      if(x_mdl(im,jp).lt.0.) mdl_x=360.+x_mdl(im,jp) 
      dx_dis=abs(x_obser-mdl_x)/rad2deg*cos((y_obser+y_mdl(im,jp))/rad2deg/2.)*re
      dy_dis=abs(y_obser-y_mdl(im,jp))/rad2deg*re
      w_q2=sqrt(dx_dis*dx_dis + dy_dis*dy_dis)
      mdl_x=x_mdl(im,jm)
      if(x_mdl(im,jm).lt.0.) mdl_x=360.+x_mdl(im,jm) 
      dx_dis=abs(x_obser-mdl_x)/rad2deg*cos((y_obser+y_mdl(im,jm))/rad2deg/2.)*re
      dy_dis=abs(y_obser-y_mdl(im,jm))/rad2deg*re
      w_q3=sqrt(dx_dis*dx_dis + dy_dis*dy_dis)
      mdl_x=x_mdl(i_min,j_min)
      if(x_mdl(i_min,j_min).lt.0.) mdl_x=360.+x_mdl(i_min,j_min) 
      dx_dis=abs(x_obser-mdl_x)/rad2deg*cos((y_obser+y_mdl(i_min,j_min))/rad2deg/2.)*re
      dy_dis=abs(y_obser-y_mdl(i_min,j_min))/rad2deg*re
      w_q4=sqrt(dx_dis*dx_dis + dy_dis*dy_dis)
   endif
   if(x_obser.ne.x_mdl(i_min,j_min).or.y_obser.ne.y_mdl(i_min,j_min)) then
      wt=1./w_q1+1./w_q2+1./w_q3+1./w_q4
   endif
!
   fld1_prf_mdl(:)=0.
   fld2_prf_mdl(:)=0.
   prs_prf_mdl(:)=0.
   do k=1,nz_mdl
      if(x_obser.eq.x_mdl(i_min,j_min).and.y_obser.eq.y_mdl(i_min,j_min)) then
         fld1_prf_mdl(k)=fld1_mdl(i_min,j_min,k)
         fld2_prf_mdl(k)=fld2_mdl(i_min,j_min,k)
         prs_prf_mdl(k)=prs_mdl(i_min,j_min,k)
      else if(quad.eq.1) then
         fld1_prf_mdl(k)=(1./w_q1*fld1_mdl(i_min,j_min,k)+1./w_q2*fld1_mdl(im,j_min,k)+ &
         1./w_q3*fld1_mdl(im,jm,k)+1./w_q4*fld1_mdl(i_min,jm,k))/wt
         fld2_prf_mdl(k)=(1./w_q1*fld2_mdl(i_min,j_min,k)+1./w_q2*fld2_mdl(im,j_min,k)+ &
         1./w_q3*fld2_mdl(im,jm,k)+1./w_q4*fld2_mdl(i_min,jm,k))/wt
         prs_prf_mdl(k)=(1./w_q1*prs_mdl(i_min,j_min,k)+1./w_q2*prs_mdl(im,j_min,k)+ &
         1./w_q3*prs_mdl(im,jm,k)+1./w_q4*prs_mdl(i_min,jm,k))/wt
      else if(quad.eq.2) then
         fld1_prf_mdl(k)=(1./w_q1*fld1_mdl(ip,j_min,k)+1./w_q2*fld1_mdl(i_min,j_min,k)+ &
         1./w_q3*fld1_mdl(i_min,jm,k)+1./w_q4*fld1_mdl(ip,jm,k))/wt
         fld2_prf_mdl(k)=(1./w_q1*fld2_mdl(ip,j_min,k)+1./w_q2*fld2_mdl(i_min,j_min,k)+ &
         1./w_q3*fld2_mdl(i_min,jm,k)+1./w_q4*fld2_mdl(ip,jm,k))/wt
         prs_prf_mdl(k)=(1./w_q1*prs_mdl(ip,j_min,k)+1./w_q2*prs_mdl(i_min,j_min,k)+ &
         1./w_q3*prs_mdl(i_min,jm,k)+1./w_q4*prs_mdl(ip,jm,k))/wt
      else if(quad.eq.3) then
         fld1_prf_mdl(k)=(1./w_q1*fld1_mdl(ip,jp,k)+1./w_q2*fld1_mdl(i_min,jp,k)+ &
         1./w_q3*fld1_mdl(i_min,j_min,k)+1./w_q4*fld1_mdl(ip,j_min,k))/wt
         fld2_prf_mdl(k)=(1./w_q1*fld2_mdl(ip,jp,k)+1./w_q2*fld2_mdl(i_min,jp,k)+ &
         1./w_q3*fld2_mdl(i_min,j_min,k)+1./w_q4*fld2_mdl(ip,j_min,k))/wt
         prs_prf_mdl(k)=(1./w_q1*prs_mdl(ip,jp,k)+1./w_q2*prs_mdl(i_min,jp,k)+ &
         1./w_q3*prs_mdl(i_min,j_min,k)+1./w_q4*prs_mdl(ip,j_min,k))/wt
      else if(quad.eq.4) then
         fld1_prf_mdl(k)=(1./w_q1*fld1_mdl(i_min,jp,k)+1./w_q2*fld1_mdl(im,jp,k)+ &
         1./w_q3*fld1_mdl(im,j_min,k)+1./w_q4*fld1_mdl(i_min,j_min,k))/wt
         fld2_prf_mdl(k)=(1./w_q1*fld2_mdl(i_min,jp,k)+1./w_q2*fld2_mdl(im,jp,k)+ &
         1./w_q3*fld2_mdl(im,j_min,k)+1./w_q4*fld2_mdl(i_min,j_min,k))/wt
         prs_prf_mdl(k)=(1./w_q1*prs_mdl(i_min,jp,k)+1./w_q2*prs_mdl(im,jp,k)+ &
         1./w_q3*prs_mdl(im,j_min,k)+1./w_q4*prs_mdl(i_min,j_min,k))/wt
      endif 
   enddo
!
! Vertical interpolation
   call interp_to_obs(fld1_prf,fld1_prf_mdl,prs_prf_mdl,prs_obs,nz_mdl,nlev_obs,kend)
   call interp_to_obs(fld2_prf,fld2_prf_mdl,prs_prf_mdl,prs_obs,nz_mdl,nlev_obs,kend)
end subroutine interp_hori_vert
!
subroutine interp_to_obs(prf_mdl,fld_mdl,prs_mdl,prs_obs,nz_mdl,nlev_obs,kend)
! Assumes prs_obs and prs_mdl are bottom to top
   implicit none
   integer                          :: nz_mdl,nlev_obs
   integer                          :: k,kk,kend
   real                             :: wt_dw,wt_up 
   real,dimension(nz_mdl)           :: fld_mdl,prs_mdl
   real,dimension(nlev_obs)         :: prs_obs
   real,dimension(nlev_obs)         :: prf_mdl
!
   prf_mdl(:)=-9999.
   kend=-9999
   do k=1,nlev_obs
      if(prs_obs(k) .gt. prs_mdl(1)) then
         prf_mdl(k)=fld_mdl(1)
         cycle
      endif
      if(prs_obs(k) .lt. prs_mdl(nz_mdl)) then
         prf_mdl(k)=fld_mdl(nz_mdl)
         if(kend.eq.-9999) kend=k-1
         cycle
      endif
      do kk=1,nz_mdl-1
         if(prs_mdl(kk).ge.prs_obs(k) .and. prs_mdl(kk+1).lt.prs_obs(k)) then
            wt_dw=log(prs_mdl(kk))-log(prs_obs(k))
            wt_up=log(prs_obs(k))-log(prs_mdl(kk+1))
            prf_mdl(k)=(wt_up*fld_mdl(kk)+wt_dw*fld_mdl(kk+1))/(wt_dw+wt_up)
            exit
         endif
      enddo               
   enddo
end subroutine interp_to_obs
!
      SUBROUTINE W3FB06(ALAT,ALON,ALAT1,ALON1,DX,ALONV,XI,XJ)
!$$$   SUBPROGRAM  DOCUMENTATION  BLOCK
!
! SUBPROGRAM:  W3FB06        LAT/LON TO POLA (I,J) FOR GRIB
!   PRGMMR: STACKPOLE        ORG: NMC42       DATE:88-04-05
!
! ABSTRACT: CONVERTS THE COORDINATES OF A LOCATION ON EARTH GIVEN IN
!   THE NATURAL COORDINATE SYSTEM OF LATITUDE/LONGITUDE TO A GRID
!   COORDINATE SYSTEM OVERLAID ON A POLAR STEREOGRAPHIC MAP PRO-
!   JECTION TRUE AT 60 DEGREES N OR S LATITUDE. W3FB06 IS THE REVERSE
!   OF W3FB07. USES GRIB SPECIFICATION OF THE LOCATION OF THE GRID
!
! PROGRAM HISTORY LOG:
!   88-01-01  ORIGINAL AUTHOR:  STACKPOLE, W/NMC42
!   90-04-12  R.E.JONES   CONVERT TO CRAY CFT77 FORTRAN
!
! USAGE:  CALL W3FB06 (ALAT,ALON,ALAT1,ALON1,DX,ALONV,XI,XJ)
!   INPUT ARGUMENT LIST:
!     ALAT     - LATITUDE IN DEGREES (NEGATIVE IN SOUTHERN HEMIS)
!     ALON     - EAST LONGITUDE IN DEGREES, REAL*4
!     ALAT1    - LATITUDE  OF LOWER LEFT POINT OF GRID (POINT (1,1))
!     ALON1    - LONGITUDE OF LOWER LEFT POINT OF GRID (POINT (1,1))
!                ALL REAL*4
!     DX       - MESH LENGTH OF GRID IN METERS AT 60 DEG LAT
!                 MUST BE SET NEGATIVE IF USING
!                 SOUTHERN HEMISPHERE PROJECTION.
!                   190500.0 LFM GRID,
!                   381000.0 NH PE GRID, -381000.0 SH PE GRID, ETC.
!     ALONV    - THE ORIENTATION OF THE GRID.  I.E.,
!                THE EAST LONGITUDE VALUE OF THE VERTICAL MERIDIAN
!                WHICH IS PARALLEL TO THE Y-AXIS (OR COLUMNS OF
!                OF THE GRID)ALONG WHICH LATITUDE INCREASES AS
!                THE Y-COORDINATE INCREASES.  REAL*4
!                   FOR EXAMPLE:
!                   255.0 FOR LFM GRID,
!                   280.0 NH PE GRID, 100.0 SH PE GRID, ETC.
!
!   OUTPUT ARGUMENT LIST:
!     XI       - I COORDINATE OF THE POINT SPECIFIED BY ALAT, ALON
!     XJ       - J COORDINATE OF THE POINT BOTH REAL*4
!
!   REMARKS: FORMULAE AND NOTATION LOOSELY BASED ON HOKE, HAYES,
!     AND RENNINGER'S "MAP PROJECTIONS AND GRID SYSTEMS...", MARCH 1981
!     AFGWC/TN-79/003
!
! ATTRIBUTES:
!   LANGUAGE: CRAY CFT77 FORTRAN
!   MACHINE:  CRAY Y-MP8/832
!$$$
         implicit none
         real RERTH,SS60,PI
         real ALAT,ALON,ALAT1,ALON1,DX,ALONV,XI,XJ
         real H,DXL,REFLON,RADPD,REBYDX
         real ALA,ALO,ALA1,ALO1,RM,RMLL,POLEI,POLEJ
!
         RERTH = 6.3712E+6
         PI    = 3.1416
         SS60  = 1.86603
!
!        PRELIMINARY VARIABLES AND REDIFINITIONS
!
!        H = 1 FOR NORTHERN HEMISPHERE; = -1 FOR SOUTHERN
!
!        REFLON IS LONGITUDE UPON WHICH THE POSITIVE X-COORDINATE
!        DRAWN THROUGH THE POLE AND TO THE RIGHT LIES
!        ROTATED AROUND FROM ORIENTATION (Y-COORDINATE) LONGITUDE
!        DIFFERENTLY IN EACH HEMISPHERE
!
         IF (DX.LT.0) THEN
           H      = -1.0
           DXL    = -DX
           REFLON = ALONV - 90.0
         ELSE
           H      = 1.0
           DXL    = DX
           REFLON = ALONV - 270.0
         ENDIF
!
         RADPD  = PI / 180.0
         REBYDX = RERTH/DXL
!
!        RADIUS TO LOWER LEFT HAND (LL) CORNER
!
         ALA1 =  ALAT1 * RADPD
         RMLL = REBYDX * COS(ALA1) * SS60/(1. + H * SIN(ALA1))
!
!        USE LL POINT INFO TO LOCATE POLE POINT
!
         ALO1  = (ALON1 - REFLON) * RADPD
         POLEI = 1. - RMLL * COS(ALO1)
         POLEJ = 1. - H * RMLL * SIN(ALO1)
!
!        RADIUS TO DESIRED POINT AND THE I J TOO
!
         ALA = ALAT   * RADPD
         RM  = REBYDX * COS(ALA) * SS60/(1. + H * SIN(ALA))
!
         ALO = (ALON - REFLON) * RADPD
         XI  = POLEI + RM * COS(ALO)
         XJ  = POLEJ + H * RM * SIN(ALO)
!
      RETURN
      END
!
      SUBROUTINE W3FB07(XI,XJ,ALAT1,ALON1,DX,ALONV,ALAT,ALON)
!$$$   SUBPROGRAM  DOCUMENTATION  BLOCK
!
! SUBPROGRAM:  W3FB07        GRID COORDS TO LAT/LON FOR GRIB
!   PRGMMR: STACKPOLE        ORG: NMC42       DATE:88-04-05
!
! ABSTRACT: CONVERTS THE COORDINATES OF A LOCATION ON EARTH GIVEN IN A
!   GRID COORDINATE SYSTEM OVERLAID ON A POLAR STEREOGRAPHIC MAP PRO-
!   JECTION TRUE AT 60 DEGREES N OR S LATITUDE TO THE
!   NATURAL COORDINATE SYSTEM OF LATITUDE/LONGITUDE
!   W3FB07 IS THE REVERSE OF W3FB06.
!   USES GRIB SPECIFICATION OF THE LOCATION OF THE GRID
!
! PROGRAM HISTORY LOG:
!   88-01-01  ORIGINAL AUTHOR:  STACKPOLE, W/NMC42
!   90-04-12  R.E.JONES   CONVERT TO CRAY CFT77 FORTRAN
!
! USAGE:  CALL W3FB07(XI,XJ,ALAT1,ALON1,DX,ALONV,ALAT,ALON)
!   INPUT ARGUMENT LIST:
!     XI       - I COORDINATE OF THE POINT  REAL*4
!     XJ       - J COORDINATE OF THE POINT  REAL*4
!     ALAT1    - LATITUDE  OF LOWER LEFT POINT OF GRID (POINT 1,1)
!                LATITUDE &lt;0 FOR SOUTHERN HEMISPHERE; REAL*4
!     ALON1    - LONGITUDE OF LOWER LEFT POINT OF GRID (POINT 1,1)
!                  EAST LONGITUDE USED THROUGHOUT; REAL*4
!     DX       - MESH LENGTH OF GRID IN METERS AT 60 DEG LAT
!                 MUST BE SET NEGATIVE IF USING
!                 SOUTHERN HEMISPHERE PROJECTION; REAL*4
!                   190500.0 LFM GRID,
!                   381000.0 NH PE GRID, -381000.0 SH PE GRID, ETC.
!     ALONV    - THE ORIENTATION OF THE GRID.  I.E.,
!                THE EAST LONGITUDE VALUE OF THE VERTICAL MERIDIAN
!                WHICH IS PARALLEL TO THE Y-AXIS (OR COLUMNS OF
!                THE GRID) ALONG WHICH LATITUDE INCREASES AS
!                THE Y-COORDINATE INCREASES.  REAL*4
!                   FOR EXAMPLE:
!                   255.0 FOR LFM GRID,
!                   280.0 NH PE GRID, 100.0 SH PE GRID, ETC.
!
!   OUTPUT ARGUMENT LIST:
!     ALAT     - LATITUDE IN DEGREES (NEGATIVE IN SOUTHERN HEMI.)
!     ALON     - EAST LONGITUDE IN DEGREES, REAL*4
!
!   REMARKS: FORMULAE AND NOTATION LOOSELY BASED ON HOKE, HAYES,
!     AND RENNINGER'S "MAP PROJECTIONS AND GRID SYSTEMS...", MARCH 1981
!     AFGWC/TN-79/003
!
! ATTRIBUTES:
!   LANGUAGE: CRAY CFT77 FORTRAN
!   MACHINE:  CRAY Y-MP8/832
!$$$
         implicit none
         real RERTH,SS60,PI
         real ALAT,ALON,ALAT1,ALON1,DX,ALONV,XI,XJ
         real H,DXL,REFLON,RADPD,DEGPRD,REBYDX
         real ALA,ALO,ALA1,ALO1,RM,RMLL,POLEI,POLEJ
         real XX,YY,R2,GI2,ARCCOS
!
         RERTH = 6.3712E+6
         PI    = 3.1416
         SS60  = 1.86603
!
!        PRELIMINARY VARIABLES AND REDIFINITIONS
!
!        H = 1 FOR NORTHERN HEMISPHERE; = -1 FOR SOUTHERN
!
!        REFLON IS LONGITUDE UPON WHICH THE POSITIVE X-COORDINATE
!        DRAWN THROUGH THE POLE AND TO THE RIGHT LIES
!        ROTATED AROUND FROM ORIENTATION (Y-COORDINATE) LONGITUDE
!        DIFFERENTLY IN EACH HEMISPHERE
!
         IF (DX.LT.0) THEN
           H      = -1.0
           DXL    = -DX
           REFLON = ALONV - 90.0
         ELSE
           H      = 1.0
           DXL    = DX
           REFLON = ALONV - 270.0
         ENDIF
!
         RADPD  = PI    / 180.0
         DEGPRD = 180.0 / PI
         REBYDX = RERTH / DXL
!
!        RADIUS TO LOWER LEFT HAND (LL) CORNER
!
         ALA1 =  ALAT1 * RADPD
         RMLL = REBYDX * COS(ALA1) * SS60/(1. + H * SIN(ALA1))
!
!        USE LL POINT INFO TO LOCATE POLE POINT
!
         ALO1 = (ALON1 - REFLON) * RADPD
         POLEI = 1. - RMLL * COS(ALO1)
         POLEJ = 1. - H * RMLL * SIN(ALO1)
!
!        RADIUS TO THE I,J POINT (IN GRID UNITS)
!
         XX =  XI - POLEI
         YY = (XJ - POLEJ) * H
         R2 =  XX**2 + YY**2
!
!        NOW THE MAGIC FORMULAE
!
         IF (R2.EQ.0) THEN
           ALAT = H * 90.
           ALON = REFLON
         ELSE
           GI2    = (REBYDX * SS60)**2
           ALAT   = DEGPRD * H * ASIN((GI2 - R2)/(GI2 + R2))
           ARCCOS = ACOS(XX/SQRT(R2))
           IF (YY.GT.0) THEN
             ALON = REFLON + DEGPRD * ARCCOS
           ELSE
             ALON = REFLON - DEGPRD * ARCCOS
           ENDIF
         ENDIF
         IF (ALON.LT.0) ALON = ALON + 360.
!
      RETURN
      END
!
      SUBROUTINE W3FB08(ALAT,ALON,ALAT1,ALON1,ALATIN,DX,XI,XJ)
!$$$   SUBPROGRAM  DOCUMENTATION  BLOCK
!
! SUBPROGRAM:  W3FB08        LAT/LON TO MERC (I,J) FOR GRIB
!   PRGMMR: STACKPOLE        ORG: NMC42       DATE:88-04-05
!
! ABSTRACT: CONVERTS A LOCATION ON EARTH GIVEN IN
!   THE COORDINATE SYSTEM OF LATITUDE/LONGITUDE TO AN (I,J)
!   COORDINATE SYSTEM OVERLAID ON A MERCATOR MAP PROJECTION
!   W3FB08 IS THE REVERSE OF W3FB09
!   USES GRIB SPECIFICATION OF THE LOCATION OF THE GRID
!
! PROGRAM HISTORY LOG:
!   88-03-01  ORIGINAL AUTHOR:  STACKPOLE, W/NMC42
!   90-04-12  R.E.JONES   CONVERT TO CRAY CFT77 FORTRAN
!
! USAGE:  CALL W3FB08 (ALAT,ALON,ALAT1,ALON1,ALATIN,DX,XI,XJ)
!   INPUT ARGUMENT LIST:
!     ALAT     - LATITUDE IN DEGREES (NEGATIVE IN SOUTHERN HEMIS)
!     ALON     - EAST LONGITUDE IN DEGREES, REAL*4
!     ALAT1    - LATITUDE  OF LOWER LEFT CORNER OF GRID (POINT (1,1))
!     ALON1    - LONGITUDE OF LOWER LEFT CORNER OF GRID (POINT (1,1))
!                ALL REAL*4
!     ALATIN   - THE LATITUDE AT WHICH THE MERCATOR CYLINDER
!                INTERSECTS THE EARTH
!     DX       - MESH LENGTH OF GRID IN METERS AT ALATIN
!
!   OUTPUT ARGUMENT LIST:
!     XI       - I COORDINATE OF THE POINT SPECIFIED BY ALAT, ALON
!     XJ       - J COORDINATE OF THE POINT; BOTH REAL*4
!
!   REMARKS: FORMULAE AND NOTATION LOOSELY BASED ON HOKE, HAYES,
!     AND RENNINGER'S "MAP PROJECTIONS AND GRID SYSTEMS...", MARCH 1981
!     AFGWC/TN-79/003
!
! ATTRIBUTES:
!   LANGUAGE: CRAY CFT77 FORTRAN
!   MACHINE:  CRAY Y-MP8/832
!$$$
         implicit none
         real ALAT,ALON,ALAT1,ALON1,ALATIN,DX,XI,XJ
         real RERTH,PI,RADPD,DEGPR,CLAIN,DELLON,DJEO
!
         RERTH  = 6.3712E+6
         PI     = 3.1416
!
!        PRELIMINARY VARIABLES AND REDIFINITIONS
!
         RADPD  = PI    / 180.0
         DEGPR  = 180.0 / PI
         CLAIN  = COS(RADPD*ALATIN)
         DELLON = DX   / (RERTH*CLAIN)
!
!        GET DISTANCE FROM EQUATOR TO ORIGIN ALAT1
!
         DJEO = 0.
         IF (ALAT1.NE.0.) &
          DJEO = (ALOG(TAN(0.5*((ALAT1+90.0)*RADPD))))/DELLON
!
!        NOW THE I AND J COORDINATES
!
         XI = 1. + ((ALON - ALON1)/(DELLON*DEGPR))
         XJ = 1. + (ALOG(TAN(0.5*((ALAT + 90.) * RADPD))))/ &
               DELLON - DJEO
!
      RETURN
      END
!
      SUBROUTINE W3FB09(XI,XJ,ALAT1,ALON1,ALATIN,DX,ALAT,ALON)
!$$$   SUBPROGRAM  DOCUMENTATION  BLOCK
!
! SUBPROGRAM:  W3FB09        MERC (I,J) TO LAT/LON FOR GRIB
!   PRGMMR: STACKPOLE        ORG: NMC42       DATE:88-04-05
!
! ABSTRACT: CONVERTS A LOCATION ON EARTH GIVEN IN
!   AN I,J COORDINATE SYSTEM OVERLAID ON A MERCATOR MAP PROJECTION
!   TO THE COORDINATE SYSTEM OF LATITUDE/LONGITUDE
!   W3FB09 IS THE REVERSE OF W3FB08
!   USES GRIB SPECIFICATION OF THE LOCATION OF THE GRID
!
! PROGRAM HISTORY LOG:
!   88-03-01  ORIGINAL AUTHOR:  STACKPOLE, W/NMC42
!   90-04-12  R.E.JONES   CONVERT TO CRAY CFT77 FORTRAN
!
! USAGE:  CALL W3FB09 (XI,XJ,ALAT1,ALON1,ALATIN,DX,ALAT,ALON)
!   INPUT ARGUMENT LIST:
!     XI       - I COORDINATE OF THE POINT
!     XJ       - J COORDINATE OF THE POINT; BOTH REAL*4
!     ALAT1    - LATITUDE  OF LOWER LEFT CORNER OF GRID (POINT (1,1))
!     ALON1    - LONGITUDE OF LOWER LEFT CORNER OF GRID (POINT (1,1))
!                ALL REAL*4
!     ALATIN   - THE LATITUDE AT WHICH THE MERCATOR CYLINDER
!                INTERSECTS THE EARTH
!     DX       - MESH LENGTH OF GRID IN METERS AT ALATIN
!
!   OUTPUT ARGUMENT LIST:
!     ALAT     - LATITUDE IN DEGREES (NEGATIVE IN SOUTHERN HEMIS)
!     ALON     - EAST LONGITUDE IN DEGREES, REAL*4
!              - OF THE POINT SPECIFIED BY (I,J)
!
!   REMARKS: FORMULAE AND NOTATION LOOSELY BASED ON HOKE, HAYES,
!     AND RENNINGER'S "MAP PROJECTIONS AND GRID SYSTEMS...", MARCH 1981
!     AFGWC/TN-79/003
!
! ATTRIBUTES:
!   LANGUAGE: CRAY CFT77 FORTRAN
!   MACHINE:  CRAY Y-MP8/832
!$$$
         implicit none
         real ALAT,ALON,ALAT1,ALON1,ALATIN,DX,XI,XJ
         real RERTH,PI,RADPD,DEGPR,CLAIN,DELLON,DJEO
!
         RERTH  = 6.3712E+6
         PI     = 3.1416
!
!        PRELIMINARY VARIABLES AND REDIFINITIONS
!
         RADPD  = PI    / 180.0
         DEGPR  = 180.0 / PI
         CLAIN  = COS(RADPD*ALATIN)
         DELLON = DX   / (RERTH*CLAIN)
!
!        GET DISTANCE FROM EQUATOR TO ORIGIN ALAT1
!
         DJEO = 0.
         IF (ALAT1.NE.0.) &
          DJEO = (ALOG(TAN(0.5*((ALAT1+90.0)*RADPD))))/DELLON
!
!        NOW THE LAT AND LON
!
         ALAT = 2.0*ATAN(EXP(DELLON*(DJEO + XJ-1.)))*DEGPR - 90.0
         ALON = (XI-1.) * DELLON * DEGPR + ALON1
!
      RETURN
      END
!
      SUBROUTINE W3FB11(ALAT,ELON,ALAT1,ELON1,DX,ELONV,ALATAN,XI,XJ)
!$$$   SUBPROGRAM  DOCUMENTATION  BLOCK
!
! SUBPROGRAM:  W3FB11        LAT/LON TO LAMBERT(I,J) FOR GRIB
!   PRGMMR: STACKPOLE        ORG: NMC42       DATE:88-11-28
!
! ABSTRACT: CONVERTS THE COORDINATES OF A LOCATION ON EARTH GIVEN IN
!   THE NATURAL COORDINATE SYSTEM OF LATITUDE/LONGITUDE TO A GRID
!   COORDINATE SYSTEM OVERLAID ON A LAMBERT CONFORMAL TANGENT CONE
!   PROJECTION TRUE AT A GIVEN N OR S LATITUDE. W3FB11 IS THE REVERSE
!   OF W3FB12. USES GRIB SPECIFICATION OF THE LOCATION OF THE GRID
!
! PROGRAM HISTORY LOG:
!   88-11-25  ORIGINAL AUTHOR:  STACKPOLE, W/NMC42
!   90-04-12  R.E.JONES   CONVERT TO CFT77 FORTRAN
!   94-04-28  R.E.JONES   ADD SAVE STATEMENT
!
! USAGE:  CALL W3FB11 (ALAT,ELON,ALAT1,ELON1,DX,ELONV,ALATAN,XI,XJ)
!   INPUT ARGUMENT LIST:
!     ALAT     - LATITUDE IN DEGREES (NEGATIVE IN SOUTHERN HEMIS)
!     ELON     - EAST LONGITUDE IN DEGREES, REAL*4
!     ALAT1    - LATITUDE  OF LOWER LEFT POINT OF GRID (POINT (1,1))
!     ELON1    - LONGITUDE OF LOWER LEFT POINT OF GRID (POINT (1,1))
!                ALL REAL*4
!     DX       - MESH LENGTH OF GRID IN METERS AT TANGENT LATITUDE
!     ELONV    - THE ORIENTATION OF THE GRID.  I.E.,
!                THE EAST LONGITUDE VALUE OF THE VERTICAL MERIDIAN
!                WHICH IS PARALLEL TO THE Y-AXIS (OR COLUMNS OF
!                OF THE GRID) ALONG WHICH LATITUDE INCREASES AS
!                THE Y-COORDINATE INCREASES.  REAL*4
!                THIS IS ALSO THE MERIDIAN (ON THE BACK SIDE OF THE
!                TANGENT CONE) ALONG WHICH THE CUT IS MADE TO LAY
!                THE CONE FLAT.
!     ALATAN   - THE LATITUDE AT WHICH THE LAMBERT CONE IS TANGENT TO
!                (TOUCHING) THE SPHERICAL EARTH.
!                 SET NEGATIVE TO INDICATE A
!                 SOUTHERN HEMISPHERE PROJECTION.
!
!   OUTPUT ARGUMENT LIST:
!     XI       - I COORDINATE OF THE POINT SPECIFIED BY ALAT, ELON
!     XJ       - J COORDINATE OF THE POINT; BOTH REAL*4
!
!   REMARKS: FORMULAE AND NOTATION LOOSELY BASED ON HOKE, HAYES,
!     AND RENNINGER'S "MAP PROJECTIONS AND GRID SYSTEMS...", MARCH 1981
!     AFGWC/TN-79/003
!
! ATTRIBUTES:
!   LANGUAGE: CRAY CFT77 FORTRAN
!   MACHINE:  CRAY C916-128, CRAY Y-MP8/864, CRAY Y-MP EL2/256
!$$$
         implicit none
         real ALAT,ELON,ALAT1,ELON1,DX,ELONV,ALATAN,XI,XJ
         real RERTH,PI,H,RADPD,REBYDX,ALATN1,AN,COSLTN,ELON1L
         real ELONL,ELONVR,ALA1,RMLL,ELO1,ARG,POLEI,POLEJ,ALA,RM,ELO
!
         RERTH  = 6.3712E+6
         PI     = 3.1416

!
!        PRELIMINARY VARIABLES AND REDIFINITIONS
!
!        H = 1 FOR NORTHERN HEMISPHERE; = -1 FOR SOUTHERN
!
         IF (ALATAN.GT.0) THEN
           H = 1.
         ELSE
           H = -1.
         ENDIF
!
         RADPD  = PI    / 180.0
         REBYDX = RERTH / DX
         ALATN1 = ALATAN * RADPD
         AN     = H * SIN(ALATN1)
         COSLTN = COS(ALATN1)

!        MAKE SURE THAT INPUT LONGITUDES DO NOT PASS THROUGH
!        THE CUT ZONE (FORBIDDEN TERRITORY) OF THE FLAT MAP
!        AS MEASURED FROM THE VERTICAL (REFERENCE) LONGITUDE.
!
         ELON1L = ELON1
         IF ((ELON1 - ELONV).GT.180.) &
          ELON1L = ELON1 - 360.
         IF ((ELON1 - ELONV).LT.(-180.)) &
          ELON1L = ELON1 + 360.
!
         ELONL = ELON
         IF ((ELON  - ELONV).GT.180.) &
          ELONL  = ELON  - 360.
         IF ((ELON - ELONV).LT.(-180.)) &
          ELONL = ELON + 360.
!
         ELONVR = ELONV * RADPD
!
!        RADIUS TO LOWER LEFT HAND (LL) CORNER
!
         ALA1 =  ALAT1 * RADPD
         RMLL = REBYDX * (((COSLTN)**(1.-AN))*(1.+AN)**AN) * &
                (((COS(ALA1))/(1.+H*SIN(ALA1)))**AN)/AN
!
!        USE LL POINT INFO TO LOCATE POLE POINT
!
         ELO1 = ELON1L * RADPD
         ARG = AN * (ELO1-ELONVR)
         POLEI = 1. - H * RMLL * SIN(ARG)
         POLEJ = 1. + RMLL * COS(ARG)
!
!        RADIUS TO DESIRED POINT AND THE I J TOO
!
         ALA =  ALAT * RADPD
         RM = REBYDX * ((COSLTN**(1.-AN))*(1.+AN)**AN) * &
              (((COS(ALA))/(1.+H*SIN(ALA)))**AN)/AN
!
         ELO = ELONL * RADPD
         ARG = AN*(ELO-ELONVR)
         XI = POLEI + H * RM * SIN(ARG)
         XJ = POLEJ - RM * COS(ARG)
!
!        IF COORDINATE LESS THAN 1
!        COMPENSATE FOR ORIGIN AT (1,1)
!
         IF (XI.LT.1.)  XI = XI - 1.
         IF (XJ.LT.1.)  XJ = XJ - 1.
!
      RETURN
      END
!
      SUBROUTINE W3FB12(XI,XJ,ALAT1,ELON1,DX,ELONV,ALATAN,ALAT,ELON, &
                 IERR)
!$$$   SUBPROGRAM  DOCUMENTATION  BLOCK
!
! SUBPROGRAM:  W3FB12        LAMBERT(I,J) TO LAT/LON FOR GRIB
!   PRGMMR: STACKPOLE        ORG: NMC42       DATE:88-11-28
!
! ABSTRACT: CONVERTS THE COORDINATES OF A LOCATION ON EARTH GIVEN IN A
!   GRID COORDINATE SYSTEM OVERLAID ON A LAMBERT CONFORMAL TANGENT
!   CONE PROJECTION TRUE AT A GIVEN N OR S LATITUDE TO THE
!   NATURAL COORDINATE SYSTEM OF LATITUDE/LONGITUDE
!   W3FB12 IS THE REVERSE OF W3FB11.
!   USES GRIB SPECIFICATION OF THE LOCATION OF THE GRID
!
! PROGRAM HISTORY LOG:
!   88-11-25  ORIGINAL AUTHOR:  STACKPOLE, W/NMC42
!   90-04-12  R.E.JONES   CONVERT TO CFT77 FORTRAN
!   94-04-28  R.E.JONES   ADD SAVE STATEMENT
!
! USAGE:  CALL W3FB12(XI,XJ,ALAT1,ELON1,DX,ELONV,ALATAN,ALAT,ELON,IERR,
!                                   IERR)
!   INPUT ARGUMENT LIST:
!     XI       - I COORDINATE OF THE POINT  REAL*4
!     XJ       - J COORDINATE OF THE POINT  REAL*4
!     ALAT1    - LATITUDE  OF LOWER LEFT POINT OF GRID (POINT 1,1)
!                LATITUDE &lt;0 FOR SOUTHERN HEMISPHERE; REAL*4
!     ELON1    - LONGITUDE OF LOWER LEFT POINT OF GRID (POINT 1,1)
!                  EAST LONGITUDE USED THROUGHOUT; REAL*4
!     DX       - MESH LENGTH OF GRID IN METERS AT TANGENT LATITUDE
!     ELONV    - THE ORIENTATION OF THE GRID.  I.E.,
!                THE EAST LONGITUDE VALUE OF THE VERTICAL MERIDIAN
!                WHICH IS PARALLEL TO THE Y-AXIS (OR COLUMNS OF
!                THE GRID) ALONG WHICH LATITUDE INCREASES AS
!                THE Y-COORDINATE INCREASES.  REAL*4
!                THIS IS ALSO THE MERIDIAN (ON THE OTHER SIDE OF THE
!                TANGENT CONE) ALONG WHICH THE CUT IS MADE TO LAY
!                THE CONE FLAT.
!     ALATAN   - THE LATITUDE AT WHICH THE LAMBERT CONE IS TANGENT TO
!                (TOUCHES OR OSCULATES) THE SPHERICAL EARTH.
!                 SET NEGATIVE TO INDICATE A
!                 SOUTHERN HEMISPHERE PROJECTION; REAL*4
!
!   OUTPUT ARGUMENT LIST:
!     ALAT     - LATITUDE IN DEGREES (NEGATIVE IN SOUTHERN HEMI.)
!     ELON     - EAST LONGITUDE IN DEGREES, REAL*4
!     IERR     - .EQ. 0   IF NO PROBLEM
!                .GE. 1   IF THE REQUESTED XI,XJ POINT IS IN THE
!                         FORBIDDEN ZONE, I.E. OFF THE LAMBERT MAP
!                         IN THE OPEN SPACE WHERE THE CONE IS CUT.
!                  IF IERR.GE.1 THEN ALAT=999. AND ELON=999.
!
!   REMARKS: FORMULAE AND NOTATION LOOSELY BASED ON HOKE, HAYES,
!     AND RENNINGER'S "MAP PROJECTIONS AND GRID SYSTEMS...", MARCH 1981
!     AFGWC/TN-79/003
!
! ATTRIBUTES:
!   LANGUAGE: CRAY CFT77 FORTRAN
!   MACHINE:  CRAY C916-128, CRAY Y-MP8/864, CRAY Y-MP EL2/256
!$$$
         implicit none
         real ALAT,ELON,ALAT1,ELON1,DX,ELONV,ALATAN,XI,XJ
         real RERTH,PI,OLDRML,H,PIBY2,RADPD,DEGPRD,REBYDX,ALATN1,AN
         real COSLTN,ELON1L,ELONVR,ALA1,RMLL,ELO1,ARG,POLEI,POLEJ
         real XX,YY,R2,THETA,BETA,ANINV,ANINV2,THING
         integer IERR
         logical NEWMAP
!
         RERTH  = 6.3712E+6
         PI     = 3.1416
         OLDRML = 99999.
!
!        PRELIMINARY VARIABLES AND REDIFINITIONS
!
!        H = 1 FOR NORTHERN HEMISPHERE; = -1 FOR SOUTHERN
!
         IF (ALATAN.GT.0) THEN
           H = 1.
         ELSE
           H = -1.
         ENDIF
!
         PIBY2  = PI     / 2.0
         RADPD  = PI     / 180.0
         DEGPRD = 1.0    / RADPD
         REBYDX = RERTH  / DX
         ALATN1 = ALATAN * RADPD
         AN     = H * SIN(ALATN1)
         COSLTN = COS(ALATN1)
!
!        MAKE SURE THAT INPUT LONGITUDE DOES NOT PASS THROUGH
!        THE CUT ZONE (FORBIDDEN TERRITORY) OF THE FLAT MAP
!        AS MEASURED FROM THE VERTICAL (REFERENCE) LONGITUDE
!
         ELON1L = ELON1
         IF ((ELON1-ELONV).GT.180.) &
          ELON1L = ELON1 - 360.
         IF ((ELON1-ELONV).LT.(-180.)) &
          ELON1L = ELON1 + 360.
!
         ELONVR = ELONV * RADPD
!
!        RADIUS TO LOWER LEFT HAND (LL) CORNER
!
         ALA1 =  ALAT1 * RADPD
         RMLL = REBYDX * ((COSLTN**(1.-AN))*(1.+AN)**AN) * &
                (((COS(ALA1))/(1.+H*SIN(ALA1)))**AN)/AN
!
!        USE RMLL TO TEST IF MAP AND GRID UNCHANGED FROM PREVIOUS
!        CALL TO THIS CODE.  THUS AVOID UNNEEDED RECOMPUTATIONS.
!
         IF (RMLL.EQ.OLDRML) THEN
           NEWMAP = .FALSE.
         ELSE
           NEWMAP = .TRUE.
           OLDRML = RMLL
!
!          USE LL POINT INFO TO LOCATE POLE POINT
!
           ELO1 = ELON1L * RADPD
           ARG = AN * (ELO1-ELONVR)
           POLEI = 1. - H * RMLL * SIN(ARG)
           POLEJ = 1. + RMLL * COS(ARG)
         ENDIF
!
!        RADIUS TO THE I,J POINT (IN GRID UNITS)
!              YY REVERSED SO POSITIVE IS DOWN
!
         XX = XI - POLEI
         YY = POLEJ - XJ
         R2 = XX**2 + YY**2
!
!        CHECK THAT THE REQUESTED I,J IS NOT IN THE FORBIDDEN ZONE
!           YY MUST BE POSITIVE UP FOR THIS TEST
!
         THETA = PI*(1.-AN)
         BETA = ABS(ATAN2(XX,-YY))
         IERR = 0
         IF (BETA.LE.THETA) THEN
           IERR = 1
           ALAT = 999.
           ELON = 999.
           IF (.NOT.NEWMAP)  RETURN
         ENDIF
!
!        NOW THE MAGIC FORMULAE
!
         IF (R2.EQ.0) THEN
           ALAT = H * 90.0
           ELON = ELONV
         ELSE
!
!          FIRST THE LONGITUDE
!
           ELON = ELONV + DEGPRD * ATAN2(H*XX,YY)/AN
           ELON = AMOD(ELON+360., 360.)
!
!          NOW THE LATITUDE
!          RECALCULATE THE THING ONLY IF MAP IS NEW SINCE LAST TIME
!
           IF (NEWMAP) THEN
             ANINV = 1./AN
             ANINV2 = ANINV/2.
             THING = ((AN/REBYDX) ** ANINV)/ &
              ((COSLTN**((1.-AN)*ANINV))*(1.+ AN))
           ENDIF
           ALAT = H*(PIBY2 - 2.*ATAN(THING*(R2**ANINV2)))*DEGPRD
         ENDIF
!
!        FOLLOWING TO ASSURE ERROR VALUES IF FIRST TIME THRU
!         IS OFF THE MAP
!
         IF (IERR.NE.0) THEN
           ALAT = 999.
           ELON = 999.
           IERR = 2
         ENDIF
      RETURN
      END
!
      SUBROUTINE W3FB13(ALAT,ELON,ALAT1,ELON1,DX,ELONV,ALATAN1,ALATAN2,XI,XJ)
!$$$   SUBPROGRAM  DOCUMENTATION  BLOCK
!
! SUBPROGRAM:  W3FB13        LAT/LON TO LAMBERT(I,J) FOR GRIB
!   PRGMMR: STACKPOLE        ORG: NMC42       DATE:88-11-28
!
! ABSTRACT: CONVERTS THE COORDINATES OF A LOCATION ON EARTH GIVEN IN
!   THE NATURAL COORDINATE SYSTEM OF LATITUDE/LONGITUDE TO A GRID
!   COORDINATE SYSTEM OVERLAID ON A LAMBERT CONFORMAL CONE
!   PROJECTION TRUE AT A GIVEN N OR S LATITUDE. W3FB13 IS THE REVERSE
!   OF W3FB14. USES GRIB SPECIFICATION OF THE LOCATION OF THE GRID
!
! PROGRAM HISTORY LOG:
!   88-11-25  ORIGINAL AUTHOR:  STACKPOLE, W/NMC42
!   90-04-12  R.E.JONES   CONVERT TO CFT77 FORTRAN
!   94-04-28  R.E.JONES   ADD SAVE STATEMENT
! 2003-06-21  GILBERT     MODIFIED FROM W3FB11 AND ADDED SUPPORT FOR
!                         SECANT CONE AS WELL AS TANGENTIAL.
!
! USAGE:  CALL W3FB13 (ALAT,ELON,ALAT1,ELON1,DX,ELONV,ALATAN1,ALATAN2,XI,XJ)
!   INPUT ARGUMENT LIST:
!     ALAT     - LATITUDE IN DEGREES (NEGATIVE IN SOUTHERN HEMIS)
!     ELON     - EAST LONGITUDE IN DEGREES, REAL*4
!     ALAT1    - LATITUDE  OF LOWER LEFT POINT OF GRID (POINT (1,1))
!     ELON1    - LONGITUDE OF LOWER LEFT POINT OF GRID (POINT (1,1))
!                ALL REAL*4
!     DX       - MESH LENGTH OF GRID IN METERS AT TANGENT LATITUDE
!     ELONV    - THE ORIENTATION OF THE GRID.  I.E.,
!                THE EAST LONGITUDE VALUE OF THE VERTICAL MERIDIAN
!                WHICH IS PARALLEL TO THE Y-AXIS (OR COLUMNS OF
!                OF THE GRID) ALONG WHICH LATITUDE INCREASES AS
!                THE Y-COORDINATE INCREASES.  REAL*4
!                THIS IS ALSO THE MERIDIAN (ON THE BACK SIDE OF THE
!                TANGENT CONE) ALONG WHICH THE CUT IS MADE TO LAY
!                THE CONE FLAT.
!     ALATAN1  - THE 1ST LATITUDE FROM THE POLE AT WHICH THE LAMBERT CONE 
!                INTERSECTS THE SPHERICAL EARTH.
!                SET NEGATIVE TO INDICATE A SOUTHERN HEMISPHERE PROJECTION.
!                (IF ALATAN1.EQ.ALATAN2 PROJECTION IS ON TANGENT CONE)
!     ALATAN2  - THE 2ND LATITUDE FROM THE POLE AT WHICH THE LAMBERT CONE 
!                INTERSECTS THE SPHERICAL EARTH.
!                SET NEGATIVE TO INDICATE A SOUTHERN HEMISPHERE PROJECTION.
!
!   OUTPUT ARGUMENT LIST:
!     XI       - I COORDINATE OF THE POINT SPECIFIED BY ALAT, ELON
!     XJ       - J COORDINATE OF THE POINT; BOTH REAL*4
!
!   REMARKS: FORMULAE AND NOTATION LOOSELY BASED ON HOKE, HAYES,
!     AND RENNINGER'S "MAP PROJECTIONS AND GRID SYSTEMS...", MARCH 1981
!     AFGWC/TN-79/003
!
! ATTRIBUTES:
!   LANGUAGE: CRAY CFT77 FORTRAN
!   MACHINE:  CRAY C916-128, CRAY Y-MP8/864, CRAY Y-MP EL2/256
!$$$
         implicit none
         real ALAT,ELON,ALAT1,ELON1,DX,ELONV,ALATAN1,ALATAN2
         real RERTH,PI,H,RADPD,REBYDX,ALATN1,ALATN2,AN,COSLTN
         real ELONL,ELON1L,ELONVR,ALA,ALA1,PSI,RMLL,ELO1,ARG,POLEI,POLEJ
         real RM,ELO,XI,XJ
!
         RERTH  = 6.3712E+6
         PI     = 3.14159
!
!        PRELIMINARY VARIABLES AND REDIFINITIONS
!
!        H = 1 FOR NORTHERN HEMISPHERE; = -1 FOR SOUTHERN
!
         IF (ALATAN1.GT.0) THEN
           H = 1.
         ELSE
           H = -1.
         ENDIF
!
         RADPD  = PI    / 180.0
         REBYDX = RERTH / DX
         ALATN1 = ALATAN1 * RADPD
         ALATN2 = ALATAN2 * RADPD
         IF (ALATAN1.EQ.ALATAN2) THEN
            AN     = H * SIN(ALATN1)
         ELSE
           AN=LOG(COS(ALATN1)/COS(ALATN2))/ &
              LOG(TAN(((H*PI/2.)-ALATN1)/2.)/TAN(((H*PI/2.)-ALATN2)/2.))
         ENDIF
         COSLTN = COS(ALATN2)
!
!        MAKE SURE THAT INPUT LONGITUDES DO NOT PASS THROUGH
!        THE CUT ZONE (FORBIDDEN TERRITORY) OF THE FLAT MAP
!        AS MEASURED FROM THE VERTICAL (REFERENCE) LONGITUDE.
!
         ELON1L = ELON1
         IF ((ELON1 - ELONV).GT.180.) ELON1L = ELON1 - 360.
         IF ((ELON1 - ELONV).LT.(-180.)) ELON1L = ELON1 + 360.
!
         ELONL = ELON
         IF ((ELON  - ELONV).GT.180.) ELONL  = ELON  - 360.
         IF ((ELON - ELONV).LT.(-180.)) ELONL = ELON + 360.
!
         ELONVR = ELONV * RADPD
!
!        RADIUS TO LOWER LEFT HAND (LL) CORNER
!
         ALA1 =  ALAT1 * RADPD
!         RMLL = REBYDX * (((COSLTN)**(1.-AN))*(1.+AN)**AN) * &
!                (((COS(ALA1))/(1.+H*SIN(ALA1)))**AN)/AN
         PSI=(REBYDX*COSLTN)/(AN*(TAN((PI/4.)-(H*ALATN2/2.))**AN))
         RMLL=PSI*(TAN((PI/4.)-(H*ALA1/2.))**AN)
!
!        USE LL POINT INFO TO LOCATE POLE POINT
!
         ELO1 = ELON1L * RADPD
         ARG = AN * (ELO1-ELONVR)
         POLEI = 1. - H * RMLL * SIN(ARG)
         POLEJ = 1. + RMLL * COS(ARG)

!
!        RADIUS TO DESIRED POINT AND THE I J TOO
!
         ALA =  ALAT * RADPD
!         RM = REBYDX * ((COSLTN**(1.-AN))*(1.+AN)**AN) * &
!              (((COS(ALA))/(1.+H*SIN(ALA)))**AN)/AN
!
         RM=PSI*(TAN((PI/4.)-(H*ALA/2.))**AN)
         ELO = ELONL * RADPD
         ARG = AN*(ELO-ELONVR)
         XI = POLEI + H * RM * SIN(ARG)
         XJ = POLEJ - RM * COS(ARG)
!
!        IF COORDINATE LESS THAN 1
!        COMPENSATE FOR ORIGIN AT (1,1)
!
         IF (NINT(XI).LT.1)  XI = XI - 1.
         IF (NINT(XJ).LT.1)  XJ = XJ - 1.
!
      RETURN 
      END
!
      SUBROUTINE W3FB14(XI,XJ,ALAT1,ELON1,DX,ELONV,ALATAN1, &
                        ALATAN2,ALAT,ELON,IERR)
!$$$   SUBPROGRAM  DOCUMENTATION  BLOCK
!
! SUBPROGRAM:  W3FB14        LAMBERT(I,J) TO LAT/LON FOR GRIB
!   PRGMMR: STACKPOLE        ORG: NMC42       DATE:88-11-28
!
! ABSTRACT: CONVERTS THE COORDINATES OF A LOCATION ON EARTH GIVEN IN A
!   GRID COORDINATE SYSTEM OVERLAID ON A LAMBERT CONFORMAL
!   CONE PROJECTION TRUE AT A GIVEN N OR S LATITUDE TO THE
!   NATURAL COORDINATE SYSTEM OF LATITUDE/LONGITUDE
!   W3FB14 IS THE REVERSE OF W3FB13.
!   USES GRIB SPECIFICATION OF THE LOCATION OF THE GRID
!
! PROGRAM HISTORY LOG:
!   88-11-25  ORIGINAL AUTHOR:  STACKPOLE, W/NMC42
!   90-04-12  R.E.JONES   CONVERT TO CFT77 FORTRAN
!   94-04-28  R.E.JONES   ADD SAVE STATEMENT
! 2003-06-21  GILBERT     MODIFIED FROM W3FB12 AND ADDED SUPPORT FOR
!                         SECANT CONE AS WELL AS TANGENTIAL.
!
! USAGE:  CALL W3FB14(XI,XJ,ALAT1,ELON1,DX,ELONV,ALATAN1,ALATAN2,ALAT,ELON,IERR,
!                                   IERR)
!   INPUT ARGUMENT LIST:
!     XI       - I COORDINATE OF THE POINT  REAL*4
!     XJ       - J COORDINATE OF THE POINT  REAL*4
!     ALAT1    - LATITUDE  OF LOWER LEFT POINT OF GRID (POINT 1,1)
!                LATITUDE <0 FOR SOUTHERN HEMISPHERE; REAL*4
!     ELON1    - LONGITUDE OF LOWER LEFT POINT OF GRID (POINT 1,1)
!                  EAST LONGITUDE USED THROUGHOUT; REAL*4
!     DX       - MESH LENGTH OF GRID IN METERS AT TANGENT LATITUDE
!     ELONV    - THE ORIENTATION OF THE GRID.  I.E.,
!                THE EAST LONGITUDE VALUE OF THE VERTICAL MERIDIAN
!                WHICH IS PARALLEL TO THE Y-AXIS (OR COLUMNS OF
!                THE GRID) ALONG WHICH LATITUDE INCREASES AS
!                THE Y-COORDINATE INCREASES.  REAL*4
!                THIS IS ALSO THE MERIDIAN (ON THE OTHER SIDE OF THE
!                TANGENT CONE) ALONG WHICH THE CUT IS MADE TO LAY
!                THE CONE FLAT.
!     ALATAN1  - THE 1ST LATITUDE AT WHICH THE LAMBERT CONE IS TANGENT TO
!                (TOUCHES OR OSCULATES) THE SPHERICAL EARTH.
!                 SET NEGATIVE TO INDICATE A
!                 SOUTHERN HEMISPHERE PROJECTION; REAL*4
!     ALATAN2  - THE 2ND LATITUDE FROM THE POLE AT WHICH THE LAMBERT CONE
!                INTERSECTS THE SPHERICAL EARTH.
!                SET NEGATIVE TO INDICATE A SOUTHERN HEMISPHERE PROJECTION.
!
!   OUTPUT ARGUMENT LIST:
!     ALAT     - LATITUDE IN DEGREES (NEGATIVE IN SOUTHERN HEMI.)
!     ELON     - EAST LONGITUDE IN DEGREES, REAL*4
!     IERR     - .EQ. 0   IF NO PROBLEM
!                .GE. 1   IF THE REQUESTED XI,XJ POINT IS IN THE
!                         FORBIDDEN ZONE, I.E. OFF THE LAMBERT MAP
!                         IN THE OPEN SPACE WHERE THE CONE IS CUT.
!                  IF IERR.GE.1 THEN ALAT=999. AND ELON=999.
!
!   REMARKS: FORMULAE AND NOTATION LOOSELY BASED ON HOKE, HAYES,
!     AND RENNINGER'S "MAP PROJECTIONS AND GRID SYSTEMS...", MARCH 1981
!     AFGWC/TN-79/003
!
! ATTRIBUTES:
!   LANGUAGE: CRAY CFT77 FORTRAN
!   MACHINE:  CRAY C916-128, CRAY Y-MP8/864, CRAY Y-MP EL2/256
!$$$
         implicit none
         real ALAT,ELON,ALAT1,ELON1,DX,ELONV,ALATAN1,ALATAN2,XI,XJ
         real RERTH,PI,OLDRML,H,PIBY2,RADPD,DEGPRD,REBYDX,ALATN1,ALATN2
         real AN,COSLTN,ELON1L,ELONVR,ALA1,PSI,RMLL,ELO1,ARG,POLEI,POLEJ
         real XX,YY,R2,THETA,BETA,ANINV,ANINV2,STH
         integer IERR
         logical NEWMAP
!
         RERTH  = 6.3712E+6
         PI     = 3.14159
         OLDRML = 99999.
!
!        PRELIMINARY VARIABLES AND REDIFINITIONS
!
!        H = 1 FOR NORTHERN HEMISPHERE; = -1 FOR SOUTHERN
!
         IF (ALATAN1.GT.0) THEN
           H = 1.
         ELSE
           H = -1.
         ENDIF
!
         PIBY2  = PI     / 2.0
         RADPD  = PI     / 180.0
         DEGPRD = 1.0    / RADPD
         REBYDX = RERTH  / DX
         ALATN1 = ALATAN1 * RADPD
         ALATN2 = ALATAN2 * RADPD
         IF (ALATAN1.EQ.ALATAN2) THEN
            AN     = H * SIN(ALATN1)
         ELSE
           AN=LOG(COS(ALATN1)/COS(ALATN2))/ &
             LOG(TAN(((H*PI/2.)-ALATN1)/2.)/TAN(((H*PI/2.)-ALATN2)/2.))
         ENDIF
         COSLTN = COS(ALATN2)
!
!        MAKE SURE THAT INPUT LONGITUDE DOES NOT PASS THROUGH
!        THE CUT ZONE (FORBIDDEN TERRITORY) OF THE FLAT MAP
!        AS MEASURED FROM THE VERTICAL (REFERENCE) LONGITUDE
!
         ELON1L = ELON1
         IF ((ELON1-ELONV).GT.180.) &
          ELON1L = ELON1 - 360.
         IF ((ELON1-ELONV).LT.(-180.)) &
          ELON1L = ELON1 + 360.
!
         ELONVR = ELONV * RADPD
!
!        RADIUS TO LOWER LEFT HAND (LL) CORNER
!
         ALA1 =  ALAT1 * RADPD
!         RMLL = REBYDX * ((COSLTN**(1.-AN))*(1.+AN)**AN) * &
!                (((COS(ALA1))/(1.+H*SIN(ALA1)))**AN)/AN
         PSI=(REBYDX*COSLTN)/(AN*(TAN((PI/4.)-(H*ALATN2/2.))**AN))
         RMLL=PSI*(TAN((PI/4.)-(H*ALA1/2.))**AN)
!
!        USE RMLL TO TEST IF MAP AND GRID UNCHANGED FROM PREVIOUS
!        CALL TO THIS CODE.  THUS AVOID UNNEEDED RECOMPUTATIONS.
!
         IF (RMLL.EQ.OLDRML) THEN
           NEWMAP = .FALSE.
         ELSE
           NEWMAP = .TRUE.
           OLDRML = RMLL
!
!          USE LL POINT INFO TO LOCATE POLE POINT
!
           ELO1 = ELON1L * RADPD
           ARG = AN * (ELO1-ELONVR)
           POLEI = 1. - H * RMLL * SIN(ARG)
           POLEJ = 1. + RMLL * COS(ARG)
         ENDIF
!
!        RADIUS TO THE I,J POINT (IN GRID UNITS)
!              YY REVERSED SO POSITIVE IS DOWN
!
         XX = XI - POLEI
         YY = POLEJ - XJ
         R2 = XX**2 + YY**2
!
!        CHECK THAT THE REQUESTED I,J IS NOT IN THE FORBIDDEN ZONE
!           YY MUST BE POSITIVE UP FOR THIS TEST
!
         THETA = PI*(1.-AN)
         BETA = ABS(ATAN2(XX,-YY))
         IERR = 0
         IF (BETA.LE.THETA) THEN
           IERR = 1
           ALAT = 999.
           ELON = 999.
           IF (.NOT.NEWMAP)  RETURN
         ENDIF
!
!        NOW THE MAGIC FORMULAE
!
         IF (R2.EQ.0) THEN
           ALAT = H * 90.0
           ELON = ELONV
         ELSE
!
!          FIRST THE LONGITUDE
!
           ELON = ELONV + DEGPRD * ATAN2(H*XX,YY)/AN
           ELON = AMOD(ELON+360., 360.)
!
!          NOW THE LATITUDE
!          RECALCULATE THE THING ONLY IF MAP IS NEW SINCE LAST TIME
!
           IF (NEWMAP) THEN
             ANINV = 1./AN
             ANINV2 = ANINV/2.
!             THING = ((AN/REBYDX) ** ANINV)/ &
!              ((COSLTN**((1.-AN)*ANINV))*(1.+ AN))
           ENDIF
           
           STH=sqrt(r2)
!           ALAT = H*(PIBY2 - 2.*ATAN(THING*(R2**ANINV2)))*DEGPRD
           ALAT = H*(PIBY2 - 2.*ATAN(((sth/psi))**ANINV))*DEGPRD
         ENDIF
!
!        FOLLOWING TO ASSURE ERROR VALUES IF FIRST TIME THRU
!         IS OFF THE MAP
!
         IF (IERR.NE.0) THEN
           ALAT = 999.
           ELON = 999.
           IERR = 2
         ENDIF
         RETURN   
         END
!
