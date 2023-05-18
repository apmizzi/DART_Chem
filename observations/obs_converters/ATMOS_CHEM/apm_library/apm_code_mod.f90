module apm_code
   use      time_manager_mod,  only : time_type, get_date, set_date, &
            get_time, set_time

   use      utilities_mod,     only : register_module, error_handler, &
            E_ERR, E_MSG, E_ALLMSG, nmlfileunit, check_namelist_read, &
            find_namelist_in_file, do_nml_file, do_nml_term, ascii_file_format

   use      types_mod, only : r8, MISSING_R8
  
   implicit none

   character(len=180)   :: source, string1

   contains
!
! Table of Contents
!   data_file='/nobackupp11/amizzi/INPUT_DATA/FRAPPE_REAL_TIME_DATA/mozart_forecasts/h0004.nc'
!   data_file='/nobackupp11/amizzi/INPUT_DATA/FIREX_REAL_TIME_DATA/cam_chem_forecasts/waccm_0001.nc'
! mozart
!   integer,parameter                                :: nx=17
!   integer,parameter                                :: ny=13
!   integer,parameter                                :: nz=56
!   integer,parameter                                :: ntim=368
! waccm
!   integer,parameter                                :: nx=17
!   integer,parameter                                :: ny=16
!   integer,parameter                                :: nz=88
!   integer,parameter                                :: ntim=69
!
!  subroutine get_upper_bdy_fld(fld,model,data_file,nx,ny,nz,ntim,lon_obs,lat_obs,prs_obs,nprs_obs, &
!  o3_prf_mdl,tmp_prf_mdl,qmr_prf_mdl,date_obs,datesec_obs)
!
!  subroutine get_MOZART_INT_DATA(file,name,nx,ny,nz,ntim,fld)
!
!  subroutine get_MOZART_REAL_DATA(file,name,nx,ny,nz,ntim,fld)
!
!  subroutine read_int_scalar(ifile, fform, context)
!
!  subroutine write_r8_scalar(ifile, my_scalar, fform, context)
!
!  subroutine read_r8_array(ifile, num_items, r8_array, fform, context)
!
!  subroutine write_r8_array(ifile, num_items, array, fform, context)
!
!  subroutine read_r8_array(ifile, num_items, r8_array, fform, context)
!
!  subroutine vertical_locate(prs_loc,prs_obs,nlev_obs,locl_prf,nlay_obs,kend)
!
!  subroutine get_model_profile(prf_locl,prf_full,nz_mdl,prs_obs,prs_mdl, &
!  tmp_mdl,qmr_mdl,fld_mdl,nlev_obs,v_wgts,prior,kend)
!
!  subroutine get_DART_diag_data(file_in,name,data,nx,ny,nz,nc)
!
!  subroutine handle_err(rc,text)
!
!  subroutine interp_hori_vert(fld1_prf,fld2_prf,fld1_mdl,fld2_mdl,x_mdl,y_mdl, &
!  x_obs,y_obs,prs_mdl,prs_obs,nx_mdl,ny_mdl,nz_mdl,nlev_obs,reject,kend)
! 
!  subroutine interp_to_obs(prf_mdl,fld_mdl,prs_mdl,prs_obs,nz_mdl,nlev_obs,kend)
!
!  subroutine W3FB06(ALAT,ALON,ALAT1,ALON1,DX,ALONV,XI,XJ)
!
!  subroutine W3FB07(XI,XJ,ALAT1,ALON1,DX,ALONV,ALAT,ALON)
!
!  subroutine W3FB08(ALAT,ALON,ALAT1,ALON1,ALATIN,DX,XI,XJ)
!
!  subroutine W3FB09(XI,XJ,ALAT1,ALON1,ALATIN,DX,ALAT,ALON)
!
!  subroutine W3FB11(ALAT,ELON,ALAT1,ELON1,DX,ELONV,ALATAN,XI,XJ)
!
!  subroutine W3FB12(XI,XJ,ALAT1,ELON1,DX,ELONV,ALATAN,ALAT,ELON, &
!  IERR)
!
!  subroutine W3FB13(ALAT,ELON,ALAT1,ELON1,DX,ELONV,ALATAN1,ALATAN2,XI,XJ)
!
!  subroutine W3FB14(XI,XJ,ALAT1,ELON1,DX,ELONV,ALATAN1, &
!  ALATAN2,ALAT,ELON,IERR)
!
!  subroutine cpsr_calculation(nlayer_trc,nlayer,spec_cpsr,avgk_cpsr,prior_cpsr,spec_obs,prior_obs,avgk_obs,cov_obs,cnt) 
!
!  subroutine mat_prd(A_mat,B_mat,C_mat,na,ma,nb,mb)
!
!  subroutine mat_tri_prd(A_mat,B_mat,C_mat,D_mat,na,ma,nb,mb,nc,mc)
!
!  subroutine vec_to_mat(a_vec,A_mat,n)
!
!  subroutine diag_inv_sqrt(A_mat,n)
!
!  subroutine diag_sqrt(A_mat,n)
!
!  subroutine lh_mat_vec_prd(SCL_mat,a_vec,s_a_vec,n)
!
!  subroutine rh_vec_mat_prd(SCL_mat,a_vec,s_a_vec,n)
!
!  subroutine mat_transpose(A_mat,AT_mat,n,m)
!
!  diag_vec(A_mat,a_vec,n)
!
!-------------------------------------------------------------------------------

subroutine get_upper_bdy_fld(fld,model,data_file,nx,ny,nz,ntim,lon_obs,lat_obs,prs_obs,nprs_obs, &
fld_prf_mdl,tmp_prf_mdl,qmr_prf_mdl,date_obs,datesec_obs)  
   implicit none
   integer,                           intent(in)    :: nx,ny,nz,ntim
   integer,                           intent(in)    :: nprs_obs
   real*8,                            intent(in)    :: lon_obs,lat_obs
   real*8,dimension(nprs_obs),        intent(in)    :: prs_obs
   real*8,dimension(nprs_obs),        intent(out)   :: fld_prf_mdl,tmp_prf_mdl,qmr_prf_mdl
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
   real,dimension(nz)                               :: prs_glb,ztrp_fld,ztrp_tmp,ztrp_qmr
   real,dimension(nz)                               :: fld_glb_xmym,fld_glb_xpym,fld_glb_xmyp,fld_glb_xpyp
   real,dimension(nz)                               :: tmp_glb_xmym,tmp_glb_xpym,tmp_glb_xmyp,tmp_glb_xpyp
   real,dimension(nz)                               :: qmr_glb_xmym,qmr_glb_xpym,qmr_glb_xmyp,qmr_glb_xpyp
   real,dimension(nx,ny,nz,ntim)                    :: fld_glb,tmp_glb,qmr_glb
   character(len=50)                                :: fld,model
   character(len=120)                               :: data_file
   character(len=*), parameter                      :: routine = 'get_upper_bdy_fld'
!
!______________________________________________________________________________________________   
!
! Read the upper boundary large scale data (do this once)
!______________________________________________________________________________________________   
!
   pi=4.*atan(1.)
   rad2deg=360./(2.*pi)
   fld_prf_mdl(:)=0.
   tmp_prf_mdl(:)=0.
   qmr_prf_mdl(:)=0.
!
   call get_MOZART_INT_DATA(data_file,'date',ntim,1,1,1,date)
   call get_MOZART_INT_DATA(data_file,'datesec',ntim,1,1,1,datesec)
   call get_MOZART_REAL_DATA(data_file,'lev',nz,1,1,1,prs_glb)
   call get_MOZART_REAL_DATA(data_file,'lat',ny,1,1,1,lat_glb)
   call get_MOZART_REAL_DATA(data_file,'lon',nx,1,1,1,lon_glb)
   if(trim(model).eq.'mozart' .or. trim(model).eq.'MOZART') then
! mozart
      call get_MOZART_REAL_DATA(data_file,trim(fld),nx,ny,nz,ntim,fld_glb)
! waccm
   elseif (trim(model).eq.'waccm' .or. trim(model).eq.'WACCM') then
      call get_MOZART_REAL_DATA(data_file,trim(fld),nx,ny,nz,ntim,fld_glb)
   else
      print *, 'APM: Large scale model type does not exist '
      call exit_all(-77)
   endif
!
   call get_MOZART_REAL_DATA(data_file,'T',nx,ny,nz,ntim,tmp_glb)
   call get_MOZART_REAL_DATA(data_file,'Q',nx,ny,nz,ntim,qmr_glb)
   lon_glb(:)=lon_glb(:)/rad2deg
   lat_glb(:)=lat_glb(:)/rad2deg
!
!______________________________________________________________________________________________   
!
! Find large scale data correspondeing to the observation time
!______________________________________________________________________________________________   
!
   jdate_obs=date_obs*24*60*60+datesec_obs   
   year=date(1)/10000
   yrleft=mod(date(1),10000)
   month=yrleft/100
   day=mod(yrleft,100)
   time_var=set_date(year,month,day,0,0,0)
   call get_time(time_var,second,jday)
   jdate_bck=jday*24*60*60+datesec(1)
!
   year=date(2)/10000
   yrleft=mod(date(2),10000)
   month=yrleft/100
   day=mod(yrleft,100)
   time_var=set_date(year,month,day,0,0,0)
   call get_time(time_var,second,jday)
   jdate_fwd=jday*24*60*60+datesec(2)
!   
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
         indx=nx-1
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
         jndx=ny-1
         bck_ywt=0.
         fwd_ywt=1.
         twty=bck_ywt+fwd_ywt
         exit
      elseif(lat_obs.gt.lat_glb(j) .and. &
         lat_obs.le.lat_glb(j+1)) then
         jndx=j
         bck_ywt=lat_glb(j+1)-lat_obs
         fwd_ywt=lat_obs-lat_glb(j)
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
      fld_glb_xmym(k)=(wt_bck*fld_glb(indx,jndx,k,itim_sav) + &
      wt_fwd*fld_glb(indx,jndx,k,itim_sav+1))/(wt_bck+wt_fwd)
      fld_glb_xpym(k)=(wt_bck*fld_glb(indx+1,jndx,k,itim_sav) + &
      wt_fwd*fld_glb(indx+1,jndx,k,itim_sav+1))/(wt_bck+wt_fwd)
      fld_glb_xmyp(k)=(wt_bck*fld_glb(indx,jndx+1,k,itim_sav) + &
      wt_fwd*fld_glb(indx,jndx+1,k,itim_sav+1))/(wt_bck+wt_fwd)
      fld_glb_xpyp(k)=(wt_bck*fld_glb(indx+1,jndx+1,k,itim_sav) + &
      wt_fwd*fld_glb(indx+1,jndx+1,k,itim_sav+1))/(wt_bck+wt_fwd)
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
      ztrp_jbck=(bck_xwt*fld_glb_xmym(k) + fwd_xwt*fld_glb_xpym(k))/twtx
      ztrp_jfwd=(bck_xwt*fld_glb_xmyp(k) + fwd_xwt*fld_glb_xpyp(k))/twtx
      ztrp_fld(k)=(bck_ywt*ztrp_jbck + fwd_ywt*ztrp_jfwd)/twty
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
      fld_prf_mdl(k)=(zwt_up*ztrp_fld(kndx) + zwt_dw*ztrp_fld(kndx+1))/twt
      tmp_prf_mdl(k)=(zwt_up*ztrp_tmp(kndx) + zwt_dw*ztrp_tmp(kndx+1))/twt
      qmr_prf_mdl(k)=(zwt_up*ztrp_qmr(kndx) + zwt_dw*ztrp_qmr(kndx+1))/twt
   enddo
 end subroutine get_upper_bdy_fld

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
!   print *, v_id
   if(rc.ne.0) then
      print *, 'nf_inq_varid error ', v_id
      stop
   endif
!
! get dimension identifiers
   v_dimid=0
   rc = nf_inq_var(f_id,v_id,v_nam,typ,v_ndim,v_dimid,natts)
!   print *, v_dimid
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
!   print *, v_dim
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
!   print *, 'f_id ',f_id
!
   if(rc.ne.0) then
      print *, 'nf_open error ',trim(file)
      stop
   endif
!
! get variables identifiers
   rc = nf_inq_varid(f_id,trim(name),v_id)
!   print *, 'v_id ',v_id
!
   if(rc.ne.0) then
      print *, 'nf_inq_varid error ', v_id
      stop
   endif
   !
! get dimension identifiers
   v_dimid=0
   rc = nf_inq_var(f_id,v_id,v_nam,typ,v_ndim,v_dimid,natts)
!   print *, 'v_dimid ',v_dimid
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
!   print *, 'v_dim ',v_dim
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
!   print *, 'fld ', fld(1,1,1,1),fld(nx/2,ny/2,nz/2,ntim/2),fld(nx,ny,nz,ntim)
!
   if(rc.ne.0) then
      print *, 'nf_get_vara_real ', fld(1,1,1,1)
      stop
   endif
   rc = nf_close(f_id)
   return
     
end subroutine get_MOZART_REAL_DATA

!-------------------------------------------------------------------------------
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

   real*8                       :: read_r8_scalar
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
   real*8,           intent(in) :: my_scalar
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
   real*8,           intent(out) :: r8_array(:)
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
   real*8,           intent(in) :: array(:)
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

!-------------------------------------------------------------------------------

subroutine get_model_profile(prf_locl,prf_full,nz_mdl,prs_obs,prs_mdl, &
   tmp_mdl,qmr_mdl,fld_mdl,nlev_obs,v_wgts,prior,kend)
   implicit none
   integer                                :: nz_mdl
   integer                                :: nlev_obs
   integer                                :: i,j,k,kend
   real                                   :: Ru,Rd,cp,eps,AvogN,msq2cmsq,grav
   real,dimension(nz_mdl)                 :: prs_mdl,tmp_mdl,qmr_mdl,fld_mdl
   real,dimension(nz_mdl)                 :: tmp_prf,vtmp_prf,fld_prf
   real,dimension(nlev_obs-1)             :: thick,v_wgts,prior,prf_locl,prf_full
   real,dimension(nlev_obs)               :: fld_prf_mdl,vtmp_prf_mdl,prs_obs
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
      fld_prf(k)=fld_mdl(k)*prs_mdl(k)/Ru/tmp_prf(k)
   enddo
! Vertical interpolation
   fld_prf_mdl(:)=-9999.  
   vtmp_prf_mdl(:)=-9999.   
   call interp_to_obs(fld_prf_mdl,fld_prf,prs_mdl,prs_obs,nz_mdl,nlev_obs,kend)
   call interp_to_obs(vtmp_prf_mdl,vtmp_prf,prs_mdl,prs_obs,nz_mdl,nlev_obs,kend)
!   
! calculate number density times vertical weighting
   prf_locl(:)=-9999.
   prf_full(:)=-9999.
   do k=1,nlev_obs-1
      thick(k)=Rd*(vtmp_prf_mdl(k)+vtmp_prf_mdl(k+1))/2./grav* &
      log(prs_obs(k)/prs_obs(k+1))     
   enddo
!
! apply scattering weights
   do k=1,nlev_obs-1
! full term
      prf_full(k)=thick(k) * (fld_prf_mdl(k)+fld_prf_mdl(k+1))/2.* &
      v_wgts(k) + (1.-v_wgts(k))*prior(k)
!
! no thicknesses      
      prf_locl(k)=(fld_prf_mdl(k)+fld_prf_mdl(k+1))/2.* &
      v_wgts(k) + (1.-v_wgts(k))*prior(k)
   enddo
!   print *, 'prf_full  ',prf_full(:)
!   print *, 'fld fld   ',fld_prf_mdl(:)
!   print *, 'avgk_obs ',v_wgts(:)
end subroutine get_model_profile

!-------------------------------------------------------------------------------

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

!-------------------------------------------------------------------------------

subroutine handle_err(rc,text)
   implicit none
   integer         :: rc
   character*(*)   :: text
   print *, 'APM: NETCDF ERROR ',trim(text),' ',rc
   call abort
end subroutine handle_err

!-------------------------------------------------------------------------------

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

!-------------------------------------------------------------------------------

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
   do k=1,nlev_obs-1
      if((prs_obs(k)+prs_obs(k+1))/2..lt.prs_mdl(nz_mdl) .and. &
      kend.eq.-9999) then
         kend=k
         exit
      endif
   enddo
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
            wt_up=log(prs_mdl(kk))-log(prs_obs(k))
            wt_dw=log(prs_obs(k))-log(prs_mdl(kk+1))
            prf_mdl(k)=(wt_up*fld_mdl(kk)+wt_dw*fld_mdl(kk+1))/(wt_dw+wt_up)
            exit
         endif
      enddo               
   enddo
end subroutine interp_to_obs

!-------------------------------------------------------------------------------

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

!-------------------------------------------------------------------------------

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

!-------------------------------------------------------------------------------

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

!-------------------------------------------------------------------------------

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

!-------------------------------------------------------------------------------

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

!-------------------------------------------------------------------------------

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

!-------------------------------------------------------------------------------

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

!-------------------------------------------------------------------------------

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

!-------------------------------------------------------------------------------

subroutine cpsr_calculation(nlayer_trc,nlayer,spec_cpsr,avgk_cpsr,prior_cpsr,spec_obs,prior_obs,avgk_obs,cov_obs,cnt) 
   real,parameter                               :: eps_tol=1.e-3
   integer                                      :: k,kk,cnt
   integer                                      :: info,nlayer,nlayer_trc,qstatus
   real                                         :: sdof
   integer                                      :: lwrk
   real                                         :: spec_cpsr(nlayer),prior_cpsr(nlayer),avgk_cpsr(nlayer,nlayer)
   real                                         :: spec_obs(nlayer),spec_obs_adj(nlayer),prior_obs(nlayer)
   real                                         :: avgk_obs(nlayer,nlayer),cov_obs(nlayer,nlayer)
   real                                         :: avgk_obs_adj(nlayer,nlayer),prior_obs_adj(nlayer)
   double precision,allocatable,dimension(:)    :: wrk
   double precision,allocatable,dimension(:)    :: ZV,ZW,SV_cov
   double precision,allocatable,dimension(:)    :: cp_x_r,cp_x_p
   double precision,allocatable,dimension(:)    :: rs_x_r,rs_x_p
   double precision,allocatable,dimension(:)    :: err2_rs_r
   double precision,allocatable,dimension(:,:)  :: Z,ZL,ZR,SV,U_cov,V_cov,UT_cov,VT_cov
   double precision,allocatable,dimension(:,:)  :: cp_avgk,cp_cov
   double precision,allocatable,dimension(:,:)  :: rs_avgk,rs_cov
!
   lwrk=5*nlayer
   allocate(wrk(lwrk))
   allocate(Z(nlayer,nlayer),SV_cov(nlayer),SV(nlayer,nlayer))
   allocate(U_cov(nlayer,nlayer),UT_cov(nlayer,nlayer),V_cov(nlayer,nlayer),VT_cov(nlayer,nlayer))
   allocate(cp_avgk(nlayer,nlayer),cp_cov(nlayer,nlayer),cp_x_r(nlayer),cp_x_p(nlayer))
   allocate(rs_avgk(nlayer,nlayer),rs_cov(nlayer,nlayer),rs_x_r(nlayer),rs_x_p(nlayer))       
   allocate(ZL(nlayer,nlayer),ZR(nlayer,nlayer),ZV(nlayer),ZW(nlayer))
   allocate(err2_rs_r(nlayer))
!
! Calculate SVD of avgk (Z=U_xxx * SV_xxx * VT_xxx) - COMPRESSION STEP
   Z(1:nlayer,1:nlayer)=dble(avgk_obs(1:nlayer,1:nlayer))
   call dgesvd('A','A',nlayer,nlayer,Z,nlayer,SV_cov,U_cov,nlayer,VT_cov,nlayer,wrk,lwrk,info)
   nlayer_trc=0
   sdof=0.
!
! Phase space truncation
   do k=1,nlayer
      if(SV_cov(k).ge.eps_tol) then
         nlayer_trc=k
         sdof=sdof+SV_cov(k)
      else
         SV_cov(k)=0
         U_cov(:,k)=0. 
         VT_cov(k,:)=0.
      endif 
   enddo
!   print *,'nlayer_trc ',nlayer_trc
!   print *, 'SV ',SV_cov(:)
   
   call mat_transpose(U_cov,UT_cov,nlayer,nlayer)
   call mat_transpose(VT_cov,V_cov,nlayer,nlayer)
   call vec_to_mat(SV_cov,SV,nlayer)
!
! Compress terms in the forward operator
! Averaging Kernel   
   ZL(1:nlayer,1:nlayer)=dble(avgk_obs(1:nlayer,1:nlayer))
   call mat_prd(UT_cov(1:nlayer,1:nlayer),ZL(1:nlayer,1:nlayer), &
   cp_avgk(1:nlayer,1:nlayer),nlayer,nlayer,nlayer,nlayer)
!   do k=1,nlayer
!      print *, 'UT ',k,(UT_cov(k,kk),kk=1,nlayer)
!   enddo
!   do k=1,nlayer
!      print *, 'avgk_obs ',k,(avgk_obs(k,kk),kk=1,nlayer)
!   enddo
!   do k=1,nlayer
!      print *, 'cp_avgk ',k,(cp_avgk(k,kk),kk=1,nlayer)
!   enddo
   
! Retrieval Error Covariance
   ZL(1:nlayer,1:nlayer)=dble(cov_obs(1:nlayer,1:nlayer))
   call mat_tri_prd(UT_cov(1:nlayer,1:nlayer),ZL(1:nlayer,1:nlayer),U_cov(1:nlayer,1:nlayer), &
   cp_cov(1:nlayer,1:nlayer),nlayer,nlayer,nlayer,nlayer,nlayer,nlayer)
!   do k=1,nlayer
!      print *, 'UT ',k,(UT_cov(k,kk),kk=1,nlayer)
!   enddo
!   do k=1,nlayer
!      print *, 'cov_obs ',k,(cov_obs(k,kk),kk=1,nlayer)
!   enddo
!   do k=1,nlayer
!      print *, 'cp_cov ',k,(cp_cov(k,kk),kk=1,nlayer)
!   enddo
   
! Adjusted retrieval
   do k=1,nlayer
      do kk=1,nlayer
         avgk_obs_adj(k,kk)=-1.*avgk_obs(k,kk)
      enddo
      avgk_obs_adj(k,k)=avgk_obs_adj(k,k)+1.
   enddo
!
! Calcuate the prior term: (I-A) x_p
   call lh_mat_vec_prd(dble(avgk_obs_adj(1:nlayer,1:nlayer)),dble(prior_obs(1:nlayer)), &
   ZW(1:nlayer),nlayer)
   prior_obs_adj(1:nlayer)=real(ZW(1:nlayer))
!
! Calculate the QOR term: x_r - (I-A) x_p
   spec_obs_adj(1:nlayer)=spec_obs(1:nlayer)-prior_obs_adj(1:nlayer)

   ZV(1:nlayer)=dble(spec_obs_adj(1:nlayer))
   call lh_mat_vec_prd(UT_cov(1:nlayer,1:nlayer),ZV(1:nlayer),cp_x_r(1:nlayer),nlayer)
!   do k=1,nlayer
!      print *, 'UT ',k,(UT_cov(k,kk),kk=1,nlayer)
!   enddo
!   print *, 'spec_obs_adj ',(spec_obs_adj(k),k=1,nlayer)
!   print *, 'cp_x_r ',(cp_x_r(k),k=1,nlayer)
!   print *, 'prior_obs_adj ',(prior_obs_adj(k),k=1,nlayer)
   
   ZV(1:nlayer)=dble(prior_obs_adj(1:nlayer))
   call lh_mat_vec_prd(UT_cov(1:nlayer,1:nlayer),ZV(1:nlayer),cp_x_p(1:nlayer),nlayer)
!   do k=1,nlayer
!      print *, 'UT ',k,(UT_cov(k,kk),kk=1,nlayer)
!   enddo
!   print *, 'spec_obs_adj ',(spec_obs_adj(k),k=1,nlayer)
!   print *, 'cp_x_p ',(cp_x_p(k),k=1,nlayer)
   
! Calculate SVD of cp_cov (Z=U_xxx * SV_xxx * VT_xxx) - ROTATION STEP
   Z(1:nlayer,1:nlayer)=cp_cov(1:nlayer,1:nlayer)
   call dgesvd('A','A',nlayer,nlayer,Z,nlayer,SV_cov,U_cov,nlayer,VT_cov,nlayer,wrk,lwrk,info)
   do k=nlayer_trc+1,nlayer
      SV_cov(k)=0
      U_cov(:,k)=0. 
      VT_cov(k,:)=0.
   enddo
!
! Scale the singular vectors
   do k=1,nlayer_trc
      U_cov(:,k)=U_cov(:,k)/sqrt(SV_cov(k))
   enddo
!   print *, 'nlayer_trc ',nlayer_trc
!   print *, 'SV ',SV_cov(:)
!
   call mat_transpose(U_cov,UT_cov,nlayer,nlayer)
   call mat_transpose(VT_cov,V_cov,nlayer,nlayer)
   call vec_to_mat(SV_cov,SV,nlayer)
!   do k=1,nlayer
!      print *, 'U ',k,(U_cov(k,kk),kk=1,nlayer)
!   enddo
!   do k=1,nlayer
!      print *, 'UT ',k,(UT_cov(k,kk),kk=1,nlayer)
!   enddo

! Rotate terms in the forward operator
   ZL(1:nlayer,1:nlayer)=cp_avgk(1:nlayer,1:nlayer)
   call mat_prd(UT_cov(1:nlayer,1:nlayer),ZL(1:nlayer,1:nlayer), &
   rs_avgk(1:nlayer,1:nlayer),nlayer,nlayer,nlayer,nlayer)
!   do k=1,nlayer
!      print *, 'UT ',k,(UT_cov(k,kk),kk=1,nlayer)
!   enddo
!   do k=1,nlayer
!      print *, 'cp_avgk ',k,(cp_avgk(k,kk),kk=1,nlayer)
!   enddo
!   do k=1,nlayer
!      print *, 'rs_avgk ',k,(rs_avgk(k,kk),kk=1,nlayer)
!   enddo
   ZL(1:nlayer,1:nlayer)=cp_cov(1:nlayer,1:nlayer)

   call mat_tri_prd(UT_cov(1:nlayer,1:nlayer),ZL(1:nlayer,1:nlayer),U_cov(1:nlayer,1:nlayer), &
   rs_cov(1:nlayer,1:nlayer),nlayer,nlayer,nlayer,nlayer,nlayer,nlayer)
   
!   do k=1,nlayer
!      print *, 'UT ',k,(UT_cov(k,kk),kk=1,nlayer)
!   enddo
!   do k=1,nlayer
!      print *, 'cp_cov ',k,(cp_cov(k,kk),kk=1,nlayer)
!   enddo
!   do k=1,nlayer
!      print *, 'rs_cov ',k,(rs_cov(k,kk),kk=1,nlayer)
!   enddo

   call lh_mat_vec_prd(UT_cov(1:nlayer,1:nlayer),cp_x_r(1:nlayer),rs_x_r(1:nlayer),nlayer)
!   do k=1,nlayer
!      print *, 'UT ',k,(UT_cov(k,kk),kk=1,nlayer)
!   enddo
!   print *, 'cp_x_r ',(cp_x_r(k),k=1,nlayer)
!   print *, 'rs_x_r ',(rs_x_r(k),k=1,nlayer)

   call lh_mat_vec_prd(UT_cov(1:nlayer,1:nlayer),cp_x_p(1:nlayer),rs_x_p(1:nlayer),nlayer)
!   do k=1,nlayer
!      print *, 'UT ',k,(UT_cov(k,kk),kk=1,nlayer)
!   enddo
!   print *, 'cp_x_p ',(cp_x_p(k),k=1,nlayer)
!   print *, 'rs_x_p ',(rs_x_p(k),k=1,nlayer)

! Get new errors (check if err2_rs_r < 0 the qstatus=1)
   qstatus=0.0
   
   do k=1,nlayer
      err2_rs_r(k)=sqrt(rs_cov(k,k))
   enddo
!
! Assign variables to return to calling routine
   spec_cpsr(1:nlayer)=real(rs_x_r(1:nlayer))
   prior_cpsr(1:nlayer)=real(rs_x_p(1:nlayer))
   avgk_cpsr(1:nlayer,1:nlayer)=real(rs_avgk(1:nlayer,1:nlayer))
!
! Clean up and return   
   deallocate(wrk)
   deallocate(Z,SV_cov,SV)
   deallocate(U_cov,UT_cov,V_cov,VT_cov)
   deallocate(cp_avgk,cp_cov,cp_x_r,cp_x_p)       
   deallocate(rs_avgk,rs_cov,rs_x_r,rs_x_p)       
   deallocate(ZL,ZR,ZV,ZW)
end subroutine cpsr_calculation

!-------------------------------------------------------------------------------

subroutine mat_prd(A_mat,B_mat,C_mat,na,ma,nb,mb)
!
! compute dot product of two matrics
   integer :: ma,na,mb,nb,i,j,k
   double precision :: A_mat(na,ma),B_mat(nb,mb),C_mat(na,mb)
!
! check that na=mb
   if(ma .ne. nb) then
      print *, 'Error in matrix dimension ma (cols) must equal nb (rows) ',ma,' ',nb
      stop
   endif
!
! initialze the product array
   C_mat(:,:)=0.
!
! calculate inner product
   do i=1,na
      do j=1,mb
         do k=1,ma
            C_mat(i,j)=C_mat(i,j)+A_mat(i,k)*B_mat(k,j) 
         enddo
      enddo
   enddo
end subroutine mat_prd

!-------------------------------------------------------------------------------

subroutine mat_tri_prd(A_mat,B_mat,C_mat,D_mat,na,ma,nb,mb,nc,mc)
!
! compute dot product of three matrics D=A*B*C
   integer :: na,ma,nb,mb,nc,mc,i,j,k
   double precision :: A_mat(na,ma),B_mat(nb,mb),C_mat(nc,mc),D_mat(na,mc)
   double precision :: Z_mat(nb,mc)
!
! check that na=mb
   if(ma .ne. nb) then
      print *, 'Error in matrix dimension ma (cols) must equal nb (rows) ',ma,' ',nb
      stop
   endif
   if(mb .ne. nc) then
      print *, 'Error in matrix dimension mb (cols) must equal nc (rows) ',mb,' ',nc
      stop
   endif
!
! initialze the product array
   Z_mat(:,:)=0.
   D_mat(:,:)=0.
!
! calculate first inner product Z=B*C
   do i=1,nb
      do j=1,mc
         do k=1,mb
            Z_mat(i,j)=Z_mat(i,j)+B_mat(i,k)*C_mat(k,j) 
         enddo
      enddo
   enddo
!
! calculate second inner product D=A*Z
   do i=1,na
      do j=1,mc
         do k=1,ma
            D_mat(i,j)=D_mat(i,j)+A_mat(i,k)*Z_mat(k,j) 
         enddo
      enddo
   enddo
end subroutine mat_tri_prd

!-------------------------------------------------------------------------------

subroutine vec_to_mat(a_vec,A_mat,n)
!
! compute dot product of two matrics
   integer :: n,i
   double precision :: a_vec(n),A_mat(n,n)
!
! initialze the product array
   A_mat(:,:)=0.
!
! calculate inner product
   do i=1,n
      A_mat(i,i)=a_vec(i) 
   enddo
end subroutine vec_to_mat

!-------------------------------------------------------------------------------

subroutine diag_inv_sqrt(A_mat,n)
!
! calculate inverse square root of diagonal elements
   integer :: n,i
   double precision :: A_mat(n,n)
   do i=1,n
      if(A_mat(i,i).le.0.) then
         print *, 'Error in Subroutine vec_to_mat arg<=0 ',i,' ',A_mat(i,i)
         call abort
      endif
      A_mat(i,i)=1./sqrt(A_mat(i,i)) 
   enddo
   return
end subroutine diag_inv_sqrt

!-------------------------------------------------------------------------------

subroutine diag_sqrt(A_mat,n)
!
! calculate square root of diagonal elements
   integer :: n,i
   double precision :: A_mat(n,n)
   do i=1,n
      if(A_mat(i,i).lt.0.) then
         print *, 'Error in Subroutine vec_to_mat arg<0 ',i,' ',A_mat(i,i)
         call abort
      endif
      A_mat(i,i)=sqrt(A_mat(i,i)) 
   enddo
end subroutine diag_sqrt

!-------------------------------------------------------------------------------

subroutine lh_mat_vec_prd(SCL_mat,a_vec,s_a_vec,n)
!
! calculate left hand side scaling of column vector
   integer :: n,i,j
   double precision :: SCL_mat(n,n),a_vec(n),s_a_vec(n)
!
! initialize s_a_vec
   s_a_vec(:)=0.
!
! conduct scaling
   do i=1,n
      do j=1,n
         s_a_vec(i)=s_a_vec(i)+SCL_mat(i,j)*a_vec(j)
      enddo 
   enddo
end subroutine lh_mat_vec_prd

!-------------------------------------------------------------------------------

subroutine rh_vec_mat_prd(SCL_mat,a_vec,s_a_vec,n)
!
! calculate right hand side scaling of a row vector
   integer :: n,i,j
   double precision :: SCL_mat(n,n),a_vec(n),s_a_vec(n)
!
! initialize s_a_vec
   s_a_vec(:)=0.
!
! conduct scaling
   do i=1,n
      do j=1,n
         s_a_vec(i)=s_a_vec(i)+a_vec(j)*SCL_mat(j,i) 
      enddo
   enddo
end subroutine rh_vec_mat_prd

!-------------------------------------------------------------------------------

subroutine mat_transpose(A_mat,AT_mat,n,m)
!
! calculate matrix transpose
   integer :: n,m,i,j
   double precision :: A_mat(n,m),AT_mat(m,n)
   do i=1,n
      do j=1,m
         AT_mat(j,i)=A_mat(i,j) 
      enddo
   enddo
end subroutine mat_transpose

!-------------------------------------------------------------------------------

subroutine diag_vec(A_mat,a_vec,n)
!
! calculate square root of diagonal elements
   integer :: n,i
   double precision :: A_mat(n,n),a_vec(n)
   do i=1,n
      a_vec(i)=A_mat(i,i) 
   enddo
end subroutine diag_vec

end module apm_code

!-------------------------------------------------------------------------------

subroutine exit_all_aapm(exit_code)
 use mpi_utilities_mod, only : get_dart_mpi_comm

 integer, intent(in) :: exit_code

integer :: ierror

! call abort on our communicator

!print *, 'calling abort on comm ', get_dart_mpi_comm()
call MPI_Abort(get_dart_mpi_comm(),  exit_code, ierror)

! execution should never get here

end subroutine exit_all_aapm

