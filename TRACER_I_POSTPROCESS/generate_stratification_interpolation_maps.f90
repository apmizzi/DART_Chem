  program main
      implicit none
      integer                                    :: nx,ny,nz,nz_chemi,nz_fire,num_mems,num_cities,num_regions
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
      real,allocatable,dimension(:)              :: lon1_regions,lon2_regions,lat1_regions,lat2_regions
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
      character(len=80),allocatable,dimension(:)  :: cities
      character(len=80),allocatable,dimension(:)  :: regions
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
      num_regions=3592
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
      npts_urban=1000
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
      num_cities,num_regions,npts_urban,npts_rural)
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
      allocate (regions(num_regions))
      allocate (lon1_regions(num_regions))
      allocate (lon2_regions(num_regions))
      allocate (lat1_regions(num_regions))
      allocate (lat2_regions(num_regions))
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
      lon1_regions = (/-69.833, -68.872, -68.266, -69.03, -70.02, -67.296, -69.1, -68.041,  &
      -71.016, -68.449, -70.168, -67.862, -70.586, -70.31, -70.237, -68.721,  &
      -69.401, -70.54, -71.018, -68.058, -69.206, -70.566, -70.812, -69.737,  &
      -70.581, -69.743, -73.72, -72.418, -73.588, -73.134, -71.992, -72.589,  &
      -73.251, -72.468, -73.087, -74.949, -72.342, -72.869, -72.335, -73.172,  &
      -73.165, -72.346, -72.135, -112.874, -112.457, -116.462, -116.339,  &
      -114.776, -113.824, -117.042, -116.543, -114.631, -114.733, -116.145,  &
      -114.331, -116.951, -112.107, -114.563, -116.191, -114.433, -116.453,  &
      -117.122, -117.04, -115.76, -115.895, -79.037, -77.078, -77.422, -76.973,  &
      -80.006, -76.988, -80.034, -76.938, -75.572, -77.247, -75.452, -77.897,  &
      -76.848, -78.868, -80.407, -77.146, -80.354, -79.855, -78.809, -79.76,  &
      -76.135, -78.714, -78.29, -76.436, -80.471, -75.01, -78.721, -75.826,  &
      -76.311, -79.017, -76.252, -76.246, -78.903, -78.76, -78.493, -78.585,  &
      -75.085, -76.092, -76.693, -76.251, -77.577, -75.611, -80.072, -79.107,  &
      -77.977, -76.613, -76.992, -75.627, -75.982, -79.703, -76.485, -78.74,  &
      -75.971, -78.321, -79.864, -79.829, -79.242, -80.232, -77.145, -76.657,  &
      -76.902, -79.406, -101.855, -99.879, -97.665, -98.123, -103.695, -97.27,  &
      -101.98, -102.573, -96.593, -95.885, -94.218, -97.001, -98.014, -99.973,  &
      -97.455, -97.372, -95.997, -94.258, -97.783, -96.288, -98.024, -101.467,  &
      -101.53, -97.811, -98.773, -96.233, -101.471, -79.322, -77.82, -79.63,  &
      -77.998, -82.803, -80.604, -78.021, -78.816, -79.381, -78.608, -78.48,  &
      -79.862, -82.514, -77.007, -80.029, -78.213, -78.728, -78.049, -78.749,  &
      -77.578, -78.434, -77.014, -77.636, -78.254, -80.95, -76.563, -78.838,  &
      -78.99, -77.265, -77.574, -78.359, -77.788, -77.866, -82.117, -79.462,  &
      -78.485, -79.342, -81.627, -80.071, -82.683, -78.138, -80.772, -80.805,  &
      -77.783, -81.872, -77.732, -80.228, -79.933, -78.422, -76.663, -78.95,  &
      -78.172, -79.137, -78.384, -79.069, -76.884, -81.563, -78.456, -76.668,  &
      -76.833, -78.97, -76.865, -78.264, -78.6, -81.133, -116.724, -117.069,  &
      -117.02, -116.348, -116.034, -112.521, -111.887, -116.916, -111.82,  &
      -111.964, -113.745, -111.701, -116.618, -113.928, -116.609, -112.159,  &
      -111.619, -116.514, -114.517, -117.002, -114.722, -76.514, -77.0, -77.671,  &
      -76.114, -76.08, -76.686, -76.095, -76.814, -75.865, -78.96, -77.077,  &
      -75.845, -76.108, -77.415, -75.789, -77.565, -77.043, -76.757, -78.078,  &
      -79.026, -76.679, -76.572, -76.557, -76.906, -79.424, -76.753, -75.583,  &
      -77.423, -76.632, -75.715, -76.368, -76.576, -77.837, -77.186, -77.435,  &
      -77.21, -77.641, -79.085, -77.066, -104.899, -105.912, -106.878, -107.171,  &
      -108.063, -107.642, -105.327, -106.075, -103.66, -106.17, -102.289,  &
      -105.274, -107.238, -107.99, -104.936, -108.609, -107.601, -108.084,  &
      -105.241, -107.922, -106.844, -104.737, -106.629, -105.574, -105.367,  &
      -104.971, -105.165, -105.18, -97.869, -100.434, -99.354, -95.627, -98.948,  &
      -96.435, -97.783, -95.977, -102.309, -97.618, -99.016, -98.603, -98.263,  &
      -102.01, -96.723, -97.006, -100.402, -95.894, -101.955, -98.307, -99.882,  &
      -94.382, -98.927, -94.207, -100.237, -99.005, -95.086, -97.432, -95.157,  &
      -97.597, -99.526, -99.442, -96.44, -100.894, -96.597, -98.627, -98.941,  &
      -95.929, -95.661, -97.694, -96.538, -99.253, -102.367, -95.482, -99.841,  &
      -97.314, -94.745, -102.54, -97.648, -94.945, -97.619, -95.32, -100.962,  &
      -97.181, -97.257, -102.872, -98.931, -94.806, -99.198, -102.343, -98.361,  &
      -101.982, -96.349, -100.514, -98.849, -96.672, -96.31, -98.934, -97.437,  &
      -97.623, -95.47, -96.667, -106.17, -96.224, -98.165, -96.38, -98.18,  &
      -101.351, -96.493, -102.925, -98.906, -102.745, -101.628, -97.174, -94.881,  &
      -97.79, -96.96, -94.971, -97.468, -98.607, -77.822, -86.354, -86.008,  &
      -86.512, -85.988, -86.546, -87.074, -87.516, -85.57, -87.8, -87.063,  &
      -87.197, -87.1, -85.794, -104.821, -103.839, -105.822, -107.374, -108.751,  &
      -104.852, -106.968, -106.976, -104.981, -105.194, -103.633, -102.645,  &
      -103.247, -106.337, -104.738, -105.19, -106.168, -107.957, -107.56,  &
      -107.107, -104.839, -107.819, -103.748, -105.096, -106.085, -104.876,  &
      -107.672, -106.113, -106.922, -103.301, -104.542, -106.449, -104.805,  &
      -105.019, -105.097, -102.738, -83.905, -85.57, -86.93, -88.389, -84.353,  &
      -86.558, -87.841, -85.382, -85.198, -87.214, -84.889, -87.514, -85.336,  &
      -84.631, -83.067, -84.328, -84.816, -86.053, -87.737, -83.238, -83.761,  &
      -84.954, -86.603, -88.901, -84.6, -85.965, -82.974, -83.428, -84.874,  &
      -83.293, -85.757, -87.553, -85.972, -82.876, -84.0, -83.4, -84.602,  &
      -84.935, -85.281, -86.318, -84.61, -84.21, -82.632, -86.005, -85.488,  &
      -87.545, -83.797, -88.096, -88.681, -83.854, -83.766, -84.884, -97.867,  &
      -95.734, -95.364, -98.41, -96.164, -96.552, -96.207, -94.609, -98.137,  &
      -97.878, -99.752, -96.616, -98.694, -96.098, -94.836, -98.219, -102.432,  &
      -98.484, -97.145, -97.208, -99.16, -94.343, -98.39, -95.873, -95.601,  &
      -97.249, -98.697, -98.191, -95.298, -94.06, -95.524, -99.79, -97.311,  &
      -97.914, -96.325, -97.868, -103.119, -99.264, -94.956, -97.945, -98.488,  &
      -97.898, -97.255, -98.03, -96.901, -95.654, -95.579, -95.676, -95.497,  &
      -101.987, -98.212, -99.56, -102.404, -94.836, -95.47, -102.35, -94.954,  &
      -98.706, -97.719, -94.983, -102.034, -94.845, -97.678, -98.847, -98.52,  &
      -97.425, -96.808, -95.93, -95.804, -96.04, -97.558, -98.305, -96.908,  &
      -94.407, -97.895, -101.933, -96.505, -102.227, -95.554, -98.146, -102.948,  &
      -94.872, -95.034, -95.238, -102.759, -94.704, -96.113, -95.856, -94.47,  &
      -97.743, -87.304, -86.703, -86.635, -85.16, -86.895, -87.934, -87.113,  &
      -87.869, -85.554, -85.897, -85.179, -86.971, -87.85, -87.751, -87.757,  &
      -85.775, -86.134, -85.897, -88.371, -86.649, -87.663, -88.035, -86.8,  &
      -86.604, -85.376, -86.85, -87.908, -87.314, -87.166, -88.326, -87.366,  &
      -86.521, -87.302, -87.638, -86.523, -86.283, -85.701, -86.324, -87.633,  &
      -85.638, -86.95, -85.39, -87.757, -87.751, -86.097, -87.107, -85.74,  &
      -86.512, -87.099, -86.38, -86.184, -85.94, -87.757, -86.018, -87.702,  &
      -85.748, -85.728, -85.239, -86.24, -87.176, -112.88, -111.705, -112.585,  &
      -111.334, -110.316, -109.939, -114.635, -112.626, -114.645, -111.902,  &
      -111.792, -109.617, -112.519, -109.341, -113.007, -111.559, -110.825,  &
      -112.074, -109.579, -109.335, -111.622, -112.509, -111.71, -111.398,  &
      -109.085, -110.887, -110.199, -110.277, -114.076, -114.379, -83.512,  &
      -87.933, -84.021, -84.382, -88.361, -84.639, -87.237, -88.787, -82.87,  &
      -84.292, -82.63, -86.589, -83.041, -82.825, -87.907, -84.376, -86.931,  &
      -86.231, -85.292, -84.707, -84.683, -83.941, -86.779, -84.759, -84.197,  &
      -82.305, -84.635, -84.676, -84.293, -120.564, -120.573, -121.99, -122.074,  &
      -124.129, -120.739, -118.86, -121.128, -118.344, -120.147, -119.208,  &
      -117.125, -116.979, -118.449, -119.921, -115.567, -121.68, -118.012,  &
      -115.525, -122.604, -119.109, -121.112, -121.854, -121.919, -120.286,  &
      -122.732, -122.761, -123.035, -120.376, -120.989, -122.03, -122.217,  &
      -119.592, -122.207, -122.357, -124.256, -121.804, -119.33, -116.576,  &
      -121.653, -121.862, -120.658, -119.304, -120.957, -115.629, -120.739,  &
      -121.015, -122.037, -124.223, -122.16, -118.951, -120.492, -122.944,  &
      -123.821, -116.708, -124.181, -119.008, -119.933, -121.337, -97.598,  &
      -102.535, -98.777, -95.159, -101.224, -96.24, -95.71, -96.954, -100.997,  &
      -95.609, -99.125, -97.534, -97.742, -103.558, -100.852, -96.98, -94.994,  &
      -101.76, -98.561, -94.098, -97.314, -96.659, -101.399, -98.588, -96.038,  &
      -98.139, -104.387, -95.461, -97.803, -97.286, -99.514, -99.032, -97.596,  &
      -97.686, -97.04, -97.113, -95.189, -100.529, -98.805, -98.253, -97.207,  &
      -97.997, -98.765, -96.932, -96.185, -98.024, -102.674, -102.004, -96.688,  &
      -94.229, -97.525, -101.675, -97.174, -100.945, -100.663, -101.209, -97.708,  &
      -99.813, -98.255, -98.583, -95.658, -95.538, -95.723, -100.436, -97.414,  &
      -101.817, -97.447, -96.31, -97.538, -96.343, -95.197, -106.106, -95.392,  &
      -101.815, -95.415, -99.854, -95.659, -97.132, -99.333, -97.097, -97.327,  &
      -97.839, -97.102, -95.668, -95.981, -96.144, -96.127, -96.925, -98.614,  &
      -96.035, -111.799, -110.016, -111.234, -112.079, -114.147, -114.627,  &
      -111.036, -111.476, -114.321, -111.37, -112.46, -111.252, -112.541,  &
      -114.241, -110.996, -109.861, -111.043, -109.402, -110.477, -114.797,  &
      -110.643, -111.82, -110.115, -110.376, -110.132, -114.727, -111.118,  &
      -111.26, -111.184, -110.754, -111.795, -112.36, -110.034, -112.783,  &
      -109.859, -112.231, -109.107, -110.751, -114.715, -75.616, -75.647,  &
      -75.413, -75.59, -75.286, -75.217, -75.744, -75.511, -75.368, -75.327,  &
      -75.235, -75.164, -76.124, -75.714, -75.742, -74.832, -75.099, -75.31,  &
      -74.642, -75.372, -74.642, -74.837, -74.631, -74.594, -75.051, -75.113,  &
      -74.406, -74.841, -74.407, -74.585, -75.526, -74.886, -74.685, -74.399,  &
      -74.972, -75.184, -75.054, -75.37, -71.652, -76.037, -78.514, -74.069,  &
      -78.225, -77.803, -74.315, -78.481, -78.307, -76.615, -121.713, -121.454,  &
      -121.115, -121.261, -121.723, -120.591, -123.05, -121.021, -122.52,  &
      -119.808, -117.136, -122.579, -120.868, -121.48, -115.423, -120.113,  &
      -120.087, -116.571, -120.965, -120.821, -122.848, -120.083, -121.161,  &
      -117.334, -118.497, -117.863, -121.08, -122.938, -117.168, -121.219,  &
      -118.281, -119.914, -119.12, -121.679, -121.823, -121.32, -120.508,  &
      -118.872, -120.88, -122.174, -119.241, -120.11, -119.005, -121.3, -116.13,  &
      -120.405, -120.643, -117.826, -121.108, -118.198, -120.915, -121.557,  &
      -122.401, -117.416, -122.355, -121.038, -120.551, -115.949, -119.672,  &
      -119.332, -122.239, -119.35, -121.634, -119.322, -121.656, -119.563,  &
      -121.175, -122.716, -117.607, -120.886, -120.334, -121.561, -119.169,  &
      -119.113, -120.507, -116.921, -120.88, -121.114, -122.289, -122.453,  &
      -119.47, -120.003, -119.113, -117.777, -124.128, -121.723, -119.878,  &
      -94.409, -95.318, -99.98, -98.153, -94.439, -97.166, -99.293, -77.765,  &
      -78.265, -77.367, -73.667, -76.189, -78.691, -78.042, -79.112, -75.19,  &
      -74.005, -75.888, -74.311, -75.909, -77.951, -77.246, -74.607, -73.966,  &
      -77.732, -73.857, -77.153, -76.235, -73.848, -77.74, -74.932, -76.361,  &
      -79.423, -78.638, -74.417, -77.004, -74.646, -77.829, -77.023, -73.738,  &
      -74.419, -75.497, -78.955, -73.296, -73.538, -75.559, -77.626, -73.364,  &
      -77.714, -73.807, -75.102, -76.569, -79.405, -74.127, -74.0, -78.01,  &
      -74.77, -74.884, -78.745, -75.507, -74.343, -74.924, -74.225, -78.49,  &
      -74.49, -71.981, -74.734, -77.907, -77.177, -78.852, -75.543, -75.532,  &
      -78.523, -75.775, -75.142, -76.566, -74.563, -76.308, -77.271, -77.109,  &
      -78.042, -73.643, -74.824, -75.022, -73.848, -73.926, -73.929, -77.873,  &
      -75.504, -78.762, -74.157, -73.939, -76.558, -75.417, -79.178, -76.463,  &
      -77.111, -117.673, -118.24, -117.15, -121.584, -122.495, -121.767,  &
      -117.456, -122.65, -119.602, -120.2, -122.191, -120.746, -119.922,  &
      -118.673, -122.165, -120.497, -119.097, -122.92, -121.963, -119.693,  &
      -119.301, -117.368, -118.831, -121.398, -120.223, -122.542, -120.453,  &
      -120.042, -121.394, -120.676, -119.483, -118.521, -119.054, -119.062,  &
      -119.32, -121.521, -120.307, -120.913, -116.111, -116.095, -123.238,  &
      -122.028, -122.293, -120.545, -117.5, -119.475, -119.421, -120.779,  &
      -121.837, -121.443, -122.168, -123.402, -122.219, -121.993, -119.117,  &
      -121.803, -117.658, -122.386, -122.671, -121.694, -116.48, -72.514,  &
      -71.225, -72.625, -72.432, -72.391, -71.63, -71.122, -71.107, -71.697,  &
      -71.948, -72.037, -72.345, -71.548, -72.398, -71.804, -71.621, -72.196,  &
      -71.154, -71.988, -71.723, -72.424, -116.975, -114.869, -119.817, -119.608,  &
      -115.833, -114.901, -74.658, -72.482, -72.221, -78.697, -75.872, -76.411,  &
      -73.444, -74.494, -75.417, -73.737, -74.256, -75.144, -77.322, -73.794,  &
      -78.151, -74.417, -74.307, -76.056, -76.889, -76.635, -77.99, -79.612,  &
      -74.017, -74.495, -123.913, -122.703, -122.977, -122.627, -119.508,  &
      -122.822, -122.855, -122.537, -122.539, -120.566, -122.929, -123.123,  &
      -120.191, -117.608, -122.486, -121.038, -117.384, -117.925, -118.878,  &
      -118.005, -117.488, -122.287, -120.582, -119.583, -122.384, -124.413,  &
      -120.838, -119.943, -120.21, -122.021, -121.578, -122.579, -122.876,  &
      -119.406, -122.691, -122.556, -120.691, -123.037, -122.524, -120.008,  &
      -122.37, -119.915, -117.709, -123.625, -119.365, -122.422, -117.626,  &
      -122.752, -124.059, -124.173, -123.028, -119.603, -119.229, -122.156,  &
      -123.526, -122.803, -123.154, -122.819, -117.212, -119.897, -123.827,  &
      -122.755, -122.742, -123.242, -123.222, -121.903, -118.894, -119.297,  &
      -119.799, -118.64, -119.762, -115.369, -114.634, -114.491, -116.103,  &
      -115.683, -115.624, -119.791, -114.113, -117.809, -119.177, -113.027,  &
      -111.256, -108.692, -111.145, -113.034, -112.61, -114.241, -111.965,  &
      -112.344, -112.751, -112.649, -111.216, -106.654, -104.769, -111.392,  &
      -114.178, -107.631, -109.727, -112.106, -114.42, -108.822, -109.46,  &
      -115.597, -110.597, -114.118, -105.868, -114.165, -114.193, -105.216,  &
      -111.898, -104.215, -114.375, -105.658, -92.17, -92.566, -90.55, -92.949,  &
      -91.954, -91.29, -93.753, -89.896, -91.963, -92.206, -89.721, -92.236,  &
      -92.06, -92.403, -91.507, -93.481, -93.356, -91.071, -92.5, -92.434,  &
      -91.592, -93.293, -91.57, -90.168, -90.42, -90.78, -90.593, -93.079,  &
      -91.04, -93.03, -91.696, -90.136, -92.168, -92.685, -92.745, -92.31,  &
      -92.197, -92.689, -93.427, -91.217, -93.301, -91.577, -117.692, -122.383,  &
      -121.834, -120.125, -121.252, -120.387, -118.427, -120.449, -119.055,  &
      -120.412, -122.771, -120.718, -122.629, -96.717, -99.353, -98.691, -98.265,  &
      -97.178, -96.013, -97.319, -97.704, -96.418, -94.774, -98.65, -96.902,  &
      -95.542, -98.0, -95.715, -96.491, -99.0, -95.676, -95.862, -96.786,  &
      -97.132, -97.996, -96.454, -99.499, -98.008, -97.982, -99.029, -94.83,  &
      -97.469, -101.499, -97.199, -95.586, -94.647, -96.021, -99.109, -96.446,  &
      -96.407, -95.544, -94.852, -97.951, -98.545, -97.623, -95.792, -96.802,  &
      -99.517, -96.368, -97.972, -94.896, -94.629, -95.443, -99.003, -97.52,  &
      -95.657, -96.325, -97.778, -95.993, -97.265, -96.359, -97.301, -97.122,  &
      -94.672, -95.335, -97.398, -94.832, -99.651, -96.711, -97.001, -96.049,  &
      -95.142, -97.145, -94.65, -96.997, -95.012, -97.319, -96.187, -97.719,  &
      -95.216, -95.413, -98.323, -92.435, -90.257, -93.741, -93.494, -92.088,  &
      -93.346, -92.246, -91.386, -91.544, -93.129, -90.611, -91.492, -92.682,  &
      -92.211, -91.229, -91.999, -92.297, -91.807, -92.737, -91.855, -93.982,  &
      -90.001, -90.71, -93.484, -92.089, -91.208, -90.943, -92.312, -93.596,  &
      -94.0, -92.838, -92.682, -91.744, -88.58, -88.514, -89.983, -90.505,  &
      -88.588, -90.48, -90.108, -89.562, -90.076, -90.62, -90.763, -89.876,  &
      -88.456, -88.463, -88.576, -90.38, -89.389, -89.868, -89.506, -88.418,  &
      -88.662, -91.101, -90.223, -89.841, -89.452, -89.482, -90.416, -90.87,  &
      -89.476, -89.017, -90.668, -90.347, -90.384, -89.622, -89.226, -90.913,  &
      -89.09, -88.615, -90.493, -88.571, -89.751, -90.294, -90.238, -88.789,  &
      -90.523, -89.672, -89.079, -89.183, -89.598, -88.688, -89.237, -89.722,  &
      -89.048, -90.44, -88.972, -90.562, -88.721, -89.993, -98.432, -98.725,  &
      -96.507, -95.347, -99.462, -90.331, -87.464, -92.382, -89.179, -88.56,  &
      -91.519, -90.911, -92.451, -89.779, -91.873, -88.871, -89.084, -88.969,  &
      -90.873, -91.517, -90.721, -88.081, -89.406, -88.306, -89.032, -91.725,  &
      -88.174, -88.795, -89.06, -88.72, -90.153, -92.323, -88.425, -91.601,  &
      -89.102, -88.578, -92.497, -89.331, -88.524, -88.895, -88.183, -91.52,  &
      -88.656, -92.782, -88.124, -90.26, -89.081, -88.79, -88.714, -87.997,  &
      -87.526, -88.112, -91.337, -91.122, -89.82, -88.567, -88.949, -90.725,  &
      -89.554, -89.666, -87.755, -87.665, -89.082, -90.219, -90.107, -88.571,  &
      -89.809, -90.375, -91.947, -89.759, -88.611, -93.767, -89.671, -89.753,  &
      -88.483, -88.798, -92.575, -87.907, -88.162, -88.755, -87.809, -89.419,  &
      -92.707, -88.653, -87.772, -90.506, -88.003, -89.524, -91.194, -89.755,  &
      -88.875, -90.389, -88.817, -89.652, -88.664, -88.682, -89.191, -89.754,  &
      -90.453, -106.003, -106.792, -104.464, -108.061, -108.168, -108.046,  &
      -104.296, -106.444, -103.337, -107.786, -106.244, -105.976, -106.684,  &
      -106.142, -103.173, -108.284, -108.844, -107.912, -103.202, -106.092,  &
      -108.45, -106.894, -105.27, -106.335, -106.794, -103.377, -106.112,  &
      -103.366, -104.468, -104.6, -105.7, -106.151, -104.706, -106.37, -108.717,  &
      -108.312, -106.929, -105.643, -107.299, -103.744, -106.036, -106.702,  &
      -106.223, -108.874, -93.094, -94.151, -91.601, -91.686, -91.927, -93.589,  &
      -89.987, -93.945, -91.206, -92.876, -91.56, -93.52, -92.539, -90.633,  &
      -91.99, -94.374, -91.456, -92.804, -88.258, -88.003, -90.03, -89.502,  &
      -91.77, -90.404, -88.879, -92.657, -88.374, -88.349, -88.63, -87.86,  &
      -92.691, -90.861, -91.919, -90.964, -89.607, -87.428, -90.537, -89.755,  &
      -88.14, -90.91, -88.61, -89.008, -88.762, -89.191, -88.765, -89.743,  &
      -89.307, -88.416, -88.777, -88.734, -89.925, -88.182, -84.094, -84.807,  &
      -85.89, -84.696, -83.056, -83.513, -83.925, -83.42, -83.026, -85.367,  &
      -83.972, -85.262, -86.583, -86.369, -85.525, -83.936, -85.048, -84.316,  &
      -85.508, -83.437, -85.571, -85.286, -84.875, -84.527, -84.042, -84.919,  &
      -85.041, -85.687, -85.965, -83.797, -85.753, -86.228, -86.146, -83.684,  &
      -84.037, -83.563, -84.699, -86.062, -87.135, -83.884, -84.144, -83.761,  &
      -86.009, -84.727, -84.509, -83.524, -85.974, -84.753, -85.305, -85.549,  &
      -84.828, -86.427, -85.35, -84.683, -86.213, -91.351, -91.51, -92.726,  &
      -91.977, -94.356, -92.453, -90.812, -94.487, -92.415, -93.453, -94.31,  &
      -91.815, -93.16, -92.064, -90.698, -93.634, -93.189, -93.068, -90.785,  &
      -91.296, -92.67, -91.915, -91.422, -93.268, -92.851, -90.185, -90.794,  &
      -94.267, -91.831, -92.784, -92.436, -93.877, -91.295, -90.001, -93.875,  &
      -90.588, -93.761, -90.217, -92.118, -91.005, -94.332, -93.401, -93.198,  &
      -91.803, -92.426, -94.628, -91.573, -94.188, -91.565, -90.552, -94.116,  &
      -90.999, -92.106, -90.828, -83.451, -84.289, -82.498, -84.293, -83.675,  &
      -83.567, -85.051, -82.245, -84.63, -84.188, -82.377, -82.287, -84.958,  &
      -85.206, -81.609, -81.285, -84.235, -84.987, -84.233, -85.143, -84.962,  &
      -85.304, -85.445, -81.954, -83.425, -83.781, -83.37, -83.495, -83.816,  &
      -83.635, -84.807, -84.012, -85.073, -81.441, -84.454, -84.905, -83.66,  &
      -88.634, -84.803, -83.092, -85.113, -88.661, -87.733, -84.57, -85.824,  &
      -85.195, -84.499, -84.776, -83.381, -88.473, -85.411, -86.472, -86.352,  &
      -86.323, -87.472, -85.008, -86.971, -85.487, -84.41, -83.705, -83.49,  &
      -84.817, -86.681, -86.342, -85.816, -85.528, -85.735, -84.227, -85.915,  &
      -86.333, -84.274, -85.006, -82.565, -84.956, -82.779, -83.846, -84.151,  &
      -84.742, -84.582, -82.851, -84.456, -84.447, -86.401, -86.295, -84.006,  &
      -85.726, -85.467, -85.659, -83.921, -85.748, -83.605, -85.663, -86.397,  &
      -84.313, -94.04, -92.821, -94.257, -93.718, -91.3, -95.039, -90.453,  &
      -93.926, -91.272, -93.505, -94.902, -91.787, -92.895, -93.328, -92.714,  &
      -95.577, -95.057, -93.745, -93.493, -90.28, -92.134, -94.386, -90.692,  &
      -91.812, -95.381, -93.892, -90.569, -90.802, -91.141, -93.922, -94.701,  &
      -94.864, -82.936, -83.0, -83.21, -83.412, -82.907, -84.522, -83.295,  &
      -82.036, -83.98, -83.915, -83.997, -81.968, -84.859, -83.57, -83.2,  &
      -82.341, -82.958, -83.5, -82.625, -81.69, -82.779, -83.99, -84.496,  &
      -83.648, -81.932, -85.305, -85.155, -83.092, -83.239, -84.209, -82.418,  &
      -83.692, -83.8, -82.926, -83.52, -84.647, -82.085, -83.311, -81.961,  &
      -83.762, -84.107, -83.708, -83.836, -83.267, -84.422, -83.265, -84.182,  &
      -83.587, -82.152, -81.256, -85.154, -85.29, -83.155, -81.719, -81.409,  &
      -82.844, -81.341, -83.749, -82.614, -83.009, -81.334, -81.87, -85.373,  &
      -82.375, -81.661, -83.859, -84.358, -84.016, -82.541, -83.575, -83.36,  &
      -85.526, -80.884, -83.759, -83.393, -82.449, -83.812, -83.789, -82.779,  &
      -82.478, -82.037, -83.806, -82.742, -85.023, -108.785, -107.269, -108.459,  &
      -109.322, -107.001, -108.236, -104.251, -72.331, -70.789, -71.822, -73.382,  &
      -72.642, -73.33, -72.09, -70.128, -71.757, -71.048, -73.243, -72.169,  &
      -73.336, -71.745, -70.204, -72.64, -70.624, -72.312, -81.128, -84.623,  &
      -82.872, -83.966, -82.52, -84.161, -82.254, -82.555, -84.396, -81.648,  &
      -81.797, -84.425, -82.227, -81.551, -84.292, -83.693, -82.715, -83.17,  &
      -82.242, -81.804, -84.087, -84.778, -84.603, -84.289, -83.291, -82.99,  &
      -83.937, -83.65, -84.457, -80.89, -82.834, -81.942, -82.69, -84.232,  &
      -83.952, -83.225, -83.298, -83.773, -84.624, -84.5, -84.24, -83.476,  &
      -84.166, -83.045, -82.247, -83.357, -81.769, -83.569, -82.756, -83.862,  &
      -81.991, -83.91, -81.005, -82.122, -90.415, -90.769, -90.276, -89.281,  &
      -88.321, -89.76, -90.447, -87.641, -88.953, -89.098, -88.317, -89.556,  &
      -90.526, -89.29, -89.201, -90.086, -89.704, -92.007, -93.656, -94.237,  &
      -91.383, -93.616, -95.807, -92.749, -93.223, -95.341, -94.248, -93.61,  &
      -91.921, -93.597, -91.671, -93.297, -94.407, -91.427, -93.124, -96.2,  &
      -91.47, -90.694, -92.97, -93.266, -95.912, -91.201, -91.584, -91.444,  &
      -91.141, -93.477, -92.336, -93.095, -91.939, -96.295, -96.129, -96.083,  &
      -92.827, -93.795, -92.691, -92.479, -92.958, -94.145, -93.736, -95.245,  &
      -96.315, -90.189, -95.864, -95.388, -95.762, -96.196, -96.567, -95.202,  &
      -95.173, -95.27, -93.605, -92.6, -91.145, -92.048, -91.722, -92.499,  &
      -91.494, -92.534, -93.858, -91.275, -92.037, -91.057, -94.033, -77.01,  &
      -80.246, -78.421, -79.872, -83.063, -78.568, -79.807, -78.072, -81.684,  &
      -81.738, -82.832, -78.775, -77.956, -79.611, -78.804, -81.102, -81.432,  &
      -78.375, -80.737, -83.258, -79.531, -78.72, -79.144, -79.829, -104.983,  &
      -107.98, -80.675, -81.288, -81.429, -80.309, -81.993, -77.924, -80.49,  &
      -80.679, -79.888, -80.246, -80.853, -80.083, -80.897, -79.712, -80.502,  &
      -82.079, -81.861, -81.502, -82.092, -81.393, -78.979, -80.037, -80.834,  &
      -80.882, -81.666, -80.951, -81.711, -79.162, -80.067, -82.28, -81.777,  &
      -81.804, -81.278, -77.847, -81.678, -81.382, -80.864, -80.777, -81.614,  &
      -80.522, -80.926, -80.315, -101.791, -100.971, -98.886, -102.832, -97.432,  &
      -97.401, -98.74, -100.711, -101.358, -101.387, -100.011, -98.039, -103.669,  &
      -97.251, -97.066, -95.167, -96.99, -95.207, -94.959, -94.755, -98.127,  &
      -95.76, -95.489, -97.149, -101.071, -94.868, -97.68, -95.006, -100.056,  &
      -96.905, -98.244, -96.241, -95.122, -96.306, -94.724, -94.648, -100.931,  &
      -95.259, -94.858, -101.731, -98.821, -99.373, -97.451, -95.563, -97.216,  &
      -89.294, -89.9, -89.445, -88.193, -91.152, -88.01, -89.176, -88.374,  &
      -88.215, -89.859, -89.079, -88.991, -87.723, -89.115, -89.104, -88.793,  &
      -89.52, -88.906, -89.261, -88.48, -88.579, -88.466, -90.025, -89.044,  &
      -89.293, -88.529, -88.406, -88.508, -89.682, -90.45, -90.441, -90.173,  &
      -88.788, -88.393, -89.831, -88.024, -89.424, -88.545, -88.611, -88.671,  &
      -90.081, -88.99, -89.712, -89.51, -89.946, -87.691, -90.292, -90.365,  &
      -88.942, -87.958, -89.956, -88.695, -87.769, -89.841, -88.772, -89.416,  &
      -89.685, -89.376, -88.557, -90.724, -88.452, -88.63, -88.732, -87.715,  &
      -89.827, -88.419, -89.138, -89.389, -88.748, -90.109, -87.72, -90.663,  &
      -88.604, -88.473, -89.992, -87.795, -89.446, -90.78, -88.97, -89.369,  &
      -89.405, -89.714, -88.207, -89.359, -88.128, -89.353, -88.887, -89.1,  &
      -87.722, -89.628, -88.118, -76.643, -76.291, -78.663, -80.89, -77.693,  &
      -76.986, -79.133, -77.643, -79.261, -79.111, -81.985, -83.45, -81.433,  &
      -78.094, -80.036, -77.486, -77.468, -77.723, -76.952, -78.496, -81.81,  &
      -80.144, -78.344, -77.561, -81.515, -75.813, -77.728, -77.814, -81.095,  &
      -82.253, -79.595, -78.863, -81.317, -80.445, -78.319, -79.091, -81.236,  &
      -75.783, -82.086, -80.005, -80.584, -77.104, -80.693, -78.11, -77.129,  &
      -79.146, -77.172, -81.266, -78.234, -78.623, -79.217, -82.536, -79.523,  &
      -79.192, -85.031, -76.781, -81.898, -78.931, -80.728, -79.711, -79.204,  &
      -81.515, -79.711, -85.075, -77.642, -85.706, -77.71, -81.863, -79.831,  &
      -82.064, -78.025, -82.142, -79.014, -82.114, -78.143, -84.891, -79.003,  &
      -85.569, -79.245, -80.96, -79.618, -84.393, -81.611, -81.58, -79.502,  &
      -86.636, -78.452, -81.603, -98.789, -95.758, -101.359, -97.99, -95.751,  &
      -95.418, -96.891, -94.965, -98.136, -99.16, -95.337, -94.965, -100.976,  &
      -97.686, -94.695, -98.225, -97.704, -96.688, -96.657, -95.701, -97.39,  &
      -99.904, -95.843, -94.983, -95.3, -94.89, -95.297, -99.337, -94.744,  &
      -98.767, -97.142, -98.874, -95.816, -94.962, -96.08, -97.676, -100.925,  &
      -94.84, -95.102, -95.812, -101.4, -96.329, -97.424, -97.589, -97.029,  &
      -89.701, -87.078, -84.689, -89.879, -89.155, -89.037, -82.361, -89.302,  &
      -88.14, -85.986, -84.948, -87.158, -85.663, -89.719, -85.097, -83.493,  &
      -85.105, -87.442, -85.427, -89.009, -89.434, -82.488, -84.544, -84.922,  &
      -87.172, -86.609, -82.939, -89.42, -84.707, -88.722, -87.596, -88.936,  &
      -88.928, -85.652, -82.574, -82.82, -84.39, -86.065, -84.236, -87.393,  &
      -86.405, -86.848, -88.43, -85.351, -88.536, -89.736, -87.822, -89.236,  &
      -89.873, -89.413, -90.847, -88.671, -89.497, -91.42, -88.197, -90.018,  &
      -87.777, -89.123, -89.251, -90.582, -88.054, -90.919, -89.064, -88.844,  &
      -90.018, -89.726, -89.773, -89.811, -89.677, -89.77, -88.879, -88.633,  &
      -89.361, -89.702, -88.294, -89.138, -89.784, -90.178, -87.767, -88.983,  &
      -90.42, -88.408, -88.492, -112.651, -109.494, -111.069, -113.152, -112.596,  &
      -112.029, -111.599, -112.504, -111.837, -111.501, -113.44, -111.3,  &
      -112.557, -111.949, -111.65, -109.57, -111.7, -111.47, -111.845, -112.162,  &
      -111.559, -112.858, -110.88, -112.014, -112.105, -110.039, -113.693,  &
      -112.129, -111.853, -112.323, -111.623, -112.33, -112.232, -109.612,  &
      -92.276, -93.799, -92.689, -94.056, -93.448, -92.781, -91.232, -93.332,  &
      -93.104, -94.217, -93.118, -94.358, -92.595, -92.788, -94.26, -93.513,  &
      -94.395, -89.682, -93.955, -77.41, -83.14, -79.104, -82.628, -82.094,  &
      -86.177, -77.245, -81.368, -78.917, -80.611, -77.596, -81.56, -81.198,  &
      -81.832, -79.921, -87.136, -80.141, -81.709, -78.012, -81.616, -78.118,  &
      -82.507, -77.125, -81.607, -78.411, -85.531, -79.412, -78.747, -77.107,  &
      -84.436, -78.083, -82.616, -77.997, -82.573, -76.967, -81.486, -80.486,  &
      -80.695, -80.493, -81.926, -81.978, -82.981, -80.256, -80.748, -82.064,  &
      -81.813, -81.523, -81.47, -82.101, -81.893, -82.385, -82.726, -82.078,  &
      -82.153, -81.447, -82.004, -83.015, -82.176, -83.437, -81.125, -85.271,  &
      -82.269, -80.528, -81.123, -81.861, -82.304, -82.294, -82.355, -80.907,  &
      -81.601, -81.909, -80.696, -81.725, -80.845, -81.28, -86.025, -85.581,  &
      -83.63, -81.511, -81.52, -85.319, -80.457, -84.627, -82.527, -82.208,  &
      -81.393, -85.839, -84.406, -86.119, -88.921, -88.81, -88.785, -85.305,  &
      -83.54, -81.84, -87.229, -86.506, -87.021, -83.283, -83.644, -84.105,  &
      -89.537, -84.573, -88.358, -87.084, -87.075, -89.586, -83.093, -88.331,  &
      -88.629, -83.624, -86.494, -85.855, -85.517, -86.929, -86.984, -83.705,  &
      -84.545, -88.951, -86.266, -89.098, -87.858, -83.314, -86.165, -86.095,  &
      -98.536, -103.867, -103.124, -96.598, -96.825, -96.604, -96.737, -96.719,  &
      -103.498, -98.263, -103.784, -97.14, -96.666, -98.078, -100.459, -101.242,  &
      -100.401, -102.563, -103.394, -96.84, -103.917, -103.569, -96.846, -96.96,  &
      -97.255, -99.877, -97.432, -85.805, -85.125, -87.304, -85.16, -85.339,  &
      -86.558, -84.976, -87.324, -86.95, -86.641, -85.204, -87.288, -86.173,  &
      -86.064, -84.89, -85.214, -85.696, -88.656, -87.432, -85.543, -85.999,  &
      -85.208, -86.155, -87.405, -92.15, -89.672, -89.379, -93.586, -93.802,  &
      -92.435, -123.16, -91.42, -90.585, -123.967, -122.881, -90.012, -89.401,  &
      -92.599, -117.856, -90.709, -124.437, -94.301, -121.396, -90.606, -119.721,  &
      -92.701, -124.324, -119.1, -93.205, -122.728, -92.269, -123.195, -90.31,  &
      -124.339, -92.002, -124.22, -123.431, -91.421, -94.38, -89.774, -93.742,  &
      -90.577, -123.094, -90.659, -123.034, -92.353, -123.349, -122.353, -94.605,  &
      -123.23, -94.379, -90.082, -124.135, -93.459, -92.602, -124.433, -123.447,  &
      -94.299, -123.18, -92.693, -119.377, -94.459, -93.901, -91.086, -119.532,  &
      -123.223, -121.842, -118.117, -92.505, -120.367, -90.007, -121.554,  &
      -93.221, -122.933, -92.943, -124.053, -94.895, -123.254, -91.95, -92.482,  &
      -121.187, -93.946, -122.988, -91.519, -122.611, -92.286, -93.836, -94.415,  &
      -94.391, -123.25, -89.605, -122.81, -122.131, -123.035, -86.29, -82.746,  &
      -80.551, -81.563, -82.645, -82.139, -82.575, -84.446, -82.851, -80.889,  &
      -82.873, -81.838, -81.101, -82.464, -81.877, -84.261, -81.543, -81.639,  &
      -82.288, -102.902, -96.389, -95.858, -98.025, -96.794, -96.165, -99.661,  &
      -98.021, -103.026, -97.398, -100.001, -96.99, -97.139, -97.192, -95.614,  &
      -96.596, -100.174, -98.474, -98.467, -99.403, -99.179, -99.768, -96.807,  &
      -100.653, -98.971, -95.888, -97.467, -100.852, -101.749, -98.666, -95.909,  &
      -97.103, -103.726, -97.113, -103.0, -100.582, -96.636, -96.54, -97.037,  &
      -96.725, -97.611, -94.594, -93.419, -95.45, -94.157, -93.029, -93.901,  &
      -93.791, -94.949, -95.618, -94.116, -94.312, -93.91, -92.678, -91.508,  &
      -93.274, -92.923, -92.2, -92.906, -92.491, -94.334, -94.476, -96.632,  &
      -93.984, -93.812, -95.879, -92.877, -93.364, -91.879, -94.493, -96.938,  &
      -86.971, -84.977, -86.711, -87.237, -85.22, -85.869, -85.661, -87.587,  &
      -85.356, -86.595, -86.88, -85.518, -86.013, -86.167, -84.83, -85.394,  &
      -87.218, -86.73, -86.972, -85.544, -86.553, -87.002, -85.308, -85.561,  &
      -86.636, -86.233, -86.999, -85.437, -84.957, -86.503, -85.611, -87.19,  &
      -86.414, -86.933, -87.45, -85.775, -86.466, -85.741, -85.557, -86.496,  &
      -86.817, -87.928, -85.522, -86.045, -86.563, -85.424, -85.796, -85.705,  &
      -85.746, -87.364, -85.18, -86.499, -86.128, -86.381, -85.001, -87.617,  &
      -87.171, -85.005, -86.242, -87.292, -85.479, -86.142, -85.832, -85.935,  &
      -85.876, -86.238, -87.239, -87.426, -85.798, -87.484, -86.061, -84.835,  &
      -85.512, -87.547, -85.856, -86.504, -86.001, -87.209, -86.924, -86.615,  &
      -84.998, -72.626, -73.259, -73.312, -73.285, -72.033, -73.191, -73.17,  &
      -72.243, -72.677, -94.036, -124.082, -93.975, -92.716, -91.522, -117.013,  &
      -122.496, -90.902, -118.871, -91.537, -120.887, -89.899, -94.803, -94.28,  &
      -121.231, -90.483, -124.179, -123.444, -122.923, -89.711, -90.795,  &
      -123.129, -93.991, -93.068, -122.303, -91.799, -91.007, -123.957, -90.064,  &
      -122.834, -91.644, -123.499, -91.565, -122.807, -94.848, -122.821,  &
      -123.362, -93.311, -89.636, -94.574, -122.79, -93.507, -123.898, -91.271,  &
      -123.95, -92.798, -123.375, -93.63, -123.372, -124.092, -91.023, -122.917,  &
      -91.04, -91.507, -92.758, -93.802, -91.179, -93.404, -91.049, -91.912,  &
      -93.581, -93.445, -93.533, -91.05, -82.407, -81.333, -82.802, -79.586,  &
      -81.053, -81.408, -81.582, -80.81, -82.537, -79.729, -80.275, -80.646,  &
      -80.28, -79.971, -81.887, -81.251, -81.919, -81.247, -81.377, -81.159,  &
      -79.4, -81.955, -79.959, -81.717, -79.349, -82.854, -93.4, -96.121, -93.02,  &
      -94.186, -97.131, -93.633, -95.57, -92.904, -92.963, -94.422, -93.465,  &
      -95.014, -93.655, -92.775, -92.309, -94.239, -93.922, -92.91, -94.551,  &
      -94.393, -94.881, -93.449, -96.232, -94.071, -95.837, -94.83, -93.663,  &
      -95.741, -93.593, -93.844, -93.988, -92.803, -93.323, -95.934, -94.972,  &
      -93.609, -94.507, -93.022, -93.212, -93.94, -93.276, -95.079, -95.596,  &
      -92.984, -92.666, -96.341, -92.182, -93.604, -92.638, -95.141, -92.558,  &
      -93.766, -95.799, -92.99, -92.079, -94.333, -93.39, -94.646, -93.987,  &
      -94.979, -94.761, -94.812, -92.509, -96.212, -91.699, -92.619, -93.824,  &
      -95.163, -96.63, -93.544, -93.861, -95.094, -95.158, -91.761, -95.643,  &
      -93.648, -92.692, -106.728, -106.486, -104.894, -109.117, -105.408,  &
      -111.003, -105.575, -109.53, -110.813, -110.562, -108.761, -105.697,  &
      -104.256, -73.068, -73.116, -72.034, -72.546, -73.133, -73.273, -72.773,  &
      -83.842, -81.854, -81.176, -82.368, -84.326, -82.353, -80.969, -83.031,  &
      -82.174, -82.626, -81.193, -83.782, -82.884, -84.1, -84.005, -83.924,  &
      -81.462, -83.691, -84.594, -83.004, -81.008, -81.562, -81.683, -81.634,  &
      -83.401, -81.111, -83.825, -84.599, -81.265, -83.088, -82.962, -82.069,  &
      -83.033, -84.648, -80.723, -83.246, -80.698, -81.907, -84.364, -82.114,  &
      -81.783, -83.204, -84.438, -84.422, -84.371, -84.026, -80.574, -84.661,  &
      -83.699, -83.461, -83.169, -82.834, -81.153, -80.977, -83.393, -83.918,  &
      -82.106, -83.406, -84.647, -84.786, -83.638, -82.663, -83.801, -80.791,  &
      -82.709, -83.639, -82.158, -84.704, -82.671, -84.217, -80.813, -82.034,  &
      -82.441, -83.5, -82.446, -83.004, -81.897, -81.223, -82.661, -83.184,  &
      -83.4, -81.158, -84.496, -81.927, -89.592, -82.256, -81.134, -81.111,  &
      -80.178, -80.983, -82.415, -79.842, -79.794, -81.406, -80.842, -82.071,  &
      -80.243, -79.468, -82.356, -79.304, -81.658, -80.943, -80.425, -79.187,  &
      -81.001, -81.188, -81.792, -83.093, -82.198, -80.521, -81.006, -81.689,  &
      -80.722, -81.103, -82.055, -81.267, -80.375, -78.497, -76.415, -78.535,  &
      -77.85, -79.285, -76.664, -77.237, -78.807, -79.105, -80.431, -80.069,  &
      -80.072, -77.801, -79.447, -78.49, -79.663, -78.653, -78.54, -78.819,  &
      -76.561, -78.771, -80.158, -80.311, -75.904, -78.299, -80.365, -78.391,  &
      -79.994, -79.904, -80.419, -80.125, -77.279, -77.252, -76.085, -75.338,  &
      -78.374, -78.086, -79.214, -77.369, -75.829, -78.986, -78.825, -79.584,  &
      -75.799, -77.059, -76.676, -76.531, -77.676, -79.25, -77.114, -77.522,  &
      -76.77, -77.097, -78.339, -79.929, -80.324, -80.264/)
!
      lon2_regions = (/-69.735, -68.614, -68.197, -68.982, -69.787, -67.23, -69.055, -67.984,  &
      -70.763, -68.396, -70.128, -67.82, -70.429, -70.044, -70.152, -68.681,  &
      -69.359, -70.087, -70.592, -67.972, -69.082, -70.524, -70.694, -69.676,  &
      -70.499, -69.576, -72.973, -72.302, -73.246, -72.231, -71.884, -72.43,  &
      -73.179, -72.407, -72.343, -72.27, -71.725, -72.279, -72.247, -73.038,  &
      -72.947, -72.134, -71.563, -112.834, -112.316, -116.1, -116.294, -114.745,  &
      -113.69, -116.723, -116.445, -114.594, -114.696, -116.103, -114.248,  &
      -116.911, -111.9, -114.492, -116.073, -114.344, -116.398, -116.913,  &
      -116.959, -115.65, -115.836, -78.995, -77.022, -77.352, -76.933, -79.961,  &
      -76.813, -79.768, -76.858, -75.504, -77.162, -75.277, -77.832, -76.706,  &
      -78.816, -80.205, -77.122, -80.321, -79.8, -78.697, -79.659, -76.045,  &
      -78.639, -78.194, -76.368, -79.248, -74.828, -78.599, -75.521, -76.131,  &
      -78.946, -76.094, -75.741, -78.867, -78.709, -78.369, -78.51, -75.02,  &
      -75.453, -76.387, -76.12, -77.401, -75.356, -80.031, -78.995, -77.729,  &
      -76.566, -76.746, -75.575, -75.861, -79.637, -76.431, -78.699, -75.915,  &
      -78.193, -79.829, -79.545, -79.085, -80.131, -76.848, -76.509, -76.522,  &
      -79.242, -101.837, -99.671, -97.592, -98.036, -103.63, -97.188, -101.671,  &
      -102.501, -96.531, -95.786, -94.134, -96.97, -97.522, -99.939, -97.419,  &
      -97.254, -95.883, -93.945, -97.682, -96.243, -97.974, -101.448, -101.361,  &
      -97.783, -98.687, -96.143, -101.35, -79.268, -77.754, -79.487, -77.947,  &
      -82.73, -80.309, -77.985, -78.76, -79.333, -78.41, -78.444, -79.779,  &
      -82.417, -76.957, -79.956, -78.11, -78.659, -77.942, -78.572, -77.494,  &
      -78.363, -76.885, -77.396, -78.073, -80.814, -76.493, -78.782, -78.809,  &
      -77.15, -77.503, -78.288, -77.729, -77.799, -82.017, -79.387, -78.414,  &
      -79.076, -81.376, -79.773, -82.525, -78.083, -80.679, -80.625, -77.666,  &
      -81.73, -77.223, -79.793, -79.85, -78.35, -76.548, -78.876, -78.025,  &
      -78.845, -78.329, -78.972, -76.85, -81.423, -78.413, -75.92, -76.791,  &
      -78.9, -76.637, -78.084, -78.445, -81.032, -116.454, -117.021, -116.893,  &
      -116.178, -115.913, -112.369, -111.847, -116.869, -111.738, -111.844,  &
      -113.656, -111.628, -116.554, -113.876, -116.492, -112.111, -111.576,  &
      -116.468, -114.355, -116.943, -114.689, -76.036, -76.182, -77.585, -76.009,  &
      -76.041, -76.512, -76.02, -76.749, -75.824, -78.702, -76.96, -75.797,  &
      -76.031, -77.3, -75.744, -77.222, -76.959, -76.67, -77.562, -78.956,  &
      -76.622, -76.377, -76.454, -76.865, -79.365, -76.634, -75.53, -77.388,  &
      -76.515, -75.669, -76.333, -76.49, -77.742, -77.151, -77.377, -76.806,  &
      -77.459, -78.962, -76.857, -104.845, -105.84, -106.797, -106.981, -108.016,  &
      -107.582, -105.131, -105.997, -103.591, -106.104, -102.242, -105.139,  &
      -107.2, -107.916, -104.578, -108.524, -107.506, -108.029, -104.663,  &
      -107.801, -106.796, -104.697, -106.448, -105.487, -105.235, -104.912,  &
      -105.089, -104.874, -97.819, -100.4, -99.323, -95.554, -98.878, -96.361,  &
      -97.732, -95.94, -102.244, -97.375, -98.909, -98.532, -98.202, -101.99,  &
      -96.677, -96.959, -100.371, -95.844, -101.878, -98.246, -99.818, -94.312,  &
      -98.837, -94.154, -100.191, -98.962, -95.026, -97.296, -95.062, -97.563,  &
      -99.455, -99.41, -96.206, -100.848, -96.533, -98.581, -98.892, -95.881,  &
      -95.327, -97.203, -96.415, -99.22, -102.335, -95.429, -99.809, -97.264,  &
      -94.608, -102.495, -96.313, -94.847, -97.568, -95.276, -100.762, -96.933,  &
      -97.175, -102.811, -98.847, -94.761, -99.158, -102.297, -98.325, -101.946,  &
      -96.319, -100.402, -98.811, -96.63, -96.245, -98.907, -97.308, -97.561,  &
      -95.422, -96.572, -106.138, -96.134, -98.129, -96.329, -98.135, -101.32,  &
      -96.379, -102.846, -98.835, -102.692, -101.559, -97.086, -94.767, -97.694,  &
      -96.892, -94.92, -97.412, -98.556, -76.675, -86.124, -85.918, -86.444,  &
      -85.716, -86.419, -86.823, -87.471, -85.337, -87.749, -86.482, -87.112,  &
      -87.033, -85.588, -104.748, -103.768, -105.781, -107.255, -108.339,  &
      -104.635, -106.911, -106.897, -104.832, -105.009, -103.504, -102.6,  &
      -103.189, -106.279, -104.71, -104.979, -106.11, -107.783, -107.504,  &
      -106.996, -104.458, -107.729, -103.683, -105.058, -105.972, -104.832,  &
      -107.632, -105.936, -106.784, -103.158, -104.471, -106.278, -104.768,  &
      -104.989, -104.963, -102.706, -83.768, -85.34, -86.856, -88.333, -84.236,  &
      -86.329, -87.759, -85.317, -85.125, -87.099, -84.028, -87.158, -85.25,  &
      -84.586, -82.894, -84.267, -84.731, -85.79, -87.351, -83.101, -83.716,  &
      -84.776, -86.548, -88.859, -84.515, -85.886, -82.878, -83.222, -84.818,  &
      -83.132, -85.724, -87.425, -85.878, -81.883, -83.94, -83.341, -84.549,  &
      -84.878, -85.228, -86.21, -84.381, -83.966, -82.544, -85.343, -85.338,  &
      -87.441, -83.73, -88.063, -88.576, -83.715, -83.619, -84.792, -97.671,  &
      -95.695, -95.28, -98.341, -96.055, -96.509, -96.071, -94.562, -98.088,  &
      -97.576, -99.714, -96.576, -98.663, -96.039, -94.752, -98.17, -102.355,  &
      -98.444, -97.081, -97.112, -99.122, -94.228, -98.32, -94.802, -95.494,  &
      -97.128, -98.63, -98.148, -95.209, -93.968, -95.444, -99.746, -97.282,  &
      -97.888, -96.28, -97.831, -103.068, -99.095, -94.806, -97.588, -98.403,  &
      -97.836, -97.207, -97.971, -96.856, -95.546, -95.536, -95.538, -95.307,  &
      -101.904, -98.16, -99.366, -102.311, -94.73, -95.368, -102.311, -94.909,  &
      -98.66, -97.647, -94.618, -101.76, -94.646, -97.605, -98.77, -97.87,  &
      -97.388, -96.47, -95.878, -95.724, -95.991, -97.508, -98.257, -96.872,  &
      -94.29, -97.81, -101.884, -96.448, -101.98, -95.428, -98.04, -102.846,  &
      -94.781, -94.931, -95.205, -102.707, -94.594, -96.064, -95.823, -94.399,  &
      -97.707, -87.243, -86.601, -86.586, -84.796, -86.795, -87.742, -86.893,  &
      -87.774, -85.286, -85.669, -85.081, -86.941, -87.813, -87.449, -87.626,  &
      -85.663, -85.823, -85.86, -88.291, -86.605, -87.588, -87.97, -86.737,  &
      -86.554, -85.323, -86.404, -87.877, -87.209, -87.126, -88.015, -87.302,  &
      -86.07, -87.259, -87.582, -86.444, -86.223, -85.571, -86.184, -86.948,  &
      -85.589, -86.865, -85.345, -87.681, -87.666, -85.995, -86.98, -85.629,  &
      -86.447, -86.995, -86.211, -86.064, -85.87, -87.717, -85.934, -87.374,  &
      -85.663, -85.667, -85.134, -86.168, -87.054, -112.853, -111.645, -112.272,  &
      -111.304, -110.273, -109.867, -114.509, -112.537, -114.5, -111.844,  &
      -111.671, -109.543, -112.425, -109.284, -112.956, -111.506, -110.756,  &
      -111.955, -109.511, -109.248, -111.542, -112.421, -111.489, -111.369,  &
      -109.029, -110.745, -110.13, -110.231, -113.959, -114.246, -83.369,  &
      -87.844, -83.901, -84.326, -88.288, -84.545, -86.993, -88.483, -82.757,  &
      -84.232, -82.412, -86.465, -82.812, -82.674, -87.842, -84.249, -86.851,  &
      -86.168, -85.143, -84.561, -84.629, -83.809, -86.705, -84.661, -84.125,  &
      -82.236, -84.537, -84.636, -84.119, -120.53, -120.531, -121.608, -122.051,  &
      -124.009, -120.536, -118.806, -121.016, -118.309, -120.111, -118.828,  &
      -116.975, -116.79, -118.382, -119.858, -115.508, -121.62, -117.926,  &
      -115.502, -122.555, -118.965, -121.065, -121.714, -121.747, -120.193,  &
      -122.586, -122.701, -122.995, -120.326, -120.942, -121.996, -121.799,  &
      -119.532, -122.141, -122.253, -124.139, -121.675, -119.214, -116.415,  &
      -121.587, -121.804, -120.609, -119.259, -120.892, -115.46, -120.598,  &
      -120.978, -121.966, -124.078, -121.922, -118.885, -120.435, -122.856,  &
      -123.764, -116.67, -124.093, -118.884, -119.54, -121.226, -97.575,  &
      -102.253, -98.746, -95.063, -101.193, -96.2, -95.59, -96.925, -100.919,  &
      -95.453, -99.077, -97.436, -97.604, -103.476, -100.784, -96.939, -94.932,  &
      -101.643, -98.464, -93.715, -97.158, -96.611, -101.364, -98.561, -95.964,  &
      -98.116, -104.329, -95.418, -97.76, -97.266, -99.46, -98.609, -97.534,  &
      -97.649, -96.979, -96.984, -95.117, -100.376, -98.024, -98.228, -97.16,  &
      -97.841, -98.696, -96.89, -96.122, -97.922, -102.627, -101.968, -96.479,  &
      -94.142, -97.486, -101.623, -97.135, -100.879, -100.629, -101.182, -97.659,  &
      -99.774, -98.179, -98.546, -95.55, -95.483, -95.681, -100.378, -97.376,  &
      -101.786, -97.383, -96.256, -97.303, -96.257, -94.887, -106.072, -95.31,  &
      -101.749, -95.176, -99.74, -95.618, -97.087, -99.264, -96.9, -97.07,  &
      -97.612, -97.084, -95.611, -95.888, -95.953, -96.046, -96.84, -98.424,  &
      -95.962, -111.763, -109.888, -111.163, -111.945, -114.027, -114.563,  &
      -110.891, -111.429, -114.276, -111.289, -111.425, -111.181, -112.236,  &
      -114.19, -110.964, -109.619, -110.961, -109.358, -110.436, -114.752,  &
      -110.617, -111.753, -109.994, -110.223, -110.067, -114.624, -111.092,  &
      -111.214, -110.721, -110.688, -111.749, -112.313, -109.942, -112.702,  &
      -109.815, -112.161, -109.036, -110.673, -114.376, -75.55, -75.441, -75.356,  &
      -75.534, -75.069, -75.12, -75.603, -75.339, -75.213, -75.295, -75.049,  &
      -75.052, -74.657, -75.487, -75.064, -74.353, -75.019, -75.157, -74.446,  &
      -75.024, -74.418, -74.721, -74.594, -74.435, -75.011, -75.049, -74.296,  &
      -74.689, -73.565, -74.557, -75.453, -74.568, -74.438, -74.355, -74.786,  &
      -74.921, -74.906, -75.305, -71.595, -75.995, -78.473, -73.519, -78.163,  &
      -77.747, -74.122, -78.368, -78.247, -76.503, -121.529, -121.427, -120.955,  &
      -121.224, -121.638, -120.558, -122.962, -120.985, -122.377, -119.583,  &
      -116.858, -122.52, -120.831, -121.314, -115.363, -120.083, -119.923,  &
      -116.103, -120.925, -120.747, -122.815, -120.042, -121.112, -117.153,  &
      -118.454, -117.809, -120.976, -122.635, -117.144, -121.164, -117.916,  &
      -119.869, -119.06, -121.645, -121.696, -121.205, -120.426, -117.486,  &
      -120.804, -122.084, -119.205, -120.01, -118.946, -121.09, -116.044,  &
      -120.369, -120.408, -117.472, -120.778, -118.145, -120.805, -121.533,  &
      -122.294, -117.051, -122.238, -121.002, -120.468, -115.913, -119.604,  &
      -119.304, -122.15, -119.255, -121.458, -119.082, -121.563, -119.516,  &
      -121.099, -122.57, -117.499, -120.551, -120.304, -121.544, -119.139,  &
      -118.941, -120.454, -116.753, -120.813, -121.062, -122.184, -122.267,  &
      -119.366, -119.65, -119.102, -117.624, -124.089, -121.674, -119.845,  &
      -94.357, -95.262, -99.94, -98.091, -94.372, -97.127, -99.239, -77.672,  &
      -78.116, -77.285, -73.595, -75.731, -78.575, -77.89, -78.52, -75.118,  &
      -73.853, -75.836, -74.249, -75.855, -77.868, -77.12, -74.464, -73.915,  &
      -77.63, -73.807, -77.009, -76.071, -73.791, -77.671, -74.903, -76.272,  &
      -79.295, -78.554, -74.359, -76.745, -74.555, -77.778, -76.745, -73.559,  &
      -74.245, -75.438, -78.914, -73.247, -73.486, -75.53, -77.571, -73.338,  &
      -77.622, -73.731, -74.938, -76.385, -79.179, -73.919, -73.964, -77.974,  &
      -74.715, -74.831, -78.558, -75.461, -74.261, -74.834, -74.203, -78.37,  &
      -74.303, -71.907, -74.661, -77.858, -76.958, -78.686, -75.477, -75.429,  &
      -78.308, -75.526, -74.981, -76.374, -74.469, -76.21, -77.206, -77.029,  &
      -77.986, -73.378, -74.63, -74.964, -73.784, -73.846, -73.885, -77.239,  &
      -75.335, -78.648, -74.084, -73.685, -76.48, -75.288, -79.11, -76.374,  &
      -76.98, -116.829, -118.142, -117.073, -120.876, -122.436, -121.591,  &
      -116.695, -121.889, -119.539, -120.179, -121.71, -120.617, -119.441,  &
      -118.379, -121.832, -120.378, -119.038, -122.545, -121.726, -119.53,  &
      -119.258, -117.33, -118.633, -121.307, -120.076, -122.422, -120.176,  &
      -119.912, -121.162, -120.58, -119.431, -118.409, -119.018, -118.715,  &
      -119.304, -121.351, -120.084, -120.7, -116.023, -116.036, -123.143,  &
      -121.897, -122.104, -120.521, -117.103, -119.128, -119.328, -120.739,  &
      -121.718, -121.411, -122.121, -123.317, -122.183, -121.894, -119.081,  &
      -121.71, -117.606, -122.35, -122.613, -121.505, -116.3, -72.412, -71.133,  &
      -72.536, -72.393, -72.308, -71.455, -71.012, -71.051, -71.552, -71.877,  &
      -71.993, -72.181, -71.386, -72.131, -71.726, -71.334, -72.129, -71.08,  &
      -71.928, -71.655, -72.369, -116.927, -114.814, -119.661, -119.507,  &
      -115.709, -114.847, -74.592, -72.294, -72.05, -78.641, -75.712, -75.936,  &
      -73.414, -74.435, -75.109, -73.647, -74.17, -75.119, -77.267, -73.76,  &
      -78.125, -74.327, -74.255, -75.579, -76.829, -76.553, -77.89, -79.547,  &
      -73.955, -74.345, -123.64, -122.528, -122.804, -122.305, -119.424,  &
      -122.709, -122.479, -122.38, -122.455, -120.446, -122.879, -122.871,  &
      -119.979, -117.56, -122.452, -120.884, -117.346, -117.858, -118.836,  &
      -117.956, -117.448, -122.249, -120.491, -119.515, -122.312, -124.338,  &
      -120.803, -119.722, -120.178, -121.904, -121.451, -122.47, -122.798,  &
      -118.979, -122.647, -122.487, -120.632, -122.857, -122.414, -119.984,  &
      -122.006, -119.889, -117.663, -123.352, -119.235, -122.182, -117.555,  &
      -122.521, -124.028, -124.128, -122.691, -119.484, -119.146, -122.133,  &
      -123.3, -122.752, -122.268, -122.749, -117.138, -119.813, -123.721,  &
      -122.703, -121.872, -123.04, -123.026, -121.696, -118.754, -119.135,  &
      -119.671, -118.614, -119.704, -114.919, -114.61, -114.428, -115.902,  &
      -115.652, -115.559, -119.752, -113.999, -117.7, -119.154, -112.905,  &
      -111.132, -108.382, -110.98, -113.007, -112.447, -114.123, -111.932,  &
      -112.309, -112.717, -112.619, -111.164, -106.59, -104.677, -111.156,  &
      -114.135, -107.591, -109.649, -111.866, -114.245, -108.638, -109.402,  &
      -115.538, -110.534, -114.06, -105.804, -113.823, -114.113, -105.172,  &
      -111.839, -104.133, -114.308, -105.629, -91.965, -92.329, -90.496, -92.903,  &
      -91.869, -90.788, -93.667, -89.833, -91.786, -92.163, -89.351, -92.196,  &
      -92.031, -92.33, -91.478, -93.406, -93.234, -90.869, -92.364, -92.373,  &
      -91.545, -93.153, -91.395, -90.126, -90.253, -90.611, -90.376, -93.039,  &
      -90.462, -92.963, -91.601, -90.077, -92.107, -92.622, -92.686, -92.266,  &
      -91.729, -92.659, -93.081, -91.165, -93.229, -91.423, -117.042, -122.319,  &
      -121.67, -119.938, -121.121, -120.243, -118.263, -120.412, -119.027,  &
      -120.126, -122.705, -120.372, -122.516, -96.618, -99.266, -98.631, -98.215,  &
      -97.101, -95.899, -97.269, -97.635, -96.378, -94.719, -98.615, -96.858,  &
      -95.512, -97.917, -95.517, -96.452, -98.94, -95.591, -95.801, -96.739,  &
      -97.095, -97.923, -96.338, -99.376, -97.93, -97.819, -98.993, -94.748,  &
      -97.385, -101.434, -97.153, -95.542, -94.59, -95.929, -99.074, -96.371,  &
      -96.367, -95.469, -94.779, -97.92, -98.317, -97.589, -95.71, -96.758,  &
      -99.487, -96.314, -97.946, -94.836, -94.491, -95.214, -98.974, -97.37,  &
      -95.616, -96.288, -97.206, -95.852, -97.205, -96.307, -97.273, -97.014,  &
      -94.593, -95.283, -97.317, -94.757, -99.627, -96.645, -96.869, -95.989,  &
      -95.097, -97.015, -94.617, -96.948, -94.933, -97.289, -95.632, -97.668,  &
      -95.115, -95.357, -98.296, -92.403, -90.004, -93.679, -93.456, -92.04,  &
      -93.248, -91.969, -91.093, -91.312, -93.021, -89.796, -91.355, -92.637,  &
      -92.039, -91.184, -91.945, -92.208, -91.734, -92.572, -91.802, -93.481,  &
      -89.678, -90.675, -93.433, -92.032, -91.169, -90.767, -92.224, -93.562,  &
      -93.974, -92.8, -92.617, -91.68, -88.537, -88.447, -89.917, -90.469,  &
      -88.527, -90.399, -89.995, -89.507, -90.04, -90.527, -90.676, -89.781,  &
      -88.293, -88.398, -88.456, -90.337, -89.341, -89.846, -89.444, -88.365,  &
      -88.618, -90.978, -90.102, -89.779, -88.691, -89.165, -90.359, -90.842,  &
      -89.414, -88.982, -90.624, -90.316, -89.933, -89.554, -89.113, -90.877,  &
      -89.023, -88.581, -90.418, -88.539, -89.714, -90.254, -89.615, -88.583,  &
      -90.47, -89.623, -88.979, -89.11, -89.476, -88.474, -89.069, -89.632,  &
      -88.969, -90.389, -88.912, -90.539, -88.659, -89.934, -98.394, -98.626,  &
      -96.477, -95.258, -99.364, -90.306, -87.419, -92.342, -89.132, -88.232,  &
      -91.464, -90.849, -92.359, -89.711, -91.827, -88.786, -88.949, -88.921,  &
      -90.75, -91.469, -90.676, -88.048, -89.36, -88.189, -88.979, -91.599,  &
      -88.133, -88.739, -89.005, -88.569, -90.111, -91.892, -88.374, -91.258,  &
      -89.001, -88.487, -92.457, -89.255, -88.335, -88.787, -87.811, -91.462,  &
      -88.614, -92.68, -87.847, -90.122, -88.924, -88.751, -88.688, -87.802,  &
      -87.497, -87.996, -91.054, -91.07, -89.739, -88.399, -88.876, -90.69,  &
      -89.52, -89.178, -87.535, -87.566, -89.044, -90.1, -90.04, -88.527,  &
      -89.739, -90.323, -91.818, -89.641, -87.839, -92.768, -89.62, -89.703,  &
      -88.292, -88.718, -92.507, -87.854, -88.126, -88.715, -87.78, -89.341,  &
      -92.631, -88.478, -87.72, -90.439, -87.938, -89.405, -91.113, -89.701,  &
      -88.736, -90.367, -88.646, -89.609, -88.62, -88.616, -89.113, -89.712,  &
      -90.375, -105.905, -106.425, -104.387, -107.961, -108.12, -107.924,  &
      -104.187, -106.335, -103.143, -107.703, -106.156, -105.891, -106.133,  &
      -105.92, -103.142, -108.064, -108.626, -107.796, -103.093, -106.067,  &
      -108.292, -106.595, -105.187, -106.246, -106.532, -103.326, -105.958,  &
      -103.309, -104.417, -104.475, -105.556, -105.893, -104.637, -106.341,  &
      -108.599, -108.184, -106.877, -105.539, -107.203, -103.701, -105.993,  &
      -106.635, -106.184, -108.773, -93.045, -94.097, -91.547, -91.58, -91.863,  &
      -93.547, -89.861, -93.891, -91.176, -92.801, -91.51, -93.431, -92.324,  &
      -90.568, -91.924, -94.317, -91.409, -92.776, -88.217, -87.758, -89.961,  &
      -89.369, -91.687, -90.36, -88.816, -92.552, -87.934, -88.31, -88.448,  &
      -87.696, -92.625, -90.766, -91.867, -90.913, -89.492, -87.336, -90.465,  &
      -89.693, -88.032, -90.871, -88.56, -88.97, -88.679, -89.037, -88.7,  &
      -89.497, -89.259, -88.116, -88.698, -88.623, -89.7, -88.146, -83.914,  &
      -84.708, -85.799, -84.588, -83.023, -83.369, -83.435, -83.317, -82.974,  &
      -85.094, -83.775, -85.2, -86.369, -86.305, -85.405, -83.84, -84.976,  &
      -84.239, -85.376, -83.348, -85.534, -85.215, -84.718, -84.442, -83.974,  &
      -84.748, -84.87, -85.611, -85.907, -82.516, -85.649, -86.17, -86.075,  &
      -83.634, -83.965, -83.461, -84.63, -85.752, -87.0, -83.488, -84.053,  &
      -83.709, -85.92, -84.627, -84.465, -83.414, -85.429, -84.681, -85.231,  &
      -85.5, -84.782, -86.352, -85.266, -84.53, -85.968, -91.323, -91.462,  &
      -92.606, -91.948, -93.982, -92.393, -90.755, -94.19, -92.361, -93.396,  &
      -94.201, -91.78, -93.036, -91.995, -90.583, -93.553, -92.914, -92.861,  &
      -90.573, -91.234, -91.933, -91.887, -91.349, -93.207, -92.76, -90.142,  &
      -90.746, -94.201, -91.733, -92.709, -92.312, -93.823, -91.241, -89.919,  &
      -93.8, -90.452, -93.691, -90.169, -91.942, -90.962, -94.282, -93.365,  &
      -93.035, -91.634, -92.383, -94.467, -91.525, -93.97, -91.53, -90.494,  &
      -94.055, -90.937, -92.033, -90.763, -83.403, -84.041, -82.446, -84.177,  &
      -83.627, -83.264, -83.681, -81.63, -84.515, -84.122, -82.31, -82.212,  &
      -84.915, -85.086, -81.435, -81.234, -84.169, -84.818, -84.137, -84.903,  &
      -84.696, -85.215, -85.001, -81.886, -83.373, -83.733, -83.306, -83.433,  &
      -83.727, -83.465, -84.779, -83.966, -84.753, -81.399, -84.423, -84.821,  &
      -83.577, -88.49, -84.603, -83.06, -85.022, -88.596, -87.561, -84.264,  &
      -85.398, -85.14, -84.447, -84.348, -83.27, -88.394, -85.321, -86.367,  &
      -86.265, -86.226, -87.241, -84.928, -86.653, -85.447, -84.05, -83.661,  &
      -83.253, -84.678, -86.606, -86.087, -85.74, -85.496, -85.622, -84.099,  &
      -85.813, -86.123, -84.168, -84.856, -82.419, -84.87, -82.729, -83.802,  &
      -83.855, -84.701, -84.533, -82.816, -84.257, -84.358, -85.985, -86.24,  &
      -83.577, -85.688, -85.389, -85.557, -83.348, -85.489, -83.557, -85.614,  &
      -86.138, -84.163, -94.006, -92.788, -94.202, -93.56, -91.253, -94.975,  &
      -90.403, -93.845, -91.075, -93.48, -94.838, -91.54, -92.848, -93.285,  &
      -92.648, -95.535, -95.018, -93.715, -93.32, -90.137, -92.097, -94.333,  &
      -90.315, -91.724, -95.296, -93.443, -90.528, -90.59, -91.094, -93.891,  &
      -94.666, -94.8, -82.797, -82.847, -83.137, -83.359, -82.835, -84.458,  &
      -83.205, -81.962, -83.912, -83.858, -83.68, -81.908, -84.789, -83.507,  &
      -83.158, -82.289, -82.901, -83.426, -82.569, -81.562, -82.736, -83.912,  &
      -84.406, -83.545, -81.861, -85.242, -84.965, -83.056, -83.176, -84.143,  &
      -82.384, -83.636, -83.522, -82.848, -83.439, -84.589, -82.035, -83.197,  &
      -81.918, -83.65, -84.005, -83.665, -83.705, -83.218, -84.361, -83.223,  &
      -84.14, -83.533, -82.101, -81.192, -85.006, -85.095, -83.089, -81.52,  &
      -81.351, -82.771, -80.941, -83.698, -82.577, -82.94, -81.29, -81.731,  &
      -85.295, -82.295, -81.626, -83.783, -84.262, -83.903, -82.473, -83.426,  &
      -83.255, -85.478, -80.84, -83.712, -83.18, -82.289, -83.78, -83.554,  &
      -82.714, -82.278, -81.986, -83.552, -82.653, -84.987, -108.734, -107.201,  &
      -108.349, -109.194, -106.931, -108.195, -104.157, -72.192, -69.937,  &
      -70.591, -73.333, -72.478, -73.202, -71.659, -70.046, -71.223, -70.775,  &
      -73.069, -72.023, -73.095, -71.025, -70.076, -72.54, -70.505, -72.173,  &
      -81.029, -84.556, -82.815, -83.893, -82.386, -84.084, -82.17, -82.292,  &
      -84.354, -81.556, -81.698, -84.374, -82.181, -81.313, -84.221, -83.644,  &
      -82.569, -83.116, -82.186, -81.75, -84.003, -84.707, -84.564, -84.195,  &
      -83.256, -82.711, -83.852, -83.613, -84.365, -80.735, -82.451, -81.849,  &
      -82.636, -84.086, -83.688, -83.144, -83.221, -83.711, -84.553, -84.403,  &
      -84.157, -83.398, -84.115, -82.961, -82.206, -83.26, -81.725, -83.518,  &
      -82.698, -83.776, -81.843, -83.877, -80.418, -81.875, -90.39, -90.714,  &
      -90.002, -89.21, -88.282, -89.718, -90.399, -87.606, -88.89, -88.886,  &
      -88.119, -89.499, -90.489, -89.17, -89.155, -89.996, -89.489, -91.919,  &
      -93.617, -94.128, -91.278, -93.589, -95.724, -92.702, -93.183, -95.31,  &
      -94.193, -93.524, -91.852, -93.532, -91.463, -93.242, -94.368, -91.324,  &
      -93.073, -96.145, -91.433, -90.643, -92.86, -93.128, -95.876, -91.176,  &
      -91.517, -91.376, -90.995, -93.435, -92.298, -93.0, -91.889, -95.746,  &
      -96.085, -96.003, -92.791, -93.741, -92.611, -92.364, -92.89, -94.07,  &
      -93.702, -95.198, -96.271, -90.113, -95.82, -95.351, -95.732, -96.146,  &
      -96.302, -95.125, -95.064, -95.159, -93.571, -92.552, -91.113, -92.003,  &
      -91.666, -92.213, -91.461, -92.426, -93.779, -91.249, -91.998, -91.005,  &
      -94.0, -76.951, -80.138, -78.321, -79.747, -82.272, -78.527, -79.766,  &
      -78.026, -81.621, -81.577, -82.65, -78.65, -77.907, -79.163, -78.641,  &
      -80.345, -81.335, -78.249, -80.37, -83.166, -79.302, -78.586, -78.779,  &
      -79.679, -104.914, -107.917, -80.622, -81.053, -80.995, -80.19, -81.329,  &
      -77.764, -80.195, -80.425, -79.776, -80.071, -80.775, -79.984, -80.852,  &
      -79.653, -80.404, -81.901, -81.764, -81.377, -81.949, -81.206, -78.932,  &
      -79.827, -80.782, -80.822, -81.584, -80.917, -81.451, -79.112, -79.997,  &
      -82.071, -81.707, -81.687, -81.166, -77.786, -81.631, -81.334, -80.824,  &
      -80.496, -81.519, -80.382, -80.606, -80.267, -101.754, -100.702, -98.833,  &
      -102.726, -97.394, -97.354, -98.659, -100.683, -101.178, -101.3, -99.972,  &
      -97.952, -103.596, -97.2, -96.983, -95.101, -96.953, -95.166, -94.927,  &
      -94.687, -98.085, -95.731, -95.439, -97.108, -101.018, -94.823, -97.618,  &
      -94.923, -99.957, -96.789, -98.216, -96.134, -95.072, -96.271, -94.677,  &
      -94.607, -100.774, -95.217, -94.83, -101.696, -98.733, -99.262, -97.41,  &
      -95.518, -97.189, -88.878, -89.858, -89.343, -88.139, -91.117, -87.968,  &
      -89.079, -88.162, -88.141, -89.782, -89.007, -88.936, -87.532, -89.032,  &
      -88.826, -88.654, -89.439, -88.864, -89.199, -88.405, -88.462, -88.415,  &
      -89.952, -88.973, -89.259, -88.497, -88.342, -88.46, -89.573, -90.41,  &
      -90.251, -90.135, -88.676, -88.356, -89.793, -87.975, -89.336, -88.496,  &
      -88.481, -88.592, -90.044, -88.962, -89.629, -89.447, -89.921, -87.652,  &
      -90.172, -90.307, -88.909, -87.757, -89.887, -88.632, -87.651, -89.811,  &
      -88.749, -89.331, -89.605, -89.32, -88.525, -90.623, -88.355, -88.583,  &
      -88.679, -87.661, -89.788, -88.301, -89.089, -89.345, -88.707, -90.072,  &
      -87.627, -90.622, -88.551, -88.378, -89.938, -87.745, -89.404, -90.749,  &
      -88.848, -89.244, -89.369, -89.683, -88.144, -89.271, -88.055, -89.311,  &
      -88.782, -89.022, -87.662, -89.567, -88.064, -76.585, -76.181, -78.584,  &
      -80.818, -77.656, -76.944, -79.096, -77.565, -78.797, -79.065, -81.776,  &
      -83.337, -80.993, -77.854, -79.611, -77.245, -77.399, -77.592, -76.855,  &
      -78.341, -81.123, -79.886, -78.289, -77.287, -81.439, -75.563, -77.501,  &
      -77.775, -80.974, -82.16, -79.33, -78.791, -81.141, -80.401, -78.278,  &
      -78.927, -81.184, -75.659, -81.925, -79.954, -80.513, -76.617, -80.532,  &
      -78.051, -77.08, -78.359, -76.914, -81.053, -77.999, -78.54, -79.1,  &
      -82.472, -79.341, -79.154, -84.852, -76.719, -81.819, -78.4, -80.63,  &
      -79.639, -79.137, -81.339, -79.617, -85.028, -77.485, -85.667, -77.551,  &
      -81.588, -79.674, -82.022, -77.73, -82.097, -78.951, -81.564, -78.077,  &
      -84.825, -78.934, -85.515, -79.086, -80.893, -79.55, -84.297, -81.416,  &
      -81.506, -79.425, -86.518, -78.231, -81.521, -98.766, -95.724, -101.326,  &
      -97.849, -95.678, -95.38, -96.761, -94.107, -98.091, -99.086, -95.175,  &
      -94.881, -100.895, -97.657, -94.658, -98.183, -97.621, -96.498, -96.626,  &
      -95.672, -97.315, -99.879, -95.801, -94.933, -95.245, -94.852, -95.228,  &
      -99.306, -94.667, -98.712, -97.121, -98.84, -95.777, -94.752, -96.054,  &
      -97.558, -100.895, -94.807, -95.057, -95.555, -101.333, -96.287, -97.367,  &
      -97.117, -96.95, -89.615, -86.993, -84.524, -89.696, -89.06, -88.964,  &
      -81.897, -89.223, -88.078, -85.934, -84.738, -86.959, -85.419, -89.623,  &
      -84.988, -83.38, -84.941, -87.275, -85.36, -88.971, -89.235, -82.347,  &
      -84.505, -84.856, -87.086, -86.515, -82.659, -89.383, -84.451, -88.611,  &
      -87.5, -88.85, -88.749, -85.589, -82.103, -82.395, -83.594, -85.996,  &
      -84.036, -87.287, -86.24, -86.755, -88.366, -85.301, -88.482, -89.387,  &
      -87.766, -89.0, -89.838, -89.321, -90.782, -88.59, -89.441, -91.311,  &
      -88.121, -89.978, -87.694, -89.026, -88.802, -90.544, -88.014, -89.798,  &
      -88.922, -88.784, -89.978, -89.684, -89.521, -89.755, -89.556, -89.64,  &
      -88.803, -88.585, -89.213, -89.664, -88.258, -89.081, -89.755, -90.117,  &
      -87.696, -88.895, -90.363, -88.358, -88.392, -112.594, -109.471, -111.005,  &
      -113.014, -112.553, -111.99, -111.559, -112.421, -111.805, -111.355,  &
      -113.264, -111.226, -112.508, -111.775, -111.622, -109.491, -111.659,  &
      -111.438, -111.813, -111.835, -111.476, -112.814, -110.775, -111.543,  &
      -112.066, -109.973, -113.445, -111.776, -111.755, -112.256, -111.554,  &
      -112.267, -112.133, -109.48, -92.24, -93.685, -92.646, -94.024, -93.387,  &
      -92.711, -91.175, -93.159, -93.05, -94.187, -93.077, -94.317, -92.535,  &
      -92.732, -94.215, -93.479, -94.289, -89.646, -93.842, -77.36, -83.084,  &
      -79.009, -82.569, -81.993, -86.085, -77.112, -81.154, -78.858, -80.576,  &
      -77.5, -81.431, -81.08, -81.767, -79.868, -86.289, -80.04, -81.544, -77.96,  &
      -81.471, -78.069, -82.238, -76.969, -81.528, -78.256, -85.48, -79.349,  &
      -78.679, -77.036, -84.404, -77.732, -82.565, -77.873, -82.267, -76.904,  &
      -81.383, -80.029, -80.629, -80.407, -81.832, -81.355, -82.94, -80.175,  &
      -80.366, -81.992, -81.643, -81.163, -81.358, -81.878, -81.836, -82.324,  &
      -82.493, -81.752, -82.097, -81.3, -81.593, -82.954, -82.1, -83.393,  &
      -80.923, -85.214, -82.141, -80.031, -81.077, -81.764, -81.943, -81.961,  &
      -82.294, -80.726, -81.529, -81.093, -80.626, -81.57, -80.446, -80.829,  &
      -85.523, -85.49, -83.531, -81.433, -81.489, -85.284, -80.116, -84.54,  &
      -82.426, -82.165, -81.22, -85.729, -84.328, -86.02, -88.791, -88.766,  &
      -88.743, -85.232, -83.134, -81.79, -87.169, -86.313, -86.379, -83.129,  &
      -83.555, -84.03, -89.481, -84.494, -88.236, -86.973, -86.998, -89.498,  &
      -82.963, -88.188, -88.55, -83.454, -86.384, -85.779, -85.447, -86.814,  &
      -86.864, -83.606, -84.406, -88.924, -86.17, -88.985, -87.753, -83.254,  &
      -86.041, -86.047, -98.392, -103.834, -103.041, -96.535, -96.746, -96.573,  &
      -96.697, -96.687, -103.456, -98.174, -103.716, -97.095, -96.609, -97.986,  &
      -100.408, -101.211, -100.269, -102.519, -103.111, -96.61, -103.786,  &
      -103.489, -96.821, -96.895, -97.045, -99.825, -97.363, -85.54, -84.982,  &
      -87.228, -85.009, -85.164, -86.46, -84.936, -87.247, -86.924, -86.428,  &
      -85.147, -87.254, -86.13, -86.034, -84.852, -85.132, -85.65, -86.979,  &
      -87.389, -85.415, -85.836, -85.101, -86.096, -87.371, -92.113, -89.638,  &
      -89.328, -93.513, -93.74, -92.212, -122.995, -91.384, -90.542, -123.757,  &
      -122.844, -89.925, -89.363, -92.55, -117.799, -90.591, -124.394, -94.181,  &
      -121.227, -90.389, -119.654, -92.677, -124.207, -119.04, -93.08, -122.656,  &
      -92.082, -123.155, -90.267, -124.177, -91.921, -124.159, -123.215, -91.342,  &
      -94.314, -89.735, -93.709, -90.525, -122.994, -90.616, -122.993, -92.043,  &
      -123.258, -122.307, -94.404, -122.831, -94.338, -90.018, -124.079, -93.408,  &
      -92.556, -124.362, -123.003, -94.248, -123.151, -92.625, -119.205, -94.241,  &
      -93.852, -91.031, -119.474, -123.192, -121.679, -118.036, -92.449,  &
      -120.338, -89.956, -121.507, -93.165, -122.82, -92.873, -123.976, -94.813,  &
      -123.065, -91.829, -92.412, -121.109, -93.896, -122.635, -91.488, -122.558,  &
      -92.245, -93.79, -94.337, -94.317, -123.175, -89.521, -122.765, -121.923,  &
      -122.926, -86.194, -82.189, -80.293, -81.3, -82.335, -82.069, -82.502,  &
      -84.092, -82.043, -80.791, -82.794, -81.785, -81.062, -82.408, -81.519,  &
      -84.163, -81.456, -81.555, -82.133, -102.839, -96.342, -95.827, -97.988,  &
      -96.707, -96.094, -99.615, -97.983, -102.986, -97.296, -99.958, -96.934,  &
      -97.113, -97.164, -95.585, -96.445, -100.147, -98.264, -98.354, -99.351,  &
      -98.988, -99.709, -96.587, -100.578, -98.933, -95.831, -97.343, -100.729,  &
      -101.694, -98.617, -95.873, -97.04, -103.627, -97.076, -102.943, -100.534,  &
      -96.602, -96.516, -96.99, -96.69, -97.566, -94.547, -93.309, -95.287,  &
      -94.091, -92.911, -93.845, -93.742, -94.821, -95.58, -94.087, -94.123,  &
      -93.827, -92.621, -91.482, -93.19, -92.879, -92.163, -92.864, -92.342,  &
      -94.17, -94.399, -96.579, -93.892, -93.767, -95.797, -92.834, -93.308,  &
      -91.83, -94.44, -96.683, -86.855, -84.89, -86.652, -87.174, -85.142,  &
      -85.809, -85.638, -87.559, -84.961, -86.44, -86.812, -85.46, -85.947,  &
      -86.092, -84.736, -85.341, -87.189, -86.696, -86.938, -85.452, -85.727,  &
      -86.895, -85.213, -85.434, -86.587, -86.051, -86.762, -85.403, -84.837,  &
      -86.442, -85.567, -87.129, -86.275, -86.898, -87.384, -85.563, -86.382,  &
      -85.692, -85.527, -86.451, -86.741, -87.858, -85.192, -85.963, -86.491,  &
      -85.337, -85.753, -85.574, -85.662, -87.335, -85.155, -86.445, -86.039,  &
      -86.275, -84.963, -87.538, -87.129, -84.78, -86.16, -87.197, -85.425,  &
      -86.059, -85.761, -85.818, -85.738, -86.21, -87.133, -87.382, -85.653,  &
      -87.037, -86.013, -84.77, -85.485, -87.421, -85.789, -86.459, -85.765,  &
      -87.136, -86.887, -86.591, -84.952, -72.442, -73.124, -72.941, -73.169,  &
      -71.987, -73.134, -73.082, -72.186, -72.631, -94.007, -124.004, -93.936,  &
      -92.595, -91.475, -116.983, -122.446, -90.732, -118.743, -91.513, -120.807,  &
      -89.838, -94.742, -94.237, -121.133, -90.348, -124.085, -123.245, -122.795,  &
      -89.687, -90.72, -122.887, -93.927, -93.039, -122.228, -91.729, -90.963,  &
      -123.894, -90.027, -122.754, -91.598, -123.372, -91.517, -122.751, -94.804,  &
      -122.764, -123.274, -93.15, -89.534, -94.551, -122.645, -93.094, -123.757,  &
      -91.135, -123.913, -92.767, -123.258, -93.571, -123.292, -124.032, -90.905,  &
      -122.749, -90.948, -91.463, -92.642, -93.691, -91.057, -93.35, -90.97,  &
      -91.819, -93.528, -93.371, -93.509, -90.993, -82.346, -81.292, -82.546,  &
      -79.536, -81.005, -81.333, -81.44, -80.612, -82.465, -79.652, -80.229,  &
      -80.529, -79.718, -79.874, -81.834, -81.179, -81.803, -81.15, -80.644,  &
      -81.116, -79.314, -81.899, -79.642, -81.599, -79.267, -82.151, -93.236,  &
      -96.018, -92.897, -94.116, -96.982, -93.461, -95.502, -92.817, -92.894,  &
      -94.333, -93.285, -94.964, -93.613, -92.728, -92.237, -94.192, -93.889,  &
      -92.812, -94.502, -94.324, -94.845, -93.408, -96.197, -93.868, -95.746,  &
      -94.794, -93.637, -95.695, -93.563, -93.67, -93.891, -92.733, -93.264,  &
      -95.884, -94.866, -93.552, -94.414, -92.951, -93.129, -93.896, -93.179,  &
      -95.026, -95.554, -92.936, -92.611, -96.3, -92.149, -93.555, -92.492,  &
      -95.078, -92.345, -93.717, -95.73, -92.939, -92.04, -94.099, -93.31,  &
      -94.607, -93.947, -94.929, -94.703, -94.784, -92.468, -96.133, -91.659,  &
      -92.515, -93.761, -95.115, -96.554, -93.467, -93.822, -94.987, -95.098,  &
      -91.553, -95.562, -93.566, -92.652, -106.669, -106.22, -104.713, -109.008,  &
      -105.356, -110.929, -105.416, -109.422, -110.738, -110.529, -108.704,  &
      -105.514, -104.172, -72.933, -73.059, -71.988, -72.449, -73.076, -73.236,  &
      -72.697, -83.808, -81.133, -80.988, -82.323, -84.211, -82.275, -80.667,  &
      -82.942, -82.019, -82.539, -81.144, -83.721, -82.808, -84.058, -83.957,  &
      -83.873, -81.413, -83.601, -84.489, -82.932, -80.974, -81.487, -81.532,  &
      -81.225, -83.364, -81.069, -83.795, -84.513, -81.157, -82.934, -82.904,  &
      -80.995, -82.952, -84.61, -80.608, -82.624, -80.529, -81.822, -84.326,  &
      -82.067, -81.648, -83.124, -83.902, -84.294, -84.301, -83.97, -80.519,  &
      -84.612, -83.569, -83.368, -83.046, -82.714, -81.03, -80.88, -83.34,  &
      -83.88, -82.068, -83.375, -84.596, -84.745, -83.59, -82.521, -83.725,  &
      -80.749, -82.666, -83.576, -82.101, -84.677, -82.523, -84.013, -80.695,  &
      -81.992, -82.365, -83.39, -82.002, -82.96, -81.841, -81.148, -82.379,  &
      -83.068, -83.298, -80.991, -84.237, -81.895, -89.489, -82.068, -81.062,  &
      -81.031, -80.02, -80.669, -82.372, -79.796, -79.715, -81.347, -80.683,  &
      -81.974, -80.197, -79.359, -82.135, -79.213, -81.57, -80.803, -80.32,  &
      -79.071, -80.938, -80.877, -81.754, -82.85, -81.787, -80.276, -80.911,  &
      -81.577, -80.609, -81.071, -82.004, -81.189, -80.331, -78.315, -76.265,  &
      -78.435, -77.644, -79.176, -76.146, -77.123, -78.721, -79.045, -80.359,  &
      -79.809, -80.047, -77.496, -79.318, -78.338, -79.566, -78.538, -78.509,  &
      -78.719, -76.488, -78.701, -80.102, -80.232, -75.819, -78.207, -79.922,  &
      -78.351, -79.918, -79.792, -80.344, -80.0, -76.884, -76.548, -75.879,  &
      -75.191, -78.342, -77.991, -79.089, -77.167, -75.722, -78.793, -78.788,  &
      -79.495, -75.757, -77.029, -75.995, -76.242, -77.498, -79.154, -77.046,  &
      -77.352, -76.657, -77.047, -78.309, -79.865, -80.095, -80.22/)
!
      lat1_regions = (/44.166, 44.729, 44.376, 44.394, 43.867, 45.161, 44.175, 46.828, 43.111,  &
      44.502, 44.653, 46.111, 43.34, 43.99, 44.457, 45.642, 44.774, 43.416,  &
      42.897, 46.67, 44.063, 44.52, 43.398, 44.747, 44.17, 44.507, 40.985,  &
      41.498, 41.31, 41.43, 41.565, 41.542, 41.719, 41.45, 41.233, 39.508,  &
      41.278, 41.858, 41.941, 41.763, 41.436, 41.656, 41.692, 42.771, 43.167,  &
      43.51, 48.67, 42.584, 42.501, 47.65, 43.837, 42.549, 42.921, 45.914,  &
      43.451, 43.609, 43.429, 42.695, 47.525, 43.618, 43.474, 46.328, 46.711,  &
      43.079, 43.026, 39.794, 40.903, 40.527, 40.506, 39.973, 40.899, 39.941,  &
      41.101, 41.333, 40.053, 41.071, 40.351, 41.191, 40.421, 40.923, 40.465,  &
      41.107, 42.193, 40.598, 41.371, 40.594, 40.596, 40.849, 40.526, 40.079,  &
      41.288, 40.31, 40.15, 40.571, 40.917, 39.855, 40.229, 41.078, 41.415,  &
      40.24, 41.397, 41.074, 41.1, 40.772, 40.769, 40.007, 40.876, 41.039,  &
      39.962, 40.725, 39.736, 40.776, 41.937, 40.771, 41.617, 41.704, 41.137,  &
      41.507, 40.628, 41.883, 39.787, 41.774, 39.883, 41.2, 40.573, 39.846,  &
      41.804, 33.813, 32.329, 32.67, 27.713, 30.341, 32.38, 35.099, 32.29,  &
      33.321, 32.142, 33.087, 33.267, 29.942, 31.721, 30.788, 30.067, 28.94,  &
      30.002, 28.345, 29.921, 30.166, 31.183, 32.204, 27.572, 29.739, 33.566,  &
      35.615, 37.086, 38.529, 37.315, 39.14, 36.8, 37.102, 37.063, 38.592, 37.71,  &
      37.982, 36.788, 37.783, 36.927, 38.23, 37.748, 37.164, 38.049, 38.426,  &
      38.366, 36.669, 37.255, 36.647, 38.179, 38.897, 36.625, 37.4, 38.203,  &
      38.351, 38.224, 37.978, 37.897, 38.312, 36.739, 36.885, 37.762, 38.649,  &
      37.284, 36.806, 36.551, 36.918, 38.19, 37.305, 37.028, 39.106, 37.038,  &
      37.149, 37.191, 36.963, 38.19, 36.941, 36.68, 36.691, 38.042, 38.973,  &
      37.984, 37.874, 37.106, 38.239, 36.632, 37.526, 38.254, 37.216, 39.057,  &
      38.803, 36.932, 43.513, 48.171, 43.999, 46.471, 47.468, 42.806, 42.072,  &
      47.788, 43.797, 43.626, 42.597, 43.941, 47.305, 45.159, 48.196, 43.367,  &
      42.647, 43.681, 42.516, 44.236, 42.768, 39.39, 38.869, 39.261, 38.536,  &
      39.021, 38.609, 39.186, 38.377, 37.97, 39.568, 38.318, 38.849, 38.71,  &
      39.672, 38.676, 39.319, 39.257, 38.475, 39.286, 39.4, 38.258, 38.183,  &
      38.417, 39.636, 39.386, 39.717, 38.056, 39.122, 38.507, 38.154, 38.865,  &
      38.77, 39.422, 39.638, 39.573, 38.493, 39.697, 39.464, 39.355, 38.977,  &
      37.42, 39.177, 39.307, 39.423, 37.215, 39.931, 39.402, 40.245, 38.8,  &
      39.295, 38.388, 39.375, 38.802, 38.664, 37.326, 40.505, 38.716, 39.332,  &
      37.218, 39.623, 40.517, 39.608, 40.331, 39.589, 40.073, 38.352, 40.291,  &
      33.535, 29.284, 31.108, 29.031, 32.744, 30.123, 33.192, 29.758, 33.147,  &
      25.859, 31.652, 34.054, 30.731, 36.024, 30.514, 30.842, 35.893, 32.523,  &
      34.961, 29.839, 28.494, 32.13, 29.318, 31.763, 34.408, 32.375, 33.594,  &
      32.299, 30.246, 31.769, 32.387, 31.8, 30.52, 32.38, 29.685, 31.882, 29.946,  &
      33.226, 30.077, 27.579, 32.055, 28.422, 31.379, 31.289, 28.671, 29.072,  &
      32.985, 36.041, 32.323, 30.0, 33.199, 30.308, 29.331, 32.923, 33.118,  &
      32.959, 29.107, 31.169, 28.655, 34.526, 32.074, 35.84, 29.572, 28.592,  &
      32.385, 28.957, 29.169, 34.013, 30.319, 30.097, 32.135, 32.289, 31.491,  &
      31.7, 27.205, 33.149, 29.115, 33.971, 32.681, 30.865, 30.244, 34.631,  &
      35.617, 33.6, 29.24, 31.385, 30.167, 32.694, 29.488, 33.067, 38.403,  &
      34.136, 32.906, 31.278, 33.553, 34.297, 34.748, 30.998, 32.533, 30.837,  &
      33.069, 32.916, 31.073, 34.133, 40.03, 40.232, 39.909, 39.457, 39.014,  &
      40.341, 38.521, 39.616, 40.291, 39.889, 37.946, 38.046, 38.059, 39.234,  &
      40.001, 40.129, 37.567, 38.431, 39.552, 37.246, 38.196, 39.519, 38.038,  &
      39.439, 38.507, 40.509, 39.542, 39.567, 40.44, 40.6, 37.141, 39.569,  &
      37.612, 40.68, 38.892, 40.111, 36.817, 37.783, 37.372, 36.831, 37.527,  &
      36.869, 36.856, 37.32, 38.651, 37.187, 38.843, 36.46, 37.082, 38.709,  &
      36.957, 38.369, 37.556, 37.626, 37.797, 36.846, 38.407, 38.097, 36.698,  &
      36.472, 38.177, 36.959, 38.31, 36.794, 37.719, 37.202, 37.551, 36.805,  &
      37.12, 38.31, 37.679, 37.526, 37.592, 38.007, 37.546, 37.454, 37.917,  &
      36.892, 38.052, 37.963, 38.694, 37.172, 37.119, 37.314, 36.694, 38.594,  &
      36.534, 36.804, 32.392, 32.66, 30.213, 30.57, 33.064, 31.506, 32.236,  &
      32.486, 31.687, 26.01, 33.143, 30.859, 27.293, 30.078, 32.117, 33.806,  &
      34.795, 29.142, 31.983, 32.449, 29.333, 33.445, 30.528, 29.366, 30.643,  &
      27.823, 33.936, 33.21, 31.919, 30.882, 28.962, 30.474, 33.07, 28.871,  &
      32.541, 28.759, 31.838, 29.98, 32.353, 31.006, 30.63, 27.463, 33.226,  &
      30.419, 29.883, 30.374, 30.455, 30.316, 28.934, 32.713, 31.043, 27.409,  &
      33.561, 30.043, 32.47, 33.9, 30.683, 30.736, 29.841, 32.37, 33.447, 31.266,  &
      29.656, 29.182, 26.085, 31.413, 33.137, 30.932, 30.182, 32.151, 30.337,  &
      30.554, 31.288, 32.492, 28.077, 35.029, 31.645, 31.923, 32.649, 32.781,  &
      31.549, 29.862, 33.12, 33.155, 34.215, 31.549, 30.316, 29.379, 33.425,  &
      33.77, 30.952, 32.807, 33.152, 32.333, 34.094, 30.469, 34.398, 32.489,  &
      31.13, 31.262, 31.81, 31.413, 33.671, 34.697, 30.239, 34.396, 33.846,  &
      31.018, 30.451, 31.79, 34.201, 34.107, 34.055, 34.922, 31.277, 34.55,  &
      31.488, 33.811, 33.258, 30.375, 31.499, 32.277, 34.459, 32.975, 33.9,  &
      31.249, 31.379, 33.487, 30.267, 33.908, 34.503, 33.128, 30.531, 34.47,  &
      34.598, 32.362, 34.93, 33.758, 33.712, 33.146, 33.399, 32.516, 31.873,  &
      31.751, 33.041, 32.386, 32.116, 32.744, 32.469, 33.17, 32.364, 32.73,  &
      33.407, 32.379, 31.94, 31.371, 33.588, 33.356, 34.968, 34.551, 32.846,  &
      36.136, 34.72, 33.023, 36.949, 32.959, 31.932, 34.688, 31.334, 34.086,  &
      32.735, 33.318, 35.085, 33.008, 35.723, 33.359, 34.89, 36.707, 35.174,  &
      34.451, 38.144, 37.663, 38.031, 37.341, 36.573, 37.833, 37.714, 36.967,  &
      37.772, 38.167, 37.394, 36.516, 38.688, 37.578, 37.079, 37.7, 36.814,  &
      36.726, 38.162, 36.979, 37.519, 37.828, 37.885, 38.02, 36.669, 37.625,  &
      38.597, 37.854, 37.945, 41.479, 38.055, 37.891, 39.007, 40.832, 35.027,  &
      35.187, 38.86, 33.331, 35.965, 35.234, 34.863, 34.218, 37.345, 36.917,  &
      32.953, 40.87, 35.102, 33.117, 38.568, 34.191, 35.539, 36.46, 39.676,  &
      37.075, 38.906, 38.943, 38.777, 36.12, 39.029, 39.188, 37.624, 36.051,  &
      39.899, 40.376, 41.736, 38.525, 35.728, 33.903, 37.862, 38.417, 36.96,  &
      35.869, 39.928, 32.662, 35.382, 37.773, 38.677, 40.709, 38.158, 34.39,  &
      36.837, 38.429, 39.384, 35.245, 40.537, 34.811, 36.634, 38.237, 27.93,  &
      31.793, 33.347, 30.784, 30.694, 28.696, 31.709, 33.203, 35.518, 33.627,  &
      28.87, 32.985, 32.342, 31.389, 36.354, 33.379, 32.966, 34.142, 28.9,  &
      29.824, 26.036, 28.589, 33.183, 29.027, 30.062, 27.35, 29.548, 32.77,  &
      26.397, 28.291, 27.328, 26.292, 26.17, 27.769, 30.642, 27.997, 31.779,  &
      31.338, 29.256, 27.744, 33.328, 29.808, 31.182, 29.667, 29.758, 29.531,  &
      32.698, 33.664, 33.576, 30.321, 28.021, 33.419, 29.992, 32.675, 30.554,  &
      36.184, 32.949, 32.93, 32.191, 26.239, 33.092, 32.16, 29.033, 32.448,  &
      27.964, 33.155, 30.553, 31.6, 31.015, 32.702, 29.293, 31.438, 30.913,  &
      34.52, 32.133, 29.149, 32.515, 32.399, 34.124, 28.709, 31.381, 32.709,  &
      31.786, 29.119, 29.638, 32.828, 29.294, 33.644, 33.82, 32.694, 34.627,  &
      34.092, 32.425, 33.029, 36.773, 34.814, 31.333, 36.895, 34.129, 34.217,  &
      33.089, 32.308, 34.512, 33.652, 31.466, 32.798, 31.785, 34.489, 33.285,  &
      32.479, 32.593, 34.826, 34.178, 31.423, 34.455, 32.566, 33.273, 36.105,  &
      32.035, 32.004, 34.768, 33.723, 33.78, 33.942, 32.243, 35.236, 35.649,  &
      34.98, 32.602, 38.698, 38.982, 38.638, 38.906, 38.681, 38.591, 39.38,  &
      38.833, 38.491, 38.761, 38.302, 38.505, 39.493, 38.276, 40.393, 39.019,  &
      40.798, 39.37, 39.939, 40.913, 41.06, 39.585, 41.126, 40.983, 39.314,  &
      40.518, 39.538, 41.03, 41.048, 39.884, 39.546, 40.052, 40.227, 41.16,  &
      38.929, 39.343, 40.678, 39.637, 41.364, 43.799, 43.005, 42.499, 43.234,  &
      42.242, 42.919, 42.488, 42.846, 42.825, 36.96, 36.492, 39.099, 36.309,  &
      39.334, 34.955, 38.462, 37.246, 37.427, 36.269, 33.679, 38.776, 37.397,  &
      36.784, 32.788, 36.196, 39.218, 33.591, 38.341, 38.331, 38.942, 36.717,  &
      36.159, 34.223, 35.579, 34.58, 38.974, 39.012, 33.314, 39.182, 34.515,  &
      36.255, 36.182, 39.257, 37.637, 38.078, 34.621, 33.564, 37.034, 40.012,  &
      35.66, 36.924, 37.624, 37.718, 33.533, 36.745, 37.257, 33.373, 37.547,  &
      35.025, 35.298, 37.767, 41.279, 33.442, 38.204, 37.304, 35.006, 33.51,  &
      37.301, 36.61, 39.722, 36.519, 39.425, 34.103, 39.725, 36.604, 37.453,  &
      38.205, 34.397, 38.665, 37.278, 38.978, 36.05, 36.022, 39.799, 32.991,  &
      38.091, 38.484, 40.121, 40.425, 36.528, 39.342, 35.793, 35.573, 40.462,  &
      38.142, 36.424, 29.787, 32.933, 31.948, 29.97, 30.754, 29.271, 26.849,  &
      42.888, 42.981, 42.326, 41.16, 41.952, 41.929, 43.193, 42.61, 44.583,  &
      42.202, 42.909, 41.341, 43.025, 43.073, 42.918, 42.628, 41.413, 42.723,  &
      43.229, 42.109, 42.565, 42.287, 42.543, 42.262, 42.462, 42.415, 42.734,  &
      41.701, 42.014, 42.891, 42.773, 42.68, 43.239, 42.94, 44.305, 42.45,  &
      43.393, 43.081, 42.807, 42.895, 42.889, 42.282, 42.235, 42.97, 42.398,  &
      42.059, 41.797, 44.261, 42.961, 41.775, 43.026, 43.098, 43.775, 44.833,  &
      44.899, 41.477, 43.185, 41.383, 41.02, 41.636, 42.708, 43.013, 43.252,  &
      42.503, 44.673, 42.003, 43.031, 42.421, 43.297, 41.432, 42.087, 43.035,  &
      42.602, 42.676, 44.621, 41.317, 44.649, 42.431, 41.973, 41.916, 42.776,  &
      43.17, 42.146, 44.285, 42.952, 41.916, 42.294, 42.527, 42.876, 43.206,  &
      33.71, 34.821, 34.193, 38.361, 38.482, 36.538, 32.54, 37.34, 36.652,  &
      36.599, 37.122, 35.205, 34.355, 34.352, 36.908, 34.842, 34.331, 38.301,  &
      36.522, 36.489, 35.464, 34.726, 34.222, 36.411, 34.576, 38.242, 37.933,  &
      38.821, 37.787, 40.373, 35.122, 35.11, 35.948, 34.118, 36.047, 37.674,  &
      39.308, 37.368, 34.112, 34.201, 39.101, 38.315, 38.042, 34.715, 34.358,  &
      36.151, 35.573, 37.615, 36.854, 39.006, 39.131, 39.366, 39.51, 38.514,  &
      36.398, 38.641, 34.343, 38.377, 41.681, 39.048, 34.08, 43.069, 44.364,  &
      42.801, 43.224, 43.34, 43.132, 43.008, 43.385, 43.416, 43.102, 42.784,  &
      42.896, 43.459, 43.599, 44.288, 42.89, 43.319, 43.956, 42.853, 43.741,  &
      43.407, 40.623, 35.942, 39.074, 39.219, 40.801, 39.225, 41.684, 41.03,  &
      40.949, 42.494, 43.127, 42.959, 43.821, 44.216, 42.963, 42.37, 41.508,  &
      42.155, 43.116, 43.481, 42.706, 41.229, 41.598, 43.918, 42.335, 43.028,  &
      42.076, 42.307, 41.32, 41.551, 46.944, 48.413, 47.396, 48.655, 46.246,  &
      48.893, 47.439, 48.088, 48.205, 47.49, 46.221, 46.569, 47.796, 47.467,  &
      46.813, 47.179, 46.867, 48.522, 46.647, 46.302, 47.94, 46.855, 46.958,  &
      47.281, 48.891, 47.935, 45.805, 46.191, 46.333, 48.072, 45.666, 47.743,  &
      45.958, 46.144, 45.856, 48.371, 47.559, 46.054, 48.867, 46.204, 47.902,  &
      46.73, 47.547, 46.971, 47.079, 48.352, 47.796, 48.232, 46.434, 46.928,  &
      46.913, 48.349, 46.782, 48.924, 48.087, 48.012, 45.258, 48.097, 46.707,  &
      47.219, 46.659, 45.795, 47.008, 48.05, 47.16, 47.445, 39.446, 39.572,  &
      38.874, 38.514, 39.019, 35.918, 35.124, 36.533, 36.096, 40.785, 40.697,  &
      39.274, 40.689, 40.908, 38.964, 46.117, 45.75, 45.722, 45.625, 48.534,  &
      45.909, 48.339, 48.157, 48.624, 46.389, 45.203, 45.638, 48.187, 47.084,  &
      47.435, 46.197, 45.72, 48.529, 46.569, 48.16, 45.657, 47.045, 48.367,  &
      45.627, 46.738, 46.373, 46.781, 47.674, 48.107, 48.495, 47.685, 48.373,  &
      48.08, 29.938, 31.183, 30.695, 32.533, 32.749, 30.129, 32.637, 30.747,  &
      30.202, 30.938, 29.255, 30.388, 30.972, 30.191, 32.435, 30.423, 30.805,  &
      29.951, 30.446, 32.75, 31.587, 31.029, 29.727, 30.824, 29.358, 29.966,  &
      30.418, 32.764, 29.386, 30.225, 29.882, 29.661, 31.668, 30.194, 32.212,  &
      29.985, 29.941, 30.069, 30.107, 32.758, 31.108, 30.407, 47.574, 48.23,  &
      47.843, 46.277, 45.576, 46.356, 45.907, 46.426, 46.955, 47.362, 45.888,  &
      46.498, 46.911, 34.73, 34.619, 36.783, 35.054, 34.129, 36.699, 36.777,  &
      35.117, 35.814, 33.983, 34.622, 35.693, 35.459, 34.986, 36.22, 36.284,  &
      35.49, 36.986, 36.351, 35.934, 34.467, 34.478, 33.923, 35.362, 35.492,  &
      36.336, 34.363, 36.554, 35.853, 36.668, 35.429, 34.835, 34.874, 35.421,  &
      35.01, 35.064, 36.402, 33.995, 33.874, 35.819, 34.548, 34.821, 34.882,  &
      34.076, 34.864, 36.105, 34.623, 36.834, 35.384, 35.668, 35.281, 35.128,  &
      36.678, 35.421, 35.284, 35.596, 34.706, 36.637, 36.274, 36.659, 35.037,  &
      36.267, 35.002, 35.445, 35.268, 35.217, 35.246, 36.347, 35.241, 36.079,  &
      35.792, 34.492, 35.842, 36.671, 35.892, 35.225, 36.623, 35.924, 34.341,  &
      30.616, 30.348, 32.009, 31.538, 31.041, 32.522, 32.426, 29.639, 31.469,  &
      31.719, 29.7, 30.598, 30.78, 30.471, 29.891, 30.534, 30.199, 32.449,  &
      32.496, 30.099, 32.333, 30.21, 29.928, 32.961, 30.392, 32.383, 32.215,  &
      30.66, 30.176, 32.854, 30.223, 31.896, 32.146, 33.803, 33.956, 34.233,  &
      33.162, 34.636, 31.562, 32.547, 32.718, 33.997, 34.134, 33.696, 31.229,  &
      33.439, 33.58, 34.897, 31.947, 30.372, 33.064, 32.347, 34.229, 30.435,  &
      33.338, 33.462, 33.719, 30.269, 31.229, 31.839, 33.163, 34.75, 33.878,  &
      33.419, 33.488, 32.131, 33.036, 31.585, 33.394, 33.099, 30.869, 31.193,  &
      33.099, 31.846, 34.19, 34.805, 32.312, 33.44, 32.338, 34.464, 32.304,  &
      34.285, 30.327, 32.75, 30.467, 34.219, 32.229, 34.715, 33.71, 34.348,  &
      34.564, 35.834, 35.517, 35.136, 34.896, 36.399, 44.889, 44.588, 45.288,  &
      45.114, 44.12, 44.238, 46.559, 44.948, 43.434, 45.39, 43.431, 42.427,  &
      43.96, 44.274, 45.089, 43.124, 44.159, 42.597, 42.611, 42.989, 45.301,  &
      44.015, 44.597, 43.316, 42.594, 42.945, 46.632, 42.773, 44.76, 42.812,  &
      42.641, 44.714, 42.766, 43.686, 42.868, 44.393, 45.986, 43.437, 44.911,  &
      45.762, 46.423, 42.614, 43.065, 43.397, 42.493, 44.444, 43.905, 43.72,  &
      45.447, 43.561, 42.558, 43.063, 42.833, 43.306, 42.897, 44.037, 45.045,  &
      43.16, 44.627, 43.779, 43.479, 43.122, 45.12, 44.84, 45.141, 42.792,  &
      44.623, 42.582, 42.993, 42.813, 44.363, 45.099, 44.877, 44.862, 44.026,  &
      43.615, 42.845, 45.306, 43.94, 45.044, 42.718, 43.728, 43.498, 43.013,  &
      43.249, 33.406, 34.677, 34.112, 34.124, 31.65, 33.579, 30.826, 33.462,  &
      32.833, 32.85, 34.89, 32.784, 36.794, 32.721, 36.684, 32.334, 32.001,  &
      34.369, 32.236, 35.034, 35.509, 31.552, 35.933, 32.428, 36.687, 35.495,  &
      35.128, 32.681, 32.824, 36.721, 32.209, 35.557, 35.868, 34.592, 32.915,  &
      35.846, 34.156, 36.854, 33.28, 33.305, 35.556, 34.906, 35.508, 36.754,  &
      32.727, 34.035, 36.333, 33.111, 35.146, 33.069, 32.1, 35.808, 35.049,  &
      34.092, 33.653, 35.297, 35.724, 35.054, 36.351, 35.882, 35.122, 34.866,  &
      33.524, 36.258, 35.443, 34.939, 36.398, 33.1, 34.026, 33.509, 44.739,  &
      44.656, 42.654, 43.509, 45.614, 45.437, 43.315, 43.824, 44.83, 42.299,  &
      44.497, 44.758, 43.666, 45.111, 43.911, 45.804, 44.944, 44.435, 44.811,  &
      43.964, 45.454, 42.67, 43.535, 42.52, 43.175, 43.149, 44.323, 43.61,  &
      44.757, 44.055, 43.292, 42.816, 44.093, 44.303, 44.313, 41.858, 42.232,  &
      42.504, 43.364, 42.911, 45.02, 42.13, 44.39, 43.788, 42.232, 43.531,  &
      43.077, 41.913, 41.9, 43.606, 41.819, 45.197, 42.087, 44.208, 43.459,  &
      43.204, 45.273, 42.539, 45.606, 42.294, 43.81, 41.918, 41.785, 43.053,  &
      41.979, 42.71, 42.615, 41.963, 41.944, 42.896, 44.2, 42.484, 41.488,  &
      45.708, 42.753, 42.636, 43.31, 43.438, 44.888, 43.97, 42.811, 42.783,  &
      44.645, 43.15, 42.577, 44.002, 43.675, 42.632, 41.875, 42.729, 34.271,  &
      33.862, 33.162, 34.534, 35.982, 33.801, 34.976, 35.235, 35.206, 36.322,  &
      35.189, 33.206, 36.194, 35.476, 34.502, 33.629, 34.4, 34.622, 35.762,  &
      33.281, 34.486, 34.769, 33.599, 33.239, 34.328, 35.869, 34.756, 34.561,  &
      33.579, 35.13, 36.31, 33.91, 35.595, 35.681, 35.483, 35.993, 35.273,  &
      36.369, 34.141, 36.249, 35.967, 33.784, 35.202, 35.188, 34.282, 36.144,  &
      34.465, 33.348, 36.484, 35.656, 34.882, 36.026, 33.576, 35.186, 31.1, 31.5,  &
      31.52, 32.04, 31.666, 33.838, 33.172, 33.308, 30.872, 33.031, 31.733,  &
      31.267, 31.346, 33.686, 31.129, 31.819, 30.846, 34.331, 31.177, 33.522,  &
      34.108, 33.966, 34.845, 32.141, 34.852, 34.537, 32.367, 34.173, 31.931,  &
      34.432, 31.756, 34.513, 34.701, 31.364, 31.757, 31.017, 42.77, 47.019,  &
      44.277, 42.998, 42.944, 46.057, 46.471, 42.169, 42.09, 44.717, 46.224,  &
      42.517, 43.021, 47.157, 42.925, 43.933, 44.21, 45.942, 46.456, 42.251,  &
      41.561, 42.704, 43.5, 42.062, 41.842, 43.553, 46.371, 42.936, 43.376,  &
      46.325, 42.428, 42.967, 42.157, 42.157, 42.81, 45.334, 42.633, 42.855,  &
      42.791, 45.404, 43.34, 45.849, 42.963, 43.407, 46.413, 42.033, 41.579,  &
      42.341, 42.394, 43.142, 41.763, 41.906, 41.474, 44.635, 43.322, 42.659,  &
      43.357, 42.661, 41.6, 41.004, 43.056, 41.986, 42.099, 41.389, 42.233,  &
      42.035, 40.765, 41.482, 42.046, 41.866, 40.71, 40.998, 43.045, 42.735,  &
      40.724, 42.717, 43.108, 41.77, 43.364, 41.042, 41.4, 43.282, 41.998,  &
      41.468, 41.81, 42.437, 42.469, 42.648, 43.093, 43.392, 31.471, 32.487,  &
      32.171, 33.308, 34.082, 34.616, 31.686, 30.815, 33.008, 32.519, 34.126,  &
      31.916, 33.219, 32.979, 33.551, 33.394, 34.305, 32.26, 31.84, 31.745,  &
      31.022, 33.264, 34.438, 34.066, 31.557, 34.673, 32.971, 31.025, 30.671,  &
      31.714, 32.983, 34.365, 32.7, 32.029, 33.562, 32.83, 32.374, 33.019,  &
      32.792, 33.759, 32.238, 33.287, 31.091, 31.188, 34.321, 31.574, 31.113,  &
      30.768, 32.043, 32.238, 33.982, 34.148, 34.271, 30.711, 31.133, 32.927,  &
      31.889, 33.641, 32.354, 33.233, 32.348, 32.36, 34.46, 32.555, 32.718,  &
      31.504, 32.859, 30.807, 33.444, 31.403, 34.538, 34.849, 31.987, 32.234,  &
      30.763, 32.18, 32.075, 32.435, 33.719, 31.156, 33.069, 33.886, 32.7,  &
      33.862, 44.746, 41.766, 43.009, 41.55, 44.741, 43.632, 42.04, 42.557,  &
      41.515, 41.775, 42.175, 42.529, 42.273, 42.476, 41.244, 42.632, 41.574,  &
      42.669, 42.199, 42.382, 41.359, 42.027, 42.409, 41.377, 42.204, 40.713,  &
      41.566, 40.538, 39.012, 40.353, 41.37, 39.428, 39.891, 40.336, 40.26,  &
      39.98, 39.73, 39.696, 40.373, 38.932, 41.171, 41.2, 41.501, 41.28, 40.822,  &
      40.997, 39.484, 41.129, 40.109, 40.095, 41.496, 40.455, 39.481, 40.51,  &
      40.854, 41.372, 40.959, 40.856, 40.248, 39.866, 41.086, 40.806, 40.091,  &
      40.842, 40.211, 40.544, 39.514, 41.53, 39.052, 41.148, 39.926, 40.266,  &
      38.767, 41.035, 39.408, 40.759, 39.782, 40.955, 39.865, 40.792, 41.185,  &
      38.793, 37.439, 39.674, 39.548, 39.991, 41.334, 37.982, 40.406, 41.222,  &
      38.548, 40.541, 42.1, 36.995, 40.535, 37.255, 40.988, 43.238, 42.456,  &
      40.616, 43.083, 41.015, 41.712, 42.731, 41.637, 42.7, 41.89, 42.456,  &
      41.332, 41.599, 42.503, 41.992, 40.381, 41.301, 42.764, 42.469, 42.045,  &
      42.007, 43.097, 41.55, 42.215, 40.938, 41.908, 41.349, 42.0, 43.044,  &
      41.674, 42.609, 41.028, 42.015, 42.976, 43.268, 41.016, 41.256, 40.978,  &
      41.375, 41.824, 41.756, 40.998, 43.188, 42.064, 43.169, 40.728, 43.389,  &
      43.052, 42.386, 43.112, 43.313, 42.611, 42.178, 41.959, 41.757, 42.151,  &
      41.279, 42.395, 43.255, 42.7, 42.445, 41.563, 41.65, 41.58, 41.325, 36.266,  &
      35.328, 35.613, 35.635, 35.22, 35.361, 35.337, 34.013, 35.232, 36.183,  &
      35.134, 35.393, 34.538, 36.011, 36.077, 34.897, 35.354, 34.973, 35.258,  &
      35.291, 36.507, 35.285, 35.835, 36.468, 42.031, 44.002, 37.719, 37.691,  &
      37.186, 38.951, 38.079, 39.245, 39.206, 40.582, 38.833, 39.376, 38.908,  &
      39.28, 37.64, 39.46, 37.739, 37.707, 37.983, 39.327, 38.951, 38.122,  &
      39.041, 39.579, 37.319, 39.611, 37.649, 39.594, 39.152, 38.973, 39.122,  &
      38.789, 38.912, 38.801, 39.374, 39.194, 38.457, 38.789, 38.266, 40.245,  &
      37.362, 38.998, 39.881, 37.781, 47.258, 46.758, 48.082, 46.847, 48.398,  &
      47.915, 46.877, 46.749, 48.182, 48.4, 48.351, 46.891, 48.143, 38.904,  &
      36.999, 39.544, 37.661, 38.768, 39.097, 36.999, 39.45, 38.183, 37.633,  &
      39.366, 39.36, 37.159, 39.552, 38.942, 37.725, 37.789, 38.723, 38.385,  &
      38.913, 37.813, 37.805, 37.049, 37.933, 38.27, 37.498, 39.319, 38.351,  &
      38.827, 38.127, 39.838, 38.336, 37.671, 39.263, 38.601, 38.069, 40.402,  &
      39.29, 38.428, 39.967, 39.457, 37.889, 37.962, 40.109, 39.961, 42.062,  &
      39.763, 41.883, 41.817, 40.391, 37.992, 41.079, 39.074, 37.799, 40.771,  &
      40.73, 40.696, 40.733, 38.363, 38.658, 42.249, 42.405, 40.889, 41.428,  &
      42.081, 40.449, 39.069, 40.702, 38.861, 42.078, 37.688, 42.393, 40.278,  &
      40.306, 38.717, 39.123, 38.91, 40.452, 39.685, 39.097, 37.788, 41.035,  &
      41.218, 41.602, 38.693, 42.368, 40.324, 40.083, 39.147, 40.521, 38.081,  &
      40.432, 40.175, 42.231, 41.318, 39.374, 38.481, 39.41, 41.517, 40.781,  &
      37.141, 38.426, 41.146, 40.892, 40.008, 41.333, 41.793, 38.398, 42.028,  &
      39.961, 38.279, 37.748, 38.327, 38.529, 38.973, 39.246, 38.698, 41.999,  &
      41.317, 39.362, 39.582, 39.582, 40.445, 36.053, 36.24, 34.61, 36.208,  &
      36.169, 35.057, 34.474, 35.578, 34.895, 35.788, 35.25, 35.15, 35.145,  &
      35.282, 35.948, 35.45, 35.341, 34.337, 34.855, 36.248, 35.605, 35.803,  &
      33.914, 34.642, 36.376, 35.846, 35.212, 35.291, 35.52, 35.157, 34.703,  &
      35.381, 35.396, 35.223, 36.074, 34.576, 35.556, 35.885, 35.629, 36.371,  &
      35.868, 34.643, 36.436, 35.145, 36.426, 33.528, 34.948, 36.075, 33.898,  &
      36.275, 34.649, 29.764, 35.099, 35.7, 29.713, 35.826, 27.145, 35.481,  &
      26.65, 35.715, 34.792, 24.64, 36.304, 30.397, 34.815, 30.745, 36.404,  &
      25.908, 34.865, 26.755, 35.852, 28.647, 36.341, 26.4, 33.926, 30.678,  &
      34.798, 30.757, 35.383, 26.729, 35.235, 30.147, 35.21, 29.421, 35.695,  &
      30.696, 35.437, 27.818, 38.502, 39.456, 37.163, 38.013, 37.193, 37.913,  &
      38.993, 38.708, 37.632, 38.169, 38.893, 39.203, 37.017, 38.564, 38.606,  &
      38.333, 38.334, 39.126, 39.834, 37.411, 37.999, 39.821, 38.618, 38.484,  &
      38.576, 38.561, 37.321, 39.741, 37.367, 37.635, 37.556, 38.865, 39.884,  &
      39.695, 39.185, 38.769, 38.464, 38.716, 39.095, 38.93, 37.567, 39.193,  &
      37.252, 37.466, 37.201, 35.246, 36.218, 35.399, 35.39, 35.704, 35.23,  &
      36.468, 35.574, 36.035, 36.219, 35.091, 35.57, 36.047, 35.523, 35.856,  &
      35.984, 35.439, 35.995, 35.33, 36.041, 35.936, 36.087, 35.304, 35.982,  &
      35.938, 35.037, 36.075, 35.83, 35.817, 35.411, 35.53, 35.774, 35.529,  &
      35.06, 36.213, 36.361, 35.653, 36.495, 36.169, 35.183, 36.139, 35.423,  &
      35.632, 36.352, 36.107, 40.525, 41.32, 41.28, 39.975, 38.046, 39.593,  &
      40.859, 41.35, 39.859, 40.224, 38.193, 38.985, 41.893, 42.165, 40.109,  &
      40.095, 38.129, 38.598, 39.397, 38.363, 38.105, 39.626, 38.956, 37.998,  &
      41.754, 41.089, 39.563, 39.508, 38.599, 39.78, 38.943, 39.49, 38.3, 40.761,  &
      37.872, 39.424, 42.354, 42.271, 38.266, 37.606, 39.206, 37.647, 39.343,  &
      40.297, 39.338, 40.563, 39.119, 40.448, 37.13, 40.596, 37.016, 41.607,  &
      39.247, 38.522, 41.026, 39.525, 39.676, 40.82, 40.636, 37.828, 39.575,  &
      39.994, 38.749, 40.272, 37.02, 40.443, 39.916, 40.624, 40.729, 40.507,  &
      41.694, 40.397, 38.753, 36.951, 36.935, 40.249, 37.584, 38.94, 39.329,  &
      36.586, 39.769, 39.116, 37.629, 38.236, 38.615, 37.985, 39.715, 39.346,  &
      37.134, 36.162, 36.658, 34.514, 29.61, 35.22, 28.837, 35.902, 30.692,  &
      34.639, 28.834, 34.131, 27.757, 35.866, 30.516, 35.862, 27.725, 35.344,  &
      30.367, 34.942, 28.216, 34.722, 27.701, 34.98, 29.557, 35.483, 26.211,  &
      35.76, 30.942, 35.23, 34.264, 35.828, 30.597, 33.968, 29.808, 35.682,  &
      28.712, 35.961, 26.395, 35.749, 36.113, 27.005, 29.612, 29.962, 30.495,  &
      26.897, 24.845, 29.759, 24.544, 28.159, 26.737, 28.833, 29.127, 29.971,  &
      30.13, 27.846, 28.753, 27.208, 28.646, 30.275, 30.226, 30.453, 24.688,  &
      30.751, 28.963, 25.404, 26.814, 30.503, 26.838, 29.048, 29.176, 27.181,  &
      26.263, 28.276, 26.798, 29.565, 27.861, 28.892, 30.051, 30.245, 30.075,  &
      28.092, 28.027, 29.788, 27.043, 30.542, 29.062, 28.476, 29.68, 35.636,  &
      35.481, 35.422, 36.308, 35.792, 35.858, 36.117, 36.08, 36.432, 35.513,  &
      35.71, 35.85, 35.92, 36.421, 36.145, 35.177, 36.396, 36.262, 36.363,  &
      35.175, 35.664, 36.365, 35.176, 35.141, 35.769, 35.444, 35.935, 35.85,  &
      36.411, 35.665, 36.007, 35.578, 35.909, 35.331, 36.391, 36.07, 36.088,  &
      35.154, 35.81, 45.408, 44.644, 44.097, 43.573, 44.254, 43.294, 43.82,  &
      43.417, 43.417, 44.313, 44.342, 43.993, 45.203, 43.687, 45.53, 44.979,  &
      44.345, 43.014, 44.002, 43.439, 44.462, 44.386, 43.439, 42.768, 44.876,  &
      43.355, 42.866, 39.965, 41.579, 40.267, 41.308, 39.279, 38.788, 40.583,  &
      38.763, 39.012, 39.079, 40.714, 38.026, 41.436, 38.866, 41.415, 39.782,  &
      38.406, 41.326, 39.637, 41.127, 39.163, 39.606, 38.197, 40.131, 39.196,  &
      37.169, 36.877, 39.772, 38.344, 38.865, 44.52, 38.047, 38.082, 46.108,  &
      44.834, 36.76, 36.761, 38.329, 44.756, 38.472, 43.092, 39.311, 43.965,  &
      37.752, 45.816, 39.134, 42.004, 43.534, 36.672, 45.24, 37.723, 45.287,  &
      37.542, 43.326, 38.801, 43.159, 44.513, 39.653, 38.625, 36.219, 39.058,  &
      38.199, 43.762, 37.566, 43.877, 38.485, 44.903, 45.269, 37.015, 43.988,  &
      39.339, 36.204, 43.947, 36.594, 40.164, 42.37, 42.352, 37.482, 44.261,  &
      37.63, 45.769, 38.796, 39.149, 39.425, 45.881, 44.191, 42.141, 45.302,  &
      39.723, 42.173, 36.543, 43.703, 39.086, 44.479, 37.323, 44.837, 40.315,  &
      45.18, 39.134, 39.359, 44.579, 36.893, 42.141, 38.957, 45.137, 37.118,  &
      37.086, 36.807, 37.808, 44.834, 36.562, 45.054, 45.318, 45.267, 30.336,  &
      26.842, 27.477, 27.383, 28.358, 29.924, 28.695, 30.365, 27.645, 28.502,  &
      29.604, 27.486, 28.468, 29.366, 27.879, 30.228, 29.941, 30.569, 28.173,  &
      42.063, 41.028, 40.376, 40.853, 40.242, 41.521, 41.393, 41.102, 42.812,  &
      41.411, 40.842, 40.611, 41.243, 40.122, 40.045, 41.402, 40.916, 40.864,  &
      40.562, 40.429, 40.653, 40.744, 40.71, 40.185, 40.485, 40.651, 41.989,  &
      41.077, 41.12, 42.443, 40.984, 41.435, 41.805, 40.898, 41.113, 42.861,  &
      41.183, 40.907, 42.224, 41.829, 40.836, 45.619, 43.611, 45.846, 45.245,  &
      43.634, 45.382, 44.602, 47.421, 45.303, 43.623, 46.298, 45.137, 44.022,  &
      43.623, 45.471, 44.481, 43.83, 47.45, 46.661, 45.065, 45.437, 47.753,  &
      46.467, 45.021, 46.767, 44.019, 44.551, 47.89, 43.601, 46.748, 40.014,  &
      40.789, 40.571, 41.173, 40.341, 40.233, 40.404, 38.196, 40.96, 40.257,  &
      39.614, 39.315, 40.463, 40.636, 39.192, 40.432, 41.313, 39.71, 38.275,  &
      40.851, 39.417, 38.363, 41.402, 39.786, 41.282, 40.383, 40.34, 41.632,  &
      39.027, 40.022, 41.45, 39.02, 40.716, 38.664, 41.277, 40.469, 39.373,  &
      41.64, 40.05, 38.709, 40.7, 37.922, 40.122, 41.427, 41.672, 39.888, 40.992,  &
      38.97, 41.274, 38.327, 40.866, 38.539, 40.721, 41.299, 40.412, 38.333,  &
      40.906, 39.794, 41.039, 39.755, 39.589, 38.583, 38.627, 38.909, 39.486,  &
      40.114, 41.449, 39.081, 41.366, 39.353, 40.207, 40.187, 40.45, 38.625,  &
      40.771, 41.405, 41.19, 38.628, 41.51, 41.034, 40.146, 44.114, 42.85,  &
      44.352, 43.582, 44.507, 43.987, 44.59, 44.902, 44.111, 37.853, 44.52,  &
      38.982, 38.113, 38.33, 43.865, 43.737, 38.444, 45.596, 39.78, 44.281,  &
      37.685, 39.311, 38.776, 44.229, 36.715, 43.671, 43.111, 45.694, 36.41,  &
      37.913, 44.835, 39.23, 37.103, 45.381, 37.915, 38.318, 45.971, 37.952,  &
      42.589, 37.986, 45.069, 37.627, 44.982, 39.915, 44.794, 43.363, 38.651,  &
      36.837, 39.412, 44.381, 36.991, 45.427, 38.132, 44.588, 38.643, 42.946,  &
      40.059, 44.032, 44.358, 38.929, 45.095, 38.429, 39.296, 38.182, 38.722,  &
      38.784, 38.219, 38.52, 36.706, 38.711, 37.227, 38.518, 38.807, 34.157,  &
      32.997, 34.418, 33.437, 33.279, 33.223, 33.885, 32.326, 34.506, 34.58,  &
      34.203, 34.217, 32.639, 34.667, 35.114, 34.683, 34.405, 35.092, 33.784,  &
      33.295, 34.384, 33.758, 34.111, 35.033, 33.292, 34.583, 44.245, 46.263,  &
      45.239, 44.76, 47.86, 47.195, 44.802, 44.702, 47.393, 44.857, 48.555,  &
      43.609, 44.645, 44.015, 44.422, 44.097, 44.449, 45.329, 45.109, 45.906,  &
      45.954, 44.464, 43.637, 44.119, 44.421, 45.66, 45.744, 44.933, 44.428,  &
      45.271, 45.057, 46.398, 45.822, 45.564, 45.221, 44.515, 44.282, 45.47,  &
      44.421, 44.758, 44.059, 46.899, 46.582, 45.808, 44.191, 43.985, 44.155,  &
      45.537, 44.528, 44.528, 43.892, 45.078, 48.827, 45.673, 43.955, 45.467,  &
      45.331, 43.97, 44.283, 45.712, 44.285, 46.346, 43.837, 48.053, 47.017,  &
      47.458, 44.824, 46.421, 46.239, 44.062, 44.949, 45.09, 43.851, 43.997,  &
      43.602, 45.415, 44.279, 44.332, 42.777, 41.052, 44.497, 42.734, 41.221,  &
      44.215, 41.488, 43.415, 41.764, 42.815, 41.249, 43.84, 43.549, 44.774,  &
      44.374, 43.27, 44.895, 44.153, 44.308, 40.754, 40.894, 40.875, 40.404,  &
      41.493, 40.835, 41.818, 39.677, 39.28, 39.833, 39.979, 40.323, 41.255,  &
      38.951, 39.276, 40.867, 40.612, 41.323, 41.455, 40.778, 40.244, 39.734,  &
      39.959, 40.688, 40.941, 40.565, 39.735, 40.531, 41.531, 39.315, 39.557,  &
      41.089, 41.279, 40.471, 40.84, 39.771, 41.876, 40.24, 40.105, 39.712,  &
      40.787, 39.783, 39.498, 41.24, 40.816, 41.566, 40.823, 39.723, 40.993,  &
      41.128, 41.292, 40.71, 41.231, 41.769, 41.507, 38.839, 39.464, 39.337,  &
      40.074, 41.279, 39.176, 39.019, 39.639, 41.727, 40.136, 40.612, 41.2,  &
      39.67, 39.631, 40.642, 40.762, 41.021, 39.518, 39.875, 41.263, 38.84,  &
      39.641, 40.645, 40.666, 40.509, 40.2, 41.409, 39.46, 40.528, 37.185, 34.14,  &
      32.829, 32.249, 34.333, 32.108, 34.433, 33.645, 33.819, 34.072, 34.609,  &
      34.473, 33.66, 34.132, 34.651, 34.179, 34.256, 33.411, 34.747, 33.412,  &
      32.448, 34.845, 33.987, 34.651, 34.839, 33.792, 32.265, 34.688, 32.873,  &
      34.334, 34.718, 34.973, 41.869, 40.385, 40.73, 40.003, 40.877, 40.398,  &
      40.943, 39.775, 41.218, 41.142, 40.335, 40.787, 41.795, 39.85, 41.178,  &
      40.988, 41.908, 40.409, 40.96, 41.072, 39.944, 40.453, 41.854, 40.814,  &
      40.134, 41.49, 41.985, 39.995, 39.861, 41.362, 41.327, 41.125, 39.726,  &
      40.054, 40.875, 41.518, 40.81, 40.451, 40.52, 41.148, 40.854, 40.212,  &
      41.651, 40.748, 40.491, 39.971, 39.912, 40.267, 40.546, 40.207, 39.723,  &
      41.067, 40.559, 41.732, 40.287, 39.822, 41.578, 41.199/)
!
      lat2_regions = (/44.364, 44.987, 44.426, 44.457, 43.957, 45.191, 44.235, 46.881, 43.441,  &
      44.565, 44.697, 46.147, 43.419, 44.152, 44.517, 45.675, 44.8, 43.922, 43.2,  &
      46.706, 44.134, 44.579, 43.479, 44.801, 44.256, 44.628, 41.567, 41.627,  &
      41.67, 42.006, 41.697, 41.629, 41.762, 41.526, 41.577, 41.541, 41.625,  &
      42.431, 42.032, 41.948, 41.646, 41.799, 42.474, 42.799, 43.238, 43.731,  &
      48.709, 42.612, 42.611, 47.803, 43.901, 42.582, 42.948, 45.937, 43.549,  &
      43.628, 43.598, 42.747, 47.553, 43.73, 43.536, 46.435, 46.759, 43.172,  &
      43.07, 39.823, 40.948, 40.598, 40.557, 40.021, 41.126, 40.238, 41.185,  &
      41.377, 40.138, 41.226, 40.401, 41.286, 40.504, 41.071, 40.494, 41.132,  &
      42.256, 40.739, 41.483, 40.668, 40.642, 40.95, 40.593, 40.843, 41.335,  &
      40.436, 40.407, 40.732, 40.968, 39.966, 40.588, 41.111, 41.439, 40.399,  &
      41.451, 41.143, 41.664, 40.822, 40.827, 40.093, 41.033, 41.085, 40.042,  &
      40.891, 39.771, 40.931, 41.966, 40.843, 41.64, 41.796, 41.183, 41.607,  &
      40.705, 41.907, 40.097, 41.962, 39.919, 41.337, 40.596, 40.101, 41.863,  &
      33.846, 32.509, 32.711, 27.785, 30.381, 32.433, 35.324, 32.354, 33.435,  &
      32.235, 33.162, 33.312, 30.743, 31.761, 30.803, 30.203, 29.025, 30.302,  &
      28.448, 29.966, 30.203, 31.204, 32.286, 27.595, 29.82, 33.606, 35.71,  &
      37.152, 38.607, 37.363, 39.169, 36.925, 37.28, 37.094, 38.65, 37.762,  &
      38.171, 36.821, 37.837, 36.978, 38.276, 37.843, 37.2, 38.083, 38.502,  &
      38.422, 36.746, 37.326, 36.711, 38.378, 38.97, 36.729, 37.445, 38.295,  &
      38.489, 38.293, 38.038, 37.942, 38.391, 36.794, 36.919, 37.823, 38.678,  &
      37.559, 36.885, 36.785, 37.001, 38.262, 37.35, 37.132, 39.157, 37.122,  &
      37.778, 37.462, 37.102, 38.26, 37.029, 36.782, 36.749, 38.221, 39.011,  &
      38.064, 37.951, 37.184, 38.305, 37.321, 37.573, 38.298, 37.418, 39.262,  &
      38.944, 36.974, 43.75, 48.193, 44.1, 46.508, 47.517, 42.964, 42.119,  &
      47.827, 43.878, 43.699, 42.637, 43.976, 47.333, 45.196, 48.323, 43.401,  &
      42.696, 43.718, 42.609, 44.268, 42.784, 39.657, 39.645, 39.341, 38.593,  &
      39.065, 38.763, 39.24, 38.419, 38.005, 39.727, 38.373, 38.897, 38.82,  &
      39.766, 38.711, 39.568, 39.296, 38.504, 39.834, 39.463, 38.321, 38.389,  &
      38.504, 39.696, 39.436, 39.807, 38.093, 39.164, 38.621, 38.236, 38.954,  &
      38.853, 39.461, 39.674, 39.644, 38.694, 39.846, 39.58, 39.621, 39.012,  &
      37.494, 39.237, 39.426, 39.464, 37.251, 40.116, 39.566, 40.276, 38.856,  &
      39.317, 38.486, 39.422, 38.914, 39.137, 37.375, 40.54, 38.777, 40.022,  &
      37.372, 39.666, 40.548, 39.668, 40.393, 39.73, 40.175, 38.407, 40.657,  &
      33.591, 29.323, 31.163, 29.087, 32.77, 30.196, 33.238, 29.8, 33.203, 26.14,  &
      31.771, 34.104, 30.78, 36.055, 30.551, 30.883, 35.925, 32.593, 35.041,  &
      29.896, 28.548, 32.186, 29.367, 31.825, 34.442, 32.402, 33.627, 32.459,  &
      30.377, 31.797, 32.418, 31.845, 30.72, 32.412, 29.723, 31.917, 29.985,  &
      33.267, 30.469, 27.928, 32.131, 28.454, 31.405, 31.341, 28.728, 29.143,  &
      33.054, 36.076, 33.245, 30.131, 33.256, 30.336, 29.42, 33.276, 33.154,  &
      32.982, 29.205, 31.24, 28.698, 34.561, 32.105, 35.895, 29.602, 28.786,  &
      32.409, 28.998, 29.234, 34.044, 30.378, 30.151, 32.201, 32.367, 31.528,  &
      31.772, 27.242, 33.186, 29.165, 33.995, 32.787, 30.918, 30.308, 34.649,  &
      35.676, 33.659, 29.336, 31.492, 30.202, 32.756, 29.536, 33.138, 39.418,  &
      34.397, 32.978, 31.37, 33.84, 34.39, 34.879, 31.052, 32.706, 30.915,  &
      33.787, 32.978, 31.144, 34.23, 40.118, 40.274, 39.953, 39.574, 39.179,  &
      40.484, 38.564, 39.656, 40.349, 40.088, 38.02, 38.11, 38.077, 39.3, 40.028,  &
      40.21, 37.593, 38.566, 39.599, 37.293, 38.344, 39.569, 38.063, 39.487,  &
      38.57, 40.552, 39.559, 39.675, 40.527, 40.648, 37.197, 39.653, 37.642,  &
      40.755, 39.026, 40.138, 36.896, 37.9, 37.469, 36.874, 37.658, 37.04,  &
      36.884, 37.388, 38.7, 37.32, 39.487, 36.689, 37.132, 38.803, 36.99, 38.404,  &
      37.676, 37.952, 38.123, 36.914, 38.438, 38.228, 36.761, 36.522, 38.323,  &
      37.029, 38.361, 36.909, 37.808, 37.303, 37.591, 36.898, 37.189, 38.639,  &
      37.716, 37.577, 37.631, 38.088, 37.588, 37.525, 38.17, 37.218, 38.14,  &
      38.476, 38.801, 37.434, 37.193, 37.35, 36.801, 38.764, 36.669, 36.888,  &
      32.522, 32.693, 30.247, 30.617, 33.169, 31.532, 32.39, 32.518, 31.721,  &
      26.271, 33.179, 30.9, 27.323, 30.114, 32.197, 33.828, 34.851, 29.187,  &
      32.032, 32.498, 29.371, 33.485, 30.564, 30.258, 30.769, 27.936, 33.976,  &
      33.251, 32.012, 30.967, 28.994, 30.511, 33.1, 28.902, 32.597, 28.833,  &
      31.87, 30.094, 32.464, 31.162, 30.697, 27.542, 33.283, 30.49, 29.932,  &
      30.456, 30.483, 30.43, 29.204, 32.763, 31.09, 27.655, 33.604, 30.093,  &
      32.542, 33.939, 30.76, 30.769, 29.899, 32.646, 33.691, 31.41, 29.708,  &
      29.247, 26.451, 31.457, 33.348, 30.978, 30.228, 32.232, 30.379, 30.603,  &
      31.334, 32.571, 28.114, 35.084, 31.712, 32.065, 32.713, 32.842, 31.609,  &
      29.896, 33.217, 33.199, 34.243, 31.682, 30.411, 29.409, 33.481, 33.803,  &
      31.009, 32.906, 33.194, 32.591, 34.255, 30.727, 34.654, 32.525, 31.339,  &
      31.386, 31.932, 31.448, 33.725, 34.897, 30.44, 34.499, 34.073, 31.053,  &
      30.527, 31.853, 34.257, 34.161, 34.096, 34.969, 31.362, 34.925, 31.54,  &
      33.91, 33.304, 30.931, 31.546, 32.598, 34.515, 33.028, 33.981, 31.296,  &
      31.491, 33.627, 30.707, 33.955, 34.545, 33.182, 30.607, 34.607, 34.696,  &
      32.457, 35.056, 33.792, 33.773, 33.338, 33.47, 32.577, 31.947, 31.862,  &
      33.334, 32.46, 32.161, 32.903, 32.59, 33.285, 32.426, 32.763, 33.581,  &
      32.444, 31.98, 31.457, 33.636, 33.433, 35.193, 34.628, 32.993, 36.171,  &
      34.805, 33.069, 37.016, 32.992, 31.963, 34.78, 31.372, 34.14, 32.798,  &
      33.362, 35.292, 33.079, 35.762, 33.432, 34.939, 36.735, 35.276, 34.588,  &
      38.234, 37.696, 38.085, 37.373, 36.652, 37.912, 37.838, 37.142, 37.861,  &
      38.239, 37.546, 36.639, 38.793, 37.76, 37.132, 37.825, 36.89, 36.77,  &
      38.238, 37.219, 37.554, 37.872, 37.972, 38.089, 36.764, 37.708, 38.694,  &
      37.88, 38.039, 41.513, 38.093, 38.052, 39.028, 40.994, 35.199, 35.231,  &
      38.993, 33.357, 36.016, 35.458, 34.927, 34.276, 37.39, 37.01, 33.005,  &
      40.926, 35.141, 33.133, 38.598, 34.28, 35.584, 36.534, 39.818, 37.13,  &
      39.009, 38.978, 38.833, 36.18, 39.119, 39.228, 38.044, 36.123, 39.982,  &
      40.405, 41.867, 38.59, 35.791, 33.991, 37.933, 38.473, 36.996, 35.993,  &
      39.956, 32.876, 35.665, 37.807, 38.701, 40.865, 38.327, 34.418, 36.883,  &
      38.516, 39.472, 35.274, 40.619, 34.827, 36.923, 38.306, 27.96, 31.946,  &
      33.38, 30.845, 30.736, 28.734, 31.813, 33.23, 35.583, 33.701, 28.924,  &
      33.066, 32.402, 31.441, 36.407, 33.416, 33.023, 34.263, 28.986, 30.193,  &
      26.151, 28.649, 33.206, 29.05, 30.105, 27.369, 29.58, 32.808, 26.509,  &
      28.325, 27.367, 26.43, 26.254, 27.811, 30.673, 28.147, 31.826, 31.545,  &
      29.777, 27.775, 33.37, 29.93, 31.205, 29.693, 29.798, 29.618, 32.733,  &
      33.704, 33.789, 30.438, 28.047, 33.463, 30.027, 32.762, 30.585, 36.206,  &
      32.988, 32.958, 32.241, 26.321, 33.159, 32.24, 29.054, 32.496, 27.99,  &
      33.175, 30.615, 31.664, 31.207, 32.764, 29.492, 31.46, 30.966, 34.555,  &
      32.459, 29.243, 32.542, 32.446, 34.168, 28.896, 31.688, 32.801, 31.824,  &
      29.172, 29.699, 32.929, 29.356, 33.69, 34.017, 32.726, 34.656, 34.173,  &
      32.467, 33.088, 36.843, 34.912, 31.516, 36.94, 34.168, 34.292, 33.885,  &
      32.352, 34.688, 33.691, 31.503, 32.91, 32.001, 34.516, 33.392, 32.512,  &
      32.62, 34.885, 34.295, 31.611, 34.522, 32.626, 33.3, 36.154, 32.555, 32.09,  &
      34.791, 33.772, 33.921, 33.986, 32.268, 35.264, 35.694, 35.053, 32.761,  &
      38.771, 39.34, 38.724, 38.943, 38.79, 38.697, 39.514, 38.99, 38.621,  &
      38.793, 38.484, 38.594, 40.437, 38.708, 40.908, 39.562, 40.845, 39.505,  &
      40.129, 41.108, 41.25, 39.658, 41.159, 41.08, 39.345, 40.578, 39.655,  &
      41.092, 41.853, 39.922, 39.578, 40.367, 40.344, 41.203, 39.125, 39.639,  &
      40.811, 39.664, 41.413, 43.875, 43.037, 42.959, 43.263, 42.289, 42.996,  &
      42.541, 42.906, 42.998, 37.188, 36.527, 39.276, 36.342, 39.385, 34.977,  &
      38.531, 37.262, 37.549, 36.372, 33.818, 38.831, 37.419, 36.875, 32.826,  &
      36.214, 39.285, 33.871, 38.384, 38.404, 38.989, 36.737, 36.235, 34.281,  &
      35.64, 34.642, 39.05, 39.171, 33.344, 39.265, 34.741, 36.27, 36.251,  &
      39.292, 37.731, 38.233, 34.719, 34.338, 37.09, 40.084, 35.689, 37.033,  &
      37.656, 37.865, 33.584, 36.773, 37.404, 33.717, 37.79, 35.071, 35.454,  &
      37.795, 41.441, 33.838, 38.364, 37.328, 35.058, 33.554, 37.374, 36.638,  &
      39.77, 36.566, 39.537, 34.468, 39.858, 36.622, 37.518, 38.31, 34.474,  &
      38.779, 37.301, 39.026, 36.095, 36.153, 39.823, 33.08, 38.196, 38.525,  &
      40.22, 40.732, 36.619, 39.705, 35.805, 35.666, 40.51, 38.195, 36.438,  &
      29.834, 32.977, 31.981, 30.049, 30.815, 29.32, 26.929, 42.933, 43.022,  &
      42.379, 41.222, 42.22, 42.01, 43.321, 43.258, 44.615, 42.308, 42.979,  &
      41.382, 43.066, 43.117, 42.979, 42.694, 41.474, 42.845, 43.325, 42.22,  &
      42.673, 42.367, 42.581, 42.293, 42.517, 42.507, 42.818, 41.767, 42.243,  &
      42.943, 42.816, 42.93, 43.449, 43.113, 44.349, 42.509, 43.435, 43.111,  &
      42.847, 42.984, 42.913, 42.404, 42.342, 43.068, 42.54, 42.177, 42.139,  &
      44.298, 42.991, 41.813, 43.064, 43.213, 43.798, 44.894, 44.963, 41.508,  &
      43.237, 41.518, 41.077, 41.698, 42.778, 43.079, 43.342, 42.568, 44.734,  &
      42.187, 43.149, 42.478, 43.494, 41.532, 42.157, 43.1, 42.682, 42.73,  &
      44.739, 41.422, 44.69, 42.57, 42.068, 41.94, 43.324, 43.307, 42.175,  &
      44.354, 43.19, 42.024, 42.335, 42.57, 43.004, 43.244, 34.247, 34.884,  &
      34.223, 38.912, 38.551, 36.862, 33.414, 38.139, 36.721, 36.615, 37.469,  &
      35.334, 34.472, 34.517, 37.197, 34.99, 34.39, 38.715, 36.708, 36.643,  &
      35.521, 34.762, 34.312, 36.489, 34.669, 38.387, 38.07, 38.98, 38.07,  &
      40.439, 35.172, 35.167, 35.971, 34.321, 36.066, 37.774, 39.374, 37.539,  &
      34.157, 34.252, 39.288, 38.453, 38.205, 34.76, 34.625, 36.393, 35.611,  &
      37.65, 37.02, 39.02, 39.166, 39.463, 39.539, 38.536, 36.428, 38.709,  &
      34.367, 38.414, 41.763, 39.178, 34.188, 43.196, 44.518, 42.897, 43.277,  &
      43.421, 43.312, 43.071, 43.408, 43.471, 43.159, 42.835, 42.982, 43.604,  &
      43.735, 44.318, 43.162, 43.391, 44.092, 42.922, 43.786, 43.496, 40.654,  &
      36.011, 39.217, 39.317, 40.879, 39.265, 41.747, 41.149, 41.054, 42.53,  &
      43.232, 43.344, 43.859, 44.25, 43.189, 42.464, 41.575, 42.181, 43.146,  &
      43.521, 42.762, 41.373, 41.646, 44.095, 42.399, 43.056, 42.142, 42.344,  &
      41.41, 41.618, 47.005, 48.522, 47.496, 48.908, 46.287, 49.002, 47.839,  &
      48.229, 48.271, 47.544, 46.309, 46.848, 47.897, 47.514, 46.836, 47.242,  &
      46.902, 48.565, 46.721, 46.331, 47.969, 46.906, 47.028, 47.34, 48.942,  &
      47.967, 45.839, 46.282, 46.354, 48.124, 45.743, 47.824, 46.054, 46.366,  &
      45.874, 48.409, 47.659, 46.221, 48.965, 46.222, 48.204, 46.742, 47.589,  &
      47.028, 47.234, 48.544, 47.846, 48.377, 46.561, 47.017, 47.146, 48.429,  &
      46.849, 48.957, 48.142, 48.078, 45.803, 48.143, 46.757, 47.248, 46.7,  &
      45.826, 48.035, 48.155, 47.291, 47.547, 39.515, 39.643, 38.976, 38.541,  &
      39.058, 36.336, 35.15, 36.621, 36.308, 40.825, 40.759, 39.317, 40.748,  &
      40.993, 38.998, 46.159, 45.817, 45.871, 45.75, 48.577, 46.032, 48.398,  &
      48.188, 48.644, 46.412, 45.262, 45.69, 48.234, 47.137, 47.551, 46.279,  &
      45.745, 48.56, 46.708, 48.269, 45.717, 47.084, 48.409, 45.686, 46.776,  &
      46.442, 46.978, 47.727, 48.123, 48.52, 47.73, 48.445, 48.103, 30.006,  &
      31.496, 30.769, 32.567, 32.804, 30.673, 32.71, 30.813, 30.361, 30.967,  &
      29.511, 30.422, 31.009, 30.247, 32.468, 30.511, 30.961, 30.122, 30.517,  &
      32.823, 31.656, 31.132, 29.89, 30.864, 29.587, 30.076, 30.675, 32.82,  &
      29.96, 30.251, 29.943, 29.779, 31.713, 30.261, 32.29, 30.024, 30.401,  &
      30.094, 30.379, 32.841, 31.17, 30.578, 47.828, 48.261, 47.886, 46.344,  &
      45.649, 46.436, 46.106, 46.464, 46.977, 47.495, 45.935, 46.738, 47.007,  &
      34.825, 34.689, 36.812, 35.087, 34.22, 36.822, 36.819, 35.16, 35.843,  &
      34.059, 34.64, 35.72, 35.479, 35.068, 36.343, 36.321, 35.524, 37.065,  &
      36.38, 36.015, 34.511, 34.565, 34.059, 35.434, 35.554, 36.449, 34.409,  &
      36.639, 35.899, 36.714, 35.498, 34.862, 34.958, 35.464, 35.039, 35.101,  &
      36.47, 34.023, 33.918, 35.87, 34.682, 34.855, 34.964, 34.106, 34.894,  &
      36.156, 34.667, 36.944, 35.427, 35.828, 35.31, 35.291, 36.714, 35.443,  &
      35.784, 35.647, 34.753, 36.685, 36.312, 36.774, 35.142, 36.322, 35.062,  &
      35.491, 35.315, 35.254, 35.405, 36.383, 35.27, 36.18, 35.842, 34.526,  &
      35.976, 36.7, 36.357, 35.295, 36.665, 35.977, 34.365, 30.693, 30.507,  &
      32.056, 31.583, 31.151, 32.657, 32.613, 29.728, 31.618, 31.806, 30.106,  &
      30.727, 30.847, 30.624, 30.018, 30.57, 30.264, 32.486, 32.578, 30.169,  &
      32.653, 30.392, 29.954, 33.019, 30.424, 32.425, 32.414, 30.717, 30.204,  &
      32.899, 30.247, 31.953, 32.191, 33.843, 34.005, 34.338, 33.205, 34.686,  &
      31.621, 32.64, 32.775, 34.022, 34.234, 33.807, 31.283, 33.566, 33.652,  &
      34.97, 32.007, 30.417, 33.096, 32.38, 34.286, 30.472, 33.458, 33.552,  &
      33.808, 30.516, 31.405, 31.89, 33.191, 34.801, 33.922, 33.471, 33.517,  &
      32.564, 33.08, 31.777, 33.427, 33.155, 30.934, 31.299, 33.127, 31.891,  &
      34.262, 35.375, 32.476, 33.458, 32.366, 34.53, 32.344, 34.415, 30.522,  &
      32.803, 30.624, 34.279, 32.268, 34.76, 33.747, 34.405, 34.636, 35.885,  &
      35.559, 35.162, 34.928, 36.448, 44.957, 44.62, 45.332, 45.17, 44.335,  &
      44.265, 46.606, 44.984, 43.491, 45.417, 43.508, 42.61, 43.983, 44.314,  &
      45.117, 43.151, 44.19, 42.634, 42.797, 43.016, 45.388, 44.045, 44.638,  &
      43.397, 42.647, 42.982, 46.9, 42.808, 45.001, 42.855, 42.758, 44.754,  &
      42.79, 43.929, 43.037, 44.71, 46.027, 43.464, 45.018, 45.866, 46.482,  &
      42.789, 43.1, 43.423, 42.668, 44.473, 43.964, 43.985, 45.484, 43.637,  &
      42.62, 43.101, 42.862, 43.327, 43.26, 44.19, 45.182, 43.186, 44.705,  &
      43.816, 43.513, 43.185, 45.154, 44.986, 45.21, 43.418, 45.363, 42.619,  &
      43.021, 42.958, 44.417, 45.137, 44.911, 44.893, 44.049, 43.632, 42.943,  &
      45.362, 44.103, 45.08, 42.754, 43.78, 43.575, 43.087, 43.3, 33.493, 34.722,  &
      34.338, 34.171, 31.701, 33.651, 30.871, 33.507, 32.897, 32.984, 35.388,  &
      32.885, 36.873, 32.782, 36.738, 32.465, 32.053, 34.454, 32.305, 35.113,  &
      35.558, 32.079, 36.149, 32.449, 36.824, 35.575, 35.194, 32.803, 32.85,  &
      36.764, 32.446, 35.654, 35.913, 34.871, 32.981, 35.911, 34.201, 36.92,  &
      33.452, 33.38, 35.726, 34.95, 35.555, 36.824, 32.827, 34.098, 36.476,  &
      33.211, 35.19, 33.086, 32.173, 35.831, 35.094, 34.154, 33.749, 35.329,  &
      35.817, 35.086, 36.394, 35.979, 35.15, 34.911, 33.608, 36.331, 35.502,  &
      35.125, 36.425, 33.186, 34.064, 33.542, 44.768, 44.675, 42.821, 43.56,  &
      45.675, 45.537, 43.362, 43.86, 44.901, 42.583, 44.53, 44.822, 43.845,  &
      45.152, 43.966, 45.839, 44.973, 44.586, 44.861, 44.026, 45.496, 42.71,  &
      43.578, 42.564, 43.201, 43.217, 44.372, 43.651, 45.025, 44.081, 43.533,  &
      42.857, 44.146, 44.434, 44.336, 42.079, 42.277, 42.554, 43.422, 42.935,  &
      45.102, 42.369, 44.552, 43.824, 42.385, 43.701, 43.116, 42.165, 41.976,  &
      43.745, 41.862, 45.234, 42.115, 44.293, 43.525, 43.234, 45.346, 42.654,  &
      45.679, 42.333, 43.867, 41.977, 41.86, 43.078, 42.891, 42.754, 42.683,  &
      41.999, 41.973, 42.946, 44.304, 42.529, 41.77, 45.874, 43.207, 42.672,  &
      43.35, 43.486, 45.046, 43.998, 42.926, 43.198, 44.693, 43.206, 42.682,  &
      44.075, 43.711, 42.681, 41.997, 42.866, 34.304, 33.911, 33.28, 34.562,  &
      36.513, 33.843, 35.044, 35.522, 35.252, 36.344, 35.239, 33.245, 36.282,  &
      35.524, 34.573, 33.698, 34.538, 34.688, 35.917, 33.369, 35.039, 34.795,  &
      33.654, 33.31, 34.404, 35.906, 34.787, 34.599, 33.661, 35.191, 36.382,  &
      33.967, 35.641, 35.771, 35.509, 36.1, 35.306, 36.4, 34.301, 36.293, 35.992,  &
      33.815, 35.337, 35.287, 34.326, 36.276, 34.523, 33.506, 36.544, 35.693,  &
      34.925, 36.086, 33.632, 35.257, 31.186, 31.677, 31.571, 32.119, 31.719,  &
      34.051, 34.386, 33.628, 30.947, 33.076, 31.812, 31.337, 31.401, 33.745,  &
      31.305, 31.915, 30.902, 34.57, 31.249, 33.659, 34.277, 34.042, 35.306,  &
      32.177, 34.963, 34.615, 32.419, 34.275, 31.996, 34.622, 31.792, 34.566,  &
      34.944, 31.412, 31.791, 31.059, 42.819, 47.147, 44.408, 43.051, 43.024,  &
      46.102, 46.526, 42.349, 42.391, 44.753, 46.278, 42.857, 43.114, 47.266,  &
      42.966, 44.007, 44.304, 45.991, 46.594, 42.305, 41.781, 42.726, 43.781,  &
      42.105, 42.008, 43.634, 46.433, 43.325, 43.425, 46.357, 42.479, 43.034,  &
      42.266, 42.229, 42.848, 45.422, 43.23, 42.9, 42.839, 45.437, 43.53, 45.907,  &
      43.018, 43.433, 46.502, 42.08, 41.886, 42.43, 42.651, 43.169, 41.825,  &
      42.024, 41.827, 44.925, 43.382, 42.689, 43.478, 42.715, 41.631, 41.041,  &
      43.09, 42.109, 42.123, 41.414, 42.303, 42.082, 40.858, 41.526, 42.093,  &
      42.089, 40.757, 41.033, 43.083, 42.768, 40.764, 42.741, 43.17, 41.888,  &
      43.386, 41.076, 41.681, 43.331, 42.038, 41.777, 41.843, 42.579, 42.495,  &
      42.681, 43.127, 43.425, 31.555, 32.59, 32.217, 33.347, 34.137, 34.714,  &
      31.763, 30.865, 33.063, 32.575, 34.437, 31.963, 33.249, 33.022, 33.59,  &
      33.446, 34.384, 32.296, 31.885, 31.905, 31.061, 33.32, 34.504, 34.167,  &
      31.692, 34.81, 33.107, 31.046, 30.706, 31.768, 33.03, 34.416, 32.947,  &
      32.095, 33.618, 32.873, 32.42, 33.201, 32.822, 33.85, 32.324, 33.319,  &
      31.241, 31.226, 34.435, 31.633, 31.145, 30.804, 32.11, 32.318, 34.058,  &
      34.364, 34.31, 30.85, 31.222, 33.011, 32.238, 33.68, 32.388, 33.296,  &
      32.391, 32.521, 34.561, 32.636, 32.772, 31.556, 32.953, 30.919, 33.51,  &
      31.493, 34.612, 34.911, 32.026, 32.283, 31.007, 32.254, 32.106, 32.72,  &
      33.749, 31.292, 33.109, 34.048, 32.772, 33.927, 44.769, 41.82, 43.072,  &
      41.655, 44.837, 43.661, 42.093, 42.621, 41.95, 43.063, 42.268, 42.648,  &
      42.367, 42.701, 41.297, 42.973, 41.854, 42.773, 42.281, 42.671, 42.107,  &
      42.066, 42.518, 41.471, 42.312, 40.751, 41.592, 40.568, 39.039, 40.439,  &
      41.418, 39.48, 40.179, 40.455, 40.293, 40.006, 39.751, 39.73, 40.632,  &
      38.984, 41.194, 41.312, 41.525, 41.306, 40.869, 41.043, 39.53, 41.165,  &
      40.182, 40.118, 41.588, 40.527, 39.499, 40.558, 40.936, 41.493, 41.079,  &
      40.908, 40.336, 40.026, 41.143, 40.858, 40.136, 40.894, 40.241, 40.597,  &
      39.575, 41.577, 39.155, 41.185, 39.95, 40.289, 38.809, 41.069, 39.463,  &
      40.874, 39.815, 41.358, 40.047, 40.816, 41.214, 39.006, 37.484, 39.695,  &
      39.604, 40.036, 41.37, 38.025, 40.569, 41.346, 38.636, 40.567, 42.155,  &
      37.051, 40.604, 37.407, 41.032, 43.279, 42.558, 40.641, 43.113, 41.073,  &
      41.762, 42.76, 41.667, 42.743, 41.912, 42.489, 41.385, 41.791, 42.537,  &
      42.035, 40.441, 41.339, 42.803, 42.519, 42.08, 42.07, 43.198, 41.568,  &
      42.255, 40.989, 41.936, 41.479, 42.034, 43.068, 41.73, 42.695, 41.377,  &
      42.04, 43.027, 43.295, 41.048, 41.336, 41.072, 41.43, 41.86, 41.794,  &
      41.032, 43.213, 42.115, 43.196, 40.776, 43.411, 43.099, 42.609, 43.183,  &
      43.471, 42.677, 42.195, 42.0, 41.785, 42.182, 41.315, 42.57, 43.29, 42.755,  &
      42.482, 41.59, 41.681, 41.597, 41.347, 36.308, 35.453, 35.716, 35.865,  &
      35.846, 35.405, 35.428, 34.068, 35.277, 36.247, 35.291, 35.422, 34.564,  &
      36.151, 36.174, 35.853, 35.407, 35.062, 35.741, 35.406, 36.722, 35.379,  &
      36.137, 36.542, 42.074, 44.037, 37.743, 38.08, 37.43, 39.013, 38.577,  &
      39.364, 39.456, 40.694, 38.949, 39.541, 38.948, 39.357, 37.718, 39.484,  &
      37.838, 37.982, 38.11, 39.491, 39.043, 38.212, 39.08, 39.696, 37.413,  &
      39.716, 37.714, 39.615, 39.374, 39.006, 39.189, 38.883, 38.972, 38.834,  &
      39.433, 39.238, 38.527, 38.824, 38.31, 40.541, 37.474, 39.065, 40.194,  &
      37.808, 47.286, 46.903, 48.143, 46.914, 48.433, 47.973, 46.95, 46.773,  &
      48.283, 48.433, 48.378, 46.94, 48.195, 38.944, 37.1, 39.595, 37.72, 38.797,  &
      39.153, 37.089, 39.474, 38.21, 37.706, 39.397, 39.403, 37.182, 39.581,  &
      38.986, 37.792, 37.85, 38.746, 38.441, 38.95, 37.839, 37.85, 37.091,  &
      38.004, 38.296, 37.523, 39.366, 38.393, 38.915, 38.155, 39.866, 38.36,  &
      37.847, 39.297, 38.629, 38.102, 40.428, 39.315, 38.584, 40.164, 39.525,  &
      37.939, 38.021, 40.231, 40.204, 42.106, 39.947, 42.022, 41.9, 40.428,  &
      38.069, 41.111, 39.153, 37.835, 40.792, 40.753, 40.739, 40.758, 38.398,  &
      38.686, 42.337, 42.432, 40.995, 41.469, 42.11, 40.482, 39.142, 40.775,  &
      38.909, 42.106, 37.79, 42.446, 40.312, 40.357, 38.787, 39.174, 38.939,  &
      40.48, 39.76, 39.139, 37.829, 41.276, 41.26, 41.651, 38.746, 42.395,  &
      40.358, 40.168, 39.205, 40.554, 38.104, 40.485, 40.223, 42.266, 41.347,  &
      39.41, 38.511, 39.498, 41.568, 40.81, 37.179, 38.47, 41.177, 40.932,  &
      40.068, 41.409, 41.825, 38.446, 42.062, 39.996, 38.37, 37.809, 38.355,  &
      38.549, 38.998, 39.309, 38.758, 42.032, 41.39, 39.406, 39.643, 39.609,  &
      40.524, 36.083, 36.373, 34.644, 36.296, 36.189, 35.087, 34.513, 35.625,  &
      35.305, 35.811, 35.391, 35.224, 35.418, 35.506, 36.229, 35.683, 35.431,  &
      34.455, 34.948, 36.373, 35.952, 36.078, 33.963, 34.85, 36.433, 36.232,  &
      35.341, 35.322, 35.595, 35.22, 34.833, 35.411, 35.547, 35.305, 36.121,  &
      34.706, 35.598, 35.937, 35.725, 36.424, 35.923, 34.832, 36.563, 35.216,  &
      36.447, 34.002, 35.177, 36.237, 33.962, 36.345, 34.716, 29.818, 35.233,  &
      35.751, 29.78, 35.877, 27.311, 36.071, 26.726, 35.754, 34.828, 24.709,  &
      36.388, 30.462, 34.865, 30.813, 36.511, 26.421, 34.986, 26.8, 36.054,  &
      28.702, 36.453, 26.773, 33.963, 30.714, 34.847, 30.801, 35.559, 26.767,  &
      35.29, 30.216, 35.347, 29.528, 35.764, 30.833, 35.607, 27.869, 38.529,  &
      39.474, 37.188, 38.109, 37.263, 37.951, 39.124, 39.405, 37.663, 38.197,  &
      39.012, 39.368, 37.07, 38.587, 38.637, 38.357, 38.4, 39.26, 39.857, 37.44,  &
      38.086, 39.843, 38.648, 38.517, 38.645, 38.597, 37.364, 39.776, 37.47,  &
      37.661, 37.585, 38.904, 39.914, 39.836, 39.208, 38.885, 38.493, 38.77,  &
      39.129, 39.158, 37.594, 39.217, 37.295, 37.854, 37.267, 35.327, 36.303,  &
      35.521, 35.498, 35.797, 35.293, 36.744, 35.615, 36.083, 36.27, 35.311,  &
      35.702, 36.232, 35.606, 36.011, 36.049, 35.531, 36.109, 35.426, 36.131,  &
      36.138, 36.208, 35.386, 36.047, 36.018, 35.187, 36.24, 35.892, 35.976,  &
      35.491, 35.57, 35.855, 35.755, 35.12, 36.477, 36.656, 36.144, 36.566,  &
      36.414, 35.285, 36.276, 35.478, 35.714, 36.417, 36.154, 40.932, 41.343,  &
      41.386, 40.026, 38.093, 39.634, 40.899, 41.408, 39.999, 40.327, 38.22,  &
      39.023, 41.963, 42.493, 40.134, 40.142, 38.872, 38.65, 39.424, 38.426,  &
      38.155, 39.921, 39.03, 38.041, 41.828, 41.162, 39.611, 39.567, 38.618,  &
      39.821, 39.016, 39.545, 38.379, 40.793, 37.928, 39.492, 42.389, 42.351,  &
      38.294, 37.65, 39.237, 37.773, 39.367, 40.32, 39.373, 40.622, 39.166,  &
      40.543, 37.235, 40.653, 37.06, 41.853, 39.279, 38.589, 41.062, 39.555,  &
      39.732, 41.536, 40.731, 37.857, 39.704, 40.481, 38.786, 40.317, 37.189,  &
      40.834, 39.996, 40.675, 40.773, 40.569, 41.749, 40.492, 38.787, 36.988,  &
      36.972, 40.282, 37.632, 39.025, 39.381, 36.715, 39.805, 39.145, 37.658,  &
      38.273, 38.646, 38.019, 39.768, 39.378, 37.205, 36.205, 36.701, 34.569,  &
      29.648, 35.336, 28.926, 35.954, 30.771, 34.74, 29.141, 34.195, 27.779,  &
      35.929, 30.693, 35.936, 27.824, 35.392, 30.535, 34.99, 28.435, 34.783,  &
      27.76, 35.065, 29.774, 35.599, 26.255, 35.864, 30.975, 35.272, 34.351,  &
      35.867, 30.656, 34.393, 29.853, 35.797, 29.068, 36.011, 26.447, 36.343,  &
      36.146, 27.038, 29.708, 30.521, 30.534, 26.957, 25.185, 29.823, 24.608,  &
      28.421, 26.787, 29.087, 29.194, 30.032, 30.236, 28.193, 28.816, 27.355,  &
      28.971, 30.315, 30.308, 30.481, 24.777, 30.798, 29.038, 26.999, 26.845,  &
      30.592, 27.112, 29.293, 29.209, 27.28, 26.322, 28.841, 26.867, 29.701,  &
      28.516, 29.661, 30.322, 30.348, 30.17, 28.218, 28.099, 29.849, 27.513,  &
      30.602, 29.146, 28.54, 30.019, 35.717, 35.549, 35.549, 36.374, 35.849,  &
      35.958, 36.163, 36.284, 36.508, 35.564, 35.994, 36.511, 35.992, 36.51,  &
      36.201, 35.263, 36.527, 36.342, 36.433, 35.233, 35.787, 36.439, 35.253,  &
      35.21, 35.895, 35.522, 35.972, 36.023, 36.538, 35.799, 36.078, 35.63,  &
      35.985, 35.417, 36.459, 36.112, 36.115, 35.276, 35.833, 45.492, 44.692,  &
      44.165, 43.628, 44.33, 43.311, 43.834, 43.443, 43.449, 44.396, 44.386,  &
      44.022, 45.233, 43.768, 45.554, 45.008, 44.397, 43.034, 44.237, 43.624,  &
      44.532, 44.428, 43.468, 42.794, 44.951, 43.386, 42.916, 40.28, 41.722,  &
      40.303, 41.443, 39.343, 38.92, 40.672, 38.819, 39.04, 39.246, 40.786,  &
      38.063, 41.461, 38.889, 41.437, 39.821, 38.477, 42.493, 39.69, 41.18,  &
      39.363, 39.715, 38.311, 40.15, 39.224, 37.205, 36.936, 39.835, 38.398,  &
      39.054, 44.727, 38.077, 38.163, 46.213, 44.856, 36.818, 36.798, 38.366,  &
      44.805, 38.53, 43.133, 39.373, 44.159, 37.941, 45.851, 39.163, 42.092,  &
      43.599, 36.732, 45.295, 37.861, 45.351, 37.589, 43.466, 38.915, 43.194,  &
      44.651, 39.751, 38.678, 36.248, 39.095, 38.26, 43.813, 37.629, 43.938,  &
      38.681, 44.938, 45.343, 37.211, 44.152, 39.389, 36.277, 44.049, 36.664,  &
      40.232, 42.457, 42.538, 37.515, 44.287, 37.718, 45.929, 38.968, 39.2,  &
      39.46, 45.901, 44.233, 42.283, 45.348, 39.759, 42.204, 36.605, 43.761,  &
      39.136, 44.561, 37.363, 45.024, 40.373, 45.254, 39.19, 39.457, 44.668,  &
      36.943, 42.487, 38.993, 45.182, 37.158, 37.127, 36.891, 37.864, 44.872,  &
      36.609, 45.079, 45.386, 45.332, 30.403, 27.645, 27.937, 27.647, 28.617,  &
      29.983, 28.754, 30.624, 28.422, 28.72, 29.63, 27.649, 28.518, 29.406,  &
      28.226, 30.325, 29.988, 30.659, 28.471, 42.127, 41.049, 40.402, 40.88,  &
      40.292, 41.562, 41.424, 41.131, 42.844, 41.468, 40.874, 40.644, 41.271,  &
      40.167, 40.082, 41.475, 40.947, 40.989, 40.646, 40.456, 40.743, 40.798,  &
      40.896, 40.225, 40.511, 40.697, 42.063, 41.16, 41.156, 42.476, 41.028,  &
      41.465, 41.903, 40.93, 41.156, 42.889, 41.227, 40.929, 42.25, 41.855,  &
      40.901, 45.643, 43.702, 45.991, 45.272, 43.714, 45.425, 44.635, 47.534,  &
      45.329, 43.66, 46.417, 45.215, 44.054, 43.645, 45.598, 44.532, 43.862,  &
      47.503, 46.742, 45.092, 45.478, 47.804, 46.492, 45.055, 46.871, 44.04,  &
      44.581, 47.919, 43.683, 46.968, 40.081, 40.894, 40.599, 41.213, 40.385,  &
      40.295, 40.431, 38.258, 41.244, 40.31, 39.664, 39.362, 40.491, 40.678,  &
      39.282, 40.479, 41.34, 39.753, 38.322, 40.917, 40.179, 38.44, 41.472,  &
      39.806, 41.306, 40.572, 40.522, 41.673, 39.146, 40.083, 41.481, 39.056,  &
      40.779, 38.693, 41.338, 40.611, 39.476, 41.696, 40.07, 38.754, 40.843,  &
      37.958, 40.273, 41.464, 41.725, 39.977, 41.026, 39.055, 41.338, 38.353,  &
      40.904, 38.571, 40.776, 41.377, 40.454, 38.373, 40.955, 39.888, 41.08,  &
      39.793, 39.641, 38.624, 38.758, 38.991, 39.613, 40.145, 41.485, 39.125,  &
      41.44, 39.576, 40.311, 40.216, 40.48, 38.736, 40.84, 41.473, 41.336,  &
      38.676, 41.563, 41.07, 40.192, 44.28, 42.96, 44.573, 43.616, 44.554,  &
      44.047, 44.7, 44.964, 44.208, 37.889, 44.695, 39.009, 38.176, 38.365,  &
      43.897, 43.755, 38.507, 45.705, 39.813, 44.334, 37.762, 39.384, 38.82,  &
      44.363, 36.806, 43.736, 43.324, 45.945, 36.444, 37.954, 45.06, 39.297,  &
      37.132, 45.422, 37.976, 38.378, 46.104, 37.998, 42.664, 38.014, 45.11,  &
      37.662, 45.028, 39.952, 44.838, 43.435, 38.728, 36.903, 39.456, 44.441,  &
      37.285, 45.533, 38.249, 44.638, 38.671, 43.038, 40.107, 44.08, 44.472,  &
      39.003, 45.238, 38.472, 39.32, 38.219, 38.786, 38.859, 38.265, 38.571,  &
      36.782, 38.78, 37.322, 38.543, 38.85, 34.203, 33.029, 34.61, 33.471,  &
      33.322, 33.267, 33.93, 32.518, 34.569, 34.677, 34.235, 34.306, 33.215,  &
      34.712, 35.174, 34.734, 34.493, 35.132, 34.249, 33.341, 34.457, 33.809,  &
      34.334, 35.173, 33.409, 35.052, 44.334, 46.313, 45.347, 44.783, 47.955,  &
      47.275, 44.82, 44.782, 47.444, 44.914, 48.618, 43.642, 44.683, 44.073,  &
      44.47, 44.12, 44.476, 45.408, 45.148, 46.039, 45.984, 44.494, 43.674,  &
      44.211, 44.487, 45.691, 45.793, 44.967, 44.46, 45.365, 45.088, 46.46,  &
      45.886, 45.608, 45.312, 44.564, 44.345, 45.538, 44.489, 44.79, 44.124,  &
      46.946, 46.615, 45.854, 44.214, 44.024, 44.174, 45.593, 44.58, 44.565,  &
      44.133, 45.114, 48.858, 45.714, 43.985, 45.735, 45.399, 43.999, 44.355,  &
      45.755, 44.312, 46.383, 43.881, 48.141, 47.046, 47.547, 44.862, 46.459,  &
      46.297, 44.103, 44.972, 45.199, 43.893, 44.098, 43.639, 45.501, 44.308,  &
      44.365, 42.936, 41.213, 44.545, 42.779, 41.286, 44.317, 41.56, 43.491,  &
      41.803, 42.847, 41.368, 43.862, 43.638, 44.84, 44.487, 43.342, 44.936,  &
      44.182, 44.39, 40.78, 41.213, 40.985, 40.468, 41.536, 40.893, 41.913,  &
      39.736, 39.389, 39.858, 40.002, 40.385, 41.299, 38.98, 39.305, 40.906,  &
      40.659, 41.426, 41.499, 40.827, 40.285, 39.794, 40.07, 40.941, 40.962,  &
      40.598, 39.757, 40.568, 41.606, 39.384, 39.634, 41.856, 41.333, 40.495,  &
      40.915, 40.333, 41.973, 40.302, 40.129, 39.817, 40.809, 39.866, 40.082,  &
      41.328, 40.867, 41.589, 40.858, 39.77, 41.142, 41.203, 41.407, 40.8,  &
      41.317, 41.839, 41.567, 38.887, 39.515, 39.366, 40.13, 41.311, 39.24,  &
      39.142, 39.671, 41.755, 40.165, 40.667, 41.252, 39.707, 39.791, 40.833,  &
      40.794, 41.043, 39.553, 39.921, 41.502, 38.891, 39.728, 40.703, 40.816,  &
      40.659, 40.274, 41.479, 39.643, 40.571, 37.235, 34.26, 32.887, 32.315,  &
      34.407, 32.301, 34.473, 33.707, 33.925, 34.133, 34.764, 34.534, 33.716,  &
      34.199, 34.878, 34.234, 34.315, 33.569, 34.789, 33.497, 32.524, 35.11,  &
      34.017, 34.793, 35.143, 34.032, 32.314, 34.761, 32.942, 34.398, 34.76,  &
      35.018, 41.911, 40.621, 40.797, 40.048, 40.979, 40.487, 41.085, 39.825,  &
      41.265, 41.181, 40.4, 40.945, 41.811, 40.014, 41.252, 41.048, 41.944,  &
      40.509, 40.987, 41.15, 39.978, 40.503, 41.899, 40.881, 40.164, 41.551,  &
      42.203, 40.057, 39.904, 41.424, 41.445, 41.197, 39.904, 40.392, 41.051,  &
      41.621, 40.843, 40.519, 40.657, 41.271, 40.892, 40.418, 41.674, 40.854,  &
      40.535, 39.997, 40.32, 40.431, 40.731, 40.269, 39.763, 41.206, 40.583,  &
      41.821, 40.318, 39.887, 41.744, 41.237/)
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
      call put_NETCDF_fld_int(trim(wrfchem_file),"LON1_REGIONS","urban boundaries", &
      lon1_regions,num_regions,1,1)
      call put_NETCDF_fld_int(trim(wrfchem_file),"LON2_REGIONS","urban boundaries", &
      lon2_regions,num_regions,1,1)
      call put_NETCDF_fld_int(trim(wrfchem_file),"LAT1_REGIONS","urban boundaries", &
      lat1_regions,num_regions,1,1)
      call put_NETCDF_fld_int(trim(wrfchem_file),"LAT2_REGIONS","urban boundaries", &
      lat2_regions,num_regions,1,1)
!
! Set up WRFCHEM urban, rural, and cities indices
      allocate(wrfchem_urban_ii(num_regions,npts_urban))
      allocate(wrfchem_urban_jj(num_regions,npts_urban))
      allocate(wrfchem_urban_npts(num_regions))
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
            do icity=1,num_regions
!            
! Urban points
               if(lon(i,j).ge.lon_conus_west .and. lon(i,j).le.lon_conus_east .and. &
               lat(i,j).ge.lat_conus_south .and. lat(i,j).le.lat_conus_north .and. &
               lon(i,j).ge.lon1_regions(icity) .and. lon(i,j).le.lon2_regions(icity) .and. &
               lat(i,j).ge.lat1_regions(icity) .and. lat(i,j).le.lat2_regions(icity)) then
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
!      print *, 'URBAN ',sum(wrfchem_urban_npts(1:num_regions))
!      print *, 'RURAL ',wrfchem_rural_npts
!
      wrfchem_file=trim(path_output)//"/"//trim(file_output)
      call put_NETCDF_fld_int(trim(wrfchem_file),"NUM_TRACER_I_URBAN","number of points per region", &
      wrfchem_urban_npts,num_regions,1,1)
      call put_NETCDF_fld_int(trim(wrfchem_file),"TRACER_I_URBAN_II","west-east index", &
      wrfchem_urban_ii,num_regions,npts_urban,1)
      call put_NETCDF_fld_int(trim(wrfchem_file),"TRACER_I_URBAN_JJ","south-north index", &
      wrfchem_urban_jj,num_regions,npts_urban,1)
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
      allocate(wrfcmaq_urban_ii(num_regions,npts_urban))
      allocate(wrfcmaq_urban_jj(num_regions,npts_urban))
      allocate(wrfcmaq_urban_npts(num_regions))
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
         do icity=1,num_regions
!            
! Urban points
            if(lon_wrfcmaq(ii,jj).ge.lon_conus_west .and. lon_wrfcmaq(ii,jj).le.lon_conus_east .and. &
            lat_wrfcmaq(ii,jj).ge.lat_conus_south .and. lat_wrfcmaq(ii,jj).le.lat_conus_north .and. &
            lon_wrfcmaq(ii,jj).ge.lon1_regions(icity) .and. lon_wrfcmaq(ii,jj).le.lon2_regions(icity) .and. &
            lat_wrfcmaq(ii,jj).ge.lat1_regions(icity) .and. lat_wrfcmaq(ii,jj).le.lat2_regions(icity)) then
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
      call put_NETCDF_fld_int(trim(wrfcmaq_file),"NUM_WRFCMAQ_URBAN","number of points per region", &
      wrfcmaq_urban_npts,num_regions,1,1)
      call put_NETCDF_fld_int(trim(wrfcmaq_file),"WRFCMAQ_URBAN_II","west-east index", &
      wrfcmaq_urban_ii,num_regions,npts_urban,1)
      call put_NETCDF_fld_int(trim(wrfcmaq_file),"WRFCMAQ_URBAN_JJ","south-north index", &
      wrfcmaq_urban_jj,num_regions,npts_urban,1)
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
   num_cities,num_regions,npts_urban,npts_rural)
      use :: netcdf
      implicit none
!      
      integer                    :: rc,fid,scl_dimid
      integer                    :: nx,ny,nz,npts_traceri_conus,npts_wrfcmaq_conus
      integer                    :: num_cities,num_regions,npts_urban,npts_rural
      integer                    :: var_id,att_id,x_dimid,y_dimid,z_dimid
      integer                    :: npts_traceri_conus_dimid,npts_wrfcmaq_conus_dimid
      integer                    :: num_cities_dimid,num_regions_dimid
      integer                    :: npts_urban_dimid,npts_rural_dimid
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

      rc=nf90_def_dim(fid,"num_regions",num_regions,num_regions_dimid)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at num_regions_dimid')

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
! Regions Mappings
!      rc=nf90_def_var(fid,"CITIES",NF90_CHAR,(/num_cities_dimid/),var_id)
!      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at CITIES')
      rc=nf90_def_var(fid,"LON1_REGIONS",NF90_INT,(/num_regions_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at LON1_REGIONS')

      rc=nf90_def_var(fid,"LON2_REGIONS",NF90_INT,(/num_regions_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at LON2_REGIONS')

      rc=nf90_def_var(fid,"LAT1_REGIONS",NF90_INT,(/num_regions_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at LAT1_REGIONS')

      rc=nf90_def_var(fid,"LAT2_REGIONS",NF90_INT,(/num_regions_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at LAT2_REGIONS')
!
! TRACER-I Urban Mappings      
      rc=nf90_def_var(fid,"NUM_TRACER_I_URBAN",NF90_INT,(/num_regions_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_URBAN_NPTS')

      rc=nf90_def_var(fid,"TRACER_I_URBAN_II",NF90_INT,(/num_regions_dimid,npts_urban_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_URBAN_II')

      rc=nf90_def_var(fid,"TRACER_I_URBAN_JJ",NF90_INT,(/num_regions_dimid,npts_urban_dimid/),var_id)
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
      rc=nf90_def_var(fid,"NUM_WRFCMAQ_URBAN",NF90_INT,(/num_regions_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at WRFCMAQ_URBAN_NPTS')

      rc=nf90_def_var(fid,"WRFCMAQ_URBAN_II",NF90_INT,(/num_regions_dimid,npts_urban_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at WRFCMAQ_URBAN_II')

      rc=nf90_def_var(fid,"WRFCMAQ_URBAN_JJ",NF90_INT,(/num_regions_dimid,npts_urban_dimid/),var_id)
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
   
