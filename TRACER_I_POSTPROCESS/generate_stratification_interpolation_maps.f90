  program main
      implicit none
      integer                                    :: nx,ny,nz,nz_chemi,nz_fire,num_mems,num_cities
      integer                                    :: i,j,k,imem,ifld,unit,urban_flg,ii,jj
      integer                                    :: num_met_flds,num_chem_flds,num_chemi_flds,num_fire_flds
      integer                                    :: nx_tcr2,ny_tcr2,nz_tcr2,nt_tcr2
      integer                                    :: nx_camchem,ny_camchem,nz_camchem,nt_camchem
      integer                                    :: nx_wrfcmaq,ny_wrfcmaq
      integer                                    :: nz_wrfcmaq_met,nz_wrfcmaq_chem
      integer                                    :: nt_wrfcmaq_met,nt_wrfcmaq_chem
      integer                                    :: lon_conus_west,lon_conus_east,lat_conus_south,lat_conus_north
      integer                                    :: npts_wrfchem_conus,npts_wrfcmaq_conus
      integer                                    :: num_wrfcmaq,num_wrfchem_conus,num_wrfcmaq_conus
      integer                                    :: ipts,icity,npts_urban,npts_rural
      integer                                    :: wrfchem_rural_npts,wrfcmaq_rural_npts
      integer                                    :: i_min,j_min,reject
      integer,allocatable,dimension(:)           :: wrfchem_conus_ii,wrfchem_conus_jj
      integer,allocatable,dimension(:)           :: wrfcmaq_conus_ii,wrfcmaq_conus_jj
      integer,allocatable,dimension(:)           :: wrfchem_urban_npts
      integer,allocatable,dimension(:)           :: wrfchem_rural_ii,wrfchem_rural_jj
      integer,allocatable,dimension(:,:)         :: wrfchem_urban_ii,wrfchem_urban_jj
      integer,allocatable,dimension(:)           :: wrfcmaq_urban_npts
      integer,allocatable,dimension(:)           :: wrfcmaq_rural_ii,wrfcmaq_rural_jj
      integer,allocatable,dimension(:,:)         :: wrfcmaq_urban_ii,wrfcmaq_urban_jj
      integer,allocatable,dimension(:)           :: wrfcmaq_i,wrfcmaq_j
      integer,allocatable,dimension(:)           :: wrfcmaq_ii,wrfcmaq_jj
      integer,allocatable,dimension(:,:)         :: tcr2_ll_ii,tcr2_lr_ii,tcr2_ul_ii,tcr2_ur_ii
      integer,allocatable,dimension(:,:)         :: tcr2_ll_jj,tcr2_lr_jj,tcr2_ul_jj,tcr2_ur_jj
      integer,allocatable,dimension(:,:)         :: camchem_ll_ii,camchem_lr_ii,camchem_ul_ii,camchem_ur_ii
      integer,allocatable,dimension(:,:)         :: camchem_ll_jj,camchem_lr_jj,camchem_ul_jj,camchem_ur_jj
      real                                       :: kappa,t_base,diff,dx,dy,xi,xj,lon_trac_fixed,lon_cmaq_fixed
      real                                       :: lon_us_west,lon_us_east,lat_us_south,lat_us_north
      real                                       :: pa_cmaq,pb_cmaq,xcen_cmaq,delx_cmaq,xcmaq_sw    
      real,allocatable,dimension(:)              :: lon1_cities,lon2_cities,lat1_cities,lat2_cities
      real,allocatable,dimension(:)              :: t_conus_mn,t_conus_sd,u_conus_mn,u_conus_sd
      real,allocatable,dimension(:)              :: v_conus_mn,v_conus_sd,q_conus_mn,q_conus_sd
      real,allocatable,dimension(:)              :: co_conus_mn,co_conus_sd,o3_conus_mn,o3_conus_sd
      real,allocatable,dimension(:)              :: no2_conus_mn,no2_conus_sd,so2_conus_mn,so2_conus_sd
      real,allocatable,dimension(:)              :: e_co_conus_mn,e_co_conus_sd,e_no2_conus_mn,e_no2_conus_sd
      real,allocatable,dimension(:)              :: e_so2_conus_mn,e_so2_conus_sd,ebu_co_conus_mn,ebu_co_conus_sd
      real,allocatable,dimension(:)              :: ebu_no2_conus_mn,ebu_no2_conus_sd,ebu_so2_conus_mn,ebu_so2_conus_sd
      real,allocatable,dimension(:)              :: t_urban_mn,t_urban_sd,u_urban_mn,u_urban_sd
      real,allocatable,dimension(:)              :: v_urban_mn,v_urban_sd,q_urban_mn,q_urban_sd
      real,allocatable,dimension(:)              :: co_urban_mn,co_urban_sd,o3_urban_mn,o3_urban_sd
      real,allocatable,dimension(:)              :: no2_urban_mn,no2_urban_sd,so2_urban_mn,so2_urban_sd
      real,allocatable,dimension(:)              :: e_co_urban_mn,e_co_urban_sd,e_no2_urban_mn,e_no2_urban_sd
      real,allocatable,dimension(:)              :: e_so2_urban_mn,e_so2_urban_sd,ebu_co_urban_mn,ebu_co_urban_sd
      real,allocatable,dimension(:)              :: ebu_no2_urban_mn,ebu_no2_urban_sd,ebu_so2_urban_mn,ebu_so2_urban_sd
      real,allocatable,dimension(:)              :: t_rural_mn,t_rural_sd,u_rural_mn,u_rural_sd
      real,allocatable,dimension(:)              :: v_rural_mn,v_rural_sd,q_rural_mn,q_rural_sd
      real,allocatable,dimension(:)              :: co_rural_mn,co_rural_sd,o3_rural_mn,o3_rural_sd
      real,allocatable,dimension(:)              :: no2_rural_mn,no2_rural_sd,so2_rural_mn,so2_rural_sd
      real,allocatable,dimension(:)              :: e_co_rural_mn,e_co_rural_sd,e_no2_rural_mn,e_no2_rural_sd
      real,allocatable,dimension(:)              :: e_so2_rural_mn,e_so2_rural_sd,ebu_co_rural_mn,ebu_co_rural_sd
      real,allocatable,dimension(:)              :: ebu_no2_rural_mn,ebu_no2_rural_sd,ebu_so2_rural_mn,ebu_so2_rural_sd
      real,allocatable,dimension(:)              :: lon_tcr2,lat_tcr2,lon_camchem,lat_camchem
      real,allocatable,dimension(:,:)            :: t_cities_mn,t_cities_sd,u_cities_mn,u_cities_sd
      real,allocatable,dimension(:,:)            :: v_cities_mn,v_cities_sd,q_cities_mn,q_cities_sd
      real,allocatable,dimension(:,:)            :: co_cities_mn,co_cities_sd,o3_cities_mn,o3_cities_sd
      real,allocatable,dimension(:,:)            :: no2_cities_mn,no2_cities_sd,so2_cities_mn,so2_cities_sd
      real,allocatable,dimension(:,:)            :: e_co_cities_mn,e_co_cities_sd,e_no2_cities_mn,e_no2_cities_sd
      real,allocatable,dimension(:,:)            :: e_so2_cities_mn,e_so2_cities_sd,ebu_co_cities_mn,ebu_co_cities_sd
      real,allocatable,dimension(:,:)            :: ebu_no2_cities_mn,ebu_no2_cities_sd,ebu_so2_cities_mn,ebu_so2_cities_sd
      real,allocatable,dimension(:,:)            :: lon,lat
      real,allocatable,dimension(:,:)            :: lon_wrfcmaq,lat_wrfcmaq
      real,allocatable,dimension(:,:,:)          :: p_ens_mn,p_ens_sd
      real,allocatable,dimension(:,:,:)          :: t_ens_mn,t_ens_sd,u_ens_mn,u_ens_sd
      real,allocatable,dimension(:,:,:)          :: v_ens_mn,v_ens_sd,q_ens_mn,q_ens_sd
      real,allocatable,dimension(:,:,:)          :: co_ens_mn,co_ens_sd,o3_ens_mn,o3_ens_sd
      real,allocatable,dimension(:,:,:)          :: no2_ens_mn,no2_ens_sd,so2_ens_mn,so2_ens_sd
      real,allocatable,dimension(:,:,:)          :: e_co_ens_mn,e_co_ens_sd
      real,allocatable,dimension(:,:,:)          :: ebu_co_ens_mn,ebu_co_ens_sd
      real,allocatable,dimension(:,:,:)          :: e_no2_ens_mn,e_no2_ens_sd,e_so2_ens_mn,e_so2_ens_sd
      real,allocatable,dimension(:,:,:)          :: ebu_no2_ens_mn,ebu_no2_ens_sd,ebu_so2_ens_mn,ebu_so2_ens_sd
      real,allocatable,dimension(:,:,:)          :: stag_fld
      real,allocatable,dimension(:,:,:,:)        :: p_fld,p_base,t_fld,u_fld,v_fld,q_fld
      real,allocatable,dimension(:,:,:,:)        :: co_fld,o3_fld,no2_fld,so2_fld
      real,allocatable,dimension(:,:,:,:)        :: e_co_fld,e_no2_fld,e_so2_fld
      real,allocatable,dimension(:,:,:,:)        :: ebu_co_fld,ebu_no2_fld,ebu_so2_fld
      character(len=30)                          :: cmem
      character(len=200)                         :: wrfchem_file,path_input,path_output
      character(len=200)                         :: wrfout_input,wrfchemi_input,wrffirechemi_input,file_output
      character(len=200)                         :: tcr2_met_pre,tcr2_met_suf,tcr2_chem_file
      character(len=200)                         :: tcr2_file,camchem_file,wrfcmaq_file
      character(len=200)                         :: wrfcmaq_gridcro2d,wrfcmaq_griddot2d,wrfcmaq_metcro2d
      character(len=200)                         :: wrfcmaq_metcro3d,wrfcmaq_metdot3d,wrfcmaq_chemcro2d
      character(len=60),allocatable,dimension(:) :: met_flds,chem_flds,chemi_flds,firechemi_flds
      character(len=80),allocatable,dimension(:)  :: cities!
      namelist/ens_postprocess/path_input,path_output,wrfout_input, &
      wrfchemi_input,wrffirechemi_input,file_output, &
      nx,ny,nz,nz_chemi,nz_fire,num_met_flds,num_chem_flds,num_chemi_flds,num_fire_flds, &
      num_mems,tcr2_met_pre,tcr2_met_suf,tcr2_chem_file,camchem_file, &
      wrfcmaq_gridcro2d,wrfcmaq_griddot2d,wrfcmaq_metcro2d,wrfcmaq_metcro3d, &
      wrfcmaq_metdot3d,wrfcmaq_chemcro2d
      namelist/ens_varlist/met_flds,chem_flds,chemi_flds,firechemi_flds
!
      pa_cmaq=33.
      pb_cmaq=45.
!      xcen_cmaq=-97.
      xcen_cmaq=-97.70499
      xcen_cmaq=xcen_cmaq+360.
      delx_cmaq=12000.
!
      kappa=0.286
      num_cities=29
      urban_flg=0
      lon_conus_west=-125.
      lon_conus_east=-67.
      lat_conus_south=24.
      lat_conus_north=49.
!
      nx_tcr2=78
      ny_tcr2=35
      nz_tcr2=32
      nt_tcr2=360
!
      nx_camchem=81
      ny_camchem=47
      nz_camchem=32
      nt_camchem=8
!
! CRO is grid centers DOT is grid edges
! WRFCMAQ CHEM is at level 1 only ????      
      nx_wrfcmaq=442
      ny_wrfcmaq=265
      nz_wrfcmaq_met=35
      nz_wrfcmaq_chem=1
      nt_wrfcmaq_met=25
      nt_wrfcmaq_chem=720
!
      unit=20
      open(unit=unit,file="ens_postprocess.nl",form="formatted", &
      status="old",action="read")
      rewind(unit)
      read(unit,ens_postprocess)
      close(unit)
!
      allocate(met_flds(num_met_flds))      
      allocate(chem_flds(num_chem_flds))      
      allocate(chemi_flds(num_chemi_flds))      
      allocate(firechemi_flds(num_fire_flds))      
      unit=20
      open(unit=unit,file="ens_varlist.nl",form="formatted", &
      status="old",action="read")
      rewind(unit)
      read(unit,ens_varlist)
      close(unit)
!
      npts_wrfchem_conus=nx*ny      
      npts_wrfcmaq_conus=nx*ny      
      npts_urban=200
      npts_rural=nx*ny
!
!      print *, "NAMELIST: ens_postprocess"
!      print *,"path input ",         trim(path_input)
!      print *,"path output ",        trim(path_output)
!      print *,"wrfout_input ",       trim(wrfout_input)
!      print *,"wrfchemi_input ",     trim(wrfchemi_input)
!      print *,"wrffirechemi_input ", trim(wrffirechemi_input)
!      print *,"file output ",        trim(file_output)
!      print *,"nx ",                 nx
!      print *,"ny ",                 ny
!      print *,"nz ",                 nz
!      print *,"nz_chemi ",           nz_chemi
!      print *,"nz_fire ",            nz_fire
!      print *,"num_met_flds ",       num_met_flds
!      print *,"num_chem_flds ",      num_chem_flds
!      print *,"num_chemi_flds ",     num_chemi_flds
!      print *,"num_fire_flds ",      num_fire_flds
!      print *,"num_mems ",           num_mems
!      print *,"tcr2_met_pre ",       trim(tcr2_met_pre)
!      print *,"tcr2_met_suf ",       trim(tcr2_met_suf)
!      print *,"tcr2_chem_file ",     trim(tcr2_chem_file)
!      print *,"camchem_file ",      trim(camchem_file)
!      print *,"wrfcmaq_gridcro2d ", trim(wrfcmaq_gridcro2d)
!      print *,"wrfcmaq_griddot2d ", trim(wrfcmaq_griddot2d)
!      print *,"wrfcmaq_metcro2d ",  trim(wrfcmaq_metcro2d)
!      print *,"wrfcmaq_metcro3d ",  trim(wrfcmaq_metcro3d)
!      print *,"wrfcmaq_metdot3d ",  trim(wrfcmaq_metdot3d)
!      print *,"wrfcmaq_chemcro2d ", trim(wrfcmaq_chemcro2d)
!      print *, " "
!      print *, "NAMELIST: ens_varlist"
!      print *, "met_flds ",        (met_flds(i),i=1,num_met_flds)
!      print *, "chem_flds ",       (chem_flds(i),i=1,num_chem_flds)
!      print *, "chemi_flds ",      (chemi_flds(i),i=1,num_chemi_flds)
!      print *, "fire_flds ",       (fire_flds(i),i=1,num_fire_flds)
!
! Create NETCDF TRACER I stratifications data file
      wrfchem_file=trim(path_output)//"/"//trim(file_output)
      print *, 'APM: Create file ',trim(wrfchem_file)
      call create_NETCDF_file(trim(wrfchem_file),nx,ny,nz,npts_wrfchem_conus,npts_wrfcmaq_conus, &
      num_cities,npts_urban,npts_rural)
!
! TRACER I lon and lat
      allocate(lon(nx,ny))
      allocate(lat(nx,ny))
      wrfchem_file=trim(path_input)//"/run_e001/"//trim(wrfout_input)
      call get_WRFCHEM_fld(trim(wrfchem_file),"XLONG",lon,nx,ny,1,"real")
      call get_WRFCHEM_fld(trim(wrfchem_file),"XLAT",lat,nx,ny,1,"real")
!
! Determine the TRACER I CONUS indices
      num_wrfchem_conus=0
      allocate(wrfchem_conus_ii(nx*ny))
      allocate(wrfchem_conus_jj(nx*ny))
      do i=1,nx
         do j=1,ny
            if(lon(i,j).ge.lon_conus_west .and. lon(i,j).le.lon_conus_east .and. &
               lat(i,j).ge.lat_conus_south .and. lat(i,j).le.lat_conus_north) then
               num_wrfchem_conus=num_wrfchem_conus+1
               wrfchem_conus_ii(num_wrfchem_conus)=i
               wrfchem_conus_jj(num_wrfchem_conus)=j
             endif
         enddo
      enddo
      print *, 'NUM_WRFCHEM_CONUS ',num_wrfchem_conus
!
! Put TRACER I data
      wrfchem_file=trim(path_output)//"/"//trim(file_output)
      print *, 'FILE ',trim(wrfchem_file)
      call put_NETCDF_fld_int(trim(wrfchem_file),"NUM_TRACER_I_CONUS","conus points count", &
      num_wrfchem_conus,1,1,1)
      call put_NETCDF_fld_int(trim(wrfchem_file),"TRACER_I_CONUS_II","west-east index", &
      wrfchem_conus_ii,num_wrfchem_conus,1,1)
      call put_NETCDF_fld_int(trim(wrfchem_file),"TRACER_I_CONUS_JJ","south-north index", &
      wrfchem_conus_jj,num_wrfchem_conus,1,1)
      deallocate(wrfchem_conus_ii,wrfchem_conus_jj)
!
! Determine indices for interpolating TCR2, WRFCMAQ, and CAMCHEM to the WRFCHEM grid
      allocate(lon_tcr2(nx_tcr2))
      allocate(lat_tcr2(ny_tcr2))
      allocate(tcr2_ll_ii(nx,ny),tcr2_ll_jj(nx,ny))
      allocate(tcr2_lr_ii(nx,ny),tcr2_lr_jj(nx,ny))
      allocate(tcr2_ul_ii(nx,ny),tcr2_ul_jj(nx,ny))
      allocate(tcr2_ur_ii(nx,ny),tcr2_ur_jj(nx,ny))
      tcr2_file=trim(tcr2_met_pre)//"t"//trim(tcr2_met_suf)
      print *, trim(tcr2_file)
      call get_WRFCHEM_fld(trim(tcr2_file),"lon",lon_tcr2,nx_tcr2,1,1,"real")
      do i=1,nx_tcr2
         if(lon_tcr2(i).gt.180.) lon_tcr2(i)=lon_tcr2(i)-360.
      enddo
      call get_WRFCHEM_fld(trim(tcr2_file),"lat",lat_tcr2,ny_tcr2,1,1,"real")
      dx=lon_tcr2(2)-lon_tcr2(1)
      dy=lat_tcr2(2)-lat_tcr2(1)
      do i=1,nx
         do j=1,ny
            diff=lon(i,j)-lon_tcr2(1)
            tcr2_ll_ii(i,j)=int(diff/dx)+1
            tcr2_ul_ii(i,j)=int(diff/dx)+1
            tcr2_lr_ii(i,j)=int(diff/dx)+2
            tcr2_ur_ii(i,j)=int(diff/dx)+2
            diff=lat(i,j)-lat_tcr2(1)
            tcr2_ll_jj(i,j)=int(diff/dy)+1
            tcr2_lr_jj(i,j)=int(diff/dy)+1
            tcr2_ul_jj(i,j)=int(diff/dy)+2
            tcr2_ur_jj(i,j)=int(diff/dy)+2
         enddo
      enddo
      wrfchem_file=trim(path_output)//"/"//trim(file_output)
      call put_NETCDF_fld_int(trim(wrfchem_file),"TCR2_LL_II","west-east lower left interpolation index", &
      tcr2_ll_ii,nx,ny,1)
      call put_NETCDF_fld_int(trim(wrfchem_file),"TCR2_LL_JJ","south-north lower left interpolation index", &
      tcr2_ll_jj,nx,ny,1)
      call put_NETCDF_fld_int(trim(wrfchem_file),"TCR2_LR_II","west-east lower right interpolation index", &
      tcr2_lr_ii,nx,ny,1)
      call put_NETCDF_fld_int(trim(wrfchem_file),"TCR2_LR_JJ","south-north lower right interpolation index", &
      tcr2_lr_jj,nx,ny,1)
      call put_NETCDF_fld_int(trim(wrfchem_file),"TCR2_UL_II","west-east lower left interpolation index", &
      tcr2_ul_ii,nx,ny,1)
      call put_NETCDF_fld_int(trim(wrfchem_file),"TCR2_UL_JJ","south-north lower left interpolation index", &
      tcr2_ul_jj,nx,ny,1)
      call put_NETCDF_fld_int(trim(wrfchem_file),"TCR2_UR_II","west-east lower right interpolation index", &
      tcr2_ur_ii,nx,ny,1)
      call put_NETCDF_fld_int(trim(wrfchem_file),"TCR2_UR_JJ","south-north lower right interpolation index", &
      tcr2_ur_jj,nx,ny,1)
      deallocate(lon_tcr2)
      deallocate(lat_tcr2)
      deallocate(tcr2_ll_ii,tcr2_ll_jj)
      deallocate(tcr2_lr_ii,tcr2_lr_jj)
      deallocate(tcr2_ul_ii,tcr2_ul_jj)
      deallocate(tcr2_ur_ii,tcr2_ur_jj)
!
! WRFCMAQ
      allocate(lon_wrfcmaq(nx_wrfcmaq,ny_wrfcmaq))
      allocate(lat_wrfcmaq(nx_wrfcmaq,ny_wrfcmaq))
      allocate(wrfcmaq_i(nx*ny),wrfcmaq_j(nx*ny))
      allocate(wrfcmaq_ii(nx*ny),wrfcmaq_jj(nx*ny))
      print *, trim(wrfcmaq_gridcro2d)
      call get_WRFCHEM_fld(trim(wrfcmaq_gridcro2d),"LON",lon_wrfcmaq,nx_wrfcmaq,ny_wrfcmaq,1,"real")
      call get_WRFCHEM_fld(trim(wrfcmaq_gridcro2d),"LAT",lat_wrfcmaq,nx_wrfcmaq,ny_wrfcmaq,1,"real")
!      print *, 'WRFCMAQ lon ',lon_wrfcmaq(:,:)
!      print *, 'WRFCMAQ lat ',lat_wrfcmaq(:,:)
!     
      xcmaq_sw=lon_wrfcmaq(1,1)
      if(xcmaq_sw.lt.0.) xcmaq_sw=xcmaq_sw+360.
      num_wrfcmaq=0
      do i=1,nx
         do j=1,ny
            lon_trac_fixed=lon(i,j)
            if(lon(i,j).le.0) lon_trac_fixed=lon(i,j)+360.
            call w3fb13(xi,xj,lat(i,j),lon_trac_fixed,lat_wrfcmaq(1,1), &
            xcmaq_sw,delx_cmaq,xcen_cmaq,pa_cmaq,pb_cmaq)
            i_min = nint(xi)
            j_min = nint(xj)
            if(i_min.lt.1 .or. i_min.gt.nx_wrfcmaq .or. &
            j_min.lt.1 .or. j_min.gt.ny_wrfcmaq) cycle
            num_wrfcmaq=num_wrfcmaq+1
            wrfcmaq_i(num_wrfcmaq)=i
            wrfcmaq_j(num_wrfcmaq)=j            
            wrfcmaq_ii(num_wrfcmaq)=i_min
            wrfcmaq_jj(num_wrfcmaq)=j_min            
         enddo
      enddo
      call put_NETCDF_fld_int(trim(wrfchem_file),"NUM_WRFCMAQ", &
      "WRFCMAQ mapping points count",num_wrfcmaq,1,1,1)
      wrfchem_file=trim(path_output)//"/"//trim(file_output)
      call put_NETCDF_fld_int(trim(wrfchem_file),"WRFCMAQ_I", &
      "mapping to traceri east-west traceri index",wrfcmaq_i,nx*ny,1,1)
      call put_NETCDF_fld_int(trim(wrfchem_file),"WRFCMAQ_J", &
      "mapping to traceri south-north traceri index",wrfcmaq_j,nx*ny,1,1)
      call put_NETCDF_fld_int(trim(wrfchem_file),"WRFCMAQ_II", &
      "mapping to traceri east-west wrfcmaq index", wrfcmaq_ii,nx*ny,1,1)
      call put_NETCDF_fld_int(trim(wrfchem_file),"WRFCMAQ_JJ", &
      "mapping to traceri south-north wrfcmaq index",wrfcmaq_jj,nx*ny,1,1)
!
! CAMCHEM
      allocate(lon_camchem(nx_camchem))
      allocate(lat_camchem(ny_camchem))
      allocate(camchem_ll_ii(nx,ny),camchem_ll_jj(nx,ny))
      allocate(camchem_lr_ii(nx,ny),camchem_lr_jj(nx,ny))
      allocate(camchem_ul_ii(nx,ny),camchem_ul_jj(nx,ny))
      allocate(camchem_ur_ii(nx,ny),camchem_ur_jj(nx,ny))
      call get_WRFCHEM_fld(trim(camchem_file),"lon",lon_camchem,nx_camchem,1,1,"double")
      call get_WRFCHEM_fld(trim(camchem_file),"lat",lat_camchem,ny_camchem,1,1,"double")
      do i=1,nx_camchem
         if(lon_camchem(i).gt.180.) lon_camchem(i)=lon_camchem(i)-360.
      enddo
      dx=lon_camchem(2)-lon_camchem(1)
      dy=lat_camchem(2)-lat_camchem(1)
      do i=1,nx
         do j=1,ny
            diff=lon(i,j)-lon_camchem(1)
            camchem_ll_ii(i,j)=int(diff/dx)+1
            camchem_ul_ii(i,j)=int(diff/dx)+1
            camchem_lr_ii(i,j)=int(diff/dx)+2
            camchem_ur_ii(i,j)=int(diff/dx)+2
            diff=lat(i,j)-lat_camchem(1)
            camchem_ll_jj(i,j)=int(diff/dy)+1
            camchem_lr_jj(i,j)=int(diff/dy)+1
            camchem_ul_jj(i,j)=int(diff/dy)+2
            camchem_ur_jj(i,j)=int(diff/dy)+2
         enddo
      enddo
      wrfchem_file=trim(path_output)//"/"//trim(file_output)
      call put_NETCDF_fld_int(trim(wrfchem_file),"CAMCHEM_LL_II","west-east lower left interpolation index", &
      camchem_ll_ii,nx,ny,1)
      call put_NETCDF_fld_int(trim(wrfchem_file),"CAMCHEM_LL_JJ","south-north lower left interpolation index", &
      camchem_ll_jj,nx,ny,1)
      call put_NETCDF_fld_int(trim(wrfchem_file),"CAMCHEM_LR_II","west-east lower right interpolation index", &
      camchem_lr_ii,nx,ny,1)
      call put_NETCDF_fld_int(trim(wrfchem_file),"CAMCHEM_LR_JJ","south-north lower right interpolation index", &
      camchem_lr_jj,nx,ny,1)
      call put_NETCDF_fld_int(trim(wrfchem_file),"CAMCHEM_UL_II","west-east lower left interpolation index", &
      camchem_ul_ii,nx,ny,1)
      call put_NETCDF_fld_int(trim(wrfchem_file),"CAMCHEM_UL_JJ","south-north lower left interpolation index", &
      camchem_ul_jj,nx,ny,1)
      call put_NETCDF_fld_int(trim(wrfchem_file),"CAMCHEM_UR_II","west-east lower right interpolation index", &
      camchem_ur_ii,nx,ny,1)
      call put_NETCDF_fld_int(trim(wrfchem_file),"CAMCHEM_UR_JJ","south-north lower right interpolation index", &
      camchem_ur_jj,nx,ny,1)
      deallocate(lon_camchem)
      deallocate(lat_camchem)
      deallocate(camchem_ll_ii,camchem_ll_jj)
      deallocate(camchem_lr_ii,camchem_lr_jj)
      deallocate(camchem_ul_ii,camchem_ul_jj)
      deallocate(camchem_ur_ii,camchem_ur_jj)
!
! WRFCMAQ
!      print *, 'APM: before WRFCMAQ lon and lat read '
      call get_WRFCHEM_fld(trim(wrfcmaq_gridcro2d),"LON",lon_wrfcmaq,nx_wrfcmaq,ny_wrfcmaq,1,"real")
      call get_WRFCHEM_fld(trim(wrfcmaq_gridcro2d),"LAT",lat_wrfcmaq,nx_wrfcmaq,ny_wrfcmaq,1,"real")
!
! Determine the WRFCMAQ CONUS indices
      num_wrfcmaq_conus=0
      allocate(wrfcmaq_conus_ii(nx*ny))
      allocate(wrfcmaq_conus_jj(nx*ny))
      do ipts=1,num_wrfcmaq
         i=wrfcmaq_i(ipts)
         j=wrfcmaq_j(ipts)
         ii=wrfcmaq_ii(ipts)
         jj=wrfcmaq_jj(ipts)
         if(lon_wrfcmaq(ii,jj).ge.lon_conus_west .and. lon_wrfcmaq(ii,jj).le.lon_conus_east .and. &
         lat_wrfcmaq(ii,jj).ge.lat_conus_south .and. lat_wrfcmaq(ii,jj).le.lat_conus_north) then
            num_wrfcmaq_conus=num_wrfcmaq_conus+1
            wrfcmaq_conus_ii(num_wrfcmaq_conus)=i
            wrfcmaq_conus_jj(num_wrfcmaq_conus)=j
         endif
      enddo
!
! Put WRFCMAQ data
      wrfchem_file=trim(path_output)//"/"//trim(file_output)
      call put_NETCDF_fld_int(trim(wrfchem_file),"NUM_WRFCMAQ_CONUS","conus points count", &
      num_wrfcmaq_conus,1,1,1)
      call put_NETCDF_fld_int(trim(wrfchem_file),"WRFCMAQ_CONUS_II","west-east index", &
      wrfcmaq_conus_ii,num_wrfcmaq_conus,1,1)
      call put_NETCDF_fld_int(trim(wrfchem_file),"WRFCMAQ_CONUS_JJ","south-north index", &
      wrfcmaq_conus_jj,num_wrfcmaq_conus,1,1)
      deallocate(wrfcmaq_conus_ii,wrfcmaq_conus_jj)
!
! Determine the urban, rural, and cities indices      
      allocate (cities(num_cities))
      allocate (lon1_cities(num_cities))
      allocate (lon2_cities(num_cities))
      allocate (lat1_cities(num_cities))
      allocate (lat2_cities(num_cities))
!      
      cities = (/'Boston','New York','Philadelphia','DC&Baltimore','Charlotte','Orlando','Miami', &
      'Pittsburgh','Atlanta','Detroit','Cincinnati','Nashville','Birmingham','Chicago', &
      'Indianapolis','St. Louis','Memphis','Minneapolis','Kansas City','Houston','Albuquerque','NFR', &
      'Dallas','Salt Lake City','Las Vegas','Phoenix','Seattle','San Francisco','Los Angeles'/)
!
      lon1_cities = (/-71.4, -74.6, -75.6, -77.6, -81.2, -81.9, -80.5, -80.4, -84.9, -84.0, &
      -84.8, -87.3, -87.3, -88.6, -86.6, -91.0, -90.6,  -94.0, -95.2, -96.0, -106.93, -105.4, &
      -97.9, -112.3, -115.5, -112.7, -123.0, -122.5, -118.5/)
!
      lon2_cities = (/-70.7, -73.8, -74.6, -76.2, -80.4, -80.9, -80.0, -79.3, -83.8, -82.7, &
      -84.1, -86.2, -86.2, -87.4, -85.7, -89.6,  -89.4, -92.5, -94.1, -94.8, -106.3, -103.8, &
      -96.2, -111.4, -114.8, -111.3, -121.6, -121.0, -117.0/)
!     
      lat1_cities = (/42.1, 40.4, 39.8, 38.5, 34.8, 28.1, 25.6, 40.0, 33.4, 42.0, 38.8, &
      35.8, 33.1, 41.4, 39.4, 38.2, 34.8, 44.5, 38.7, 29.2, 34.7, 39.5, 32.3, 40.0, 35.8, &
      32.7, 46.8, 37.3, 33.2/);
!
      lat2_cities = (/42.7, 41.1, 40.2, 39.6, 35.6, 29.1, 26.9, 40.9, 34.2, 42.9, 39.7, &
      36.5, 33.9, 42.5, 40.3, 39.1, 35.4, 45.6, 39.5, 30.8, 35.51, 40.9, 33.4, 41.5, 36.5, &
      34.2, 48.6, 39.0, 34.7/)
!
      wrfchem_file=trim(path_output)//"/"//trim(file_output)
!      call put_NETCDF_CHAR_fld(trim(wrfchem_file),"CITIES","urban stratifications", &
!      cities,num_cities,1,1)
      call put_NETCDF_fld_int(trim(wrfchem_file),"LON1_CITIES","urban boundaries", &
      lon1_cities,num_cities,1,1)
      call put_NETCDF_fld_int(trim(wrfchem_file),"LON2_CITIES","urban boundaries", &
      lon2_cities,num_cities,1,1)
      call put_NETCDF_fld_int(trim(wrfchem_file),"LAT1_CITIES","urban boundaries", &
      lat1_cities,num_cities,1,1)
      call put_NETCDF_fld_int(trim(wrfchem_file),"LAT2_CITIES","urban boundaries", &
      lat2_cities,num_cities,1,1)
!
! Set up WRFCHEM urban, rural, and cities indices
      allocate(wrfchem_urban_ii(num_cities,npts_urban))
      allocate(wrfchem_urban_jj(num_cities,npts_urban))
      allocate(wrfchem_urban_npts(num_cities))
      allocate(wrfchem_rural_ii(nx*ny))
      allocate(wrfchem_rural_jj(nx*ny))
      wrfchem_urban_ii(:,:)=0
      wrfchem_urban_jj(:,:)=0
      wrfchem_urban_npts(:)=0
      wrfchem_rural_ii(:)=0
      wrfchem_rural_jj(:)=0
      wrfchem_rural_npts=0
      do i=1,nx
         do j=1,ny
            urban_flg=0
            do icity=1,num_cities
!            
! Urban points
               if(lon(i,j).ge.lon_conus_west .and. lon(i,j).le.lon_conus_east .and. &
               lat(i,j).ge.lat_conus_south .and. lat(i,j).le.lat_conus_north .and. &
               lon(i,j).ge.lon1_cities(icity) .and. lon(i,j).le.lon2_cities(icity) .and. &
               lat(i,j).ge.lat1_cities(icity) .and. lat(i,j).le.lat2_cities(icity)) then
                  urban_flg=1
                  wrfchem_urban_npts(icity)=wrfchem_urban_npts(icity)+1
                  if(wrfchem_urban_npts(icity).gt.npts_urban) then
                     print *, 'APM: Increase wrfchem_urban NPTS'
                     stop
                  endif
                  wrfchem_urban_ii(icity,wrfchem_urban_npts(icity))=i
                  wrfchem_urban_jj(icity,wrfchem_urban_npts(icity))=j
                  exit
               endif
            enddo
!
! Rural points            
            if(urban_flg.eq.0 .and. &
            lon(i,j).ge.lon_conus_west .and. lon(i,j).le.lon_conus_east .and. &
            lat(i,j).ge.lat_conus_south .and. lat(i,j).le.lat_conus_north) then
               wrfchem_rural_npts=wrfchem_rural_npts+1
               wrfchem_rural_ii(wrfchem_rural_npts)=i
               wrfchem_rural_jj(wrfchem_rural_npts)=j
            endif
         enddo
      enddo
!      print *, 'CONUS ',num_wrfchem_conus
!      print *, 'URBAN ',sum(wrfchem_urban_npts(1:num_cities))
!      print *, 'RURAL ',wrfchem_rural_npts
!
      wrfchem_file=trim(path_output)//"/"//trim(file_output)
      call put_NETCDF_fld_int(trim(wrfchem_file),"NUM_TRACER_I_URBAN","number of points per city", &
      wrfchem_urban_npts,num_cities,1,1)
      call put_NETCDF_fld_int(trim(wrfchem_file),"TRACER_I_URBAN_II","west-east index", &
      wrfchem_urban_ii,num_cities,npts_urban,1)
      call put_NETCDF_fld_int(trim(wrfchem_file),"TRACER_I_URBAN_JJ","south-north index", &
      wrfchem_urban_jj,num_cities,npts_urban,1)
      call put_NETCDF_fld_int(trim(wrfchem_file),"NUM_TRACER_I_RURAL","number of rural points", &
      wrfchem_rural_npts,1,1,1)
      call put_NETCDF_fld_int(trim(wrfchem_file),"TRACER_I_RURAL_II","west-east index", &
      wrfchem_rural_ii,npts_rural,1,1)
      call put_NETCDF_fld_int(trim(wrfchem_file),"TRACER_I_RURAL_JJ","south-north index", &
      wrfchem_rural_jj,npts_rural,1,1)
      deallocate(wrfchem_urban_npts)
      deallocate(wrfchem_urban_ii,wrfchem_urban_jj)
      deallocate(wrfchem_rural_ii,wrfchem_rural_jj)
!
! Set up WRFCMAQ urban, rural, and cities indices
      allocate(wrfcmaq_urban_ii(num_cities,npts_urban))
      allocate(wrfcmaq_urban_jj(num_cities,npts_urban))
      allocate(wrfcmaq_urban_npts(num_cities))
      allocate(wrfcmaq_rural_ii(nx*ny))
      allocate(wrfcmaq_rural_jj(nx*ny))
      wrfcmaq_urban_ii(:,:)=0
      wrfcmaq_urban_jj(:,:)=0
      wrfcmaq_urban_npts(:)=0
      wrfcmaq_rural_ii(:)=0
      wrfcmaq_rural_jj(:)=0
      wrfcmaq_rural_npts=0
      do ipts=1,num_wrfcmaq
         i=wrfcmaq_i(ipts)
         j=wrfcmaq_j(ipts)
         ii=wrfcmaq_ii(ipts)
         jj=wrfcmaq_jj(ipts)
         urban_flg=0
         do icity=1,num_cities
!            
! Urban points
            if(lon_wrfcmaq(ii,jj).ge.lon_conus_west .and. lon_wrfcmaq(ii,jj).le.lon_conus_east .and. &
            lat_wrfcmaq(ii,jj).ge.lat_conus_south .and. lat_wrfcmaq(ii,jj).le.lat_conus_north .and. &
            lon_wrfcmaq(ii,jj).ge.lon1_cities(icity) .and. lon_wrfcmaq(ii,jj).le.lon2_cities(icity) .and. &
            lat_wrfcmaq(ii,jj).ge.lat1_cities(icity) .and. lat_wrfcmaq(ii,jj).le.lat2_cities(icity)) then
               urban_flg=1
               wrfcmaq_urban_npts(icity)=wrfcmaq_urban_npts(icity)+1
               if(wrfcmaq_urban_npts(icity).gt.npts_urban) then
                  print *, 'APM: Increase wrfcmaq_urban NPTS'
                  stop
               endif
               wrfcmaq_urban_ii(icity,wrfcmaq_urban_npts(icity))=i
               wrfcmaq_urban_jj(icity,wrfcmaq_urban_npts(icity))=j
               exit
            endif
         enddo
!
! Rural points            
         if(urban_flg.eq.0 .and. &
         lon_wrfcmaq(ii,jj).ge.lon_conus_west .and. lon_wrfcmaq(ii,jj).le.lon_conus_east .and. &
         lat_wrfcmaq(ii,jj).ge.lat_conus_south .and. lat_wrfcmaq(ii,jj).le.lat_conus_north) then
            wrfcmaq_rural_npts=wrfcmaq_rural_npts+1
            wrfcmaq_rural_ii(wrfcmaq_rural_npts)=i
            wrfcmaq_rural_jj(wrfcmaq_rural_npts)=j
         endif
      enddo
      wrfcmaq_file=trim(path_output)//"/"//trim(file_output)
      call put_NETCDF_fld_int(trim(wrfcmaq_file),"NUM_WRFCMAQ_URBAN","number of points per city", &
      wrfcmaq_urban_npts,num_cities,1,1)
      call put_NETCDF_fld_int(trim(wrfcmaq_file),"WRFCMAQ_URBAN_II","west-east index", &
      wrfcmaq_urban_ii,num_cities,npts_urban,1)
      call put_NETCDF_fld_int(trim(wrfcmaq_file),"WRFCMAQ_URBAN_JJ","south-north index", &
      wrfcmaq_urban_jj,num_cities,npts_urban,1)
      call put_NETCDF_fld_int(trim(wrfchem_file),"NUM_WRFCMAQ_RURAL","number of rural points", &
      wrfcmaq_rural_npts,1,1,1)
      call put_NETCDF_fld_int(trim(wrfchem_file),"WRFCMAQ_RURAL_II","west-east index", &
      wrfcmaq_rural_ii,npts_rural,1,1)
      call put_NETCDF_fld_int(trim(wrfchem_file),"WRFCMAQ_RURAL_JJ","south-north index", &
      wrfcmaq_rural_jj,npts_rural,1,1)
      deallocate(wrfcmaq_urban_npts)
      deallocate(wrfcmaq_urban_ii,wrfcmaq_urban_jj)
      deallocate(wrfcmaq_rural_ii,wrfcmaq_rural_jj)

      deallocate(lon)
      deallocate(lat)
      wrfchem_file=trim(path_output)//"/"//trim(file_output)
      print *, 'APM: Close file ',trim(wrfchem_file)

      stop
      
!
! The rest of this script is legacy code
! The functionality has moved to generate_statistics.f90   
!
! Met fields      
      do ifld=1,num_met_flds
! T
         if(trim(met_flds(ifld)).eq."T") then
            print *, '   APM: Before process T'
            allocate(t_fld(nx,ny,nz,num_mems))
            allocate(p_fld(nx,ny,nz,num_mems))
            allocate(p_base(nx,ny,nz,num_mems))
            do imem=1,num_mems
               if(imem.ge.0.and.imem.lt.10) write(cmem,"('/run_e00',i1)"),imem
               if(imem.ge.10.and.imem.lt.100) write(cmem,"('/run_e0',i2)"),imem
               if(imem.ge.100.and.imem.lt.1000) write(cmem,"('/run_e',i3)"),imem
               wrfchem_file=trim(path_input)//trim(cmem)//"/"//trim(wrfout_input)
               call get_WRFCHEM_fld(trim(wrfchem_file),"T00",t_base,1,1,1)
               call get_WRFCHEM_fld(trim(wrfchem_file),"P",p_fld(1,1,1,imem),nx,ny,nz)
               call get_WRFCHEM_fld(trim(wrfchem_file),"PB",p_base(1,1,1,imem),nx,ny,nz)
               do i=1,nx
                  do j=1,ny
                     do k=1,nz
                        t_fld(i,j,k,imem)=((t_fld(i,j,k,imem)+t_base))* &
                        ((p_fld(i,j,k,imem)+p_base(i,j,k,imem))/100000.)**kappa
                        p_fld(i,j,k,imem)=p_fld(i,j,k,imem)+p_base(i,j,k,imem)
                     enddo
                  enddo
               enddo
            enddo
            deallocate(p_base)
            allocate(p_ens_mn(nx,ny,nz))
            allocate(p_ens_sd(nx,ny,nz))
            allocate(t_ens_mn(nx,ny,nz))
            allocate(t_ens_sd(nx,ny,nz))
! Ensemle stats T
            call ens_stats(t_fld,t_ens_mn,t_ens_sd,nx,ny,nz,num_mems)
            deallocate(t_fld)
            allocate(t_conus_mn(nz),t_conus_sd(nz))
            allocate(t_urban_mn(nz),t_urban_sd(nz))
            allocate(t_rural_mn(nz),t_rural_sd(nz))
            allocate(t_cities_mn(num_cities,nz),t_cities_sd(num_cities,nz))
            print *, 'Before call to spatial_stats '
            urban_flg=0
! Spatial stats T
            call spatial_stats(urban_flg,t_conus_mn,t_conus_sd,t_urban_mn,t_urban_sd,t_rural_mn, &
            t_rural_sd,t_cities_mn,t_cities_sd,t_ens_mn,t_ens_sd,lon,lat,nx,ny,nz,num_cities)
! Ensemble stats P
            call ens_stats(p_fld,p_ens_mn,p_ens_sd,nx,ny,nz,num_mems)            
            deallocate(p_fld)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"P_MN","hPa",p_ens_mn,nx,ny,nz)
            call put_NETCDF_fld(trim(wrfchem_file),"P_SD","hPa",p_ens_sd,nx,ny,nz)
            call put_NETCDF_fld(trim(wrfchem_file),"T_MN","K",t_ens_mn,nx,ny,nz)
            call put_NETCDF_fld(trim(wrfchem_file),"T_SD","K",t_ens_sd,nx,ny,nz)
            deallocate(p_ens_mn)
            deallocate(p_ens_sd)
            deallocate(t_ens_mn)
            deallocate(t_ens_sd)
            deallocate(t_conus_mn,t_conus_sd)
            deallocate(t_urban_mn,t_urban_sd)
            deallocate(t_rural_mn,t_rural_sd)
            deallocate(t_cities_mn,t_cities_sd)
!
! Comparative reanalyses
! TCR2
!            tcr2_file=trim(tcr2_met_pre)//"t"//trim(tcr2_met_suf)
!            call get_TCR2_fld(trim(tcr2_file),"var",t_tcr2_raw,nx_tcr2,ny_tcr2,nz_tcr2_nt_tcr2)
!            call TCR2_interpolate(t_tcr2,t_tcr2_raw,nx,ny,nx_tcr2,ny_tcr2,tcr2_ll_ii,tcr2_lr_ii, &
!            tcr2_ul_ii,tcr2_ur_ii,tcr2_ll_jj,tcr2_lr_jj,tcr2_ul_jj,tcr2_ur_jj),tcr2_dwn_kk, &
!            tcr2_up_kk)
            print *, '   APM: After process T'            
! U
         elseif(trim(met_flds(ifld)).eq."U") then
            print *, '   APM: Before process U'
            allocate(stag_fld(nx+1,ny,nz))
            allocate(u_fld(nx,ny,nz,num_mems))
            do imem=1,num_mems
               if(imem.ge.0.and.imem.lt.10) write(cmem,"('/run_e00',i1)"),imem
               if(imem.ge.10.and.imem.lt.100) write(cmem,"('/run_e0',i2)"),imem
               if(imem.ge.100.and.imem.lt.1000) write(cmem,"('/run_e',i3)"),imem
               wrfchem_file=trim(path_input)//trim(cmem)//"/"//trim(wrfout_input)
               call get_WRFCHEM_fld(trim(wrfchem_file),"U",stag_fld(1,1,1),nx+1,ny,nz)
               do i=1,nx
                  do j=1,ny
                     do k=1,nz
                        u_fld(i,j,k,imem)=(stag_fld(i,j,k)+stag_fld(i+1,j,k))/2. 
                     enddo
                  enddo
               enddo
            enddo
            deallocate(stag_fld)
            allocate(u_ens_mn(nx,ny,nz))
            allocate(u_ens_sd(nx,ny,nz))
! Ensemble stats U
            call ens_stats(u_fld,u_ens_mn,u_ens_sd,nx,ny,nz,num_mems)
            deallocate(u_fld)
            allocate(u_conus_mn(nz),u_conus_sd(nz))
            allocate(u_urban_mn(nz),u_urban_sd(nz))
            allocate(u_rural_mn(nz),u_rural_sd(nz))
            allocate(u_cities_mn(num_cities,nz),u_cities_sd(num_cities,nz))
! Spatial stats U
            urban_flg=0
            call spatial_stats(urban_flg,u_conus_mn,u_conus_sd,u_urban_mn,u_urban_sd,u_rural_mn, &
            u_rural_sd,u_cities_mn,u_cities_sd,u_ens_mn,u_ens_sd,lon,lat,nx,ny,nz,num_cities)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"U_MN","m/s",u_ens_mn,nx,ny,nz)
            call put_NETCDF_fld(trim(wrfchem_file),"U_SD","m/s",u_ens_sd,nx,ny,nz)
            deallocate(u_ens_mn)
            deallocate(u_ens_sd)
            deallocate(u_conus_mn,u_conus_sd)
            deallocate(u_urban_mn,u_urban_sd)
            deallocate(u_rural_mn,u_rural_sd)
            deallocate(u_cities_mn,u_cities_sd)
            print *, '   APM: After process U'
! V
         elseif(trim(met_flds(ifld)).eq."V") then
            print *, '   APM: Before process V'
            allocate(stag_fld(nx,ny+1,nz))
            allocate(v_fld(nx,ny,nz,num_mems))
            do imem=1,num_mems
               if(imem.ge.0.and.imem.lt.10) write(cmem,"('/run_e00',i1)"),imem
               if(imem.ge.10.and.imem.lt.100) write(cmem,"('/run_e0',i2)"),imem
               if(imem.ge.100.and.imem.lt.1000) write(cmem,"('/run_e',i3)"),imem
               wrfchem_file=trim(path_input)//trim(cmem)//"/"//trim(wrfout_input)
               call get_WRFCHEM_fld(trim(wrfchem_file),"V",stag_fld(1,1,1),nx,ny+1,nz)
               do i=1,nx
                  do j=1,ny
                     do k=1,nz
                        v_fld(i,j,k,imem)=(stag_fld(i,j,k)+stag_fld(i,j+1,k))/2. 
                     enddo
                  enddo
               enddo
            enddo
            deallocate(stag_fld)
            allocate(v_ens_mn(nx,ny,nz))
            allocate(v_ens_sd(nx,ny,nz))
! Ensemble stats V
            call ens_stats(v_fld,v_ens_mn,v_ens_sd,nx,ny,nz,num_mems)
            deallocate(v_fld)
            allocate(v_conus_mn(nz),v_conus_sd(nz))
            allocate(v_urban_mn(nz),v_urban_sd(nz))
            allocate(v_rural_mn(nz),v_rural_sd(nz))
            allocate(v_cities_mn(num_cities,nz),v_cities_sd(num_cities,nz))
! Spatial stats U
            urban_flg=0
            call spatial_stats(urban_flg,v_conus_mn,v_conus_sd,v_urban_mn,v_urban_sd,v_rural_mn, &
            v_rural_sd,v_cities_mn,v_cities_sd,v_ens_mn,v_ens_sd,lon,lat,nx,ny,nz,num_cities)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"V_MN","m/s",v_ens_mn,nx,ny,nz)
            call put_NETCDF_fld(trim(wrfchem_file),"V_SD","m/s",v_ens_sd,nx,ny,nz)
            deallocate(v_ens_mn)
            deallocate(v_ens_sd)
            deallocate(v_conus_mn,v_conus_sd)
            deallocate(v_urban_mn,v_urban_sd)
            deallocate(v_rural_mn,v_rural_sd)
            deallocate(v_cities_mn,v_cities_sd)
            print *, '   APM: After process V'
! Q
         elseif(trim(met_flds(ifld)).eq."Q") then
            print *, '   APM: Before process Q'
            allocate(q_fld(nx,ny,nz,num_mems))
            do imem=1,num_mems
               if(imem.ge.0.and.imem.lt.10) write(cmem,"('/run_e00',i1)"),imem
               if(imem.ge.10.and.imem.lt.100) write(cmem,"('/run_e0',i2)"),imem
               if(imem.ge.100.and.imem.lt.1000) write(cmem,"('/run_e',i3)"),imem
               wrfchem_file=trim(path_input)//trim(cmem)//"/"//trim(wrfout_input)
               call get_WRFCHEM_fld(trim(wrfchem_file),"QVAPOR",q_fld(1,1,1,imem),nx,ny,nz)
            enddo
            allocate(q_ens_mn(nx,ny,nz))
            allocate(q_ens_sd(nx,ny,nz))
! Ensemble stats Q
            call ens_stats(q_fld,q_ens_mn,q_ens_sd,nx,ny,nz,num_mems)
            deallocate(q_fld)
            allocate(q_conus_mn(nz),q_conus_sd(nz))
            allocate(q_urban_mn(nz),q_urban_sd(nz))
            allocate(q_rural_mn(nz),q_rural_sd(nz))
            allocate(q_cities_mn(num_cities,nz),q_cities_sd(num_cities,nz))
! Spatial stats Q
            urban_flg=0
            call spatial_stats(urban_flg,q_conus_mn,q_conus_sd,q_urban_mn,q_urban_sd,q_rural_mn, &
            q_rural_sd,q_cities_mn,q_cities_sd,q_ens_mn,q_ens_sd,lon,lat,nx,ny,nz,num_cities)       
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"Q_MN","mixing_ratio",q_ens_mn,nx,ny,nz)
            call put_NETCDF_fld(trim(wrfchem_file),"Q_SD","mixing_ratio",q_ens_sd,nx,ny,nz)
            deallocate(q_ens_mn)
            deallocate(q_ens_sd)
            deallocate(q_conus_mn,q_conus_sd)
            deallocate(q_urban_mn,q_urban_sd)
            deallocate(q_rural_mn,q_rural_sd)
            deallocate(q_cities_mn,q_cities_sd)
            print *, '   APM: After process Q'
         endif
      enddo
!
! Chem fields      
      do ifld=1,num_chem_flds
! CO
         if(trim(chem_flds(ifld)).eq."co") then
            print *, '   APM: Before process CO'
            allocate(co_fld(nx,ny,nz,num_mems))
            do imem=1,num_mems
               if(imem.ge.0.and.imem.lt.10) write(cmem,"('/run_e00',i1)"),imem
               if(imem.ge.10.and.imem.lt.100) write(cmem,"('/run_e0',i2)"),imem
               if(imem.ge.100.and.imem.lt.1000) write(cmem,"('/run_e',i3)"),imem
               wrfchem_file=trim(path_input)//trim(cmem)//"/"//trim(wrfout_input)
               call get_WRFCHEM_fld(trim(wrfchem_file),"co",co_fld(1,1,1,imem),nx,ny,nz)
            enddo
            allocate(co_ens_mn(nx,ny,nz))
            allocate(co_ens_sd(nx,ny,nz))
! Ensemble stats O3
            call ens_stats(co_fld,co_ens_mn,co_ens_sd,nx,ny,nz,num_mems)
            deallocate(co_fld)
! Spatial stats O3
            urban_flg=0
            call spatial_stats(urban_flg,co_conus_mn,co_conus_sd,co_urban_mn,co_urban_sd,co_rural_mn, &
            co_rural_sd,co_cities_mn,co_cities_sd,co_ens_mn,co_ens_sd,lon,lat,nx,ny,nz,num_cities)       
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"CO_MN","mixing ratio (ppm)",co_ens_mn,nx,ny,nz)
            call put_NETCDF_fld(trim(wrfchem_file),"CO_SD","mixing ratio (ppm)",co_ens_sd,nx,ny,nz)
            deallocate(co_ens_mn)
            deallocate(co_ens_sd)
            print *, '   APM: After process CO'
! O3
         elseif(trim(chem_flds(ifld)).eq."o3") then
            print *, '   APM: Before process O3'
            allocate(o3_fld(nx,ny,nz,num_mems))
            do imem=1,num_mems
               if(imem.ge.0.and.imem.lt.10) write(cmem,"('/run_e00',i1)"),imem
               if(imem.ge.10.and.imem.lt.100) write(cmem,"('/run_e0',i2)"),imem
               if(imem.ge.100.and.imem.lt.1000) write(cmem,"('/run_e',i3)"),imem
               wrfchem_file=trim(path_input)//trim(cmem)//"/"//trim(wrfout_input)
               call get_WRFCHEM_fld(trim(wrfchem_file),"o3",o3_fld(1,1,1,imem),nx,ny,nz)
            enddo
            allocate(o3_ens_mn(nx,ny,nz))
            allocate(o3_ens_sd(nx,ny,nz))
! Ensemble stats O3
            call ens_stats(o3_fld,o3_ens_mn,o3_ens_sd,nx,ny,nz,num_mems)
            deallocate(o3_fld)
! Spatial stats O3
            urban_flg=0
            call spatial_stats(urban_flg,o3_conus_mn,o3_conus_sd,o3_urban_mn,o3_urban_sd,o3_rural_mn, &
            o3_rural_sd,o3_cities_mn,o3_cities_sd,o3_ens_mn,o3_ens_sd,lon,lat,nx,ny,nz,num_cities)       
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"O3_MN","mixing ratio (ppm)",o3_ens_mn,nx,ny,nz)
            call put_NETCDF_fld(trim(wrfchem_file),"O3_SD","mixing_ratio (ppm)",o3_ens_sd,nx,ny,nz)
            deallocate(o3_ens_mn)
            deallocate(o3_ens_sd)
            print *, '   APM: After process O3'
! NO2
         elseif(trim(chem_flds(ifld)).eq."no2") then
            print *, '   APM: Before process NO2'
            allocate(no2_fld(nx,ny,nz,num_mems))
            do imem=1,num_mems
               if(imem.ge.0.and.imem.lt.10) write(cmem,"('/run_e00',i1)"),imem
               if(imem.ge.10.and.imem.lt.100) write(cmem,"('/run_e0',i2)"),imem
               if(imem.ge.100.and.imem.lt.1000) write(cmem,"('/run_e',i3)"),imem
               wrfchem_file=trim(path_input)//trim(cmem)//"/"//trim(wrfout_input)
               call get_WRFCHEM_fld(trim(wrfchem_file),"no2",no2_fld(1,1,1,imem),nx,ny,nz)
            enddo
            allocate(no2_ens_mn(nx,ny,nz))
            allocate(no2_ens_sd(nx,ny,nz))
! Ensemble stats NO2
            call ens_stats(no2_fld,no2_ens_mn,no2_ens_sd,nx,ny,nz,num_mems)
            deallocate(no2_fld)
! Spatial stats NO2
            urban_flg=0
            call spatial_stats(urban_flg,no2_conus_mn,no2_conus_sd,no2_urban_mn,no2_urban_sd,no2_rural_mn, &
            no2_rural_sd,no2_cities_mn,no2_cities_sd,no2_ens_mn,no2_ens_sd,lon,lat,nx,ny,nz,num_cities)       
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"NO2_MN","mixing ratio (ppm)",no2_ens_mn,nx,ny,nz)
            call put_NETCDF_fld(trim(wrfchem_file),"NO2_SD","mixing_ratio (ppm)",no2_ens_sd,nx,ny,nz)
            deallocate(no2_ens_mn)
            deallocate(no2_ens_sd)
            print *, '   APM: After process NO2'
! SO2
         elseif(trim(chem_flds(ifld)).eq."so2") then
            print *, '   APM: Before process SO2'
            allocate(so2_fld(nx,ny,nz,num_mems))
            do imem=1,num_mems
               if(imem.ge.0.and.imem.lt.10) write(cmem,"('/run_e00',i1)"),imem
               if(imem.ge.10.and.imem.lt.100) write(cmem,"('/run_e0',i2)"),imem
               if(imem.ge.100.and.imem.lt.1000) write(cmem,"('/run_e',i3)"),imem
               wrfchem_file=trim(path_input)//trim(cmem)//"/"//trim(wrfout_input)
               call get_WRFCHEM_fld(trim(wrfchem_file),"so2",so2_fld(1,1,1,imem),nx,ny,nz)
            enddo
            allocate(so2_ens_mn(nx,ny,nz))
            allocate(so2_ens_sd(nx,ny,nz))
! Ensemble stats SO2
            call ens_stats(so2_fld,so2_ens_mn,so2_ens_sd,nx,ny,nz,num_mems)
            deallocate(so2_fld)
! Spatial stats SO2
            urban_flg=0
            call spatial_stats(urban_flg,so2_conus_mn,so2_conus_sd,so2_urban_mn,so2_urban_sd,so2_rural_mn, &
            so2_rural_sd,so2_cities_mn,so2_cities_sd,so2_ens_mn,so2_ens_sd,lon,lat,nx,ny,nz,num_cities)       
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"SO2_MN","mixing ratio (ppm)",so2_ens_mn,nx,ny,nz)
            call put_NETCDF_fld(trim(wrfchem_file),"SO2_SD","mixing_ratio (ppm)",so2_ens_sd,nx,ny,nz)
            deallocate(so2_ens_mn)
            deallocate(so2_ens_sd)
            print *, '   APM: After process SO2'
         endif
      enddo
!
! Chemi Emis fields      
      do ifld=1,num_chemi_flds
! E_CO
         if(trim(chemi_flds(ifld)).eq."E_CO") then
            print *, '   APM: Before process E_CO'
            allocate(e_co_fld(nx,ny,nz_chemi,num_mems))
            do imem=1,num_mems
               if(imem.ge.0.and.imem.lt.10) write(cmem,"('/run_e00',i1)"),imem
               if(imem.ge.10.and.imem.lt.100) write(cmem,"('/run_e0',i2)"),imem
               if(imem.ge.100.and.imem.lt.1000) write(cmem,"('/run_e',i3)"),imem
               wrfchem_file=trim(path_input)//trim(cmem)//"/"//trim(wrfchemi_input)
               call get_WRFCHEM_fld(trim(wrfchem_file),"E_CO",e_co_fld(1,1,1,imem),nx,ny,nz_chemi)
            enddo
! Ensemble stats E_CO
            allocate(e_co_ens_mn(nx,ny,nz_chemi))
            allocate(e_co_ens_sd(nx,ny,nz_chemi))
            call ens_stats(e_co_fld,e_co_ens_mn,e_co_ens_sd,nx,ny,nz_chemi,num_mems)
            deallocate(e_co_fld)
! Spatial stats E_CO
            urban_flg=0
            call spatial_stats(urban_flg,e_co_conus_mn,e_co_conus_sd,e_co_urban_mn,e_co_urban_sd,e_co_rural_mn, &
            e_co_rural_sd,e_co_cities_mn,e_co_cities_sd,e_co_ens_mn,e_co_ens_sd,lon,lat,nx,ny,nz,num_cities)       
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"E_CO_MN","flux (mol km-2 hr-1)",e_co_ens_mn,nx,ny,nz_chemi)
            call put_NETCDF_fld(trim(wrfchem_file),"E_CO_SD","flux (mol klm-2 hr-1)",e_co_ens_sd,nx,ny,nz_chemi)
            deallocate(e_co_ens_mn)
            deallocate(e_co_ens_sd)
            print *, '   APM: After process E_CO'
! E_NO2
         elseif(trim(chemi_flds(ifld)).eq."E_NO2") then
            print *, '   APM: Before process E_NO2'
            allocate(e_no2_fld(nx,ny,nz_chemi,num_mems))
            do imem=1,num_mems
               if(imem.ge.0.and.imem.lt.10) write(cmem,"('/run_e00',i1)"),imem
               if(imem.ge.10.and.imem.lt.100) write(cmem,"('/run_e0',i2)"),imem
               if(imem.ge.100.and.imem.lt.1000) write(cmem,"('/run_e',i3)"),imem
               wrfchem_file=trim(path_input)//trim(cmem)//"/"//trim(wrfchemi_input)
               call get_WRFCHEM_fld(trim(wrfchem_file),"E_NO2",e_no2_fld(1,1,1,imem),nx,ny,nz_chemi)
            enddo
            allocate(e_no2_ens_mn(nx,ny,nz_chemi))
            allocate(e_no2_ens_sd(nx,ny,nz_chemi))
! Spatial stats E_NO2
            call ens_stats(e_no2_fld,e_no2_ens_mn,e_no2_ens_sd,nx,ny,nz_chemi,num_mems)
            deallocate(e_no2_fld)
! Spatial stats E_NO2
            urban_flg=0
            call spatial_stats(urban_flg,e_no2_conus_mn,e_no2_conus_sd,e_no2_urban_mn,e_no2_urban_sd,e_no2_rural_mn, &
            e_no2_rural_sd,e_no2_cities_mn,e_no2_cities_sd,e_no2_ens_mn,e_no2_ens_sd,lon,lat,nx,ny,nz,num_cities)       
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"E_NO2_MN","flux (mol km-2 hr-1)",e_no2_ens_mn,nx,ny,nz_chemi)
            call put_NETCDF_fld(trim(wrfchem_file),"E_NO2_SD","flux (mol km-2 hr-1)",e_no2_ens_sd,nx,ny,nz_chemi)
            deallocate(e_no2_ens_mn)
            deallocate(e_no2_ens_sd)
            print *, '   APM: After process E_NO2'
! E_SO2
         elseif(trim(chemi_flds(ifld)).eq."E_SO2") then
            print *, '   APM: Before process E_SO2'
            allocate(e_so2_fld(nx,ny,nz_chemi,num_mems))
            do imem=1,num_mems
               if(imem.ge.0.and.imem.lt.10) write(cmem,"('/run_e00',i1)"),imem
               if(imem.ge.10.and.imem.lt.100) write(cmem,"('/run_e0',i2)"),imem
               if(imem.ge.100.and.imem.lt.1000) write(cmem,"('/run_e',i3)"),imem
               wrfchem_file=trim(path_input)//trim(cmem)//"/"//trim(wrfchemi_input)
               call get_WRFCHEM_fld(trim(wrfchem_file),"E_SO2",e_so2_fld(1,1,1,imem),nx,ny,nz_chemi)
            enddo
            allocate(e_so2_ens_mn(nx,ny,nz_chemi))
            allocate(e_so2_ens_sd(nx,ny,nz_chemi))
! Spatial stats E_SO2
            call ens_stats(e_so2_fld,e_so2_ens_mn,e_so2_ens_sd,nx,ny,nz_chemi,num_mems)
            deallocate(e_so2_fld)
! Spatial stats E_SO2
            urban_flg=0
            call spatial_stats(urban_flg,e_so2_conus_mn,e_so2_conus_sd,e_so2_urban_mn,e_so2_urban_sd,e_so2_rural_mn, &
            e_so2_rural_sd,e_so2_cities_mn,e_so2_cities_sd,e_so2_ens_mn,e_so2_ens_sd,lon,lat,nx,ny,nz,num_cities)       
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"E_SO2_MN","flux (mol km-2 hr-1)",e_so2_ens_mn,nx,ny,nz_chemi)
            call put_NETCDF_fld(trim(wrfchem_file),"E_SO2_SD","flux (mol km-2 hr-1)",e_so2_ens_sd,nx,ny,nz_chemi)
            deallocate(e_so2_ens_mn)
            deallocate(e_so2_ens_sd)
            print *, '   APM: After process E_SO2'
         endif
      enddo
!
! Firechemi Emis fields      
      do ifld=1,num_fire_flds
! EBU_CO
         if(trim(firechemi_flds(ifld)).eq."EBU_CO") then
            print *, '   APM: Before process EBU_CO'
            allocate(ebu_co_fld(nx,ny,nz_fire,num_mems))
            do imem=1,num_mems
               if(imem.ge.0.and.imem.lt.10) write(cmem,"('/run_e00',i1)"),imem
               if(imem.ge.10.and.imem.lt.100) write(cmem,"('/run_e0',i2)"),imem
               if(imem.ge.100.and.imem.lt.1000) write(cmem,"('/run_e',i3)"),imem
               wrfchem_file=trim(path_input)//trim(cmem)//"/"//trim(wrffirechemi_input)
               call get_WRFCHEM_fld(trim(wrfchem_file),"EBU_CO",ebu_co_fld(1,1,1,imem),nx,ny,nz_fire)
            enddo
            allocate(ebu_co_ens_mn(nx,ny,nz_fire))
            allocate(ebu_co_ens_sd(nx,ny,nz_fire))
! Ensemble stats EBU_CO
            call ens_stats(ebu_co_fld,ebu_co_ens_mn,ebu_co_ens_sd,nx,ny,nz_fire,num_mems)
            deallocate(ebu_co_fld)
! Spatial stats EBU_CO
            urban_flg=0
            call spatial_stats(urban_flg,ebu_co_conus_mn,ebu_co_conus_sd,ebu_co_urban_mn,ebu_co_urban_sd,ebu_co_rural_mn, &
            ebu_co_rural_sd,ebu_co_cities_mn,ebu_co_cities_sd,ebu_co_ens_mn,ebu_co_ens_sd,lon,lat,nx,ny,nz,num_cities)       
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"EBU_CO_MN","flux (mol km-2 hr-1)",ebu_co_ens_mn,nx,ny,nz_fire)
            call put_NETCDF_fld(trim(wrfchem_file),"EBU_CO_SD","flux (mol km-2 hr-1)",ebu_co_ens_sd,nx,ny,nz_fire)
            deallocate(ebu_co_ens_mn)
            deallocate(ebu_co_ens_sd)
            print *, '   APM: After process EBU_CO'
! EBU_NO2
         elseif(trim(firechemi_flds(ifld)).eq."EBU_NO2") then
            print *, '   APM: Before process E_NO2'
            allocate(ebu_no2_fld(nx,ny,nz_fire,num_mems))
            do imem=1,num_mems
               if(imem.ge.0.and.imem.lt.10) write(cmem,"('/run_e00',i1)"),imem
               if(imem.ge.10.and.imem.lt.100) write(cmem,"('/run_e0',i2)"),imem
               if(imem.ge.100.and.imem.lt.1000) write(cmem,"('/run_e',i3)"),imem
               wrfchem_file=trim(path_input)//trim(cmem)//"/"//trim(wrffirechemi_input)
               call get_WRFCHEM_fld(trim(wrfchem_file),"EBU_NO2",ebu_no2_fld(1,1,1,imem),nx,ny,nz_fire)
            enddo
            allocate(ebu_no2_ens_mn(nx,ny,nz_fire))
            allocate(ebu_no2_ens_sd(nx,ny,nz_fire))
! Ensemble stats EBU_NO2
            call ens_stats(ebu_no2_fld,ebu_no2_ens_mn,ebu_no2_ens_sd,nx,ny,nz_fire,num_mems)
            deallocate(ebu_no2_fld)
! Spatial stats EBU_NO2
            urban_flg=0
            call spatial_stats(urban_flg,ebu_no2_conus_mn,ebu_no2_conus_sd,ebu_no2_urban_mn,ebu_no2_urban_sd,ebu_no2_rural_mn, &
            ebu_no2_rural_sd,ebu_no2_cities_mn,ebu_no2_cities_sd,ebu_no2_ens_mn,ebu_no2_ens_sd,lon,lat,nx,ny,nz,num_cities)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"EBU_NO2_MN","flux (mol km-2 hr-1)",ebu_no2_ens_mn,nx,ny,nz_fire)
            call put_NETCDF_fld(trim(wrfchem_file),"EBU_NO2_SD","flux (mol km-2 hr-1)",ebu_no2_ens_sd,nx,ny,nz_fire)
            deallocate(ebu_no2_ens_mn)
            deallocate(ebu_no2_ens_sd)
            print *, '   APM: After process EBU_NO2'
! EBU_SO2
         elseif(trim(firechemi_flds(ifld)).eq."EBU_SO2") then
            print *, '   APM: Before process EBU_SO2'
            allocate(ebu_so2_fld(nx,ny,nz_fire,num_mems))
            do imem=1,num_mems
               if(imem.ge.0.and.imem.lt.10) write(cmem,"('/run_e00',i1)"),imem
               if(imem.ge.10.and.imem.lt.100) write(cmem,"('/run_e0',i2)"),imem
               if(imem.ge.100.and.imem.lt.1000) write(cmem,"('/run_e',i3)"),imem
               wrfchem_file=trim(path_input)//trim(cmem)//"/"//trim(wrffirechemi_input)
               call get_WRFCHEM_fld(trim(wrfchem_file),"EBU_SO2",ebu_so2_fld(1,1,1,imem),nx,ny,nz_fire)
            enddo
            allocate(ebu_so2_ens_mn(nx,ny,nz_fire))
            allocate(ebu_so2_ens_sd(nx,ny,nz_fire))
! Ensemble stats EBU_SO2
            call ens_stats(ebu_so2_fld,ebu_so2_ens_mn,ebu_so2_ens_sd,nx,ny,nz_fire,num_mems)
            deallocate(ebu_so2_fld)
! Spatial stats EBU_SO2
            urban_flg=0
            call spatial_stats(urban_flg,ebu_so2_conus_mn,ebu_so2_conus_sd,ebu_so2_urban_mn,ebu_so2_urban_sd,ebu_so2_rural_mn, &
            ebu_so2_rural_sd,ebu_so2_cities_mn,ebu_so2_cities_sd,ebu_so2_ens_mn,ebu_so2_ens_sd,lon,lat,nx,ny,nz,num_cities)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"EBU_SO2_MN","flux (mol km-2 hr-1)",ebu_so2_ens_mn,nx,ny,nz_fire)
            call put_NETCDF_fld(trim(wrfchem_file),"EBU_SO2_SD","flux (mol km-2 hr-1)",ebu_so2_ens_sd,nx,ny,nz_fire)
            deallocate(e_so2_ens_mn)
            deallocate(e_so2_ens_sd)
            print *, '   APM: After process E_SO2'
         endif
      enddo
!
      deallocate(lon)
      deallocate(lat)
      wrfchem_file=trim(path_output)//"/"//trim(file_output)
      print *, 'APM: Close file ',trim(wrfchem_file)
   end program main

!-------------------------------------------------------------------------------
                          
   subroutine get_WRFCHEM_fld(file,name,data3d,nx,ny,nz,nf_type)
      implicit none
      include 'netcdf.inc'      
      integer, parameter                      :: maxdim=6
      integer                                 :: nx,ny,nz
      integer                                 :: i,rc
      integer                                 :: f_id
      integer                                 :: v_id,v_ndim,typ,natts
      integer,dimension(maxdim)               :: one
      integer,dimension(maxdim)               :: v_dimid
      integer,dimension(maxdim)               :: v_dim
      real,dimension(nx,ny,nz)                :: data3d
      real,dimension(nx,ny,nz,1)              :: data4d_real
      double precision,dimension(nx,ny,nz,1)  :: data4d_double
      character(len=200)                      :: v_nam
      character*(*)                           :: name
      character*(*)                           :: file
      character*(*)                           :: nf_type
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
      else if(1.ne.v_dim(4)) then             
         print *, 'ERROR: time dimension conflict ',1,v_dim(4)
         stop
      endif
!
! get data
      one(:)=1
      if(trim(nf_type).eq.'real') then
         rc = nf_get_vara_real(f_id,v_id,one,v_dim,data4d_real)
         data3d(:,:,:)=data4d_real(:,:,:,1)
      elseif(trim(nf_type).eq.'double') then
         rc = nf_get_vara_double(f_id,v_id,one,v_dim,data4d_double)
         data3d(:,:,:)=real(data4d_double(:,:,:,1))
      endif
      rc = nf_close(f_id)
      return
   end subroutine get_WRFCHEM_fld

!-------------------------------------------------------------------------------

   subroutine put_WRFCHEM_fld(file,name,data3d,nx,ny,nz)
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
      real,dimension(nx,ny,nz)              :: data3d
      real,dimension(nx,ny,nz,1)            :: data4d
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
!      print *, 'f_id ',f_id
!
! get variables identifiers
      rc = nf_inq_varid(f_id,trim(name),v_id)
!      print *, v_id
      if(rc.ne.0) then
         print *, 'nf_inq_varid error ', v_id
         stop
      endif
!      print *, 'v_id ',v_id
!
! get dimension identifiers
      v_dimid=0
      rc = nf_inq_var(f_id,v_id,v_nam,typ,v_ndim,v_dimid,natts)
!      print *, v_dimid
      if(rc.ne.0) then
         print *, 'nf_inq_var error ', v_dimid
         stop
      endif
!      print *, 'v_ndim, v_dimid ',v_ndim,v_dimid      
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
      else if(1.ne.v_dim(4)) then             
         print *, 'ERROR: time dimension conflict ',1,v_dim(4)
         stop
      endif
!
! put data
      data4d(:,:,:,1)=data3d(:,:,:)   
      one(:)=1
      rc = nf_put_vara_real(f_id,v_id,one(1:v_ndim),v_dim(1:v_ndim),data4d)
      rc = nf_close(f_id)
      return
   end subroutine put_WRFCHEM_fld

!-------------------------------------------------------------------------------

   subroutine create_NETCDF_file(wrfchem_file,nx,ny,nz,npts_traceri_conus,npts_wrfcmaq_conus, &
   num_cities,npts_urban,npts_rural)
      use :: netcdf
      implicit none
!      
      integer                    :: rc,fid,scl_dimid
      integer                    :: nx,ny,nz,npts_traceri_conus,npts_wrfcmaq_conus,num_cities,npts_urban,npts_rural
      integer                    :: var_id,att_id,x_dimid,y_dimid,z_dimid
      integer                    :: npts_traceri_conus_dimid,npts_wrfcmaq_conus_dimid
      integer                    :: num_cities_dimid,npts_urban_dimid,npts_rural_dimid
      character(len=*)           :: wrfchem_file
!
! Define dimensions
      rc=nf90_create(trim(wrfchem_file),NF90_CLOBBER,fid)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at create file')

      rc=nf90_def_dim(fid,"scalar",1,scl_dimid)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at scl_dimid')

      rc=nf90_def_dim(fid,"west-east",nx,x_dimid)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at x_dimid')

      rc=nf90_def_dim(fid,"south-north",ny,y_dimid)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at y_dimid')

      rc=nf90_def_dim(fid,"bottom-top",nz,z_dimid)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at z_dimid')

      rc=nf90_def_dim(fid,"npts_traceri_conus",npts_traceri_conus,npts_traceri_conus_dimid)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at npts_traceri_conus_dimid')

      rc=nf90_def_dim(fid,"npts_wrfcmaq_conus",npts_wrfcmaq_conus,npts_wrfcmaq_conus_dimid)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at npts_wrfcmaq_conus_dimid')

      rc=nf90_def_dim(fid,"num_cities",num_cities,num_cities_dimid)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at num_cities_dimid')

      rc=nf90_def_dim(fid,"npts_urban",npts_urban,npts_urban_dimid)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at npts_urban_dimid')

      rc=nf90_def_dim(fid,"npts_rural",npts_rural,npts_rural_dimid)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at npts_rural_dimid')
!
! Define variables
! TRACER-I CONUS Mappings      
      rc=nf90_def_var(fid,"NUM_TRACER_I_CONUS",NF90_INT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at NUM_TRACER_I_CONUS')

      rc=nf90_def_var(fid,"TRACER_I_CONUS_II",NF90_INT,(/npts_traceri_conus_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_CONUS_II')

      rc=nf90_def_var(fid,"TRACER_I_CONUS_JJ",NF90_INT,(/npts_traceri_conus_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_CONUS_JJ')
!
! TCR2 Mappings
      rc=nf90_def_var(fid,"TCR2_LL_II",NF90_INT,(/x_dimid,y_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TCR2_LL_II')

      rc=nf90_def_var(fid,"TCR2_LL_JJ",NF90_INT,(/x_dimid,y_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TCR2_LL_JJ')

      rc=nf90_def_var(fid,"TCR2_LR_II",NF90_INT,(/x_dimid,y_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TCR2_LR_II')

      rc=nf90_def_var(fid,"TCR2_LR_JJ",NF90_INT,(/x_dimid,y_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TCR2_LR_JJ')

      rc=nf90_def_var(fid,"TCR2_UL_II",NF90_INT,(/x_dimid,y_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TCR2_UL_II')

      rc=nf90_def_var(fid,"TCR2_UL_JJ",NF90_INT,(/x_dimid,y_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TCR2_UL_JJ')

      rc=nf90_def_var(fid,"TCR2_UR_II",NF90_INT,(/x_dimid,y_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TCR2_UR_II')

      rc=nf90_def_var(fid,"TCR2_UR_JJ",NF90_INT,(/x_dimid,y_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TCR2_UR_JJ')
!
! WRFCMAQ Mappings
      rc=nf90_def_var(fid,"NUM_WRFCMAQ",NF90_INT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at NUM_WRFCMAQ')

      rc=nf90_def_var(fid,"WRFCMAQ_I",NF90_INT,(/npts_wrfcmaq_conus_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at WRFCMAQ_I')

      rc=nf90_def_var(fid,"WRFCMAQ_J",NF90_INT,(/npts_wrfcmaq_conus_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at WRFCMAQ_J')

      rc=nf90_def_var(fid,"WRFCMAQ_II",NF90_INT,(/npts_wrfcmaq_conus_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at WRFCMAQ_II')

      rc=nf90_def_var(fid,"WRFCMAQ_JJ",NF90_INT,(/npts_wrfcmaq_conus_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at WRFCMAQ_JJ')
!
! WRFCMAQ CONUS Mappings
      rc=nf90_def_var(fid,"NUM_WRFCMAQ_CONUS",NF90_INT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at NUM_WRFCMAQ_CONUS')

      rc=nf90_def_var(fid,"WRFCMAQ_CONUS_II",NF90_INT,(/npts_wrfcmaq_conus_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at WRFCMAQ_CONUS_II')

      rc=nf90_def_var(fid,"WRFCMAQ_CONUS_JJ",NF90_INT,(/npts_wrfcmaq_conus_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at WRFCMAQ_CONUS_JJ')
!
! CAMCHEM Mappings
      rc=nf90_def_var(fid,"CAMCHEM_LL_II",NF90_INT,(/x_dimid,y_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at CAMCHEM_LL_II')

      rc=nf90_def_var(fid,"CAMCHEM_LL_JJ",NF90_INT,(/x_dimid,y_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at CAMCHEM_LL_JJ')

      rc=nf90_def_var(fid,"CAMCHEM_LR_II",NF90_INT,(/x_dimid,y_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at CAMCHEM_LR_II')

      rc=nf90_def_var(fid,"CAMCHEM_LR_JJ",NF90_INT,(/x_dimid,y_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at CAMCHEM_LR_JJ')

      rc=nf90_def_var(fid,"CAMCHEM_UL_II",NF90_INT,(/x_dimid,y_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at CAMCHEM_UL_II')

      rc=nf90_def_var(fid,"CAMCHEM_UL_JJ",NF90_INT,(/x_dimid,y_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at CAMCHEM_UL_JJ')

      rc=nf90_def_var(fid,"CAMCHEM_UR_II",NF90_INT,(/x_dimid,y_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at CAMCHEM_UR_II')

      rc=nf90_def_var(fid,"CAMCHEM_UR_JJ",NF90_INT,(/x_dimid,y_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at CAMCHEM_UR_JJ')
!
! Cities Mappings
!      rc=nf90_def_var(fid,"CITIES",NF90_CHAR,(/num_cities_dimid/),var_id)
!      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at CITIES')

      rc=nf90_def_var(fid,"LON1_CITIES",NF90_INT,(/num_cities_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at LON1_CITIES')

      rc=nf90_def_var(fid,"LON2_CITIES",NF90_INT,(/num_cities_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at LON2_CITIES')

      rc=nf90_def_var(fid,"LAT1_CITIES",NF90_INT,(/num_cities_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at LAT1_CITIES')

      rc=nf90_def_var(fid,"LAT2_CITIES",NF90_INT,(/num_cities_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at LAT2_CITIES')
!
! TRACER-I Urban Mappings      
      rc=nf90_def_var(fid,"NUM_TRACER_I_URBAN",NF90_INT,(/num_cities_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_URBAN_NPTS')

      rc=nf90_def_var(fid,"TRACER_I_URBAN_II",NF90_INT,(/num_cities_dimid,npts_urban_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_URBAN_II')

      rc=nf90_def_var(fid,"TRACER_I_URBAN_JJ",NF90_INT,(/num_cities_dimid,npts_urban_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_URBAN_JJ')
!
! TRACER-I Rural Mappings      
      rc=nf90_def_var(fid,"NUM_TRACER_I_RURAL",NF90_INT,(/1/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_RURAL_NPTS')

      rc=nf90_def_var(fid,"TRACER_I_RURAL_II",NF90_INT,(/npts_rural_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_RURAL_II')

      rc=nf90_def_var(fid,"TRACER_I_RURAL_JJ",NF90_INT,(/npts_rural_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_RURAL_JJ')
!
! WRFCMAQ Urban Mappings      
      rc=nf90_def_var(fid,"NUM_WRFCMAQ_URBAN",NF90_INT,(/num_cities_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at WRFCMAQ_URBAN_NPTS')

      rc=nf90_def_var(fid,"WRFCMAQ_URBAN_II",NF90_INT,(/num_cities_dimid,npts_urban_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at WRFCMAQ_URBAN_II')

      rc=nf90_def_var(fid,"WRFCMAQ_URBAN_JJ",NF90_INT,(/num_cities_dimid,npts_urban_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at WRFCMAQ_URBAN_JJ')
!
! WRFCMAQ Rural Mappings      
      rc=nf90_def_var(fid,"NUM_WRFCMAQ_RURAL",NF90_INT,(/1/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at WRFCMAQ_RURAL_NPTS')

      rc=nf90_def_var(fid,"WRFCMAQ_RURAL_II",NF90_INT,(/npts_rural_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at WRFCMAQ_RURAL_II')

      rc=nf90_def_var(fid,"WRFCMAQ_RURAL_JJ",NF90_INT,(/npts_rural_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at WRFCMAQ_RURAL_JJ')
!
      rc=nf90_enddef(fid)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at enddef')
      rc=nf90_close(fid)
      return
   end subroutine create_NETCDF_FILE

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
   
   subroutine put_NETCDF_fld(wrfchem_file,var_name,var_units,data,nx,ny,nz)
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
   end subroutine put_NETCDF_fld

!-------------------------------------------------------------------------------
   
   subroutine put_NETCDF_CHAR_fld(wrfchem_file,var_name,var_units,data,nx,ny,nz)
      use :: netcdf
      implicit none
!
      integer                                :: rc,fid,varid
      integer                                :: nx,ny,nz
      character(len=*)                       :: wrfchem_file,var_name,var_units
      character(len=*),dimension(nx,ny,nz)   :: data
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
   end subroutine put_NETCDF_CHAR_fld

!-------------------------------------------------------------------------------

   subroutine ens_stats(fld,fld_ens_mn,fld_ens_sd,nx,ny,nz,num_mems)
      implicit none
      integer                           :: i,j,k,imem,nx,ny,nz,num_mems
      real,dimension(nx,ny,nz)          :: fld_ens_mn,fld_ens_vr,fld_ens_sd
      real,dimension(nx,ny,nz,num_mems) :: fld
!
      fld_ens_mn(:,:,:)=0.
      fld_ens_vr(:,:,:)=0.
      fld_ens_sd(:,:,:)=0.
      do i=1,nx
         do j=1,ny
            do k=1,nz
               do imem=1,num_mems
                  fld_ens_mn(i,j,k)=fld_ens_mn(i,j,k)+fld(i,j,k,imem)/real(num_mems)
               enddo
            enddo
         enddo
      enddo
!
      do i=1,nx
         do j=1,ny
            do k=1,nz
               do imem=1,num_mems
                  fld_ens_vr(i,j,k)=fld_ens_vr(i,j,k)+((fld(i,j,k,imem)- &
                  fld_ens_mn(i,j,k))**2)/real(num_mems-1)
               enddo
            enddo
         enddo
      enddo
!
      fld_ens_sd(:,:,:)=sqrt(fld_ens_vr(:,:,:))
      return
   end subroutine ens_stats

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

!-------------------------------------------------------------------------------

   subroutine spatial_stats(urban_flg,fld_conus_mn,fld_conus_sd,fld_urban_mn,fld_urban_sd,fld_rural_mn, &
   fld_rural_sd,fld_cities_mn,fld_cities_sd,fld_ens_mn,fld_ens_sd,lon,lat,nx,ny,nz,num_cities)
      use :: netcdf
      implicit none
      integer                                     :: urban_flg,nx,ny,nz,num_cities
      integer                                     :: i,j,k,ipts,icity,rural_npts,npts
      integer,allocatable,dimension(:)            :: urban_npts
      integer,allocatable,dimension(:)            :: rural_indx,rural_jndx
      integer,allocatable,dimension(:,:)          :: urban_indx,urban_jndx
      real                                        :: wt
      real,dimension(nz)                          :: fld_conus_mn,fld_conus_vr,fld_conus_sd
      real,dimension(nz)                          :: fld_urban_mn,fld_urban_vr,fld_urban_sd
      real,dimension(nz)                          :: fld_rural_mn,fld_rural_vr,fld_rural_sd
      real,dimension(num_cities,nz)               :: fld_cities_mn,fld_cities_vr,fld_cities_sd
      real,dimension(num_cities,nz)               :: zwt
      real,dimension(nx,ny)                       :: lon,lat
      real,dimension(nx,ny,nz)                    :: fld_ens_mn,fld_ens_sd
      real,allocatable,dimension(:)               :: lon1_city,lon2_city,lat1_city,lat2_city
      character(len=80),allocatable,dimension(:)  :: cities




!
      npts=200
      allocate (cities(num_cities))
      allocate (lon1_city(num_cities))
      allocate (lon2_city(num_cities))
      allocate (lat1_city(num_cities))
      allocate (lat2_city(num_cities))
!      
      cities = (/'Boston','New York','Philadelphia','DC&Baltimore','Charlotte','Orlando','Miami', &
      'Pittsburgh','Atlanta','Detroit','Cincinnati','Nashville','Birmingham','Chicago', &
      'Indianapolis','St. Louis','Memphis','Minneapolis','Kansas City','Houston','Albuquerque','NFR', &
      'Dallas','Salt Lake City','Las Vegas','Phoenix','Seattle','San Francisco','Los Angeles'/)
!
      lon1_city = (/-71.4, -74.6, -75.6, -77.6, -81.2, -81.9, -80.5, -80.4, -84.9, -84.0, &
      -84.8, -87.3, -87.3, -88.6, -86.6, -91.0, -90.6,  -94.0, -95.2, -96.0, -106.93, -105.4, &
      -97.9, -112.3, -115.5, -112.7, -123.0, -122.5, -118.5/)
!
      lon2_city = (/-70.7, -73.8, -74.6, -76.2, -80.4, -80.9, -80.0, -79.3, -83.8, -82.7, &
      -84.1, -86.2, -86.2, -87.4, -85.7, -89.6,  -89.4, -92.5, -94.1, -94.8, -106.3, -103.8, &
      -96.2, -111.4, -114.8, -111.3, -121.6, -121.0, -117.0/)
!     
      lat1_city = (/42.1, 40.4, 39.8, 38.5, 34.8, 28.1, 25.6, 40.0, 33.4, 42.0, 38.8, &
      35.8, 33.1, 41.4, 39.4, 38.2, 34.8, 44.5, 38.7, 29.2, 34.7, 39.5, 32.3, 40.0, 35.8, &
      32.7, 46.8, 37.3, 33.2/);
!
      lat2_city = (/42.7, 41.1, 40.2, 39.6, 35.6, 29.1, 26.9, 40.9, 34.2, 42.9, 39.7, &
      36.5, 33.9, 42.5, 40.3, 39.1, 35.4, 45.6, 39.5, 30.8, 35.51, 40.9, 33.4, 41.5, 36.5, &
      34.2, 48.6, 39.0, 34.7/)
!
! Set up index array (Do this only once based on urban_flg)
      if(urban_flg.eq.0) then
         allocate(urban_indx(num_cities,npts))
         allocate(urban_jndx(num_cities,npts))
         allocate(urban_npts(num_cities))
         allocate(rural_indx(nx*ny))
         allocate(rural_jndx(nx*ny))
         urban_indx(:,:)=0
         urban_jndx(:,:)=0
         urban_npts(:)=0
         rural_indx(:)=0
         rural_jndx(:)=0
         rural_npts=0
         do i=1,nx
            do j=1,ny
               urban_flg=0
               do icity=1,num_cities
!            
! Urban points
                  if(lon(i,j).ge.lon1_city(icity) .and. lon(i,j).le.lon2_city(icity) .and. &
                  lat(i,j).ge.lat1_city(icity) .and. lat(i,j).le.lat2_city(icity)) then
                     urban_flg=1
                     urban_npts(icity)=urban_npts(icity)+1
                     if(urban_npts(icity).gt.npts) then
                        print *, 'APM: Increase NPTS'
                        stop
                     endif
                     urban_indx(icity,urban_npts(icity))=i
                     urban_jndx(icity,urban_npts(icity))=j
                     exit
                  endif
               enddo
!
! Rural points            
               if(urban_flg.eq.0) then
                  rural_npts=rural_npts+1
                  rural_indx(rural_npts)=i
                  rural_jndx(rural_npts)=j
               endif
            enddo
         enddo
      endif
!
! CONUS
      fld_conus_mn(:)=0.
      fld_conus_vr(:)=0.
      zwt(:,:)=0.
      do i=1,nx
         do j=1,ny
            wt=cos(lat(i,j))
            wt=1.
            do k=1,nz
               fld_conus_mn(k)=fld_conus_mn(k)+wt*fld_ens_mn(i,j,k)
               fld_conus_vr(k)=fld_conus_vr(k)+wt*(fld_ens_sd(i,j,k)**2)
               zwt(1,k)=zwt(1,k)+wt
            enddo
         enddo   
      enddo
      do k=1,nz
         fld_conus_mn(k)=fld_conus_mn(k)/zwt(1,k)
         fld_conus_vr(k)=fld_conus_vr(k)/(zwt(1,k)-1)
         fld_conus_sd(k)=sqrt(fld_conus_vr(k))
      enddo
      print *, 'fld_conus_mn ',fld_conus_mn(:)
      print *, 'fld_conus_sd ',fld_conus_sd(:)
!
! URBAN
      fld_urban_mn(:)=0. 
      fld_urban_vr(:)=0.
      zwt(:,:)=0.
      do icity=1,num_cities
         do ipts=1,urban_npts(icity)
            i=urban_indx(icity,ipts)
            j=urban_jndx(icity,ipts)
            wt=cos(lat(i,j))
            wt=1.
            do k=1,nz
               fld_urban_mn(k)=fld_urban_mn(k)+wt*fld_ens_mn(i,j,k)
               fld_urban_vr(k)=fld_urban_vr(k)+wt*(fld_ens_sd(i,j,k)**2)
               zwt(1,k)=zwt(1,k)+wt
            enddo
         enddo
      enddo
      do k=1,nz
         fld_urban_mn(k)=fld_urban_mn(k)/zwt(1,k)
         fld_urban_vr(k)=fld_urban_vr(k)/(zwt(1,k)-1)
         fld_urban_sd(k)=sqrt(fld_urban_vr(k))
      enddo
      print *, 'fld_urban_mn ',fld_urban_mn(:)
      print *, 'fld_urban_sd ',fld_urban_sd(:)
!
! RURAL
      fld_rural_mn(:)=0.         
      fld_rural_vr(:)=0.         
      zwt(:,:)=0.
      do ipts=1,rural_npts
         i=rural_indx(ipts)
         j=rural_jndx(ipts)
         wt=cos(lat(i,j))
         wt=1.
         do k=1,nz
            fld_rural_mn(k)=fld_rural_mn(k)+wt*fld_ens_mn(i,j,k)
            fld_rural_vr(k)=fld_rural_vr(k)+wt*(fld_ens_sd(i,j,k)**2)
            zwt(1,k)=zwt(1,k)+wt
         enddo
      enddo
      do k=1,nz
         fld_rural_mn(k)=fld_rural_mn(k)/zwt(1,k)   
         fld_rural_vr(k)=fld_rural_vr(k)/(zwt(1,k)-1)   
         fld_rural_sd(k)=sqrt(fld_rural_vr(k))
      enddo
      print *, 'fld_rural_mn ',fld_rural_mn(:)
      print *, 'fld_rural_sd ',fld_rural_sd(:)
! CITIES
      fld_cities_mn(:,:)=0.         
      fld_cities_vr(:,:)=0.         
      zwt(:,:)=0.
      do icity=1,num_cities
         do ipts=1,urban_npts(icity)
            i=urban_indx(icity,ipts)
            j=urban_jndx(icity,ipts)
            wt=cos(lat(i,j))
            wt=1.
            do k=1,nz
               fld_cities_mn(icity,k)=fld_cities_mn(icity,k)+wt*fld_ens_mn(i,j,k)
               fld_cities_vr(icity,k)=fld_cities_vr(icity,k)+wt*(fld_ens_sd(i,j,k)**2)
               zwt(icity,k)=zwt(icity,k)+wt
            enddo
         enddo
      enddo
      do icity=1,num_cities
         do k=1,nz
            fld_cities_mn(icity,k)=fld_cities_mn(icity,k)/zwt(icity,k)   
            fld_cities_vr(icity,k)=fld_cities_vr(icity,k)/(zwt(icity,k)-1)   
            fld_cities_sd(icity,k)=sqrt(fld_cities_vr(icity,k))
         enddo
      enddo
      print *, 'fld_cities_mn ',fld_cities_mn(1,:)
      print *, 'fld_cities_sd ',fld_cities_sd(1,:)
   end subroutine spatial_stats

!-------------------------------------------------------------------------------

   subroutine w3fb13(xi_real,xj_real,alat,elon,alat1,elon1, &
   dx,elonv,alatan1,alatan2)
   implicit none
   real                 :: alat,elon,alat1,elon1,elonl,dx,elonv
   real                 :: alatan1,alatan2
   real                 :: rerth,pi,cone_fac
   real                 :: an,h,radpd,rebydx,alatn1,alatn2
   real                 :: cosltn,elon1l,elonvr
   real                 :: ala1,psi,rmll,elo1,arg,polei,polej,ala,rm,elo
   real                 :: xi_real,xj_real
!
   rerth=6.3712e6
   pi=3.14159
   cone_fac=.715567
!
   if(alatan1.gt.0) then
      h=1
   else
      h=-1
   endif
!
   radpd=pi/180.
   rebydx=rerth/dx
   alatn1=alatan1*radpd
   alatn2=alatan2*radpd
   if(alatan1.eq.alatan2) then
      an=h*sin(alatn1)
   else
      an=log(cos(alatn1)/cos(alatn2))/log(tan(((h*pi/2.)- &
      alatn1)/2.)/tan(((h*pi/2.)-alatn2)/2.))
   endif
   cosltn=cos(alatn2)
!
   elon1l=elon1
   if(elon1-elonv.gt.180) then
      elon1l=elon1-360
   endif
   if(elon1-elonv.lt.-180) then
      elon1l=elon1+360
   endif
!
   elonl=elon
   if(elon-elonv.gt.180) then
      elonl=elon-360
   endif
   if(elon-elonv.lt.-180) then
      elonl=elon+360;
   endif
!
   elonvr=elonv*radpd
!
   ala1=alat1*radpd
   psi=(rebydx*cosltn)/(an*(tan((pi/4.)-(h*alatn2/2.))**an))
   rmll=psi*(tan((pi/4.)-(h*ala1/2.))**an)
!
   elo1=elon1l*radpd
   arg=an*(elo1-elonvr)
   polei=1.-h*rmll*sin(arg)
   polej=1+rmll*cos(arg)
!
   ala=alat*radpd
!
   rm=psi*(tan((pi/4.)-(h*ala/2.))**an)
   elo=elonl*radpd
   arg=an*(elo-elonvr)
   xi_real=polei+h*rm*sin(arg)
   xj_real=polej-rm*cos(arg)
!
   if(nint(xi_real).lt.1) then
      xi_real=xi_real-1.
   endif
   if(nint(xj_real).lt.1) then
      xj_real=xj_real-1.
   endif
end subroutine w3fb13
   
