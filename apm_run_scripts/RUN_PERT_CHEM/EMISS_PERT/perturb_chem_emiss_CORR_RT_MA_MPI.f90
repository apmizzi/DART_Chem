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
! DART $Id: perturb_chem_emiss_CORR_RT_MA_MPI.f90 13171 2019-05-09 16:42:36Z thoar@ucar.edu $

! code to perturb the wrfchem emission files

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
!                               apm_pack, &
!                               apm_unpack, &
!                               apm_pack_2d, &
!                               apm_unpack_2d, &
!                               recenter_factors
!
!   use apm_utilities_mod, only : get_dist
!
   implicit none
!
! version controlled file description for error handling, do not edit
   character(len=*), parameter :: source   = 'perturb_chem_emiss_CORR_RT_MA_MPI.f90'
   character(len=*), parameter :: revision = ''
   character(len=*), parameter :: revdate  = ''
   include 'mpif.h'
   integer                                  :: ierr,rank,num_procs
   integer                                  :: unit,unita,unitb,unitc
   integer                                  :: date,ngrid_corr,icnt,icnt_tsk
   integer                                  :: nx,ny,nxy,nz,nzp,nz_chem,nz_fire,nz_biog
   integer                                  :: nchem_spcs,nfire_spcs,nbiog_spcs,num_mems
   integer                                  :: i,j,k,isp,imem,ntotal_spcs
   integer,dimension(MPI_STATUS_SIZE)       :: stat
   integer,allocatable,dimension(:,:)       :: itask
   real                                     :: pi,grav,zfac,zmin,fac_min,nnum_mem
   real                                     :: sprd_chem,sprd_fire,sprd_biog
   real                                     :: corr_lngth_hz,corr_lngth_vt
   real                                     :: corr_lngth_tm,corr_tm_delt
   real                                     :: grid_length,get_dist
   real                                     :: mean,std,wgt_end
   real                                     :: cpu_str,cpu_end,cpu_dif,flg
   real,allocatable,dimension(:)            :: tmp_arry
   real,allocatable,dimension(:,:)          :: lat,lon
   real,allocatable,dimension(:,:,:)        :: geo_ht
   real,allocatable,dimension(:,:,:,:)      :: A_chem,A_fire,A_biog
   real,allocatable,dimension(:,:,:)        :: chem_data3d
   real,allocatable,dimension(:,:,:)        :: chem_fac_old,chem_fac_new,chem_fac_end
   real,allocatable,dimension(:,:,:)        :: fire_fac_old,fire_fac_new,fire_fac_end
   real,allocatable,dimension(:,:,:)        :: biog_fac_old,biog_fac_new,biog_fac_end
   character(len=20)                        :: cmem
   character(len=150)                       :: pert_path_pr,pert_path_po,filenm
   character(len=150)                       :: wrfchemi,wrffirechemi,wrfbiogchemi
   character(len=150)                       :: wrfchem_file,wrffire_file,wrfbiog_file
   character(len=150),allocatable,dimension(:) :: ch_chem_spc,ch_fire_spc,ch_biog_spc 
   logical                                  :: sw_corr_tm,sw_seed,sw_chem,sw_fire,sw_biog
!
   namelist /perturb_chem_emiss_corr_nml/date,nx,ny,nz,nz_chem,nchem_spcs,nfire_spcs,nbiog_spcs, &
   pert_path_pr,pert_path_po,nnum_mem,wrfchemi,wrffirechemi,wrfbiogchemi,sprd_chem,sprd_fire,sprd_biog, &
   sw_corr_tm,sw_seed,sw_chem,sw_fire,sw_biog,corr_lngth_hz,corr_lngth_vt,corr_lngth_tm,corr_tm_delt
   namelist /perturb_chem_emiss_spec_nml/ch_chem_spc,ch_fire_spc,ch_biog_spc
!
! Setup MPI
   call mpi_init(ierr)
   call mpi_comm_rank(MPI_COMM_WORLD,rank,ierr)
   call mpi_comm_size(MPI_COMM_WORLD,num_procs,ierr)
!
! Assign constants
   pi=4.*atan(1.)
   grav=9.8
   nz_fire=1
   nz_biog=1
   zfac=2.
   zmin=1.e-10
   fac_min=0.01
   icnt_tsk=2
!
! Read control namelist
   unit=20
   open(unit=unit,file='perturb_chem_emiss_corr_nml.nl',form='formatted', &
   status='old',action='read')
   rewind(unit)   
   read(unit,perturb_chem_emiss_corr_nml)
   close(unit)
!   if(rank.eq.0) then
!      print *, 'date               ',date
!      print *, 'nx                 ',nx
!      print *, 'ny                 ',ny
!      print *, 'nz                 ',nz
!      print *, 'nz_chem            ',nz_chem
!      print *, 'nchem_spcs         ',nchem_spcs
!      print *, 'nfire_spcs         ',nfire_spcs
!      print *, 'nbiog_spcs         ',nbiog_spcs
!      print *, 'pert_path_pr       ',trim(pert_path_pr)
!      print *, 'pert_path_po       ',trim(pert_path_po)
!      print *, 'num_mem            ',nnum_mem
!      print *, 'wrfchemi           ',trim(wrfchemi)
!      print *, 'wrffirechemi       ',trim(wrffirechemi)
!      print *, 'wrfbiogchemi       ',trim(wrfbiogchemi)
!      print *, 'sprd_chem          ',sprd_chem
!      print *, 'sprd_fire          ',sprd_fire
!      print *, 'sprd_biog          ',sprd_biog
!      print *, 'sw_corr_tm         ',sw_corr_tm
!      print *, 'sw_seed            ',sw_seed
!      print *, 'sw_chem            ',sw_chem
!      print *, 'sw_fire            ',sw_fire
!      print *, 'sw_biog            ',sw_biog
!      print *, 'corr_lngth_hz      ',corr_lngth_hz
!      print *, 'corr_lngth_vt      ',corr_lngth_vt
!      print *, 'corr_lngth_tm      ',corr_lngth_tm
!      print *, 'corr_tm_delt       ',corr_tm_delt
!   endif
!
   nxy=nx*ny   
   nzp=nz+1
   num_mems=nint(nnum_mem)
!
! Allocate arrays
   allocate(ch_chem_spc(nchem_spcs),ch_fire_spc(nfire_spcs),ch_biog_spc(nbiog_spcs))
   if(sw_chem) then
      allocate(A_chem(nx,ny,nz_chem,nz_chem))
      A_chem(:,:,:,:)=0.
   else
      nchem_spcs=0
   endif
   if(sw_fire) then
      allocate(A_fire(nx,ny,nz_fire,nz_fire))
      A_fire(:,:,:,:)=0.
   else
      nfire_spcs=0
   endif
   if(sw_biog) then
      allocate(A_biog(nx,ny,nz_biog,nz_biog))
      A_biog(:,:,:,:)=0.
   else
      nbiog_spcs=0.
   endif
!
! Read the species namelist
   unit=20
   open(unit=unit,file='perturb_emiss_chem_spec_nml.nl',form='formatted', &
   status='old',action='read')
   rewind(unit)
   read(unit,perturb_chem_emiss_spec_nml)
   close(unit)
!
! Get lat / lon data
   allocate(lat(nx,ny),lon(nx,ny))
   call get_WRFINPUT_lat_lon(lat,lon,nx,ny)
!
! Get mean geopotential height data
   allocate(geo_ht(nx,ny,nz))
   call get_WRFINPUT_geo_ht(geo_ht,nx,ny,nz,nzp,num_mems)
   geo_ht(:,:,:)=geo_ht(:,:,:)/grav
!
! Get horiztonal grid length
   grid_length=get_dist(lat(nx/2,ny/2),lat(nx/2+1,ny/2),lon(nx/2,ny/2),lon(nx/2+1,ny/2))
!
! Calculate number of horizontal grid points to be correlated 
   ngrid_corr=ceiling(zfac*corr_lngth_hz/grid_length)+1
!
! Construct the vertical weights
   if(sw_chem) then
      call vertical_transform(A_chem,geo_ht,nx,ny,nz,nz_chem,corr_lngth_vt)
   endif
   if(sw_fire) then
      call vertical_transform(A_fire,geo_ht,nx,ny,nz,nz_fire,corr_lngth_vt)
   endif
   if(sw_biog) then
      call vertical_transform(A_biog,geo_ht,nx,ny,nz,nz_biog,corr_lngth_vt)
   endif
   deallocate(geo_ht)
!
! Allocate processors
   ntotal_spcs=0
   if(sw_chem) then
      ntotal_spcs=ntotal_spcs+nchem_spcs
   endif
   if(sw_fire) then
      ntotal_spcs=ntotal_spcs+nfire_spcs
   endif
   if(sw_biog) then
      ntotal_spcs=ntotal_spcs+nbiog_spcs
   endif
   ntotal_spcs=ntotal_spcs*num_mems
   allocate(itask(num_mems,ntotal_spcs))
   icnt=0
   do imem=1,num_mems
      do isp=1,nchem_spcs
         icnt=icnt+1
         itask(imem,icnt)=mod(icnt-1,num_procs-icnt_tsk)+icnt_tsk
!         if(rank.eq.0) print *,'CHEM imem,isp,icnt,itask ',imem,isp,icnt,itask(imem,icnt) 
      enddo
      do isp=1,nfire_spcs
         icnt=icnt+1
         itask(imem,icnt)=mod(((imem-1)*ntotal_spcs+icnt-1),num_procs)
!         if(rank.eq.0) print *,'FIRE imem,isp,icnt,itask ',imem,isp,icnt,itask(imem,icnt) 
      enddo
      do isp=1,nbiog_spcs
         icnt=icnt+1
         itask(imem,icnt)=mod(((imem-1)*ntotal_spcs+icnt-1),num_procs)
!         if(rank.eq.0) print *,'BIOG imem,isp,icnt,itask ',imem,isp,icnt,itask(imem,icnt) 
      enddo
   enddo
!
! Read old scaling factors if they exist   
   if(rank.eq.0) then
      if(.not.sw_corr_tm) then
         if(sw_chem) then
            unita=30
            filenm=trim(pert_path_pr)//'/pert_chem_icbc'
            open(unit=unita,file=trim(filenm), &
            form='unformatted',status='unknown')
            rewind(unita)
         endif
!         
         if(sw_fire) then
            unitb=40
            filenm=trim(pert_path_pr)//'/pert_fire_icbc'
            open(unit=unitb,file=trim(filenm), &
            form='unformatted',status='unknown')
            rewind(unitb)
         endif
!
         if(sw_biog) then
            unitc=50
            filenm=trim(pert_path_pr)//'/pert_biog_icbc'
            open(unit=unitc,file=trim(filenm), &
            form='unformatted',status='unknown')
            rewind(unitc)
         endif
!
         icnt=0
         do imem=1,num_mems
            unita=30
            allocate(chem_fac_old(nx,ny,nz_chem))
            allocate(tmp_arry(nx*ny*nz_chem))
            do isp=1,nchem_spcs
               icnt=icnt+1
               read(unita) chem_fac_old
               call apm_pack(tmp_arry,chem_fac_old,nx,ny,nz_chem)
               call mpi_send(tmp_arry,nx*ny*nz_chem,MPI_FLOAT, &
               itask(imem,icnt),1,MPI_COMM_WORLD,ierr)
            enddo
            deallocate(chem_fac_old)
            deallocate(tmp_arry)
!
            unitb=40
            allocate(fire_fac_old(nx,ny,nz_fire))
            allocate(tmp_arry(nx*ny*nz_fire))
            do isp=1,nfire_spcs
               icnt=icnt+1
               read(unitb) fire_fac_old
               call apm_pack(tmp_arry,fire_fac_old,nx,ny,nz_fire)
               call mpi_send(tmp_arry,nx*ny*nz_fire,MPI_FLOAT, &
               itask(imem,icnt),2,MPI_COMM_WORLD,ierr)
            enddo
            deallocate(fire_fac_old)
            deallocate(tmp_arry)
!
            unitc=50
            allocate(biog_fac_old(nx,ny,nz_biog))
            allocate(tmp_arry(nx*ny*nz_biog))
            do isp=1,nbiog_spcs
               icnt=icnt+1
               read(unitc) biog_fac_old
               call apm_pack(tmp_arry,biog_fac_old,nx,ny,nz_biog)
               call mpi_send(tmp_arry,nx*ny*nz_biog,MPI_FLOAT, &
               itask(imem,icnt),3,MPI_COMM_WORLD,ierr)
            enddo
            deallocate(biog_fac_old)
            deallocate(tmp_arry)
         enddo
         close(unita)
         close(unitb)
         close(unitc)
      endif
!      
      call mpi_recv(flg,1,MPI_FLOAT,1,3,MPI_COMM_WORLD,stat,ierr)
!
      if(sw_chem) then
         unita=30
         filenm=trim(pert_path_po)//'/pert_chem_icbc_temp'
         open(unit=unita,file=trim(filenm), &
         form='unformatted',status='unknown')
         rewind(unita)
      endif
!
      if(sw_fire) then
         unita=40
         filenm=trim(pert_path_po)//'/pert_fire_icbc_temp'
         open(unit=unita,file=trim(filenm), &
         form='unformatted',status='unknown')
         rewind(unita)
      endif
!
      if(sw_biog) then
         unita=50
         filenm=trim(pert_path_po)//'/pert_biog_icbc_temp'
         open(unit=unita,file=trim(filenm), &
         form='unformatted',status='unknown')
         rewind(unita)
      endif
!
      icnt=0
      do imem=1,num_mems
         if(imem.ge.0.and.imem.lt.10) write(cmem,"('.e00',i1)"),imem
         if(imem.ge.10.and.imem.lt.100) write(cmem,"('.e0',i2)"),imem
         if(imem.ge.100.and.imem.lt.1000) write(cmem,"('.e',i3)"),imem
         unita=30
         do isp=1,nchem_spcs
            icnt=icnt+1
            allocate(chem_fac_end(nx,ny,nz_chem))
            allocate(tmp_arry(nx*ny*nz_chem))
            read(unita) chem_fac_end
            call apm_pack(tmp_arry,chem_fac_end,nx,ny,nz_chem)
            call mpi_send(tmp_arry,nx*ny*nz_chem,MPI_FLOAT, &
            itask(imem,icnt),4,MPI_COMM_WORLD,ierr)
            deallocate(chem_fac_end)
            deallocate(tmp_arry)
!
            wrfchem_file=trim(wrfchemi)
            allocate(chem_data3d(nx,ny,nz_chem))
            allocate(tmp_arry(nx*ny*nz_chem))
            call get_WRFCHEM_emiss_data(wrfchem_file,ch_chem_spc(isp),chem_data3d, &
            nx,ny,nz_chem)
            call apm_pack(tmp_arry,chem_data3d,nx,ny,nz_chem)
            call mpi_send(tmp_arry,nx*ny*nz_chem,MPI_FLOAT, &
            itask(imem,icnt),5,MPI_COMM_WORLD,ierr)
            deallocate(chem_data3d)
            deallocate(tmp_arry)
         enddo
!
         unita=40
         do isp=1,nfire_spcs
            icnt=icnt+1
            allocate(fire_fac_end(nx,ny,nz_fire))
            allocate(tmp_arry(nx*ny*nz_fire))
            read(unita) fire_fac_end
            call apm_pack(tmp_arry,fire_fac_end,nx,ny,nz_fire)
            call mpi_send(tmp_arry,nx*ny*nz_fire,MPI_FLOAT, &
            itask(imem,icnt),6,MPI_COMM_WORLD,ierr)
            deallocate(fire_fac_end)
            deallocate(tmp_arry)
!
            wrfchem_file=trim(wrffirechemi)
            allocate(chem_data3d(nx,ny,nz_fire))
            allocate(tmp_arry(nx*ny*nz_fire))
            call get_WRFCHEM_emiss_data(wrfchem_file,ch_chem_spc(isp),chem_data3d, &
            nx,ny,nz_fire)
            call apm_pack(tmp_arry,chem_data3d,nx,ny,nz_fire)
            call mpi_send(tmp_arry,nx*ny*nz_fire,MPI_FLOAT, &
            itask(imem,icnt),7,MPI_COMM_WORLD,ierr)
            deallocate(chem_data3d)
            deallocate(tmp_arry)
        enddo
!
         unita=50
         do isp=1,nbiog_spcs
            icnt=icnt+1
            allocate(biog_fac_end(nx,ny,nz_biog))
            allocate(tmp_arry(nx*ny*nz_biog))
            read(unita) biog_fac_end
            call apm_pack(tmp_arry,biog_fac_end,nx,ny,nz_biog)
            call mpi_send(tmp_arry,nx*ny*nz_biog,MPI_FLOAT, &
            itask(imem,icnt),8,MPI_COMM_WORLD,ierr)
            deallocate(biog_fac_end)
            deallocate(tmp_arry)
!
            wrfchem_file=trim(wrfbiogchemi)
            allocate(chem_data3d(nx,ny,nz_biog))
            allocate(tmp_arry(nx*ny*nz_biog))
            call get_WRFCHEM_emiss_data(wrfchem_file,ch_chem_spc(isp),chem_data3d, &
            nx,ny,nz_biog)
            call apm_pack(tmp_arry,chem_data3d,nx,ny,nz_biog)
            call mpi_send(tmp_arry,nx*ny*nz_biog,MPI_FLOAT, &
            itask(imem,icnt),9,MPI_COMM_WORLD,ierr)
            deallocate(chem_data3d)
            deallocate(tmp_arry)            
         enddo
      enddo
   endif
!
! Loop through member and species. Assign one member/species to each processor   
   if(rank.ne.0 .and. rank.ne.1) then
      icnt=0
      do imem=1,num_mems
         if(imem.ge.0.and.imem.lt.10) write(cmem,"('.e00',i1)"),imem
         if(imem.ge.10.and.imem.lt.100) write(cmem,"('.e0',i2)"),imem
         if(imem.ge.100.and.imem.lt.1000) write(cmem,"('.e',i3)"),imem
         allocate(chem_fac_old(nx,ny,nz_chem))
         allocate(chem_fac_new(nx,ny,nz_chem))
         allocate(chem_fac_end(nx,ny,nz_chem))
         allocate(chem_data3d(nx,ny,nz_chem))      
         do isp=1,nchem_spcs
            icnt=icnt+1
            if(rank.eq.itask(imem,icnt)) then
               if(.not.sw_corr_tm) then
                  allocate(tmp_arry(nx*ny*nz_chem))
                  call mpi_recv(tmp_arry,nx*ny*nz_chem, &
                  MPI_FLOAT,0,1,MPI_COMM_WORLD,stat,ierr)
                  call apm_unpack(tmp_arry,chem_fac_old,nx,ny,nz_chem)
                  deallocate(tmp_arry)
               endif
!
               if(sw_seed) call init_const_random_seed(rank,date)
               call cpu_time(cpu_str)
               call perturb_fields(chem_fac_old,chem_fac_new, &
               lat,lon,A_chem,nx,ny,nz_chem,nchem_spcs,ngrid_corr,sw_corr_tm, &
               corr_lngth_hz,rank)
               call cpu_time(cpu_end)
               cpu_dif=cpu_end-cpu_str
               print *, 'RANK: ',itask(imem,icnt),' imem,isp, ',imem,isp,' perturb_fields: chem time ',cpu_dif
!
! Impose temporal correlations
               wgt_end=exp(-1.0*corr_tm_delt/corr_lngth_tm)
               chem_fac_end(:,:,:)=wgt_end*chem_fac_old(:,:,:)+(1.-wgt_end)* &
               chem_fac_new(:,:,:)
!               
! Send chem_fac_end to rank 1 for writing to archive file            
               allocate(tmp_arry(nx*ny*nz_chem))
               call apm_pack(tmp_arry,chem_fac_end,nx,ny,nz_chem)
               call mpi_send(tmp_arry,nx*ny*nz_chem,MPI_FLOAT, &
               1,21,MPI_COMM_WORLD,ierr)
               deallocate(tmp_arry)             
            endif
         enddo
         deallocate(chem_fac_old)
         deallocate(chem_fac_new)
         deallocate(chem_fac_end)
         deallocate(chem_data3d)      
!
         allocate(fire_fac_old(nx,ny,nz_fire))
         allocate(fire_fac_new(nx,ny,nz_fire))
         allocate(fire_fac_end(nx,ny,nz_fire))
         allocate(chem_data3d(nx,ny,nz_fire))      
         do isp=1,nfire_spcs
            icnt=icnt+1
            if(rank.eq.itask(imem,icnt)) then
               if(.not.sw_corr_tm) then
                  allocate(tmp_arry(nx*ny*nz_fire))
                  call mpi_recv(tmp_arry,nx*ny*nz_fire, &
                  MPI_FLOAT,0,2,MPI_COMM_WORLD,stat,ierr)
                  call apm_unpack(tmp_arry,fire_fac_old,nx,ny,nz_fire)
                  deallocate(tmp_arry)
               endif
!
               if(sw_seed) call init_const_random_seed(rank,date)
               call cpu_time(cpu_str)
               call perturb_fields(fire_fac_old,fire_fac_new, &
               lat,lon,A_fire,nx,ny,nz_fire,nfire_spcs,ngrid_corr,sw_corr_tm, &
               corr_lngth_hz,rank)
               call cpu_time(cpu_end)
               cpu_dif=cpu_end-cpu_str
               print *, 'RANK: ',itask(imem,icnt),' imem,isp, ',imem,isp,' perturb_fields: fire time ',cpu_dif
!
! Impose temporal correlations
               wgt_end=exp(-1.0*corr_tm_delt/corr_lngth_tm)
               fire_fac_end(:,:,:)=wgt_end*fire_fac_old(:,:,:)+(1.-wgt_end)* &
               fire_fac_new(:,:,:)
!               
! Send fire_fac_end to rank 1 for writing to archive file            
               allocate(tmp_arry(nx*ny*nz_fire))
               call apm_pack(tmp_arry,fire_fac_end,nx,ny,nz_fire)
               call mpi_send(tmp_arry,nx*ny*nz_fire,MPI_FLOAT, &
               1,22,MPI_COMM_WORLD,ierr)
               deallocate(tmp_arry)             
            endif
         enddo
         deallocate(fire_fac_old)
         deallocate(fire_fac_new)
         deallocate(fire_fac_end)
         deallocate(chem_data3d)      
!
         allocate(biog_fac_old(nx,ny,nz_biog))
         allocate(biog_fac_new(nx,ny,nz_biog))
         allocate(biog_fac_end(nx,ny,nz_biog))
         allocate(chem_data3d(nx,ny,nz_biog))      
         do isp=1,nbiog_spcs
            icnt=icnt+1
            if(rank.eq.itask(imem,icnt)) then
               if(.not.sw_corr_tm) then
                  allocate(tmp_arry(nx*ny*nz_biog))
                  call mpi_recv(tmp_arry,nx*ny*nz_biog, &
                  MPI_FLOAT,0,3,MPI_COMM_WORLD,stat,ierr)
                  call apm_unpack(tmp_arry,biog_fac_old,nx,ny,nz_biog)
                  deallocate(tmp_arry)
               endif
!
               if(sw_seed) call init_const_random_seed(rank,date)
               call cpu_time(cpu_str)
               call perturb_fields(biog_fac_old,biog_fac_new, &
               lat,lon,A_biog,nx,ny,nz_biog,nbiog_spcs,ngrid_corr,sw_corr_tm, &
               corr_lngth_hz,rank)
               call cpu_time(cpu_end)
               cpu_dif=cpu_end-cpu_str
               print *, 'RANK: ',itask(imem,icnt),' imem,isp, ',imem,isp,' perturb_fields: biog time ',cpu_dif
!
! Impose temporal correlations
               wgt_end=exp(-1.0*corr_tm_delt/corr_lngth_tm)
               biog_fac_end(:,:,:)=wgt_end*biog_fac_old(:,:,:)+(1.-wgt_end)* &
               biog_fac_new(:,:,:)
!               
! Send biog_fac_end to rank 1 for writing to archive file
               allocate(tmp_arry(nx*ny*nz_biog))
               call apm_pack(tmp_arry,biog_fac_end,nx,ny,nz_biog)
               call mpi_send(tmp_arry,nx*ny*nz_biog,MPI_FLOAT, &
               1,23,MPI_COMM_WORLD,ierr)
               deallocate(tmp_arry) 
            endif
         enddo
         deallocate(biog_fac_old)
         deallocate(biog_fac_new)
         deallocate(biog_fac_end)
         deallocate(chem_data3d)      
      enddo
!
      icnt=0
      do imem=1,num_mems
         if(imem.ge.0.and.imem.lt.10) write(cmem,"('.e00',i1)"),imem
         if(imem.ge.10.and.imem.lt.100) write(cmem,"('.e0',i2)"),imem
         if(imem.ge.100.and.imem.lt.1000) write(cmem,"('.e',i3)"),imem
         allocate (chem_fac_end(nx,ny,nz_chem))
         allocate (chem_data3d(nx,ny,nz_chem))
         do isp=1,nchem_spcs
            icnt=icnt+1
            if(rank.eq.itask(imem,icnt)) then
               allocate(tmp_arry(nx*ny*nz_chem))
               call mpi_recv(tmp_arry,nx*ny*nz_chem,MPI_FLOAT, &
               0,4,MPI_COMM_WORLD,stat,ierr)
               call apm_unpack(tmp_arry,chem_fac_end,nx,ny,nz_chem)
               deallocate(tmp_arry)
!                                                                                                          
               allocate(tmp_arry(nx*ny*nz_chem))
               call mpi_recv(tmp_arry,nx*ny*nz_chem, &
               MPI_FLOAT,0,5,MPI_COMM_WORLD,stat,ierr)
               call apm_unpack(tmp_arry,chem_data3d,nx,ny,nz_chem)
               deallocate(tmp_arry)
!
               do i=1,nx
                  do j=1,ny
                     do k=1,nz_chem
                        if(chem_data3d(i,j,k)*(1.+chem_fac_end(i,j,k)) .le. 0.) then
                           chem_data3d(i,j,k)=fac_min*chem_data3d(i,j,k)
                        else
                           chem_data3d(i,j,k)=chem_data3d(i,j,k)*(1.+chem_fac_end(i,j,k))
                        endif
                     enddo
                  enddo
               enddo
!
               allocate(tmp_arry(nx*ny*nz_chem))
               call apm_pack(tmp_arry,chem_data3d,nx,ny,nz_chem)
               call mpi_send(tmp_arry,nx*ny*nz_chem,MPI_FLOAT, &
               1,24,MPI_COMM_WORLD,ierr)
               deallocate(tmp_arry)
            endif
         enddo      
         deallocate (chem_fac_end)
         deallocate (chem_data3d)
!
         allocate (fire_fac_end(nx,ny,nz_fire))
         allocate (chem_data3d(nx,ny,nz_fire))
         do isp=1,nfire_spcs
            icnt=icnt+1
            if(rank.eq.itask(imem,icnt)) then
               allocate(tmp_arry(nx*ny*nz_fire))
               call mpi_recv(tmp_arry,nx*ny*nz_fire,MPI_FLOAT, &
               0,6,MPI_COMM_WORLD,stat,ierr)
               call apm_unpack(tmp_arry,fire_fac_end,nx,ny,nz_fire)
               deallocate(tmp_arry)
!                                                                                                          
               allocate(tmp_arry(nx*ny*nz_fire))
               call mpi_recv(tmp_arry,nx*ny*nz_fire, &
               MPI_FLOAT,0,7,MPI_COMM_WORLD,stat,ierr)
               call apm_unpack(tmp_arry,chem_data3d,nx,ny,nz_fire)
               deallocate(tmp_arry)
!
               do i=1,nx
                  do j=1,ny
                     do k=1,nz_fire
                        if(chem_data3d(i,j,k)*(1.+fire_fac_end(i,j,k)) .le. 0.) then
                           chem_data3d(i,j,k)=fac_min*chem_data3d(i,j,k)
                        else
                           chem_data3d(i,j,k)=chem_data3d(i,j,k)*(1.+fire_fac_end(i,j,k))
                        endif
                     enddo
                  enddo
               enddo
!
               allocate(tmp_arry(nx*ny*nz_fire))
               call apm_pack(tmp_arry,chem_data3d,nx,ny,nz_fire)
               call mpi_send(tmp_arry,nx*ny*nz_fire,MPI_FLOAT, &
               1,25,MPI_COMM_WORLD,ierr)
               deallocate(tmp_arry)
            endif
         enddo      
         deallocate (fire_fac_end)
         deallocate (chem_data3d)
!
         allocate (biog_fac_end(nx,ny,nz_biog))
         allocate (chem_data3d(nx,ny,nz_biog))
         do isp=1,nbiog_spcs
            icnt=icnt+1
            if(rank.eq.itask(imem,icnt)) then
               allocate(tmp_arry(nx*ny*nz_biog))
               call mpi_recv(tmp_arry,nx*ny*nz_biog,MPI_FLOAT, &
               0,8,MPI_COMM_WORLD,stat,ierr)
               call apm_unpack(tmp_arry,biog_fac_end,nx,ny,nz_biog)
               deallocate(tmp_arry)
!                                                                                                          
               allocate(tmp_arry(nx*ny*nz_biog))
               call mpi_recv(tmp_arry,nx*ny*nz_biog, &
               MPI_FLOAT,0,9,MPI_COMM_WORLD,stat,ierr)
               call apm_unpack(tmp_arry,chem_data3d,nx,ny,nz_biog)
               deallocate(tmp_arry)
!
               do i=1,nx
                  do j=1,ny
                     do k=1,nz_biog
                        if(chem_data3d(i,j,k)*(1.+biog_fac_end(i,j,k)) .le. 0.) then
                           chem_data3d(i,j,k)=fac_min*chem_data3d(i,j,k)
                        else
                           chem_data3d(i,j,k)=chem_data3d(i,j,k)*(1.+biog_fac_end(i,j,k))
                        endif
                     enddo
                  enddo
               enddo
!
               allocate(tmp_arry(nx*ny*nz_biog))
               call apm_pack(tmp_arry,chem_data3d,nx,ny,nz_biog)
               call mpi_send(tmp_arry,nx*ny*nz_biog,MPI_FLOAT, &
               1,26,MPI_COMM_WORLD,ierr)
               deallocate(tmp_arry)
            endif
         enddo
         deallocate (biog_fac_end)
         deallocate (chem_data3d)         
      enddo
   endif
!
! Save the correlation factors for next cycle
   if (rank.eq.1) then
      if(sw_chem) then
         unita=30
         filenm=trim(pert_path_po)//'/pert_chem_icbc_temp'
         open(unit=unita,file=trim(filenm),form='unformatted',status='unknown')
         rewind(unita)
      endif
      if(sw_fire) then
         unita=40
         filenm=trim(pert_path_po)//'/pert_fire_icbc_temp'
         open(unit=unita,file=trim(filenm),form='unformatted',status='unknown')
         rewind(unita)
      endif
      if(sw_biog) then
         unita=50
         filenm=trim(pert_path_po)//'/pert_biog_icbc_temp'
         open(unit=unita,file=trim(filenm),form='unformatted',status='unknown')
         rewind(unita)
      endif
      icnt=0
      do imem=1,num_mems
         unita=30
         allocate(chem_fac_end(nx,ny,nz_chem))
         do isp=1,nchem_spcs
            icnt=icnt+1
            allocate(tmp_arry(nx*ny*nz_chem))
            call mpi_recv(tmp_arry,nx*ny*nz_chem,MPI_FLOAT, &
            itask(imem,icnt),21,MPI_COMM_WORLD,stat,ierr)
            call apm_unpack(tmp_arry,chem_fac_end,nx,ny,nz_chem)
            write(unita) chem_fac_end
            deallocate(tmp_arry)
         enddo
         deallocate(chem_fac_end)
!         
         unitb=40
         allocate(fire_fac_end(nx,ny,nz_fire))
         do isp=1,nfire_spcs
            icnt=icnt+1
            allocate(tmp_arry(nx*ny*nz_fire))
            call mpi_recv(tmp_arry,nx*ny*nz_fire,MPI_FLOAT, &
            itask(imem,icnt),22,MPI_COMM_WORLD,stat,ierr)
            call apm_unpack(tmp_arry,fire_fac_end,nx,ny,nz_fire)
            write(unitb) fire_fac_end
            deallocate(tmp_arry)
         enddo
         deallocate(fire_fac_end)
!
         unitc=50
         allocate(biog_fac_end(nx,ny,nz_biog))
         do isp=1,nbiog_spcs
            icnt=icnt+1
            allocate(tmp_arry(nx*ny*nz_biog))
            call mpi_recv(tmp_arry,nx*ny*nz_biog,MPI_FLOAT, &
            itask(imem,icnt),23,MPI_COMM_WORLD,stat,ierr)
            call apm_unpack(tmp_arry,biog_fac_end,nx,ny,nz_biog)
            write(unitc) biog_fac_end
            deallocate(tmp_arry)
         enddo
         deallocate(biog_fac_end)
      enddo
      close(unita)
      close(unitb)
      close(unitc)
!
      call mpi_send(1.,1,MPI_FLOAT,0,3,MPI_COMM_WORLD,ierr)
!
      icnt=0
      do imem=1,num_mems
         if(imem.ge.0.and.imem.lt.10) write(cmem,"('.e00',i1)"),imem
         if(imem.ge.10.and.imem.lt.100) write(cmem,"('.e0',i2)"),imem
         if(imem.ge.100.and.imem.lt.1000) write(cmem,"('.e',i3)"),imem
         do isp=1,nchem_spcs
            icnt=icnt+1
            allocate(chem_data3d(nx,ny,nz_chem))
            allocate(tmp_arry(nx*ny*nz_chem))
            call mpi_recv(tmp_arry,nx*ny*nz_chem,MPI_FLOAT, &
            itask(imem,icnt),24,MPI_COMM_WORLD,stat,ierr)
            call apm_unpack(tmp_arry,chem_data3d,nx,ny,nz_chem)
            wrfchem_file=trim(wrfchemi)//trim(cmem)
            call put_WRFCHEM_emiss_data(wrfchem_file,ch_chem_spc(isp),chem_data3d, &
            nx,ny,nz_chem)
            deallocate(chem_data3d)
            deallocate(tmp_arry)
         enddo
!
         do isp=1,nfire_spcs
            icnt=icnt+1
            allocate(chem_data3d(nx,ny,nz_fire))
            allocate(tmp_arry(nx*ny*nz_fire))
            call mpi_recv(tmp_arry,nx*ny*nz_fire,MPI_FLOAT, &
            itask(imem,icnt),25,MPI_COMM_WORLD,stat,ierr)
            call apm_unpack(tmp_arry,chem_data3d,nx,ny,nz_fire)
            wrfchem_file=trim(wrffirechemi)//trim(cmem)
            call put_WRFCHEM_emiss_data(wrfchem_file,ch_fire_spc(isp),chem_data3d, &
            nx,ny,nz_fire)
            deallocate(chem_data3d)
            deallocate(tmp_arry)
         enddo
!
         do isp=1,nbiog_spcs
            icnt=icnt+1
            allocate(chem_data3d(nx,ny,nz_fire))
            allocate(tmp_arry(nx*ny*nz_fire))
            call mpi_recv(tmp_arry,nx*ny*nz_biog,MPI_FLOAT, &
            itask(imem,icnt),26,MPI_COMM_WORLD,stat,ierr)
            call apm_unpack(tmp_arry,chem_data3d,nx,ny,nz_biog)
            wrfchem_file=trim(wrfbiogchemi)//trim(cmem)
            call put_WRFCHEM_emiss_data(wrfchem_file,ch_biog_spc(isp),chem_data3d, &
            nx,ny,nz_biog)
            deallocate(chem_data3d)
            deallocate(tmp_arry)
         enddo
      enddo
   endif
   deallocate(ch_chem_spc)
   deallocate(ch_fire_spc)
   deallocate(ch_biog_spc)
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
! row 1         
               if(k.eq.1 .and. l.eq.1) then
                  A_chem(i,j,k,l)=1.
               elseif(k.eq.1 .and. l.gt.1) then
                  A_chem(i,j,k,l)=0.
               endif
! row 2         
               if(k.eq.2 .and. l.eq.1) then
                  A_chem(i,j,k,l)=vcov
               elseif(k.eq.2 .and. l.eq.2) then
                  A_chem(i,j,k,l)=sqrt(1.-A_chem(i,j,k,l-1)*A_chem(i,j,k,l-1))
               elseif (k.eq.2 .and. l.gt.2) then
                  A_chem(i,j,k,l)=0.
               endif
! row 3 and greater         
               if(k.ge.3) then
                  if(l.eq.1) then
                     A_chem(i,j,k,l)=vcov
                  elseif(l.lt.k .and. l.ne.1) then
                     do ll=1,l-1
                        A_chem(i,j,k,l)=A_chem(i,j,k,l)+A_chem(i,j,l,ll)*A_chem(i,j,k,ll)
                     enddo
                     if(A_chem(i,j,l,l).ne.0) A_chem(i,j,k,l)=(vcov-A_chem(i,j,k,l))/A_chem(i,j,l,l)
                  elseif(l.eq.k) then
                     do ll=1,l-1
                        A_chem(i,j,k,l)=A_chem(i,j,k,l)+A_chem(i,j,k,ll)*A_chem(i,j,k,ll)
                     enddo
                     A_chem(i,j,k,l)=sqrt(1.-A_chem(i,j,k,l))
                  endif
               endif
            enddo
         enddo
      enddo
   enddo
end subroutine vertical_transform

!-------------------------------------------------------------------------------

subroutine perturb_fields(chem_fac_old,chem_fac_new, &
lat,lon,A_chem,nx,ny,nz,nchem_spcs,ngrid_corr,sw_corr_tm, &
corr_lngth_hz,rank)

!   use apm_utilities_mod,  only :get_dist
  
   implicit none
   integer,                               intent(in)   :: nx,ny,nz,rank
   integer,                               intent(in)   :: sw_corr_tm
   integer,                               intent(in)   :: ngrid_corr,nchem_spcs
   real,                                  intent(in)   :: corr_lngth_hz
   real,dimension(nx,ny),                 intent(in)   :: lat,lon
   real,dimension(nx,ny,nz,nz),           intent(in)   :: A_chem
   real,dimension(nx,ny,nz),              intent(out)  :: chem_fac_old
   real,dimension(nx,ny,nz),              intent(out)  :: chem_fac_new
!
   integer                             :: i,j,k,isp,ii,jj,kk,nxy
   integer                             :: ii_str,ii_end,jj_str,jj_end,icnt,ncnt
   integer,allocatable,dimension(:)    :: indx,jndx
   real                                :: pi,get_dist,wgt_sum
   real                                :: u_ran_1,u_ran_2,zdist
   real,allocatable,dimension(:)       :: pert_chem_sum_old,pert_chem_sum_new,wgt
   real,allocatable,dimension(:,:,:)   :: pert_chem_old,pert_chem_new
!
! Constants
   pi=4.*atan(1.)
   nxy=nx*ny
!
! Define horizontal perturbations
   allocate(pert_chem_old(nx,ny,nz))
   allocate(pert_chem_new(nx,ny,nz))
   pert_chem_old(:,:,:)=0.
   pert_chem_new(:,:,:)=0.
   if(sw_corr_tm) then
      do i=1,nx
         do j=1,ny
            do k=1,nz
               call random_number(u_ran_1)
               if(u_ran_1.eq.0.) call random_number(u_ran_1)
               call random_number(u_ran_2)
               if(u_ran_2.eq.0.) call random_number(u_ran_2)
               pert_chem_old(i,j,k)=sqrt(-2.*log(u_ran_1))*cos(2.*pi*u_ran_2)
            enddo
         enddo
      enddo
   endif
   do i=1,nx
      do j=1,ny
         do k=1,nz
            call random_number(u_ran_1)
            if(u_ran_1.eq.0.) call random_number(u_ran_1)
            call random_number(u_ran_2)
            if(u_ran_2.eq.0.) call random_number(u_ran_2)
            pert_chem_new(i,j,k)=sqrt(-2.*log(u_ran_1))*cos(2.*pi*u_ran_2)
         enddo
      enddo
   enddo
!
! Apply horizontal correlations
   if(sw_corr_tm) then
      chem_fac_old(:,:,:)=0.
   endif
   chem_fac_new(:,:,:)=0.
   allocate(indx(nxy),jndx(nxy),wgt(nxy))
   do i=1,nx
      do j=1,ny
         indx(:)=0
         jndx(:)=0
         call horiz_grid_wts(i,j,indx,jndx,ncnt,wgt,wgt_sum,lon,lat,nx,ny,nxy, &
         ngrid_corr,corr_lngth_hz,rank)
         if(sw_corr_tm) then         
            if(ncnt.eq.0) then
               do k=1,nz
                  chem_fac_old(i,j,k)=pert_chem_old(i,j,k)
               enddo
            endif
            do icnt=1,ncnt
               ii=indx(icnt)
               jj=jndx(icnt)
               do k=1,nz
                  chem_fac_old(i,j,k)=chem_fac_old(i,j,k)+wgt(icnt)* &
                  pert_chem_old(ii,jj,k)/wgt_sum
               enddo
            enddo
         endif
         if(ncnt.eq.0) then   
            do k=1,nz
               chem_fac_new(i,j,k)=pert_chem_new(i,j,k)
            enddo
         endif
         do icnt=1,ncnt
            ii=indx(icnt)
            jj=jndx(icnt)
            do k=1,nz
               chem_fac_new(i,j,k)=chem_fac_new(i,j,k)+wgt(icnt)* &
               pert_chem_new(ii,jj,k)/wgt_sum
            enddo
         enddo
      enddo
   enddo
   deallocate(indx,jndx,wgt)
   deallocate(pert_chem_old)
   deallocate(pert_chem_new)
!
! Apply vertical correlations
   if(sw_corr_tm) then
      allocate(pert_chem_sum_old(nz))
      do i=1,nx
         do j=1,ny
            pert_chem_sum_old(:)=0.
            do k=1,nz
               do kk=1,nz
                  pert_chem_sum_old(k)=pert_chem_sum_old(k)+A_chem(i,j,k,kk)* &
                  chem_fac_old(i,j,kk)
               enddo
            enddo
            do k=1,nz
               chem_fac_old(i,j,k)=pert_chem_sum_old(k)
            enddo
         enddo
      enddo
      deallocate(pert_chem_sum_old)
   endif
   allocate(pert_chem_sum_new(nz))
   do i=1,nx
      do j=1,ny
         pert_chem_sum_new(:)=0.
         do k=1,nz
            do kk=1,nz
               pert_chem_sum_new(k)=pert_chem_sum_new(k)+A_chem(i,j,k,kk)* &
               chem_fac_new(i,j,kk)
            enddo
         enddo
         do k=1,nz
            chem_fac_new(i,j,k)=pert_chem_sum_new(k)
         enddo
      enddo
   enddo
   deallocate(pert_chem_sum_new)
end subroutine perturb_fields

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

subroutine get_WRFCHEM_emiss_data(file,name,data,nx,ny,nz_chem)
   implicit none
   include 'netcdf.inc'
   integer, parameter                    :: maxdim=6
   integer                               :: nx,ny,nz_chem
   integer                               :: i,rc
   integer                               :: f_id
   integer                               :: v_id,v_ndim,typ,natts
   integer,dimension(maxdim)             :: one
   integer,dimension(maxdim)             :: v_dimid
   integer,dimension(maxdim)             :: v_dim
   real,dimension(nx,ny,nz_chem)         :: data
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
      print *, 'nf_get_vara_real ', data(1,1,1)
      stop
   endif
   rc = nf_close(f_id)
   return
end subroutine get_WRFCHEM_emiss_data

!-------------------------------------------------------------------------------

subroutine put_WRFCHEM_emiss_data(file,name,data,nx,ny,nz_chem)
   implicit none
   include 'netcdf.inc'
   integer, parameter                    :: maxdim=6
   integer                               :: nx,ny,nz_chem
   integer                               :: i,rc
   integer                               :: f_id
   integer                               :: v_id,v_ndim,typ,natts
   integer,dimension(maxdim)             :: one
   integer,dimension(maxdim)             :: v_dimid
   integer,dimension(maxdim)             :: v_dim
   real,dimension(nx,ny,nz_chem)         :: data
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
!   rc = nf_close(f_id)
!   rc = nf_open(trim(file),NF_WRITE,f_id)
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

subroutine recenter_factors(chem_fac,nx,ny,nz_chem,nchem_spcs, &
num_mem,sprd_chem)
   implicit none
   integer,           intent(in)       :: nx,ny,nz_chem,nchem_spcs,num_mem
   real,              intent(in)       :: sprd_chem
   real,dimension(nx,ny,nz_chem,nchem_spcs,num_mem),intent(inout) :: chem_fac
   integer                                                        :: i,j,k,isp,imem
   real                                                           :: mean,std
   real,dimension(num_mem)                                        :: mems,pers
!
! Recenter about ensemble mean
   do i=1,nx
      do j=1,ny
         do k=1,nz_chem
            do isp=1,nchem_spcs
               mems(:)=chem_fac(i,j,k,isp,:)
               mean=sum(mems)/real(num_mem)
               pers=(mems-mean)*(mems-mean)
               std=sqrt(sum(pers)/real(num_mem-1))
               do imem=1,num_mem
                  chem_fac(i,j,k,isp,imem)=(chem_fac(i,j,k,isp,imem)-mean)*sprd_chem/std
               enddo
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
