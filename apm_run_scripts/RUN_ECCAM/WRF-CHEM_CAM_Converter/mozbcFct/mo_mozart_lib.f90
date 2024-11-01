
      module module_mozart_lib

      implicit none

!---------------------------------------------------------------
!     include files
!---------------------------------------------------------------
      include 'netcdf.inc'

!---------------------------------------------------------------
!     public procedures
!---------------------------------------------------------------
      public  :: init_mozart_lib
      public  :: bc_interpolate4d
      public  :: ic_interpolate4d
      public  :: exit_mozart_lib
      public  :: get_moz_time_ndx

!---------------------------------------------------------------
!     private procedures
!---------------------------------------------------------------
      private :: handle_error
      private :: lotim

!---------------------------------------------------------------
!     public variables
!---------------------------------------------------------------
      integer, public  :: nlon, nlat, nlev                    ! data dimension length
      integer, public  :: lon_dimid, lat_dimid, lev_dimid     ! data dimension ids
      integer, public  :: year, month, day
      integer, public  :: hour, minute, second
      integer, public  :: ntime_m
      real, public     :: p_moz_fac = 1.
      real, public, allocatable :: moz_times(:)
      logical, public  :: invert_p_moz = .false.
      character(len=9) :: moz_var_suffix  = '_VMR_inst'
      character(len=16) :: moz_var_prefix = ' '
      character(len=16) :: src_model = 'MOZART'
      character(len=16) :: src_ps_name = 'PS'
      character(len=16) :: press_a = 'hyam'
      character(len=16) :: press_b = 'hybm'

!---------------------------------------------------------------
!     variables for reading netCDF data
!---------------------------------------------------------------
      integer, private :: ncid = 0                           ! netCDF file ID
      integer, private :: nstt(4), ncnt(4)                   ! start index and counter array
      integer, private :: start_index = 1                    ! monthly mean data
      integer, private :: ntime                              ! data dimension length
      integer, private :: nscalar, nstring                   ! data dimension length
      logical, private :: src_lons_are_nonneg
      logical          :: src_lons_are_periodic
      logical, private :: reorder_lats
      integer, allocatable :: moz_date(:)
      integer, allocatable :: moz_datesec(:) 

!---------------------------------------------------------------
!     variables used for interpolation
!---------------------------------------------------------------
      real, public :: ps0 = 1.e5

!     integer, private, allocatable :: ix(:,:,:)
!     integer, private, allocatable :: jy(:,:,:)                        ! index used by interpolation
!     real, private, allocatable    :: ax(:,:,:)                        ! weight coef. all domain
!     real, private, allocatable    :: by(:,:,:)                        ! weight coef. all domain
!     real, private, allocatable    :: mozval(:,:,:)
!     real, private, allocatable    :: tmpval(:,:,:)
!     real, private, allocatable    :: ps_moz(:,:)
!     real, private, allocatable    :: ps_mozi(:,:)
!     real, private, allocatable    :: hyam(:)
!     real, private, allocatable    :: hybm(:)
      integer, allocatable :: ix(:,:,:)
      integer, allocatable :: jy(:,:,:)                        ! index used by interpolation
      real, allocatable    :: ax(:,:,:)                        ! weight coef. all domain
      real, allocatable    :: by(:,:,:)                        ! weight coef. all domain
      real, allocatable    :: mozval(:,:,:)
      real, allocatable    :: tmpval(:,:,:)
      real, allocatable    :: ps_moz(:,:)
      real, allocatable    :: ps_mozi(:,:)
      real, allocatable    :: hyam(:)
      real, allocatable    :: hybm(:)

!---------------------------------------------------------------
!     debugging
!---------------------------------------------------------------
      integer :: dbg_i = 1, dbg_j = 1
      character(len=16) :: dbg_species = ''

      type t_type
        integer :: ndx
        integer :: ncid_lo, ncid_hi
        integer :: lo_moz_ndx, hi_moz_ndx
        integer :: lo_buf_ndx, hi_buf_ndx
        integer :: gap_date, gap_secs
        real    :: dels
        real, pointer :: conc(:,:,:,:)
        real, pointer :: ps(:,:,:)
        logical :: in_gap
        logical :: t_interp
      end type t_type

      type(t_type), private :: time_type

      contains

      subroutine init_mozart_lib( moz_dir, moz_fn, x2d, y2d, wrf_date, &
                                  wrf_datesec, wrf_lons_are_nonneg, nx, ny, nspec )
!---------------------------------------------------------------
!     initialize netcdf file
!---------------------------------------------------------------

      use mo_calendar, only : diffdat
      use utils,       only : wrf2mz_map, toupper

!---------------------------------------------------------------
!     dummy arguments
!---------------------------------------------------------------
      integer, intent(in)      :: wrf_date
      integer, intent(in)      :: wrf_datesec
      integer, intent(in)      :: nx, ny
      integer, intent(in)      :: nspec
      character(*), intent(in) :: moz_dir
      character(*), intent(inout) :: moz_fn
      real, intent(in)         :: x2d(nx,ny)
      real, intent(in)         :: y2d(nx,ny)
      logical, intent(in)      :: wrf_lons_are_nonneg

!---------------------------------------------------------------
!     local variables
!---------------------------------------------------------------
      integer :: status, tstat
      integer :: dimid, varid
      integer :: i, j, k, n 
      integer :: jwrk, ju
      integer :: vid
      real    :: model_x, model_y, model_dx, src_dx, tst_lon
      real    :: wrf_lons(nx,ny)
      real, allocatable  :: x1d(:), y1d(:)
      character(len=128) :: filenm
      character(len=32)  :: spcnam
      character(len=16)  :: wrk_str
      logical            :: has_press_a
      logical            :: has_lon_offset
      logical            :: monotonic

      filenm = trim( moz_dir ) // adjustl( moz_fn )
!---------------------------------------------------------------
!     open the initial mozart netCDF file
!---------------------------------------------------------------
      status = nf_open( trim(filenm), nf_nowrite, ncid )
      if( status /= nf_noerr ) then
         write(*,*) 'failed to open ',trim(filenm)
         call handle_error( status )
      end if
      write(*,*) 'init_mozart_lib: opened ',trim(filenm)

!---------------------------------------------------------------
!     read times
!---------------------------------------------------------------
      call read_moz_times( ncid )

      write(*,*) 'init_mozart_lib: moz time diagnostic'
      write(*,'(''n_moz_times = '',i6)') ntime_m
      write(*,*) 'moz_dates'
      do n = 1,ntime_m,5
        write(*,'(5i12)') moz_date(n:min(n+4,ntime_m))
      end do
      write(*,*) 'moz_datesecs'
      do n = 1,ntime_m,5
        write(*,'(5i12)') moz_datesec(n:min(n+4,ntime_m))
      end do
!     stop 'Debugging'

      time_type%ndx = lotim( wrf_date, wrf_datesec, moz_date, moz_datesec, ntime_m )
      if( time_type%ndx == 0 ) then
        status = nf_close( ncid )
        call next_flnm( moz_fn, .false. )
        filenm = trim( moz_dir ) // adjustl( moz_fn )
!---------------------------------------------------------------
!     open the initial mozart netCDF file
!---------------------------------------------------------------
        status = nf_open( trim(filenm), nf_nowrite, ncid )
        if( status /= nf_noerr ) then
          write(*,*) 'failed to open ',trim(filenm)
          call handle_error( status )
        end if
        write(*,*) 'init_mozart_lib: opened ',trim(filenm)
        call read_moz_times( ncid )
        time_type%ndx = lotim( wrf_date, wrf_datesec, moz_date, moz_datesec, ntime_m )
        if( time_type%ndx == 0 ) then
          write(*,*) 'init_mozart_lib: time ',wrf_date,' ',wrf_datesec
          write(*,*) '                 is before '
          write(*,*) '                 ',moz_date(1),' ',moz_datesec(1)
          write(*,*) '                 the first time in mozart file ',trim(moz_fn)
          stop
        end if
      end if
!---------------------------------------------------------------
!     check mozart variables
!---------------------------------------------------------------
      call chk_moz_vars( nspec, filenm )

!---------------------------------------------------------------
!     get the longitude dimension length of the src data
!---------------------------------------------------------------
      status = nf_inq_dimid( ncid, 'lon', lon_dimid )
      if( status /= nf_noerr )  call handle_error( status )

      status = nf_inq_dimlen( ncid, lon_dimid, nlon )
      if( status /= nf_noerr )  call handle_error( status )

!---------------------------------------------------------------
!     get the latitude dimension length of the src data
!---------------------------------------------------------------
      status = nf_inq_dimid( ncid, 'lat', lat_dimid )
      if( status /= nf_noerr )  call handle_error( status )

      status = nf_inq_dimlen( ncid, lat_dimid, nlat )
      if( status /= nf_noerr )  call handle_error( status )

!---------------------------------------------------------------
!     get the vertical dimension length of the src data
!---------------------------------------------------------------
      status = nf_inq_dimid( ncid, 'lev', lev_dimid )
      if( status /= nf_noerr )  call handle_error( status )

      status = nf_inq_dimlen( ncid, lev_dimid, nlev )
      if( status /= nf_noerr )  call handle_error( status )

!---------------------------------------------------------------
!     read vertical coordinates
!---------------------------------------------------------------
      allocate( hyam(nlev), hybm(nlev), stat=status )
      if( status /= 0 ) then
         write(*,*) 'failed to allocate hyam, hybm; error = ',status
         stop
      end if

      has_press_a = .false.
      wrk_str = press_a
      call toupper( wrk_str )
      if( wrk_str /= 'NONE' ) then
        status = nf_inq_varid( ncid, trim(press_a), varid )
        if( status /= nf_noerr )  call handle_error( status )

        status = nf_get_var_real( ncid, varid, hyam )
        if( status /= nf_noerr )  call handle_error( status )

        status = nf_inq_varid( ncid, 'p0', varid )
        if( status == nf_noerr ) then
          status = nf_get_var_real( ncid, varid, ps0 )
          if( status /= nf_noerr )  then
            call handle_error( status )
          endif
        elseif( trim(src_model) == 'ECMWF' ) then
          ps0 = 1.
        endif
        has_press_a = .true.
      endif

      wrk_str = press_b
      call toupper( wrk_str )
      if( wrk_str /= 'NONE' ) then
        status = nf_inq_varid( ncid, trim(press_b), varid )
        if( status /= nf_noerr )  call handle_error( status )

        status = nf_get_var_real( ncid, varid, hybm )
        if( status /= nf_noerr )  call handle_error( status )
      else
        if( .not. has_press_a ) then
          hyam(:) = 0.
        endif
      endif

!---------------------------------------------------------------
!     read longitudes
!---------------------------------------------------------------
      allocate( x1d(nlon), y1d(nlat), stat=status )
      if( status /= 0 ) then
         write(*,*) 'failed to allocate x1d, y1d; error = ',status
         stop
      end if

      status = nf_inq_varid( ncid, 'lon', varid )
      if( status /= nf_noerr )  call handle_error( status )

      status = nf_get_var_real( ncid, varid, x1d )
      if( status /= nf_noerr )  call handle_error( status )

!---------------------------------------------------------------
!     check longitudes for monotonicity
!---------------------------------------------------------------
      monotonic = .true.
      do n = 2,nlon-1
        if( (x1d(n+1) - x1d(n))*(x1d(n) - x1d(n-1)) <= 0. ) then
          monotonic = .false.
          exit
        endif
      end do
      if( .not. monotonic ) then
        write(*,*) 'init_mozart_lib: Source file longitudes are not monotonic'
        stop 'Src lon grid error'
      endif

      src_lons_are_nonneg = all( x1d(:) >= 0. )
      has_lon_offset      = src_lons_are_nonneg .xor. wrf_lons_are_nonneg

      src_dx  = x1d(2) - x1d(1)
      tst_lon = mod( x1d(1) - src_dx + 360.,360. )
      src_lons_are_periodic = abs( tst_lon - x1d(nlon) ) <= 1.e-4*abs( src_dx )

      wrf_lons(:,:) = x2d(:,:)
      if( has_lon_offset ) then
        if( .not. wrf_lons_are_nonneg ) then
          wrf_lons(:,:) = mod( 360. + wrf_lons(:,:),360. )
        endif
      endif

      write(*,*) ' '
      write(*,*) 'src lons are nonneg,periodic,have offset = ',src_lons_are_nonneg,src_lons_are_periodic,has_lon_offset
      write(*,*) ' '

!---------------------------------------------------------------
!     read latitudes
!---------------------------------------------------------------
      status = nf_inq_varid( ncid, 'lat', varid )
      if( status /= nf_noerr )  call handle_error( status )

      status = nf_get_var_real( ncid, varid, y1d )
      if( status /= nf_noerr )  call handle_error( status )
!---------------------------------------------------------------
!     check latitudes for monotonicity
!---------------------------------------------------------------
      monotonic = .true.
      do n = 2,nlat-1
        if( (y1d(n+1) - y1d(n))*(y1d(n) - y1d(n-1)) <= 0. ) then
          monotonic = .false.
          exit
        endif
      end do
      if( .not. monotonic ) then
        write(*,*) 'init_mozart_lib: Source file latitudes are not monotonic'
        stop 'Src lon grid error'
      endif
!---------------------------------------------------------------------
!   check that lats are monotinicity increasing and reorder if not
!---------------------------------------------------------------------
      reorder_lats = .false.
      if( all( y1d(2:nlat) < y1d(1:nlat-1) ) ) then
        reorder_lats = .true.
        do j = 1,nlat/2
          jwrk = y1d(j)
          ju = nlat - j + 1
          y1d(j)  = y1d(ju)
          y1d(ju) = jwrk
        end do
      endif

      write(*,*) ' '
      write(*,*) 'src lats are reordered = ',reorder_lats
      write(*,*) ' '
      do j = 1,nlat,5
        write(*,'(1p,5g15.7)') y1d(j:min(j+4,nlat))
      end do
      write(*,*) ' '

!---------------------------------------------------------------
!     allocate memory space to store interpolation coef.
!---------------------------------------------------------------
      tstat = 0
      allocate( ax(nx,ny,0:1), by(nx,ny,0:1), stat=status )
      tstat = tstat + status
      allocate( ix(nx,ny,0:1), jy(nx,ny,0:1), stat=status )
      tstat = tstat + status
      if( tstat /= 0 ) then
         write(*,*) 'allocate for ax ... jy failed; error = ',tstat
      end if

!---------------------------------------------------------------
!     horizontal interpolation coefs.
!---------------------------------------------------------------
!---------------------------------------------------------------
! all domain
!---------------------------------------------------------------
      do j = 1, ny 
         do i = 1, nx
!           model_x = mod( 360. + x2d(i,j),360. )
            model_x = wrf_lons(i,j)
            if( model_x >= x1d(nlon) ) then
              if( src_lons_are_periodic ) then
                ix(i,j,0) = nlon
              else
                ix(i,j,0) = nlon - 1
              endif
            else if( model_x < x1d(1) ) then
              if( src_lons_are_periodic ) then
                ix(i,j,0) = nlon
              else
                ix(i,j,0) = 1
              endif
            else
               do n = 1, nlon
                  if( model_x < x1d(n) ) then
                     ix(i,j,0) = min( nlon-1, max(n-1,1) )
                     exit
                  end if
               end do
            end if
            ix(i,j,1) = mod( ix(i,j,0),nlon ) + 1
            model_dx = x1d(ix(i,j,1)) - x1d(ix(i,j,0))
            if( model_dx < 0. ) then
               model_dx = 360. + model_dx
            end if
            ax(i,j,0) = min( 1.,max( 0.,(model_x - x1d(ix(i,j,0)))/model_dx ) )
            ax(i,j,1) = 1.0 - ax(i,j,0)
            model_y = y2d(i,j)
            do n = 1, nlat
               if( model_y < y1d(n) ) then
                 exit
               end if
            end do
            jy(i,j,0) = min( nlat-1, max(n-1,1) )
            jy(i,j,1) = jy(i,j,0) + 1
            by(i,j,0) = (model_y - y1d(jy(i,j,0)))/(y1d(jy(i,j,1)) - y1d(jy(i,j,0)))
            by(i,j,0) = min( 1.,max( 0.,by(i,j,0) ) )
            by(i,j,1) = 1.0 - by(i,j,0)
         end do
      end do

!---------------------------------------------------------------
!     release memory
!---------------------------------------------------------------
      deallocate( x1d, y1d )

!---------------------------------------------------------------
!     allocate memory space for reading
!---------------------------------------------------------------
      allocate( mozval(nlon,nlat,nlev), tmpval(nlon,nlat,nlev), &
                time_type%conc(nlon,nlat,nlev,2), stat=status )
      if( status /= 0 ) then
         write(*,*) 'failed to allocate mozval, tmpval; error = ',status
         stop
      end if
!---------------------------------------------------------------
!     allocate mozart surface pressure arrays
!---------------------------------------------------------------
      allocate( ps_moz(nlon,nlat), ps_mozi(nx,ny), &
                time_type%ps(nlon,nlat,2), stat=status )
      if( status /= 0 ) then
         write(*,*) 'failed to allocate ps_moz,ps_mozi; error = ',status
         stop
      end if

!---------------------------------------------------------------
!     setup time_type
!---------------------------------------------------------------
      time_type%lo_moz_ndx = 0
      time_type%hi_moz_ndx = 0
      time_type%lo_buf_ndx = 1
      time_type%hi_buf_ndx = 2
      time_type%ncid_lo    = 0
      time_type%ncid_hi    = 0
      time_type%in_gap     = .false.
      time_type%t_interp   = .false.

      if( time_type%ndx > 0 ) then
        time_type%lo_moz_ndx = time_type%ndx
        time_type%ncid_lo    = ncid
        time_type%ncid_hi    = ncid
      endif

      write(*,*) 'finished init_mozart_lib'

      end subroutine init_mozart_lib

      subroutine read_moz_times( ncid )
!---------------------------------------------------------------
!     read times from current mozart input file
!---------------------------------------------------------------
      use mo_calendar, only : newdate
      use utils,       only : toupper

!---------------------------------------------------------------
!     dummy arguments
!---------------------------------------------------------------
      integer, intent(in) :: ncid

!---------------------------------------------------------------
!     local variables
!---------------------------------------------------------------
      integer :: varid
      integer :: status
      integer :: cnt, m
      integer :: sl, su
      integer :: ios, slen, spos, sbeg
      integer :: yr, mn, dy
      real    :: days
      real, allocatable :: times(:)
      character(len=132) :: units_text, wrk_text
      logical :: is_days_since, is_hours_since
      logical :: err

      status = nf_inq_dimid( ncid, 'time', varid )
      if( status /= nf_noerr )  call handle_error( status )

      status = nf_inq_dimlen( ncid, varid, ntime_m )
      if( status /= nf_noerr ) call handle_error( status )

      if( allocated( moz_date ) ) then
        deallocate( moz_date, moz_datesec )
      end if
      allocate( moz_date(ntime_m), moz_datesec(ntime_m), stat=status )
      if( status /= 0 ) then
        write(*,*) 'failed to allocate date, datesec; error = ',status
        stop
      end if

      select case( trim(src_model) )
        case('MOZART')
!---------------------------------------------------------------
!     MOZART datasets must have date,datesec integer arrays
!---------------------------------------------------------------
          status = nf_inq_varid( ncid, 'date', varid )
          if( status /= nf_noerr )  call handle_error( status )

          status = nf_get_var_int( ncid, varid, moz_date )
          if( status /= nf_noerr )  call handle_error( status )

          status = nf_inq_varid( ncid, 'datesec', varid )
          if( status /= nf_noerr )  call handle_error( status )

          status = nf_get_var_int( ncid, varid, moz_datesec )
          if( status /= nf_noerr )  call handle_error( status )
        case('GEOS5','ECMWF')
!---------------------------------------------------------------
!     GEOS5 datasets expect to read the time variable
!---------------------------------------------------------------
          status = nf_inq_varid( ncid, 'time', varid )
          if( status /= nf_noerr )  call handle_error( status )
          units_text = ' '
          status = nf_get_att_text( ncid, varid, 'units', units_text )
          if( status /= nf_noerr )  call handle_error( status )
          wrk_text = units_text
          err = .true.
          sl = scan( trim(wrk_text), '0123456789' )

          if( sl > 0 ) then
            sbeg = sl
            slen = len_trim( wrk_text )
            su = scan( trim(wrk_text),'-' ) - 1
            if( su >= sl ) then
              read(wrk_text(sl:su),*,iostat=ios) yr
              if( ios == 0 ) then
                wrk_text(sbeg:su+1) = ' '
                sl = min( su + 2,slen )
                su = scan( trim(wrk_text),'-' ) - 1
                if( su >= sl ) then
                  read(wrk_text(sl:su),*,iostat=ios) mn
                  if( ios == 0 ) then
                    sl = min( su + 2,slen )
                    wrk_text(sbeg:su+1) = ' '
                    su = sl
                    do while( su <= slen )
                      if( scan( wrk_text(su:su),'0123456789' ) ) then
                        su = su + 1
                      else
                        su = su - 1
                        exit
                      endif
                    end do
                    su = min( su,slen )
                    read(wrk_text(sl:su),*,iostat=ios) dy
                    if( ios == 0 ) then
                      err = .false.
                    endif
                  endif
                endif
              endif
            endif
          endif

          if( .not. err ) then
            wrk_text = units_text
            call toupper( wrk_text )
            spos = index( trim(wrk_text),'DAYS' )
            is_days_since  = spos /= 0
            if( .not. is_days_since ) then
              spos = index( trim(wrk_text),'HOURS' )
              is_hours_since = spos /= 0
              if( .not. is_hours_since ) then
                spos = index( trim(wrk_text),'HRS' )
                is_hours_since = spos /= 0
              endif
            else
              is_hours_since = .false.
            endif
            if( .not. is_days_since .and. .not. is_hours_since ) then
              write(*,*) 'moz_read_times: time variable is neither days or hours since'
              stop 'Time err'
            endif

            allocate( times(ntime_m), stat=status )
            if( status /= 0 ) then
              write(*,*) 'moz_read_times: failed to allocate times; error = ',status
              stop
            end if
            status = nf_inq_varid( ncid, 'time', varid )
            if( status /= nf_noerr )  call handle_error( status )
            status = nf_get_var_real( ncid, varid, times )
            if( status /= nf_noerr )  call handle_error( status )

            moz_date(:) = dy + 100*(mn + 100*yr)
            do m = 1,ntime_m
              if( is_days_since ) then
                days = times(m)
              elseif( is_hours_since ) then
                days = times(m)/24.
              endif
              moz_date(m) = newdate( moz_date(m),int(days) )
              moz_datesec(m) = int( (days - aint(days))*86400. )
            end do

            deallocate( times )
          else
            write(*,*) 'read_moz_times: units text'
            write(*,*) trim(units_text)
            write(*,*) 'read_moz_times: is not expected format'
            stop
          endif
      end select

      end subroutine read_moz_times

      subroutine get_moz_time_ndx( moz_dir, moz_fn, wrf_date, wrf_datesec, nspec )
!---------------------------------------------------------------
!     get mozart time index for wrf_date, wrf_datesec
!---------------------------------------------------------------

      use mo_calendar, only : diffdat

!---------------------------------------------------------------
!     dummy arguments
!---------------------------------------------------------------
      integer, intent(in)  :: wrf_date
      integer, intent(in)  :: wrf_datesec
      integer, intent(in)  :: nspec
      character(len=*), intent(in)    :: moz_dir
      character(len=*), intent(inout) :: moz_fn

!---------------------------------------------------------------
!     local variables
!---------------------------------------------------------------
      integer :: i, n
      integer :: status
      character(len=128) :: filenm
      logical :: found

      write(*,*) ' '
      write(*,*) 'get_moz_time_ndx; moz_dir,moz_fn = ',trim(moz_dir),trim(moz_fn)
      write(*,*) 'get_moz_time_ndx; wrf_date,wrf_datesec,ntime_m = ',wrf_date,wrf_datesec,ntime_m

      n = lotim( wrf_date, wrf_datesec, moz_date, moz_datesec, ntime_m )
      if( n > 0 ) then
!---------------------------------------------------------------
!     wrf time in present mozart dataset
!---------------------------------------------------------------
        write(*,*) 'get_moz_time_ndx; moz_tndx = ',n
        time_type%lo_moz_ndx = n
        time_type%in_gap     = .false.
        if( time_type%t_interp ) then
          time_type%hi_moz_ndx = n + 1
        endif
        if( time_type%ncid_hi /= time_type%ncid_lo ) then
          status = nf_close( time_type%ncid_lo )
          if( status /= 0 ) then
            filenm = trim( moz_dir ) // adjustl( moz_fn )
            write(*,*) 'get_moz_time_ndx: failed to close ',trim(filenm),' ; error = ',status
            stop
          end if
          time_type%ncid_lo = time_type%ncid_hi
        endif
        time_type%ncid_hi    = time_type%ncid_lo
      else if( n < 0 ) then
!---------------------------------------------------------------
!     wrf time after present mozart dataset
!---------------------------------------------------------------
         time_type%ncid_lo    = ncid
         time_type%lo_moz_ndx = ntime_m
         call next_flnm( moz_fn, .true. )
         filenm = trim( moz_dir ) // adjustl( moz_fn )
!---------------------------------------------------------------
!     open the input netCDF file
!---------------------------------------------------------------
         status = nf_open( trim(filenm), nf_nowrite, ncid )
         if( status /= nf_noerr ) call handle_error( status )
         write(*,*) 'get_moz_time_ndx: opened ',trim(filenm)
!---------------------------------------------------------------
!     check mozart variables
!---------------------------------------------------------------
         call chk_moz_vars( nspec, filenm )
         time_type%gap_date = moz_date(ntime_m)
         time_type%gap_secs = moz_datesec(ntime_m)
         call read_moz_times( ncid )
         n = lotim( wrf_date, wrf_datesec, moz_date, moz_datesec, ntime_m )
         time_type%ndx = n
         if( n > 0 ) then
           write(*,*) 'get_moz_time_ndx; moz_tndx = ',n
           status = nf_close( time_type%ncid_lo )
           if( status /= 0 ) then
             filenm = trim( moz_dir ) // adjustl( moz_fn )
             write(*,*) 'get_moz_time_ndx: failed to close ',trim(filenm),' ; error = ',status
             stop
           end if
           time_type%in_gap     = .false.
           time_type%ncid_lo    = ncid
           time_type%ncid_hi    = ncid
           time_type%lo_moz_ndx = n
         else if( n == 0 ) then
           time_type%in_gap     = .true.
           time_type%hi_moz_ndx = 1
           time_type%ncid_hi = ncid
           time_type%dels = time_type%dels/diffdat( time_type%gap_date, time_type%gap_secs, moz_date(1), moz_datesec(1) )
           time_type%t_interp = .true.
         else
           write(*,*) 'get_moz_time_ndx: failed to find ',wrf_date,' : ',wrf_datesec
           write(*,*) '                  in file ',trim(filenm)
           stop
         end if
      else if( time_type%in_gap ) then
        time_type%dels = time_type%dels/diffdat( time_type%gap_date, time_type%gap_secs, moz_date(1), moz_datesec(1) )
      end if

      end subroutine get_moz_time_ndx

      subroutine next_flnm( filenm, incr )
!---------------------------------------------------------------
!     increment mozart filename
!---------------------------------------------------------------

!---------------------------------------------------------------
!     dummy arguments
!---------------------------------------------------------------
      character(len=*), intent(inout) :: filenm
      logical, intent(in)             :: incr

!---------------------------------------------------------------
!     local variables
!---------------------------------------------------------------
      integer :: il, iu, ios, nlen
      integer :: file_number
      character(len=6) :: frmt
      logical :: found

      found = .false.
      iu    = scan( trim(filenm), '0123456789', back=.true. )
      do il = iu-1,1,-1
         if( index( '0123456789', filenm(il:il) ) == 0 ) then
            found = .true.
            exit
         end if
      end do
      if( .not. found ) then
         write(*,*) 'next_filenm: mozart file ',trim(filenm),' is not proper format'
         stop
      end if

      il = il + 1
      write(*,*) ' '
      if( incr ) then
        write(*,*) 'next_flnm; trying to increment file ',trim(filenm)
      else
        write(*,*) 'next_flnm; trying to decrement file ',trim(filenm)
      endif
      write(*,*) 'next_flnm; il, iu = ',il,iu
      read(filenm(il:iu),*,iostat=ios) file_number
      if( ios /= 0 ) then
         write(*,*) 'next_filenm: failed to read ',filenm(il:iu),' ; error = ',ios
         stop
      end if
      write(*,*) 'next_flnm; file_number = ',file_number
      if( incr ) then
        file_number = file_number + 1
      else
        file_number = file_number - 1
      endif
      nlen = iu - il + 1
      write(frmt,'(''(i'',i1,''.'',i1,'')'')') nlen,nlen
      write(filenm(il:iu),frmt) file_number

      write(*,*) 'next_flnm; new file = ',trim(filenm)

      end subroutine next_flnm

      subroutine read_mozart_ps( bndx, tndx, ncid )
!---------------------------------------------------------------
!     read mozart surface pressure
!---------------------------------------------------------------

!---------------------------------------------------------------
!     dummy arguments
!---------------------------------------------------------------
      integer, intent(in) :: bndx              ! buffer index
      integer, intent(in) :: tndx              ! time index
      integer, intent(in) :: ncid              ! netcdf file index

!---------------------------------------------------------------
!     local variables
!---------------------------------------------------------------
      integer :: j, ju
      integer :: status
      integer :: varid, ndims
      integer :: dimids(4)
      real    :: wrk(nlon)

      status = nf_inq_varid( ncid, trim(src_ps_name), varid )
      if( status /= nf_noerr )  then
        write(*,*) 'mozart_ps: failed to get ',trim(src_ps_name),' id'
        call handle_error( status )
      end if

!---------------------------------------------------------------
!     check dimensionality
!---------------------------------------------------------------
      status = nf_inq_varndims( ncid, varid, ndims )
      if( status /= nf_noerr )  then
        write(*,*) 'mozart_ps: failed to get dimension count for ',trim(src_ps_name)
        call handle_error( status )
      end if

      if( ndims < 3 .or. ndims > 4 ) then
        write(*,*) 'mozart_ps: ps variable does not have 3 or 4 dimensions'
        stop 'Var_error'
      endif
      status = nf_inq_vardimid( ncid, varid, dimids )
      if( status /= nf_noerr )  then
        write(*,*) 'mozart_ps: failed to get dimensions for ',trim(src_ps_name)
        call handle_error( status )
      end if
      if( dimids(1) /= lon_dimid .or. dimids(2) /= lat_dimid ) then
        write(*,*) 'mozart_ps: ps variable must be ordered (lon,lat)'
        stop 'Var_error'
      end if
      if( ndims == 4 .and. dimids(3) /= lev_dimid ) then
        write(*,*) 'mozart_ps: ps variable must be ordered (lon,lat,lev)'
        stop 'Var_error'
      end if

      if( ndims == 3 ) then
        nstt(1:ndims) = (/ 1, 1, tndx /)
        ncnt(1:ndims) = (/ nlon, nlat, 1 /)
      elseif( ndims == 4 ) then
        nstt(1:ndims) = (/ 1, 1, 1, tndx /)
        ncnt(1:ndims) = (/ nlon, nlat, 1, 1 /)
      endif
      status = nf_get_vara_real( ncid, varid, nstt(1:ndims), ncnt(1:ndims), time_type%ps(:,:,bndx) )
      if( status /= nf_noerr ) then
        write(*,*) 'mozart_ps: failed to read ',trim(src_ps_name)
        call handle_error( status )
      end if

      if( reorder_lats ) then
        do j = 1,nlat/2
          wrk(:) = time_type%ps(:,j,bndx)
          ju = nlat - j + 1
          time_type%ps(:,j,bndx)  = time_type%ps(:,ju,bndx)
          time_type%ps(:,ju,bndx) = wrk(:)
        end do
      endif

      end subroutine read_mozart_ps

      subroutine tinterp_mozart_ps( dels )
!---------------------------------------------------------------
!     time interpolation of mozart surface pressure
!---------------------------------------------------------------

!---------------------------------------------------------------
!     dummy arguments
!---------------------------------------------------------------
      real, intent(in) :: dels                ! linear interp factor

!---------------------------------------------------------------
!     local variables
!---------------------------------------------------------------
      integer :: j
      integer :: lo_ndx, hi_ndx
      real    :: delsm1

      if( time_type%t_interp ) then
        delsm1 = 1. - dels
!---------------------------------------------------------------
!     interpolate mozart surface pressure to wrf grid
!---------------------------------------------------------------
        do j = 1,nlat 
          ps_moz(:,j) = time_type%ps(:,j,1) * dels &
                      + time_type%ps(:,j,2) * delsm1
        end do
      else
        do j = 1,nlat 
          ps_moz(:,j) = time_type%ps(:,j,1)
        end do
      endif

      end subroutine tinterp_mozart_ps

      subroutine hinterp_mozart_ps( nx, ny )
!---------------------------------------------------------------
!     horizontal interpolation of mozart surface pressure
!---------------------------------------------------------------

!---------------------------------------------------------------
!     dummy arguments
!---------------------------------------------------------------
      integer, intent(in) :: nx                ! wrf x dimension
      integer, intent(in) :: ny                ! wrf y dimension

!---------------------------------------------------------------
!     local variables
!---------------------------------------------------------------
      integer :: i, j

!---------------------------------------------------------------
!     interpolate mozart surface pressure to wrf grid
!---------------------------------------------------------------
      do j = 1,ny 
        do i = 1,nx 
          ps_mozi(i,j) = ps_moz(ix(i,j,0),jy(i,j,0))*ax(i,j,1)*by(i,j,1) &
                       + ps_moz(ix(i,j,0),jy(i,j,1))*ax(i,j,1)*by(i,j,0) &
                       + ps_moz(ix(i,j,1),jy(i,j,0))*ax(i,j,0)*by(i,j,1) &
                       + ps_moz(ix(i,j,1),jy(i,j,1))*ax(i,j,0)*by(i,j,0)
        end do
      end do

      end subroutine hinterp_mozart_ps

      subroutine bc_interpolate4d( ndx, wrfxs, wrfxe, wrfys, wrfye, &
                                   ps_wrf, znu, p_top, nx, ny, &
                                   nz, nw )
!---------------------------------------------------------------
!     interpolate four-dimensional field ... 
!---------------------------------------------------------------

      use utils, only : wrf2mz_map

!---------------------------------------------------------------
!     input arguments
!---------------------------------------------------------------
      integer, intent(in)      :: ndx
      integer, intent(in)      :: nx, ny, nz, nw          ! dimensions
      real, intent(in)         :: p_top                   ! wrf top reference pressure (Pa)
      real, intent(in)         :: ps_wrf(nx,ny)           ! wrf surface pressure (Pa)
      real, intent(in)         :: znu(nz)                 ! sigma coordinates
      real, intent(out)        :: wrfxs(ny,nz,nw)         ! wrfchem vmr(ppm)
      real, intent(out)        :: wrfxe(ny,nz,nw)         ! wrfchem vmr(ppm)
      real, intent(out)        :: wrfys(nx,nz,nw)         ! wrfchem vmr(ppm)
      real, intent(out)        :: wrfye(nx,nz,nw)         ! wrfchem vmr(ppm)

!---------------------------------------------------------------
!     local variables
!---------------------------------------------------------------
      integer :: i, j, k, ku, n
      integer :: status, varid
      real    :: wrk_var
      real, allocatable :: wrk(:)
      real, allocatable :: wrk1(:)
      real, allocatable :: p_moz(:)
      real, allocatable :: p_wrf(:)
      character(len=20) :: mozspn

      if( wrf2mz_map(ndx)%moz_cnt > 0 ) then
        allocate( wrk(nlev), wrk1(nz), p_moz(nlev), p_wrf(nz), stat=status )
        if( status /= 0 ) then
          write(*,*) 'bc_interpolated4d: failed to allocate wrk ... p_wrf; error = ',status
          stop
        end if
!---------------------------------------------------------------
!     read mozart pressure
!---------------------------------------------------------------
        if( ndx == 1 ) then
          call read_mozart_ps( time_type%lo_buf_ndx, time_type%lo_moz_ndx, time_type%ncid_lo )
          if( time_type%t_interp ) then
            call read_mozart_ps( time_type%hi_buf_ndx, time_type%hi_moz_ndx, time_type%ncid_hi )
          endif
          call tinterp_mozart_ps( time_type%dels )
          call hinterp_mozart_ps( nx, ny )
        endif
!---------------------------------------------------------------
!     read mozart species
!---------------------------------------------------------------
        call read_moz_species( ndx, time_type%lo_buf_ndx, time_type%lo_moz_ndx, time_type%ncid_lo )
        if( time_type%t_interp ) then
          call read_moz_species( ndx, time_type%hi_buf_ndx, time_type%hi_moz_ndx, time_type%ncid_hi )
        endif
        call tinterp_moz_species( time_type%dels )
!---------------------------------------------------------------
!     horizontally interpolate species at boundaries
!---------------------------------------------------------------
!     west
!---------------------------------------------------------------
        do j = 1,ny
          wrk(:) = mozval(ix(1,j,0),jy(1,j,0),:)*ax(1,j,1)*by(1,j,1) &
                 + mozval(ix(1,j,0),jy(1,j,1),:)*ax(1,j,1)*by(1,j,0) &
                 + mozval(ix(1,j,1),jy(1,j,0),:)*ax(1,j,0)*by(1,j,1) &
                 + mozval(ix(1,j,1),jy(1,j,1),:)*ax(1,j,0)*by(1,j,0)
          if( .not. invert_p_moz ) then
            p_moz(:) = p_moz_fac*(ps_mozi(1,j)*hybm(:) + ps0*hyam(:))
          else
            p_moz(nlev:1:-1) = p_moz_fac*(ps_mozi(1,j)*hybm(:) + ps0*hyam(:))
            do k = 1,nlev/2
              wrk_var = wrk(k)
              ku = nlev - k + 1
              wrk(k)  = wrk(ku)
              wrk(ku) = wrk_var
            end do
          endif
          p_wrf(:) = ps_wrf(1,j)*znu(nz:1:-1) + (1. - znu(nz:1:-1))*p_top
          call vinterp( p_moz, p_wrf, wrk, wrk1, nz, nlev )
          do n = 1,nw
            wrfxs(j,:,n) = wrk1(nz:1:-1)
          end do
        end do
!---------------------------------------------------------------
!     east
!---------------------------------------------------------------
        do j = 1, ny
          wrk(:) = mozval(ix(nx,j,0),jy(nx,j,0),:)*ax(nx,j,1)*by(nx,j,1) &
                 + mozval(ix(nx,j,0),jy(nx,j,1),:)*ax(nx,j,1)*by(nx,j,0) &
                 + mozval(ix(nx,j,1),jy(nx,j,0),:)*ax(nx,j,0)*by(nx,j,1) &
                 + mozval(ix(nx,j,1),jy(nx,j,1),:)*ax(nx,j,0)*by(nx,j,0)
          if( .not. invert_p_moz ) then
            p_moz(:) = p_moz_fac*(ps_mozi(nx,j)*hybm(:) + ps0*hyam(:))
          else
            p_moz(nlev:1:-1) = p_moz_fac*(ps_mozi(nx,j)*hybm(:) + ps0*hyam(:))
            do k = 1,nlev/2
              wrk_var = wrk(k)
              ku = nlev - k + 1
              wrk(k)  = wrk(ku)
              wrk(ku) = wrk_var
            end do
          endif
          p_wrf(:) = ps_wrf(nx,j)*znu(nz:1:-1) + (1. - znu(nz:1:-1))*p_top
          call vinterp( p_moz, p_wrf, wrk, wrk1, nz, nlev )
          do n = 1,nw
            wrfxe(j,:,n) = wrk1(nz:1:-1)
          end do
        end do
!---------------------------------------------------------------
!     north
!---------------------------------------------------------------
        do i = 1,nx
          wrk(:) = mozval(ix(i,ny,0),jy(i,ny,0),:)*ax(i,ny,1)*by(i,ny,1) &
                 + mozval(ix(i,ny,0),jy(i,ny,1),:)*ax(i,ny,1)*by(i,ny,0) &
                 + mozval(ix(i,ny,1),jy(i,ny,0),:)*ax(i,ny,0)*by(i,ny,1) &
                 + mozval(ix(i,ny,1),jy(i,ny,1),:)*ax(i,ny,0)*by(i,ny,0)
          if( .not. invert_p_moz ) then
            p_moz(:) = p_moz_fac*(ps_mozi(i,ny)*hybm(:) + ps0*hyam(:))
          else
            p_moz(nlev:1:-1) = p_moz_fac*(ps_mozi(i,ny)*hybm(:) + ps0*hyam(:))
            do k = 1,nlev/2
              wrk_var = wrk(k)
              ku = nlev - k + 1
              wrk(k)  = wrk(ku)
              wrk(ku) = wrk_var
            end do
          endif
          p_wrf(:) = ps_wrf(i,ny)*znu(nz:1:-1) + (1. - znu(nz:1:-1))*p_top
          call vinterp( p_moz, p_wrf, wrk, wrk1, nz, nlev )
          do n = 1,nw
            wrfye(i,:,n) = wrk1(nz:1:-1)
          end do
        end do
!---------------------------------------------------------------
!     south
!---------------------------------------------------------------
        do i = 1,nx
          wrk(:) = mozval(ix(i,1,0),jy(i,1,0),:)*ax(i,1,1)*by(i,1,1) &
                 + mozval(ix(i,1,0),jy(i,1,1),:)*ax(i,1,1)*by(i,1,0) &
                 + mozval(ix(i,1,1),jy(i,1,0),:)*ax(i,1,0)*by(i,1,1) &
                 + mozval(ix(i,1,1),jy(i,1,1),:)*ax(i,1,0)*by(i,1,0)
          if( .not. invert_p_moz ) then
            p_moz(:) = p_moz_fac*(ps_mozi(i,1)*hybm(:) + ps0*hyam(:))
          else
            p_moz(nlev:1:-1) = p_moz_fac*(ps_mozi(i,1)*hybm(:) + ps0*hyam(:))
            do k = 1,nlev/2
              wrk_var = wrk(k)
              ku = nlev - k + 1
              wrk(k)  = wrk(ku)
              wrk(ku) = wrk_var
            end do
          endif
          p_wrf(:) = ps_wrf(i,1)*znu(nz:1:-1) + (1. - znu(nz:1:-1))*p_top
          call vinterp( p_moz, p_wrf, wrk, wrk1, nz, nlev )
          do n = 1,nw
            wrfys(i,:,n) = wrk1(nz:1:-1)
          end do
        end do
        deallocate( wrk, wrk1, p_moz, p_wrf )
      else
        do n = 1,nw
          wrfxs(:,:,n) = wrf2mz_map(ndx)%wrf_conc
          wrfxe(:,:,n) = wrf2mz_map(ndx)%wrf_conc
          wrfys(:,:,n) = wrf2mz_map(ndx)%wrf_conc
          wrfye(:,:,n) = wrf2mz_map(ndx)%wrf_conc
        end do
      end if

      if( trim(wrf2mz_map(ndx)%wrf_name) == trim(dbg_species) ) then
         write(*,*) ' '
         write(*,*) 'mozart ',trim(dbg_species),' east bc values'
         write(*,'(10(1p,g15.7))') wrfxe(:,1,1)
      end if

      end subroutine bc_interpolate4d

      subroutine ic_interpolate4d( ndx, conc, ps_wrf, znu, p_top, &
                                   nx, ny, nz )
!---------------------------------------------------------------
!     interpolate four-dimensional field ... 
!---------------------------------------------------------------

      use utils, only : wrf2mz_map

!---------------------------------------------------------------
!     input arguments
!---------------------------------------------------------------
      integer, intent(in)      :: ndx
      integer, intent(in)      :: nx, ny, nz              ! dimensions
      real, intent(in)         :: p_top                   ! wrf top reference pressure (Pa)
      real, intent(in)         :: ps_wrf(nx,ny)           ! wrf surface pressure (Pa)
      real, intent(in)         :: znu(nz)                 ! sigma coordinates
      real, intent(out)        :: conc(nx,ny,nz)          ! wrfchem vmr(ppm)

!---------------------------------------------------------------
!     local variables
!---------------------------------------------------------------
      integer :: i, j, k, ku, n
      integer :: status, varid
      real    :: wrk_var
      real, allocatable :: wrk(:)
      real, allocatable :: wrk1(:)
      real, allocatable :: p_moz(:)
      real, allocatable :: p_wrf(:)
      character(len=20) :: mozspn

      if( wrf2mz_map(ndx)%moz_cnt > 0 ) then
        allocate( wrk(nlev), wrk1(nz), p_moz(nlev), p_wrf(nz), stat=status )
        if( status /= 0 ) then
          write(*,*) 'failed to allocate wrk ... p_wrf; error = ',status
          stop
        end if
!---------------------------------------------------------------
!     read mozart pressure
!---------------------------------------------------------------
        if( ndx == 1 ) then
          call read_mozart_ps( time_type%lo_buf_ndx, time_type%lo_moz_ndx, time_type%ncid_lo )
          if( time_type%t_interp ) then
            call read_mozart_ps( time_type%hi_buf_ndx, time_type%hi_moz_ndx, time_type%ncid_hi )
          endif
          call tinterp_mozart_ps( time_type%dels )
          call hinterp_mozart_ps( nx, ny )
        endif
!---------------------------------------------------------------
!     read mozart species
!---------------------------------------------------------------
        call read_moz_species( ndx, time_type%lo_buf_ndx, time_type%lo_moz_ndx, time_type%ncid_lo )
        if( time_type%t_interp ) then
          call read_moz_species( ndx, time_type%hi_buf_ndx, time_type%hi_moz_ndx, time_type%ncid_hi )
        endif
        call tinterp_moz_species( time_type%dels )
!---------------------------------------------------------------
!     horizontally interpolate species
!---------------------------------------------------------------
        do j = 1,ny
          do i = 1,nx
            wrk(:)  = mozval(ix(i,j,0),jy(i,j,0),:)*ax(i,j,1)*by(i,j,1) &
                    + mozval(ix(i,j,0),jy(i,j,1),:)*ax(i,j,1)*by(i,j,0) &
                    + mozval(ix(i,j,1),jy(i,j,0),:)*ax(i,j,0)*by(i,j,1) &
                    + mozval(ix(i,j,1),jy(i,j,1),:)*ax(i,j,0)*by(i,j,0)
            if( .not. invert_p_moz ) then
                p_moz(:) = p_moz_fac*(ps_mozi(i,j)*hybm(:) + ps0*hyam(:))
            else
              p_moz(nlev:1:-1) = p_moz_fac*(ps_mozi(i,j)*hybm(:) + ps0*hyam(:))
              do k = 1,nlev/2
                wrk_var = wrk(k)
                ku = nlev - k + 1
                wrk(k)  = wrk(ku)
                wrk(ku) = wrk_var
              end do
            endif
            p_wrf(:) = ps_wrf(i,j)*znu(nz:1:-1) + (1. - znu(nz:1:-1))*p_top
            call vinterp( p_moz, p_wrf, wrk, wrk1, nz, nlev )
            conc(i,j,:) = wrk1(nz:1:-1)
            if( dbg_i == i .and. dbg_j == j ) then
              if( trim(wrf2mz_map(ndx)%wrf_name) == trim(dbg_species) ) then
                write(*,*) ' '
                write(*,'(''wrf grid i,j indices = '',2i4)') dbg_i,dbg_j
                write(*,*) 'mozart grid interpolation points'
                write(*,'(''ix = '',2i4)') ix(dbg_i,dbg_j,:)
                write(*,'(''jy = '',2i4)') jy(dbg_i,dbg_j,:)
                write(*,*) 'mozart vertical column ',trim(dbg_species),' values @ i,j =',ix(i,j,0),jy(i,j,0)
                write(*,'(10(1p,g15.7))') mozval(ix(i,j,0),jy(i,j,0),:)
                write(*,*) 'mozart horiz ',trim(dbg_species),' values @ surface'
                write(*,'(10(1p,g15.7))') mozval(ix(i,j,0),jy(i,j,0),nlev), mozval(ix(i,j,1),jy(i,j,0),nlev), &
                                          mozval(ix(i,j,0),jy(i,j,1),nlev), mozval(ix(i,j,1),jy(i,j,1),nlev)
                write(*,*) 'mozart column interpolant ',trim(dbg_species),' values'
                write(*,'(10(1p,g15.7))') wrk
                write(*,*) 'wrf interpolated column ',trim(dbg_species),' values'
                write(*,'(10(1p,g15.7))') wrk1
                write(*,*) ' '
              endif
            endif
          end do
        end do
        deallocate( wrk, wrk1, p_moz, p_wrf )
      else
        conc(:,:,:) = wrf2mz_map(ndx)%wrf_conc
      end if

      end subroutine ic_interpolate4d

      subroutine read_moz_species( sndx, bndx, tndx, ncid )
!---------------------------------------------------------------
!     read mozart species
!---------------------------------------------------------------

      use utils, only : wrf2mz_map

!---------------------------------------------------------------
!     dummy arguments
!---------------------------------------------------------------
      integer, intent(in) :: sndx              ! species index
      integer, intent(in) :: bndx              ! buffer index
      integer, intent(in) :: tndx              ! time index
      integer, intent(in) :: ncid              ! netcdf file index

!---------------------------------------------------------------
!     local variables
!---------------------------------------------------------------
      real, parameter :: mbar = 28.966         ! mean mol mass of dry air
      integer :: j, ju, k
      integer :: n
      integer :: nspec
      integer :: status
      integer :: varid
      real    :: wrk(nlon)
      real    :: mozval(nlon,nlat,nlev)
      character(len=20) :: mozspn
        
      nspec = wrf2mz_map(sndx)%moz_cnt
      if( nspec > 0 ) then
        nstt(1:4) = (/ 1, 1, 1, tndx /)
        ncnt(1:4) = (/ nlon, nlat, nlev, 1 /)
        mozval(:,:,:) = 0.
        tmpval(:,:,:) = 0.
        do n = 1,nspec
          if( wrf2mz_map(sndx)%moz_ext(n) ) then
            mozspn = trim(moz_var_prefix) // trim(wrf2mz_map(sndx)%moz_names(n)) // trim(moz_var_suffix)
          else
            mozspn = trim(wrf2mz_map(sndx)%moz_names(n))
          end if
          write(*,*)'read_moz_species: reading', mozspn
          status = nf_inq_varid( ncid, mozspn, varid )
          if( status /= nf_noerr )  then
            write(*,*) 'read_moz_species: failed to get id of ',mozspn
            call handle_error( status )
          end if
          status = nf_get_vara_real( ncid, varid, nstt, ncnt, tmpval )
      write(*,*)'read_moz_species1 =', tmpval(357,152,1)
          if( status /= nf_noerr ) then
            write(*,*) 'read_moz_species: failed to read ',mozspn
           call handle_error( status )
          end if

          if( wrf2mz_map(sndx)%moz_wght(n) == 1. ) then
            mozval(:,:,:) = mozval(:,:,:) + tmpval(:,:,:)
      write(*,*)'read_moz_species2 =',mozval(357,152,1)
          elseif( src_model /= 'ECMWF' ) then
            mozval(:,:,:) = mozval(:,:,:) + wrf2mz_map(sndx)%moz_wght(n)*tmpval(:,:,:)
      write(*,*)'read_moz_species3 =',mozval(357,152,1)
          else
            if( wrf2mz_map(sndx)%wrf_name(1:5) /= 'num_a' ) then
              mozval(:,:,:) = mozval(:,:,:) + mbar*tmpval(:,:,:)/wrf2mz_map(sndx)%moz_wght(n)
      write(*,*)'read_moz_species4 =',mozval(357,152,1)
            else
              mozval(:,:,:) = mozval(:,:,:) + wrf2mz_map(sndx)%moz_wght(n)*tmpval(:,:,:)
      write(*,*)'read_moz_species5 =',mozval(357,152,1)
            end if
          end if
        end do
        mozval(:,:,:) = mozval(:,:,:)*wrf2mz_map(sndx)%wrf_wght
      end if
      write(*,*)'read_moz_species6 =',mozval(357,152,1)

      time_type%conc(:,:,:,bndx) = mozval(:,:,:)

      if( reorder_lats ) then
        do k = 1,nlev
          do j = 1,nlat/2
            wrk(:) = time_type%conc(:,j,k,bndx)
            ju = nlat - j + 1
            time_type%conc(:,j,k,bndx)  = time_type%conc(:,ju,k,bndx)
            time_type%conc(:,ju,k,bndx) = wrk(:)
          end do
        end do
      endif

      end subroutine read_moz_species

      subroutine tinterp_moz_species( dels )
!---------------------------------------------------------------
!     time interpolation of mozart species concentration
!---------------------------------------------------------------

!---------------------------------------------------------------
!     dummy arguments
!---------------------------------------------------------------
      real, intent(in) :: dels                ! linear interp factor

!---------------------------------------------------------------
!     local variables
!---------------------------------------------------------------
      integer :: j, k
      integer :: lo_ndx, hi_ndx
      real    :: delsm1

      lo_ndx = time_type%lo_buf_ndx
      if( time_type%t_interp ) then
        hi_ndx = time_type%hi_buf_ndx
        delsm1 = 1. - dels
        do k = 1,nlev 
          do j = 1,nlat 
            mozval(:,j,k) = time_type%conc(:,j,k,lo_ndx) * dels &
                          + time_type%conc(:,j,k,hi_ndx) * delsm1
          end do
        end do
      else
        do k = 1,nlev 
          do j = 1,nlat 
            mozval(:,j,k) = time_type%conc(:,j,k,lo_ndx)
          end do
        end do
      endif

      end subroutine tinterp_moz_species

      subroutine handle_error( status )
!---------------------------------------------------------------
!     handle errors produced by calling netCDF functions
!---------------------------------------------------------------

!---------------------------------------------------------------
!     dummy arguments :
!---------------------------------------------------------------
      integer, intent(in) :: status

!---------------------------------------------------------------
!     print the error information from processing NETcdf file
!---------------------------------------------------------------
      write(*,*) nf_strerror( status )

!---------------------------------------------------------------
!     exit from the bconLib
!---------------------------------------------------------------
      call exit_mozart_lib( flag=1 )

      end subroutine handle_error

      subroutine exit_mozart_lib( flag )
!---------------------------------------------------------------
!     exit from module_mozart_lib 
!---------------------------------------------------------------

!---------------------------------------------------------------
!     dummy arguments
!---------------------------------------------------------------
      integer, optional, intent(in) :: flag

!---------------------------------------------------------------
!     local variables
!---------------------------------------------------------------
      integer :: status

!---------------------------------------------------------------
!     deallocate
!---------------------------------------------------------------
      if( allocated(ix) ) deallocate( ix )
      if( allocated(jy) ) deallocate( jy )
      if( allocated(ax) ) deallocate( ax )
      if( allocated(by) ) deallocate( by )

      if( allocated(mozval) ) deallocate( mozval )
      if( allocated(tmpval) ) deallocate( tmpval )

!-----------------------------------------------------------------------
!     close netCDF file
!-----------------------------------------------------------------------
      if( time_type%ncid_lo /= 0 ) then
        status = nf_close( time_type%ncid_lo )
        if( time_type%ncid_hi /= 0 .and. &
            (time_type%ncid_hi /= time_type%ncid_lo) ) then
          status = nf_close( time_type%ncid_hi )
        end if
      end if

!-----------------------------------------------------------------------
!     output information
!-----------------------------------------------------------------------
      if( present(flag) ) then
        select case( flag )
          case( 1 ); write(*,*) 'fail to process netCDF file...'
          case default; write(*,*) 'unknown error(s) occurred ...'
        endselect
        stop ' in module_mozart_lib ...'
      else
        write(*,*) 'successfully exited from module_mozart_lib ...'
      end if

      end subroutine exit_mozart_lib

      subroutine vinterp( p_moz, p_wrf, src, interp, nz, nlev )
!-----------------------------------------------------------------------
!   	... vertically interpolate input data
!-----------------------------------------------------------------------

      implicit none

!-----------------------------------------------------------------------
!   	... dummy arguments
!-----------------------------------------------------------------------
      integer, intent(in) :: nz, nlev
      real, intent(in)    :: p_moz(nlev)
      real, intent(in)    :: p_wrf(nz)
      real, intent(in)    :: src(nlev)
      real, intent(out)   :: interp(nz)

!-----------------------------------------------------------------------
!   	... local variables
!-----------------------------------------------------------------------
      integer :: i
      integer :: k, kl, ku
      real    :: delp, pinterp

level_loop : &
      do k = 1,nz
         pinterp = p_wrf(k)
         if( pinterp <= p_moz(1) ) then
            interp(k) = src(1)
         else if( pinterp > p_moz(nlev) ) then
            interp(k) = src(nlev)
         else
            do ku = 2,nlev
               if( pinterp <= p_moz(ku) ) then
                  kl = ku - 1
                  delp = log( pinterp/p_moz(kl) ) &
                         / log( p_moz(ku)/p_moz(kl) )
                  interp(k) = src(kl) + delp * (src(ku) - src(kl))
                  exit
               end if
            end do
         end if
      end do level_loop

      end subroutine vinterp

      integer function lotim( cdate, csec, date, datesec, ntim )
!-----------------------------------------------------------------------
! 	... return the index of the time sample that is the lower
!           bound of the interval that contains the input date.  if
!           (cdate,csec) is earlier than the first time sample then 0 is
!           returned.  if (cdate,csec) is later than the last time sample then
!           -index is returned.  if (cdate,csec) is equal to the date of a
!           dynamics time sample then that index is returned.
!-----------------------------------------------------------------------

      use mo_calendar,  only : diffdat

      implicit none

!-----------------------------------------------------------------------
! 	... dummy arguments
!-----------------------------------------------------------------------
      integer, intent(in) :: cdate    ! date in yyyymmdd
      integer, intent(in) :: csec     ! seconds relative to date
      integer, intent(in) :: ntim     ! number times
      integer, intent(in) :: date(ntim)
      integer, intent(in) :: datesec(ntim)

!-----------------------------------------------------------------------
! 	... local variables
!-----------------------------------------------------------------------
      integer :: n
      real    :: dtime

!-----------------------------------------------------------------------
!     	... find latest date that is earlier than or equal to (date,sec)
!-----------------------------------------------------------------------
      do n = 1,ntim
        dtime = diffdat( cdate, csec, date(n), datesec(n) )
        if( dtime > 0. ) then
          lotim = n - 1
          if( lotim > 0 ) then
            time_type%dels = dtime/diffdat( date(lotim), datesec(lotim), date(n), datesec(n) )
            time_type%t_interp = time_type%dels /= 1.
          else
            time_type%dels = dtime
          endif
          exit
        endif
      end do

      if( n > ntim ) then
        if( dtime == 0. ) then
          lotim = ntim
          time_type%dels = 1.
          time_type%t_interp = .false.
        else
          lotim = -ntim
          time_type%dels = dtime
        endif
      endif

      end function lotim

      subroutine chk_moz_vars( nspec, filenm )
!---------------------------------------------------------------
!     check wrf to mozart variable mapping
!---------------------------------------------------------------

      use utils,       only : wrf2mz_map

!---------------------------------------------------------------
!     dummy arguments
!---------------------------------------------------------------
      integer, intent(in) :: nspec
      character(len=*), intent(in) :: filenm

!---------------------------------------------------------------
!     local variables
!---------------------------------------------------------------
      integer :: i, n
      integer :: vid
      integer :: status
      character(len=32) :: spcnam

      do n = 1,nspec
         write(*,*) 'checking wrf variable ',trim(wrf2mz_map(n)%wrf_name)
         do i = 1,wrf2mz_map(n)%moz_cnt
            spcnam = ' '
            if( wrf2mz_map(n)%moz_ext(i) ) then
               spcnam = trim(moz_var_prefix) // trim(wrf2mz_map(n)%moz_names(i)) // trim(moz_var_suffix)
            else
               spcnam = trim(wrf2mz_map(n)%moz_names(i))
            end if
            write(*,*) 'len ',trim(wrf2mz_map(n)%moz_names(i)),' = ',len_trim(wrf2mz_map(n)%moz_names(i))
            status = nf_inq_varid( ncid, trim(spcnam), vid )
            if( status /= nf_noerr ) then
               write(*,*) 'chk_moz_vars: could not find ',spcnam,' in ',trim(filenm)
               call handle_error( status )
            end if
         end do
      end do

      end subroutine chk_moz_vars

      end module module_mozart_lib
