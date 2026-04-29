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
   implicit none
!
! version controlled file description for error handling, do not edit
   character(len=*), parameter :: source   = 'perturb_chem_emiss_CORR_RT_MA_MPI.f90'
   character(len=*), parameter :: revision = ''
   character(len=*), parameter :: revdate  = ''
   include 'mpif.h'
   integer                                  :: ierr,rank,num_procs,seed_trm
   integer                                  :: unit,unita,unitb,unitc
   integer                                  :: date,ngrid_corr,icnt,icnt_tsk
   integer                                  :: ngrid_corr_chem,ngrid_corr_fire,ngrid_corr_biog
   integer                                  :: nx,ny,nz,nzp,nz_chem,nz_fire,nz_biog
   integer                                  :: nchem_spcs,nfire_spcs,nbiog_spcs,num_mems
   integer                                  :: i,j,k,kk,isp,imem,ntotal_spcs
      integer,dimension(8)                     :: date_time_vals
   integer,dimension(MPI_STATUS_SIZE)       :: stat
   integer,allocatable,dimension(:)         :: itask_chem,itask_fire,itask_biog
   real                                     :: pi,grav,zfac,zmin,fac_min,nnum_mem
   real                                     :: sprd_chem,sprd_fire,sprd_biog
   real                                     :: corr_lngth_hz,corr_lngth_vt
   real                                     :: corr_lngth_tm,corr_tm_delt
   real                                     :: grid_length,get_dist,zfac_chem,zfac_fire,zfac_biog
   real                                     :: mean,std,wgt_end,scl_fac_chem,scl_fac_fire,scl_fac_biog
   real                                     :: cpu_str,cpu_end,cpu_dif,flg
   real                                     :: u_ran_1,u_ran_2,sum,rsprd_crit
   real,allocatable,dimension(:)            :: tmp_arry
   real,allocatable,dimension(:,:)          :: lat,lon
   real,allocatable,dimension(:,:,:)        :: geo_ht,zfld,zmean,zmean_save,chem_mem
   real,allocatable,dimension(:,:,:,:)      :: A_chem,A_fire,A_biog
   real,allocatable,dimension(:,:,:)        :: chem_data3d,fire_data3d,biog_data3d
   real,allocatable,dimension(:,:,:)        :: chem_vari3d,fire_vari3d,biog_vari3d
   real,allocatable,dimension(:,:,:)        :: chem_vari_old,chem_vari_new,chem_vari_end
   real,allocatable,dimension(:,:,:)        :: fire_vari_old,fire_vari_new,fire_vari_end
   real,allocatable,dimension(:,:,:)        :: biog_vari_old,biog_vari_new,biog_vari_end
   character(len=20)                        :: cmem
   character(len=100)                       :: ch_date,ch_time,ch_zone
   character(len=150)                       :: pert_path_pr,pert_path_po,filenm
   character(len=150)                       :: wrfchemi,wrffirechemi,wrfbiogchemi
   character(len=150)                       :: wrfchemi_vari,wrffirechemi_vari,wrfbiogchemi_vari
   character(len=150)                       :: wrfchem_file,wrffire_file,wrfbiog_file
   character(len=150),allocatable,dimension(:) :: ch_chem_spc,ch_fire_spc,ch_biog_spc 
   logical                                  :: sw_corr_tm,sw_seed,sw_chem,sw_fire,sw_biog
!
   namelist /perturb_chem_emiss_corr_nml/date,nx,ny,nz,nz_chem,nchem_spcs,nfire_spcs,nbiog_spcs, &
   pert_path_pr,pert_path_po,nnum_mem,wrfchemi,wrffirechemi,wrfbiogchemi,sprd_chem,sprd_fire,sprd_biog, &
   sw_corr_tm,sw_seed,sw_chem,sw_fire,sw_biog,corr_lngth_hz,corr_lngth_vt,corr_lngth_tm,corr_tm_delt
   namelist /perturb_chem_emiss_spec_nml/ch_chem_spc,ch_fire_spc,ch_biog_spc
!
! Setup mpi
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
   zfac_chem=4.
   zfac_fire=4.
   zfac_biog=4.
   zmin=1.e-10
   fac_min=0.01
   icnt_tsk=1
   rsprd_crit=3.0
   scl_fac_chem=30.0
   scl_fac_chem=12.5
   scl_fac_fire=10.
   scl_fac_fire=8.5
   scl_fac_fire=5.5
   scl_fac_fire=4.0
   scl_fac_biog=1.
!
! Read control namelist
   unit=20
   open(unit=unit,file='perturb_chem_emiss_corr_nml.nl',form='formatted', &
   status='old',action='read')
   rewind(unit)   
   read(unit,perturb_chem_emiss_corr_nml)
   close(unit)
   if(rank.eq.0) then
      print *, 'date               ',date
      print *, 'nx                 ',nx
      print *, 'ny                 ',ny
      print *, 'nz                 ',nz
      print *, 'nz_chem            ',nz_chem
      print *, 'nchem_spcs         ',nchem_spcs
      print *, 'nfire_spcs         ',nfire_spcs
      print *, 'nbiog_spcs         ',nbiog_spcs
      print *, 'pert_path_pr       ',trim(pert_path_pr)
      print *, 'pert_path_po       ',trim(pert_path_po)
      print *, 'num_mem            ',nnum_mem
      print *, 'wrfchemi           ',trim(wrfchemi)
      print *, 'wrffirechemi       ',trim(wrffirechemi)
      print *, 'wrfbiogchemi       ',trim(wrfbiogchemi)
      print *, 'sprd_chem          ',sprd_chem
      print *, 'sprd_fire          ',sprd_fire
      print *, 'sprd_biog          ',sprd_biog
      print *, 'sw_corr_tm         ',sw_corr_tm
      print *, 'sw_seed            ',sw_seed
      print *, 'sw_chem            ',sw_chem
      print *, 'sw_fire            ',sw_fire
      print *, 'sw_biog            ',sw_biog
      print *, 'corr_lngth_hz      ',corr_lngth_hz
      print *, 'corr_lngth_vt      ',corr_lngth_vt
      print *, 'corr_lngth_tm      ',corr_lngth_tm
      print *, 'corr_tm_delt       ',corr_tm_delt
   endif
!
   nzp=nz+1
   num_mems=nint(nnum_mem)
   wgt_end=exp(-1.0*corr_tm_delt/corr_lngth_tm)
   sw_corr_tm=.false.
!
! Allocate arrays
   allocate(ch_chem_spc(nchem_spcs))
   allocate(ch_fire_spc(nfire_spcs))
   allocate(ch_biog_spc(nbiog_spcs))
!
   if(sw_chem) then   
      allocate(chem_vari_old(nx,ny,nz_chem))
      allocate(chem_vari_new(nx,ny,nz_chem))
      allocate(chem_vari_end(nx,ny,nz_chem))
      chem_vari_old(:,:,:)=0.
      chem_vari_new(:,:,:)=0.
      chem_vari_end(:,:,:)=0.
   endif
   if(sw_fire) then   
      allocate(fire_vari_old(nx,ny,nz_fire))
      allocate(fire_vari_new(nx,ny,nz_fire))
      allocate(fire_vari_end(nx,ny,nz_fire))
      fire_vari_old(:,:,:)=0.
      fire_vari_new(:,:,:)=0.
      fire_vari_end(:,:,:)=0.
   endif
   if(sw_biog) then   
      allocate(biog_vari_old(nx,ny,nz_biog))
      allocate(biog_vari_new(nx,ny,nz_biog))
      allocate(biog_vari_end(nx,ny,nz_biog))
      biog_vari_old(:,:,:)=0.
      biog_vari_new(:,:,:)=0.
      biog_vari_end(:,:,:)=0.
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
! Allocate vertical smoothing arrays
   if(sw_chem) then
      allocate(A_chem(nx,ny,nz_chem,nz_chem))
      A_chem(:,:,:,:)=0.
   else
      nchem_spcs=0
   endif
!
   if(sw_fire) then
      allocate(A_fire(nx,ny,nz_fire,nz_fire))
      A_fire(:,:,:,:)=0.
   else
      nfire_spcs=0
   endif
!
   if(sw_biog) then
      allocate(A_biog(nx,ny,nz_biog,nz_biog))
      A_biog(:,:,:,:)=0.
   else
      nbiog_spcs=0.
   endif
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
! Set ngrid_corr for different emissions types
   ngrid_corr_chem=ngrid_corr
   ngrid_corr_fire=ngrid_corr
   ngrid_corr_biog=0.
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
! Allocate processors (reserve rank 0)
   if(sw_chem) then
      allocate(itask_chem(nchem_spcs))
      do isp=1,nchem_spcs
         itask_chem(isp)=isp-1+icnt_tsk
!         if(rank.eq.0) print *, 'APM: itask_chem ',isp,itask_chem(isp)
      enddo
   endif   
   if(sw_fire) then
      allocate(itask_fire(nfire_spcs))
      do isp=1,nfire_spcs
         itask_fire(isp)=isp-1+nchem_spcs+icnt_tsk
!         if(rank.eq.0) print *, 'APM: itask_fire ',isp,itask_fire(isp)
      enddo
   endif
   if(sw_biog) then
      allocate(itask_biog(nbiog_spcs))
      do isp=1,nbiog_spcs
         itask_biog(isp)=isp-1+nfire_spcs+nchem_spcs+icnt_tsk
!         if(rank.eq.0) print *, 'APM: itask_biog ',isp,itask_biog(isp)
      enddo
   endif
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
! READ NEW EMISSIONS FIELDS AND SEND TO OTHER PROCESSORS
!      
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!
! Read and send new chemi fields from only one member (all members are initially the same)
      if(sw_chem) then
         wrfchem_file=trim(pert_path_po)//'/'//trim(wrfchemi)
         allocate(tmp_arry(nx*ny*nz_chem))
         allocate(chem_data3d(nx,ny,nz_chem))
         do isp=1,nchem_spcs
            call get_WRFCHEM_emiss_data(wrfchem_file,ch_chem_spc(isp),chem_data3d, &
            nx,ny,nz_chem)
!
! Use log transform            
            do i=1,nx
               do j=1,ny
                  do k=1,nz_chem
                     if(chem_data3d(i,j,k).gt.0.) then
                        chem_data3d(i,j,k)=log(chem_data3d(i,j,k))
                     else
                        chem_data3d(i,j,k)=0.
                     endif
                  enddo
               enddo
            enddo
            call apm_pack(tmp_arry,chem_data3d,nx,ny,nz_chem)
            call mpi_send(tmp_arry,nx*ny*nz_chem,MPI_FLOAT, &
            itask_chem(isp),1,MPI_COMM_WORLD,ierr)
         enddo
         deallocate(chem_data3d)
         deallocate(tmp_arry)
      endif
!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!
! RECEIVE NEW PERTURBATION VARIANCE FROM OTHER PROCESSORS
! READ EMISSIONS, APPLY SCALING, AND WRITE TO EMISSIONS FILE
!      
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!
      if(sw_chem) then
!
! Receive new perturbation variance, read emissions, scale emissions, and
! write emissions to archive file
!
         allocate(chem_data3d(nx,ny,nz_chem))
         allocate(chem_vari3d(nx,ny,nz_chem))
         allocate(tmp_arry(nx*ny*nz_chem))
         do isp=1,nchem_spcs
!
! Receive new ensemble error variance
            call mpi_recv(tmp_arry,nx*ny*nz_chem,MPI_FLOAT, &
            itask_chem(isp),4,MPI_COMM_WORLD,stat,ierr)
            call apm_unpack(tmp_arry,chem_vari_new,nx,ny,nz_chem)
            if(isp.eq.nchem_spcs) print *, 'APM: After receive in RANK 0 ',trim(ch_chem_spc(isp))
!
! Read field to be perturbed              
            wrfchem_file=trim(pert_path_po)//'/'//trim(wrfchemi)
            call get_WRFCHEM_emiss_data(wrfchem_file,ch_chem_spc(isp),chem_data3d, &
            nx,ny,nz_chem)
!
! Use log transform            
            do i=1,nx
               do j=1,ny
                  do k=1,nz_chem
                     if(chem_data3d(i,j,k).gt.0.) then
                        chem_data3d(i,j,k)=log(chem_data3d(i,j,k))
                     else
                        chem_data3d(i,j,k)=0.
                     endif
                  enddo
               enddo
            enddo
            if(isp.eq.nchem_spcs) print *, 'APM: After read field to perturb ',trim(ch_chem_spc(isp))
!
! Read old ensemble error variance
            if(sw_corr_tm) then            
               wrfchem_file=trim(pert_path_pr)//'/'//trim(wrfchemi_vari)
               call get_WRFCHEM_emiss_data(wrfchem_file,ch_chem_spc(isp),chem_vari3d, &
               nx,ny,nz_chem)
!
! Calculate temporally smoothed ensemble error variance            
               do i=1,nx
                  do j=1,ny
                     do k=1,nz_chem
                        chem_vari_end(i,j,k)=(1.-wgt_end)*chem_vari3d(i,j,k)+ &
                        wgt_end*chem_vari_new(i,j,k)
                     enddo
                  enddo
               enddo
            else
               do i=1,nx
                  do j=1,ny
                     do k=1,nz_chem
                        chem_vari_end(i,j,k)=chem_vari_new(i,j,k)
                     enddo
                  enddo
               enddo
            endif
            if(isp.eq.nchem_spcs) print *, 'APM: After temporal smoothing ',trim(ch_chem_spc(isp))
!
! Limit the new relative spread
!            do i=1,nx
!               do j=1,ny
!                  do k=1,nz_chem
!                     if(chem_data3d(i,j,k).gt.0.) then
!                        if(sqrt(chem_vari_end(i,j,k))/chem_data3d(i,j,k).gt.rsprd_crit) then
!                           chem_vari_end(i,j,k)=(chem_data3d(i,j,k)*rsprd_crit)**2.
!                        endif
!                     endif
!                  enddo
!               enddo
!            enddo
!
! Write new ensemble error variance
            wrfchemi_vari=trim(wrfchemi)//'_vari'            
            wrfchem_file=trim(pert_path_po)//'/'//trim(wrfchemi_vari)
            call put_WRFCHEM_emiss_data(wrfchem_file,ch_chem_spc(isp),chem_vari_end, &
            nx,ny,nz_chem)
            if(isp.eq.nchem_spcs) print *, 'APM: After write new variance ',trim(ch_chem_spc(isp))
!
! For each ensemble member generate perturbed field
            allocate(zfld(nx,ny,nz_chem))               
            allocate(chem_mem(nx,ny,nz_chem))
            sum=0.
            do imem=1,num_mems
               if(imem.ge.0.and.imem.lt.10) write(cmem,"('.e00',i1)"),imem
               if(imem.ge.10.and.imem.lt.100) write(cmem,"('.e0',i2)"),imem
               if(imem.ge.100.and.imem.lt.1000) write(cmem,"('.e',i3)"),imem
!
! Generate N(0,1) filed               
               do i=1,nx
                  do j=1,ny
                     do k=1,nz_chem
                        call random_number(u_ran_1)
                        if(u_ran_1.eq.0.) call random_number(u_ran_1)
                        call random_number(u_ran_2)
                        if(u_ran_2.eq.0.) call random_number(u_ran_2)
                        zfld(i,j,k)=sqrt(-2.*log(u_ran_1))*cos(2.*pi*u_ran_2)
                     enddo
                  enddo
               enddo
               if(isp.eq.nchem_spcs.and.imem.eq.num_mems) print *, &
               'APM: After generate N(0,1) field ',trim(ch_chem_spc(isp))
!
! Impose the temporally smoothed ensemble error variance and new ensemble mean    
               do i=1,nx
                  do j=1,ny
                     do k=1,nz_chem
                        chem_mem(i,j,k)=exp(chem_data3d(i,j,k)+zfld(i,j,k)*sqrt(chem_vari_end(i,j,k)))
                     enddo
                  enddo
               enddo
               if(isp.eq.nchem_spcs.and.imem.eq.num_mems) print *, &
               'APM: After generate new member ',trim(ch_chem_spc(isp))
!
! Write data for the perturbed member
               wrfchem_file=trim(pert_path_po)//'/'//trim(wrfchemi)//cmem
               if(isp.eq.1.and.imem.eq.1) print *,'APM OUTFILE ',trim(wrfchem_file)
               if(isp.eq.1.and.imem.eq.num_mems) print *,'APM OUTFILE ',trim(wrfchem_file)
               call put_WRFCHEM_emiss_data(wrfchem_file,ch_chem_spc(isp),chem_mem, &
               nx,ny,nz_chem)
               if(isp.eq.nchem_spcs.and.imem.eq.num_mems) print *, &
               'APM: After write new member ',trim(ch_chem_spc(isp))
!
! Check means and relative spread
               sum=sum+chem_mem(nx/2,ny/2,1)/real(num_mems)
            enddo
! non-log form            
!            print *,'APM: ',trim(ch_chem_spc(isp)),sum,chem_data3d(nx/2,ny/2,1), &
!            sqrt(chem_vari_end(nx/2,ny/2,1))/chem_data3d(nx/2,ny/2,1)*100.,'%'
! log form
            print *,'APM: ',trim(ch_chem_spc(isp)),sum,exp(chem_data3d(nx/2,ny/2,1))
!
            deallocate(zfld)
            deallocate(chem_mem)
         enddo
         deallocate(tmp_arry)
         deallocate(chem_vari3d)
         deallocate(chem_data3d)
      endif
   endif
!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!
! RANK itask(imem,isp)   RANK itask(imem,isp)   RANK itask(imem,isp)
!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!
   if(rank.ne.0) then
      if(sw_chem) then
         do isp=1,nchem_spcs
            if(rank.eq.itask_chem(isp)) then
               chem_vari_new(:,:,:)=0.
!
! Receive new chemi fields
               allocate(tmp_arry(nx*ny*nz_chem))
               call mpi_recv(tmp_arry,nx*ny*nz_chem, &
               MPI_FLOAT,0,1,MPI_COMM_WORLD,stat,ierr)
               call apm_unpack(tmp_arry,chem_vari_new,nx,ny,nz_chem)
               deallocate(tmp_arry)
!
! Calculate new error variance
!
!               call date_and_time(ch_date,ch_time,ch_zone,date_time_vals)
!               seed_trm=date_time_vals(5)*date_time_vals(6)*date_time_vals(7)
!               if(sw_seed) call init_const_random_seed(rank,seed_trm)
!
               if(isp.eq.nchem_spcs) print *, 'APM: Before call to perturb_fields ', &
               trim(ch_chem_spc(isp))               
               call perturb_fields(chem_vari_new,lat,lon,A_chem,nx,ny,nz_chem, &
               ngrid_corr_chem,corr_lngth_hz,rank,sprd_chem,itask_chem,nchem_spcs)
               if(isp.eq.nchem_spcs) print *, 'APM: After call to perturb_fields ', &
               trim(ch_chem_spc(isp))               
            endif
         enddo
!
         do isp=1,nchem_spcs
            if(rank.eq.itask_chem(isp)) then
! 
! Send new perturbation variance to rank 0
               allocate(tmp_arry(nx*ny*nz_chem))
               call apm_pack(tmp_arry,chem_vari_new,nx,ny,nz_chem)
               call mpi_send(tmp_arry,nx*ny*nz_chem,MPI_FLOAT, &
               0,4,MPI_COMM_WORLD,ierr)
               deallocate(tmp_arry)
            endif
         enddo
      endif
   endif
!
   if(sw_chem) then   
      deallocate(chem_vari_old)
      deallocate(chem_vari_new)
      deallocate(chem_vari_end)
      deallocate(A_chem)
      deallocate(itask_chem)
   endif
   if(sw_fire) then   
      deallocate(fire_vari_old)
      deallocate(fire_vari_new)
      deallocate(fire_vari_end)
      deallocate(A_fire)
      deallocate(itask_fire)
   endif
   if(sw_biog) then   
      deallocate(biog_vari_old)
      deallocate(biog_vari_new)
      deallocate(biog_vari_end)
      deallocate(A_biog)
      deallocate(itask_biog)
   endif
   deallocate(lat,lon)
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
               if(geo_ht(i,j,k).lt.0. .or. geo_ht(i,j,l).lt.0.) vcov=0.
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
end subroutine vertical_transform

!-------------------------------------------------------------------------------

subroutine perturb_fields(chem_vari_new,lat,lon,A_chem,nx,ny,nz, &
ngrid_corr,corr_lngth_hz,rank,sprd_chem,itask,nspc)
!   use apm_utilities_mod,  only :get_dist
  
   implicit none
   integer,                               intent(in)     :: nx,ny,nz,rank,nspc
   integer,                               intent(in)     :: ngrid_corr
   integer,dimension(nspc),               intent(in)     :: itask
   real,                                  intent(in)     :: corr_lngth_hz,sprd_chem
   real,dimension(nx,ny),                 intent(in)     :: lat,lon
   real,dimension(nx,ny,nz,nz),           intent(in)     :: A_chem
   real,dimension(nx,ny,nz),              intent(inout)  :: chem_vari_new
!
   integer                             :: i,j,k,ii,jj,kk
   integer                             :: ii_str,ii_end,jj_str,jj_end,icnt,ncnt
   real                                :: pi,get_dist,wgt
   real                                :: u_ran_1,u_ran_2,zdist
   real,allocatable,dimension(:)       :: fld_sum,wgt_sum
   real,allocatable,dimension(:,:,:)   :: pert_chem_new
   real,allocatable,dimension(:,:,:)   :: chem_vari_new_smth
!
! Constants
   pi=4.*atan(1.)
!
! Define perturbation variance
   allocate(pert_chem_new(nx,ny,nz))
   pert_chem_new(:,:,:)=0.
   do i=1,nx
      do j=1,ny
         do k=1,nz
            call random_number(u_ran_1)
            if(u_ran_1.eq.0.) call random_number(u_ran_1)
            call random_number(u_ran_2)
            if(u_ran_2.eq.0.) call random_number(u_ran_2)
! white noise stdv
            pert_chem_new(i,j,k)=(chem_vari_new(i,j,k)*sprd_chem*sqrt(-2.*log(u_ran_1))*cos(2.*pi*u_ran_2))**2.
! constant stdv
!            pert_chem_new(i,j,k)=(chem_vari_new(i,j,k))**2.
         enddo
      enddo
   enddo
!
! Apply horizontal correlations
   allocate(fld_sum(nz))   
   allocate(wgt_sum(nz))
!
   chem_vari_new(:,:,:)=0.
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
            if(wgt_sum(k).gt.0.) then
               chem_vari_new(i,j,k)=fld_sum(k)/wgt_sum(k)
            else
               chem_vari_new(i,j,k)=pert_chem_new(i,j,k)
            endif
         enddo
      enddo
   enddo
!
! Apply vertical correlations
!
   allocate(chem_vari_new_smth(nx,ny,nz))
   chem_vari_new_smth(:,:,:)=0.
   do i=1,nx
      do j=1,ny
         fld_sum(:)=0.
         wgt_sum(:)=0.
         do k=1,nz
            do kk=1,nz
               fld_sum(k)=fld_sum(k)+A_chem(i,j,k,kk)*chem_vari_new(i,j,kk)
               wgt_sum(k)=wgt_sum(k)+A_chem(i,j,k,kk)
            enddo
         enddo
         do k=1,nz
            if(wgt_sum(k).gt.0.) then
               chem_vari_new_smth(i,j,k)=fld_sum(k)/wgt_sum(k)
            else              
               chem_vari_new_smth(i,j,k)=chem_vari_new(i,j,k)
            endif
         enddo
      enddo
   enddo
   chem_vari_new(:,:,:)=chem_vari_new_smth(:,:,:)
   deallocate(chem_vari_new_smth)
   deallocate(fld_sum)
   deallocate(wgt_sum)
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
   file='wrfinput_d01.template'
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
   file='wrfinput_d01.template'
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

!-------------------------------------------------------------------------------
 
subroutine limit_emiss_maxnmin(fld,nx,ny,nz,nt,zfac)
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
end subroutine limit_emiss_maxnmin
