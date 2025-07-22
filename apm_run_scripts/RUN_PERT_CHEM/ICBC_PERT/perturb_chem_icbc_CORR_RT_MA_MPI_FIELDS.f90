!
! Copyright 2019 NCAR/ACOM
! 
! Licensed under the Apache License, Version 2.0 (the "License");
! you may not use this file except in compliance with the License.
! You may obtain a copy of the License at
! 
!     http://www.apache.org/licenses/LICENSE-2.0
! 
! Unless required by applicable law or agreed to in writing, software
! distributed under the License is distributed on an "AS IS" BASIS,
! WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
! See the License for the specific language governing permissions and
! limitations under the License.
!
! DART $Id: perturb_chem_icbc_CORR_RT_MA_MPI.f90 13171 2019-05-09 16:42:36Z thoar@ucar.edu $
!
! Code to perturb the wrfchem icbc files
!
program main
!   use apm_err_corr_mod, only :vertical_transform, &
!                               get_WRFINPUT_land_mask, &
!                               get_WRFINPUT_lat_lon, &
!                               get_WRFINPUT_geo_ht, &
!                               get_WRFCHEM_icbc_data, &
!                               put_WRFCHEM_icbc_data, &
!                               get_WRFCHEM_emiss_data, &
!                               put_WRFCHEM_emiss_data, &
!                               init_random_seed, &
!                               init_const_random_seed, &
!                               apm_pack_3d, &
!                               apm_unpack_3d, &
!                               apm_pack_4d, &
!                               apm_unpack_4d, &
!                               recenter_factors
!
!   use apm_utilities_mod, only : get_dist
!
   implicit none
   include 'mpif.h'
   character(len=*), parameter                 :: source   = 'perturb_chem_icbc_CORR_RT_MA_MPI.f90'
   character(len=*), parameter                 :: revision = ''
   character(len=*), parameter                 :: revdate  = ''
   integer,parameter                           :: nbdy_exts=8
   integer,parameter                           :: nhalo=5
   character(len=5),parameter,dimension(nbdy_exts) :: bdy_exts=(/'_BXS ','_BXE ','_BYS ','_BYE ','_BTXS', &
   '_BTXE','_BTYS','_BTYE'/)
!
   integer                                     :: ierr,rank,task,num_procs,num_procs_avail
   integer                                     :: nt,unit,date,nx,ny,nz,nxy,nxyz,nzp,nchem_spcs
   integer                                     :: num_mems,status,ngrid_corr
   integer                                     :: h,i,ii,j,jj,k,kk,l,isp,imem,ibdy,bdy_idx
   integer                                     :: ifile,icnt,ncnt,ntasks,icnt_tsk
   integer                                     :: unita,unitb
   integer                                     :: proc_del,proc_res
   integer                                     :: proc_del_avl,proc_res_avl
   integer                                     :: proc_del_mem,task_res_mem
   integer,dimension(MPI_STATUS_SIZE)          :: stat
   integer,dimension(nbdy_exts)                :: bdy_dims
   integer,allocatable,dimension(:)            :: proc_beg,proc_end
   integer,allocatable,dimension(:)            :: indx,jndx
   integer,allocatable,dimension(:,:)          :: itask
   real                                        :: get_dist
   real                                        :: pi,grav,zfac,tfac,fac_min
   real                                        :: nnum_mems,sprd_chem
   real                                        :: corr_lngth_hz,corr_lngth_vt,corr_lngth_tm
   real                                        :: corr_tm_delt,grid_length
   real                                        :: wgt_bc_str,wgt_bc_mid,wgt_bc_end
   real                                        :: chem_fac_mid,std
   real                                        :: u_ran_1,u_ran_2,zdist
   real                                        :: wgt_sum,test_const
   real                                        :: cpu_str,cpu_end,cpu_dif,flg
   real,allocatable,dimension(:)               :: tmp_arry,wgt
   real,allocatable,dimension(:,:)             :: lat,lon
   real,allocatable,dimension(:,:,:)           :: geo_ht,chem_data_end
   real,allocatable,dimension(:,:,:)           :: chem_fac_mem_old,chem_fac_mem_new
   real,allocatable,dimension(:,:,:,:)         :: chem_data3d,chem_data3d_sav
   real,allocatable,dimension(:,:,:,:)         :: chem_databdy
   real,allocatable,dimension(:,:,:,:)         :: A_chem
   real,allocatable,dimension(:,:,:)           :: chem_fac_old,chem_fac_new,chem_fac_end
   real,allocatable,dimension(:,:,:,:,:)       :: chem_data_sav_1,chem_data_sav_2
   real,allocatable,dimension(:)               :: pert_chem_sum_old,pert_chem_sum_new
   real,allocatable,dimension(:,:,:)           :: pert_chem_old,pert_chem_new

   character(len=20)                           :: cmem
   character(len=200)                          :: pert_path_old,pert_path_new,ch_spcs,filenm
   character(len=200)                          :: wrfinput_fld_new,wrfinput_err_new
   character(len=200)                          :: wrfbdy_fld_new,wrfchem_file_ic,wrfchem_file_bc
   character(len=200),allocatable,dimension(:) :: ch_chem_spc
   logical                                     :: sw_corr_tm,sw_seed
!
   namelist /perturb_chem_icbc_corr_nml/date,nx,ny,nz,nchem_spcs,pert_path_old,pert_path_new,nnum_mems, &
   wrfinput_fld_new,wrfinput_err_new,wrfbdy_fld_new,sprd_chem,corr_lngth_hz,corr_lngth_vt, &
  corr_lngth_tm,corr_tm_delt,sw_corr_tm,sw_seed
   namelist /perturb_chem_icbc_spcs_nml/ch_chem_spc
!
! Setup mpi
   call mpi_init(ierr)
   call mpi_comm_rank(MPI_COMM_WORLD,rank,ierr)
   call mpi_comm_size(MPI_COMM_WORLD,num_procs,ierr)
!
! Assign constants
   pi=4.*atan(1.)
   grav=9.8
   nt=2
   zfac=2.
   tfac=60.*60.
   fac_min=0.01
   icnt_tsk=2
!
! Read control namelist
   unit=20
   open(unit=unit,file='perturb_chem_icbc_corr_nml.nl',form='formatted', &
   status='old',action='read')
   rewind(unit)   
   read(unit,perturb_chem_icbc_corr_nml)
   close(unit)
   if(rank.eq.0) then
      print *, 'date               ',date
      print *, 'nx                 ',nx
      print *, 'ny                 ',ny
      print *, 'nz                 ',nz
      print *, 'nchem_spcs         ',nchem_spcs
      print *, 'pert_path_old     ',trim(pert_path_old)
      print *, 'pert_path_new     ',trim(pert_path_new)
      print *, 'num_mems           ',nnum_mems
      print *, 'wrfinput_fld_new   ',trim(wrfinput_fld_new)
      print *, 'wrfinput_err_new   ',trim(wrfinput_err_new)
      print *, 'wrfbdy_fld_new     ',trim(wrfbdy_fld_new)
      print *, 'sprd_chem          ',sprd_chem
      print *, 'corr_lngth_hz      ',corr_lngth_hz
      print *, 'corr_lngth_vt      ',corr_lngth_vt
      print *, 'corr_lngth_tm      ',corr_lngth_tm
      print *, 'corr_tm_delt       ',corr_tm_delt
      print *, 'sw_corr_tm         ',sw_corr_tm
      print *, 'sw_seed            ',sw_seed
   endif
   nxy=nx*ny
   nzp=nz+1
   num_mems=nint(nnum_mems)
   bdy_dims=(/ny,ny,nx,nx,ny,ny,nx,nx/)
!
! Allocate arrays
   allocate(ch_chem_spc(nchem_spcs))
   allocate(A_chem(nx,ny,nz,nz))
   A_chem(:,:,:,:)=0.
!
! Read the species namelist
   unit=20
   open( unit=unit,file='perturb_chem_icbc_spcs_nml.nl',form='formatted', &
   status='old',action='read')
   rewind(unit)
   read(unit,perturb_chem_icbc_spcs_nml)
   close(unit)
!
! Get lat / lon data (-90 to 90; -180 to 180)
   allocate(lat(nx,ny),lon(nx,ny))
   call get_WRFINPUT_lat_lon(lat,lon,nx,ny)
!
! Get mean geopotential height data
   allocate(geo_ht(nx,ny,nz))
   call get_WRFINPUT_geo_ht(geo_ht,nx,ny,nz,nzp,num_mems)
   geo_ht(:,:,:)=geo_ht(:,:,:)/grav
!
! Get horiztonal grid length
   grid_length=get_dist(lat(nx/2,ny),lat(nx/2+1,ny),lon(nx/2,ny),lon(nx/2+1,ny))
!   if(rank.eq.0) then
!      print *, 'horizontal grid length ',grid_length
!   endif
!
! Calculate number of horizontal grid points to be correlated 
   ngrid_corr=ceiling(zfac*corr_lngth_hz/grid_length)+1
!   if(rank.eq.0) then
!      print *, 'ngrid_corr ',ngrid_corr
!   endif

   call cpu_time(cpu_str)
   if(rank.eq.0) print *, 'APM: Before vertical transform: time str ', cpu_str
!
! Construct the vertical weights
   call vertical_transform(A_chem,geo_ht,nx,ny,nz,nz,corr_lngth_vt)
   deallocate(geo_ht)
!   if(rank.eq.0) then
!      do k=1,nz
!         print *, 'Level ',k,' A_chem ',(A_chem(nx/2,ny/2,k,kk),kk=1,nz)
!      enddo
!   endif   

   call cpu_time(cpu_end)
   cpu_dif=cpu_end-cpu_str
   if(rank.eq.0) print *, 'APM: After vertical transform: time dif', cpu_dif
!
! Allocate processors (reserve tasks 0 and 1)
   allocate(itask(nchem_spcs,num_mems))
   ntasks=num_mems*nchem_spcs
   do isp=1,nchem_spcs
      do imem=1,num_mems
         itask(isp,imem)=mod(((isp-1)*num_mems+imem-1),num_procs-icnt_tsk)+icnt_tsk
      enddo
   enddo
!
!##############################################################
!
! Task: 0
!   
! Read IC/BC fields from current and previous cycles and send
! them to the slave tasks.   
!
!##############################################################
!   
   if(rank.eq.0) then
      do isp=1,nchem_spcs
!
! Read previous cycle ICs, calculate perturbations, and send peturbations
         allocate(chem3d(nx,ny,nz,num_mems))
         allocate(chem3d_mean(nx,ny,nz))
         allocate(tmp_arry(nx*ny*nz))
         if(sw_corr_tm) then
            do imem=1,num_mems
               call get_WRFCHEM_icbc_data(wrfchem_file_ic,ch_chem_spc(isp), &
               chem3d(:,:,:,imem),nx,ny,nz,1)
            enddo
            chem_data3d_mean(:,:,:)=0.
            do imem=1,num_mems
               chem3d_mean(:,:,:)=chem3d_mean(:,:,:) + &
               chem3d(:,:,:,imem)/float(num_mems)
            enddo
            do imem=1,num_mems
               chem3d(:,:,:,imem)=chem3d(:,:,:,imem) - &
               chem3d_mean(:,:,:)
            enddo
            do imem=1,num_mems
               call apm_pack_4d(tmp_arry,chem3d(:,:,:,imem),nx,ny,nz,1)
               call mpi_send(tmp_arry,nx*ny*nz,MPI_FLOAT, &               
               itask(isp,imem),1,MPI_COMM_WORLD,ierr)
            enddo
         endif
         deallocate (chem3d)
!
! Read current cycle ICs and send full field (all members set to parent)
         imem=1
         call get_WRFCHEM_icbc_data(wrfchem_file_ic,ch_chem_spc(isp), &
         chem3d_mean(:,:,:),nx,ny,nz,1)
         do imem=1,num_mems
            call apm_pack_4d(tmp_arry,chem3d_mean,nx,ny,nz,1)
            call mpi_send(tmp_arry,nx*ny*nz,MPI_FLOAT, &               
            itask(isp,imem),2,MPI_COMM_WORLD,ierr)
         enddo
         deallocate(chem_data3d_mean)     
         deallocate(tmp_arry)
!
         do ibdy=1,nbdy_exts
            allocate(chembdy(bdy_dims(ibdy),nz,nhalo,nt,num_mems))
            allocate(chembdy_mean(bdy_dims(ibdy),nz,nhalo,nt))
            allocate(tmp_arry(bdy_dims(ibdy)*nz*nhalo*nt))
!
! Read current cycle BCs and send full fields (all members set to parent)
            imem=1
            ch_spcs=trim(ch_chem_spc(isp))//trim(bdy_exts(ibdy))
            call get_WRFCHEM_icbc_data(wrfchem_file_bc,ch_spcs, &
            chembdy_mean,bdy_dims(ibdy),nz,nhalo,nt)
            do imem=1,num_mems
               call apm_pack_4d(tmp_arry,chembdy_mean(:,:,:,:,imem), &
               bdy_dims(ibdy),nz,nhalo,nt)
               call mpi_send(tmp_arry,bdy_dims(ibdy)*nz*nhalo*nt,MPI_FLOAT, &               
               itask(isp,imem),ibdy+3,MPI_COMM_WORLD,ierr)
            enddo
            deallocate(chembdy_mean)
            deallocate(tmp_arry)
         enddo
      enddo
   endif   
!
!##############################################################
!
! Task: itask(isp,imem) Not tasks 0 or 1
!   
! Calculate perturbed IC/BC fields for current cycle and apply temporal smoothing
!
!##############################################################
!   
   if(rank.ne.0 .and. rank.ne.1) then
      do isp=1,nchem_spcs
         allocate(chem3d_old(nx.ny,nz)
         allocate(chem3d_new(nx.ny,nz)
         allocate(chem3d_new_sav(nx.ny,nz)
         allocate(chem3d_end(nx.ny,nz)
         do imem=1,num_mems
            if(rank.eq.itask(isp,imem)) then
               allocate(tmp_arry(nx*ny*nz))
!
! Receive previous cycle IC perturbations          
               if(sw_corr_tm) then
                  call mpi_recv(tmp_arry,nx*ny*nz,MPI_FLOAT, &
                  0,1,MPI_COMM_WORLD,stat,ierr)
                  call apm_unpack_3d(tmp_arry,chem3d_old,nx,ny,nz)
               endif
!
! Receive current cycle IC full fields (all members set to parent)
               call mpi_recv(tmp_arry,nx*ny*nz,MPI_FLOAT, &
               0,2,MPI_COMM_WORLD,stat,ierr)
               call apm_unpack_3d(tmp_arry,chem3d_new,nx,ny,nz)
               deallocate(tmp_arry)
!
               do ibdy=1,nbdy_exts
                  allocate(chembdy_new(bdy_dims(ibdy),nz,nhalo,nt))
                  allocate(tmp_arry(bdy_dims(ibdy)*nz*nhalo*nt))
!
! Receive current cycle BC full fields (all members set to parent)
                  call mpi_recv(tmp_arry,bdy_dims(ibdy)*nz*nhalo*nt,MPI_FLOAT, &
                  0,ibdy+3,MPI_COMM_WORLD,stat,ierr)
                  call apm_unpack_3d(tmp_arry,chembdy_new,bdy_dims(ibdy),nz,nhalo,nt)
                  deallocate(tmp_arry)
               enddo
!
! Perturb the current cycle IC full fields
               if(sw_seed) call init_const_random_seed(rank,date)
               chem3d_new_sav(:,:,:)=chem3d_new(:,:,:)
               call perturb_fields(chem3d_new,lat,lon,A_chem,nx,ny,nz, &
               ngrid_corr,corr_lngth_hz,rank,sprd_chem)
!
! Impose temporal smoothing
               wgt_bc_end=exp(-1.0*corr_tm_delt*corr_tm_delt/corr_lngth_tm/corr_lngth_tm)
               chem3d_end(:,:,:)=(wgt_bc_end*chem3d_old(:,:,:)+ &
               chem3d_new(:,:,:))/(wgt_bc_end+1.)
               deallocate(chem3d_old)
!
! Send results to Task 1 for writing to IC input files
               allocate(tmp_arry(nx*ny*nz))
               call apm_pack_4d(tmp_arry,chem3d_end,nx,ny,nz,1)
               call mpi_send(tmp_arry,nx*ny*nz,MPI_FLOAT, &               
               1,1,MPI_COMM_WORLD,ierr)
               deallocate(tmp_arry)
!
! Perturb the current cycle BC full fields
               do ibdy=1,nbdy_exts
                  if(ibdy.eq.1.or.ibdy.eq.2.or.ibdy.eq.5.or.ibdy.eq.6) then 
                     if(ibdy.eq.1.or.ibdy.eq.2) then
!
! Non-tendency terms     
                        i=1
                        if(ibdy/2*2.eq.ibdy) i=nx 
                        do h=1,nhalo
                           do k=1,nz
                              do j=1,bdy_dims(ibdy)
                                 chembdy_end(j,k,h,1)=chembdy_new(j,k,h,1)* &
                                 chem3d_end(i,j,k)/chem3d_new_sav(i,j,k)
                                 chembdy_end(j,k,h,2)=chembdy_new(j,k,h,2)* &
                                 chem3d_end(i,j,k)/chem3d_new_sav(i,j,k)
                              enddo 
                           enddo
                        enddo         
                     else
!
! Tendency terms     
                        i=1
                        if(ibdy/2*2.eq.ibdy) i=nx
                        do h=1,nhalo
                           do k=1,nz
                              do j=1,bdy_dims(ibdy)
                                 chembdy_end(j,k,h,1)=chembdy_new(j,k,h,1)* &
                                 (chem3d_old(i,j,k)+chem3d_end(i,j,k))/2./ &
                                 chem3d_new_sav(i,j,k)
                                 chembdy_end(j,k,h,2)=chembdy_new(j,k,h,2)* &
                                 (chem3d_old(i,j,k)*chem3d_end(i,j,k))/2./ &
                                 chem3d_new_sav(i,j,k)
                              enddo 
                           enddo
                        enddo
                     endif
                  else if(ibdy.eq.3.or.ibdy.eq.4.or.ibdy.eq.7.or.ibdy.eq.8) then
                     if(ibdy.eq.3.or.ibdy.eq.4) then
!
! Non-tendency terms
                        j=1  
                        if(ibdy/2*2.eq.ibdy) j=ny
                        do h=1,nhalo
                           do k=1,nz
                              do i=1,bdy_dims(ibdy)
                                 chembdy_end(j,k,h,1)=chembdy_new(j,k,h,1)* &
                                 chem3d_end(i,j,k)/chem3d_new_sav(i,j,k)
                                 chembdy_end(j,k,h,2)=chembdy_new(j,k,h,2)* &
                                 chem3d_end(i,j,k)/chem3d_new_sav(i,j,k)
                              enddo
                           enddo
                        enddo   
                     else
!
! Tendency terms     
                        j=1  
                        if(ibdy/2*2.eq.ibdy) j=ny
                        do h=1,nhalo
                           do k=1,nz
                              do i=1,bdy_dims(ibdy)
                                 chembdy_end(j,k,h,1)=chembdy_new(j,k,h,1)* &
                                 (chem3d_old(i,j,k)+chem3d_end(i,j,k))/2./ &
                                 chem3d_new_sav(i,j,k)
                                 chembdy_end(j,k,h,2)=chembdy_new(j,k,h,2)* &
                                 (chem3d_old(i,j,k)*chem3d_end(i,j,k))/2./ &
                                 chem3d_new_sav(i,j,k)
                              enddo 
                           enddo
                        enddo         
                     endif         
                  endif 
!
! Send results to Task 1 for writing to BC input files
                  allocate(tmp_arry(bdy_dims(ibdy)*nz*nhalo*nt))
                  call apm_pack_4d(tmp_arry,chembdy_end,bdy_dims(ibdy),nz,nhalo,nt)
                  call mpi_send(tmp_arry,bdy_dims(ibdy)*nz*nhalo*nt,MPI_FLOAT, &               
                  1,ibdy+1,MPI_COMM_WORLD,ierr)
                  deallocate(tmp_arry)
               enddo
               deallocate(chem3d_new)
               deallocate(chem2d_new_sav)
               deallocate(chembdy_new)
               deallocate(chembdy_end)               
            endif
         enddo
      enddo   
   endif
!
!##############################################################
!
! Task 1:
!   
! Receive results and write perturbed full fields to current IC/BC files
!
!##############################################################
!   
   if(rank.eq.1) then
      do isp=1,nchem_spcs
         allocate(chem3d_end(nx.ny,nz)
         do imem=1,num_mems
            if(rank.eq.itask(isp,imem)) then
               allocate(tmp_arry(nx*ny*nz))
               call mpi_recv(tmp_arry,nx*ny*nz,MPI_FLOAT, &
               itask(isp,imem),1,MPI_COMM_WORLD,stat,ierr)
               call apm_unpack_3d(tmp_arry,chem3d_end,nx,ny,nz)
               deallocate(tmp_arry)
               call put_WRFCHEM_icbc_data(wrfchem_file_ic,ch_chem_spc(isp), &
               chem3d_end,nx,ny,nz,1)
!
               do ibdy=1,nbdy_exts
                  allocate(chembdy_end(bdy_dims(ibdy),nz,nhalo,nt))
                  allocate(tmp_arry(bdy_dims(ibdy)*nz*nhalo*nt))
                  call mpi_recv(tmp_arry,bdy_dims(ibdy)*nz*nhalo*nt,MPI_FLOAT, &
                  itask(isp,imem),ibdy+1,MPI_COMM_WORLD,stat,ierr)
                  call apm_unpack_3d(tmp_arry,chembdy_end,bdy_dims(ibdy),nz,nhalo,nt)
                  deallocate(tmp_arry)
                  ch_spcs=trim(ch_chem_spc(isp))//trim(bdy_exts(ibdy))
                  call put_WRFCHEM_icbc_data(wrfchem_file_bc,ch_spcs, &
                  chembdy_end(:,:,:,:,ibdy),bdy_dims(ibdy),nz,nhalo,nt)
                  deallocate(chembdy_end)
               enddo
            endif
         enddo
         deallocate(chem3d_end)
      enddo
   endif
!  
   deallocate(ch_chem_spc)
   deallocate(A_chem)
   deallocate(lat,lon)
   deallocate(itask)
   call mpi_finalize(ierr)
   stop
end program main
 
!-------------------------------------------------------------------------------

real function get_dist(lat1,lat2,lon1,lon2)
! returns distance in km
   implicit none
   real:: lat1,lat2,lon1,lon2
   real:: lon_dif,rtemp
   real:: pi,ang2rad,r_earth
   real:: coef_a,coef_c
   pi=4.*atan(1.0)
   ang2rad=pi/180.
   r_earth=6371.393
! Haversine Code
   coef_a=sin((lat2-lat1)/2.*ang2rad) * sin((lat2-lat1)/2.*ang2rad) + & 
   cos(lat1*ang2rad)*cos(lat2*ang2rad) * sin((lon2-lon1)/2.*ang2rad) * &
   sin((lon2-lon1)/2.*ang2rad)
   coef_c=2.*atan2(sqrt(coef_a),sqrt(1.-coef_a))
   get_dist=abs(coef_c*r_earth)
end function get_dist

!-------------------------------------------------------------------------------

subroutine vertical_transform(A_chem,geo_ht,nx,ny,nz,nz_chem,corr_lngth_vt)
   implicit none
   integer,                               intent(in)   :: nx,ny,nz,nz_chem
   real,                                  intent(in)   :: corr_lngth_vt
   real,dimension(nx,ny,nz),              intent(in)   :: geo_ht
   real,dimension(nx,ny,nz_chem,nz_chem), intent(out)  :: A_chem
!
   integer             :: i,j,k,l,ll
   real                :: vcov
!
   A_chem(:,:,:,:)=0. 
   do k=1,nz_chem
      do l=1,nz_chem
         do i=1,nx
            do j=1,ny
               vcov=1.-abs(geo_ht(i,j,k)-geo_ht(i,j,l))/corr_lngth_vt
               if(vcov.lt.0.) vcov=0.
!
! linear decrease
!               A_chem(i,j,k,l)=vcov
!
! exponential decrease
!               if(vcov.ne.0.) then               
!                  A_chem(i,j,k,l)=exp(1. - 1./vcov)
!               endif
!
! square root decrease
               A_chem(i,j,k,l)=vcov    
               if(vcov.ne.1.) then               
                  A_chem(i,j,k,l)=sqrt(1. - (1.-vcov)*(1.-vcov))
               endif
            enddo
         enddo
      enddo
   enddo
!
! Old code
! row 1         
!               if(k.eq.1 .and. l.eq.1) then
!                  A_chem(i,j,k,l)=1.
!               elseif(k.eq.1 .and. l.gt.1) then
!                  A_chem(i,j,k,l)=0.
!               endif
! row 2         
!               if(k.eq.2 .and. l.eq.1) then
!                  A_chem(i,j,k,l)=vcov
!               elseif(k.eq.2 .and. l.eq.2) then
!                  A_chem(i,j,k,l)=sqrt(1.-A_chem(i,j,k,l-1)*A_chem(i,j,k,l-1))
!               elseif (k.eq.2 .and. l.gt.2) then
!                  A_chem(i,j,k,l)=0.
!               endif
! row 3 and greater         
!               if(k.ge.3) then
!                  if(l.eq.1) then
!                     A_chem(i,j,k,l)=vcov
!                  elseif(l.lt.k .and. l.ne.1) then
!                     do ll=1,l-1
!                        A_chem(i,j,k,l)=A_chem(i,j,k,l)+A_chem(i,j,l,ll)*A_chem(i,j,k,ll)
!                     enddo
!                     if(A_chem(i,j,l,l).ne.0) A_chem(i,j,k,l)=(vcov-A_chem(i,j,k,l))/A_chem(i,j,l,l)
!                  elseif(l.eq.k) then
!                     do ll=1,l-1
!                        A_chem(i,j,k,l)=A_chem(i,j,k,l)+A_chem(i,j,k,ll)*A_chem(i,j,k,ll)
!                     enddo
!                     A_chem(i,j,k,l)=sqrt(1.-A_chem(i,j,k,l))
!                  endif
!               endif
end subroutine vertical_transform

!-------------------------------------------------------------------------------

subroutine perturb_fields(fld_new,lat,lon,A_chem, &
nx,ny,nz,ngrid_corr,corr_lngth_hz,rank,sprd_chem)

!   use apm_utilities_mod,  only :get_dist
  
   implicit none
   integer,                               intent(in)   :: nx,ny,nz,rank
   integer,                               intent(in)   :: ngrid_corr
   real,                                  intent(in)   :: corr_lngth_hz,sprd_chem
   real,dimension(nx,ny),                 intent(in)   :: lat,lon
   real,dimension(nx,ny,nz,nz),           intent(in)   :: A_chem
   real,dimension(nx,ny,nz),              intent(out)  :: fld_new
!
   integer                             :: i,j,k,ii,jj,kk
   integer                             :: ii_str,ii_end,jj_str,jj_end
   real                                :: pi,get_dist,wwgt,wgt_sum
   real                                :: u_ran_1,u_ran_2,zdist
   real,allocatable,dimension(:)       :: vert_smth
   real,allocatable,dimension(:,:,:)   :: wwgt_sum
   real,allocatable,dimension(:,:,:)   :: fld_new_smth
!
! Constants
   pi=4.*atan(1.)
!
! Define horizontal perturbations (Box-Muller transform N(0,1)
   do i=1,nx
      do j=1,ny
         do k=1,nz
            call random_number(u_ran_1)
            if(u_ran_1.eq.0.) call random_number(u_ran_1)
            call random_number(u_ran_2)
            if(u_ran_2.eq.0.) call random_number(u_ran_2)
            fld_new(i,j,k)=fld_new(i,j,k)*sprd_chem*sqrt(-2.*log(u_ran_1))*cos(2.*pi*u_ran_2)
         enddo
      enddo
   enddo
!
! Apply horizontal correlations
   allocate(fld_new_smth(nx,ny,nz))   
   allocate(wwgt_sum(nx,ny,nz))   
   fld_new_smth(:,:,:)=0.
   wwgt_sum(:,:,:)=0.
   do i=1,nx
      do j=1,ny
         ii_str=max(1,i-ngrid_corr)
         ii_end=min(nx,i+ngrid_corr)
         jj_str=max(1,j-ngrid_corr)
         jj_end=min(ny,j+ngrid_corr)
         do ii=ii_str,ii_end
            do jj=jj_str,jj_end
               zdist=get_dist(lat(ii,jj),lat(i,j),lon(ii,jj),lon(i,j))
               if(zdist.le.2.0*corr_lngth_hz) then
                  wwgt=1./exp(zdist*zdist/corr_lngth_hz/corr_lngth_hz)
                  do k=1,nz
                     fld_new_smth(i,j,k)=fld_new_smth(i,j,k)+wwgt*fld_new(ii,jj,k)
                     wwgt_sum(i,j,k)=wwgt_sum(i,j,k)+wwgt
                  enddo
               endif
            enddo
         enddo
         do k=1,nz
            if(wwgt_sum(i,j,k).gt.0) then
               fld_new_smth(i,j,k)=fld_new_smth(i,j,k)/wwgt_sum(i,j,k)
            else
               fld_new_smth(i,j,k)=fld_new(i,j,k)
            endif                            
         enddo
      enddo
   enddo
   fld_new(:,:,:)=fld_new_smth(:,:,:)
   deallocate(fld_new_smth)
   deallocate(wwgt_sum)
!   
! Apply vertical smoothing
   allocate(vert_smth(nz))
   do i=1,nx
      do j=1,ny
         vert_smth(:)=0.
         do k=1,nz
            wgt_sum=0.
            do kk=1,nz
               vert_smth(k)=vert_smth(k)+A_chem(i,j,k,kk)* &
               fld_new(i,j,kk)
               wgt_sum=wgt_sum+A_chem(i,j,k,kk)
            enddo
         enddo
         do k=1,nz
            fld_new(i,j,k)=vert_smth(k)/wgt_sum
         enddo
      enddo
   enddo
   deallocate(vert_smth) 
end subroutine perturb_fields

!-------------------------------------------------------------------------------

subroutine get_WRFINPUT_land_mask(xland,nx,ny)
   implicit none
   include 'netcdf.inc'
   integer, parameter                    :: maxdim=6
   integer                               :: nx,ny
   integer                               :: i,rc
   integer                               :: f_id
   integer                               :: v_id,v_ndim,typ,natts
   integer,dimension(maxdim)             :: one
   integer,dimension(maxdim)             :: v_dimid
   integer,dimension(maxdim)             :: v_dim
   real,dimension(nx,ny)                 :: xland
   character(len=150)                    :: v_nam
   character*(80)                         :: name
   character*(80)                         :: file
!
! open netcdf file
   file='wrfinput_d01.e001'
   name='XLAND'
   rc = nf_open(trim(file),NF_NOWRITE,f_id)
!   print *, trim(file)
   if(rc.ne.0) then
      print *, 'nf_open error ',trim(file)
      stop
   endif
!
! get variables identifiers
   rc = nf_inq_varid(f_id,trim(name),v_id)
!  print *, v_id
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
   else if(1.ne.v_dim(3)) then             
      print *, 'ERROR: nz dimension conflict ','1',v_dim(3)
      stop
!   else if(1.ne.v_dim(4)) then             
!      print *, 'ERROR: time dimension conflict ',1,v_dim(4)
!      stop
   endif
!
! get data
   one(:)=1
   rc = nf_get_vara_real(f_id,v_id,one,v_dim,xland)
   if(rc.ne.0) then
      print *, 'nf_get_vara_real ', xland(1,1)
      stop
   endif
   rc = nf_close(f_id)
   return
end subroutine get_WRFINPUT_land_mask   

!-------------------------------------------------------------------------------

subroutine get_WRFINPUT_lat_lon(lat,lon,nx,ny)
   implicit none
   include 'netcdf.inc'
   integer, parameter                    :: maxdim=6
   integer                               :: nx,ny
   integer                               :: i,rc
   integer                               :: f_id
   integer                               :: v_id,v_ndim,typ,natts
   integer,dimension(maxdim)             :: one
   integer,dimension(maxdim)             :: v_dimid
  integer,dimension(maxdim)             :: v_dim
   real,dimension(nx,ny)                 :: lat,lon
   character(len=150)                    :: v_nam
   character*(80)                         :: name
   character*(80)                         :: file
!
! open netcdf file
   file='wrfinput_d01.e001'
   name='XLAT'
   rc = nf_open(trim(file),NF_NOWRITE,f_id)
!   print *, trim(file)
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
   else if(1.ne.v_dim(3)) then             
      print *, 'ERROR: nz dimension conflict ','1',v_dim(3)
      stop
!   else if(1.ne.v_dim(4)) then             
!      print *, 'ERROR: time dimension conflict ',1,v_dim(4)
!      stop
   endif
!
! get data
   one(:)=1
   rc = nf_get_vara_real(f_id,v_id,one,v_dim,lat)
   if(rc.ne.0) then
      print *, 'nf_get_vara_real ', lat(1,1)
      stop
   endif
   
   name='XLONG'
   rc = nf_inq_varid(f_id,trim(name),v_id)
   if(rc.ne.0) then
      print *, 'nf_inq_varid error ', v_id
      stop
   endif
   rc = nf_get_vara_real(f_id,v_id,one,v_dim,lon)
   if(rc.ne.0) then
      print *, 'nf_get_vara_real ', lon(1,1)
      stop
   endif
   rc = nf_close(f_id)
   return
end subroutine get_WRFINPUT_lat_lon

!-------------------------------------------------------------------------------

subroutine get_WRFINPUT_geo_ht(geo_ht,nx,ny,nz,nzp,nmem)
   implicit none
   include 'netcdf.inc'
   integer, parameter                    :: maxdim=6
   integer                               :: k,nx,ny,nz,nzp,nmem
   integer                               :: i,imem,rc
   integer                               :: f_id
   integer                               :: v_id_ph,v_id_phb,v_ndim,typ,natts
   integer,dimension(maxdim)             :: one
   integer,dimension(maxdim)             :: v_dimid
   integer,dimension(maxdim)             :: v_dim
   real,dimension(nx,ny,nzp)             :: ph,phb
   real,dimension(nx,ny,nz)              :: geo_ht
   character(len=150)                    :: v_nam
   character*(80)                        :: name,cmem
   character*(80)                        :: file
!
! Loop through members to find ensemble mean geo_ht
   geo_ht(:,:,:)=0.
   do imem=1,nmem
      if(imem.ge.0.and.imem.lt.10) write(cmem,"('.e00',i1)"),imem
      if(imem.ge.10.and.imem.lt.100) write(cmem,"('.e0',i2)"),imem
      if(imem.ge.100.and.imem.lt.1000) write(cmem,"('.e',i3)"),imem
!
! open netcdf file
      file='wrfinput_d01'//trim(cmem)
      rc = nf_open(trim(file),NF_NOWRITE,f_id)
      if(rc.ne.0) then
         print *, 'nf_open error ',trim(file)
         stop
      endif
!
! get variables identifiers
      name='PH'
      rc = nf_inq_varid(f_id,trim(name),v_id_ph)
      if(rc.ne.0) then
         print *, 'nf_inq_varid error ', v_id_ph
         stop
      endif
      name='PHB'
      rc = nf_inq_varid(f_id,trim(name),v_id_phb)
      if(rc.ne.0) then
         print *, 'nf_inq_varid error ', v_id_phb
         stop
      endif
!
! get dimension identifiers
      v_dimid=0
      rc = nf_inq_var(f_id,v_id_ph,v_nam,typ,v_ndim,v_dimid,natts)
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
      else if(nzp.ne.v_dim(3)) then             
         print *, 'ERROR: nzp dimension conflict ','nzp',v_dim(3)
         stop
      endif
!
! get data
      one(:)=1
      rc = nf_get_vara_real(f_id,v_id_ph,one,v_dim,ph)
      if(rc.ne.0) then
         print *, 'nf_get_vara_real ', ph(1,1,1)
         stop
      endif
      rc = nf_get_vara_real(f_id,v_id_phb,one,v_dim,phb)
      if(rc.ne.0) then
         print *, 'nf_get_vara_real ', phb(1,1,1)
         stop
      endif
!
! get mean geo_ht
      do k=1,nz
         geo_ht(:,:,k)=geo_ht(:,:,k)+(ph(:,:,k)+phb(:,:,k)+ph(:,:,k+1)+ &
         phb(:,:,k+1))/2./float(nmem)
      enddo
      rc = nf_close(f_id)
   enddo
end subroutine get_WRFINPUT_geo_ht

!-------------------------------------------------------------------------------

subroutine get_WRFCHEM_emiss_data(file,name,data,nx,ny,nz_chem,nl)
   implicit none
   include 'netcdf.inc'
   integer, parameter                    :: maxdim=6
   integer                               :: nx,ny,nz_chem,nl
   integer                               :: i,rc
   integer                               :: f_id
   integer                               :: v_id,v_ndim,typ,natts
   integer,dimension(maxdim)             :: one
   integer,dimension(maxdim)             :: v_dimid
   integer,dimension(maxdim)             :: v_dim
   real,dimension(nx,ny,nz_chem,nl)      :: data
   character(len=150)                    :: v_nam
   character*(*)                         :: name
   character*(*)                         :: file
!
! open netcdf file
   rc = nf_open(trim(file),NF_SHARE,f_id)
!   print *, trim(file)
   if(rc.ne.0) then
      print *, 'nf_open error in get ',rc, trim(file)
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
   else if(nz_chem.ne.v_dim(3)) then             
      print *, 'ERROR: nz_chem dimension conflict ',nz_chem,v_dim(3)
      stop
   else if(1.ne.v_dim(4)) then             
      print *, 'ERROR: time dimension conflict ',1,v_dim(4)
      stop
   endif
!
! get data
   one(:)=1
   rc = nf_get_vara_real(f_id,v_id,one,v_dim,data)
   if(rc.ne.0) then
      print *, 'nf_get_vara_real ', data(1,1,1,1)
      stop
   endif
   rc = nf_close(f_id)
   return
end subroutine get_WRFCHEM_emiss_data

!-------------------------------------------------------------------------------

subroutine put_WRFCHEM_emiss_data(file,name,data,nx,ny,nz_chem,nl)
   implicit none
   include 'netcdf.inc'
   integer, parameter                    :: maxdim=6
   integer                               :: nx,ny,nz_chem,nl
   integer                               :: i,rc
   integer                               :: f_id
   integer                               :: v_id,v_ndim,typ,natts
   integer,dimension(maxdim)             :: one
   integer,dimension(maxdim)             :: v_dimid
   integer,dimension(maxdim)             :: v_dim
   real,dimension(nx,ny,nz_chem,nl)      :: data
   character(len=150)                    :: v_nam
   character*(*)                         :: name
   character*(*)                         :: file
!
! open netcdf file
   rc = nf_open(trim(file),NF_WRITE,f_id)
   if(rc.ne.0) then
      print *, 'nf_open error in put ',rc, trim(file)
      stop
   endif
!   print *, 'f_id ',f_id
!
! get variables identifiers
    rc = nf_inq_varid(f_id,trim(name),v_id)
!    print *, v_id
    if(rc.ne.0) then
       print *, 'nf_inq_varid error ', v_id
       stop
    endif
!    print *, 'v_id ',v_id
!
! get dimension identifiers
    v_dimid=0
    rc = nf_inq_var(f_id,v_id,v_nam,typ,v_ndim,v_dimid,natts)
!    print *, v_dimid
    if(rc.ne.0) then
       print *, 'nf_inq_var error ', v_dimid
       stop
    endif
!    print *, 'v_ndim, v_dimid ',v_ndim,v_dimid      
!
! get dimensions
    v_dim(:)=1
    do i=1,v_ndim
       rc = nf_inq_dimlen(f_id,v_dimid(i),v_dim(i))
    enddo
!    print *, v_dim
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
    else if(nz_chem.ne.v_dim(3)) then             
       print *, 'ERROR: nz_chem dimension conflict ',nz_chem,v_dim(3)
       stop
    else if(1.ne.v_dim(4)) then             
       print *, 'ERROR: time dimension conflict ',1,v_dim(4)
       stop
    endif
!
! put data
    one(:)=1
   rc = nf_put_vara_real(f_id,v_id,one(1:v_ndim),v_dim(1:v_ndim),data)
   if(rc.ne.0) then
      print *, 'nf_put_vara_real return code ',rc
      print *, 'f_id,v_id ',f_id,v_id
      print *, 'one ',one(1:v_ndim)
      print *, 'v_dim ',v_dim(1:v_ndim)
      stop
   endif
   rc = nf_close(f_id)
   return
end subroutine put_WRFCHEM_emiss_data

!-------------------------------------------------------------------------------

subroutine init_random_seed()
   implicit none
   integer, allocatable :: aseed(:)
   integer :: i, n, un, istat, dt(8), pid, t(2), s
   integer(8) :: count, tms, ierr

   call random_seed(size = n)
   allocate(aseed(n))
!
! Fallback to XOR:ing the current time and pid. The PID is
! useful in case one launches multiple instances of the same
! program in parallel.                                                  
   call system_clock(count)
   if (count /= 0) then
      t = transfer(count, t)
   else
      call date_and_time(values=dt)
      tms = (dt(1) - 1970) * 365_8 * 24 * 60 * 60 * 1000 &
           + dt(2) * 31_8 * 24 * 60 * 60 * 1000 &
           + dt(3) * 24 * 60 * 60 * 60 * 1000 &
           + dt(5) * 60 * 60 * 1000 &
           + dt(6) * 60 * 1000 + dt(7) * 1000 &
           + dt(8)
      t = transfer(tms, t)
   end if
   s = ieor(t(1), t(2))
!   pid = getpid() + 1099279 ! Add a prime
   call pxfgetpid(pid,ierr)
   s = ieor(s, pid)
   if (n >= 3) then
      aseed(1) = t(1) + 36269
      aseed(2) = t(2) + 72551
      aseed(3) = pid
      if (n > 3) then
         aseed(4:) = s + 37 * (/ (i, i = 0, n - 4) /)
      end if
   else
      aseed = s + 37 * (/ (i, i = 0, n - 1 ) /)
   end if
   call random_seed(put=aseed)
end subroutine init_random_seed

!-------------------------------------------------------------------------------

subroutine init_const_random_seed(rank,date)
   implicit none
   integer                          :: rank,date,primes_dim
   integer                          :: n,at,found,i,str
   integer,allocatable,dimension(:) :: primes,aseed
   logical                          :: is_prime
    
   call random_seed(size=n)
   primes_dim=(rank+1)*n
   allocate (aseed(n))
   allocate (primes(primes_dim))
   primes(1)=2
   at=2
   found=1
   do
      is_prime=.true.
      do i=1,found
         if(mod(at,primes(i)).eq.0) then
            is_prime=.false.
            exit
         endif
      enddo
      if(is_prime) then
         found=found+1
         primes(found)=at
      endif
      at=at+1
      if(found.eq.primes_dim) then
         exit
      endif
   enddo
   str=((rank+1)-1)*n+1
   do i=str,primes_dim
      aseed(i-str+1)=date*primes(i)
   enddo
   call random_seed(put=aseed)
   deallocate(aseed,primes)
end subroutine init_const_random_seed

!-------------------------------------------------------------------------------

subroutine apm_pack_3d(A_pck,A_unpck,nx,ny,nz)
   implicit none
   integer                      :: nx,ny,nz,nt
   integer                      :: i,j,k,l,idx
   real,dimension(nx,ny,nz)     :: A_unpck
   real,dimension(nx*ny*nz)     :: A_pck
   idx=0
   do i=1,nx
      do j=1,ny
         do k=1,nz
            idx=idx+1
            A_pck(idx)=A_unpck(i,j,k)
         enddo
      enddo
   enddo
end subroutine apm_pack_3d

!-------------------------------------------------------------------------------

subroutine apm_unpack_3d(A_pck,A_unpck,nx,ny,nz)
   implicit none
   integer                      :: nx,ny,nz
   integer                      :: i,j,k,l,idx
   real,dimension(nx,ny,nz)     :: A_unpck
   real,dimension(nx*ny*nz)     :: A_pck
   idx=0
   do i=1,nx
      do j=1,ny
         do k=1,nz
            idx=idx+1
            A_unpck(i,j,k)=A_pck(idx)
         enddo
      enddo
   enddo
end subroutine apm_unpack_3d

!-------------------------------------------------------------------------------

subroutine apm_pack_4d(A_pck,A_unpck,nx,ny,nz,nt)
   implicit none
   integer                      :: nx,ny,nz,nt
   integer                      :: i,j,k,l,idx
   real,dimension(nx,ny,nz,nt)  :: A_unpck
   real,dimension(nx*ny*nz*nt)  :: A_pck
   idx=0
   do i=1,nx
      do j=1,ny
         do k=1,nz
            do l=1,nt
               idx=idx+1
               A_pck(idx)=A_unpck(i,j,k,l)
            enddo
         enddo
      enddo
   enddo
end subroutine apm_pack_4d

!-------------------------------------------------------------------------------

subroutine apm_unpack_4d(A_pck,A_unpck,nx,ny,nz,nt)
   implicit none
   integer                      :: nx,ny,nz,nt
   integer                      :: i,j,k,l,idx
   real,dimension(nx,ny,nz,nt)  :: A_unpck
   real,dimension(nx*ny*nz*nt)  :: A_pck
   idx=0
   do i=1,nx
      do j=1,ny
         do k=1,nz
            do l=1,nt
               idx=idx+1
               A_unpck(i,j,k,l)=A_pck(idx)
            enddo
         enddo
      enddo
   enddo
end subroutine apm_unpack_4d

!-------------------------------------------------------------------------------

subroutine recenter_factors(chem_fac,nx,ny,nz,num_mems,sprd_chem)
   implicit none
   integer,           intent(in)       :: nx,ny,nz,num_mems
   real,              intent(in)       :: sprd_chem
   real,dimension(nx,ny,nz,num_mems),intent(inout) :: chem_fac
   integer                                         :: i,j,k,imem
   real                                            :: mean,std
   real,dimension(num_mems)                        :: mems,pers
!
! Recenter about ensemble mean
   do i=1,nx
      do j=1,ny
         do k=1,nz
            mems(:)=chem_fac(i,j,k,:)
            mean=sum(mems)/real(num_mems)
            pers=(mems-mean)*(mems-mean)
            std=sqrt(sum(pers)/real(num_mems-1))
            do imem=1,num_mems
               chem_fac(i,j,k,imem)=(chem_fac(i,j,k,imem)-mean)*sprd_chem/std
            enddo
         enddo
      enddo
   enddo
end subroutine recenter_factors

!-------------------------------------------------------------------------------

subroutine get_WRFCHEM_icbc_data(file,name,data,nx,ny,nz,nt)
   implicit none
   include 'netcdf.inc'
   integer, parameter                    :: maxdim=6
   integer                               :: nx,ny,nz,nt
   integer                               :: i,rc
   integer                               :: f_id
   integer                               :: v_id,v_ndim,typ,natts
   integer,dimension(maxdim)             :: one
   integer,dimension(maxdim)             :: v_dimid
   integer,dimension(maxdim)             :: v_dim
   real,dimension(nx,ny,nz,nt)           :: data
   character(len=200)                    :: v_nam
   character*(*)                         :: name
   character*(*)                         :: file
!
! open netcdf file
   rc = nf_open(trim(file),NF_SHARE,f_id)
   if(rc.ne.0) then
      print *, 'nf_open error in get ',rc, trim(file)
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
      print *, 'ERROR: nz dimension conflict ',nz,v_dim(3)
      stop
   else if(nt.ne.v_dim(4)) then             
      print *, 'ERROR: time dimension conflict ',1,v_dim(4)
      stop
   endif
!
! get data
   one(:)=1
   rc = nf_get_vara_real(f_id,v_id,one,v_dim,data)
   rc = nf_close(f_id)
   return
end subroutine get_WRFCHEM_icbc_data

!-------------------------------------------------------------------------------

subroutine put_WRFCHEM_icbc_data(file,name,data,nx,ny,nz,nt)
   implicit none
   include 'netcdf.inc'
   integer, parameter                    :: maxdim=6
   integer                               :: nx,ny,nz,nt
   integer                               :: i,rc
   integer                               :: f_id
   integer                               :: v_id,v_ndim,typ,natts
   integer,dimension(maxdim)             :: one
   integer,dimension(maxdim)             :: v_dimid
   integer,dimension(maxdim)             :: v_dim
   real,dimension(nx,ny,nz,nt)           :: data
   character(len=200)                    :: v_nam
   character*(*)                         :: name
   character*(*)                         :: file
!
! open netcdf file
   rc = nf_open(trim(file),NF_WRITE,f_id)
   if(rc.ne.0) then
      print *, 'nf_open error in put ',rc, trim(file)
      stop
   endif
!   print *, 'f_id ',f_id
!
! get variables identifiers
   rc = nf_inq_varid(f_id,trim(name),v_id)
!   print *, v_id
   if(rc.ne.0) then
      print *, 'nf_inq_varid error ', v_id
      stop
   endif
!   print *, 'v_id ',v_id
!
! get dimension identifiers
   v_dimid=0
   rc = nf_inq_var(f_id,v_id,v_nam,typ,v_ndim,v_dimid,natts)
!   print *, v_dimid
   if(rc.ne.0) then
      print *, 'nf_inq_var error ', v_dimid
      stop
   endif
!   print *, 'v_ndim, v_dimid ',v_ndim,v_dimid      
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
      print *, 'ERROR: nz dimension conflict ',nz,v_dim(3)
      stop
   else if(nt.ne.v_dim(4)) then             
      print *, 'ERROR: time dimension conflict ',1,v_dim(4)
      stop
   endif
!
! put data
   one(:)=1
   rc = nf_put_vara_real(f_id,v_id,one(1:v_ndim),v_dim(1:v_ndim),data)
   rc = nf_close(f_id)
   return
end subroutine put_WRFCHEM_icbc_data
!
subroutine horiz_grid_wts(iref,jref,indx,jndx,ncnt,wgt,wgt_sum,lon,lat,nx,ny,nxy, &
ngrid_corr,corr_lngth_hz,rank)
   implicit none
   integer,                          intent(in)  :: nx,ny,nxy,ngrid_corr
   integer,                          intent(in)  :: rank
   integer,                          intent(out) :: iref,jref,ncnt
   integer,dimension(nxy),           intent(out) :: indx,jndx
   real,                             intent(in)  :: corr_lngth_hz
   real,                             intent(out) :: wgt_sum
   real,dimension(nxy),              intent(out) :: wgt
   real,dimension(nx,ny),            intent(in)  :: lon,lat
!
   integer                           :: i,j,ii,jj,ii_str,ii_end,jj_str,jj_end
   real                              :: zdist,get_dist
!
   ncnt=0
   wgt_sum=0.
   ii_str=max(1,iref-ngrid_corr)
   ii_end=min(nx,iref+ngrid_corr)
   jj_str=max(1,jref-ngrid_corr)
   jj_end=min(ny,jref+ngrid_corr)
   do ii=ii_str,ii_end
      do jj=jj_str,jj_end
         zdist=get_dist(lat(ii,jj),lat(iref,jref),lon(ii,jj),lon(iref,jref))
         if(zdist.le.2.0*corr_lngth_hz) then
            ncnt=ncnt+1
            indx(ncnt)=ii
            jndx(ncnt)=jj
            wgt(ncnt)=1./exp(zdist*zdist/corr_lngth_hz/corr_lngth_hz)
            wgt_sum=wgt_sum+wgt(ncnt)
         endif
      enddo
   enddo
end subroutine horiz_grid_wts
