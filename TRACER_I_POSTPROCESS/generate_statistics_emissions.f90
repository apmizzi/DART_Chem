  program main
      implicit none
      integer                                    :: nx,ny,nz,nz_chemi,nz_fire,num_mems
      integer                                    :: i,j,k,l,imem,ifld,unit
      integer                                    :: npts_conus,npts_urban,npts_rural
      integer                                    :: yyyy_traceri,mm_traceri,dd_traceri,hh_traceri
      integer                                    :: num_conus,num_rural,num_regions,num_cities
      integer                                    :: date_traceri
      integer,allocatable,dimension(:)           :: num_urban
      integer,allocatable,dimension(:)           :: traceri_conus_ii,traceri_conus_jj
      integer,allocatable,dimension(:)           :: traceri_rural_ii,traceri_rural_jj
      real,allocatable,dimension(:)              :: e_co_conus_mn,e_co_conus_sd,e_no2_conus_mn,e_no2_conus_sd
      real,allocatable,dimension(:)              :: e_so2_conus_mn,e_so2_conus_sd,ebu_in_co_conus_mn,ebu_in_co_conus_sd
      real,allocatable,dimension(:)              :: ebu_in_no2_conus_mn,ebu_in_no2_conus_sd,ebu_in_so2_conus_mn,ebu_in_so2_conus_sd
      real,allocatable,dimension(:)              :: e_co_urban_mn,e_co_urban_sd,e_no2_urban_mn,e_no2_urban_sd
      real,allocatable,dimension(:)              :: e_so2_urban_mn,e_so2_urban_sd,ebu_in_co_urban_mn,ebu_in_co_urban_sd
      real,allocatable,dimension(:)              :: ebu_in_no2_urban_mn,ebu_in_no2_urban_sd,ebu_in_so2_urban_mn,ebu_in_so2_urban_sd
      real,allocatable,dimension(:)              :: e_co_rural_mn,e_co_rural_sd,e_no2_rural_mn,e_no2_rural_sd
      real,allocatable,dimension(:)              :: e_so2_rural_mn,e_so2_rural_sd,ebu_in_co_rural_mn,ebu_in_co_rural_sd
      real,allocatable,dimension(:)              :: ebu_in_no2_rural_mn,ebu_in_no2_rural_sd,ebu_in_so2_rural_mn,ebu_in_so2_rural_sd
      real,allocatable,dimension(:,:)            :: e_co_cities_mn,e_co_cities_sd,e_no2_cities_mn,e_no2_cities_sd
      real,allocatable,dimension(:,:)            :: e_so2_cities_mn,e_so2_cities_sd,ebu_in_co_cities_mn,ebu_in_co_cities_sd
      real,allocatable,dimension(:,:)            :: ebu_in_no2_cities_mn,ebu_in_no2_cities_sd,ebu_in_so2_cities_mn
      real,allocatable,dimension(:,:)            :: ebu_in_so2_cities_sd
      real,allocatable,dimension(:,:)            :: lon,lat,traceri_urban_ii,traceri_urban_jj
      real,allocatable,dimension(:,:,:)          :: no2_ens_mn,no2_ens_sd,so2_ens_mn,so2_ens_sd
      real,allocatable,dimension(:,:,:)          :: e_co_ens_mn,e_co_ens_sd
      real,allocatable,dimension(:,:,:)          :: ebu_in_co_ens_mn,ebu_in_co_ens_sd
      real,allocatable,dimension(:,:,:)          :: e_no2_ens_mn,e_no2_ens_sd,e_so2_ens_mn,e_so2_ens_sd
      real,allocatable,dimension(:,:,:)          :: ebu_in_no2_ens_mn,ebu_in_no2_ens_sd,ebu_in_so2_ens_mn,ebu_in_so2_ens_sd
      real,allocatable,dimension(:,:,:,:)        :: e_co_fld,e_no2_fld,e_so2_fld
      real,allocatable,dimension(:,:,:,:)        :: ebu_in_co_fld,ebu_in_no2_fld,ebu_in_so2_fld
      character(len=30)                          :: cmem
      character(len=50)                          :: fld_name
      character(len=200)                         :: path_input,path_output
      character(len=200)                         :: read_file,write_file
      character(len=200)                         :: strat_interp_map_file
      character(len=200)                         :: wrfout_input,wrfchemi_input,wrffirechemi_input
      character(len=200)                         :: file_output
      character(len=60),allocatable,dimension(:) :: met_flds,chem_flds,chemi_flds,firechemi_flds
!
      namelist/ens_postprocess/path_input,path_output,wrfout_input,wrfchemi_input, &
      wrffirechemi_input,file_output,nx,ny,nz,nz_chemi,nz_fire,num_mems,date_traceri
!     
      strat_interp_map_file="TRACER_I_Stratifications_Data"
      nx=440
      ny=284
      npts_conus=nx*ny
      npts_urban=1000
      npts_rural=nx*ny
      num_cities=29
      num_regions=3592
!
      unit=20
      open(unit=unit,file="ens_postprocess.nl",form="formatted", &
      status="old",action="read")
      rewind(unit)
      read(unit,ens_postprocess)
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
!      print *,"num_mems ",           num_mems
!      print *,"date_traceri ",       date_traceri
      yyyy_traceri=date_traceri/1000000
      mm_traceri=(date_traceri-yyyy_traceri*1000000)/10000
      dd_traceri=(date_traceri-yyyy_traceri*1000000-mm_traceri*10000)/100
      hh_traceri=date_traceri-yyyy_traceri*1000000-mm_traceri*10000-dd_traceri*100
!      print *, yyyy_traceri,mm_traceri,dd_traceri,hh_traceri
!
! Read stratifications and interpolation mappings data
! TRACER I
      allocate(traceri_conus_ii(npts_conus))
      allocate(traceri_conus_jj(npts_conus))
      call get_WRFCHEM_fld_int(trim(strat_interp_map_file),"NUM_TRACER_I_CONUS",num_conus,1,1,1,1)
      call get_WRFCHEM_fld_int(trim(strat_interp_map_file),"TRACER_I_CONUS_II",traceri_conus_ii, &
      npts_conus,1,1,1)
      call get_WRFCHEM_fld_int(trim(strat_interp_map_file),"TRACER_I_CONUS_JJ",traceri_conus_jj, &
      npts_conus,1,1,1)
      allocate(num_urban(num_regions))
      allocate(traceri_urban_ii(num_regions,npts_urban))
      allocate(traceri_urban_jj(num_regions,npts_urban))
      call get_WRFCHEM_fld_int(trim(strat_interp_map_file),"NUM_TRACER_I_URBAN",num_urban, &
      num_regions,1,1,1)
      call get_WRFCHEM_fld_int(trim(strat_interp_map_file),"TRACER_I_URBAN_II",traceri_urban_ii, &
      num_regions,npts_urban,1,1)
      call get_WRFCHEM_fld_int(trim(strat_interp_map_file),"TRACER_I_URBAN_JJ",traceri_urban_jj, &
      num_regions,npts_urban,1,1)
      allocate(traceri_rural_ii(npts_rural))
      allocate(traceri_rural_jj(npts_rural))
      call get_WRFCHEM_fld_int(trim(strat_interp_map_file),"NUM_TRACER_I_RURAL",num_rural,1,1,1,1)
      call get_WRFCHEM_fld_int(trim(strat_interp_map_file),"TRACER_I_RURAL_II",traceri_rural_ii,npts_rural,1,1,1)
      call get_WRFCHEM_fld_int(trim(strat_interp_map_file),"TRACER_I_RURAL_JJ",traceri_rural_jj,npts_rural,1,1,1)
!
! Create output NETCDF file
      write_file=trim(path_output)//"/"//trim(file_output)
      print *, 'APM: Create file ',trim(write_file)
      call create_NETCDF_file(trim(write_file),nx,ny,nz,nz_chemi,nz_fire)
!
! lon and lat
      allocate(lon(nx,ny))
      allocate(lat(nx,ny))
      read_file=trim(path_input)//"/run_e001/"//trim(wrfout_input)
      call get_WRFCHEM_fld_real(trim(read_file),"XLONG",lon,nx,ny,1,1)
      call get_WRFCHEM_fld_real(trim(read_file),"XLAT",lat,nx,ny,1,1)
!      
      write_file=trim(path_output)//"/"//trim(file_output)
      call put_NETCDF_fld(trim(write_file),"TRACER_I_LON","degrees",lon,nx,ny,1)
      call put_NETCDF_fld(trim(write_file),"TRACER_I_LAT","degrees",lat,nx,ny,1)
!
! CHEMI Emissions 
! E_CO
      print *, '   APM: Before process E_CO'
      allocate(e_co_fld(nx,ny,nz_chemi,num_mems))
      allocate(e_co_conus_mn(nz_chemi),e_co_conus_sd(nz_chemi))
      allocate(e_co_urban_mn(nz_chemi),e_co_urban_sd(nz_chemi))
      allocate(e_co_rural_mn(nz_chemi),e_co_rural_sd(nz_chemi))
      do imem=1,num_mems
         if(imem.ge.0.and.imem.lt.10) write(cmem,"('/run_e00',i1)"),imem
         if(imem.ge.10.and.imem.lt.100) write(cmem,"('/run_e0',i2)"),imem
         if(imem.ge.100.and.imem.lt.1000) write(cmem,"('/run_e',i3)"),imem
         read_file=trim(path_input)//trim(cmem)//"/"//trim(wrfchemi_input)
!         print *, 'READ FILE ',imem,trim(read_file)
         call get_WRFCHEM_fld_real(trim(read_file),"E_CO",e_co_fld(1,1,1,imem),nx,ny,nz_chemi,1)
      enddo
!      
! Ensemble stats E_CO
      allocate(e_co_ens_mn(nx,ny,nz_chemi))
      allocate(e_co_ens_sd(nx,ny,nz_chemi))
      call ens_stats_emiss(e_co_fld,e_co_ens_mn,e_co_ens_sd,nx,ny,nz_chemi,num_mems)
      deallocate(e_co_fld)
      write_file=trim(path_output)//"/"//trim(file_output)
      call put_NETCDF_fld(trim(write_file),"TRACER_I_E_CO_MN", &
      "flux (mol km^-2 hr^-1)",e_co_ens_mn,nx,ny,nz_chemi)
      call put_NETCDF_fld(trim(write_file),"TRACER_I_E_CO_SD", &
      "flux (mol km^-2 hr^-1)",e_co_ens_sd,nx,ny,nz_chemi)
!
! CONUS Spatial statistics E_CO
      call spatial_mean_and_variance_emiss(e_co_ens_mn,e_co_ens_sd, &
      e_co_conus_mn,e_co_conus_sd,traceri_conus_ii,traceri_conus_jj, &
      1,nx*ny,num_conus,nx,ny,nz_chemi)
!      print *, 'e_co_conus_mn TRACER1 ',e_co_conus_mn(:)
!      print *, 'e_co_conus_sd TRACER1 ',e_co_conus_sd(:)
      write_file=trim(path_output)//"/"//trim(file_output)
      call put_NETCDF_fld(trim(write_file),"TRACER_I_E_CO_CONUS_MN", &
      "flux (mol km^-2 hr^-1)",e_co_conus_mn,nz_chemi,1,1)
      call put_NETCDF_fld(trim(write_file),"TRACER_I_E_CO_CONUS_SD", &
      "flux (mol km^-2 hr^-1)",e_co_conus_sd,nz_chemi,1,1)
!
! TRACER-I URBAN Spatial statistics E_CO
      call spatial_mean_and_variance_emiss(e_co_ens_mn,e_co_ens_sd, &
      e_co_urban_mn,e_co_urban_sd,traceri_urban_ii,traceri_urban_jj, &
      num_regions,npts_urban,num_urban,nx,ny,nz_chemi)
!      print *, 'e_co_urban_mn TRACER1 ',e_co_urban_mn(:)
!      print *, 'e_co_urban_sd TRACER1 ',e_co_urban_sd(:)
      write_file=trim(path_output)//"/"//trim(file_output)
      call put_NETCDF_fld(trim(write_file),"TRACER_I_E_CO_URBAN_MN", &
      "flux (mol km^-2 hr^-1)",e_co_urban_mn,nz_chemi,1,1)
      call put_NETCDF_fld(trim(write_file),"TRACER_I_E_CO_URBAN_SD", &
      "flux (mol km^-2 hr^-1)",e_co_urban_sd,nz_chemi,1,1)
!
! TRACER-I RURAL Spatial statistics E_CO
      call spatial_mean_and_variance_emiss(e_co_ens_mn,e_co_ens_sd, &
      e_co_rural_mn,e_co_rural_sd,traceri_rural_ii,traceri_rural_jj, &
      1,nx*ny,num_rural,nx,ny,nz_chemi)
!      print *, 'e_co_rural_mn TRACER1 ',e_co_rural_mn(:)
!      print *, 'e_co_rural_sd TRACER1 ',e_co_rural_sd(:)
      write_file=trim(path_output)//"/"//trim(file_output)
      call put_NETCDF_fld(trim(write_file),"TRACER_I_E_CO_RURAL_MN", &
      "flux (mol km^-2 hr^-1)",e_co_rural_mn,nz_chemi,1,1)
      call put_NETCDF_fld(trim(write_file),"TRACER_I_E_CO_RURAL_SD", &
      "flux (mol km^-2 hr^-1)",e_co_rural_sd,nz_chemi,1,1)     
      deallocate(e_co_ens_mn)    
      deallocate(e_co_ens_sd)
      deallocate(e_co_conus_mn)
      deallocate(e_co_conus_sd)
      deallocate(e_co_urban_mn)
      deallocate(e_co_urban_sd)
      deallocate(e_co_rural_mn)
      deallocate(e_co_rural_sd)
      print *, '   APM: After process E_CO'
!
! E_NO2
      print *, '   APM: Before process E_NO2'
      allocate(e_no2_fld(nx,ny,nz_chemi,num_mems))
      allocate(e_no2_conus_mn(nz_chemi),e_no2_conus_sd(nz_chemi))
      allocate(e_no2_urban_mn(nz_chemi),e_no2_urban_sd(nz_chemi))
      allocate(e_no2_rural_mn(nz_chemi),e_no2_rural_sd(nz_chemi))
      do imem=1,num_mems
         if(imem.ge.0.and.imem.lt.10) write(cmem,"('/run_e00',i1)"),imem
         if(imem.ge.10.and.imem.lt.100) write(cmem,"('/run_e0',i2)"),imem
         if(imem.ge.100.and.imem.lt.1000) write(cmem,"('/run_e',i3)"),imem
         read_file=trim(path_input)//trim(cmem)//"/"//trim(wrfchemi_input)
!         print *, 'READ FILE ',imem,trim(read_file)
         call get_WRFCHEM_fld_real(trim(read_file),"E_NO2",e_no2_fld(1,1,1,imem),nx,ny,nz_chemi,1)
      enddo
!      
! Ensemble stats E_NO2
      allocate(e_no2_ens_mn(nx,ny,nz_chemi))
      allocate(e_no2_ens_sd(nx,ny,nz_chemi))
      call ens_stats_emiss(e_no2_fld,e_no2_ens_mn,e_no2_ens_sd,nx,ny,nz_chemi,num_mems)
      deallocate(e_no2_fld)
      write_file=trim(path_output)//"/"//trim(file_output)
      call put_NETCDF_fld(trim(write_file),"TRACER_I_E_NO2_MN", &
      "flux (mol km^-2 hr^-1)",e_no2_ens_mn,nx,ny,nz_chemi)
      call put_NETCDF_fld(trim(write_file),"TRACER_I_E_NO2_SD", &
      "flux (mol km^-2 hr^-1)",e_no2_ens_sd,nx,ny,nz_chemi)
!
! CONUS Spatial statistics E_NO2
      call spatial_mean_and_variance_emiss(e_no2_ens_mn,e_no2_ens_sd, &
      e_no2_conus_mn,e_no2_conus_sd,traceri_conus_ii,traceri_conus_jj, &
      1,nx*ny,num_conus,nx,ny,nz_chemi)
!      print *, 'e_no2_conus_mn TRACER1 ',e_no2_conus_mn(:)
!      print *, 'e_no2_conus_sd TRACER1 ',e_no2_conus_sd(:)
      write_file=trim(path_output)//"/"//trim(file_output)
      call put_NETCDF_fld(trim(write_file),"TRACER_I_E_NO2_CONUS_MN", &
      "flux (mol km^-2 hr^-1)",e_no2_conus_mn,nz_chemi,1,1)
      call put_NETCDF_fld(trim(write_file),"TRACER_I_E_NO2_CONUS_SD", &
      "flux (mol km^-2 hr^-1)",e_no2_conus_sd,nz_chemi,1,1)
!
! TRACER-I URBAN Spatial statistics E_NO2
      call spatial_mean_and_variance_emiss(e_no2_ens_mn,e_no2_ens_sd, &
      e_no2_urban_mn,e_no2_urban_sd,traceri_urban_ii,traceri_urban_jj, &
      num_regions,npts_urban,num_urban,nx,ny,nz_chemi)
!      print *, 'e_no2_urban_mn TRACER1 ',e_no2_urban_mn(:)
!      print *, 'e_no2_urban_sd TRACER1 ',e_no2_urban_sd(:)
      write_file=trim(path_output)//"/"//trim(file_output)
      call put_NETCDF_fld(trim(write_file),"TRACER_I_E_NO2_URBAN_MN", &
      "flux (mol km^-2 hr^-1)",e_no2_urban_mn,nz_chemi,1,1)
      call put_NETCDF_fld(trim(write_file),"TRACER_I_E_NO2_URBAN_SD", &
      "flux (mol km^-2 hr^-1)",e_no2_urban_sd,nz_chemi,1,1)
!
! TRACER-I RURAL Spatial statistics E_NO2
      call spatial_mean_and_variance_emiss(e_no2_ens_mn,e_no2_ens_sd, &
      e_no2_rural_mn,e_no2_rural_sd,traceri_rural_ii,traceri_rural_jj, &
      1,nx*ny,num_rural,nx,ny,nz_chemi)
!      print *, 'e_no2_rural_mn TRACER1 ',e_no2_rural_mn(:)
!      print *, 'e_no2_rural_sd TRACER1 ',e_no2_rural_sd(:)
      write_file=trim(path_output)//"/"//trim(file_output)
      call put_NETCDF_fld(trim(write_file),"TRACER_I_E_NO2_RURAL_MN", &
      "flux (mol km^-2 hr^-1)",e_no2_rural_mn,nz_chemi,1,1)
      call put_NETCDF_fld(trim(write_file),"TRACER_I_E_NO2_RURAL_SD", &
      "flux (mol km^-2 hr^-1)",e_no2_rural_sd,nz_chemi,1,1)     
!
      deallocate(e_no2_ens_mn)    
      deallocate(e_no2_ens_sd)
      deallocate(e_no2_conus_mn)
      deallocate(e_no2_conus_sd)
      deallocate(e_no2_urban_mn)
      deallocate(e_no2_urban_sd)
      deallocate(e_no2_rural_mn)
      deallocate(e_no2_rural_sd)
      print *, '   APM: After process E_NO2'
!
! E_SO2
      print *, '   APM: Before process E_SO2'
      allocate(e_so2_fld(nx,ny,nz_chemi,num_mems))
      allocate(e_so2_conus_mn(nz_chemi),e_so2_conus_sd(nz_chemi))
      allocate(e_so2_urban_mn(nz_chemi),e_so2_urban_sd(nz_chemi))
      allocate(e_so2_rural_mn(nz_chemi),e_so2_rural_sd(nz_chemi))
      do imem=1,num_mems
         if(imem.ge.0.and.imem.lt.10) write(cmem,"('/run_e00',i1)"),imem
         if(imem.ge.10.and.imem.lt.100) write(cmem,"('/run_e0',i2)"),imem
         if(imem.ge.100.and.imem.lt.1000) write(cmem,"('/run_e',i3)"),imem
         read_file=trim(path_input)//trim(cmem)//"/"//trim(wrfchemi_input)
!         print *, 'READ FILE ',imem,trim(read_file)
         call get_WRFCHEM_fld_real(trim(read_file),"E_SO2",e_so2_fld(1,1,1,imem),nx,ny,nz_chemi,1)
      enddo
!      
! Ensemble stats E_SO2
      allocate(e_so2_ens_mn(nx,ny,nz_chemi))
      allocate(e_so2_ens_sd(nx,ny,nz_chemi))
      call ens_stats_emiss(e_so2_fld,e_so2_ens_mn,e_so2_ens_sd,nx,ny,nz_chemi,num_mems)
      deallocate(e_so2_fld)
      write_file=trim(path_output)//"/"//trim(file_output)
      call put_NETCDF_fld(trim(write_file),"TRACER_I_E_SO2_MN", &
      "flux (mol km^-2 hr^-1)",e_so2_ens_mn,nx,ny,nz_chemi)
      call put_NETCDF_fld(trim(write_file),"TRACER_I_E_SO2_SD", &
      "flux (mol km^-2 hr^-1)",e_so2_ens_sd,nx,ny,nz_chemi)
!
! CONUS Spatial statistics E_SO2
      call spatial_mean_and_variance_emiss(e_so2_ens_mn,e_so2_ens_sd, &
      e_so2_conus_mn,e_so2_conus_sd,traceri_conus_ii,traceri_conus_jj, &
      1,nx*ny,num_conus,nx,ny,nz_chemi)
!      print *, 'e_so2_conus_mn TRACER1 ',e_so2_conus_mn(:)
!      print *, 'e_so2_conus_sd TRACER1 ',e_so2_conus_sd(:)
      write_file=trim(path_output)//"/"//trim(file_output)
      call put_NETCDF_fld(trim(write_file),"TRACER_I_E_SO2_CONUS_MN", &
      "flux (mol km^-2 hr^-1)",e_so2_conus_mn,nz_chemi,1,1)
      call put_NETCDF_fld(trim(write_file),"TRACER_I_E_SO2_CONUS_SD", &
      "flux (mol km^-2 hr^-1)",e_so2_conus_sd,nz_chemi,1,1)
!
! TRACER-I URBAN Spatial statistics E_SO2
      call spatial_mean_and_variance_emiss(e_so2_ens_mn,e_so2_ens_sd, &
      e_so2_urban_mn,e_so2_urban_sd,traceri_urban_ii,traceri_urban_jj, &
      num_regions,npts_urban,num_urban,nx,ny,nz_chemi)
!      print *, 'e_so2_urban_mn TRACER1 ',e_so2_urban_mn(:)
!      print *, 'e_so2_urban_sd TRACER1 ',e_so2_urban_sd(:)
      write_file=trim(path_output)//"/"//trim(file_output)
      call put_NETCDF_fld(trim(write_file),"TRACER_I_E_SO2_URBAN_MN", &
      "flux (mol km^-2 hr^-1)",e_so2_urban_mn,nz_chemi,1,1)
      call put_NETCDF_fld(trim(write_file),"TRACER_I_E_SO2_URBAN_SD", &
      "flux (mol km^-2 hr^-1)",e_so2_urban_sd,nz_chemi,1,1)
!
! TRACER-I RURAL Spatial statistics E_SO2
      call spatial_mean_and_variance_emiss(e_so2_ens_mn,e_so2_ens_sd, &
      e_so2_rural_mn,e_so2_rural_sd,traceri_rural_ii,traceri_rural_jj, &
      1,nx*ny,num_rural,nx,ny,nz_chemi)
!      print *, 'e_so2_rural_mn TRACER1 ',e_so2_rural_mn(:)
!      print *, 'e_so2_rural_sd TRACER1 ',e_so2_rural_sd(:)
      write_file=trim(path_output)//"/"//trim(file_output)
      call put_NETCDF_fld(trim(write_file),"TRACER_I_E_SO2_RURAL_MN", &
      "flux (mol km^-2 hr^-1)",e_so2_rural_mn,nz_chemi,1,1)
      call put_NETCDF_fld(trim(write_file),"TRACER_I_E_SO2_RURAL_SD", &
      "flux (mol km^-2 hr^-1)",e_so2_rural_sd,nz_chemi,1,1)     
!
      deallocate(e_so2_ens_mn)    
      deallocate(e_so2_ens_sd)
      deallocate(e_so2_conus_mn)
      deallocate(e_so2_conus_sd)
      deallocate(e_so2_urban_mn)
      deallocate(e_so2_urban_sd)
      deallocate(e_so2_rural_mn)
      deallocate(e_so2_rural_sd)
      print *, '   APM: After process E_SO2'
!
! FIRECHEMI Emissions 
! EBU_IN_CO
      print *, '   APM: Before process EBU_IN_CO'
      allocate(ebu_in_co_fld(nx,ny,nz_fire,num_mems))
      allocate(ebu_in_co_conus_mn(nz_fire),ebu_in_co_conus_sd(nz_fire))
      allocate(ebu_in_co_urban_mn(nz_fire),ebu_in_co_urban_sd(nz_fire))
      allocate(ebu_in_co_rural_mn(nz_fire),ebu_in_co_rural_sd(nz_fire))
      do imem=1,num_mems
         if(imem.ge.0.and.imem.lt.10) write(cmem,"('/run_e00',i1)"),imem
         if(imem.ge.10.and.imem.lt.100) write(cmem,"('/run_e0',i2)"),imem
         if(imem.ge.100.and.imem.lt.1000) write(cmem,"('/run_e',i3)"),imem
         read_file=trim(path_input)//trim(cmem)//"/"//trim(wrffirechemi_input)
!         print *, 'READ FILE ',imem,trim(read_file)
         call get_WRFCHEM_fld_real(trim(read_file),"ebu_in_co",ebu_in_co_fld(1,1,1,imem),nx,ny,nz_fire,1)
      enddo
!      
! Ensemble stats EBU_IN_CO
      allocate(ebu_in_co_ens_mn(nx,ny,nz_fire))
      allocate(ebu_in_co_ens_sd(nx,ny,nz_fire))
      call ens_stats_emiss(ebu_in_co_fld,ebu_in_co_ens_mn,ebu_in_co_ens_sd,nx,ny,nz_fire,num_mems)
      deallocate(ebu_in_co_fld)
      write_file=trim(path_output)//"/"//trim(file_output)
      call put_NETCDF_fld(trim(write_file),"TRACER_I_EBU_IN_CO_MN", &
      "flux (mol km^-2 hr^-1)",ebu_in_co_ens_mn,nx,ny,nz_fire)
      call put_NETCDF_fld(trim(write_file),"TRACER_I_EBU_IN_CO_SD", &
      "flux (mol km^-2 hr^-1)",ebu_in_co_ens_sd,nx,ny,nz_fire)
!
! CONUS Spatial statistics EBU_IN_CO
      call spatial_mean_and_variance_emiss(ebu_in_co_ens_mn,ebu_in_co_ens_sd, &
      ebu_in_co_conus_mn,ebu_in_co_conus_sd,traceri_conus_ii,traceri_conus_jj, &
      1,nx*ny,num_conus,nx,ny,nz_fire)
!      print *, 'ebu_in_co_conus_mn TRACER1 ',ebu_in_co_conus_mn(:)
!      print *, 'ebu_in_co_conus_sd TRACER1 ',ebu_in_co_conus_sd(:)
      write_file=trim(path_output)//"/"//trim(file_output)
      call put_NETCDF_fld(trim(write_file),"TRACER_I_EBU_IN_CO_CONUS_MN", &
      "flux (mol km^-2 hr^-1)",ebu_in_co_conus_mn,nz_fire,1,1)
      call put_NETCDF_fld(trim(write_file),"TRACER_I_EBU_IN_CO_CONUS_SD", &
      "flux (mol km^-2 hr^-1)",ebu_in_co_conus_sd,nz_fire,1,1)
!
! TRACER-I URBAN Spatial statistics EBU_IN_CO
      call spatial_mean_and_variance_emiss(ebu_in_co_ens_mn,ebu_in_co_ens_sd, &
      ebu_in_co_urban_mn,ebu_in_co_urban_sd,traceri_urban_ii,traceri_urban_jj, &
      num_regions,npts_urban,num_urban,nx,ny,nz_fire)
!      print *, 'ebu_in_co_urban_mn TRACER1 ',ebu_in_co_urban_mn(:)
!      print *, 'ebu_in_co_urban_sd TRACER1 ',ebu_in_co_urban_sd(:)
      write_file=trim(path_output)//"/"//trim(file_output)
      call put_NETCDF_fld(trim(write_file),"TRACER_I_EBU_IN_CO_URBAN_MN", &
      "flux (mol km^-2 hr^-1)",ebu_in_co_urban_mn,nz_fire,1,1)
      call put_NETCDF_fld(trim(write_file),"TRACER_I_EBU_IN_CO_URBAN_SD", &
      "flux (mol km^-2 hr^-1)",ebu_in_co_urban_sd,nz_fire,1,1)
!
! TRACER-I RURAL Spatial statistics EBU_IN_CO
      call spatial_mean_and_variance_emiss(ebu_in_co_ens_mn,ebu_in_co_ens_sd, &
      ebu_in_co_rural_mn,ebu_in_co_rural_sd,traceri_rural_ii,traceri_rural_jj, &
      1,nx*ny,num_rural,nx,ny,nz_fire)
!      print *, 'ebu_in_co_rural_mn TRACER1 ',ebu_in_co_rural_mn(:)
!      print *, 'ebu_in_co_rural_sd TRACER1 ',ebu_in_co_rural_sd(:)
      write_file=trim(path_output)//"/"//trim(file_output)
      call put_NETCDF_fld(trim(write_file),"TRACER_I_EBU_IN_CO_RURAL_MN", &
      "flux (mol km^-2 hr^-1)",ebu_in_co_rural_mn,nz_fire,1,1)
      call put_NETCDF_fld(trim(write_file),"TRACER_I_EBU_IN_CO_RURAL_SD", &
      "flux (mol km^-2 hr^-1)",ebu_in_co_rural_sd,nz_fire,1,1)     
      deallocate(ebu_in_co_ens_mn)    
      deallocate(ebu_in_co_ens_sd)
      deallocate(ebu_in_co_conus_mn)
      deallocate(ebu_in_co_conus_sd)
      deallocate(ebu_in_co_urban_mn)
      deallocate(ebu_in_co_urban_sd)
      deallocate(ebu_in_co_rural_mn)
      deallocate(ebu_in_co_rural_sd)
      print *, '   APM: After process EBU_IN_CO'
!
! EBU_IN_NO2
      print *, '   APM: Before process EBU_IN_NO2'
      allocate(ebu_in_no2_fld(nx,ny,nz_fire,num_mems))
      allocate(ebu_in_no2_conus_mn(nz_fire),ebu_in_no2_conus_sd(nz_fire))
      allocate(ebu_in_no2_urban_mn(nz_fire),ebu_in_no2_urban_sd(nz_fire))
      allocate(ebu_in_no2_rural_mn(nz_fire),ebu_in_no2_rural_sd(nz_fire))
      do imem=1,num_mems
         if(imem.ge.0.and.imem.lt.10) write(cmem,"('/run_e00',i1)"),imem
         if(imem.ge.10.and.imem.lt.100) write(cmem,"('/run_e0',i2)"),imem
         if(imem.ge.100.and.imem.lt.1000) write(cmem,"('/run_e',i3)"),imem
         read_file=trim(path_input)//trim(cmem)//"/"//trim(wrffirechemi_input)
!         print *, 'READ FILE ',imem,trim(read_file)
         call get_WRFCHEM_fld_real(trim(read_file),"ebu_in_no2",ebu_in_no2_fld(1,1,1,imem),nx,ny,nz_fire,1)
      enddo
!      
! Ensemble stats EBU_IN_NO2
      allocate(ebu_in_no2_ens_mn(nx,ny,nz_fire))
      allocate(ebu_in_no2_ens_sd(nx,ny,nz_fire))
      call ens_stats_emiss(ebu_in_no2_fld,ebu_in_no2_ens_mn,ebu_in_no2_ens_sd,nx,ny,nz_fire,num_mems)
      deallocate(ebu_in_no2_fld)
      write_file=trim(path_output)//"/"//trim(file_output)
      call put_NETCDF_fld(trim(write_file),"TRACER_I_EBU_IN_NO2_MN", &
      "flux (mol km^-2 hr^-1)",ebu_in_no2_ens_mn,nx,ny,nz_fire)
      call put_NETCDF_fld(trim(write_file),"TRACER_I_EBU_IN_NO2_SD", &
      "flux (mol km^-2 hr^-1)",ebu_in_no2_ens_sd,nx,ny,nz_fire)
!
! CONUS Spatial statistics EBU_IN_NO2
      call spatial_mean_and_variance_emiss(ebu_in_no2_ens_mn,ebu_in_no2_ens_sd, &
      ebu_in_no2_conus_mn,ebu_in_no2_conus_sd,traceri_conus_ii,traceri_conus_jj, &
      1,nx*ny,num_conus,nx,ny,nz_fire)
      print *, 'ebu_in_no2_conus_mn TRACER1 ',ebu_in_no2_conus_mn(:)
      print *, 'ebu_in_no2_conus_sd TRACER1 ',ebu_in_no2_conus_sd(:)
      write_file=trim(path_output)//"/"//trim(file_output)
      call put_NETCDF_fld(trim(write_file),"TRACER_I_EBU_IN_NO2_CONUS_MN", &
      "flux (mol km^-2 hr^-1)",ebu_in_no2_conus_mn,nz_fire,1,1)
      call put_NETCDF_fld(trim(write_file),"TRACER_I_EBU_IN_NO2_CONUS_SD", &
      "flux (mol km^-2 hr^-1)",ebu_in_no2_conus_sd,nz_fire,1,1)
!
! TRACER-I URBAN Spatial statistics EBU_IN_NO2
      call spatial_mean_and_variance_emiss(ebu_in_no2_ens_mn,ebu_in_no2_ens_sd, &
      ebu_in_no2_urban_mn,ebu_in_no2_urban_sd,traceri_urban_ii,traceri_urban_jj, &
      num_regions,npts_urban,num_urban,nx,ny,nz_fire)
      print *, 'ebu_in_no2_urban_mn TRACER1 ',ebu_in_no2_urban_mn(:)
      print *, 'ebu_in_no2_urban_sd TRACER1 ',ebu_in_no2_urban_sd(:)
      write_file=trim(path_output)//"/"//trim(file_output)
      call put_NETCDF_fld(trim(write_file),"TRACER_I_EBU_IN_NO2_URBAN_MN", &
      "flux (mol km^-2 hr^-1)",ebu_in_no2_urban_mn,nz_fire,1,1)
      call put_NETCDF_fld(trim(write_file),"TRACER_I_EBU_IN_NO2_URBAN_SD", &
      "flux (mol km^-2 hr^-1)",ebu_in_no2_urban_sd,nz_fire,1,1)
!
! TRACER-I RURAL Spatial statistics EBU_IN_NO2
      call spatial_mean_and_variance_emiss(ebu_in_no2_ens_mn,ebu_in_no2_ens_sd, &
      ebu_in_no2_rural_mn,ebu_in_no2_rural_sd,traceri_rural_ii,traceri_rural_jj, &
      1,nx*ny,num_rural,nx,ny,nz_fire)
      print *, 'ebu_in_no2_rural_mn TRACER1 ',ebu_in_no2_rural_mn(:)
      print *, 'ebu_in_no2_rural_sd TRACER1 ',ebu_in_no2_rural_sd(:)
      write_file=trim(path_output)//"/"//trim(file_output)
      call put_NETCDF_fld(trim(write_file),"TRACER_I_EBU_IN_NO2_RURAL_MN", &
      "flux (mol km^-2 hr^-1)",ebu_in_no2_rural_mn,nz_fire,1,1)
      call put_NETCDF_fld(trim(write_file),"TRACER_I_EBU_IN_NO2_RURAL_SD", &
      "flux (mol km^-2 hr^-1)",ebu_in_no2_rural_sd,nz_fire,1,1)     
!
      deallocate(ebu_in_no2_ens_mn)    
      deallocate(ebu_in_no2_ens_sd)
      deallocate(ebu_in_no2_conus_mn)
      deallocate(ebu_in_no2_conus_sd)
      deallocate(ebu_in_no2_urban_mn)
      deallocate(ebu_in_no2_urban_sd)
      deallocate(ebu_in_no2_rural_mn)
      deallocate(ebu_in_no2_rural_sd)
      print *, '   APM: After process EBU_IN_NO2'
!
! EBU_IN_SO2
      print *, '   APM: Before process EBU_IN_SO2'
      allocate(ebu_in_so2_fld(nx,ny,nz_fire,num_mems))
      allocate(ebu_in_so2_conus_mn(nz_fire),ebu_in_so2_conus_sd(nz_fire))
      allocate(ebu_in_so2_urban_mn(nz_fire),ebu_in_so2_urban_sd(nz_fire))
      allocate(ebu_in_so2_rural_mn(nz_fire),ebu_in_so2_rural_sd(nz_fire))
      do imem=1,num_mems
         if(imem.ge.0.and.imem.lt.10) write(cmem,"('/run_e00',i1)"),imem
         if(imem.ge.10.and.imem.lt.100) write(cmem,"('/run_e0',i2)"),imem
         if(imem.ge.100.and.imem.lt.1000) write(cmem,"('/run_e',i3)"),imem
         read_file=trim(path_input)//trim(cmem)//"/"//trim(wrffirechemi_input)
!         print *, 'READ FILE ',imem,trim(read_file)
         call get_WRFCHEM_fld_real(trim(read_file),"ebu_in_so2",ebu_in_so2_fld(1,1,1,imem),nx,ny,nz_fire,1)
      enddo
!      
! Ensemble stats EBU_IN_SO2
      allocate(ebu_in_so2_ens_mn(nx,ny,nz_fire))
      allocate(ebu_in_so2_ens_sd(nx,ny,nz_fire))
      call ens_stats_emiss(ebu_in_so2_fld,ebu_in_so2_ens_mn,ebu_in_so2_ens_sd,nx,ny,nz_fire,num_mems)
      deallocate(ebu_in_so2_fld)
      write_file=trim(path_output)//"/"//trim(file_output)
      call put_NETCDF_fld(trim(write_file),"TRACER_I_EBU_IN_SO2_MN", &
      "flux (mol km^-2 hr^-1)",ebu_in_so2_ens_mn,nx,ny,nz_fire)
      call put_NETCDF_fld(trim(write_file),"TRACER_I_EBU_IN_SO2_SD", &
      "flux (mol km^-2 hr^-1)",ebu_in_so2_ens_sd,nx,ny,nz_fire)
!
! CONUS Spatial statistics EBU_IN_SO2
      call spatial_mean_and_variance_emiss(ebu_in_so2_ens_mn,ebu_in_so2_ens_sd, &
      ebu_in_so2_conus_mn,ebu_in_so2_conus_sd,traceri_conus_ii,traceri_conus_jj, &
      1,nx*ny,num_conus,nx,ny,nz_fire)
      print *, 'ebu_in_so2_conus_mn TRACER1 ',ebu_in_so2_conus_mn(:)
      print *, 'ebu_in_so2_conus_sd TRACER1 ',ebu_in_so2_conus_sd(:)
      write_file=trim(path_output)//"/"//trim(file_output)
      call put_NETCDF_fld(trim(write_file),"TRACER_I_EBU_IN_SO2_CONUS_MN", &
      "flux (mol km^-2 hr^-1)",ebu_in_so2_conus_mn,nz_fire,1,1)
      call put_NETCDF_fld(trim(write_file),"TRACER_I_EBU_IN_SO2_CONUS_SD", &
      "flux (mol km^-2 hr^-1)",ebu_in_so2_conus_sd,nz_fire,1,1)
!
! TRACER-I URBAN Spatial statistics EBU_IN_SO2
      call spatial_mean_and_variance_emiss(ebu_in_so2_ens_mn,ebu_in_so2_ens_sd, &
      ebu_in_so2_urban_mn,ebu_in_so2_urban_sd,traceri_urban_ii,traceri_urban_jj, &
      num_regions,npts_urban,num_urban,nx,ny,nz_fire)
      print *, 'ebu_in_so2_urban_mn TRACER1 ',ebu_in_so2_urban_mn(:)
      print *, 'ebu_in_so2_urban_sd TRACER1 ',ebu_in_so2_urban_sd(:)
      write_file=trim(path_output)//"/"//trim(file_output)
      call put_NETCDF_fld(trim(write_file),"TRACER_I_EBU_IN_SO2_URBAN_MN", &
      "flux (mol km^-2 hr^-1)",ebu_in_so2_urban_mn,nz_fire,1,1)
      call put_NETCDF_fld(trim(write_file),"TRACER_I_EBU_IN_SO2_URBAN_SD", &
      "flux (mol km^-2 hr^-1)",ebu_in_so2_urban_sd,nz_fire,1,1)
!
! TRACER-I RURAL Spatial statistics EBU_IN_SO2
      call spatial_mean_and_variance_emiss(ebu_in_so2_ens_mn,ebu_in_so2_ens_sd, &
      ebu_in_so2_rural_mn,ebu_in_so2_rural_sd,traceri_rural_ii,traceri_rural_jj, &
      1,nx*ny,num_rural,nx,ny,nz_fire)
      print *, 'ebu_in_so2_rural_mn TRACER1 ',ebu_in_so2_rural_mn(:)
      print *, 'ebu_in_so2_rural_sd TRACER1 ',ebu_in_so2_rural_sd(:)
      write_file=trim(path_output)//"/"//trim(file_output)
      call put_NETCDF_fld(trim(write_file),"TRACER_I_EBU_IN_SO2_RURAL_MN", &
      "flux (mol km^-2 hr^-1)",ebu_in_so2_rural_mn,nz_fire,1,1)
      call put_NETCDF_fld(trim(write_file),"TRACER_I_EBU_IN_SO2_RURAL_SD", &
      "flux (mol km^-2 hr^-1)",ebu_in_so2_rural_sd,nz_fire,1,1)     
!
      deallocate(ebu_in_so2_ens_mn)    
      deallocate(ebu_in_so2_ens_sd)
      deallocate(ebu_in_so2_conus_mn)
      deallocate(ebu_in_so2_conus_sd)
      deallocate(ebu_in_so2_urban_mn)
      deallocate(ebu_in_so2_urban_sd)
      deallocate(ebu_in_so2_rural_mn)
      deallocate(ebu_in_so2_rural_sd)
      print *, '   APM: After process EBU_IN_SO2'




stop




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
      character*(*)                                       :: file
      character*(*)                                       :: name
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
!
! TRACER-I Ensemble means and spread E_CO, E_NO2, and E_SO2
      rc=nf90_def_var(fid,"TRACER_I_E_CO_MN",NF90_FLOAT,(/x_dimid,y_dimid,z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_E_CO_MN')

      rc=nf90_def_var(fid,"TRACER_I_E_CO_SD",NF90_FLOAT,(/x_dimid,y_dimid,z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_E_CO_SD')
 
      rc=nf90_def_var(fid,"TRACER_I_E_NO2_MN",NF90_FLOAT,(/x_dimid,y_dimid,z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_E_NO2_MN')

      rc=nf90_def_var(fid,"TRACER_I_E_NO2_SD",NF90_FLOAT,(/x_dimid,y_dimid,z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_E_NO2_SD')
 
      rc=nf90_def_var(fid,"TRACER_I_E_SO2_MN",NF90_FLOAT,(/x_dimid,y_dimid,z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_E_SO2_MN')

      rc=nf90_def_var(fid,"TRACER_I_E_SO2_SD",NF90_FLOAT,(/x_dimid,y_dimid,z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_E_SO2_SD')
!
! TRACER-I Ensemble means and spread EBU_IN_CO, EBU_IN_NO2, and EBU_IN_SO2
      rc=nf90_def_var(fid,"TRACER_I_EBU_IN_CO_MN",NF90_FLOAT,(/x_dimid,y_dimid,z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_EBU_IN_CO_MN')

      rc=nf90_def_var(fid,"TRACER_I_EBU_IN_CO_SD",NF90_FLOAT,(/x_dimid,y_dimid,z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_EBU_IN_CO_SD')
 
      rc=nf90_def_var(fid,"TRACER_I_EBU_IN_NO2_MN",NF90_FLOAT,(/x_dimid,y_dimid,z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_EBU_IN_NO2_MN')

      rc=nf90_def_var(fid,"TRACER_I_EBU_IN_NO2_SD",NF90_FLOAT,(/x_dimid,y_dimid,z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_EBU_IN_NO2_SD')
 
      rc=nf90_def_var(fid,"TRACER_I_EBU_IN_SO2_MN",NF90_FLOAT,(/x_dimid,y_dimid,z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_EBU_IN_SO2_MN')

      rc=nf90_def_var(fid,"TRACER_I_EBU_IN_SO2_SD",NF90_FLOAT,(/x_dimid,y_dimid,z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_EBU_IN_SO2_SD')
!
! TRACER-I SPATIAL MN
! E_CO, E_NO2, and E_SO2
      rc=nf90_def_var(fid,"TRACER_I_E_CO_CONUS_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_E_CO_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_E_CO_URBAN_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_E_CO_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_E_CO_RURAL_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_E_CO_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_E_NO2_CONUS_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_E_NO2_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_E_NO2_URBAN_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_E_NO2_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_E_NO2_RURAL_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_E_NO2_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_E_SO2_CONUS_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_E_SO2_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_E_SO2_URBAN_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_E_SO2_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_E_SO2_RURAL_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_E_SO2_RURAL_MN')
!
! TRACER-I SPATIAL MN
! EBU_IN_CO, EBU_IN_NO2, and EBU_IN_SO2
      rc=nf90_def_var(fid,"TRACER_I_EBU_IN_CO_CONUS_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_EBU_IN_CO_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_EBU_IN_CO_URBAN_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_EBU_IN_CO_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_EBU_IN_CO_RURAL_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_EBU_IN_CO_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_EBU_IN_NO2_CONUS_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_EBU_IN_NO2_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_EBU_IN_NO2_URBAN_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_EBU_IN_NO2_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_EBU_IN_NO2_RURAL_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_EBU_IN_NO2_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_EBU_IN_SO2_CONUS_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_EBU_IN_SO2_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_EBU_IN_SO2_URBAN_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_EBU_IN_SO2_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_EBU_IN_SO2_RURAL_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_EBU_IN_SO2_RURAL_MN')
!
! TRACER I SPATIAL SD
! E_CO, E_NO2, and E_SO2      
      rc=nf90_def_var(fid,"TRACER_I_E_CO_CONUS_SD",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_E_CO_CONUS_SD')

      rc=nf90_def_var(fid,"TRACER_I_E_CO_URBAN_SD",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_E_CO_CONUS_SD')

      rc=nf90_def_var(fid,"TRACER_I_E_CO_RURAL_SD",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_E_CO_CONUS_SD')

      rc=nf90_def_var(fid,"TRACER_I_E_NO2_CONUS_SD",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_E_NO2_CONUS_SD')

      rc=nf90_def_var(fid,"TRACER_I_E_NO2_URBAN_SD",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_E_NO2_URBAN_SD')

      rc=nf90_def_var(fid,"TRACER_I_E_NO2_RURAL_SD",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_E_NO2_RURAL_SD')

      rc=nf90_def_var(fid,"TRACER_I_E_SO2_CONUS_SD",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_E_SO2_CONUS_SD')

      rc=nf90_def_var(fid,"TRACER_I_E_SO2_URBAN_SD",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_E_SO2_URBAN_SD')

      rc=nf90_def_var(fid,"TRACER_I_E_SO2_RURAL_SD",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_E_SO2_RURAL_SD')
!
! TRACER I SPATIAL SD
! EBU_IN_CO, EBU_IN_NO2, and EBU_IN_SO2      
      rc=nf90_def_var(fid,"TRACER_I_EBU_IN_CO_CONUS_SD",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_EBU_IN_CO_CONUS_SD')

      rc=nf90_def_var(fid,"TRACER_I_EBU_IN_CO_URBAN_SD",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_EBU_IN_CO_CONUS_SD')

      rc=nf90_def_var(fid,"TRACER_I_EBU_IN_CO_RURAL_SD",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_EBU_IN_CO_CONUS_SD')

      rc=nf90_def_var(fid,"TRACER_I_EBU_IN_NO2_CONUS_SD",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_EBU_IN_NO2_CONUS_SD')

      rc=nf90_def_var(fid,"TRACER_I_EBU_IN_NO2_URBAN_SD",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_EBU_IN_NO2_URBAN_SD')

      rc=nf90_def_var(fid,"TRACER_I_EBU_IN_NO2_RURAL_SD",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_EBU_IN_NO2_RURAL_SD')

      rc=nf90_def_var(fid,"TRACER_I_EBU_IN_SO2_CONUS_SD",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_EBU_IN_SO2_CONUS_SD')

      rc=nf90_def_var(fid,"TRACER_I_EBU_IN_SO2_URBAN_SD",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_EBU_IN_SO2_URBAN_SD')

      rc=nf90_def_var(fid,"TRACER_I_EBU_IN_SO2_RURAL_SD",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_EBU_IN_SO2_RURAL_SD')
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

   subroutine ens_stats_emiss(fld,fld_ens_mn,fld_ens_sd,nx,ny,nz,num_mems)
      implicit none
      integer                           :: i,j,k,imem,nx,ny,nz,num_mems
      integer,dimension(nx,ny,nz)       :: ncnt
      real,dimension(nx,ny,nz)          :: fld_ens_mn,fld_ens_vr,fld_ens_sd
      real,dimension(nx,ny,nz,num_mems) :: fld
!
      fld_ens_mn(:,:,:)=0.
      fld_ens_vr(:,:,:)=0.
      fld_ens_sd(:,:,:)=0.
      ncnt(:,:,:)=0
      do i=1,nx
         do j=1,ny
            do k=1,nz
               do imem=1,num_mems
                  if(fld(i,j,k,imem).gt.0.) then
                     ncnt(i,j,k)=ncnt(i,j,k)+1
                     fld_ens_mn(i,j,k)=fld_ens_mn(i,j,k)+fld(i,j,k,imem)
                  endif
               enddo
            enddo
         enddo
      enddo
      do i=1,nx
         do j=1,ny
            do k=1,nz
               if(ncnt(i,j,k).gt.0.) then
                  fld_ens_mn(i,j,k)=fld_ens_mn(i,j,k)/real(ncnt(i,j,k))
               endif
            enddo
         enddo
      enddo
!
      ncnt(:,:,:)=0
      do i=1,nx
         do j=1,ny
            do k=1,nz
               do imem=1,num_mems
                  if(fld(i,j,k,imem).gt.0.) then
                     ncnt(i,j,k)=ncnt(i,j,k)+1
                     fld_ens_vr(i,j,k)=fld_ens_vr(i,j,k)+((fld(i,j,k,imem)- &
                     fld_ens_mn(i,j,k))**2)
                  endif
               enddo
            enddo
         enddo
      enddo
      do i=1,nx
         do j=1,ny
            do k=1,nz
               if(ncnt(i,j,k).gt.1) then
                  fld_ens_vr(i,j,k)=fld_ens_vr(i,j,k)/real(ncnt(i,j,k)-1)
               endif
            enddo
         enddo
      enddo
!
      fld_ens_sd(:,:,:)=sqrt(fld_ens_vr(:,:,:))
      return
   end subroutine ens_stats_emiss

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

   subroutine spatial_mean_and_variance_emiss(fld_ens_mn,fld_ens_sd,fld_region_mn,fld_region_sd,fld_region_ii, &
   fld_region_jj,num_region,npts_region,npts_mdl_region,nx,ny,nz)
      implicit none
      integer                                         :: i,j,k,irgn,ipt
      integer                                         :: nx,ny,nz,num_region,npts_region
      integer,dimension(num_region)                   :: npts_mdl_region
      integer,dimension(num_region,npts_region)       :: fld_region_ii,fld_region_jj
      real                                            :: wt_mn,wt_vr
      real,dimension(nz)                              :: zwt_mn,zwt_vr
      real,dimension(nz)                              :: fld_region_mn,fld_region_vr,fld_region_sd
      real,dimension(nx,ny,nz)                        :: fld_ens_mn,fld_ens_vr,fld_ens_sd
!
      fld_region_mn(:)=0.
      fld_region_vr(:)=0.
      fld_region_sd(:)=0.
!
      zwt_mn(:)=0.
      zwt_vr(:)=0.
      do irgn=1,num_region
         do ipt=1,npts_mdl_region(irgn)
            i=fld_region_ii(irgn,ipt)
            j=fld_region_jj(irgn,ipt)
            wt_mn=1.
            do k=1,nz
               if(fld_ens_mn(i,j,k).gt.0.) then
                  fld_region_mn(k)=fld_region_mn(k)+wt_mn*fld_ens_mn(i,j,k)
                  zwt_mn(k)=zwt_mn(k)+wt_mn
               endif
            enddo
            wt_vr=1.
            do k=1,nz
               if(fld_ens_vr(i,j,k).gt.0.) then
                  fld_region_vr(k)=fld_region_vr(k)+wt_vr*(fld_ens_sd(i,j,k)**2)
                  zwt_vr(k)=zwt_vr(k)+wt_vr
               endif
            enddo
         enddo
      enddo
      do k=1,nz
         if(zwt_mn(k).gt.0) then
            fld_region_mn(k)=fld_region_mn(k)/zwt_mn(k)
         endif
         if(zwt_vr(k).gt.0) then
            fld_region_vr(k)=fld_region_vr(k)/(zwt_vr(k))
         endif
         fld_region_sd(k)=sqrt(fld_region_vr(k))
      enddo
   end subroutine spatial_mean_and_variance_emiss

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
            fld_region_vr(irgn,k)=fld_region_vr(irgn,k)/(zwt(irgn,k)-1)
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

