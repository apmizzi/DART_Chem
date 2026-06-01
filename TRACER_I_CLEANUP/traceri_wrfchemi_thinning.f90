  program main
      implicit none
      integer,parameter                    :: nvars=21
      integer                              :: nx,ny,nz_chemi,ivar,unit
      integer                              :: i,j,k
      integer,dimension(nvars)             :: arc_rank
      real,allocatable,dimension(:,:)      :: fld2d
      real,allocatable,dimension(:,:,:)    :: fld3d
      character(len=200)                   :: path_input,path_output
      character(len=200)                   :: file_input,file_output
      character(len=200)                   :: read_file,write_file
      character(len=50),dimension(nvars)   :: arc_vars
      character(len=200),dimension(nvars)  :: arc_units_coms
!      
! Size wrfchemi (un-thinned but compressed): 15 M
! Size wrfout (thinned and compressed):      7.9 M 
!
      namelist/wrfchemi_thinning_nml/path_input,path_output,file_input,file_output
!
      nx=440
      ny=284
      nz_chemi=20
!
      arc_vars=['XLONG','XLAT','E_CO','E_NO','E_SO2','E_NO2','E_HCHO','E_HONO','E_NH3','E_CH4', &
      'E_ACT','E_EOH','E_ETEG','E_ETH','E_HC3','E_HC5','E_HC8','E_KET','E_OL2','E_OLI', &
      'E_OLT']
!
      arc_rank=[2,2,3,3,3,3,3,3,3,3,  3,3,3,3,3,3,3,3,3,3,  3]
!
      arc_units_coms=['West to east longitude: degrees', &
      'South to north latitude: degrees',&
      'CO hourly emissions: mole km^-2 hr^-1',&
      'NO hourly emissions: mole km^-2 hr^-1',&
      'NO2 hourly emissions: mole km^-2 hr^-1',&
      'SO2 hourly emissions: mole km^-2 hr^-1',&
      'HCHO hourly emissions: mole km^-2 hr^-1',&
      'HONO hourly emissions: mole km^-2 hr^-1',&
      'NH3 hourly emissions: mole km^-2 hr^-1',&
      'CH4 hourly emissions: mole km^-2 hr^-1',&                              ! 10
      'ACT hourly emissions: mole km^-2 hr^-1',&
      'EOH hourly emissions: mole km^-2 hr^-1',&
      'ETEG hourly emissions: mole km^-2 hr^-1',&
      'ETH hourly emissions: mole km^-2 hr^-1',&
      'HC3 hourly emissions: mole km^-2 hr^-1',&
      'HC5 hourly emissions: mole km^-2 hr^-1',&
      'HC8 hourly emissions: mole km^-2 hr^-1',&
      'KET hourly emissions: mole km^-2 hr^-1',&
      'OL2 hourly emissions: mole km^-2 hr^-1',&
      'OLI hourly emissions: mole km^-2 hr^-1',&                              ! 20
      'OLT hourly emissions: mole km^-2 hr^-1']
!      
      allocate(fld2d(nx,ny))
      allocate(fld3d(nx,ny,nz_chemi))
!
! Read namelist data
      unit=20
      open(unit=unit,file="wrfchemi_thinning_nml.nl",form="formatted", &
      status="old",action="read")
      rewind(unit)
      read(unit,wrfchemi_thinning_nml)
      close(unit)
      print *, 'path_input     ',trim(path_input)
      print *, 'path_output    ',trim(path_output)
      print *, 'file_input     ',trim(file_input)
      print *, 'file_output    ',trim(file_output)
!
! Create thinned wrfchemi file
      read_file=trim(path_input)//"/"//trim(file_input)
      write_file=trim(path_output)//"/"//trim(file_output)
      print *, 'APM: write file ',trim(write_file)
      call create_NETCDF_file(trim(write_file),nx,ny,nz_chemi)
      print *, 'APM: Created the thinned file'
!
      do ivar=1,nvars
         print *, 'APM: Process variable ',trim(arc_vars(ivar)),' rank ',arc_rank(ivar)
         if(arc_rank(ivar).eq.2) then
            call get_WRFCHEM_fld_real(trim(read_file),trim(arc_vars(ivar)),fld2d,nx,ny,1,1)
            call put_NETCDF_fld_real(trim(write_file),trim(arc_vars(ivar)),trim(arc_units_coms(ivar)), &
            fld2d,nx,ny,1)
            cycle
         elseif(arc_rank(ivar).eq.3) then
            call get_WRFCHEM_fld_real(trim(read_file),trim(arc_vars(ivar)),fld3d,nx,ny,nz_chemi,1)
            call put_NETCDF_fld_real(trim(write_file),trim(arc_vars(ivar)),trim(arc_units_coms(ivar)), &
            fld3d,nx,ny,nz_chemi)
               cycle     
         endif
      enddo
      deallocate(fld2d)
      deallocate(fld3d)
   end program main

!-------------------------------------------------------------------------------

   subroutine create_NETCDF_file(wrfchem_thin_file,nx,ny,nz_chemi)
      use :: netcdf
      implicit none
!      
      integer                    :: nx,ny,nz_chemi,rc,fid
      integer                    :: var_id,att_id,nx_dimid,ny_dimid,nz_chemi_dimid
      character(len=*)           :: wrfchem_thin_file
!
! Define dimensions
      rc=nf90_create(trim(wrfchem_thin_file),NF90_CLOBBER,fid)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at create file')

      rc=nf90_def_dim(fid,"west-east",nx,nx_dimid)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at nx_dimid')

      rc=nf90_def_dim(fid,"south-north",ny,ny_dimid)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at ny_dimid')

      rc=nf90_def_dim(fid,"bottom-top",nz_chemi,nz_chemi_dimid)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at nz_chemi_dimid')
!
! Define variables
      rc=nf90_def_var(fid,"XLONG",NF90_REAL,(/nx_dimid,ny_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at XLONG')

      rc=nf90_def_var(fid,"XLAT",NF90_REAL,(/nx_dimid,ny_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at XLAT')

      rc=nf90_def_var(fid,"E_CO",NF90_REAL,(/nx_dimid,ny_dimid,nz_chemi_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at E_CO')

      rc=nf90_def_var(fid,"E_NO",NF90_REAL,(/nx_dimid,ny_dimid,nz_chemi_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at E_NO')

      rc=nf90_def_var(fid,"E_NO2",NF90_REAL,(/nx_dimid,ny_dimid,nz_chemi_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at E_NO2')

      rc=nf90_def_var(fid,"E_SO2",NF90_REAL,(/nx_dimid,ny_dimid,nz_chemi_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at E_SO2')

      rc=nf90_def_var(fid,"E_HCHO",NF90_REAL,(/nx_dimid,ny_dimid,nz_chemi_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at E_HCHO')

      rc=nf90_def_var(fid,"E_HONO",NF90_REAL,(/nx_dimid,ny_dimid,nz_chemi_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at E_HONO')

      rc=nf90_def_var(fid,"E_NH3",NF90_REAL,(/nx_dimid,ny_dimid,nz_chemi_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at E_NH3')

      rc=nf90_def_var(fid,"E_CH4",NF90_REAL,(/nx_dimid,ny_dimid,nz_chemi_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at E_CH4')

      rc=nf90_def_var(fid,"E_ACT",NF90_REAL,(/nx_dimid,ny_dimid,nz_chemi_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at E_ACT')

      rc=nf90_def_var(fid,"E_EOH",NF90_REAL,(/nx_dimid,ny_dimid,nz_chemi_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at E_EOH')

      rc=nf90_def_var(fid,"E_ETEG",NF90_REAL,(/nx_dimid,ny_dimid,nz_chemi_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at E_ETEG')

      rc=nf90_def_var(fid,"E_ETH",NF90_REAL,(/nx_dimid,ny_dimid,nz_chemi_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at E_ETH')

      rc=nf90_def_var(fid,"E_HC3",NF90_REAL,(/nx_dimid,ny_dimid,nz_chemi_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at E_HC3')

      rc=nf90_def_var(fid,"E_HC5",NF90_REAL,(/nx_dimid,ny_dimid,nz_chemi_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at E_HC5')

      rc=nf90_def_var(fid,"E_HC8",NF90_REAL,(/nx_dimid,ny_dimid,nz_chemi_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at E_HC8')

      rc=nf90_def_var(fid,"E_KET",NF90_REAL,(/nx_dimid,ny_dimid,nz_chemi_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at E_KET')

      rc=nf90_def_var(fid,"E_OL2",NF90_REAL,(/nx_dimid,ny_dimid,nz_chemi_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at E_OL2')

      rc=nf90_def_var(fid,"E_OLI",NF90_REAL,(/nx_dimid,ny_dimid,nz_chemi_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at E_OLI')

      rc=nf90_def_var(fid,"E_OLT",NF90_REAL,(/nx_dimid,ny_dimid,nz_chemi_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at E_OL2')

      rc=nf90_enddef(fid)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at enddef')
      rc=nf90_close(fid)
      return
   end subroutine create_NETCDF_FILE

!-------------------------------------------------------------------------------
   
   subroutine get_WRFCHEM_fld_real(file,name,data4d,nx,ny,nz,nt)
      implicit none
      include 'netcdf.inc'      
      integer, parameter                                  :: maxdim=6
      integer                                             :: nx,ny,nz,nt
      integer                                             :: i,rc
      integer                                             :: f_id
      integer                                             :: v_id,v_ndim,typ,natts
      integer,dimension(maxdim)                           :: one
      integer,dimension(maxdim)                           :: v_dimid
      integer,dimension(maxdim)                           :: v_dim
      real,dimension(nx,ny,nz,nt)                         :: data4d
      character(len=200)                                  :: v_nam
      character*(*)                                       :: name
      character*(*)                                       :: file
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
!      print *, v_id
      if(rc.ne.0) then
         print *, 'nf_inq_varid error ', v_id
         stop
      endif
!
! get dimension identifiers
      v_dimid=0
      rc = nf_inq_var(f_id,v_id,v_nam,typ,v_ndim,v_dimid,natts)
!      print *, v_dimid
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
!      print *, v_dim
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
         print *, 'ERROR: time dimension conflict ',nt,v_dim(4)
         stop
      endif
!
! get data
      one(:)=1
      rc = nf_get_vara_real(f_id,v_id,one,v_dim,data4d)
      rc = nf_close(f_id)
      return
   end subroutine get_WRFCHEM_fld_real

!-------------------------------------------------------------------------------
   
   subroutine put_NETCDF_fld_int(wrfchem_file,var_name,var_units,data,nx,ny,nz)
      use :: netcdf
      implicit none
!
      integer                       :: rc,fid,varid
      integer                       :: nx,ny,nz
      integer,dimension(nx,ny,nz)   :: data
      character(len=*)              :: wrfchem_file,var_name,var_units
!
      rc=nf90_open(trim(wrfchem_file),NF90_WRITE,fid)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at put open')
      
      rc=nf90_inq_varid(fid,trim(var_name),varid)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at put inq_varid')

      rc=nf90_put_var(fid,varid,data)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at put var'//trim(var_name))

      rc=nf90_redef(fid)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at put redef')

      rc=nf90_put_att(fid,varid,"units",trim(var_units))
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at put att'//trim(var_name))

      rc=nf90_enddef(fid)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at put enddef')
      
      rc=nf90_close(fid)
      return
   end subroutine put_NETCDF_fld_int

!-------------------------------------------------------------------------------
   
   subroutine put_NETCDF_fld_real(wrfchem_file,var_name,var_units,data,nx,ny,nz)
      use :: netcdf
      implicit none
!
      integer                       :: rc,fid,varid
      integer                       :: nx,ny,nz
      integer,dimension(nx,ny,nz)   :: data
      character(len=*)              :: wrfchem_file,var_name,var_units
!
      rc=nf90_open(trim(wrfchem_file),NF90_WRITE,fid)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at put open')
      
      rc=nf90_inq_varid(fid,trim(var_name),varid)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at put inq_varid')

      rc=nf90_put_var(fid,varid,data)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at put var'//trim(var_name))

      rc=nf90_redef(fid)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at put redef')

      rc=nf90_put_att(fid,varid,"units",trim(var_units))
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at put att'//trim(var_name))

      rc=nf90_enddef(fid)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at put enddef')
      
      rc=nf90_close(fid)
      return
   end subroutine put_NETCDF_fld_real

!-------------------------------------------------------------------------------

   subroutine handle_err(rc,err_msg)
      use :: netcdf
      implicit none
      integer           :: rc
      character(len=*)  :: err_msg
!
      print *, 'NETCDF ERROR: ',trim(err_msg),' MSG=',nf90_strerror(rc)
      stop
   end subroutine handle_err
