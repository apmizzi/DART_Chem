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
!
! Calculate number of horizontal grid points to be correlated 
   ngrid_corr=ceiling(zfac*corr_lngth_hz/grid_length)+1

   call cpu_time(cpu_str)
   if(rank.eq.0) print *, 'APM: Before vertical transform: time str ', cpu_str
!
! Construct the vertical weights
   call vertical_transform(A_chem,geo_ht,nx,ny,nz,nz,corr_lngth_vt)
   deallocate(geo_ht)

   call cpu_time(cpu_end)
   cpu_dif=cpu_end-cpu_str
   if(rank.eq.0) print *, 'APM: After vertical transform: time dif', cpu_dif
!
! Allocate processors (reserve tasks 0 and 1)
   allocate(itask(num_mems,nchem_spcs))
   ntasks=num_mems*nchem_spcs
   do imem=1,num_mems
      do isp=1,nchem_spcs
         itask(imem,isp)=mod(((imem-1)*nchem_spcs+isp-1),num_procs-icnt_tsk)+icnt_tsk
      enddo
   enddo
!
! Read old scaling factors if they exist      
   if(rank.eq.0) then
      if(.not.sw_corr_tm) then
         unita=30
         filenm=trim(pert_path_old)//'/pert_chem_icbc'
         open(unit=unita,file=trim(filenm), &
         form='unformatted',status='unknown')
         rewind(unita)
         do imem=1,num_mems
            do isp=1,nchem_spcs
               allocate(chem_fac_old(nx,ny,nz))
               allocate(tmp_arry(nx*ny*nz))
               unita=30
               read(unita) chem_fac_old
               call apm_pack_3d(tmp_arry,chem_fac_old,nx,ny,nz)
               call mpi_send(tmp_arry,nx*ny*nz,MPI_FLOAT, &
               itask(imem,isp),1,MPI_COMM_WORLD,ierr)
               deallocate(chem_fac_old)
               deallocate(tmp_arry)
            enddo
         enddo
         close(unita)
      endif
!      
      call mpi_recv(flg,1,MPI_FLOAT,1,3,MPI_COMM_WORLD,stat,ierr)
!
      unita=30
      filenm=trim(pert_path_new)//'/pert_chem_icbc'
      open(unit=unita,file=trim(filenm),form='unformatted',status='unknown')
      rewind(unita)
      do imem=1,num_mems
         if(imem.ge.0.and.imem.lt.10) write(cmem,"('.e00',i1)"),imem
         if(imem.ge.10.and.imem.lt.100) write(cmem,"('.e0',i2)"),imem
         if(imem.ge.100.and.imem.lt.1000) write(cmem,"('.e',i3)"),imem
         wrfchem_file_ic=trim(wrfinput_fld_new)//trim(cmem)
         wrfchem_file_bc=trim(wrfbdy_fld_new)//trim(cmem)
         do isp=1,nchem_spcs
            allocate(chem_fac_end(nx,ny,nz))
            allocate(tmp_arry(nx*ny*nz))
            read(unita) chem_fac_end
            call apm_pack_3d(tmp_arry,chem_fac_end,nx,ny,nz)
            call mpi_send(tmp_arry,nx*ny*nz,MPI_FLOAT, &
            itask(imem,isp),1,MPI_COMM_WORLD,ierr)
            deallocate(chem_fac_end)
            deallocate(tmp_arry)
!
            allocate(chem_data3d(nx,ny,nz,1))
            allocate(tmp_arry(nx*ny*nz))
            call get_WRFCHEM_icbc_data(wrfchem_file_ic,ch_chem_spc(isp), &
            chem_data3d,nx,ny,nz,1)
            call apm_pack_4d(tmp_arry,chem_data3d,nx,ny,nz,1)
            call mpi_send(tmp_arry,nx*ny*nz,MPI_FLOAT, &               
            itask(imem,isp),2,MPI_COMM_WORLD,ierr)
            deallocate(chem_data3d)     
            deallocate(tmp_arry)
!
            do ibdy=1,nbdy_exts
               allocate(chem_databdy(bdy_dims(ibdy),nz,nhalo,nt))
               allocate(tmp_arry(bdy_dims(ibdy)*nz*nhalo*nt)) 
               ch_spcs=trim(ch_chem_spc(isp))//trim(bdy_exts(ibdy))
               call get_WRFCHEM_icbc_data(wrfchem_file_bc,ch_spcs, &
               chem_databdy,bdy_dims(ibdy),nz,nhalo,nt)
               call apm_pack_4d(tmp_arry,chem_databdy,bdy_dims(ibdy),nz,nhalo,nt)
               call mpi_send(tmp_arry,bdy_dims(ibdy)*nz*nhalo*nt,MPI_FLOAT, &               
               itask(imem,isp),ibdy+2,MPI_COMM_WORLD,ierr)
               deallocate(chem_databdy)
               deallocate(tmp_arry)
            enddo
         enddo
      enddo
      close(unita)
   endif
!
! Loop through member and species. Assign one member/species to each processor
! Note: the perturb_fields step is very slow; need to have at least (num_mems * nchem_spcs) + 2
! processors   
   if(rank.ne.0 .and. rank.ne.1) then   
      allocate(chem_fac_old(nx,ny,nz))
      allocate(chem_fac_new(nx,ny,nz))
      allocate(chem_fac_end(nx,ny,nz))
      allocate(chem_data3d(nx,ny,nz,1))
      do imem=1,num_mems
         do isp=1,nchem_spcs
            if(rank.eq.itask(imem,isp)) then
               if (rank.eq.3) then
                  call cpu_time(cpu_str)
                 print *, 'APM: Before pert_flds rank,imem,isp ',rank,imem,isp,cpu_str
               endif
               if(.not.sw_corr_tm) then
                  allocate(tmp_arry(nx*ny*nz))
                  call mpi_recv(tmp_arry,nx*ny*nz,MPI_FLOAT, &
                  0,1,MPI_COMM_WORLD,stat,ierr)
                  call apm_unpack_3d(tmp_arry,chem_fac_old,nx,ny,nz)
                  deallocate(tmp_arry)
               endif
               if(sw_seed) call init_const_random_seed(rank,date)
               call perturb_fields(chem_fac_old,chem_fac_new, &
               lat,lon,A_chem,nx,ny,nz,nchem_spcs,ngrid_corr,sw_corr_tm, &
               corr_lngth_hz,rank)
!
! Impose temporal correlations
               wgt_bc_str=exp(-0.0*corr_tm_delt/corr_lngth_tm)
               wgt_bc_mid=exp(-0.5*corr_tm_delt/corr_lngth_tm)
               wgt_bc_end=exp(-1.0*corr_tm_delt/corr_lngth_tm)
               chem_fac_end(:,:,:)=wgt_bc_end*chem_fac_old(:,:,:)+(1.-wgt_bc_end)* &
               chem_fac_new(:,:,:)
!
! Send chem_fac_end to rank 1 for writing to archive file            
               allocate(tmp_arry(nx*ny*nz))
               call apm_pack_3d(tmp_arry,chem_fac_end,nx,ny,nz)
               call mpi_send(tmp_arry,nx*ny*nz,MPI_FLOAT, &
               1,21,MPI_COMM_WORLD,ierr)
               deallocate(tmp_arry)
               if (rank.eq.3) then
                  call cpu_time(cpu_end)
                  cpu_dif=cpu_end-cpu_str
                  print *, 'APM: After pert_flds rank,imem,isp ',rank,imem,isp,cpu_end,cpu_dif
               endif
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
               if (rank.eq.3) then
                  call cpu_time(cpu_str)
                  print *, 'APM: Before smoothing rank,imem,isp ',rank,imem,isp,cpu_str
               endif
               allocate(tmp_arry(nx*ny*nz))
               call mpi_recv(tmp_arry,nx*ny*nz,MPI_FLOAT, &
               0,1,MPI_COMM_WORLD,stat,ierr)
               call apm_unpack_3d(tmp_arry,chem_fac_end,nx,ny,nz)
               deallocate(tmp_arry)
!
               allocate(tmp_arry(nx*ny*nz))
               call mpi_recv(tmp_arry,nx*ny*nz, &
               MPI_FLOAT,0,2,MPI_COMM_WORLD,stat,ierr)
               call apm_unpack_4d(tmp_arry,chem_data3d,nx,ny,nz,1)
               deallocate(tmp_arry)
! ICs
               do i=1,nx
                  do j=1,ny
                     do k=1,nz
                        if(chem_data3d(i,j,k,1)*(1.+chem_fac_end(i,j,k)) .le. 0.) then
                           chem_data3d(i,j,k,1)=fac_min*chem_data3d(i,j,k,1)
                        else
                           chem_data3d(i,j,k,1)=chem_data3d(i,j,k,1)*(1.+chem_fac_end(i,j,k))
                        endif
                     enddo
                  enddo
               enddo
!                                                                                                       
               allocate(tmp_arry(nx*ny*nz))
               call apm_pack_4d(tmp_arry,chem_data3d,nx,ny,nz,1)
               call mpi_send(tmp_arry,nx*ny*nz,MPI_FLOAT, &
               1,22,MPI_COMM_WORLD,ierr)
               deallocate(tmp_arry)              
! BCs              
               do ibdy=1,nbdy_exts
                  if(ibdy.eq.1) allocate(chem_data_sav_1(bdy_dims(ibdy),nz,nhalo,nt,2))
                  if(ibdy.eq.3) allocate(chem_data_sav_2(bdy_dims(ibdy),nz,nhalo,nt,2))
                  allocate(chem_databdy(bdy_dims(ibdy),nz,nhalo,nt))
                  allocate(tmp_arry(bdy_dims(ibdy)*nz*nhalo*nt))
                  call mpi_recv(tmp_arry,bdy_dims(ibdy)*nz*nhalo*nt, &
                  MPI_FLOAT,0,ibdy+2,MPI_COMM_WORLD,stat,ierr)
                  call apm_unpack_4d(tmp_arry,chem_databdy,bdy_dims(ibdy),nz,nhalo,nt)
                  deallocate(tmp_arry)
!
                  if(ibdy.eq.1.or.ibdy.eq.2.or.ibdy.eq.5.or.ibdy.eq.6) then 
! non-tendency terms
                     if(ibdy.eq.1.or.ibdy.eq.2) then
                        chem_data_sav_1(:,:,:,:,ibdy)=chem_databdy(:,:,:,:)
                        i=1
                        if(ibdy/2*2.eq.ibdy) i=nx 
                        do h=1,nhalo
                           do k=1,nz
                              do j=1,bdy_dims(ibdy)
                                 chem_fac_mid=wgt_bc_mid*chem_fac_old(i,j,k)+ &
                                 (1.-wgt_bc_mid)* chem_fac_end(i,j,k)
                                 if(chem_databdy(j,k,h,1)*(1.+chem_fac_end(i,j,k)) &
                                 .le. 0.) then
                                    chem_databdy(j,k,h,1)=fac_min*chem_databdy(j,k,h,1)
                                 else
                                    chem_databdy(j,k,h,1)=chem_databdy(j,k,h,1)*(1.+ &
                                    chem_fac_end(i,j,k))
                                 endif
                                 if(chem_databdy(j,k,h,2)*(1.+chem_fac_mid) .le. 0) then
                                    chem_databdy(j,k,h,2)=fac_min*chem_databdy(j,k,h,2)
                                 else
                                    chem_databdy(j,k,h,2)=chem_databdy(j,k,h,2)*(1.+chem_fac_mid)
                                 endif
                              enddo
                           enddo
                        enddo
                     else
! Tendency terms need to account for a temporal change in the perturbation
! Form: d(Af)/dt = dA/dt*f + A*df/dt; chem_databdy is dA/dt; chem_data_sav_1 is A
                        allocate(chem_data_end(bdy_dims(ibdy),nz,nhalo))
                        chem_data_end(:,:,:)=chem_databdy(:,:,:,2)*corr_tm_delt/2.*tfac+ &
                        chem_data_sav_1(:,:,:,2,ibdy-4)
                        i=1
                        if(ibdy/2*2.eq.ibdy) i=nx
                        do h=1,nhalo
                           do k=1,nz
                              do j=1,bdy_dims(ibdy)
                                 chem_fac_mid=wgt_bc_mid*chem_fac_old(i,j,k)+ &
                                 (1.-wgt_bc_mid)*chem_fac_end(i,j,k)
!             
                                 chem_databdy(j,k,h,1)=chem_databdy(j,k,h,1)* &
                                 (1.+(chem_fac_old(i,j,k)+chem_fac_mid)/2.) + &
                                 (chem_data_sav_1(j,k,h,1,ibdy-4)+ &
                                 chem_data_sav_1(j,k,h,2,ibdy-4))/2. * (chem_fac_mid- &
                                 chem_fac_old(i,j,k))/(corr_tm_delt/2.)/tfac
!             
                                 chem_databdy(j,k,h,2)=chem_databdy(j,k,h,2)* &
                                 (1.+(chem_fac_mid+chem_fac_end(i,j,k))/2.) + &
                                 (chem_data_sav_1(j,k,h,2,ibdy-4)+ &
                                 chem_data_end(j,k,h))/2. * (chem_fac_end(i,j,k)- &
                                 chem_fac_mid)/(corr_tm_delt/2.)/tfac
                              enddo
                           enddo
                        enddo
                        deallocate(chem_data_end)
                     endif
                  else if(ibdy.eq.3.or.ibdy.eq.4.or.ibdy.eq.7.or.ibdy.eq.8) then
! non-tendency terms
                     if(ibdy.eq.3.or.ibdy.eq.4) then
                        chem_data_sav_2(:,:,:,:,ibdy-2)=chem_databdy(:,:,:,:)
                        j=1  
                        if(ibdy/2*2.eq.ibdy) j=ny
                        do h=1,nhalo
                           do k=1,nz
                              do i=1,bdy_dims(ibdy)
                                 chem_fac_mid=wgt_bc_mid*chem_fac_old(i,j,k)+(1.- &
                                 wgt_bc_mid)*chem_fac_end(i,j,k)
                                 if(chem_databdy(i,k,h,1)*(1.+chem_fac_old(i,j,k)) &
                                 .le.0.) then
                                    chem_databdy(i,k,h,1)=fac_min*chem_databdy(i,k,h,1)
                                 else
                                    chem_databdy(i,k,h,1)=chem_databdy(i,k,h,1)*(1.+ &
                                    chem_fac_old(i,j,k))
                                 endif
                                 if(chem_databdy(i,k,h,2)*(1.+chem_fac_mid).le.0.) then
                                    chem_databdy(i,k,h,2)=fac_min*chem_databdy(i,k,h,2)
                                 else
                                    chem_databdy(i,k,h,2)=chem_databdy(i,k,h,2)*(1.+chem_fac_mid)
                                 endif
                              enddo
                           enddo
                        enddo
                     else
! Tendency terms need to account for a temporal change in the perturbation
! Form: d(Af)/dt = dA/dt*f + A*df/dt; chem_databdy is dA/dt; chem_data_sav_2 is A
                        allocate(chem_data_end(bdy_dims(ibdy),nz,nhalo))
                        chem_data_end(:,:,:)=chem_databdy(:,:,:,2)*(corr_tm_delt/2.)*tfac+ &
                        chem_data_sav_2(:,:,:,2,ibdy-6)
                        j=1  
                        if(ibdy/2*2.eq.ibdy) j=ny
                        do h=1,nhalo
                           do k=1,nz
                              do i=1,bdy_dims(ibdy)
                                 chem_fac_mid=wgt_bc_mid*chem_fac_old(i,j,k)+ &
                                 (1.-wgt_bc_mid)*chem_fac_end(i,j,k)
!                       
                                 chem_databdy(j,k,h,1)=chem_databdy(i,k,h,1)* &
                                 (1.+(chem_fac_old(i,j,k)+chem_fac_mid)/2.) + &
                                 (chem_data_sav_2(i,k,h,1,ibdy-6)+ &
                                 chem_data_sav_2(i,k,h,2,ibdy-6))/2. * (chem_fac_mid- &
                                 chem_fac_old(i,j,k))/(corr_tm_delt/2.)/tfac
!                       
                                 chem_databdy(j,k,h,2)=chem_databdy(i,k,h,2)* &
                                 (1.+(chem_fac_mid+chem_fac_end(i,j,k))/2.) + &
                                 (chem_data_sav_2(i,k,h,2,ibdy-6)+chem_data_end(i,k,h))/2. * &
                                 (chem_fac_end(i,j,k)-chem_fac_mid)/(corr_tm_delt/2.)/tfac
                              enddo
                           enddo
                        enddo
                        deallocate(chem_data_end)
                     endif
                  endif
!
                  allocate(tmp_arry(bdy_dims(ibdy)*nz*nhalo*nt))
                  call apm_pack_4d(tmp_arry,chem_databdy,bdy_dims(ibdy),nz,nhalo,nt)
                  call mpi_send(tmp_arry,bdy_dims(ibdy)*nz*nhalo*nt,MPI_FLOAT, &
                  1,ibdy+22,MPI_COMM_WORLD,ierr)
                  deallocate(tmp_arry)
                  deallocate(chem_databdy)
               enddo
               deallocate(chem_data_sav_1)
               deallocate(chem_data_sav_2)
               if (rank.eq.3) then
                  call cpu_time(cpu_end)
                  cpu_dif=cpu_end-cpu_str
                  print *, 'APM: After smoothing rank,imem,isp ',rank,imem,isp,cpu_end,cpu_dif
               endif
            endif
         enddo
      enddo
      deallocate(chem_fac_old)
      deallocate(chem_fac_new)
      deallocate(chem_fac_end)
      deallocate(chem_data3d)
   endif   
!
! Save the correlation factors for next cycle
   if (rank.eq.1) then
      call cpu_time(cpu_str)
      print *, 'APM: Before final writes ',rank,imem,isp,cpu_str
      unitb=40
      filenm=trim(pert_path_new)//'/pert_chem_icbc'
      open(unit=unitb,file=trim(filenm),form='unformatted',status='unknown')
      rewind(unitb)
      allocate(chem_fac_end(nx,ny,nz))
      do imem=1,num_mems
         do isp=1,nchem_spcs
            allocate(tmp_arry(nx*ny*nz))
            call mpi_recv(tmp_arry,nx*ny*nz,MPI_FLOAT, &
            itask(imem,isp),21,MPI_COMM_WORLD,stat,ierr)
            call apm_unpack_3d(tmp_arry,chem_fac_end,nx,ny,nz)
            write(unitb) chem_fac_end
            deallocate(tmp_arry)
         enddo
      enddo
      deallocate(chem_fac_end)
      close(unitb)
!
      call mpi_send(1.,1,MPI_FLOAT,0,3,MPI_COMM_WORLD,ierr)
!
      allocate(chem_data3d(nx,ny,nz,1))
      do imem=1,num_mems
         if(imem.ge.0.and.imem.lt.10) write(cmem,"('.e00',i1)"),imem
         if(imem.ge.10.and.imem.lt.100) write(cmem,"('.e0',i2)"),imem
         if(imem.ge.100.and.imem.lt.1000) write(cmem,"('.e',i3)"),imem
         wrfchem_file_ic=trim(wrfinput_fld_new)//trim(cmem)
         wrfchem_file_bc=trim(wrfbdy_fld_new)//trim(cmem)
         do isp=1,nchem_spcs
            allocate(tmp_arry(nx*ny*nz))            
! ICs
            call mpi_recv(tmp_arry,nx*ny*nz,MPI_FLOAT, &
            itask(imem,isp),22,MPI_COMM_WORLD,stat,ierr)
            call apm_unpack_4d(tmp_arry,chem_data3d,nx,ny,nz,1)
            call put_WRFCHEM_icbc_data(wrfchem_file_ic,ch_chem_spc(isp), &
            chem_data3d,nx,ny,nz,1)
            deallocate(tmp_arry)
! BCs
            do ibdy=1,nbdy_exts
               ch_spcs=trim(ch_chem_spc(isp))//trim(bdy_exts(ibdy))
               allocate(chem_databdy(bdy_dims(ibdy),nz,nhalo,nt))
               allocate(tmp_arry(bdy_dims(ibdy)*nz*nhalo*nt))
               call mpi_recv(tmp_arry,bdy_dims(ibdy)*nz*nhalo*nt,MPI_FLOAT, &
               itask(imem,isp),ibdy+22,MPI_COMM_WORLD,stat,ierr)
               call apm_unpack_4d(tmp_arry,chem_databdy,bdy_dims(ibdy),nz,nhalo,nt)
               call put_WRFCHEM_icbc_data(wrfchem_file_bc,ch_spcs, &
               chem_databdy,bdy_dims(ibdy),nz,nhalo,nt)
               deallocate(chem_databdy)
               deallocate(tmp_arry)
            enddo
         enddo
      enddo
      deallocate(chem_data3d)
      close(unitb)
      call cpu_time(cpu_end)
      cpu_dif=cpu_end-cpu_str
      print *, 'APM: After final writes ',rank,imem,isp,cpu_end,cpu_dif
   endif
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
   integer                             :: ierr
   integer,allocatable,dimension(:)    :: indx,jndx
   real                                :: pi,get_dist,wgt_sum
   real                                :: u_ran_1,u_ran_2,zdist
   real,allocatable,dimension(:)       :: pert_chem_sum_old,pert_chem_sum_new,wgt
   real,allocatable,dimension(:,:,:)   :: pert_chem_old,pert_chem_new
   real                                :: cpu_str,cpu_end,cpu_dif
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
!   
   if(sw_corr_tm) then
!
! chem_fac_old calc takes one hour for each member/species for TRACER-I
      if(rank.eq.3) then
         call cpu_time(cpu_str)
         print *, 'APM: Before chem_fac_old ', cpu_str
      endif
      do i=1,nx
         do j=1,ny
            indx(:)=0
            jndx(:)=0
            call horiz_grid_wts(i,j,indx,jndx,ncnt,wgt,wgt_sum,lon,lat,nx,ny,nxy, &
            ngrid_corr,corr_lngth_hz,rank)
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
         enddo
      enddo
      if(rank.eq.3) then
         call cpu_time(cpu_end)
         cpu_dif=cpu_end-cpu_str
         print *, 'APM: After chem_fac_old ', cpu_end, cpu_dif
      endif
   endif
!
! chem_fac_new calc takes one hour for each member/species for TRACER-I
   if(rank.eq.3) then
      call cpu_time(cpu_str)
      print *, 'APM: Before chem_fac_new ', cpu_str
   endif
   do i=1,nx
      do j=1,ny
         indx(:)=0
         jndx(:)=0
         call horiz_grid_wts(i,j,indx,jndx,ncnt,wgt,wgt_sum,lon,lat,nx,ny,nxy, &
         ngrid_corr,corr_lngth_hz,rank)
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
   if(rank.eq.3) then
      call cpu_time(cpu_end)
      cpu_dif=cpu_end-cpu_str
      print *, 'APM: After chem_fac_new ', cpu_end, cpu_dif
   endif
!
! Apply vertical correlations
! takes 30 sec for chem_fac_old   
   if(sw_corr_tm) then
      if(rank.eq.3) then
         call cpu_time(cpu_str)
         print *, 'APM: Before chem_fac_old vert_corr calc ', cpu_str
      endif
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
      if(rank.eq.3) then
         call cpu_time(cpu_end)
         cpu_dif=cpu_end-cpu_str
         print *, 'APM: After chem_fac_old vert_corr calc ', cpu_end, cpu_dif
      endif
   endif
!
! takes 30 sec for chem_fac_new
   if(rank.eq.3) then
      call cpu_time(cpu_str)
      print *, 'APM: Before chem_fac_new vert_corr calc ', cpu_str
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
   if(rank.eq.3) then
      call cpu_time(cpu_end)
      cpu_dif=cpu_end-cpu_str
      print *, 'APM: After chem_fac_new vert_corr calc ', cpu_end, cpu_dif
   endif
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
