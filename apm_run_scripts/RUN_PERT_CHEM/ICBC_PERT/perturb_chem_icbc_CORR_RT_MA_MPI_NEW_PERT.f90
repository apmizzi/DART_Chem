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
   integer,parameter                           :: nbdy_exts=8
   integer,parameter                           :: nhalo=5
   character(len=5),parameter,dimension(nbdy_exts) :: bdy_exts=(/'_BXS','_BXE','_BYS','_BYE','_BTXS', &
   '_BTXE','_BTYS','_BTYE'/)
!
   integer                                     :: ierr,rank,num_procs,num_procs_avail
   integer                                     :: nt,unit,unita,unitb,date,nx,ny,nz,nxy,nxyz,nzp,nchem_spcs
   integer                                     :: num_mems,status,ngrid_corr,zfac_fld,zfac_bdy
   integer                                     :: h,i,ii,j,ij,n,jj,k,kk,l,isp,imem,ibdy,bdy_idx
   integer                                     :: ifile,icnt,ncnt,ntasks,icnt_tsk,seed_trm
   integer,dimension(8)                        :: date_time_vals
   integer,dimension(MPI_STATUS_SIZE)          :: stat
   integer,dimension(nbdy_exts)                :: bdy_dims
   integer,allocatable,dimension(:,:)          :: itask
   integer,allocatable,dimension(:,:,:)        :: ilabel
   
!
   real                                        :: pi,grav,zfac,tfac
   real                                        :: nnum_mems,sprd_chem
   real                                        :: corr_lngth_hz,corr_lngth_vt,corr_lngth_tm
   real                                        :: corr_tm_delt,grid_length
   real                                        :: wgt_bc_str,wgt_bc_mid,wgt_bc_end
   real                                        :: get_dist,wgt_end,scl_fac_ics,scl_fac_bcs
   real,allocatable,dimension(:,:)             :: lat,lon
   real,allocatable,dimension(:,:,:)           :: geo_ht,chem_data_end
   real,allocatable,dimension(:,:,:)           :: chem_fac_old,chem_fac_new,chem_fac_end
   real,allocatable,dimension(:,:,:,:)         :: bdy_fac_old,bdy_fac_new,bdy_fac_end
   real,allocatable,dimension(:,:,:,:)         :: A_chem
   real,allocatable,dimension(:,:,:)           :: chem_data3d
   real,allocatable,dimension(:,:,:,:)         :: chem_data4d
   real,allocatable,dimension(:,:,:,:)         :: bdy_data4d
   real,allocatable,dimension(:)               :: tmp_arry
!
   character(len=20)                           :: cmem
   character(len=100)                          :: ch_date,ch_time,ch_zone
   character(len=300)                          :: ch_spcs,filenm
   character(len=300)                          :: pert_path_old,pert_path_new
   character(len=300)                          :: wrfinput_file_new
   character(len=300)                          :: wrfbdy_file_new
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
   zfac=1.
   zfac_fld=4.
   zfac_bdy=4.
   tfac=60.*60.
   icnt_tsk=1
   scl_fac_ics=16.
   scl_fac_bcs=4.5 
   sw_bdy_only=.true.
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
   nzp=nz+1
   num_mems=nint(nnum_mems)
   bdy_dims=(/ny,ny,nx,nx,ny,ny,nx,nx/)
!
! Allocate arrays
   allocate(ch_chem_spc(nchem_spcs))
   allocate(chem_data4d(nx,ny,nz,1))
   allocate(chem_fac_old(nx,ny,nz))
   allocate(chem_fac_new(nx,ny,nz))
   allocate(chem_fac_end(nx,ny,nz))
   chem_fac_old(:,:,:)=0.
   chem_fac_new(:,:,:)=0.
   chem_fac_end(:,:,:)=0.
!
! Read the species namelist
   unit=20
   open( unit=unit,file='perturb_chem_icbc_spcs_nml.nl',form='formatted', &
   status='old',action='read')
   rewind(unit)
   read(unit,perturb_chem_icbc_spcs_nml)
   close(unit)
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
   allocate(itask(num_mems,nchem_spcs))
   do imem=1,num_mems
      do isp=1,nchem_spcs
         itask(imem,isp)=mod(((imem-1)*nchem_spcs+isp-1),num_procs-icnt_tsk)+icnt_tsk
      enddo
   enddo
!
! Allocate labels
   allocate(ilabel(nbdy_exts,num_mems,nchem_spcs))
   ilabel(:,:,:)=10
   do ibdy=1,nbdy_exts
      do imem=1,num_mems
         do isp=1,nchem_spcs
            ilabel(ibdy,imem,isp)=ilabel(ibdy,imem,isp)+1
         enddo
      enddo
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
! READ OLD IC SCALING FACTORS AND SEND TO OTHER PROCESSORS
!      
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!
      if(.not.sw_bdy_only) then
         if(sw_corr_tm) then
            if(rank.eq.0) print *, 'APM: Before read and send old scaling factors '
            unit=30
            filenm=trim(pert_path_old)//'/pert_chem_ic'
            open(unit=unit,file=trim(filenm), &
            form='unformatted',status='unknown')
            rewind(unit)
!           
            allocate(tmp_arry(nx*ny*nz))
            do imem=1,num_mems
               do isp=1,nchem_spcs
                  read(unit) chem_fac_old
                  call apm_pack(tmp_arry,chem_fac_old,nx,ny,nz)
                  call mpi_send(tmp_arry,nx*ny*nz,MPI_FLOAT, &
                  itask(imem,isp),1,MPI_COMM_WORLD,ierr)
               enddo
            enddo
            close(unit)
            deallocate(tmp_arry)
            if(rank.eq.0) print *, 'APM: After read and send old scaling factors '
         endif
!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!
! RECEIVE NEW IC SCALING FACTORS FROM OTHER PROCESSORS AND WRITE TO ARCHIVE FILE
! READ EMISSIONS, APPLY SCALING, AND WRITE TO EMISSIONS FILE
!      
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!
! Receive new IC scaling factors, write to archive file, read emissions, scale emissions, and
! write emissions to archive file
!
         if(rank.eq.0) print *, 'APM: Before receive new IC scaling and write '   
         unit=30
         filenm=trim(pert_path_new)//'/pert_chem_ic'
         open(unit=unit,file=trim(filenm),form='unformatted',status='unknown')
         rewind(unit)
!        
         allocate(chem_data3d(nx,ny,nz))
         allocate(tmp_arry(nx*ny*nz))
         do imem=1,num_mems
            if(imem.ge.0.and.imem.lt.10) write(cmem,"('.e00',i1)"),imem
            if(imem.ge.10.and.imem.lt.100) write(cmem,"('.e0',i2)"),imem
            if(imem.ge.100.and.imem.lt.1000) write(cmem,"('.e',i3)"),imem
            do isp=1,nchem_spcs
               call mpi_recv(tmp_arry,nx*ny*nz,MPI_FLOAT, &
               itask(imem,isp),2,MPI_COMM_WORLD,stat,ierr)
               call apm_unpack(tmp_arry,chem_fac_end,nx,ny,nz)
               write(unit) chem_fac_end
               wrfchem_file=trim(pert_path_new)//'/'//trim(wrfinput_file_new)
               call get_WRFCHEM_icbc_data(wrfchem_file,ch_chem_spc(isp),chem_data3d, &
               chem_data4d,nx,ny,nz,1)
               do i=1,nx
                  do j=1,ny
                     do k=1,nz
!                        if(chem_data3d(i,j,k)*(1.+chem_fac_end(i,j,k)*scl_fac_ics) .gt. 0.) then
!                           chem_data3d(i,j,k)=chem_data3d(i,j,k)*(1.+chem_fac_end(i,j,k)*scl_fac_ics)
!                        elseif (chem_data3d(i,j,k)*(1.+chem_fac_end(i,j,k)) .gt. 0.) then
!                           chem_data3d(i,j,k)=chem_data3d(i,j,k)*(1.+chem_fac_end(i,j,k))
!                        endif
!
                        if(chem_data3d(i,j,k) .gt. 0.) then
                           chem_data3d(i,j,k)=exp(log(chem_data3d(i,j,k))+(1.+chem_fac_end(i,j,k)*scl_fac_ics))
                        endif
                     enddo
                  enddo
               enddo
!
! Check the distribution extrema
!               call limit_fld_maxnmin(chem_data3d,nx,ny,nz,zfac_fld)
!               
               wrfchem_file=trim(pert_path_new)//'/'//trim(wrfinput_file_new)//trim(cmem)
               call put_WRFCHEM_icbc_data(wrfchem_file,ch_chem_spc(isp),chem_data3d, &
               chem_data4d,nx,ny,nz,1)
            enddo
         enddo
         deallocate(tmp_arry)
         deallocate(chem_data3d)
         close(unit)
         if(rank.eq.0) print *, 'APM: After receive new IC scaling and write '
      endif
!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!
! OPEN BC FILES FOR READING OLD SCALING (unita) AND SAVING NEW SCLAING (unitb)
!      
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!
      if(sw_corr_tm) then
         unita=20
         filenm=trim(pert_path_old)//'/pert_chem_bc'
         open(unit=unita,file=trim(filenm), &
         form='unformatted',status='unknown')
         rewind(unita)
      endif
!      
      unitb=30
      filenm=trim(pert_path_new)//'/pert_chem_bc'
      open(unit=unitb,file=trim(filenm),form='unformatted',status='unknown')
      rewind(unitb)
!
      do ibdy=1,nbdy_exts
!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!
! READ OLD BC SCALING FACTORS AND SEND TO OTHER PROCESSORS
!      
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
         if(sw_corr_tm) then
            if(rank.eq.0) print *, 'APM: Before read and send old BC scaling factors ibdy ',ibdy
            allocate(bdy_fac_old(bdy_dims(ibdy),nz,nhalo,nt))
            allocate(tmp_arry(bdy_dims(ibdy)*nz*nhalo*nt))
            bdy_fac_old(:,:,:,:)=0.
            do imem=1,num_mems
               do isp=1,nchem_spcs
                  read(unita) bdy_fac_old
                  call apm_pack4d(tmp_arry,bdy_fac_old,bdy_dims(ibdy),nz,nhalo,nt)
                  call mpi_send(tmp_arry,bdy_dims(ibdy)*nz*nhalo*nt,MPI_FLOAT, &
                  itask(imem,isp),ilabel(ibdy,imem,isp),MPI_COMM_WORLD,ierr)
               enddo
            enddo
            deallocate(tmp_arry)
            deallocate(bdy_fac_old)
            if(rank.eq.0) print *, 'APM: After read and send old scaling factors ibdy ',ibdy
         endif
!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!
! RECEIVE NEW BC SCALING FACTORS FROM OTHER PROCESSORS AND WRITE TO ARCHIVE FILE
! READ EMISSIONS, APPLY SCALING, AND WRITE TO EMISSIONS FILE
!      
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!
! Receive new BC scaling factors, write to archive file, read emissions, scale emissions, and
! write emissions to archive file
!
         if(rank.eq.0) print *, 'APM: Before receive new BC scaling and write ibdy ',ibdy   
         allocate(bdy_fac_end(bdy_dims(ibdy),nz,nhalo,nt))
         allocate(bdy_data4d(bdy_dims(ibdy),nz,nhalo,nt))
         allocate(tmp_arry(bdy_dims(ibdy)*nz*nhalo*nt))
         do imem=1,num_mems
            if(imem.ge.0.and.imem.lt.10) write(cmem,"('.e00',i1)"),imem
            if(imem.ge.10.and.imem.lt.100) write(cmem,"('.e0',i2)"),imem
            if(imem.ge.100.and.imem.lt.1000) write(cmem,"('.e',i3)"),imem
            do isp=1,nchem_spcs
               bdy_fac_end(:,:,:,:)=0.
               bdy_data4d(:,:,:,:)=0.
               tmp_arry(:)=0.
               call mpi_recv(tmp_arry,bdy_dims(ibdy)*nz*nhalo*nt,MPI_FLOAT, &
               itask(imem,isp),ilabel(ibdy,imem,isp),MPI_COMM_WORLD,stat,ierr)
               call apm_unpack4d(tmp_arry,bdy_fac_end,bdy_dims(ibdy),nz,nhalo,nt)
               write(unitb) bdy_fac_end
               wrfchem_file=trim(pert_path_new)//'/'//trim(wrfbdy_file_new)
               ch_spcs=trim(ch_chem_spc(isp))//trim(bdy_exts(ibdy))
               call get_WRFCHEM_bdy_data(wrfchem_file,trim(ch_spcs),bdy_data4d, &
               bdy_dims(ibdy),nz,nhalo,nt)
               if(ibdy.le.4) then
! boundary non-tendencies may not be negative
                  do ij=1,bdy_dims(ibdy)
                     do k=1,nz
                        do l=1,nhalo
                           do n=1,nt
!                              if(bdy_data4d(ij,k,l,n)*(1.+bdy_fac_end(ij,k,l,n)*scl_fac_bcs) .gt. 0.) then
!                                 bdy_data4d(ij,k,l,n)=bdy_data4d(ij,k,l,n)*(1.+bdy_fac_end(ij,k,l,n)*scl_fac_bcs)
!                              elseif(bdy_data4d(ij,k,l,n)*(1.+bdy_fac_end(ij,k,l,n)) .gt. 0.) then
!                                 bdy_data4d(ij,k,l,n)=bdy_data4d(ij,k,l,n)*(1.+bdy_fac_end(ij,k,l,n))
!                              endif
!
                              if(bdy_data4d(ij,k,l,n) .gt. 0.) then
                                 bdy_data4d(ij,k,l,n)=exp(log(bdy_data4d(ij,k,l,n))+(1.+bdy_fac_end(ij,k,l,n)*scl_fac_bcs))
                              endif
                           enddo
                        enddo
                     enddo
                  enddo
!
! Check the distribution extrema
!               call limit_bdy_maxnmin(bdy_data4d,bdy_dims(ibdy),nhalo,nt,zfac_bdy)
!               
               else
! boundary tendencies may be negative
                  do ij=1,bdy_dims(ibdy)
                     do k=1,nz
                        do l=1,nhalo
                           do n=1,nt
!                              bdy_data4d(ij,k,l,n)=bdy_data4d(ij,k,l,n)*(1.+bdy_fac_end(ij,k,l,n)*scl_fac_bcs)
                              bdy_data4d(ij,k,l,n)=bdy_data4d(ij,k,l,n)*(1.+bdy_fac_end(ij,k,l,n))
                           enddo
                        enddo
                     enddo
                  enddo
               endif
               wrfchem_file=trim(pert_path_new)//'/'//trim(wrfbdy_file_new)//trim(cmem)
               call put_WRFCHEM_bdy_data(wrfchem_file,ch_spcs,bdy_data4d, &
               bdy_dims(ibdy),nz,nhalo,nt)
            enddo
         enddo
         deallocate(tmp_arry)
         deallocate(bdy_data4d)
         deallocate(bdy_fac_end)
         if(rank.eq.0) print *, 'APM: After receive new BC scaling and write ibdy ',ibdy   
      enddo
      if(sw_corr_tm) close(unita)
      close(unitb)
   endif
!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!
! RANK itask(imem,isp)   RANK itask(imem,isp)   RANK itask(imem,isp)
!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!
! RECEIVE OLD IC SCALING FACTORS (OR CALCULATE OLD SCALING FACTORS) AND SEND TO
! RANK 0 FOR WRITING TO ARCHIVE FILE   
!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!
   if(rank.ne.0) then
      wgt_end=exp(-1.0*corr_tm_delt/corr_lngth_tm)
!
! ICs
      if(.not.sw_bdy_only) then
         do imem=1,num_mems
            if(imem.ge.0.and.imem.lt.10) write(cmem,"('.e00',i1)"),imem
            if(imem.ge.10.and.imem.lt.100) write(cmem,"('.e0',i2)"),imem
            if(imem.ge.100.and.imem.lt.1000) write(cmem,"('.e',i3)"),imem
            do isp=1,nchem_spcs
               if(rank.eq.itask(imem,isp)) then
                  chem_fac_old(:,:,:)=0.
                  chem_fac_new(:,:,:)=0.
                  chem_fac_end(:,:,:)=0.
!
! Receive old scaling factors
                  if(sw_corr_tm) then
                     if(rank.eq.itask(1,1)) print *,'APM: Before receive old scaling factors IC RANK ',rank
                     allocate(tmp_arry(nx*ny*nz))
                     call mpi_recv(tmp_arry,nx*ny*nz, &
                     MPI_FLOAT,0,1,MPI_COMM_WORLD,stat,ierr)
                     call apm_unpack(tmp_arry,chem_fac_old,nx,ny,nz)
                     deallocate(tmp_arry)
                     if(rank.eq.itask(1,1)) print *,'APM: After receive old scaling factors IC RANK ',rank
                  endif
!
! Calculate new scaling factors
                  if(rank.eq.itask(1,1)) print *,'APM: Before calc and send new scaling IC RANK ',rank
                  call date_and_time(ch_date,ch_time,ch_zone,date_time_vals)
                  seed_trm=date_time_vals(5)*date_time_vals(6)*date_time_vals(7)
                  if(sw_seed) call init_const_random_seed(rank,seed_trm)
                  call perturb_icbc_fields(chem_fac_old,chem_fac_new, &
                  lat,lon,A_chem,nx,ny,nz,ngrid_corr,sw_corr_tm, &
                  corr_lngth_hz,rank,sprd_chem,itask,num_mems,nchem_spcs)
!         
! Impose temporal correlations
                  chem_fac_end(:,:,:)=(1.-wgt_end)*chem_fac_old(:,:,:)+wgt_end* &
                  chem_fac_new(:,:,:)
! 
! Send new scaling factors to rank 0 for writing to archive file            
                  allocate(tmp_arry(nx*ny*nz))
                  call apm_pack(tmp_arry,chem_fac_end,nx,ny,nz)
                  call mpi_send(tmp_arry,nx*ny*nz,MPI_FLOAT, &
                  0,2,MPI_COMM_WORLD,ierr)
                  deallocate(tmp_arry)
                  if(rank.eq.itask(1,1)) print *,'APM: After calc and send new scaling IC RANK ',rank
               endif
            enddo
         enddo
         deallocate(chem_fac_old)
         deallocate(chem_fac_new)
         deallocate(chem_fac_end)
      endif
!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!
! RECEIVE OLD BC SCALING FACTORS (OR CALCULATE OLD SCALING FACTORS) AND SEND TO
! RANK 0 FOR WRITING TO ARCHIVE FILE   
!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!
! BCs
      do ibdy=1,nbdy_exts
         allocate(bdy_fac_old(bdy_dims(ibdy),nz,nhalo,nt))
         allocate(bdy_fac_new(bdy_dims(ibdy),nz,nhalo,nt))
         allocate(bdy_fac_end(bdy_dims(ibdy),nz,nhalo,nt))
         do imem=1,num_mems
            if(imem.ge.0.and.imem.lt.10) write(cmem,"('.e00',i1)"),imem
            if(imem.ge.10.and.imem.lt.100) write(cmem,"('.e0',i2)"),imem
            if(imem.ge.100.and.imem.lt.1000) write(cmem,"('.e',i3)"),imem
            do isp=1,nchem_spcs
               if(rank.eq.itask(imem,isp)) then
                  bdy_fac_old(:,:,:,:)=0.
                  bdy_fac_new(:,:,:,:)=0.
                  bdy_fac_end(:,:,:,:)=0.
!
! Receive old scaling factors
                  if(sw_corr_tm) then
                     if(rank.eq.itask(1,1)) print *,'APM: Before receive old scaling factors BC ibdy ',ibdy
                     allocate(tmp_arry(bdy_dims(ibdy)*nz*nhalo*nt))
                     call mpi_recv(tmp_arry,bdy_dims(ibdy)*nz*nhalo*nt, &
                     MPI_FLOAT,0,ilabel(ibdy,imem,isp),MPI_COMM_WORLD,stat,ierr)
                     call apm_unpack4d(tmp_arry,bdy_fac_old,bdy_dims(ibdy),nz,nhalo,nt)
                     deallocate(tmp_arry)
                     if(rank.eq.itask(1,1)) print *,'APM: After receive old scaling factors BC ibdy ',ibdy
                  endif
!
! Calculate new scaling factors
                  if(rank.eq.itask(1,1)) print *,'APM: Before pert_bdy_fields for new scaling BC ibdy ',ibdy
                  call date_and_time(ch_date,ch_time,ch_zone,date_time_vals)
                  seed_trm=date_time_vals(5)*date_time_vals(6)*date_time_vals(7)
                  if(sw_seed) call init_const_random_seed(rank,seed_trm)
                  call perturb_bdy_fields(bdy_fac_old,bdy_fac_new,lat,lon,A_chem, &
                  ngrid_corr,corr_lngth_hz,sw_corr_tm,sprd_chem,ibdy,bdy_dims(ibdy),nz,nhalo,nt,nx,ny,rank,itask(1,1))
                  if(rank.eq.itask(1,1)) print *,'APM: After pert_bdy_fields for new scaling BC ibdy ',ibdy
               endif
            enddo   
         enddo
!
         do imem=1,num_mems
            if(imem.ge.0.and.imem.lt.10) write(cmem,"('.e00',i1)"),imem
            if(imem.ge.10.and.imem.lt.100) write(cmem,"('.e0',i2)"),imem
            if(imem.ge.100.and.imem.lt.1000) write(cmem,"('.e',i3)"),imem
            do isp=1,nchem_spcs
               if(rank.eq.itask(imem,isp)) then
!
! Impose temporal correlations
                  bdy_fac_end(:,:,:,:)=(1.-wgt_end)*bdy_fac_old(:,:,:,:)+wgt_end* &
                  bdy_fac_new(:,:,:,:)
! 
! Send new scaling factors to rank 0 for writing to archive file            
                  if(rank.eq.itask(1,1)) print *,'APM: Before send new scaling BC ibdy ',ibdy
                  allocate(tmp_arry(bdy_dims(ibdy)*nz*nhalo*nt))
                  call apm_pack4d(tmp_arry,bdy_fac_end,bdy_dims(ibdy),nz,nhalo,nt)
                  call mpi_send(tmp_arry,bdy_dims(ibdy)*nz*nhalo*nt,MPI_FLOAT, &
                  0,ilabel(ibdy,imem,isp),MPI_COMM_WORLD,ierr)
                  deallocate(tmp_arry)
                  if(rank.eq.itask(1,1)) print *,'APM: After send new scaling BC ibdy ',ibdy
               endif
            enddo
         enddo
         deallocate(bdy_fac_old)
         deallocate(bdy_fac_new)
         deallocate(bdy_fac_end)
      enddo
   endif   
   deallocate(ch_chem_spc)
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

subroutine perturb_icbc_fields(chem_fac_old,chem_fac_new,lat,lon,A_chem,nx,ny,nz, &
ngrid_corr,sw_corr_tm,corr_lngth_hz,rank,sprd_chem,itask,nmem,nspc)

!   use apm_utilities_mod,  only :get_dist
  
   implicit none
   integer,                               intent(in)     :: nx,ny,nz,rank,nmem,nspc
   integer,                               intent(in)     :: ngrid_corr
   integer,dimension(nmem,nspc),          intent(in)     :: itask
   real,                                  intent(in)     :: corr_lngth_hz,sprd_chem
   real,dimension(nx,ny),                 intent(in)     :: lat,lon
   real,dimension(nx,ny,nz,nz),           intent(in)     :: A_chem
   real,dimension(nx,ny,nz),              intent(inout)  :: chem_fac_old
   real,dimension(nx,ny,nz),              intent(inout)  :: chem_fac_new
   logical,                               intent(in)     :: sw_corr_tm
!
   integer                             :: i,j,k,ii,jj,kk
   integer                             :: ii_str,ii_end,jj_str,jj_end,icnt,ncnt
   real                                :: pi,get_dist,wgt
   real                                :: u_ran_1,u_ran_2,zdist
   real,allocatable,dimension(:)       :: fld_sum,wgt_sum
   real,allocatable,dimension(:,:,:)   :: pert_chem_old,pert_chem_new
   real,allocatable,dimension(:,:,:)   :: chem_fac_old_smth,chem_fac_new_smth
!
! Constants
   pi=4.*atan(1.)
!
! Define perturbations (Box-Muller transform N(0,1)
   if(.not.sw_corr_tm) then
      allocate(pert_chem_old(nx,ny,nz))
      pert_chem_old(:,:,:)=0.
      do i=1,nx
         do j=1,ny
            do k=1,nz
               call random_number(u_ran_1)
               if(u_ran_1.eq.0.) call random_number(u_ran_1)
               call random_number(u_ran_2)
               if(u_ran_2.eq.0.) call random_number(u_ran_2)
               pert_chem_old(i,j,k)=sprd_chem*sqrt(-2.*log(u_ran_1))*cos(2.*pi*u_ran_2)
            enddo
         enddo
      enddo
   endif
!   
   allocate(pert_chem_new(nx,ny,nz))
   pert_chem_new(:,:,:)=0.
   do i=1,nx
      do j=1,ny
         do k=1,nz
            call random_number(u_ran_1)
            if(u_ran_1.eq.0.) call random_number(u_ran_1)
            call random_number(u_ran_2)
            if(u_ran_2.eq.0.) call random_number(u_ran_2)
            pert_chem_new(i,j,k)=sprd_chem*sqrt(-2.*log(u_ran_1))*cos(2.*pi*u_ran_2)
         enddo
      enddo
   enddo
!
! Apply horizontal correlations
   allocate(fld_sum(nz))   
   allocate(wgt_sum(nz))
!
   if(.not.sw_corr_tm) then
      chem_fac_old(:,:,:)=0.
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
                        fld_sum(k)=fld_sum(k)+wgt*pert_chem_old(ii,jj,k)
                        wgt_sum(k)=wgt_sum(k)+wgt
                     enddo
                  endif
               enddo
            enddo
            do k=1,nz
               if(wgt_sum(k).ne.0.) then
                  chem_fac_old(i,j,k)=fld_sum(k)/wgt_sum(k)
               else
                  chem_fac_old(i,j,k)=pert_chem_old(i,j,k)
               endif
            enddo
         enddo
      enddo
      deallocate(pert_chem_old)
   endif
!
   chem_fac_new(:,:,:)=0.
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
                     fld_sum(k)=fld_sum(k)+wgt*pert_chem_new(ii,jj,k)
                     wgt_sum(k)=wgt_sum(k)+wgt
                  enddo
               endif
            enddo
         enddo
         do k=1,nz
            if(wgt_sum(k).ne.0.) then
               chem_fac_new(i,j,k)=fld_sum(k)/wgt_sum(k)
            else
               chem_fac_new(i,j,k)=pert_chem_new(i,j,k)
            endif
         enddo
      enddo
   enddo
   deallocate(pert_chem_new)
!
!
! Apply vertical correlations
   if(.not.sw_corr_tm) then
      allocate(chem_fac_old_smth(nx,ny,nz))
      chem_fac_old_smth(:,:,:)=0.
      do i=1,nx
         do j=1,ny
            fld_sum(:)=0.
            wgt_sum(:)=0.
            do k=1,nz
               do kk=1,nz
                  fld_sum(k)=fld_sum(k)+A_chem(i,j,k,kk)*chem_fac_old(i,j,kk)
                  wgt_sum(k)=wgt_sum(k)+A_chem(i,j,k,kk)
               enddo
            enddo
            do k=1,nz
               if(wgt_sum(k).ne.0) then
                  chem_fac_old_smth(i,j,k)=fld_sum(k)/wgt_sum(k)
               else
                  chem_fac_old_smth(i,j,k)=chem_fac_old(i,j,k)
               endif
            enddo
         enddo
      enddo
      chem_fac_old(:,:,:)=chem_fac_old_smth(:,:,:)
      deallocate(chem_fac_old_smth)
   endif
!
   allocate(chem_fac_new_smth(nx,ny,nz))
   chem_fac_new_smth(:,:,:)=0.
   do i=1,nx
      do j=1,ny
         fld_sum(:)=0.
         wgt_sum(:)=0.
         do k=1,nz
            do kk=1,nz
               fld_sum(k)=fld_sum(k)+A_chem(i,j,k,kk)*chem_fac_new(i,j,kk)
               wgt_sum(k)=wgt_sum(k)+A_chem(i,j,k,kk)
            enddo
         enddo
         do k=1,nz
            if(wgt_sum(k).ne.0.) then
               chem_fac_new_smth(i,j,k)=fld_sum(k)/wgt_sum(k)
            else              
               chem_fac_new_smth(i,j,k)=chem_fac_new(i,j,k)
            endif
         enddo
      enddo
   enddo
   chem_fac_new(:,:,:)=chem_fac_new_smth(:,:,:)
   deallocate(chem_fac_new_smth)
   deallocate(fld_sum)
   deallocate(wgt_sum)
end subroutine perturb_icbc_fields

!-------------------------------------------------------------------------------

subroutine perturb_bdy_fields(bdy_fac_old,bdy_fac_new,lat,lon,A_chem,ngrid_corr, &
corr_lngth_hz,sw_corr_tm,sprd_chem,ibdy,bdy_dim,nz,nhalo,nt,nx,ny,rank,itask)
   implicit none
   integer,                               intent(in)     :: nx,ny,nz,ibdy
   integer,                               intent(in)     :: ngrid_corr,rank,itask
   integer,                               intent(in)     :: nhalo,nt,bdy_dim
   real,                                  intent(in)     :: corr_lngth_hz,sprd_chem
   real,dimension(nx,ny),                 intent(in)     :: lat,lon
   real,dimension(bdy_dim,nz,nhalo,nt),   intent(inout)  :: bdy_fac_old
   real,dimension(bdy_dim,nz,nhalo,nt),   intent(inout)  :: bdy_fac_new
   real,dimension(nx,ny,nz,nz),           intent(in)     :: A_chem
   logical,                               intent(in)     :: sw_corr_tm
!
   integer                             :: i,j,k,l,h,ii,jj,kk,hh,ij,ijp
   integer                             :: ij_str,ij_end
   real                                :: pi,u_ran_1,u_ran_2
   real                                :: wgt,zdist,get_dist
   real                                :: zlat1,zlat2,zlon1,zlon2
   real,allocatable,dimension(:,:)     :: fld_sum,wgt_sum
   real,allocatable,dimension(:,:,:,:) :: pert_chem_old,pert_chem_new
   real,allocatable,dimension(:,:,:,:) :: bdy_fac_old_smth,bdy_fac_new_smth
!
! Constants
   pi=4.*atan(1.)
!
! Define perturbations (Box-Muller transform N(0,1)
   if(.not.sw_corr_tm) then
      allocate(pert_chem_old(bdy_dim,nz,nhalo,nt))
      pert_chem_old(:,:,:,:)=0.
      do ij=1,bdy_dim
         do k=1,nz
            do h=1,nhalo
               do l=1,nt
                  call random_number(u_ran_1)
                  if(u_ran_1.eq.0.) call random_number(u_ran_1)
                  call random_number(u_ran_2)
                  if(u_ran_2.eq.0.) call random_number(u_ran_2)
                  pert_chem_old(ij,k,h,l)=sprd_chem*sqrt(-2.*log(u_ran_1))*cos(2.*pi*u_ran_2)
               enddo
            enddo
         enddo
      enddo
   endif
!   
   allocate(pert_chem_new(bdy_dim,nz,nhalo,nt))
   pert_chem_new(:,:,:,:)=0.
   do ij=1,bdy_dim
      do k=1,nz
         do h=1,nhalo
            do l=1,nt
               call random_number(u_ran_1)
               if(u_ran_1.eq.0.) call random_number(u_ran_1)
               call random_number(u_ran_2)
               if(u_ran_2.eq.0.) call random_number(u_ran_2)
               pert_chem_new(ij,k,h,l)=sprd_chem*sqrt(-2.*log(u_ran_1))*cos(2.*pi*u_ran_2)
            enddo
         enddo
      enddo
   enddo
!
! Apply horizontal correlations to old scaling fators
   allocate(fld_sum(nz,nt))   
   allocate(wgt_sum(nz,nt))
!
   if(.not.sw_corr_tm) then
      bdy_fac_old(:,:,:,:)=0.
      do ij=1,bdy_dim
         ij_str=max(1,ij-ngrid_corr)
!
! ibdy=1 BXS
! ibdy=2 BXE
! ibdy=5 BTXS
! ibdy=6 BTXE
!
         i=-999
         j=-999
         if(ibdy.eq.1.or.ibdy.eq.2.or.ibdy.eq.5.or.ibdy.eq.6) then 
            i=1
            if(ibdy/2*2.eq.ibdy) i=nx 
            ij_end=min(ny,ij+ngrid_corr)
!
! ibdy=3 BYS
! ibdy=4 BYE
! ibdy=7 BTYS
! ibdy=8 BTYE
!      
         elseif(ibdy.eq.3.or.ibdy.eq.4.or.ibdy.eq.7.or.ibdy.eq.8) then 
            j=1
            if(ibdy/2*2.eq.ibdy) j=ny
            ij_end=min(nx,ij+ngrid_corr)
         endif
         do h=1,nhalo
            fld_sum(:,:)=0.
            wgt_sum(:,:)=0.
            do ijp=ij_str,ij_end
               do hh=1,nhalo
                  if (i.eq.1) then
                     zdist=get_dist(lat(i+hh-1,ijp),lat(i+h-1,ij),lon(i+hh-1,ijp),lon(i+h-1,ij))
                  elseif(i.eq.nx) then
                     zdist=get_dist(lat(i-hh+1,ijp),lat(i-h+1,ij),lon(i-hh+1,ijp),lon(i-h+1,ij))
                  elseif (j.eq.1) then
                     zdist=get_dist(lat(ijp,j+hh-1),lat(ij,j+h-1),lon(ijp,j+hh-1),lon(ij,j+h-1))
                  elseif(j.eq.ny) then
                     zdist=get_dist(lat(ijp,j-hh+1),lat(ij,j-h+1),lon(ijp,j-hh+1),lon(ij,j-h+1))
                  endif
                  if(zdist.le.corr_lngth_hz) then
                     wgt=1./exp(zdist*zdist/corr_lngth_hz/corr_lngth_hz)
                     do l=1,nt
                        do k=1,nz
                           fld_sum(k,l)=fld_sum(k,l)+wgt*pert_chem_old(ijp,k,hh,l)
                           wgt_sum(k,l)=wgt_sum(k,l)+wgt
                        enddo
                     enddo
                  endif
               enddo
            enddo
            do l=1,nt
               do k=1,nz
                  if(wgt_sum(k,l).ne.0.) then
                     bdy_fac_old(ij,k,h,l)=fld_sum(k,l)/wgt_sum(k,l)
                  else
                     bdy_fac_old(ij,k,h,l)=pert_chem_old(ij,k,h,l)
                  endif
               enddo
            enddo
         enddo
      enddo
      deallocate(pert_chem_old)
   endif
!
! Apply horizontal correlations to new scaling fators
   bdy_fac_new(:,:,:,:)=0.
    do ij=1,bdy_dim
      ij_str=max(1,ij-ngrid_corr)
!
! ibdy=1 BXS
! ibdy=2 BXE
! ibdy=5 BTXS
! ibdy=6 BTXE
!
      i=-999
      j=-999
      if(ibdy.eq.1.or.ibdy.eq.2.or.ibdy.eq.5.or.ibdy.eq.6) then 
         i=1
         if(ibdy/2*2.eq.ibdy) i=nx 
         ij_end=min(ny,ij+ngrid_corr)
!
! ibdy=3 BYS
! ibdy=4 BYE
! ibdy=7 BTYS
! ibdy=8 BTYE
!      
      elseif(ibdy.eq.3.or.ibdy.eq.4.or.ibdy.eq.7.or.ibdy.eq.8) then 
         j=1
         if(ibdy/2*2.eq.ibdy) j=ny
         ij_end=min(nx,ij+ngrid_corr)
      endif
      do h=1,nhalo
         fld_sum(:,:)=0.
         wgt_sum(:,:)=0.
         do ijp=ij_str,ij_end
            do hh=1,nhalo
               if (i.eq.1) then
                  zdist=get_dist(lat(i+hh-1,ijp),lat(i+h-1,ij),lon(i+hh-1,ijp),lon(i+h-1,ij))
               elseif(i.eq.nx) then
                  zdist=get_dist(lat(i-hh+1,ijp),lat(i-h+1,ij),lon(i-hh+1,ijp),lon(i-h+1,ij))
               elseif (j.eq.1) then
                  zdist=get_dist(lat(ijp,j+hh-1),lat(ij,j+h-1),lon(ijp,j+hh-1),lon(ij,j+h-1))
               elseif(j.eq.ny) then
                  zdist=get_dist(lat(ijp,j-hh+1),lat(ij,j-h+1),lon(ijp,j-hh+1),lon(ij,j-h+1))
               endif
               if(zdist.le.corr_lngth_hz) then
                  wgt=1./exp(zdist*zdist/corr_lngth_hz/corr_lngth_hz)
                  do l=1,nt
                     do k=1,nz
                        fld_sum(k,l)=fld_sum(k,l)+wgt*pert_chem_new(ijp,k,hh,l)
                        wgt_sum(k,l)=wgt_sum(k,l)+wgt
                     enddo
                  enddo
               endif
            enddo
         enddo
         do l=1,nt
            do k=1,nz
               if(wgt_sum(k,l).ne.0.) then
                  bdy_fac_new(ij,k,h,l)=fld_sum(k,l)/wgt_sum(k,l)
               else
                  bdy_fac_new(ij,k,h,l)=pert_chem_new(ij,k,h,l)
               endif
            enddo
         enddo
      enddo
   enddo
   deallocate(pert_chem_new)
!
! Apply vertical correlations to old scaling factors
   if(.not.sw_corr_tm) then
      allocate(bdy_fac_old_smth(bdy_dim,nz,nhalo,nt))
      bdy_fac_old_smth(:,:,:,:)=0.
      i=-999
      j=-999
      if(ibdy.eq.1.or.ibdy.eq.2.or.ibdy.eq.5.or.ibdy.eq.6) then 
         i=1
         if(ibdy/2*2.eq.ibdy) i=nx 
      elseif(ibdy.eq.3.or.ibdy.eq.4.or.ibdy.eq.7.or.ibdy.eq.8) then 
         j=1
         if(ibdy/2*2.eq.ibdy) j=ny
      endif
      do ij=1,bdy_dim
         do h=1,nhalo
            fld_sum(:,:)=0.
            wgt_sum(:,:)=0.
            do kk=1,nz
               do k=1,nz
                  do l=1,nt
                     if(i.eq.1) then
                        fld_sum(k,l)=fld_sum(k,l)+A_chem(i+h-1,ij,k,kk)*bdy_fac_old(ij,kk,h,l)
                        wgt_sum(k,l)=wgt_sum(k,l)+A_chem(i+h-1,ij,k,kk)
                     elseif(i.eq.nx) then
                        fld_sum(k,l)=fld_sum(k,l)+A_chem(i-h+1,ij,k,kk)*bdy_fac_old(ij,kk,h,l)
                        wgt_sum(k,l)=wgt_sum(k,l)+A_chem(i-h+1,ij,k,kk)
                     elseif(j.eq.1) then
                        fld_sum(k,l)=fld_sum(k,l)+A_chem(ij,j+h-1,k,kk)*bdy_fac_old(ij,kk,h,l)
                        wgt_sum(k,l)=wgt_sum(k,l)+A_chem(ij,j+h-1,k,kk)
                     elseif(j.eq.ny) then
                        fld_sum(k,l)=fld_sum(k,l)+A_chem(ij,j-h+1,k,kk)*bdy_fac_old(ij,kk,h,l)
                        wgt_sum(k,l)=wgt_sum(k,l)+A_chem(ij,j-h+1,k,kk)
                     endif
                  enddo
               enddo
            enddo
            do l=1,nt
               do k=1,nz
                  if(wgt_sum(k,l).ne.0.) then
                     bdy_fac_old_smth(ij,k,h,l)=fld_sum(k,l)/wgt_sum(k,l)
                  else
                     bdy_fac_old_smth(ij,k,h,l)=bdy_fac_old(ij,k,h,l)
                  endif
               enddo
            enddo
         enddo
      enddo
      bdy_fac_old(:,:,:,:)=bdy_fac_old_smth(:,:,:,:)
      deallocate(bdy_fac_old_smth)
   endif
!
! Apply vertical correlations to new scaling factors
   allocate(bdy_fac_new_smth(bdy_dim,nz,nhalo,nt))
   bdy_fac_new_smth(:,:,:,:)=0.
   i=-999
   j=-999
   if(ibdy.eq.1.or.ibdy.eq.2.or.ibdy.eq.5.or.ibdy.eq.6) then 
      i=1
      if(ibdy/2*2.eq.ibdy) i=nx 
   elseif(ibdy.eq.3.or.ibdy.eq.4.or.ibdy.eq.7.or.ibdy.eq.8) then 
      j=1
      if(ibdy/2*2.eq.ibdy) j=ny
   endif
   do ij=1,bdy_dim
      do h=1,nhalo
         fld_sum(:,:)=0.
         wgt_sum(:,:)=0.
         do kk=1,nz
            do k=1,nz
               do l=1,nt
                  if(i.eq.1) then
                     fld_sum(k,l)=fld_sum(k,l)+A_chem(i+h-1,ij,k,kk)*bdy_fac_new(ij,kk,h,l)
                     wgt_sum(k,l)=wgt_sum(k,l)+A_chem(i+h-1,ij,k,kk)
                  elseif(i.eq.nx) then
                     fld_sum(k,l)=fld_sum(k,l)+A_chem(i-h+1,ij,k,kk)*bdy_fac_new(ij,kk,h,l)
                     wgt_sum(k,l)=wgt_sum(k,l)+A_chem(i-h+1,ij,k,kk)
                  elseif(j.eq.1) then
                     fld_sum(k,l)=fld_sum(k,l)+A_chem(ij,j+h-1,k,kk)*bdy_fac_new(ij,kk,h,l)
                     wgt_sum(k,l)=wgt_sum(k,l)+A_chem(ij,j+h-1,k,kk)
                  elseif(j.eq.ny) then
                     fld_sum(k,l)=fld_sum(k,l)+A_chem(ij,j-h+1,k,kk)*bdy_fac_new(ij,kk,h,l)
                     wgt_sum(k,l)=wgt_sum(k,l)+A_chem(ij,j-h+1,k,kk)
                  endif
               enddo
            enddo
         enddo
         do l=1,nt
            do k=1,nz
               if(wgt_sum(k,l).ne.0.) then
                  bdy_fac_new_smth(ij,k,h,l)=fld_sum(k,l)/wgt_sum(k,l)
               else
                  bdy_fac_new_smth(ij,k,h,l)=bdy_fac_new(ij,k,h,l)
               endif
            enddo
         enddo
      enddo
   enddo
   bdy_fac_new(:,:,:,:)=bdy_fac_new_smth(:,:,:,:)
   deallocate(bdy_fac_new_smth)
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

subroutine get_WRFCHEM_icbc_data(file,name,data3d,data4d,nx,ny,nz,nt)
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
   else if(nt.ne.v_dim(4)) then             
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

subroutine put_WRFCHEM_icbc_data(file,name,data3d,data4d,nx,ny,nz,nt)
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
   else if(nt.ne.v_dim(4)) then             
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
   else if(nt.ne.v_dim(4)) then             
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
   else if(nt.ne.v_dim(4)) then             
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
