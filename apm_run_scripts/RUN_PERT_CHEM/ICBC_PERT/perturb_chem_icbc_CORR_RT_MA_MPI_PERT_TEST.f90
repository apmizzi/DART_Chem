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
   integer                                     :: nt,icnt_task,unit,date,nx,ny,nz,nxy,nxyz,nzp,nchem_spcs
   integer                                     :: num_mems,status,ngrid_corr
   integer                                     :: h,i,ii,j,jj,k,kk,l,isp,imem,ibdy,bdy_idx
   integer                                     :: ifile,icnt,ncnt,ntasks,icnt_tsk,seed_trm
   integer,dimension(8)                        :: date_time_vals
   integer,dimension(MPI_STATUS_SIZE)          :: stat
   integer,dimension(nbdy_exts)                :: bdy_dims
   integer,allocatable,dimension(:,:)          :: itask
!
   real                                        :: pi,grav,zfac,tfac
   real                                        :: nnum_mems,sprd_chem
   real                                        :: corr_lngth_hz,corr_lngth_vt,corr_lngth_tm
   real                                        :: corr_tm_delt,grid_length
   real                                        :: wgt_bc_str,wgt_bc_mid,wgt_bc_end
   real                                        :: get_dist
   real,allocatable,dimension(:,:)             :: lat,lon
   real,allocatable,dimension(:,:,:)           :: geo_ht,chem_data_end
   real,allocatable,dimension(:,:,:,:)         :: A_chem
   real,allocatable,dimension(:,:,:,:)         :: chem_data3d_old,chem_data3d_new,chem_data3d_smth
   real,allocatable,dimension(:,:,:,:)         :: chem_databdy_old,chem_databdy_new,chem_databdy_smth
   real,allocatable,dimension(:)               :: tmp_arry,wgt
!
   character(len=20)                           :: cmem
   character(len=100)                          :: ch_date,ch_time,ch_zone
   character(len=300)                          :: ch_spcs
   character(len=300)                          :: wrfinput_path_old,wrfinput_path_new
   character(len=300)                          :: wrfbdy_path_old,wrfbdy_path_new
   character(len=300)                          :: wrfinput_file_old,wrfinput_file_new
   character(len=300)                          :: wrfbdy_file_old,wrfbdy_file_new
   character(len=300)                          :: file_old,file_new,file_new_3d,file_new_bdy
   character(len=300),allocatable,dimension(:) :: ch_chem_spc
!
   logical                                     :: sw_corr_tm,sw_seed
!
   namelist /perturb_chem_icbc_corr_nml/date,nx,ny,nz,nchem_spcs, &
   wrfinput_path_old,wrfinput_path_new,wrfbdy_path_old,wrfbdy_path_new,wrfinput_file_old, &
   wrfinput_file_new,wrfbdy_file_old,wrfbdy_file_new,nnum_mems,sprd_chem,corr_lngth_hz, &
   corr_lngth_vt,corr_lngth_tm,corr_tm_delt,sw_corr_tm,sw_seed
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
   icnt_tsk=1
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
      print *, 'wrfinput_path_old  ',trim(wrfinput_path_old)
      print *, 'wrfinput_path_new  ',trim(wrfinput_path_new)
      print *, 'wrfbdy_path_old    ',trim(wrfbdy_path_old)
      print *, 'wrfbdy_path_new    ',trim(wrfbdy_path_new)
      print *, 'wrfinput_file_old  ',trim(wrfinput_file_old)
      print *, 'wrfinput_file_new  ',trim(wrfinput_file_new)
      print *, 'wrfbdy_file_old    ',trim(wrfbdy_file_old)
      print *, 'wrfbdy_file_new    ',trim(wrfbdy_file_new)
      print *, 'num_mems           ',nnum_mems
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
!
! Construct the vertical weights
   call vertical_transform(A_chem,geo_ht,nx,ny,nz,nz,corr_lngth_vt)
   deallocate(geo_ht)
!   if(rank.eq.0) then
!      do k=1,nz
!         print *,'A_chem level ',k,' : ',(A_chem(nx/2,ny/2,k,kk),kk=1,nz)
!      enddo
!   endif
!
! Allocate processors (reserve task 0)
   allocate(itask(num_mems,nchem_spcs))
   ntasks=num_mems*nchem_spcs
   do imem=1,num_mems
      do isp=1,nchem_spcs
         itask(imem,isp)=mod(((imem-1)*nchem_spcs+isp-1),num_procs-icnt_tsk)+icnt_tsk
      enddo
   enddo
!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!
! Rank: 0
!   
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!
   if(rank.eq.0) then
!
! Process ICs      
      do imem=1,num_mems
         if(imem.ge.0.and.imem.lt.10) write(cmem,"('.e00',i1)"),imem
         if(imem.ge.10.and.imem.lt.100) write(cmem,"('.e0',i2)"),imem
         if(imem.ge.100.and.imem.lt.1000) write(cmem,"('.e',i3)"),imem
         file_old=trim(wrfinput_path_old)//'/'//trim(wrfinput_file_old)//trim(cmem)
         file_new=trim(wrfinput_path_new)//'/'//trim(wrfinput_file_new)//trim(cmem)
         file_new_3d=trim(wrfinput_path_new)//'/'//trim(wrfinput_file_new)//trim(cmem)
         file_new_bdy=trim(wrfbdy_path_new)//'/'//trim(wrfbdy_file_new)//trim(cmem)
         do isp=1,nchem_spcs
!
! Read and send old ICs
            if(sw_corr_tm) then
               allocate(chem_data3d_old(nx,ny,nz,1))
               allocate(tmp_arry(nx*ny*nz))
               call get_WRFCHEM_icbc_data(file_old,ch_chem_spc(isp), &
               chem_data3d_old,nx,ny,nz,1)
               call apm_pack_4d(tmp_arry,chem_data3d_old,nx,ny,nz,1)
               call mpi_send(tmp_arry,nx*ny*nz,MPI_FLOAT, &
               itask(imem,isp),1,MPI_COMM_WORLD,ierr)
               deallocate(chem_data3d_old)
               deallocate(tmp_arry)
            endif
!
! Read and send new ICs
            allocate(chem_data3d_new(nx,ny,nz,1))
            allocate(tmp_arry(nx*ny*nz))
            call get_WRFCHEM_icbc_data(file_new,ch_chem_spc(isp), &
            chem_data3d_new,nx,ny,nz,1)
            call apm_pack_4d(tmp_arry,chem_data3d_new,nx,ny,nz,1)
            call mpi_send(tmp_arry,nx*ny*nz,MPI_FLOAT, &               
            itask(imem,isp),2,MPI_COMM_WORLD,ierr)
            deallocate(chem_data3d_new)     
            deallocate(tmp_arry)
         enddo
      enddo
!
! Receive and write smoothed new ICs
      do imem=1,num_mems
         if(imem.ge.0.and.imem.lt.10) write(cmem,"('.e00',i1)"),imem
         if(imem.ge.10.and.imem.lt.100) write(cmem,"('.e0',i2)"),imem
         if(imem.ge.100.and.imem.lt.1000) write(cmem,"('.e',i3)"),imem
         file_old=trim(wrfinput_path_old)//'/'//trim(wrfinput_file_old)//trim(cmem)
         file_new=trim(wrfinput_path_new)//'/'//trim(wrfinput_file_new)//trim(cmem)
         file_new_3d=trim(wrfinput_path_new)//'/'//trim(wrfinput_file_new)//trim(cmem)
         file_new_bdy=trim(wrfbdy_path_new)//'/'//trim(wrfbdy_file_new)//trim(cmem)
         do isp=1,nchem_spcs
            allocate(chem_data3d_new(nx,ny,nz,1))
            allocate(tmp_arry(nx*ny*nz))
            call mpi_recv(tmp_arry,nx*ny*nz,MPI_FLOAT, &
            itask(imem,isp),1,MPI_COMM_WORLD,stat,ierr)
            call apm_unpack_4d(tmp_arry,chem_data3d_new,nx,ny,nz,1)
            call put_WRFCHEM_icbc_data(file_new_3d,ch_chem_spc(isp), &
            chem_data3d_new,nx,ny,nz,1)
            deallocate(chem_data3d_new)
            deallocate(tmp_arry) 
         enddo
      enddo
!
! Process BCs
      do ibdy=1,nbdy_exts
         do imem=1,num_mems
            if(imem.ge.0.and.imem.lt.10) write(cmem,"('.e00',i1)"),imem
            if(imem.ge.10.and.imem.lt.100) write(cmem,"('.e0',i2)"),imem
            if(imem.ge.100.and.imem.lt.1000) write(cmem,"('.e',i3)"),imem
            file_old=trim(wrfbdy_path_old)//'/'//trim(wrfbdy_file_old)//trim(cmem)
            file_new=trim(wrfbdy_path_new)//'/'//trim(wrfbdy_file_new)//trim(cmem)
            file_new_3d=trim(wrfinput_path_new)//'/'//trim(wrfinput_file_new)//trim(cmem)
            file_new_bdy=trim(wrfbdy_path_new)//'/'//trim(wrfbdy_file_new)//trim(cmem)
            do isp=1,nchem_spcs
!
! Read and send old BCs
               if(sw_corr_tm) then
                  allocate(chem_databdy_old(bdy_dims(ibdy),nz,nhalo,nt))
                  allocate(tmp_arry(bdy_dims(ibdy)*nz*nhalo*nt)) 
                  ch_spcs=trim(ch_chem_spc(isp))//trim(bdy_exts(ibdy))
                  call get_WRFCHEM_icbc_data(file_old,ch_spcs, &
                  chem_databdy_old,bdy_dims(ibdy),nz,nhalo,nt)
                  call apm_pack_4d(tmp_arry,chem_databdy_old,bdy_dims(ibdy),nz,nhalo,nt)
                  call mpi_send(tmp_arry,bdy_dims(ibdy)*nz*nhalo*nt,MPI_FLOAT, &               
                  itask(imem,isp),2+ibdy,MPI_COMM_WORLD,ierr)
                  deallocate(chem_databdy_old)
                  deallocate(tmp_arry)
               endif
!
! Read and send new BCs
               allocate(chem_databdy_new(bdy_dims(ibdy),nz,nhalo,nt))
               allocate(tmp_arry(bdy_dims(ibdy)*nz*nhalo*nt)) 
               ch_spcs=trim(ch_chem_spc(isp))//trim(bdy_exts(ibdy))
               call get_WRFCHEM_icbc_data(file_new,ch_spcs, &
               chem_databdy_new,bdy_dims(ibdy),nz,nhalo,nt)
               call apm_pack_4d(tmp_arry,chem_databdy_new,bdy_dims(ibdy),nz,nhalo,nt)
               call mpi_send(tmp_arry,bdy_dims(ibdy)*nz*nhalo*nt,MPI_FLOAT, &               
               itask(imem,isp),2+nbdy_exts+ibdy,MPI_COMM_WORLD,ierr)
               deallocate(chem_databdy_new)
               deallocate(tmp_arry)
            enddo   
         enddo
!
! Receive and write smoothed BCs
         do imem=1,num_mems
            if(imem.ge.0.and.imem.lt.10) write(cmem,"('.e00',i1)"),imem
            if(imem.ge.10.and.imem.lt.100) write(cmem,"('.e0',i2)"),imem
            if(imem.ge.100.and.imem.lt.1000) write(cmem,"('.e',i3)"),imem
            file_old=trim(wrfbdy_path_old)//'/'//trim(wrfbdy_file_old)//trim(cmem)
            file_new=trim(wrfbdy_path_new)//'/'//trim(wrfbdy_file_new)//trim(cmem)
            file_new_3d=trim(wrfinput_path_new)//'/'//trim(wrfinput_file_new)//trim(cmem)
            file_new_bdy=trim(wrfbdy_path_new)//'/'//trim(wrfbdy_file_new)//trim(cmem)
            do isp=1,nchem_spcs
               ch_spcs=trim(ch_chem_spc(isp))//trim(bdy_exts(ibdy))
               allocate(chem_databdy_new(bdy_dims(ibdy),nz,nhalo,nt))
               allocate(tmp_arry(bdy_dims(ibdy)*nz*nhalo*nt))
               call mpi_recv(tmp_arry,bdy_dims(ibdy)*nz*nhalo*nt,MPI_FLOAT, &
               itask(imem,isp),1+ibdy,MPI_COMM_WORLD,stat,ierr)
               call apm_unpack_4d(tmp_arry,chem_databdy_new,bdy_dims(ibdy),nz,nhalo,nt)
               call put_WRFCHEM_icbc_data(file_new_bdy,ch_spcs, &
               chem_databdy_new,bdy_dims(ibdy),nz,nhalo,nt)
               deallocate(chem_databdy_new)
               deallocate(tmp_arry)
            enddo
         enddo
      enddo
   endif
!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!
! Rank: itask(imem,isp)
!   
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!
   if(rank.ne.0) then   
      wgt_bc_str=exp(-0.0*corr_tm_delt/corr_lngth_tm)
      wgt_bc_mid=exp(-0.5*corr_tm_delt/corr_lngth_tm)
      wgt_bc_end=exp(-1.0*corr_tm_delt/corr_lngth_tm)
!
! Process ICs
      do imem=1,num_mems
         do isp=1,nchem_spcs
            if(rank.eq.itask(imem,isp)) then
!
! Receive old ICs
               if(sw_corr_tm) then
                  allocate(chem_data3d_old(nx,ny,nz,1))
                  allocate(tmp_arry(nx*ny*nz))
                  call mpi_recv(tmp_arry,nx*ny*nz,MPI_FLOAT, &
                  0,1,MPI_COMM_WORLD,stat,ierr)
                  call apm_unpack_4d(tmp_arry,chem_data3d_old,nx,ny,nz,1)
                  deallocate(tmp_arry)
               endif   
!
! Receive new ICs
               allocate(chem_data3d_new(nx,ny,nz,1))
               allocate(tmp_arry(nx*ny*nz))
               call mpi_recv(tmp_arry,nx*ny*nz,MPI_FLOAT, &
               0,2,MPI_COMM_WORLD,stat,ierr)
               call apm_unpack_4d(tmp_arry,chem_data3d_new,nx,ny,nz,1)
               deallocate(tmp_arry)
!               
! Perturb and smooth new ICs               
               call date_and_time(ch_date,ch_time,ch_zone,date_time_vals)
               seed_trm=date_time_vals(5)*date_time_vals(6)*date_time_vals(7)
               if(sw_seed) call init_const_random_seed(rank,seed_trm)
               call perturb_wrfinput_fields(chem_data3d_new(:,:,:,1),lat,lon,A_chem, &
               nx,ny,nz,ngrid_corr,corr_lngth_hz,sprd_chem,rank,ch_chem_spc(isp))
!
! Temporal smoothing new ICs
               allocate(chem_data3d_smth(nx,ny,nz,1))
               if(sw_corr_tm) then
                  chem_data3d_smth(:,:,:,:)=(1.-wgt_bc_end)*chem_data3d_old(:,:,:,:)+wgt_bc_end* &
                  chem_data3d_new(:,:,:,:)
               else
                  chem_data3d_smth(:,:,:,:)=chem_data3d_new(:,:,:,:)
               endif
               if(sw_corr_tm) deallocate(chem_data3d_old)
               deallocate(chem_data3d_new)
            endif
         enddo
      enddo
!
! Send smoothed new ICs to Rank 0               
      do imem=1,num_mems
         do isp=1,nchem_spcs
            if(rank.eq.itask(imem,isp)) then
               allocate(tmp_arry(nx*ny*nz))
               call apm_pack_4d(tmp_arry,chem_data3d_smth,nx,ny,nz,1)
               call mpi_send(tmp_arry,nx*ny*nz,MPI_FLOAT, &
               0,1,MPI_COMM_WORLD,ierr)
               deallocate(chem_data3d_smth)
               deallocate(tmp_arry)
            endif
         enddo
      enddo
!
! Process BCs
      do ibdy=1,nbdy_exts
         do imem=1,num_mems
            do isp=1,nchem_spcs
               if(rank.eq.itask(imem,isp)) then
!
! Receive old BCs
                  if(sw_corr_tm) then
                     allocate(chem_databdy_old(bdy_dims(ibdy),nz,nhalo,nt))
                     allocate(tmp_arry(bdy_dims(ibdy)*nz*nhalo*nt))
                     call mpi_recv(tmp_arry,bdy_dims(ibdy)*nz*nhalo*nt,MPI_FLOAT, &
                     0,2+ibdy,MPI_COMM_WORLD,stat,ierr)
                     call apm_unpack_4d(tmp_arry,chem_databdy_old,bdy_dims(ibdy),nz,nhalo,nt)
                     deallocate(tmp_arry)
                  endif
!
! Receive new BCs 
                  allocate(chem_databdy_new(bdy_dims(ibdy),nz,nhalo,nt))
                  allocate(tmp_arry(bdy_dims(ibdy)*nz*nhalo*nt))
                  call mpi_recv(tmp_arry,bdy_dims(ibdy)*nz*nhalo*nt,MPI_FLOAT, &
                  0,2+nbdy_exts+ibdy,MPI_COMM_WORLD,stat,ierr)
                  call apm_unpack_4d(tmp_arry,chem_databdy_new,bdy_dims(ibdy),nz,nhalo,nt)
                  deallocate(tmp_arry)
!
! Perturb and smooth new BCs               
                  ch_spcs=trim(ch_chem_spc(isp))//trim(bdy_exts(ibdy))
                  call date_and_time(ch_date,ch_time,ch_zone,date_time_vals)
                  seed_trm=date_time_vals(5)*date_time_vals(6)*date_time_vals(7)
                  if(sw_seed) call init_const_random_seed(rank,seed_trm)
                  call perturb_wrfbdy_fields(chem_databdy_new,lat,lon,A_chem,nx,ny,nz, &
                  ngrid_corr,corr_lngth_hz,sprd_chem,rank,nhalo,nt,ibdy,bdy_dims(ibdy),ch_spcs)
!
! Temporal smoothing new BCs
                  allocate(chem_databdy_smth(bdy_dims(ibdy),nz,nhalo,nt))
                  if(sw_corr_tm) then
                     chem_databdy_smth(:,:,:,:)=(1.-wgt_bc_end)*chem_databdy_old(:,:,:,:)+wgt_bc_end* &
                     chem_databdy_new(:,:,:,:)
                  else
                     chem_databdy_smth(:,:,:,:)=chem_databdy_new(:,:,:,:)
                  endif
                  if(sw_corr_tm) deallocate(chem_databdy_old)
                  deallocate(chem_databdy_new)
               endif
            enddo
         enddo
!
! Send smoothed BCs to rank 0
         do imem=1,num_mems
            do isp=1,nchem_spcs
               if(rank.eq.itask(imem,isp)) then
                  allocate(tmp_arry(bdy_dims(ibdy)*nz*nhalo*nt))
                  call apm_pack_4d(tmp_arry,chem_databdy_smth,bdy_dims(ibdy),nz,nhalo,nt)
                  call mpi_send(tmp_arry,bdy_dims(ibdy)*nz*nhalo*nt,MPI_FLOAT, &
                  0,1+ibdy,MPI_COMM_WORLD,ierr)
                  deallocate(chem_databdy_smth)
                  deallocate(tmp_arry)
               endif
            enddo
         enddo
      enddo
   endif
!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!
! Rank: all
!   
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
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

subroutine perturb_wrfinput_fields(chem_data3d,lat,lon,A_chem, &
nx,ny,nz,ngrid_corr,corr_lngth_hz,sprd_chem,rank,ch_spcs)
   implicit none
   integer,                               intent(in)     :: nx,ny,nz
   integer,                               intent(in)     :: ngrid_corr,rank
   real,                                  intent(in)     :: corr_lngth_hz,sprd_chem
   real,dimension(nx,ny),                 intent(in)     :: lat,lon
   real,dimension(nx,ny,nz),              intent(inout)  :: chem_data3d
   real,dimension(nx,ny,nz,nz),           intent(in)     :: A_chem
!
   integer                             :: i,j,k,ii,jj,kk
   integer                             :: ii_str,ii_end,jj_str,jj_end
!
   real                                :: pi,u_ran_1,u_ran_2
   real                                :: wgt,zdist,get_dist
!
   real,allocatable,dimension(:)       :: fld_sum,wgt_sum
   real,allocatable,dimension(:,:,:)   :: pert_chem
   real,allocatable,dimension(:,:,:)   :: chem_data3d_new
   real,allocatable,dimension(:,:,:)   :: chem_data3d_smth
!
   character(len=300)                  :: ch_spcs
!
! Constants
   pi=4.*atan(1.)
!
! Define perturbations (Box-Muller transform N(0,1)
   allocate(pert_chem(nx,ny,nz))
   allocate(chem_data3d_new(nx,ny,nz))
   allocate(chem_data3d_smth(nx,ny,nz))
   pert_chem(:,:,:)=0.
   chem_data3d_new(:,:,:)=0.
   chem_data3d_smth(:,:,:)=0.
   do i=1,nx
      do j=1,ny
         do k=1,nz
            call random_number(u_ran_1)
            if(u_ran_1.eq.0.) call random_number(u_ran_1)
            call random_number(u_ran_2)
            if(u_ran_2.eq.0.) call random_number(u_ran_2)
            pert_chem(i,j,k)=sprd_chem*sqrt(-2.*log(u_ran_1))*cos(2.*pi*u_ran_2)
         enddo
      enddo
   enddo
!
! Apply perturbations ICs
   do i=1,nx
      do j=1,ny
         do k=1,nz
            if(chem_data3d(i,j,k)*(1.+pert_chem(i,j,k)) .le. 0.) then
               chem_data3d_new(i,j,k)=chem_data3d(i,j,k)
            else
               chem_data3d_new(i,j,k)=chem_data3d(i,j,k)*(1.+pert_chem(i,j,k))
            endif
         enddo
      enddo
   enddo
   deallocate(pert_chem)
!
! Apply horizontal correlations ICs
   allocate(fld_sum(nz))
   allocate(wgt_sum(nz))
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
                     fld_sum(k)=fld_sum(k)+wgt*chem_data3d_new(ii,jj,k)
                     wgt_sum(k)=wgt_sum(k)+wgt
                  enddo
               endif
            enddo
         enddo
         do k=1,nz
            if(wgt_sum(k).ne.0) then
               chem_data3d_smth(i,j,k)=fld_sum(k)/wgt_sum(k)
            else
               chem_data3d_smth(i,j,k)=chem_data3d_new(i,j,k)
            endif                            
         enddo
      enddo
   enddo
   chem_data3d_new(:,:,:)=chem_data3d_smth(:,:,:)
   chem_data3d_smth(:,:,:)=0.
!   
! Apply vertical correlations ICs
   do i=1,nx
      do j=1,ny
         fld_sum(:)=0.
         wgt_sum(:)=0.
         do k=1,nz
            do kk=1,nz
               fld_sum(k)=fld_sum(k)+A_chem(i,j,k,kk)*chem_data3d_new(i,j,kk)
               wgt_sum(k)=wgt_sum(k)+A_chem(i,j,k,kk)
            enddo
         enddo
         do k=1,nz
            if(wgt_sum(k).ne.0.) then
               chem_data3d_smth(i,j,k)=fld_sum(k)/wgt_sum(k)
            else
               chem_data3d_smth(i,j,k)=chem_data3d_new(i,j,k)
            endif
         enddo
      enddo
   enddo
   chem_data3d(:,:,:)=chem_data3d_smth(:,:,:)
   deallocate(chem_data3d_new)
   deallocate(chem_data3d_smth)
   deallocate(fld_sum)
   deallocate(wgt_sum)
!
end subroutine perturb_wrfinput_fields

!-------------------------------------------------------------------------------

subroutine perturb_wrfbdy_fields(chem_databdy,lat,lon,A_chem,nx,ny,nz, &
ngrid_corr,corr_lngth_hz,sprd_chem,rank,nhalo,nt,ibdy,bdy_dim,ch_spcs)
  implicit none
   integer,                               intent(in)     :: nx,ny,nz
   integer,                               intent(in)     :: ngrid_corr,rank
   integer,                               intent(in)     :: nhalo,nt,ibdy,bdy_dim
   real,                                  intent(in)     :: corr_lngth_hz,sprd_chem
   real,dimension(nx,ny),                 intent(in)     :: lat,lon
   real,dimension(bdy_dim,nz,nhalo,nt),   intent(inout)  :: chem_databdy
   real,dimension(nx,ny,nz,nz),           intent(in)     :: A_chem
!
   integer                             :: i,j,k,l,h,ii,jj,hh,ij,ijp,kk
   integer                             :: ij_str,ij_end
!
   real                                :: pi,u_ran_1,u_ran_2
   real                                :: wgt,zdist,get_dist
!
   real,allocatable,dimension(:,:)     :: fld_sum,wgt_sum
   real,allocatable,dimension(:,:,:,:) :: pert_chem
   real,allocatable,dimension(:,:,:,:) :: chem_databdy_new
   real,allocatable,dimension(:,:,:,:) :: chem_databdy_smth
!
   character(len=300)                  :: ch_spcs
!
! Constants
   pi=4.*atan(1.)                                                                                  
!
! Define perturbations (Box-Muller transform N(0,1)
   allocate(pert_chem(bdy_dim,nz,nhalo,nt))
   allocate(chem_databdy_new(bdy_dim,nz,nhalo,nt))
   allocate(chem_databdy_smth(bdy_dim,nz,nhalo,nt))
   pert_chem(:,:,:,:)=0.
   chem_databdy_new(:,:,:,:)=0.
   chem_databdy_smth(:,:,:,:)=0.
   do ij=1,bdy_dim
      do k=1,nz
         do h=1,nhalo
            do l=1,nt 
               call random_number(u_ran_1)
               if(u_ran_1.eq.0.) call random_number(u_ran_1)
               call random_number(u_ran_2)
               if(u_ran_2.eq.0.) call random_number(u_ran_2)
               pert_chem(ij,k,h,l)=sprd_chem*sqrt(-2.*log(u_ran_1))*cos(2.*pi*u_ran_2)
            enddo
         enddo
      enddo
   enddo   
!
! Apply perturbations BCs               
   do ij=1,bdy_dim
      do k=1,nz
         do h=1,nhalo
            do l=1,nt 
               if(chem_databdy(ij,k,h,l)*(1.+pert_chem(ij,k,h,l)) &
               .le. 0.) then
                  chem_databdy_new(ij,k,h,l)=chem_databdy(ij,k,h,l)
               else
                  chem_databdy_new(ij,k,h,l)=chem_databdy(ij,k,h,l)*(1.+ &
                  pert_chem(ij,k,h,l))
               endif
            enddo
         enddo
      enddo
   enddo
   deallocate(pert_chem)
!
! Apply horizontal correlations BCs
   allocate(fld_sum(nz,nt))   
   allocate(wgt_sum(nz,nt))
   do ij=1,bdy_dim
      ij_str=max(1,ij-ngrid_corr)
!
! ibdy=1 BXS
! ibdy=2 BXE
! ibdy=5 BTXS
! ibdy=6 BTXE
!      
      if(ibdy.eq.1.or.ibdy.eq.2.or.ibdy.eq.5.or.ibdy.eq.6) then 
         i=1
         j=-999
         if(ibdy/2*2.eq.ibdy) i=nx 
         ij_end=min(ny,ij+ngrid_corr)
!
! ibdy=3 BYS
! ibdy=4 BYE
! ibdy=7 BTYS
! ibdy=8 BTYE
!      
      elseif(ibdy.eq.3.or.ibdy.eq.4.or.ibdy.eq.7.or.ibdy.eq.8) then 
         i=-999
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
                  zdist=get_dist(lat(i+hh-1,ijp),lat(h,ij),lon(i+hh-1,ijp),lon(h,ij))
               elseif(i.eq.nx) then
                  zdist=get_dist(lat(i-hh+1,ijp),lat(h,ij),lon(i-hh+1,ijp),lon(h,ij))
               elseif (j.eq.1) then
                  zdist=get_dist(lat(ijp,j+hh-1),lat(ij,h),lon(ijp,j+hh-1),lon(ij,h))
               elseif(j.eq.ny) then
                  zdist=get_dist(lat(ijp,j-hh+1),lat(ij,h),lon(ijp,j-hh+1),lon(ij,h))
               endif
               if(zdist.le.corr_lngth_hz) then
                  wgt=1./exp(zdist*zdist/corr_lngth_hz/corr_lngth_hz)
                  do l=1,nt
                     do k=1,nz
                        fld_sum(k,l)=fld_sum(k,l)+wgt*chem_databdy_new(ijp,k,hh,l)
                        wgt_sum(k,l)=wgt_sum(k,l)+wgt
                     enddo
                  enddo
               endif
            enddo
         enddo
         do l=1,nt
            do k=1,nz
               if(wgt_sum(k,l).ne.0.) then
                  chem_databdy_smth(ij,k,h,l)=fld_sum(k,l)/wgt_sum(k,l)
               else
                  chem_databdy_smth(ij,k,h,l)=chem_databdy_new(ij,k,h,l)
               endif
            enddo
         enddo
      enddo
   enddo
   chem_databdy_new(:,:,:,:)=chem_databdy_smth(:,:,:,:)
   chem_databdy_smth(:,:,:,:)=0.
!   
! Apply vertical correlations BCs
   if(ibdy.eq.1.or.ibdy.eq.2.or.ibdy.eq.5.or.ibdy.eq.6) then 
      i=1
      j=-999
      if(ibdy/2*2.eq.ibdy) i=nx 
   elseif(ibdy.eq.3.or.ibdy.eq.4.or.ibdy.eq.7.or.ibdy.eq.8) then 
      i=-999
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
                     fld_sum(k,l)=fld_sum(k,l)+A_chem(i+h-1,ij,k,kk)*chem_databdy_new(ij,kk,h,l)
                     wgt_sum(k,l)=wgt_sum(k,l)+A_chem(i+h-1,ij,k,kk)
                  elseif(i.eq.nx) then
                     fld_sum(k,l)=fld_sum(k,l)+A_chem(i-h+1,ij,k,kk)*chem_databdy_new(ij,kk,h,l)
                     wgt_sum(k,l)=wgt_sum(k,l)+A_chem(i-h+1,ij,k,kk)
                  elseif(j.eq.1) then
                     fld_sum(k,l)=fld_sum(k,l)+A_chem(ij,j+h-1,k,kk)*chem_databdy_new(ij,kk,h,l)
                     wgt_sum(k,l)=wgt_sum(k,l)+A_chem(ij,j+h-1,k,kk)
                  elseif(j.eq.ny) then
                     fld_sum(k,l)=fld_sum(k,l)+A_chem(ij,j-h+1,k,kk)*chem_databdy_new(ij,kk,h,l)
                     wgt_sum(k,l)=wgt_sum(k,l)+A_chem(ij,j-h+1,k,kk)
                  endif
               enddo
            enddo
         enddo
         do l=1,nt
            do k=1,nz
               if(wgt_sum(k,l).ne.0.) then
                  chem_databdy_smth(ij,k,h,l)=fld_sum(k,l)/wgt_sum(k,l)
               else
                  chem_databdy_smth(ij,k,h,l)=chem_databdy_new(ij,k,h,l)
               endif
            enddo
         enddo
      enddo
   enddo
   chem_databdy(:,:,:,:)=chem_databdy_smth(:,:,:,:)
   deallocate(chem_databdy_new)
   deallocate(chem_databdy_smth)
   deallocate(fld_sum)
   deallocate(wgt_sum)
!
end subroutine perturb_wrfbdy_fields

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
   file='wrfinput_d01'
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
! get geo_ht
   do k=1,nz
      geo_ht(:,:,k)=(ph(:,:,k)+phb(:,:,k)+ph(:,:,k+1)+ &
      phb(:,:,k+1))/2.
   enddo
   rc = nf_close(f_id)
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
