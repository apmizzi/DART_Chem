
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

! version controlled file description for error handling, do not edit
   character(len=*), parameter :: source   = 'perturb_chem_emiss_CORR_RT_MA_MPI.f90'
   character(len=*), parameter :: revision = ''
   character(len=*), parameter :: revdate  = ''
!
   integer                                  :: unit,unita,unitb,num_procs,rank,stat
   integer                                  :: nx,ny,nz,nzp,nz_chem,nz_fire,nz_biog
   integer                                  :: nchem_spcs,nfire_spcs,nbiog_spcs
   integer                                  :: i,ii,j,jj,k,kk,l,ll,isp,num_mem,imem,ierr
   integer                                  :: ngrid_corr
   integer                                  :: ii_str,ii_end,ii_npt,ii_sft
   integer                                  :: jj_str,jj_end,jj_npt,jj_sft
   integer                                  :: year,month,day,hour
   real                                     :: pi,grav,u_ran_1,u_ran_2,nnum_mem
   real                                     :: sprd_chem,sprd_fire,sprd_biog
   real                                     :: zdist,zfac,tmp,zmin,fac
   real                                     :: grid_length,vcov
   real                                     :: corr_lngth_hz
   real                                     :: corr_lngth_vt
   real                                     :: corr_lngth_tm
   real                                     :: corr_tm_delt
   real                                     :: wgt,wgt_summ,wgt_end
   real,allocatable,dimension(:)            :: pert_chem_sum_old
   real,allocatable,dimension(:)            :: pert_chem_sum_new
   real                                     :: mean,std,get_dist
   real                                     :: atime1,atime2,atime3,atime4,atime5,atime6
!
   real,allocatable,dimension(:)            :: tmp_arry
   real,allocatable,dimension(:,:)          :: xland,lat,lon
   real,allocatable,dimension(:,:,:)        :: geo_ht,wgt_sum
   real,allocatable,dimension(:,:,:,:)      :: A_chem,A_fire,A_biog
   real,allocatable,dimension(:,:,:)        :: pert_chem_old
   real,allocatable,dimension(:,:,:)        :: pert_chem_new
   real,allocatable,dimension(:,:,:)        :: pert_chem_end,pert_fire_end,pert_biog_end
   real,allocatable,dimension(:,:)          :: chem_data2d
   real,allocatable,dimension(:,:,:)        :: chem_data2d_sav,chem_data2d_sav1, chem_data2d_sav2
   real,allocatable,dimension(:,:)          :: chem_data2d_mean_prior
   real,allocatable,dimension(:,:)          :: chem_data2d_mean_post
   real,allocatable,dimension(:,:)          :: chem_data2d_sprd_prior
   real,allocatable,dimension(:,:)          :: chem_data2d_sprd_post
   real,allocatable,dimension(:,:)          :: chem_data2d_sprd_post_adj
   real,allocatable,dimension(:,:)          :: chem_data2d_frac
   real,allocatable,dimension(:,:,:)        :: chem_data3d
   real,allocatable,dimension(:,:,:,:)      :: chem_data3d_sav,chem_data3d_sav1, chem_data3d_sav2
   real,allocatable,dimension(:,:,:)        :: chem_data3d_sum
   real,allocatable,dimension(:,:,:)        :: chem_data3d_mean_prior
   real,allocatable,dimension(:,:,:)        :: chem_data3d_mean_post
   real,allocatable,dimension(:,:,:)        :: chem_data3d_sprd_prior
   real,allocatable,dimension(:,:,:)        :: chem_data3d_sprd_post
   real,allocatable,dimension(:,:,:)        :: chem_data3d_sprd_post_adj
   real,allocatable,dimension(:,:,:)        :: chem_data3d_frac
   real,allocatable,dimension(:,:,:)        :: chem_fac_mem_old, chem_fac_mem_new
   real,allocatable,dimension(:,:,:,:)      :: chem_fac_old,fire_fac_old,biog_fac_old
   real,allocatable,dimension(:,:,:,:)      :: chem_fac_new,fire_fac_new,biog_fac_new
   real,allocatable,dimension(:,:,:,:)      :: chem_fac_end,fire_fac_end,biog_fac_end
   real,allocatable,dimension(:,:,:,:)      :: chem_fac,fire_fac,biog_fac,dist
   real,allocatable,dimension(:)            :: mems,pers,pert_chem_sum
   character(len=150)                       :: pert_path_pr,pert_path_po
   character(len=150)                       :: wrfchemi,wrffirechemi,wrfbiogchemi
   character(len=20)                        :: cmem
!
   character(len=150)                       :: wrfchem_file,wrffire_file,wrfbiog_file
   character(len=150),allocatable,dimension(:) :: ch_chem_spc 
   character(len=150),allocatable,dimension(:) :: ch_fire_spc 
   character(len=150),allocatable,dimension(:) :: ch_biog_spc 
   logical                                  :: sw_corr_tm,sw_seed,sw_chem,sw_fire,sw_biog
   namelist /post_emiss_inflation_nml/nx,ny,nz,nz_chem,nchem_spcs,nfire_spcs, &
   pert_path_pr,pert_path_po,nnum_mem,wrfchemi,wrffirechemi,fac
   namelist /post_emiss_inflation_spec_nml/ch_chem_spc,ch_fire_spc
!
! Assign constants
   pi=4.*atan(1.)
   grav=9.8
   nz_fire=1
   nz_biog=1
   zfac=2.
   zmin=1.e-10
!
! Read control namelist
   unit=20
   open(unit=unit,file='post_emiss_inflation_nml.nl',form='formatted', &
   status='old',action='read')
   read(unit,post_emiss_inflation_nml)
   close(unit)
   print *, 'nx                 ',nx
   print *, 'ny                 ',ny
   print *, 'nz                 ',nz
   print *, 'nz_chem            ',nz_chem
   print *, 'nchem_spcs         ',nchem_spcs
   print *, 'nfire_spcs         ',nfire_spcs
   print *, 'pert_path_pr       ',trim(pert_path_pr)
   print *, 'pert_path_po       ',trim(pert_path_po)
   print *, 'num_mem            ',nnum_mem
   print *, 'wrfchemi           ',trim(wrfchemi)
   print *, 'wrffirechemi       ',trim(wrffirechemi)
   print *, 'fac                ',fac
   num_mem=nint(nnum_mem)
!
! Allocate arrays
   allocate(ch_chem_spc(nchem_spcs))
   allocate(ch_fire_spc(nfire_spcs))
!
! Read the species namelist
   unit=20
   open(unit=unit,file='post_emiss_inflation_spec_nml.nl',form='formatted', &
   status='old',action='read')
   read(unit,post_emiss_inflation_spec_nml)
   close(unit)
!
! Posterior emissions inflation
!
! Anthropogenic emissions
  allocate(chem_data3d(nx,ny,nz_chem))
  do isp=1,nchem_spcs
     print *, 'Post inflation for the chemi EMISSs ',trim(ch_chem_spc(isp))
     allocate(chem_data3d_sav(nx,ny,nz_chem,num_mem))
     allocate(chem_data3d_sav1(nx,ny,nz_chem,num_mem))
     allocate(chem_data3d_sav2(nx,ny,nz_chem,num_mem))
     do imem=1,num_mem
        if(imem.ge.0.and.imem.lt.10) write(cmem,"('.e00',i1)"),imem
        if(imem.ge.10.and.imem.lt.100) write(cmem,"('.e0',i2)"),imem
        if(imem.ge.100.and.imem.lt.1000) write(cmem,"('.e',i3)"),imem
        wrfchem_file=trim(wrfchemi)//trim(cmem)//trim('_old')
        call get_WRFCHEM_emiss_data(wrfchem_file,ch_chem_spc(isp),chem_data3d,nx,ny,nz_chem)
        do i=1,nx
           do j=1,ny
              do k=1,nz_chem
                 chem_data3d_sav(i,j,k,imem)=chem_data3d(i,j,k)
              enddo
           enddo
        enddo
     enddo
!
     allocate(mems(num_mem),pers(num_mem))
     allocate(chem_data3d_mean_prior(nx,ny,nz_chem))
     allocate(chem_data3d_sprd_prior(nx,ny,nz_chem))
     allocate(chem_data3d_mean_post(nx,ny,nz_chem))
     allocate(chem_data3d_sprd_post(nx,ny,nz_chem))
     allocate(chem_data3d_sprd_post_adj(nx,ny,nz_chem))
     do i=1,nx
        do j=1,ny
           do k=1,nz_chem
              mems(:)=chem_data3d_sav(i,j,k,1:num_mem)
              mean=sum(mems)/real(num_mem)
              pers(:)=(mems(:)-mean)*(mems(:)-mean)
              std=sqrt(sum(pers)/real(num_mem-1))
              chem_data3d_mean_prior(i,j,k)=mean
              chem_data3d_sprd_prior(i,j,k)=std
           enddo
        enddo
     enddo

! Read in posterior ensemble member and adjust spread
     do imem=1,num_mem
        if(imem.ge.0.and.imem.lt.10) write(cmem,"('.e00',i1)"),imem
        if(imem.ge.10.and.imem.lt.100) write(cmem,"('.e0',i2)"),imem
        if(imem.ge.100.and.imem.lt.1000) write(cmem,"('.e',i3)"),imem
        wrfchem_file=trim(wrfchemi)//trim(cmem)
        call get_WRFCHEM_emiss_data(wrfchem_file,ch_chem_spc(isp),chem_data3d,nx,ny,nz_chem)
        do i=1,nx
           do j=1,ny
              do k=1,nz_chem
                     chem_data3d_sav1(i,j,k,imem)=chem_data3d(i,j,k)
              enddo
           enddo
        enddo
     enddo
!
     do i=1,nx
        do j=1,ny
           do k=1,nz_chem
              mems(:)=chem_data3d_sav1(i,j,k,1:num_mem)
              mean=sum(mems)/real(num_mem)
              pers(:)=(mems(:)-mean)*(mems(:)-mean)
              std=sqrt(sum(pers)/real(num_mem-1))
              chem_data3d_mean_post(i,j,k)=mean
              chem_data3d_sprd_post(i,j,k)=std
           enddo
        enddo
     enddo
!
! Posterior inflation to 50% of prior spread
     do i=1,nx
        do j=1,ny
           do k=1,nz_chem
              mems(:)=chem_data3d_sav1(i,j,k,1:num_mem)
              mean=sum(mems)/real(num_mem)
              chem_data3d_sav2(i,j,k,1:num_mem) = mems(:)
              if (chem_data3d_sprd_prior(i,j,k) .gt. 0. .and. chem_data3d_sprd_post(i,j,k) .gt. 0. &
              .and. chem_data3d_sprd_post(i,j,k) .lt. fac*chem_data3d_sprd_prior(i,j,k)) then
                 chem_data3d_sav2(i,j,k,1:num_mem) = (mems(:) - mean)* &
                 (fac*chem_data3d_sprd_prior(i,j,k))/chem_data3d_sprd_post(i,j,k) + mean
              endif
              mems(:)=chem_data3d_sav2(i,j,k,1:num_mem)
              mean=sum(mems)/real(num_mem)
              pers(:)=(mems(:)-mean)*(mems(:)-mean)                             
              std=sqrt(sum(pers)/real(num_mem-1)) 
              chem_data3d_sprd_post_adj(i,j,k)=std                       
           enddo
        enddo
     enddo
!          
     do imem=1,num_mem                      
        if(imem.ge.0.and.imem.lt.10) write(cmem,"('.e00',i1)"),imem
        if(imem.ge.10.and.imem.lt.100) write(cmem,"('.e0',i2)"),imem
        if(imem.ge.100.and.imem.lt.1000) write(cmem,"('.e',i3)"),imem
        wrfchem_file=trim(wrfchemi)//trim(cmem)
!
! remove negative value
        do i=1,nx
           do j=1,ny
              do k=1,nz_chem
                 if (chem_data3d_sav2(i,j,k,imem) .lt. 0) then
                    chem_data3d_sav2(i,j,k,imem)=0
                 endif
              enddo
           enddo
        enddo
        call put_WRFCHEM_emiss_data(wrfchem_file,ch_chem_spc(isp),chem_data3d_sav2(:,:,:,imem),nx,ny,nz_chem)
     enddo
     deallocate(mems,pers)                   
     wrfchem_file=trim(wrfchemi)//'_sprd_post'
     print *, 'put the spread ',trim(wrfchem_file)
     call put_WRFCHEM_emiss_data(wrfchem_file,ch_chem_spc(isp),chem_data3d_sprd_post,nx,ny,nz_chem)
     wrfchem_file=trim(wrfchemi)//'_sprd_post_adj'
     print *, 'put the spread ',trim(wrfchem_file)
     call put_WRFCHEM_emiss_data(wrfchem_file,ch_chem_spc(isp),chem_data3d_sprd_post_adj,nx,ny,nz_chem)
!
     deallocate(chem_data3d_sav)
     deallocate(chem_data3d_sav1)
     deallocate(chem_data3d_sav2)
     deallocate(chem_data3d_mean_prior)
     deallocate(chem_data3d_sprd_prior)
     deallocate(chem_data3d_mean_post)
     deallocate(chem_data3d_sprd_post)                     
     deallocate(chem_data3d_sprd_post_adj) 
  enddo
  deallocate(chem_data3d)
!
! Biomass burning emissions
  allocate(chem_data3d(nx,ny,1))
  do isp=1,nfire_spcs
     print *, 'Post inflation for the firechemi EMISSs ',trim(ch_fire_spc(isp))
     allocate(chem_data2d_sav(nx,ny,num_mem))
     allocate(chem_data2d_sav1(nx,ny,num_mem))
     allocate(chem_data2d_sav2(nx,ny,num_mem))
     do imem=1,num_mem
        if(imem.ge.0.and.imem.lt.10) write(cmem,"('.e00',i1)"),imem
        if(imem.ge.10.and.imem.lt.100) write(cmem,"('.e0',i2)"),imem
        if(imem.ge.100.and.imem.lt.1000) write(cmem,"('.e',i3)"),imem
        wrfchem_file=trim(wrffirechemi)//trim(cmem)//trim('_old')
        call get_WRFCHEM_emiss_data(wrfchem_file,ch_fire_spc(isp),chem_data3d,nx,ny,1)
        do i=1,nx
           do j=1,ny
              chem_data2d_sav(i,j,imem)=chem_data3d(i,j,1)
           enddo
        enddo
     enddo
!
     allocate(mems(num_mem),pers(num_mem))
     allocate(chem_data2d_mean_prior(nx,ny))
     allocate(chem_data2d_sprd_prior(nx,ny))
     allocate(chem_data2d_mean_post(nx,ny))
     allocate(chem_data2d_sprd_post(nx,ny))
     allocate(chem_data2d_sprd_post_adj(nx,ny))
     do i=1,nx
        do j=1,ny
           mems(:)=chem_data2d_sav(i,j,1:num_mem)
           mean=sum(mems)/real(num_mem)
           pers(:)=(mems(:)-mean)*(mems(:)-mean)
           std=sqrt(sum(pers)/real(num_mem-1))
           chem_data2d_mean_prior(i,j)=mean
           chem_data2d_sprd_prior(i,j)=std
        enddo
     enddo
!
! Read in posterior ensemble member and adjust spread
     do imem=1,num_mem
        if(imem.ge.0.and.imem.lt.10) write(cmem,"('.e00',i1)"),imem
        if(imem.ge.10.and.imem.lt.100) write(cmem,"('.e0',i2)"),imem
        if(imem.ge.100.and.imem.lt.1000) write(cmem,"('.e',i3)"),imem
        wrfchem_file=trim(wrffirechemi)//trim(cmem)
        call get_WRFCHEM_emiss_data(wrfchem_file,ch_fire_spc(isp),chem_data3d,nx,ny,1)
        do i=1,nx
           do j=1,ny
              chem_data2d_sav1(i,j,imem)=chem_data3d(i,j,1)
           enddo
        enddo
     enddo
!
     do i=1,nx
        do j=1,ny
           mems(:)=chem_data2d_sav1(i,j,1:num_mem)
           mean=sum(mems)/real(num_mem)
           pers(:)=(mems(:)-mean)*(mems(:)-mean)
           std=sqrt(sum(pers)/real(num_mem-1))
           chem_data2d_mean_post(i,j)=mean
           chem_data2d_sprd_post(i,j)=std
        enddo
     enddo
!
! Posterior inflation to 50% of prior spread
     do i=1,nx
        do j=1,ny
           mems(:)=chem_data2d_sav1(i,j,1:num_mem)
           mean=sum(mems)/real(num_mem)
           chem_data2d_sav2(i,j,1:num_mem) = mems(:)
!
           if (chem_data2d_sprd_prior(i,j) .gt. 0. .and. chem_data2d_sprd_post(i,j) .gt. 0. &
           .and. chem_data2d_sprd_post(i,j) .lt. fac*chem_data2d_sprd_prior(i,j)) then
              chem_data2d_sav2(i,j,1:num_mem) = (mems(:) - mean)* &
              (fac*chem_data2d_sprd_prior(i,j))/chem_data2d_sprd_post(i,j) + mean
           endif
           mems(:)=chem_data2d_sav2(i,j,1:num_mem)
           mean=sum(mems)/real(num_mem)
           pers(:)=(mems(:)-mean)*(mems(:)-mean)                             
           std=sqrt(sum(pers)/real(num_mem-1)) 
           chem_data2d_sprd_post_adj(i,j)=std                       
        enddo
     enddo
!          
     do imem=1,num_mem                      
        if(imem.ge.0.and.imem.lt.10) write(cmem,"('.e00',i1)"),imem
        if(imem.ge.10.and.imem.lt.100) write(cmem,"('.e0',i2)"),imem
        if(imem.ge.100.and.imem.lt.1000) write(cmem,"('.e',i3)"),imem
        wrfchem_file=trim(wrffirechemi)//trim(cmem)
!
! remove negative value
        do i=1,nx
           do j=1,ny
              if (chem_data2d_sav2(i,j,imem) .lt. 0) then
                 chem_data2d_sav2(i,j,imem)=0
              endif
           enddo
        enddo
        chem_data3d_sav2(:,:,1,imem)=chem_data2d_sav2(:,:,imem)
        call put_WRFCHEM_emiss_data(wrfchem_file,ch_fire_spc(isp),chem_data3d_sav2(:,:,1,imem),nx,ny,1)
     enddo
     deallocate(mems,pers)                   
     wrfchem_file=trim(wrffirechemi)//'_sprd_post'
     print *, 'put the spread ',trim(wrfchem_file)
     chem_data3d(:,:,1)=chem_data2d_sprd_post(:,:)
     call put_WRFCHEM_emiss_data(wrfchem_file,ch_fire_spc(isp),chem_data3d,nx,ny,1)
     wrfchem_file=trim(wrffirechemi)//'_sprd_post_adj'
     print *, 'put the spread ',trim(wrfchem_file)
     chem_data3d(:,:,1)=chem_data2d_sprd_post_adj(:,:)
     call put_WRFCHEM_emiss_data(wrfchem_file,ch_fire_spc(isp),chem_data3d,nx,ny,1)
!
     deallocate(chem_data2d_sav)
     deallocate(chem_data2d_sav1)
     deallocate(chem_data2d_sav2)
     deallocate(chem_data2d_mean_prior)
     deallocate(chem_data2d_sprd_prior)
     deallocate(chem_data2d_mean_post)
     deallocate(chem_data2d_sprd_post)                     
     deallocate(chem_data2d_sprd_post_adj) 
  enddo
  deallocate(chem_data3d)
end program
!
          function get_dist(lat1,lat2,lon1,lon2)
! returns distance in km
             implicit none
             real:: lat1,lat2,lon1,lon2,get_dist
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
!
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
!             rc = nf_close(f_id)
!             rc = nf_open(trim(file),NF_WRITE,f_id)
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
!
          subroutine init_random_seed(rank,year,month,day,hour)

            use iso_fortran_env, only: int64
            implicit none
            integer, allocatable :: seed(:)
            integer :: i, n, un, istat, dt(8), pid, ierr
            integer :: rank,year,month,day,hour
            integer(int64) :: t

            call random_seed(size = n)
            allocate(seed(n))

                  t = (year - 1970) * 365_int64 * 24 * 60 * 60 * 1000 &
                       + month * 31_int64 * 24 * 60 * 60 * 1000 &
                       + day * 24_int64 * 60 * 60 * 1000 &
                       + hour * 60 * 60 * 1000 &
                       + rank * 1011
                 print*, t

               do i = 1, n
                  seed(i) = lcg(t)
               end do

               print*,  rank, seed(:)

            call random_seed(put=seed)

          contains
            ! This simple PRNG might not be good enough for real work,
            ! but is
            ! sufficient for seeding a better PRNG.
            function lcg(s)
              integer :: lcg
              integer(int64) :: s
              if (s == 0) then
                 s = 104729
              else
                 s = mod(s, 4294967296_int64)
              end if
              s = mod(s * 279470273_int64, 4294967291_int64)
              lcg = int(mod(s, int(huge(0), int64)), kind(0))
            end function lcg
          end subroutine init_random_seed
!
          subroutine init_const_random_seed(rank,date)
             implicit none
             integer                          :: rank,date,primes_dim
             integer                          :: n,at,found,i,str
             integer,allocatable,dimension(:) :: primes,aseed
             logical                          :: is_prime
!             
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
