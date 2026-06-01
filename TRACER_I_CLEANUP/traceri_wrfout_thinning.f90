  program main
      implicit none
      integer,parameter                    :: nvars=94
      integer                              :: nx,ny,nz,ivar,unit
      integer                              :: i,j,k
      integer,dimension(nvars)             :: arc_rank
      real                                 :: p_top,t_base,kappa
      real,allocatable,dimension(:)        :: znu_fld
      real,allocatable,dimension(:,:)      :: fld2d,mu_fld,mub_fld
      real,allocatable,dimension(:,:,:)    :: fld3d,fld_stag
      real,allocatable,dimension(:,:,:)    :: p_fld,p_1,p_2,p_base,t_fld
      character(len=200)                   :: path_input,path_output
      character(len=200)                   :: file_input,file_output
      character(len=200)                   :: read_file,write_file
      character(len=50),dimension(nvars)   :: arc_vars
      character(len=200),dimension(nvars)  :: arc_units_coms
! 
! Size wrfout (un-thinned and compressed):  1.1 G
! Size wrfout (thinned and compressed):     430 M
!
! Size reduction for one run_eXXX directory
! Without thinning and compression          8.0 G
! With thinning and compression             2.3 G
!
! Size reduction for wrfchem_initial
! Without thinning and compression          284 G
! With thinning and compression              69 G
!     
      namelist/wrfout_thinning_nml/path_input,path_output,file_input,file_output
!
      nx=440
      ny=284
      nz=50
      p_top=5000.
      t_base=290.
      kappa=0.286
!
      arc_vars=['XLONG','XLAT','P','PSFC','THM','U','V','W','QVAPOR','TH2', &
      'Q2','U10','V10','co','o3','no','no2','so2','sulf','PM10', &
      'PM2_5_DRY','hno3','hcho','hono','nh3','ch4','act','eoh','eteg','eth', &
      'hc3','hc5','hc8','ket','oli','olt','iso','ald','paa','pan', &
      'mpan','moh','CLDFRA','CLDFRA2','PBLH','TMN','HFX','ACHFX','LH','ACLHF', &
      'QFX','ALBEDO','ALBBCK','EMISS','EXTCOF55','ACSWUPT','ACSWUPTC','ACSWDNT','ACSWDNTC','ACSWUPB', &
      'ACSWUPBC','ACSWDNB','ACSWDNBC','ACLWUPT','ACLWUPTC','ACLWDNT','ACLWDNTC','ACLWUPB','ACLWUPBC','ACLWDNB',&
      'ACLWDNBC','SWUPT','SWUPTC','SWDNT','SWDNTC','SWUPB','SWUPBC','SWDNB','SWDNBC','LWUPT', &
      'LWUPTC','LWDNT','LWDNTC','LWUPB','LWUPBC','LWDNB','LWDNBC','SWDOWN','SWNORM','OLR', &
      'GLW','AOD_OUT','AOD2D_OUT','ATOP2D_OUT']
!
      arc_rank=[2,2,3,2,3,3,3,3,3,2,  2,2,2,3,3,3,3,3,3,3,  3,3,3,3,3,3,3,3,3,3,  3,3,3,3,3,3,3,3,3,3, &
      3,3,3,3,2,2,2,2,2,2,  2,2,2,2,3,2,2,2,2,2,  2,2,2,2,2,2,2,2,2,2,  2,2,2,2,2,2,2,2,2,2,  &
      2,2,2,2,2,2,2,2,2,2,  2,3,2,2]
!
      arc_units_coms=['West to east longitude: degrees', &
      'South to north latitude: degrees',&
      'Total pressure: Pa',&
      'Surface pressure: Pa',&
      'Total temperature: K',&
      'West to east velocity: m/s',&
      'South to north velocity: m/s',&
      'Bottom to top velocity: m/s',&
      'Water vapor mixing ratio: kg/kg',&
      'Potential temperature at 2 m: K',&                                      ! 10
      'Water vapor mixing ratio at 2 m: kg/kg',&
      'West to east velocity at 10 m: m/s',&
      'South to north velocity at 10 m: m/s',&
      'CO mixing ratio: kg/kg (ppmb)',&
      'O3 mixing ratio: kg/kg (ppmb)',&
      'NO mixing ratio: kg/kg (ppmb)',&
      'NO2 mixing ratio: kg/kg (ppmb)',&
      'SO2 mixing ratio: kg/kg (ppmb)',&
      'SO4^-2 mixing ratio: kg/kg (ppmb)',&
      'PM10 dry mass: ug/m^-3',&                                               ! 20
      'PM2.5 dry mass: ug/m^-3',&
      'HNO3 mixing ratio: kg/kg (ppmb)',&
      'HCHO mixing ratio: kg/kg (ppmb)',&
      'HONO mixing ratio: kg/kg (ppmb)',&
      'NH3 mixing ratio: kg/kg (ppmb)',&
      'CH4 mixing ratio: kg/kg (ppmb)',&
      'ACT mixing ratio: kg/kg (ppmb)',&
      'EOH mixing ratio: kg/kg (ppmb)',&
      'ETEG mixing ratio: kg/kg (ppmb)',&
      'ETH mixing ratio: kg/kg (ppmb)',&                                       ! 30
      'HC3 mixing ratio: kg/kg (ppmb)',&
      'HC5 mixing ratio: kg/kg (ppmb)',&
      'HC8 mixing ratio: kg/kg (ppmb)',&
      'KET mixing ratio: kg/kg (ppmb)',&
      'OLI mixing ratio: kg/kg (ppmb)',&
      'OLT mixing ratio: kg/kg (ppmb)',&
      'ISO mixing ratio: kg/kg (ppmb)',&
      'ALD mixing ratio: kg/kg (ppmb)',&
      'PAA mixing ratio: kg/kg (ppmb)',&
      'PAN mixing ratio: kg/kg (ppmb)',&                                       ! 40
      'MPAN mixing ratio: kg/kg (ppmb)',&
      'MOH mixing ratio: kg/kg (ppmb)',&
      'Cloud fraction: fraction',&
      'Cloud fraction: fraction',&
      'PBL height: m',&
      'Soil temperature at lower boundary: K',&
      'Upward sensible heat flux at surface: W m^-2',&
      'Accumulated upward sensible heat flux at surface: W m^-2',&
      'Upward atent heat flux at surface: W m^-2',&
      'Accumulated latent heat flux at surface: W m^-2',&                     ! 50
      'Upward moisture flux at surface: W m^-2',&
      'Surface albedo: fractional percent',&
      'Background albedo: fractional percent',&
      'Surface emissivity: fractional percent',&
      '55 um extinction coef: km^-1',&
      'Accumulated upwelling SW flux at top: J m^-2',&
      'Accumulated upwelling clear sky SW flux at top: J m^-2',&
      'Accumulated downwelling SW flux at top: J m^-2',&
      'Accumulated downwelling clear sky SW flux at top: J m^-2',&
      'Accumulated upwelling SW flux at surface: J m^-2',&                     ! 60
      'Accumulated upwelling clear sky SW flux at surface: J m^-2',&
      'Accumulated downwelling SW flux at surface: J m^-2',&
      'Accumulated downwelling clear sky SW flux at surface: J m^-2',&
      'Accumulated upwelling LW flux at top: J m^-2',&
      'Accumulated upwelling clear sky LW flux at top: J m^-2',&
      'Accumulated downwelling LW flux at top: J m^-2',&
      'Accumulated downwelling clear sky LW flux at top: J m^-2',&
      'Accumulated upwelling LW flux at surface: J m^-2',&
      'Accumulated upwelling clear sky LW flux at surface: J m^-2',&
      'Accumulated downwelling LW flux at surface: J m^-2',&                   ! 70
      'Accumulated downwelling clear sky LW flux at surface: J m^-2',&
      'Instantaneous upwelling SW flux at top: W m^-2',&
      'Instantaneous upwelling clear sky SW flux at top: W m^-2',&
      'Instantaneous downwelling SW flux at top: W m^-2',&
      'Instantaneous downwelling clear sky SW flux at top: W m^-2',&
      'Instantaneous upwelling SW flux at surface: W m^-2',&
      'Instantaneous upwelling clear sky SW flux at surface: W m^-2',&
      'Instantaneous downwelling SW flux at surface: W m^-2',&
      'Instantaneous downwelling clear sky SW flux at surface: W m^-2',&
      'Instantaneous upwelling LW flux at top: W m^-2',&                       ! 80
      'Instantaneous upwelling clear sky LW flux at top: W m^-2',&
      'Instantaneous downwelling LW flux at top: W m^-2',&
      'Instantaneous downwelling clear sky LW flux at top: W m^-2',&
      'Instantaneous upwelling LW flux at surface: W m^-2',&
      'Instantaneous upwelling clear sky LW flux at surface: W m^-2',&
      'Instantaneous downwelling LW flux at surface: W m^-2',&
      'Instantaneous downwelling clear sky LW flux at surface: W m^-2',&
      'Downwrd SW flux at surface: W m^-2',&
      'Normal downwrd SW flux at surface: W m^-2',&
      'Upward LW flux at TOA: W m^-2',&                                        ! 90
      'Downward LW flux at surface: W m^-2',&
      'Aerosol optical depth: no units',&
      '2D aerosol optical depth: no units',&
      'Aerosol optical depth at top: no units']
!      
      allocate(fld2d(nx,ny))
      allocate(fld3d(nx,ny,nz))
!
! Read namelist data
      unit=20
      open(unit=unit,file="wrfout_thinning_nml.nl",form="formatted", &
      status="old",action="read")
      rewind(unit)
      read(unit,wrfout_thinning_nml)
      close(unit)
      print *, 'path_input     ',trim(path_input)
      print *, 'path_output    ',trim(path_output)
      print *, 'file_input     ',trim(file_input)
      print *, 'file_output    ',trim(file_output)
!
! Create thinned wrfout file
      read_file=trim(path_input)//"/"//trim(file_input)
      write_file=trim(path_output)//"/"//trim(file_output)
      print *, 'APM: write file ',trim(write_file)
      call create_NETCDF_file(trim(write_file),nx,ny,nz)
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
            if(trim(arc_vars(ivar)).eq.'P') then
               allocate(p_fld(nx,ny,nz))
               allocate(p_1(nx,ny,nz))
               allocate(p_2(nx,ny,nz))
               allocate(p_base(nx,ny,nz))
               allocate(mu_fld(nx,ny))
               allocate(mub_fld(nx,ny))
               allocate(znu_fld(nz))
               call get_WRFCHEM_fld_real(trim(read_file),"P",p_fld,nx,ny,nz,1)
               call get_WRFCHEM_fld_real(trim(read_file),"PB",p_base,nx,ny,nz,1)
               call get_WRFCHEM_fld_real(trim(read_file),"MU",mu_fld,nx,ny,1,1) 
               call get_WRFCHEM_fld_real(trim(read_file),"MUB",mub_fld,nx,ny,1,1) 
               call get_WRFCHEM_fld_real(trim(read_file),"ZNU",znu_fld,nz,1,1,1)
               do i=1,nx
                  do j=1,ny
                     do k=1,nz
                        p_1(i,j,k)=znu_fld(k)*(mu_fld(i,j)+mub_fld(i,j))+p_top
                     enddo
                  enddo
               enddo
               do i=1,nx
                  do j=1,ny
                     do k=1,nz
                        p_2(i,j,k)=p_fld(i,j,k)+p_base(i,j,k)
                     enddo
                  enddo
               enddo
               p_fld(:,:,:)=p_2(:,:,:)
!               print *,'APM: Put ',trim(arc_vars(ivar)),trim(arc_units_coms(ivar))
!               print *, 'PRESSURE: ',p_fld(:,:,1)
               call put_NETCDF_fld_real(trim(write_file),trim(arc_vars(ivar)),trim(arc_units_coms(ivar)), &
               p_fld,nx,ny,nz)
               deallocate(p_1)
               deallocate(p_2)
               deallocate(p_base)
               deallocate(mu_fld)
               deallocate(mub_fld)
               deallocate(znu_fld)
               cycle
            elseif (trim(arc_vars(ivar)).eq.'THM') then
               allocate(t_fld(nx,ny,nz))
               call get_WRFCHEM_fld_real(trim(read_file),"T00",t_base,1,1,1,1)
               call get_WRFCHEM_fld_real(trim(read_file),"THM",t_fld(1,1,1),nx,ny,nz,1)
               do i=1,nx
                  do j=1,ny
                     do k=1,nz
                        t_fld(i,j,k)=((t_fld(i,j,k)+t_base))* &
                        (p_fld(i,j,k)/100000.)**kappa
                     enddo
                  enddo
               enddo
               call put_NETCDF_fld_real(trim(write_file),"T",trim(arc_units_coms(ivar)), &
               t_fld,nx,ny,nz)
               deallocate(p_fld)
               deallocate(t_fld)
               cycle
            elseif (trim(arc_vars(ivar)).eq.'U') then
               allocate(fld_stag(nx+1,ny,nz))
               call get_WRFCHEM_fld_real(trim(read_file),trim(arc_vars(ivar)),fld_stag,nx+1,ny,nz,1)
               do i=1,nx
                  do j=1,ny
                     do k=1,nz
                        fld3d(i,j,k)=(fld_stag(i,j,k)+fld_stag(i+1,j,k))/2.
                     enddo
                  enddo
               enddo
               call put_NETCDF_fld_real(trim(write_file),trim(arc_vars(ivar)),trim(arc_units_coms(ivar)), &
               fld3d,nx,ny,nz)
               deallocate(fld_stag)
               cycle
            elseif (trim(arc_vars(ivar)).eq.'V') then
               allocate(fld_stag(nx,ny+1,nz))
               call get_WRFCHEM_fld_real(trim(read_file),trim(arc_vars(ivar)),fld_stag,nx,ny+1,nz,1)
               do i=1,nx
                  do j=1,ny
                     do k=1,nz
                        fld3d(i,j,k)=(fld_stag(i,j,k)+fld_stag(i,j+1,k))/2.
                     enddo
                  enddo
               enddo
               call put_NETCDF_fld_real(trim(write_file),trim(arc_vars(ivar)),trim(arc_units_coms(ivar)), &
               fld3d,nx,ny,nz)
               deallocate(fld_stag)
               cycle
            elseif (trim(arc_vars(ivar)).eq.'W') then
               allocate(fld_stag(nx,ny,nz+1))
               call get_WRFCHEM_fld_real(trim(read_file),trim(arc_vars(ivar)),fld_stag,nx,ny,nz+1,1)
               do i=1,nx
                  do j=1,ny
                     do k=1,nz
                        fld3d(i,j,k)=(fld_stag(i,j,k)+fld_stag(i,j,k+1))/2.
                     enddo
                  enddo
               enddo
               call put_NETCDF_fld_real(trim(write_file),trim(arc_vars(ivar)),trim(arc_units_coms(ivar)), &
               fld3d,nx,ny,nz)
               deallocate(fld_stag)
               cycle
            else
               call get_WRFCHEM_fld_real(trim(read_file),trim(arc_vars(ivar)),fld3d,nx,ny,nz,1)
               call put_NETCDF_fld_real(trim(write_file),trim(arc_vars(ivar)),trim(arc_units_coms(ivar)), &
               fld3d,nx,ny,nz)
               cycle     
            endif   
         endif
      enddo
      deallocate(fld2d)
      deallocate(fld3d)
   end program main

!-------------------------------------------------------------------------------

   subroutine create_NETCDF_file(wrfchem_thin_file,nx,ny,nz)
      use :: netcdf
      implicit none
!      
      integer                    :: nx,ny,nz,nz_ddv,rc,fid
      integer                    :: var_id,att_id,nx_dimid,ny_dimid,nz_dimid
      character(len=*)           :: wrfchem_thin_file
!
! Define dimensions
      rc=nf90_create(trim(wrfchem_thin_file),NF90_CLOBBER,fid)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at create file')

      rc=nf90_def_dim(fid,"west-east",nx,nx_dimid)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at nx_dimid')

      rc=nf90_def_dim(fid,"south-north",ny,ny_dimid)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at ny_dimid')

      rc=nf90_def_dim(fid,"bottom-top",nz,nz_dimid)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at nz_dimid')
!
! Define variables
      rc=nf90_def_var(fid,"XLONG",NF90_REAL,(/nx_dimid,ny_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at XLONG')

      rc=nf90_def_var(fid,"XLAT",NF90_REAL,(/nx_dimid,ny_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at XLAT')

      rc=nf90_def_var(fid,"P",NF90_REAL,(/nx_dimid,ny_dimid,nz_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at P')

      rc=nf90_def_var(fid,"PSFC",NF90_REAL,(/nx_dimid,ny_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at PSFC')

      rc=nf90_def_var(fid,"T",NF90_REAL,(/nx_dimid,ny_dimid,nz_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at THM')

      rc=nf90_def_var(fid,"U",NF90_REAL,(/nx_dimid,ny_dimid,nz_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at U')

      rc=nf90_def_var(fid,"V",NF90_REAL,(/nx_dimid,ny_dimid,nz_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at V')

      rc=nf90_def_var(fid,"W",NF90_REAL,(/nx_dimid,ny_dimid,nz_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at W')

      rc=nf90_def_var(fid,"QVAPOR",NF90_REAL,(/nx_dimid,ny_dimid,nz_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at QVAPOR')

      rc=nf90_def_var(fid,"TH2",NF90_REAL,(/nx_dimid,ny_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TH2')

      rc=nf90_def_var(fid,"Q2",NF90_REAL,(/nx_dimid,ny_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at Q2')

      rc=nf90_def_var(fid,"U10",NF90_REAL,(/nx_dimid,ny_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at U10')

      rc=nf90_def_var(fid,"V10",NF90_REAL,(/nx_dimid,ny_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at V10')

      rc=nf90_def_var(fid,"co",NF90_REAL,(/nx_dimid,ny_dimid,nz_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at co')

      rc=nf90_def_var(fid,"o3",NF90_REAL,(/nx_dimid,ny_dimid,nz_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at o3')

      rc=nf90_def_var(fid,"no",NF90_REAL,(/nx_dimid,ny_dimid,nz_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at no')

      rc=nf90_def_var(fid,"no2",NF90_REAL,(/nx_dimid,ny_dimid,nz_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at no2')

      rc=nf90_def_var(fid,"so2",NF90_REAL,(/nx_dimid,ny_dimid,nz_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at so2')

      rc=nf90_def_var(fid,"sulf",NF90_REAL,(/nx_dimid,ny_dimid,nz_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at sulf')

      rc=nf90_def_var(fid,"PM10",NF90_REAL,(/nx_dimid,ny_dimid,nz_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at PM10')

      rc=nf90_def_var(fid,"PM2_5_DRY",NF90_REAL,(/nx_dimid,ny_dimid,nz_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at PM2_5_DRY')

      rc=nf90_def_var(fid,"hno3",NF90_REAL,(/nx_dimid,ny_dimid,nz_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at hno3')

      rc=nf90_def_var(fid,"hcho",NF90_REAL,(/nx_dimid,ny_dimid,nz_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at hcho')

      rc=nf90_def_var(fid,"hono",NF90_REAL,(/nx_dimid,ny_dimid,nz_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at hono')
      
      rc=nf90_def_var(fid,"nh3",NF90_REAL,(/nx_dimid,ny_dimid,nz_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at nh3')

      rc=nf90_def_var(fid,"ch4",NF90_REAL,(/nx_dimid,ny_dimid,nz_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at ch4')

      rc=nf90_def_var(fid,"act",NF90_REAL,(/nx_dimid,ny_dimid,nz_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at act')

      rc=nf90_def_var(fid,"eoh",NF90_REAL,(/nx_dimid,ny_dimid,nz_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at eoh')

      rc=nf90_def_var(fid,"eteg",NF90_REAL,(/nx_dimid,ny_dimid,nz_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at eteg')

      rc=nf90_def_var(fid,"eth",NF90_REAL,(/nx_dimid,ny_dimid,nz_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at eth')

      rc=nf90_def_var(fid,"hc3",NF90_REAL,(/nx_dimid,ny_dimid,nz_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at hc3')

      rc=nf90_def_var(fid,"hc5",NF90_REAL,(/nx_dimid,ny_dimid,nz_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at hc5')

      rc=nf90_def_var(fid,"hc8",NF90_REAL,(/nx_dimid,ny_dimid,nz_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at hc8')

      rc=nf90_def_var(fid,"ket",NF90_REAL,(/nx_dimid,ny_dimid,nz_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at ket')

      rc=nf90_def_var(fid,"oli",NF90_REAL,(/nx_dimid,ny_dimid,nz_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at oli')

      rc=nf90_def_var(fid,"olt",NF90_REAL,(/nx_dimid,ny_dimid,nz_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at olt')

      rc=nf90_def_var(fid,"iso",NF90_REAL,(/nx_dimid,ny_dimid,nz_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at iso')

      rc=nf90_def_var(fid,"ald",NF90_REAL,(/nx_dimid,ny_dimid,nz_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at ald')

      rc=nf90_def_var(fid,"paa",NF90_REAL,(/nx_dimid,ny_dimid,nz_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at paa')

      rc=nf90_def_var(fid,"pan",NF90_REAL,(/nx_dimid,ny_dimid,nz_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at pan')

      rc=nf90_def_var(fid,"mpan",NF90_REAL,(/nx_dimid,ny_dimid,nz_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at mpan')

      rc=nf90_def_var(fid,"moh",NF90_REAL,(/nx_dimid,ny_dimid,nz_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at moh')
      
      rc=nf90_def_var(fid,"CLDFRA",NF90_REAL,(/nx_dimid,ny_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at CLDFRA')

      rc=nf90_def_var(fid,"CLDFRA2",NF90_REAL,(/nx_dimid,ny_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at CLDFRA2')

      rc=nf90_def_var(fid,"PBLH",NF90_REAL,(/nx_dimid,ny_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at PBLH')

      rc=nf90_def_var(fid,"TMN",NF90_REAL,(/nx_dimid,ny_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TMN')
      
      rc=nf90_def_var(fid,"HFX",NF90_REAL,(/nx_dimid,ny_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at HFX')
      
      rc=nf90_def_var(fid,"ACHFX",NF90_REAL,(/nx_dimid,ny_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at ACHFX')
      
      rc=nf90_def_var(fid,"LH",NF90_REAL,(/nx_dimid,ny_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at LH')
      
      rc=nf90_def_var(fid,"ACLHF",NF90_REAL,(/nx_dimid,ny_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at ACLHF')

      rc=nf90_def_var(fid,"QFX",NF90_REAL,(/nx_dimid,ny_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at QFX')

      rc=nf90_def_var(fid,"ALBEDO",NF90_REAL,(/nx_dimid,ny_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at ALBEDO')
      
      rc=nf90_def_var(fid,"ALBBCK",NF90_REAL,(/nx_dimid,ny_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at ALBBCK')
      
      rc=nf90_def_var(fid,"EMISS",NF90_REAL,(/nx_dimid,ny_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at EMISS')

      rc=nf90_def_var(fid,"EXTCOF55",NF90_REAL,(/nx_dimid,ny_dimid,nz_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at EXTCOF55')
      
      rc=nf90_def_var(fid,"ACSWUPT",NF90_REAL,(/nx_dimid,ny_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at ACSWUPT')

      rc=nf90_def_var(fid,"ACSWUPTC",NF90_REAL,(/nx_dimid,ny_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at ACSWUPTC')

      rc=nf90_def_var(fid,"ACSWDNT",NF90_REAL,(/nx_dimid,ny_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at ACSWDNT')

      rc=nf90_def_var(fid,"ACSWDNTC",NF90_REAL,(/nx_dimid,ny_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at ACSWDNTC')

      rc=nf90_def_var(fid,"ACSWUPB",NF90_REAL,(/nx_dimid,ny_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at ACSWUPB')

      rc=nf90_def_var(fid,"ACSWUPBC",NF90_REAL,(/nx_dimid,ny_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at ACSWUPBC')

      rc=nf90_def_var(fid,"ACSWDNB",NF90_REAL,(/nx_dimid,ny_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at ACSWDNB')

      rc=nf90_def_var(fid,"ACSWDNBC",NF90_REAL,(/nx_dimid,ny_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at ACSWDNBC')

      rc=nf90_def_var(fid,"ACLWUPT",NF90_REAL,(/nx_dimid,ny_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at ACLWUPT')

      rc=nf90_def_var(fid,"ACLWUPTC",NF90_REAL,(/nx_dimid,ny_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at ACLWUPTC')

      rc=nf90_def_var(fid,"ACLWDNT",NF90_REAL,(/nx_dimid,ny_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at ACLWDNT')

      rc=nf90_def_var(fid,"ACLWDNTC",NF90_REAL,(/nx_dimid,ny_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at ACLWDNTC')

      rc=nf90_def_var(fid,"ACLWUPB",NF90_REAL,(/nx_dimid,ny_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at ACLWUPB')

      rc=nf90_def_var(fid,"ACLWUPBC",NF90_REAL,(/nx_dimid,ny_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at ACLWUPBC')

      rc=nf90_def_var(fid,"ACLWDNB",NF90_REAL,(/nx_dimid,ny_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at ACLWDNB')

      rc=nf90_def_var(fid,"ACLWDNBC",NF90_REAL,(/nx_dimid,ny_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at ACLWDNBC')

      rc=nf90_def_var(fid,"SWUPT",NF90_REAL,(/nx_dimid,ny_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at SWUPT')

      rc=nf90_def_var(fid,"SWUPTC",NF90_REAL,(/nx_dimid,ny_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at SWUPTC')

      rc=nf90_def_var(fid,"SWDNT",NF90_REAL,(/nx_dimid,ny_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at SWDNT')

      rc=nf90_def_var(fid,"SWDNTC",NF90_REAL,(/nx_dimid,ny_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at SWDNTC')

      rc=nf90_def_var(fid,"SWUPB",NF90_REAL,(/nx_dimid,ny_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at SWUPB')

      rc=nf90_def_var(fid,"SWUPBC",NF90_REAL,(/nx_dimid,ny_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at SWUPBC')

      rc=nf90_def_var(fid,"SWDNB",NF90_REAL,(/nx_dimid,ny_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at SWDNB')

      rc=nf90_def_var(fid,"SWDNBC",NF90_REAL,(/nx_dimid,ny_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at SWDNBC')

      rc=nf90_def_var(fid,"LWUPT",NF90_REAL,(/nx_dimid,ny_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at LWUPT')

      rc=nf90_def_var(fid,"LWUPTC",NF90_REAL,(/nx_dimid,ny_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at LWUPTC')

      rc=nf90_def_var(fid,"LWDNT",NF90_REAL,(/nx_dimid,ny_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at LWDNT')

      rc=nf90_def_var(fid,"LWDNTC",NF90_REAL,(/nx_dimid,ny_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at LWDNTC')

      rc=nf90_def_var(fid,"LWUPB",NF90_REAL,(/nx_dimid,ny_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at LWUPB')

      rc=nf90_def_var(fid,"LWUPBC",NF90_REAL,(/nx_dimid,ny_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at LWUPBC')

      rc=nf90_def_var(fid,"LWDNB",NF90_REAL,(/nx_dimid,ny_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at LWDNB')

      rc=nf90_def_var(fid,"LWDNBC",NF90_REAL,(/nx_dimid,ny_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at LWDNBC')

      rc=nf90_def_var(fid,"SWDOWN",NF90_REAL,(/nx_dimid,ny_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at SWDOWN')

      rc=nf90_def_var(fid,"SWNORM",NF90_REAL,(/nx_dimid,ny_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at SWNORM')

      rc=nf90_def_var(fid,"OLR",NF90_REAL,(/nx_dimid,ny_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at QLR')

      rc=nf90_def_var(fid,"GLW",NF90_REAL,(/nx_dimid,ny_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at GLW')
      
      rc=nf90_def_var(fid,"AOD_OUT",NF90_REAL,(/nx_dimid,ny_dimid,nz_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at AOD_OUT')

      rc=nf90_def_var(fid,"AOD2D_OUT",NF90_REAL,(/nx_dimid,ny_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at AOD2D_OUT')

      rc=nf90_def_var(fid,"ATOP2D_OUT",NF90_REAL,(/nx_dimid,ny_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at ATOP2D_OUT')

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
