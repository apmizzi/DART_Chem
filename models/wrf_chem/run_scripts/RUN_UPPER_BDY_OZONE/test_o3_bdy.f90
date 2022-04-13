!-------------------------------------------------------------------------------
!
! ifort -C test_o3_bdy.f90 -o test_o3_bdy.exe -I$NETCDF_DIR/include -L$NETCDF_DIR/lib -lnetcdff -lnetcdf
!
program main
!
   implicit none
!  
   integer                                          :: nx,ny,nz,ntim
   integer,allocatable,dimension(:)                 :: date
   real,allocatable,dimension(:)                    :: lon_glb
   real,allocatable,dimension(:)                    :: lat_glb
   real,allocatable,dimension(:)                    :: prs_glb
   real,allocatable,dimension(:,:,:,:)              :: o3_glb
   character(len=120)                               :: data_file
! 
   nx=17
   ny=13
   nz=56
   ntim=368
!______________________________________________________________________________________________   
!
! Read the upper boundary large scale data (do this once)
!______________________________________________________________________________________________   
!
   data_file='/nobackupp11/amizzi/INPUT_DATA/FRAPPE_REAL_TIME_DATA/mozart_forecasts/h0004.nc'
!
   allocate(date(ntim))   
   call get_MOZART_INT_DATA(data_file,'date',ntim,1,1,1,date)
!
   allocate(prs_glb(nz))   
   call get_MOZART_REAL_DATA(data_file,'lev',nz,1,1,1,prs_glb)
!
   allocate(lat_glb(ny))   
   call get_MOZART_REAL_DATA(data_file,'lat',ny,1,1,1,lat_glb)
   print *, lat_glb
   stop
!
   allocate(lon_glb(nx))   
   call get_MOZART_REAL_DATA(data_file,'lon',nx,1,1,1,lon_glb)
!
   allocate(o3_glb(nx,ny,nz,ntim))   
   call get_MOZART_REAL_DATA(data_file,'O3_VMR_inst',nx,ny,nz,ntim,o3_glb)
end

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
!print *, v_id
if(rc.ne.0) then
   print *, 'nf_inq_varid error ', v_id
   stop
endif
!
! get dimension identifiers
v_dimid=0
rc = nf_inq_var(f_id,v_id,v_nam,typ,v_ndim,v_dimid,natts)
!print *, v_dimid
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
!print *, v_dim
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
!print *, 'f_id ',f_id
!
if(rc.ne.0) then
   print *, 'nf_open error ',trim(file)
   stop
endif
!
! get variables identifiers
rc = nf_inq_varid(f_id,trim(name),v_id)
!print *, 'v_id ',v_id
!
if(rc.ne.0) then
   print *, 'nf_inq_varid error ', v_id
   stop
endif
!
! get dimension identifiers
v_dimid=0
rc = nf_inq_var(f_id,v_id,v_nam,typ,v_ndim,v_dimid,natts)
!print *, 'v_dimid ',v_dimid
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
!print *, 'v_dim ',v_dim
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
!print *, 'fld ', fld(1,1,1,1),fld(nx/2,ny/2,nz/2,ntim/2),fld(nx,ny,nz,ntim)
!
if(rc.ne.0) then
   print *, 'nf_get_vara_real ', fld(1,1,1,1)
   stop
endif
rc = nf_close(f_id)
return
  
end subroutine get_MOZART_REAL_DATA
