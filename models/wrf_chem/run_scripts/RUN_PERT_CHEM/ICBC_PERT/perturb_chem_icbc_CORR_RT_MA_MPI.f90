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

! code to perturb the wrfchem icbc files

program main

implicit none

! version controlled file description for error handling, do not edit
character(len=*), parameter :: source   = 'perturb_chem_icbc_CORR_RT_MA_MPI.f90'
character(len=*), parameter :: revision = ''
character(len=*), parameter :: revdate  = ''

             include 'mpif.h'
             integer,parameter                           :: nbdy_exts=8
             integer,parameter                           :: nhalo=5
             integer                                     :: unit,unita,unitb,num_procs
             integer                                     :: nx,ny,nz,nzp,nt,nchem_spcs,rank,stat
             integer                                     :: i,ii,j,jj,h,k,kk,l,ll,ibdy,bdy_idx
             integer                                     :: ierr,isp,num_mem,imem
             integer                                     :: ngrid_corr,nbff
             integer                                     :: ii_str,ii_end,ii_npt,ii_sft
             integer                                     :: jj_str,jj_end,jj_npt,jj_sft
             real                                        :: pi,grav,u_ran_1,u_ran_2,nnum_mem
             real                                        :: sprd_chem,zdist,zfac,tfac
             real                                        :: grid_length,vcov
             real                                        :: corr_lngth_hz
             real                                        :: corr_lngth_vt
             real                                        :: corr_lngth_tm
             real                                        :: corr_tm_delt
             real                                        :: wgt,wgt_bc_str,wgt_bc_mid,wgt_bc_end,wgt_summ
             real                                        :: mean,std,get_dist
             real                                        :: atime1,atime2,atime3,atime4,atime5,atime6
             real                                        :: atime1_mem,atime2_mem
             real                                        :: chem_fac_mid,zloge
             real,allocatable,dimension(:)               :: tmp_arry
             real,allocatable,dimension(:,:)             :: lat,lon
             real,allocatable,dimension(:,:,:)           :: geo_ht,wgt_sum
             real,allocatable,dimension(:,:,:)           :: pert_chem_old, pert_chem_new, pert_chem_end
             real,allocatable,dimension(:,:,:)           :: chem_fac_mem_old, chem_fac_mem_new
             real,allocatable,dimension(:,:,:,:)         :: dist
             real,allocatable,dimension(:,:,:,:)         :: chem_fac_old
             real,allocatable,dimension(:,:,:,:)         :: chem_fac_new
             real,allocatable,dimension(:,:,:,:)         :: chem_fac_end
             real,allocatable,dimension(:,:,:,:)         :: A
             real,allocatable,dimension(:,:,:,:)         :: chem_data3d
             real,allocatable,dimension(:,:,:,:)         :: chem_data3d_sav
             real,allocatable,dimension(:,:,:,:)         :: chem_data3d_mean
             real,allocatable,dimension(:,:,:,:)         :: chem_data3d_sprd
             real,allocatable,dimension(:,:,:,:)         :: chem_data3d_frac
             real,allocatable,dimension(:,:,:,:)         :: chem_databdy
             real,allocatable,dimension(:,:,:)           :: chem_data_end
             real,allocatable,dimension(:,:,:,:,:)       :: chem_data_sav_1
             real,allocatable,dimension(:,:,:,:,:)       :: chem_data_sav_2
             real,allocatable,dimension(:)               :: mems,pers
             real,allocatable,dimension(:)               :: pert_chem_sum_old, pert_chem_sum_new
             character(len=150)                          :: pert_path_old,pert_path_new,ch_spcs
             character(len=150)                          :: wrfchem_file,wrfinput_err_new
             character(len=150)                          :: wrfinput_fld_new,wrfbdy_fld_new
             character(len=20)                           :: cmem
             character(len=5),dimension(nbdy_exts)       :: bdy_exts=(/'_BXS ','_BXE ','_BYS ','_BYE ','_BTXS', &
             '_BTXE','_BTYS','_BTYE'/)
             integer,dimension(nbdy_exts)                :: bdy_dims=(/139,139,179,179,139,139,179,179/)
             character(len=150),allocatable,dimension(:) :: ch_chem_spc
             logical                                     :: sw_corr_tm,sw_seed
             namelist /perturb_chem_icbc_corr_nml/nx,ny,nz,nchem_spcs,pert_path_old,pert_path_new,nnum_mem, &
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
             zloge=log10(exp(1.))
!
! Read control namelist
             unit=20
             open(unit=unit,file='perturb_chem_icbc_corr_nml.nl',form='formatted', &
             status='old',action='read') 
             read(unit,perturb_chem_icbc_corr_nml)
             close(unit)
             if(rank.eq.0) then   
                print *, 'nx                 ',nx
                print *, 'ny                 ',ny
                print *, 'nz                 ',nz
                print *, 'nchem_spcs         ',nchem_spcs
                print *, 'pert_path_old     ',trim(pert_path_old)
                print *, 'pert_path_new     ',trim(pert_path_new)
                print *, 'num_mem            ',nnum_mem
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
             nzp=nz+1
             num_mem=nint(nnum_mem)
             bdy_dims=(/ny,ny,nx,nx,ny,ny,nx,nx/)
!
! Allocate arrays
             allocate(ch_chem_spc(nchem_spcs))
             allocate(A(nx,ny,nz,nz))
             A(:,:,:,:)=0.
!
! Read the species namelist
             unit=20
             open( unit=unit,file='perturb_chem_icbc_spcs_nml.nl',form='formatted', &
             status='old',action='read')
             read(unit,perturb_chem_icbc_spcs_nml)
             close(unit)
!
! Get lat / lon data (-90 to 90; -180 to 180)
             allocate(lat(nx,ny),lon(nx,ny))
             call get_WRFINPUT_lat_lon(lat,lon,nx,ny)
!
! Get mean geopotential height data
             allocate(geo_ht(nx,ny,nz))
             call get_WRFINPUT_geo_ht(geo_ht,nx,ny,nz,nzp,num_mem)
             geo_ht(:,:,:)=geo_ht(:,:,:)/grav
!
! Construct the vertical correlations transformation matrix
             do k=1,nz
                do l=1,nz
                   do i=1,nx
                      do j=1,ny
                         vcov=1.-abs(geo_ht(i,j,k)-geo_ht(i,j,l))/corr_lngth_vt
                         if(vcov.lt.0.) vcov=0.
! row 1         
                         if(k.eq.1 .and. l.eq.1) then
                            A(i,j,k,l)=1.
                         elseif(k.eq.1 .and. l.gt.1) then
                            A(i,j,k,l)=0.
                         endif
! row 2         
                         if(k.eq.2 .and. l.eq.1) then
                            A(i,j,k,l)=vcov
                         elseif(k.eq.2 .and. l.eq.2) then
                            A(i,j,k,l)=sqrt(1.-A(i,j,k,l-1)*A(i,j,k,l-1))
                         elseif (k.eq.2 .and. l.gt.2) then
                            A(i,j,k,l)=0.
                         endif
! row 3 and greater
                         if(k.ge.3) then
                            if(l.eq.1) then
                               A(i,j,k,l)=vcov
                            elseif(l.lt.k .and. l.ne.1) then
                               do ll=1,l-1
                                  A(i,j,k,l)=A(i,j,k,l)+A(i,j,l,ll)*A(i,j,k,ll)
                               enddo
                               if(A(i,j,l,l).ne.0) A(i,j,k,l)=(vcov-A(i,j,k,l))/A(i,j,l,l)
                            elseif(l.eq.k) then
                               do ll=1,l-1
                                  A(i,j,k,l)=A(i,j,k,l)+A(i,j,k,ll)*A(i,j,k,ll)
                               enddo
                               A(i,j,k,l)=sqrt(1.-A(i,j,k,l))
                            endif
                         endif
                      enddo
                   enddo
                enddo
             enddo
             deallocate(geo_ht)
!
! Get horiztonal grid length
             grid_length=get_dist(lat(nx/2,ny),lat(nx/2+1,ny),lon(nx/2,ny),lon(nx/2+1,ny))
!
! Calculate number of horizontal grid points to be correlated 
             ngrid_corr=ceiling(zfac*corr_lngth_hz/grid_length)
             if(rank.eq.0) print *, 'ngrid_corr         ',ngrid_corr
!
! Calculate new random number seed
             if(num_mem.gt.num_procs-1) then
                print *, 'APM ERROR: NOT ENOUGH PROCESSORS num_mem = ',num_mem, ' procs = ',num_procs-1
                call mpi_finalize(ierr)
                stop
             endif
             if(sw_seed) call init_random_seed()
             if(rank.ne.0) then
!
! Stop excess processes
                if(rank.gt.num_mem) then
                   call mpi_finalize(ierr)
                   stop
                endif
!            
                if(sw_corr_tm) then
                   allocate(pert_chem_old(nx,ny,nz))
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
                allocate(pert_chem_new(nx,ny,nz))
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
! Impose horizontal correlations
                if(rank.eq.1) print *,rank,'horizontal correlations'
                allocate(wgt_sum(nx,ny,nz))
                wgt_sum(:,:,:)=0.
                if(sw_corr_tm) then
                   allocate(chem_fac_mem_old(nx,ny,nz))
                   chem_fac_mem_old(:,:,:)=0.
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
                                  wgt=1./exp(zdist*zdist/corr_lngth_hz/corr_lngth_hz)
                                  do k=1,nz
                                     wgt_sum(i,j,k)=wgt_sum(i,j,k)+wgt
                                     chem_fac_mem_old(i,j,k)=chem_fac_mem_old(i,j,k)+wgt*pert_chem_old(ii,jj,k)
                                  enddo
                               endif
                            enddo
                         enddo
                         do k=1,nz
                            if(wgt_sum(i,j,k).gt.0) then
                               chem_fac_mem_old(i,j,k)=chem_fac_mem_old(i,j,k)/wgt_sum(i,j,k)
                            else
                               chem_fac_mem_old(i,j,k)=pert_chem_old(i,j,k)
                            endif                            
                         enddo
                      enddo
                   enddo
                endif
                allocate(chem_fac_mem_new(nx,ny,nz))
                chem_fac_mem_new(:,:,:)=0.
                wgt_sum(:,:,:)=0.
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
                               wgt=1./exp(zdist*zdist/corr_lngth_hz/corr_lngth_hz)
                               do k=1,nz
                                  wgt_sum(i,j,k)=wgt_sum(i,j,k)+wgt
                                  chem_fac_mem_new(i,j,k)=chem_fac_mem_new(i,j,k)+wgt*pert_chem_new(ii,jj,k)
                               enddo
                            endif
                         enddo
                      enddo
                      do k=1,nz
                         if(wgt_sum(i,j,k).gt.0) then
                            chem_fac_mem_new(i,j,k)=chem_fac_mem_new(i,j,k)/wgt_sum(i,j,k)
                         else
                            chem_fac_mem_new(i,j,k)=pert_chem_new(i,j,k)
                         endif                            
                      enddo
                   enddo
                enddo
                deallocate(wgt_sum)
                if(sw_corr_tm) then
                   deallocate(pert_chem_old)
                endif
                deallocate(pert_chem_new)
                deallocate(lat,lon)
!
! Impose vertical correlations
                if(rank.eq.1) print *,rank,'vertical correlations'
                if(sw_corr_tm) then
                   allocate(pert_chem_sum_old(nz))
                   do i=1,nx
                      do j=1,ny
                         pert_chem_sum_old(:)=0.
                         do k=1,nz
                            do kk=1,nz 
                               pert_chem_sum_old(k)=pert_chem_sum_old(k)+A(i,j,k,kk)*chem_fac_mem_old(i,j,kk)
                            enddo
                         enddo
                         do k=1,nz
                            chem_fac_mem_old(i,j,k)=pert_chem_sum_old(k)
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
                            pert_chem_sum_new(k)=pert_chem_sum_new(k)+A(i,j,k,kk)*chem_fac_mem_new(i,j,kk)
                         enddo
                      enddo
                      do k=1,nz
                         chem_fac_mem_new(i,j,k)=pert_chem_sum_new(k)
                      enddo 
                   enddo
                enddo
                deallocate(pert_chem_sum_new)
                deallocate(A)
!
                allocate(tmp_arry(nx*ny*nz))
                if(sw_corr_tm) then
                   call apm_pack(tmp_arry,chem_fac_mem_old,nx,ny,nz,1)
                   call mpi_send(tmp_arry,nx*ny*nz,MPI_FLOAT,0,11,MPI_COMM_WORLD,ierr)
                   deallocate(chem_fac_mem_old)
                endif
                call apm_pack(tmp_arry,chem_fac_mem_new,nx,ny,nz,1)
                call mpi_send(tmp_arry,nx*ny*nz,MPI_FLOAT,0,12,MPI_COMM_WORLD,ierr)
                deallocate(tmp_arry)
                deallocate(chem_fac_mem_new)
                call mpi_finalize(ierr)
                stop                
             elseif (rank.eq.0) then
                allocate(tmp_arry(nx*ny*nz))
                if(sw_corr_tm) then
                   allocate(chem_fac_old(nx,ny,nz,num_mem))
                   do imem=1,num_mem
                      call mpi_recv(tmp_arry,nx*ny*nz,MPI_FLOAT,imem,11,MPI_COMM_WORLD,stat,ierr)
                      call apm_unpack(tmp_arry,chem_fac_old(:,:,:,imem),nx,ny,nz,1)
                   enddo
                endif
                allocate(chem_fac_new(nx,ny,nz,num_mem))
                do imem=1,num_mem
                   call mpi_recv(tmp_arry,nx*ny*nz,MPI_FLOAT,imem,12,MPI_COMM_WORLD,stat,ierr)
                   call apm_unpack(tmp_arry,chem_fac_new(:,:,:,imem),nx,ny,nz,1)
                enddo
                deallocate(tmp_arry)
!
! Recentering
                print *, rank,'recentering '
                allocate(mems(num_mem),pers(num_mem))             
                if(sw_corr_tm) then
                   do i=1,nx
                      do j=1,ny
                         do k=1,nz
                            mems(:)=chem_fac_old(i,j,k,:)
                            mean=sum(mems)/real(num_mem)
                            pers(:)=(mems(:)-mean)*(mems(:)-mean)
                            std=sqrt(sum(pers)/real(num_mem-1))
                            do imem=1,num_mem
                               if(std.ne.0) then
                                  chem_fac_old(i,j,k,imem)=(chem_fac_old(i,j,k,imem)-mean)*sprd_chem/zloge/std
                               endif 
                            enddo
                         enddo
                      enddo
                   enddo
                endif
                do i=1,nx
                   do j=1,ny
                      do k=1,nz
                         mems(:)=chem_fac_new(i,j,k,:)
                         mean=sum(mems)/real(num_mem)
                         pers(:)=(mems(:)-mean)*(mems(:)-mean)
                         std=sqrt(sum(pers)/real(num_mem-1))
                         do imem=1,num_mem
                            if(std.ne.0) then
                               chem_fac_new(i,j,k,imem)=(chem_fac_new(i,j,k,imem)-mean)*sprd_chem/std
                            endif 
                         enddo
                      enddo
                   enddo
                enddo
                deallocate(mems,pers)
!
! Impose temporal correlations
                print *, rank,'temporal correlations '
                unita=30
                unitb=40
                if(.not.sw_corr_tm) then
                   allocate(chem_fac_old(nx,ny,nz,num_mem))
                   open(unit=unita,file=trim(pert_path_old)//'/pert_chem_icbc', &
                   form='unformatted',status='unknown')
                   read(unita) chem_fac_old
                   close(unita)
                endif
                allocate(chem_fac_end(nx,ny,nz,num_mem))
                wgt_bc_str=1.-0.0*corr_tm_delt/corr_lngth_tm
                wgt_bc_mid=1.-0.5*corr_tm_delt/corr_lngth_tm
                wgt_bc_end=1.-1.0*corr_tm_delt/corr_lngth_tm
                chem_fac_end(:,:,:,:)=wgt_bc_end*chem_fac_old(:,:,:,:)+sqrt(1.-wgt_bc_end*wgt_bc_end)*chem_fac_new(:,:,:,:) 
                open(unit=unitb,file=trim(pert_path_new)//'/pert_chem_icbc', &
                form='unformatted',status='unknown')
                write(unitb) chem_fac_end
                close(unitb)
!
! Perturb the members
                print *, rank,'perturb the IC/BCs '
                do isp=1,nchem_spcs
                   allocate(chem_data3d_sav(nx,ny,nz,num_mem))
                   do imem=1,num_mem
                      if(imem.ge.0.and.imem.lt.10) write(cmem,"('.e00',i1)"),imem
                      if(imem.ge.10.and.imem.lt.100) write(cmem,"('.e0',i2)"),imem
                      if(imem.ge.100.and.imem.lt.1000) write(cmem,"('.e',i3)"),imem
! ICs
                      print *, 'Start ICs mem ',imem               
                      wrfchem_file=trim(wrfinput_fld_new)//trim(cmem)
                      allocate(chem_data3d(nx,ny,nz,1))
                      call get_WRFCHEM_icbc_data(wrfchem_file,ch_chem_spc(isp),chem_data3d,nx,ny,nz,1)
                      do i=1,nx
                         do j=1,ny
                            do k=1,nz
!
! The perturbation is N(0,1) in ln space.  It needs to be N(0,1) in log space.
! Rule: ln(x)=log(x)/log(e).  So the coversion is chem_fac_old(i,j,k,imem)/log(e).
!
                               chem_data3d(i,j,k,1)=chem_data3d(i,j,k,1)*exp(chem_fac_old(i,j,k,imem))
                            enddo
                         enddo
                      enddo 
                      call put_WRFCHEM_icbc_data(wrfchem_file,ch_chem_spc(isp),chem_data3d,nx,ny,nz,1)
                      chem_data3d_sav(:,:,:,imem)=chem_data3d(:,:,:,1)
                      deallocate(chem_data3d)
! BCs              
                      wrfchem_file=trim(wrfbdy_fld_new)//trim(cmem)
                      do ibdy=1,nbdy_exts
                         if(ibdy.eq.1) allocate(chem_data_sav_1(bdy_dims(ibdy),nz,nhalo,nt,2))
                         if(ibdy.eq.3) allocate(chem_data_sav_2(bdy_dims(ibdy),nz,nhalo,nt,2))
                         ch_spcs=trim(ch_chem_spc(isp))//trim(bdy_exts(ibdy))
                         print *, 'Start BCs mem, spcs ',imem,trim(ch_spcs)               
                         allocate(chem_databdy(bdy_dims(ibdy),nz,nhalo,nt))
                         call get_WRFCHEM_icbc_data(wrfchem_file,ch_spcs,chem_databdy,bdy_dims(ibdy),nz,nhalo,nt)
                         if(ibdy.eq.1.or.ibdy.eq.2.or.ibdy.eq.5.or.ibdy.eq.6) then 
                            if(ibdy.eq.1.or.ibdy.eq.2) then
                               chem_data_sav_1(:,:,:,:,ibdy)=chem_databdy(:,:,:,:)
                               i=1
                               if(ibdy/2*2.eq.ibdy) i=nx 
                               do h=1,nhalo
                                  do k=1,nz
                                     do j=1,bdy_dims(ibdy)
                                        chem_fac_mid=wgt_bc_mid*chem_fac_old(i,j,k,imem)+sqrt(1.-wgt_bc_mid* &
                                        wgt_bc_mid)*chem_fac_new(i,j,k,imem)
                                        chem_databdy(j,k,h,1)=chem_databdy(j,k,h,1)*exp(chem_fac_old(i,j,k,imem))
                                        chem_databdy(j,k,h,2)=chem_databdy(j,k,h,2)*exp(chem_fac_mid)
                                     enddo
                                  enddo
                               enddo
                            else
! Tendency terms need to account for a temporal change in the perturbation
                               allocate(chem_data_end(bdy_dims(ibdy),nz,nhalo))
                               chem_data_end(:,:,:)=chem_databdy(:,:,:,2)*corr_tm_delt/2.*tfac+chem_data_sav_1(:,:,:,2,ibdy-4)
                               i=1
                               if(ibdy/2*2.eq.ibdy) i=nx
                               do h=1,nhalo
                                  do k=1,nz
                                     do j=1,bdy_dims(ibdy)

                                        chem_fac_mid=wgt_bc_mid*chem_fac_old(i,j,k,imem)+sqrt(1.-wgt_bc_mid* &
                                        wgt_bc_mid)*chem_fac_new(i,j,k,imem)

!                                        if(trim(ch_chem_spc(isp)).eq.'co' .and. imem.eq.1) then
!                                           print *, 'i,j,k,h,ibdy,imem ',i,j,k,h,ibdy,imem
!                                           print *, 'old ',   chem_fac_old(i,j,k,imem)
!                                           print *, 'mid ',   chem_fac_mid
!                                           print *, 'new ',   chem_fac_new(i,j,k,imem)
!                                           print *, 'end ',   chem_fac_end(i,j,k,imem)
!                                           print *, 'sav 1 ', chem_data_sav_1(j,k,h,1,ibdy-4)
!                                           print *, 'sav 2 ', chem_data_sav_1(j,k,h,2,ibdy-4)
!                                           print *, 'end ',   chem_data_end(j,k,h)
!                                           print *, 'tend 1 ',chem_databdy(j,k,h,1)
!                                           print *, 'tend 2 ',chem_databdy(j,k,h,2)
!                                        endif
!
                                        chem_databdy(j,k,h,1)=chem_databdy(j,k,h,1)* &
                                        (exp(chem_fac_old(i,j,k,imem))+exp(chem_fac_mid))/2. + &
                                        (exp(chem_fac_mid)-exp(chem_fac_old(i,j,k,imem)))/(corr_tm_delt/2.)/tfac* &
                                        (chem_data_sav_1(j,k,h,1,ibdy-4)+chem_data_sav_1(j,k,h,2,ibdy-4))/2.
!
                                        chem_databdy(j,k,h,2)=chem_databdy(j,k,h,2)* &
                                        (exp(chem_fac_mid)+exp(chem_fac_end(i,j,k,imem)))/2. + &
                                        (exp(chem_fac_end(i,j,k,imem))-exp(chem_fac_mid))/(corr_tm_delt/2.)/tfac* &
                                        (chem_data_sav_1(j,k,h,2,ibdy-4)+chem_data_end(j,k,h))/2.                             
                                     enddo
                                  enddo
                               enddo
                               deallocate(chem_data_end)
                            endif
                         else if(ibdy.eq.3.or.ibdy.eq.4.or.ibdy.eq.7.or.ibdy.eq.8) then
                            if(ibdy.eq.3.or.ibdy.eq.4) then
                               chem_data_sav_2(:,:,:,:,ibdy-2)=chem_databdy(:,:,:,:)
                               j=1  
                               if(ibdy/2*2.eq.ibdy) j=ny
                               do h=1,nhalo
                                  do k=1,nz
                                     do i=1,bdy_dims(ibdy)
                                        chem_fac_mid=wgt_bc_mid*chem_fac_old(i,j,k,imem)+sqrt(1.-wgt_bc_mid* &
                                        wgt_bc_mid)*chem_fac_new(i,j,k,imem)
                                        chem_databdy(i,k,h,1)=chem_databdy(i,k,h,1)*exp(chem_fac_old(i,j,k,imem))
                                        chem_databdy(i,k,h,2)=chem_databdy(i,k,h,2)*exp(chem_fac_mid)
                                     enddo
                                  enddo
                               enddo
                            else
! Tendency terms need to account for a temporal change in the perturbation
                               allocate(chem_data_end(bdy_dims(ibdy),nz,nhalo))
                               chem_data_end(:,:,:)=chem_databdy(:,:,:,2)*(corr_tm_delt/2.)*tfac+chem_data_sav_2(:,:,:,2,ibdy-6)
                               j=1  
                               if(ibdy/2*2.eq.ibdy) j=ny
                               do h=1,nhalo
                                  do k=1,nz
                                     do i=1,bdy_dims(ibdy)
                                        chem_fac_mid=wgt_bc_mid*chem_fac_old(i,j,k,imem)+sqrt(1.-wgt_bc_mid* &
                                        wgt_bc_mid)*chem_fac_new(i,j,k,imem)
!
                                        chem_databdy(i,k,h,1)=chem_databdy(i,k,h,1)* &
                                        (exp(chem_fac_old(i,j,k,imem))+exp(chem_fac_mid))/2. + &
                                        (exp(chem_fac_mid)-exp(chem_fac_old(i,j,k,imem)))/(corr_tm_delt/2.)/tfac* &
                                        (chem_data_sav_2(i,k,h,1,ibdy-6)+chem_data_sav_2(i,k,h,2,ibdy-6))/2.
!
                                        chem_databdy(i,k,h,2)=chem_databdy(i,k,h,2)* &
                                        (exp(chem_fac_mid)+exp(chem_fac_end(i,j,k,imem)))/2. + &
                                        (exp(chem_fac_end(i,j,k,imem))-exp(chem_fac_mid))/(corr_tm_delt/2.)/tfac* &
                                        (chem_data_sav_2(i,k,h,2,ibdy-6)+chem_data_end(i,k,h))/2.
                                     enddo
                                  enddo
                               enddo
                               deallocate(chem_data_end)
                            endif
                         endif
                         call put_WRFCHEM_icbc_data(wrfchem_file,ch_spcs,chem_databdy,bdy_dims(ibdy),nz,nhalo,nt)
                         deallocate(chem_databdy)
                         print *, 'Finish BCs mem, spcs ',imem,trim(ch_spcs)               
                      enddo   ! BC type loop
                      deallocate(chem_data_sav_1)
                      deallocate(chem_data_sav_2)
                   enddo      ! member loop
!
! Calculate mean and variance
                   allocate(mems(num_mem),pers(num_mem))
                   allocate(chem_data3d_mean(nx,ny,nz,1))
                   allocate(chem_data3d_sprd(nx,ny,nz,1))
                   allocate(chem_data3d_frac(nx,ny,nz,1))
                   do i=1,nx
                      do j=1,ny
                         do k=1,nz
                            mems(:)=chem_data3d_sav(i,j,k,1:num_mem)
                            mean=sum(mems)/real(num_mem)
                            pers(:)=(mems(:)-mean)*(mems(:)-mean)
                            std=sqrt(sum(pers)/real(num_mem-1))
                            chem_data3d_mean(i,j,k,1)=mean
                            chem_data3d_sprd(i,j,k,1)=std
                            chem_data3d_frac(i,j,k,1)=std/mean
                         enddo
                      enddo
                   enddo
                   deallocate(mems,pers)                   
                   wrfchem_file=trim(pert_path_new)//'/'//trim(wrfinput_fld_new)//'_mean'
                   call put_WRFCHEM_icbc_data(wrfchem_file,ch_chem_spc(isp),chem_data3d_mean,nx,ny,nz,1)
                   wrfchem_file=trim(pert_path_new)//'/'//trim(wrfinput_fld_new)//'_sprd'
                   call put_WRFCHEM_icbc_data(wrfchem_file,ch_chem_spc(isp),chem_data3d_sprd,nx,ny,nz,1)
                   wrfchem_file=trim(pert_path_new)//'/'//trim(wrfinput_fld_new)//'_frac'
                   call put_WRFCHEM_icbc_data(wrfchem_file,ch_chem_spc(isp),chem_data3d_frac,nx,ny,nz,1)
                   deallocate(chem_data3d_sav)
                   deallocate(chem_data3d_mean)
                   deallocate(chem_data3d_sprd)
                   deallocate(chem_data3d_frac)
                enddo            ! end species loop: same random field for each species
                deallocate(chem_fac_old)
                deallocate(chem_fac_new)
                deallocate(ch_chem_spc)
                call mpi_finalize(ierr)
                stop
             endif
          end program main
!
          function get_dist(lat1,lat2,lon1,lon2)
! returns distance in km
             implicit none
             real:: lat1,lat2,lon1,lon2,get_dist
             real:: lon_dif,rtemp,zx,zy
             real:: pi,ang2rad,r_earth
             real:: coef_a,coef_c
             pi=4.*atan(1.0)
             ang2rad=pi/180.
             r_earth=6371.393
! Haversine Code
!             coef_a=sin((lat2-lat1)/2.*ang2rad) * sin((lat2-lat1)/2.*ang2rad) + & 
!             cos(lat1*ang2rad)*cos(lat2*ang2rad) * sin((lon2-lon1)/2.*ang2rad) * &
!             sin((lon2-lon1)/2.*ang2rad)
!             coef_c=2.*atan2(sqrt(coef_a),sqrt(1.-coef_a))
!             get_dist=abs(coef_c*r_earth)
! Equi-rectangular (Pythagorian Formula)
             zx=(lon2-lon1)*ang2rad * cos((lat1+lat2)/2.*ang2rad)
             zy=(lat2-lat1)*ang2rad
             get_dist=r_earth*sqrt(zx*zx + zy*zy)
          end function get_dist
!
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
!             print *, trim(file)
             if(rc.ne.0) then
                print *, 'nf_open error ',trim(file)
                stop
             endif
!
! get variables identifiers
             rc = nf_inq_varid(f_id,trim(name),v_id)
!             print *, v_id
             if(rc.ne.0) then
                print *, 'nf_inq_varid error ', v_id
                stop
             endif
!
! get dimension identifiers
             v_dimid=0
             rc = nf_inq_var(f_id,v_id,v_nam,typ,v_ndim,v_dimid,natts)
!             print *, v_dimid
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
!             print *, v_dim
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
!             else if(1.ne.v_dim(4)) then             
!                print *, 'ERROR: time dimension conflict ',1,v_dim(4)
!                stop
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
!
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
!             print *, trim(file)
             if(rc.ne.0) then
                print *, 'nf_open error ',trim(file)
                stop
             endif
!
! get variables identifiers
             rc = nf_inq_varid(f_id,trim(name),v_id)
!             print *, v_id
             if(rc.ne.0) then
                print *, 'nf_inq_varid error ', v_id
                stop
             endif
!
! get dimension identifiers
             v_dimid=0
             rc = nf_inq_var(f_id,v_id,v_nam,typ,v_ndim,v_dimid,natts)
!             print *, v_dimid
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
!             print *, v_dim
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
!             else if(1.ne.v_dim(4)) then             
!                print *, 'ERROR: time dimension conflict ',1,v_dim(4)
!                stop
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
!
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
!
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
             character(len=150)                    :: v_nam
             character*(*)                         :: name
             character*(*)                         :: file
!
! open netcdf file
             rc = nf_open(trim(file),NF_SHARE,f_id)
!             print *, trim(file)
             if(rc.ne.0) then
                print *, 'nf_open error in get ',rc, trim(file)
                stop
             endif
!
! get variables identifiers
             rc = nf_inq_varid(f_id,trim(name),v_id)
!             print *, v_id
             if(rc.ne.0) then
                print *, 'nf_inq_varid error ', v_id
                stop
             endif
!
! get dimension identifiers
             v_dimid=0
             rc = nf_inq_var(f_id,v_id,v_nam,typ,v_ndim,v_dimid,natts)
!             print *, v_dimid
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
!             print *, v_dim
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
!
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
!             print *, 'f_id ',f_id
!
! get variables identifiers
             rc = nf_inq_varid(f_id,trim(name),v_id)
!             print *, v_id
             if(rc.ne.0) then
                print *, 'nf_inq_varid error ', v_id
                stop
             endif
!             print *, 'v_id ',v_id
!
! get dimension identifiers
             v_dimid=0
             rc = nf_inq_var(f_id,v_id,v_nam,typ,v_ndim,v_dimid,natts)
!             print *, v_dimid
             if(rc.ne.0) then
                print *, 'nf_inq_var error ', v_dimid
                stop
             endif
!             print *, 'v_ndim, v_dimid ',v_ndim,v_dimid      
!
! get dimensions
             v_dim(:)=1
             do i=1,v_ndim
                rc = nf_inq_dimlen(f_id,v_dimid(i),v_dim(i))
             enddo
!             print *, v_dim
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
          subroutine init_random_seed()
!!             use ifport
             implicit none
             integer, allocatable :: aseed(:)
             integer :: i, n, un, istat, dt(8), pid, t(2), s, ierr
             integer(8) :: count, tms
!
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
!             pid = getpid() + 1099279 ! Add a prime
             call pxfgetpid(pid,ierr)
             pid = pid + 1099279 ! Add a prime
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
!
          subroutine apm_pack(A_pck,A_unpck,nx,ny,nz,nl)
             implicit none
             integer                      :: nx,ny,nz,nl
             integer                      :: i,j,k,l,idx
             real,dimension(nx,ny,nz,nl)  :: A_unpck
             real,dimension(nx*ny*nz*nl)  :: A_pck
             idx=0
             do l=1,nl
                do k=1,nz
                   do j=1,ny
                      do i=1,nx
                         idx=idx+1
                         A_pck(idx)=A_unpck(i,j,k,l)
                      enddo
                   enddo
                enddo
             enddo
          end subroutine apm_pack
!
          subroutine apm_unpack(A_pck,A_unpck,nx,ny,nz,nl)
             implicit none
             integer                      :: nx,ny,nz,nl
             integer                      :: i,j,k,l,idx
             real,dimension(nx,ny,nz,nl)  :: A_unpck
             real,dimension(nx*ny*nz*nl)  :: A_pck
             idx=0
             do l=1,nl
                do k=1,nz
                   do j=1,ny
                      do i=1,nx
                         idx=idx+1
                         A_unpck(i,j,k,l)=A_pck(idx)
                      enddo
                   enddo
                enddo
             enddo
          end subroutine apm_unpack
!
          subroutine apm_pack_2d(A_pck,A_unpck,nx,ny,nz,nl)
             implicit none
             integer                      :: nx,ny,nz,nl
             integer                      :: i,j,k,l,idx
             real,dimension(nx,ny)        :: A_unpck
             real,dimension(nx*ny)        :: A_pck
             idx=0
             do j=1,ny
                do i=1,nx
                   idx=idx+1
                   A_pck(idx)=A_unpck(i,j)
                enddo
             enddo
          end subroutine apm_pack_2d
!
          subroutine apm_unpack_2d(A_pck,A_unpck,nx,ny,nz,nl)
             implicit none
             integer                      :: nx,ny,nz,nl
             integer                      :: i,j,k,l,idx
             real,dimension(nx,ny)        :: A_unpck
             real,dimension(nx*ny)        :: A_pck
             idx=0
             do j=1,ny
                do i=1,nx
                   idx=idx+1
                   A_unpck(i,j)=A_pck(idx)
                enddo
             enddo
          end subroutine apm_unpack_2d

