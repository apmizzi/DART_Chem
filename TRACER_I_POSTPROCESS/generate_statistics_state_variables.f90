  program main
      implicit none
      integer                                    :: nx,ny,nz,nz_chemi,nz_fire,num_mems
      integer                                    :: i,j,k,imem,ifld,unit,urban_flg
      integer                                    :: num_met_flds,num_chem_flds,num_chemi_flds,num_fire_flds
      integer                                    :: npts_wrfchem_conus,npts_wrfcmaq_conus,num_cities
      integer                                    :: npts_urban,npts_rural
      integer                                    :: wrfcmaq_rural_npts
      integer                                    :: yyyy_wrfchem,mm_wrfchem,dd_wrfchem,hh_wrfchem
      integer,allocatable,dimension(:)           :: wrfchem_conus_ii,wrfchem_conus_jj
      integer,allocatable,dimension(:)           :: wrfchem_urban_npts,num_wrfcmaq_urban
      integer,allocatable,dimension(:)           :: wrfchem_rural_ii,wrfchem_rural_jj
      integer,allocatable,dimension(:)           :: wrfcmaq_i,wrfcmaq_j
      integer,allocatable,dimension(:)           :: wrfcmaq_ii,wrfcmaq_jj
      integer,allocatable,dimension(:)           :: wrfcmaq_conus_ii,wrfcmaq_conus_jj
      integer,allocatable,dimension(:)           :: wrfcmaq_rural_ii,wrfcmaq_rural_jj
      integer,allocatable,dimension(:,:)         :: wrfchem_urban_ii,wrfchem_urban_jj
      integer,allocatable,dimension(:,:)         :: wrfcmaq_urban_ii,wrfcmaq_urban_jj
      integer,allocatable,dimension(:,:)         :: tcr2_ll_ii,tcr2_ll_jj,tcr2_lr_ii,tcr2_lr_jj
      integer,allocatable,dimension(:,:)         :: tcr2_ul_ii,tcr2_ul_jj,tcr2_ur_ii,tcr2_ur_jj
      integer,allocatable,dimension(:,:)         :: camchem_ll_ii,camchem_ll_jj,camchem_lr_ii,camchem_lr_jj
      integer,allocatable,dimension(:,:)         :: camchem_ul_ii,camchem_ul_jj,camchem_ur_ii,camchem_ur_jj
      integer,allocatable,dimension(:,:)         :: wrfcmaq_ll_ii,wrfcmaq_ll_jj,wrfcmaq_lr_ii,wrfcmaq_lr_jj
      integer,allocatable,dimension(:,:)         :: wrfcmaq_ul_ii,wrfcmaq_ul_jj,wrfcmaq_ur_ii,wrfcmaq_ur_jj
      real                                       :: kappa,t_base
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
      real,allocatable,dimension(:,:)              :: t_cities_mn,t_cities_sd,u_cities_mn,u_cities_sd
      real,allocatable,dimension(:,:)              :: v_cities_mn,v_cities_sd,q_cities_mn,q_cities_sd
      real,allocatable,dimension(:,:)              :: co_cities_mn,co_cities_sd,o3_cities_mn,o3_cities_sd
      real,allocatable,dimension(:,:)              :: no2_cities_mn,no2_cities_sd,so2_cities_mn,so2_cities_sd
      real,allocatable,dimension(:,:)              :: e_co_cities_mn,e_co_cities_sd,e_no2_cities_mn,e_no2_cities_sd
      real,allocatable,dimension(:,:)              :: e_so2_cities_mn,e_so2_cities_sd,ebu_co_cities_mn,ebu_co_cities_sd
      real,allocatable,dimension(:,:)              :: ebu_no2_cities_mn,ebu_no2_cities_sd,ebu_so2_cities_mn,ebu_so2_cities_sd
      real,allocatable,dimension(:,:)            :: lon,lat
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
      character(len=200)                         :: strat_interp_map_file
      character(len=200)                         :: wrfout_input,wrfchemi_input,wrffirechemi_input,file_output
      character(len=60),allocatable,dimension(:) :: met_flds,chem_flds,chemi_flds,firechemi_flds

      
      integer                                    :: targ_time,l,ll_tcr2,ll_camchem,ll_wrfcmaq
      integer                                    :: nx_tcr2,ny_tcr2,nz_tcr2,nt_tcr2
      integer                                    :: nx_camchem,ny_camchem,nz_camchem,nt_camchem
      integer                                    :: nx_wrfcmaq,ny_wrfcmaq,nz_wrfcmaq_met,nt_wrfcmaq_met
      integer                                    :: nz_wrfcmaq_chem,nt_wrfcmaq_chem
      integer                                    :: num_wrfchem_conus,num_wrfchem_rural
      integer                                    :: num_wrfcmaq,num_wrfcmaq_conus,num_wrfcmaq_rural
      integer                                    :: date_wrfchem
      integer,allocatable,dimension(:)           :: date_tcr2,secs_camchem
      real                                       :: bk_wt_tcr2,fw_wt_tcr2
      real                                       :: bk_wt_camchem,fw_wt_camchem
      real                                       :: bk_wt_wrfcmaq,fw_wt_wrfcmaq
      real                                       :: molcwt_co,molcwt_o3,molcwt_no2,molcwt_so2
      real                                       :: molcwt_dry_air
      real,allocatable,dimension(:)              :: p_tcr2,lon_tcr2,lat_tcr2
      real,allocatable,dimension(:)              :: lon_camchem,lat_camchem,time_tcr2
      real,allocatable,dimension(:,:)            :: lon_wrfcmaq,lat_wrfcmaq
      real,allocatable,dimension(:,:,:)          :: fld_intrp_tcr2,fld_intrp_camchem
      real,allocatable,dimension(:,:,:)          :: camchem_sfc_vec
      real,allocatable,dimension(:,:,:)          :: ps_camchem,p_camchem, p_wrfcmaq
      real,allocatable,dimension(:,:,:)          :: t_tcr2,t_camchem,t_wrfcmaq
      real,allocatable,dimension(:,:,:)          :: u_tcr2,u_camchem,u_wrfcmaq
      real,allocatable,dimension(:,:,:)          :: v_tcr2,v_camchem,v_wrfcmaq
      real,allocatable,dimension(:,:,:)          :: q_tcr2,q_camchem,q_wrfcmaq
      real,allocatable,dimension(:,:,:)          :: co_tcr2,co_camchem,co_wrfcmaq
      real,allocatable,dimension(:,:,:)          :: o3_tcr2,o3_camchem,o3_wrfcmaq
      real,allocatable,dimension(:,:,:)          :: no2_tcr2,no2_camchem,no2_wrfcmaq
      real,allocatable,dimension(:,:,:)          :: so2_tcr2,so2_camchem,so2_wrfcmaq
      real,allocatable,dimension(:,:,:)          :: fld_tcr2,fld_camchem,fld_wrfcmaq,e_vapor           
      real,allocatable,dimension(:,:,:,:)        :: tcr2_vec,camchem_vec,wrfcmaq_vec
      double precision                           :: p0_camchem
      double precision,allocatable,dimension(:)  :: hyam_camchem,hybm_camchem,temp_tcr2,temp_camchem
      character(len=200)                         :: tcr2_met_pre,tcr2_met_suf,tcr2_chem_file
      character(len=200)                         :: tcr2_file,camchem_file
      character(len=200)                         :: wrfcmaq_gridcro2d,wrfcmaq_griddot2d,wrfcmaq_metcro2d
      character(len=200)                         :: wrfcmaq_metcro3d,wrfcmaq_metdot3d,wrfcmaq_chemcro2d
!
      namelist/ens_postprocess/path_input,path_output,wrfout_input,wrfchemi_input, &
      wrffirechemi_input,file_output,nx,ny,nz,nz_chemi,nz_fire,num_met_flds, &
      num_chem_flds,num_chemi_flds,num_fire_flds,num_mems,date_wrfchem, &
      tcr2_met_pre,tcr2_met_suf,tcr2_chem_file,camchem_file, &
      wrfcmaq_gridcro2d,wrfcmaq_griddot2d,wrfcmaq_metcro2d,wrfcmaq_metcro3d, &
      wrfcmaq_metdot3d,wrfcmaq_chemcro2d
      namelist/ens_varlist/met_flds,chem_flds,chemi_flds,firechemi_flds
!     
      molcwt_dry_air=28.97
      molcwt_co=28.01
      molcwt_o3=48.00
      molcwt_no2=46.01
      molcwt_so2=64.07
      kappa=0.286
      num_cities=29
      urban_flg=0
      strat_interp_map_file="TRACER_I_Stratifications_Data"
      nx=440
      ny=284
      npts_wrfchem_conus=124960
      npts_wrfcmaq_conus=124960
      num_cities=29
      npts_urban=200
      npts_rural=124960
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
!      print *,"date_wrfchem ",       date_wrfchem      
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
       yyyy_wrfchem=date_wrfchem/1000000
       mm_wrfchem=(date_wrfchem-yyyy_wrfchem*1000000)/10000
       dd_wrfchem=(date_wrfchem-yyyy_wrfchem*1000000-mm_wrfchem*10000)/100
       hh_wrfchem=date_wrfchem-yyyy_wrfchem*1000000-mm_wrfchem*10000-dd_wrfchem*100
!       print *, yyyy_wrfchem,mm_wrfchem,dd_wrfchem,hh_wrfchem
!
! Read stratifications and interpolation mappings data
! TRACER I
      allocate(wrfchem_conus_ii(npts_wrfchem_conus))
      allocate(wrfchem_conus_jj(npts_wrfchem_conus))
      call get_WRFCHEM_fld_int(trim(strat_interp_map_file),"NUM_TRACER_I_CONUS",num_wrfchem_conus,1,1,1,1)
      call get_WRFCHEM_fld_int(trim(strat_interp_map_file),"TRACER_I_CONUS_II",wrfchem_conus_ii,npts_wrfchem_conus,1,1,1)
      call get_WRFCHEM_fld_int(trim(strat_interp_map_file),"TRACER_I_CONUS_JJ",wrfchem_conus_jj,npts_wrfchem_conus,1,1,1)
      allocate(wrfchem_urban_npts(num_cities))
      allocate(wrfchem_urban_ii(num_cities,npts_urban))
      allocate(wrfchem_urban_jj(num_cities,npts_urban))
      call get_WRFCHEM_fld_int(trim(strat_interp_map_file),"NUM_TRACER_I_URBAN",wrfchem_urban_npts,num_cities,1,1,1)
      call get_WRFCHEM_fld_int(trim(strat_interp_map_file),"TRACER_I_URBAN_II",wrfchem_urban_ii,num_cities,npts_urban,1,1)
      call get_WRFCHEM_fld_int(trim(strat_interp_map_file),"TRACER_I_URBAN_JJ",wrfchem_urban_jj,num_cities,npts_urban,1,1)
      allocate(wrfchem_rural_ii(npts_rural))
      allocate(wrfchem_rural_jj(npts_rural))
      call get_WRFCHEM_fld_int(trim(strat_interp_map_file),"NUM_TRACER_I_RURAL",num_wrfchem_rural,1,1,1,1)
      call get_WRFCHEM_fld_int(trim(strat_interp_map_file),"TRACER_I_RURAL_II",wrfchem_rural_ii,npts_rural,1,1,1)
      call get_WRFCHEM_fld_int(trim(strat_interp_map_file),"TRACER_I_RURAL_JJ",wrfchem_rural_jj,npts_rural,1,1,1)
!
! WRFCMAQ
      allocate(wrfcmaq_i(npts_wrfcmaq_conus))
      allocate(wrfcmaq_j(npts_wrfcmaq_conus))
      allocate(wrfcmaq_ii(npts_wrfcmaq_conus))
      allocate(wrfcmaq_jj(npts_wrfcmaq_conus))
      call get_WRFCHEM_fld_int(trim(strat_interp_map_file),"NUM_WRFCMAQ",num_wrfcmaq,1,1,1,1)
      call get_WRFCHEM_fld_int(trim(strat_interp_map_file),"WRFCMAQ_I",wrfcmaq_i,npts_wrfcmaq_conus,1,1,1)
      call get_WRFCHEM_fld_int(trim(strat_interp_map_file),"WRFCMAQ_J",wrfcmaq_j,npts_wrfcmaq_conus,1,1,1)
      call get_WRFCHEM_fld_int(trim(strat_interp_map_file),"WRFCMAQ_II",wrfcmaq_ii,npts_wrfcmaq_conus,1,1,1)
      call get_WRFCHEM_fld_int(trim(strat_interp_map_file),"WRFCMAQ_JJ",wrfcmaq_jj,npts_wrfcmaq_conus,1,1,1)
!
      allocate(wrfcmaq_conus_ii(npts_wrfcmaq_conus))
      allocate(wrfcmaq_conus_jj(npts_wrfcmaq_conus))
      call get_WRFCHEM_fld_int(trim(strat_interp_map_file),"NUM_WRFCMAQ_CONUS",num_wrfcmaq_conus,1,1,1,1)
      call get_WRFCHEM_fld_int(trim(strat_interp_map_file),"WRFCMAQ_CONUS_II",wrfcmaq_conus_ii,npts_wrfcmaq_conus,1,1,1)
      call get_WRFCHEM_fld_int(trim(strat_interp_map_file),"WRFCMAQ_CONUS_JJ",wrfcmaq_conus_jj,npts_wrfcmaq_conus,1,1,1)
!
      allocate(num_wrfcmaq_urban(num_cities))
      allocate(wrfcmaq_urban_ii(num_cities,npts_urban))
      allocate(wrfcmaq_urban_jj(num_cities,npts_urban))
      call get_WRFCHEM_fld_int(trim(strat_interp_map_file),"NUM_WRFCMAQ_URBAN",num_wrfcmaq_urban,num_cities,1,1,1)
      call get_WRFCHEM_fld_int(trim(strat_interp_map_file),"WRFCMAQ_URBAN_II",wrfcmaq_urban_ii,num_cities,npts_urban,1,1)
      call get_WRFCHEM_fld_int(trim(strat_interp_map_file),"WRFCMAQ_URBAN_JJ",wrfcmaq_urban_jj,num_cities,npts_urban,1,1)
      allocate(wrfcmaq_rural_ii(npts_rural))
      allocate(wrfcmaq_rural_jj(npts_rural))
      call get_WRFCHEM_fld_int(trim(strat_interp_map_file),"NUM_WRFCMAQ_RURAL",num_wrfcmaq_rural,1,1,1,1)
      call get_WRFCHEM_fld_int(trim(strat_interp_map_file),"WRFCMAQ_RURAL_II",wrfcmaq_rural_ii,npts_rural,1,1,1)
      call get_WRFCHEM_fld_int(trim(strat_interp_map_file),"WRFCMAQ_RURAL_JJ",wrfcmaq_rural_jj,npts_rural,1,1,1)
!
! TCR2
      allocate(tcr2_ll_ii(nx,ny))
      allocate(tcr2_ll_jj(nx,ny))
      allocate(tcr2_lr_ii(nx,ny))
      allocate(tcr2_lr_jj(nx,ny))
      allocate(tcr2_ul_ii(nx,ny))
      allocate(tcr2_ul_jj(nx,ny))
      allocate(tcr2_ur_ii(nx,ny))
      allocate(tcr2_ur_jj(nx,ny))
      call get_WRFCHEM_fld_int(trim(strat_interp_map_file),"TCR2_LL_II",tcr2_ll_ii,nx,ny,1,1)
      call get_WRFCHEM_fld_int(trim(strat_interp_map_file),"TCR2_LL_JJ",tcr2_ll_jj,nx,ny,1,1)
      call get_WRFCHEM_fld_int(trim(strat_interp_map_file),"TCR2_LR_II",tcr2_lr_ii,nx,ny,1,1)
      call get_WRFCHEM_fld_int(trim(strat_interp_map_file),"TCR2_LR_JJ",tcr2_lr_jj,nx,ny,1,1)
      call get_WRFCHEM_fld_int(trim(strat_interp_map_file),"TCR2_UL_II",tcr2_ul_ii,nx,ny,1,1)
      call get_WRFCHEM_fld_int(trim(strat_interp_map_file),"TCR2_UL_JJ",tcr2_ul_jj,nx,ny,1,1)
      call get_WRFCHEM_fld_int(trim(strat_interp_map_file),"TCR2_UR_II",tcr2_ur_ii,nx,ny,1,1)
      call get_WRFCHEM_fld_int(trim(strat_interp_map_file),"TCR2_UR_JJ",tcr2_ur_jj,nx,ny,1,1)
!
! CAMCHEM
      allocate(camchem_ll_ii(nx,ny))
      allocate(camchem_ll_jj(nx,ny))
      allocate(camchem_lr_ii(nx,ny))
      allocate(camchem_lr_jj(nx,ny))
      allocate(camchem_ul_ii(nx,ny))
      allocate(camchem_ul_jj(nx,ny))
      allocate(camchem_ur_ii(nx,ny))
      allocate(camchem_ur_jj(nx,ny))
      call get_WRFCHEM_fld_int(trim(strat_interp_map_file),"CAMCHEM_LL_II",camchem_ll_ii,nx,ny,1,1)
      call get_WRFCHEM_fld_int(trim(strat_interp_map_file),"CAMCHEM_LL_JJ",camchem_ll_jj,nx,ny,1,1)
      call get_WRFCHEM_fld_int(trim(strat_interp_map_file),"CAMCHEM_LR_II",camchem_lr_ii,nx,ny,1,1)
      call get_WRFCHEM_fld_int(trim(strat_interp_map_file),"CAMCHEM_LR_JJ",camchem_lr_jj,nx,ny,1,1)
      call get_WRFCHEM_fld_int(trim(strat_interp_map_file),"CAMCHEM_UL_II",camchem_ul_ii,nx,ny,1,1)
      call get_WRFCHEM_fld_int(trim(strat_interp_map_file),"CAMCHEM_UL_JJ",camchem_ul_jj,nx,ny,1,1)
      call get_WRFCHEM_fld_int(trim(strat_interp_map_file),"CAMCHEM_UR_II",camchem_ur_ii,nx,ny,1,1)
      call get_WRFCHEM_fld_int(trim(strat_interp_map_file),"CAMCHEM_UR_JJ",camchem_ur_jj,nx,ny,1,1)
!
! Create statistics NETCDF file
      wrfchem_file=trim(path_output)//"/"//trim(file_output)
      print *, 'APM: Create file ',trim(wrfchem_file)
      call create_NETCDF_file(trim(wrfchem_file),nx,ny,nz,nz_chemi,nz_fire)
!
! lon and lat
      allocate(lon(nx,ny))
      allocate(lat(nx,ny))
      wrfchem_file=trim(path_input)//"/run_e001/"//trim(wrfout_input)
      call get_WRFCHEM_fld_real(trim(wrfchem_file),"XLONG",lon,nx,ny,1,1)
      call get_WRFCHEM_fld_real(trim(wrfchem_file),"XLAT",lat,nx,ny,1,1)
!      
      wrfchem_file=trim(path_output)//"/"//trim(file_output)
      call put_NETCDF_fld(trim(wrfchem_file),"TRACER_I_LON","degrees",lon,nx,ny,1)
      call put_NETCDF_fld(trim(wrfchem_file),"TRACER_I_LAT","degrees",lat,nx,ny,1)
!
! Met fields
      do ifld=1,num_met_flds
!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!
! T and P
!            
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!            
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
               call get_WRFCHEM_fld_real(trim(wrfchem_file),"T00",t_base,1,1,1,1)
               call get_WRFCHEM_fld_real(trim(wrfchem_file),"THM",t_fld(1,1,1,imem),nx,ny,nz,1)
               call get_WRFCHEM_fld_real(trim(wrfchem_file),"P",p_fld(1,1,1,imem),nx,ny,nz,1)
               call get_WRFCHEM_fld_real(trim(wrfchem_file),"PB",p_base(1,1,1,imem),nx,ny,nz,1)
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
! Ensemble stats T
            call ens_stats(t_fld,t_ens_mn,t_ens_sd,nx,ny,nz,num_mems)
            deallocate(t_fld)
! Ensemble stats P
            call ens_stats(p_fld,p_ens_mn,p_ens_sd,nx,ny,nz,num_mems)
            deallocate(p_fld)
            deallocate(p_ens_sd)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"TRACER_I_P","Pa",p_ens_mn,nx,ny,nz)
!            print *, 'P TRACER I MN ',p_ens_mn(:,:,1);
            call put_NETCDF_fld(trim(wrfchem_file),"TRACER_I_T_MN","K",t_ens_mn,nx,ny,nz)
!            print *, 'T TRACER I MN ',t_ens_mn(:,:,1);
            call put_NETCDF_fld(trim(wrfchem_file),"TRACER_I_T_SD","K",t_ens_sd,nx,ny,nz)
!            print *, 'T TRACER I SD ',t_ens_sd(:,:,1);
!
! Read WRFCMAQ data
            allocate(t_wrfcmaq(nx,ny,nz))
            allocate(fld_wrfcmaq(nx_wrfcmaq,ny_wrfcmaq,nz_wrfcmaq_met))
            allocate(p_wrfcmaq(nx_wrfcmaq,ny_wrfcmaq,nz_wrfcmaq_met))
            allocate(lon_wrfcmaq(nx_wrfcmaq,ny_wrfcmaq))
            allocate(lat_wrfcmaq(nx_wrfcmaq,ny_wrfcmaq))
            allocate(wrfcmaq_vec(nx_wrfcmaq,ny_wrfcmaq,nz_wrfcmaq_met,nt_wrfcmaq_met))            
            call get_WRFCHEM_fld_real(trim(wrfcmaq_metcro3d),"TA",wrfcmaq_vec,nx_wrfcmaq,ny_wrfcmaq, &
            nz_wrfcmaq_met,nt_wrfcmaq_met)
            call get_WRFCHEM_fld_real(trim(wrfcmaq_gridcro2d),"LON",lon_wrfcmaq,nx_wrfcmaq,ny_wrfcmaq, &
            1,1)
            call get_WRFCHEM_fld_real(trim(wrfcmaq_gridcro2d),"LAT",lat_wrfcmaq,nx_wrfcmaq,ny_wrfcmaq, &
            1,1)
            do i=1,nx_wrfcmaq
               do j=1,ny_wrfcmaq
                  if(lon_wrfcmaq(i,j).ge.180.) then
                     lon_wrfcmaq(i,j)=lon_wrfcmaq(i,j)-360.
                  endif
               enddo
            enddo            
!            print *, 'APM: lon_wrfcmaq ',lon_wrfcmaq(:,:)
!            print *, 'APM: lat_wrfcmaq ',lat_wrfcmaq(:,:)
!            print *, 'APM: t_wrfcmaq ',wrfcmaq_vec(:,:,1,1)
!
! Find corresponding WRFCMAQ time index
            bk_wt_wrfcmaq=-999
            fw_wt_wrfcmaq=-999
            targ_time=hh_wrfchem
            do l=1,nt_wrfcmaq_met
               ll_wrfcmaq=l
               if(l-1.eq.targ_time) then
                  bk_wt_wrfcmaq=1.
                  fw_wt_wrfcmaq=0.
                  exit
               elseif(l.eq.targ_time) then
                  bk_wt_wrfcmaq=0.
                  fw_wt_wrfcmaq=1.
                  exit
               elseif(l-1.lt.targ_time .and. l.gt.targ_time) then
                  bk_wt_wrfcmaq=l-targ_time
                  fw_wt_wrfcmaq=targ_time-(l-1)
                  exit
               endif
            enddo
            if(bk_wt_wrfcmaq.lt.0 .or. fw_wt_wrfcmaq.lt.0) then
               print *, 'APM: Error in WRFCMAQ temporal interpolation '
               stop
            endif
            fld_wrfcmaq(:,:,:)=(bk_wt_wrfcmaq*wrfcmaq_vec(:,:,:,ll_wrfcmaq) + fw_wt_wrfcmaq* &
            wrfcmaq_vec(:,:,:,ll_wrfcmaq+1))/(bk_wt_wrfcmaq+fw_wt_wrfcmaq)
!            print *, 'APM: fld_wrfcmaq ',fld_wrfcmaq(:,:,1)
!
! Get WRFCMAQ pressure (vertical grid is bottom to top; P is in Pa)
            call get_WRFCHEM_fld_real(trim(wrfcmaq_metcro3d),"PRES",wrfcmaq_vec,nx_wrfcmaq,ny_wrfcmaq, &
            nz_wrfcmaq_met,nt_wrfcmaq_met)
!            print *, 'APM: p_wrfcmaq ',wrfcmaq_vec(nx_wrfcmaq/2,ny_wrfcmaq/2,:,1)
            p_wrfcmaq(:,:,:)=(bk_wt_wrfcmaq*wrfcmaq_vec(:,:,:,ll_wrfcmaq) + fw_wt_wrfcmaq* &
            wrfcmaq_vec(:,:,:,ll_wrfcmaq+1))/(bk_wt_wrfcmaq+fw_wt_wrfcmaq)
            deallocate(wrfcmaq_vec)
!            print *, 'APM: p_wrfcmaq ',p_wrfcmaq(nx_wrfcmaq/2,ny_wrfcmaq/2,:)
!
! WRFCMAQ interpolation - WRFCMAQ has vertical interpolation and
! and horizontal mapping because TRACER-I and WRFCMAQ are on same
! Mercator grid with different origins.
            call wrfcmaq_interpolate_3dp(t_wrfcmaq,fld_wrfcmaq,p_wrfcmaq,p_ens_mn,wrfcmaq_i, &
            wrfcmaq_j,wrfcmaq_ii,wrfcmaq_jj,num_wrfcmaq,nx_wrfcmaq,ny_wrfcmaq,nz_wrfcmaq_met, &
            nx,ny,nz,.true.)
            deallocate(fld_wrfcmaq)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"WRFCMAQ_T","K",t_wrfcmaq,nx,ny,nz)
!            print *, 'T WRFCMAQ MN ',t_wrfcmaq(:,:,1);
            deallocate(lon_wrfcmaq)
            deallocate(lat_wrfcmaq)
!
! Read TCR2 data (met file vertical grid is bottom to top; h0001.nc vertical grid is top to bottom)
! Use the h0001.nc data            
!            tcr2_file=trim(tcr2_met_pre)//"t"//trim(tcr2_met_suf)
            tcr2_file=trim(tcr2_chem_file)
!            print *, 'TCR2 FILE ',trim(tcr2_file)
            allocate(t_tcr2(nx,ny,nz))
            allocate(fld_tcr2(nx_tcr2,ny_tcr2,nz_tcr2))
            allocate(p_tcr2(nz_tcr2))
            allocate(lon_tcr2(nx_tcr2))
            allocate(lat_tcr2(ny_tcr2))
            allocate(time_tcr2(nt_tcr2))
            allocate(tcr2_vec(nx_tcr2,ny_tcr2,nz_tcr2,nt_tcr2))
            call get_WRFCHEM_fld_real(trim(tcr2_file),"T",tcr2_vec,nx_tcr2,ny_tcr2,nz_tcr2,nt_tcr2)            
            allocate(temp_tcr2(nz_tcr2))
            call get_WRFCHEM_fld_double(trim(tcr2_file),"lev",temp_tcr2,nz_tcr2,1,1,1)
            p_tcr2(:)=real(temp_tcr2(:))
            deallocate(temp_tcr2)
            p_tcr2(:)=p_tcr2(:)*100.
            call get_WRFCHEM_fld_real(trim(tcr2_file),"lon",lon_tcr2,nx_tcr2,1,1,1)            
            call get_WRFCHEM_fld_real(trim(tcr2_file),"lat",lat_tcr2,ny_tcr2,1,1,1)
            do i=1,nx_tcr2
               if(lon_tcr2(i).gt.180.) lon_tcr2(i)=lon_tcr2(i)-360.
            enddo
            allocate(temp_tcr2(nt_tcr2))
            call get_WRFCHEM_fld_double(trim(tcr2_file),"time",temp_tcr2,nt_tcr2,1,1,1)
            time_tcr2(:)=real(temp_tcr2(:))
            deallocate(temp_tcr2)
!            print *, 'APM: T TCR2 VEC ',tcr2_vec(:,:,1,1)
!            print *, 'APM: P TCR2 ',p_tcr2(:)
!
! Find corresponding TCR2 time index
            bk_wt_tcr2=-999
            fw_wt_tcr2=-999
            targ_time=dd_wrfchem*24*60 + hh_wrfchem*60
            do l=1,nt_tcr2
               ll_tcr2=l
               if(time_tcr2(l).eq.targ_time) then
                  bk_wt_tcr2=1.
                  fw_wt_tcr2=0.
                  exit
               elseif(time_tcr2(l+1).eq.targ_time) then
                  bk_wt_tcr2=0.
                  fw_wt_tcr2=1.
                  exit
               elseif(time_tcr2(l).lt.targ_time .and. time_tcr2(l+1).gt.targ_time) then
                  bk_wt_tcr2=time_tcr2(l+1)-targ_time
                  fw_wt_tcr2=targ_time-time_tcr2(l)
                  exit
               endif
            enddo
            if(bk_wt_tcr2.lt.0 .or. fw_wt_tcr2.lt.0) then
               print *, 'APM: Error in TCR2 temporal interpolation '
               stop
            endif
            fld_tcr2(:,:,:)=(bk_wt_tcr2*tcr2_vec(:,:,:,ll_tcr2) + fw_wt_tcr2* &
            tcr2_vec(:,:,:,ll_tcr2+1))/(bk_wt_tcr2+fw_wt_tcr2)
            call zinvert(fld_tcr2,nx_tcr2,ny_tcr2,nz_tcr2,1)
            call zinvert(p_tcr2,1,1,nz_tcr2,1)
            deallocate(time_tcr2)
            deallocate(tcr2_vec)
!
! TCR2 spatial interpolation
            call spatial_interpolate_1dp(t_tcr2,fld_tcr2,p_tcr2,p_ens_mn, &
            tcr2_ll_ii,tcr2_ll_jj,tcr2_lr_ii,tcr2_lr_jj,tcr2_ul_ii,tcr2_ul_jj, &
            tcr2_ur_ii,tcr2_ur_jj,lon,lat,lon_tcr2,lat_tcr2, &
            nx_tcr2,ny_tcr2,nz_tcr2,nx,ny,nz)
!            print *,'TCR2 T ',fld_tcr2(:,:,1)
!            print *,'TCR2 P ',p_tcr2(:)
!            print *,'TRACER1 P /5 ',p_ens_mn(nx/5,ny/5,:)
!            print *,'TCR2 T /2 ',t_tcr2(nx/2,ny/2,:)
!            print *,'TCR2 T /5 ',t_tcr2(nx/5,ny/5,:)
            deallocate(fld_tcr2)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"TCR2_T","K",t_tcr2,nx,ny,nz)
!  
! Read CAMCHEM data (vertical grid is top to bottom)
!            print *, 'CAMCHEM FILE ',trim(camchem_file)
            allocate(t_camchem(nx,ny,nz))
            allocate(fld_camchem(nx_camchem,ny_camchem,nz_camchem))
            allocate(p_camchem(nx_camchem,ny_camchem,nz_camchem))
            allocate(hyam_camchem(nz_camchem))
            allocate(hybm_camchem(nz_camchem))
            allocate(lon_camchem(nx_camchem))
            allocate(lat_camchem(ny_camchem))
            allocate(secs_camchem(nt_camchem))
            allocate(camchem_vec(nx_camchem,ny_camchem,nz_camchem,nt_camchem))
            allocate(camchem_sfc_vec(nx_camchem,ny_camchem,nt_camchem))
            call get_WRFCHEM_fld_real(trim(camchem_file),"T",camchem_vec,nx_camchem, &
            ny_camchem,nz_camchem,nt_camchem)
            call get_WRFCHEM_fld_double(trim(camchem_file),"P0",p0_camchem,1,1,1,1)
            call get_WRFCHEM_fld_real(trim(camchem_file),"PS",camchem_sfc_vec,nx_camchem, &
            ny_camchem,nt_camchem,1)
            call get_WRFCHEM_fld_double(trim(camchem_file),"hyam",hyam_camchem,nz_camchem,1,1,1)
            call get_WRFCHEM_fld_double(trim(camchem_file),"hybm",hybm_camchem,nz_camchem,1,1,1)
            allocate(temp_camchem(nx_camchem))
            call get_WRFCHEM_fld_double(trim(camchem_file),"lon",temp_camchem,nx_camchem,1,1,1)
            lon_camchem(:)=real(temp_camchem(:))
            deallocate(temp_camchem)
            do i=1,nx_camchem
               if(lon_camchem(i).gt.180.) lon_camchem(i)=lon_camchem(i)-360.
            enddo
            allocate(temp_camchem(ny_camchem))
            call get_WRFCHEM_fld_double(trim(camchem_file),"lat",temp_camchem,ny_camchem,1,1,1)
            lat_camchem(:)=real(temp_camchem(:))
            deallocate(temp_camchem)
            call get_WRFCHEM_fld_int(trim(camchem_file),"nscur",secs_camchem,nt_camchem,1,1,1)
!
! Find corresponding CAMCHEM time
            bk_wt_camchem=-999
            fw_wt_camchem=-999
            targ_time=hh_wrfchem*60*60
            do l=1,nt_camchem
               ll_camchem=l
               if(secs_camchem(l).eq.targ_time) then
                  bk_wt_camchem=1.
                  fw_wt_camchem=0.
                  exit
               elseif(secs_camchem(l+1).eq.targ_time) then
                  bk_wt_camchem=0.
                  fw_wt_camchem=1.
                  exit
               elseif(secs_camchem(l).lt.targ_time .and. secs_camchem(l+1).gt.targ_time) then
                  bk_wt_camchem=secs_camchem(l+1)-targ_time
                  fw_wt_camchem=targ_time-secs_camchem(l)
                  exit
               endif
            enddo
            if(bk_wt_camchem.lt.0 .or. fw_wt_camchem.lt.0) then
               print *, 'APM: Error in CAMCHEM temporal interpolation '
               stop
            endif
            fld_camchem(:,:,:)=(bk_wt_camchem*camchem_vec(:,:,:,ll_camchem) + fw_wt_camchem* &
            camchem_vec(:,:,:,ll_camchem+1))/(bk_wt_camchem+fw_wt_camchem)
!            print *, 'FLD_CAMCHEM T ',fld_camchem(:,:,:)
            deallocate(secs_camchem)
            deallocate(camchem_vec)
!
! Get CAMCHEM pressure 
            do i=1,nx_camchem
               do j=1,ny_camchem
                  do k=1,nz_camchem
                     p_camchem(i,j,k)=(bk_wt_camchem*(hyam_camchem(k)*p0_camchem+ &
                     hybm_camchem(k)*camchem_sfc_vec(i,j,ll_camchem)) + fw_wt_camchem*(hyam_camchem(k)* &
                     p0_camchem+hybm_camchem(k)*camchem_sfc_vec(i,j,ll_camchem+1)))/(bk_wt_camchem+fw_wt_camchem)
                  enddo
               enddo
            enddo
            deallocate(hyam_camchem)
            deallocate(hybm_camchem)
            deallocate(camchem_sfc_vec)
            call zinvert(fld_camchem,nx_camchem,ny_camchem,nz_camchem,1)
            call zinvert(p_camchem,nx_camchem,ny_camchem,nz_camchem,1)
!            print *, 'APM: T CAMCHEM ',fld_camchem(:,:,10)
!            print *, 'APM: P CAMCHEM ',p_camchem(nx_camchem/2,ny_camchem/2,:)
!            print *, 'APM: P CAMCHEM ',p_camchem(nx_camchem/5,ny_camchem/5,:)
!
! CAMCHEM spatial interpolation
!            print *, 'APM: P CAMCHEM ',p_camchem(nx_camchem/5,ny_camchem/5,:)
!            print *, 'APM: P TRACER1 ',p_ens_mn(nx/5,ny/5,:)           
!            print *, 'CAMCHEM T /2 ',fld_camchem(nx_camchem/2,ny_camchem/2,:)
!            print *, 'CAMCHEM T /5 ',fld_camchem(nx_camchem/5,ny_camchem/5,:)
!             print *, 'CAMCHEM LAT ',lat_camchem(:)
!
            call spatial_interpolate_3dp(t_camchem,fld_camchem,p_camchem,p_ens_mn, &
            camchem_ll_ii,camchem_ll_jj,camchem_lr_ii,camchem_lr_jj,camchem_ul_ii, &
            camchem_ul_jj,camchem_ur_ii,camchem_ur_jj,lon,lat,lon_camchem,lat_camchem, &
            nx_camchem,ny_camchem,nz_camchem,nx,ny,nz)
!
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"CAMCHEM_T","K",t_camchem,nx,ny,nz)
            deallocate(fld_camchem)
!
            allocate(t_conus_mn(nz),t_conus_sd(nz))
            allocate(t_urban_mn(nz),t_urban_sd(nz))
            allocate(t_rural_mn(nz),t_rural_sd(nz))
            allocate(t_cities_mn(num_cities,nz),t_cities_sd(num_cities,nz))
!
! TRACER-I CONUS Spatial statistics T
            call spatial_mean_and_variance(t_ens_mn,t_ens_sd, &
            t_conus_mn,t_conus_sd,wrfchem_conus_ii,wrfchem_conus_jj, &
            1,nx*ny,num_wrfchem_conus,nx,ny,nz)
!            print *, 't_conus_mn TRACER1 ',t_conus_mn(:)
!            print *, 't_conus_sd TRACER1 ',t_conus_sd(:)
             wrfchem_file=trim(path_output)//"/"//trim(file_output)
             call put_NETCDF_fld(trim(wrfchem_file),"TRACER_I_T_CONUS_MN", &
             "degrees",t_conus_mn,nz,1,1)
             call put_NETCDF_fld(trim(wrfchem_file),"TRACER_I_T_CONUS_SD", &
             "degrees",t_conus_sd,nz,1,1)
!
! TRACER-I URBAN Spatial statistics T
            call spatial_mean_and_variance(t_ens_mn,t_ens_sd, &
            t_urban_mn,t_urban_sd,wrfchem_urban_ii,wrfchem_urban_jj, &
            num_cities,npts_urban,wrfchem_urban_npts,nx,ny,nz)
!            print *, 't_urban_mn TRACER1 ',t_urban_mn(:)
!            print *, 't_urban_sd TRACER1 ',t_urban_sd(:)
             wrfchem_file=trim(path_output)//"/"//trim(file_output)
             call put_NETCDF_fld(trim(wrfchem_file),"TRACER_I_T_URBAN_MN", &
             "degrees",t_urban_mn,nz,1,1)
             call put_NETCDF_fld(trim(wrfchem_file),"TRACER_I_T_URBAN_SD", &
             "degrees",t_urban_sd,nz,1,1)
!
! TRACER-I RURAL Spatial statistics T
            call spatial_mean_and_variance(t_ens_mn,t_ens_sd, &
            t_rural_mn,t_rural_sd,wrfchem_rural_ii,wrfchem_rural_jj, &
            1,nx*ny,num_wrfchem_rural,nx,ny,nz)
!            print *, 't_rural_mn TRACER1 ',t_rural_mn(:)
!           print *, 't_rural_sd TRACER1 ',t_rural_sd(:)
             wrfchem_file=trim(path_output)//"/"//trim(file_output)
             call put_NETCDF_fld(trim(wrfchem_file),"TRACER_I_T_RURAL_MN", &
             "degrees",t_rural_mn,nz,1,1)
             call put_NETCDF_fld(trim(wrfchem_file),"TRACER_I_T_RURAL_SD", &
             "degrees",t_rural_sd,nz,1,1)     
!
! WRFCMAQ CONUS Spatial statistics T
            call spatial_mean_and_variance(t_wrfcmaq,t_wrfcmaq, &
            t_conus_mn,t_conus_sd,wrfcmaq_conus_ii,wrfcmaq_conus_jj, &
            1,nx*ny,num_wrfcmaq_conus,nx,ny,nz)
!            print *, 't_conus_mn WRFCMAQ ',t_conus_mn(:)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"WRFCMAQ_T_CONUS_MN", &
            "degrees",t_conus_mn,nz,1,1)
!
! WRFCMAQ URBAN Spatial statistics T
            call spatial_mean_and_variance(t_wrfcmaq,t_wrfcmaq, &
            t_urban_mn,t_urban_sd,wrfcmaq_urban_ii,wrfcmaq_urban_jj, &
            num_cities,npts_urban,num_wrfcmaq_urban,nx,ny,nz)
!            print *, 't_urban_mn WRFCMAQ ',t_urban_mn(:)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"WRFCMAQ_T_URBAN_MN", &
            "degrees",t_urban_mn,nz,1,1)
!
! WRFCMAQ RURAL Spatial statistics T
            call spatial_mean_and_variance(t_wrfcmaq,t_wrfcmaq, &
            t_rural_mn,t_rural_sd,wrfcmaq_rural_ii,wrfcmaq_rural_jj, &
            1,nx*ny,num_wrfcmaq_rural,nx,ny,nz)
!            print *, 't_rural_mn WRFCMAQ ',t_rural_mn(:)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"WRFCMAQ_T_RURAL_MN", &
            "degrees",t_rural_mn,nz,1,1)
!
! TCR2 CONUS Spatial statistics T
            call spatial_mean_and_variance(t_tcr2,t_tcr2, &
            t_conus_mn,t_conus_sd,wrfchem_conus_ii,wrfchem_conus_jj, &
            1,nx*ny,num_wrfchem_conus,nx,ny,nz)
!            print *, 't_conus_mn TCR2 ',t_conus_mn(:)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"TCR2_T_CONUS_MN", &
            "degrees",t_conus_mn,nz,1,1)

! TCR2 URBAN Spatial statistics T
            call spatial_mean_and_variance(t_tcr2,t_tcr2, &
            t_urban_mn,t_urban_sd,wrfchem_urban_ii,wrfchem_urban_jj, &
            num_cities,npts_urban,wrfchem_urban_npts,nx,ny,nz)
!            print *, 't_urban_mn TCR2 ',t_urban_mn(:)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"TCR2_T_URBAN_MN", &
            "degrees",t_urban_mn,nz,1,1)
!
! TCR2 RURAL Spatial statistics T
            call spatial_mean_and_variance(t_tcr2,t_tcr2, &
            t_rural_mn,t_rural_sd,wrfchem_rural_ii,wrfchem_rural_jj, &
            1,nx*ny,num_wrfchem_rural,nx,ny,nz)
!            print *, 't_rural_mn TCR2 ',t_rural_mn(:)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"TCR2_T_RURAL_MN", &
            "degrees",t_rural_mn,nz,1,1)
!
! CAMCHEM CONUS Spatial statistics T
            call spatial_mean_and_variance(t_camchem,t_camchem, &
            t_conus_mn,t_conus_sd,wrfchem_conus_ii,wrfchem_conus_jj, &
            1,nx*ny,num_wrfchem_conus,nx,ny,nz)
!            print *, 't_conus_mn CAMCHEM ',t_conus_mn(:)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"CAMCHEM_T_CONUS_MN", &
            "degrees",t_conus_mn,nz,1,1)

! CAMCHEM URBAN Spatial statistics T
            call spatial_mean_and_variance(t_camchem,t_camchem, &
            t_urban_mn,t_urban_sd,wrfchem_urban_ii,wrfchem_urban_jj, &
            num_cities,npts_urban,wrfchem_urban_npts,nx,ny,nz)
!            print *, 't_urban_mn CAMCHEM ',t_urban_mn(:)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"CAMCHEM_T_URBAN_MN", &
            "degrees",t_urban_mn,nz,1,1)
!
! CAMCHEM RURAL Spatial statistics T
            call spatial_mean_and_variance(t_camchem,t_camchem, &
            t_rural_mn,t_rural_sd,wrfchem_rural_ii,wrfchem_rural_jj, &
            1,nx*ny,num_wrfchem_rural,nx,ny,nz)
!            print *, 't_rural_mn CAMCHEM ',t_rural_mn(:)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"CAMCHEM_T_RURAL_MN", &
            "degrees",t_rural_mn,nz,1,1)
!
            deallocate(t_ens_mn)           
            deallocate(t_ens_sd)           
            deallocate(t_tcr2)           
            deallocate(t_wrfcmaq)           
            deallocate(t_camchem)           
            deallocate(t_conus_mn)
            deallocate(t_conus_sd)
            deallocate(t_urban_mn)
            deallocate(t_urban_sd)
            deallocate(t_rural_mn)
            deallocate(t_rural_sd)
            deallocate(t_cities_mn)
            deallocate(t_cities_sd)
            print *, '   APM: After process T'
!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!
! U
!            
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!            
         elseif(trim(met_flds(ifld)).eq."U") then
            print *, '   APM: Before process U'
!
! TRACER I
            allocate(stag_fld(nx+1,ny,nz))
            allocate(u_fld(nx,ny,nz,num_mems))
            do imem=1,num_mems
               if(imem.ge.0.and.imem.lt.10) write(cmem,"('/run_e00',i1)"),imem
               if(imem.ge.10.and.imem.lt.100) write(cmem,"('/run_e0',i2)"),imem
               if(imem.ge.100.and.imem.lt.1000) write(cmem,"('/run_e',i3)"),imem
               wrfchem_file=trim(path_input)//trim(cmem)//"/"//trim(wrfout_input)
               call get_WRFCHEM_fld_real(trim(wrfchem_file),"U",stag_fld(1,1,1),nx+1,ny,nz,1)
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
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"TRACER_I_U_MN","m/s",u_ens_mn,nx,ny,nz)
            call put_NETCDF_fld(trim(wrfchem_file),"TRACER_I_U_SD","m/s",u_ens_sd,nx,ny,nz)
!            print *, 'U TRACER I MN ',u_ens_mn(:,:,1)
!            print *, 'U TRACER I SD ',u_ens_sd(:,:,1)
!
! WRFCMAQ
            allocate(wrfcmaq_vec(nx_wrfcmaq+1,ny_wrfcmaq+1,nz_wrfcmaq_met,nt_wrfcmaq_met))
            allocate(fld_wrfcmaq(nx_wrfcmaq+1,ny_wrfcmaq+1,nz_wrfcmaq_met))
            print *, 'FILE ',trim(wrfcmaq_metdot3d)
            call get_WRFCHEM_fld_real(trim(wrfcmaq_metdot3d),"UWINDC",wrfcmaq_vec,nx_wrfcmaq+1, &
            ny_wrfcmaq+1,nz_wrfcmaq_met,nt_wrfcmaq_met)
            fld_wrfcmaq(:,:,:)=(bk_wt_wrfcmaq*wrfcmaq_vec(:,:,:,ll_wrfcmaq) + fw_wt_wrfcmaq* &
            wrfcmaq_vec(:,:,:,ll_wrfcmaq+1))/(bk_wt_wrfcmaq+fw_wt_wrfcmaq)
            deallocate(wrfcmaq_vec)
            allocate(u_fld(nx_wrfcmaq,ny_wrfcmaq,nz_wrfcmaq_met,1))
            do i=1,nx_wrfcmaq
               do j=1,ny_wrfcmaq
                  do k=1,nz_wrfcmaq_met
                     u_fld(i,j,k,1)=(2.*fld_wrfcmaq(i,j,k)+fld_wrfcmaq(i+1,j,k)+ &
                     fld_wrfcmaq(i,j+1,k))/4.
                  enddo
               enddo
            enddo
            deallocate(fld_wrfcmaq)
            allocate(u_wrfcmaq(nx,ny,nz))
            call wrfcmaq_interpolate_3dp(u_wrfcmaq,u_fld(:,:,:,1),p_wrfcmaq,p_ens_mn,wrfcmaq_i, &
            wrfcmaq_j,wrfcmaq_ii,wrfcmaq_jj,num_wrfcmaq,nx_wrfcmaq,ny_wrfcmaq,nz_wrfcmaq_met, &
            nx,ny,nz,.false.)
            deallocate(u_fld)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"WRFCMAQ_U","m/s",u_wrfcmaq,nx,ny,nz)
!            print *, 'U WRFCMAQ MN ',u_wrfcmaq(:,:,1);
!
! TCR2
! Met file vertical grid is bottom to top; h0001.nc vertical grid is top to bottom)
! Use the h0001.nc data            
!            tcr2_file=trim(tcr2_met_pre)//"u"//trim(tcr2_met_suf)
            tcr2_file=trim(tcr2_chem_file)
!            print *, 'TCR2 FILE ',trim(tcr2_file)
            allocate(u_tcr2(nx,ny,nz))
            allocate(fld_tcr2(nx_tcr2,ny_tcr2,nz_tcr2))
            allocate(tcr2_vec(nx_tcr2,ny_tcr2,nz_tcr2,nt_tcr2))
            call get_WRFCHEM_fld_real(trim(tcr2_file),"U",tcr2_vec,nx_tcr2,ny_tcr2,nz_tcr2,nt_tcr2)
!            print *, 'TCR2 VEC ',tcr2_vec(:,:,1,1)
            fld_tcr2(:,:,:)=(bk_wt_tcr2*tcr2_vec(:,:,:,ll_tcr2) + fw_wt_tcr2* &
            tcr2_vec(:,:,:,ll_tcr2+1))/(bk_wt_tcr2+fw_wt_tcr2)
            call zinvert(fld_tcr2,nx_tcr2,ny_tcr2,nz_tcr2,1)
            deallocate(tcr2_vec)
!            print *,'TCR2 fld U ',fld_tcr2(:,:,1)
!
! TCR2 spatial interpolation
            call spatial_interpolate_1dp(u_tcr2,fld_tcr2,p_tcr2,p_ens_mn, &
            tcr2_ll_ii,tcr2_ll_jj,tcr2_lr_ii,tcr2_lr_jj,tcr2_ul_ii,tcr2_ul_jj, &
            tcr2_ur_ii,tcr2_ur_jj,lon,lat,lon_tcr2,lat_tcr2, &
            nx_tcr2,ny_tcr2,nz_tcr2,nx,ny,nz)
!            print *,'TCR2 U ',u_tcr2(:,:,1)
            deallocate(fld_tcr2)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"TCR2_U","m/s",u_tcr2,nx,ny,nz)
!  
! CAMCHEM
! Vertical grid is top to bottom
!            print *, 'CAMCHEM FILE ',trim(camchem_file)
            allocate(u_camchem(nx,ny,nz))
            allocate(fld_camchem(nx_camchem,ny_camchem,nz_camchem))
            allocate(camchem_vec(nx_camchem,ny_camchem,nz_camchem,nt_camchem))
            call get_WRFCHEM_fld_real(trim(camchem_file),"U",camchem_vec,nx_camchem, &
            ny_camchem,nz_camchem,nt_camchem)
!            print *, 'CAMCHEM U VEC ',camchem_vec(:,:,1,1)     
            fld_camchem(:,:,:)=(bk_wt_camchem*camchem_vec(:,:,:,ll_camchem) + fw_wt_camchem* &
            camchem_vec(:,:,:,ll_camchem+1))/(bk_wt_camchem+fw_wt_camchem)
            deallocate(camchem_vec)
!            print *, 'CAMCHEM U fld ',fld_camchem(:,:,1)     
            call zinvert(fld_camchem,nx_camchem,ny_camchem,nz_camchem,1)
!            print *, 'APM: U CAMCHEM ',fld_camchem(:,:,1)
!
! CAMCHEM spatial interpolation
            call spatial_interpolate_3dp(u_camchem,fld_camchem,p_camchem,p_ens_mn, &
            camchem_ll_ii,camchem_ll_jj,camchem_lr_ii,camchem_lr_jj,camchem_ul_ii, &
            camchem_ul_jj,camchem_ur_ii,camchem_ur_jj,lon,lat,lon_camchem,lat_camchem, &
            nx_camchem,ny_camchem,nz_camchem,nx,ny,nz)
!            print *,'CAMCHEM U ',u_camchem(:,:,1)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"CAMCHEM_U","m/s",u_camchem,nx,ny,nz)
            deallocate(fld_camchem)
!
            allocate(u_conus_mn(nz),u_conus_sd(nz))
            allocate(u_urban_mn(nz),u_urban_sd(nz))
            allocate(u_rural_mn(nz),u_rural_sd(nz))
            allocate(u_cities_mn(num_cities,nz),u_cities_sd(num_cities,nz))
!
! TRACER I CONUS Spatial statistics U
            call spatial_mean_and_variance(u_ens_mn,u_ens_sd, &
            u_conus_mn,u_conus_sd,wrfchem_conus_ii,wrfchem_conus_jj, &
            1,nx*ny,num_wrfchem_conus,nx,ny,nz)
!            print *, 'u_conus_mn TRACER1 ',u_conus_mn(:)
!            print *, 'u_conus_sd TRACER1 ',u_conus_sd(:)
             wrfchem_file=trim(path_output)//"/"//trim(file_output)
             call put_NETCDF_fld(trim(wrfchem_file),"TRACER_I_U_CONUS_MN","m/s",u_conus_mn,nz,1,1)
             call put_NETCDF_fld(trim(wrfchem_file),"TRACER_I_U_CONUS_SD","m/s",u_conus_sd,nz,1,1)
!
! TRACER I URBAN Spatial statistics U
            call spatial_mean_and_variance(u_ens_mn,u_ens_sd, &
            u_urban_mn,u_urban_sd,wrfchem_urban_ii,wrfchem_urban_jj, &
            num_cities,npts_urban,wrfchem_urban_npts,nx,ny,nz)
!            print *, 'u_urban_mn TRACER1 ',u_urban_mn(:)
!            print *, 'u_urban_sd TRACER1 ',u_urban_sd(:)
             wrfchem_file=trim(path_output)//"/"//trim(file_output)
             call put_NETCDF_fld(trim(wrfchem_file),"TRACER_I_U_URBAN_MN","m/s",u_urban_mn,nz,1,1)
             call put_NETCDF_fld(trim(wrfchem_file),"TRACER_I_U_URBAN_SD","m/s",u_urban_sd,nz,1,1)
!
! TRACER I RURAL Spatial statistics U
            call spatial_mean_and_variance(u_ens_mn,u_ens_sd, &
            u_rural_mn,u_rural_sd,wrfchem_rural_ii,wrfchem_rural_jj, &
            1,nx*ny,num_wrfchem_rural,nx,ny,nz)
!            print *, 'u_rural_mn TRACER1',u_rural_mn(:)
!            print *, 'u_rural_sd TRACER1',u_rural_sd(:)
             wrfchem_file=trim(path_output)//"/"//trim(file_output)
             call put_NETCDF_fld(trim(wrfchem_file),"TRACER_I_U_RURAL_MN","m/s",u_rural_mn,nz,1,1)
             call put_NETCDF_fld(trim(wrfchem_file),"TRACER_I_U_RURAL_SD","m/s",u_rural_sd,nz,1,1)
!
! WRFCMAQ CONUS Spatial statistics U
            call spatial_mean_and_variance(u_wrfcmaq,u_wrfcmaq, &
            u_conus_mn,u_conus_sd,wrfcmaq_conus_ii,wrfcmaq_conus_jj, &
            1,nx*ny,num_wrfcmaq_conus,nx,ny,nz)
!            print *, 'u_conus_mn WRFCMAQ ',u_conus_mn(:)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"WRFCMAQ_U_CONUS_MN", &
            "m/s",u_conus_mn,nz,1,1)
!
! WRFCMAQ URBAN Spatial statistics U
            call spatial_mean_and_variance(u_wrfcmaq,u_wrfcmaq, &
            u_urban_mn,u_urban_sd,wrfcmaq_urban_ii,wrfcmaq_urban_jj, &
            num_cities,npts_urban,num_wrfcmaq_urban,nx,ny,nz)
!            print *, 'u_urban_mn WRFCMAQ ',u_urban_mn(:)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"WRFCMAQ_U_URBAN_MN", &
            "m/s",u_urban_mn,nz,1,1)
!
! WRFCMAQ RURAL Spatial statistics U
            call spatial_mean_and_variance(u_wrfcmaq,u_wrfcmaq, &
            u_rural_mn,u_rural_sd,wrfcmaq_rural_ii,wrfcmaq_rural_jj, &
            1,nx*ny,num_wrfcmaq_rural,nx,ny,nz)
!            print *, 'u_rural_mn WRFCMAQ ',u_rural_mn(:)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"WRFCMAQ_U_RURAL_MN", &
            "m/s",u_rural_mn,nz,1,1)
!
! TCR2 CONUS Spatial statistics U
            call spatial_mean_and_variance(u_tcr2,u_tcr2, &
            u_conus_mn,u_conus_sd,wrfchem_conus_ii,wrfchem_conus_jj, &
            1,nx*ny,num_wrfchem_conus,nx,ny,nz)
!            print *, 'u_conus_mn TCR2 ',u_conus_mn(:)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"TCR2_U_CONUS_MN","m/s",u_conus_mn,nz,1,1)

! TCR2 URBAN Spatial statistics U
            call spatial_mean_and_variance(u_tcr2,u_tcr2, &
            u_urban_mn,u_urban_sd,wrfchem_urban_ii,wrfchem_urban_jj, &
            num_cities,npts_urban,wrfchem_urban_npts,nx,ny,nz)
!            print *, 'u_urban_mn TCR2 ',u_urban_mn(:)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"TCR2_U_URBAN_MN","m/s",u_urban_mn,nz,1,1)
!
! TCR2 RURAL Spatial statistics U
            call spatial_mean_and_variance(u_tcr2,u_tcr2, &
            u_rural_mn,u_rural_sd,wrfchem_rural_ii,wrfchem_rural_jj, &
            1,nx*ny,num_wrfchem_rural,nx,ny,nz)
!            print *, 'u_rural_mn TCR2 ',u_rural_mn(:)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"TCR2_U_RURAL_MN","m/s",u_rural_mn,nz,1,1)
!
! CAMCHEM CONUS Spatial statistics U
            call spatial_mean_and_variance(u_camchem,u_camchem, &
            u_conus_mn,u_conus_sd,wrfchem_conus_ii,wrfchem_conus_jj, &
            1,nx*ny,num_wrfchem_conus,nx,ny,nz)
!            print *, 'u_conus_mn CAMCHEM ',u_conus_mn(:)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"CAMCHEM_U_CONUS_MN","m/s",u_conus_mn,nz,1,1)

! CAMCHEM URBAN Spatial statistics U
            call spatial_mean_and_variance(u_camchem,u_camchem, &
            u_urban_mn,u_urban_sd,wrfchem_urban_ii,wrfchem_urban_jj, &
            num_cities,npts_urban,wrfchem_urban_npts,nx,ny,nz)
!            print *, 'u_urban_mn CAMCHEM ',u_urban_mn(:)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"CAMCHEM_U_URBAN_MN","m/s",u_urban_mn,nz,1,1)
!
! CAMCHEM RURAL Spatial statistics U
            call spatial_mean_and_variance(u_camchem,u_camchem, &
            u_rural_mn,u_rural_sd,wrfchem_rural_ii,wrfchem_rural_jj, &
            1,nx*ny,num_wrfchem_rural,nx,ny,nz)
!            print *, 'u_rural_mn CAMCHEM ',u_rural_mn(:)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"CAMCHEM_U_RURAL_MN","m/s",u_rural_mn,nz,1,1)
!
            deallocate(u_ens_mn)           
            deallocate(u_ens_sd)           
            deallocate(u_tcr2)           
            deallocate(u_wrfcmaq)           
            deallocate(u_camchem)           
            deallocate(u_conus_mn)
            deallocate(u_conus_sd)
            deallocate(u_urban_mn)
            deallocate(u_urban_sd)
            deallocate(u_rural_mn)
            deallocate(u_rural_sd)
            deallocate(u_cities_mn)
            deallocate(u_cities_sd)
            print *, '   APM: After process U'
!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!
! V
!            
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!            
         elseif(trim(met_flds(ifld)).eq."V") then
            print *, '   APM: Before process V'
!
! TRACER I            
            allocate(stag_fld(nx,ny+1,nz))
            allocate(v_fld(nx,ny,nz,num_mems))
            do imem=1,num_mems
               if(imem.ge.0.and.imem.lt.10) write(cmem,"('/run_e00',i1)"),imem
               if(imem.ge.10.and.imem.lt.100) write(cmem,"('/run_e0',i2)"),imem
               if(imem.ge.100.and.imem.lt.1000) write(cmem,"('/run_e',i3)"),imem
               wrfchem_file=trim(path_input)//trim(cmem)//"/"//trim(wrfout_input)
               call get_WRFCHEM_fld_real(trim(wrfchem_file),"V",stag_fld(1,1,1),nx,ny+1,nz,1)
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
! Ensemle stats V
            call ens_stats(v_fld,v_ens_mn,v_ens_sd,nx,ny,nz,num_mems)
            deallocate(v_fld)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"TRACER_I_V_MN","m/s",v_ens_mn,nx,ny,nz)
            call put_NETCDF_fld(trim(wrfchem_file),"TRACER_I_V_SD","m/s",v_ens_sd,nx,ny,nz)
!
! WRFCMAQ
            allocate(wrfcmaq_vec(nx_wrfcmaq+1,ny_wrfcmaq+1,nz_wrfcmaq_met,nt_wrfcmaq_met))
            allocate(fld_wrfcmaq(nx_wrfcmaq+1,ny_wrfcmaq+1,nz_wrfcmaq_met))
            print *, 'FILE ',trim(wrfcmaq_metdot3d)
            call get_WRFCHEM_fld_real(trim(wrfcmaq_metdot3d),"VWINDC",wrfcmaq_vec,nx_wrfcmaq+1, &
            ny_wrfcmaq+1,nz_wrfcmaq_met,nt_wrfcmaq_met)
            fld_wrfcmaq(:,:,:)=(bk_wt_wrfcmaq*wrfcmaq_vec(:,:,:,ll_wrfcmaq) + fw_wt_wrfcmaq* &
            wrfcmaq_vec(:,:,:,ll_wrfcmaq+1))/(bk_wt_wrfcmaq+fw_wt_wrfcmaq)
            deallocate(wrfcmaq_vec)
            allocate(v_fld(nx_wrfcmaq,ny_wrfcmaq,nz_wrfcmaq_met,1))
            do i=1,nx_wrfcmaq
               do j=1,ny_wrfcmaq
                  do k=1,nz_wrfcmaq_met
                     v_fld(i,j,k,1)=(2.*fld_wrfcmaq(i,j,k)+fld_wrfcmaq(i+1,j,k)+ &
                     fld_wrfcmaq(i,j+1,k))/4.
                  enddo
               enddo
            enddo
            deallocate(fld_wrfcmaq)
            allocate(v_wrfcmaq(nx,ny,nz))
            call wrfcmaq_interpolate_3dp(v_wrfcmaq,v_fld(:,:,:,1),p_wrfcmaq,p_ens_mn,wrfcmaq_i, &
            wrfcmaq_j,wrfcmaq_ii,wrfcmaq_jj,num_wrfcmaq,nx_wrfcmaq,ny_wrfcmaq,nz_wrfcmaq_met, &
            nx,ny,nz,.false.)
            deallocate(v_fld)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"WRFCMAQ_V","m/s",v_wrfcmaq,nx,ny,nz)
!            print *, 'V WRFCMAQ MN ',v_wrfcmaq(:,:,1);
!
! TCR2
! Met file vertical grid is bottom to top; h0001.nc vertical grid is top to bottom)
! Use the h0001.nc data            
!            tcr2_file=trim(tcr2_met_pre)//"v"//trim(tcr2_met_suf)
            tcr2_file=trim(tcr2_chem_file)
!            print *, 'TCR2 FILE ',trim(tcr2_file)
            allocate(v_tcr2(nx,ny,nz))
            allocate(fld_tcr2(nx_tcr2,ny_tcr2,nz_tcr2))
            allocate(tcr2_vec(nx_tcr2,ny_tcr2,nz_tcr2,nt_tcr2))
            call get_WRFCHEM_fld_real(trim(tcr2_file),"V",tcr2_vec,nx_tcr2,ny_tcr2,nz_tcr2,nt_tcr2)
!            print *, 'TCR2 VEC ',tcr2_vec(:,:,1,1)
            fld_tcr2(:,:,:)=(bk_wt_tcr2*tcr2_vec(:,:,:,ll_tcr2) + fw_wt_tcr2* &
            tcr2_vec(:,:,:,ll_tcr2+1))/(bk_wt_tcr2+fw_wt_tcr2)
            call zinvert(fld_tcr2,nx_tcr2,ny_tcr2,nz_tcr2,1)
            deallocate(tcr2_vec)
!            print *,'TCR2 fld V ',fld_tcr2(:,:,1)
!
! TCR2 spatial interpolation
            call spatial_interpolate_1dp(v_tcr2,fld_tcr2,p_tcr2,p_ens_mn, &
            tcr2_ll_ii,tcr2_ll_jj,tcr2_lr_ii,tcr2_lr_jj,tcr2_ul_ii,tcr2_ul_jj, &
            tcr2_ur_ii,tcr2_ur_jj,lon,lat,lon_tcr2,lat_tcr2, &
            nx_tcr2,ny_tcr2,nz_tcr2,nx,ny,nz)
!            print *,'TCR2 V ',v_tcr2(:,:,1)
            deallocate(fld_tcr2)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"TCR2_V","m/s",v_tcr2,nx,ny,nz)
!  
! Read CAMCHEM data (vertical grid is top to bottom)
!            print *, 'CAMCHEM FILE ',trim(camchem_file)
            allocate(v_camchem(nx,ny,nz))
            allocate(fld_camchem(nx_camchem,ny_camchem,nz_camchem))
            allocate(camchem_vec(nx_camchem,ny_camchem,nz_camchem,nt_camchem))
            call get_WRFCHEM_fld_real(trim(camchem_file),"V",camchem_vec,nx_camchem, &
            ny_camchem,nz_camchem,nt_camchem)
!            print *, 'CAMCHEM V VEC ',camchem_vec(:,:,1,1)     
            fld_camchem(:,:,:)=(bk_wt_camchem*camchem_vec(:,:,:,ll_camchem) + fw_wt_camchem* &
            camchem_vec(:,:,:,ll_camchem+1))/(bk_wt_camchem+fw_wt_camchem)
            deallocate(camchem_vec)
!            print *, 'CAMCHEM V fld ',fld_camchem(:,:,1)     
            call zinvert(fld_camchem,nx_camchem,ny_camchem,nz_camchem,1)
!            print *, 'APM: V CAMCHEM ',fld_camchem(:,:,1)
!
! CAMCHEM spatial interpolation
            call spatial_interpolate_3dp(v_camchem,fld_camchem,p_camchem,p_ens_mn, &
            camchem_ll_ii,camchem_ll_jj,camchem_lr_ii,camchem_lr_jj,camchem_ul_ii, &
            camchem_ul_jj,camchem_ur_ii,camchem_ur_jj,lon,lat,lon_camchem,lat_camchem, &
            nx_camchem,ny_camchem,nz_camchem,nx,ny,nz)
!            print *,'CAMCHEM V ',v_camchem(:,:,1)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"CAMCHEM_V", &
            "m/s",v_camchem,nx,ny,nz)
            deallocate(fld_camchem)
!
            allocate(v_conus_mn(nz),v_conus_sd(nz))
            allocate(v_urban_mn(nz),v_urban_sd(nz))
            allocate(v_rural_mn(nz),v_rural_sd(nz))
            allocate(v_cities_mn(num_cities,nz),v_cities_sd(num_cities,nz))
!
! TRACER I CONUS Spatial statistics V
            call spatial_mean_and_variance(v_ens_mn,v_ens_sd, &
            v_conus_mn,v_conus_sd,wrfchem_conus_ii,wrfchem_conus_jj, &
            1,nx*ny,num_wrfchem_conus,nx,ny,nz)
!            print *, 'v_conus_mn TRACER1 ',v_conus_mn(:)
!            print *, 'v_conus_sd TRACER1 ',v_conus_sd(:)
             wrfchem_file=trim(path_output)//"/"//trim(file_output)
             call put_NETCDF_fld(trim(wrfchem_file),"TRACER_I_V_CONUS_MN", &
             "m/s",v_conus_mn,nz,1,1)
             call put_NETCDF_fld(trim(wrfchem_file),"TRACER_I_V_CONUS_SD", &
             "m/s",v_conus_sd,nz,1,1)
!
! TRACER I URBAN Spatial statistics V
            call spatial_mean_and_variance(v_ens_mn,v_ens_sd, &
            v_urban_mn,v_urban_sd,wrfchem_urban_ii,wrfchem_urban_jj, &
            num_cities,npts_urban,wrfchem_urban_npts,nx,ny,nz)
!            print *, 'v_urban_mn TRACER1 ',v_urban_mn(:)
!            print *, 'v_urban_sd TRACER1 ',v_urban_sd(:)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"TRACER_I_V_URBAN_MN", &
            "m/s",v_urban_mn,nz,1,1)
            call put_NETCDF_fld(trim(wrfchem_file),"TRACER_I_V_URBAN_SD", &
            "m/s",v_urban_sd,nz,1,1)
!
! TRACER I RURAL Spatial statistics V
            call spatial_mean_and_variance(v_ens_mn,v_ens_sd, &
            v_rural_mn,v_rural_sd,wrfchem_rural_ii,wrfchem_rural_jj, &
            1,nx*ny,num_wrfchem_rural,nx,ny,nz)
!            print *, 'v_rural_mn TRACER1 ',v_rural_mn(:)
!            print *, 'v_rural_sd TRACER1 ',v_rural_sd(:)
             wrfchem_file=trim(path_output)//"/"//trim(file_output)
             call put_NETCDF_fld(trim(wrfchem_file),"TRACER_I_V_RURAL_MN", &
             "m/s",v_rural_mn,nz,1,1)
             call put_NETCDF_fld(trim(wrfchem_file),"TRACER_I_V_RURAL_SD", &
             "m/s",v_rural_sd,nz,1,1)
!
! WRFCMAQ CONUS Spatial statistics V
            call spatial_mean_and_variance(v_wrfcmaq,v_wrfcmaq, &
            v_conus_mn,v_conus_sd,wrfcmaq_conus_ii,wrfcmaq_conus_jj, &
            1,nx*ny,num_wrfcmaq_conus,nx,ny,nz)
!            print *, 'v_conus_mn WRFCMAQ ',v_conus_mn(:)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"WRFCMAQ_V_CONUS_MN", &
            "m/s",v_conus_mn,nz,1,1)
!
! WRFCMAQ URBAN Spatial statistics V
            call spatial_mean_and_variance(v_wrfcmaq,v_wrfcmaq, &
            v_urban_mn,v_urban_sd,wrfcmaq_urban_ii,wrfcmaq_urban_jj, &
            num_cities,npts_urban,num_wrfcmaq_urban,nx,ny,nz)
!            print *, 'v_urban_mn WRFCMAQ ',v_urban_mn(:)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"WRFCMAQ_V_URBAN_MN", &
            "m/s",v_urban_mn,nz,1,1)
!
! WRFCMAQ RURAL Spatial statistics V
            call spatial_mean_and_variance(v_wrfcmaq,v_wrfcmaq, &
            v_rural_mn,v_rural_sd,wrfcmaq_rural_ii,wrfcmaq_rural_jj, &
            1,nx*ny,num_wrfcmaq_rural,nx,ny,nz)
!            print *, 'v_rural_mn WRFCMAQ ',v_rural_mn(:)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"WRFCMAQ_V_RURAL_MN", &
            "m/s",v_rural_mn,nz,1,1)
!
! TCR2 CONUS Spatial statistics V
            call spatial_mean_and_variance(v_tcr2,v_tcr2, &
            v_conus_mn,v_conus_sd,wrfchem_conus_ii,wrfchem_conus_jj, &
            1,nx*ny,num_wrfchem_conus,nx,ny,nz)
!            print *, 'v_conus_mn TCR2 ',v_conus_mn(:)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"TCR2_V_CONUS_MN", &
            "m/s",v_conus_mn,nz,1,1)

! TCR2 URBAN Spatial statistics V
            call spatial_mean_and_variance(v_tcr2,v_tcr2, &
            v_urban_mn,v_urban_sd,wrfchem_urban_ii,wrfchem_urban_jj, &
            num_cities,npts_urban,wrfchem_urban_npts,nx,ny,nz)
!            print *, 'v_urban_mn TCR2 ',v_urban_mn(:)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"TCR2_V_URBAN_MN", &
            "m/s",v_urban_mn,nz,1,1)
!
! TCR2 RURAL Spatial statistics V
            call spatial_mean_and_variance(v_tcr2,v_tcr2, &
            v_rural_mn,v_rural_sd,wrfchem_rural_ii,wrfchem_rural_jj, &
            1,nx*ny,num_wrfchem_rural,nx,ny,nz)
!            print *, 'v_rural_mn TCR2 ',v_rural_mn(:)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"TCR2_V_RURAL_MN", &
            "m/s",v_rural_mn,nz,1,1)
!
! CAMCHEM CONUS Spatial statistics V
            call spatial_mean_and_variance(v_camchem,v_camchem, &
            v_conus_mn,v_conus_sd,wrfchem_conus_ii,wrfchem_conus_jj, &
            1,nx*ny,num_wrfchem_conus,nx,ny,nz)
!            print *, 'v_conus_mn CAMCHEM ',v_conus_mn(:)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"CAMCHEM_V_CONUS_MN", &
            "m/s",v_conus_mn,nz,1,1)

! CAMCHEM URBAN Spatial statistics V
            call spatial_mean_and_variance(v_camchem,v_camchem, &
            v_urban_mn,v_urban_sd,wrfchem_urban_ii,wrfchem_urban_jj, &
            num_cities,npts_urban,wrfchem_urban_npts,nx,ny,nz)
!            print *, 'v_urban_mn CAMCHEM ',v_urban_mn(:)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"CAMCHEM_V_URBAN_MN", &
            "m/s",v_urban_mn,nz,1,1)
!
! CAMCHEM RURAL Spatial statistics V
            call spatial_mean_and_variance(v_camchem,v_camchem, &
            v_rural_mn,v_rural_sd,wrfchem_rural_ii,wrfchem_rural_jj, &
            1,nx*ny,num_wrfchem_rural,nx,ny,nz)
!            print *, 'v_rural_mn CAMCHEM ',v_rural_mn(:)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"CAMCHEM_V_RURAL_MN", &
            "m/s",v_rural_mn,nz,1,1)
!
            deallocate(v_ens_mn)           
            deallocate(v_ens_sd)           
            deallocate(v_tcr2)           
            deallocate(v_wrfcmaq)           
            deallocate(v_camchem)           
            deallocate(v_conus_mn)
            deallocate(v_conus_sd)
            deallocate(v_urban_mn)
            deallocate(v_urban_sd)
            deallocate(v_rural_mn)
            deallocate(v_rural_sd)
            deallocate(v_cities_mn)
            deallocate(v_cities_sd)
            print *, '   APM: After process V'
!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!
! Q
!            
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!            
         elseif(trim(met_flds(ifld)).eq."Q") then
            print *, '   APM: Before process Q'
!
! TRACER I
            allocate(q_fld(nx,ny,nz,num_mems))
            do imem=1,num_mems
               if(imem.ge.0.and.imem.lt.10) write(cmem,"('/run_e00',i1)"),imem
               if(imem.ge.10.and.imem.lt.100) write(cmem,"('/run_e0',i2)"),imem
               if(imem.ge.100.and.imem.lt.1000) write(cmem,"('/run_e',i3)"),imem
               wrfchem_file=trim(path_input)//trim(cmem)//"/"//trim(wrfout_input)
               call get_WRFCHEM_fld_real(trim(wrfchem_file),"QVAPOR",q_fld(1,1,1,imem),nx,ny,nz,1)
            enddo
            allocate(q_ens_mn(nx,ny,nz))
            allocate(q_ens_sd(nx,ny,nz))
! Ensemble stats Q
            call ens_stats(q_fld,q_ens_mn,q_ens_sd,nx,ny,nz,num_mems)
            deallocate(q_fld)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"TRACER_I_Q_MN","mixing ratio (kg/kg)",q_ens_mn,nx,ny,nz)
            call put_NETCDF_fld(trim(wrfchem_file),"TRACER_I_Q_SD","mixing ratio (kg/kg)",q_ens_sd,nx,ny,nz)
!
! WRFCMAQ
            allocate(wrfcmaq_vec(nx_wrfcmaq,ny_wrfcmaq,nz_wrfcmaq_met,nt_wrfcmaq_met))
            allocate(fld_wrfcmaq(nx_wrfcmaq,ny_wrfcmaq,nz_wrfcmaq_met))
            print *, 'FILE ',trim(wrfcmaq_metdot3d)
            call get_WRFCHEM_fld_real(trim(wrfcmaq_metcro3d),"QV",wrfcmaq_vec,nx_wrfcmaq, &
            ny_wrfcmaq,nz_wrfcmaq_met,nt_wrfcmaq_met)
            fld_wrfcmaq(:,:,:)=(bk_wt_wrfcmaq*wrfcmaq_vec(:,:,:,ll_wrfcmaq) + fw_wt_wrfcmaq* &
            wrfcmaq_vec(:,:,:,ll_wrfcmaq+1))/(bk_wt_wrfcmaq+fw_wt_wrfcmaq)
            deallocate(wrfcmaq_vec)
            allocate(q_wrfcmaq(nx,ny,nz))
            call wrfcmaq_interpolate_3dp(q_wrfcmaq,fld_wrfcmaq,p_wrfcmaq,p_ens_mn,wrfcmaq_i, &
            wrfcmaq_j,wrfcmaq_ii,wrfcmaq_jj,num_wrfcmaq,nx_wrfcmaq,ny_wrfcmaq,nz_wrfcmaq_met, &
            nx,ny,nz,.false.)
            deallocate(fld_wrfcmaq)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"WRFCMAQ_Q","kg/kg mixing ratio",q_wrfcmaq,nx,ny,nz)
!            print *, 'Q WRFCMAQ MN ',q_wrfcmaq(:,:,1);
!
! TCR2 data
! Met file vertical grid is bottom to top; h0001.nc vertical grid is top to bottom)
! Use the h0001.nc data            
!            tcr2_file=trim(tcr2_met_pre)//"q"//trim(tcr2_met_suf)
            tcr2_file=trim(tcr2_chem_file)
!            print *, 'TCR2 FILE ',trim(tcr2_file)
            allocate(q_tcr2(nx,ny,nz)) 
            allocate(fld_tcr2(nx_tcr2,ny_tcr2,nz_tcr2))
            allocate(tcr2_vec(nx_tcr2,ny_tcr2,nz_tcr2,nt_tcr2))
            call get_WRFCHEM_fld_real(trim(tcr2_file),"Q",tcr2_vec,nx_tcr2,ny_tcr2,nz_tcr2,nt_tcr2)
!            print *, 'TCR2 VEC ',tcr2_vec(:,:,1,1)
            fld_tcr2(:,:,:)=(bk_wt_tcr2*tcr2_vec(:,:,:,ll_tcr2) + fw_wt_tcr2* &
            tcr2_vec(:,:,:,ll_tcr2+1))/(bk_wt_tcr2+fw_wt_tcr2)
            call zinvert(fld_tcr2,nx_tcr2,ny_tcr2,nz_tcr2,1)
            deallocate(tcr2_vec)
!            print *,'TCR2 fld Q ',fld_tcr2(:,:,1)
!
! TCR2 spatial interpolation
            call spatial_interpolate_1dp(q_tcr2,fld_tcr2,p_tcr2,p_ens_mn, &
            tcr2_ll_ii,tcr2_ll_jj,tcr2_lr_ii,tcr2_lr_jj,tcr2_ul_ii,tcr2_ul_jj, &
            tcr2_ur_ii,tcr2_ur_jj,lon,lat,lon_tcr2,lat_tcr2, &
            nx_tcr2,ny_tcr2,nz_tcr2,nx,ny,nz)
!            print *,'TCR2 Q ',q_tcr2(:,:,1)
            deallocate(fld_tcr2)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"TCR2_Q","mixing ratio (kg/kg)",q_tcr2,nx,ny,nz)
!  
! CAMCHEM data
! Vertical grid is top to bottom)
!            print *, 'CAMCHEM FILE ',trim(camchem_file)
            allocate(q_camchem(nx,ny,nz))
            allocate(fld_camchem(nx_camchem,ny_camchem,nz_camchem))
            allocate(camchem_vec(nx_camchem,ny_camchem,nz_camchem,nt_camchem))
!
! In CAMCHEM Q is specific humidity (q = .622 * e / (P - 0.378 * e); e_d = P - e; q_mr = e / e_d)
!    q/0.622 = e / (P - 0.378 * e); q/0.622 * (P-0.378*e) = e; q/0.622*P - q/0.622*0.378*e = e;
!    q/0.622*P = (1. + q/0.622*0.378) * e; e = q/0.622*P / (1. + q/0.622*0.378)
!
! Use simplier formula mr=sp_hum/(1.-sp_hum)
!            
            call get_WRFCHEM_fld_real(trim(camchem_file),"Q",camchem_vec,nx_camchem, &
            ny_camchem,nz_camchem,nt_camchem)
!            print *, 'CAMCHEM Q VEC ',camchem_vec(:,:,1,1)     
            fld_camchem(:,:,:)=(bk_wt_camchem*camchem_vec(:,:,:,ll_camchem) + fw_wt_camchem* &
            camchem_vec(:,:,:,ll_camchem+1))/(bk_wt_camchem+fw_wt_camchem)
            deallocate(camchem_vec)
!
! Convert to mixing ratio
            call zinvert(fld_camchem,nx_camchem,ny_camchem,nz_camchem,1)
!            allocate(e_vapor(nx_camchem,ny_camchem,nz_camchem))
!            e_vapor(:,:,:)=fld_camchem(:,:,:)/.622*p_camchem(:,:,:) / (1.+fld_camchem(:,:,:)/.622*.378)
!            fld_camchem(:,:,:)=e_vapor(:,:,:)/(p_camchem(:,:,:)-e_vapor(:,:,:))
!            deallocate(e_vapor)
             fld_camchem(:,:,:)=fld_camchem(:,:,:)/(1.-fld_camchem(:,:,:))
!            print *, 'APM: Q CAMCHEM ',fld_camchem(:,:,1)
!
! CAMCHEM spatial interpolation
            call spatial_interpolate_3dp(q_camchem,fld_camchem,p_camchem,p_ens_mn, &
            camchem_ll_ii,camchem_ll_jj,camchem_lr_ii,camchem_lr_jj,camchem_ul_ii, &
            camchem_ul_jj,camchem_ur_ii,camchem_ur_jj,lon,lat,lon_camchem,lat_camchem, &
            nx_camchem,ny_camchem,nz_camchem,nx,ny,nz)
!            print *,'CAMCHEM Q ',q_camchem(:,:,1)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"CAMCHEM_Q","mixing ratio (kg/kg)",q_camchem,nx,ny,nz)
            deallocate(fld_camchem)
!
            allocate(q_conus_mn(nz),q_conus_sd(nz))
            allocate(q_urban_mn(nz),q_urban_sd(nz))
            allocate(q_rural_mn(nz),q_rural_sd(nz))
            allocate(q_cities_mn(num_cities,nz),q_cities_sd(num_cities,nz))
!
! TRACER I CONUS Spatial statistics Q
            call spatial_mean_and_variance(q_ens_mn,q_ens_sd, &
            q_conus_mn,q_conus_sd,wrfchem_conus_ii,wrfchem_conus_jj, &
            1,nx*ny,num_wrfchem_conus,nx,ny,nz)
!            print *, 'q_conus_mn TRACER1 ',q_conus_mn(:)
!            print *, 'q_conus_sd TRACER1 ',q_conus_sd(:)
             wrfchem_file=trim(path_output)//"/"//trim(file_output)
             call put_NETCDF_fld(trim(wrfchem_file),"TRACER_I_Q_CONUS_MN", &
             "mixing ratio (kg/kg)",q_conus_mn,nz,1,1)
             call put_NETCDF_fld(trim(wrfchem_file),"TRACER_I_Q_CONUS_SD", &
             "mixing ratio (kg/kg)",q_conus_sd,nz,1,1)
!
! TRACER I URBAN Spatial statistics Q
            call spatial_mean_and_variance(q_ens_mn,q_ens_sd, &
            q_urban_mn,q_urban_sd,wrfchem_urban_ii,wrfchem_urban_jj, &
            num_cities,npts_urban,wrfchem_urban_npts,nx,ny,nz)
!            print *, 'q_urban_mn TRACER1 ',q_urban_mn(:)
!            print *, 'q_urban_sd TRACER1 ',q_urban_sd(:)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"TRACER_I_Q_URBAN_MN", &
            "mixing ratio (kg/kg)",q_urban_mn,nz,1,1)
            call put_NETCDF_fld(trim(wrfchem_file),"TRACER_I_Q_URBAN_SD", &
            "mixing ratio (kg/kg)",q_urban_sd,nz,1,1)
!
! TRACER I RURAL Spatial statistics Q
            call spatial_mean_and_variance(q_ens_mn,q_ens_sd, &
            q_rural_mn,q_rural_sd,wrfchem_rural_ii,wrfchem_rural_jj, &
            1,nx*ny,num_wrfchem_rural,nx,ny,nz)
!            print *, 'q_rural_mn TRACER1 ',q_rural_mn(:)
!            print *, 'q_rural_sd TRACER1 ',q_rural_sd(:)
             wrfchem_file=trim(path_output)//"/"//trim(file_output)
             call put_NETCDF_fld(trim(wrfchem_file),"TRACER_I_Q_RURAL_MN", &
             "mixing ratio (kg/kg)",q_rural_mn,nz,1,1)
             call put_NETCDF_fld(trim(wrfchem_file),"TRACER_I_Q_RURAL_SD", &
             "mixing ratio (kg/kg)",q_rural_sd,nz,1,1)
!
! WRFCMAQ CONUS Spatial statistics Q
            call spatial_mean_and_variance(q_wrfcmaq,q_wrfcmaq, &
            q_conus_mn,q_conus_sd,wrfcmaq_conus_ii,wrfcmaq_conus_jj, &
            1,nx*ny,num_wrfcmaq_conus,nx,ny,nz)
!            print *, 'q_conus_mn WRFCMAQ ',q_conus_mn(:)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"WRFCMAQ_Q_CONUS_MN", &
            "kg/kg ppm",q_conus_mn,nz,1,1)
!
! WRFCMAQ URBAN Spatial statistics Q
            call spatial_mean_and_variance(q_wrfcmaq,q_wrfcmaq, &
            q_urban_mn,q_urban_sd,wrfcmaq_urban_ii,wrfcmaq_urban_jj, &
            num_cities,npts_urban,num_wrfcmaq_urban,nx,ny,nz)
!            print *, 'q_urban_mn WRFCMAQ ',q_urban_mn(:)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"WRFCMAQ_Q_URBAN_MN", &
            "kg/kg ppm",q_urban_mn,nz,1,1)
!
! WRFCMAQ RURAL Spatial statistics Q
            call spatial_mean_and_variance(q_wrfcmaq,q_wrfcmaq, &
            q_rural_mn,q_rural_sd,wrfcmaq_rural_ii,wrfcmaq_rural_jj, &
            1,nx*ny,num_wrfcmaq_rural,nx,ny,nz)
!            print *, 'q_rural_mn WRFCMAQ ',q_rural_mn(:)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"WRFCMAQ_Q_RURAL_MN", &
            "kg/kg ppm",q_rural_mn,nz,1,1)
!
! TCR2 CONUS Spatial statistics Q
            call spatial_mean_and_variance(q_tcr2,q_tcr2, &
            q_conus_mn,q_conus_sd,wrfchem_conus_ii,wrfchem_conus_jj, &
            1,nx*ny,num_wrfchem_conus,nx,ny,nz)
!            print *, 'q_conus_mn TCR2 ',q_conus_mn(:)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"TCR2_Q_CONUS_MN", &
            "mixing ratio (kg/kg)",q_conus_mn,nz,1,1)

! TCR2 URBAN Spatial statistics Q
            call spatial_mean_and_variance(q_tcr2,q_tcr2, &
            q_urban_mn,q_urban_sd,wrfchem_urban_ii,wrfchem_urban_jj, &
            num_cities,npts_urban,wrfchem_urban_npts,nx,ny,nz)
!            print *, 'q_urban_mn TCR2 ',q_urban_mn(:)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"TCR2_Q_URBAN_MN", &
            "mixing ratio (kg/kg)",q_urban_mn,nz,1,1)
!
! TCR2 RURAL Spatial statistics Q
            call spatial_mean_and_variance(q_tcr2,q_tcr2, &
            q_rural_mn,q_rural_sd,wrfchem_rural_ii,wrfchem_rural_jj, &
            1,nx*ny,num_wrfchem_rural,nx,ny,nz)
!            print *, 'q_rural_mn TCR2 ',q_rural_mn(:)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"TCR2_Q_RURAL_MN", &
            "mixing ratio (kg/kg)",q_rural_mn,nz,1,1)
!
! CAMCHEM CONUS Spatial statistics Q
            call spatial_mean_and_variance(q_camchem,q_camchem, &
            q_conus_mn,q_conus_sd,wrfchem_conus_ii,wrfchem_conus_jj, &
            1,nx*ny,num_wrfchem_conus,nx,ny,nz)
!            print *, 'q_conus_mn CAMCHEM ',q_conus_mn(:)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"CAMCHEM_Q_CONUS_MN", &
            "mixing ratio (kg/kg)",q_conus_mn,nz,1,1)

! CAMCHEM URBAN Spatial statistics Q
            call spatial_mean_and_variance(q_camchem,q_camchem, &
            q_urban_mn,q_urban_sd,wrfchem_urban_ii,wrfchem_urban_jj, &
            num_cities,npts_urban,wrfchem_urban_npts,nx,ny,nz)
!            print *, 'q_urban_mn CAMCHEM ',q_urban_mn(:)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"CAMCHEM_Q_URBAN_MN", &
            "mixing ratio (kg/kg)",q_urban_mn,nz,1,1)
!
! CAMCHEM RURAL Spatial statistics Q
            call spatial_mean_and_variance(q_camchem,q_camchem, &
            q_rural_mn,q_rural_sd,wrfchem_rural_ii,wrfchem_rural_jj, &
            1,nx*ny,num_wrfchem_rural,nx,ny,nz)
!            print *, 'q_rural_mn CAMCHEM ',q_rural_mn(:)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"CAMCHEM_Q_RURAL_MN", &
            "mixing ratio (kg/kg)",q_rural_mn,nz,1,1)
!
            deallocate(q_ens_mn)           
            deallocate(q_ens_sd)           
            deallocate(q_tcr2)           
            deallocate(q_wrfcmaq)           
            deallocate(q_camchem)           
            deallocate(q_conus_mn)
            deallocate(q_conus_sd)
            deallocate(q_urban_mn)
            deallocate(q_urban_sd)
            deallocate(q_rural_mn)
            deallocate(q_rural_sd)
            deallocate(q_cities_mn)
            deallocate(q_cities_sd)
            print *, '   APM: After process Q'
         endif
      enddo  
!
! Chem fields
      do ifld=1,num_chem_flds
!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!
! CO
!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!
         if(trim(chem_flds(ifld)).eq."co") then
            print *, '   APM: Before process CO'
!
! TRACER I            
            allocate(co_fld(nx,ny,nz,num_mems))
            do imem=1,num_mems
               if(imem.ge.0.and.imem.lt.10) write(cmem,"('/run_e00',i1)"),imem
               if(imem.ge.10.and.imem.lt.100) write(cmem,"('/run_e0',i2)"),imem
               if(imem.ge.100.and.imem.lt.1000) write(cmem,"('/run_e',i3)"),imem
               wrfchem_file=trim(path_input)//trim(cmem)//"/"//trim(wrfout_input)
               call get_WRFCHEM_fld_real(trim(wrfchem_file),"co",co_fld(1,1,1,imem),nx,ny,nz,1)
            enddo
            allocate(co_ens_mn(nx,ny,nz))
            allocate(co_ens_sd(nx,ny,nz))
! Ensemble stats CO
            call ens_stats(co_fld,co_ens_mn,co_ens_sd,nx,ny,nz,num_mems)
            deallocate(co_fld)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"TRACER_I_CO_MN","mixing ratio (kg/kg)",co_ens_mn,nx,ny,nz)
            call put_NETCDF_fld(trim(wrfchem_file),"TRACER_I_CO_SD","mixing ratio (kg/kg)",co_ens_sd,nx,ny,nz)
!
! WRFCMAQ
            allocate(wrfcmaq_vec(nx_wrfcmaq,ny_wrfcmaq,nz_wrfcmaq_chem,nt_wrfcmaq_chem))
            allocate(fld_wrfcmaq(nx_wrfcmaq,ny_wrfcmaq,nz_wrfcmaq_chem))
            print *, 'FILE ',trim(wrfcmaq_metdot3d)
            call get_WRFCHEM_fld_real(trim(wrfcmaq_chemcro2d),"CO",wrfcmaq_vec,nx_wrfcmaq, &
            ny_wrfcmaq,nz_wrfcmaq_chem,nt_wrfcmaq_chem)
!            print *, 'CO VEC ',wrfcmaq_vec(:,:,nz_wrfcmaq_chem,49)
!
! WRFCMAQ chemistry has one month of data per file and only one vertical level
! find time index
            ll_wrfcmaq=(dd_wrfchem-1)*24+hh_wrfchem+1
            fld_wrfcmaq(:,:,:)=wrfcmaq_vec(:,:,:,ll_wrfcmaq)
            deallocate(wrfcmaq_vec)
            allocate(co_wrfcmaq(nx,ny,nz))
            call wrfcmaq_interpolate_2dh(co_wrfcmaq,fld_wrfcmaq,wrfcmaq_i,wrfcmaq_j, &
            wrfcmaq_ii,wrfcmaq_jj,num_wrfcmaq,nx_wrfcmaq,ny_wrfcmaq,nz_wrfcmaq_chem,nx,ny,nz)
            deallocate(fld_wrfcmaq)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"WRFCMAQ_CO","kg/kg mixing ratio",co_wrfcmaq,nx,ny,nz)
!            print *, 'CO WRFCMAQ MN ',co_wrfcmaq(:,:,1);
!
! Read TCR2 data (vertical grid is bottom to top)
            tcr2_file=trim(tcr2_chem_file)
!            print *, 'TCR2 FILE ',trim(tcr2_file)
            allocate(co_tcr2(nx,ny,nz))
            allocate(fld_tcr2(nx_tcr2,ny_tcr2,nz_tcr2))
            allocate(tcr2_vec(nx_tcr2,ny_tcr2,nz_tcr2,nt_tcr2))
            call get_WRFCHEM_fld_real(trim(tcr2_file),"CO_VMR_inst",tcr2_vec,nx_tcr2,ny_tcr2,nz_tcr2,nt_tcr2)
!            print *, 'APM: ll_tcr2 ',ll_tcr2
!            print *, 'TCR2 VEC ll',tcr2_vec(nx_tcr2/5,ny_tcr2/5,:,ll_tcr2)
!            print *, 'TCR2 VEC ll+1',tcr2_vec(nx_tcr2/5,ny_tcr2/5,:,ll_tcr2+1)
!
            fld_tcr2(:,:,:)=(bk_wt_tcr2*tcr2_vec(:,:,:,ll_tcr2) + fw_wt_tcr2* &
            tcr2_vec(:,:,:,ll_tcr2+1))/(bk_wt_tcr2+fw_wt_tcr2)
            call zinvert(fld_tcr2,nx_tcr2,ny_tcr2,nz_tcr2,1)
!
! Convert units to ppm
            fld_tcr2(:,:,:)=fld_tcr2(:,:,:)*1.e6
            deallocate(tcr2_vec)
!            print *,'TCR2 fld CO ',fld_tcr2(nx_tcr2/5,ny_tcr2/5,:)
!            print *,'TCR2 P ',p_tcr2(:)
!
! TCR2 spatial interpolation
            call spatial_interpolate_1dp(co_tcr2,fld_tcr2,p_tcr2,p_ens_mn, &
            tcr2_ll_ii,tcr2_ll_jj,tcr2_lr_ii,tcr2_lr_jj,tcr2_ul_ii,tcr2_ul_jj, &
            tcr2_ur_ii,tcr2_ur_jj,lon,lat,lon_tcr2,lat_tcr2, &
            nx_tcr2,ny_tcr2,nz_tcr2,nx,ny,nz)
!            print *,'TCR2 CO ',co_tcr2(nx/5,ny/5,:)
!            print *,'TCR2 P ',p_tcr2(:)
!            print *,'TRACER1 P ',p_ens_mn(nx/5,ny/5,:)
            deallocate(fld_tcr2)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"TCR2_CO","mixing ratio (kg/kg)",co_tcr2,nx,ny,nz)
!  
! Read CAMCHEM data (vertical grid is top to bottom)
!            print *, 'CAMCHEM FILE ',trim(camchem_file)
            allocate(co_camchem(nx,ny,nz))
            allocate(fld_camchem(nx_camchem,ny_camchem,nz_camchem))
            allocate(camchem_vec(nx_camchem,ny_camchem,nz_camchem,nt_camchem))
!
            call get_WRFCHEM_fld_real(trim(camchem_file),"CO",camchem_vec,nx_camchem, &
            ny_camchem,nz_camchem,nt_camchem)
!            print *, 'CAMCHEM CO VEC ll ',camchem_vec(nx_camchem/5,ny_camchem/5,:,ll_camchem)
!            print *, 'CAMCHEM CO VEC ll+1',camchem_vec(nx_camchem/5,ny_camchem/5,:,ll_camchem+1)
            fld_camchem(:,:,:)=(bk_wt_camchem*camchem_vec(:,:,:,ll_camchem) + fw_wt_camchem* &
            camchem_vec(:,:,:,ll_camchem+1))/(bk_wt_camchem+fw_wt_camchem)
!
! Convert units from mol/mol to ppm
            fld_camchem(:,:,:)=fld_camchem(:,:,:)*1.e6*molcwt_co/molcwt_dry_air
!            
            call zinvert(fld_camchem,nx_camchem,ny_camchem,nz_camchem,1)
            deallocate(camchem_vec)
!            print *, 'APM: CO CAMCHEM FLD ',fld_camchem(nx_camchem/5,ny_camchem/5,:)
!
! CAMCHEM spatial interpolation
            call spatial_interpolate_3dp(co_camchem,fld_camchem,p_camchem,p_ens_mn, &
            camchem_ll_ii,camchem_ll_jj,camchem_lr_ii,camchem_lr_jj,camchem_ul_ii, &
            camchem_ul_jj,camchem_ur_ii,camchem_ur_jj,lon,lat,lon_camchem,lat_camchem, &
            nx_camchem,ny_camchem,nz_camchem,nx,ny,nz)
!            print *,'CAMCHEM CO ',co_camchem(nx/5,ny/5,:)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"CAMCHEM_CO","mixing ratio (kg/kg)",co_camchem,nx,ny,nz)
            deallocate(fld_camchem)
!
            allocate(co_conus_mn(nz),co_conus_sd(nz))
            allocate(co_urban_mn(nz),co_urban_sd(nz))
            allocate(co_rural_mn(nz),co_rural_sd(nz))
            allocate(co_cities_mn(num_cities,nz),co_cities_sd(num_cities,nz))
!
! TRACER I CONUS Spatial statistics CO
            call spatial_mean_and_variance(co_ens_mn,co_ens_sd, &
            co_conus_mn,co_conus_sd,wrfchem_conus_ii,wrfchem_conus_jj, &
            1,nx*ny,num_wrfchem_conus,nx,ny,nz)
!            print *, 'co_conus_mn TRACER1 ',co_conus_mn(:)
!            print *, 'co_conus_sd TRACER1 ',co_conus_sd(:)
             wrfchem_file=trim(path_output)//"/"//trim(file_output)
             call put_NETCDF_fld(trim(wrfchem_file),"TRACER_I_CO_CONUS_MN", &
             "mixing ratio (kg/kg)",co_conus_mn,nz,1,1)
             call put_NETCDF_fld(trim(wrfchem_file),"TRACER_I_CO_CONUS_SD", &
             "mixing ratio (kg/kg)",co_conus_sd,nz,1,1)
!
! TRACER I URBAN Spatial statistics CO
            call spatial_mean_and_variance(co_ens_mn,co_ens_sd, &
            co_urban_mn,co_urban_sd,wrfchem_urban_ii,wrfchem_urban_jj, &
            num_cities,npts_urban,wrfchem_urban_npts,nx,ny,nz)
!            print *, 'co_urban_mn TRACER1 ',co_urban_mn(:)
!            print *, 'co_urban_sd TRACER1 ',co_urban_sd(:)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"TRACER_I_CO_URBAN_MN", &
            "mixing ratio (kg/kg)",co_urban_mn,nz,1,1)
            call put_NETCDF_fld(trim(wrfchem_file),"TRACER_I_CO_URBAN_SD", &
            "mixing ratio (kg/kg)",co_urban_sd,nz,1,1)
!            
! TRACER I RURAL Spatial statistics CO
            call spatial_mean_and_variance(co_ens_mn,co_ens_sd, &
            co_rural_mn,co_rural_sd,wrfchem_rural_ii,wrfchem_rural_jj, &
            1,nx*ny,num_wrfchem_rural,nx,ny,nz)
!            print *, 'co_rural_mn TRACER1 ',co_rural_mn(:)
!            print *, 'co_rural_sd TRACER1 ',co_rural_sd(:)
             wrfchem_file=trim(path_output)//"/"//trim(file_output)
             call put_NETCDF_fld(trim(wrfchem_file),"TRACER_I_CO_RURAL_MN", &
             "mixing ratio (kg/kg)",co_rural_mn,nz,1,1)
             call put_NETCDF_fld(trim(wrfchem_file),"TRACER_I_CO_RURAL_SD", &
             "mixing ratio (kg/kg)",co_rural_sd,nz,1,1)
!
! WRFCMAQ CONUS Spatial statistics CO
            call spatial_mean_and_variance(co_wrfcmaq,co_wrfcmaq, &
            co_conus_mn,co_conus_sd,wrfcmaq_conus_ii,wrfcmaq_conus_jj, &
            1,nx*ny,num_wrfcmaq_conus,nx,ny,nz)
!            print *, 'co_conus_mn WRFCMAQ ',co_conus_mn(:)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"WRFCMAQ_CO_CONUS_MN", &
            "kg/kg ppm",co_conus_mn,nz,1,1)
!
! WRFCMAQ URBAN Spatial statistics CO
            call spatial_mean_and_variance(co_wrfcmaq,co_wrfcmaq, &
            co_urban_mn,co_urban_sd,wrfcmaq_urban_ii,wrfcmaq_urban_jj, &
            num_cities,npts_urban,num_wrfcmaq_urban,nx,ny,nz)
!            print *, 'co_urban_mn WRFCMAQ ',co_urban_mn(:)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"WRFCMAQ_CO_URBAN_MN", &
            "kg/kg ppm",co_urban_mn,nz,1,1)
!
! WRFCMAQ RURAL Spatial statistics CO
            call spatial_mean_and_variance(co_wrfcmaq,co_wrfcmaq, &
            co_rural_mn,co_rural_sd,wrfcmaq_rural_ii,wrfcmaq_rural_jj, &
            1,nx*ny,num_wrfcmaq_rural,nx,ny,nz)
!            print *, 'co_rural_mn WRFCMAQ ',co_rural_mn(:)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"WRFCMAQ_CO_RURAL_MN", &
            "kg/kg ppm",co_rural_mn,nz,1,1)
!
! TCR2 CONUS Spatial statistics CO
            call spatial_mean_and_variance(co_tcr2,co_tcr2, &
            co_conus_mn,co_conus_sd,wrfchem_conus_ii,wrfchem_conus_jj, &
            1,nx*ny,num_wrfchem_conus,nx,ny,nz)
!            print *, 'co_conus_mn TCR2 ',co_conus_mn(:)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"TCR2_CO_CONUS_MN", &
            "mixing ratio (kg/kg)",co_conus_mn,nz,1,1)

! TCR2 URBAN Spatial statistics CO
            call spatial_mean_and_variance(co_tcr2,co_tcr2, &
            co_urban_mn,co_urban_sd,wrfchem_urban_ii,wrfchem_urban_jj, &
            num_cities,npts_urban,wrfchem_urban_npts,nx,ny,nz)
!            print *, 'co_urban_mn TCR2 ',co_urban_mn(:)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"TCR2_CO_URBAN_MN", &
            "mixing ratio (kg/kg)",co_urban_mn,nz,1,1)
!
! TCR2 RURAL Spatial statistics CO
            call spatial_mean_and_variance(co_tcr2,co_tcr2, &
            co_rural_mn,co_rural_sd,wrfchem_rural_ii,wrfchem_rural_jj, &
            1,nx*ny,num_wrfchem_rural,nx,ny,nz)
!            print *, 'co_rural_mn TCR2 ',co_rural_mn(:)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"TCR2_CO_RURAL_MN", &
            "mixing ratio (kg/kg)",co_rural_mn,nz,1,1)
!
! CAMCHEM CONUS Spatial statistics CO
            call spatial_mean_and_variance(co_camchem,co_camchem, &
            co_conus_mn,co_conus_sd,wrfchem_conus_ii,wrfchem_conus_jj, &
            1,nx*ny,num_wrfchem_conus,nx,ny,nz)
!            print *, 'co_conus_mn CAMCHEM ',co_conus_mn(:)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"CAMCHEM_CO_CONUS_MN", &
            "mixing ratio (kg/kg)",co_conus_mn,nz,1,1)

! CAMCHEM URBAN Spatial statistics CO
            call spatial_mean_and_variance(co_camchem,co_camchem, &
            co_urban_mn,co_urban_sd,wrfchem_urban_ii,wrfchem_urban_jj, &
            num_cities,npts_urban,wrfchem_urban_npts,nx,ny,nz)
!            print *, 'co_urban_mn CAMCHEM ',co_urban_mn(:)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"CAMCHEM_CO_URBAN_MN", &
            "mixing ratio (kg/kg)",co_urban_mn,nz,1,1)
!
! CAMCHEM RURAL Spatial statistics CO
            call spatial_mean_and_variance(co_camchem,co_camchem, &
            co_rural_mn,co_rural_sd,wrfchem_rural_ii,wrfchem_rural_jj, &
            1,nx*ny,num_wrfchem_rural,nx,ny,nz)
!            print *, 'co_rural_mn CAMCHEM ',co_rural_mn(:)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"CAMCHEM_CO_RURAL_MN", &
            "mixing ratio (kg/kg)",co_rural_mn,nz,1,1)
!
            deallocate(co_ens_mn)           
            deallocate(co_ens_sd)           
!            deallocate(co_wrfcmaq)           
            deallocate(co_tcr2)           
            deallocate(co_camchem)           
            deallocate(co_conus_mn)
            deallocate(co_conus_sd)
            deallocate(co_urban_mn)
            deallocate(co_urban_sd)
            deallocate(co_rural_mn)
            deallocate(co_rural_sd)
            deallocate(co_cities_mn)
            deallocate(co_cities_sd)
            print *, '   APM: After process CO'
!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!
! O3
!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!
         elseif(trim(chem_flds(ifld)).eq."o3") then
            print *, '   APM: Before process O3'
            allocate(o3_fld(nx,ny,nz,num_mems))
            do imem=1,num_mems
               if(imem.ge.0.and.imem.lt.10) write(cmem,"('/run_e00',i1)"),imem
               if(imem.ge.10.and.imem.lt.100) write(cmem,"('/run_e0',i2)"),imem
               if(imem.ge.100.and.imem.lt.1000) write(cmem,"('/run_e',i3)"),imem
               wrfchem_file=trim(path_input)//trim(cmem)//"/"//trim(wrfout_input)
               call get_WRFCHEM_fld_real(trim(wrfchem_file),"o3",o3_fld(1,1,1,imem),nx,ny,nz,1)
            enddo
            allocate(o3_ens_mn(nx,ny,nz))
            allocate(o3_ens_sd(nx,ny,nz))
! Ensemble stats O3
            call ens_stats(o3_fld,o3_ens_mn,o3_ens_sd,nx,ny,nz,num_mems)
            deallocate(o3_fld)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"TRACER_I_O3_MN","mixing ratio (kg/kg)",o3_ens_mn,nx,ny,nz)
            call put_NETCDF_fld(trim(wrfchem_file),"TRACER_I_O3_SD","mixing ratio (kg/kg)",o3_ens_sd,nx,ny,nz)
!
! WRFCMAQ
            allocate(wrfcmaq_vec(nx_wrfcmaq,ny_wrfcmaq,nz_wrfcmaq_chem,nt_wrfcmaq_chem))
            allocate(fld_wrfcmaq(nx_wrfcmaq,ny_wrfcmaq,nz_wrfcmaq_chem))
!            print *, 'FILE ',trim(wrfcmaq_metdot3d)
            call get_WRFCHEM_fld_real(trim(wrfcmaq_chemcro2d),"O3",wrfcmaq_vec,nx_wrfcmaq, &
            ny_wrfcmaq,nz_wrfcmaq_chem,nt_wrfcmaq_chem)
!            print *, 'O3 VEC ',wrfcmaq_vec(:,:,nz_wrfcmaq_chem,49)
!
! WRFCMAQ chemistry has one month of data per file and only one vertical level
! find time index
            ll_wrfcmaq=(dd_wrfchem-1)*24+hh_wrfchem+1
            fld_wrfcmaq(:,:,:)=wrfcmaq_vec(:,:,:,ll_wrfcmaq)
            deallocate(wrfcmaq_vec)
            allocate(o3_wrfcmaq(nx,ny,nz))
            call wrfcmaq_interpolate_2dh(o3_wrfcmaq,fld_wrfcmaq,wrfcmaq_i,wrfcmaq_j, &
            wrfcmaq_ii,wrfcmaq_jj,num_wrfcmaq,nx_wrfcmaq,ny_wrfcmaq,nz_wrfcmaq_chem,nx,ny,nz)
            deallocate(fld_wrfcmaq)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"WRFCMAQ_O3","kg/kg mixing ratio",o3_wrfcmaq,nx,ny,nz)
!            print *, 'O3 WRFCMAQ MN ',o3_wrfcmaq(:,:,1);
!
! Read TCR2 data (vertical grid is bottom to top)
            tcr2_file=trim(tcr2_chem_file)
!            print *, 'TCR2 FILE ',trim(tcr2_file)
            allocate(o3_tcr2(nx,ny,nz))
            allocate(fld_tcr2(nx_tcr2,ny_tcr2,nz_tcr2))
            allocate(tcr2_vec(nx_tcr2,ny_tcr2,nz_tcr2,nt_tcr2))
            call get_WRFCHEM_fld_real(trim(tcr2_file),"O3_VMR_inst",tcr2_vec,nx_tcr2,ny_tcr2,nz_tcr2,nt_tcr2)
!            print *, 'TCR2 VEC ',tcr2_vec(:,:,1,1)
            fld_tcr2(:,:,:)=(bk_wt_tcr2*tcr2_vec(:,:,:,ll_tcr2) + fw_wt_tcr2* &
            tcr2_vec(:,:,:,ll_tcr2+1))/(bk_wt_tcr2+fw_wt_tcr2)
!
! Convert units from to ppm
            fld_tcr2(:,:,:)=fld_tcr2(:,:,:)*1.e6
!            
            call zinvert(fld_tcr2,nx_tcr2,ny_tcr2,nz_tcr2,1)
            deallocate(tcr2_vec)
!            print *,'TCR2 fld O3 ',fld_tcr2(:,:,1)
!
! TCR2 spatial interpolation
            call spatial_interpolate_1dp(o3_tcr2,fld_tcr2,p_tcr2,p_ens_mn, &
            tcr2_ll_ii,tcr2_ll_jj,tcr2_lr_ii,tcr2_lr_jj,tcr2_ul_ii,tcr2_ul_jj, &
            tcr2_ur_ii,tcr2_ur_jj,lon,lat,lon_tcr2,lat_tcr2, &
            nx_tcr2,ny_tcr2,nz_tcr2,nx,ny,nz)
!            print *,'TCR2 O3 ',o3_tcr2(:,:,1)
            deallocate(fld_tcr2)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"TCR2_O3","mixing ratio (kg/kg)",o3_tcr2,nx,ny,nz)
!  
! Read CAMCHEM data (vertical grid is top to bottom)
!            print *, 'CAMCHEM FILE ',trim(camchem_file)
            allocate(o3_camchem(nx,ny,nz))
            allocate(fld_camchem(nx_camchem,ny_camchem,nz_camchem))
            allocate(camchem_vec(nx_camchem,ny_camchem,nz_camchem,nt_camchem))
!
            call get_WRFCHEM_fld_real(trim(camchem_file),"O3",camchem_vec,nx_camchem, &
            ny_camchem,nz_camchem,nt_camchem)
!            print *, 'CAMCHEM O3 VEC ',camchem_vec(:,:,1,1)     
            fld_camchem(:,:,:)=(bk_wt_camchem*camchem_vec(:,:,:,ll_camchem) + fw_wt_camchem* &
            camchem_vec(:,:,:,ll_camchem+1))/(bk_wt_camchem+fw_wt_camchem)
!
! Convert units from mol/mol to ppm
            fld_camchem(:,:,:)=fld_camchem(:,:,:)*1.e6*molcwt_o3/molcwt_dry_air
!            
            call zinvert(fld_camchem,nx_camchem,ny_camchem,nz_camchem,1)
            deallocate(camchem_vec)
!            print *, 'APM: O3 CAMCHEM ',fld_camchem(:,:,1)
!
! CAMCHEM spatial interpolation
            call spatial_interpolate_3dp(o3_camchem,fld_camchem,p_camchem,p_ens_mn, &
            camchem_ll_ii,camchem_ll_jj,camchem_lr_ii,camchem_lr_jj,camchem_ul_ii, &
            camchem_ul_jj,camchem_ur_ii,camchem_ur_jj,lon,lat,lon_camchem,lat_camchem, &
            nx_camchem,ny_camchem,nz_camchem,nx,ny,nz)
!            print *,'CAMCHEM O3 ',o3_camchem(:,:,1)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"CAMCHEM_O3","mixing ratio (kg/kg)",o3_camchem,nx,ny,nz)
            deallocate(fld_camchem)
!
            allocate(o3_conus_mn(nz),o3_conus_sd(nz))
            allocate(o3_urban_mn(nz),o3_urban_sd(nz))
            allocate(o3_rural_mn(nz),o3_rural_sd(nz))
            allocate(o3_cities_mn(num_cities,nz),o3_cities_sd(num_cities,nz))
!
! TRACER I CONUS Spatial statistics O3
            call spatial_mean_and_variance(o3_ens_mn,o3_ens_sd, &
            o3_conus_mn,o3_conus_sd,wrfchem_conus_ii,wrfchem_conus_jj, &
            1,nx*ny,num_wrfchem_conus,nx,ny,nz)
!            print *, 'o3_conus_mn TRACER1 ',o3_conus_mn(:)
!            print *, 'o3_conus_sd TRACER1 ',o3_conus_sd(:)
             wrfchem_file=trim(path_output)//"/"//trim(file_output)
             call put_NETCDF_fld(trim(wrfchem_file),"TRACER_I_O3_CONUS_MN", &
             "mixing ratio (kg/kg)",o3_conus_mn,nz,1,1)
             call put_NETCDF_fld(trim(wrfchem_file),"TRACER_I_O3_CONUS_SD", &
             "mixing ratio (kg/kg)",o3_conus_sd,nz,1,1)
!
! TRACER I URBAN Spatial statistics O3
            call spatial_mean_and_variance(o3_ens_mn,o3_ens_sd, &
            o3_urban_mn,o3_urban_sd,wrfchem_urban_ii,wrfchem_urban_jj, &
            num_cities,npts_urban,wrfchem_urban_npts,nx,ny,nz)
!            print *, 'o3_urban_mn TRACER1 ',o3_urban_mn(:)
!            print *, 'o3_urban_sd TRACER1 ',o3_urban_sd(:)
             wrfchem_file=trim(path_output)//"/"//trim(file_output)
             call put_NETCDF_fld(trim(wrfchem_file),"TRACER_I_O3_URBAN_MN", &
             "mixing ratio (kg/kg)",o3_urban_mn,nz,1,1)
             call put_NETCDF_fld(trim(wrfchem_file),"TRACER_I_O3_URBAN_SD", &
             "mixing ratio (kg/kg)",o3_urban_sd,nz,1,1)
!
! TRACER I RURAL Spatial statistics O3
            call spatial_mean_and_variance(o3_ens_mn,o3_ens_sd, &
            o3_rural_mn,o3_rural_sd,wrfchem_rural_ii,wrfchem_rural_jj, &
            1,nx*ny,num_wrfchem_rural,nx,ny,nz)
!            print *, 'o3_rural_mn TRACER1 ',o3_rural_mn(:)
!            print *, 'o3_rural_sd TRACER1 ',o3_rural_sd(:)
             wrfchem_file=trim(path_output)//"/"//trim(file_output)
             call put_NETCDF_fld(trim(wrfchem_file),"TRACER_I_O3_RURAL_MN", &
             "mixing ratio (kg/kg)",o3_rural_mn,nz,1,1)
             call put_NETCDF_fld(trim(wrfchem_file),"TRACER_I_O3_RURAL_SD", &
             "mixing ratio (kg/kg)",o3_rural_sd,nz,1,1)
!
! WRFCMAQ CONUS Spatial statistics O3
            call spatial_mean_and_variance(o3_wrfcmaq,o3_wrfcmaq, &
            o3_conus_mn,o3_conus_sd,wrfcmaq_conus_ii,wrfcmaq_conus_jj, &
            1,nx*ny,num_wrfcmaq_conus,nx,ny,nz)
!            print *, 'o3_conus_mn WRFCMAQ ',o3_conus_mn(:)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"WRFCMAQ_O3_CONUS_MN", &
            "mixing ratio (kg/kg)",o3_conus_mn,nz,1,1)
!
! WRFCMAQ URBAN Spatial statistics O3
            call spatial_mean_and_variance(o3_wrfcmaq,o3_wrfcmaq, &
            o3_urban_mn,o3_urban_sd,wrfcmaq_urban_ii,wrfcmaq_urban_jj, &
            num_cities,npts_urban,num_wrfcmaq_urban,nx,ny,nz)
!            print *, 'o3_urban_mn WRFCMAQ ',o3_urban_mn(:)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"WRFCMAQ_O3_URBAN_MN", &
            "mixing ratio (kg/kg)",o3_urban_mn,nz,1,1)
!
! WRFCMAQ RURAL Spatial statistics O3
            call spatial_mean_and_variance(o3_wrfcmaq,o3_wrfcmaq, &
            o3_rural_mn,o3_rural_sd,wrfcmaq_rural_ii,wrfcmaq_rural_jj, &
            1,nx*ny,num_wrfcmaq_rural,nx,ny,nz)
!            print *, 'o3_rural_mn WRFCMAQ',o3_rural_mn(:)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"WRFCMAQ_O3_RURAL_MN", &
            "mixing ratio (kg/kg)",o3_rural_mn,nz,1,1)
!
! TCR2 CONUS Spatial statistics O3
            call spatial_mean_and_variance(o3_tcr2,o3_tcr2, &
            o3_conus_mn,o3_conus_sd,wrfchem_conus_ii,wrfchem_conus_jj, &
            1,nx*ny,num_wrfchem_conus,nx,ny,nz)
!            print *, 'o3_conus_mn TCR2 ',o3_conus_mn(:)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"TCR2_O3_CONUS_MN", &
            "mixing ratio (kg/kg)",o3_conus_mn,nz,1,1)

! TCR2 URBAN Spatial statistics O3
            call spatial_mean_and_variance(o3_tcr2,o3_tcr2, &
            o3_urban_mn,o3_urban_sd,wrfchem_urban_ii,wrfchem_urban_jj, &
            num_cities,npts_urban,wrfchem_urban_npts,nx,ny,nz)
!            print *, 'o3_urban_mn TCR2 ',o3_urban_mn(:)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"TCR2_O3_URBAN_MN", &
            "mixing ratio (kg/kg)",o3_urban_mn,nz,1,1)
!
! TCR2 RURAL Spatial statistics O3
            call spatial_mean_and_variance(o3_tcr2,o3_tcr2, &
            o3_rural_mn,o3_rural_sd,wrfchem_rural_ii,wrfchem_rural_jj, &
            1,nx*ny,num_wrfchem_rural,nx,ny,nz)
!            print *, 'o3_rural_mn TCR2 ',o3_rural_mn(:)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"TCR2_O3_RURAL_MN", &
            "mixing ratio (kg/kg)",o3_rural_mn,nz,1,1)
!
! CAMCHEM CONUS Spatial statistics O3
            call spatial_mean_and_variance(o3_camchem,o3_camchem, &
            o3_conus_mn,o3_conus_sd,wrfchem_conus_ii,wrfchem_conus_jj, &
            1,nx*ny,num_wrfchem_conus,nx,ny,nz)
!            print *, 'o3_conus_mn CAMCHEM ',o3_conus_mn(:)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"CAMCHEM_O3_CONUS_MN", &
            "mixing ratio (kg/kg)",o3_conus_mn,nz,1,1)

! CAMCHEM URBAN Spatial statistics O3
            call spatial_mean_and_variance(o3_camchem,o3_camchem, &
            o3_urban_mn,o3_urban_sd,wrfchem_urban_ii,wrfchem_urban_jj, &
            num_cities,npts_urban,wrfchem_urban_npts,nx,ny,nz)
!            print *, 'o3_urban_mn CAMCHEM ',o3_urban_mn(:)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"CAMCHEM_O3_URBAN_MN", &
            "mixing ratio (kg/kg)",o3_urban_mn,nz,1,1)
!
! CAMCHEM RURAL Spatial statistics O3
            call spatial_mean_and_variance(o3_camchem,o3_camchem, &
            o3_rural_mn,o3_rural_sd,wrfchem_rural_ii,wrfchem_rural_jj, &
            1,nx*ny,num_wrfchem_rural,nx,ny,nz)
!            print *, 'o3_rural_mn CAMCHEM ',o3_rural_mn(:)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"CAMCHEM_O3_RURAL_MN", &
            "mixing ratio (kg/kg)",o3_rural_mn,nz,1,1)
!
            deallocate(o3_ens_mn)           
            deallocate(o3_ens_sd)           
            deallocate(o3_tcr2)           
            deallocate(o3_wrfcmaq)           
            deallocate(o3_camchem)           
            deallocate(o3_conus_mn)
            deallocate(o3_conus_sd)
            deallocate(o3_urban_mn)
            deallocate(o3_urban_sd)
            deallocate(o3_rural_mn)
            deallocate(o3_rural_sd)
            deallocate(o3_cities_mn)
            deallocate(o3_cities_sd)
            print *, '   APM: After process O3'
!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!
! NO2
!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!
         elseif(trim(chem_flds(ifld)).eq."no2") then
            print *, '   APM: Before process NO2'
!
! TRACER I            
            allocate(no2_fld(nx,ny,nz,num_mems))
            do imem=1,num_mems
               if(imem.ge.0.and.imem.lt.10) write(cmem,"('/run_e00',i1)"),imem
               if(imem.ge.10.and.imem.lt.100) write(cmem,"('/run_e0',i2)"),imem
               if(imem.ge.100.and.imem.lt.1000) write(cmem,"('/run_e',i3)"),imem
               wrfchem_file=trim(path_input)//trim(cmem)//"/"//trim(wrfout_input)
               call get_WRFCHEM_fld_real(trim(wrfchem_file),"no2",no2_fld(1,1,1,imem),nx,ny,nz,1)
            enddo
            allocate(no2_ens_mn(nx,ny,nz))
            allocate(no2_ens_sd(nx,ny,nz))
! Ensemble stats NO2
            call ens_stats(no2_fld,no2_ens_mn,no2_ens_sd,nx,ny,nz,num_mems)
            deallocate(no2_fld)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"TRACER_I_NO2_MN", &
            "mixing ratio (kg/kg)",no2_ens_mn,nx,ny,nz)
            call put_NETCDF_fld(trim(wrfchem_file),"TRACER_I_NO2_SD", &
            "mixing ratio (kg/kg)",no2_ens_sd,nx,ny,nz)
!
! WRFCMAQ
            allocate(wrfcmaq_vec(nx_wrfcmaq,ny_wrfcmaq,nz_wrfcmaq_chem,nt_wrfcmaq_chem))
            allocate(fld_wrfcmaq(nx_wrfcmaq,ny_wrfcmaq,nz_wrfcmaq_chem))
!            print *, 'FILE ',trim(wrfcmaq_metdot3d)
            call get_WRFCHEM_fld_real(trim(wrfcmaq_chemcro2d),"NO2",wrfcmaq_vec,nx_wrfcmaq, &
            ny_wrfcmaq,nz_wrfcmaq_chem,nt_wrfcmaq_chem)
!            print *, 'NO2 VEC ',wrfcmaq_vec(:,:,nz_wrfcmaq_chem,49)
!
! WRFCMAQ chemistry has one month of data per file and only one vertical level
! find time index
            ll_wrfcmaq=(dd_wrfchem-1)*24+hh_wrfchem+1
            fld_wrfcmaq(:,:,:)=wrfcmaq_vec(:,:,:,ll_wrfcmaq)
            deallocate(wrfcmaq_vec)
            allocate(no2_wrfcmaq(nx,ny,nz))
            call wrfcmaq_interpolate_2dh(no2_wrfcmaq,fld_wrfcmaq,wrfcmaq_i,wrfcmaq_j, &
            wrfcmaq_ii,wrfcmaq_jj,num_wrfcmaq,nx_wrfcmaq,ny_wrfcmaq,nz_wrfcmaq_chem,nx,ny,nz)
            deallocate(fld_wrfcmaq)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"WRFCMAQ_NO2","kg/kg mixing ratio",no2_wrfcmaq,nx,ny,nz)
!            print *, 'NO2 WRFCMAQ MN ',NO2_wrfcmaq(:,:,1);
!
! Read TCR2 data (vertical grid is bottom to top)
            tcr2_file=trim(tcr2_chem_file)
!            print *, 'TCR2 FILE ',trim(tcr2_file)
            allocate(no2_tcr2(nx,ny,nz))
            allocate(fld_tcr2(nx_tcr2,ny_tcr2,nz_tcr2))
            allocate(tcr2_vec(nx_tcr2,ny_tcr2,nz_tcr2,nt_tcr2))
            call get_WRFCHEM_fld_real(trim(tcr2_file),"NO2_VMR_inst", &
            tcr2_vec,nx_tcr2,ny_tcr2,nz_tcr2,nt_tcr2)
!            print *, 'TCR2 VEC ',tcr2_vec(:,:,1,1)
            fld_tcr2(:,:,:)=(bk_wt_tcr2*tcr2_vec(:,:,:,ll_tcr2) + fw_wt_tcr2* &
            tcr2_vec(:,:,:,ll_tcr2+1))/(bk_wt_tcr2+fw_wt_tcr2)
!
! Convert units from to ppm
            fld_tcr2(:,:,:)=fld_tcr2(:,:,:)*1.e6
            call zinvert(fld_tcr2,nx_tcr2,ny_tcr2,nz_tcr2,1)
            deallocate(tcr2_vec)
!            print *,'TCR2 fld NO2 ',fld_tcr2(:,:,1)
!
! TCR2 spatial interpolation
            call spatial_interpolate_1dp(no2_tcr2,fld_tcr2,p_tcr2,p_ens_mn, &
            tcr2_ll_ii,tcr2_ll_jj,tcr2_lr_ii,tcr2_lr_jj,tcr2_ul_ii,tcr2_ul_jj, &
            tcr2_ur_ii,tcr2_ur_jj,lon,lat,lon_tcr2,lat_tcr2, &
            nx_tcr2,ny_tcr2,nz_tcr2,nx,ny,nz)
!            print *,'TCR2 NO2 ',no2_tcr2(:,:,1)
            deallocate(fld_tcr2)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"TCR2_NO2", &
            "mixing ratio (kg/kg)",no2_tcr2,nx,ny,nz)
!  
! Read CAMCHEM data (vertical grid is top to bottom)
!            print *, 'CAMCHEM FILE ',trim(camchem_file)
            allocate(no2_camchem(nx,ny,nz))
            allocate(fld_camchem(nx_camchem,ny_camchem,nz_camchem))
            allocate(camchem_vec(nx_camchem,ny_camchem,nz_camchem,nt_camchem))
!
            call get_WRFCHEM_fld_real(trim(camchem_file),"NO2",camchem_vec,nx_camchem, &
            ny_camchem,nz_camchem,nt_camchem)
!            print *, 'CAMCHEM NO2 VEC ',camchem_vec(:,:,1,1)     
            fld_camchem(:,:,:)=(bk_wt_camchem*camchem_vec(:,:,:,ll_camchem) + fw_wt_camchem* &
            camchem_vec(:,:,:,ll_camchem+1))/(bk_wt_camchem+fw_wt_camchem)
!
! Convert units from mol/mol to ppm
            fld_camchem(:,:,:)=fld_camchem(:,:,:)*1.e6*molcwt_no2/molcwt_dry_air
!            
            call zinvert(fld_camchem,nx_camchem,ny_camchem,nz_camchem,1)
            deallocate(camchem_vec)
!            print *, 'APM: NO2 CAMCHEM ',fld_camchem(:,:,1)
!
! CAMCHEM spatial interpolation
            call spatial_interpolate_3dp(no2_camchem,fld_camchem,p_camchem,p_ens_mn, &
            camchem_ll_ii,camchem_ll_jj,camchem_lr_ii,camchem_lr_jj,camchem_ul_ii, &
            camchem_ul_jj,camchem_ur_ii,camchem_ur_jj,lon,lat,lon_camchem,lat_camchem, &
            nx_camchem,ny_camchem,nz_camchem,nx,ny,nz)
!            print *,'CAMCHEM NO2 ',no2_camchem(:,:,1)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"CAMCHEM_NO2", &
            "mixing ratio (kg/kg)",no2_camchem,nx,ny,nz)
            deallocate(fld_camchem)
!
            allocate(no2_conus_mn(nz),no2_conus_sd(nz))
            allocate(no2_urban_mn(nz),no2_urban_sd(nz))
            allocate(no2_rural_mn(nz),no2_rural_sd(nz))
            allocate(no2_cities_mn(num_cities,nz),no2_cities_sd(num_cities,nz))
!
! TRACER I CONUS Spatial statistics NO2
            call spatial_mean_and_variance(no2_ens_mn,no2_ens_sd, &
            no2_conus_mn,no2_conus_sd,wrfchem_conus_ii,wrfchem_conus_jj, &
            1,nx*ny,num_wrfchem_conus,nx,ny,nz)
!            print *, 'no2_conus_mn TRACER1 ',no2_conus_mn(:)
!            print *, 'no2_conus_sd TRACER1 ',no2_conus_sd(:)
             wrfchem_file=trim(path_output)//"/"//trim(file_output)
             call put_NETCDF_fld(trim(wrfchem_file),"TRACER_I_NO2_CONUS_MN", &
             "mixing ratio (kg/kg)",no2_conus_mn,nz,1,1)
             call put_NETCDF_fld(trim(wrfchem_file),"TRACER_I_NO2_CONUS_SD", &
             "mixing ratio (kg/kg)",no2_conus_sd,nz,1,1)
!
! TRACER I URBAN Spatial statistics NO2
            call spatial_mean_and_variance(no2_ens_mn,no2_ens_sd, &
            no2_urban_mn,no2_urban_sd,wrfchem_urban_ii,wrfchem_urban_jj, &
            num_cities,npts_urban,wrfchem_urban_npts,nx,ny,nz)
!            print *, 'no2_urban_mn TRACER1 ',no2_urban_mn(:)
!            print *, 'no2_urban_sd TRACER1 ',no2_urban_sd(:)
             wrfchem_file=trim(path_output)//"/"//trim(file_output)
             call put_NETCDF_fld(trim(wrfchem_file),"TRACER_I_NO2_URBAN_MN", &
             "mixing ratio (kg/kg)",no2_urban_mn,nz,1,1)
             call put_NETCDF_fld(trim(wrfchem_file),"TRACER_I_NO2_URBAN_SD", &
             "mixing ratio (kg/kg)",no2_urban_sd,nz,1,1)
!
! TRACER I RURAL Spatial statistics NO2
            call spatial_mean_and_variance(no2_ens_mn,no2_ens_sd, &
            no2_rural_mn,no2_rural_sd,wrfchem_rural_ii,wrfchem_rural_jj, &
            1,nx*ny,num_wrfchem_rural,nx,ny,nz)
!            print *, 'no2_rural_mn TRACER1 ',no2_rural_mn(:)
!            print *, 'no2_rural_sd TRACER1 ',no2_rural_sd(:)
             wrfchem_file=trim(path_output)//"/"//trim(file_output)
             call put_NETCDF_fld(trim(wrfchem_file),"TRACER_I_NO2_RURAL_MN", &
             "mixing ratio (kg/kg)",no2_rural_mn,nz,1,1)
             call put_NETCDF_fld(trim(wrfchem_file),"TRACER_I_NO2_RURAL_SD", &
             "mixing ratio (kg/kg)",no2_rural_sd,nz,1,1)
!
! WRFCMAQ CONUS Spatial statistics NO2
            call spatial_mean_and_variance(no2_wrfcmaq,no2_wrfcmaq, &
            no2_conus_mn,no2_conus_sd,wrfcmaq_conus_ii,wrfcmaq_conus_jj, &
            1,nx*ny,num_wrfcmaq_conus,nx,ny,nz)
!            print *, 'no2_conus_mn WRFCMAQ ',no2_conus_mn(:)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"WRFCMAQ_NO2_CONUS_MN", &
             "mixing ratio (kg/kg)",no2_conus_mn,nz,1,1)
!
! WRFCMAQ URBAN Spatial statistics NO2
            call spatial_mean_and_variance(no2_wrfcmaq,no2_wrfcmaq, &
            no2_urban_mn,no2_urban_sd,wrfcmaq_urban_ii,wrfcmaq_urban_jj, &
            num_cities,npts_urban,num_wrfcmaq_urban,nx,ny,nz)
!            print *, 'no2_urban_mn WRFCMAQ ',no2_urban_mn(:)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"WRFCMAQ_NO2_URBAN_MN", &
            "mixing ratio (kg/kg)",no2_urban_mn,nz,1,1)
!
! WRFCMAQ RURAL Spatial statistics NO2
            call spatial_mean_and_variance(no2_wrfcmaq,no2_wrfcmaq, &
            no2_rural_mn,no2_rural_sd,wrfcmaq_rural_ii,wrfcmaq_rural_jj, &
            1,nx*ny,num_wrfcmaq_rural,nx,ny,nz)
!            print *, 'no2_rural_mn WRFCMAQ ',no2_rural_mn(:)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"WRFCMAQ_NO2_RURAL_MN", &
            "mixing ratio (kg/kg)",no2_rural_mn,nz,1,1)
!
! TCR2 CONUS Spatial statistics NO2
            call spatial_mean_and_variance(no2_tcr2,no2_tcr2, &
            no2_conus_mn,no2_conus_sd,wrfchem_conus_ii,wrfchem_conus_jj, &
            1,nx*ny,num_wrfchem_conus,nx,ny,nz)
!            print *, 'no2_conus_mn TCR2 ',no2_conus_mn(:)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"TCR2_NO2_CONUS_MN", &
            "mixing ratio (kg/kg)",no2_conus_mn,nz,1,1)

! TCR2 URBAN Spatial statistics NO2
            call spatial_mean_and_variance(no2_tcr2,no2_tcr2, &
            no2_urban_mn,no2_urban_sd,wrfchem_urban_ii,wrfchem_urban_jj, &
            num_cities,npts_urban,wrfchem_urban_npts,nx,ny,nz)
!            print *, 'no2_urban_mn TCR2 ',no2_urban_mn(:)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"TCR2_NO2_URBAN_MN", &
            "mixing ratio (kg/kg)",no2_urban_mn,nz,1,1)
!
! TCR2 RURAL Spatial statistics NO2
            call spatial_mean_and_variance(no2_tcr2,no2_tcr2, &
            no2_rural_mn,no2_rural_sd,wrfchem_rural_ii,wrfchem_rural_jj, &
            1,nx*ny,num_wrfchem_rural,nx,ny,nz)
!            print *, 'no2_rural_mn TCR2 ',no2_rural_mn(:)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"TCR2_NO2_RURAL_MN", &
            "mixing ratio (kg/kg)",no2_rural_mn,nz,1,1)
!
! CAMCHEM CONUS Spatial statistics NO2
            call spatial_mean_and_variance(no2_camchem,no2_camchem, &
            no2_conus_mn,no2_conus_sd,wrfchem_conus_ii,wrfchem_conus_jj, &
            1,nx*ny,num_wrfchem_conus,nx,ny,nz)
!            print *, 'no2_conus_mn CAMCHEM ',no2_conus_mn(:)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"CAMCHEM_NO2_CONUS_MN", &
            "mixing ratio (kg/kg)",no2_conus_mn,nz,1,1)

! CAMCHEM URBAN Spatial statistics NO2
            call spatial_mean_and_variance(no2_camchem,no2_camchem, &
            no2_urban_mn,no2_urban_sd,wrfchem_urban_ii,wrfchem_urban_jj, &
            num_cities,npts_urban,wrfchem_urban_npts,nx,ny,nz)
!            print *, 'no2_urban_mn CAMCHEM ',no2_urban_mn(:)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"CAMCHEM_NO2_URBAN_MN", &
            "mixing ratio (kg/kg)",no2_urban_mn,nz,1,1)
!
! CAMCHEM RURAL Spatial statistics NO2
            call spatial_mean_and_variance(no2_camchem,no2_camchem, &
            no2_rural_mn,no2_rural_sd,wrfchem_rural_ii,wrfchem_rural_jj, &
            1,nx*ny,num_wrfchem_rural,nx,ny,nz)
!            print *, 'no2_rural_mn CAMCHEM ',no2_rural_mn(:)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"CAMCHEM_NO2_RURAL_MN", &
            "mixing ratio (kg/kg)",no2_rural_mn,nz,1,1)
!
            deallocate(no2_ens_mn)           
            deallocate(no2_ens_sd)           
!            deallocate(no2_wrfcmaq)           
            deallocate(no2_tcr2)           
            deallocate(no2_camchem)           
            deallocate(no2_conus_mn)
            deallocate(no2_conus_sd)
            deallocate(no2_urban_mn)
            deallocate(no2_urban_sd)
            deallocate(no2_rural_mn)
            deallocate(no2_rural_sd)
            deallocate(no2_cities_mn)
            deallocate(no2_cities_sd)
            print *, '   APM: After process NO2'
!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!
! SO2
!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!
         elseif(trim(chem_flds(ifld)).eq."so2") then
            print *, '   APM: Before process SO2'
            allocate(so2_fld(nx,ny,nz,num_mems))
            do imem=1,num_mems
               if(imem.ge.0.and.imem.lt.10) write(cmem,"('/run_e00',i1)"),imem
               if(imem.ge.10.and.imem.lt.100) write(cmem,"('/run_e0',i2)"),imem
               if(imem.ge.100.and.imem.lt.1000) write(cmem,"('/run_e',i3)"),imem
               wrfchem_file=trim(path_input)//trim(cmem)//"/"//trim(wrfout_input)
               call get_WRFCHEM_fld_real(trim(wrfchem_file),"so2",so2_fld(1,1,1,imem),nx,ny,nz,1)
            enddo
            allocate(so2_ens_mn(nx,ny,nz))
            allocate(so2_ens_sd(nx,ny,nz))
! Ensemble stats SO2
            call ens_stats(so2_fld,so2_ens_mn,so2_ens_sd,nx,ny,nz,num_mems)
            deallocate(so2_fld)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"TRACER_I_SO2_MN","mixing ratio (kg/kg)",so2_ens_mn,nx,ny,nz)
            call put_NETCDF_fld(trim(wrfchem_file),"TRACER_I_SO2_SD","mixing ratio (kg/kg)",so2_ens_sd,nx,ny,nz)
!
! WRFCMAQ
            allocate(wrfcmaq_vec(nx_wrfcmaq,ny_wrfcmaq,nz_wrfcmaq_chem,nt_wrfcmaq_chem))
            allocate(fld_wrfcmaq(nx_wrfcmaq,ny_wrfcmaq,nz_wrfcmaq_chem))
!            print *, 'FILE ',trim(wrfcmaq_metdot3d)
            call get_WRFCHEM_fld_real(trim(wrfcmaq_chemcro2d),"SO2",wrfcmaq_vec,nx_wrfcmaq, &
            ny_wrfcmaq,nz_wrfcmaq_chem,nt_wrfcmaq_chem)
!            print *, 'SO2 VEC ',wrfcmaq_vec(:,:,nz_wrfcmaq_chem,49)
!
! WRFCMAQ chemistry has one month of data per file and only one vertical level
! find time index
            ll_wrfcmaq=(dd_wrfchem-1)*24+hh_wrfchem+1
            fld_wrfcmaq(:,:,:)=wrfcmaq_vec(:,:,:,ll_wrfcmaq)
            deallocate(wrfcmaq_vec)
            allocate(so2_wrfcmaq(nx,ny,nz))
            call wrfcmaq_interpolate_2dh(so2_wrfcmaq,fld_wrfcmaq,wrfcmaq_i,wrfcmaq_j, &
            wrfcmaq_ii,wrfcmaq_jj,num_wrfcmaq,nx_wrfcmaq,ny_wrfcmaq,nz_wrfcmaq_chem,nx,ny,nz)
            deallocate(fld_wrfcmaq)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"WRFCMAQ_SO2","kg/kg mixing ratio",so2_wrfcmaq,nx,ny,nz)
!            print *, 'SO2 WRFCMAQ MN ',so2_wrfcmaq(:,:,1);
!
! Read TCR2 data (vertical grid is bottom to top)
            tcr2_file=trim(tcr2_chem_file)
!            print *, 'TCR2 FILE ',trim(tcr2_file)
            allocate(so2_tcr2(nx,ny,nz))
            allocate(fld_tcr2(nx_tcr2,ny_tcr2,nz_tcr2))
            allocate(tcr2_vec(nx_tcr2,ny_tcr2,nz_tcr2,nt_tcr2))
            call get_WRFCHEM_fld_real(trim(tcr2_file),"SO2_VMR_inst",tcr2_vec,nx_tcr2,ny_tcr2,nz_tcr2,nt_tcr2)
!            print *, 'TCR2 VEC ',tcr2_vec(:,:,1,1)
            fld_tcr2(:,:,:)=(bk_wt_tcr2*tcr2_vec(:,:,:,ll_tcr2) + fw_wt_tcr2* &
            tcr2_vec(:,:,:,ll_tcr2+1))/(bk_wt_tcr2+fw_wt_tcr2)
!
! Convert units from to ppm
            fld_tcr2(:,:,:)=fld_tcr2(:,:,:)*1.e6
!
            call zinvert(fld_tcr2,nx_tcr2,ny_tcr2,nz_tcr2,1)
            deallocate(tcr2_vec)
!            print *,'TCR2 fld SO2 ',fld_tcr2(:,:,1)
!
! TCR2 spatial interpolation
            call spatial_interpolate_1dp(so2_tcr2,fld_tcr2,p_tcr2,p_ens_mn, &
            tcr2_ll_ii,tcr2_ll_jj,tcr2_lr_ii,tcr2_lr_jj,tcr2_ul_ii,tcr2_ul_jj, &
            tcr2_ur_ii,tcr2_ur_jj,lon,lat,lon_tcr2,lat_tcr2, &
            nx_tcr2,ny_tcr2,nz_tcr2,nx,ny,nz)
!            print *,'TCR2 SO2 ',so2_tcr2(:,:,1)
            deallocate(fld_tcr2)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"TCR2_SO2","mixing ratio (kg/kg)",so2_tcr2,nx,ny,nz)
!  
! Read CAMCHEM data (vertical grid is top to bottom)
!            print *, 'CAMCHEM FILE ',trim(camchem_file)
            allocate(so2_camchem(nx,ny,nz))
            allocate(fld_camchem(nx_camchem,ny_camchem,nz_camchem))
            allocate(camchem_vec(nx_camchem,ny_camchem,nz_camchem,nt_camchem))
!
            call get_WRFCHEM_fld_real(trim(camchem_file),"SO2",camchem_vec,nx_camchem, &
            ny_camchem,nz_camchem,nt_camchem)
!            print *, 'CAMCHEM SO2 VEC ',camchem_vec(:,:,1,1)     
            fld_camchem(:,:,:)=(bk_wt_camchem*camchem_vec(:,:,:,ll_camchem) + fw_wt_camchem* &
            camchem_vec(:,:,:,ll_camchem+1))/(bk_wt_camchem+fw_wt_camchem)
!
! Convert units from mol/mol to ppm
            fld_camchem(:,:,:)=fld_camchem(:,:,:)*1.e6*molcwt_so2/molcwt_dry_air
!            
            call zinvert(fld_camchem,nx_camchem,ny_camchem,nz_camchem,1)
            deallocate(camchem_vec)
!            print *, 'APM: SO2 CAMCHEM ',fld_camchem(:,:,1)
!
! CAMCHEM spatial interpolation
            call spatial_interpolate_3dp(so2_camchem,fld_camchem,p_camchem,p_ens_mn, &
            camchem_ll_ii,camchem_ll_jj,camchem_lr_ii,camchem_lr_jj,camchem_ul_ii, &
            camchem_ul_jj,camchem_ur_ii,camchem_ur_jj,lon,lat,lon_camchem,lat_camchem, &
            nx_camchem,ny_camchem,nz_camchem,nx,ny,nz)
!            print *,'CAMCHEM SO2 ',so2_camchem(:,:,1)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"CAMCHEM_SO2","mixing ratio (kg/kg)",so2_camchem,nx,ny,nz)
            deallocate(fld_camchem)
!
            allocate(so2_conus_mn(nz),so2_conus_sd(nz))
            allocate(so2_urban_mn(nz),so2_urban_sd(nz))
            allocate(so2_rural_mn(nz),so2_rural_sd(nz))
            allocate(so2_cities_mn(num_cities,nz),so2_cities_sd(num_cities,nz))
!
! TRACER I CONUS Spatial statistics SO2
            call spatial_mean_and_variance(so2_ens_mn,so2_ens_sd, &
            so2_conus_mn,so2_conus_sd,wrfchem_conus_ii,wrfchem_conus_jj, &
            1,nx*ny,num_wrfchem_conus,nx,ny,nz)
!            print *, 'so2_conus_mn ',so2_conus_mn(:)
!            print *, 'so2_conus_sd ',so2_conus_sd(:)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"TRACER_I_SO2_CONUS_MN", &
            "mixing ratio (kg/kg)",so2_conus_mn,nz,1,1)
            call put_NETCDF_fld(trim(wrfchem_file),"TRACER_I_SO2_CONUS_SD", &
            "mixing ratio (kg/kg)",so2_conus_sd,nz,1,1)
!
! TRACER I URBAN Spatial statistics SO2
            call spatial_mean_and_variance(so2_ens_mn,so2_ens_sd, &
            so2_urban_mn,so2_urban_sd,wrfchem_urban_ii,wrfchem_urban_jj, &
            num_cities,npts_urban,wrfchem_urban_npts,nx,ny,nz)
!            print *, 'so2_urban_mn ',so2_urban_mn(:)
!            print *, 'so2_urban_sd ',so2_urban_sd(:)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"TRACER_I_SO2_URBAN_MN", &
            "mixing ratio (kg/kg)",so2_urban_mn,nz,1,1)
            call put_NETCDF_fld(trim(wrfchem_file),"TRACER_I_SO2_URBAN_SD", &
            "mixing ratio (kg/kg)",so2_urban_sd,nz,1,1)
!
! TRACER I RURAL Spatial statistics SO2
            call spatial_mean_and_variance(so2_ens_mn,so2_ens_sd, &
            so2_rural_mn,so2_rural_sd,wrfchem_rural_ii,wrfchem_rural_jj, &
            1,nx*ny,num_wrfchem_rural,nx,ny,nz)
!            print *, 'so2_rural_mn ',so2_rural_mn(:)
!            print *, 'so2_rural_sd ',so2_rural_sd(:)
             wrfchem_file=trim(path_output)//"/"//trim(file_output)
             call put_NETCDF_fld(trim(wrfchem_file),"TRACER_I_SO2_RURAL_MN", &
             "mixing ratio (kg/kg)",so2_rural_mn,nz,1,1)
             call put_NETCDF_fld(trim(wrfchem_file),"TRACER_I_SO2_RURAL_SD", &
             "mixing ratio (kg/kg)",so2_rural_sd,nz,1,1)
!
! WRFCMAQ CONUS Spatial statistics SO2
            call spatial_mean_and_variance(so2_wrfcmaq,so2_wrfcmaq, &
            so2_conus_mn,so2_conus_sd,wrfcmaq_conus_ii,wrfcmaq_conus_jj, &
            1,nx*ny,num_wrfcmaq_conus,nx,ny,nz)
!            print *, 'so2_conus_mn ',so2_conus_mn(:)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"WRFCMAQ_SO2_CONUS_MN", &
             "mixing ratio (kg/kg)",so2_conus_mn,nz,1,1)
!
! WRFCMAQ URBAN Spatial statistics SO2
            call spatial_mean_and_variance(so2_wrfcmaq,so2_wrfcmaq, &
            so2_urban_mn,so2_urban_sd,wrfcmaq_urban_ii,wrfcmaq_urban_jj, &
            num_cities,npts_urban,num_wrfcmaq_urban,nx,ny,nz)
!            print *, 'so2_urban_mn ',so2_urban_mn(:)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"WRFCMAQ_SO2_URBAN_MN", &
             "mixing ratio (kg/kg)",so2_urban_mn,nz,1,1)
!
! WRFCMAQ RURAL Spatial statistics SO2
            call spatial_mean_and_variance(so2_wrfcmaq,so2_wrfcmaq, &
            so2_rural_mn,so2_rural_sd,wrfcmaq_rural_ii,wrfcmaq_rural_jj, &
            1,nx*ny,num_wrfcmaq_rural,nx,ny,nz)
!            print *, 'so2_rural_mn ',so2_rural_mn(:)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"WRFCMAQ_SO2_RURAL_MN", &
             "mixing ratio (kg/kg)",so2_rural_mn,nz,1,1)
!
! TCR2 CONUS Spatial statistics SO2
            call spatial_mean_and_variance(so2_tcr2,so2_tcr2, &
            so2_conus_mn,so2_conus_sd,wrfchem_conus_ii,wrfchem_conus_jj, &
            1,nx*ny,num_wrfchem_conus,nx,ny,nz)
!            print *, 'so2_conus_mn ',so2_conus_mn(:)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"TCR2_SO2_CONUS_MN", &
            "mixing ratio (kg/kg)",so2_conus_mn,nz,1,1)

! TCR2 URBAN Spatial statistics SO2
            call spatial_mean_and_variance(so2_tcr2,so2_tcr2, &
            so2_urban_mn,so2_urban_sd,wrfchem_urban_ii,wrfchem_urban_jj, &
            num_cities,npts_urban,wrfchem_urban_npts,nx,ny,nz)
!            print *, 'so2_urban_mn ',so2_urban_mn(:)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"TCR2_SO2_URBAN_MN", &
            "mixing ratio (kg/kg)",so2_urban_mn,nz,1,1)
!
! TCR2 RURAL Spatial statistics SO2
            call spatial_mean_and_variance(so2_tcr2,so2_tcr2, &
            so2_rural_mn,so2_rural_sd,wrfchem_rural_ii,wrfchem_rural_jj, &
            1,nx*ny,num_wrfchem_rural,nx,ny,nz)
!            print *, 'so2_rural_mn ',so2_rural_mn(:)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"TCR2_SO2_RURAL_MN", &
            "mixing ratio (kg/kg)",so2_rural_mn,nz,1,1)
!
! CAMCHEM CONUS Spatial statistics SO2
            call spatial_mean_and_variance(so2_camchem,so2_camchem, &
            so2_conus_mn,so2_conus_sd,wrfchem_conus_ii,wrfchem_conus_jj, &
            1,nx*ny,num_wrfchem_conus,nx,ny,nz)
!            print *, 'so2_conus_mn ',so2_conus_mn(:)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"CAMCHEM_SO2_CONUS_MN", &
            "mixing ratio (kg/kg)",so2_conus_mn,nz,1,1)

! CAMCHEM URBAN Spatial statistics SO2
            call spatial_mean_and_variance(so2_camchem,so2_camchem, &
            so2_urban_mn,so2_urban_sd,wrfchem_urban_ii,wrfchem_urban_jj, &
            num_cities,npts_urban,wrfchem_urban_npts,nx,ny,nz)
!            print *, 'so2_urban_mn ',so2_urban_mn(:)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"CAMCHEM_SO2_URBAN_MN", &
            "mixing ratio (kg/kg)",so2_urban_mn,nz,1,1)
!
! CAMCHEM RURAL Spatial statistics SO2
            call spatial_mean_and_variance(so2_camchem,so2_camchem, &
            so2_rural_mn,so2_rural_sd,wrfchem_rural_ii,wrfchem_rural_jj, &
            1,nx*ny,num_wrfchem_rural,nx,ny,nz)
!            print *, 'so2_rural_mn ',so2_rural_mn(:)
            wrfchem_file=trim(path_output)//"/"//trim(file_output)
            call put_NETCDF_fld(trim(wrfchem_file),"CAMCHEM_SO2_RURAL_MN", &
            "mixing ratio (kg/kg)",so2_rural_mn,nz,1,1)
!
            deallocate(so2_ens_mn)           
            deallocate(so2_ens_sd)           
!            deallocate(so2_wrfcmaq)           
            deallocate(so2_tcr2)           
            deallocate(so2_camchem)           
            deallocate(so2_conus_mn)
            deallocate(so2_conus_sd)
            deallocate(so2_urban_mn)
            deallocate(so2_urban_sd)
            deallocate(so2_rural_mn)
            deallocate(so2_rural_sd)
            deallocate(so2_cities_mn)
            deallocate(so2_cities_sd)
            print *, '   APM: After process SO2'
         endif
      enddo
      deallocate(lon)
      deallocate(lat)
      wrfchem_file=trim(path_output)//"/"//trim(file_output)
      print *, 'APM: Close file ',trim(wrfchem_file)



!!!!
!!!! Chemi Emis fields      
!!!      do ifld=1,num_chemi_flds
!!!! E_CO
!!!         if(trim(chemi_flds(ifld)).eq."E_CO") then
!!!            print *, '   APM: Before process E_CO'
!!!            allocate(e_co_fld(nx,ny,nz_chemi,num_mems))
!!!            do imem=1,num_mems
!!!               if(imem.ge.0.and.imem.lt.10) write(cmem,"('/run_e00',i1)"),imem
!!!               if(imem.ge.10.and.imem.lt.100) write(cmem,"('/run_e0',i2)"),imem
!!!               if(imem.ge.100.and.imem.lt.1000) write(cmem,"('/run_e',i3)"),imem
!!!               wrfchem_file=trim(path_input)//trim(cmem)//"/"//trim(wrfchemi_input)
!!!               call get_WRFCHEM_fld(trim(wrfchem_file),"E_CO",e_co_fld(1,1,1,imem),nx,ny,nz_chemi)
!!!            enddo
!!!! Ensemble stats E_CO
!!!            allocate(e_co_ens_mn(nx,ny,nz_chemi))
!!!            allocate(e_co_ens_sd(nx,ny,nz_chemi))
!!!            call ens_stats(e_co_fld,e_co_ens_mn,e_co_ens_sd,nx,ny,nz_chemi,num_mems)
!!!            deallocate(e_co_fld)
!!!! Spatial stats E_CO
!!!            urban_flg=0
!!!            call spatial_stats(urban_flg,e_co_conus_mn,e_co_conus_sd,e_co_urban_mn,e_co_urban_sd,e_co_rural_mn, &
!!!            e_co_rural_sd,e_co_cities_mn,e_co_cities_sd,e_co_ens_mn,e_co_ens_sd,lon,lat,nx,ny,nz,num_cities)       
!!!            wrfchem_file=trim(path_output)//"/"//trim(file_output)
!!!            call put_NETCDF_fld(trim(wrfchem_file),"E_CO_MN","flux (mol km-2 hr-1)",e_co_ens_mn,nx,ny,nz_chemi)
!!!            call put_NETCDF_fld(trim(wrfchem_file),"E_CO_SD","flux (mol klm-2 hr-1)",e_co_ens_sd,nx,ny,nz_chemi)
!!!            deallocate(e_co_ens_mn)
!!!            deallocate(e_co_ens_sd)
!!!            print *, '   APM: After process E_CO'
!!!! E_NO2
!!!         elseif(trim(chemi_flds(ifld)).eq."E_NO2") then
!!!            print *, '   APM: Before process E_NO2'
!!!            allocate(e_no2_fld(nx,ny,nz_chemi,num_mems))
!!!            do imem=1,num_mems
!!!               if(imem.ge.0.and.imem.lt.10) write(cmem,"('/run_e00',i1)"),imem
!!!               if(imem.ge.10.and.imem.lt.100) write(cmem,"('/run_e0',i2)"),imem
!!!               if(imem.ge.100.and.imem.lt.1000) write(cmem,"('/run_e',i3)"),imem
!!!               wrfchem_file=trim(path_input)//trim(cmem)//"/"//trim(wrfchemi_input)
!!!               call get_WRFCHEM_fld(trim(wrfchem_file),"E_NO2",e_no2_fld(1,1,1,imem),nx,ny,nz_chemi)
!!!            enddo
!!!            allocate(e_no2_ens_mn(nx,ny,nz_chemi))
!!!            allocate(e_no2_ens_sd(nx,ny,nz_chemi))
!!!! Spatial stats E_NO2
!!!            call ens_stats(e_no2_fld,e_no2_ens_mn,e_no2_ens_sd,nx,ny,nz_chemi,num_mems)
!!!            deallocate(e_no2_fld)
!!!! Spatial stats E_NO2
!!!            urban_flg=0
!!!            call spatial_stats(urban_flg,e_no2_conus_mn,e_no2_conus_sd,e_no2_urban_mn,e_no2_urban_sd,e_no2_rural_mn, &
!!!            e_no2_rural_sd,e_no2_cities_mn,e_no2_cities_sd,e_no2_ens_mn,e_no2_ens_sd,lon,lat,nx,ny,nz,num_cities)       
!!!            wrfchem_file=trim(path_output)//"/"//trim(file_output)
!!!            call put_NETCDF_fld(trim(wrfchem_file),"E_NO2_MN","flux (mol km-2 hr-1)",e_no2_ens_mn,nx,ny,nz_chemi)
!!!            call put_NETCDF_fld(trim(wrfchem_file),"E_NO2_SD","flux (mol km-2 hr-1)",e_no2_ens_sd,nx,ny,nz_chemi)
!!!            deallocate(e_no2_ens_mn)
!!!            deallocate(e_no2_ens_sd)
!!!            print *, '   APM: After process E_NO2'
!!!! E_SO2
!!!         elseif(trim(chemi_flds(ifld)).eq."E_SO2") then
!!!            print *, '   APM: Before process E_SO2'
!!!            allocate(e_so2_fld(nx,ny,nz_chemi,num_mems))
!!!            do imem=1,num_mems
!!!               if(imem.ge.0.and.imem.lt.10) write(cmem,"('/run_e00',i1)"),imem
!!!               if(imem.ge.10.and.imem.lt.100) write(cmem,"('/run_e0',i2)"),imem
!!!               if(imem.ge.100.and.imem.lt.1000) write(cmem,"('/run_e',i3)"),imem
!!!               wrfchem_file=trim(path_input)//trim(cmem)//"/"//trim(wrfchemi_input)
!!!               call get_WRFCHEM_fld(trim(wrfchem_file),"E_SO2",e_so2_fld(1,1,1,imem),nx,ny,nz_chemi)
!!!            enddo
!!!            allocate(e_so2_ens_mn(nx,ny,nz_chemi))
!!!            allocate(e_so2_ens_sd(nx,ny,nz_chemi))
!!!! Spatial stats E_SO2
!!!            call ens_stats(e_so2_fld,e_so2_ens_mn,e_so2_ens_sd,nx,ny,nz_chemi,num_mems)
!!!            deallocate(e_so2_fld)
!!!! Spatial stats E_SO2
!!!            urban_flg=0
!!!            call spatial_stats(urban_flg,e_so2_conus_mn,e_so2_conus_sd,e_so2_urban_mn,e_so2_urban_sd,e_so2_rural_mn, &
!!!            e_so2_rural_sd,e_so2_cities_mn,e_so2_cities_sd,e_so2_ens_mn,e_so2_ens_sd,lon,lat,nx,ny,nz,num_cities)       
!!!            wrfchem_file=trim(path_output)//"/"//trim(file_output)
!!!            call put_NETCDF_fld(trim(wrfchem_file),"E_SO2_MN","flux (mol km-2 hr-1)",e_so2_ens_mn,nx,ny,nz_chemi)
!!!            call put_NETCDF_fld(trim(wrfchem_file),"E_SO2_SD","flux (mol km-2 hr-1)",e_so2_ens_sd,nx,ny,nz_chemi)
!!!            deallocate(e_so2_ens_mn)
!!!            deallocate(e_so2_ens_sd)
!!!            print *, '   APM: After process E_SO2'
!!!         endif
!!!      enddo
!!!!
!!!! Firechemi Emis fields      
!!!      do ifld=1,num_fire_flds
!!!! EBU_CO
!!!         if(trim(firechemi_flds(ifld)).eq."EBU_CO") then
!!!            print *, '   APM: Before process EBU_CO'
!!!            allocate(ebu_co_fld(nx,ny,nz_fire,num_mems))
!!!            do imem=1,num_mems
!!!               if(imem.ge.0.and.imem.lt.10) write(cmem,"('/run_e00',i1)"),imem
!!!               if(imem.ge.10.and.imem.lt.100) write(cmem,"('/run_e0',i2)"),imem
!!!               if(imem.ge.100.and.imem.lt.1000) write(cmem,"('/run_e',i3)"),imem
!!!               wrfchem_file=trim(path_input)//trim(cmem)//"/"//trim(wrffirechemi_input)
!!!               call get_WRFCHEM_fld(trim(wrfchem_file),"EBU_CO",ebu_co_fld(1,1,1,imem),nx,ny,nz_fire)
!!!            enddo
!!!            allocate(ebu_co_ens_mn(nx,ny,nz_fire))
!!!            allocate(ebu_co_ens_sd(nx,ny,nz_fire))
!!!! Ensemble stats EBU_CO
!!!            call ens_stats(ebu_co_fld,ebu_co_ens_mn,ebu_co_ens_sd,nx,ny,nz_fire,num_mems)
!!!            deallocate(ebu_co_fld)
!!!! Spatial stats EBU_CO
!!!            urban_flg=0
!!!            call spatial_stats(urban_flg,ebu_co_conus_mn,ebu_co_conus_sd,ebu_co_urban_mn,ebu_co_urban_sd,ebu_co_rural_mn, &
!!!            ebu_co_rural_sd,ebu_co_cities_mn,ebu_co_cities_sd,ebu_co_ens_mn,ebu_co_ens_sd,lon,lat,nx,ny,nz,num_cities)       
!!!            wrfchem_file=trim(path_output)//"/"//trim(file_output)
!!!            call put_NETCDF_fld(trim(wrfchem_file),"EBU_CO_MN","flux (mol km-2 hr-1)",ebu_co_ens_mn,nx,ny,nz_fire)
!!!            call put_NETCDF_fld(trim(wrfchem_file),"EBU_CO_SD","flux (mol km-2 hr-1)",ebu_co_ens_sd,nx,ny,nz_fire)
!!!            deallocate(ebu_co_ens_mn)
!!!            deallocate(ebu_co_ens_sd)
!!!            print *, '   APM: After process EBU_CO'
!!!! EBU_NO2
!!!         elseif(trim(firechemi_flds(ifld)).eq."EBU_NO2") then
!!!            print *, '   APM: Before process E_NO2'
!!!            allocate(ebu_no2_fld(nx,ny,nz_fire,num_mems))
!!!            do imem=1,num_mems
!!!               if(imem.ge.0.and.imem.lt.10) write(cmem,"('/run_e00',i1)"),imem
!!!               if(imem.ge.10.and.imem.lt.100) write(cmem,"('/run_e0',i2)"),imem
!!!               if(imem.ge.100.and.imem.lt.1000) write(cmem,"('/run_e',i3)"),imem
!!!               wrfchem_file=trim(path_input)//trim(cmem)//"/"//trim(wrffirechemi_input)
!!!               call get_WRFCHEM_fld(trim(wrfchem_file),"EBU_NO2",ebu_no2_fld(1,1,1,imem),nx,ny,nz_fire)
!!!            enddo
!!!            allocate(ebu_no2_ens_mn(nx,ny,nz_fire))
!!!            allocate(ebu_no2_ens_sd(nx,ny,nz_fire))
!!!! Ensemble stats EBU_NO2
!!!            call ens_stats(ebu_no2_fld,ebu_no2_ens_mn,ebu_no2_ens_sd,nx,ny,nz_fire,num_mems)
!!!            deallocate(ebu_no2_fld)
!!!! Spatial stats EBU_NO2
!!!            urban_flg=0
!!!            call spatial_stats(urban_flg,ebu_no2_conus_mn,ebu_no2_conus_sd,ebu_no2_urban_mn,ebu_no2_urban_sd,ebu_no2_rural_mn, &
!!!            ebu_no2_rural_sd,ebu_no2_cities_mn,ebu_no2_cities_sd,ebu_no2_ens_mn,ebu_no2_ens_sd,lon,lat,nx,ny,nz,num_cities)
!!!            wrfchem_file=trim(path_output)//"/"//trim(file_output)
!!!            call put_NETCDF_fld(trim(wrfchem_file),"EBU_NO2_MN","flux (mol km-2 hr-1)",ebu_no2_ens_mn,nx,ny,nz_fire)
!!!            call put_NETCDF_fld(trim(wrfchem_file),"EBU_NO2_SD","flux (mol km-2 hr-1)",ebu_no2_ens_sd,nx,ny,nz_fire)
!!!            deallocate(ebu_no2_ens_mn)
!!!            deallocate(ebu_no2_ens_sd)
!!!            print *, '   APM: After process EBU_NO2'
!!!! EBU_SO2
!!!         elseif(trim(firechemi_flds(ifld)).eq."EBU_SO2") then
!!!            print *, '   APM: Before process EBU_SO2'
!!!            allocate(ebu_so2_fld(nx,ny,nz_fire,num_mems))
!!!            do imem=1,num_mems
!!!               if(imem.ge.0.and.imem.lt.10) write(cmem,"('/run_e00',i1)"),imem
!!!               if(imem.ge.10.and.imem.lt.100) write(cmem,"('/run_e0',i2)"),imem
!!!               if(imem.ge.100.and.imem.lt.1000) write(cmem,"('/run_e',i3)"),imem
!!!               wrfchem_file=trim(path_input)//trim(cmem)//"/"//trim(wrffirechemi_input)
!!!               call get_WRFCHEM_fld(trim(wrfchem_file),"EBU_SO2",ebu_so2_fld(1,1,1,imem),nx,ny,nz_fire)
!!!            enddo
!!!            allocate(ebu_so2_ens_mn(nx,ny,nz_fire))
!!!            allocate(ebu_so2_ens_sd(nx,ny,nz_fire))
!!!! Ensemble stats EBU_SO2
!!!            call ens_stats(ebu_so2_fld,ebu_so2_ens_mn,ebu_so2_ens_sd,nx,ny,nz_fire,num_mems)
!!!            deallocate(ebu_so2_fld)
!!!! Spatial stats EBU_SO2
!!!            urban_flg=0
!!!            call spatial_stats(urban_flg,ebu_so2_conus_mn,ebu_so2_conus_sd,ebu_so2_urban_mn,ebu_so2_urban_sd,ebu_so2_rural_mn, &
!!!            ebu_so2_rural_sd,ebu_so2_cities_mn,ebu_so2_cities_sd,ebu_so2_ens_mn,ebu_so2_ens_sd,lon,lat,nx,ny,nz,num_cities)
!!!            wrfchem_file=trim(path_output)//"/"//trim(file_output)
!!!            call put_NETCDF_fld(trim(wrfchem_file),"EBU_SO2_MN","flux (mol km-2 hr-1)",ebu_so2_ens_mn,nx,ny,nz_fire)
!!!            call put_NETCDF_fld(trim(wrfchem_file),"EBU_SO2_SD","flux (mol km-2 hr-1)",ebu_so2_ens_sd,nx,ny,nz_fire)
!!!            deallocate(e_so2_ens_mn)
!!!            deallocate(e_so2_ens_sd)
!!!            print *, '   APM: After process E_SO2'
!!!         endif
!!!      enddo
!!!!
   end program main

!-------------------------------------------------------------------------------
   
   subroutine get_WRFCHEM_fld_int(file,name,data4d,nx,ny,nz,nt)
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
      integer,dimension(nz,ny,nz,nt)                      :: data4d
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
      rc = nf_get_vara_int(f_id,v_id,one,v_dim,data4d)
      rc = nf_close(f_id)
      return
   end subroutine get_WRFCHEM_fld_int

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
   
   subroutine get_WRFCHEM_fld_double(file,name,data4d,nx,ny,nz,nt)
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
      double precision,dimension(nx,ny,nz,nt)             :: data4d
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
      rc = nf_get_vara_double(f_id,v_id,one,v_dim,data4d)
      rc = nf_close(f_id)
      return
   end subroutine get_WRFCHEM_fld_double

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

   subroutine create_NETCDF_file(wrfchem_file,nx,ny,nz,nz_chemi,nz_fire)
      use :: netcdf
      implicit none
!      
      integer                    :: rc,fid
      integer                    :: nx,ny,nz,nz_chemi,nz_fire
      integer                    :: x_dimid,y_dimid,z_dimid,zch_dimid,zfr_dimid,scl_dimid
      integer                    :: var_id,att_id
      character(len=*)           :: wrfchem_file
!      
      rc=nf90_create(trim(wrfchem_file),NF90_CLOBBER,fid)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at create file')
      rc=nf90_def_dim(fid,"west-east",nx,x_dimid)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at x_dimid')
      rc=nf90_def_dim(fid,"south-north",ny,y_dimid)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at y_dimid')
      rc=nf90_def_dim(fid,"bottom-top",nz,z_dimid)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at z_dimid')
      rc=nf90_def_dim(fid,"bottom-top_chemi",nz_chemi,zch_dimid)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at zch_dimid')
      rc=nf90_def_dim(fid,"bottom-top_fire",nz_fire,zfr_dimid)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at zfr_dimid')
      rc=nf90_def_dim(fid,"scalar",1,scl_dimid)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at scl_dimid')
!
! TRACER-I LON, LAT, and P      
      rc=nf90_def_var(fid,"TRACER_I_LON",NF90_FLOAT,(/x_dimid,y_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at LON')

      rc=nf90_def_var(fid,"TRACER_I_LAT",NF90_FLOAT,(/x_dimid,y_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at LAT')

      rc=nf90_def_var(fid,"TRACER_I_P",NF90_FLOAT,(/x_dimid,y_dimid,z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at P')
!
! TRACER-I Ensemble means and spread T, U, V, and Q
      rc=nf90_def_var(fid,"TRACER_I_T_MN",NF90_FLOAT,(/x_dimid,y_dimid,z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_T_MN')

      rc=nf90_def_var(fid,"TRACER_I_T_SD",NF90_FLOAT,(/x_dimid,y_dimid,z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_T_SD')
 
      rc=nf90_def_var(fid,"TRACER_I_U_MN",NF90_FLOAT,(/x_dimid,y_dimid,z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_U_MN')

      rc=nf90_def_var(fid,"TRACER_I_U_SD",NF90_FLOAT,(/x_dimid,y_dimid,z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_U_SD')
 
      rc=nf90_def_var(fid,"TRACER_I_V_MN",NF90_FLOAT,(/x_dimid,y_dimid,z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_V_MN')

      rc=nf90_def_var(fid,"TRACER_I_V_SD",NF90_FLOAT,(/x_dimid,y_dimid,z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_V_SD')
 
      rc=nf90_def_var(fid,"TRACER_I_Q_MN",NF90_FLOAT,(/x_dimid,y_dimid,z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_Q_MN')

      rc=nf90_def_var(fid,"TRACER_I_Q_SD",NF90_FLOAT,(/x_dimid,y_dimid,z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_Q_SD')

      rc=nf90_def_var(fid,"TRACER_I_CO_MN",NF90_FLOAT,(/x_dimid,y_dimid,z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_CO_MN')

      rc=nf90_def_var(fid,"TRACER_I_CO_SD",NF90_FLOAT,(/x_dimid,y_dimid,z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_CO_SD')

      rc=nf90_def_var(fid,"TRACER_I_O3_MN",NF90_FLOAT,(/x_dimid,y_dimid,z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_O3_MN')

      rc=nf90_def_var(fid,"TRACER_I_O3_SD",NF90_FLOAT,(/x_dimid,y_dimid,z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_O3_SD')

      rc=nf90_def_var(fid,"TRACER_I_NO2_MN",NF90_FLOAT,(/x_dimid,y_dimid,z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_NO2_MN')

      rc=nf90_def_var(fid,"TRACER_I_NO2_SD",NF90_FLOAT,(/x_dimid,y_dimid,z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_NO2_SD')

      rc=nf90_def_var(fid,"TRACER_I_SO2_MN",NF90_FLOAT,(/x_dimid,y_dimid,z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_SO2_MN')

      rc=nf90_def_var(fid,"TRACER_I_SO2_SD",NF90_FLOAT,(/x_dimid,y_dimid,z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_SO2_SD')

      rc=nf90_def_var(fid,"WRFCMAQ_T",NF90_FLOAT,(/x_dimid,y_dimid,z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at WRFCMAQ_T')

      rc=nf90_def_var(fid,"WRFCMAQ_U",NF90_FLOAT,(/x_dimid,y_dimid,z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at WRFCMAQ_U')

      rc=nf90_def_var(fid,"WRFCMAQ_V",NF90_FLOAT,(/x_dimid,y_dimid,z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at WRFCMAQ_V')

      rc=nf90_def_var(fid,"WRFCMAQ_Q",NF90_FLOAT,(/x_dimid,y_dimid,z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at WRFCMAQ_Q')

      rc=nf90_def_var(fid,"WRFCMAQ_CO",NF90_FLOAT,(/x_dimid,y_dimid,z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at WRFCMAQ_CO')

      rc=nf90_def_var(fid,"WRFCMAQ_O3",NF90_FLOAT,(/x_dimid,y_dimid,z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at WRFCMAQ_O3')

      rc=nf90_def_var(fid,"WRFCMAQ_NO2",NF90_FLOAT,(/x_dimid,y_dimid,z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at WRFCMAQ_NO2')

      rc=nf90_def_var(fid,"WRFCMAQ_SO2",NF90_FLOAT,(/x_dimid,y_dimid,z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at WRFCMAQ_SO2')

      rc=nf90_def_var(fid,"TCR2_T",NF90_FLOAT,(/x_dimid,y_dimid,z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TCR2_T')

      rc=nf90_def_var(fid,"TCR2_U",NF90_FLOAT,(/x_dimid,y_dimid,z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TCR2_U')

      rc=nf90_def_var(fid,"TCR2_V",NF90_FLOAT,(/x_dimid,y_dimid,z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TCR2_V')

      rc=nf90_def_var(fid,"TCR2_Q",NF90_FLOAT,(/x_dimid,y_dimid,z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TCR2_Q')

      rc=nf90_def_var(fid,"TCR2_CO",NF90_FLOAT,(/x_dimid,y_dimid,z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TCR2_Q')

      rc=nf90_def_var(fid,"TCR2_O3",NF90_FLOAT,(/x_dimid,y_dimid,z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TCR2_O3')

      rc=nf90_def_var(fid,"TCR2_NO2",NF90_FLOAT,(/x_dimid,y_dimid,z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TCR2_NO2')

      rc=nf90_def_var(fid,"TCR2_SO2",NF90_FLOAT,(/x_dimid,y_dimid,z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TCR2_SO2')

      rc=nf90_def_var(fid,"CAMCHEM_T",NF90_FLOAT,(/x_dimid,y_dimid,z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at CAMCHEM_T')

      rc=nf90_def_var(fid,"CAMCHEM_U",NF90_FLOAT,(/x_dimid,y_dimid,z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at CAMCHEM_U')

      rc=nf90_def_var(fid,"CAMCHEM_V",NF90_FLOAT,(/x_dimid,y_dimid,z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at CAMCHEM_V')

      rc=nf90_def_var(fid,"CAMCHEM_Q",NF90_FLOAT,(/x_dimid,y_dimid,z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at CAMCHEM_Q')

      rc=nf90_def_var(fid,"CAMCHEM_CO",NF90_FLOAT,(/x_dimid,y_dimid,z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at CAMCHEM_CO')

      rc=nf90_def_var(fid,"CAMCHEM_O3",NF90_FLOAT,(/x_dimid,y_dimid,z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at CAMCHEM_O3')

      rc=nf90_def_var(fid,"CAMCHEM_NO2",NF90_FLOAT,(/x_dimid,y_dimid,z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at CAMCHEM_NO2')

      rc=nf90_def_var(fid,"CAMCHEM_SO2",NF90_FLOAT,(/x_dimid,y_dimid,z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at CAMCHEM_SO2')
!
! TRACER-I MN
! T, U, V, and Q
      rc=nf90_def_var(fid,"TRACER_I_T_CONUS_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_T_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_T_URBAN_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_T_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_T_RURAL_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_T_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_U_CONUS_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_U_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_U_URBAN_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_U_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_U_RURAL_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_U_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_V_CONUS_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_V_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_V_URBAN_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_V_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_V_RURAL_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_V_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_Q_CONUS_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_Q_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_Q_URBAN_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_Q_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_Q_RURAL_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_Q_RURAL_MN')
!
! CO, O3, NO2, and SO2
      rc=nf90_def_var(fid,"TRACER_I_CO_CONUS_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_CO_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_CO_URBAN_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_CO_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_CO_RURAL_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_CO_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_O3_CONUS_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_O3_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_O3_URBAN_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_O3_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_O3_RURAL_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_O3_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_NO2_CONUS_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_NO2_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_NO2_URBAN_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_NO2_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_NO2_RURAL_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_NO2_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_SO2_CONUS_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_SO2_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_SO2_URBAN_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_SO2_URABN_MN')

      rc=nf90_def_var(fid,"TRACER_I_SO2_RURAL_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_SO2_RURAL_MN')
!
! TRACER I SD
! T, U, V, and Q      
      rc=nf90_def_var(fid,"TRACER_I_T_CONUS_SD",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_T_CONUS_SD')

      rc=nf90_def_var(fid,"TRACER_I_T_URBAN_SD",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_T_CONUS_SD')

      rc=nf90_def_var(fid,"TRACER_I_T_RURAL_SD",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_T_CONUS_SD')

      rc=nf90_def_var(fid,"TRACER_I_U_CONUS_SD",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_U_CONUS_SD')

      rc=nf90_def_var(fid,"TRACER_I_U_URBAN_SD",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_U_URBAN_SD')

      rc=nf90_def_var(fid,"TRACER_I_U_RURAL_SD",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_U_RURAL_SD')

      rc=nf90_def_var(fid,"TRACER_I_V_CONUS_SD",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_V_CONUS_SD')

      rc=nf90_def_var(fid,"TRACER_I_V_URBAN_SD",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_V_URBAN_SD')

      rc=nf90_def_var(fid,"TRACER_I_V_RURAL_SD",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_V_RURAL_SD')

      rc=nf90_def_var(fid,"TRACER_I_Q_CONUS_SD",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_Q_CONUS_SD')

      rc=nf90_def_var(fid,"TRACER_I_Q_URBAN_SD",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_Q_URBAN_SD')

      rc=nf90_def_var(fid,"TRACER_I_Q_RURAL_SD",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_Q_RURAL_SD')
!
! CO, O3, NO2, and SO2
      rc=nf90_def_var(fid,"TRACER_I_CO_CONUS_SD",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_CO_CONUS_SD')

      rc=nf90_def_var(fid,"TRACER_I_CO_URBAN_SD",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_CO_URBAN_SD')

      rc=nf90_def_var(fid,"TRACER_I_CO_RURAL_SD",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_CO_RURAL_SD')

      rc=nf90_def_var(fid,"TRACER_I_O3_CONUS_SD",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_O3_CONUS_SD')

      rc=nf90_def_var(fid,"TRACER_I_O3_URBAN_SD",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_O3_URBAN_SD')

      rc=nf90_def_var(fid,"TRACER_I_O3_RURAL_SD",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_O3_RURAL_SD')

      rc=nf90_def_var(fid,"TRACER_I_NO2_CONUS_SD",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_NO2_CONUS_SD')

      rc=nf90_def_var(fid,"TRACER_I_NO2_URBAN_SD",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_NO2_URBAN_SD')

      rc=nf90_def_var(fid,"TRACER_I_NO2_RURAL_SD",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_NO2_RURAL_SD')

      rc=nf90_def_var(fid,"TRACER_I_SO2_CONUS_SD",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_SO2_CONUS_SD')

      rc=nf90_def_var(fid,"TRACER_I_SO2_URBAN_SD",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_SO2_URBAN_SD')

      rc=nf90_def_var(fid,"TRACER_I_SO2_RURAL_SD",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_SO2_RURAL_SD')
!
! WRFCMAQ T, U, V, and Q
      rc=nf90_def_var(fid,"WRFCMAQ_T_CONUS_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at WRFCMAQ_T_CONUS_MN')

      rc=nf90_def_var(fid,"WRFCMAQ_T_URBAN_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at WRFCMAQ_T_URBAN_MN')

      rc=nf90_def_var(fid,"WRFCMAQ_T_RURAL_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at WRFCMAQ_T_RURAL_MN')

      rc=nf90_def_var(fid,"WRFCMAQ_U_CONUS_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at WRFCMAQ_U_CONUS_MN')

      rc=nf90_def_var(fid,"WRFCMAQ_U_URBAN_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at WRFCMAQ_U_URBAN_MN')

      rc=nf90_def_var(fid,"WRFCMAQ_U_RURAL_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at WRFCMAQ_U_RURAL_MN')

      rc=nf90_def_var(fid,"WRFCMAQ_V_CONUS_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at WRFCMAQ_V_CONUS_MN')

      rc=nf90_def_var(fid,"WRFCMAQ_V_URBAN_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at WRFCMAQ_V_URBAN_MN')

      rc=nf90_def_var(fid,"WRFCMAQ_V_RURAL_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at WRFCMAQ_V_RURAL_MN')

      rc=nf90_def_var(fid,"WRFCMAQ_Q_CONUS_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at WRFCMAQ_Q_CONUS_MN')

      rc=nf90_def_var(fid,"WRFCMAQ_Q_URBAN_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at WRFCMAQ_Q_URBAN_MN')

      rc=nf90_def_var(fid,"WRFCMAQ_Q_RURAL_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at WRFCMAQ_Q_RURAL_MN')
!
! CO, O3, NO2, SO2
      rc=nf90_def_var(fid,"WRFCMAQ_CO_CONUS_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at WRFCMAQ_CO_CONUS_MN')

      rc=nf90_def_var(fid,"WRFCMAQ_CO_URBAN_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at WRFCMAQ_CO_URBAN_MN')

      rc=nf90_def_var(fid,"WRFCMAQ_CO_RURAL_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at WRFCMAQ_CO_RURAL_MN')

      rc=nf90_def_var(fid,"WRFCMAQ_O3_CONUS_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at WRFCMAQ_O3_CONUS_MN')

      rc=nf90_def_var(fid,"WRFCMAQ_O3_URBAN_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at WRFCMAQ_O3_URBAN_MN')

      rc=nf90_def_var(fid,"WRFCMAQ_O3_RURAL_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at WRFCMAQ_O3_RURAL_MN')

      rc=nf90_def_var(fid,"WRFCMAQ_NO2_CONUS_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at WRFCMAQ_NO2_CONUS_MN')

      rc=nf90_def_var(fid,"WRFCMAQ_NO2_URBAN_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at WRFCMAQ_NO2_CONUS_MN')

      rc=nf90_def_var(fid,"WRFCMAQ_NO2_RURAL_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at WRFCMAQ_NO2_CONUS_MN')

      rc=nf90_def_var(fid,"WRFCMAQ_SO2_CONUS_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at WRFCMAQ_SO2_CONUS_MN')

      rc=nf90_def_var(fid,"WRFCMAQ_SO2_URBAN_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at WRFCMAQ_SO2_URBAN_MN')

      rc=nf90_def_var(fid,"WRFCMAQ_SO2_RURAL_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at WRFCMAQ_SO2_RURAL_MN')
!
! TCR2 T, U, V, and Q
      rc=nf90_def_var(fid,"TCR2_T_CONUS_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TCR2_T_CONUS_MN')

      rc=nf90_def_var(fid,"TCR2_T_URBAN_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TCR2_T_URBAN_MN')

      rc=nf90_def_var(fid,"TCR2_T_RURAL_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TCR2_T_RURAL_MN')

      rc=nf90_def_var(fid,"TCR2_U_CONUS_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TCR2_U_CONUS_MN')

      rc=nf90_def_var(fid,"TCR2_U_URBAN_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TCR2_U_URBAN_MN')

      rc=nf90_def_var(fid,"TCR2_U_RURAL_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TCR2_U_RURAL_MN')

      rc=nf90_def_var(fid,"TCR2_V_CONUS_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TCR2_V_CONUS_MN')

      rc=nf90_def_var(fid,"TCR2_V_URBAN_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TCR2_V_URBAN_MN')

      rc=nf90_def_var(fid,"TCR2_V_RURAL_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TCR2_V_RURAL_MN')

      rc=nf90_def_var(fid,"TCR2_Q_CONUS_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TCR2_Q_CONUS_MN')

      rc=nf90_def_var(fid,"TCR2_Q_URBAN_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TCR2_Q_URBAN_MN')

      rc=nf90_def_var(fid,"TCR2_Q_RURAL_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TCR2_Q_RURAL_MN')
!
! CO, O3, NO2, and SO2
      rc=nf90_def_var(fid,"TCR2_CO_CONUS_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TCR2_CO_CONUS_MN')

      rc=nf90_def_var(fid,"TCR2_CO_URBAN_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TCR2_CO_URBAN_MN')

      rc=nf90_def_var(fid,"TCR2_CO_RURAL_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TCR2_CO_RURAL_MN')

      rc=nf90_def_var(fid,"TCR2_O3_CONUS_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TCR2_O3_CONUS_MN')

      rc=nf90_def_var(fid,"TCR2_O3_URBAN_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TCR2_O3_URBAN_MN')

      rc=nf90_def_var(fid,"TCR2_O3_RURAL_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TCR2_O3_RURAL_MN')

      rc=nf90_def_var(fid,"TCR2_NO2_CONUS_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TCR2_NO2_CONUS_MN')

      rc=nf90_def_var(fid,"TCR2_NO2_URBAN_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TCR2_NO2_URBAN_MN')

      rc=nf90_def_var(fid,"TCR2_NO2_RURAL_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TCR2_NO2_RURAL_MN')

      rc=nf90_def_var(fid,"TCR2_SO2_CONUS_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TCR2_SO2_CONUS_MN')

      rc=nf90_def_var(fid,"TCR2_SO2_URBAN_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TCR2_SO2_URBAN_MN')

      rc=nf90_def_var(fid,"TCR2_SO2_RURAL_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TCR2_SO2_RURAL_MN')

!
! CAMCHEM T, U, V, and Q
      rc=nf90_def_var(fid,"CAMCHEM_T_CONUS_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at CAMCHEM_T_CONUS_MN')

      rc=nf90_def_var(fid,"CAMCHEM_T_URBAN_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at CAMCHEM_T_URBAN_MN')

      rc=nf90_def_var(fid,"CAMCHEM_T_RURAL_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at CAMCHEM_T_RURAL_MN')

      rc=nf90_def_var(fid,"CAMCHEM_U_CONUS_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at CAMCHEM_U_CONUS_MN')

      rc=nf90_def_var(fid,"CAMCHEM_U_URBAN_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at CAMCHEM_U_URBAN_MN')

      rc=nf90_def_var(fid,"CAMCHEM_U_RURAL_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at CAMCHEM_U_RURAL_MN')

      rc=nf90_def_var(fid,"CAMCHEM_V_CONUS_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at CAMCHEM_V_CONUS_MN')

      rc=nf90_def_var(fid,"CAMCHEM_V_URBAN_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at CAMCHEM_V_URBAN_MN')

      rc=nf90_def_var(fid,"CAMCHEM_V_RURAL_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at CAMCHEM_V_RURAL_MN')

      rc=nf90_def_var(fid,"CAMCHEM_Q_CONUS_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at CAMCHEM_Q_CONUS_MN')

      rc=nf90_def_var(fid,"CAMCHEM_Q_URBAN_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at CAMCHEM_Q_URBAN_MN')

      rc=nf90_def_var(fid,"CAMCHEM_Q_RURAL_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at CAMCHEM_Q_RURAL_MN')
!
! CO, O3, NO2, and SO2
      rc=nf90_def_var(fid,"CAMCHEM_CO_CONUS_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at CAMCHEM_CO_CONUS_MN')

      rc=nf90_def_var(fid,"CAMCHEM_CO_URBAN_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at CAMCHEM_CO_URBAN_MN')

      rc=nf90_def_var(fid,"CAMCHEM_CO_RURAL_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at CAMCHEM_CO_RURAL_MN')

      rc=nf90_def_var(fid,"CAMCHEM_O3_CONUS_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at CAMCHEM_O3_CONUS_MN')

      rc=nf90_def_var(fid,"CAMCHEM_O3_URBAN_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at CAMCHEM_O3_URBAN_MN')

      rc=nf90_def_var(fid,"CAMCHEM_O3_RURAL_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at CAMCHEM_O3_RURAL_MN')

      rc=nf90_def_var(fid,"CAMCHEM_NO2_CONUS_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at CAMCHEM_NO2_CONUS_MN')

      rc=nf90_def_var(fid,"CAMCHEM_NO2_URBAN_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at CAMCHEM_NO2_URBAN_MN')

      rc=nf90_def_var(fid,"CAMCHEM_NO2_RURAL_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at CAMCHEM_NO2_RURAL_MN')

      rc=nf90_def_var(fid,"CAMCHEM_SO2_CONUS_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at CAMCHEM_SO2_CONUS_MN')

      rc=nf90_def_var(fid,"CAMCHEM_SO2_URBAN_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at CAMCHEM_SO2_URBAN_MN')

      rc=nf90_def_var(fid,"CAMCHEM_SO2_RURAL_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at CAMCHEM_SO2_RURAL_MN')
!
      rc=nf90_enddef(fid)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at enddef')

      rc=nf90_close(fid)
      return
   end subroutine create_NETCDF_FILE

!-------------------------------------------------------------------------------

   subroutine put_NETCDF_fld(wrfchem_file,var_name,var_units,data,nx,ny,nz)
      use :: netcdf
      implicit none
!
      integer                    :: rc,fid,varid
      integer                    :: nx,ny,nz
      real,dimension(nx,ny,nz)   :: data
      character(len=*)           :: wrfchem_file,var_name,var_units
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

   subroutine spatial_mean_and_variance(fld_ens_mn,fld_ens_sd,fld_region_mn,fld_region_sd,fld_region_ii, &
   fld_region_jj,num_region,npts_region,npts_mdl_region,nx,ny,nz)
      implicit none
      integer                                         :: i,j,k,irgn,ipt
      integer                                         :: nx,ny,nz,num_region,npts_region
      integer,dimension(num_region)                   :: npts_mdl_region
      integer,dimension(num_region,npts_region)       :: fld_region_ii,fld_region_jj
      real                                            :: wt
      real,dimension(nz)                              :: zwt
      real,dimension(nz)                              :: fld_region_mn,fld_region_vr,fld_region_sd
      real,dimension(nx,ny,nz)                        :: fld_ens_mn,fld_ens_vr,fld_ens_sd
      fld_region_mn(:)=0.
      fld_region_vr(:)=0.
      fld_region_sd(:)=0.
!
      zwt(:)=0.
      do irgn=1,num_region
         do ipt=1,npts_mdl_region(irgn)
            i=fld_region_ii(irgn,ipt)
            j=fld_region_jj(irgn,ipt)
            wt=1.
            do k=1,nz
               fld_region_mn(k)=fld_region_mn(k)+wt*fld_ens_mn(i,j,k)
               fld_region_vr(k)=fld_region_vr(k)+wt*(fld_ens_sd(i,j,k)**2)
               zwt(k)=zwt(k)+wt
            enddo
         enddo
      enddo
      do k=1,nz
         fld_region_mn(k)=fld_region_mn(k)/zwt(k)
         fld_region_vr(k)=fld_region_vr(k)/(zwt(k))
         fld_region_sd(k)=sqrt(fld_region_vr(k))
      enddo
   end subroutine spatial_mean_and_variance

!-------------------------------------------------------------------------------

   subroutine spatial_mean_and_variance_regions(fld_ens_mn,fld_ens_sd,fld_region_mn,fld_region_sd,fld_region_ii, &
   fld_region_jj,num_region,npts_region,npts_mdl_region,nx,ny,nz)
      implicit none
      integer                                         :: i,j,k,irgn,ipt
      integer                                         :: nx,ny,nz,num_region,npts_region
      integer,dimension(num_region)                   :: npts_mdl_region
      integer,dimension(num_region,npts_region)       :: fld_region_ii,fld_region_jj
      real                                            :: wt
      real,dimension(num_region,nz)                   :: fld_region_mn,fld_region_vr,fld_region_sd
      real,dimension(num_region,nz)                   :: zwt
      real,dimension(nx,ny,nz)                        :: fld_ens_mn,fld_ens_vr,fld_ens_sd
      fld_region_mn(:,:)=0.
      fld_region_vr(:,:)=0.
      fld_region_sd(:,:)=0.
!
      do irgn=1,num_region
         zwt(irgn,:)=0.
         do ipt=1,npts_mdl_region(irgn)
            i=fld_region_ii(irgn,ipt)
            j=fld_region_jj(irgn,ipt)
            wt=1.
            do k=1,nz
               fld_region_mn(irgn,k)=fld_region_mn(irgn,k)+wt*fld_ens_mn(i,j,k)
               fld_region_vr(irgn,k)=fld_region_vr(irgn,k)+wt*(fld_ens_sd(i,j,k)**2)
               zwt(irgn,k)=zwt(irgn,k)+wt
            enddo
         enddo
      enddo
      do irgn=1,num_region
         do k=1,nz
            fld_region_mn(irgn,k)=fld_region_mn(irgn,k)/zwt(irgn,k)
            fld_region_vr(irgn,k)=fld_region_vr(irgn,k)/(zwt(irgn,k))
            fld_region_sd(irgn,k)=sqrt(fld_region_vr(irgn,k))
         enddo
      enddo
   end subroutine spatial_mean_and_variance_regions

!-------------------------------------------------------------------------------

   subroutine spatial_interpolate_1dp(fld_intrp_case,fld_case,p_case,p_ref, &
      case_ll_ii,case_ll_jj,case_lr_ii,case_lr_jj,case_ul_ii,case_ul_jj, &
      case_ur_ii,case_ur_jj,lon_ref,lat_ref,lon_case,lat_case, &
      nx_case,ny_case,nz_case,nx_ref,ny_ref,nz_ref)
      implicit none
      integer                                         :: i,j,k,kk
      integer                                         :: nx_ref,ny_ref,nz_ref,nx_case,ny_case,nz_case
      integer,dimension(nx_ref,ny_ref)                :: case_ll_ii,case_ll_jj,case_lr_ii,case_lr_jj
      integer,dimension(nx_ref,ny_ref)                :: case_ul_ii,case_ul_jj,case_ur_ii,case_ur_jj
      integer,dimension(nz_ref)                       :: kk_val
      real                                            :: re,pi,rad2deg
      real                                            :: case_lat_mid,case_lon_val_lft,case_lon_val_rgt
      real                                            :: trm1,trm2
      real                                            :: wt_lft,wt_rgt
      real,dimension(nz_ref)                          :: up_wt,dw_wt
      real,dimension(nx_case)                         :: lon_case
      real,dimension(ny_case)                         :: lat_case
      real,dimension(nz_case)                         :: fld_case_prf
      real,dimension(nz_case)                         :: p_case,case_lft,case_rgt
      real,dimension(nx_ref,ny_ref)                   :: lon_ref,lat_ref
      real,dimension(nx_ref,ny_ref,nz_ref)            :: p_ref,fld_intrp_case
      real,dimension(nx_case,ny_case,nz_case)         :: fld_case
!
! Set constants
      re=6371000
      pi=4.*atan(1.)
      rad2deg=180./pi
!
! Assumes vertical grid is bottom to top
! Get vertical interpolation weights      
      do i=1,nx_ref
         do j=1,ny_ref
            up_wt(:)=0.
            dw_wt(:)=0.
            kk_val(:)=0
            do k=1,nz_ref
               do kk=1,nz_case-1
                  if(p_ref(i,j,k).gt.p_case(1)) then
                     up_wt(k)=0.
                     dw_wt(k)=1.
                     kk_val(k)=kk
                     exit
                  elseif(p_ref(i,j,k).le.p_case(nz_case)) then
                     up_wt(k)=1.
                     dw_wt(k)=0.
                     kk_val(k)=kk
                  elseif (p_ref(i,j,k).le.p_case(kk) .and. p_ref(i,j,k).gt.p_case(kk+1)) then
                     up_wt(k)=log(p_case(kk))-log(p_ref(i,j,k))
                     dw_wt(k)=log(p_ref(i,j,k))-log(p_case(kk+1))
                     kk_val(k)=kk
                     exit
                  endif
               enddo
            enddo
            if(nx_case.eq.81) then
               do k=1,nz_ref
                  print *, 'up_wt,dw_wt,k_case,p_ref,p_case ',k,dw_wt(k),up_wt(k),kk_val(k), &
                  (log(p_ref(i,j,k))-log(p_case(kk_val(k)+1))),(log(p_case(kk_val(k)))-log(p_ref(i,j,k)))
               enddo
               stop
            endif
!      
! Interpolate case field to ref field locations
            case_lat_mid=(lat_case(case_ll_jj(i,j))+lat_case(case_ul_jj(i,j)))/2.
            case_lon_val_lft=lon_case(case_ll_ii(i,j))
            trm1=(sin((lat_ref(i,j)-case_lat_mid)/rad2deg)/2.)**2.
            trm2=cos(case_lat_mid/rad2deg)*cos(lat_ref(i,j)/rad2deg)* &
            sin((lon_ref(i,j)-case_lon_val_lft)/rad2deg)**2.
            wt_rgt=asin(sqrt(trm1+trm2))
!
            case_lat_mid=(lat_case(case_lr_jj(i,j))+lat_case(case_ur_jj(i,j)))/2.
            case_lon_val_rgt=lon_case(case_lr_ii(i,j))
            trm1=(sin((lat_ref(i,j)-case_lat_mid)/rad2deg)/2.)**2.
            trm2=cos(case_lat_mid/rad2deg)*cos(lat_ref(i,j)/rad2deg)* &
            sin((lon_ref(i,j)-case_lon_val_rgt)/rad2deg)**2.
            wt_lft=asin(sqrt(trm1+trm2))
!
!            print *, 'horiz weights ',wt_lft,wt_rgt,case_lon_val_lft,lon_ref(i,j),case_lon_val_rgt
            do k=1,nz_case
               case_lft(k)=(fld_case(case_ll_ii(i,j),case_ll_jj(i,j),k)+ &
               fld_case(case_ul_ii(i,j),case_ul_jj(i,j),k))/2.
               case_rgt(k)=(fld_case(case_lr_ii(i,j),case_ll_jj(i,j),k)+ &
               fld_case(case_ur_ii(i,j),case_ul_jj(i,j),k))/2.
               fld_case_prf(k)=(wt_lft*case_lft(k)+wt_rgt*case_rgt(k))/(wt_lft+wt_rgt)              
!               print *, 'case_lft,case_rgt,intrp ', case_lft(k),case_rgt(k),fld_case_prf(k)
!               print *, 'corners ',fld_case(case_ll_ii(i,j),case_ll_jj(i,j),k), &
!               fld_case(case_lr_ii(i,j),case_lr_jj(i,j),k), &
!               fld_case(case_ul_ii(i,j),case_ul_jj(i,j),k), &
!               fld_case(case_ur_ii(i,j),case_ur_jj(i,j),k)
!               print *, ' '
            enddo
            do k=1,nz_ref
               fld_intrp_case(i,j,k)=(dw_wt(k)*fld_case_prf(kk_val(k))+ &
               up_wt(k)*fld_case_prf(kk_val(k)+1))/(dw_wt(k)+up_wt(k))
            enddo
         enddo
      enddo               
   end subroutine spatial_interpolate_1dp

!-------------------------------------------------------------------------------

   subroutine spatial_interpolate_3dp(fld_intrp_case,fld_case,p_case,p_ref, &
      case_ll_ii,case_ll_jj,case_lr_ii,case_lr_jj,case_ul_ii,case_ul_jj, &
      case_ur_ii,case_ur_jj,lon_ref,lat_ref,lon_case,lat_case, &
      nx_case,ny_case,nz_case,nx_ref,ny_ref,nz_ref)
      implicit none
      integer                                         :: i,ii,j,jj,k,kk,icorn,ncorners
      integer                                         :: nx_ref,ny_ref,nz_ref,nx_case,ny_case,nz_case
      integer,dimension(nx_ref,ny_ref)                :: case_ll_ii,case_ll_jj,case_lr_ii,case_lr_jj
      integer,dimension(nx_ref,ny_ref)                :: case_ul_ii,case_ul_jj,case_ur_ii,case_ur_jj
      integer,dimension(nz_ref)                       :: kk_val
      integer,allocatable,dimension(:,:)              :: corn_kk_val
      real                                            :: re,pi,rad2deg
      real                                            :: case_lat_mid,case_lon_val_lft,case_lon_val_rgt
      real                                            :: trm1,trm2
      real                                            :: wt_lft,wt_rgt
      real,dimension(nx_case)                         :: lon_case
      real,dimension(ny_case)                         :: lat_case
      real,dimension(nz_case)                         :: fld_case_prf
      real,dimension(nz_ref)                          :: up_wt,dw_wt
      real,dimension(nz_ref)                          :: up_vwt_lft,dw_vwt_lft,kk_vwt_lft
      real,dimension(nz_ref)                          :: up_vwt_rgt,dw_vwt_rgt,kk_vwt_rgt
      real,dimension(nz_case)                         :: case_lft,case_rgt
      real,dimension(nx_case,ny_case,nz_case)         :: p_case
      real,dimension(nx_ref,ny_ref)                   :: lon_ref,lat_ref
      real,dimension(nx_ref,ny_ref,nz_ref)            :: p_ref,fld_intrp_case
      real,dimension(nx_case,ny_case,nz_case)         :: fld_case
      real,allocatable,dimension(:,:)                 :: corn_up_wt,corn_dw_wt
!
! Set constants
      re=6371000
      pi=4.*atan(1.)
      rad2deg=180./pi
      ncorners=4
      allocate(corn_up_wt(ncorners,nz_ref))
      allocate(corn_dw_wt(ncorners,nz_ref))
      allocate(corn_kk_val(ncorners,nz_ref))
!
! Assumes vertical grid is bottom to top
! Get vertical interpolation weights      
!      print *, 'P TRACER1 ',p_ref(nx_ref/5,ny_ref/5,:)
!      print *, 'P CASE ',p_case(nx_case/5,ny_case/5,:)
      do i=1,nx_ref
         do j=1,ny_ref
            up_wt(:)=0.
            dw_wt(:)=0.
            kk_val(:)=0
            do k=1,nz_ref
               do icorn=1,ncorners
                  if(icorn.eq.1) then
                     ii=case_ll_ii(i,j)
                     jj=case_ll_jj(i,j)
                  elseif(icorn.eq.2) then
                     ii=case_lr_ii(i,j)
                     jj=case_lr_jj(i,j)
                  elseif(icorn.eq.3) then
                     ii=case_ul_ii(i,j)
                     jj=case_ul_jj(i,j)
                  elseif(icorn.eq.4) then
                     ii=case_ur_ii(i,j)
                     jj=case_ur_jj(i,j)
                  endif                     
                  do kk=1,nz_case-1
                     if(p_ref(i,j,k).gt.p_case(ii,jj,1)) then
                        corn_up_wt(icorn,k)=0.
                        corn_dw_wt(icorn,k)=1.
                        corn_kk_val(icorn,k)=kk
                        exit
                     elseif(p_ref(i,j,k).le.p_case(ii,jj,nz_case)) then
                        corn_up_wt(icorn,k)=1.
                        corn_dw_wt(icorn,k)=0.
                        corn_kk_val(icorn,k)=kk
                     elseif (p_ref(i,j,k).le.p_case(ii,jj,kk) .and. &
                     p_ref(i,j,k).gt.p_case(ii,jj,kk+1)) then
                        corn_up_wt(icorn,k)=log(p_case(ii,jj,kk))-log(p_ref(i,j,k))
                        corn_dw_wt(icorn,k)=log(p_ref(i,j,k))-log(p_case(ii,jj,kk+1))
                        corn_kk_val(icorn,k)=kk
                        exit
                     endif
                  enddo
               enddo
            enddo
!      
! Interpolate case field to ref field locations
! left mid-point            
            case_lat_mid=(lat_case(case_ll_jj(i,j))+lat_case(case_ul_jj(i,j)))/2.
            case_lon_val_lft=lon_case(case_ll_ii(i,j))
            trm1=(sin((lat_ref(i,j)-case_lat_mid)/rad2deg)/2.)**2.
            trm2=cos(case_lat_mid/rad2deg)*cos(lat_ref(i,j)/rad2deg)* &
            sin((lon_ref(i,j)-case_lon_val_lft)/rad2deg)**2.
            wt_rgt=asin(sqrt(trm1+trm2))
!               
! right mid-point            
            case_lat_mid=(lat_case(case_lr_jj(i,j))+lat_case(case_ur_jj(i,j)))/2.
            case_lon_val_rgt=lon_case(case_lr_ii(i,j))
            trm1=(sin((lat_ref(i,j)-case_lat_mid)/rad2deg)/2.)**2.
            trm2=cos(case_lat_mid/rad2deg)*cos(lat_ref(i,j)/rad2deg)* &
            sin((lon_ref(i,j)-case_lon_val_rgt)/rad2deg)**2.
            wt_lft=asin(sqrt(trm1+trm2))
!
            do k=1,nz_ref
               up_vwt_lft(k)=(corn_up_wt(1,k)+corn_up_wt(3,k))/2.
               dw_vwt_lft(k)=(corn_dw_wt(1,k)+corn_dw_wt(3,k))/2.
               kk_vwt_lft(k)=nint((corn_kk_val(1,k)+corn_kk_val(3,k))/2.)
               up_vwt_rgt(k)=(corn_up_wt(2,k)+corn_up_wt(4,k))/2.
               dw_vwt_rgt(k)=(corn_dw_wt(2,k)+corn_dw_wt(4,k))/2.
               kk_vwt_rgt(k)=nint((corn_kk_val(2,k)+corn_kk_val(4,k))/2.)
               up_wt(k)=(wt_lft*up_vwt_lft(k)+wt_rgt*up_vwt_rgt(k))/(wt_lft+wt_rgt)
               dw_wt(k)=(wt_lft*dw_vwt_lft(k)+wt_rgt*dw_vwt_rgt(k))/(wt_lft+wt_rgt)
               kk_val(k)=nint((wt_lft*kk_vwt_lft(k)+wt_rgt*kk_vwt_rgt(k))/(wt_lft+wt_rgt))
            enddo
            do k=1,nz_case
               case_lft(k)=(fld_case(case_ll_ii(i,j),case_ll_jj(i,j),k)+ &
               fld_case(case_ul_ii(i,j),case_ul_jj(i,j),k))/2.
               case_rgt(k)=(fld_case(case_lr_ii(i,j),case_ll_jj(i,j),k)+ &
               fld_case(case_ur_ii(i,j),case_ul_jj(i,j),k))/2.
               fld_case_prf(k)=(wt_lft*case_lft(k)+wt_rgt*case_rgt(k))/(wt_lft+wt_rgt)
            enddo
            do k=1,nz_ref
               fld_intrp_case(i,j,k)=(dw_wt(k)*fld_case_prf(kk_val(k))+ &
               up_wt(k)*fld_case_prf(kk_val(k)+1))/(dw_wt(k)+up_wt(k))
            enddo
         enddo
      enddo
      deallocate(corn_up_wt)
      deallocate(corn_dw_wt)
      deallocate(corn_kk_val)
   end subroutine spatial_interpolate_3dp
   
!-------------------------------------------------------------------------------

   subroutine wrfcmaq_interpolate_3dp(fld_intrp_case,fld_case,p_case,p_ref,case_i, &
   case_j,case_ii,case_jj,num_case,nx_case,ny_case,nz_case,nx_ref,ny_ref,nz_ref,do_wts_calc)
      implicit none
      integer                                         :: i,ii,j,jj,k,kk,ipt,num_case
      integer                                         :: nx_ref,ny_ref,nz_ref,nx_case,ny_case,nz_case
      integer,dimension(num_case)                     :: case_i,case_j
      integer,dimension(num_case)                     :: case_ii,case_jj
      integer,dimension(num_case,nz_ref)              :: kk_val
      real,dimension(num_case,nz_ref)                 :: up_wt,dw_wt
      real,dimension(nx_ref,ny_ref,nz_ref)            :: p_ref
      real,dimension(nx_case,ny_case,nz_case)         :: p_case
      real,dimension(nx_case,ny_case,nz_case)         :: fld_case
      real,dimension(nx_ref,ny_ref,nz_ref)            :: fld_intrp_case
      logical                                         :: do_wts_calc
!
! Get vertical interpolation weights for all points (do this once)
      if(do_wts_calc) then
         up_wt(:,:)=0.
         dw_wt(:,:)=0.
         kk_val(:,:)=0
         do ipt=1,num_case
            i=case_i(ipt)
            j=case_j(ipt)
            ii=case_ii(ipt)
            jj=case_jj(ipt)
!
! Get vertical interpolation weights      
            do k=1,nz_ref
               do kk=1,nz_case-1
                  if(p_ref(i,j,k).ge.p_case(ii,jj,1)) then
                     up_wt(ipt,k)=0.
                     dw_wt(ipt,k)=1.
                     kk_val(ipt,k)=1
                     exit
                  elseif(p_ref(i,j,k).le.p_case(ii,jj,nz_case)) then
                     up_wt(ipt,k)=1.
                     dw_wt(ipt,k)=0.
                     kk_val(ipt,k)=nz_case-1
                     exit
                  elseif (p_ref(i,j,k).le.p_case(ii,jj,kk) .and. &
                  p_ref(i,j,k).ge.p_case(ii,jj,kk+1)) then
                     up_wt(ipt,k)=log(p_case(ii,jj,kk))-log(p_ref(i,j,k))
                     dw_wt(ipt,k)=log(p_ref(i,j,k))-log(p_case(ii,jj,kk+1))
                     kk_val(ipt,k)=kk
                     exit
                  endif
               enddo
            enddo
         enddo
      endif
!      
! Interpolate case field to ref field vertical grid
      fld_intrp_case(:,:,:)=-9999      
      do ipt=1,num_case
         i=case_i(ipt)
         j=case_j(ipt)
         ii=case_ii(ipt)
         jj=case_jj(ipt)
         do k=1,nz_ref
            fld_intrp_case(i,j,k)=(dw_wt(ipt,k)*fld_case(ii,jj,kk_val(ipt,k))+ &
            up_wt(ipt,k)*fld_case(ii,jj,kk_val(ipt,k)+1))/(dw_wt(ipt,k)+up_wt(ipt,k))
         enddo
      enddo
   end subroutine wrfcmaq_interpolate_3dp

!-------------------------------------------------------------------------------

   subroutine wrfcmaq_interpolate_2dh(fld_intrp_case,fld_case,case_i,case_j, &
   case_ii,case_jj,num_case,nx_case,ny_case,nz_case,nx_ref,ny_ref,nz_ref)
      implicit none
      integer                                         :: i,ii,j,jj,k,kk,ipt,num_case
      integer                                         :: nx_ref,ny_ref,nz_ref,nx_case,ny_case,nz_case
      integer,dimension(num_case)                     :: case_i,case_j
      integer,dimension(num_case)                     :: case_ii,case_jj
      real,dimension(nx_case,ny_case,nz_case)         :: fld_case
      real,dimension(nx_ref,ny_ref,nz_ref)            :: fld_intrp_case
!      
! No vertical interpolation - wrfcmaq has only one vertical level for this data
      fld_intrp_case(:,:,:)=-9999      
      do ipt=1,num_case
         i=case_i(ipt)
         j=case_j(ipt)
         ii=case_ii(ipt)
         jj=case_jj(ipt)
         do k=1,nz_ref
            fld_intrp_case(i,j,k)=fld_case(ii,jj,nz_case)
         enddo
      enddo
   end subroutine wrfcmaq_interpolate_2dh
   
!-------------------------------------------------------------------------------
   
   subroutine zinvert(fld,nx,ny,nz,nt)           
      implicit none
      integer                       :: i,j,k,kk,l,nx,ny,nz,nt
      real,dimension(nz)            :: temp
      real,dimension(nx,ny,nz,nt)   :: fld
!
      do i=1,nx
         do j=1,ny
            do l=1,nt
               do k=1,nz
                  kk=nz-k+1
                  temp(kk)=fld(i,j,k,l)
               enddo
               do k=1,nz
                  fld(i,j,k,l)=temp(k)
               enddo
            enddo
         enddo
      enddo
   end subroutine zinvert

