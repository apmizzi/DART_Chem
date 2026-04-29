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

! code to perturb the wrfchem ICBC files

program main
   implicit none
   include 'mpif.h'
   character(len=*), parameter :: source   = 'perturb_chem_emiss_CORR_RT_MA_MPI.f90'
   character(len=*), parameter :: revision = ''
   character(len=*), parameter :: revdate  = ''
   integer,parameter                           :: nbdy_exts=8, nbdy_exts_hlf=4
   integer,parameter                           :: nhalo=5
   character(len=5),parameter,dimension(nbdy_exts) :: bdy_exts=(/'_BXS','_BXE','_BYS','_BYE','_BTXS', &
   '_BTXE','_BTYS','_BTYE'/)
!
   integer                                     :: ierr,rank,num_procs,num_procs_avail
   integer                                     :: nt,ntp,unit,unita,unitb,date
   integer                                     :: nx,ny,nz,nxy,nxyz,nzp,nchem_spcs
   integer                                     :: num_mems,status,ngrid_corr,zfac_fld,zfac_bdy
   integer                                     :: h,i,ii,j,ij,n,jj,k,kk,l,isp,imem,ibdy,bdy_idx
   integer                                     :: ifile,icnt,ncnt,ntasks,icnt_tsk,seed_trm
   integer                                     :: ic_ipt,ic_jpt
   integer                                     :: bdy_ipt,k_ipt,halo_ipt,n_ipt
   integer,dimension(8)                        :: date_time_vals
   integer,dimension(MPI_STATUS_SIZE)          :: stat
   integer,dimension(nbdy_exts)                :: bdy_dims
   integer,allocatable,dimension(:)            :: itask
   integer,allocatable,dimension(:,:,:)        :: ilabel
   
!
   real                                        :: pi,grav,zfac,tfac,sum,zero_exp
   real                                        :: nnum_mems,sprd_chem,delt,rsprd_crit
   real                                        :: corr_lngth_hz,corr_lngth_vt,corr_lngth_tm
   real                                        :: corr_tm_delt,grid_length
   real                                        :: wgt_bc_str,wgt_bc_mid,wgt_bc_end
   real                                        :: get_dist,wgt_end,scl_fac_ics,scl_fac_bcs
   real                                        :: u_ran_1,u_ran_2,ztrm
   real                                        :: bdy_exp_term1,bdy_exp_term2,bdy_exp_term3
   real,allocatable,dimension(:,:)             :: lat,lon
   real,allocatable,dimension(:,:,:)           :: geo_ht,chem_data_end
   real,allocatable,dimension(:,:,:)           :: chem_mem,zfld
   real,allocatable,dimension(:,:,:)           :: chem_vari_new,chem_vari_end
   real,allocatable,dimension(:,:,:)           :: chem_data3d,chem_vari3d
   real,allocatable,dimension(:,:,:)           :: ens_mean,ens_vari,chem_parent
   real,allocatable,dimension(:,:,:,:)         :: A_chem
   real,allocatable,dimension(:,:,:,:)         :: bdy_mem,zzfld
   real,allocatable,dimension(:,:,:,:)         :: bdy_vari_new,bdy_vari_end
   real,allocatable,dimension(:,:,:,:)         :: bdy_data4d,bdy_tend_data4d
   real,allocatable,dimension(:,:,:,:)         :: bdy_vari4d,bdy_tend_vari4d
   real,allocatable,dimension(:,:,:,:)         :: bdy_ens_mean,bdy_tend_ens_mean
   real,allocatable,dimension(:,:,:,:)         :: bdy_ens_vari,bdy_tend_ens_vari
   real,allocatable,dimension(:,:,:,:)         :: bdy_parent,bdy_tend_parent
   real,allocatable,dimension(:,:,:,:)         :: bdy_terms,bdy_vari_terms
   real,allocatable,dimension(:)               :: tmp_arry
!
   character(len=20)                           :: cmem
   character(len=100)                          :: ch_date,ch_time,ch_zone
   character(len=300)                          :: ch_spcs,filenm
   character(len=300)                          :: pert_path_old,pert_path_new
   character(len=300)                          :: wrfinput_file_old,wrfinput_file_new
   character(len=300)                          :: wrfbdy_file_old,wrfbdy_file_new,wrfbdy_vari_new
   character(len=300)                          :: wrfchem_file
   character(len=300),allocatable,dimension(:) :: ch_chem_spc
!
   logical                                     :: sw_corr_tm,sw_seed,sw_bdy_only
!
   namelist /perturb_chem_icbc_corr_nml/date,nx,ny,nz,nchem_spcs,nnum_mems,pert_path_old,pert_path_new, &
   wrfinput_file_new,wrfbdy_file_new,sprd_chem,corr_lngth_hz,corr_lngth_vt, &
   corr_lngth_tm,corr_tm_delt,sw_corr_tm,sw_seed,sw_bdy_only
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
   ntp=nt+1
   zfac=1.
   zfac_fld=4.
   zfac_bdy=4.
   tfac=60.*60.
   icnt_tsk=1
   zero_exp=-30.
   zero_exp=0.
   sw_bdy_only=.false.
   rsprd_crit=1.
!
! Read control namelist
   unit=20
   open(unit=unit,file='perturb_chem_icbc_corr_nml.nl',form='formatted', &
   status='old',action='read')
   rewind(unit)   
   read(unit,perturb_chem_icbc_corr_nml)
   close(unit)
   if(rank.eq.0) then
      print *, 'date                ',date
      print *, 'nx                  ',nx
      print *, 'ny                  ',ny
      print *, 'nz                  ',nz
      print *, 'nchem_spcs          ',nchem_spcs
      print *, 'num_mems            ',nnum_mems
      print *, 'pert_path_old       ',trim(pert_path_old)
      print *, 'pert_path_new       ',trim(pert_path_new)
      print *, 'wrfinput_file_new   ',trim(wrfinput_file_new)
      print *, 'wrfbdy_file_new     ',trim(wrfbdy_file_new)
      print *, 'sprd_chem           ',sprd_chem
      print *, 'corr_lngth_hz       ',corr_lngth_hz
      print *, 'corr_lngth_vt       ',corr_lngth_vt
      print *, 'corr_lngth_tm       ',corr_lngth_tm
      print *, 'corr_tm_delt        ',corr_tm_delt
      print *, 'sw_corr_tm          ',sw_corr_tm
      print *, 'sw_seed             ',sw_seed
      print *, 'sw_bdy_only         ',sw_bdy_only
   endif
!   sw_corr_tm=.false.
!   sw_bdy_only=.true.
   nzp=nz+1
   num_mems=nint(nnum_mems)
   delt=corr_tm_delt*3600./2.
   wgt_end=exp(-1.0*corr_tm_delt/corr_lngth_tm)
   bdy_dims=(/ny,ny,nx,nx,ny,ny,nx,nx/)
   wrfinput_file_old=trim(wrfinput_file_new)
   wrfbdy_file_old=trim(wrfbdy_file_new)
!
! Allocate arrays
   allocate(ch_chem_spc(nchem_spcs))
!
! Read the species namelist
   unit=20
   open( unit=unit,file='perturb_chem_icbc_spcs_nml.nl',form='formatted', &
   status='old',action='read')
   rewind(unit)
   read(unit,perturb_chem_icbc_spcs_nml)
   close(unit)
!   do isp=1,nchem_spcs
!      if(rank.eq.0) print *,' ICBCs ',trim(ch_chem_spc(isp)) 
!   enddo
!
! Allocate vertical smoothing arrays
   allocate(A_chem(nx,ny,nz,nz))
   A_chem(:,:,:,:)=0.
!
! Get lat / lon data (-90 to 90; -180 to 180)
   allocate(lat(nx,ny),lon(nx,ny))
   call get_WRFINPUT_lat_lon(lat,lon,nx,ny)
!
! Get mean geopotential height data
   allocate(geo_ht(nx,ny,nz))
   call get_WRFINPUT_geo_ht(geo_ht,nx,ny,nz,nzp)
   geo_ht(:,:,:)=geo_ht(:,:,:)/grav
!
! Get horiztonal grid length
   grid_length=get_dist(lat(nx/2,ny/2),lat(nx/2+1,ny/2),lon(nx/2,ny/2),lon(nx/2+1,ny/2))
!
! Calculate number of horizontal grid points to be correlated 
   ngrid_corr=ceiling(zfac*corr_lngth_hz/grid_length)+1
!
! Construct the vertical weights
   call vertical_transform(A_chem,geo_ht,nx,ny,nz,nz,corr_lngth_vt)
!   do k=1,nz
!      print *, 'A_chem row ',k,': ',(A_chem(nx/2,ny/2,k,kk),kk=1,nz)
!   enddo
   deallocate(geo_ht)
!
! Allocate processors (reserve rank 0)
   allocate(itask(nchem_spcs))
   do isp=1,nchem_spcs
      itask(isp)=isp-1+icnt_tsk
!      print *, 'ITASK ',isp,itask(isp)
   enddo
!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!
! RANK 0   RANK 0   RANK 0
!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!
   if(rank.eq.0) then
!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!
! READ NEW ICs AND SEND TO OTHER PROCESSORS
!      
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!
      if(.not.sw_bdy_only) then
!!!         wrfchem_file=trim(pert_path_new)//'/'//trim(wrfinput_file_new)
!!!         allocate(tmp_arry(nx*ny*nz))
!!!         allocate(chem_data3d(nx,ny,nz))
!!!         do isp=1,nchem_spcs
!!!            call get_WRFCHEM_icbc_data(wrfchem_file,ch_chem_spc(isp),chem_data3d, &
!!!            nx,ny,nz)
!!!!
!!!! Use log transform
!!!            ic_ipt=0
!!!            ic_jpt=0
!!!            do i=1,nx
!!!               do j=1,ny
!!!                  do k=1,nz
!!!                     if(chem_data3d(i,j,k).gt.0.) then
!!!                        chem_data3d(i,j,k)=log(chem_data3d(i,j,k))
!!!                        if(ic_ipt.eq.0.and.ic_jpt.eq.0) then
!!!                           ic_ipt=i
!!!                           ic_jpt=j
!!!                        endif
!!!                     else
!!!                        chem_data3d(i,j,k)=zero_exp
!!!                     endif
!!!                  enddo
!!!               enddo
!!!            enddo
!!!            call apm_pack(tmp_arry,chem_data3d,nx,ny,nz)
!!!            call mpi_send(tmp_arry,nx*ny*nz,MPI_FLOAT, &
!!!            itask(isp),1,MPI_COMM_WORLD,ierr)
!!!         enddo
!!!         deallocate(tmp_arry)
!!!         deallocate(chem_data3d)
!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!
! RECEIVE NEW PERTURBATION VARIANCE FROM OTHER PROCESSORS
! READ ICs, APPLY NEW VARIANCE, AND WRITE TO IC FILE
!      
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!        
         do isp=1,nchem_spcs
!
! Receive new ensemble error variance
            allocate(tmp_arry(nx*ny*nz))
            allocate(chem_vari_new(nx,ny,nz))
            call mpi_recv(tmp_arry,nx*ny*nz,MPI_FLOAT, &
            itask(isp),1,MPI_COMM_WORLD,stat,ierr)
            call apm_unpack(tmp_arry,chem_vari_new,nx,ny,nz)
            deallocate(tmp_arry)
!
! Read field to be perturbed
            wrfchem_file=trim(pert_path_new)//'/'//trim(wrfinput_file_new)
            allocate(chem_data3d(nx,ny,nz))
            call get_WRFCHEM_icbc_data(wrfchem_file,trim(ch_chem_spc(isp)),chem_data3d, &
            nx,ny,nz)
!
! Use log transform
            do i=1,nx
               do j=1,ny
                  do k=1,nz
                     if(chem_data3d(i,j,k).gt.0.) then
                        chem_data3d(i,j,k)=log(chem_data3d(i,j,k))
                     else
                        chem_data3d(i,j,k)=zero_exp
                     endif
                  enddo
               enddo
            enddo
!
! Read old ensemble perturbation variance
            allocate(chem_vari_end(nx,ny,nz))
            if(sw_corr_tm) then            
               wrfchem_file=trim(pert_path_old)//'/'//trim(wrfinput_file_old)//'_pert_vari'
               allocate(chem_vari3d(nx,ny,nz))
               call get_WRFCHEM_icbc_data(wrfchem_file,trim(ch_chem_spc(isp)),chem_vari3d, &
               nx,ny,nz)
!
! Calculate temporally smoothed ensemble error variance            
               do i=1,nx
                  do j=1,ny
                     do k=1,nz
                        chem_vari_end(i,j,k)=wgt_end*chem_vari3d(i,j,k)+ &
                        (1.-wgt_end)*chem_vari_new(i,j,k)
                     enddo
                  enddo
               enddo
               deallocate(chem_vari3d)
            else
               do i=1,nx
                  do j=1,ny
                     do k=1,nz
                        chem_vari_end(i,j,k)=chem_vari_new(i,j,k)
                     enddo
                  enddo
               enddo
            endif
            deallocate(chem_vari_new)
!
! Limit the new relative spread
!             do i=1,nx
!               do j=1,ny
!                  do k=1,nz
!                     if(chem_data3d(i,j,k).gt.0.) then
!                        if(sqrt(chem_vari_end(i,j,k))/chem_data3d(i,j,k).gt.rsprd_crit) then
!                           chem_vari_end(i,j,k)=(chem_data3d(i,j,k)*rsprd_crit)**2.
!                        endif
!                     endif
!                  enddo
!               enddo
!            enddo
!
! Write new ensemble perturbagtion variance
            wrfchem_file=trim(pert_path_new)//'/'//trim(wrfinput_file_new)//'_pert_vari'
            call put_WRFCHEM_icbc_data(wrfchem_file,ch_chem_spc(isp),chem_vari_end, &
            nx,ny,nz)
!
! For each ensemble member generate perturbed field
!!!            allocate(zfld(nx,ny,nz))
            allocate(chem_mem(nx,ny,nz))
            sum=0.
            do imem=1,num_mems
               if(imem.ge.0.and.imem.lt.10) write(cmem,"('.e00',i1)"),imem
               if(imem.ge.10.and.imem.lt.100) write(cmem,"('.e0',i2)"),imem
               if(imem.ge.100.and.imem.lt.1000) write(cmem,"('.e',i3)"),imem
!
! Generate N(0,1) filed
!!!               do i=1,nx
!!!                  do j=1,ny
!!!                     do k=1,nz
!!!                        call random_number(u_ran_1)
!!!                        if(u_ran_1.eq.0.) call random_number(u_ran_1)
!!!                        call random_number(u_ran_2)
!!!                        if(u_ran_2.eq.0.) call random_number(u_ran_2)
!!!                        zfld(i,j,k)=sqrt(-2.*log(u_ran_1))*cos(2.*pi*u_ran_2)
!!!                     enddo
!!!                  enddo
!!!               enddo
!
! Impose the temporally smoothed ensemble error variance and new ensemble mean    
               call random_number(u_ran_1)
               if(u_ran_1.eq.0.) call random_number(u_ran_1)
               call random_number(u_ran_2)
               if(u_ran_2.eq.0.) call random_number(u_ran_2)
               ztrm=sqrt(-2.*log(u_ran_1))*cos(2.*pi*u_ran_2)
               do i=1,nx
                  do j=1,ny
                     do k=1,nz
                        if(chem_data3d(i,j,k).ne.0.) then
!                           chem_mem(i,j,k)=exp(chem_data3d(i,j,k)+zfld(i,j,k)* &
!                           sqrt(chem_vari_end(i,j,k)))
                           chem_mem(i,j,k)=exp(chem_data3d(i,j,k)+ztrm* &
                           sqrt(chem_vari_end(i,j,k)))
                        else
                           chem_mem(i,j,k)=0.
                        endif
                     enddo
                  enddo
               enddo
!
! Write data for the perturbed member
               wrfchem_file=trim(pert_path_new)//'/'//trim(wrfinput_file_new)//cmem
               call put_WRFCHEM_icbc_data(wrfchem_file,trim(ch_chem_spc(isp)),chem_mem, &
               nx,ny,nz)
!
! Check means and relative spread
               sum=sum+chem_mem(nx/2,ny/2,1)/real(num_mems)
            enddo
! non-log form            
!            print *,'APM: ',isp,trim(ch_chem_spc(isp)),sum,chem_data3d(nx/2,ny/2,1), &
!            sqrt(chem_vari_end(nx/2,ny/2,1))/chem_data3d(nx/2,ny/2,1)*100.,'%'
! log form
            if(chem_data3d(nx/2,ny/2,1).ne.0) then
               print *,'APM: ',isp,trim(ch_chem_spc(isp)),sum,exp(chem_data3d(nx/2,ny/2,1))
            else
               print *,'APM: ',isp,trim(ch_chem_spc(isp)),sum,chem_data3d(nx/2,ny/2,1)        
            endif
!
!!!            deallocate(zfld)
            deallocate(chem_mem)
            deallocate(chem_data3d)
            deallocate(chem_vari_end)
         enddo
!
! Calculate ensemble mean, variance and recenter
         allocate(ens_mean(nx,ny,nz))
         allocate(ens_vari(nx,ny,nz))
         allocate(chem_parent(nx,ny,nz))
         allocate(chem_data3d(nx,ny,nz))
         do isp=1,nchem_spcs
!
! Calculate ensemble mean
            ens_mean(:,:,:)=0.
            do imem=1,num_mems
               if(imem.ge.0.and.imem.lt.10) write(cmem,"('.e00',i1)"),imem
               if(imem.ge.10.and.imem.lt.100) write(cmem,"('.e0',i2)"),imem
               if(imem.ge.100.and.imem.lt.1000) write(cmem,"('.e',i3)"),imem
               wrfchem_file=trim(pert_path_new)//'/'//trim(wrfinput_file_new)//cmem
               call get_WRFCHEM_icbc_data(wrfchem_file,trim(ch_chem_spc(isp)),chem_data3d, &
               nx,ny,nz)
               do i=1,nx
                  do j=1,ny
                     do k=1,nz
                        ens_mean(i,j,k)=ens_mean(i,j,k)+chem_data3d(i,j,k)
                     enddo
                  enddo
               enddo
            enddo
            ens_mean(:,:,:)=ens_mean(:,:,:)/real(num_mems)
!
! Calculate ensemble variance
            ens_vari(:,:,:)=0.
            do imem=1,num_mems
               if(imem.ge.0.and.imem.lt.10) write(cmem,"('.e00',i1)"),imem
               if(imem.ge.10.and.imem.lt.100) write(cmem,"('.e0',i2)"),imem
               if(imem.ge.100.and.imem.lt.1000) write(cmem,"('.e',i3)"),imem
               wrfchem_file=trim(pert_path_new)//'/'//trim(wrfinput_file_new)//cmem
               call get_WRFCHEM_icbc_data(wrfchem_file,trim(ch_chem_spc(isp)),chem_data3d, &
               nx,ny,nz)
               do i=1,nx
                  do j=1,ny
                     do k=1,nz
                        ens_vari(i,j,k)=ens_vari(i,j,k)+(chem_data3d(i,j,k)-ens_mean(i,j,k))**2.
                     enddo
                  enddo
               enddo
            enddo
            ens_vari(:,:,:)=ens_vari(:,:,:)/real(num_mems-1)
!
! Recenter the ensemble members
            wrfchem_file=trim(pert_path_new)//'/'//trim(wrfinput_file_new)
            call get_WRFCHEM_icbc_data(wrfchem_file,trim(ch_chem_spc(isp)),chem_parent, &
            nx,ny,nz)
            do imem=1,num_mems
               if(imem.ge.0.and.imem.lt.10) write(cmem,"('.e00',i1)"),imem
               if(imem.ge.10.and.imem.lt.100) write(cmem,"('.e0',i2)"),imem
               if(imem.ge.100.and.imem.lt.1000) write(cmem,"('.e',i3)"),imem
               wrfchem_file=trim(pert_path_new)//'/'//trim(wrfinput_file_new)//cmem
               call get_WRFCHEM_icbc_data(wrfchem_file,trim(ch_chem_spc(isp)),chem_data3d, &
               nx,ny,nz)
               do i=1,nx
                  do j=1,ny
                     do k=1,nz
                        chem_data3d(i,j,k)=chem_data3d(i,j,k)-ens_mean(i,j,k)+chem_parent(i,j,k)
                     enddo
                  enddo
               enddo
               wrfchem_file=trim(pert_path_new)//'/'//trim(wrfinput_file_new)//cmem
               call put_WRFCHEM_icbc_data(wrfchem_file,trim(ch_chem_spc(isp)),chem_data3d, &
               nx,ny,nz)
            enddo
!
! Write ensemble mean and variance
            wrfchem_file=trim(pert_path_new)//'/'//trim(wrfinput_file_new)//'_mean'
            call put_WRFCHEM_icbc_data(wrfchem_file,trim(ch_chem_spc(isp)),ens_mean, &
            nx,ny,nz)
            wrfchem_file=trim(pert_path_new)//'/'//trim(wrfinput_file_new)//'_vari'
            call put_WRFCHEM_icbc_data(wrfchem_file,trim(ch_chem_spc(isp)),ens_vari, &
            nx,ny,nz)
         enddo
         deallocate(ens_mean)
         deallocate(ens_vari)
         deallocate(chem_parent)
         deallocate(chem_data3d)
      endif
!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!
! READ NEW BCs AND SEND TO OTHER PROCESSORS
!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!
! Use log transform with non-tendency terms, i.e., the BC is log-normal and has the form e^x.
! For tendency terms d(e^x)/dt = e^x * dx/dt. We have d(e^x)/dt in ibdy(5,8) and e^x in ibdy(1,4).
! In log form of perturbation variance, we multiply x by the perturbation standard deviation
! which comes from the product of an N(0,1) variable and perturbation variance. Assume the N(0,1)
! variable is independent of time, so dx/t equals the product of the N(0,1) variable and the
! temporal derivative of the perturbation standard deviation.
!
      do ibdy=1,nbdy_exts_hlf
         print *, 'APM: Process ibdy ',ibdy
!!!         allocate(tmp_arry(bdy_dims(ibdy)*nz*nhalo*ntp))
!!!         allocate(bdy_data4d(bdy_dims(ibdy),nz,nhalo,nt))
!!!         allocate(bdy_tend_data4d(bdy_dims(ibdy),nz,nhalo,nt))
!!!         allocate(bdy_terms(bdy_dims(ibdy),nz,nhalo,ntp))
!!!         do isp=1,nchem_spcs
!!!!
!!!! Read non-tendency (ibdy 1 - 4) and the associated tendency (ibdy 5 - 8)
!!!            wrfchem_file=trim(pert_path_new)//'/'//trim(wrfbdy_file_new)
!!!            ch_spcs=trim(ch_chem_spc(isp))//trim(bdy_exts(ibdy))
!!!            call get_WRFCHEM_bdy_data(wrfchem_file,trim(ch_spcs),bdy_data4d, &
!!!            bdy_dims(ibdy),nz,nhalo,nt)
!!!!
!!!            ch_spcs=trim(ch_chem_spc(isp))//trim(bdy_exts(ibdy+4))
!!!            call get_WRFCHEM_bdy_data(wrfchem_file,trim(ch_spcs),bdy_tend_data4d, &
!!!            bdy_dims(ibdy+4),nz,nhalo,nt)
!!!!
!!!! Calculate last non-tendency term. Done in physical space.
!!!            do ij=1,bdy_dims(ibdy)
!!!               do k=1,nz
!!!                  do l=1,nhalo
!!!                     bdy_terms(ij,k,l,1)=bdy_data4d(ij,k,l,1)
!!!                     bdy_terms(ij,k,l,2)=bdy_data4d(ij,k,l,2)
!!!                     bdy_terms(ij,k,l,3)=bdy_data4d(ij,k,l,2)+bdy_tend_data4d(ij,k,l,2)*delt
!!!                  enddo
!!!               enddo
!!!            enddo
!!!            ch_spcs=trim(ch_chem_spc(isp))//trim(bdy_exts(ibdy))
!!!!
!!!! Apply log transform
!!!            bdy_ipt=0
!!!            k_ipt=0
!!!            halo_ipt=0
!!!            n_ipt=0
!!!            do ij=1,bdy_dims(ibdy)
!!!               do k=1,nz
!!!                  do l=1,nhalo
!!!                     do n=1,ntp
!!!                        if(bdy_terms(ij,k,l,n).gt.0) then
!!!                           bdy_terms(ij,k,l,n)=log(bdy_terms(ij,k,l,n))
!!!                           if(bdy_ipt.eq.0.and.k_ipt.eq.0.and.halo_ipt.eq.0.and.n_ipt.eq.0) then
!!!                              bdy_ipt=ij
!!!                              k_ipt=k
!!!                              halo_ipt=l
!!!                              n_ipt=n
!!!                           endif
!!!                        else
!!!                           bdy_terms(ij,k,l,n)=zero_exp
!!!                        endif
!!!                     enddo
!!!                  enddo
!!!               enddo
!!!            enddo
!!!!
!!!! Send to other processors
!!!            call apm_pack4d(tmp_arry,bdy_terms,bdy_dims(ibdy),nz,nhalo,ntp)
!!!            call mpi_send(tmp_arry,bdy_dims(ibdy)*nz*nhalo*ntp,MPI_FLOAT, &
!!!            itask(isp),2+ibdy,MPI_COMM_WORLD,ierr)
!!!            ch_spcs=trim(ch_chem_spc(isp))//trim(bdy_exts(ibdy))
!!!         enddo
!!!         deallocate(tmp_arry)
!!!         deallocate(bdy_data4d)
!!!         deallocate(bdy_tend_data4d)
!!!         deallocate(bdy_terms)
!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!
! RECEIVE NEW PERTURBATION VARIANCE FROM OTHER PROCESSORS
! READ BCs, APPLY NEW VARIANCE, AND WRITE TO BC FILE
!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!
         do isp=1,nchem_spcs
!
! Receive new ensemble error variance. These are in log space
            allocate(tmp_arry(bdy_dims(ibdy)*nz*nhalo*ntp))
            allocate(bdy_vari_new(bdy_dims(ibdy),nz,nhalo,ntp))
            ch_spcs=trim(ch_chem_spc(isp))//trim(bdy_exts(ibdy))
            call mpi_recv(tmp_arry,bdy_dims(ibdy)*nz*nhalo*ntp,MPI_FLOAT, &
            itask(isp),2+ibdy,MPI_COMM_WORLD,stat,ierr)
            call apm_unpack4d(tmp_arry,bdy_vari_new,bdy_dims(ibdy),nz,nhalo,ntp)
            deallocate (tmp_arry)
!
! Read BDY fields to be perturbed. These are read in physical space.
! Read non-tendency (ibdy 1 - 4) and the associated tendency (ibdy 5 - 8)
            wrfchem_file=trim(pert_path_new)//'/'//trim(wrfbdy_file_new)
            allocate(bdy_data4d(bdy_dims(ibdy),nz,nhalo,nt))
            allocate(bdy_tend_data4d(bdy_dims(ibdy),nz,nhalo,nt))
            allocate(bdy_terms(bdy_dims(ibdy),nz,nhalo,ntp))
            ch_spcs=trim(ch_chem_spc(isp))//trim(bdy_exts(ibdy))
            call get_WRFCHEM_bdy_data(wrfchem_file,trim(ch_spcs),bdy_data4d, &
            bdy_dims(ibdy),nz,nhalo,nt)
!
            ch_spcs=trim(ch_chem_spc(isp))//trim(bdy_exts(ibdy+4))
            call get_WRFCHEM_bdy_data(wrfchem_file,trim(ch_spcs),bdy_tend_data4d, &
            bdy_dims(ibdy+4),nz,nhalo,nt)
!
! Calculate last non-tendency term. Done in physical space.
            do ij=1,bdy_dims(ibdy)
               do k=1,nz
                  do l=1,nhalo
                     bdy_terms(ij,k,l,1)=bdy_data4d(ij,k,l,1)
                     bdy_terms(ij,k,l,2)=bdy_data4d(ij,k,l,2)
                     bdy_terms(ij,k,l,3)=bdy_data4d(ij,k,l,2)+bdy_tend_data4d(ij,k,l,2)*delt
                  enddo
               enddo
            enddo
            deallocate(bdy_data4d)
            deallocate(bdy_tend_data4d)
!
! Apply log transform
            do ij=1,bdy_dims(ibdy)
               do k=1,nz
                  do l=1,nhalo
                     do n=1,ntp
                        if(bdy_terms(ij,k,l,n).gt.0) then
                           bdy_terms(ij,k,l,n)=log(bdy_terms(ij,k,l,n))
                        else
                           bdy_terms(ij,k,l,n)=zero_exp
                        endif
                     enddo
                  enddo
               enddo
            enddo
!
! Read old ensemble perturbation variance. These are in log space.
            allocate(bdy_vari_end(bdy_dims(ibdy),nz,nhalo,ntp))
            if(sw_corr_tm) then
               wrfchem_file=trim(pert_path_old)//'/'//trim(wrfbdy_file_old)//'_pert_vari'
               allocate(bdy_vari4d(bdy_dims(ibdy),nz,nhalo,nt))
               allocate(bdy_tend_vari4d(bdy_dims(ibdy),nz,nhalo,nt))
               allocate(bdy_vari_terms(bdy_dims(ibdy),nz,nhalo,ntp))
               ch_spcs=trim(ch_chem_spc(isp))//trim(bdy_exts(ibdy))
               call get_WRFCHEM_bdy_data(wrfchem_file,trim(ch_spcs),bdy_vari4d, &
               bdy_dims(ibdy),nz,nhalo,nt)
!
               ch_spcs=trim(ch_chem_spc(isp))//trim(bdy_exts(ibdy+4))
               call get_WRFCHEM_bdy_data(wrfchem_file,trim(ch_spcs),bdy_tend_vari4d, &
               bdy_dims(ibdy+4),nz,nhalo,nt)
!
! Calculate last non-tendency term. These are in log spaace
               do ij=1,bdy_dims(ibdy)
                  do k=1,nz
                     do l=1,nhalo
                        bdy_vari_terms(ij,k,l,1)=bdy_vari4d(ij,k,l,1)
                        bdy_vari_terms(ij,k,l,2)=bdy_vari4d(ij,k,l,2)
                        bdy_vari_terms(ij,k,l,3)=bdy_vari4d(ij,k,l,2)+bdy_tend_vari4d(ij,k,l,2)*delt
                     enddo
                  enddo
               enddo
               deallocate(bdy_vari4d)
               deallocate(bdy_tend_vari4d)
!
! Calculate temporally smoothed ensemble error variance. These are in log space.
               do ij=1,bdy_dims(ibdy)
                  do k=1,nz
                     do l=1,nhalo
                        do n=1,ntp
                           bdy_vari_end(ij,k,l,n)=wgt_end*bdy_vari_terms(ij,k,l,n)+ &
                           (1.-wgt_end)*bdy_vari_new(ij,k,l,n)
                        enddo
                     enddo
                  enddo
               enddo
               deallocate(bdy_vari_terms)
            else
               do ij=1,bdy_dims(ibdy)
                  do k=1,nz
                     do l=1,nhalo
                        do n=1,ntp
                           bdy_vari_end(ij,k,l,n)=bdy_vari_new(ij,k,l,n)
                        enddo
                     enddo
                  enddo
               enddo
            endif
            deallocate(bdy_vari_new)
!
! Limit the new relative spread
!            do ij=1,bdy_dims(ibdy)
!               do k=1,nz
!                  do l=1,nhalo
!                     do n=1,ntp
!                        if(bdy_terms(ij,k,l,n).gt.0.) then
!                           if(sqrt(bdy_vari_end(ij,k,l,n))/bdy_terms(ij,k,l,n).gt.rsprd_crit) then
!                              bdy_vari_end(ij,k,l,n)=(bdy_terms(ij,k,l,n)*rsprd_crit)**2.
!                           endif
!                        endif
!                     enddo
!                  enddo
!               enddo
!            enddo
!
! Calculate new variance terms for storage. These are in log space.
! The log space tendencies are used to calculate the end-time variance. 
            allocate(bdy_vari4d(bdy_dims(ibdy),nz,nhalo,nt))
            allocate(bdy_tend_vari4d(bdy_dims(ibdy),nz,nhalo,nt))
            do ij=1,bdy_dims(ibdy)
               do k=1,nz
                  do l=1,nhalo
                     bdy_vari4d(ij,k,l,1)=bdy_vari_end(ij,k,l,1)
                     bdy_vari4d(ij,k,l,2)=bdy_vari_end(ij,k,l,2)
                     bdy_tend_vari4d(ij,k,l,1)=(bdy_vari_end(ij,k,l,2)- &
                     bdy_vari_end(ij,k,l,1))/delt
                     bdy_tend_vari4d(ij,k,l,2)=(bdy_vari_end(ij,k,l,3)- &
                     bdy_vari_end(ij,k,l,2))/delt
                  enddo
               enddo
            enddo
!
! Write new ensemble error variance. These are in log space.
            wrfchem_file=trim(pert_path_new)//'/'//trim(wrfbdy_file_new)//'_pert_vari'
            ch_spcs=trim(ch_chem_spc(isp))//trim(bdy_exts(ibdy))
            call put_WRFCHEM_bdy_data(wrfchem_file,ch_spcs,bdy_vari4d, &
            bdy_dims(ibdy),nz,nhalo,nt)
!
            ch_spcs=trim(ch_chem_spc(isp))//trim(bdy_exts(ibdy+4))
            call put_WRFCHEM_bdy_data(wrfchem_file,ch_spcs,bdy_tend_vari4d, &
            bdy_dims(ibdy+4),nz,nhalo,nt)
            deallocate(bdy_vari4d)
            deallocate(bdy_tend_vari4d)
!
! For each member generate perturbed field
            sum=0.
            do imem=1,num_mems
               if(imem.ge.0.and.imem.lt.10) write(cmem,"('.e00',i1)"),imem
               if(imem.ge.10.and.imem.lt.100) write(cmem,"('.e0',i2)"),imem
               if(imem.ge.100.and.imem.lt.1000) write(cmem,"('.e',i3)"),imem
!!!               allocate(zzfld(bdy_dims(ibdy),nz,nhalo,ntp))
               allocate(bdy_mem(bdy_dims(ibdy),nz,nhalo,ntp))
!
! Generate N(0,1) field
!!!               do ij=1,bdy_dims(ibdy)
!!!                  do k=1,nz
!!!                     do l=1,nhalo
!!!                        do n=1,ntp
!!!                           call random_number(u_ran_1)
!!!                           if(u_ran_1.eq.0.) call random_number(u_ran_1)
!!!                           call random_number(u_ran_2)
!!!                           if(u_ran_2.eq.0.) call random_number(u_ran_2)
!!!                           zzfld(ij,k,l,n)=sqrt(-2.*log(u_ran_1))*cos(2.*pi*u_ran_2)
!!!                        enddo
!!!                     enddo
!!!                  enddo
!!!               enddo
!
! Impose temporally smoothed ensemble error variance and new ensemble mean.
               call random_number(u_ran_1)
               if(u_ran_1.eq.0.) call random_number(u_ran_1)
               call random_number(u_ran_2)
               if(u_ran_2.eq.0.) call random_number(u_ran_2)
               ztrm=sqrt(-2.*log(u_ran_1))*cos(2.*pi*u_ran_2)
               do ij=1,bdy_dims(ibdy)
                  do k=1,nz
                     do l=1,nhalo
                        do n=1,ntp
                           if(bdy_terms(ij,k,l,n).ne.0.) then
!                              bdy_mem(ij,k,l,n)=exp(bdy_terms(ij,k,l,n)+zzfld(ij,k,l,n)* &
!                              sqrt(bdy_vari_end(ij,k,l,n)))
                              bdy_mem(ij,k,l,n)=exp(bdy_terms(ij,k,l,n)+ztrm* &
                              sqrt(bdy_vari_end(ij,k,l,n)))
                           else
                              bdy_mem(ij,k,l,n)=0.
                           endif
                        enddo
                     enddo
                  enddo
               enddo
!!!               deallocate(zzfld)
!
! Calculate the perturbed BDY terms
               allocate(bdy_data4d(bdy_dims(ibdy),nz,nhalo,nt))
               allocate(bdy_tend_data4d(bdy_dims(ibdy),nz,nhalo,nt))
               do ij=1,bdy_dims(ibdy)
                  do k=1,nz
                     do l=1,nhalo
                        bdy_data4d(ij,k,l,1)=bdy_mem(ij,k,l,1)
                        bdy_data4d(ij,k,l,2)=bdy_mem(ij,k,l,2)
                        bdy_tend_data4d(ij,k,l,1)=(bdy_mem(ij,k,l,2) - &
                        bdy_mem(ij,k,l,1))/delt
                        bdy_tend_data4d(ij,k,l,2)=(bdy_mem(ij,k,l,3) - &
                        bdy_mem(ij,k,l,2))/delt
                     enddo
                  enddo
               enddo
               deallocate(bdy_mem)
!
! Write data for perturbed member
               wrfchem_file=trim(pert_path_new)//'/'//trim(wrfbdy_file_new)//cmem
               ch_spcs=trim(ch_chem_spc(isp))//trim(bdy_exts(ibdy))
               call put_WRFCHEM_bdy_data(wrfchem_file,ch_spcs,bdy_data4d, &
               bdy_dims(ibdy),nz,nhalo,nt)
!
               ch_spcs=trim(ch_chem_spc(isp))//trim(bdy_exts(ibdy+4))
               call put_WRFCHEM_bdy_data(wrfchem_file,ch_spcs,bdy_tend_data4d, &
               bdy_dims(ibdy+4),nz,nhalo,nt)
!
               sum=sum+bdy_data4d(ibdy,nz/2,nhalo/2,2)/real(num_mems)
               deallocate(bdy_data4d)
               deallocate(bdy_tend_data4d)
            enddo
            ch_spcs=trim(ch_chem_spc(isp))//trim(bdy_exts(ibdy))
            if(bdy_terms(ibdy,nz/2,nhalo/2,2).ne.0.) then
               print *,'APM: ',isp,trim(ch_spcs),sum,exp(bdy_terms(ibdy,nz/2,nhalo/2,2))
            else
               print *,'APM: ',isp,trim(ch_spcs),sum,bdy_terms(ibdy,nz/2,nhalo/2,2)
            endif
            deallocate(bdy_terms)
            deallocate(bdy_vari_end)
         enddo
      enddo
!
! Calculate ensemble mean, variance and recenter      
      do isp=1,nchem_spcs
         do ibdy=1,nbdy_exts_hlf
            allocate(bdy_ens_mean(bdy_dims(ibdy),nz,nhalo,nt))
            allocate(bdy_tend_ens_mean(bdy_dims(ibdy),nz,nhalo,nt))
            allocate(bdy_ens_vari(bdy_dims(ibdy),nz,nhalo,nt))
            allocate(bdy_tend_ens_vari(bdy_dims(ibdy),nz,nhalo,nt))
            allocate(bdy_parent(bdy_dims(ibdy),nz,nhalo,nt))
            allocate(bdy_tend_parent(bdy_dims(ibdy),nz,nhalo,nt))
            allocate(bdy_data4d(bdy_dims(ibdy),nz,nhalo,nt))
            allocate(bdy_tend_data4d(bdy_dims(ibdy),nz,nhalo,nt))
!
! Calculate ensemble mean
            bdy_ens_mean(:,:,:,:)=0.
            bdy_tend_ens_mean(:,:,:,:)=0.
            do imem=1,num_mems
               if(imem.ge.0.and.imem.lt.10) write(cmem,"('.e00',i1)"),imem
               if(imem.ge.10.and.imem.lt.100) write(cmem,"('.e0',i2)"),imem
               if(imem.ge.100.and.imem.lt.1000) write(cmem,"('.e',i3)"),imem
               wrfchem_file=trim(pert_path_new)//'/'//trim(wrfbdy_file_new)//cmem
               ch_spcs=trim(ch_chem_spc(isp))//trim(bdy_exts(ibdy))
               call get_WRFCHEM_bdy_data(wrfchem_file,trim(ch_spcs),bdy_data4d, &
               bdy_dims(ibdy),nz,nhalo,nt)
!
               ch_spcs=trim(ch_chem_spc(isp))//trim(bdy_exts(ibdy+4))
               call get_WRFCHEM_bdy_data(wrfchem_file,trim(ch_spcs),bdy_tend_data4d, &
               bdy_dims(ibdy),nz,nhalo,nt)
               do ij=1,bdy_dims(ibdy)
                  do k=1,nz
                     do l=1,nhalo
                        do n=1,nt
                           bdy_ens_mean(ij,k,l,n)=bdy_ens_mean(ij,k,l,n)+ &
                           bdy_data4d(ij,k,l,n)
                           bdy_tend_ens_mean(ij,k,l,n)=bdy_tend_ens_mean(ij,k,l,n)+ &
                           bdy_tend_data4d(ij,k,l,n)
                        enddo
                     enddo
                  enddo
               enddo
            enddo
            bdy_ens_mean(:,:,:,:)=bdy_ens_mean(:,:,:,:)/real(num_mems)
            bdy_tend_ens_mean(:,:,:,:)=bdy_tend_ens_mean(:,:,:,:)/real(num_mems)
!
! Calculate ensemble variance
            bdy_ens_vari(:,:,:,:)=0.
            bdy_tend_ens_vari(:,:,:,:)=0.
            do imem=1,num_mems
               if(imem.ge.0.and.imem.lt.10) write(cmem,"('.e00',i1)"),imem
               if(imem.ge.10.and.imem.lt.100) write(cmem,"('.e0',i2)"),imem
               if(imem.ge.100.and.imem.lt.1000) write(cmem,"('.e',i3)"),imem
               wrfchem_file=trim(pert_path_new)//'/'//trim(wrfbdy_file_new)//cmem
               ch_spcs=trim(ch_chem_spc(isp))//trim(bdy_exts(ibdy))
               call get_WRFCHEM_bdy_data(wrfchem_file,trim(ch_spcs),bdy_data4d, &
               bdy_dims(ibdy),nz,nhalo,nt)
!
               ch_spcs=trim(ch_chem_spc(isp))//trim(bdy_exts(ibdy+4))
               call get_WRFCHEM_bdy_data(wrfchem_file,trim(ch_spcs),bdy_tend_data4d, &
               bdy_dims(ibdy),nz,nhalo,nt)
               do ij=1,bdy_dims(ibdy)
                  do k=1,nz
                     do l=1,nhalo
                        do n=1,nt
                           bdy_ens_vari(ij,k,l,n)=bdy_ens_vari(ij,k,l,n)+ &
                           (bdy_data4d(ij,k,l,n)-bdy_ens_mean(ij,k,l,n))**2.
                           bdy_tend_ens_vari(ij,k,l,n)=bdy_tend_ens_vari(ij,k,l,n)+ &
                           (bdy_tend_data4d(ij,k,l,n)-bdy_tend_ens_mean(ij,k,l,n))**2.
                        enddo
                     enddo
                  enddo
               enddo
            enddo
            bdy_ens_vari(:,:,:,:)=bdy_ens_vari(:,:,:,:)/real(num_mems-1)
            bdy_tend_ens_vari(:,:,:,:)=bdy_tend_ens_vari(:,:,:,:)/real(num_mems-1)
!
! Recenter the ensemble members
            wrfchem_file=trim(pert_path_new)//'/'//trim(wrfbdy_file_new)
            ch_spcs=trim(ch_chem_spc(isp))//trim(bdy_exts(ibdy))
            call get_WRFCHEM_bdy_data(wrfchem_file,trim(ch_spcs),bdy_parent, &
            bdy_dims(ibdy),nz,nhalo,nt)
!
            ch_spcs=trim(ch_chem_spc(isp))//trim(bdy_exts(ibdy+4))
            call get_WRFCHEM_bdy_data(wrfchem_file,trim(ch_spcs),bdy_tend_parent, &
            bdy_dims(ibdy+4),nz,nhalo,nt)
            do imem=1,num_mems
               if(imem.ge.0.and.imem.lt.10) write(cmem,"('.e00',i1)"),imem
               if(imem.ge.10.and.imem.lt.100) write(cmem,"('.e0',i2)"),imem
               if(imem.ge.100.and.imem.lt.1000) write(cmem,"('.e',i3)"),imem
               wrfchem_file=trim(pert_path_new)//'/'//trim(wrfbdy_file_new)//cmem
               ch_spcs=trim(ch_chem_spc(isp))//trim(bdy_exts(ibdy))
               call get_WRFCHEM_bdy_data(wrfchem_file,trim(ch_spcs),bdy_data4d, &
               bdy_dims(ibdy),nz,nhalo,nt)
!
               ch_spcs=trim(ch_chem_spc(isp))//trim(bdy_exts(ibdy+4))
               call get_WRFCHEM_bdy_data(wrfchem_file,trim(ch_spcs),bdy_tend_data4d, &
               bdy_dims(ibdy),nz,nhalo,nt)
               do ij=1,bdy_dims(ibdy)
                  do k=1,nz
                     do l=1,nhalo
                        do n=1,nt
                           bdy_data4d(ij,k,l,n)=bdy_data4d(ij,k,l,n)-bdy_ens_mean(ij,k,l,n)+ &
                           bdy_parent(ij,k,l,n)
                           bdy_tend_data4d(ij,k,l,n)=bdy_tend_data4d(ij,k,l,n)- &
                           bdy_tend_ens_mean(ij,k,l,n)+bdy_tend_parent(ij,k,l,n)
                        enddo     
                     enddo
                  enddo
               enddo
               wrfchem_file=trim(pert_path_new)//'/'//trim(wrfbdy_file_new)//cmem
               ch_spcs=trim(ch_chem_spc(isp))//trim(bdy_exts(ibdy))
               call put_WRFCHEM_bdy_data(wrfchem_file,ch_spcs,bdy_data4d, &
               bdy_dims(ibdy),nz,nhalo,nt)
!
               ch_spcs=trim(ch_chem_spc(isp))//trim(bdy_exts(ibdy+4))
               call put_WRFCHEM_bdy_data(wrfchem_file,ch_spcs,bdy_tend_data4d, &
               bdy_dims(ibdy+4),nz,nhalo,nt)
            enddo
!
! Write ensemble mean and variance
            wrfchem_file=trim(pert_path_new)//'/'//trim(wrfbdy_file_new)//'_mean'
            ch_spcs=trim(ch_chem_spc(isp))//trim(bdy_exts(ibdy))
            call put_WRFCHEM_bdy_data(wrfchem_file,ch_spcs,bdy_ens_mean, &
            bdy_dims(ibdy),nz,nhalo,nt)
!
            ch_spcs=trim(ch_chem_spc(isp))//trim(bdy_exts(ibdy+4))
            call put_WRFCHEM_bdy_data(wrfchem_file,ch_spcs,bdy_tend_ens_mean, &
            bdy_dims(ibdy+4),nz,nhalo,nt)
!
            wrfchem_file=trim(pert_path_new)//'/'//trim(wrfbdy_file_new)//'_vari'
            ch_spcs=trim(ch_chem_spc(isp))//trim(bdy_exts(ibdy))
            call put_WRFCHEM_bdy_data(wrfchem_file,ch_spcs,bdy_ens_vari, &
            bdy_dims(ibdy),nz,nhalo,nt)
!
            ch_spcs=trim(ch_chem_spc(isp))//trim(bdy_exts(ibdy+4))
            call put_WRFCHEM_bdy_data(wrfchem_file,ch_spcs,bdy_tend_ens_vari, &
            bdy_dims(ibdy+4),nz,nhalo,nt)
!           
            deallocate(bdy_ens_mean)
            deallocate(bdy_tend_ens_mean)
            deallocate(bdy_ens_vari)
            deallocate(bdy_tend_ens_vari)
            deallocate(bdy_parent)
            deallocate(bdy_tend_parent)
            deallocate(bdy_data4d)
            deallocate(bdy_tend_data4d)
         enddo
      enddo




      print *,'APM: Finished all ibdy terms'
   endif
!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!
! RANK itask(isp)   RANK itask(isp)   RANK itask(isp)
!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!
   if(rank.ne.0) then
!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!
! ICs
!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!
      if(.not.sw_bdy_only) then
         do isp=1,nchem_spcs
            if(rank.eq.itask(isp)) then
!
! Receive new IC fields
!!!               allocate(tmp_arry(nx*ny*nz))
               allocate(chem_vari_new(nx,ny,nz))
!!!               call mpi_recv(tmp_arry,nx*ny*nz, &
!!!               MPI_FLOAT,0,1,MPI_COMM_WORLD,stat,ierr)
!!!               call apm_unpack(tmp_arry,chem_vari_new,nx,ny,nz)
!!!               deallocate(tmp_arry)
!
! Calculate new error variance
               call date_and_time(ch_date,ch_time,ch_zone,date_time_vals)
               seed_trm=date_time_vals(5)*date_time_vals(6)*date_time_vals(7)
               if(sw_seed) call init_const_random_seed(rank,seed_trm)
!
               call perturb_icbc_fields(chem_vari_new,lat,lon,A_chem,nx,ny,nz, &
               ngrid_corr,corr_lngth_hz,rank,sprd_chem,nchem_spcs)
            endif
         enddo
!
         do isp=1,nchem_spcs
            if(rank.eq.itask(isp)) then
!
! Send new perturbation variance to rank 0
               allocate(tmp_arry(nx*ny*nz))
               call apm_pack(tmp_arry,chem_vari_new,nx,ny,nz)
               call mpi_send(tmp_arry,nx*ny*nz,MPI_FLOAT, &
               0,1,MPI_COMM_WORLD,ierr)
               deallocate(tmp_arry)
            endif
         enddo
         deallocate(chem_vari_new)
      endif
!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!
! BCs
!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!
! Receive new BC fields. These are in log space.
      do ibdy=1,nbdy_exts_hlf
         allocate(bdy_vari_new(bdy_dims(ibdy),nz,nhalo,ntp))
         do isp=1,nchem_spcs
            if(rank.eq.itask(isp)) then
               bdy_vari_new(:,:,:,:)=0.
!!!               allocate(tmp_arry(bdy_dims(ibdy)*nz*nhalo*ntp))
!!!               ch_spcs=trim(ch_chem_spc(isp))//trim(bdy_exts(ibdy))
!!!               call mpi_recv(tmp_arry,bdy_dims(ibdy)*nz*nhalo*ntp, &
!!!               MPI_FLOAT,0,2+ibdy,MPI_COMM_WORLD,stat,ierr)
!!!               call apm_unpack4d(tmp_arry,bdy_vari_new,bdy_dims(ibdy),nz,nhalo,ntp)
!!!               deallocate(tmp_arry)
!
! Calculate new error variance. Done in log space.
               call date_and_time(ch_date,ch_time,ch_zone,date_time_vals)
               seed_trm=date_time_vals(5)*date_time_vals(6)*date_time_vals(7)
               if(sw_seed) call init_const_random_seed(rank,seed_trm)
!
               call perturb_bdy_fields(bdy_vari_new,lat,lon,A_chem, &
               ngrid_corr,corr_lngth_hz,sprd_chem,ibdy,bdy_dims(ibdy),nz,nhalo,ntp,nx,ny,rank)
            endif
         enddo
!
         do isp=1,nchem_spcs
            if(rank.eq.itask(isp)) then
!
! Send new perturbation variance to rank 0
               allocate(tmp_arry(bdy_dims(ibdy)*nz*nhalo*ntp))
               call apm_pack4d(tmp_arry,bdy_vari_new,bdy_dims(ibdy),nz,nhalo,ntp)
               call mpi_send(tmp_arry,bdy_dims(ibdy)*nz*nhalo*ntp,MPI_FLOAT, &
               0,2+ibdy,MPI_COMM_WORLD,ierr)
               deallocate(tmp_arry)
            endif
         enddo
         deallocate(bdy_vari_new)
      enddo
   endif
   deallocate(ch_chem_spc)
   deallocate(A_chem)
   deallocate(lat,lon)
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
   real                :: vcov,vcov_exp,del_geop
!
   A_chem(:,:,:,:)=0. 
   do k=1,nz_chem
      do l=1,nz_chem
         do i=1,nx
            do j=1,ny
               del_geop=abs(geo_ht(i,j,k)-geo_ht(i,j,l))
               if(del_geop.le.corr_lngth_vt) then
                  vcov=1.-del_geop/corr_lngth_vt
                  vcov_exp=1./exp(del_geop*del_geop/corr_lngth_vt/corr_lngth_vt)
                  if(geo_ht(i,j,k).lt.0. .or. geo_ht(i,j,l).lt.0.) then
                     vcov=0.
                     vcov_exp=0.
                  endif
                  if(vcov.lt.0.) vcov=0.
!
! linear decrease
!                  A_chem(i,j,k,l)=vcov
!
! exponential decrease
                  A_chem(i,j,k,l)=vcov_exp
!
! square root decrease
!                  A_chem(i,j,k,l)=vcov    
!                  if(vcov.ne.1.) then               
!                     A_chem(i,j,k,l)=sqrt(1. - (1.-vcov)*(1.-vcov))
!                  endif
               endif   
            enddo
         enddo
      enddo
   enddo
end subroutine vertical_transform

!-------------------------------------------------------------------------------

subroutine perturb_icbc_fields(chem_vari_new,lat,lon,A_chem,nx,ny,nz, &
ngrid_corr,corr_lngth_hz,rank,sprd_chem,nspc)
!   use apm_utilities_mod,  only :get_dist  
   implicit none
   integer,                               intent(in)     :: nx,ny,nz,rank,nspc
   integer,                               intent(in)     :: ngrid_corr
   real,                                  intent(in)     :: corr_lngth_hz,sprd_chem
   real,dimension(nx,ny),                 intent(in)     :: lat,lon
   real,dimension(nx,ny,nz,nz),           intent(in)     :: A_chem
   real,dimension(nx,ny,nz),              intent(inout)  :: chem_vari_new
!
   integer                             :: i,j,k,ii,jj,kk
   integer                             :: ii_str,ii_end,jj_str,jj_end,icnt,ncnt
   real                                :: pi,get_dist,wgt,zero_exp
   real                                :: u_ran_1,u_ran_2,zdist
   real,allocatable,dimension(:)       :: fld_sum,wgt_sum
   real,allocatable,dimension(:,:,:)   :: pert_chem_new
   real,allocatable,dimension(:,:,:)   :: chem_vari_newp
   real,allocatable,dimension(:,:,:)   :: chem_vari_new_smth
!
! Constants
   pi=4.*atan(1.)
   zero_exp=-30.
   zero_exp=0.
!
! Define perturbation variance (Box-Muller transform N(0,1)   
   allocate(pert_chem_new(nx,ny,nz))
   pert_chem_new(:,:,:)=0.
   do i=1,nx
      do j=1,ny
         do k=1,nz
            call random_number(u_ran_1)
            if(u_ran_1.eq.0.) call random_number(u_ran_1)
            call random_number(u_ran_2)
            if(u_ran_2.eq.0.) call random_number(u_ran_2)
!            pert_chem_new(i,j,k)=(chem_vari_new(i,j,k)*sprd_chem*sqrt(-2.* &
!            log(u_ran_1))*cos(2.*pi*u_ran_2))**2.
            pert_chem_new(i,j,k)=(sprd_chem*sqrt(-2.* &
            log(u_ran_1))*cos(2.*pi*u_ran_2))**2.
         enddo
      enddo
   enddo
!
! Apply horizontal correlations
   allocate(fld_sum(nz))
   allocate(wgt_sum(nz))
   allocate(chem_vari_newp(nx,ny,nz))
   chem_vari_newp(:,:,:)=0.
   do i=1,nx
      do j=1,ny
         ii_str=max(1,i-ngrid_corr)
         ii_end=min(nx,i+ngrid_corr)
         jj_str=max(1,j-ngrid_corr)
         jj_end=min(ny,j+ngrid_corr)
         fld_sum(:)=0.
         wgt_sum(:)=0.
         do ii=ii_str,ii_end
            do jj=jj_str,jj_end
               zdist=get_dist(lat(ii,jj),lat(i,j),lon(ii,jj),lon(i,j))
               if(zdist.le.corr_lngth_hz) then
                  wgt=1./exp(zdist*zdist/corr_lngth_hz/corr_lngth_hz)
                  do k=1,nz
!                     if(pert_chem_new(ii,jj,k).ne.zero_exp) then
                        fld_sum(k)=fld_sum(k)+wgt*pert_chem_new(ii,jj,k)
                        wgt_sum(k)=wgt_sum(k)+wgt
!                     endif
                  enddo
               endif
            enddo
         enddo
         do k=1,nz
            if(wgt_sum(k).gt.0.) then
               chem_vari_newp(i,j,k)=fld_sum(k)/wgt_sum(k)
            else
               chem_vari_newp(i,j,k)=pert_chem_new(i,j,k)
            endif
         enddo
      enddo
   enddo
   deallocate(pert_chem_new)
!
! Apply vertical correlations
   allocate(chem_vari_new_smth(nx,ny,nz))
   chem_vari_new_smth(:,:,:)=0.
   do i=1,nx
      do j=1,ny
         fld_sum(:)=0.
         wgt_sum(:)=0.
         do k=1,nz
            do kk=1,nz
!               if(chem_vari_newp(i,j,k).ne.zero_exp) then
                  fld_sum(k)=fld_sum(k)+A_chem(i,j,k,kk)*chem_vari_newp(i,j,kk)
                  wgt_sum(k)=wgt_sum(k)+A_chem(i,j,k,kk)
!               endif
            enddo
         enddo
         do k=1,nz
            if(wgt_sum(k).gt.0.) then
               chem_vari_new_smth(i,j,k)=fld_sum(k)/wgt_sum(k)
            else              
               chem_vari_new_smth(i,j,k)=chem_vari_newp(i,j,k)
            endif
         enddo
      enddo
   enddo
   chem_vari_new(:,:,:)=chem_vari_new_smth(:,:,:)
   deallocate(chem_vari_newp)
   deallocate(chem_vari_new_smth)
   deallocate(fld_sum)
   deallocate(wgt_sum)
end subroutine perturb_icbc_fields

!-------------------------------------------------------------------------------

subroutine perturb_bdy_fields(bdy_vari_new,lat,lon,A_chem,ngrid_corr, &
corr_lngth_hz,sprd_chem,ibdy,bdy_dim,nz,nhalo,ntp,nx,ny,rank)
   implicit none
   integer,                               intent(in)     :: nx,ny,nz,ibdy
   integer,                               intent(in)     :: ngrid_corr,rank
   integer,                               intent(in)     :: nhalo,ntp,bdy_dim
   real,                                  intent(in)     :: corr_lngth_hz,sprd_chem
   real,dimension(nx,ny),                 intent(in)     :: lat,lon
   real,dimension(bdy_dim,nz,nhalo,ntp),  intent(inout)  :: bdy_vari_new
   real,dimension(nx,ny,nz,nz),           intent(in)     :: A_chem
!
   integer                             :: i,j,k,l,n,ii,jj,kk,ll,ij,ijp
   integer                             :: ij_str,ij_end
   real                                :: pi,u_ran_1,u_ran_2,zero_exp
   real                                :: wgt,zdist,get_dist
   real                                :: zlat1,zlat2,zlon1,zlon2
   real,allocatable,dimension(:,:)     :: fld_sum,wgt_sum
   real,allocatable,dimension(:,:,:,:) :: pert_chem_new
   real,allocatable,dimension(:,:,:,:) :: bdy_vari_newp
   real,allocatable,dimension(:,:,:,:) :: bdy_vari_new_smth
!
! Constants
   pi=4.*atan(1.)
   zero_exp=-30.
   zero_exp=0.
!
! Define perturbations (Box-Muller transform N(0,1)
   allocate(pert_chem_new(bdy_dim,nz,nhalo,ntp))
   pert_chem_new(:,:,:,:)=0.
   do ij=1,bdy_dim
      do k=1,nz
         do l=1,nhalo
            do n=1,ntp
               call random_number(u_ran_1)
               if(u_ran_1.eq.0.) call random_number(u_ran_1)
               call random_number(u_ran_2)
               if(u_ran_2.eq.0.) call random_number(u_ran_2)
!               pert_chem_new(ij,k,l,n)=(bdy_vari_new(ij,k,l,n)*sprd_chem*sqrt(-2.* &
!               log(u_ran_1))*cos(2.*pi*u_ran_2))**2.
               pert_chem_new(ij,k,l,n)=(sprd_chem*sqrt(-2.* &
               log(u_ran_1))*cos(2.*pi*u_ran_2))**2.
            enddo
         enddo
      enddo
   enddo
!
! Apply horizontal correlations
   allocate(fld_sum(nz,ntp))   
   allocate(wgt_sum(nz,ntp))
   allocate(bdy_vari_newp(bdy_dim,nz,nhalo,ntp))
   bdy_vari_newp(:,:,:,:)=0.
    do ij=1,bdy_dim
      ij_str=max(1,ij-ngrid_corr)
!
! ibdy=1 BXS
! ibdy=2 BXE
      i=-999
      j=-999
      if(ibdy.eq.1.or.ibdy.eq.2) then 
         i=1
         if(ibdy/2*2.eq.ibdy) i=nx 
         ij_end=min(ny,ij+ngrid_corr)
!
! ibdy=3 BYS
! ibdy=4 BYE
      elseif(ibdy.eq.3.or.ibdy.eq.4) then 
         j=1
         if(ibdy/2*2.eq.ibdy) j=ny
         ij_end=min(nx,ij+ngrid_corr)
      endif
      do l=1,nhalo
         fld_sum(:,:)=0.
         wgt_sum(:,:)=0.
         do ijp=ij_str,ij_end
            do ll=1,nhalo
               if (i.eq.1) then
                  zdist=get_dist(lat(i+ll-1,ijp),lat(i+l-1,ij),lon(i+ll-1,ijp),lon(i+l-1,ij))
               elseif(i.eq.nx) then
                  zdist=get_dist(lat(i-ll+1,ijp),lat(i-l+1,ij),lon(i-ll+1,ijp),lon(i-l+1,ij))
               elseif (j.eq.1) then
                  zdist=get_dist(lat(ijp,j+ll-1),lat(ij,j+l-1),lon(ijp,j+ll-1),lon(ij,j+l-1))
               elseif(j.eq.ny) then
                  zdist=get_dist(lat(ijp,j-ll+1),lat(ij,j-l+1),lon(ijp,j-ll+1),lon(ij,j-l+1))
               endif
               if(zdist.le.corr_lngth_hz) then
                  wgt=1./exp(zdist*zdist/corr_lngth_hz/corr_lngth_hz)
                  do n=1,ntp
                     do k=1,nz
!                        if(pert_chem_new(ijp,k,ll,n).ne.zero_exp) then
                           fld_sum(k,n)=fld_sum(k,n)+wgt*pert_chem_new(ijp,k,ll,n)
                           wgt_sum(k,n)=wgt_sum(k,n)+wgt
!                        endif
                     enddo
                  enddo
               endif
            enddo
         enddo
         do n=1,ntp
            do k=1,nz
               if(wgt_sum(k,n).gt.0.) then
                  bdy_vari_newp(ij,k,l,n)=fld_sum(k,n)/wgt_sum(k,n)
               else
                  bdy_vari_newp(ij,k,l,n)=pert_chem_new(ij,k,l,n)
               endif
            enddo
         enddo
      enddo
   enddo
   deallocate(pert_chem_new)
!
! Apply vertical correlations
   allocate(bdy_vari_new_smth(bdy_dim,nz,nhalo,ntp))
   bdy_vari_new_smth(:,:,:,:)=0.
   i=-999
   j=-999
   if(ibdy.eq.1.or.ibdy.eq.2) then 
      i=1
      if(ibdy/2*2.eq.ibdy) i=nx 
   elseif(ibdy.eq.3.or.ibdy.eq.4) then 
      j=1
      if(ibdy/2*2.eq.ibdy) j=ny
   endif
   do ij=1,bdy_dim
      do l=1,nhalo
         fld_sum(:,:)=0.
         wgt_sum(:,:)=0.
         do kk=1,nz
            do k=1,nz
               do n=1,ntp
!                  if(bdy_vari_newp(ij,kk,l,n).ne.zero_exp) then
                     if(i.eq.1) then
                        fld_sum(k,n)=fld_sum(k,n)+A_chem(i+l-1,ij,k,kk)*bdy_vari_newp(ij,kk,l,n)
                        wgt_sum(k,n)=wgt_sum(k,n)+A_chem(i+l-1,ij,k,kk)
                     elseif(i.eq.nx) then
                        fld_sum(k,n)=fld_sum(k,n)+A_chem(i-l+1,ij,k,kk)*bdy_vari_newp(ij,kk,l,n)
                        wgt_sum(k,n)=wgt_sum(k,n)+A_chem(i-l+1,ij,k,kk)
                     elseif(j.eq.1) then
                        fld_sum(k,n)=fld_sum(k,n)+A_chem(ij,j+l-1,k,kk)*bdy_vari_newp(ij,kk,l,n)
                        wgt_sum(k,n)=wgt_sum(k,n)+A_chem(ij,j+l-1,k,kk)
                     elseif(j.eq.ny) then
                        fld_sum(k,n)=fld_sum(k,n)+A_chem(ij,j-l+1,k,kk)*bdy_vari_newp(ij,kk,l,n)
                        wgt_sum(k,n)=wgt_sum(k,n)+A_chem(ij,j-l+1,k,kk)
                     endif
!                  endif
               enddo
            enddo
         enddo
         do n=1,ntp
            do k=1,nz
               if(wgt_sum(k,n).gt.0.) then
                  bdy_vari_new_smth(ij,k,l,n)=fld_sum(k,n)/wgt_sum(k,n)
               else
                  bdy_vari_new_smth(ij,k,l,n)=bdy_vari_newp(ij,k,l,n)
               endif
            enddo
         enddo
      enddo
   enddo
   bdy_vari_new(:,:,:,:)=bdy_vari_new_smth(:,:,:,:)
   deallocate(bdy_vari_newp)
   deallocate(bdy_vari_new_smth)
   deallocate(fld_sum)
   deallocate(wgt_sum)
end subroutine perturb_bdy_fields

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
   file='wrfinput_d01'
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

subroutine get_WRFINPUT_geo_ht(geo_ht,nx,ny,nz,nzp)
   implicit none
   include 'netcdf.inc'
   integer, parameter                    :: maxdim=6
   integer                               :: k,nx,ny,nz,nzp
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
!
! open netcdf file
   file='wrfinput_d01'
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
      geo_ht(:,:,k)=(ph(:,:,k)+phb(:,:,k) + ph(:,:,k+1)+ &
      phb(:,:,k+1))/2.
   enddo
   rc = nf_close(f_id)
end subroutine get_WRFINPUT_geo_ht

!-------------------------------------------------------------------------------

subroutine init_const_random_seed(rank,date)
   implicit none
   integer                          :: rank,date,primes_dim
   integer                          :: n,at,found,i,str
   integer,allocatable,dimension(:) :: primes,aseed
   logical                          :: is_prime
    
   call random_seed(size=n)
   primes_dim=rank*n
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
   str=(rank-1)*n+1
   do i=str,primes_dim
      aseed(i-str+1)=date*primes(i)
   enddo
   call random_seed(put=aseed)
   deallocate(aseed,primes)
end subroutine init_const_random_seed

!-------------------------------------------------------------------------------

subroutine apm_pack(A_pck,A_unpck,nx,ny,nz)
   implicit none
   integer                      :: nx,ny,nz
   integer                      :: i,j,k,l,idx
   real,dimension(nx,ny,nz)  :: A_unpck
   real,dimension(nx*ny*nz)  :: A_pck
   idx=0
   do k=1,nz
      do j=1,ny
         do i=1,nx
            idx=idx+1
            A_pck(idx)=A_unpck(i,j,k)
         enddo
      enddo
   enddo
end subroutine apm_pack

!-------------------------------------------------------------------------------

subroutine apm_unpack(A_pck,A_unpck,nx,ny,nz)
   implicit none
   integer                      :: nx,ny,nz
   integer                      :: i,j,k,l,idx
   real,dimension(nx,ny,nz)  :: A_unpck
   real,dimension(nx*ny*nz)  :: A_pck
   idx=0
   do k=1,nz
      do j=1,ny
         do i=1,nx
            idx=idx+1
            A_unpck(i,j,k)=A_pck(idx)
         enddo
      enddo
   enddo
end subroutine apm_unpack

!-------------------------------------------------------------------------------

subroutine apm_pack4d(A_pck,A_unpck,nx,ny,nz,nt)
   implicit none
   integer                      :: nx,ny,nz,nt
   integer                      :: i,j,k,l,idx
   real,dimension(nx,ny,nz,nt)  :: A_unpck
   real,dimension(nx*ny*nz*nt)  :: A_pck
   idx=0
   do l=1,nt
      do k=1,nz
         do j=1,ny
            do i=1,nx
               idx=idx+1
               A_pck(idx)=A_unpck(i,j,k,l)
            enddo
         enddo
      enddo
   enddo
end subroutine apm_pack4d

!-------------------------------------------------------------------------------

subroutine apm_unpack4d(A_pck,A_unpck,nx,ny,nz,nt)
   implicit none
   integer                      :: nx,ny,nz,nt
   integer                      :: i,j,k,l,idx
   real,dimension(nx,ny,nz,nt)  :: A_unpck
   real,dimension(nx*ny*nz*nt)  :: A_pck
   idx=0
   do l=1,nt
      do k=1,nz
         do j=1,ny
            do i=1,nx
               idx=idx+1
               A_unpck(i,j,k,l)=A_pck(idx)
            enddo
         enddo
      enddo
   enddo
end subroutine apm_unpack4d

!-------------------------------------------------------------------------------

subroutine get_WRFCHEM_icbc_data(file,name,data3d,nx,ny,nz)
   implicit none
   include 'netcdf.inc'
   integer, parameter                    :: maxdim=6
   integer                               :: nx,ny,nz
   integer                               :: i,rc
   integer                               :: f_id
   integer                               :: v_id,v_ndim,typ,natts
   integer,dimension(maxdim)             :: one
   integer,dimension(maxdim)             :: v_dimid
   integer,dimension(maxdim)             :: v_dim
   real,dimension(nx,ny,nz)              :: data3d
   real,dimension(nx,ny,nz,1)            :: data4d
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
   else if(1.ne.v_dim(4)) then             
      print *, 'ERROR: time dimension conflict ',1,v_dim(4)
      stop
   endif
!
! get data
   one(:)=1
   rc = nf_get_vara_real(f_id,v_id,one,v_dim,data4d)
   rc = nf_close(f_id)
   data3d(:,:,:)=data4d(:,:,:,1)
   return
end subroutine get_WRFCHEM_icbc_data

!-------------------------------------------------------------------------------

subroutine put_WRFCHEM_icbc_data(file,name,data3d,nx,ny,nz)
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
   real,dimension(nx,ny,nz)              :: data3d
   real,dimension(nx,ny,nz,1)            :: data4d
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
   else if(1.ne.v_dim(4)) then             
      print *, 'ERROR: time dimension conflict ',1,v_dim(4)
      stop
   endif
!
! put data
   data4d(:,:,:,1)=data3d(:,:,:)   
   one(:)=1
   rc = nf_put_vara_real(f_id,v_id,one(1:v_ndim),v_dim(1:v_ndim),data4d)
   rc = nf_close(f_id)
   return
end subroutine put_WRFCHEM_icbc_data

!-------------------------------------------------------------------------------

subroutine get_WRFCHEM_bdy_data(file,name,data4d,nx,ny,nz,nt)
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
   real,dimension(nx,ny,nz,nt)           :: data4d
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
   else if(2.ne.v_dim(4)) then             
      print *, 'ERROR: time dimension conflict ',1,v_dim(4)
      stop
   endif
!
! get data
   one(:)=1
   rc = nf_get_vara_real(f_id,v_id,one,v_dim,data4d)
   rc = nf_close(f_id)
   return
end subroutine get_WRFCHEM_bdy_data

!-------------------------------------------------------------------------------

subroutine put_WRFCHEM_bdy_data(file,name,data4d,nx,ny,nz,nt)
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
   real,dimension(nx,ny,nz,nt)           :: data4d
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
   else if(2.ne.v_dim(4)) then             
      print *, 'ERROR: time dimension conflict ',1,v_dim(4)
      stop
   endif
!
! put data
   one(:)=1
   rc = nf_put_vara_real(f_id,v_id,one(1:v_ndim),v_dim(1:v_ndim),data4d)
   rc = nf_close(f_id)
   return
end subroutine put_WRFCHEM_bdy_data

!-------------------------------------------------------------------------------
 
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

!-------------------------------------------------------------------------------
 
subroutine limit_fld_maxnmin(fld,nx,ny,nz,nt,zfac)
   implicit none
   integer,                          intent(in)      :: nx,ny,nz,nt
   integer                                           :: i,j,k,l
   real,                             intent(in)      :: zfac
   real, dimension(nx,ny,nz,nt),     intent(inout)   :: fld
   real, dimension(nz,nt)                            :: fld_mn,fld_std
   real, dimension(nx,ny,nz,nt)                      :: fld_tmp
!
! Calculate mean
   fld_mn(:,:)=0.
   do l=1,nt
      do k=1,nz
         do i=1,nx
            do j=1,ny
               fld_mn(k,l)=fld_mn(k,l)+fld(i,j,k,l)
            enddo
         enddo
         fld_mn(k,l)=fld_mn(k,l)/real(nx*ny)
      enddo
   enddo
!
! Calculate spatial standard deviation
   fld_std(:,:)=0.
   do l=1,nt
      do k=1,nz
         do i=1,nx
            do j=1,ny
               fld_std(k,l)=fld_std(k,l)+(fld(i,j,k,l)-fld_mn(k,l))*(fld(i,j,k,l)-fld_mn(k,l))
            enddo
         enddo
         fld_std(k,l)=sqrt(fld_std(k,l)/real(nx*ny-1))
      enddo
   enddo
!
!   Check and limit the distribution extreme values
   do l=1,nt
      do k=1,nz
         do i=1,nx
            do j=1,ny
               if(fld(i,j,k,l).gt.fld_mn(k,l)+zfac*fld_std(k,l)) fld(i,j,k,l)=fld_mn(k,l)+zfac*fld_std(k,l)
!               if(fld(i,j,k,l).lt.fld_mn(k,l)-zfac*fld_std(k,l)) fld(i,j,k,l)=fld_mn(k,l)-zfac*fld_std(k,l)
            enddo
         enddo
      enddo
   enddo
end subroutine limit_fld_maxnmin

!-------------------------------------------------------------------------------
 
subroutine limit_bdy_maxnmin(fld,nxy,nz,nhalo,nt,zfac)
   implicit none
   integer,                          intent(in)      :: nxy,nz,nhalo,nt
   integer                                           :: ij,k,h,l
   real,                             intent(in)      :: zfac
   real, dimension(nxy,nz,nhalo,nt), intent(inout)   :: fld
   real, dimension(nz,nt)                            :: fld_mn,fld_std
!
! Calculate mean
   fld_mn(:,:)=0.
   do l=1,nt
      do k=1,nz
         do ij=1,nxy
            do h=1,nhalo
               fld_mn(k,l)=fld_mn(k,l)+fld(ij,k,h,l)
            enddo
         enddo
         fld_mn(k,l)=fld_mn(k,l)/real(nxy*nhalo)
      enddo
   enddo
!
! Calculate spatial standard deviation
   fld_std(:,:)=0.
   do l=1,nt
      do k=1,nz
         do ij=1,nxy
            do h=1,nhalo
               fld_std(k,l)=fld_std(k,l)+(fld(ij,k,h,l)-fld_mn(k,l))*(fld(ij,k,h,l)-fld_mn(k,l))
            enddo
         enddo
         fld_std(k,l)=sqrt(fld_std(k,l)/real(nxy*nhalo-1))
      enddo
   enddo
!
!   Check and limit the distribution extreme values
   do l=1,nt
      do k=1,nz
         do ij=1,nxy
            do h=1,nhalo
               if(fld(ij,k,h,l).gt.fld_mn(k,l)+zfac*fld_std(k,l)) fld(ij,k,h,l)=fld_mn(k,l)+zfac*fld_std(k,l)
!               if(fld(ij,k,h,l).lt.fld_mn(k,l)-zfac*fld_std(k,l)) fld(ij,k,h,l)=fld_mn(k,l)-zfac*fld_std(k,l)
            enddo
         enddo
      enddo
   enddo
end subroutine limit_bdy_maxnmin
!
