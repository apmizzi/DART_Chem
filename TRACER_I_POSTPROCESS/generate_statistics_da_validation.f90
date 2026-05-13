  program main
      implicit none
!
      integer,parameter                               :: nnum_mems=30      
      integer,parameter                               :: max_nobs=100000      
      integer                                         :: i,j,k,ipt,conus_stpts,urban_stpts,rural_stpts
      integer                                         :: nx,ny,nz,num_mems,nz_chemi,nz_fire,icnt,ipt1,ipt2
      integer                                         :: npts_conus,npts_urban,npts_rural,icty,iskip
      integer                                         :: num_conus,num_rural,num_cities
      integer                                         :: unit,date_traceri
      integer                                         :: yyyy_traceri,mm_traceri,dd_traceri,hh_traceri
      integer,allocatable,dimension(:)                :: num_urban
      integer,allocatable,dimension(:)                :: traceri_conus_ii,traceri_conus_jj
      integer,allocatable,dimension(:)                :: traceri_rural_ii,traceri_rural_jj
      integer,allocatable,dimension(:,:)              :: traceri_urban_ii,traceri_urban_jj
      real                                            :: p_lay_top,p_lay_bot
      real,allocatable,dimension(:,:)                 :: traceri_lon,traceri_lat
!
! RADIOSONE T
      integer                                         :: rads_t_sav
      integer,dimension(max_nobs)                     :: rads_t_i,rads_t_j
      real                                            :: rads_t_mn_trc,rads_t_mn_obs
      real                                            :: rads_t_vr_trc,rads_t_vr_obs
      real                                            :: rads_t_nmb,rads_t_rmse,rads_t_rcor
      real,dimension(max_nobs)                        :: rads_t_lon,rads_t_lat,rads_t_vert
      real,dimension(max_nobs)                        :: rads_t_val,rads_t_err,rads_t_prior_mn
      real,dimension(max_nobs)                        :: rads_t_post_mn,rads_t_prior_sd
      real,dimension(max_nobs)                        :: rads_t_post_sd
      real,dimension(max_nobs,nnum_mems)              :: rads_t_prior_mem,rads_t_post_mem
!
! RADIOSONE U
      integer                                         :: rads_u_sav
      integer,dimension(max_nobs)                     :: rads_u_i,rads_u_j
      real                                            :: rads_u_mn_trc,rads_u_mn_obs
      real                                            :: rads_u_vr_trc,rads_u_vr_obs
      real                                            :: rads_u_nmb,rads_u_rmse,rads_u_rcor
      real,dimension(max_nobs)                        :: rads_u_lon,rads_u_lat,rads_u_vert
      real,dimension(max_nobs)                        :: rads_u_val,rads_u_err,rads_u_prior_mn
      real,dimension(max_nobs)                        :: rads_u_post_mn,rads_u_prior_sd
      real,dimension(max_nobs)                        :: rads_u_post_sd
      real,dimension(max_nobs,nnum_mems)              :: rads_u_prior_mem,rads_u_post_mem
!
! RADIOSONE V
      integer                                         :: rads_v_sav
      integer,dimension(max_nobs)                     :: rads_v_i,rads_v_j
      real                                            :: rads_v_mn_trc,rads_v_mn_obs
      real                                            :: rads_v_vr_trc,rads_v_vr_obs
      real                                            :: rads_v_nmb,rads_v_rmse,rads_v_rcor
      real,dimension(max_nobs)                        :: rads_v_lon,rads_v_lat,rads_v_vert
      real,dimension(max_nobs)                        :: rads_v_val,rads_v_err,rads_v_prior_mn
      real,dimension(max_nobs)                        :: rads_v_post_mn,rads_v_prior_sd
      real,dimension(max_nobs)                        :: rads_v_post_sd
      real,dimension(max_nobs,nnum_mems)              :: rads_v_prior_mem,rads_v_post_mem
!
! RADIOSONE Q
      integer                                         :: rads_q_sav
      integer,dimension(max_nobs)                     :: rads_q_i,rads_q_j
      real                                            :: rads_q_mn_trc,rads_q_mn_obs
      real                                            :: rads_q_vr_trc,rads_q_vr_obs
      real                                            :: rads_q_nmb,rads_q_rmse,rads_q_rcor
      real,dimension(max_nobs)                        :: rads_q_lon,rads_q_lat,rads_q_vert
      real,dimension(max_nobs)                        :: rads_q_val,rads_q_err,rads_q_prior_mn
      real,dimension(max_nobs)                        :: rads_q_post_mn,rads_q_prior_sd
      real,dimension(max_nobs)                        :: rads_q_post_sd
      real,dimension(max_nobs,nnum_mems)              :: rads_q_prior_mem,rads_q_post_mem
!
! AIRNOW CO
      integer                                         :: airn_co_sav
      integer,dimension(max_nobs)                     :: airn_co_i,airn_co_j
      real                                            :: airn_co_mn_trc,airn_co_mn_obs
      real                                            :: airn_co_vr_trc,airn_co_vr_obs
      real                                            :: airn_co_nmb,airn_co_rmse,airn_co_rcor
      real,dimension(max_nobs)                        :: airn_co_lon,airn_co_lat,airn_co_vert
      real,dimension(max_nobs)                        :: airn_co_val,airn_co_err,airn_co_prior_mn
      real,dimension(max_nobs)                        :: airn_co_post_mn,airn_co_prior_sd
      real,dimension(max_nobs)                        :: airn_co_post_sd
      real,dimension(max_nobs,nnum_mems)              :: airn_co_prior_mem,airn_co_post_mem
!
! AIRNOW O3
      integer                                         :: airn_o3_sav
      integer,dimension(max_nobs)                     :: airn_o3_i,airn_o3_j
      real                                            :: airn_o3_mn_trc,airn_o3_mn_obs
      real                                            :: airn_o3_vr_trc,airn_o3_vr_obs
      real                                            :: airn_o3_nmb,airn_o3_rmse,airn_o3_rcor
      real,dimension(max_nobs)                        :: airn_o3_lon,airn_o3_lat,airn_o3_vert
      real,dimension(max_nobs)                        :: airn_o3_val,airn_o3_err,airn_o3_prior_mn
      real,dimension(max_nobs)                        :: airn_o3_post_mn,airn_o3_prior_sd
      real,dimension(max_nobs)                        :: airn_o3_post_sd
      real,dimension(max_nobs,nnum_mems)              :: airn_o3_prior_mem,airn_o3_post_mem
!
! AIRNOW NO2
      integer                                         :: airn_no2_sav
      integer,dimension(max_nobs)                     :: airn_no2_i,airn_no2_j
      real                                            :: airn_no2_mn_trc,airn_no2_mn_obs
      real                                            :: airn_no2_vr_trc,airn_no2_vr_obs
      real                                            :: airn_no2_nmb,airn_no2_rmse,airn_no2_rcor
      real,dimension(max_nobs)                        :: airn_no2_lon,airn_no2_lat,airn_no2_vert
      real,dimension(max_nobs)                        :: airn_no2_val,airn_no2_err,airn_no2_prior_mn
      real,dimension(max_nobs)                        :: airn_no2_post_mn,airn_no2_prior_sd
      real,dimension(max_nobs)                        :: airn_no2_post_sd
      real,dimension(max_nobs,nnum_mems)              :: airn_no2_prior_mem,airn_no2_post_mem
!
! AIRNOW SO2
      integer                                         :: airn_so2_sav
      integer,dimension(max_nobs)                     :: airn_so2_i,airn_so2_j
      real                                            :: airn_so2_mn_trc,airn_so2_mn_obs
      real                                            :: airn_so2_vr_trc,airn_so2_vr_obs
      real                                            :: airn_so2_nmb,airn_so2_rmse,airn_so2_rcor
      real,dimension(max_nobs)                        :: airn_so2_lon,airn_so2_lat,airn_so2_vert
      real,dimension(max_nobs)                        :: airn_so2_val,airn_so2_err,airn_so2_prior_mn
      real,dimension(max_nobs)                        :: airn_so2_post_mn,airn_so2_prior_sd
      real,dimension(max_nobs)                        :: airn_so2_post_sd
      real,dimension(max_nobs,nnum_mems)              :: airn_so2_prior_mem,airn_so2_post_mem
!
      character(len=200)                              :: file_strat_interp_map
      character(len=200)                              :: file_input_obs_seq_final
      character(len=200)                              :: file_input_prior_mn
      character(len=200)                              :: file_read_obs_seq_final
      character(len=200)                              :: file_read_prior_mn
      character(len=200)                              :: path_input,path_output,file_output
      character(len=200)                              :: file_read,file_write,file_strats
!
      namelist/ens_da_validation/date_traceri,path_input,path_output,file_strats, &
      file_input_obs_seq_final,file_input_prior_mn,file_output,nx,ny,nz,num_mems
!
      file_strat_interp_map="TRACER_I_Stratifications_Data"
      nx=440
      ny=284
      nz=50
      npts_conus=124960
      npts_urban=200
      npts_rural=124960
      num_cities=29
      p_lay_bot=103000.
      p_lay_top=95000.
!
      unit=20
      open(unit=unit,file="ens_da_validation.nl",form="formatted", &
      status="old",action="read")
      rewind(unit)
      read(unit,ens_da_validation)
      close(unit)
!
!      print *, "NAMELIST: ens_da_diagnostics"
!      print *,"date traceri ",              date_traceri
!      print *,"path input ",                trim(path_input)
!      print *,"path output ",               trim(path_output)
!      print *,"file_input_obs_seq_final ",  trim(file_input_obs_seq_final)
!      print *,"file_input_prior_mn ",       trim(file_input_prior_mn)
!      print *,"file output ",               trim(file_output)
!      print *,"nx ",                        nx
!      print *,"ny ",                        ny
!      print *,"nz ",                        nz
!      print *,"num_mems ",                  num_mems
      yyyy_traceri=date_traceri/1000000
      mm_traceri=(date_traceri-yyyy_traceri*1000000)/10000
      dd_traceri=(date_traceri-yyyy_traceri*1000000-mm_traceri*10000)/100
      hh_traceri=date_traceri-yyyy_traceri*1000000-mm_traceri*10000-dd_traceri*100
!
! Get TRACER-I lon and lat
      allocate(traceri_lon(nx,ny))      
      allocate(traceri_lat(nx,ny))      
      file_read_prior_mn=trim(path_input)//"/"//trim(file_input_prior_mn)
!      print *, 'READ FILE ',trim(file_read_prior_mn)
      call get_WRFCHEM_fld_real(trim(file_read_prior_mn),"XLONG",traceri_lon,nx,ny,1,1)
      call get_WRFCHEM_fld_real(trim(file_read_prior_mn),"XLAT",traceri_lat,nx,ny,1,1)
!
! Read stratifications and interpolation mappings data
! TRACER I
      allocate(traceri_conus_ii(npts_conus))
      allocate(traceri_conus_jj(npts_conus))
!      print *, 'STRAT FILE ',trim(file_strat_interp_map)
      call get_WRFCHEM_fld_int(trim(file_strat_interp_map),"NUM_TRACER_I_CONUS",num_conus,1,1,1,1)
      call get_WRFCHEM_fld_int(trim(file_strat_interp_map),"TRACER_I_CONUS_II",traceri_conus_ii, &
      npts_conus,1,1,1)
      call get_WRFCHEM_fld_int(trim(file_strat_interp_map),"TRACER_I_CONUS_JJ",traceri_conus_jj, &
      npts_conus,1,1,1)
      allocate(num_urban(num_cities))
      allocate(traceri_urban_ii(num_cities,npts_urban))
      allocate(traceri_urban_jj(num_cities,npts_urban))
      call get_WRFCHEM_fld_int(trim(file_strat_interp_map),"NUM_TRACER_I_URBAN",num_urban,num_cities,1,1,1)
      call get_WRFCHEM_fld_int(trim(file_strat_interp_map),"TRACER_I_URBAN_II",traceri_urban_ii, &
      num_cities,npts_urban,1,1)
      call get_WRFCHEM_fld_int(trim(file_strat_interp_map),"TRACER_I_URBAN_JJ",traceri_urban_jj, &
      num_cities,npts_urban,1,1)
      allocate(traceri_rural_ii(npts_rural))
      allocate(traceri_rural_jj(npts_rural))
      call get_WRFCHEM_fld_int(trim(file_strat_interp_map),"NUM_TRACER_I_RURAL",num_rural,1,1,1,1)
      call get_WRFCHEM_fld_int(trim(file_strat_interp_map),"TRACER_I_RURAL_II",traceri_rural_ii, &
      npts_rural,1,1,1)
      call get_WRFCHEM_fld_int(trim(file_strat_interp_map),"TRACER_I_RURAL_JJ",traceri_rural_jj, &
      npts_rural,1,1,1)
!
! Create output NETCDF file
      file_write=trim(path_output)//"/"//trim(file_output)
!      print *, 'WRITE FILE  ',trim(file_write)
      call create_NETCDF_file(trim(file_write),nx,ny,nz)
!
! Read validation data from DART obs_sequence file
      file_read_obs_seq_final=trim(path_input)//"/"//trim(file_input_obs_seq_final)
!      print *, 'READ FILE ',trim(file_read_obs_seq_final)
!
! RADIOSONDE T
      call get_obs_seq_ens(file_read_obs_seq_final,'RADIOSONDE_TEMPERATURE', &
      max_nobs,num_mems,rads_t_sav,rads_t_lon,rads_t_lat,rads_t_vert,rads_t_val, &
      rads_t_err,rads_t_prior_mn,rads_t_post_mn,rads_t_prior_sd,rads_t_post_sd, &
      rads_t_prior_mem,rads_t_post_mem)
      call get_platform_i_j(rads_t_i,rads_t_j,rads_t_lon,rads_t_lat,max_nobs,rads_t_sav, &
      traceri_lon,traceri_lat,nx,ny)
!
      call conus_ens_mn_skill_metrics(rads_t_mn_trc,rads_t_mn_obs,rads_t_vr_trc,rads_t_vr_obs, &
      rads_t_nmb,rads_t_rmse,rads_t_rcor,traceri_conus_ii,traceri_conus_jj,num_conus,rads_t_post_mn, &
      rads_t_val,rads_t_i,rads_t_j,rads_t_sav,rads_t_vert,p_lay_bot,p_lay_top,conus_stpts, &
      max_nobs,npts_conus)
      print *, ' '
      print *, 'T TRC MN   ',rads_t_mn_trc
      print *, 'OBS MN   ',rads_t_mn_obs
      print *, 'TRC VR   ',rads_t_vr_trc
      print *, 'OBS VR   ',rads_t_vr_obs
      print *, 'NMB      ',rads_t_nmb
      print *, 'RMSE     ',rads_t_rmse
      print *, 'RCOR     ',rads_t_rcor
      print *, 'NPTS     ',conus_stpts
      call put_NETCDF_fld(trim(file_write),"RADS_T_CONUS_MN_ENS_MN","scalar",rads_t_mn_trc,1,1,1)
      call put_NETCDF_fld(trim(file_write),"RADS_T_CONUS_MN_OBS_VAL","scalar",rads_t_mn_obs,1,1,1)
      call put_NETCDF_fld(trim(file_write),"RADS_T_CONUS_VR_ENS_MN","scalar",rads_t_vr_trc,1,1,1)
      call put_NETCDF_fld(trim(file_write),"RADS_T_CONUS_VR_OBS_VAL","scalar",rads_t_vr_obs,1,1,1)
      call put_NETCDF_fld(trim(file_write),"RADS_T_CONUS_NMB_ENS_MN","scalar",rads_t_nmb,1,1,1)
      call put_NETCDF_fld(trim(file_write),"RADS_T_CONUS_RMSE_ENS_MN","scalar",rads_t_rmse,1,1,1)
      call put_NETCDF_fld(trim(file_write),"RADS_T_CONUS_RCOR_ENS_MN","scalar",rads_t_rcor,1,1,1)
      call put_NETCDF_fld(trim(file_write),"RADS_T_CONUS_MN_NPTS","scalar",conus_stpts,1,1,1)
!
      call urban_ens_mn_skill_metrics(rads_t_mn_trc,rads_t_mn_obs,rads_t_vr_trc,rads_t_vr_obs, &
      rads_t_nmb,rads_t_rmse,rads_t_rcor,traceri_urban_ii,traceri_urban_jj,num_urban,rads_t_post_mn, &
      rads_t_val,rads_t_i,rads_t_j,rads_t_sav,rads_t_vert,p_lay_bot,p_lay_top,urban_stpts, &
      max_nobs,npts_urban,num_cities)
      print *, ' '
      print *, 'T TRC MN   ',rads_t_mn_trc
      print *, 'OBS MN   ',rads_t_mn_obs
      print *, 'TRC VR   ',rads_t_vr_trc
      print *, 'OBS VR   ',rads_t_vr_obs
      print *, 'NMB      ',rads_t_nmb
      print *, 'RMSE     ',rads_t_rmse
      print *, 'RCOR     ',rads_t_rcor
      print *, 'NPTS     ',urban_stpts
      call put_NETCDF_fld(trim(file_write),"RADS_T_URBAN_MN_ENS_MN","scalar",rads_t_mn_trc,1,1,1)
      call put_NETCDF_fld(trim(file_write),"RADS_T_URBAN_MN_OBS_VAL","scalar",rads_t_mn_obs,1,1,1)
      call put_NETCDF_fld(trim(file_write),"RADS_T_URBAN_VR_ENS_MN","scalar",rads_t_vr_trc,1,1,1)
      call put_NETCDF_fld(trim(file_write),"RADS_T_URBAN_VR_OBS_VAL","scalar",rads_t_vr_obs,1,1,1)
      call put_NETCDF_fld(trim(file_write),"RADS_T_URBAN_NMB_ENS_MN","scalar",rads_t_nmb,1,1,1)
      call put_NETCDF_fld(trim(file_write),"RADS_T_URBAN_RMSE_ENS_MN","scalar",rads_t_rmse,1,1,1)
      call put_NETCDF_fld(trim(file_write),"RADS_T_URBAN_RCOR_ENS_MN","scalar",rads_t_rcor,1,1,1)
      call put_NETCDF_fld(trim(file_write),"RADS_T_URBAN_MN_NPTS","scalar",urban_stpts,1,1,1)
!      
      call rural_ens_mn_skill_metrics(rads_t_mn_trc,rads_t_mn_obs,rads_t_vr_trc,rads_t_vr_obs, &
      rads_t_nmb,rads_t_rmse,rads_t_rcor,traceri_rural_ii,traceri_rural_jj,num_rural,rads_t_post_mn, &
      rads_t_val,rads_t_i,rads_t_j,rads_t_sav,rads_t_vert,p_lay_bot,p_lay_top,rural_stpts, &
      max_nobs,npts_rural)
      print *, ' '
      print *, 'T TRC MN   ',rads_t_mn_trc
      print *, 'OBS MN   ',rads_t_mn_obs
      print *, 'TRC VR   ',rads_t_vr_trc
      print *, 'OBS VR   ',rads_t_vr_obs
      print *, 'NMB      ',rads_t_nmb
      print *, 'RMSE     ',rads_t_rmse
      print *, 'RCOR     ',rads_t_rcor
      print *, 'NPTS     ',rural_stpts      
      call put_NETCDF_fld(trim(file_write),"RADS_T_RURAL_MN_ENS_MN","scalar",rads_t_mn_trc,1,1,1)
      call put_NETCDF_fld(trim(file_write),"RADS_T_RURAL_MN_OBS_VAL","scalar",rads_t_mn_obs,1,1,1)
      call put_NETCDF_fld(trim(file_write),"RADS_T_RURAL_VR_ENS_MN","scalar",rads_t_vr_trc,1,1,1)
      call put_NETCDF_fld(trim(file_write),"RADS_T_RURAL_VR_OBS_VAL","scalar",rads_t_vr_obs,1,1,1)
      call put_NETCDF_fld(trim(file_write),"RADS_T_RURAL_NMB_ENS_MN","scalar",rads_t_nmb,1,1,1)
      call put_NETCDF_fld(trim(file_write),"RADS_T_RURAL_RMSE_ENS_MN","scalar",rads_t_rmse,1,1,1)
      call put_NETCDF_fld(trim(file_write),"RADS_T_RURAL_RCOR_ENS_MN","scalar",rads_t_rcor,1,1,1)
      call put_NETCDF_fld(trim(file_write),"RADS_T_RURAL_MN_NPTS","scalar",rural_stpts,1,1,1)
!
! RADIOSONDE U
      call get_obs_seq_ens(file_read_obs_seq_final,'RADIOSONDE_U_WIND_COMPONENT', &
      max_nobs,num_mems,rads_u_sav,rads_u_lon,rads_u_lat,rads_u_vert,rads_u_val, &
      rads_u_err,rads_u_prior_mn,rads_u_post_mn,rads_u_prior_sd,rads_u_post_sd, &
      rads_u_prior_mem,rads_u_post_mem)      
      call get_platform_i_j(rads_u_i,rads_u_j,rads_u_lon,rads_u_lat,max_nobs,rads_u_sav, &
      traceri_lon,traceri_lat,nx,ny)
!      
      call conus_ens_mn_skill_metrics(rads_u_mn_trc,rads_u_mn_obs,rads_u_vr_trc,rads_u_vr_obs, &
      rads_u_nmb,rads_u_rmse,rads_u_rcor,traceri_conus_ii,traceri_conus_jj,num_conus,rads_u_post_mn, &
      rads_u_val,rads_u_i,rads_u_j,rads_u_sav,rads_u_vert,p_lay_bot,p_lay_top,conus_stpts, &
      max_nobs,npts_conus)
      print *, ' '
      print *, 'U TRC MN   ',rads_u_mn_trc
      print *, 'OBS MN   ',rads_u_mn_obs
      print *, 'TRC VR   ',rads_u_vr_trc
      print *, 'OBS VR   ',rads_u_vr_obs
      print *, 'NMB      ',rads_u_nmb
      print *, 'RMSE     ',rads_u_rmse
      print *, 'RCOR     ',rads_u_rcor
      print *, 'NPTS     ',conus_stpts
      call put_NETCDF_fld(trim(file_write),"RADS_U_CONUS_MN_ENS_MN","scalar",rads_u_mn_trc,1,1,1)
      call put_NETCDF_fld(trim(file_write),"RADS_U_CONUS_MN_OBS_VAL","scalar",rads_u_mn_obs,1,1,1)
      call put_NETCDF_fld(trim(file_write),"RADS_U_CONUS_VR_ENS_MN","scalar",rads_u_vr_trc,1,1,1)
      call put_NETCDF_fld(trim(file_write),"RADS_U_CONUS_VR_OBS_VAL","scalar",rads_u_vr_obs,1,1,1)
      call put_NETCDF_fld(trim(file_write),"RADS_U_CONUS_NMB_ENS_MN","scalar",rads_u_nmb,1,1,1)
      call put_NETCDF_fld(trim(file_write),"RADS_U_CONUS_RMSE_ENS_MN","scalar",rads_u_rmse,1,1,1)
      call put_NETCDF_fld(trim(file_write),"RADS_U_CONUS_RCOR_ENS_MN","scalar",rads_u_rcor,1,1,1)
      call put_NETCDF_fld(trim(file_write),"RADS_U_CONUS_MN_NPTS","scalar",conus_stpts,1,1,1)
!
      call urban_ens_mn_skill_metrics(rads_u_mn_trc,rads_u_mn_obs,rads_u_vr_trc,rads_u_vr_obs, &
      rads_u_nmb,rads_u_rmse,rads_u_rcor,traceri_urban_ii,traceri_urban_jj,num_urban,rads_u_post_mn, &
      rads_u_val,rads_u_i,rads_u_j,rads_u_sav,rads_u_vert,p_lay_bot,p_lay_top,urban_stpts, &
      max_nobs,npts_urban,num_cities)
      print *, ' '
      print *, 'U TRC MN   ',rads_u_mn_trc
      print *, 'OBS MN   ',rads_u_mn_obs
      print *, 'TRC VR   ',rads_u_vr_trc
      print *, 'OBS VR   ',rads_u_vr_obs
      print *, 'NMB      ',rads_u_nmb
      print *, 'RMSE     ',rads_u_rmse
      print *, 'RCOR     ',rads_u_rcor
      print *, 'NPTS     ',urban_stpts
      call put_NETCDF_fld(trim(file_write),"RADS_U_URBAN_MN_ENS_MN","scalar",rads_u_mn_trc,1,1,1)
      call put_NETCDF_fld(trim(file_write),"RADS_U_URBAN_MN_OBS_VAL","scalar",rads_u_mn_obs,1,1,1)
      call put_NETCDF_fld(trim(file_write),"RADS_U_URBAN_VR_ENS_MN","scalar",rads_u_vr_trc,1,1,1)
      call put_NETCDF_fld(trim(file_write),"RADS_U_URBAN_VR_OBS_VAL","scalar",rads_u_vr_obs,1,1,1)
      call put_NETCDF_fld(trim(file_write),"RADS_U_URBAN_NMB_ENS_MN","scalar",rads_u_nmb,1,1,1)
      call put_NETCDF_fld(trim(file_write),"RADS_U_URBAN_RMSE_ENS_MN","scalar",rads_u_rmse,1,1,1)
      call put_NETCDF_fld(trim(file_write),"RADS_U_URBAN_RCOR_ENS_MN","scalar",rads_u_rcor,1,1,1)
      call put_NETCDF_fld(trim(file_write),"RADS_U_URBAN_MN_NPTS","scalar",urban_stpts,1,1,1)
!      
      call rural_ens_mn_skill_metrics(rads_u_mn_trc,rads_u_mn_obs,rads_u_vr_trc,rads_u_vr_obs, &
      rads_u_nmb,rads_u_rmse,rads_u_rcor,traceri_rural_ii,traceri_rural_jj,num_rural,rads_u_post_mn, &
      rads_u_val,rads_u_i,rads_u_j,rads_u_sav,rads_u_vert,p_lay_bot,p_lay_top,rural_stpts, &
      max_nobs,npts_rural)
      print *, ' '
      print *, 'U TRC MN   ',rads_u_mn_trc
      print *, 'OBS MN   ',rads_u_mn_obs
      print *, 'TRC VR   ',rads_u_vr_trc
      print *, 'OBS VR   ',rads_u_vr_obs
      print *, 'NMB      ',rads_u_nmb
      print *, 'RMSE     ',rads_u_rmse
      print *, 'RCOR     ',rads_u_rcor
      print *, 'NPTS     ',rural_stpts
      call put_NETCDF_fld(trim(file_write),"RADS_U_RURAL_MN_ENS_MN","scalar",rads_u_mn_trc,1,1,1)
      call put_NETCDF_fld(trim(file_write),"RADS_U_RURAL_MN_OBS_VAL","scalar",rads_u_mn_obs,1,1,1)
      call put_NETCDF_fld(trim(file_write),"RADS_U_RURAL_VR_ENS_MN","scalar",rads_u_vr_trc,1,1,1)
      call put_NETCDF_fld(trim(file_write),"RADS_U_RURAL_VR_OBS_VAL","scalar",rads_u_vr_obs,1,1,1)
      call put_NETCDF_fld(trim(file_write),"RADS_U_RURAL_NMB_ENS_MN","scalar",rads_u_nmb,1,1,1)
      call put_NETCDF_fld(trim(file_write),"RADS_U_RURAL_RMSE_ENS_MN","scalar",rads_u_rmse,1,1,1)
      call put_NETCDF_fld(trim(file_write),"RADS_U_RURAL_RCOR_ENS_MN","scalar",rads_u_rcor,1,1,1)
      call put_NETCDF_fld(trim(file_write),"RADS_U_RURAL_MN_NPTS","scalar",rural_stpts,1,1,1)
!
! RADIOSONDE V
      call get_obs_seq_ens(file_read_obs_seq_final,'RADIOSONDE_V_WIND_COMPONENT', &
      max_nobs,num_mems,rads_v_sav,rads_v_lon,rads_v_lat,rads_v_vert,rads_v_val, &
      rads_v_err,rads_v_prior_mn,rads_v_post_mn,rads_v_prior_sd,rads_v_post_sd, &
      rads_v_prior_mem,rads_v_post_mem)
      call get_platform_i_j(rads_v_i,rads_v_j,rads_v_lon,rads_v_lat,max_nobs,rads_v_sav, &
      traceri_lon,traceri_lat,nx,ny)
!
      call conus_ens_mn_skill_metrics(rads_v_mn_trc,rads_v_mn_obs,rads_v_vr_trc,rads_v_vr_obs, &
      rads_v_nmb,rads_v_rmse,rads_v_rcor,traceri_conus_ii,traceri_conus_jj,num_conus,rads_v_post_mn, &
      rads_v_val,rads_v_i,rads_v_j,rads_v_sav,rads_v_vert,p_lay_bot,p_lay_top,conus_stpts, &
      max_nobs,npts_conus)
      print *, ' '
      print *, 'V TRC MN   ',rads_v_mn_trc
      print *, 'OBS MN   ',rads_v_mn_obs
      print *, 'TRC VR   ',rads_v_vr_trc
      print *, 'OBS VR   ',rads_v_vr_obs
      print *, 'NMB      ',rads_v_nmb
      print *, 'RMSE     ',rads_v_rmse
      print *, 'RCOR     ',rads_v_rcor 
      print *, 'NPTS     ',conus_stpts
      call put_NETCDF_fld(trim(file_write),"RADS_V_CONUS_MN_ENS_MN","scalar",rads_v_mn_trc,1,1,1)
      call put_NETCDF_fld(trim(file_write),"RADS_V_CONUS_MN_OBS_VAL","scalar",rads_v_mn_obs,1,1,1)
      call put_NETCDF_fld(trim(file_write),"RADS_V_CONUS_VR_ENS_MN","scalar",rads_v_vr_trc,1,1,1)
      call put_NETCDF_fld(trim(file_write),"RADS_V_CONUS_VR_OBS_VAL","scalar",rads_v_vr_obs,1,1,1)
      call put_NETCDF_fld(trim(file_write),"RADS_V_CONUS_NMB_ENS_MN","scalar",rads_v_nmb,1,1,1)
      call put_NETCDF_fld(trim(file_write),"RADS_V_CONUS_RMSE_ENS_MN","scalar",rads_v_rmse,1,1,1)
      call put_NETCDF_fld(trim(file_write),"RADS_V_CONUS_RCOR_ENS_MN","scalar",rads_v_rcor,1,1,1)
      call put_NETCDF_fld(trim(file_write),"RADS_V_CONUS_MN_NPTS","scalar",conus_stpts,1,1,1)
!
      call urban_ens_mn_skill_metrics(rads_v_mn_trc,rads_v_mn_obs,rads_v_vr_trc,rads_v_vr_obs, &
      rads_v_nmb,rads_v_rmse,rads_v_rcor,traceri_urban_ii,traceri_urban_jj,num_urban,rads_v_post_mn, &
      rads_v_val,rads_v_i,rads_v_j,rads_v_sav,rads_v_vert,p_lay_bot,p_lay_top,urban_stpts, &
      max_nobs,npts_urban,num_cities)
      print *, ' '
      print *, 'V TRC MN   ',rads_v_mn_trc
      print *, 'OBS MN   ',rads_v_mn_obs
      print *, 'TRC VR   ',rads_v_vr_trc
      print *, 'OBS VR   ',rads_v_vr_obs
      print *, 'NMB      ',rads_v_nmb
      print *, 'RMSE     ',rads_v_rmse
      print *, 'RCOR     ',rads_v_rcor
      print *, 'NPTS     ',urban_stpts
      call put_NETCDF_fld(trim(file_write),"RADS_V_URBAN_MN_ENS_MN","scalar",rads_v_mn_trc,1,1,1)
      call put_NETCDF_fld(trim(file_write),"RADS_V_URBAN_MN_OBS_VAL","scalar",rads_v_mn_obs,1,1,1)
      call put_NETCDF_fld(trim(file_write),"RADS_V_URBAN_VR_ENS_MN","scalar",rads_v_vr_trc,1,1,1)
      call put_NETCDF_fld(trim(file_write),"RADS_V_URBAN_VR_OBS_VAL","scalar",rads_v_vr_obs,1,1,1)
      call put_NETCDF_fld(trim(file_write),"RADS_V_URBAN_NMB_ENS_MN","scalar",rads_v_nmb,1,1,1)
      call put_NETCDF_fld(trim(file_write),"RADS_V_URBAN_RMSE_ENS_MN","scalar",rads_v_rmse,1,1,1)
      call put_NETCDF_fld(trim(file_write),"RADS_V_URBAN_RCOR_ENS_MN","scalar",rads_v_rcor,1,1,1)
      call put_NETCDF_fld(trim(file_write),"RADS_V_URBAN_MN_NPTS","scalar",urban_stpts,1,1,1)
!      
      call rural_ens_mn_skill_metrics(rads_v_mn_trc,rads_v_mn_obs,rads_v_vr_trc,rads_v_vr_obs, &
      rads_v_nmb,rads_v_rmse,rads_v_rcor,traceri_rural_ii,traceri_rural_jj,num_rural,rads_v_post_mn, &
      rads_v_val,rads_v_i,rads_v_j,rads_v_sav,rads_v_vert,p_lay_bot,p_lay_top,rural_stpts, &
      max_nobs,npts_rural)
      print *, ' '
      print *, 'V TRC MN   ',rads_v_mn_trc
      print *, 'OBS MN   ',rads_v_mn_obs
      print *, 'TRC VR   ',rads_v_vr_trc
      print *, 'OBS VR   ',rads_v_vr_obs
      print *, 'NMB      ',rads_v_nmb
      print *, 'RMSE     ',rads_v_rmse
      print *, 'RCOR     ',rads_v_rcor
      print *, 'NPTS     ',rural_stpts      
      call put_NETCDF_fld(trim(file_write),"RADS_V_RURAL_MN_ENS_MN","scalar",rads_v_mn_trc,1,1,1)
      call put_NETCDF_fld(trim(file_write),"RADS_V_RURAL_MN_OBS_VAL","scalar",rads_v_mn_obs,1,1,1)
      call put_NETCDF_fld(trim(file_write),"RADS_V_RURAL_VR_ENS_MN","scalar",rads_v_vr_trc,1,1,1)
      call put_NETCDF_fld(trim(file_write),"RADS_V_RURAL_VR_OBS_VAL","scalar",rads_v_vr_obs,1,1,1)
      call put_NETCDF_fld(trim(file_write),"RADS_V_RURAL_NMB_ENS_MN","scalar",rads_v_nmb,1,1,1)
      call put_NETCDF_fld(trim(file_write),"RADS_V_RURAL_RMSE_ENS_MN","scalar",rads_v_rmse,1,1,1)
      call put_NETCDF_fld(trim(file_write),"RADS_V_RURAL_RCOR_ENS_MN","scalar",rads_v_rcor,1,1,1)
      call put_NETCDF_fld(trim(file_write),"RADS_V_RURAL_MN_NPTS","scalar",rural_stpts,1,1,1)
!
! RADIOSONDE Q
      call get_obs_seq_ens(file_read_obs_seq_final,'RADIOSONDE_SPECIFIC_HUMIDITY', &
      max_nobs,num_mems,rads_q_sav,rads_q_lon,rads_q_lat,rads_q_vert,rads_q_val, &
      rads_q_err,rads_q_prior_mn,rads_q_post_mn,rads_q_prior_sd,rads_q_post_sd, &
      rads_q_prior_mem,rads_q_post_mem)
      call get_platform_i_j(rads_q_i,rads_q_j,rads_q_lon,rads_q_lat,max_nobs,rads_q_sav, &
      traceri_lon,traceri_lat,nx,ny)
!
      call conus_ens_mn_skill_metrics(rads_q_mn_trc,rads_q_mn_obs,rads_q_vr_trc,rads_q_vr_obs, &
      rads_q_nmb,rads_q_rmse,rads_q_rcor,traceri_conus_ii,traceri_conus_jj,num_conus,rads_q_post_mn, &
      rads_q_val,rads_q_i,rads_q_j,rads_q_sav,rads_q_vert,p_lay_bot,p_lay_top,conus_stpts, &
      max_nobs,npts_conus)
      print *, ' '
      print *, 'Q TRC MN   ',rads_q_mn_trc
      print *, 'OBS MN   ',rads_q_mn_obs
      print *, 'TRC VR   ',rads_q_vr_trc
      print *, 'OBS VR   ',rads_q_vr_obs
      print *, 'NMB      ',rads_q_nmb
      print *, 'RMSE     ',rads_q_rmse
      print *, 'RCOR     ',rads_q_rcor
      print *, 'NPTS     ',conus_stpts
      call put_NETCDF_fld(trim(file_write),"RADS_Q_CONUS_MN_ENS_MN","scalar",rads_q_mn_trc,1,1,1)
      call put_NETCDF_fld(trim(file_write),"RADS_Q_CONUS_MN_OBS_VAL","scalar",rads_q_mn_obs,1,1,1)
      call put_NETCDF_fld(trim(file_write),"RADS_Q_CONUS_VR_ENS_MN","scalar",rads_q_vr_trc,1,1,1)
      call put_NETCDF_fld(trim(file_write),"RADS_Q_CONUS_VR_OBS_VAL","scalar",rads_q_vr_obs,1,1,1)
      call put_NETCDF_fld(trim(file_write),"RADS_Q_CONUS_NMB_ENS_MN","scalar",rads_q_nmb,1,1,1)
      call put_NETCDF_fld(trim(file_write),"RADS_Q_CONUS_RMSE_ENS_MN","scalar",rads_q_rmse,1,1,1)
      call put_NETCDF_fld(trim(file_write),"RADS_Q_CONUS_RCOR_ENS_MN","scalar",rads_q_rcor,1,1,1)
      call put_NETCDF_fld(trim(file_write),"RADS_Q_CONUS_MN_NPTS","scalar",conus_stpts,1,1,1)
!
      call urban_ens_mn_skill_metrics(rads_q_mn_trc,rads_q_mn_obs,rads_q_vr_trc,rads_q_vr_obs, &
      rads_q_nmb,rads_q_rmse,rads_q_rcor,traceri_urban_ii,traceri_urban_jj,num_urban,rads_q_post_mn, &
      rads_q_val,rads_q_i,rads_q_j,rads_q_sav,rads_q_vert,p_lay_bot,p_lay_top,urban_stpts, &
      max_nobs,npts_urban,num_cities)
      print *, ' '
      print *, 'Q TRC MN   ',rads_q_mn_trc
      print *, 'OBS MN   ',rads_q_mn_obs
      print *, 'TRC VR   ',rads_q_vr_trc
      print *, 'OBS VR   ',rads_q_vr_obs
      print *, 'NMB      ',rads_q_nmb
      print *, 'RMSE     ',rads_q_rmse
      print *, 'RCOR     ',rads_q_rcor
      print *, 'NPTS     ',urban_stpts
      call put_NETCDF_fld(trim(file_write),"RADS_Q_URBAN_MN_ENS_MN","scalar",rads_q_mn_trc,1,1,1)
      call put_NETCDF_fld(trim(file_write),"RADS_Q_URBAN_MN_OBS_VAL","scalar",rads_q_mn_obs,1,1,1)
      call put_NETCDF_fld(trim(file_write),"RADS_Q_URBAN_VR_ENS_MN","scalar",rads_q_vr_trc,1,1,1)
      call put_NETCDF_fld(trim(file_write),"RADS_Q_URBAN_VR_OBS_VAL","scalar",rads_q_vr_obs,1,1,1)
      call put_NETCDF_fld(trim(file_write),"RADS_Q_URBAN_NMB_ENS_MN","scalar",rads_q_nmb,1,1,1)
      call put_NETCDF_fld(trim(file_write),"RADS_Q_URBAN_RMSE_ENS_MN","scalar",rads_q_rmse,1,1,1)
      call put_NETCDF_fld(trim(file_write),"RADS_Q_URBAN_RCOR_ENS_MN","scalar",rads_q_rcor,1,1,1)
      call put_NETCDF_fld(trim(file_write),"RADS_Q_URBAN_MN_NPTS","scalar",urban_stpts,1,1,1)
!      
      call rural_ens_mn_skill_metrics(rads_q_mn_trc,rads_q_mn_obs,rads_q_vr_trc,rads_q_vr_obs, &
      rads_q_nmb,rads_q_rmse,rads_q_rcor,traceri_rural_ii,traceri_rural_jj,num_rural,rads_q_post_mn, &
      rads_q_val,rads_q_i,rads_q_j,rads_q_sav,rads_q_vert,p_lay_bot,p_lay_top,rural_stpts, &
      max_nobs,npts_rural)
      print *, ' '
      print *, 'Q TRC MN   ',rads_q_mn_trc
      print *, 'OBS MN   ',rads_q_mn_obs
      print *, 'TRC VR   ',rads_q_vr_trc
      print *, 'OBS VR   ',rads_q_vr_obs
      print *, 'NMB      ',rads_q_nmb
      print *, 'RMSE     ',rads_q_rmse
      print *, 'RCOR     ',rads_q_rcor
      print *, 'NPTS     ',rural_stpts
      call put_NETCDF_fld(trim(file_write),"RADS_Q_RURAL_MN_ENS_MN","scalar",rads_q_mn_trc,1,1,1)
      call put_NETCDF_fld(trim(file_write),"RADS_Q_RURAL_MN_OBS_VAL","scalar",rads_q_mn_obs,1,1,1)
      call put_NETCDF_fld(trim(file_write),"RADS_Q_RURAL_VR_ENS_MN","scalar",rads_q_vr_trc,1,1,1)
      call put_NETCDF_fld(trim(file_write),"RADS_Q_RURAL_VR_OBS_VAL","scalar",rads_q_vr_obs,1,1,1)
      call put_NETCDF_fld(trim(file_write),"RADS_Q_RURAL_NMB_ENS_MN","scalar",rads_q_nmb,1,1,1)
      call put_NETCDF_fld(trim(file_write),"RADS_Q_RURAL_RMSE_ENS_MN","scalar",rads_q_rmse,1,1,1)
      call put_NETCDF_fld(trim(file_write),"RADS_Q_RURAL_RCOR_ENS_MN","scalar",rads_q_rcor,1,1,1)
      call put_NETCDF_fld(trim(file_write),"RADS_Q_RURAL_MN_NPTS","scalar",rural_stpts,1,1,1)
!
! AIRNOW CO
      call get_obs_seq_ens(file_read_obs_seq_final,'AIRNOW_CO', &
      max_nobs,num_mems,airn_co_sav,airn_co_lon,airn_co_lat,airn_co_vert,airn_co_val, &
      airn_co_err,airn_co_prior_mn,airn_co_post_mn,airn_co_prior_sd,airn_co_post_sd, &
      airn_co_prior_mem,airn_co_post_mem)
      call get_platform_i_j(airn_co_i,airn_co_j,airn_co_lon,airn_co_lat,max_nobs,airn_co_sav, &
      traceri_lon,traceri_lat,nx,ny)
!
      call conus_ens_mn_skill_metrics(airn_co_mn_trc,airn_co_mn_obs,airn_co_vr_trc,airn_co_vr_obs, &
      airn_co_nmb,airn_co_rmse,airn_co_rcor,traceri_conus_ii,traceri_conus_jj,num_conus,airn_co_post_mn, &
      airn_co_val,airn_co_i,airn_co_j,airn_co_sav,airn_co_vert,p_lay_bot,p_lay_top,conus_stpts, &
      max_nobs,npts_conus)
      print *, ' '
      print *, 'CO TRC MN   ',airn_co_mn_trc
      print *, 'OBS MN   ',airn_co_mn_obs
      print *, 'TRC VR   ',airn_co_vr_trc
      print *, 'OBS VR   ',airn_co_vr_obs
      print *, 'NMB      ',airn_co_nmb
      print *, 'RMSE     ',airn_co_rmse
      print *, 'RCOR     ',airn_co_rcor
      print *, 'NPTS     ',conus_stpts
      call put_NETCDF_fld(trim(file_write),"AIRN_CO_CONUS_MN_ENS_MN","scalar",airn_co_mn_trc,1,1,1)
      call put_NETCDF_fld(trim(file_write),"AIRN_CO_CONUS_MN_OBS_VAL","scalar",airn_co_mn_obs,1,1,1)
      call put_NETCDF_fld(trim(file_write),"AIRN_CO_CONUS_VR_ENS_MN","scalar",airn_co_vr_trc,1,1,1)
      call put_NETCDF_fld(trim(file_write),"AIRN_CO_CONUS_VR_OBS_VAL","scalar",airn_co_vr_obs,1,1,1)
      call put_NETCDF_fld(trim(file_write),"AIRN_CO_CONUS_NMB_ENS_MN","scalar",airn_co_nmb,1,1,1)
      call put_NETCDF_fld(trim(file_write),"AIRN_CO_CONUS_RMSE_ENS_MN","scalar",airn_co_rmse,1,1,1)
      call put_NETCDF_fld(trim(file_write),"AIRN_CO_CONUS_RCOR_ENS_MN","scalar",airn_co_rcor,1,1,1)
      call put_NETCDF_fld(trim(file_write),"AIRN_CO_CONUS_MN_NPTS","scalar",conus_stpts,1,1,1)
!
      call urban_ens_mn_skill_metrics(airn_co_mn_trc,airn_co_mn_obs,airn_co_vr_trc,airn_co_vr_obs, &
      airn_co_nmb,airn_co_rmse,airn_co_rcor,traceri_urban_ii,traceri_urban_jj,num_urban,airn_co_post_mn, &
      airn_co_val,airn_co_i,airn_co_j,airn_co_sav,airn_co_vert,p_lay_bot,p_lay_top,urban_stpts, &
      max_nobs,npts_urban,num_cities)
      print *, ' '
      print *, 'CO TRC MN   ',airn_co_mn_trc
      print *, 'OBS MN   ',airn_co_mn_obs
      print *, 'TRC VR   ',airn_co_vr_trc
      print *, 'OBS VR   ',airn_co_vr_obs
      print *, 'NMB      ',airn_co_nmb
      print *, 'RMSE     ',airn_co_rmse
      print *, 'RCOR     ',airn_co_rcor
      print *, 'NPTS     ',urban_stpts
      call put_NETCDF_fld(trim(file_write),"AIRN_CO_URBAN_MN_ENS_MN","scalar",airn_co_mn_trc,1,1,1)
      call put_NETCDF_fld(trim(file_write),"AIRN_CO_URBAN_MN_OBS_VAL","scalar",airn_co_mn_obs,1,1,1)
      call put_NETCDF_fld(trim(file_write),"AIRN_CO_URBAN_VR_ENS_MN","scalar",airn_co_vr_trc,1,1,1)
      call put_NETCDF_fld(trim(file_write),"AIRN_CO_URBAN_VR_OBS_VAL","scalar",airn_co_vr_obs,1,1,1)
      call put_NETCDF_fld(trim(file_write),"AIRN_CO_URBAN_NMB_ENS_MN","scalar",airn_co_nmb,1,1,1)
      call put_NETCDF_fld(trim(file_write),"AIRN_CO_URBAN_RMSE_ENS_MN","scalar",airn_co_rmse,1,1,1)
      call put_NETCDF_fld(trim(file_write),"AIRN_CO_URBAN_RCOR_ENS_MN","scalar",airn_co_rcor,1,1,1)
      call put_NETCDF_fld(trim(file_write),"AIRN_CO_URBAN_MN_NPTS","scalar",urban_stpts,1,1,1)!
!      
      call rural_ens_mn_skill_metrics(airn_co_mn_trc,airn_co_mn_obs,airn_co_vr_trc,airn_co_vr_obs, &
      airn_co_nmb,airn_co_rmse,airn_co_rcor,traceri_rural_ii,traceri_rural_jj,num_rural,airn_co_post_mn, &
      airn_co_val,airn_co_i,airn_co_j,airn_co_sav,airn_co_vert,p_lay_bot,p_lay_top,rural_stpts, &
      max_nobs,npts_rural)
      print *, ' '
      print *, 'CO TRC MN   ',airn_co_mn_trc
      print *, 'OBS MN   ',airn_co_mn_obs
      print *, 'TRC VR   ',airn_co_vr_trc
      print *, 'OBS VR   ',airn_co_vr_obs
      print *, 'NMB      ',airn_co_nmb
      print *, 'RMSE     ',airn_co_rmse
      print *, 'RCOR     ',airn_co_rcor
      print *, 'NPTS     ',rural_stpts
      call put_NETCDF_fld(trim(file_write),"AIRN_CO_RURAL_MN_ENS_MN","scalar",airn_co_mn_trc,1,1,1)
      call put_NETCDF_fld(trim(file_write),"AIRN_CO_RURAL_MN_OBS_VAL","scalar",airn_co_mn_obs,1,1,1)
      call put_NETCDF_fld(trim(file_write),"AIRN_CO_RURAL_VR_ENS_MN","scalar",airn_co_vr_trc,1,1,1)
      call put_NETCDF_fld(trim(file_write),"AIRN_CO_RURAL_VR_OBS_VAL","scalar",airn_co_vr_obs,1,1,1)
      call put_NETCDF_fld(trim(file_write),"AIRN_CO_RURAL_NMB_ENS_MN","scalar",airn_co_nmb,1,1,1)
      call put_NETCDF_fld(trim(file_write),"AIRN_CO_RURAL_RMSE_ENS_MN","scalar",airn_co_rmse,1,1,1)
      call put_NETCDF_fld(trim(file_write),"AIRN_CO_RURAL_RCOR_ENS_MN","scalar",airn_co_rcor,1,1,1)
      call put_NETCDF_fld(trim(file_write),"AIRN_CO_RURAL_MN_NPTS","scalar",rural_stpts,1,1,1)
!
! AIRNOW O3
      call get_obs_seq_ens(file_read_obs_seq_final,'AIRNOW_O3', &
      max_nobs,num_mems,airn_o3_sav,airn_o3_lon,airn_o3_lat,airn_o3_vert,airn_o3_val, &
      airn_o3_err,airn_o3_prior_mn,airn_o3_post_mn,airn_o3_prior_sd,airn_o3_post_sd, &
      airn_o3_prior_mem,airn_o3_post_mem)
      call get_platform_i_j(airn_o3_i,airn_o3_j,airn_o3_lon,airn_o3_lat,max_nobs,airn_o3_sav, &
      traceri_lon,traceri_lat,nx,ny)
!
      call conus_ens_mn_skill_metrics(airn_o3_mn_trc,airn_o3_mn_obs,airn_o3_vr_trc,airn_o3_vr_obs, &
      airn_o3_nmb,airn_o3_rmse,airn_o3_rcor,traceri_conus_ii,traceri_conus_jj,num_conus,airn_o3_post_mn, &
      airn_o3_val,airn_o3_i,airn_o3_j,airn_o3_sav,airn_o3_vert,p_lay_bot,p_lay_top,conus_stpts, &
      max_nobs,npts_conus)
      print *, ' '
      print *, 'O3 TRC MN   ',airn_o3_mn_trc
      print *, 'OBS MN   ',airn_o3_mn_obs
      print *, 'TRC VR   ',airn_o3_vr_trc
      print *, 'OBS VR   ',airn_o3_vr_obs
      print *, 'NMB      ',airn_o3_nmb
      print *, 'RMSE     ',airn_o3_rmse
      print *, 'RCOR     ',airn_o3_rcor
      print *, 'NPTS     ',conus_stpts  
      call put_NETCDF_fld(trim(file_write),"AIRN_O3_CONUS_MN_ENS_MN","scalar",airn_o3_mn_trc,1,1,1)
      call put_NETCDF_fld(trim(file_write),"AIRN_O3_CONUS_MN_OBS_VAL","scalar",airn_o3_mn_obs,1,1,1)
      call put_NETCDF_fld(trim(file_write),"AIRN_O3_CONUS_VR_ENS_MN","scalar",airn_o3_vr_trc,1,1,1)
      call put_NETCDF_fld(trim(file_write),"AIRN_O3_CONUS_VR_OBS_VAL","scalar",airn_o3_vr_obs,1,1,1)
      call put_NETCDF_fld(trim(file_write),"AIRN_O3_CONUS_NMB_ENS_MN","scalar",airn_o3_nmb,1,1,1)
      call put_NETCDF_fld(trim(file_write),"AIRN_O3_CONUS_RMSE_ENS_MN","scalar",airn_o3_rmse,1,1,1)
      call put_NETCDF_fld(trim(file_write),"AIRN_O3_CONUS_RCOR_ENS_MN","scalar",airn_o3_rcor,1,1,1)
      call put_NETCDF_fld(trim(file_write),"AIRN_O3_CONUS_MN_NPTS","scalar",conus_stpts,1,1,1)
!
      call urban_ens_mn_skill_metrics(airn_o3_mn_trc,airn_o3_mn_obs,airn_o3_vr_trc,airn_o3_vr_obs, &
      airn_o3_nmb,airn_o3_rmse,airn_o3_rcor,traceri_urban_ii,traceri_urban_jj,num_urban,airn_o3_post_mn, &
      airn_o3_val,airn_o3_i,airn_o3_j,airn_o3_sav,airn_o3_vert,p_lay_bot,p_lay_top,urban_stpts, &
      max_nobs,npts_urban,num_cities)
      print *, ' '
      print *, 'O3 TRC MN   ',airn_o3_mn_trc
      print *, 'OBS MN   ',airn_o3_mn_obs
      print *, 'TRC VR   ',airn_o3_vr_trc
      print *, 'OBS VR   ',airn_o3_vr_obs
      print *, 'NMB      ',airn_o3_nmb
      print *, 'RMSE     ',airn_o3_rmse
      print *, 'RCOR     ',airn_o3_rcor
      print *, 'NPTS     ',urban_stpts
      call put_NETCDF_fld(trim(file_write),"AIRN_O3_URBAN_MN_ENS_MN","scalar",airn_o3_mn_trc,1,1,1)
      call put_NETCDF_fld(trim(file_write),"AIRN_O3_URBAN_MN_OBS_VAL","scalar",airn_o3_mn_obs,1,1,1)
      call put_NETCDF_fld(trim(file_write),"AIRN_O3_URBAN_VR_ENS_MN","scalar",airn_o3_vr_trc,1,1,1)
      call put_NETCDF_fld(trim(file_write),"AIRN_O3_URBAN_VR_OBS_VAL","scalar",airn_o3_vr_obs,1,1,1)
      call put_NETCDF_fld(trim(file_write),"AIRN_O3_URBAN_NMB_ENS_MN","scalar",airn_o3_nmb,1,1,1)
      call put_NETCDF_fld(trim(file_write),"AIRN_O3_URBAN_RMSE_ENS_MN","scalar",airn_o3_rmse,1,1,1)
      call put_NETCDF_fld(trim(file_write),"AIRN_O3_URBAN_RCOR_ENS_MN","scalar",airn_o3_rcor,1,1,1)
      call put_NETCDF_fld(trim(file_write),"AIRN_O3_URBAN_MN_NPTS","scalar",urban_stpts,1,1,1)
!      
      call rural_ens_mn_skill_metrics(airn_o3_mn_trc,airn_o3_mn_obs,airn_o3_vr_trc,airn_o3_vr_obs, &
      airn_o3_nmb,airn_o3_rmse,airn_o3_rcor,traceri_rural_ii,traceri_rural_jj,num_rural,airn_o3_post_mn, &
      airn_o3_val,airn_o3_i,airn_o3_j,airn_o3_sav,airn_o3_vert,p_lay_bot,p_lay_top,rural_stpts, &
      max_nobs,npts_rural)
      print *, ' '
      print *, 'O3 TRC MN   ',airn_o3_mn_trc
      print *, 'OBS MN   ',airn_o3_mn_obs
      print *, 'TRC VR   ',airn_o3_vr_trc
      print *, 'OBS VR   ',airn_o3_vr_obs
      print *, 'NMB      ',airn_o3_nmb
      print *, 'RMSE     ',airn_o3_rmse
      print *, 'RCOR     ',airn_o3_rcor
      print *, 'NPTS     ',rural_stpts      
      call put_NETCDF_fld(trim(file_write),"AIRN_O3_RURAL_MN_ENS_MN","scalar",airn_o3_mn_trc,1,1,1)
      call put_NETCDF_fld(trim(file_write),"AIRN_O3_RURAL_MN_OBS_VAL","scalar",airn_o3_mn_obs,1,1,1)
      call put_NETCDF_fld(trim(file_write),"AIRN_O3_RURAL_VR_ENS_MN","scalar",airn_o3_vr_trc,1,1,1)
      call put_NETCDF_fld(trim(file_write),"AIRN_O3_RURAL_VR_OBS_VAL","scalar",airn_o3_vr_obs,1,1,1)
      call put_NETCDF_fld(trim(file_write),"AIRN_O3_RURAL_NMB_ENS_MN","scalar",airn_o3_nmb,1,1,1)
      call put_NETCDF_fld(trim(file_write),"AIRN_O3_RURAL_RMSE_ENS_MN","scalar",airn_o3_rmse,1,1,1)
      call put_NETCDF_fld(trim(file_write),"AIRN_O3_RURAL_RCOR_ENS_MN","scalar",airn_o3_rcor,1,1,1)
      call put_NETCDF_fld(trim(file_write),"AIRN_O3_RURAL_MN_NPTS","scalar",rural_stpts,1,1,1)
!
! AIRNOW NO2
      file_read_obs_seq_final=trim(path_input)//"/"//trim(file_input_obs_seq_final)
      call get_obs_seq_ens(file_read_obs_seq_final,'AIRNOW_NO2', &
      max_nobs,num_mems,airn_no2_sav,airn_no2_lon,airn_no2_lat,airn_no2_vert,airn_no2_val, &
      airn_no2_err,airn_no2_prior_mn,airn_no2_post_mn,airn_no2_prior_sd,airn_no2_post_sd, &
      airn_no2_prior_mem,airn_no2_post_mem)
      call get_platform_i_j(airn_no2_i,airn_no2_j,airn_no2_lon,airn_no2_lat,max_nobs,airn_no2_sav, &
      traceri_lon,traceri_lat,nx,ny)
!
      call conus_ens_mn_skill_metrics(airn_no2_mn_trc,airn_no2_mn_obs,airn_no2_vr_trc,airn_no2_vr_obs, &
      airn_no2_nmb,airn_no2_rmse,airn_no2_rcor,traceri_conus_ii,traceri_conus_jj,num_conus,airn_no2_post_mn, &
      airn_no2_val,airn_no2_i,airn_no2_j,airn_no2_sav,airn_no2_vert,p_lay_bot,p_lay_top,conus_stpts, &
      max_nobs,npts_conus)
      print *, ' '
      print *, 'NO2 TRC MN   ',airn_no2_mn_trc
      print *, 'OBS MN   ',airn_no2_mn_obs
      print *, 'TRC VR   ',airn_no2_vr_trc
      print *, 'OBS VR   ',airn_no2_vr_obs
      print *, 'NMB      ',airn_no2_nmb
      print *, 'RMSE     ',airn_no2_rmse
      print *, 'RCOR     ',airn_no2_rcor
      print *, 'NPTS     ',conus_stpts  
      call put_NETCDF_fld(trim(file_write),"AIRN_NO2_CONUS_MN_ENS_MN","scalar",airn_no2_mn_trc,1,1,1)
      call put_NETCDF_fld(trim(file_write),"AIRN_NO2_CONUS_MN_OBS_VAL","scalar",airn_no2_mn_obs,1,1,1)
      call put_NETCDF_fld(trim(file_write),"AIRN_NO2_CONUS_VR_ENS_MN","scalar",airn_no2_vr_trc,1,1,1)
      call put_NETCDF_fld(trim(file_write),"AIRN_NO2_CONUS_VR_OBS_VAL","scalar",airn_no2_vr_obs,1,1,1)
      call put_NETCDF_fld(trim(file_write),"AIRN_NO2_CONUS_NMB_ENS_MN","scalar",airn_no2_nmb,1,1,1)
      call put_NETCDF_fld(trim(file_write),"AIRN_NO2_CONUS_RMSE_ENS_MN","scalar",airn_no2_rmse,1,1,1)
      call put_NETCDF_fld(trim(file_write),"AIRN_NO2_CONUS_RCOR_ENS_MN","scalar",airn_no2_rcor,1,1,1)
      call put_NETCDF_fld(trim(file_write),"AIRN_NO2_CONUS_MN_NPTS","scalar",conus_stpts,1,1,1)
!
      call urban_ens_mn_skill_metrics(airn_no2_mn_trc,airn_no2_mn_obs,airn_no2_vr_trc,airn_no2_vr_obs, &
      airn_no2_nmb,airn_no2_rmse,airn_no2_rcor,traceri_urban_ii,traceri_urban_jj,num_urban,airn_no2_post_mn, &
      airn_no2_val,airn_no2_i,airn_no2_j,airn_no2_sav,airn_no2_vert,p_lay_bot,p_lay_top,urban_stpts, &
      max_nobs,npts_urban,num_cities)
      print *, ' '
      print *, 'NO2 TRC MN   ',airn_no2_mn_trc
      print *, 'OBS MN   ',airn_no2_mn_obs
      print *, 'TRC VR   ',airn_no2_vr_trc
      print *, 'OBS VR   ',airn_no2_vr_obs
      print *, 'NMB      ',airn_no2_nmb
      print *, 'RMSE     ',airn_no2_rmse
      print *, 'RCOR     ',airn_no2_rcor
      print *, 'NPTS     ',urban_stpts
      call put_NETCDF_fld(trim(file_write),"AIRN_NO2_URBAN_MN_ENS_MN","scalar",airn_no2_mn_trc,1,1,1)
      call put_NETCDF_fld(trim(file_write),"AIRN_NO2_URBAN_MN_OBS_VAL","scalar",airn_no2_mn_obs,1,1,1)
      call put_NETCDF_fld(trim(file_write),"AIRN_NO2_URBAN_VR_ENS_MN","scalar",airn_no2_vr_trc,1,1,1)
      call put_NETCDF_fld(trim(file_write),"AIRN_NO2_URBAN_VR_OBS_VAL","scalar",airn_no2_vr_obs,1,1,1)
      call put_NETCDF_fld(trim(file_write),"AIRN_NO2_URBAN_NMB_ENS_MN","scalar",airn_no2_nmb,1,1,1)
      call put_NETCDF_fld(trim(file_write),"AIRN_NO2_URBAN_RMSE_ENS_MN","scalar",airn_no2_rmse,1,1,1)
      call put_NETCDF_fld(trim(file_write),"AIRN_NO2_URBAN_RCOR_ENS_MN","scalar",airn_no2_rcor,1,1,1)
      call put_NETCDF_fld(trim(file_write),"AIRN_NO2_URBAN_MN_NPTS","scalar",urban_stpts,1,1,1)
!      
      call rural_ens_mn_skill_metrics(airn_no2_mn_trc,airn_no2_mn_obs,airn_no2_vr_trc,airn_no2_vr_obs, &
      airn_no2_nmb,airn_no2_rmse,airn_no2_rcor,traceri_rural_ii,traceri_rural_jj,num_rural,airn_no2_post_mn, &
      airn_no2_val,airn_no2_i,airn_no2_j,airn_no2_sav,airn_no2_vert,p_lay_bot,p_lay_top,rural_stpts, &
      max_nobs,npts_rural)
      print *, ' '
      print *, 'NO2 TRC MN   ',airn_no2_mn_trc
      print *, 'OBS MN   ',airn_no2_mn_obs
      print *, 'TRC VR   ',airn_no2_vr_trc
      print *, 'OBS VR   ',airn_no2_vr_obs
      print *, 'NMB      ',airn_no2_nmb
      print *, 'RMSE     ',airn_no2_rmse
      print *, 'RCOR     ',airn_no2_rcor
      print *, 'NPTS     ',rural_stpts      
      call put_NETCDF_fld(trim(file_write),"AIRN_NO2_RURAL_MN_ENS_MN","scalar",airn_no2_mn_trc,1,1,1)
      call put_NETCDF_fld(trim(file_write),"AIRN_NO2_RURAL_MN_OBS_VAL","scalar",airn_no2_mn_obs,1,1,1)
      call put_NETCDF_fld(trim(file_write),"AIRN_NO2_RURAL_VR_ENS_MN","scalar",airn_no2_vr_trc,1,1,1)
      call put_NETCDF_fld(trim(file_write),"AIRN_NO2_RURAL_VR_OBS_VAL","scalar",airn_no2_vr_obs,1,1,1)
      call put_NETCDF_fld(trim(file_write),"AIRN_NO2_RURAL_NMB_ENS_MN","scalar",airn_no2_nmb,1,1,1)
      call put_NETCDF_fld(trim(file_write),"AIRN_NO2_RURAL_RMSE_ENS_MN","scalar",airn_no2_rmse,1,1,1)
      call put_NETCDF_fld(trim(file_write),"AIRN_NO2_RURAL_RCOR_ENS_MN","scalar",airn_no2_rcor,1,1,1)
      call put_NETCDF_fld(trim(file_write),"AIRN_NO2_RURAL_MN_NPTS","scalar",rural_stpts,1,1,1)
!
! AIRNOW SO2
      file_read_obs_seq_final=trim(path_input)//"/"//trim(file_input_obs_seq_final)
      call get_obs_seq_ens(file_read_obs_seq_final,'AIRNOW_SO2', &
      max_nobs,num_mems,airn_so2_sav,airn_so2_lon,airn_so2_lat,airn_so2_vert,airn_so2_val, &
      airn_so2_err,airn_so2_prior_mn,airn_so2_post_mn,airn_so2_prior_sd,airn_so2_post_sd, &
      airn_so2_prior_mem,airn_so2_post_mem)
      call get_platform_i_j(airn_so2_i,airn_so2_j,airn_so2_lon,airn_so2_lat,max_nobs,airn_so2_sav, &
      traceri_lon,traceri_lat,nx,ny)
!
      call conus_ens_mn_skill_metrics(airn_so2_mn_trc,airn_so2_mn_obs,airn_so2_vr_trc,airn_so2_vr_obs, &
      airn_so2_nmb,airn_so2_rmse,airn_so2_rcor,traceri_conus_ii,traceri_conus_jj,num_conus,airn_so2_post_mn, &
      airn_so2_val,airn_so2_i,airn_so2_j,airn_so2_sav,airn_so2_vert,p_lay_bot,p_lay_top,conus_stpts, &
      max_nobs,npts_conus)
      print *, ' '
      print *, 'SO2 TRC MN   ',airn_so2_mn_trc
      print *, 'OBS MN   ',airn_so2_mn_obs
      print *, 'TRC VR   ',airn_so2_vr_trc
      print *, 'OBS VR   ',airn_so2_vr_obs
      print *, 'NMB      ',airn_so2_nmb
      print *, 'RMSE     ',airn_so2_rmse
      print *, 'RCOR     ',airn_so2_rcor
      print *, 'NPTS     ',conus_stpts  
      call put_NETCDF_fld(trim(file_write),"AIRN_SO2_CONUS_MN_ENS_MN","scalar",airn_so2_mn_trc,1,1,1)
      call put_NETCDF_fld(trim(file_write),"AIRN_SO2_CONUS_MN_OBS_VAL","scalar",airn_so2_mn_obs,1,1,1)
      call put_NETCDF_fld(trim(file_write),"AIRN_SO2_CONUS_VR_ENS_MN","scalar",airn_so2_vr_trc,1,1,1)
      call put_NETCDF_fld(trim(file_write),"AIRN_SO2_CONUS_VR_OBS_VAL","scalar",airn_so2_vr_obs,1,1,1)
      call put_NETCDF_fld(trim(file_write),"AIRN_SO2_CONUS_NMB_ENS_MN","scalar",airn_so2_nmb,1,1,1)
      call put_NETCDF_fld(trim(file_write),"AIRN_SO2_CONUS_RMSE_ENS_MN","scalar",airn_so2_rmse,1,1,1)
      call put_NETCDF_fld(trim(file_write),"AIRN_SO2_CONUS_RCOR_ENS_MN","scalar",airn_so2_rcor,1,1,1)
      call put_NETCDF_fld(trim(file_write),"AIRN_SO2_CONUS_MN_NPTS","scalar",conus_stpts,1,1,1)
!
      call urban_ens_mn_skill_metrics(airn_so2_mn_trc,airn_so2_mn_obs,airn_so2_vr_trc,airn_so2_vr_obs, &
      airn_so2_nmb,airn_so2_rmse,airn_so2_rcor,traceri_urban_ii,traceri_urban_jj,num_urban,airn_so2_post_mn, &
      airn_so2_val,airn_so2_i,airn_so2_j,airn_so2_sav,airn_so2_vert,p_lay_bot,p_lay_top,urban_stpts, &
      max_nobs,npts_urban,num_cities)
      print *, ' '
      print *, 'SO2 TRC MN   ',airn_so2_mn_trc
      print *, 'OBS MN   ',airn_so2_mn_obs
      print *, 'TRC VR   ',airn_so2_vr_trc
      print *, 'OBS VR   ',airn_so2_vr_obs
      print *, 'NMB      ',airn_so2_nmb
      print *, 'RMSE     ',airn_so2_rmse
      print *, 'RCOR     ',airn_so2_rcor
      print *, 'NPTS     ',urban_stpts
      call put_NETCDF_fld(trim(file_write),"AIRN_SO2_URBAN_MN_ENS_MN","scalar",airn_so2_mn_trc,1,1,1)
      call put_NETCDF_fld(trim(file_write),"AIRN_SO2_URBAN_MN_OBS_VAL","scalar",airn_so2_mn_obs,1,1,1)
      call put_NETCDF_fld(trim(file_write),"AIRN_SO2_URBAN_VR_ENS_MN","scalar",airn_so2_vr_trc,1,1,1)
      call put_NETCDF_fld(trim(file_write),"AIRN_SO2_URBAN_VR_OBS_VAL","scalar",airn_so2_vr_obs,1,1,1)
      call put_NETCDF_fld(trim(file_write),"AIRN_SO2_URBAN_NMB_ENS_MN","scalar",airn_so2_nmb,1,1,1)
      call put_NETCDF_fld(trim(file_write),"AIRN_SO2_URBAN_RMSE_ENS_MN","scalar",airn_so2_rmse,1,1,1)
      call put_NETCDF_fld(trim(file_write),"AIRN_SO2_URBAN_RCOR_ENS_MN","scalar",airn_so2_rcor,1,1,1)
      call put_NETCDF_fld(trim(file_write),"AIRN_SO2_URBAN_MN_NPTS","scalar",urban_stpts,1,1,1)
!      
      call rural_ens_mn_skill_metrics(airn_so2_mn_trc,airn_so2_mn_obs,airn_so2_vr_trc,airn_so2_vr_obs, &
      airn_so2_nmb,airn_so2_rmse,airn_so2_rcor,traceri_rural_ii,traceri_rural_jj,num_rural,airn_so2_post_mn, &
      airn_so2_val,airn_so2_i,airn_so2_j,airn_so2_sav,airn_so2_vert,p_lay_bot,p_lay_top,rural_stpts, &
      max_nobs,npts_rural)
      print *, ' '
      print *, 'SO2 TRC MN   ',airn_so2_mn_trc
      print *, 'OBS MN   ',airn_so2_mn_obs
      print *, 'TRC VR   ',airn_so2_vr_trc
      print *, 'OBS VR   ',airn_so2_vr_obs
      print *, 'NMB      ',airn_so2_nmb
      print *, 'RMSE     ',airn_so2_rmse
      print *, 'RCOR     ',airn_so2_rcor
      print *, 'NPTS     ',rural_stpts      
      call put_NETCDF_fld(trim(file_write),"AIRN_SO2_RURAL_MN_ENS_MN","scalar",airn_so2_mn_trc,1,1,1)
      call put_NETCDF_fld(trim(file_write),"AIRN_SO2_RURAL_MN_OBS_VAL","scalar",airn_so2_mn_obs,1,1,1)
      call put_NETCDF_fld(trim(file_write),"AIRN_SO2_RURAL_VR_ENS_MN","scalar",airn_so2_vr_trc,1,1,1)
      call put_NETCDF_fld(trim(file_write),"AIRN_SO2_RURAL_VR_OBS_VAL","scalar",airn_so2_vr_obs,1,1,1)
      call put_NETCDF_fld(trim(file_write),"AIRN_SO2_RURAL_NMB_ENS_MN","scalar",airn_so2_nmb,1,1,1)
      call put_NETCDF_fld(trim(file_write),"AIRN_SO2_RURAL_RMSE_ENS_MN","scalar",airn_so2_rmse,1,1,1)
      call put_NETCDF_fld(trim(file_write),"AIRN_SO2_RURAL_RCOR_ENS_MN","scalar",airn_so2_rcor,1,1,1)
      call put_NETCDF_fld(trim(file_write),"AIRN_SO2_RURAL_MN_NPTS","scalar",rural_stpts,1,1,1)
!
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

   subroutine create_NETCDF_file(new_file,nx,ny,nz)
      use :: netcdf
      implicit none
!      
      integer                    :: rc,fid
      integer                    :: nx,ny,nz,nz_chemi,nz_fire
      integer                    :: x_dimid,y_dimid,z_dimid,scl_dimid
      integer                    :: var_id,att_id
      character(len=*)           :: new_file
!      
      rc=nf90_create(trim(new_file),NF90_CLOBBER,fid)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at create file')
      rc=nf90_def_dim(fid,"west-east",nx,x_dimid)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at x_dimid')
      rc=nf90_def_dim(fid,"south-north",ny,y_dimid)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at y_dimid')
      rc=nf90_def_dim(fid,"bottom-top",nz,z_dimid)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at z_dimid')
      rc=nf90_def_dim(fid,"scalar",1,scl_dimid)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at scl_dimid')
!
! TRACER-I: T, U, V, and Q for CONUS, URBAN, and RURAL against RADIOSONDE data
! CONUS T
      rc=nf90_def_var(fid,"RADS_T_CONUS_MN_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: RADS_T_CONUS_MN_ENS_MN')

      rc=nf90_def_var(fid,"RADS_T_CONUS_MN_OBS_VAL",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: RADS_T_CONUS_MN_OBS_VAL')

      rc=nf90_def_var(fid,"RADS_T_CONUS_VR_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: RADS_T_CONUS_VR_ENS_MN')

      rc=nf90_def_var(fid,"RADS_T_CONUS_VR_OBS_VAL",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: RADS_T_CONUS_VR_OBS_VAL')

      rc=nf90_def_var(fid,"RADS_T_CONUS_NMB_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: RADS_T_CONUS_NMB_ENS_MN')

      rc=nf90_def_var(fid,"RADS_T_CONUS_RMSE_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: RADS_T_CONUS_RMSE_ENS_MN')

      rc=nf90_def_var(fid,"RADS_T_CONUS_RCOR_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: RADS_T_CONUS_RCOR_ENS_MN')

      rc=nf90_def_var(fid,"RADS_T_CONUS_MN_NPTS",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: RADS_T_CONUS_MN_NPTS')
!
! URBAN
      rc=nf90_def_var(fid,"RADS_T_URBAN_MN_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: RADS_T_URBAN_MN_ENS_MN')

      rc=nf90_def_var(fid,"RADS_T_URBAN_MN_OBS_VAL",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: RADS_T_URBAN_MN_OBS_VAL')

      rc=nf90_def_var(fid,"RADS_T_URBAN_VR_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: RADS_T_URBAN_VR_ENS_MN')

      rc=nf90_def_var(fid,"RADS_T_URBAN_VR_OBS_VAL",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: RADS_T_URBAN_VR_OBS_VAL')

      rc=nf90_def_var(fid,"RADS_T_URBAN_NMB_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: RADS_T_URBAN_NMB_ENS_MN')

      rc=nf90_def_var(fid,"RADS_T_URBAN_RMSE_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: RADS_T_URBAN_RMSE_ENS_MN')

      rc=nf90_def_var(fid,"RADS_T_URBAN_RCOR_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: RADS_T_URBAN_RCOR_ENS_MN')

      rc=nf90_def_var(fid,"RADS_T_URBAN_MN_NPTS",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: RADS_T_URBAN_MN_NPTS')
!
! RURAL
      rc=nf90_def_var(fid,"RADS_T_RURAL_MN_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: RADS_T_RURAL_MN_ENS_MN')

      rc=nf90_def_var(fid,"RADS_T_RURAL_MN_OBS_VAL",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: RADS_T_RURAL_MN_OBS_VAL')

      rc=nf90_def_var(fid,"RADS_T_RURAL_VR_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: RADS_T_RURAL_VR_ENS_MN')

      rc=nf90_def_var(fid,"RADS_T_RURAL_VR_OBS_VAL",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: RADS_T_RURAL_VR_OBS_VAL')

      rc=nf90_def_var(fid,"RADS_T_RURAL_NMB_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: RADS_T_RURAL_NMB_ENS_MN')

      rc=nf90_def_var(fid,"RADS_T_RURAL_RMSE_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: RADS_T_RURAL_RMSE_ENS_MN')

      rc=nf90_def_var(fid,"RADS_T_RURAL_RCOR_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: RADS_T_RURAL_RCOR_ENS_MN')

      rc=nf90_def_var(fid,"RADS_T_RURAL_MN_NPTS",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: RADS_T_RURAL_MN_NPTS')
!
! CONUS U
      rc=nf90_def_var(fid,"RADS_U_CONUS_MN_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: RADS_U_CONUS_MN_ENS_MN')

      rc=nf90_def_var(fid,"RADS_U_CONUS_MN_OBS_VAL",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: RADS_U_CONUS_MN_OBS_VAL')

      rc=nf90_def_var(fid,"RADS_U_CONUS_VR_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: RADS_U_CONUS_VR_ENS_MN')

      rc=nf90_def_var(fid,"RADS_U_CONUS_VR_OBS_VAL",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: RADS_U_CONUS_VR_OBS_VAL')

      rc=nf90_def_var(fid,"RADS_U_CONUS_NMB_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: RADS_U_CONUS_NMB_ENS_MN')

      rc=nf90_def_var(fid,"RADS_U_CONUS_RMSE_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: RADS_U_CONUS_RMSE_ENS_MN')

      rc=nf90_def_var(fid,"RADS_U_CONUS_RCOR_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: RADS_U_CONUS_RCOR_ENS_MN')

      rc=nf90_def_var(fid,"RADS_U_CONUS_MN_NPTS",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: RADS_U_CONUS_MN_NPTS')
!
! URBAN
      rc=nf90_def_var(fid,"RADS_U_URBAN_MN_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: RADS_U_URBAN_MN_ENS_MN')

      rc=nf90_def_var(fid,"RADS_U_URBAN_MN_OBS_VAL",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: RADS_U_URBAN_MN_OBS_VAL')

      rc=nf90_def_var(fid,"RADS_U_URBAN_VR_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: RADS_U_URBAN_VR_ENS_MN')

      rc=nf90_def_var(fid,"RADS_U_URBAN_VR_OBS_VAL",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: RADS_U_URBAN_VR_OBS_VAL')

      rc=nf90_def_var(fid,"RADS_U_URBAN_NMB_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: RADS_U_URBAN_NMB_ENS_MN')

      rc=nf90_def_var(fid,"RADS_U_URBAN_RMSE_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: RADS_U_URBAN_RMSE_ENS_MN')

      rc=nf90_def_var(fid,"RADS_U_URBAN_RCOR_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: RADS_U_URBAN_RCOR_ENS_MN')

      rc=nf90_def_var(fid,"RADS_U_URBAN_MN_NPTS",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: RADS_U_URBAN_MN_NPTS')
!
! RURAL
      rc=nf90_def_var(fid,"RADS_U_RURAL_MN_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: RADS_U_RURAL_MN_ENS_MN')

      rc=nf90_def_var(fid,"RADS_U_RURAL_MN_OBS_VAL",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: RADS_U_RURAL_MN_OBS_VAL')

      rc=nf90_def_var(fid,"RADS_U_RURAL_VR_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: RADS_U_RURAL_VR_ENS_MN')

      rc=nf90_def_var(fid,"RADS_U_RURAL_VR_OBS_VAL",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: RADS_U_RURAL_VR_OBS_VAL')

      rc=nf90_def_var(fid,"RADS_U_RURAL_NMB_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: RADS_U_RURAL_NMB_ENS_MN')

      rc=nf90_def_var(fid,"RADS_U_RURAL_RMSE_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: RADS_U_RURAL_RMSE_ENS_MN')

      rc=nf90_def_var(fid,"RADS_U_RURAL_RCOR_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: RADS_U_RURAL_RCOR_ENS_MN')

      rc=nf90_def_var(fid,"RADS_U_RURAL_MN_NPTS",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: RADS_U_RURAL_MN_NPTS')
!
! CONUS V
      rc=nf90_def_var(fid,"RADS_V_CONUS_MN_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: RADS_V_CONUS_MN_ENS_MN')

      rc=nf90_def_var(fid,"RADS_V_CONUS_MN_OBS_VAL",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: RADS_V_CONUS_MN_OBS_VAL')

      rc=nf90_def_var(fid,"RADS_V_CONUS_VR_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: RADS_V_CONUS_VR_ENS_MN')

      rc=nf90_def_var(fid,"RADS_V_CONUS_VR_OBS_VAL",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: RADS_V_CONUS_VR_OBS_VAL')

      rc=nf90_def_var(fid,"RADS_V_CONUS_NMB_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: RADS_V_CONUS_NMB_ENS_MN')

      rc=nf90_def_var(fid,"RADS_V_CONUS_RMSE_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: RADS_V_CONUS_RMSE_ENS_MN')

      rc=nf90_def_var(fid,"RADS_V_CONUS_RCOR_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: RADS_V_CONUS_RCOR_ENS_MN')

      rc=nf90_def_var(fid,"RADS_V_CONUS_MN_NPTS",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: RADS_V_CONUS_MN_NPTS')
!
! URBAN
      rc=nf90_def_var(fid,"RADS_V_URBAN_MN_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: RADS_V_URBAN_MN_ENS_MN')

      rc=nf90_def_var(fid,"RADS_V_URBAN_MN_OBS_VAL",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: RADS_V_URBAN_MN_OBS_VAL')

      rc=nf90_def_var(fid,"RADS_V_URBAN_VR_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: RADS_V_URBAN_VR_ENS_MN')

      rc=nf90_def_var(fid,"RADS_V_URBAN_VR_OBS_VAL",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: RADS_V_URBAN_VR_OBS_VAL')

      rc=nf90_def_var(fid,"RADS_V_URBAN_NMB_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: RADS_V_URBAN_NMB_ENS_MN')

      rc=nf90_def_var(fid,"RADS_V_URBAN_RMSE_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: RADS_V_URBAN_RMSE_ENS_MN')

      rc=nf90_def_var(fid,"RADS_V_URBAN_RCOR_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: RADS_V_URBAN_RCOR_ENS_MN')

      rc=nf90_def_var(fid,"RADS_V_URBAN_MN_NPTS",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: RADS_V_URBAN_MN_NPTS')
!
! RURAL
      rc=nf90_def_var(fid,"RADS_V_RURAL_MN_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: RADS_V_RURAL_MN_ENS_MN')

      rc=nf90_def_var(fid,"RADS_V_RURAL_MN_OBS_VAL",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: RADS_V_RURAL_MN_OBS_VAL')

      rc=nf90_def_var(fid,"RADS_V_RURAL_VR_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: RADS_V_RURAL_VR_ENS_MN')

      rc=nf90_def_var(fid,"RADS_V_RURAL_VR_OBS_VAL",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: RADS_V_RURAL_VR_OBS_VAL')

      rc=nf90_def_var(fid,"RADS_V_RURAL_NMB_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: RADS_V_RURAL_NMB_ENS_MN')

      rc=nf90_def_var(fid,"RADS_V_RURAL_RMSE_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: RADS_V_RURAL_RMSE_ENS_MN')

      rc=nf90_def_var(fid,"RADS_V_RURAL_RCOR_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: RADS_V_RURAL_RCOR_ENS_MN')

      rc=nf90_def_var(fid,"RADS_V_RURAL_MN_NPTS",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: RADS_V_RURAL_MN_NPTS')
!
! CONUS Q
      rc=nf90_def_var(fid,"RADS_Q_CONUS_MN_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: RADS_Q_CONUS_MN_ENS_MN')

      rc=nf90_def_var(fid,"RADS_Q_CONUS_MN_OBS_VAL",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: RADS_Q_CONUS_MN_OBS_VAL')

      rc=nf90_def_var(fid,"RADS_Q_CONUS_VR_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: RADS_Q_CONUS_VR_ENS_MN')

      rc=nf90_def_var(fid,"RADS_Q_CONUS_VR_OBS_VAL",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: RADS_Q_CONUS_VR_OBS_VAL')

      rc=nf90_def_var(fid,"RADS_Q_CONUS_NMB_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: RADS_Q_CONUS_NMB_ENS_MN')

      rc=nf90_def_var(fid,"RADS_Q_CONUS_RMSE_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: RADS_Q_CONUS_RMSE_ENS_MN')

      rc=nf90_def_var(fid,"RADS_Q_CONUS_RCOR_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: RADS_Q_CONUS_RCOR_ENS_MN')

      rc=nf90_def_var(fid,"RADS_Q_CONUS_MN_NPTS",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: Q_CONUS_MN_NPTS')
!
! URBAN
      rc=nf90_def_var(fid,"RADS_Q_URBAN_MN_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: RADS_Q_URBAN_MN_ENS_MN')

      rc=nf90_def_var(fid,"RADS_Q_URBAN_MN_OBS_VAL",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: RADS_Q_URBAN_MN_OBS_VAL')

      rc=nf90_def_var(fid,"RADS_Q_URBAN_VR_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: RADS_Q_URBAN_VR_ENS_MN')

      rc=nf90_def_var(fid,"RADS_Q_URBAN_VR_OBS_VAL",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: RADS_Q_URBAN_VR_OBS_VAL')

      rc=nf90_def_var(fid,"RADS_Q_URBAN_NMB_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: RADS_Q_URBAN_NMB_ENS_MN')

      rc=nf90_def_var(fid,"RADS_Q_URBAN_RMSE_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: RADS_Q_URBAN_RMSE_ENS_MN')

      rc=nf90_def_var(fid,"RADS_Q_URBAN_RCOR_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: RADS_Q_URBAN_RCOR_ENS_MN')

      rc=nf90_def_var(fid,"RADS_Q_URBAN_MN_NPTS",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: RADS_Q_URBAN_MN_NPTS')
!
! RURAL
      rc=nf90_def_var(fid,"RADS_Q_RURAL_MN_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: RADS_Q_RURAL_MN_ENS_MN')

      rc=nf90_def_var(fid,"RADS_Q_RURAL_MN_OBS_VAL",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: RADS_Q_RURAL_MN_OBS_VAL')

      rc=nf90_def_var(fid,"RADS_Q_RURAL_VR_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: RADS_Q_RURAL_VR_ENS_MN')

      rc=nf90_def_var(fid,"RADS_Q_RURAL_VR_OBS_VAL",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: RADS_Q_RURAL_VR_OBS_VAL')

      rc=nf90_def_var(fid,"RADS_Q_RURAL_NMB_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: RADS_Q_RURAL_NMB_ENS_MN')

      rc=nf90_def_var(fid,"RADS_Q_RURAL_RMSE_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: RADS_Q_RURAL_RMSE_ENS_MN')

      rc=nf90_def_var(fid,"RADS_Q_RURAL_RCOR_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: RADS_Q_RURAL_RCOR_ENS_MN')

      rc=nf90_def_var(fid,"RADS_Q_RURAL_MN_NPTS",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: RADS_Q_RURAL_MN_NPTS')
!
! TRACER-I: CO, O3, NO2, and SO2 for CONUS, URBAN, and RURAL against AIRNOW data
! CONUS CO
      rc=nf90_def_var(fid,"AIRN_CO_CONUS_MN_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: AIRN_CO_CONUS_MN_ENS_MN')

      rc=nf90_def_var(fid,"AIRN_CO_CONUS_MN_OBS_VAL",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: AIRN_CO_CONUS_MN_OBS_VAL')

      rc=nf90_def_var(fid,"AIRN_CO_CONUS_VR_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: AIRN_CO_CONUS_VR_ENS_MN')

      rc=nf90_def_var(fid,"AIRN_CO_CONUS_VR_OBS_VAL",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: AIRN_CO_CONUS_VR_OBS_VAL')

      rc=nf90_def_var(fid,"AIRN_CO_CONUS_NMB_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: AIRN_CO_CONUS_NMB_ENS_MN')

      rc=nf90_def_var(fid,"AIRN_CO_CONUS_RMSE_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: AIRN_CO_CONUS_RMSE_ENS_MN')

      rc=nf90_def_var(fid,"AIRN_CO_CONUS_RCOR_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: AIRN_CO_CONUS_RCOR_ENS_MN')

      rc=nf90_def_var(fid,"AIRN_CO_CONUS_MN_NPTS",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: AIRN_CO_CONUS_MN_NPTS')
!
! URBAN
      rc=nf90_def_var(fid,"AIRN_CO_URBAN_MN_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: AIRN_CO_URBAN_MN_ENS_MN')

      rc=nf90_def_var(fid,"AIRN_CO_URBAN_MN_OBS_VAL",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: AIRN_CO_URBAN_MN_OBS_VAL')

      rc=nf90_def_var(fid,"AIRN_CO_URBAN_VR_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: AIRN_CO_URBAN_VR_ENS_MN')

      rc=nf90_def_var(fid,"AIRN_CO_URBAN_VR_OBS_VAL",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: AIRN_CO_URBAN_VR_OBS_VAL')

      rc=nf90_def_var(fid,"AIRN_CO_URBAN_NMB_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: AIRN_CO_URBAN_NMB_ENS_MN')

      rc=nf90_def_var(fid,"AIRN_CO_URBAN_RMSE_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: AIRN_CO_URBAN_RMSE_ENS_MN')

      rc=nf90_def_var(fid,"AIRN_CO_URBAN_RCOR_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: AIRN_CO_URBAN_RCOR_ENS_MN')

      rc=nf90_def_var(fid,"AIRN_CO_URBAN_MN_NPTS",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: AIRN_CO_URBAN_MN_NPTS')
!
! RURAL
      rc=nf90_def_var(fid,"AIRN_CO_RURAL_MN_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: AIRN_CO_RURAL_MN_ENS_MN')

      rc=nf90_def_var(fid,"AIRN_CO_RURAL_MN_OBS_VAL",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: AIRN_CO_RURAL_MN_OBS_VAL')

      rc=nf90_def_var(fid,"AIRN_CO_RURAL_VR_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: AIRN_CO_RURAL_VR_ENS_MN')

      rc=nf90_def_var(fid,"AIRN_CO_RURAL_VR_OBS_VAL",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: AIRN_CO_RURAL_VR_OBS_VAL')

      rc=nf90_def_var(fid,"AIRN_CO_RURAL_NMB_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: AIRN_CO_RURAL_NMB_ENS_MN')

      rc=nf90_def_var(fid,"AIRN_CO_RURAL_RMSE_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: AIRN_CO_RURAL_RMSE_ENS_MN')

      rc=nf90_def_var(fid,"AIRN_CO_RURAL_RCOR_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: AIRN_CO_RURAL_RCOR_ENS_MN')

      rc=nf90_def_var(fid,"AIRN_CO_RURAL_MN_NPTS",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: AIRN_CO_RURAL_MN_NPTS')
!
! CONUS O3
      rc=nf90_def_var(fid,"AIRN_O3_CONUS_MN_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: AIRN_O3_CONUS_MN_ENS_MN')

      rc=nf90_def_var(fid,"AIRN_O3_CONUS_MN_OBS_VAL",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: AIRN_O3_CONUS_MN_OBS_VAL')

      rc=nf90_def_var(fid,"AIRN_O3_CONUS_VR_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: AIRN_O3_CONUS_VR_ENS_MN')

      rc=nf90_def_var(fid,"AIRN_O3_CONUS_VR_OBS_VAL",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: AIRN_O3_CONUS_VR_OBS_VAL')

      rc=nf90_def_var(fid,"AIRN_O3_CONUS_NMB_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: AIRN_O3_CONUS_NMB_ENS_MN')

      rc=nf90_def_var(fid,"AIRN_O3_CONUS_RMSE_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: AIRN_O3_CONUS_RMSE_ENS_MN')

      rc=nf90_def_var(fid,"AIRN_O3_CONUS_RCOR_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: AIRN_O3_CONUS_RCOR_ENS_MN')

      rc=nf90_def_var(fid,"AIRN_O3_CONUS_MN_NPTS",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: AIRN_O3_CONUS_MN_NPTS')
!
! URBAN
      rc=nf90_def_var(fid,"AIRN_O3_URBAN_MN_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: AIRN_O3_URBAN_MN_ENS_MN')

      rc=nf90_def_var(fid,"AIRN_O3_URBAN_MN_OBS_VAL",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: AIRN_O3_URBAN_MN_OBS_VAL')

      rc=nf90_def_var(fid,"AIRN_O3_URBAN_VR_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: AIRN_O3_URBAN_VR_ENS_MN')

      rc=nf90_def_var(fid,"AIRN_O3_URBAN_VR_OBS_VAL",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: AIRN_O3_URBAN_VR_OBS_VAL')

      rc=nf90_def_var(fid,"AIRN_O3_URBAN_NMB_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: AIRN_O3_URBAN_NMB_ENS_MN')

      rc=nf90_def_var(fid,"AIRN_O3_URBAN_RMSE_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: AIRN_O3_URBAN_RMSE_ENS_MN')

      rc=nf90_def_var(fid,"AIRN_O3_URBAN_RCOR_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: AIRN_O3_URBAN_RCOR_ENS_MN')

      rc=nf90_def_var(fid,"AIRN_O3_URBAN_MN_NPTS",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: AIRN_O3_URBAN_MN_NPTS')
!
! RURAL
      rc=nf90_def_var(fid,"AIRN_O3_RURAL_MN_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: AIRN_O3_RURAL_MN_ENS_MN')

      rc=nf90_def_var(fid,"AIRN_O3_RURAL_MN_OBS_VAL",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: AIRN_O3_RURAL_MN_OBS_VAL')

      rc=nf90_def_var(fid,"AIRN_O3_RURAL_VR_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: AIRN_O3_RURAL_VR_ENS_MN')

      rc=nf90_def_var(fid,"AIRN_O3_RURAL_VR_OBS_VAL",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: AIRN_O3_RURAL_VR_OBS_VAL')

      rc=nf90_def_var(fid,"AIRN_O3_RURAL_NMB_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: AIRN_O3_RURAL_NMB_ENS_MN')

      rc=nf90_def_var(fid,"AIRN_O3_RURAL_RMSE_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: AIRN_O3_RURAL_RMSE_ENS_MN')

      rc=nf90_def_var(fid,"AIRN_O3_RURAL_RCOR_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: AIRN_O3_RURAL_RCOR_ENS_MN')

      rc=nf90_def_var(fid,"AIRN_O3_RURAL_MN_NPTS",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: AIRN_O3_RURAL_MN_NPTS')
!
! CONUS NO2
      rc=nf90_def_var(fid,"AIRN_NO2_CONUS_MN_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: AIRN_NO2_CONUS_MN_ENS_MN')

      rc=nf90_def_var(fid,"AIRN_NO2_CONUS_MN_OBS_VAL",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: AIRN_NO2_CONUS_MN_OBS_VAL')

      rc=nf90_def_var(fid,"AIRN_NO2_CONUS_VR_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: AIRN_NO2_CONUS_VR_ENS_MN')

      rc=nf90_def_var(fid,"AIRN_NO2_CONUS_VR_OBS_VAL",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: AIRN_NO2_CONUS_VR_OBS_VAL')

      rc=nf90_def_var(fid,"AIRN_NO2_CONUS_NMB_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: AIRN_NO2_CONUS_NMB_ENS_MN')

      rc=nf90_def_var(fid,"AIRN_NO2_CONUS_RMSE_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: AIRN_NO2_CONUS_RMSE_ENS_MN')

      rc=nf90_def_var(fid,"AIRN_NO2_CONUS_RCOR_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: AIRN_NO2_CONUS_RCOR_ENS_MN')

      rc=nf90_def_var(fid,"AIRN_NO2_CONUS_MN_NPTS",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: AIRN_NO2_CONUS_MN_NPTS')
!
! URBAN
      rc=nf90_def_var(fid,"AIRN_NO2_URBAN_MN_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: AIRN_NO2_URBAN_MN_ENS_MN')

      rc=nf90_def_var(fid,"AIRN_NO2_URBAN_MN_OBS_VAL",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: AIRN_NO2_URBAN_MN_OBS_VAL')

      rc=nf90_def_var(fid,"AIRN_NO2_URBAN_VR_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: AIRN_NO2_URBAN_VR_ENS_MN')

      rc=nf90_def_var(fid,"AIRN_NO2_URBAN_VR_OBS_VAL",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: AIRN_NO2_URBAN_VR_OBS_VAL')

      rc=nf90_def_var(fid,"AIRN_NO2_URBAN_NMB_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: AIRN_NO2_URBAN_NMB_ENS_MN')

      rc=nf90_def_var(fid,"AIRN_NO2_URBAN_RMSE_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: AIRN_NO2_URBAN_RMSE_ENS_MN')

      rc=nf90_def_var(fid,"AIRN_NO2_URBAN_RCOR_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: AIRN_NO2_URBAN_RCOR_ENS_MN')

      rc=nf90_def_var(fid,"AIRN_NO2_URBAN_MN_NPTS",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: AIRN_NO2_URBAN_MN_NPTS')
!
! RURAL
      rc=nf90_def_var(fid,"AIRN_NO2_RURAL_MN_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: AIRN_NO2_RURAL_MN_ENS_MN')

      rc=nf90_def_var(fid,"AIRN_NO2_RURAL_MN_OBS_VAL",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: AIRN_NO2_RURAL_MN_OBS_VAL')

      rc=nf90_def_var(fid,"AIRN_NO2_RURAL_VR_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: AIRN_NO2_RURAL_VR_ENS_MN')

      rc=nf90_def_var(fid,"AIRN_NO2_RURAL_VR_OBS_VAL",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: AIRN_NO2_RURAL_VR_OBS_VAL')

      rc=nf90_def_var(fid,"AIRN_NO2_RURAL_NMB_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: AIRN_NO2_RURAL_NMB_ENS_MN')

      rc=nf90_def_var(fid,"AIRN_NO2_RURAL_RMSE_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: AIRN_NO2_RURAL_RMSE_ENS_MN')

      rc=nf90_def_var(fid,"AIRN_NO2_RURAL_RCOR_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: AIRN_NO2_RURAL_RCOR_ENS_MN')

      rc=nf90_def_var(fid,"AIRN_NO2_RURAL_MN_NPTS",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: AIRN_NO2_RURAL_MN_NPTS')
!
! CONUS SO2
      rc=nf90_def_var(fid,"AIRN_SO2_CONUS_MN_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: AIRN_SO2_CONUS_MN_ENS_MN')

      rc=nf90_def_var(fid,"AIRN_SO2_CONUS_MN_OBS_VAL",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: AIRN_SO2_CONUS_MN_OBS_VAL')

      rc=nf90_def_var(fid,"AIRN_SO2_CONUS_VR_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: AIRN_SO2_CONUS_VR_ENS_MN')

      rc=nf90_def_var(fid,"AIRN_SO2_CONUS_VR_OBS_VAL",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: AIRN_SO2_CONUS_VR_OBS_VAL')

      rc=nf90_def_var(fid,"AIRN_SO2_CONUS_NMB_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: AIRN_SO2_CONUS_NMB_ENS_MN')

      rc=nf90_def_var(fid,"AIRN_SO2_CONUS_RMSE_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: AIRN_SO2_CONUS_RMSE_ENS_MN')

      rc=nf90_def_var(fid,"AIRN_SO2_CONUS_RCOR_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: AIRN_SO2_CONUS_RCOR_ENS_MN')

      rc=nf90_def_var(fid,"AIRN_SO2_CONUS_MN_NPTS",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: AIRN_SO2_CONUS_MN_NPTS')
!
! URBAN
      rc=nf90_def_var(fid,"AIRN_SO2_URBAN_MN_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: AIRN_SO2_URBAN_MN_ENS_MN')

      rc=nf90_def_var(fid,"AIRN_SO2_URBAN_MN_OBS_VAL",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: AIRN_SO2_URBAN_MN_OBS_VAL')

      rc=nf90_def_var(fid,"AIRN_SO2_URBAN_VR_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: AIRN_SO2_URBAN_VR_ENS_MN')

      rc=nf90_def_var(fid,"AIRN_SO2_URBAN_VR_OBS_VAL",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: AIRN_SO2_URBAN_VR_OBS_VAL')

      rc=nf90_def_var(fid,"AIRN_SO2_URBAN_NMB_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: AIRN_SO2_URBAN_NMB_ENS_MN')

      rc=nf90_def_var(fid,"AIRN_SO2_URBAN_RMSE_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: AIRN_SO2_URBAN_RMSE_ENS_MN')

      rc=nf90_def_var(fid,"AIRN_SO2_URBAN_RCOR_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: AIRN_SO2_URBAN_RCOR_ENS_MN')

      rc=nf90_def_var(fid,"AIRN_SO2_URBAN_MN_NPTS",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: AIRN_SO2_URBAN_MN_NPTS')
!
! RURAL
      rc=nf90_def_var(fid,"AIRN_SO2_RURAL_MN_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: AIRN_SO2_RURAL_MN_ENS_MN')

      rc=nf90_def_var(fid,"AIRN_SO2_RURAL_MN_OBS_VAL",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: AIRN_SO2_RURAL_MN_OBS_VAL')

      rc=nf90_def_var(fid,"AIRN_SO2_RURAL_VR_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: AIRN_SO2_RURAL_VR_ENS_MN')

      rc=nf90_def_var(fid,"AIRN_SO2_RURAL_VR_OBS_VAL",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: AIRN_SO2_RURAL_VR_OBS_VAL')

      rc=nf90_def_var(fid,"AIRN_SO2_RURAL_NMB_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: AIRN_SO2_RURAL_NMB_ENS_MN')

      rc=nf90_def_var(fid,"AIRN_SO2_RURAL_RMSE_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: AIRN_SO2_RURAL_RMSE_ENS_MN')

      rc=nf90_def_var(fid,"AIRN_SO2_RURAL_RCOR_ENS_MN",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: AIRN_SO2_RURAL_RCOR_ENS_MN')

      rc=nf90_def_var(fid,"AIRN_SO2_RURAL_MN_NPTS",NF90_FLOAT,(/scl_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: AIRN_SO2_RURAL_MN_NPTS')
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

   subroutine spatial_mean_and_variance(fld_prior_ens_mn,fld_post_ens_mn,fld_incr, &
   fld_prior_ens_vr,fld_post_ens_vr,fld_prior_infl,fld_post_infl,fld_prior_emn_rmn, &
   fld_post_emn_rmn,fld_incr_rmn,fld_prior_evr_rmn,fld_post_evr_rmn,fld_prior_infl_rmn, &
   fld_post_infl_rmn,fld_region_ii,fld_region_jj,num_region,npts_region,ncnt_region,nx,ny,nz)
   implicit none
      integer                                         :: i,j,k,irgn,ipt
      integer                                         :: nx,ny,nz,num_region,npts_region
      integer,dimension(num_region)                   :: ncnt_region
      integer,dimension(num_region,npts_region)       :: fld_region_ii,fld_region_jj
      real                                            :: wt
      real,dimension(nz)                              :: zwt
      real,dimension(nz)                              :: fld_prior_emn_rmn,fld_post_emn_rmn,fld_incr_rmn      
      real,dimension(nz)                              :: fld_prior_evr_rmn,fld_post_evr_rmn      
      real,dimension(nz)                              :: fld_prior_infl_rmn,fld_post_infl_rmn      
      real,dimension(nx,ny,nz)                        :: fld_prior_ens_mn,fld_post_ens_mn,fld_incr
      real,dimension(nx,ny,nz)                        :: fld_prior_ens_vr,fld_post_ens_vr
      real,dimension(nx,ny,nz)                        :: fld_prior_infl,fld_post_infl
      fld_prior_emn_rmn(:)=0.
      fld_post_emn_rmn(:)=0.
      fld_incr_rmn(:)=0.
      fld_prior_evr_rmn(:)=0.
      fld_post_evr_rmn(:)=0.
      fld_prior_infl_rmn(:)=0.
      fld_post_infl_rmn(:)=0.
!
      zwt(:)=0.
      do irgn=1,num_region
         do ipt=1,ncnt_region(irgn)
            i=fld_region_ii(irgn,ipt)
            j=fld_region_jj(irgn,ipt)
            wt=1.
            do k=1,nz
               fld_prior_emn_rmn(k)=fld_prior_emn_rmn(k)+wt*fld_prior_ens_mn(i,j,k)
               fld_post_emn_rmn(k)=fld_post_emn_rmn(k)+wt*fld_post_ens_mn(i,j,k)
               fld_incr_rmn(k)=fld_incr_rmn(k)+wt*fld_incr(i,j,k)
               fld_prior_evr_rmn(k)=fld_prior_evr_rmn(k)+wt*fld_prior_ens_vr(i,j,k)
               fld_post_evr_rmn(k)=fld_post_evr_rmn(k)+wt*fld_post_ens_vr(i,j,k) 
               fld_prior_infl_rmn(k)=fld_prior_infl_rmn(k)+wt*fld_prior_infl(i,j,k)
               fld_post_infl_rmn(k)=fld_post_infl_rmn(k)+wt*fld_post_infl(i,j,k)
              zwt(k)=zwt(k)+wt
            enddo
         enddo
      enddo
      do k=1,nz
         fld_prior_emn_rmn(k)=fld_prior_emn_rmn(k)/zwt(k)
         fld_post_emn_rmn(k)=fld_post_emn_rmn(k)/zwt(k)
         fld_incr_rmn(k)=fld_incr_rmn(k)/zwt(k)
         fld_prior_evr_rmn(k)=fld_prior_evr_rmn(k)/zwt(k)
         fld_post_evr_rmn(k)=fld_post_evr_rmn(k)/zwt(k)
         fld_prior_infl_rmn(k)=fld_prior_infl_rmn(k)/zwt(k)
         fld_post_infl_rmn(k)=fld_post_infl_rmn(k)/zwt(k)
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
   
!-------------------------------------------------------------------------------

   subroutine get_obs_seq_ens(file_in,obs_type,max_nobs,num_mems, &
   type_sav,type_lon,type_lat,type_vert,type_obs_val,type_err_var, &
   type_eval_prior_mn,type_eval_post_mn,type_eval_prior_sd,type_eval_post_sd, &
   type_eval_prior_mem,type_eval_post_mem)
      implicit none
      integer                                      :: ipt,irec,imem,num_mems,obs_rec
      integer                                      :: iunit,nobs_kind,num_copies,num_qc, &
                                                      first_obs,last_obs,ncep_qc,dart_qc,kind_id, &
                                                      nid,isav,obs_sec_skip,obs_day_skip, &
                                                      npr_int,npr_adj,npr_trop,npr_tot, &
                                                      rec_skip,max_nobs,num_obs,max_num_obs
      integer,allocatable,dimension(:)             :: obs_kind_id
      real                                         :: qc_crit,airn_cnt,rads_cnt,obs_val, &
                                                      prior_mean,post_mean,prior_sdev, &
                                                      post_sdev,x_rad,y_rad,z_var,z_id, &
                                                      err_var_skip,lon_obs,lat_obs,pi,rad2deg
      real,allocatable,dimension(:)                :: prior_exp_ob,post_exp_ob,prs,prior, &
                                                      avgk,scwt
      character(*)                                 :: obs_type
      character(len=50)                            :: file_type,obs_kind_defn,chr_num_obs, &
                                                      chr_max_num_obs,meta_data,chr_first_obs, &
                                                      chr_last_obs,chr_obsdef,chr_locxd,chr_kind, &
                                                      chr_num_copies,chr_num_qc,chr_obs
      character(len=200)                           :: file_in
      character(len=50),allocatable,dimension(:)   :: obs_kind
!
! OBS TO SAVE
      integer                                      :: type_sav
      integer,dimension(max_nobs)                  :: type_obs_sec,type_obs_day
      real,dimension(max_nobs)                     :: type_err_var,type_obs_val,type_eval_prior_mn, &
                                                      type_eval_prior_sd,type_eval_post_mn, &
                                                      type_eval_post_sd,type_lon,type_lat,type_vert
      real,dimension(max_nobs,num_mems)            :: type_eval_prior_mem,type_eval_post_mem
!
! Initialize arrays
      iunit=50
      qc_crit=1
      type_sav=0
      pi=4.*atan(1.)
      rad2deg=180./pi
!      print *, 'FIND OBS TYPE ',trim(obs_type)     
      open(unit=iunit,form='formatted',file=trim(file_in)) 
!
! Read data
      read(iunit,*) file_type
!      print *, trim(file_type)
      read(iunit,*) obs_kind_defn
!      print *, trim(obs_kind_defn)
! Read number of observations types      
      read(iunit,*) nobs_kind
!      print *, nobs_kind
      allocate(obs_kind_id(nobs_kind))
      allocate(obs_kind(nobs_kind))
!
! Read obs_ids and obs_kinds      
      do irec=1,nobs_kind
         read(iunit,*) obs_kind_id(irec),obs_kind(irec)
!         print *,'obs_id, obs_kind ',obs_kind_id(irec),trim(obs_kind(irec))
      enddo
!
! Read num_copies and num_qc
      read(iunit,*) chr_num_copies,num_copies,chr_num_qc,num_qc
!      print *, trim(chr_num_copies),num_copies,trim(chr_num_qc),num_qc
!
! Read num_obs and max_num_obs
      read(iunit,*) chr_num_obs,num_obs,chr_max_num_obs,max_num_obs
!      print *, trim(chr_num_obs),num_obs,trim(chr_max_num_obs),max_num_obs
!
! Read num_copies meta data
      do irec=1,num_copies
         read(iunit,*) meta_data
!         print *, trim(meta_data)
      enddo
!
! Read num_qc meta data
      do irec=1,num_qc
         read(iunit,*) meta_data
!         print *, trim(meta_data)
      enddo
!
! Read first and last
      read(iunit,*) chr_first_obs,first_obs,chr_last_obs,last_obs
!      print *, trim(chr_first_obs),first_obs,trim(chr_last_obs),last_obs
!
! Read the observation data
      allocate(prior_exp_ob(num_mems))      
      allocate(post_exp_ob(num_mems))      
      do irec=1,num_obs
!         print *, 'Reading obs_seq.final obs record ',irec
         read(iunit,*) chr_obs,obs_rec
!         print *, 'APM: ',trim(chr_obs),obs_rec
!
! Read observation data
         read(iunit,*), obs_val  
!         print *, obs_val
         read(iunit,*), prior_mean  
!         print *, prior_mean
         read(iunit,*), post_mean  
!         print *, post_mean
         read(iunit,*), prior_sdev  
!         print *, prior_sdev
         read(iunit,*), post_sdev 
!         print *, post_sdev
         do imem=1,num_mems
            read(iunit,*), prior_exp_ob(imem)  
!            print *, prior_exp_ob(imem)
            read(iunit,*), post_exp_ob(imem)
!            print *, post_exp_ob(imem)
         enddo
! Read qc data
         read(iunit,*), ncep_qc  
!         print *, ncep_qc
         read(iunit,*), dart_qc  
!         print *, dart_qc
!
! Skip record
         read(iunit,*)
!
! Read chr_obsdef
         read(iunit,*) chr_obsdef
!         print *, trim(chr_obsdef)
!
! Read chr_locxd
         read(iunit,*) chr_locxd
!         print *, trim(chr_locxd)
!
! Read either 2D or 3D location data         
         select case (trim(chr_locxd))
         case('loc2d')
            read(iunit,*),x_rad,y_rad
!            print *, x_rad,y_rad
         case('loc3d')
            read(iunit,*),x_rad,y_rad,z_var,z_id
!            print *,'x_rad,y_rad,z_var,z_id ',x_rad,y_rad,z_var,z_id
         end select
         lon_obs=x_rad*rad2deg
         lat_obs=y_rad*rad2deg
!
! Read chr_kind
         read(iunit,*) chr_kind
!         print *, trim(chr_kind)
! Read kind_id         
         read(iunit,*) kind_id
!         print *, kind_id
!
! Test whether kind_id is an obs_kind to be saved
!         print *,'REC 1 ',irec,kind_id         
         do nid=1,nobs_kind
            if(obs_kind_id(nid) .eq. kind_id) then
!
! Select case for save_obs_kind
               if((trim(obs_type).eq.trim(obs_kind(nid))) .and. &
               (dart_qc.eq.0 .or. dart_qc.eq.1)) then
                  select case (trim(obs_kind(nid)))
                  case('AIRNOW_CO', &
                     'AIRNOW_O3', &
                     'AIRNOW_NO2', &
                     'AIRNOW_SO2')
!
! Save this obs type
                     type_sav=type_sav+1                 
! Read time data 
                     read(iunit,*) type_obs_sec(type_sav),type_obs_day(type_sav)
! Read obervation error variance 
                     read(iunit,*) type_err_var(type_sav)
!
! Save the ensemble data
                     type_obs_val(type_sav)=obs_val
                     type_lon(type_sav)=lon_obs
                     type_lat(type_sav)=lat_obs
                     type_vert(type_sav)=z_var
                     type_eval_prior_mn(type_sav)=prior_mean
                     type_eval_prior_sd(type_sav)=prior_sdev
                     type_eval_post_mn(type_sav)=post_mean
                     type_eval_post_sd(type_sav)=post_sdev
                     do imem=1,num_mems
                        type_eval_prior_mem(type_sav,imem)=prior_exp_ob(imem)
                        type_eval_post_mem(type_sav,imem)=post_exp_ob(imem)
                     enddo
                     exit
                  case('RADIOSONDE_U_WIND_COMPONENT', &
                  'RADIOSONDE_V_WIND_COMPONENT', &
                  'RADIOSONDE_TEMPERATURE', &
                  'RADIOSONDE_SPECIFIC_HUMIDITY')
!
! Save this obs type
                     type_sav=type_sav+1
! Read time data 
                     read(iunit,*) type_obs_sec(type_sav),type_obs_day(type_sav)
! Read obervation error variance 
                     read(iunit,*) type_err_var(type_sav)
!
! Save the ensemble data
                     type_obs_val(type_sav)=obs_val
                     type_lon(type_sav)=lon_obs
                     type_lat(type_sav)=lat_obs
                     type_vert(type_sav)=z_var
                     type_eval_prior_mn(type_sav)=prior_mean
                     type_eval_prior_sd(type_sav)=prior_sdev
                     type_eval_post_mn(type_sav)=post_mean
                     type_eval_post_sd(type_sav)=post_sdev
                     do imem=1,num_mems
                        type_eval_prior_mem(type_sav,imem)=prior_exp_ob(imem)
                        type_eval_post_mem(type_sav,imem)=post_exp_ob(imem)
                     enddo
                     exit
                  end select
!
! Cases to skip
               else
                  select case (trim(obs_kind(nid)))
                  case('RADIOSONDE_U_WIND_COMPONENT', &
                  'RADIOSONDE_V_WIND_COMPONENT', &
                  'RADIOSONDE_TEMPERATURE', &
                  'RADIOSONDE_SPECIFIC_HUMIDITY', &
                  'AIRCRAFT_U_WIND_COMPONENT', &
                  'AIRCRAFT_V_WIND_COMPONENT', &
                  'AIRCRAFT_TEMPERATURE', &
                  'ACARS_U_WIND_COMPONENT', &
                  'ACARS_V_WIND_COMPONENT', &
                  'ACARS_TEMPERATURE',&
                  'MARINE_SFC_U_WIND_COMPONENT', &
                  'MARINE_SFC_V_WIND_COMPONENT', &
                  'MARINE_SFC_TEMPERATURE', &
                  'MARINE_SFC_SPECIFIC_HUMIDITY', &
                  'LAND_SFC_U_WIND_COMPONENT', &
                  'LAND_SFC_V_WIND_COMPONENT', &
                  'LAND_SFC_TEMPERATURE', &
                  'LAND_SFC_SPECIFIC_HUMIDITY', &
                  'SAT_U_WIND_COMPONENT', &
                  'SAT_V_WIND_COMPONENT', &
                  'RADIOSONDE_SURFACE_ALTIMETER', &
                  'MARINE_SFC_ALTIMETER', &
                  'LAND_SFC_ALTIMETER', &
                  'AIRNOW_CO', &
                  'AIRNOW_O3', &
                  'AIRNOW_NO2', &
                  'AIRNOW_SO2')
!! Skip time data 
                     read(iunit,*) obs_sec_skip,obs_day_skip
! Skip obervation error variance 
                     read(iunit,*) err_var_skip
                     exit
                  case('MOPITT_V9_CO_PROFILE')
!                  print *, trim(obs_kind(nid))
!
! Read number of vertical levels
                     read(iunit,*) npr_adj
!                     print *, npr_adj
                     read(iunit,*) npr_tot
!                     print *, npr_tot
                     npr_int=npr_adj
!
! Read meta data
                     allocate(prs(npr_int+1))                  
                     allocate(prior(npr_int))                  
                     allocate(avgk(npr_int))                  
                     read(iunit,*) prs(1:npr_int+1)
                     read(iunit,*) prior(1:npr_int)
                     read(iunit,*) avgk(1:npr_int)
                     read(iunit,*) rec_skip
                     read(iunit,*) obs_sec_skip,obs_day_skip
                     read(iunit,*) err_var_skip
                     deallocate(prs)                  
                     deallocate(prior)                  
                     deallocate(avgk)                  
                     exit
                  case('OMI_O3_PROFILE')
!                  print *, trim(obs_kind(nid))
!
! Read number of vertical levels
                     read(iunit,*) npr_tot
!                     print *, npr_tot
                     read(iunit,*) npr_adj
!                     print *, npr_adj
                     read(iunit,*) npr_adj
!                     print *, npr_adj
                     npr_int=npr_tot
!
! Read meta data
                     allocate(prs(npr_int+1))                  
                     allocate(prior(npr_int))                  
                     allocate(avgk(npr_int))                  
                     read(iunit,*) prs(1:npr_int+1)
                     read(iunit,*) prior(1:npr_int)
                     read(iunit,*) avgk(1:npr_int)
                     read(iunit,*) rec_skip
                     read(iunit,*) obs_sec_skip,obs_day_skip
                     read(iunit,*) err_var_skip
                     deallocate(prs)                  
                     deallocate(prior)                  
                     deallocate(avgk)                  
                     exit
                  case('OMI_NO2_DOMINO_TROP_COL')
!                  print *, trim(obs_kind(nid))
!
! Read number of vertical levels
                     read(iunit,*) npr_tot
!                     print *, npr_tot
                     read(iunit,*) npr_trop
!                     print *, npr_trop
                     npr_int=npr_tot
!
! Read meta data
                     allocate(prs(npr_int+1))                  
                     allocate(scwt(npr_int))                  
                     read(iunit,*) prs(1:npr_int+1)
                     read(iunit,*) scwt(1:npr_int)
                     read(iunit,*) rec_skip
                     read(iunit,*) obs_sec_skip,obs_day_skip
                     read(iunit,*) err_var_skip
                     deallocate(prs)                  
                     deallocate(scwt)                  
                     exit
                  case('OMI_SO2_PBL_COL')
!                  print *, trim(obs_kind(nid))
!
! Read number of vertical levels
                     read(iunit,*) npr_tot
!                     print *, npr_tot
                     read(iunit,*) npr_trop
!                     print *, npr_trop
                     npr_int=npr_tot
!
! Read meta data
                     allocate(prs(npr_int+1))                  
                     allocate(scwt(npr_int))                  
                     read(iunit,*) prs(1:npr_int+1)
                     read(iunit,*) scwt(1:npr_int)
                     read(iunit,*) rec_skip
                     read(iunit,*) obs_sec_skip,obs_day_skip
                     read(iunit,*) err_var_skip
                     deallocate(prs)                  
                     deallocate(scwt)                  
                     exit
                  case('GOME2A_NO2_TROP_COL')
!                  print *, trim(obs_kind(nid))
!
! Read number of vertical levels
                     read(iunit,*) npr_tot
!                     print *, npr_tot
                     read(iunit,*) npr_trop
!                     print *, npr_trop
                     npr_int=npr_tot
!
! Read meta data
                     allocate(prs(npr_int+1))                  
                     allocate(scwt(npr_int))                  
                     read(iunit,*) prs(1:npr_int+1)
                     read(iunit,*) scwt(1:npr_int)
                     read(iunit,*) rec_skip
                     read(iunit,*) obs_sec_skip,obs_day_skip
                     read(iunit,*) err_var_skip
                     deallocate(prs)                  
                     deallocate(scwt)                  
                     exit
                  case('SCIAM_NO2_TROP_COL')
!                  print *, trim(obs_kind(nid))
!
! Read number of vertical levels
                     read(iunit,*) npr_tot
!                     print *, npr_tot
                     read(iunit,*) npr_trop
!                     print *, npr_trop
                     npr_int=npr_tot
!
! Read meta data
                     allocate(prs(npr_int+1))                  
                     allocate(scwt(npr_int))                  
                     read(iunit,*) prs(1:npr_int+1)
                     read(iunit,*) scwt(1:npr_int)
                     read(iunit,*) rec_skip
                     read(iunit,*) obs_sec_skip,obs_day_skip
                     read(iunit,*) err_var_skip
                     deallocate(prs)                  
                     deallocate(scwt)                  
                     exit
                  case('TES_CO_PROFILE')
!                  print *, trim(obs_kind(nid))
!
! Read number of vertical levels
                     read(iunit,*) npr_tot
                     print *, npr_tot
                     read(iunit,*) npr_adj
                     print *, npr_adj
                     read(iunit,*) npr_adj
                     print *, npr_adj
                     npr_int=npr_tot
                     print *, 'npr_int ',npr_int
!
! Read meta data
                     allocate(prs(npr_int))
                     allocate(prior(npr_int))
                     allocate(avgk(npr_int))
                     read(iunit,*) prs(1:npr_int)
                     read(iunit,*) prior(1:npr_int)
                     read(iunit,*) avgk(1:npr_int)
                     read(iunit,*) rec_skip
                     read(iunit,*) obs_sec_skip,obs_day_skip
                     read(iunit,*) err_var_skip
                     deallocate(prs)
                     deallocate(prior)
                     deallocate(avgk)
                     exit
                  case('TES_O3_PROFILE')
!                  print *, trim(obs_kind(nid))
!
! Read number of vertical levels
                     read(iunit,*) npr_tot
!                     print *, npr_tot
                     read(iunit,*) npr_adj
!                     print *, npr_adj
                     read(iunit,*) npr_adj
!                     print *, npr_adj
                     npr_int=npr_tot
!
! Read meta data
                     allocate(prs(npr_int))
                     allocate(prior(npr_int))
                     allocate(avgk(npr_int))
                     read(iunit,*) prs(1:npr_int)
                     read(iunit,*) prior(1:npr_int)
                     read(iunit,*) avgk(1:npr_int)
                     read(iunit,*) rec_skip
                     read(iunit,*) obs_sec_skip,obs_day_skip
                     read(iunit,*) err_var_skip
                     deallocate(prs)
                     deallocate(prior)
                     deallocate(avgk)
                     exit
                  case('MLS_O3_PROFILE')
!                  print *, trim(obs_kind(nid))
!
! Read number of vertical levels
                     read(iunit,*) npr_tot
!                     print *, npr_tot
                     read(iunit,*) npr_adj
!                     print *, npr_adj
                     read(iunit,*) npr_adj
!                     print *, npr_adj
                     npr_int=npr_tot
!
! Read meta data
                     allocate(prs(npr_int))
                     allocate(prior(npr_int))
                     allocate(avgk(npr_int))
                     read(iunit,*) prs(1:npr_int)
                     read(iunit,*) prior(1:npr_int)
                     read(iunit,*) avgk(1:npr_int)
                     read(iunit,*) rec_skip
                     read(iunit,*) obs_sec_skip,obs_day_skip
                     read(iunit,*) err_var_skip
                     deallocate(prs)
                     deallocate(prior)
                     deallocate(avgk)
                     exit
                  case('MLS_HNO3_PROFILE')
!                  print *, trim(obs_kind(nid))
!
! Read number of vertical levels
                     read(iunit,*) npr_tot
!                     print *, npr_tot
                     read(iunit,*) npr_adj
!                     print *, npr_adj
                     read(iunit,*) npr_adj
!                     print *, npr_adj
                     npr_int=npr_tot
!
! Read meta data
                     allocate(prs(npr_int))
                     allocate(prior(npr_int))
                     allocate(avgk(npr_int))
                     read(iunit,*) prs(1:npr_int)
                     read(iunit,*) prior(1:npr_int)
                     read(iunit,*) avgk(1:npr_int)
                     read(iunit,*) rec_skip
                     read(iunit,*) obs_sec_skip,obs_day_skip
                     read(iunit,*) err_var_skip
                     deallocate(prs)
                     deallocate(prior)
                     deallocate(avgk)
                     exit
                  end select
               endif              
            else if(nid .eq. nobs_kind) then
               print *, 'ERROR: OBS_KIND_ID NOT FOUND ',trim(obs_kind(nid))
               call abort
            endif
         enddo
      enddo
      close(iunit)
      deallocate(obs_kind_id)
      deallocate(obs_kind)
      deallocate(prior_exp_ob)
      deallocate(post_exp_ob)
!      print *, 'NUM TYPE SAV ',type_sav
!      do ipt=1,type_sav
!         print *,ipt,type_lon(ipt),type_lat(ipt),type_vert(ipt),type_obs_val(ipt)
!      enddo
      return
   end subroutine get_obs_seq_ens

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

!-------------------------------------------------------------------------------

subroutine get_platform_i_j(plat_i,plat_j,plat_lon,plat_lat,max_nobs,plat_npts,lon,lat, &
nx,ny)
   implicit none
   integer                       :: max_nobs,plat_npts,nx,ny
   integer                       :: ipt,i_rnd,j_rnd
   integer,dimension(max_nobs)   :: plat_i,plat_j    
   real                          :: truelat1,truelat2,ctrlon,ctrlat,delx
   real                          :: lon_fixed,lon11_fixed,xi,xj
   real,dimension(nx,ny)         :: lon,lat
   real,dimension(max_nobs)      :: plat_lon,plat_lat
!
   truelat1=33.
   truelat2=45.
   ctrlon=-97.70499
   ctrlon=ctrlon+360.
   ctrlat=39.67239
   delx=12000.
!
   do ipt=1,plat_npts
      lon_fixed=plat_lon(ipt)
      if(lon_fixed.le.0) lon_fixed=plat_lon(ipt)+360.
      lon11_fixed=lon(1,1)
      if(lon11_fixed.le.0) lon11_fixed=lon(1,1)+360.
      call w3fb13(xi,xj,plat_lat(ipt),lon_fixed,lat(1,1), &
      lon11_fixed,delx,ctrlon,truelat1,truelat2)
!      print *, 'plat_lon(ipt) ',plat_lon(ipt)
!      print *, 'plat_lat(ipt) ',plat_lat(ipt)
!      print *, 'lon(1,1)      ',lon(1,1)      
      i_rnd = nint(xi)
      j_rnd = nint(xj)
      if(i_rnd.lt.1 .or. i_rnd.gt.nx .or. &
      j_rnd.lt.1 .or. j_rnd.gt.ny) then
         print *, 'platform point not in TRACER-I domain ',i_rnd,j_rnd     
         stop
      endif   
      plat_i(ipt)=i_rnd
      plat_j(ipt)=j_rnd
   enddo
   return  
end subroutine get_platform_i_j
 
!-------------------------------------------------------------------------------

subroutine conus_ens_mn_skill_metrics(plat_mean_trc,plat_mean_obs,plat_vari_trc, &
plat_vari_obs,plat_nmb,plat_rmse,plat_rcor,conus_ii,conus_jj,num_conus,plat_val_trc, &
plat_val_obs,plat_i,plat_j,plat_npts,plat_vert,p_lay_bot,p_lay_top,conus_stpts, &
max_nobs,npts_conus)
   implicit none
   integer                          :: ipt,jpt,ncnt,conus_stpts,plat_npts
   integer                          :: num_conus,max_nobs,npts_conus
   integer,dimension(plat_npts)     :: conus_pt
   integer,dimension(npts_conus)    :: conus_ii,conus_jj
   integer,dimension(max_nobs)      :: plat_i,plat_j
   real                             :: plat_mean_inc,plat_mean_trc,plat_mean_obs
   real                             :: plat_vari_trc,plat_vari_obs
   real                             :: plat_nmb,plat_rmse,plat_rcor
   real                             :: plat_sums_trc,plat_sums_obs
   real                             :: p_lay_bot,p_lay_top
   real,dimension(max_nobs)         :: plat_val_trc,plat_val_obs,plat_vert
   real,dimension(max_nobs)         :: plat_val,plat_obs
!
! Find platform points in the CONUS domain and
! within the pressure layer of interest (p_lay_bot - p_lay_top)
   conus_stpts=0
   do ipt=1,plat_npts
      do jpt=1,num_conus
         if(plat_i(ipt).eq.conus_ii(jpt).and.plat_j(ipt).eq.conus_jj(jpt)) then
            if((plat_vert(ipt).le.p_lay_bot .and. plat_vert(ipt).ge.p_lay_top) .or. &
            (plat_vert(ipt).eq.1)) then
               conus_stpts=conus_stpts+1
               conus_pt(conus_stpts)=ipt
               exit
            endif
         endif
      enddo
   enddo
!
   if(conus_stpts.lt.2) then
      plat_mean_trc=-999
      plat_mean_obs=-999
      plat_vari_trc=-999
      plat_vari_obs=-999
      plat_nmb=-999
      plat_rmse=-999
      plat_rcor=-999
      return
   endif
!
! Calculate TRACER-I and OBS mean and NMB
   plat_mean_inc=0.
   plat_mean_trc=0.
   plat_mean_obs=0.
   ncnt=0
   do ipt=1,conus_stpts
      plat_mean_inc=plat_mean_inc+plat_val_trc(conus_pt(ipt))-plat_val_obs(conus_pt(ipt))
      plat_mean_trc=plat_mean_trc+plat_val_trc(conus_pt(ipt))
      plat_mean_obs=plat_mean_obs+plat_val_obs(conus_pt(ipt))
      ncnt=ncnt+1
   enddo
   plat_nmb=plat_mean_inc/plat_mean_obs*100.
   plat_mean_trc=plat_mean_trc/real(ncnt)
   plat_mean_obs=plat_mean_obs/real(ncnt)
!   print *, plat_nmb,plat_mean_trc,plat_mean_obs
!
! Calculate TRACER-I and OBS variance and NMB
   plat_rmse=0.
   plat_vari_trc=0.
   plat_vari_obs=0.
   ncnt=0
   do ipt=1,conus_stpts
      plat_rmse=plat_rmse+(plat_val_trc(conus_pt(ipt))-plat_val_obs(conus_pt(ipt)))**2.
      plat_vari_trc=plat_vari_trc+(plat_val_trc(conus_pt(ipt))-plat_mean_trc)**2.
      plat_vari_obs=plat_vari_obs+(plat_val_obs(conus_pt(ipt))-plat_mean_obs)**2.
      ncnt=ncnt+1
   enddo
   plat_rmse=sqrt(plat_rmse/real(ncnt))
   plat_vari_trc=plat_vari_trc/real(ncnt-1)
   plat_vari_obs=plat_vari_obs/real(ncnt-1)
!   print *, plat_rmse,plat_vari_trc,plat_vari_obs
!
! Calculate Pearson correlation coefficient
   plat_rcor=0.
   plat_sums_trc=0.
   plat_sums_obs=0.
   ncnt=0
   do ipt=1,conus_stpts
      plat_rcor=plat_rcor+(plat_val_trc(conus_pt(ipt))-plat_mean_trc)* &
      (plat_val_obs(conus_pt(ipt))-plat_mean_obs)
      plat_sums_trc=plat_sums_trc+(plat_val_trc(conus_pt(ipt))-plat_mean_trc)**2
      plat_sums_obs=plat_sums_obs+(plat_val_obs(conus_pt(ipt))-plat_mean_obs)**2
      ncnt=ncnt+1
   enddo
   plat_rcor=plat_rcor/sqrt(plat_sums_trc)/sqrt(plat_sums_obs)
!   print *, plat_rcor
   return
end subroutine conus_ens_mn_skill_metrics
!-------------------------------------------------------------------------------

subroutine urban_ens_mn_skill_metrics(plat_mean_trc,plat_mean_obs,plat_vari_trc, &
plat_vari_obs,plat_nmb,plat_rmse,plat_rcor,urban_ii,urban_jj,num_urban,plat_val_trc, &
plat_val_obs,plat_i,plat_j,plat_npts,plat_vert,p_lay_bot,p_lay_top,urban_stpts, &
max_nobs,npts_urban,num_cities)
   implicit none
   integer                                    :: ipt,jpt,icty,ncnt,plat_npts,iskip
   integer                                    :: max_nobs,npts_urban,urban_stpts,num_cities
   integer,dimension(plat_npts)               :: urban_pt
   integer,dimension(num_cities)              :: num_urban
   integer,dimension(num_cities,npts_urban)   :: urban_ii,urban_jj
   integer,dimension(max_nobs)                :: plat_i,plat_j
   real                                       :: plat_mean_inc,plat_mean_trc,plat_mean_obs
   real                                       :: plat_vari_trc,plat_vari_obs
   real                                       :: plat_nmb,plat_rmse,plat_rcor
   real                                       :: plat_sums_trc,plat_sums_obs
   real                                       :: p_lay_bot,p_lay_top
   real,dimension(max_nobs)                   :: plat_val_trc,plat_val_obs,plat_vert
   real,dimension(max_nobs)                   :: plat_val,plat_obs
!
! Find platform points in the URBAN domain and within
! the pressure layer of interest (p_lay_bot - p_lay_top)   
   urban_stpts=0
   do ipt=1,plat_npts
      iskip=0
      do icty=1,num_cities
         do jpt=1,num_urban(icty)
            if(plat_i(ipt).eq.urban_ii(icty,jpt).and.plat_j(ipt).eq.urban_jj(icty,jpt)) then
               if((plat_vert(ipt).le.p_lay_bot .and. plat_vert(ipt).ge.p_lay_top) .or. &
               (plat_vert(ipt).eq.1)) then
                  urban_stpts=urban_stpts+1
                  urban_pt(urban_stpts)=ipt
                  iskip=1
                  exit
               endif
            endif
         enddo
         if(iskip.eq.1) exit
      enddo
   enddo
!
   if(urban_stpts.lt.2) then
      plat_mean_trc=-999
      plat_mean_obs=-999
      plat_vari_trc=-999
      plat_vari_obs=-999
      plat_nmb=-999
      plat_rmse=-999
      plat_rcor=-999
      return
   endif
!
! Calculate TRACER-I and OBS mean and NMB
   plat_mean_inc=0.
   plat_mean_trc=0.
   plat_mean_obs=0.
   ncnt=0
   do ipt=1,urban_stpts
      plat_mean_inc=plat_mean_inc+plat_val_trc(urban_pt(ipt))-plat_val_obs(urban_pt(ipt))
      plat_mean_trc=plat_mean_trc+plat_val_trc(urban_pt(ipt))
      plat_mean_obs=plat_mean_obs+plat_val_obs(urban_pt(ipt))
      ncnt=ncnt+1
   enddo
   plat_nmb=plat_mean_inc/plat_mean_obs*100.
   plat_mean_trc=plat_mean_trc/real(ncnt)
   plat_mean_obs=plat_mean_obs/real(ncnt)
!   print *, plat_nmb,plat_mean_trc,plat_mean_obs
!
! Calculate TRACER-I and OBS variance and NMB
   plat_rmse=0.
   plat_vari_trc=0.
   plat_vari_obs=0.
   ncnt=0
   do ipt=1,urban_stpts
      plat_rmse=plat_rmse+(plat_val_trc(urban_pt(ipt))-plat_val_obs(urban_pt(ipt)))**2.
      plat_vari_trc=plat_vari_trc+(plat_val_trc(urban_pt(ipt))-plat_mean_trc)**2.
      plat_vari_obs=plat_vari_obs+(plat_val_obs(urban_pt(ipt))-plat_mean_obs)**2.
      ncnt=ncnt+1
   enddo
   plat_rmse=sqrt(plat_rmse/real(ncnt))
   plat_vari_trc=plat_vari_trc/real(ncnt-1)
   plat_vari_obs=plat_vari_obs/real(ncnt-1)
!   print *, plat_rmse,plat_vari_trc,plat_vari_obs
!
! Calculate Pearson correlation coefficient
   plat_rcor=0.
   plat_sums_trc=0.
   plat_sums_obs=0.
   ncnt=0
   do ipt=1,urban_stpts
      plat_rcor=plat_rcor+(plat_val_trc(urban_pt(ipt))-plat_mean_trc)* &
      (plat_val_obs(urban_pt(ipt))-plat_mean_obs)
      plat_sums_trc=plat_sums_trc+(plat_val_trc(urban_pt(ipt))-plat_mean_trc)**2
      plat_sums_obs=plat_sums_obs+(plat_val_obs(urban_pt(ipt))-plat_mean_obs)**2
      ncnt=ncnt+1
   enddo
   plat_rcor=plat_rcor/sqrt(plat_sums_trc)/sqrt(plat_sums_obs)
!   print *, plat_rcor
   return
end subroutine urban_ens_mn_skill_metrics
!-------------------------------------------------------------------------------

subroutine rural_ens_mn_skill_metrics(plat_mean_trc,plat_mean_obs,plat_vari_trc, &
plat_vari_obs,plat_nmb,plat_rmse,plat_rcor,rural_ii,rural_jj,num_rural,plat_val_trc, &
plat_val_obs,plat_i,plat_j,plat_npts,plat_vert,p_lay_bot,p_lay_top,rural_stpts, &
max_nobs,npts_rural)
   implicit none
   integer                          :: ipt,jpt,ncnt,rural_stpts,plat_npts
   integer                          :: num_rural,max_nobs,npts_rural
   integer,dimension(plat_npts)     :: rural_pt
   integer,dimension(npts_rural)    :: rural_ii,rural_jj
   integer,dimension(max_nobs)      :: plat_i,plat_j
   real                             :: plat_mean_inc,plat_mean_trc,plat_mean_obs
   real                             :: plat_vari_trc,plat_vari_obs
   real                             :: plat_nmb,plat_rmse,plat_rcor
   real                             :: plat_sums_trc,plat_sums_obs
   real                             :: p_lay_bot,p_lay_top
   real,dimension(max_nobs)         :: plat_val_trc,plat_val_obs,plat_vert
   real,dimension(max_nobs)         :: plat_val,plat_obs
!
! Find platform points in the RURAL domain and
! within the pressure layer of interest (p_lay_bot - p_lay_top)   
   rural_stpts=0
   do ipt=1,plat_npts
      do jpt=1,num_rural
         if(plat_i(ipt).eq.rural_ii(jpt).and.plat_j(ipt).eq.rural_jj(jpt)) then
            if((plat_vert(ipt).le.p_lay_bot .and. plat_vert(ipt).ge.p_lay_top) .or. &
            (plat_vert(ipt).eq.1)) then
               rural_stpts=rural_stpts+1
               rural_pt(rural_stpts)=ipt
               exit
            endif
         endif
      enddo
   enddo
!
   if(rural_stpts.lt.2) then
      plat_mean_trc=-999
      plat_mean_obs=-999
      plat_vari_trc=-999
      plat_vari_obs=-999
      plat_nmb=-999
      plat_rmse=-999
      plat_rcor=-999
      return
   endif
!
! Calculate TRACER-I and OBS mean and NMB
   plat_mean_inc=0.
   plat_mean_trc=0.
   plat_mean_obs=0.
   ncnt=0
   do ipt=1,rural_stpts
      plat_mean_inc=plat_mean_inc+plat_val_trc(rural_pt(ipt))-plat_val_obs(rural_pt(ipt))
      plat_mean_trc=plat_mean_trc+plat_val_trc(rural_pt(ipt))
      plat_mean_obs=plat_mean_obs+plat_val_obs(rural_pt(ipt))
      ncnt=ncnt+1
   enddo
   plat_nmb=plat_mean_inc/plat_mean_obs*100.
   plat_mean_trc=plat_mean_trc/real(ncnt)
   plat_mean_obs=plat_mean_obs/real(ncnt)
!   print *, plat_nmb,plat_mean_trc,plat_mean_obs
!
! Calculate TRACER-I and OBS variance and NMB
   plat_rmse=0.
   plat_vari_trc=0.
   plat_vari_obs=0.
   ncnt=0
   do ipt=1,rural_stpts
      plat_rmse=plat_rmse+(plat_val_trc(rural_pt(ipt))-plat_val_obs(rural_pt(ipt)))**2.
      plat_vari_trc=plat_vari_trc+(plat_val_trc(rural_pt(ipt))-plat_mean_trc)**2.
      plat_vari_obs=plat_vari_obs+(plat_val_obs(rural_pt(ipt))-plat_mean_obs)**2.
      ncnt=ncnt+1
   enddo
   plat_rmse=sqrt(plat_rmse/real(ncnt))
   plat_vari_trc=plat_vari_trc/real(ncnt-1)
   plat_vari_obs=plat_vari_obs/real(ncnt-1)
!   print *, plat_rmse,plat_vari_trc,plat_vari_obs
!
! Calculate Pearson correlation coefficient
   plat_rcor=0.
   plat_sums_trc=0.
   plat_sums_obs=0.
   ncnt=0
   do ipt=1,rural_stpts
      plat_rcor=plat_rcor+(plat_val_trc(rural_pt(ipt))-plat_mean_trc)* &
      (plat_val_obs(rural_pt(ipt))-plat_mean_obs)
      plat_sums_trc=plat_sums_trc+(plat_val_trc(rural_pt(ipt))-plat_mean_trc)**2
      plat_sums_obs=plat_sums_obs+(plat_val_obs(rural_pt(ipt))-plat_mean_obs)**2
      ncnt=ncnt+1
   enddo
   plat_rcor=plat_rcor/sqrt(plat_sums_trc)/sqrt(plat_sums_obs)
!   print *, plat_rcor
   return
end subroutine rural_ens_mn_skill_metrics
