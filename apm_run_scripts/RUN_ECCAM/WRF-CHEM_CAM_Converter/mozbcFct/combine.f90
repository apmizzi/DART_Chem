
   program combine

   implicit none

   integer :: n
   integer :: ncid, dimid, varid
   integer :: lonid, latid, timid
   integer :: nlon, nlat, ntimes
   integer :: astat, ios, nfstat

   real, allocatable :: psurf(:,:,:)

   character(len=64) :: filename

   include 'netcdf.inc'

!---------------------------------------------------------------------------
!  open surface pressure file
!---------------------------------------------------------------------------
   write(*,*) 'Enter pressure filename'
   read(*,'(a)',iostat=ios) filename
   if( ios /= 0 ) then
     write(*,*) 'Combine: failed to read filename; error = ',ios
     stop 'Read err'
   endif

   nfstat = nf_open( trim(filename), nf_nowrite, ncid ) 
   if( nfstat /= nf_noerr ) then
     write(*,*) 'combine: failed to open ',trim(filename),' ; error = ',nfstat
     stop 'File err'
   else
     write(*,*) 'combine: opened ',trim(filename)
   endif

!---------------------------------------------------------------------------
!  get times
!---------------------------------------------------------------------------
   nfstat = nf_inq_dimid( ncid, 'time', timid )
   if( nfstat /= nf_noerr ) then
     write(*,*) 'combine: failed to get time id; error = ',nfstat
     stop 'Dim id err'
   endif
   nfstat = nf_inq_dimlen( ncid, timid, ntimes )
   if( nfstat /= nf_noerr ) then
     write(*,*) 'combine: failed to get time dim; error = ',nfstat
     stop 'Dim err'
   else
     write(*,*) 'combine: time size = ',ntimes
   endif
!---------------------------------------------------------------------------
!  get lons
!---------------------------------------------------------------------------
   nfstat = nf_inq_dimid( ncid, 'lon', lonid )
   if( nfstat /= nf_noerr ) then
     write(*,*) 'combine: failed to get lon id; error = ',nfstat
     stop 'Dim id err'
   endif
   nfstat = nf_inq_dimlen( ncid, lonid, nlon )
   if( nfstat /= nf_noerr ) then
     write(*,*) 'combine: failed to get lon dim; error = ',nfstat
     stop 'Dim err'
   else
     write(*,*) 'combine: lon size = ',nlon
   endif
!---------------------------------------------------------------------------
!  get lats
!---------------------------------------------------------------------------
   nfstat = nf_inq_dimid( ncid, 'lat', latid )
   if( nfstat /= nf_noerr ) then
     write(*,*) 'combine: failed to get lat id; error = ',nfstat
     stop 'Dim id err'
   endif
   nfstat = nf_inq_dimlen( ncid, lonid, nlat )
   if( nfstat /= nf_noerr ) then
     write(*,*) 'combine: failed to get lat dim; error = ',nfstat
     stop 'Dim err'
   else
     write(*,*) 'combine: lat size = ',nlat
   endif
!---------------------------------------------------------------------------
!  allocate surface pressure variable
!---------------------------------------------------------------------------
   allocate( psurf(nlon,nlat,ntimes),stat=astat )
   if( astat /= 0 ) then
     write(*,*) 'combine: failed to allocate psurf; error = ',astat
     stop 'Alloc err'
   endif
!---------------------------------------------------------------------------
!  read surface pressure
!---------------------------------------------------------------------------
   nfstat = nf_inq_varid( ncid, 'lnsp', varid )
   if( nfstat /= nf_noerr ) then
     write(*,*) 'combine: failed to get lnsp id; error = ',nfstat
     stop 'Var id err'
   endif
   nfstat = nf_get_var_real( ncid, varid, psurf )
   if( nfstat /= nf_noerr ) then
     write(*,*) 'combine: failed to read lnsf; error = ',nfstat
     stop 'Read err'
   endif

   psurf(:,:,:) = exp( psurf(:,:,:) )

   write(*,*) ' '
   write(*,*) 'Combine: psrf at lon,lat == 1'
   do n = 1,ntimes,4
     write(*,'(1p,5g15.7)') psurf(1,1,n:min(ntimes,n+4))
   end do

   write(*,*) ' '
   write(*,*) 'Combine: psrf at lat,time == 1'
   do n = 1,nlon,4
     write(*,'(1p,5g15.7)') psurf(n:min(nlon,n+4),1,1)
   end do

   write(*,*) ' '
   write(*,*) 'Combine: psrf at lon,time == 1'
   do n = 1,nlat,4
     write(*,'(1p,5g15.7)') psurf(1,n:min(nlat,n+4),1)
   end do

   nfstat = nf_close( ncid )

!---------------------------------------------------------------------------
!  open source input/output file
!---------------------------------------------------------------------------
   write(*,*) ' '
   write(*,*) 'Enter base ECMWF filename'
   read(*,'(a)',iostat=ios) filename
   if( ios /= 0 ) then
     write(*,*) 'Combine: failed to read filename; error = ',ios
     stop 'Read err'
   endif

   nfstat = nf_open( trim(filename), nf_write, ncid ) 
   write(*,*) ' '
   if( nfstat /= nf_noerr ) then
     write(*,*) 'combine: failed to open ',trim(filename),' ; error = ',nfstat
     stop 'File err'
   else
     write(*,*) 'combine: opened ',trim(filename)
   endif
!---------------------------------------------------------------------------
!  get times
!---------------------------------------------------------------------------
   nfstat = nf_inq_dimid( ncid, 'time', timid )
   if( nfstat /= nf_noerr ) then
     write(*,*) 'combine: failed to get time id; error = ',nfstat
     stop 'Dim id err'
   endif
!---------------------------------------------------------------------------
!  get lons
!---------------------------------------------------------------------------
   nfstat = nf_inq_dimid( ncid, 'lon', lonid )
   if( nfstat /= nf_noerr ) then
     write(*,*) 'combine: failed to get lon id; error = ',nfstat
     stop 'Dim id err'
   endif
!---------------------------------------------------------------------------
!  get lats
!---------------------------------------------------------------------------
   nfstat = nf_inq_dimid( ncid, 'lat', latid )
   if( nfstat /= nf_noerr ) then
     write(*,*) 'combine: failed to get lat id; error = ',nfstat
     stop 'Dim id err'
   endif

   nfstat = nf_redef( ncid )
   if( nfstat /= nf_noerr ) then
     write(*,*) 'combine: failed to enter define mode; error = ',nfstat
     stop 'Define err'
   endif

   nfstat = nf_def_var( ncid, 'psurf', NF_FLOAT, 3, (/ lonid,latid,timid /), varid )
   if( nfstat /= nf_noerr ) then
     write(*,*) 'combine: failed to define psurf; error = ',nfstat
     stop 'Define err'
   endif

   nfstat = nf_enddef( ncid )
   if( nfstat /= nf_noerr ) then
     write(*,*) 'combine: failed to leave define mode; error = ',nfstat
     stop 'Define err'
   endif

!---------------------------------------------------------------------------
!  write psurf
!---------------------------------------------------------------------------
   nfstat = nf_put_var_real( ncid, varid, psurf )
   if( nfstat /= nf_noerr ) then
     write(*,*) 'combine: failed to write psurf; error = ',nfstat
     stop 'Write err'
   endif

   nfstat = nf_close( ncid )

   deallocate( psurf )

   end program combine
