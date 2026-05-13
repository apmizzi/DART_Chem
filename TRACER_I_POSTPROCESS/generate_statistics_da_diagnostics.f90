  program main
      implicit none
!
      integer                                         :: i,j,k
      integer                                         :: nx,ny,nz,num_mems,nz_chemi,nz_fire
      integer                                         :: npts_conus,npts_urban,npts_rural
      integer                                         :: num_conus,num_rural,num_cities
      integer                                         :: unit,date_traceri
      integer                                         :: yyyy_traceri,mm_traceri,dd_traceri,hh_traceri
      integer,allocatable,dimension(:)                :: num_urban
      integer,allocatable,dimension(:)                :: traceri_conus_ii,traceri_conus_jj
      integer,allocatable,dimension(:)                :: traceri_rural_ii,traceri_rural_jj
      integer,allocatable,dimension(:,:)              :: traceri_urban_ii,traceri_urban_jj
      real                                            :: ptop,tbase,kappa
      real,allocatable,dimension(:)                   :: traceri_znu
      real,allocatable,dimension(:,:)                 :: traceri_lon,traceri_lat,traceri_mub
      real,allocatable,dimension(:,:,:)               :: traceri_p
      real,allocatable,dimension(:,:,:)               :: temp_fld1,temp_fld2,temp_fld3,temp_fld4
      real,allocatable,dimension(:,:,:)               :: temp_fld5,temp_fld6,temp_fld7,temp_fld8
!
! T arrays
      real,allocatable,dimension(:)                   :: t_ens_mn_prior_conus_mn,t_ens_mn_post_conus_mn
      real,allocatable,dimension(:)                   :: t_incr_conus_mn
      real,allocatable,dimension(:)                   :: t_ens_sd_prior_conus_mn,t_ens_sd_post_conus_mn
      real,allocatable,dimension(:)                   :: t_ens_vr_prior_conus_mn,t_ens_vr_post_conus_mn
      real,allocatable,dimension(:)                   :: t_infl_prior_conus_mn,t_infl_post_conus_mn
      real,allocatable,dimension(:)                   :: t_ens_mn_prior_urban_mn,t_ens_mn_post_urban_mn
      real,allocatable,dimension(:)                   :: t_incr_urban_mn
      real,allocatable,dimension(:)                   :: t_ens_sd_prior_urban_mn,t_ens_sd_post_urban_mn
      real,allocatable,dimension(:)                   :: t_ens_vr_prior_urban_mn,t_ens_vr_post_urban_mn
      real,allocatable,dimension(:)                   :: t_infl_prior_urban_mn,t_infl_post_urban_mn
      real,allocatable,dimension(:)                   :: t_ens_mn_prior_rural_mn,t_ens_mn_post_rural_mn
      real,allocatable,dimension(:)                   :: t_incr_rural_mn
      real,allocatable,dimension(:)                   :: t_ens_sd_prior_rural_mn,t_ens_sd_post_rural_mn
      real,allocatable,dimension(:)                   :: t_ens_vr_prior_rural_mn,t_ens_vr_post_rural_mn
      real,allocatable,dimension(:)                   :: t_infl_prior_rural_mn,t_infl_post_rural_mn
      real,allocatable,dimension(:,:,:)               :: traceri_t_prior_ens_mn,traceri_t_post_ens_mn
      real,allocatable,dimension(:,:,:)               :: traceri_t_incr
      real,allocatable,dimension(:,:,:)               :: traceri_t_prior_ens_sd,traceri_t_post_ens_sd
      real,allocatable,dimension(:,:,:)               :: traceri_t_prior_ens_vr,traceri_t_post_ens_vr
      real,allocatable,dimension(:,:,:)               :: traceri_t_infl_prior,traceri_t_infl_post
!
! U arrays
      real,allocatable,dimension(:)                   :: u_ens_mn_prior_conus_mn,u_ens_mn_post_conus_mn
      real,allocatable,dimension(:)                   :: u_incr_conus_mn
      real,allocatable,dimension(:)                   :: u_ens_sd_prior_conus_mn,u_ens_sd_post_conus_mn
      real,allocatable,dimension(:)                   :: u_ens_vr_prior_conus_mn,u_ens_vr_post_conus_mn
      real,allocatable,dimension(:)                   :: u_infl_prior_conus_mn,u_infl_post_conus_mn
      real,allocatable,dimension(:)                   :: u_ens_mn_prior_urban_mn,u_ens_mn_post_urban_mn
      real,allocatable,dimension(:)                   :: u_incr_urban_mn
      real,allocatable,dimension(:)                   :: u_ens_sd_prior_urban_mn,u_ens_sd_post_urban_mn
      real,allocatable,dimension(:)                   :: u_ens_vr_prior_urban_mn,u_ens_vr_post_urban_mn
      real,allocatable,dimension(:)                   :: u_infl_prior_urban_mn,u_infl_post_urban_mn
      real,allocatable,dimension(:)                   :: u_ens_mn_prior_rural_mn,u_ens_mn_post_rural_mn
      real,allocatable,dimension(:)                   :: u_incr_rural_mn
      real,allocatable,dimension(:)                   :: u_ens_sd_prior_rural_mn,u_ens_sd_post_rural_mn
      real,allocatable,dimension(:)                   :: u_ens_vr_prior_rural_mn,u_ens_vr_post_rural_mn
      real,allocatable,dimension(:)                   :: u_infl_prior_rural_mn,u_infl_post_rural_mn
      real,allocatable,dimension(:,:,:)               :: traceri_u_prior_ens_mn,traceri_u_post_ens_mn
      real,allocatable,dimension(:,:,:)               :: traceri_u_incr
      real,allocatable,dimension(:,:,:)               :: traceri_u_prior_ens_sd,traceri_u_post_ens_sd
      real,allocatable,dimension(:,:,:)               :: traceri_u_prior_ens_vr,traceri_u_post_ens_vr
      real,allocatable,dimension(:,:,:)               :: traceri_u_infl_prior,traceri_u_infl_post
!
! V arrays
      real,allocatable,dimension(:)                   :: v_ens_mn_prior_conus_mn,v_ens_mn_post_conus_mn
      real,allocatable,dimension(:)                   :: v_incr_conus_mn
      real,allocatable,dimension(:)                   :: v_ens_sd_prior_conus_mn,v_ens_sd_post_conus_mn
      real,allocatable,dimension(:)                   :: v_ens_vr_prior_conus_mn,v_ens_vr_post_conus_mn
      real,allocatable,dimension(:)                   :: v_infl_prior_conus_mn,v_infl_post_conus_mn
      real,allocatable,dimension(:)                   :: v_ens_mn_prior_urban_mn,v_ens_mn_post_urban_mn
      real,allocatable,dimension(:)                   :: v_incr_urban_mn
      real,allocatable,dimension(:)                   :: v_ens_sd_prior_urban_mn,v_ens_sd_post_urban_mn
      real,allocatable,dimension(:)                   :: v_ens_vr_prior_urban_mn,v_ens_vr_post_urban_mn
      real,allocatable,dimension(:)                   :: v_infl_prior_urban_mn,v_infl_post_urban_mn
      real,allocatable,dimension(:)                   :: v_ens_mn_prior_rural_mn,v_ens_mn_post_rural_mn
      real,allocatable,dimension(:)                   :: v_incr_rural_mn
      real,allocatable,dimension(:)                   :: v_ens_sd_prior_rural_mn,v_ens_sd_post_rural_mn
      real,allocatable,dimension(:)                   :: v_ens_vr_prior_rural_mn,v_ens_vr_post_rural_mn
      real,allocatable,dimension(:)                   :: v_infl_prior_rural_mn,v_infl_post_rural_mn
      real,allocatable,dimension(:,:,:)               :: traceri_v_prior_ens_mn,traceri_v_post_ens_mn
      real,allocatable,dimension(:,:,:)               :: traceri_v_incr
      real,allocatable,dimension(:,:,:)               :: traceri_v_prior_ens_sd,traceri_v_post_ens_sd
      real,allocatable,dimension(:,:,:)               :: traceri_v_prior_ens_vr,traceri_v_post_ens_vr
      real,allocatable,dimension(:,:,:)               :: traceri_v_infl_prior,traceri_v_infl_post
!
! Q arrays
      real,allocatable,dimension(:)                   :: q_ens_mn_prior_conus_mn,q_ens_mn_post_conus_mn
      real,allocatable,dimension(:)                   :: q_incr_conus_mn
      real,allocatable,dimension(:)                   :: q_ens_sd_prior_conus_mn,q_ens_sd_post_conus_mn
      real,allocatable,dimension(:)                   :: q_ens_vr_prior_conus_mn,q_ens_vr_post_conus_mn
      real,allocatable,dimension(:)                   :: q_infl_prior_conus_mn,q_infl_post_conus_mn
      real,allocatable,dimension(:)                   :: q_ens_mn_prior_urban_mn,q_ens_mn_post_urban_mn
      real,allocatable,dimension(:)                   :: q_incr_urban_mn
      real,allocatable,dimension(:)                   :: q_ens_sd_prior_urban_mn,q_ens_sd_post_urban_mn
      real,allocatable,dimension(:)                   :: q_ens_vr_prior_urban_mn,q_ens_vr_post_urban_mn
      real,allocatable,dimension(:)                   :: q_infl_prior_urban_mn,q_infl_post_urban_mn
      real,allocatable,dimension(:)                   :: q_ens_mn_prior_rural_mn,q_ens_mn_post_rural_mn
      real,allocatable,dimension(:)                   :: q_incr_rural_mn
      real,allocatable,dimension(:)                   :: q_ens_sd_prior_rural_mn,q_ens_sd_post_rural_mn
      real,allocatable,dimension(:)                   :: q_ens_vr_prior_rural_mn,q_ens_vr_post_rural_mn
      real,allocatable,dimension(:)                   :: q_infl_prior_rural_mn,q_infl_post_rural_mn
      real,allocatable,dimension(:,:,:)               :: traceri_q_prior_ens_mn,traceri_q_post_ens_mn
      real,allocatable,dimension(:,:,:)               :: traceri_q_incr
      real,allocatable,dimension(:,:,:)               :: traceri_q_prior_ens_sd,traceri_q_post_ens_sd
      real,allocatable,dimension(:,:,:)               :: traceri_q_prior_ens_vr,traceri_q_post_ens_vr
      real,allocatable,dimension(:,:,:)               :: traceri_q_infl_prior,traceri_q_infl_post
!
! CO arrays
      real,allocatable,dimension(:)                   :: co_ens_mn_prior_conus_mn,co_ens_mn_post_conus_mn
      real,allocatable,dimension(:)                   :: co_incr_conus_mn
      real,allocatable,dimension(:)                   :: co_ens_sd_prior_conus_mn,co_ens_sd_post_conus_mn
      real,allocatable,dimension(:)                   :: co_ens_vr_prior_conus_mn,co_ens_vr_post_conus_mn
      real,allocatable,dimension(:)                   :: co_infl_prior_conus_mn,co_infl_post_conus_mn
      real,allocatable,dimension(:)                   :: co_ens_mn_prior_urban_mn,co_ens_mn_post_urban_mn
      real,allocatable,dimension(:)                   :: co_incr_urban_mn
      real,allocatable,dimension(:)                   :: co_ens_sd_prior_urban_mn,co_ens_sd_post_urban_mn
      real,allocatable,dimension(:)                   :: co_ens_vr_prior_urban_mn,co_ens_vr_post_urban_mn
      real,allocatable,dimension(:)                   :: co_infl_prior_urban_mn,co_infl_post_urban_mn
      real,allocatable,dimension(:)                   :: co_ens_mn_prior_rural_mn,co_ens_mn_post_rural_mn
      real,allocatable,dimension(:)                   :: co_incr_rural_mn
      real,allocatable,dimension(:)                   :: co_ens_sd_prior_rural_mn,co_ens_sd_post_rural_mn
      real,allocatable,dimension(:)                   :: co_ens_vr_prior_rural_mn,co_ens_vr_post_rural_mn
      real,allocatable,dimension(:)                   :: co_infl_prior_rural_mn,co_infl_post_rural_mn
      real,allocatable,dimension(:,:,:)               :: traceri_co_prior_ens_mn,traceri_co_post_ens_mn
      real,allocatable,dimension(:,:,:)               :: traceri_co_incr
      real,allocatable,dimension(:,:,:)               :: traceri_co_prior_ens_sd,traceri_co_post_ens_sd
      real,allocatable,dimension(:,:,:)               :: traceri_co_prior_ens_vr,traceri_co_post_ens_vr
      real,allocatable,dimension(:,:,:)               :: traceri_co_infl_prior,traceri_co_infl_post
!
! O3 arrays
      real,allocatable,dimension(:)                   :: o3_ens_mn_prior_conus_mn,o3_ens_mn_post_conus_mn
      real,allocatable,dimension(:)                   :: o3_incr_conus_mn
      real,allocatable,dimension(:)                   :: o3_ens_sd_prior_conus_mn,o3_ens_sd_post_conus_mn
      real,allocatable,dimension(:)                   :: o3_ens_vr_prior_conus_mn,o3_ens_vr_post_conus_mn
      real,allocatable,dimension(:)                   :: o3_infl_prior_conus_mn,o3_infl_post_conus_mn
      real,allocatable,dimension(:)                   :: o3_ens_mn_prior_urban_mn,o3_ens_mn_post_urban_mn
      real,allocatable,dimension(:)                   :: o3_incr_urban_mn
      real,allocatable,dimension(:)                   :: o3_ens_sd_prior_urban_mn,o3_ens_sd_post_urban_mn
      real,allocatable,dimension(:)                   :: o3_ens_vr_prior_urban_mn,o3_ens_vr_post_urban_mn
      real,allocatable,dimension(:)                   :: o3_infl_prior_urban_mn,o3_infl_post_urban_mn
      real,allocatable,dimension(:)                   :: o3_ens_mn_prior_rural_mn,o3_ens_mn_post_rural_mn
      real,allocatable,dimension(:)                   :: o3_incr_rural_mn
      real,allocatable,dimension(:)                   :: o3_ens_sd_prior_rural_mn,o3_ens_sd_post_rural_mn
      real,allocatable,dimension(:)                   :: o3_ens_vr_prior_rural_mn,o3_ens_vr_post_rural_mn
      real,allocatable,dimension(:)                   :: o3_infl_prior_rural_mn,o3_infl_post_rural_mn
      real,allocatable,dimension(:,:,:)               :: traceri_o3_prior_ens_mn,traceri_o3_post_ens_mn
      real,allocatable,dimension(:,:,:)               :: traceri_o3_incr
      real,allocatable,dimension(:,:,:)               :: traceri_o3_prior_ens_sd,traceri_o3_post_ens_sd
      real,allocatable,dimension(:,:,:)               :: traceri_o3_prior_ens_vr,traceri_o3_post_ens_vr
      real,allocatable,dimension(:,:,:)               :: traceri_o3_infl_prior,traceri_o3_infl_post
!
! NO2 arrays
      real,allocatable,dimension(:)                   :: no2_ens_mn_prior_conus_mn,no2_ens_mn_post_conus_mn
      real,allocatable,dimension(:)                   :: no2_incr_conus_mn
      real,allocatable,dimension(:)                   :: no2_ens_sd_prior_conus_mn,no2_ens_sd_post_conus_mn
      real,allocatable,dimension(:)                   :: no2_ens_vr_prior_conus_mn,no2_ens_vr_post_conus_mn
      real,allocatable,dimension(:)                   :: no2_infl_prior_conus_mn,no2_infl_post_conus_mn
      real,allocatable,dimension(:)                   :: no2_ens_mn_prior_urban_mn,no2_ens_mn_post_urban_mn
      real,allocatable,dimension(:)                   :: no2_incr_urban_mn
      real,allocatable,dimension(:)                   :: no2_ens_sd_prior_urban_mn,no2_ens_sd_post_urban_mn
      real,allocatable,dimension(:)                   :: no2_ens_vr_prior_urban_mn,no2_ens_vr_post_urban_mn
      real,allocatable,dimension(:)                   :: no2_infl_prior_urban_mn,no2_infl_post_urban_mn
      real,allocatable,dimension(:)                   :: no2_ens_mn_prior_rural_mn,no2_ens_mn_post_rural_mn
      real,allocatable,dimension(:)                   :: no2_incr_rural_mn
      real,allocatable,dimension(:)                   :: no2_ens_sd_prior_rural_mn,no2_ens_sd_post_rural_mn
      real,allocatable,dimension(:)                   :: no2_ens_vr_prior_rural_mn,no2_ens_vr_post_rural_mn
      real,allocatable,dimension(:)                   :: no2_infl_prior_rural_mn,no2_infl_post_rural_mn
      real,allocatable,dimension(:,:,:)               :: traceri_no2_prior_ens_mn,traceri_no2_post_ens_mn
      real,allocatable,dimension(:,:,:)               :: traceri_no2_incr
      real,allocatable,dimension(:,:,:)               :: traceri_no2_prior_ens_sd,traceri_no2_post_ens_sd
      real,allocatable,dimension(:,:,:)               :: traceri_no2_prior_ens_vr,traceri_no2_post_ens_vr
      real,allocatable,dimension(:,:,:)               :: traceri_no2_infl_prior,traceri_no2_infl_post
!
! SO2 arrays
      real,allocatable,dimension(:)                   :: so2_ens_mn_prior_conus_mn,so2_ens_mn_post_conus_mn
      real,allocatable,dimension(:)                   :: so2_incr_conus_mn
      real,allocatable,dimension(:)                   :: so2_ens_sd_prior_conus_mn,so2_ens_sd_post_conus_mn
      real,allocatable,dimension(:)                   :: so2_ens_vr_prior_conus_mn,so2_ens_vr_post_conus_mn
      real,allocatable,dimension(:)                   :: so2_infl_prior_conus_mn,so2_infl_post_conus_mn
      real,allocatable,dimension(:)                   :: so2_ens_mn_prior_urban_mn,so2_ens_mn_post_urban_mn
      real,allocatable,dimension(:)                   :: so2_incr_urban_mn
      real,allocatable,dimension(:)                   :: so2_ens_sd_prior_urban_mn,so2_ens_sd_post_urban_mn
      real,allocatable,dimension(:)                   :: so2_ens_vr_prior_urban_mn,so2_ens_vr_post_urban_mn
      real,allocatable,dimension(:)                   :: so2_infl_prior_urban_mn,so2_infl_post_urban_mn
      real,allocatable,dimension(:)                   :: so2_ens_mn_prior_rural_mn,so2_ens_mn_post_rural_mn
      real,allocatable,dimension(:)                   :: so2_incr_rural_mn
      real,allocatable,dimension(:)                   :: so2_ens_sd_prior_rural_mn,so2_ens_sd_post_rural_mn
      real,allocatable,dimension(:)                   :: so2_ens_vr_prior_rural_mn,so2_ens_vr_post_rural_mn
      real,allocatable,dimension(:)                   :: so2_infl_prior_rural_mn,so2_infl_post_rural_mn
      real,allocatable,dimension(:,:,:)               :: traceri_so2_prior_ens_mn,traceri_so2_post_ens_mn
      real,allocatable,dimension(:,:,:)               :: traceri_so2_incr
      real,allocatable,dimension(:,:,:)               :: traceri_so2_prior_ens_sd,traceri_so2_post_ens_sd
      real,allocatable,dimension(:,:,:)               :: traceri_so2_prior_ens_vr,traceri_so2_post_ens_vr
      real,allocatable,dimension(:,:,:)               :: traceri_so2_infl_prior,traceri_so2_infl_post
!
! E_CO arrays
      real,allocatable,dimension(:)                   :: e_co_ens_mn_prior_conus_mn,e_co_ens_mn_post_conus_mn
      real,allocatable,dimension(:)                   :: e_co_incr_conus_mn
      real,allocatable,dimension(:)                   :: e_co_ens_sd_prior_conus_mn,e_co_ens_sd_post_conus_mn
      real,allocatable,dimension(:)                   :: e_co_ens_vr_prior_conus_mn,e_co_ens_vr_post_conus_mn
      real,allocatable,dimension(:)                   :: e_co_infl_prior_conus_mn,e_co_infl_post_conus_mn
      real,allocatable,dimension(:)                   :: e_co_ens_mn_prior_urban_mn,e_co_ens_mn_post_urban_mn
      real,allocatable,dimension(:)                   :: e_co_incr_urban_mn
      real,allocatable,dimension(:)                   :: e_co_ens_sd_prior_urban_mn,e_co_ens_sd_post_urban_mn
      real,allocatable,dimension(:)                   :: e_co_ens_vr_prior_urban_mn,e_co_ens_vr_post_urban_mn
      real,allocatable,dimension(:)                   :: e_co_infl_prior_urban_mn,e_co_infl_post_urban_mn
      real,allocatable,dimension(:)                   :: e_co_ens_mn_prior_rural_mn,e_co_ens_mn_post_rural_mn
      real,allocatable,dimension(:)                   :: e_co_incr_rural_mn
      real,allocatable,dimension(:)                   :: e_co_ens_sd_prior_rural_mn,e_co_ens_sd_post_rural_mn
      real,allocatable,dimension(:)                   :: e_co_ens_vr_prior_rural_mn,e_co_ens_vr_post_rural_mn
      real,allocatable,dimension(:)                   :: e_co_infl_prior_rural_mn,e_co_infl_post_rural_mn
      real,allocatable,dimension(:,:,:)               :: traceri_e_co_prior_ens_mn,traceri_e_co_post_ens_mn
      real,allocatable,dimension(:,:,:)               :: traceri_e_co_incr
      real,allocatable,dimension(:,:,:)               :: traceri_e_co_prior_ens_sd,traceri_e_co_post_ens_sd
      real,allocatable,dimension(:,:,:)               :: traceri_e_co_prior_ens_vr,traceri_e_co_post_ens_vr
      real,allocatable,dimension(:,:,:)               :: traceri_e_co_infl_prior,traceri_e_co_infl_post
      real,allocatable,dimension(:,:,:)               :: traceri_e_co_arc_prior
      real,allocatable,dimension(:)                   :: e_co_arc_prior_conus_mn
      real,allocatable,dimension(:)                   :: e_co_arc_prior_urban_mn
      real,allocatable,dimension(:)                   :: e_co_arc_prior_rural_mn
!
! E_NO2 arrays
      real,allocatable,dimension(:)                   :: e_no2_ens_mn_prior_conus_mn,e_no2_ens_mn_post_conus_mn
      real,allocatable,dimension(:)                   :: e_no2_incr_conus_mn
      real,allocatable,dimension(:)                   :: e_no2_ens_sd_prior_conus_mn,e_no2_ens_sd_post_conus_mn
      real,allocatable,dimension(:)                   :: e_no2_ens_vr_prior_conus_mn,e_no2_ens_vr_post_conus_mn
      real,allocatable,dimension(:)                   :: e_no2_infl_prior_conus_mn,e_no2_infl_post_conus_mn
      real,allocatable,dimension(:)                   :: e_no2_ens_mn_prior_urban_mn,e_no2_ens_mn_post_urban_mn
      real,allocatable,dimension(:)                   :: e_no2_incr_urban_mn
      real,allocatable,dimension(:)                   :: e_no2_ens_sd_prior_urban_mn,e_no2_ens_sd_post_urban_mn
      real,allocatable,dimension(:)                   :: e_no2_ens_vr_prior_urban_mn,e_no2_ens_vr_post_urban_mn
      real,allocatable,dimension(:)                   :: e_no2_infl_prior_urban_mn,e_no2_infl_post_urban_mn
      real,allocatable,dimension(:)                   :: e_no2_ens_mn_prior_rural_mn,e_no2_ens_mn_post_rural_mn
      real,allocatable,dimension(:)                   :: e_no2_incr_rural_mn
      real,allocatable,dimension(:)                   :: e_no2_ens_sd_prior_rural_mn,e_no2_ens_sd_post_rural_mn
      real,allocatable,dimension(:)                   :: e_no2_ens_vr_prior_rural_mn,e_no2_ens_vr_post_rural_mn
      real,allocatable,dimension(:)                   :: e_no2_infl_prior_rural_mn,e_no2_infl_post_rural_mn
      real,allocatable,dimension(:,:,:)               :: traceri_e_no2_prior_ens_mn,traceri_e_no2_post_ens_mn
      real,allocatable,dimension(:,:,:)               :: traceri_e_no2_incr
      real,allocatable,dimension(:,:,:)               :: traceri_e_no2_prior_ens_sd,traceri_e_no2_post_ens_sd
      real,allocatable,dimension(:,:,:)               :: traceri_e_no2_prior_ens_vr,traceri_e_no2_post_ens_vr
      real,allocatable,dimension(:,:,:)               :: traceri_e_no2_infl_prior,traceri_e_no2_infl_post
      real,allocatable,dimension(:,:,:)               :: traceri_e_no2_arc_prior
      real,allocatable,dimension(:)                   :: e_no2_arc_prior_conus_mn
      real,allocatable,dimension(:)                   :: e_no2_arc_prior_urban_mn
      real,allocatable,dimension(:)                   :: e_no2_arc_prior_rural_mn
!
! E_SO2 arrays
      real,allocatable,dimension(:)                   :: e_so2_ens_mn_prior_conus_mn,e_so2_ens_mn_post_conus_mn
      real,allocatable,dimension(:)                   :: e_so2_incr_conus_mn
      real,allocatable,dimension(:)                   :: e_so2_ens_sd_prior_conus_mn,e_so2_ens_sd_post_conus_mn
      real,allocatable,dimension(:)                   :: e_so2_ens_vr_prior_conus_mn,e_so2_ens_vr_post_conus_mn
      real,allocatable,dimension(:)                   :: e_so2_infl_prior_conus_mn,e_so2_infl_post_conus_mn
      real,allocatable,dimension(:)                   :: e_so2_ens_mn_prior_urban_mn,e_so2_ens_mn_post_urban_mn
      real,allocatable,dimension(:)                   :: e_so2_incr_urban_mn
      real,allocatable,dimension(:)                   :: e_so2_ens_sd_prior_urban_mn,e_so2_ens_sd_post_urban_mn
      real,allocatable,dimension(:)                   :: e_so2_ens_vr_prior_urban_mn,e_so2_ens_vr_post_urban_mn
      real,allocatable,dimension(:)                   :: e_so2_infl_prior_urban_mn,e_so2_infl_post_urban_mn
      real,allocatable,dimension(:)                   :: e_so2_ens_mn_prior_rural_mn,e_so2_ens_mn_post_rural_mn
      real,allocatable,dimension(:)                   :: e_so2_incr_rural_mn
      real,allocatable,dimension(:)                   :: e_so2_ens_sd_prior_rural_mn,e_so2_ens_sd_post_rural_mn
      real,allocatable,dimension(:)                   :: e_so2_ens_vr_prior_rural_mn,e_so2_ens_vr_post_rural_mn
      real,allocatable,dimension(:)                   :: e_so2_infl_prior_rural_mn,e_so2_infl_post_rural_mn
      real,allocatable,dimension(:,:,:)               :: traceri_e_so2_prior_ens_mn,traceri_e_so2_post_ens_mn
      real,allocatable,dimension(:,:,:)               :: traceri_e_so2_incr
      real,allocatable,dimension(:,:,:)               :: traceri_e_so2_prior_ens_sd,traceri_e_so2_post_ens_sd
      real,allocatable,dimension(:,:,:)               :: traceri_e_so2_prior_ens_vr,traceri_e_so2_post_ens_vr
      real,allocatable,dimension(:,:,:)               :: traceri_e_so2_infl_prior,traceri_e_so2_infl_post
      real,allocatable,dimension(:,:,:)               :: traceri_e_so2_arc_prior
      real,allocatable,dimension(:)                   :: e_so2_arc_prior_conus_mn
      real,allocatable,dimension(:)                   :: e_so2_arc_prior_urban_mn
      real,allocatable,dimension(:)                   :: e_so2_arc_prior_rural_mn
!
! EBU_IN_CO arrays
      real,allocatable,dimension(:)                   :: ebu_in_co_ens_mn_prior_conus_mn,ebu_in_co_ens_mn_post_conus_mn
      real,allocatable,dimension(:)                   :: ebu_in_co_incr_conus_mn
      real,allocatable,dimension(:)                   :: ebu_in_co_ens_sd_prior_conus_mn,ebu_in_co_ens_sd_post_conus_mn
      real,allocatable,dimension(:)                   :: ebu_in_co_ens_vr_prior_conus_mn,ebu_in_co_ens_vr_post_conus_mn
      real,allocatable,dimension(:)                   :: ebu_in_co_infl_prior_conus_mn,ebu_in_co_infl_post_conus_mn
      real,allocatable,dimension(:)                   :: ebu_in_co_ens_mn_prior_urban_mn,ebu_in_co_ens_mn_post_urban_mn
      real,allocatable,dimension(:)                   :: ebu_in_co_incr_urban_mn
      real,allocatable,dimension(:)                   :: ebu_in_co_ens_sd_prior_urban_mn,ebu_in_co_ens_sd_post_urban_mn
      real,allocatable,dimension(:)                   :: ebu_in_co_ens_vr_prior_urban_mn,ebu_in_co_ens_vr_post_urban_mn
      real,allocatable,dimension(:)                   :: ebu_in_co_infl_prior_urban_mn,ebu_in_co_infl_post_urban_mn
      real,allocatable,dimension(:)                   :: ebu_in_co_ens_mn_prior_rural_mn,ebu_in_co_ens_mn_post_rural_mn
      real,allocatable,dimension(:)                   :: ebu_in_co_incr_rural_mn
      real,allocatable,dimension(:)                   :: ebu_in_co_ens_sd_prior_rural_mn,ebu_in_co_ens_sd_post_rural_mn
      real,allocatable,dimension(:)                   :: ebu_in_co_ens_vr_prior_rural_mn,ebu_in_co_ens_vr_post_rural_mn
      real,allocatable,dimension(:)                   :: ebu_in_co_infl_prior_rural_mn,ebu_in_co_infl_post_rural_mn
      real,allocatable,dimension(:,:,:)               :: traceri_ebu_in_co_prior_ens_mn,traceri_ebu_in_co_post_ens_mn
      real,allocatable,dimension(:,:,:)               :: traceri_ebu_in_co_incr
      real,allocatable,dimension(:,:,:)               :: traceri_ebu_in_co_prior_ens_sd,traceri_ebu_in_co_post_ens_sd
      real,allocatable,dimension(:,:,:)               :: traceri_ebu_in_co_prior_ens_vr,traceri_ebu_in_co_post_ens_vr
      real,allocatable,dimension(:,:,:)               :: traceri_ebu_in_co_infl_prior,traceri_ebu_in_co_infl_post
      real,allocatable,dimension(:,:,:)               :: traceri_ebu_in_co_arc_prior
      real,allocatable,dimension(:)                   :: ebu_in_co_arc_prior_conus_mn
      real,allocatable,dimension(:)                   :: ebu_in_co_arc_prior_urban_mn
      real,allocatable,dimension(:)                   :: ebu_in_co_arc_prior_rural_mn
!
! EBU_IN_NO2 arrays
      real,allocatable,dimension(:)                   :: ebu_in_no2_ens_mn_prior_conus_mn,ebu_in_no2_ens_mn_post_conus_mn
      real,allocatable,dimension(:)                   :: ebu_in_no2_incr_conus_mn
      real,allocatable,dimension(:)                   :: ebu_in_no2_ens_sd_prior_conus_mn,ebu_in_no2_ens_sd_post_conus_mn
      real,allocatable,dimension(:)                   :: ebu_in_no2_ens_vr_prior_conus_mn,ebu_in_no2_ens_vr_post_conus_mn
      real,allocatable,dimension(:)                   :: ebu_in_no2_infl_prior_conus_mn,ebu_in_no2_infl_post_conus_mn
      real,allocatable,dimension(:)                   :: ebu_in_no2_ens_mn_prior_urban_mn,ebu_in_no2_ens_mn_post_urban_mn
      real,allocatable,dimension(:)                   :: ebu_in_no2_incr_urban_mn
      real,allocatable,dimension(:)                   :: ebu_in_no2_ens_sd_prior_urban_mn,ebu_in_no2_ens_sd_post_urban_mn
      real,allocatable,dimension(:)                   :: ebu_in_no2_ens_vr_prior_urban_mn,ebu_in_no2_ens_vr_post_urban_mn
      real,allocatable,dimension(:)                   :: ebu_in_no2_infl_prior_urban_mn,ebu_in_no2_infl_post_urban_mn
      real,allocatable,dimension(:)                   :: ebu_in_no2_ens_mn_prior_rural_mn,ebu_in_no2_ens_mn_post_rural_mn
      real,allocatable,dimension(:)                   :: ebu_in_no2_incr_rural_mn
      real,allocatable,dimension(:)                   :: ebu_in_no2_ens_sd_prior_rural_mn,ebu_in_no2_ens_sd_post_rural_mn
      real,allocatable,dimension(:)                   :: ebu_in_no2_ens_vr_prior_rural_mn,ebu_in_no2_ens_vr_post_rural_mn
      real,allocatable,dimension(:)                   :: ebu_in_no2_infl_prior_rural_mn,ebu_in_no2_infl_post_rural_mn
      real,allocatable,dimension(:,:,:)               :: traceri_ebu_in_no2_prior_ens_mn,traceri_ebu_in_no2_post_ens_mn
      real,allocatable,dimension(:,:,:)               :: traceri_ebu_in_no2_incr
      real,allocatable,dimension(:,:,:)               :: traceri_ebu_in_no2_prior_ens_sd,traceri_ebu_in_no2_post_ens_sd
      real,allocatable,dimension(:,:,:)               :: traceri_ebu_in_no2_prior_ens_vr,traceri_ebu_in_no2_post_ens_vr
      real,allocatable,dimension(:,:,:)               :: traceri_ebu_in_no2_infl_prior,traceri_ebu_in_no2_infl_post
      real,allocatable,dimension(:,:,:)               :: traceri_ebu_in_no2_arc_prior
      real,allocatable,dimension(:)                   :: ebu_in_no2_arc_prior_conus_mn
      real,allocatable,dimension(:)                   :: ebu_in_no2_arc_prior_urban_mn
      real,allocatable,dimension(:)                   :: ebu_in_no2_arc_prior_rural_mn
!
! EBU_IN_SO2 arrays
      real,allocatable,dimension(:)                   :: ebu_in_so2_ens_mn_prior_conus_mn,ebu_in_so2_ens_mn_post_conus_mn
      real,allocatable,dimension(:)                   :: ebu_in_so2_incr_conus_mn
      real,allocatable,dimension(:)                   :: ebu_in_so2_ens_sd_prior_conus_mn,ebu_in_so2_ens_sd_post_conus_mn
      real,allocatable,dimension(:)                   :: ebu_in_so2_ens_vr_prior_conus_mn,ebu_in_so2_ens_vr_post_conus_mn
      real,allocatable,dimension(:)                   :: ebu_in_so2_infl_prior_conus_mn,ebu_in_so2_infl_post_conus_mn
      real,allocatable,dimension(:)                   :: ebu_in_so2_ens_mn_prior_urban_mn,ebu_in_so2_ens_mn_post_urban_mn
      real,allocatable,dimension(:)                   :: ebu_in_so2_incr_urban_mn
      real,allocatable,dimension(:)                   :: ebu_in_so2_ens_sd_prior_urban_mn,ebu_in_so2_ens_sd_post_urban_mn
      real,allocatable,dimension(:)                   :: ebu_in_so2_ens_vr_prior_urban_mn,ebu_in_so2_ens_vr_post_urban_mn
      real,allocatable,dimension(:)                   :: ebu_in_so2_infl_prior_urban_mn,ebu_in_so2_infl_post_urban_mn
      real,allocatable,dimension(:)                   :: ebu_in_so2_ens_mn_prior_rural_mn,ebu_in_so2_ens_mn_post_rural_mn
      real,allocatable,dimension(:)                   :: ebu_in_so2_incr_rural_mn
      real,allocatable,dimension(:)                   :: ebu_in_so2_ens_sd_prior_rural_mn,ebu_in_so2_ens_sd_post_rural_mn
      real,allocatable,dimension(:)                   :: ebu_in_so2_ens_vr_prior_rural_mn,ebu_in_so2_ens_vr_post_rural_mn
      real,allocatable,dimension(:)                   :: ebu_in_so2_infl_prior_rural_mn,ebu_in_so2_infl_post_rural_mn
      real,allocatable,dimension(:,:,:)               :: traceri_ebu_in_so2_prior_ens_mn,traceri_ebu_in_so2_post_ens_mn
      real,allocatable,dimension(:,:,:)               :: traceri_ebu_in_so2_incr
      real,allocatable,dimension(:,:,:)               :: traceri_ebu_in_so2_prior_ens_sd,traceri_ebu_in_so2_post_ens_sd
      real,allocatable,dimension(:,:,:)               :: traceri_ebu_in_so2_prior_ens_vr,traceri_ebu_in_so2_post_ens_vr
      real,allocatable,dimension(:,:,:)               :: traceri_ebu_in_so2_infl_prior,traceri_ebu_in_so2_infl_post
      real,allocatable,dimension(:,:,:)               :: traceri_ebu_in_so2_arc_prior
      real,allocatable,dimension(:)                   :: ebu_in_so2_arc_prior_conus_mn
      real,allocatable,dimension(:)                   :: ebu_in_so2_arc_prior_urban_mn
      real,allocatable,dimension(:)                   :: ebu_in_so2_arc_prior_rural_mn
!
      character(len=200)                              :: strat_interp_map_file
      character(len=200)                              :: path_input,path_output,file_output
      character(len=200)                              :: file_input_prior_mn,file_input_prior_sd
      character(len=200)                              :: file_input_post_mn,file_input_post_sd
      character(len=200)                              :: file_input_infl_prior,file_input_infl_post
      character(len=200)                              :: file_read_prior_mn,file_read_prior_sd
      character(len=200)                              :: file_read_post_mn,file_read_post_sd
      character(len=200)                              :: file_read_infl_prior,file_read_infl_post
      character(len=200)                              :: file_read,file_write,file_strats
      character(len=200)                              :: path_input_arc_emis,file_input_arc_prior_chemi
      character(len=200)                              :: file_input_arc_prior_fire
      character(len=200)                              :: file_read_arc_prior_chemi,file_read_arc_prior_fire
!
      namelist/ens_da_diagnostics/date_traceri,path_input,path_output,file_strats, &
      file_input_prior_mn,file_input_post_mn,file_input_prior_sd,file_input_post_sd, &
      file_input_infl_prior,file_input_infl_post,file_output,nx,ny,nz,num_mems,nz_chemi, &
      nz_fire,path_input_arc_emis,file_input_arc_prior_chemi,file_input_arc_prior_fire
!     
      strat_interp_map_file="TRACER_I_Stratifications_Data"
      nx=440
      ny=284
      ptop=5000.
      tbase=290.
      kappa=0.286
      npts_conus=124960
      npts_urban=200
      npts_rural=124960
      num_cities=29
!
      unit=20
      open(unit=unit,file="ens_da_diagnostics.nl",form="formatted", &
      status="old",action="read")
      rewind(unit)
      read(unit,ens_da_diagnostics)
      close(unit)
!
!      print *, "NAMELIST: ens_da_diagnostics"
!      print *,"date traceri ",              date_traceri
!      print *,"path input ",                trim(path_input)
!      print *,"path output ",               trim(path_output)
!      print *,"file_input_prior_mn ",       trim(file_input_prior_mn)
!      print *,"file_input_prior_sd ",       trim(file_input_prior_sd)
!      print *,"file_input_post_mn " ,       trim(file_input_prior_mn)
!      print *,"file_input_post_sd ",        trim(file_input_prior_sd)
!      print *,"file_input_infl_prior ",     trim(file_input_infl_prior)
!      print *,"file_input_infl_post ",      trim(file_input_infl_post)
!      print *,"file output ",               trim(file_output)
!      print *,"nx ",                        nx
!      print *,"ny ",                        ny
!      print *,"nz ",                        nz
!      print *,"nz_chemi ",                  nz_chemi
!      print *,"nz_fire ",                   nz_fire
!      print *,"path_input_arc_emis ",       trim(path_input_arc_emis)
!      print *,"file_input_arc_prior_chemi ",trim(file_input_arc_prior_chemi)
!      print *,"file_input_arc_prior_fire ", trim(file_input_arc_prior_fire)
!
      yyyy_traceri=date_traceri/1000000
      mm_traceri=(date_traceri-yyyy_traceri*1000000)/10000
      dd_traceri=(date_traceri-yyyy_traceri*1000000-mm_traceri*10000)/100
      hh_traceri=date_traceri-yyyy_traceri*1000000-mm_traceri*10000-dd_traceri*100
!
! Read stratifications and interpolation mappings data
! TRACER I
      allocate(traceri_conus_ii(npts_conus))
      allocate(traceri_conus_jj(npts_conus))
!      print *, 'STRAT FILE ',trim(strat_interp_map_file)
      call get_WRFCHEM_fld_int(trim(strat_interp_map_file),"NUM_TRACER_I_CONUS",num_conus,1,1,1,1)
      call get_WRFCHEM_fld_int(trim(strat_interp_map_file),"TRACER_I_CONUS_II",traceri_conus_ii, &
      npts_conus,1,1,1)
      call get_WRFCHEM_fld_int(trim(strat_interp_map_file),"TRACER_I_CONUS_JJ",traceri_conus_jj, &
      npts_conus,1,1,1)
      allocate(num_urban(num_cities))
      allocate(traceri_urban_ii(num_cities,npts_urban))
      allocate(traceri_urban_jj(num_cities,npts_urban))
      call get_WRFCHEM_fld_int(trim(strat_interp_map_file),"NUM_TRACER_I_URBAN",num_urban,num_cities,1,1,1)
      call get_WRFCHEM_fld_int(trim(strat_interp_map_file),"TRACER_I_URBAN_II",traceri_urban_ii, &
      num_cities,npts_urban,1,1)
      call get_WRFCHEM_fld_int(trim(strat_interp_map_file),"TRACER_I_URBAN_JJ",traceri_urban_jj, &
      num_cities,npts_urban,1,1)
      allocate(traceri_rural_ii(npts_rural))
      allocate(traceri_rural_jj(npts_rural))
      call get_WRFCHEM_fld_int(trim(strat_interp_map_file),"NUM_TRACER_I_RURAL",num_rural,1,1,1,1)
      call get_WRFCHEM_fld_int(trim(strat_interp_map_file),"TRACER_I_RURAL_II",traceri_rural_ii, &
      npts_rural,1,1,1)
      call get_WRFCHEM_fld_int(trim(strat_interp_map_file),"TRACER_I_RURAL_JJ",traceri_rural_jj, &
      npts_rural,1,1,1)
!
! Create output NETCDF file
      file_write=trim(path_output)//"/"//trim(file_output)
!      print *, 'WRITE FILE  ',trim(file_write)
      call create_NETCDF_file(trim(file_write),nx,ny,nz,nz_chemi,nz_fire)
!
! Read TRACER I data
      file_read_arc_prior_chemi=trim(path_input_arc_emis)//"/"//trim(file_input_arc_prior_chemi)
      file_read_arc_prior_fire=trim(path_input_arc_emis)//"/"//trim(file_input_arc_prior_fire)
      file_read_prior_mn=trim(path_input)//"/"//trim(file_input_prior_mn)
      file_read_post_mn=trim(path_input)//"/"//trim(file_input_post_mn)
      file_read_prior_sd=trim(path_input)//"/"//trim(file_input_prior_sd)
      file_read_post_sd=trim(path_input)//"/"//trim(file_input_post_sd)
      file_read_infl_prior=trim(path_input)//"/"//trim(file_input_infl_prior)
      file_read_infl_post=trim(path_input)//"/"//trim(file_input_infl_post)
!
! Read lon, lat, and p
      allocate(traceri_lon(nx,ny))      
      allocate(traceri_lat(nx,ny))      
      allocate(traceri_znu(nz))      
      allocate(traceri_mub(nx,ny))      
      allocate(traceri_p(nx,ny,nz))
!      print *, 'READ FILE ',trim(file_read_prior_mn)
      call get_WRFCHEM_fld_real(trim(file_read_prior_mn),"XLONG",traceri_lon,nx,ny,1,1)
      call get_WRFCHEM_fld_real(trim(file_read_prior_mn),"XLAT",traceri_lat,nx,ny,1,1)
      call get_WRFCHEM_fld_real(trim(file_read_prior_mn),"MUB",traceri_mub,nx,ny,1,1) 
      call get_WRFCHEM_fld_real(trim(file_read_prior_mn),"ZNU",traceri_znu,nz,1,1,1)
!      print *, 'APM: Complete read lon,lat,mub,mu '
      do i=1,nx
         do j=1,ny
            do k=1,nz
               traceri_p(i,j,k)=traceri_znu(k)*traceri_mub(i,j)+ptop
            enddo
         enddo
      enddo
      deallocate(traceri_znu)
      deallocate(traceri_mub)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_LON", &
      "Degrees E - W",traceri_lon,nx,ny,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_LAT", &
      "Degrees S - N",traceri_lat,nx,ny,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_P", &
      "Pa bottom to top",traceri_p,nx,ny,nz)
!      print *, 'PRESSURE ',traceri_p(:,:,10)
!      print *, 'APM: Complete put lon,lat,mub,mu '
!
! Read and process T
!      
      allocate(traceri_t_prior_ens_mn(nx,ny,nz))
      allocate(traceri_t_post_ens_mn(nx,ny,nz))
      allocate(traceri_t_incr(nx,ny,nz))
      allocate(traceri_t_prior_ens_sd(nx,ny,nz))
      allocate(traceri_t_post_ens_sd(nx,ny,nz))
      allocate(traceri_t_prior_ens_vr(nx,ny,nz))
      allocate(traceri_t_post_ens_vr(nx,ny,nz))
      allocate(traceri_t_infl_prior(nx,ny,nz))
      allocate(traceri_t_infl_post(nx,ny,nz))
!
      call get_WRFCHEM_fld_real(trim(file_read_prior_mn),"THM",traceri_t_prior_ens_mn,nx,ny,nz,1)
      call get_WRFCHEM_fld_real(trim(file_read_post_mn),"THM",traceri_t_post_ens_mn,nx,ny,nz,1)
      call get_WRFCHEM_fld_real(trim(file_read_prior_sd),"THM",traceri_t_prior_ens_sd,nx,ny,nz,1)
      call get_WRFCHEM_fld_real(trim(file_read_post_sd),"THM",traceri_t_post_ens_sd,nx,ny,nz,1)
      call get_WRFCHEM_fld_real(trim(file_read_infl_prior),"THM",traceri_t_infl_prior,nx,ny,nz,1)
      call get_WRFCHEM_fld_real(trim(file_read_infl_post),"THM",traceri_t_infl_post,nx,ny,nz,1)
      do i=1,nx
         do j=1,ny
            do k=1,nz
               traceri_t_prior_ens_mn(i,j,k)=((traceri_t_prior_ens_mn(i,j,k)+tbase))* &
               (traceri_p(i,j,k)/100000.)**kappa
               traceri_t_post_ens_mn(i,j,k)=((traceri_t_post_ens_mn(i,j,k)+tbase))* &
               (traceri_p(i,j,k)/100000.)**kappa
               traceri_t_prior_ens_sd(i,j,k)=(traceri_t_prior_ens_sd(i,j,k))* &
               (traceri_p(i,j,k)/100000.)**kappa
               traceri_t_post_ens_sd(i,j,k)=(traceri_t_post_ens_sd(i,j,k))* &
               (traceri_p(i,j,k)/100000.)**kappa
            enddo
         enddo
      enddo
!      print *, 'TEMP PRIOR EMN ',traceri_t_prior_ens_mn(:,:,1)
!      print *, 'TEMP POST EMN  ',traceri_t_post_ens_mn(:,:,1)
!      print *, 'TEMP PRIOR ESD ',traceri_t_prior_ens_sd(:,:,1)
!      print *, 'TEMP POST ESD  ',traceri_t_post_ens_sd(:,:,1)
!
      traceri_t_incr(:,:,:)=traceri_t_post_ens_mn(:,:,:)-traceri_t_prior_ens_mn(:,:,:)
      traceri_t_prior_ens_vr(:,:,:)=traceri_t_prior_ens_sd(:,:,:)**2.
      traceri_t_post_ens_vr(:,:,:)=traceri_t_post_ens_sd(:,:,:)**2.
!
! TRACER-I CONUS Spatial statistics T
      allocate(t_ens_mn_prior_conus_mn(nz))
      allocate(t_ens_mn_post_conus_mn(nz))
      allocate(t_incr_conus_mn(nz))
      allocate(t_ens_vr_prior_conus_mn(nz))
      allocate(t_ens_vr_post_conus_mn(nz))
      allocate(t_ens_sd_prior_conus_mn(nz))
      allocate(t_ens_sd_post_conus_mn(nz))
      allocate(t_infl_prior_conus_mn(nz))
      allocate(t_infl_post_conus_mn(nz))
!
      call spatial_mean_and_variance(traceri_t_prior_ens_mn,traceri_t_post_ens_mn, &
      traceri_t_incr,traceri_t_prior_ens_vr,traceri_t_post_ens_vr,traceri_t_infl_prior, &
      traceri_t_infl_post,t_ens_mn_prior_conus_mn,t_ens_mn_post_conus_mn,t_incr_conus_mn, &
      t_ens_vr_prior_conus_mn,t_ens_vr_post_conus_mn,t_infl_prior_conus_mn,t_infl_post_conus_mn, &
      traceri_conus_ii,traceri_conus_jj,1,nx*ny,num_conus,nx,ny,nz)
!
      t_ens_sd_prior_conus_mn(:)=sqrt(t_ens_vr_prior_conus_mn(:))
      t_ens_sd_post_conus_mn(:)=sqrt(t_ens_vr_post_conus_mn(:))
!
!      print *, 'DATE ',date_traceri      
      call put_NETCDF_fld(trim(file_write),"TRACER_I_T_EMN_PRIOR_CONUS_MN", &
      "degrees",t_ens_mn_prior_conus_mn,nz,1,1)
!      print *, 'T PRIOR EMN CONUS ', t_ens_mn_prior_conus_mn(:)     
      call put_NETCDF_fld(trim(file_write),"TRACER_I_T_EMN_POST_CONUS_MN", &
      "degrees",t_ens_mn_post_conus_mn,nz,1,1)
!      print *, 'T POST EMN CONUS ', t_ens_mn_post_conus_mn(:)     
      call put_NETCDF_fld(trim(file_write),"TRACER_I_T_INCR_CONUS_MN", &
      "degrees",t_incr_conus_mn,nz,1,1)
!      print *, 'T INCR CONUS ', t_incr_conus_mn(:)     
      call put_NETCDF_fld(trim(file_write),"TRACER_I_T_ESD_PRIOR_CONUS_MN", &
      "degrees",t_ens_sd_prior_conus_mn,nz,1,1)
!      print *, 'T PRIOR ESD CONUS ', t_ens_sd_prior_conus_mn(:)     
      call put_NETCDF_fld(trim(file_write),"TRACER_I_T_ESD_POST_CONUS_MN", &
      "degrees",t_ens_sd_post_conus_mn,nz,1,1)
!      print *, 'T POST ESD CONUS ', t_ens_sd_post_conus_mn(:)     
      call put_NETCDF_fld(trim(file_write),"TRACER_I_T_INFL_PRIOR_CONUS_MN", &
      "no units",t_infl_prior_conus_mn,nz,1,1)
!      print *, 'T PRIOR INFL CONUS ', t_infl_prior_conus_mn(:)     
      call put_NETCDF_fld(trim(file_write),"TRACER_I_T_INFL_POST_CONUS_MN", &
      "no units",t_infl_post_conus_mn,nz,1,1)
!      print *, 'T POST INFL CONUS ', t_infl_post_conus_mn(:)     
!      print *,'T_ENS_PRIOR_MN ',t_ens_mn_prior_conus_mn(:)
!      print *,'T_INCR ',t_incr_conus_mn(:)
!      print *,'T_ENS_PRIOR_SD ',t_ens_sd_prior_conus_mn(:)
!      print *,'T_INFL_PRIOR_MN ',t_infl_prior_conus_mn(:)
!
      deallocate(t_ens_mn_prior_conus_mn)
      deallocate(t_ens_mn_post_conus_mn)
      deallocate(t_incr_conus_mn)
      deallocate(t_ens_vr_prior_conus_mn)
      deallocate(t_ens_vr_post_conus_mn)
      deallocate(t_ens_sd_prior_conus_mn)
      deallocate(t_ens_sd_post_conus_mn)
      deallocate(t_infl_prior_conus_mn)
      deallocate(t_infl_post_conus_mn)
!
!  TRACER-I URBAN Spatial statistics T
      allocate(t_ens_mn_prior_urban_mn(nz))
      allocate(t_ens_mn_post_urban_mn(nz))
      allocate(t_incr_urban_mn(nz))
      allocate(t_ens_vr_prior_urban_mn(nz))
      allocate(t_ens_vr_post_urban_mn(nz))
      allocate(t_ens_sd_prior_urban_mn(nz))
      allocate(t_ens_sd_post_urban_mn(nz))
      allocate(t_infl_prior_urban_mn(nz))
      allocate(t_infl_post_urban_mn(nz))
!
      call spatial_mean_and_variance(traceri_t_prior_ens_mn,traceri_t_post_ens_mn, &
      traceri_t_incr,traceri_t_prior_ens_vr,traceri_t_post_ens_vr,traceri_t_infl_prior, &
      traceri_t_infl_post,t_ens_mn_prior_urban_mn,t_ens_mn_post_urban_mn,t_incr_urban_mn, &
      t_ens_vr_prior_urban_mn,t_ens_vr_post_urban_mn,t_infl_prior_urban_mn,t_infl_post_urban_mn, &
      traceri_urban_ii,traceri_urban_jj,num_cities,npts_urban,num_urban,nx,ny,nz)
!
      t_ens_sd_prior_urban_mn(:)=sqrt(t_ens_vr_prior_urban_mn(:))
      t_ens_sd_post_urban_mn(:)=sqrt(t_ens_vr_post_urban_mn(:))
!
      call put_NETCDF_fld(trim(file_write),"TRACER_I_T_EMN_PRIOR_URBAN_MN", &
      "degrees",t_ens_mn_prior_urban_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_T_EMN_POST_URBAN_MN", &
      "degrees",t_ens_mn_post_urban_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_T_INCR_URBAN_MN", &
      "degrees",t_incr_urban_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_T_ESD_PRIOR_URBAN_MN", &
      "degrees",t_ens_sd_prior_urban_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_T_ESD_POST_URBAN_MN", &
      "degrees",t_ens_sd_post_urban_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_T_INFL_PRIOR_URBAN_MN", &
      "degrees",t_infl_prior_urban_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_T_INFL_POST_URBAN_MN", &
      "degrees",t_infl_post_urban_mn,nz,1,1)
!      print *,'T_ENS_PRIOR_MN ',t_ens_mn_prior_urban_mn(:)
!      print *,'T_INCR ',t_incr_urban_mn(:)
!      print *,'T_ENS_PRIOR_SD ',t_ens_sd_prior_urban_mn(:)
!      print *,'T_INFL_PRIOR_MN ',t_infl_prior_urban_mn(:)
!
      deallocate(t_ens_mn_prior_urban_mn)
      deallocate(t_ens_mn_post_urban_mn)
      deallocate(t_incr_urban_mn)
      deallocate(t_ens_vr_prior_urban_mn)
      deallocate(t_ens_vr_post_urban_mn)
      deallocate(t_ens_sd_prior_urban_mn)
      deallocate(t_ens_sd_post_urban_mn)
      deallocate(t_infl_prior_urban_mn)
      deallocate(t_infl_post_urban_mn)
!
!  TRACER-I RURAL Spatial statistics T
      allocate(t_ens_mn_prior_rural_mn(nz))
      allocate(t_ens_mn_post_rural_mn(nz))
      allocate(t_incr_rural_mn(nz))
      allocate(t_ens_vr_prior_rural_mn(nz))
      allocate(t_ens_vr_post_rural_mn(nz))
      allocate(t_ens_sd_prior_rural_mn(nz))
      allocate(t_ens_sd_post_rural_mn(nz))
      allocate(t_infl_prior_rural_mn(nz))
      allocate(t_infl_post_rural_mn(nz))
!
      call spatial_mean_and_variance(traceri_t_prior_ens_mn,traceri_t_post_ens_mn, &
      traceri_t_incr,traceri_t_prior_ens_vr,traceri_t_post_ens_vr,traceri_t_infl_prior, &
      traceri_t_infl_post,t_ens_mn_prior_rural_mn,t_ens_mn_post_rural_mn,t_incr_rural_mn, &
      t_ens_vr_prior_rural_mn,t_ens_vr_post_rural_mn,t_infl_prior_rural_mn,t_infl_post_rural_mn, &
      traceri_rural_ii,traceri_rural_jj,1,nx*ny,num_rural,nx,ny,nz)
!
      t_ens_sd_prior_rural_mn(:)=sqrt(t_ens_vr_prior_rural_mn(:))
      t_ens_sd_post_rural_mn(:)=sqrt(t_ens_vr_post_rural_mn(:))
!
      call put_NETCDF_fld(trim(file_write),"TRACER_I_T_EMN_PRIOR_RURAL_MN", &
      "degrees",t_ens_mn_prior_rural_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_T_EMN_POST_RURAL_MN", &
      "degrees",t_ens_mn_post_rural_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_T_INCR_RURAL_MN", &
      "degrees",t_incr_rural_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_T_ESD_PRIOR_RURAL_MN", &
      "degrees",t_ens_sd_prior_rural_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_T_ESD_POST_RURAL_MN", &
      "degrees",t_ens_sd_post_rural_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_T_INFL_PRIOR_RURAL_MN", &
      "degrees",t_infl_prior_rural_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_T_INFL_POST_RURAL_MN", &
      "degrees",t_infl_post_rural_mn,nz,1,1)
!      print *,'T_ENS_PRIOR_MN ',t_ens_mn_prior_rural_mn(:)
!      print *,'T_INCR ',t_incr_rural_mn(:)
!      print *,'T_ENS_PRIOR_SD ',t_ens_sd_prior_rural_mn(:)
!      print *,'T_INFL_PRIOR_MN ',t_infl_prior_rural_mn(:)
!
      deallocate(t_ens_mn_prior_rural_mn)
      deallocate(t_ens_mn_post_rural_mn)
      deallocate(t_incr_rural_mn)
      deallocate(t_ens_vr_prior_rural_mn)
      deallocate(t_ens_vr_post_rural_mn)
      deallocate(t_ens_sd_prior_rural_mn)
      deallocate(t_ens_sd_post_rural_mn)
      deallocate(t_infl_prior_rural_mn)
      deallocate(t_infl_post_rural_mn)
!
      deallocate(traceri_t_prior_ens_mn)
      deallocate(traceri_t_post_ens_mn)
      deallocate(traceri_t_incr)
      deallocate(traceri_t_prior_ens_sd)
      deallocate(traceri_t_post_ens_sd)
      deallocate(traceri_t_prior_ens_vr)
      deallocate(traceri_t_post_ens_vr)
      deallocate(traceri_t_infl_prior)
      deallocate(traceri_t_infl_post)
!
! Read and process U
!
      allocate(traceri_u_prior_ens_mn(nx,ny,nz))
      allocate(traceri_u_post_ens_mn(nx,ny,nz))
      allocate(traceri_u_incr(nx,ny,nz))
      allocate(traceri_u_prior_ens_sd(nx,ny,nz))
      allocate(traceri_u_post_ens_sd(nx,ny,nz))
      allocate(traceri_u_prior_ens_vr(nx,ny,nz))
      allocate(traceri_u_post_ens_vr(nx,ny,nz))
      allocate(traceri_u_infl_prior(nx,ny,nz))
      allocate(traceri_u_infl_post(nx,ny,nz))
      allocate(temp_fld1(nx+1,ny,nz))
      allocate(temp_fld2(nx+1,ny,nz))
      allocate(temp_fld3(nx+1,ny,nz))
      allocate(temp_fld4(nx+1,ny,nz))
      allocate(temp_fld5(nx+1,ny,nz))
      allocate(temp_fld6(nx+1,ny,nz))
!
      call get_WRFCHEM_fld_real(trim(file_read_prior_mn),"U",temp_fld1,nx+1,ny,nz,1)
      call get_WRFCHEM_fld_real(trim(file_read_post_mn),"U",temp_fld2,nx+1,ny,nz,1)
      call get_WRFCHEM_fld_real(trim(file_read_prior_sd),"U",temp_fld3,nx+1,ny,nz,1)
      call get_WRFCHEM_fld_real(trim(file_read_post_sd),"U",temp_fld4,nx+1,ny,nz,1)
      call get_WRFCHEM_fld_real(trim(file_read_infl_prior),"U",temp_fld5,nx+1,ny,nz,1)
      call get_WRFCHEM_fld_real(trim(file_read_infl_post),"U",temp_fld6,nx+1,ny,nz,1)
      do i=1,nx
         do j=1,ny
            do k=1,nz
               traceri_u_prior_ens_mn(i,j,k)=(temp_fld1(i+1,j,k)+temp_fld1(i,j,k))/2.
               traceri_u_post_ens_mn(i,j,k)=(temp_fld2(i+1,j,k)+temp_fld2(i,j,k))/2.
               traceri_u_prior_ens_sd(i,j,k)=(temp_fld3(i+1,j,k)+temp_fld3(i,j,k))/2.
               traceri_u_post_ens_sd(i,j,k)=(temp_fld4(i+1,j,k)+temp_fld4(i,j,k))/2.
               traceri_u_infl_prior(i,j,k)=(temp_fld5(i+1,j,k)+temp_fld5(i,j,k))/2.
               traceri_u_infl_post(i,j,k)=(temp_fld6(i+1,j,k)+temp_fld6(i,j,k))/2.
            enddo
         enddo
      enddo
      deallocate(temp_fld1)
      deallocate(temp_fld2)
      deallocate(temp_fld3)
      deallocate(temp_fld4)
      deallocate(temp_fld5)
      deallocate(temp_fld6)
!
      traceri_u_incr(:,:,:)=traceri_u_post_ens_mn(:,:,:)-traceri_u_prior_ens_mn(:,:,:)
      traceri_u_prior_ens_vr(:,:,:)=traceri_u_prior_ens_sd(:,:,:)**2.
      traceri_u_post_ens_vr(:,:,:)=traceri_u_post_ens_sd(:,:,:)**2.
!
! TRACER-I CONUS Spatial statistics U
      allocate(u_ens_mn_prior_conus_mn(nz))
      allocate(u_ens_mn_post_conus_mn(nz))
      allocate(u_incr_conus_mn(nz))
      allocate(u_ens_vr_prior_conus_mn(nz))
      allocate(u_ens_vr_post_conus_mn(nz))
      allocate(u_ens_sd_prior_conus_mn(nz))
      allocate(u_ens_sd_post_conus_mn(nz))
      allocate(u_infl_prior_conus_mn(nz))
      allocate(u_infl_post_conus_mn(nz))
!
      call spatial_mean_and_variance(traceri_u_prior_ens_mn,traceri_u_post_ens_mn, &
      traceri_u_incr,traceri_u_prior_ens_vr,traceri_u_post_ens_vr,traceri_u_infl_prior, &
      traceri_u_infl_post,u_ens_mn_prior_conus_mn,u_ens_mn_post_conus_mn,u_incr_conus_mn, &
      u_ens_vr_prior_conus_mn,u_ens_vr_post_conus_mn,u_infl_prior_conus_mn,u_infl_post_conus_mn, &
      traceri_conus_ii,traceri_conus_jj,1,nx*ny,num_conus,nx,ny,nz)
!
      u_ens_sd_prior_conus_mn(:)=sqrt(u_ens_vr_prior_conus_mn(:))
      u_ens_sd_post_conus_mn(:)=sqrt(u_ens_vr_post_conus_mn(:))
!
      call put_NETCDF_fld(trim(file_write),"TRACER_I_U_EMN_PRIOR_CONUS_MN", &
      "degrees",u_ens_mn_prior_conus_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_U_EMN_POST_CONUS_MN", &
      "degrees",u_ens_mn_post_conus_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_U_INCR_CONUS_MN", &
      "degrees",u_incr_conus_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_U_ESD_PRIOR_CONUS_MN", &
      "degrees",u_ens_sd_prior_conus_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_U_ESD_POST_CONUS_MN", &
      "degrees",u_ens_sd_post_conus_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_U_INFL_PRIOR_CONUS_MN", &
      "no units",u_infl_prior_conus_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_U_INFL_POST_CONUS_MN", &
      "no units",u_infl_post_conus_mn,nz,1,1)
!      print *,'U_ENS_PRIOR_MN ',u_ens_mn_prior_conus_mn(:)
!      print *,'U_INCR ',u_incr_conus_mn(:)
!      print *,'U_ENS_PRIOR_SD ',u_ens_sd_prior_conus_mn(:)
!      print *,'U_INFL_PRIOR_MN ',u_infl_prior_conus_mn(:)
!
      deallocate(u_ens_mn_prior_conus_mn)
      deallocate(u_ens_mn_post_conus_mn)
      deallocate(u_incr_conus_mn)
      deallocate(u_ens_vr_prior_conus_mn)
      deallocate(u_ens_vr_post_conus_mn)
      deallocate(u_ens_sd_prior_conus_mn)
      deallocate(u_ens_sd_post_conus_mn)
      deallocate(u_infl_prior_conus_mn)
      deallocate(u_infl_post_conus_mn)
!
!  TRACER-I URBAN Spatial statistics U
      allocate(u_ens_mn_prior_urban_mn(nz))
      allocate(u_ens_mn_post_urban_mn(nz))
      allocate(u_incr_urban_mn(nz))
      allocate(u_ens_vr_prior_urban_mn(nz))
      allocate(u_ens_vr_post_urban_mn(nz))
      allocate(u_ens_sd_prior_urban_mn(nz))
      allocate(u_ens_sd_post_urban_mn(nz))
      allocate(u_infl_prior_urban_mn(nz))
      allocate(u_infl_post_urban_mn(nz))
!
      call spatial_mean_and_variance(traceri_u_prior_ens_mn,traceri_u_post_ens_mn, &
      traceri_u_incr,traceri_u_prior_ens_vr,traceri_u_post_ens_vr,traceri_u_infl_prior, &
      traceri_u_infl_post,u_ens_mn_prior_urban_mn,u_ens_mn_post_urban_mn,u_incr_urban_mn, &
      u_ens_vr_prior_urban_mn,u_ens_vr_post_urban_mn,u_infl_prior_urban_mn,u_infl_post_urban_mn, &
      traceri_urban_ii,traceri_urban_jj,num_cities,npts_urban,num_urban,nx,ny,nz)
!
      u_ens_sd_prior_urban_mn(:)=sqrt(u_ens_vr_prior_urban_mn(:))
      u_ens_sd_post_urban_mn(:)=sqrt(u_ens_vr_post_urban_mn(:))
!
      call put_NETCDF_fld(trim(file_write),"TRACER_I_U_EMN_PRIOR_URBAN_MN", &
      "degrees",u_ens_mn_prior_urban_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_U_EMN_POST_URBAN_MN", &
      "degrees",u_ens_mn_post_urban_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_U_INCR_URBAN_MN", &
      "degrees",u_incr_urban_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_U_ESD_PRIOR_URBAN_MN", &
      "degrees",u_ens_sd_prior_urban_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_U_ESD_POST_URBAN_MN", &
      "degrees",u_ens_sd_post_urban_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_U_INFL_PRIOR_URBAN_MN", &
      "degrees",u_infl_prior_urban_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_U_INFL_POST_URBAN_MN", &
      "degrees",u_infl_post_urban_mn,nz,1,1)
!      print *,'U_ENS_PRIOR_MN ',u_ens_mn_prior_urban_mn(:)
!      print *,'U_INCR ',u_incr_urban_mn(:)
!      print *,'U_ENS_PRIOR_SD ',u_ens_sd_prior_urban_mn(:)
!      print *,'U_INFL_PRIOR_MN ',u_infl_prior_urban_mn(:)
!
      deallocate(u_ens_mn_prior_urban_mn)
      deallocate(u_ens_mn_post_urban_mn)
      deallocate(u_incr_urban_mn)
      deallocate(u_ens_vr_prior_urban_mn)
      deallocate(u_ens_vr_post_urban_mn)
      deallocate(u_ens_sd_prior_urban_mn)
      deallocate(u_ens_sd_post_urban_mn)
      deallocate(u_infl_prior_urban_mn)
      deallocate(u_infl_post_urban_mn)
!
!  TRACER-I RURAL Spatial statistics U
      allocate(u_ens_mn_prior_rural_mn(nz))
      allocate(u_ens_mn_post_rural_mn(nz))
      allocate(u_incr_rural_mn(nz))
      allocate(u_ens_vr_prior_rural_mn(nz))
      allocate(u_ens_vr_post_rural_mn(nz))
      allocate(u_ens_sd_prior_rural_mn(nz))
      allocate(u_ens_sd_post_rural_mn(nz))
      allocate(u_infl_prior_rural_mn(nz))
      allocate(u_infl_post_rural_mn(nz))
!
      call spatial_mean_and_variance(traceri_u_prior_ens_mn,traceri_u_post_ens_mn, &
      traceri_u_incr,traceri_u_prior_ens_vr,traceri_u_post_ens_vr,traceri_u_infl_prior, &
      traceri_u_infl_post,u_ens_mn_prior_rural_mn,u_ens_mn_post_rural_mn,u_incr_rural_mn, &
      u_ens_vr_prior_rural_mn,u_ens_vr_post_rural_mn,u_infl_prior_rural_mn,u_infl_post_rural_mn, &
      traceri_rural_ii,traceri_rural_jj,1,nx*ny,num_rural,nx,ny,nz)
!
      u_ens_sd_prior_rural_mn(:)=sqrt(u_ens_vr_prior_rural_mn(:))
      u_ens_sd_post_rural_mn(:)=sqrt(u_ens_vr_post_rural_mn(:))
!
      call put_NETCDF_fld(trim(file_write),"TRACER_I_U_EMN_PRIOR_RURAL_MN", &
      "degrees",u_ens_mn_prior_rural_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_U_EMN_POST_RURAL_MN", &
      "degrees",u_ens_mn_post_rural_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_U_INCR_RURAL_MN", &
      "degrees",u_incr_rural_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_U_ESD_PRIOR_RURAL_MN", &
      "degrees",u_ens_sd_prior_rural_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_U_ESD_POST_RURAL_MN", &
      "degrees",u_ens_sd_post_rural_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_U_INFL_PRIOR_RURAL_MN", &
      "degrees",u_infl_prior_rural_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_U_INFL_POST_RURAL_MN", &
      "degrees",u_infl_post_rural_mn,nz,1,1)
!      print *,'U_ENS_PRIOR_MN ',u_ens_mn_prior_rural_mn(:)
!      print *,'U_INCR ',u_incr_rural_mn(:)
!      print *,'U_ENS_PRIOR_SD ',u_ens_sd_prior_rural_mn(:)
!      print *,'U_INFL_PRIOR_MN ',u_infl_prior_rural_mn(:)
!
      deallocate(u_ens_mn_prior_rural_mn)
      deallocate(u_ens_mn_post_rural_mn)
      deallocate(u_incr_rural_mn)
      deallocate(u_ens_vr_prior_rural_mn)
      deallocate(u_ens_vr_post_rural_mn)
      deallocate(u_ens_sd_prior_rural_mn)
      deallocate(u_ens_sd_post_rural_mn)
      deallocate(u_infl_prior_rural_mn)
      deallocate(u_infl_post_rural_mn)
!
      deallocate(traceri_u_prior_ens_mn)
      deallocate(traceri_u_post_ens_mn)
      deallocate(traceri_u_incr)
      deallocate(traceri_u_prior_ens_sd)
      deallocate(traceri_u_post_ens_sd)
      deallocate(traceri_u_prior_ens_vr)
      deallocate(traceri_u_post_ens_vr)
      deallocate(traceri_u_infl_prior)
      deallocate(traceri_u_infl_post)
!
! Read and process V
!
      allocate(traceri_v_prior_ens_mn(nx,ny,nz))
      allocate(traceri_v_post_ens_mn(nx,ny,nz))
      allocate(traceri_v_incr(nx,ny,nz))
      allocate(traceri_v_prior_ens_sd(nx,ny,nz))
      allocate(traceri_v_post_ens_sd(nx,ny,nz))
      allocate(traceri_v_prior_ens_vr(nx,ny,nz))
      allocate(traceri_v_post_ens_vr(nx,ny,nz))
      allocate(traceri_v_infl_prior(nx,ny,nz))
      allocate(traceri_v_infl_post(nx,ny,nz))
      allocate(temp_fld1(nx,ny+1,nz))
      allocate(temp_fld2(nx,ny+1,nz))
      allocate(temp_fld3(nx,ny+1,nz))
      allocate(temp_fld4(nx,ny+1,nz))
      allocate(temp_fld5(nx,ny+1,nz))
      allocate(temp_fld6(nx,ny+1,nz))
!
      call get_WRFCHEM_fld_real(trim(file_read_prior_mn),"V",temp_fld1,nx,ny+1,nz,1)
      call get_WRFCHEM_fld_real(trim(file_read_post_mn),"V",temp_fld2,nx,ny+1,nz,1)
      call get_WRFCHEM_fld_real(trim(file_read_prior_sd),"V",temp_fld3,nx,ny+1,nz,1)
      call get_WRFCHEM_fld_real(trim(file_read_post_sd),"V",temp_fld4,nx,ny+1,nz,1)
      call get_WRFCHEM_fld_real(trim(file_read_infl_prior),"V",temp_fld5,nx,ny+1,nz,1)
      call get_WRFCHEM_fld_real(trim(file_read_infl_post),"V",temp_fld6,nx,ny+1,nz,1)
      do i=1,nx
         do j=1,ny
            do k=1,nz
               traceri_v_prior_ens_mn(i,j,k)=(temp_fld1(i,j+1,k)+temp_fld1(i,j,k))/2.
               traceri_v_post_ens_mn(i,j,k)=(temp_fld2(i,j+1,k)+temp_fld2(i,j,k))/2.
               traceri_v_prior_ens_sd(i,j,k)=(temp_fld3(i,j+1,k)+temp_fld3(i,j,k))/2.
               traceri_v_post_ens_sd(i,j,k)=(temp_fld4(i,j+1,k)+temp_fld4(i,j,k))/2.
               traceri_v_infl_prior(i,j,k)=(temp_fld5(i,j+1,k)+temp_fld5(i,j,k))/2.
               traceri_v_infl_post(i,j,k)=(temp_fld6(i,j+1,k)+temp_fld6(i,j,k))/2.
            enddo
         enddo
      enddo
      deallocate(temp_fld1)
      deallocate(temp_fld2)
      deallocate(temp_fld3)
      deallocate(temp_fld4)
      deallocate(temp_fld5)
      deallocate(temp_fld6)
!
      traceri_v_incr(:,:,:)=traceri_v_post_ens_mn(:,:,:)-traceri_v_prior_ens_mn(:,:,:)
      traceri_v_prior_ens_vr(:,:,:)=traceri_v_prior_ens_sd(:,:,:)**2.
      traceri_v_post_ens_vr(:,:,:)=traceri_v_post_ens_sd(:,:,:)**2.
!
! TRACER-I CONUS Spatial statistics V
      allocate(v_ens_mn_prior_conus_mn(nz))
      allocate(v_ens_mn_post_conus_mn(nz))
      allocate(v_incr_conus_mn(nz))
      allocate(v_ens_vr_prior_conus_mn(nz))
      allocate(v_ens_vr_post_conus_mn(nz))
      allocate(v_ens_sd_prior_conus_mn(nz))
      allocate(v_ens_sd_post_conus_mn(nz))
      allocate(v_infl_prior_conus_mn(nz))
      allocate(v_infl_post_conus_mn(nz))
!
      call spatial_mean_and_variance(traceri_v_prior_ens_mn,traceri_v_post_ens_mn, &
      traceri_v_incr,traceri_v_prior_ens_vr,traceri_v_post_ens_vr,traceri_v_infl_prior, &
      traceri_v_infl_post,v_ens_mn_prior_conus_mn,v_ens_mn_post_conus_mn,v_incr_conus_mn, &
      v_ens_vr_prior_conus_mn,v_ens_vr_post_conus_mn,v_infl_prior_conus_mn,v_infl_post_conus_mn, &
      traceri_conus_ii,traceri_conus_jj,1,nx*ny,num_conus,nx,ny,nz)
!
      v_ens_sd_prior_conus_mn(:)=sqrt(v_ens_vr_prior_conus_mn(:))
      v_ens_sd_post_conus_mn(:)=sqrt(v_ens_vr_post_conus_mn(:))
!
      call put_NETCDF_fld(trim(file_write),"TRACER_I_V_EMN_PRIOR_CONUS_MN", &
      "degrees",v_ens_mn_prior_conus_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_V_EMN_POST_CONUS_MN", &
      "degrees",v_ens_mn_post_conus_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_V_INCR_CONUS_MN", &
      "degrees",v_incr_conus_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_V_ESD_PRIOR_CONUS_MN", &
      "degrees",v_ens_sd_prior_conus_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_V_ESD_POST_CONUS_MN", &
      "degrees",v_ens_sd_post_conus_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_V_INFL_PRIOR_CONUS_MN", &
      "no units",v_infl_prior_conus_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_V_INFL_POST_CONUS_MN", &
      "no units",v_infl_post_conus_mn,nz,1,1)
!      print *,'V_ENS_PRIOR_MN ',v_ens_mn_prior_conus_mn(:)
!      print *,'V_INCR ',v_incr_conus_mn(:)
!      print *,'V_ENS_PRIOR_SD ',v_ens_sd_prior_conus_mn(:)
!      print *,'V_INFL_PRIOR_MN ',v_infl_prior_conus_mn(:)
!
      deallocate(v_ens_mn_prior_conus_mn)
      deallocate(v_ens_mn_post_conus_mn)
      deallocate(v_incr_conus_mn)
      deallocate(v_ens_vr_prior_conus_mn)
      deallocate(v_ens_vr_post_conus_mn)
      deallocate(v_ens_sd_prior_conus_mn)
      deallocate(v_ens_sd_post_conus_mn)
      deallocate(v_infl_prior_conus_mn)
      deallocate(v_infl_post_conus_mn)
!
!  TRACER-I URBAN Spatial statistics V
      allocate(v_ens_mn_prior_urban_mn(nz))
      allocate(v_ens_mn_post_urban_mn(nz))
      allocate(v_incr_urban_mn(nz))
      allocate(v_ens_vr_prior_urban_mn(nz))
      allocate(v_ens_vr_post_urban_mn(nz))
      allocate(v_ens_sd_prior_urban_mn(nz))
      allocate(v_ens_sd_post_urban_mn(nz))
      allocate(v_infl_prior_urban_mn(nz))
      allocate(v_infl_post_urban_mn(nz))
!
      call spatial_mean_and_variance(traceri_v_prior_ens_mn,traceri_v_post_ens_mn, &
      traceri_v_incr,traceri_v_prior_ens_vr,traceri_v_post_ens_vr,traceri_v_infl_prior, &
      traceri_v_infl_post,v_ens_mn_prior_urban_mn,v_ens_mn_post_urban_mn,v_incr_urban_mn, &
      v_ens_vr_prior_urban_mn,v_ens_vr_post_urban_mn,v_infl_prior_urban_mn,v_infl_post_urban_mn, &
      traceri_urban_ii,traceri_urban_jj,num_cities,npts_urban,num_urban,nx,ny,nz)
!
      v_ens_sd_prior_urban_mn(:)=sqrt(v_ens_vr_prior_urban_mn(:))
      v_ens_sd_post_urban_mn(:)=sqrt(v_ens_vr_post_urban_mn(:))
!
      call put_NETCDF_fld(trim(file_write),"TRACER_I_V_EMN_PRIOR_URBAN_MN", &
      "degrees",v_ens_mn_prior_urban_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_V_EMN_POST_URBAN_MN", &
      "degrees",v_ens_mn_post_urban_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_V_INCR_URBAN_MN", &
      "degrees",v_incr_urban_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_V_ESD_PRIOR_URBAN_MN", &
      "degrees",v_ens_sd_prior_urban_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_V_ESD_POST_URBAN_MN", &
      "degrees",v_ens_sd_post_urban_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_V_INFL_PRIOR_URBAN_MN", &
      "degrees",v_infl_prior_urban_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_V_INFL_POST_URBAN_MN", &
      "degrees",v_infl_post_urban_mn,nz,1,1)
!      print *,'V_ENS_PRIOR_MN ',v_ens_mn_prior_urban_mn(:)
!      print *,'V_INCR ',v_incr_urban_mn(:)
!      print *,'V_ENS_PRIOR_SD ',v_ens_sd_prior_urban_mn(:)
!      print *,'V_INFL_PRIOR_MN ',v_infl_prior_urban_mn(:)
!
      deallocate(v_ens_mn_prior_urban_mn)
      deallocate(v_ens_mn_post_urban_mn)
      deallocate(v_incr_urban_mn)
      deallocate(v_ens_vr_prior_urban_mn)
      deallocate(v_ens_vr_post_urban_mn)
      deallocate(v_ens_sd_prior_urban_mn)
      deallocate(v_ens_sd_post_urban_mn)
      deallocate(v_infl_prior_urban_mn)
      deallocate(v_infl_post_urban_mn)
!
!  TRACER-I RURAL Spatial statistics V
      allocate(v_ens_mn_prior_rural_mn(nz))
      allocate(v_ens_mn_post_rural_mn(nz))
      allocate(v_incr_rural_mn(nz))
      allocate(v_ens_vr_prior_rural_mn(nz))
      allocate(v_ens_vr_post_rural_mn(nz))
      allocate(v_ens_sd_prior_rural_mn(nz))
      allocate(v_ens_sd_post_rural_mn(nz))
      allocate(v_infl_prior_rural_mn(nz))
      allocate(v_infl_post_rural_mn(nz))
!
      call spatial_mean_and_variance(traceri_v_prior_ens_mn,traceri_v_post_ens_mn, &
      traceri_v_incr,traceri_v_prior_ens_vr,traceri_v_post_ens_vr,traceri_v_infl_prior, &
      traceri_v_infl_post,v_ens_mn_prior_rural_mn,v_ens_mn_post_rural_mn,v_incr_rural_mn, &
      v_ens_vr_prior_rural_mn,v_ens_vr_post_rural_mn,v_infl_prior_rural_mn,v_infl_post_rural_mn, &
      traceri_rural_ii,traceri_rural_jj,1,nx*ny,num_rural,nx,ny,nz)
!
      v_ens_sd_prior_rural_mn(:)=sqrt(v_ens_vr_prior_rural_mn(:))
      v_ens_sd_post_rural_mn(:)=sqrt(v_ens_vr_post_rural_mn(:))
!
      call put_NETCDF_fld(trim(file_write),"TRACER_I_V_EMN_PRIOR_RURAL_MN", &
      "degrees",v_ens_mn_prior_rural_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_V_EMN_POST_RURAL_MN", &
      "degrees",v_ens_mn_post_rural_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_V_INCR_RURAL_MN", &
      "degrees",v_incr_rural_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_V_ESD_PRIOR_RURAL_MN", &
      "degrees",v_ens_sd_prior_rural_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_V_ESD_POST_RURAL_MN", &
      "degrees",v_ens_sd_post_rural_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_V_INFL_PRIOR_RURAL_MN", &
      "degrees",v_infl_prior_rural_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_V_INFL_POST_RURAL_MN", &
      "degrees",v_infl_post_rural_mn,nz,1,1)
!      print *,'V_ENS_PRIOR_MN ',v_ens_mn_prior_rural_mn(:)
!      print *,'V_INCR ',v_incr_rural_mn(:)
!      print *,'V_ENS_PRIOR_SD ',v_ens_sd_prior_rural_mn(:)
!      print *,'V_INFL_PRIOR_MN ',v_infl_prior_rural_mn(:)
!
      deallocate(v_ens_mn_prior_rural_mn)
      deallocate(v_ens_mn_post_rural_mn)
      deallocate(v_incr_rural_mn)
      deallocate(v_ens_vr_prior_rural_mn)
      deallocate(v_ens_vr_post_rural_mn)
      deallocate(v_ens_sd_prior_rural_mn)
      deallocate(v_ens_sd_post_rural_mn)
      deallocate(v_infl_prior_rural_mn)
      deallocate(v_infl_post_rural_mn)
!
      deallocate(traceri_v_prior_ens_mn)
      deallocate(traceri_v_post_ens_mn)
      deallocate(traceri_v_incr)
      deallocate(traceri_v_prior_ens_sd)
      deallocate(traceri_v_post_ens_sd)
      deallocate(traceri_v_prior_ens_vr)
      deallocate(traceri_v_post_ens_vr)
      deallocate(traceri_v_infl_prior)
      deallocate(traceri_v_infl_post)
!
! Read and process Q
!
      allocate(traceri_q_prior_ens_mn(nx,ny,nz))
      allocate(traceri_q_post_ens_mn(nx,ny,nz))
      allocate(traceri_q_incr(nx,ny,nz))
      allocate(traceri_q_prior_ens_sd(nx,ny,nz))
      allocate(traceri_q_post_ens_sd(nx,ny,nz))
      allocate(traceri_q_prior_ens_vr(nx,ny,nz))
      allocate(traceri_q_post_ens_vr(nx,ny,nz))
      allocate(traceri_q_infl_prior(nx,ny,nz))
      allocate(traceri_q_infl_post(nx,ny,nz))
!
      call get_WRFCHEM_fld_real(trim(file_read_prior_mn),"QVAPOR",traceri_q_prior_ens_mn,nx,ny,nz,1)
      call get_WRFCHEM_fld_real(trim(file_read_post_mn),"QVAPOR",traceri_q_post_ens_mn,nx,ny,nz,1)
      call get_WRFCHEM_fld_real(trim(file_read_prior_sd),"QVAPOR",traceri_q_prior_ens_sd,nx,ny,nz,1)
      call get_WRFCHEM_fld_real(trim(file_read_post_sd),"QVAPOR",traceri_q_post_ens_sd,nx,ny,nz,1)
      call get_WRFCHEM_fld_real(trim(file_read_infl_prior),"QVAPOR",traceri_q_infl_prior,nx,ny,nz,1)
      call get_WRFCHEM_fld_real(trim(file_read_infl_post),"QVAPOR",traceri_q_infl_post,nx,ny,nz,1)
!
      traceri_q_incr(:,:,:)=traceri_q_post_ens_mn(:,:,:)-traceri_q_prior_ens_mn(:,:,:)
      traceri_q_prior_ens_vr(:,:,:)=traceri_q_prior_ens_sd(:,:,:)**2.
      traceri_q_post_ens_vr(:,:,:)=traceri_q_post_ens_sd(:,:,:)**2.
!
! TRACER-I CONUS Spatial statistics Q
      allocate(q_ens_mn_prior_conus_mn(nz))
      allocate(q_ens_mn_post_conus_mn(nz))
      allocate(q_incr_conus_mn(nz))
      allocate(q_ens_vr_prior_conus_mn(nz))
      allocate(q_ens_vr_post_conus_mn(nz))
      allocate(q_ens_sd_prior_conus_mn(nz))
      allocate(q_ens_sd_post_conus_mn(nz))
      allocate(q_infl_prior_conus_mn(nz))
      allocate(q_infl_post_conus_mn(nz))
!
      call spatial_mean_and_variance(traceri_q_prior_ens_mn,traceri_q_post_ens_mn, &
      traceri_q_incr,traceri_q_prior_ens_vr,traceri_q_post_ens_vr,traceri_q_infl_prior, &
      traceri_q_infl_post,q_ens_mn_prior_conus_mn,q_ens_mn_post_conus_mn,q_incr_conus_mn, &
      q_ens_vr_prior_conus_mn,q_ens_vr_post_conus_mn,q_infl_prior_conus_mn,q_infl_post_conus_mn, &
      traceri_conus_ii,traceri_conus_jj,1,nx*ny,num_conus,nx,ny,nz)
!
      q_ens_sd_prior_conus_mn(:)=sqrt(q_ens_vr_prior_conus_mn(:))
      q_ens_sd_post_conus_mn(:)=sqrt(q_ens_vr_post_conus_mn(:))
!
      call put_NETCDF_fld(trim(file_write),"TRACER_I_Q_EMN_PRIOR_CONUS_MN", &
      "degrees",q_ens_mn_prior_conus_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_Q_EMN_POST_CONUS_MN", &
      "degrees",q_ens_mn_post_conus_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_Q_INCR_CONUS_MN", &
      "degrees",q_incr_conus_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_Q_ESD_PRIOR_CONUS_MN", &
      "degrees",q_ens_sd_prior_conus_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_Q_ESD_POST_CONUS_MN", &
      "degrees",q_ens_sd_post_conus_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_Q_INFL_PRIOR_CONUS_MN", &
      "no units",q_infl_prior_conus_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_Q_INFL_POST_CONUS_MN", &
      "no units",q_infl_post_conus_mn,nz,1,1)
!      print *,'Q_ENS_PRIOR_MN ',q_ens_mn_prior_conus_mn(:)
!      print *,'Q_INCR ',q_incr_conus_mn(:)
!      print *,'Q_ENS_PRIOR_SD ',q_ens_sd_prior_conus_mn(:)
!      print *,'Q_INFL_PRIOR_MN ',q_infl_prior_conus_mn(:)
!
      deallocate(q_ens_mn_prior_conus_mn)
      deallocate(q_ens_mn_post_conus_mn)
      deallocate(q_incr_conus_mn)
      deallocate(q_ens_vr_prior_conus_mn)
      deallocate(q_ens_vr_post_conus_mn)
      deallocate(q_ens_sd_prior_conus_mn)
      deallocate(q_ens_sd_post_conus_mn)
      deallocate(q_infl_prior_conus_mn)
      deallocate(q_infl_post_conus_mn)
!
!  TRACER-I URBAN Spatial statistics Q
      allocate(q_ens_mn_prior_urban_mn(nz))
      allocate(q_ens_mn_post_urban_mn(nz))
      allocate(q_incr_urban_mn(nz))
      allocate(q_ens_vr_prior_urban_mn(nz))
      allocate(q_ens_vr_post_urban_mn(nz))
      allocate(q_ens_sd_prior_urban_mn(nz))
      allocate(q_ens_sd_post_urban_mn(nz))
      allocate(q_infl_prior_urban_mn(nz))
      allocate(q_infl_post_urban_mn(nz))
!
      call spatial_mean_and_variance(traceri_q_prior_ens_mn,traceri_q_post_ens_mn, &
      traceri_q_incr,traceri_q_prior_ens_vr,traceri_q_post_ens_vr,traceri_q_infl_prior, &
      traceri_q_infl_post,q_ens_mn_prior_urban_mn,q_ens_mn_post_urban_mn,q_incr_urban_mn, &
      q_ens_vr_prior_urban_mn,q_ens_vr_post_urban_mn,q_infl_prior_urban_mn,q_infl_post_urban_mn, &
      traceri_urban_ii,traceri_urban_jj,num_cities,npts_urban,num_urban,nx,ny,nz)
!
      q_ens_sd_prior_urban_mn(:)=sqrt(q_ens_vr_prior_urban_mn(:))
      q_ens_sd_post_urban_mn(:)=sqrt(q_ens_vr_post_urban_mn(:))
!
      call put_NETCDF_fld(trim(file_write),"TRACER_I_Q_EMN_PRIOR_URBAN_MN", &
      "degrees",q_ens_mn_prior_urban_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_Q_EMN_POST_URBAN_MN", &
      "degrees",q_ens_mn_post_urban_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_Q_INCR_URBAN_MN", &
      "degrees",q_incr_urban_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_Q_ESD_PRIOR_URBAN_MN", &
      "degrees",q_ens_sd_prior_urban_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_Q_ESD_POST_URBAN_MN", &
      "degrees",q_ens_sd_post_urban_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_Q_INFL_PRIOR_URBAN_MN", &
      "degrees",q_infl_prior_urban_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_Q_INFL_POST_URBAN_MN", &
      "degrees",q_infl_post_urban_mn,nz,1,1)
!      print *,'Q_ENS_PRIOR_MN ',q_ens_mn_prior_urban_mn(:)
!      print *,'Q_INCR ',q_incr_urban_mn(:)
!      print *,'Q_ENS_PRIOR_SD ',q_ens_sd_prior_urban_mn(:)
!      print *,'Q_INFL_PRIOR_MN ',q_infl_prior_urban_mn(:)
!
      deallocate(q_ens_mn_prior_urban_mn)
      deallocate(q_ens_mn_post_urban_mn)
      deallocate(q_incr_urban_mn)
      deallocate(q_ens_vr_prior_urban_mn)
      deallocate(q_ens_vr_post_urban_mn)
      deallocate(q_ens_sd_prior_urban_mn)
      deallocate(q_ens_sd_post_urban_mn)
      deallocate(q_infl_prior_urban_mn)
      deallocate(q_infl_post_urban_mn)
!
!  TRACER-I RURAL Spatial statistics Q
      allocate(q_ens_mn_prior_rural_mn(nz))
      allocate(q_ens_mn_post_rural_mn(nz))
      allocate(q_incr_rural_mn(nz))
      allocate(q_ens_vr_prior_rural_mn(nz))
      allocate(q_ens_vr_post_rural_mn(nz))
      allocate(q_ens_sd_prior_rural_mn(nz))
      allocate(q_ens_sd_post_rural_mn(nz))
      allocate(q_infl_prior_rural_mn(nz))
      allocate(q_infl_post_rural_mn(nz))
!
      call spatial_mean_and_variance(traceri_q_prior_ens_mn,traceri_q_post_ens_mn, &
      traceri_q_incr,traceri_q_prior_ens_vr,traceri_q_post_ens_vr,traceri_q_infl_prior, &
      traceri_q_infl_post,q_ens_mn_prior_rural_mn,q_ens_mn_post_rural_mn,q_incr_rural_mn, &
      q_ens_vr_prior_rural_mn,q_ens_vr_post_rural_mn,q_infl_prior_rural_mn,q_infl_post_rural_mn, &
      traceri_rural_ii,traceri_rural_jj,1,nx*ny,num_rural,nx,ny,nz)
!
      q_ens_sd_prior_rural_mn(:)=sqrt(q_ens_vr_prior_rural_mn(:))
      q_ens_sd_post_rural_mn(:)=sqrt(q_ens_vr_post_rural_mn(:))
!
      call put_NETCDF_fld(trim(file_write),"TRACER_I_Q_EMN_PRIOR_RURAL_MN", &
      "degrees",q_ens_mn_prior_rural_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_Q_EMN_POST_RURAL_MN", &
      "degrees",q_ens_mn_post_rural_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_Q_INCR_RURAL_MN", &
      "degrees",q_incr_rural_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_Q_ESD_PRIOR_RURAL_MN", &
      "degrees",q_ens_sd_prior_rural_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_Q_ESD_POST_RURAL_MN", &
      "degrees",q_ens_sd_post_rural_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_Q_INFL_PRIOR_RURAL_MN", &
      "degrees",q_infl_prior_rural_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_Q_INFL_POST_RURAL_MN", &
      "degrees",q_infl_post_rural_mn,nz,1,1)
!      print *,'Q_ENS_PRIOR_MN ',q_ens_mn_prior_rural_mn(:)
!      print *,'Q_INCR ',q_incr_rural_mn(:)
!      print *,'Q_ENS_PRIOR_SD ',q_ens_sd_prior_rural_mn(:)
!      print *,'Q_INFL_PRIOR_MN ',q_infl_prior_rural_mn(:)
!
      deallocate(q_ens_mn_prior_rural_mn)
      deallocate(q_ens_mn_post_rural_mn)
      deallocate(q_incr_rural_mn)
      deallocate(q_ens_vr_prior_rural_mn)
      deallocate(q_ens_vr_post_rural_mn)
      deallocate(q_ens_sd_prior_rural_mn)
      deallocate(q_ens_sd_post_rural_mn)
      deallocate(q_infl_prior_rural_mn)
      deallocate(q_infl_post_rural_mn)
!
      deallocate(traceri_q_prior_ens_mn)
      deallocate(traceri_q_post_ens_mn)
      deallocate(traceri_q_incr)
      deallocate(traceri_q_prior_ens_sd)
      deallocate(traceri_q_post_ens_sd)
      deallocate(traceri_q_prior_ens_vr)
      deallocate(traceri_q_post_ens_vr)
      deallocate(traceri_q_infl_prior)
      deallocate(traceri_q_infl_post)
!
! Read and process CO
!
      allocate(traceri_co_prior_ens_mn(nx,ny,nz))
      allocate(traceri_co_post_ens_mn(nx,ny,nz))
      allocate(traceri_co_incr(nx,ny,nz))
      allocate(traceri_co_prior_ens_sd(nx,ny,nz))
      allocate(traceri_co_post_ens_sd(nx,ny,nz))
      allocate(traceri_co_prior_ens_vr(nx,ny,nz))
      allocate(traceri_co_post_ens_vr(nx,ny,nz))
      allocate(traceri_co_infl_prior(nx,ny,nz))
      allocate(traceri_co_infl_post(nx,ny,nz))
!
      call get_WRFCHEM_fld_real(trim(file_read_prior_mn),"co",traceri_co_prior_ens_mn,nx,ny,nz,1)
      call get_WRFCHEM_fld_real(trim(file_read_post_mn),"co",traceri_co_post_ens_mn,nx,ny,nz,1)
      call get_WRFCHEM_fld_real(trim(file_read_prior_sd),"co",traceri_co_prior_ens_sd,nx,ny,nz,1)
      call get_WRFCHEM_fld_real(trim(file_read_post_sd),"co",traceri_co_post_ens_sd,nx,ny,nz,1)
      call get_WRFCHEM_fld_real(trim(file_read_infl_prior),"co",traceri_co_infl_prior,nx,ny,nz,1)
      call get_WRFCHEM_fld_real(trim(file_read_infl_post),"co",traceri_co_infl_post,nx,ny,nz,1)
!
      traceri_co_incr(:,:,:)=traceri_co_post_ens_mn(:,:,:)-traceri_co_prior_ens_mn(:,:,:)
      traceri_co_prior_ens_vr(:,:,:)=traceri_co_prior_ens_sd(:,:,:)**2.
      traceri_co_post_ens_vr(:,:,:)=traceri_co_post_ens_sd(:,:,:)**2.
!
! TRACER-I CONUS Spatial statistics CO
      allocate(co_ens_mn_prior_conus_mn(nz))
      allocate(co_ens_mn_post_conus_mn(nz))
      allocate(co_incr_conus_mn(nz))
      allocate(co_ens_vr_prior_conus_mn(nz))
      allocate(co_ens_vr_post_conus_mn(nz))
      allocate(co_ens_sd_prior_conus_mn(nz))
      allocate(co_ens_sd_post_conus_mn(nz))
      allocate(co_infl_prior_conus_mn(nz))
      allocate(co_infl_post_conus_mn(nz))
!
      call spatial_mean_and_variance(traceri_co_prior_ens_mn,traceri_co_post_ens_mn, &
      traceri_co_incr,traceri_co_prior_ens_vr,traceri_co_post_ens_vr,traceri_co_infl_prior, &
      traceri_co_infl_post,co_ens_mn_prior_conus_mn,co_ens_mn_post_conus_mn,co_incr_conus_mn, &
      co_ens_vr_prior_conus_mn,co_ens_vr_post_conus_mn,co_infl_prior_conus_mn,co_infl_post_conus_mn, &
      traceri_conus_ii,traceri_conus_jj,1,nx*ny,num_conus,nx,ny,nz)
!
      co_ens_sd_prior_conus_mn(:)=sqrt(co_ens_vr_prior_conus_mn(:))
      co_ens_sd_post_conus_mn(:)=sqrt(co_ens_vr_post_conus_mn(:))
!
      call put_NETCDF_fld(trim(file_write),"TRACER_I_CO_EMN_PRIOR_CONUS_MN", &
      "degrees",co_ens_mn_prior_conus_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_CO_EMN_POST_CONUS_MN", &
      "degrees",co_ens_mn_post_conus_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_CO_INCR_CONUS_MN", &
      "degrees",co_incr_conus_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_CO_ESD_PRIOR_CONUS_MN", &
      "degrees",co_ens_sd_prior_conus_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_CO_ESD_POST_CONUS_MN", &
      "degrees",co_ens_sd_post_conus_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_CO_INFL_PRIOR_CONUS_MN", &
      "no units",co_infl_prior_conus_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_CO_INFL_POST_CONUS_MN", &
      "no units",co_infl_post_conus_mn,nz,1,1)
!      print *,'CO_ENS_PRIOR_MN ',co_ens_mn_prior_conus_mn(:)
!      print *,'CO_INCR ',co_incr_conus_mn(:)
!      print *,'CO_ENS_PRIOR_SD ',co_ens_sd_prior_conus_mn(:)
!      print *,'CO_INFL_PRIOR_MN ',co_infl_prior_conus_mn(:)
!
      deallocate(co_ens_mn_prior_conus_mn)
      deallocate(co_ens_mn_post_conus_mn)
      deallocate(co_incr_conus_mn)
      deallocate(co_ens_vr_prior_conus_mn)
      deallocate(co_ens_vr_post_conus_mn)
      deallocate(co_ens_sd_prior_conus_mn)
      deallocate(co_ens_sd_post_conus_mn)
      deallocate(co_infl_prior_conus_mn)
      deallocate(co_infl_post_conus_mn)
!
!  TRACER-I URBAN Spatial statistics CO
      allocate(co_ens_mn_prior_urban_mn(nz))
      allocate(co_ens_mn_post_urban_mn(nz))
      allocate(co_incr_urban_mn(nz))
      allocate(co_ens_vr_prior_urban_mn(nz))
      allocate(co_ens_vr_post_urban_mn(nz))
      allocate(co_ens_sd_prior_urban_mn(nz))
      allocate(co_ens_sd_post_urban_mn(nz))
      allocate(co_infl_prior_urban_mn(nz))
      allocate(co_infl_post_urban_mn(nz))
!
      call spatial_mean_and_variance(traceri_co_prior_ens_mn,traceri_co_post_ens_mn, &
      traceri_co_incr,traceri_co_prior_ens_vr,traceri_co_post_ens_vr,traceri_co_infl_prior, &
      traceri_co_infl_post,co_ens_mn_prior_urban_mn,co_ens_mn_post_urban_mn,co_incr_urban_mn, &
      co_ens_vr_prior_urban_mn,co_ens_vr_post_urban_mn,co_infl_prior_urban_mn,co_infl_post_urban_mn, &
      traceri_urban_ii,traceri_urban_jj,num_cities,npts_urban,num_urban,nx,ny,nz)
!
      co_ens_sd_prior_urban_mn(:)=sqrt(co_ens_vr_prior_urban_mn(:))
      co_ens_sd_post_urban_mn(:)=sqrt(co_ens_vr_post_urban_mn(:))
!
      call put_NETCDF_fld(trim(file_write),"TRACER_I_CO_EMN_PRIOR_URBAN_MN", &
      "degrees",co_ens_mn_prior_urban_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_CO_EMN_POST_URBAN_MN", &
      "degrees",co_ens_mn_post_urban_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_CO_INCR_URBAN_MN", &
      "degrees",co_incr_urban_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_CO_ESD_PRIOR_URBAN_MN", &
      "degrees",co_ens_sd_prior_urban_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_CO_ESD_POST_URBAN_MN", &
      "degrees",co_ens_sd_post_urban_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_CO_INFL_PRIOR_URBAN_MN", &
      "degrees",co_infl_prior_urban_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_CO_INFL_POST_URBAN_MN", &
      "degrees",co_infl_post_urban_mn,nz,1,1)
!      print *,'CO_ENS_PRIOR_MN ',co_ens_mn_prior_urban_mn(:)
!      print *,'CO_INCR ',co_incr_urban_mn(:)
!      print *,'CO_ENS_PRIOR_SD ',co_ens_sd_prior_urban_mn(:)
!      print *,'CO_INFL_PRIOR_MN ',co_infl_prior_urban_mn(:)
!
      deallocate(co_ens_mn_prior_urban_mn)
      deallocate(co_ens_mn_post_urban_mn)
      deallocate(co_incr_urban_mn)
      deallocate(co_ens_vr_prior_urban_mn)
      deallocate(co_ens_vr_post_urban_mn)
      deallocate(co_ens_sd_prior_urban_mn)
      deallocate(co_ens_sd_post_urban_mn)
      deallocate(co_infl_prior_urban_mn)
      deallocate(co_infl_post_urban_mn)
!
!  TRACER-I RURAL Spatial statistics CO
      allocate(co_ens_mn_prior_rural_mn(nz))
      allocate(co_ens_mn_post_rural_mn(nz))
      allocate(co_incr_rural_mn(nz))
      allocate(co_ens_vr_prior_rural_mn(nz))
      allocate(co_ens_vr_post_rural_mn(nz))
      allocate(co_ens_sd_prior_rural_mn(nz))
      allocate(co_ens_sd_post_rural_mn(nz))
      allocate(co_infl_prior_rural_mn(nz))
      allocate(co_infl_post_rural_mn(nz))
!
      call spatial_mean_and_variance(traceri_co_prior_ens_mn,traceri_co_post_ens_mn, &
      traceri_co_incr,traceri_co_prior_ens_vr,traceri_co_post_ens_vr,traceri_co_infl_prior, &
      traceri_co_infl_post,co_ens_mn_prior_rural_mn,co_ens_mn_post_rural_mn,co_incr_rural_mn, &
      co_ens_vr_prior_rural_mn,co_ens_vr_post_rural_mn,co_infl_prior_rural_mn,co_infl_post_rural_mn, &
      traceri_rural_ii,traceri_rural_jj,1,nx*ny,num_rural,nx,ny,nz)
!
      co_ens_sd_prior_rural_mn(:)=sqrt(co_ens_vr_prior_rural_mn(:))
      co_ens_sd_post_rural_mn(:)=sqrt(co_ens_vr_post_rural_mn(:))
!
      call put_NETCDF_fld(trim(file_write),"TRACER_I_CO_EMN_PRIOR_RURAL_MN", &
      "degrees",co_ens_mn_prior_rural_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_CO_EMN_POST_RURAL_MN", &
      "degrees",co_ens_mn_post_rural_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_CO_INCR_RURAL_MN", &
      "degrees",co_incr_rural_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_CO_ESD_PRIOR_RURAL_MN", &
      "degrees",co_ens_sd_prior_rural_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_CO_ESD_POST_RURAL_MN", &
      "degrees",co_ens_sd_post_rural_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_CO_INFL_PRIOR_RURAL_MN", &
      "degrees",co_infl_prior_rural_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_CO_INFL_POST_RURAL_MN", &
      "degrees",co_infl_post_rural_mn,nz,1,1)
!      print *,'CO_ENS_PRIOR_MN ',co_ens_mn_prior_rural_mn(:)
!      print *,'CO_INCR ',co_incr_rural_mn(:)
!      print *,'CO_ENS_PRIOR_SD ',co_ens_sd_prior_rural_mn(:)
!      print *,'CO_INFL_PRIOR_MN ',co_infl_prior_rural_mn(:)
!
      deallocate(co_ens_mn_prior_rural_mn)
      deallocate(co_ens_mn_post_rural_mn)
      deallocate(co_incr_rural_mn)
      deallocate(co_ens_vr_prior_rural_mn)
      deallocate(co_ens_vr_post_rural_mn)
      deallocate(co_ens_sd_prior_rural_mn)
      deallocate(co_ens_sd_post_rural_mn)
      deallocate(co_infl_prior_rural_mn)
      deallocate(co_infl_post_rural_mn)
!
      deallocate(traceri_co_prior_ens_mn)
      deallocate(traceri_co_post_ens_mn)
      deallocate(traceri_co_incr)
      deallocate(traceri_co_prior_ens_sd)
      deallocate(traceri_co_post_ens_sd)
      deallocate(traceri_co_prior_ens_vr)
      deallocate(traceri_co_post_ens_vr)
      deallocate(traceri_co_infl_prior)
      deallocate(traceri_co_infl_post)
!
! Read and process O3
!
      allocate(traceri_o3_prior_ens_mn(nx,ny,nz))
      allocate(traceri_o3_post_ens_mn(nx,ny,nz))
      allocate(traceri_o3_incr(nx,ny,nz))
      allocate(traceri_o3_prior_ens_sd(nx,ny,nz))
      allocate(traceri_o3_post_ens_sd(nx,ny,nz))
      allocate(traceri_o3_prior_ens_vr(nx,ny,nz))
      allocate(traceri_o3_post_ens_vr(nx,ny,nz))
      allocate(traceri_o3_infl_prior(nx,ny,nz))
      allocate(traceri_o3_infl_post(nx,ny,nz))
!
      call get_WRFCHEM_fld_real(trim(file_read_prior_mn),"o3",traceri_o3_prior_ens_mn,nx,ny,nz,1)
      call get_WRFCHEM_fld_real(trim(file_read_post_mn),"o3",traceri_o3_post_ens_mn,nx,ny,nz,1)
      call get_WRFCHEM_fld_real(trim(file_read_prior_sd),"o3",traceri_o3_prior_ens_sd,nx,ny,nz,1)
      call get_WRFCHEM_fld_real(trim(file_read_post_sd),"o3",traceri_o3_post_ens_sd,nx,ny,nz,1)
      call get_WRFCHEM_fld_real(trim(file_read_infl_prior),"o3",traceri_o3_infl_prior,nx,ny,nz,1)
      call get_WRFCHEM_fld_real(trim(file_read_infl_post),"o3",traceri_o3_infl_post,nx,ny,nz,1)
!
      traceri_o3_incr(:,:,:)=traceri_o3_post_ens_mn(:,:,:)-traceri_o3_prior_ens_mn(:,:,:)
      traceri_o3_prior_ens_vr(:,:,:)=traceri_o3_prior_ens_sd(:,:,:)**2.
      traceri_o3_post_ens_vr(:,:,:)=traceri_o3_post_ens_sd(:,:,:)**2.
!
! TRACER-I CONUS Spatial statistics O3
      allocate(o3_ens_mn_prior_conus_mn(nz))
      allocate(o3_ens_mn_post_conus_mn(nz))
      allocate(o3_incr_conus_mn(nz))
      allocate(o3_ens_vr_prior_conus_mn(nz))
      allocate(o3_ens_vr_post_conus_mn(nz))
      allocate(o3_ens_sd_prior_conus_mn(nz))
      allocate(o3_ens_sd_post_conus_mn(nz))
      allocate(o3_infl_prior_conus_mn(nz))
      allocate(o3_infl_post_conus_mn(nz))
!
      call spatial_mean_and_variance(traceri_o3_prior_ens_mn,traceri_o3_post_ens_mn, &
      traceri_o3_incr,traceri_o3_prior_ens_vr,traceri_o3_post_ens_vr,traceri_o3_infl_prior, &
      traceri_o3_infl_post,o3_ens_mn_prior_conus_mn,o3_ens_mn_post_conus_mn,o3_incr_conus_mn, &
      o3_ens_vr_prior_conus_mn,o3_ens_vr_post_conus_mn,o3_infl_prior_conus_mn,o3_infl_post_conus_mn, &
      traceri_conus_ii,traceri_conus_jj,1,nx*ny,num_conus,nx,ny,nz)
!
      o3_ens_sd_prior_conus_mn(:)=sqrt(o3_ens_vr_prior_conus_mn(:))
      o3_ens_sd_post_conus_mn(:)=sqrt(o3_ens_vr_post_conus_mn(:))
!
      call put_NETCDF_fld(trim(file_write),"TRACER_I_O3_EMN_PRIOR_CONUS_MN", &
      "degrees",o3_ens_mn_prior_conus_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_O3_EMN_POST_CONUS_MN", &
      "degrees",o3_ens_mn_post_conus_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_O3_INCR_CONUS_MN", &
      "degrees",o3_incr_conus_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_O3_ESD_PRIOR_CONUS_MN", &
      "degrees",o3_ens_sd_prior_conus_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_O3_ESD_POST_CONUS_MN", &
      "degrees",o3_ens_sd_post_conus_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_O3_INFL_PRIOR_CONUS_MN", &
      "no units",o3_infl_prior_conus_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_O3_INFL_POST_CONUS_MN", &
      "no units",o3_infl_post_conus_mn,nz,1,1)
!      print *,'O3_ENS_PRIOR_MN ',o3_ens_mn_prior_conus_mn(:)
!      print *,'O3_INCR ',o3_incr_conus_mn(:)
!      print *,'O3_ENS_PRIOR_SD ',o3_ens_sd_prior_conus_mn(:)
!      print *,'O3_INFL_PRIOR_MN ',o3_infl_prior_conus_mn(:)
!
      deallocate(o3_ens_mn_prior_conus_mn)
      deallocate(o3_ens_mn_post_conus_mn)
      deallocate(o3_incr_conus_mn)
      deallocate(o3_ens_vr_prior_conus_mn)
      deallocate(o3_ens_vr_post_conus_mn)
      deallocate(o3_ens_sd_prior_conus_mn)
      deallocate(o3_ens_sd_post_conus_mn)
      deallocate(o3_infl_prior_conus_mn)
      deallocate(o3_infl_post_conus_mn)
!
!  TRACER-I URBAN Spatial statistics O3
      allocate(o3_ens_mn_prior_urban_mn(nz))
      allocate(o3_ens_mn_post_urban_mn(nz))
      allocate(o3_incr_urban_mn(nz))
      allocate(o3_ens_vr_prior_urban_mn(nz))
      allocate(o3_ens_vr_post_urban_mn(nz))
      allocate(o3_ens_sd_prior_urban_mn(nz))
      allocate(o3_ens_sd_post_urban_mn(nz))
      allocate(o3_infl_prior_urban_mn(nz))
      allocate(o3_infl_post_urban_mn(nz))
!
      call spatial_mean_and_variance(traceri_o3_prior_ens_mn,traceri_o3_post_ens_mn, &
      traceri_o3_incr,traceri_o3_prior_ens_vr,traceri_o3_post_ens_vr,traceri_o3_infl_prior, &
      traceri_o3_infl_post,o3_ens_mn_prior_urban_mn,o3_ens_mn_post_urban_mn,o3_incr_urban_mn, &
      o3_ens_vr_prior_urban_mn,o3_ens_vr_post_urban_mn,o3_infl_prior_urban_mn,o3_infl_post_urban_mn, &
      traceri_urban_ii,traceri_urban_jj,num_cities,npts_urban,num_urban,nx,ny,nz)
!
      o3_ens_sd_prior_urban_mn(:)=sqrt(o3_ens_vr_prior_urban_mn(:))
      o3_ens_sd_post_urban_mn(:)=sqrt(o3_ens_vr_post_urban_mn(:))
!
      call put_NETCDF_fld(trim(file_write),"TRACER_I_O3_EMN_PRIOR_URBAN_MN", &
      "degrees",o3_ens_mn_prior_urban_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_O3_EMN_POST_URBAN_MN", &
      "degrees",o3_ens_mn_post_urban_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_O3_INCR_URBAN_MN", &
      "degrees",o3_incr_urban_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_O3_ESD_PRIOR_URBAN_MN", &
      "degrees",o3_ens_sd_prior_urban_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_O3_ESD_POST_URBAN_MN", &
      "degrees",o3_ens_sd_post_urban_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_O3_INFL_PRIOR_URBAN_MN", &
      "degrees",o3_infl_prior_urban_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_O3_INFL_POST_URBAN_MN", &
      "degrees",o3_infl_post_urban_mn,nz,1,1)
!      print *,'O3_ENS_PRIOR_MN ',o3_ens_mn_prior_urban_mn(:)
!      print *,'O3_INCR ',o3_incr_urban_mn(:)
!      print *,'O3_ENS_PRIOR_SD ',o3_ens_sd_prior_urban_mn(:)
!      print *,'O3_INFL_PRIOR_MN ',o3_infl_prior_urban_mn(:)
!
      deallocate(o3_ens_mn_prior_urban_mn)
      deallocate(o3_ens_mn_post_urban_mn)
      deallocate(o3_incr_urban_mn)
      deallocate(o3_ens_vr_prior_urban_mn)
      deallocate(o3_ens_vr_post_urban_mn)
      deallocate(o3_ens_sd_prior_urban_mn)
      deallocate(o3_ens_sd_post_urban_mn)
      deallocate(o3_infl_prior_urban_mn)
      deallocate(o3_infl_post_urban_mn)
!
!  TRACER-I RURAL Spatial statistics O3
      allocate(o3_ens_mn_prior_rural_mn(nz))
      allocate(o3_ens_mn_post_rural_mn(nz))
      allocate(o3_incr_rural_mn(nz))
      allocate(o3_ens_vr_prior_rural_mn(nz))
      allocate(o3_ens_vr_post_rural_mn(nz))
      allocate(o3_ens_sd_prior_rural_mn(nz))
      allocate(o3_ens_sd_post_rural_mn(nz))
      allocate(o3_infl_prior_rural_mn(nz))
      allocate(o3_infl_post_rural_mn(nz))
!
      call spatial_mean_and_variance(traceri_o3_prior_ens_mn,traceri_o3_post_ens_mn, &
      traceri_o3_incr,traceri_o3_prior_ens_vr,traceri_o3_post_ens_vr,traceri_o3_infl_prior, &
      traceri_o3_infl_post,o3_ens_mn_prior_rural_mn,o3_ens_mn_post_rural_mn,o3_incr_rural_mn, &
      o3_ens_vr_prior_rural_mn,o3_ens_vr_post_rural_mn,o3_infl_prior_rural_mn,o3_infl_post_rural_mn, &
      traceri_rural_ii,traceri_rural_jj,1,nx*ny,num_rural,nx,ny,nz)
!
      o3_ens_sd_prior_rural_mn(:)=sqrt(o3_ens_vr_prior_rural_mn(:))
      o3_ens_sd_post_rural_mn(:)=sqrt(o3_ens_vr_post_rural_mn(:))
!
      call put_NETCDF_fld(trim(file_write),"TRACER_I_O3_EMN_PRIOR_RURAL_MN", &
      "degrees",o3_ens_mn_prior_rural_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_O3_EMN_POST_RURAL_MN", &
      "degrees",o3_ens_mn_post_rural_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_O3_INCR_RURAL_MN", &
      "degrees",o3_incr_rural_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_O3_ESD_PRIOR_RURAL_MN", &
      "degrees",o3_ens_sd_prior_rural_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_O3_ESD_POST_RURAL_MN", &
      "degrees",o3_ens_sd_post_rural_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_O3_INFL_PRIOR_RURAL_MN", &
      "degrees",o3_infl_prior_rural_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_O3_INFL_POST_RURAL_MN", &
      "degrees",o3_infl_post_rural_mn,nz,1,1)
!      print *,'O3_ENS_PRIOR_MN ',o3_ens_mn_prior_rural_mn(:)
!      print *,'O3_INCR ',o3_incr_rural_mn(:)
!      print *,'O3_ENS_PRIOR_SD ',o3_ens_sd_prior_rural_mn(:)
!      print *,'O3_INFL_PRIOR_MN ',o3_infl_prior_rural_mn(:)
!
      deallocate(o3_ens_mn_prior_rural_mn)
      deallocate(o3_ens_mn_post_rural_mn)
      deallocate(o3_incr_rural_mn)
      deallocate(o3_ens_vr_prior_rural_mn)
      deallocate(o3_ens_vr_post_rural_mn)
      deallocate(o3_ens_sd_prior_rural_mn)
      deallocate(o3_ens_sd_post_rural_mn)
      deallocate(o3_infl_prior_rural_mn)
      deallocate(o3_infl_post_rural_mn)
!
      deallocate(traceri_o3_prior_ens_mn)
      deallocate(traceri_o3_post_ens_mn)
      deallocate(traceri_o3_incr)
      deallocate(traceri_o3_prior_ens_sd)
      deallocate(traceri_o3_post_ens_sd)
      deallocate(traceri_o3_prior_ens_vr)
      deallocate(traceri_o3_post_ens_vr)
      deallocate(traceri_o3_infl_prior)
      deallocate(traceri_o3_infl_post)
!
! Read and process NO2
!
      allocate(traceri_no2_prior_ens_mn(nx,ny,nz))
      allocate(traceri_no2_post_ens_mn(nx,ny,nz))
      allocate(traceri_no2_incr(nx,ny,nz))
      allocate(traceri_no2_prior_ens_sd(nx,ny,nz))
      allocate(traceri_no2_post_ens_sd(nx,ny,nz))
      allocate(traceri_no2_prior_ens_vr(nx,ny,nz))
      allocate(traceri_no2_post_ens_vr(nx,ny,nz))
      allocate(traceri_no2_infl_prior(nx,ny,nz))
      allocate(traceri_no2_infl_post(nx,ny,nz))
!
      call get_WRFCHEM_fld_real(trim(file_read_prior_mn),"no2",traceri_no2_prior_ens_mn,nx,ny,nz,1)
      call get_WRFCHEM_fld_real(trim(file_read_post_mn),"no2",traceri_no2_post_ens_mn,nx,ny,nz,1)
      call get_WRFCHEM_fld_real(trim(file_read_prior_sd),"no2",traceri_no2_prior_ens_sd,nx,ny,nz,1)
      call get_WRFCHEM_fld_real(trim(file_read_post_sd),"no2",traceri_no2_post_ens_sd,nx,ny,nz,1)
      call get_WRFCHEM_fld_real(trim(file_read_infl_prior),"no2",traceri_no2_infl_prior,nx,ny,nz,1)
      call get_WRFCHEM_fld_real(trim(file_read_infl_post),"no2",traceri_no2_infl_post,nx,ny,nz,1)
!
      traceri_no2_incr(:,:,:)=traceri_no2_post_ens_mn(:,:,:)-traceri_no2_prior_ens_mn(:,:,:)
      traceri_no2_prior_ens_vr(:,:,:)=traceri_no2_prior_ens_sd(:,:,:)**2.
      traceri_no2_post_ens_vr(:,:,:)=traceri_no2_post_ens_sd(:,:,:)**2.
!
! TRACER-I CONUS Spatial statistics NO2
      allocate(no2_ens_mn_prior_conus_mn(nz))
      allocate(no2_ens_mn_post_conus_mn(nz))
      allocate(no2_incr_conus_mn(nz))
      allocate(no2_ens_vr_prior_conus_mn(nz))
      allocate(no2_ens_vr_post_conus_mn(nz))
      allocate(no2_ens_sd_prior_conus_mn(nz))
      allocate(no2_ens_sd_post_conus_mn(nz))
      allocate(no2_infl_prior_conus_mn(nz))
      allocate(no2_infl_post_conus_mn(nz))
!
      call spatial_mean_and_variance(traceri_no2_prior_ens_mn,traceri_no2_post_ens_mn, &
      traceri_no2_incr,traceri_no2_prior_ens_vr,traceri_no2_post_ens_vr,traceri_no2_infl_prior, &
      traceri_no2_infl_post,no2_ens_mn_prior_conus_mn,no2_ens_mn_post_conus_mn,no2_incr_conus_mn, &
      no2_ens_vr_prior_conus_mn,no2_ens_vr_post_conus_mn,no2_infl_prior_conus_mn,no2_infl_post_conus_mn, &
      traceri_conus_ii,traceri_conus_jj,1,nx*ny,num_conus,nx,ny,nz)
!
      no2_ens_sd_prior_conus_mn(:)=sqrt(no2_ens_vr_prior_conus_mn(:))
      no2_ens_sd_post_conus_mn(:)=sqrt(no2_ens_vr_post_conus_mn(:))
!
      call put_NETCDF_fld(trim(file_write),"TRACER_I_NO2_EMN_PRIOR_CONUS_MN", &
      "degrees",no2_ens_mn_prior_conus_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_NO2_EMN_POST_CONUS_MN", &
      "degrees",no2_ens_mn_post_conus_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_NO2_INCR_CONUS_MN", &
      "degrees",no2_incr_conus_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_NO2_ESD_PRIOR_CONUS_MN", &
      "degrees",no2_ens_sd_prior_conus_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_NO2_ESD_POST_CONUS_MN", &
      "degrees",no2_ens_sd_post_conus_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_NO2_INFL_PRIOR_CONUS_MN", &
      "no units",no2_infl_prior_conus_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_NO2_INFL_POST_CONUS_MN", &
      "no units",no2_infl_post_conus_mn,nz,1,1)
!      print *,'NO2_ENS_PRIOR_MN ',no2_ens_mn_prior_conus_mn(:)
!      print *,'NO2_INCR ',no2_incr_conus_mn(:)
!      print *,'NO2_ENS_PRIOR_SD ',no2_ens_sd_prior_conus_mn(:)
!      print *,'NO2_INFL_PRIOR_MN ',no2_infl_prior_conus_mn(:)
!
      deallocate(no2_ens_mn_prior_conus_mn)
      deallocate(no2_ens_mn_post_conus_mn)
      deallocate(no2_incr_conus_mn)
      deallocate(no2_ens_vr_prior_conus_mn)
      deallocate(no2_ens_vr_post_conus_mn)
      deallocate(no2_ens_sd_prior_conus_mn)
      deallocate(no2_ens_sd_post_conus_mn)
      deallocate(no2_infl_prior_conus_mn)
      deallocate(no2_infl_post_conus_mn)
!
!  TRACER-I URBAN Spatial statistics NO2
      allocate(no2_ens_mn_prior_urban_mn(nz))
      allocate(no2_ens_mn_post_urban_mn(nz))
      allocate(no2_incr_urban_mn(nz))
      allocate(no2_ens_vr_prior_urban_mn(nz))
      allocate(no2_ens_vr_post_urban_mn(nz))
      allocate(no2_ens_sd_prior_urban_mn(nz))
      allocate(no2_ens_sd_post_urban_mn(nz))
      allocate(no2_infl_prior_urban_mn(nz))
      allocate(no2_infl_post_urban_mn(nz))
!
      call spatial_mean_and_variance(traceri_no2_prior_ens_mn,traceri_no2_post_ens_mn, &
      traceri_no2_incr,traceri_no2_prior_ens_vr,traceri_no2_post_ens_vr,traceri_no2_infl_prior, &
      traceri_no2_infl_post,no2_ens_mn_prior_urban_mn,no2_ens_mn_post_urban_mn,no2_incr_urban_mn, &
      no2_ens_vr_prior_urban_mn,no2_ens_vr_post_urban_mn,no2_infl_prior_urban_mn,no2_infl_post_urban_mn, &
      traceri_urban_ii,traceri_urban_jj,num_cities,npts_urban,num_urban,nx,ny,nz)
!
      no2_ens_sd_prior_urban_mn(:)=sqrt(no2_ens_vr_prior_urban_mn(:))
      no2_ens_sd_post_urban_mn(:)=sqrt(no2_ens_vr_post_urban_mn(:))
!
      call put_NETCDF_fld(trim(file_write),"TRACER_I_NO2_EMN_PRIOR_URBAN_MN", &
      "degrees",no2_ens_mn_prior_urban_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_NO2_EMN_POST_URBAN_MN", &
      "degrees",no2_ens_mn_post_urban_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_NO2_INCR_URBAN_MN", &
      "degrees",no2_incr_urban_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_NO2_ESD_PRIOR_URBAN_MN", &
      "degrees",no2_ens_sd_prior_urban_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_NO2_ESD_POST_URBAN_MN", &
      "degrees",no2_ens_sd_post_urban_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_NO2_INFL_PRIOR_URBAN_MN", &
      "degrees",no2_infl_prior_urban_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_NO2_INFL_POST_URBAN_MN", &
      "degrees",no2_infl_post_urban_mn,nz,1,1)
!      print *,'NO2_ENS_PRIOR_MN ',no2_ens_mn_prior_urban_mn(:)
!      print *,'NO2_INCR ',no2_incr_urban_mn(:)
!      print *,'NO2_ENS_PRIOR_SD ',no2_ens_sd_prior_urban_mn(:)
!      print *,'NO2_INFL_PRIOR_MN ',no2_infl_prior_urban_mn(:)
!
      deallocate(no2_ens_mn_prior_urban_mn)
      deallocate(no2_ens_mn_post_urban_mn)
      deallocate(no2_incr_urban_mn)
      deallocate(no2_ens_vr_prior_urban_mn)
      deallocate(no2_ens_vr_post_urban_mn)
      deallocate(no2_ens_sd_prior_urban_mn)
      deallocate(no2_ens_sd_post_urban_mn)
      deallocate(no2_infl_prior_urban_mn)
      deallocate(no2_infl_post_urban_mn)
!
!  TRACER-I RURAL Spatial statistics NO2
      allocate(no2_ens_mn_prior_rural_mn(nz))
      allocate(no2_ens_mn_post_rural_mn(nz))
      allocate(no2_incr_rural_mn(nz))
      allocate(no2_ens_vr_prior_rural_mn(nz))
      allocate(no2_ens_vr_post_rural_mn(nz))
      allocate(no2_ens_sd_prior_rural_mn(nz))
      allocate(no2_ens_sd_post_rural_mn(nz))
      allocate(no2_infl_prior_rural_mn(nz))
      allocate(no2_infl_post_rural_mn(nz))
!
      call spatial_mean_and_variance(traceri_no2_prior_ens_mn,traceri_no2_post_ens_mn, &
      traceri_no2_incr,traceri_no2_prior_ens_vr,traceri_no2_post_ens_vr,traceri_no2_infl_prior, &
      traceri_no2_infl_post,no2_ens_mn_prior_rural_mn,no2_ens_mn_post_rural_mn,no2_incr_rural_mn, &
      no2_ens_vr_prior_rural_mn,no2_ens_vr_post_rural_mn,no2_infl_prior_rural_mn,no2_infl_post_rural_mn, &
      traceri_rural_ii,traceri_rural_jj,1,nx*ny,num_rural,nx,ny,nz)
!
      no2_ens_sd_prior_rural_mn(:)=sqrt(no2_ens_vr_prior_rural_mn(:))
      no2_ens_sd_post_rural_mn(:)=sqrt(no2_ens_vr_post_rural_mn(:))
!
      call put_NETCDF_fld(trim(file_write),"TRACER_I_NO2_EMN_PRIOR_RURAL_MN", &
      "degrees",no2_ens_mn_prior_rural_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_NO2_EMN_POST_RURAL_MN", &
      "degrees",no2_ens_mn_post_rural_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_NO2_INCR_RURAL_MN", &
      "degrees",no2_incr_rural_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_NO2_ESD_PRIOR_RURAL_MN", &
      "degrees",no2_ens_sd_prior_rural_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_NO2_ESD_POST_RURAL_MN", &
      "degrees",no2_ens_sd_post_rural_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_NO2_INFL_PRIOR_RURAL_MN", &
      "degrees",no2_infl_prior_rural_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_NO2_INFL_POST_RURAL_MN", &
      "degrees",no2_infl_post_rural_mn,nz,1,1)
!      print *,'NO2_ENS_PRIOR_MN ',no2_ens_mn_prior_rural_mn(:)
!      print *,'NO2_INCR ',no2_incr_rural_mn(:)
!      print *,'NO2_ENS_PRIOR_SD ',no2_ens_sd_prior_rural_mn(:)
!      print *,'NO2_INFL_PRIOR_MN ',no2_infl_prior_rural_mn(:)
!
      deallocate(no2_ens_mn_prior_rural_mn)
      deallocate(no2_ens_mn_post_rural_mn)
      deallocate(no2_incr_rural_mn)
      deallocate(no2_ens_vr_prior_rural_mn)
      deallocate(no2_ens_vr_post_rural_mn)
      deallocate(no2_ens_sd_prior_rural_mn)
      deallocate(no2_ens_sd_post_rural_mn)
      deallocate(no2_infl_prior_rural_mn)
      deallocate(no2_infl_post_rural_mn)
!
      deallocate(traceri_no2_prior_ens_mn)
      deallocate(traceri_no2_post_ens_mn)
      deallocate(traceri_no2_incr)
      deallocate(traceri_no2_prior_ens_sd)
      deallocate(traceri_no2_post_ens_sd)
      deallocate(traceri_no2_prior_ens_vr)
      deallocate(traceri_no2_post_ens_vr)
      deallocate(traceri_no2_infl_prior)
      deallocate(traceri_no2_infl_post)
!
! Read and process SO2
!
      allocate(traceri_so2_prior_ens_mn(nx,ny,nz))
      allocate(traceri_so2_post_ens_mn(nx,ny,nz))
      allocate(traceri_so2_incr(nx,ny,nz))
      allocate(traceri_so2_prior_ens_sd(nx,ny,nz))
      allocate(traceri_so2_post_ens_sd(nx,ny,nz))
      allocate(traceri_so2_prior_ens_vr(nx,ny,nz))
      allocate(traceri_so2_post_ens_vr(nx,ny,nz))
      allocate(traceri_so2_infl_prior(nx,ny,nz))
      allocate(traceri_so2_infl_post(nx,ny,nz))
!
      call get_WRFCHEM_fld_real(trim(file_read_prior_mn),"so2",traceri_so2_prior_ens_mn,nx,ny,nz,1)
      call get_WRFCHEM_fld_real(trim(file_read_post_mn),"so2",traceri_so2_post_ens_mn,nx,ny,nz,1)
      call get_WRFCHEM_fld_real(trim(file_read_prior_sd),"so2",traceri_so2_prior_ens_sd,nx,ny,nz,1)
      call get_WRFCHEM_fld_real(trim(file_read_post_sd),"so2",traceri_so2_post_ens_sd,nx,ny,nz,1)
      call get_WRFCHEM_fld_real(trim(file_read_infl_prior),"so2",traceri_so2_infl_prior,nx,ny,nz,1)
      call get_WRFCHEM_fld_real(trim(file_read_infl_post),"so2",traceri_so2_infl_post,nx,ny,nz,1)
!
      traceri_so2_incr(:,:,:)=traceri_so2_post_ens_mn(:,:,:)-traceri_so2_prior_ens_mn(:,:,:)
      traceri_so2_prior_ens_vr(:,:,:)=traceri_so2_prior_ens_sd(:,:,:)**2.
      traceri_so2_post_ens_vr(:,:,:)=traceri_so2_post_ens_sd(:,:,:)**2.
!
! TRACER-I CONUS Spatial statistics SO2
      allocate(so2_ens_mn_prior_conus_mn(nz))
      allocate(so2_ens_mn_post_conus_mn(nz))
      allocate(so2_incr_conus_mn(nz))
      allocate(so2_ens_vr_prior_conus_mn(nz))
      allocate(so2_ens_vr_post_conus_mn(nz))
      allocate(so2_ens_sd_prior_conus_mn(nz))
      allocate(so2_ens_sd_post_conus_mn(nz))
      allocate(so2_infl_prior_conus_mn(nz))
      allocate(so2_infl_post_conus_mn(nz))
!
      call spatial_mean_and_variance(traceri_so2_prior_ens_mn,traceri_so2_post_ens_mn, &
      traceri_so2_incr,traceri_so2_prior_ens_vr,traceri_so2_post_ens_vr,traceri_so2_infl_prior, &
      traceri_so2_infl_post,so2_ens_mn_prior_conus_mn,so2_ens_mn_post_conus_mn,so2_incr_conus_mn, &
      so2_ens_vr_prior_conus_mn,so2_ens_vr_post_conus_mn,so2_infl_prior_conus_mn,so2_infl_post_conus_mn, &
      traceri_conus_ii,traceri_conus_jj,1,nx*ny,num_conus,nx,ny,nz)
!
      so2_ens_sd_prior_conus_mn(:)=sqrt(so2_ens_vr_prior_conus_mn(:))
      so2_ens_sd_post_conus_mn(:)=sqrt(so2_ens_vr_post_conus_mn(:))
!
      call put_NETCDF_fld(trim(file_write),"TRACER_I_SO2_EMN_PRIOR_CONUS_MN", &
      "degrees",so2_ens_mn_prior_conus_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_SO2_EMN_POST_CONUS_MN", &
      "degrees",so2_ens_mn_post_conus_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_SO2_INCR_CONUS_MN", &
      "degrees",so2_incr_conus_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_SO2_ESD_PRIOR_CONUS_MN", &
      "degrees",so2_ens_sd_prior_conus_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_SO2_ESD_POST_CONUS_MN", &
      "degrees",so2_ens_sd_post_conus_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_SO2_INFL_PRIOR_CONUS_MN", &
      "no units",so2_infl_prior_conus_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_SO2_INFL_POST_CONUS_MN", &
      "no units",so2_infl_post_conus_mn,nz,1,1)
!      print *,'SO2_ENS_PRIOR_MN ',so2_ens_mn_prior_conus_mn(:)
!      print *,'SO2_INCR ',so2_incr_conus_mn(:)
!      print *,'SO2_ENS_PRIOR_SD ',so2_ens_sd_prior_conus_mn(:)
!      print *,'SO2_INFL_PRIOR_MN ',so2_infl_prior_conus_mn(:)
!
      deallocate(so2_ens_mn_prior_conus_mn)
      deallocate(so2_ens_mn_post_conus_mn)
      deallocate(so2_incr_conus_mn)
      deallocate(so2_ens_vr_prior_conus_mn)
      deallocate(so2_ens_vr_post_conus_mn)
      deallocate(so2_ens_sd_prior_conus_mn)
      deallocate(so2_ens_sd_post_conus_mn)
      deallocate(so2_infl_prior_conus_mn)
      deallocate(so2_infl_post_conus_mn)
!
!  TRACER-I URBAN Spatial statistics SO2
      allocate(so2_ens_mn_prior_urban_mn(nz))
      allocate(so2_ens_mn_post_urban_mn(nz))
      allocate(so2_incr_urban_mn(nz))
      allocate(so2_ens_vr_prior_urban_mn(nz))
      allocate(so2_ens_vr_post_urban_mn(nz))
      allocate(so2_ens_sd_prior_urban_mn(nz))
      allocate(so2_ens_sd_post_urban_mn(nz))
      allocate(so2_infl_prior_urban_mn(nz))
      allocate(so2_infl_post_urban_mn(nz))
!
      call spatial_mean_and_variance(traceri_so2_prior_ens_mn,traceri_so2_post_ens_mn, &
      traceri_so2_incr,traceri_so2_prior_ens_vr,traceri_so2_post_ens_vr,traceri_so2_infl_prior, &
      traceri_so2_infl_post,so2_ens_mn_prior_urban_mn,so2_ens_mn_post_urban_mn,so2_incr_urban_mn, &
      so2_ens_vr_prior_urban_mn,so2_ens_vr_post_urban_mn,so2_infl_prior_urban_mn,so2_infl_post_urban_mn, &
      traceri_urban_ii,traceri_urban_jj,num_cities,npts_urban,num_urban,nx,ny,nz)
!
      so2_ens_sd_prior_urban_mn(:)=sqrt(so2_ens_vr_prior_urban_mn(:))
      so2_ens_sd_post_urban_mn(:)=sqrt(so2_ens_vr_post_urban_mn(:))
!
      call put_NETCDF_fld(trim(file_write),"TRACER_I_SO2_EMN_PRIOR_URBAN_MN", &
      "degrees",so2_ens_mn_prior_urban_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_SO2_EMN_POST_URBAN_MN", &
      "degrees",so2_ens_mn_post_urban_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_SO2_INCR_URBAN_MN", &
      "degrees",so2_incr_urban_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_SO2_ESD_PRIOR_URBAN_MN", &
      "degrees",so2_ens_sd_prior_urban_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_SO2_ESD_POST_URBAN_MN", &
      "degrees",so2_ens_sd_post_urban_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_SO2_INFL_PRIOR_URBAN_MN", &
      "degrees",so2_infl_prior_urban_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_SO2_INFL_POST_URBAN_MN", &
      "degrees",so2_infl_post_urban_mn,nz,1,1)
!      print *,'SO2_ENS_PRIOR_MN ',so2_ens_mn_prior_urban_mn(:)
!      print *,'SO2_INCR ',so2_incr_urban_mn(:)
!      print *,'SO2_ENS_PRIOR_SD ',so2_ens_sd_prior_urban_mn(:)
!      print *,'SO2_INFL_PRIOR_MN ',so2_infl_prior_urban_mn(:)
!
      deallocate(so2_ens_mn_prior_urban_mn)
      deallocate(so2_ens_mn_post_urban_mn)
      deallocate(so2_incr_urban_mn)
      deallocate(so2_ens_vr_prior_urban_mn)
      deallocate(so2_ens_vr_post_urban_mn)
      deallocate(so2_ens_sd_prior_urban_mn)
      deallocate(so2_ens_sd_post_urban_mn)
      deallocate(so2_infl_prior_urban_mn)
      deallocate(so2_infl_post_urban_mn)
!
!  TRACER-I RURAL Spatial statistics SO2
      allocate(so2_ens_mn_prior_rural_mn(nz))
      allocate(so2_ens_mn_post_rural_mn(nz))
      allocate(so2_incr_rural_mn(nz))
      allocate(so2_ens_vr_prior_rural_mn(nz))
      allocate(so2_ens_vr_post_rural_mn(nz))
      allocate(so2_ens_sd_prior_rural_mn(nz))
      allocate(so2_ens_sd_post_rural_mn(nz))
      allocate(so2_infl_prior_rural_mn(nz))
      allocate(so2_infl_post_rural_mn(nz))
!
      call spatial_mean_and_variance(traceri_so2_prior_ens_mn,traceri_so2_post_ens_mn, &
      traceri_so2_incr,traceri_so2_prior_ens_vr,traceri_so2_post_ens_vr,traceri_so2_infl_prior, &
      traceri_so2_infl_post,so2_ens_mn_prior_rural_mn,so2_ens_mn_post_rural_mn,so2_incr_rural_mn, &
      so2_ens_vr_prior_rural_mn,so2_ens_vr_post_rural_mn,so2_infl_prior_rural_mn,so2_infl_post_rural_mn, &
      traceri_rural_ii,traceri_rural_jj,1,nx*ny,num_rural,nx,ny,nz)
!
      so2_ens_sd_prior_rural_mn(:)=sqrt(so2_ens_vr_prior_rural_mn(:))
      so2_ens_sd_post_rural_mn(:)=sqrt(so2_ens_vr_post_rural_mn(:))
!
      call put_NETCDF_fld(trim(file_write),"TRACER_I_SO2_EMN_PRIOR_RURAL_MN", &
      "degrees",so2_ens_mn_prior_rural_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_SO2_EMN_POST_RURAL_MN", &
      "degrees",so2_ens_mn_post_rural_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_SO2_INCR_RURAL_MN", &
      "degrees",so2_incr_rural_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_SO2_ESD_PRIOR_RURAL_MN", &
      "degrees",so2_ens_sd_prior_rural_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_SO2_ESD_POST_RURAL_MN", &
      "degrees",so2_ens_sd_post_rural_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_SO2_INFL_PRIOR_RURAL_MN", &
      "degrees",so2_infl_prior_rural_mn,nz,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_SO2_INFL_POST_RURAL_MN", &
      "degrees",so2_infl_post_rural_mn,nz,1,1)
!      print *,'SO2_ENS_PRIOR_MN ',so2_ens_mn_prior_rural_mn(:)
!      print *,'SO2_INCR ',so2_incr_rural_mn(:)
!      print *,'SO2_ENS_PRIOR_SD ',so2_ens_sd_prior_rural_mn(:)
!      print *,'SO2_INFL_PRIOR_MN ',so2_infl_prior_rural_mn(:)
!
      deallocate(so2_ens_mn_prior_rural_mn)
      deallocate(so2_ens_mn_post_rural_mn)
      deallocate(so2_incr_rural_mn)
      deallocate(so2_ens_vr_prior_rural_mn)
      deallocate(so2_ens_vr_post_rural_mn)
      deallocate(so2_ens_sd_prior_rural_mn)
      deallocate(so2_ens_sd_post_rural_mn)
      deallocate(so2_infl_prior_rural_mn)
      deallocate(so2_infl_post_rural_mn)
!
      deallocate(traceri_so2_prior_ens_mn)
      deallocate(traceri_so2_post_ens_mn)
      deallocate(traceri_so2_incr)
      deallocate(traceri_so2_prior_ens_sd)
      deallocate(traceri_so2_post_ens_sd)
      deallocate(traceri_so2_prior_ens_vr)
      deallocate(traceri_so2_post_ens_vr)
      deallocate(traceri_so2_infl_prior)
      deallocate(traceri_so2_infl_post)
!
! Read and process E_CO
!
      allocate(traceri_e_co_arc_prior(nx,ny,nz_chemi))
      allocate(traceri_e_co_prior_ens_mn(nx,ny,nz_chemi))
      allocate(traceri_e_co_post_ens_mn(nx,ny,nz_chemi))
      allocate(traceri_e_co_incr(nx,ny,nz_chemi))
      allocate(traceri_e_co_prior_ens_sd(nx,ny,nz_chemi))
      allocate(traceri_e_co_post_ens_sd(nx,ny,nz_chemi))
      allocate(traceri_e_co_prior_ens_vr(nx,ny,nz_chemi))
      allocate(traceri_e_co_post_ens_vr(nx,ny,nz_chemi))
      allocate(traceri_e_co_infl_prior(nx,ny,nz_chemi))
      allocate(traceri_e_co_infl_post(nx,ny,nz_chemi))
!
      call get_WRFCHEM_fld_real(trim(file_read_arc_prior_chemi),"E_CO",traceri_e_co_arc_prior,nx,ny,nz_chemi,1)
      call get_WRFCHEM_fld_real(trim(file_read_prior_mn),"E_CO",traceri_e_co_prior_ens_mn,nx,ny,nz_chemi,1)
      call get_WRFCHEM_fld_real(trim(file_read_post_mn),"E_CO",traceri_e_co_post_ens_mn,nx,ny,nz_chemi,1)
      call get_WRFCHEM_fld_real(trim(file_read_prior_sd),"E_CO",traceri_e_co_prior_ens_sd,nx,ny,nz_chemi,1)
      call get_WRFCHEM_fld_real(trim(file_read_post_sd),"E_CO",traceri_e_co_post_ens_sd,nx,ny,nz_chemi,1)
      call get_WRFCHEM_fld_real(trim(file_read_infl_prior),"E_CO",traceri_e_co_infl_prior,nx,ny,nz_chemi,1)
      call get_WRFCHEM_fld_real(trim(file_read_infl_post),"E_CO",traceri_e_co_infl_post,nx,ny,nz_chemi,1)
!
      traceri_e_co_incr(:,:,:)=traceri_e_co_post_ens_mn(:,:,:)-traceri_e_co_prior_ens_mn(:,:,:)
      traceri_e_co_prior_ens_vr(:,:,:)=traceri_e_co_prior_ens_sd(:,:,:)**2.
      traceri_e_co_post_ens_vr(:,:,:)=traceri_e_co_post_ens_sd(:,:,:)**2.
!
! TRACER-I CONUS Spatial statistics E_CO
      allocate(e_co_arc_prior_conus_mn(nz_chemi))
      allocate(e_co_ens_mn_prior_conus_mn(nz_chemi))
      allocate(e_co_ens_mn_post_conus_mn(nz_chemi))
      allocate(e_co_incr_conus_mn(nz_chemi))
      allocate(e_co_ens_vr_prior_conus_mn(nz_chemi))
      allocate(e_co_ens_vr_post_conus_mn(nz_chemi))
      allocate(e_co_ens_sd_prior_conus_mn(nz_chemi))
      allocate(e_co_ens_sd_post_conus_mn(nz_chemi))
      allocate(e_co_infl_prior_conus_mn(nz_chemi))
      allocate(e_co_infl_post_conus_mn(nz_chemi))
!
      call spatial_mean_and_variance_emiss(traceri_e_co_prior_ens_mn,traceri_e_co_post_ens_mn, &
      traceri_e_co_incr,traceri_e_co_prior_ens_vr,traceri_e_co_post_ens_vr,traceri_e_co_infl_prior, &
      traceri_e_co_infl_post,e_co_ens_mn_prior_conus_mn,e_co_ens_mn_post_conus_mn,e_co_incr_conus_mn, &
      e_co_ens_vr_prior_conus_mn,e_co_ens_vr_post_conus_mn,e_co_infl_prior_conus_mn,e_co_infl_post_conus_mn, &
      traceri_conus_ii,traceri_conus_jj,1,nx*ny,num_conus,nx,ny,nz_chemi, &
      traceri_e_co_arc_prior,e_co_arc_prior_conus_mn)
!
      e_co_ens_sd_prior_conus_mn(:)=sqrt(e_co_ens_vr_prior_conus_mn(:))
      e_co_ens_sd_post_conus_mn(:)=sqrt(e_co_ens_vr_post_conus_mn(:))
!
      call put_NETCDF_fld(trim(file_write),"TRACER_I_E_CO_ARC_PRIOR_CONUS_MN", &
      "degrees",e_co_arc_prior_conus_mn,nz_chemi,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_E_CO_EMN_PRIOR_CONUS_MN", &
      "degrees",e_co_ens_mn_prior_conus_mn,nz_chemi,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_E_CO_EMN_POST_CONUS_MN", &
      "degrees",e_co_ens_mn_post_conus_mn,nz_chemi,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_E_CO_INCR_CONUS_MN", &
      "degrees",e_co_incr_conus_mn,nz_chemi,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_E_CO_ESD_PRIOR_CONUS_MN", &
      "degrees",e_co_ens_sd_prior_conus_mn,nz_chemi,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_E_CO_ESD_POST_CONUS_MN", &
      "degrees",e_co_ens_sd_post_conus_mn,nz_chemi,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_E_CO_INFL_PRIOR_CONUS_MN", &
      "no units",e_co_infl_prior_conus_mn,nz_chemi,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_E_CO_INFL_POST_CONUS_MN", &
      "no units",e_co_infl_post_conus_mn,nz_chemi,1,1)
!      print *,'E_CO_ENS_PRIOR_MN ',e_co_ens_mn_prior_conus_mn(:)
!      print *,'E_CO_INCR ',e_co_incr_conus_mn(:)
!      print *,'E_CO_ENS_PRIOR_SD ',e_co_ens_sd_prior_conus_mn(:)
!      print *,'E_CO_INFL_PRIOR_MN ',e_co_infl_prior_conus_mn(:)
!
      deallocate(e_co_arc_prior_conus_mn)
      deallocate(e_co_ens_mn_prior_conus_mn)
      deallocate(e_co_ens_mn_post_conus_mn)
      deallocate(e_co_incr_conus_mn)
      deallocate(e_co_ens_vr_prior_conus_mn)
      deallocate(e_co_ens_vr_post_conus_mn)
      deallocate(e_co_ens_sd_prior_conus_mn)
      deallocate(e_co_ens_sd_post_conus_mn)
      deallocate(e_co_infl_prior_conus_mn)
      deallocate(e_co_infl_post_conus_mn)
!
!  TRACER-I URBAN Spatial statistics E_CO
      allocate(e_co_arc_prior_urban_mn(nz_chemi))
      allocate(e_co_ens_mn_prior_urban_mn(nz_chemi))
      allocate(e_co_ens_mn_post_urban_mn(nz_chemi))
      allocate(e_co_incr_urban_mn(nz_chemi))
      allocate(e_co_ens_vr_prior_urban_mn(nz_chemi))
      allocate(e_co_ens_vr_post_urban_mn(nz_chemi))
      allocate(e_co_ens_sd_prior_urban_mn(nz_chemi))
      allocate(e_co_ens_sd_post_urban_mn(nz_chemi))
      allocate(e_co_infl_prior_urban_mn(nz_chemi))
      allocate(e_co_infl_post_urban_mn(nz_chemi))
!
      call spatial_mean_and_variance_emiss(traceri_e_co_prior_ens_mn,traceri_e_co_post_ens_mn, &
      traceri_e_co_incr,traceri_e_co_prior_ens_vr,traceri_e_co_post_ens_vr,traceri_e_co_infl_prior, &
      traceri_e_co_infl_post,e_co_ens_mn_prior_urban_mn,e_co_ens_mn_post_urban_mn,e_co_incr_urban_mn, &
      e_co_ens_vr_prior_urban_mn,e_co_ens_vr_post_urban_mn,e_co_infl_prior_urban_mn,e_co_infl_post_urban_mn, &
      traceri_urban_ii,traceri_urban_jj,num_cities,npts_urban,num_urban,nx,ny,nz_chemi, &
      traceri_e_co_arc_prior,e_co_arc_prior_urban_mn)
!
      e_co_ens_sd_prior_urban_mn(:)=sqrt(e_co_ens_vr_prior_urban_mn(:))
      e_co_ens_sd_post_urban_mn(:)=sqrt(e_co_ens_vr_post_urban_mn(:))
!
      call put_NETCDF_fld(trim(file_write),"TRACER_I_E_CO_ARC_PRIOR_URBAN_MN", &
      "degrees",e_co_arc_prior_urban_mn,nz_chemi,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_E_CO_EMN_PRIOR_URBAN_MN", &
      "degrees",e_co_ens_mn_prior_urban_mn,nz_chemi,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_E_CO_EMN_POST_URBAN_MN", &
      "degrees",e_co_ens_mn_post_urban_mn,nz_chemi,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_E_CO_INCR_URBAN_MN", &
      "degrees",e_co_incr_urban_mn,nz_chemi,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_E_CO_ESD_PRIOR_URBAN_MN", &
      "degrees",e_co_ens_sd_prior_urban_mn,nz_chemi,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_E_CO_ESD_POST_URBAN_MN", &
      "degrees",e_co_ens_sd_post_urban_mn,nz_chemi,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_E_CO_INFL_PRIOR_URBAN_MN", &
      "degrees",e_co_infl_prior_urban_mn,nz_chemi,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_E_CO_INFL_POST_URBAN_MN", &
      "degrees",e_co_infl_post_urban_mn,nz_chemi,1,1)
!      print *,'E_CO_ENS_PRIOR_MN ',e_co_ens_mn_prior_urban_mn(:)
!      print *,'E_CO_INCR ',e_co_incr_urban_mn(:)
!      print *,'E_CO_ENS_PRIOR_SD ',e_co_ens_sd_prior_urban_mn(:)
!      print *,'E_CO_INFL_PRIOR_MN ',e_co_infl_prior_urban_mn(:)
!
      deallocate(e_co_arc_prior_urban_mn)
      deallocate(e_co_ens_mn_prior_urban_mn)
      deallocate(e_co_ens_mn_post_urban_mn)
      deallocate(e_co_incr_urban_mn)
      deallocate(e_co_ens_vr_prior_urban_mn)
      deallocate(e_co_ens_vr_post_urban_mn)
      deallocate(e_co_ens_sd_prior_urban_mn)
      deallocate(e_co_ens_sd_post_urban_mn)
      deallocate(e_co_infl_prior_urban_mn)
      deallocate(e_co_infl_post_urban_mn)
!
!  TRACER-I RURAL Spatial statistics E_CO
      allocate(e_co_arc_prior_rural_mn(nz_chemi))
      allocate(e_co_ens_mn_prior_rural_mn(nz_chemi))
      allocate(e_co_ens_mn_post_rural_mn(nz_chemi))
      allocate(e_co_incr_rural_mn(nz_chemi))
      allocate(e_co_ens_vr_prior_rural_mn(nz_chemi))
      allocate(e_co_ens_vr_post_rural_mn(nz_chemi))
      allocate(e_co_ens_sd_prior_rural_mn(nz_chemi))
      allocate(e_co_ens_sd_post_rural_mn(nz_chemi))
      allocate(e_co_infl_prior_rural_mn(nz_chemi))
      allocate(e_co_infl_post_rural_mn(nz_chemi))
!
      call spatial_mean_and_variance_emiss(traceri_e_co_prior_ens_mn,traceri_e_co_post_ens_mn, &
      traceri_e_co_incr,traceri_e_co_prior_ens_vr,traceri_e_co_post_ens_vr,traceri_e_co_infl_prior, &
      traceri_e_co_infl_post,e_co_ens_mn_prior_rural_mn,e_co_ens_mn_post_rural_mn,e_co_incr_rural_mn, &
      e_co_ens_vr_prior_rural_mn,e_co_ens_vr_post_rural_mn,e_co_infl_prior_rural_mn,e_co_infl_post_rural_mn, &
      traceri_rural_ii,traceri_rural_jj,1,nx*ny,num_rural,nx,ny,nz_chemi, &
      traceri_e_co_arc_prior,e_co_arc_prior_rural_mn)
!
      e_co_ens_sd_prior_rural_mn(:)=sqrt(e_co_ens_vr_prior_rural_mn(:))
      e_co_ens_sd_post_rural_mn(:)=sqrt(e_co_ens_vr_post_rural_mn(:))
!
      call put_NETCDF_fld(trim(file_write),"TRACER_I_E_CO_ARC_PRIOR_RURAL_MN", &
      "degrees",e_co_arc_prior_rural_mn,nz_chemi,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_E_CO_EMN_PRIOR_RURAL_MN", &
      "degrees",e_co_ens_mn_prior_rural_mn,nz_chemi,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_E_CO_EMN_POST_RURAL_MN", &
      "degrees",e_co_ens_mn_post_rural_mn,nz_chemi,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_E_CO_INCR_RURAL_MN", &
      "degrees",e_co_incr_rural_mn,nz_chemi,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_E_CO_ESD_PRIOR_RURAL_MN", &
      "degrees",e_co_ens_sd_prior_rural_mn,nz_chemi,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_E_CO_ESD_POST_RURAL_MN", &
      "degrees",e_co_ens_sd_post_rural_mn,nz_chemi,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_E_CO_INFL_PRIOR_RURAL_MN", &
      "degrees",e_co_infl_prior_rural_mn,nz_chemi,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_E_CO_INFL_POST_RURAL_MN", &
      "degrees",e_co_infl_post_rural_mn,nz_chemi,1,1)
!      print *,'E_CO_ENS_PRIOR_MN ',e_co_ens_mn_prior_rural_mn(:)
!      print *,'E_CO_INCR ',e_co_incr_rural_mn(:)
!      print *,'E_CO_ENS_PRIOR_SD ',e_co_ens_sd_prior_rural_mn(:)
!      print *,'E_CO_INFL_PRIOR_MN ',e_co_infl_prior_rural_mn(:)
!
      deallocate(e_co_arc_prior_rural_mn)
      deallocate(e_co_ens_mn_prior_rural_mn)
      deallocate(e_co_ens_mn_post_rural_mn)
      deallocate(e_co_incr_rural_mn)
      deallocate(e_co_ens_vr_prior_rural_mn)
      deallocate(e_co_ens_vr_post_rural_mn)
      deallocate(e_co_ens_sd_prior_rural_mn)
      deallocate(e_co_ens_sd_post_rural_mn)
      deallocate(e_co_infl_prior_rural_mn)
      deallocate(e_co_infl_post_rural_mn)
!
      deallocate(traceri_e_co_arc_prior)
      deallocate(traceri_e_co_prior_ens_mn)
      deallocate(traceri_e_co_post_ens_mn)
      deallocate(traceri_e_co_incr)
      deallocate(traceri_e_co_prior_ens_sd)
      deallocate(traceri_e_co_post_ens_sd)
      deallocate(traceri_e_co_prior_ens_vr)
      deallocate(traceri_e_co_post_ens_vr)
      deallocate(traceri_e_co_infl_prior)
      deallocate(traceri_e_co_infl_post)
!
! Read and process E_NO2
!
      allocate(traceri_e_no2_arc_prior(nx,ny,nz_chemi))
      allocate(traceri_e_no2_prior_ens_mn(nx,ny,nz_chemi))
      allocate(traceri_e_no2_post_ens_mn(nx,ny,nz_chemi))
      allocate(traceri_e_no2_incr(nx,ny,nz_chemi))
      allocate(traceri_e_no2_prior_ens_sd(nx,ny,nz_chemi))
      allocate(traceri_e_no2_post_ens_sd(nx,ny,nz_chemi))
      allocate(traceri_e_no2_prior_ens_vr(nx,ny,nz_chemi))
      allocate(traceri_e_no2_post_ens_vr(nx,ny,nz_chemi))
      allocate(traceri_e_no2_infl_prior(nx,ny,nz_chemi))
      allocate(traceri_e_no2_infl_post(nx,ny,nz_chemi))
!
      call get_WRFCHEM_fld_real(trim(file_read_arc_prior_chemi),"E_NO2",traceri_e_no2_arc_prior,nx,ny,nz_chemi,1)
      call get_WRFCHEM_fld_real(trim(file_read_prior_mn),"E_NO2",traceri_e_no2_prior_ens_mn,nx,ny,nz_chemi,1)
      call get_WRFCHEM_fld_real(trim(file_read_post_mn),"E_NO2",traceri_e_no2_post_ens_mn,nx,ny,nz_chemi,1)
      call get_WRFCHEM_fld_real(trim(file_read_prior_sd),"E_NO2",traceri_e_no2_prior_ens_sd,nx,ny,nz_chemi,1)
      call get_WRFCHEM_fld_real(trim(file_read_post_sd),"E_NO2",traceri_e_no2_post_ens_sd,nx,ny,nz_chemi,1)
      call get_WRFCHEM_fld_real(trim(file_read_infl_prior),"E_NO2",traceri_e_no2_infl_prior,nx,ny,nz_chemi,1)
      call get_WRFCHEM_fld_real(trim(file_read_infl_post),"E_NO2",traceri_e_no2_infl_post,nx,ny,nz_chemi,1)
!
      traceri_e_no2_incr(:,:,:)=traceri_e_no2_post_ens_mn(:,:,:)-traceri_e_no2_prior_ens_mn(:,:,:)
      traceri_e_no2_prior_ens_vr(:,:,:)=traceri_e_no2_prior_ens_sd(:,:,:)**2.
      traceri_e_no2_post_ens_vr(:,:,:)=traceri_e_no2_post_ens_sd(:,:,:)**2.
!
! TRACER-I CONUS Spatial statistics E_NO2
      allocate(e_no2_arc_prior_conus_mn(nz_chemi))
      allocate(e_no2_ens_mn_prior_conus_mn(nz_chemi))
      allocate(e_no2_ens_mn_post_conus_mn(nz_chemi))
      allocate(e_no2_incr_conus_mn(nz_chemi))
      allocate(e_no2_ens_vr_prior_conus_mn(nz_chemi))
      allocate(e_no2_ens_vr_post_conus_mn(nz_chemi))
      allocate(e_no2_ens_sd_prior_conus_mn(nz_chemi))
      allocate(e_no2_ens_sd_post_conus_mn(nz_chemi))
      allocate(e_no2_infl_prior_conus_mn(nz_chemi))
      allocate(e_no2_infl_post_conus_mn(nz_chemi))
!
      call spatial_mean_and_variance_emiss(traceri_e_no2_prior_ens_mn,traceri_e_no2_post_ens_mn, &
      traceri_e_no2_incr,traceri_e_no2_prior_ens_vr,traceri_e_no2_post_ens_vr,traceri_e_no2_infl_prior, &
      traceri_e_no2_infl_post,e_no2_ens_mn_prior_conus_mn,e_no2_ens_mn_post_conus_mn,e_no2_incr_conus_mn, &
      e_no2_ens_vr_prior_conus_mn,e_no2_ens_vr_post_conus_mn,e_no2_infl_prior_conus_mn,e_no2_infl_post_conus_mn, &
      traceri_conus_ii,traceri_conus_jj,1,nx*ny,num_conus,nx,ny,nz_chemi, &
      traceri_e_no2_arc_prior,e_no2_arc_prior_conus_mn)
!
      e_no2_ens_sd_prior_conus_mn(:)=sqrt(e_no2_ens_vr_prior_conus_mn(:))
      e_no2_ens_sd_post_conus_mn(:)=sqrt(e_no2_ens_vr_post_conus_mn(:))
!
      call put_NETCDF_fld(trim(file_write),"TRACER_I_E_NO2_ARC_PRIOR_CONUS_MN", &
      "degrees",e_no2_arc_prior_conus_mn,nz_chemi,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_E_NO2_EMN_PRIOR_CONUS_MN", &
      "degrees",e_no2_ens_mn_prior_conus_mn,nz_chemi,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_E_NO2_EMN_POST_CONUS_MN", &
      "degrees",e_no2_ens_mn_post_conus_mn,nz_chemi,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_E_NO2_INCR_CONUS_MN", &
      "degrees",e_no2_incr_conus_mn,nz_chemi,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_E_NO2_ESD_PRIOR_CONUS_MN", &
      "degrees",e_no2_ens_sd_prior_conus_mn,nz_chemi,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_E_NO2_ESD_POST_CONUS_MN", &
      "degrees",e_no2_ens_sd_post_conus_mn,nz_chemi,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_E_NO2_INFL_PRIOR_CONUS_MN", &
      "no units",e_no2_infl_prior_conus_mn,nz_chemi,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_E_NO2_INFL_POST_CONUS_MN", &
      "no units",e_no2_infl_post_conus_mn,nz_chemi,1,1)
!      print *,'E_NO2_ENS_PRIOR_MN ',e_no2_ens_mn_prior_conus_mn(:)
!      print *,'E_NO2_INCR ',e_no2_incr_conus_mn(:)
!      print *,'E_NO2_ENS_PRIOR_SD ',e_no2_ens_sd_prior_conus_mn(:)
!      print *,'E_NO2_INFL_PRIOR_MN ',e_no2_infl_prior_conus_mn(:)
!
      deallocate(e_no2_arc_prior_conus_mn)
      deallocate(e_no2_ens_mn_prior_conus_mn)
      deallocate(e_no2_ens_mn_post_conus_mn)
      deallocate(e_no2_incr_conus_mn)
      deallocate(e_no2_ens_vr_prior_conus_mn)
      deallocate(e_no2_ens_vr_post_conus_mn)
      deallocate(e_no2_ens_sd_prior_conus_mn)
      deallocate(e_no2_ens_sd_post_conus_mn)
      deallocate(e_no2_infl_prior_conus_mn)
      deallocate(e_no2_infl_post_conus_mn)
!
!  TRACER-I URBAN Spatial statistics E_NO2
      allocate(e_no2_arc_prior_urban_mn(nz_chemi))
      allocate(e_no2_ens_mn_prior_urban_mn(nz_chemi))
      allocate(e_no2_ens_mn_post_urban_mn(nz_chemi))
      allocate(e_no2_incr_urban_mn(nz_chemi))
      allocate(e_no2_ens_vr_prior_urban_mn(nz_chemi))
      allocate(e_no2_ens_vr_post_urban_mn(nz_chemi))
      allocate(e_no2_ens_sd_prior_urban_mn(nz_chemi))
      allocate(e_no2_ens_sd_post_urban_mn(nz_chemi))
      allocate(e_no2_infl_prior_urban_mn(nz_chemi))
      allocate(e_no2_infl_post_urban_mn(nz_chemi))
!
      call spatial_mean_and_variance_emiss(traceri_e_no2_prior_ens_mn,traceri_e_no2_post_ens_mn, &
      traceri_e_no2_incr,traceri_e_no2_prior_ens_vr,traceri_e_no2_post_ens_vr,traceri_e_no2_infl_prior, &
      traceri_e_no2_infl_post,e_no2_ens_mn_prior_urban_mn,e_no2_ens_mn_post_urban_mn,e_no2_incr_urban_mn, &
      e_no2_ens_vr_prior_urban_mn,e_no2_ens_vr_post_urban_mn,e_no2_infl_prior_urban_mn,e_no2_infl_post_urban_mn, &
      traceri_urban_ii,traceri_urban_jj,num_cities,npts_urban,num_urban,nx,ny,nz_chemi, &
      traceri_e_no2_arc_prior,e_no2_arc_prior_urban_mn)
!
      e_no2_ens_sd_prior_urban_mn(:)=sqrt(e_no2_ens_vr_prior_urban_mn(:))
      e_no2_ens_sd_post_urban_mn(:)=sqrt(e_no2_ens_vr_post_urban_mn(:))
!
      call put_NETCDF_fld(trim(file_write),"TRACER_I_E_NO2_ARC_PRIOR_URBAN_MN", &
      "degrees",e_no2_arc_prior_urban_mn,nz_chemi,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_E_NO2_EMN_PRIOR_URBAN_MN", &
      "degrees",e_no2_ens_mn_prior_urban_mn,nz_chemi,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_E_NO2_EMN_POST_URBAN_MN", &
      "degrees",e_no2_ens_mn_post_urban_mn,nz_chemi,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_E_NO2_INCR_URBAN_MN", &
      "degrees",e_no2_incr_urban_mn,nz_chemi,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_E_NO2_ESD_PRIOR_URBAN_MN", &
      "degrees",e_no2_ens_sd_prior_urban_mn,nz_chemi,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_E_NO2_ESD_POST_URBAN_MN", &
      "degrees",e_no2_ens_sd_post_urban_mn,nz_chemi,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_E_NO2_INFL_PRIOR_URBAN_MN", &
      "degrees",e_no2_infl_prior_urban_mn,nz_chemi,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_E_NO2_INFL_POST_URBAN_MN", &
      "degrees",e_no2_infl_post_urban_mn,nz_chemi,1,1)
!      print *,'E_NO2_ENS_PRIOR_MN ',e_no2_ens_mn_prior_urban_mn(:)
!      print *,'E_NO2_INCR ',e_no2_incr_urban_mn(:)
!      print *,'E_NO2_ENS_PRIOR_SD ',e_no2_ens_sd_prior_urban_mn(:)
!      print *,'E_NO2_INFL_PRIOR_MN ',e_no2_infl_prior_urban_mn(:)
!
      deallocate(e_no2_arc_prior_urban_mn)
      deallocate(e_no2_ens_mn_prior_urban_mn)
      deallocate(e_no2_ens_mn_post_urban_mn)
      deallocate(e_no2_incr_urban_mn)
      deallocate(e_no2_ens_vr_prior_urban_mn)
      deallocate(e_no2_ens_vr_post_urban_mn)
      deallocate(e_no2_ens_sd_prior_urban_mn)
      deallocate(e_no2_ens_sd_post_urban_mn)
      deallocate(e_no2_infl_prior_urban_mn)
      deallocate(e_no2_infl_post_urban_mn)
!
!  TRACER-I RURAL Spatial statistics E_NO2
      allocate(e_no2_arc_prior_rural_mn(nz_chemi))
      allocate(e_no2_ens_mn_prior_rural_mn(nz_chemi))
      allocate(e_no2_ens_mn_post_rural_mn(nz_chemi))
      allocate(e_no2_incr_rural_mn(nz_chemi))
      allocate(e_no2_ens_vr_prior_rural_mn(nz_chemi))
      allocate(e_no2_ens_vr_post_rural_mn(nz_chemi))
      allocate(e_no2_ens_sd_prior_rural_mn(nz_chemi))
      allocate(e_no2_ens_sd_post_rural_mn(nz_chemi))
      allocate(e_no2_infl_prior_rural_mn(nz_chemi))
      allocate(e_no2_infl_post_rural_mn(nz_chemi))
!
      call spatial_mean_and_variance_emiss(traceri_e_no2_prior_ens_mn,traceri_e_no2_post_ens_mn, &
      traceri_e_no2_incr,traceri_e_no2_prior_ens_vr,traceri_e_no2_post_ens_vr,traceri_e_no2_infl_prior, &
      traceri_e_no2_infl_post,e_no2_ens_mn_prior_rural_mn,e_no2_ens_mn_post_rural_mn,e_no2_incr_rural_mn, &
      e_no2_ens_vr_prior_rural_mn,e_no2_ens_vr_post_rural_mn,e_no2_infl_prior_rural_mn,e_no2_infl_post_rural_mn, &
      traceri_rural_ii,traceri_rural_jj,1,nx*ny,num_rural,nx,ny,nz_chemi, &
      traceri_e_no2_arc_prior,e_no2_arc_prior_rural_mn)
!
      e_no2_ens_sd_prior_rural_mn(:)=sqrt(e_no2_ens_vr_prior_rural_mn(:))
      e_no2_ens_sd_post_rural_mn(:)=sqrt(e_no2_ens_vr_post_rural_mn(:))
!
      call put_NETCDF_fld(trim(file_write),"TRACER_I_E_NO2_ARC_PRIOR_RURAL_MN", &
      "degrees",e_no2_arc_prior_rural_mn,nz_chemi,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_E_NO2_EMN_PRIOR_RURAL_MN", &
      "degrees",e_no2_ens_mn_prior_rural_mn,nz_chemi,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_E_NO2_EMN_POST_RURAL_MN", &
      "degrees",e_no2_ens_mn_post_rural_mn,nz_chemi,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_E_NO2_INCR_RURAL_MN", &
      "degrees",e_no2_incr_rural_mn,nz_chemi,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_E_NO2_ESD_PRIOR_RURAL_MN", &
      "degrees",e_no2_ens_sd_prior_rural_mn,nz_chemi,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_E_NO2_ESD_POST_RURAL_MN", &
      "degrees",e_no2_ens_sd_post_rural_mn,nz_chemi,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_E_NO2_INFL_PRIOR_RURAL_MN", &
      "degrees",e_no2_infl_prior_rural_mn,nz_chemi,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_E_NO2_INFL_POST_RURAL_MN", &
      "degrees",e_no2_infl_post_rural_mn,nz_chemi,1,1)
!      print *,'E_NO2_ENS_PRIOR_MN ',e_no2_ens_mn_prior_rural_mn(:)
!      print *,'E_NO2_INCR ',e_no2_incr_rural_mn(:)
!      print *,'E_NO2_ENS_PRIOR_SD ',e_no2_ens_sd_prior_rural_mn(:)
!      print *,'E_NO2_INFL_PRIOR_MN ',e_no2_infl_prior_rural_mn(:)
!
      deallocate(e_no2_arc_prior_rural_mn)
      deallocate(e_no2_ens_mn_prior_rural_mn)
      deallocate(e_no2_ens_mn_post_rural_mn)
      deallocate(e_no2_incr_rural_mn)
      deallocate(e_no2_ens_vr_prior_rural_mn)
      deallocate(e_no2_ens_vr_post_rural_mn)
      deallocate(e_no2_ens_sd_prior_rural_mn)
      deallocate(e_no2_ens_sd_post_rural_mn)
      deallocate(e_no2_infl_prior_rural_mn)
      deallocate(e_no2_infl_post_rural_mn)
!
      deallocate(traceri_e_no2_arc_prior)
      deallocate(traceri_e_no2_prior_ens_mn)
      deallocate(traceri_e_no2_post_ens_mn)
      deallocate(traceri_e_no2_incr)
      deallocate(traceri_e_no2_prior_ens_sd)
      deallocate(traceri_e_no2_post_ens_sd)
      deallocate(traceri_e_no2_prior_ens_vr)
      deallocate(traceri_e_no2_post_ens_vr)
      deallocate(traceri_e_no2_infl_prior)
      deallocate(traceri_e_no2_infl_post)
!
! Read and process E_SO2
!
      allocate(traceri_e_so2_arc_prior(nx,ny,nz_chemi))
      allocate(traceri_e_so2_prior_ens_mn(nx,ny,nz_chemi))
      allocate(traceri_e_so2_post_ens_mn(nx,ny,nz_chemi))
      allocate(traceri_e_so2_incr(nx,ny,nz_chemi))
      allocate(traceri_e_so2_prior_ens_sd(nx,ny,nz_chemi))
      allocate(traceri_e_so2_post_ens_sd(nx,ny,nz_chemi))
      allocate(traceri_e_so2_prior_ens_vr(nx,ny,nz_chemi))
      allocate(traceri_e_so2_post_ens_vr(nx,ny,nz_chemi))
      allocate(traceri_e_so2_infl_prior(nx,ny,nz_chemi))
      allocate(traceri_e_so2_infl_post(nx,ny,nz_chemi))
!
      call get_WRFCHEM_fld_real(trim(file_read_arc_prior_chemi),"E_SO2",traceri_e_so2_arc_prior,nx,ny,nz_chemi,1)
      call get_WRFCHEM_fld_real(trim(file_read_prior_mn),"E_SO2",traceri_e_so2_prior_ens_mn,nx,ny,nz_chemi,1)
      call get_WRFCHEM_fld_real(trim(file_read_post_mn),"E_SO2",traceri_e_so2_post_ens_mn,nx,ny,nz_chemi,1)
      call get_WRFCHEM_fld_real(trim(file_read_prior_sd),"E_SO2",traceri_e_so2_prior_ens_sd,nx,ny,nz_chemi,1)
      call get_WRFCHEM_fld_real(trim(file_read_post_sd),"E_SO2",traceri_e_so2_post_ens_sd,nx,ny,nz_chemi,1)
      call get_WRFCHEM_fld_real(trim(file_read_infl_prior),"E_SO2",traceri_e_so2_infl_prior,nx,ny,nz_chemi,1)
      call get_WRFCHEM_fld_real(trim(file_read_infl_post),"E_SO2",traceri_e_so2_infl_post,nx,ny,nz_chemi,1)
!
      traceri_e_so2_incr(:,:,:)=traceri_e_so2_post_ens_mn(:,:,:)-traceri_e_so2_prior_ens_mn(:,:,:)
      traceri_e_so2_prior_ens_vr(:,:,:)=traceri_e_so2_prior_ens_sd(:,:,:)**2.
      traceri_e_so2_post_ens_vr(:,:,:)=traceri_e_so2_post_ens_sd(:,:,:)**2.
!
! TRACER-I CONUS Spatial statistics E_SO2
      allocate(e_so2_arc_prior_conus_mn(nz_chemi))
      allocate(e_so2_ens_mn_prior_conus_mn(nz_chemi))
      allocate(e_so2_ens_mn_post_conus_mn(nz_chemi))
      allocate(e_so2_incr_conus_mn(nz_chemi))
      allocate(e_so2_ens_vr_prior_conus_mn(nz_chemi))
      allocate(e_so2_ens_vr_post_conus_mn(nz_chemi))
      allocate(e_so2_ens_sd_prior_conus_mn(nz_chemi))
      allocate(e_so2_ens_sd_post_conus_mn(nz_chemi))
      allocate(e_so2_infl_prior_conus_mn(nz_chemi))
      allocate(e_so2_infl_post_conus_mn(nz_chemi))
!
      call spatial_mean_and_variance_emiss(traceri_e_so2_prior_ens_mn,traceri_e_so2_post_ens_mn, &
      traceri_e_so2_incr,traceri_e_so2_prior_ens_vr,traceri_e_so2_post_ens_vr,traceri_e_so2_infl_prior, &
      traceri_e_so2_infl_post,e_so2_ens_mn_prior_conus_mn,e_so2_ens_mn_post_conus_mn,e_so2_incr_conus_mn, &
      e_so2_ens_vr_prior_conus_mn,e_so2_ens_vr_post_conus_mn,e_so2_infl_prior_conus_mn,e_so2_infl_post_conus_mn, &
      traceri_conus_ii,traceri_conus_jj,1,nx*ny,num_conus,nx,ny,nz_chemi, &
      traceri_e_so2_arc_prior,e_so2_arc_prior_conus_mn)
!
      e_so2_ens_sd_prior_conus_mn(:)=sqrt(e_so2_ens_vr_prior_conus_mn(:))
      e_so2_ens_sd_post_conus_mn(:)=sqrt(e_so2_ens_vr_post_conus_mn(:))
!
      call put_NETCDF_fld(trim(file_write),"TRACER_I_E_SO2_ARC_PRIOR_CONUS_MN", &
      "degrees",e_so2_arc_prior_conus_mn,nz_chemi,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_E_SO2_EMN_PRIOR_CONUS_MN", &
      "degrees",e_so2_ens_mn_prior_conus_mn,nz_chemi,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_E_SO2_EMN_POST_CONUS_MN", &
      "degrees",e_so2_ens_mn_post_conus_mn,nz_chemi,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_E_SO2_INCR_CONUS_MN", &
      "degrees",e_so2_incr_conus_mn,nz_chemi,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_E_SO2_ESD_PRIOR_CONUS_MN", &
      "degrees",e_so2_ens_sd_prior_conus_mn,nz_chemi,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_E_SO2_ESD_POST_CONUS_MN", &
      "degrees",e_so2_ens_sd_post_conus_mn,nz_chemi,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_E_SO2_INFL_PRIOR_CONUS_MN", &
      "no units",e_so2_infl_prior_conus_mn,nz_chemi,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_E_SO2_INFL_POST_CONUS_MN", &
      "no units",e_so2_infl_post_conus_mn,nz_chemi,1,1)
!      print *,'E_SO2_ENS_PRIOR_MN ',e_so2_ens_mn_prior_conus_mn(:)
!      print *,'E_SO2_INCR ',e_so2_incr_conus_mn(:)
!      print *,'E_SO2_ENS_PRIOR_SD ',e_so2_ens_sd_prior_conus_mn(:)
!      print *,'E_SO2_INFL_PRIOR_MN ',e_so2_infl_prior_conus_mn(:)
!
      deallocate(e_so2_arc_prior_conus_mn)
      deallocate(e_so2_ens_mn_prior_conus_mn)
      deallocate(e_so2_ens_mn_post_conus_mn)
      deallocate(e_so2_incr_conus_mn)
      deallocate(e_so2_ens_vr_prior_conus_mn)
      deallocate(e_so2_ens_vr_post_conus_mn)
      deallocate(e_so2_ens_sd_prior_conus_mn)
      deallocate(e_so2_ens_sd_post_conus_mn)
      deallocate(e_so2_infl_prior_conus_mn)
      deallocate(e_so2_infl_post_conus_mn)
!
!  TRACER-I URBAN Spatial statistics E_SO2
      allocate(e_so2_arc_prior_urban_mn(nz_chemi))
      allocate(e_so2_ens_mn_prior_urban_mn(nz_chemi))
      allocate(e_so2_ens_mn_post_urban_mn(nz_chemi))
      allocate(e_so2_incr_urban_mn(nz_chemi))
      allocate(e_so2_ens_vr_prior_urban_mn(nz_chemi))
      allocate(e_so2_ens_vr_post_urban_mn(nz_chemi))
      allocate(e_so2_ens_sd_prior_urban_mn(nz_chemi))
      allocate(e_so2_ens_sd_post_urban_mn(nz_chemi))
      allocate(e_so2_infl_prior_urban_mn(nz_chemi))
      allocate(e_so2_infl_post_urban_mn(nz_chemi))
!
      call spatial_mean_and_variance_emiss(traceri_e_so2_prior_ens_mn,traceri_e_so2_post_ens_mn, &
      traceri_e_so2_incr,traceri_e_so2_prior_ens_vr,traceri_e_so2_post_ens_vr,traceri_e_so2_infl_prior, &
      traceri_e_so2_infl_post,e_so2_ens_mn_prior_urban_mn,e_so2_ens_mn_post_urban_mn,e_so2_incr_urban_mn, &
      e_so2_ens_vr_prior_urban_mn,e_so2_ens_vr_post_urban_mn,e_so2_infl_prior_urban_mn,e_so2_infl_post_urban_mn, &
      traceri_urban_ii,traceri_urban_jj,num_cities,npts_urban,num_urban,nx,ny,nz_chemi, &
      traceri_e_so2_arc_prior,e_so2_arc_prior_urban_mn)
!
      e_so2_ens_sd_prior_urban_mn(:)=sqrt(e_so2_ens_vr_prior_urban_mn(:))
      e_so2_ens_sd_post_urban_mn(:)=sqrt(e_so2_ens_vr_post_urban_mn(:))
!
      call put_NETCDF_fld(trim(file_write),"TRACER_I_E_SO2_ARC_PRIOR_URBAN_MN", &
      "degrees",e_so2_arc_prior_urban_mn,nz_chemi,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_E_SO2_EMN_PRIOR_URBAN_MN", &
      "degrees",e_so2_ens_mn_prior_urban_mn,nz_chemi,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_E_SO2_EMN_POST_URBAN_MN", &
      "degrees",e_so2_ens_mn_post_urban_mn,nz_chemi,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_E_SO2_INCR_URBAN_MN", &
      "degrees",e_so2_incr_urban_mn,nz_chemi,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_E_SO2_ESD_PRIOR_URBAN_MN", &
      "degrees",e_so2_ens_sd_prior_urban_mn,nz_chemi,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_E_SO2_ESD_POST_URBAN_MN", &
      "degrees",e_so2_ens_sd_post_urban_mn,nz_chemi,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_E_SO2_INFL_PRIOR_URBAN_MN", &
      "degrees",e_so2_infl_prior_urban_mn,nz_chemi,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_E_SO2_INFL_POST_URBAN_MN", &
      "degrees",e_so2_infl_post_urban_mn,nz_chemi,1,1)
!      print *,'E_SO2_ENS_PRIOR_MN ',e_so2_ens_mn_prior_urban_mn(:)
!      print *,'E_SO2_INCR ',e_so2_incr_urban_mn(:)
!      print *,'E_SO2_ENS_PRIOR_SD ',e_so2_ens_sd_prior_urban_mn(:)
!      print *,'E_SO2_INFL_PRIOR_MN ',e_so2_infl_prior_urban_mn(:)
!
      deallocate(e_so2_arc_prior_urban_mn)
      deallocate(e_so2_ens_mn_prior_urban_mn)
      deallocate(e_so2_ens_mn_post_urban_mn)
      deallocate(e_so2_incr_urban_mn)
      deallocate(e_so2_ens_vr_prior_urban_mn)
      deallocate(e_so2_ens_vr_post_urban_mn)
      deallocate(e_so2_ens_sd_prior_urban_mn)
      deallocate(e_so2_ens_sd_post_urban_mn)
      deallocate(e_so2_infl_prior_urban_mn)
      deallocate(e_so2_infl_post_urban_mn)
!
!  TRACER-I RURAL Spatial statistics E_SO2
      allocate(e_so2_arc_prior_rural_mn(nz_chemi))
      allocate(e_so2_ens_mn_prior_rural_mn(nz_chemi))
      allocate(e_so2_ens_mn_post_rural_mn(nz_chemi))
      allocate(e_so2_incr_rural_mn(nz_chemi))
      allocate(e_so2_ens_vr_prior_rural_mn(nz_chemi))
      allocate(e_so2_ens_vr_post_rural_mn(nz_chemi))
      allocate(e_so2_ens_sd_prior_rural_mn(nz_chemi))
      allocate(e_so2_ens_sd_post_rural_mn(nz_chemi))
      allocate(e_so2_infl_prior_rural_mn(nz_chemi))
      allocate(e_so2_infl_post_rural_mn(nz_chemi))
!
      call spatial_mean_and_variance_emiss(traceri_e_so2_prior_ens_mn,traceri_e_so2_post_ens_mn, &
      traceri_e_so2_incr,traceri_e_so2_prior_ens_vr,traceri_e_so2_post_ens_vr,traceri_e_so2_infl_prior, &
      traceri_e_so2_infl_post,e_so2_ens_mn_prior_rural_mn,e_so2_ens_mn_post_rural_mn,e_so2_incr_rural_mn, &
      e_so2_ens_vr_prior_rural_mn,e_so2_ens_vr_post_rural_mn,e_so2_infl_prior_rural_mn,e_so2_infl_post_rural_mn, &
      traceri_rural_ii,traceri_rural_jj,1,nx*ny,num_rural,nx,ny,nz_chemi, &
      traceri_e_so2_arc_prior,e_so2_arc_prior_rural_mn)
!
      e_so2_ens_sd_prior_rural_mn(:)=sqrt(e_so2_ens_vr_prior_rural_mn(:))
      e_so2_ens_sd_post_rural_mn(:)=sqrt(e_so2_ens_vr_post_rural_mn(:))
!
      call put_NETCDF_fld(trim(file_write),"TRACER_I_E_SO2_ARC_PRIOR_RURAL_MN", &
      "degrees",e_so2_arc_prior_rural_mn,nz_chemi,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_E_SO2_EMN_PRIOR_RURAL_MN", &
      "degrees",e_so2_ens_mn_prior_rural_mn,nz_chemi,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_E_SO2_EMN_POST_RURAL_MN", &
      "degrees",e_so2_ens_mn_post_rural_mn,nz_chemi,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_E_SO2_INCR_RURAL_MN", &
      "degrees",e_so2_incr_rural_mn,nz_chemi,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_E_SO2_ESD_PRIOR_RURAL_MN", &
      "degrees",e_so2_ens_sd_prior_rural_mn,nz_chemi,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_E_SO2_ESD_POST_RURAL_MN", &
      "degrees",e_so2_ens_sd_post_rural_mn,nz_chemi,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_E_SO2_INFL_PRIOR_RURAL_MN", &
      "degrees",e_so2_infl_prior_rural_mn,nz_chemi,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_E_SO2_INFL_POST_RURAL_MN", &
      "degrees",e_so2_infl_post_rural_mn,nz_chemi,1,1)
!      print *,'E_SO2_ENS_PRIOR_MN ',e_so2_ens_mn_prior_rural_mn(:)
!      print *,'E_SO2_INCR ',e_so2_incr_rural_mn(:)
!      print *,'E_SO2_ENS_PRIOR_SD ',e_so2_ens_sd_prior_rural_mn(:)
!      print *,'E_SO2_INFL_PRIOR_MN ',e_so2_infl_prior_rural_mn(:)
!
      deallocate(e_so2_arc_prior_rural_mn)
      deallocate(e_so2_ens_mn_prior_rural_mn)
      deallocate(e_so2_ens_mn_post_rural_mn)
      deallocate(e_so2_incr_rural_mn)
      deallocate(e_so2_ens_vr_prior_rural_mn)
      deallocate(e_so2_ens_vr_post_rural_mn)
      deallocate(e_so2_ens_sd_prior_rural_mn)
      deallocate(e_so2_ens_sd_post_rural_mn)
      deallocate(e_so2_infl_prior_rural_mn)
      deallocate(e_so2_infl_post_rural_mn)
!
      deallocate(traceri_e_so2_arc_prior)
      deallocate(traceri_e_so2_prior_ens_mn)
      deallocate(traceri_e_so2_post_ens_mn)
      deallocate(traceri_e_so2_incr)
      deallocate(traceri_e_so2_prior_ens_sd)
      deallocate(traceri_e_so2_post_ens_sd)
      deallocate(traceri_e_so2_prior_ens_vr)
      deallocate(traceri_e_so2_post_ens_vr)
      deallocate(traceri_e_so2_infl_prior)
      deallocate(traceri_e_so2_infl_post)
!
! Read and process EBU_IN_CO
!
      allocate(traceri_ebu_in_co_arc_prior(nx,ny,nz_fire))
      allocate(traceri_ebu_in_co_prior_ens_mn(nx,ny,nz_fire))
      allocate(traceri_ebu_in_co_post_ens_mn(nx,ny,nz_fire))
      allocate(traceri_ebu_in_co_incr(nx,ny,nz_fire))
      allocate(traceri_ebu_in_co_prior_ens_sd(nx,ny,nz_fire))
      allocate(traceri_ebu_in_co_post_ens_sd(nx,ny,nz_fire))
      allocate(traceri_ebu_in_co_prior_ens_vr(nx,ny,nz_fire))
      allocate(traceri_ebu_in_co_post_ens_vr(nx,ny,nz_fire))
      allocate(traceri_ebu_in_co_infl_prior(nx,ny,nz_fire))
      allocate(traceri_ebu_in_co_infl_post(nx,ny,nz_fire))
!
      call get_WRFCHEM_fld_real(trim(file_read_arc_prior_fire),"ebu_in_co",traceri_ebu_in_co_arc_prior,nx,ny,nz_fire,1)
      call get_WRFCHEM_fld_real(trim(file_read_prior_mn),"ebu_in_co",traceri_ebu_in_co_prior_ens_mn,nx,ny,nz_fire,1)
      call get_WRFCHEM_fld_real(trim(file_read_post_mn),"ebu_in_co",traceri_ebu_in_co_post_ens_mn,nx,ny,nz_fire,1)
      call get_WRFCHEM_fld_real(trim(file_read_prior_sd),"ebu_in_co",traceri_ebu_in_co_prior_ens_sd,nx,ny,nz_fire,1)
      call get_WRFCHEM_fld_real(trim(file_read_post_sd),"ebu_in_co",traceri_ebu_in_co_post_ens_sd,nx,ny,nz_fire,1)
      call get_WRFCHEM_fld_real(trim(file_read_infl_prior),"ebu_in_co",traceri_ebu_in_co_infl_prior,nx,ny,nz_fire,1)
      call get_WRFCHEM_fld_real(trim(file_read_infl_post),"ebu_in_co",traceri_ebu_in_co_infl_post,nx,ny,nz_fire,1)
!
      traceri_ebu_in_co_incr(:,:,:)=traceri_ebu_in_co_post_ens_mn(:,:,:)-traceri_ebu_in_co_prior_ens_mn(:,:,:)
      traceri_ebu_in_co_prior_ens_vr(:,:,:)=traceri_ebu_in_co_prior_ens_sd(:,:,:)**2.
      traceri_ebu_in_co_post_ens_vr(:,:,:)=traceri_ebu_in_co_post_ens_sd(:,:,:)**2.
!
! TRACER-I CONUS Spatial statistics EBU_IN_CO
      allocate(ebu_in_co_arc_prior_conus_mn(nz_fire))
      allocate(ebu_in_co_ens_mn_prior_conus_mn(nz_fire))
      allocate(ebu_in_co_ens_mn_post_conus_mn(nz_fire))
      allocate(ebu_in_co_incr_conus_mn(nz_fire))
      allocate(ebu_in_co_ens_vr_prior_conus_mn(nz_fire))
      allocate(ebu_in_co_ens_vr_post_conus_mn(nz_fire))
      allocate(ebu_in_co_ens_sd_prior_conus_mn(nz_fire))
      allocate(ebu_in_co_ens_sd_post_conus_mn(nz_fire))
      allocate(ebu_in_co_infl_prior_conus_mn(nz_fire))
      allocate(ebu_in_co_infl_post_conus_mn(nz_fire))
!
      call spatial_mean_and_variance_emiss(traceri_ebu_in_co_prior_ens_mn,traceri_ebu_in_co_post_ens_mn, &
      traceri_ebu_in_co_incr,traceri_ebu_in_co_prior_ens_vr,traceri_ebu_in_co_post_ens_vr,traceri_ebu_in_co_infl_prior, &
      traceri_ebu_in_co_infl_post,ebu_in_co_ens_mn_prior_conus_mn,ebu_in_co_ens_mn_post_conus_mn,ebu_in_co_incr_conus_mn, &
      ebu_in_co_ens_vr_prior_conus_mn,ebu_in_co_ens_vr_post_conus_mn,ebu_in_co_infl_prior_conus_mn,ebu_in_co_infl_post_conus_mn, &
      traceri_conus_ii,traceri_conus_jj,1,nx*ny,num_conus,nx,ny,nz_fire, &
      traceri_ebu_in_co_arc_prior,ebu_in_co_arc_prior_conus_mn)
!
      ebu_in_co_ens_sd_prior_conus_mn(:)=sqrt(ebu_in_co_ens_vr_prior_conus_mn(:))
      ebu_in_co_ens_sd_post_conus_mn(:)=sqrt(ebu_in_co_ens_vr_post_conus_mn(:))
!
      call put_NETCDF_fld(trim(file_write),"TRACER_I_EBU_IN_CO_ARC_PRIOR_CONUS_MN", &
      "degrees",ebu_in_co_arc_prior_conus_mn,nz_fire,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_EBU_IN_CO_EMN_PRIOR_CONUS_MN", &
      "degrees",ebu_in_co_ens_mn_prior_conus_mn,nz_fire,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_EBU_IN_CO_EMN_POST_CONUS_MN", &
      "degrees",ebu_in_co_ens_mn_post_conus_mn,nz_fire,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_EBU_IN_CO_INCR_CONUS_MN", &
      "degrees",ebu_in_co_incr_conus_mn,nz_fire,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_EBU_IN_CO_ESD_PRIOR_CONUS_MN", &
      "degrees",ebu_in_co_ens_sd_prior_conus_mn,nz_fire,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_EBU_IN_CO_ESD_POST_CONUS_MN", &
      "degrees",ebu_in_co_ens_sd_post_conus_mn,nz_fire,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_EBU_IN_CO_INFL_PRIOR_CONUS_MN", &
      "no units",ebu_in_co_infl_prior_conus_mn,nz_fire,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_EBU_IN_CO_INFL_POST_CONUS_MN", &
      "no units",ebu_in_co_infl_post_conus_mn,nz_fire,1,1)
!      print *,'EBU_IN_CO_ENS_PRIOR_MN ',ebu_in_co_ens_mn_prior_conus_mn(:)
!      print *,'EBU_IN_CO_INCR ',ebu_in_co_incr_conus_mn(:)
!      print *,'EBU_IN_CO_ENS_PRIOR_SD ',ebu_in_co_ens_sd_prior_conus_mn(:)
!      print *,'EBU_IN_CO_INFL_PRIOR_MN ',ebu_in_co_infl_prior_conus_mn(:)
!
      deallocate(ebu_in_co_arc_prior_conus_mn)
      deallocate(ebu_in_co_ens_mn_prior_conus_mn)
      deallocate(ebu_in_co_ens_mn_post_conus_mn)
      deallocate(ebu_in_co_incr_conus_mn)
      deallocate(ebu_in_co_ens_vr_prior_conus_mn)
      deallocate(ebu_in_co_ens_vr_post_conus_mn)
      deallocate(ebu_in_co_ens_sd_prior_conus_mn)
      deallocate(ebu_in_co_ens_sd_post_conus_mn)
      deallocate(ebu_in_co_infl_prior_conus_mn)
      deallocate(ebu_in_co_infl_post_conus_mn)
!
!  TRACER-I URBAN Spatial statistics EBU_IN_CO
      allocate(ebu_in_co_arc_prior_urban_mn(nz_fire))
      allocate(ebu_in_co_ens_mn_prior_urban_mn(nz_fire))
      allocate(ebu_in_co_ens_mn_post_urban_mn(nz_fire))
      allocate(ebu_in_co_incr_urban_mn(nz_fire))
      allocate(ebu_in_co_ens_vr_prior_urban_mn(nz_fire))
      allocate(ebu_in_co_ens_vr_post_urban_mn(nz_fire))
      allocate(ebu_in_co_ens_sd_prior_urban_mn(nz_fire))
      allocate(ebu_in_co_ens_sd_post_urban_mn(nz_fire))
      allocate(ebu_in_co_infl_prior_urban_mn(nz_fire))
      allocate(ebu_in_co_infl_post_urban_mn(nz_fire))
!
      call spatial_mean_and_variance_emiss(traceri_ebu_in_co_prior_ens_mn,traceri_ebu_in_co_post_ens_mn, &
      traceri_ebu_in_co_incr,traceri_ebu_in_co_prior_ens_vr,traceri_ebu_in_co_post_ens_vr,traceri_ebu_in_co_infl_prior, &
      traceri_ebu_in_co_infl_post,ebu_in_co_ens_mn_prior_urban_mn,ebu_in_co_ens_mn_post_urban_mn,ebu_in_co_incr_urban_mn, &
      ebu_in_co_ens_vr_prior_urban_mn,ebu_in_co_ens_vr_post_urban_mn,ebu_in_co_infl_prior_urban_mn,ebu_in_co_infl_post_urban_mn, &
      traceri_urban_ii,traceri_urban_jj,num_cities,npts_urban,num_urban,nx,ny,nz_fire, &
      traceri_ebu_in_co_arc_prior,ebu_in_co_arc_prior_urban_mn)
!
      ebu_in_co_ens_sd_prior_urban_mn(:)=sqrt(ebu_in_co_ens_vr_prior_urban_mn(:))
      ebu_in_co_ens_sd_post_urban_mn(:)=sqrt(ebu_in_co_ens_vr_post_urban_mn(:))
!
      call put_NETCDF_fld(trim(file_write),"TRACER_I_EBU_IN_CO_ARC_PRIOR_URBAN_MN", &
      "degrees",ebu_in_co_arc_prior_urban_mn,nz_fire,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_EBU_IN_CO_EMN_PRIOR_URBAN_MN", &
      "degrees",ebu_in_co_ens_mn_prior_urban_mn,nz_fire,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_EBU_IN_CO_EMN_POST_URBAN_MN", &
      "degrees",ebu_in_co_ens_mn_post_urban_mn,nz_fire,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_EBU_IN_CO_INCR_URBAN_MN", &
      "degrees",ebu_in_co_incr_urban_mn,nz_fire,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_EBU_IN_CO_ESD_PRIOR_URBAN_MN", &
      "degrees",ebu_in_co_ens_sd_prior_urban_mn,nz_fire,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_EBU_IN_CO_ESD_POST_URBAN_MN", &
      "degrees",ebu_in_co_ens_sd_post_urban_mn,nz_fire,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_EBU_IN_CO_INFL_PRIOR_URBAN_MN", &
      "degrees",ebu_in_co_infl_prior_urban_mn,nz_fire,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_EBU_IN_CO_INFL_POST_URBAN_MN", &
      "degrees",ebu_in_co_infl_post_urban_mn,nz_fire,1,1)
!      print *,'EBU_IN_CO_ENS_PRIOR_MN ',ebu_in_co_ens_mn_prior_urban_mn(:)
!      print *,'EBU_IN_CO_INCR ',ebu_in_co_incr_urban_mn(:)
!      print *,'EBU_IN_CO_ENS_PRIOR_SD ',ebu_in_co_ens_sd_prior_urban_mn(:)
!      print *,'EBU_IN_CO_INFL_PRIOR_MN ',ebu_in_co_infl_prior_urban_mn(:)
!
      deallocate(ebu_in_co_arc_prior_urban_mn)
      deallocate(ebu_in_co_ens_mn_prior_urban_mn)
      deallocate(ebu_in_co_ens_mn_post_urban_mn)
      deallocate(ebu_in_co_incr_urban_mn)
      deallocate(ebu_in_co_ens_vr_prior_urban_mn)
      deallocate(ebu_in_co_ens_vr_post_urban_mn)
      deallocate(ebu_in_co_ens_sd_prior_urban_mn)
      deallocate(ebu_in_co_ens_sd_post_urban_mn)
      deallocate(ebu_in_co_infl_prior_urban_mn)
      deallocate(ebu_in_co_infl_post_urban_mn)
!
!  TRACER-I RURAL Spatial statistics EBU_IN_CO
      allocate(ebu_in_co_arc_prior_rural_mn(nz_fire))
      allocate(ebu_in_co_ens_mn_prior_rural_mn(nz_fire))
      allocate(ebu_in_co_ens_mn_post_rural_mn(nz_fire))
      allocate(ebu_in_co_incr_rural_mn(nz_fire))
      allocate(ebu_in_co_ens_vr_prior_rural_mn(nz_fire))
      allocate(ebu_in_co_ens_vr_post_rural_mn(nz_fire))
      allocate(ebu_in_co_ens_sd_prior_rural_mn(nz_fire))
      allocate(ebu_in_co_ens_sd_post_rural_mn(nz_fire))
      allocate(ebu_in_co_infl_prior_rural_mn(nz_fire))
      allocate(ebu_in_co_infl_post_rural_mn(nz_fire))
!
      call spatial_mean_and_variance_emiss(traceri_ebu_in_co_prior_ens_mn,traceri_ebu_in_co_post_ens_mn, &
      traceri_ebu_in_co_incr,traceri_ebu_in_co_prior_ens_vr,traceri_ebu_in_co_post_ens_vr,traceri_ebu_in_co_infl_prior, &
      traceri_ebu_in_co_infl_post,ebu_in_co_ens_mn_prior_rural_mn,ebu_in_co_ens_mn_post_rural_mn,ebu_in_co_incr_rural_mn, &
      ebu_in_co_ens_vr_prior_rural_mn,ebu_in_co_ens_vr_post_rural_mn,ebu_in_co_infl_prior_rural_mn,ebu_in_co_infl_post_rural_mn, &
      traceri_rural_ii,traceri_rural_jj,1,nx*ny,num_rural,nx,ny,nz_fire, &
      traceri_ebu_in_co_arc_prior,ebu_in_co_arc_prior_rural_mn)
!
      ebu_in_co_ens_sd_prior_rural_mn(:)=sqrt(ebu_in_co_ens_vr_prior_rural_mn(:))
      ebu_in_co_ens_sd_post_rural_mn(:)=sqrt(ebu_in_co_ens_vr_post_rural_mn(:))
!
      call put_NETCDF_fld(trim(file_write),"TRACER_I_EBU_IN_CO_ARC_PRIOR_RURAL_MN", &
      "degrees",ebu_in_co_arc_prior_rural_mn,nz_fire,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_EBU_IN_CO_EMN_PRIOR_RURAL_MN", &
      "degrees",ebu_in_co_ens_mn_prior_rural_mn,nz_fire,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_EBU_IN_CO_EMN_POST_RURAL_MN", &
      "degrees",ebu_in_co_ens_mn_post_rural_mn,nz_fire,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_EBU_IN_CO_INCR_RURAL_MN", &
      "degrees",ebu_in_co_incr_rural_mn,nz_fire,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_EBU_IN_CO_ESD_PRIOR_RURAL_MN", &
      "degrees",ebu_in_co_ens_sd_prior_rural_mn,nz_fire,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_EBU_IN_CO_ESD_POST_RURAL_MN", &
      "degrees",ebu_in_co_ens_sd_post_rural_mn,nz_fire,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_EBU_IN_CO_INFL_PRIOR_RURAL_MN", &
      "degrees",ebu_in_co_infl_prior_rural_mn,nz_fire,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_EBU_IN_CO_INFL_POST_RURAL_MN", &
      "degrees",ebu_in_co_infl_post_rural_mn,nz_fire,1,1)
!      print *,'EBU_IN_CO_ENS_PRIOR_MN ',ebu_in_co_ens_mn_prior_rural_mn(:)
!      print *,'EBU_IN_CO_INCR ',ebu_in_co_incr_rural_mn(:)
!      print *,'EBU_IN_CO_ENS_PRIOR_SD ',ebu_in_co_ens_sd_prior_rural_mn(:)
!      print *,'EBU_IN_CO_INFL_PRIOR_MN ',ebu_in_co_infl_prior_rural_mn(:)
!
      deallocate(ebu_in_co_arc_prior_rural_mn)
      deallocate(ebu_in_co_ens_mn_prior_rural_mn)
      deallocate(ebu_in_co_ens_mn_post_rural_mn)
      deallocate(ebu_in_co_incr_rural_mn)
      deallocate(ebu_in_co_ens_vr_prior_rural_mn)
      deallocate(ebu_in_co_ens_vr_post_rural_mn)
      deallocate(ebu_in_co_ens_sd_prior_rural_mn)
      deallocate(ebu_in_co_ens_sd_post_rural_mn)
      deallocate(ebu_in_co_infl_prior_rural_mn)
      deallocate(ebu_in_co_infl_post_rural_mn)
!
      deallocate(traceri_ebu_in_co_arc_prior)
      deallocate(traceri_ebu_in_co_prior_ens_mn)
      deallocate(traceri_ebu_in_co_post_ens_mn)
      deallocate(traceri_ebu_in_co_incr)
      deallocate(traceri_ebu_in_co_prior_ens_sd)
      deallocate(traceri_ebu_in_co_post_ens_sd)
      deallocate(traceri_ebu_in_co_prior_ens_vr)
      deallocate(traceri_ebu_in_co_post_ens_vr)
      deallocate(traceri_ebu_in_co_infl_prior)
      deallocate(traceri_ebu_in_co_infl_post)
!
! Read and process EBU_IN_NO2
!
      allocate(traceri_ebu_in_no2_arc_prior(nx,ny,nz_fire))
      allocate(traceri_ebu_in_no2_prior_ens_mn(nx,ny,nz_fire))
      allocate(traceri_ebu_in_no2_post_ens_mn(nx,ny,nz_fire))
      allocate(traceri_ebu_in_no2_incr(nx,ny,nz_fire))
      allocate(traceri_ebu_in_no2_prior_ens_sd(nx,ny,nz_fire))
      allocate(traceri_ebu_in_no2_post_ens_sd(nx,ny,nz_fire))
      allocate(traceri_ebu_in_no2_prior_ens_vr(nx,ny,nz_fire))
      allocate(traceri_ebu_in_no2_post_ens_vr(nx,ny,nz_fire))
      allocate(traceri_ebu_in_no2_infl_prior(nx,ny,nz_fire))
      allocate(traceri_ebu_in_no2_infl_post(nx,ny,nz_fire))
!
      call get_WRFCHEM_fld_real(trim(file_read_arc_prior_fire),"ebu_in_no2",traceri_ebu_in_no2_arc_prior,nx,ny,nz_fire,1)
      call get_WRFCHEM_fld_real(trim(file_read_prior_mn),"ebu_in_no2",traceri_ebu_in_no2_prior_ens_mn,nx,ny,nz_fire,1)
      call get_WRFCHEM_fld_real(trim(file_read_post_mn),"ebu_in_no2",traceri_ebu_in_no2_post_ens_mn,nx,ny,nz_fire,1)
      call get_WRFCHEM_fld_real(trim(file_read_prior_sd),"ebu_in_no2",traceri_ebu_in_no2_prior_ens_sd,nx,ny,nz_fire,1)
      call get_WRFCHEM_fld_real(trim(file_read_post_sd),"ebu_in_no2",traceri_ebu_in_no2_post_ens_sd,nx,ny,nz_fire,1)
      call get_WRFCHEM_fld_real(trim(file_read_infl_prior),"ebu_in_no2",traceri_ebu_in_no2_infl_prior,nx,ny,nz_fire,1)
      call get_WRFCHEM_fld_real(trim(file_read_infl_post),"ebu_in_no2",traceri_ebu_in_no2_infl_post,nx,ny,nz_fire,1)
!
      traceri_ebu_in_no2_incr(:,:,:)=traceri_ebu_in_no2_post_ens_mn(:,:,:)-traceri_ebu_in_no2_prior_ens_mn(:,:,:)
      traceri_ebu_in_no2_prior_ens_vr(:,:,:)=traceri_ebu_in_no2_prior_ens_sd(:,:,:)**2.
      traceri_ebu_in_no2_post_ens_vr(:,:,:)=traceri_ebu_in_no2_post_ens_sd(:,:,:)**2.
!
! TRACER-I CONUS Spatial statistics EBU_IN_NO2
      allocate(ebu_in_no2_arc_prior_conus_mn(nz_fire))
      allocate(ebu_in_no2_ens_mn_prior_conus_mn(nz_fire))
      allocate(ebu_in_no2_ens_mn_post_conus_mn(nz_fire))
      allocate(ebu_in_no2_incr_conus_mn(nz_fire))
      allocate(ebu_in_no2_ens_vr_prior_conus_mn(nz_fire))
      allocate(ebu_in_no2_ens_vr_post_conus_mn(nz_fire))
      allocate(ebu_in_no2_ens_sd_prior_conus_mn(nz_fire))
      allocate(ebu_in_no2_ens_sd_post_conus_mn(nz_fire))
      allocate(ebu_in_no2_infl_prior_conus_mn(nz_fire))
      allocate(ebu_in_no2_infl_post_conus_mn(nz_fire))
!
      call spatial_mean_and_variance_emiss(traceri_ebu_in_no2_prior_ens_mn,traceri_ebu_in_no2_post_ens_mn, &
      traceri_ebu_in_no2_incr,traceri_ebu_in_no2_prior_ens_vr,traceri_ebu_in_no2_post_ens_vr,traceri_ebu_in_no2_infl_prior, &
      traceri_ebu_in_no2_infl_post,ebu_in_no2_ens_mn_prior_conus_mn,ebu_in_no2_ens_mn_post_conus_mn,ebu_in_no2_incr_conus_mn, &
      ebu_in_no2_ens_vr_prior_conus_mn,ebu_in_no2_ens_vr_post_conus_mn,ebu_in_no2_infl_prior_conus_mn,ebu_in_no2_infl_post_conus_mn, &
      traceri_conus_ii,traceri_conus_jj,1,nx*ny,num_conus,nx,ny,nz_fire, &
      traceri_ebu_in_no2_arc_prior,ebu_in_no2_arc_prior_conus_mn)
!
      ebu_in_no2_ens_sd_prior_conus_mn(:)=sqrt(ebu_in_no2_ens_vr_prior_conus_mn(:))
      ebu_in_no2_ens_sd_post_conus_mn(:)=sqrt(ebu_in_no2_ens_vr_post_conus_mn(:))
!
      call put_NETCDF_fld(trim(file_write),"TRACER_I_EBU_IN_NO2_ARC_PRIOR_CONUS_MN", &
      "degrees",ebu_in_no2_arc_prior_conus_mn,nz_fire,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_EBU_IN_NO2_EMN_PRIOR_CONUS_MN", &
      "degrees",ebu_in_no2_ens_mn_prior_conus_mn,nz_fire,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_EBU_IN_NO2_EMN_POST_CONUS_MN", &
      "degrees",ebu_in_no2_ens_mn_post_conus_mn,nz_fire,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_EBU_IN_NO2_INCR_CONUS_MN", &
      "degrees",ebu_in_no2_incr_conus_mn,nz_fire,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_EBU_IN_NO2_ESD_PRIOR_CONUS_MN", &
      "degrees",ebu_in_no2_ens_sd_prior_conus_mn,nz_fire,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_EBU_IN_NO2_ESD_POST_CONUS_MN", &
      "degrees",ebu_in_no2_ens_sd_post_conus_mn,nz_fire,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_EBU_IN_NO2_INFL_PRIOR_CONUS_MN", &
      "no units",ebu_in_no2_infl_prior_conus_mn,nz_fire,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_EBU_IN_NO2_INFL_POST_CONUS_MN", &
      "no units",ebu_in_no2_infl_post_conus_mn,nz_fire,1,1)
!      print *,'EBU_IN_NO2_ENS_PRIOR_MN ',ebu_in_no2_ens_mn_prior_conus_mn(:)
!      print *,'EBU_IN_NO2_INCR ',ebu_in_no2_incr_conus_mn(:)
!      print *,'EBU_IN_NO2_ENS_PRIOR_SD ',ebu_in_no2_ens_sd_prior_conus_mn(:)
!      print *,'EBU_IN_NO2_INFL_PRIOR_MN ',ebu_in_no2_infl_prior_conus_mn(:)
!
      deallocate(ebu_in_no2_arc_prior_conus_mn)
      deallocate(ebu_in_no2_ens_mn_prior_conus_mn)
      deallocate(ebu_in_no2_ens_mn_post_conus_mn)
      deallocate(ebu_in_no2_incr_conus_mn)
      deallocate(ebu_in_no2_ens_vr_prior_conus_mn)
      deallocate(ebu_in_no2_ens_vr_post_conus_mn)
      deallocate(ebu_in_no2_ens_sd_prior_conus_mn)
      deallocate(ebu_in_no2_ens_sd_post_conus_mn)
      deallocate(ebu_in_no2_infl_prior_conus_mn)
      deallocate(ebu_in_no2_infl_post_conus_mn)
!
!  TRACER-I URBAN Spatial statistics EBU_IN_NO2
      allocate(ebu_in_no2_arc_prior_urban_mn(nz_fire))
      allocate(ebu_in_no2_ens_mn_prior_urban_mn(nz_fire))
      allocate(ebu_in_no2_ens_mn_post_urban_mn(nz_fire))
      allocate(ebu_in_no2_incr_urban_mn(nz_fire))
      allocate(ebu_in_no2_ens_vr_prior_urban_mn(nz_fire))
      allocate(ebu_in_no2_ens_vr_post_urban_mn(nz_fire))
      allocate(ebu_in_no2_ens_sd_prior_urban_mn(nz_fire))
      allocate(ebu_in_no2_ens_sd_post_urban_mn(nz_fire))
      allocate(ebu_in_no2_infl_prior_urban_mn(nz_fire))
      allocate(ebu_in_no2_infl_post_urban_mn(nz_fire))
!
      call spatial_mean_and_variance_emiss(traceri_ebu_in_no2_prior_ens_mn,traceri_ebu_in_no2_post_ens_mn, &
      traceri_ebu_in_no2_incr,traceri_ebu_in_no2_prior_ens_vr,traceri_ebu_in_no2_post_ens_vr,traceri_ebu_in_no2_infl_prior, &
      traceri_ebu_in_no2_infl_post,ebu_in_no2_ens_mn_prior_urban_mn,ebu_in_no2_ens_mn_post_urban_mn,ebu_in_no2_incr_urban_mn, &
      ebu_in_no2_ens_vr_prior_urban_mn,ebu_in_no2_ens_vr_post_urban_mn,ebu_in_no2_infl_prior_urban_mn,ebu_in_no2_infl_post_urban_mn, &
      traceri_urban_ii,traceri_urban_jj,num_cities,npts_urban,num_urban,nx,ny,nz_fire, &
      traceri_ebu_in_no2_arc_prior,ebu_in_no2_arc_prior_urban_mn)
!
      ebu_in_no2_ens_sd_prior_urban_mn(:)=sqrt(ebu_in_no2_ens_vr_prior_urban_mn(:))
      ebu_in_no2_ens_sd_post_urban_mn(:)=sqrt(ebu_in_no2_ens_vr_post_urban_mn(:))
!
      call put_NETCDF_fld(trim(file_write),"TRACER_I_EBU_IN_NO2_ARC_PRIOR_URBAN_MN", &
      "degrees",ebu_in_no2_arc_prior_urban_mn,nz_fire,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_EBU_IN_NO2_EMN_PRIOR_URBAN_MN", &
      "degrees",ebu_in_no2_ens_mn_prior_urban_mn,nz_fire,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_EBU_IN_NO2_EMN_POST_URBAN_MN", &
      "degrees",ebu_in_no2_ens_mn_post_urban_mn,nz_fire,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_EBU_IN_NO2_INCR_URBAN_MN", &
      "degrees",ebu_in_no2_incr_urban_mn,nz_fire,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_EBU_IN_NO2_ESD_PRIOR_URBAN_MN", &
      "degrees",ebu_in_no2_ens_sd_prior_urban_mn,nz_fire,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_EBU_IN_NO2_ESD_POST_URBAN_MN", &
      "degrees",ebu_in_no2_ens_sd_post_urban_mn,nz_fire,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_EBU_IN_NO2_INFL_PRIOR_URBAN_MN", &
      "degrees",ebu_in_no2_infl_prior_urban_mn,nz_fire,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_EBU_IN_NO2_INFL_POST_URBAN_MN", &
      "degrees",ebu_in_no2_infl_post_urban_mn,nz_fire,1,1)
!      print *,'EBU_IN_NO2_ENS_PRIOR_MN ',ebu_in_no2_ens_mn_prior_urban_mn(:)
!      print *,'EBU_IN_NO2_INCR ',ebu_in_no2_incr_urban_mn(:)
!      print *,'EBU_IN_NO2_ENS_PRIOR_SD ',ebu_in_no2_ens_sd_prior_urban_mn(:)
!      print *,'EBU_IN_NO2_INFL_PRIOR_MN ',ebu_in_no2_infl_prior_urban_mn(:)
!
      deallocate(ebu_in_no2_arc_prior_urban_mn)
      deallocate(ebu_in_no2_ens_mn_prior_urban_mn)
      deallocate(ebu_in_no2_ens_mn_post_urban_mn)
      deallocate(ebu_in_no2_incr_urban_mn)
      deallocate(ebu_in_no2_ens_vr_prior_urban_mn)
      deallocate(ebu_in_no2_ens_vr_post_urban_mn)
      deallocate(ebu_in_no2_ens_sd_prior_urban_mn)
      deallocate(ebu_in_no2_ens_sd_post_urban_mn)
      deallocate(ebu_in_no2_infl_prior_urban_mn)
      deallocate(ebu_in_no2_infl_post_urban_mn)
!
!  TRACER-I RURAL Spatial statistics EBU_IN_NO2
      allocate(ebu_in_no2_arc_prior_rural_mn(nz_fire))
      allocate(ebu_in_no2_ens_mn_prior_rural_mn(nz_fire))
      allocate(ebu_in_no2_ens_mn_post_rural_mn(nz_fire))
      allocate(ebu_in_no2_incr_rural_mn(nz_fire))
      allocate(ebu_in_no2_ens_vr_prior_rural_mn(nz_fire))
      allocate(ebu_in_no2_ens_vr_post_rural_mn(nz_fire))
      allocate(ebu_in_no2_ens_sd_prior_rural_mn(nz_fire))
      allocate(ebu_in_no2_ens_sd_post_rural_mn(nz_fire))
      allocate(ebu_in_no2_infl_prior_rural_mn(nz_fire))
      allocate(ebu_in_no2_infl_post_rural_mn(nz_fire))
!
      call spatial_mean_and_variance_emiss(traceri_ebu_in_no2_prior_ens_mn,traceri_ebu_in_no2_post_ens_mn, &
      traceri_ebu_in_no2_incr,traceri_ebu_in_no2_prior_ens_vr,traceri_ebu_in_no2_post_ens_vr,traceri_ebu_in_no2_infl_prior, &
      traceri_ebu_in_no2_infl_post,ebu_in_no2_ens_mn_prior_rural_mn,ebu_in_no2_ens_mn_post_rural_mn,ebu_in_no2_incr_rural_mn, &
      ebu_in_no2_ens_vr_prior_rural_mn,ebu_in_no2_ens_vr_post_rural_mn,ebu_in_no2_infl_prior_rural_mn,ebu_in_no2_infl_post_rural_mn, &
      traceri_rural_ii,traceri_rural_jj,1,nx*ny,num_rural,nx,ny,nz_fire, &
      traceri_ebu_in_no2_arc_prior,ebu_in_no2_arc_prior_rural_mn)
!
      ebu_in_no2_ens_sd_prior_rural_mn(:)=sqrt(ebu_in_no2_ens_vr_prior_rural_mn(:))
      ebu_in_no2_ens_sd_post_rural_mn(:)=sqrt(ebu_in_no2_ens_vr_post_rural_mn(:))
!
      call put_NETCDF_fld(trim(file_write),"TRACER_I_EBU_IN_NO2_ARC_PRIOR_RURAL_MN", &
      "degrees",ebu_in_no2_arc_prior_rural_mn,nz_fire,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_EBU_IN_NO2_EMN_PRIOR_RURAL_MN", &
      "degrees",ebu_in_no2_ens_mn_prior_rural_mn,nz_fire,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_EBU_IN_NO2_EMN_POST_RURAL_MN", &
      "degrees",ebu_in_no2_ens_mn_post_rural_mn,nz_fire,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_EBU_IN_NO2_INCR_RURAL_MN", &
      "degrees",ebu_in_no2_incr_rural_mn,nz_fire,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_EBU_IN_NO2_ESD_PRIOR_RURAL_MN", &
      "degrees",ebu_in_no2_ens_sd_prior_rural_mn,nz_fire,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_EBU_IN_NO2_ESD_POST_RURAL_MN", &
      "degrees",ebu_in_no2_ens_sd_post_rural_mn,nz_fire,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_EBU_IN_NO2_INFL_PRIOR_RURAL_MN", &
      "degrees",ebu_in_no2_infl_prior_rural_mn,nz_fire,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_EBU_IN_NO2_INFL_POST_RURAL_MN", &
      "degrees",ebu_in_no2_infl_post_rural_mn,nz_fire,1,1)
!      print *,'EBU_IN_NO2_ENS_PRIOR_MN ',ebu_in_no2_ens_mn_prior_rural_mn(:)
!      print *,'EBU_IN_NO2_INCR ',ebu_in_no2_incr_rural_mn(:)
!      print *,'EBU_IN_NO2_ENS_PRIOR_SD ',ebu_in_no2_ens_sd_prior_rural_mn(:)
!      print *,'EBU_IN_NO2_INFL_PRIOR_MN ',ebu_in_no2_infl_prior_rural_mn(:)
!
      deallocate(ebu_in_no2_arc_prior_rural_mn)
      deallocate(ebu_in_no2_ens_mn_prior_rural_mn)
      deallocate(ebu_in_no2_ens_mn_post_rural_mn)
      deallocate(ebu_in_no2_incr_rural_mn)
      deallocate(ebu_in_no2_ens_vr_prior_rural_mn)
      deallocate(ebu_in_no2_ens_vr_post_rural_mn)
      deallocate(ebu_in_no2_ens_sd_prior_rural_mn)
      deallocate(ebu_in_no2_ens_sd_post_rural_mn)
      deallocate(ebu_in_no2_infl_prior_rural_mn)
      deallocate(ebu_in_no2_infl_post_rural_mn)
!
      deallocate(traceri_ebu_in_no2_arc_prior)
      deallocate(traceri_ebu_in_no2_prior_ens_mn)
      deallocate(traceri_ebu_in_no2_post_ens_mn)
      deallocate(traceri_ebu_in_no2_incr)
      deallocate(traceri_ebu_in_no2_prior_ens_sd)
      deallocate(traceri_ebu_in_no2_post_ens_sd)
      deallocate(traceri_ebu_in_no2_prior_ens_vr)
      deallocate(traceri_ebu_in_no2_post_ens_vr)
      deallocate(traceri_ebu_in_no2_infl_prior)
      deallocate(traceri_ebu_in_no2_infl_post)
!
! Read and process EBU_IN_SO2
!
      allocate(traceri_ebu_in_so2_arc_prior(nx,ny,nz_fire))
      allocate(traceri_ebu_in_so2_prior_ens_mn(nx,ny,nz_fire))
      allocate(traceri_ebu_in_so2_post_ens_mn(nx,ny,nz_fire))
      allocate(traceri_ebu_in_so2_incr(nx,ny,nz_fire))
      allocate(traceri_ebu_in_so2_prior_ens_sd(nx,ny,nz_fire))
      allocate(traceri_ebu_in_so2_post_ens_sd(nx,ny,nz_fire))
      allocate(traceri_ebu_in_so2_prior_ens_vr(nx,ny,nz_fire))
      allocate(traceri_ebu_in_so2_post_ens_vr(nx,ny,nz_fire))
      allocate(traceri_ebu_in_so2_infl_prior(nx,ny,nz_fire))
      allocate(traceri_ebu_in_so2_infl_post(nx,ny,nz_fire))
!
      call get_WRFCHEM_fld_real(trim(file_read_arc_prior_fire),"ebu_in_so2",traceri_ebu_in_so2_arc_prior,nx,ny,nz_fire,1)
      call get_WRFCHEM_fld_real(trim(file_read_prior_mn),"ebu_in_so2",traceri_ebu_in_so2_prior_ens_mn,nx,ny,nz_fire,1)
      call get_WRFCHEM_fld_real(trim(file_read_post_mn),"ebu_in_so2",traceri_ebu_in_so2_post_ens_mn,nx,ny,nz_fire,1)
      call get_WRFCHEM_fld_real(trim(file_read_prior_sd),"ebu_in_so2",traceri_ebu_in_so2_prior_ens_sd,nx,ny,nz_fire,1)
      call get_WRFCHEM_fld_real(trim(file_read_post_sd),"ebu_in_so2",traceri_ebu_in_so2_post_ens_sd,nx,ny,nz_fire,1)
      call get_WRFCHEM_fld_real(trim(file_read_infl_prior),"ebu_in_so2",traceri_ebu_in_so2_infl_prior,nx,ny,nz_fire,1)
      call get_WRFCHEM_fld_real(trim(file_read_infl_post),"ebu_in_so2",traceri_ebu_in_so2_infl_post,nx,ny,nz_fire,1)
!
      traceri_ebu_in_so2_incr(:,:,:)=traceri_ebu_in_so2_post_ens_mn(:,:,:)-traceri_ebu_in_so2_prior_ens_mn(:,:,:)
      traceri_ebu_in_so2_prior_ens_vr(:,:,:)=traceri_ebu_in_so2_prior_ens_sd(:,:,:)**2.
      traceri_ebu_in_so2_post_ens_vr(:,:,:)=traceri_ebu_in_so2_post_ens_sd(:,:,:)**2.
!
! TRACER-I CONUS Spatial statistics EBU_IN_SO2
      allocate(ebu_in_so2_ARC_prior_conus_mn(nz_fire))
      allocate(ebu_in_so2_ens_mn_prior_conus_mn(nz_fire))
      allocate(ebu_in_so2_ens_mn_post_conus_mn(nz_fire))
      allocate(ebu_in_so2_incr_conus_mn(nz_fire))
      allocate(ebu_in_so2_ens_vr_prior_conus_mn(nz_fire))
      allocate(ebu_in_so2_ens_vr_post_conus_mn(nz_fire))
      allocate(ebu_in_so2_ens_sd_prior_conus_mn(nz_fire))
      allocate(ebu_in_so2_ens_sd_post_conus_mn(nz_fire))
      allocate(ebu_in_so2_infl_prior_conus_mn(nz_fire))
      allocate(ebu_in_so2_infl_post_conus_mn(nz_fire))
!
      call spatial_mean_and_variance_emiss(traceri_ebu_in_so2_prior_ens_mn,traceri_ebu_in_so2_post_ens_mn, &
      traceri_ebu_in_so2_incr,traceri_ebu_in_so2_prior_ens_vr,traceri_ebu_in_so2_post_ens_vr,traceri_ebu_in_so2_infl_prior, &
      traceri_ebu_in_so2_infl_post,ebu_in_so2_ens_mn_prior_conus_mn,ebu_in_so2_ens_mn_post_conus_mn,ebu_in_so2_incr_conus_mn, &
      ebu_in_so2_ens_vr_prior_conus_mn,ebu_in_so2_ens_vr_post_conus_mn,ebu_in_so2_infl_prior_conus_mn,ebu_in_so2_infl_post_conus_mn, &
      traceri_conus_ii,traceri_conus_jj,1,nx*ny,num_conus,nx,ny,nz_fire, &
      traceri_ebu_in_so2_arc_prior,ebu_in_so2_arc_prior_conus_mn)
!
      ebu_in_so2_ens_sd_prior_conus_mn(:)=sqrt(ebu_in_so2_ens_vr_prior_conus_mn(:))
      ebu_in_so2_ens_sd_post_conus_mn(:)=sqrt(ebu_in_so2_ens_vr_post_conus_mn(:))
!
      call put_NETCDF_fld(trim(file_write),"TRACER_I_EBU_IN_SO2_ARC_PRIOR_CONUS_MN", &
      "degrees",ebu_in_so2_arc_prior_conus_mn,nz_fire,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_EBU_IN_SO2_EMN_PRIOR_CONUS_MN", &
      "degrees",ebu_in_so2_ens_mn_prior_conus_mn,nz_fire,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_EBU_IN_SO2_EMN_POST_CONUS_MN", &
      "degrees",ebu_in_so2_ens_mn_post_conus_mn,nz_fire,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_EBU_IN_SO2_INCR_CONUS_MN", &
      "degrees",ebu_in_so2_incr_conus_mn,nz_fire,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_EBU_IN_SO2_ESD_PRIOR_CONUS_MN", &
      "degrees",ebu_in_so2_ens_sd_prior_conus_mn,nz_fire,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_EBU_IN_SO2_ESD_POST_CONUS_MN", &
      "degrees",ebu_in_so2_ens_sd_post_conus_mn,nz_fire,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_EBU_IN_SO2_INFL_PRIOR_CONUS_MN", &
      "no units",ebu_in_so2_infl_prior_conus_mn,nz_fire,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_EBU_IN_SO2_INFL_POST_CONUS_MN", &
      "no units",ebu_in_so2_infl_post_conus_mn,nz_fire,1,1)
!      print *,'EBU_IN_SO2_ENS_PRIOR_MN ',ebu_in_so2_ens_mn_prior_conus_mn(:)
!      print *,'EBU_IN_SO2_INCR ',ebu_in_so2_incr_conus_mn(:)
!      print *,'EBU_IN_SO2_ENS_PRIOR_SD ',ebu_in_so2_ens_sd_prior_conus_mn(:)
!      print *,'EBU_IN_SO2_INFL_PRIOR_MN ',ebu_in_so2_infl_prior_conus_mn(:)
!
      deallocate(ebu_in_so2_arc_prior_conus_mn)
      deallocate(ebu_in_so2_ens_mn_prior_conus_mn)
      deallocate(ebu_in_so2_ens_mn_post_conus_mn)
      deallocate(ebu_in_so2_incr_conus_mn)
      deallocate(ebu_in_so2_ens_vr_prior_conus_mn)
      deallocate(ebu_in_so2_ens_vr_post_conus_mn)
      deallocate(ebu_in_so2_ens_sd_prior_conus_mn)
      deallocate(ebu_in_so2_ens_sd_post_conus_mn)
      deallocate(ebu_in_so2_infl_prior_conus_mn)
      deallocate(ebu_in_so2_infl_post_conus_mn)
!
!  TRACER-I URBAN Spatial statistics EBU_IN_SO2
      allocate(ebu_in_so2_arc_prior_urban_mn(nz_fire))
      allocate(ebu_in_so2_ens_mn_prior_urban_mn(nz_fire))
      allocate(ebu_in_so2_ens_mn_post_urban_mn(nz_fire))
      allocate(ebu_in_so2_incr_urban_mn(nz_fire))
      allocate(ebu_in_so2_ens_vr_prior_urban_mn(nz_fire))
      allocate(ebu_in_so2_ens_vr_post_urban_mn(nz_fire))
      allocate(ebu_in_so2_ens_sd_prior_urban_mn(nz_fire))
      allocate(ebu_in_so2_ens_sd_post_urban_mn(nz_fire))
      allocate(ebu_in_so2_infl_prior_urban_mn(nz_fire))
      allocate(ebu_in_so2_infl_post_urban_mn(nz_fire))
!
      call spatial_mean_and_variance_emiss(traceri_ebu_in_so2_prior_ens_mn,traceri_ebu_in_so2_post_ens_mn, &
      traceri_ebu_in_so2_incr,traceri_ebu_in_so2_prior_ens_vr,traceri_ebu_in_so2_post_ens_vr,traceri_ebu_in_so2_infl_prior, &
      traceri_ebu_in_so2_infl_post,ebu_in_so2_ens_mn_prior_urban_mn,ebu_in_so2_ens_mn_post_urban_mn,ebu_in_so2_incr_urban_mn, &
      ebu_in_so2_ens_vr_prior_urban_mn,ebu_in_so2_ens_vr_post_urban_mn,ebu_in_so2_infl_prior_urban_mn,ebu_in_so2_infl_post_urban_mn, &
      traceri_urban_ii,traceri_urban_jj,num_cities,npts_urban,num_urban,nx,ny,nz_fire, &
      traceri_ebu_in_so2_arc_prior,ebu_in_so2_arc_prior_urban_mn)
!
      ebu_in_so2_ens_sd_prior_urban_mn(:)=sqrt(ebu_in_so2_ens_vr_prior_urban_mn(:))
      ebu_in_so2_ens_sd_post_urban_mn(:)=sqrt(ebu_in_so2_ens_vr_post_urban_mn(:))
!
      call put_NETCDF_fld(trim(file_write),"TRACER_I_EBU_IN_SO2_ARC_PRIOR_URBAN_MN", &
      "degrees",ebu_in_so2_arc_prior_urban_mn,nz_fire,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_EBU_IN_SO2_EMN_PRIOR_URBAN_MN", &
      "degrees",ebu_in_so2_ens_mn_prior_urban_mn,nz_fire,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_EBU_IN_SO2_EMN_POST_URBAN_MN", &
      "degrees",ebu_in_so2_ens_mn_post_urban_mn,nz_fire,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_EBU_IN_SO2_INCR_URBAN_MN", &
      "degrees",ebu_in_so2_incr_urban_mn,nz_fire,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_EBU_IN_SO2_ESD_PRIOR_URBAN_MN", &
      "degrees",ebu_in_so2_ens_sd_prior_urban_mn,nz_fire,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_EBU_IN_SO2_ESD_POST_URBAN_MN", &
      "degrees",ebu_in_so2_ens_sd_post_urban_mn,nz_fire,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_EBU_IN_SO2_INFL_PRIOR_URBAN_MN", &
      "degrees",ebu_in_so2_infl_prior_urban_mn,nz_fire,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_EBU_IN_SO2_INFL_POST_URBAN_MN", &
      "degrees",ebu_in_so2_infl_post_urban_mn,nz_fire,1,1)
!      print *,'EBU_IN_SO2_ENS_PRIOR_MN ',ebu_in_so2_ens_mn_prior_urban_mn(:)
!      print *,'EBU_IN_SO2_INCR ',ebu_in_so2_incr_urban_mn(:)
!      print *,'EBU_IN_SO2_ENS_PRIOR_SD ',ebu_in_so2_ens_sd_prior_urban_mn(:)
!      print *,'EBU_IN_SO2_INFL_PRIOR_MN ',ebu_in_so2_infl_prior_urban_mn(:)
!
      deallocate(ebu_in_so2_arc_prior_urban_mn)
      deallocate(ebu_in_so2_ens_mn_prior_urban_mn)
      deallocate(ebu_in_so2_ens_mn_post_urban_mn)
      deallocate(ebu_in_so2_incr_urban_mn)
      deallocate(ebu_in_so2_ens_vr_prior_urban_mn)
      deallocate(ebu_in_so2_ens_vr_post_urban_mn)
      deallocate(ebu_in_so2_ens_sd_prior_urban_mn)
      deallocate(ebu_in_so2_ens_sd_post_urban_mn)
      deallocate(ebu_in_so2_infl_prior_urban_mn)
      deallocate(ebu_in_so2_infl_post_urban_mn)
!
!  TRACER-I RURAL Spatial statistics EBU_IN_SO2
      allocate(ebu_in_so2_arc_prior_rural_mn(nz_fire))
      allocate(ebu_in_so2_ens_mn_prior_rural_mn(nz_fire))
      allocate(ebu_in_so2_ens_mn_post_rural_mn(nz_fire))
      allocate(ebu_in_so2_incr_rural_mn(nz_fire))
      allocate(ebu_in_so2_ens_vr_prior_rural_mn(nz_fire))
      allocate(ebu_in_so2_ens_vr_post_rural_mn(nz_fire))
      allocate(ebu_in_so2_ens_sd_prior_rural_mn(nz_fire))
      allocate(ebu_in_so2_ens_sd_post_rural_mn(nz_fire))
      allocate(ebu_in_so2_infl_prior_rural_mn(nz_fire))
      allocate(ebu_in_so2_infl_post_rural_mn(nz_fire))
!
      call spatial_mean_and_variance_emiss(traceri_ebu_in_so2_prior_ens_mn,traceri_ebu_in_so2_post_ens_mn, &
      traceri_ebu_in_so2_incr,traceri_ebu_in_so2_prior_ens_vr,traceri_ebu_in_so2_post_ens_vr,traceri_ebu_in_so2_infl_prior, &
      traceri_ebu_in_so2_infl_post,ebu_in_so2_ens_mn_prior_rural_mn,ebu_in_so2_ens_mn_post_rural_mn,ebu_in_so2_incr_rural_mn, &
      ebu_in_so2_ens_vr_prior_rural_mn,ebu_in_so2_ens_vr_post_rural_mn,ebu_in_so2_infl_prior_rural_mn,ebu_in_so2_infl_post_rural_mn, &
      traceri_rural_ii,traceri_rural_jj,1,nx*ny,num_rural,nx,ny,nz_fire, &
      traceri_ebu_in_so2_arc_prior,ebu_in_so2_arc_prior_rural_mn)
!
      ebu_in_so2_ens_sd_prior_rural_mn(:)=sqrt(ebu_in_so2_ens_vr_prior_rural_mn(:))
      ebu_in_so2_ens_sd_post_rural_mn(:)=sqrt(ebu_in_so2_ens_vr_post_rural_mn(:))
!
      call put_NETCDF_fld(trim(file_write),"TRACER_I_EBU_IN_SO2_ARC_PRIOR_RURAL_MN", &
      "degrees",ebu_in_so2_arc_prior_rural_mn,nz_fire,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_EBU_IN_SO2_EMN_PRIOR_RURAL_MN", &
      "degrees",ebu_in_so2_ens_mn_prior_rural_mn,nz_fire,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_EBU_IN_SO2_EMN_POST_RURAL_MN", &
      "degrees",ebu_in_so2_ens_mn_post_rural_mn,nz_fire,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_EBU_IN_SO2_INCR_RURAL_MN", &
      "degrees",ebu_in_so2_incr_rural_mn,nz_fire,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_EBU_IN_SO2_ESD_PRIOR_RURAL_MN", &
      "degrees",ebu_in_so2_ens_sd_prior_rural_mn,nz_fire,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_EBU_IN_SO2_ESD_POST_RURAL_MN", &
      "degrees",ebu_in_so2_ens_sd_post_rural_mn,nz_fire,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_EBU_IN_SO2_INFL_PRIOR_RURAL_MN", &
      "degrees",ebu_in_so2_infl_prior_rural_mn,nz_fire,1,1)
      call put_NETCDF_fld(trim(file_write),"TRACER_I_EBU_IN_SO2_INFL_POST_RURAL_MN", &
      "degrees",ebu_in_so2_infl_post_rural_mn,nz_fire,1,1)
!      print *,'EBU_IN_SO2_ENS_PRIOR_MN ',ebu_in_so2_ens_mn_prior_rural_mn(:)
!      print *,'EBU_IN_SO2_INCR ',ebu_in_so2_incr_rural_mn(:)
!      print *,'EBU_IN_SO2_ENS_PRIOR_SD ',ebu_in_so2_ens_sd_prior_rural_mn(:)
!      print *,'EBU_IN_SO2_INFL_PRIOR_MN ',ebu_in_so2_infl_prior_rural_mn(:)
!
      deallocate(ebu_in_so2_arc_prior_rural_mn)
      deallocate(ebu_in_so2_ens_mn_prior_rural_mn)
      deallocate(ebu_in_so2_ens_mn_post_rural_mn)
      deallocate(ebu_in_so2_incr_rural_mn)
      deallocate(ebu_in_so2_ens_vr_prior_rural_mn)
      deallocate(ebu_in_so2_ens_vr_post_rural_mn)
      deallocate(ebu_in_so2_ens_sd_prior_rural_mn)
      deallocate(ebu_in_so2_ens_sd_post_rural_mn)
      deallocate(ebu_in_so2_infl_prior_rural_mn)
      deallocate(ebu_in_so2_infl_post_rural_mn)
!
      deallocate(traceri_ebu_in_so2_arc_prior)
      deallocate(traceri_ebu_in_so2_prior_ens_mn)
      deallocate(traceri_ebu_in_so2_post_ens_mn)
      deallocate(traceri_ebu_in_so2_incr)
      deallocate(traceri_ebu_in_so2_prior_ens_sd)
      deallocate(traceri_ebu_in_so2_post_ens_sd)
      deallocate(traceri_ebu_in_so2_prior_ens_vr)
      deallocate(traceri_ebu_in_so2_post_ens_vr)
      deallocate(traceri_ebu_in_so2_infl_prior)
      deallocate(traceri_ebu_in_so2_infl_post)
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

   subroutine create_NETCDF_file(new_file,nx,ny,nz,nz_chemi,nz_fire)
      use :: netcdf
      implicit none
!      
      integer                    :: rc,fid
      integer                    :: nx,ny,nz,nz_chemi,nz_fire
      integer                    :: x_dimid,y_dimid,z_dimid,zch_dimid,zfr_dimid,scl_dimid
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
! TRACER-I T DA DIAGNOSTICS
! CONUS
      rc=nf90_def_var(fid,"TRACER_I_T_EMN_PRIOR_CONUS_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_T_EMN_PRIOR_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_T_EMN_POST_CONUS_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_T_EMN_POST_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_T_INCR_CONUS_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_T_INCR_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_T_ESD_PRIOR_CONUS_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_T_ESD_PRIOR_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_T_ESD_POST_CONUS_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_T_ESD_POST_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_T_INFL_PRIOR_CONUS_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_T_INFL_PRIOR_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_T_INFL_POST_CONUS_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_T_INFL_POST_CONUS_MN')
!
! URBAN
      rc=nf90_def_var(fid,"TRACER_I_T_EMN_PRIOR_URBAN_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_T_EMN_PRIOR_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_T_EMN_POST_URBAN_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_T_EMN_POST_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_T_INCR_URBAN_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_T_INCR_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_T_ESD_PRIOR_URBAN_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_T_ESD_PRIOR_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_T_ESD_POST_URBAN_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_T_ESD_POST_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_T_INFL_PRIOR_URBAN_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_T_INFL_PRIOR_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_T_INFL_POST_URBAN_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_T_INFL_POST_URBAN_MN')
!
! RURAL
      rc=nf90_def_var(fid,"TRACER_I_T_EMN_PRIOR_RURAL_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_T_EMN_PRIOR_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_T_EMN_POST_RURAL_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_T_EMN_POST_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_T_INCR_RURAL_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_T_INCR_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_T_ESD_PRIOR_RURAL_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_T_ESD_PRIOR_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_T_ESD_POST_RURAL_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_T_ESD_POST_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_T_INFL_PRIOR_RURAL_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_T_INFL_PRIOR_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_T_INFL_POST_RURAL_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_T_INFL_POST_RURAL_MN')
!
! TRACER-I U DA DIAGNOSTICS
! CONUS
      rc=nf90_def_var(fid,"TRACER_I_U_EMN_PRIOR_CONUS_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_U_EMN_PRIOR_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_U_EMN_POST_CONUS_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_U_EMN_POST_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_U_INCR_CONUS_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_U_INCR_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_U_ESD_PRIOR_CONUS_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_U_ESD_PRIOR_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_U_ESD_POST_CONUS_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_U_ESD_POST_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_U_INFL_PRIOR_CONUS_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_U_INFL_PRIOR_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_U_INFL_POST_CONUS_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_U_INFL_POST_CONUS_MN')
!
! URBAN      
      rc=nf90_def_var(fid,"TRACER_I_U_EMN_PRIOR_URBAN_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_U_EMN_PRIOR_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_U_EMN_POST_URBAN_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_U_EMN_POST_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_U_INCR_URBAN_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_U_INCR_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_U_ESD_PRIOR_URBAN_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_U_ESD_PRIOR_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_U_ESD_POST_URBAN_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_U_ESD_POST_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_U_INFL_PRIOR_URBAN_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_U_INFL_PRIOR_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_U_INFL_POST_URBAN_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_U_INFL_POST_URBAN_MN')
!
! RURAL
      rc=nf90_def_var(fid,"TRACER_I_U_EMN_PRIOR_RURAL_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_U_EMN_PRIOR_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_U_EMN_POST_RURAL_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_U_EMN_POST_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_U_INCR_RURAL_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_U_INCR_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_U_ESD_PRIOR_RURAL_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_U_ESD_PRIOR_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_U_ESD_POST_RURAL_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_U_ESD_POST_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_U_INFL_PRIOR_RURAL_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_U_INFL_PRIOR_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_U_INFL_POST_RURAL_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_U_INFL_POST_RURAL_MN')
!
! TRACER-I V DA DIAGNOSTICS
! CONUS
      rc=nf90_def_var(fid,"TRACER_I_V_EMN_PRIOR_CONUS_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_V_EMN_PRIOR_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_V_EMN_POST_CONUS_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_V_EMN_POST_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_V_INCR_CONUS_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_V_INCR_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_V_ESD_PRIOR_CONUS_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_V_ESD_PRIOR_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_V_ESD_POST_CONUS_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_V_ESD_POST_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_V_INFL_PRIOR_CONUS_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_V_INFL_PRIOR_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_V_INFL_POST_CONUS_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_V_INFL_POST_CONUS_MN')
!
! URBAN      
      rc=nf90_def_var(fid,"TRACER_I_V_EMN_PRIOR_URBAN_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_V_EMN_PRIOR_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_V_EMN_POST_URBAN_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_V_EMN_POST_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_V_INCR_URBAN_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_V_INCR_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_V_ESD_PRIOR_URBAN_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_V_ESD_PRIOR_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_V_ESD_POST_URBAN_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_V_ESD_POST_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_V_INFL_PRIOR_URBAN_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_V_INFL_PRIOR_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_V_INFL_POST_URBAN_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_V_INFL_POST_URBAN_MN')
!
! RURAL
      rc=nf90_def_var(fid,"TRACER_I_V_EMN_PRIOR_RURAL_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_V_EMN_PRIOR_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_V_EMN_POST_RURAL_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_V_EMN_POST_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_V_INCR_RURAL_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_V_INCR_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_V_ESD_PRIOR_RURAL_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_V_ESD_PRIOR_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_V_ESD_POST_RURAL_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_V_ESD_POST_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_V_INFL_PRIOR_RURAL_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_V_INFL_PRIOR_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_V_INFL_POST_RURAL_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_V_INFL_POST_RURAL_MN')
!
! TRACER-I Q DA DIAGNOSTICS
! CONUS
      rc=nf90_def_var(fid,"TRACER_I_Q_EMN_PRIOR_CONUS_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_Q_EMN_PRIOR_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_Q_EMN_POST_CONUS_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_Q_EMN_POST_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_Q_INCR_CONUS_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_Q_INCR_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_Q_ESD_PRIOR_CONUS_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_Q_ESD_PRIOR_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_Q_ESD_POST_CONUS_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_Q_ESD_POST_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_Q_INFL_PRIOR_CONUS_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_Q_INFL_PRIOR_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_Q_INFL_POST_CONUS_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_Q_INFL_POST_CONUS_MN')
!
! URBAN      
      rc=nf90_def_var(fid,"TRACER_I_Q_EMN_PRIOR_URBAN_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_Q_EMN_PRIOR_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_Q_EMN_POST_URBAN_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_Q_EMN_POST_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_Q_INCR_URBAN_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_Q_INCR_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_Q_ESD_PRIOR_URBAN_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_Q_ESD_PRIOR_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_Q_ESD_POST_URBAN_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_Q_ESD_POST_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_Q_INFL_PRIOR_URBAN_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_Q_INFL_PRIOR_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_Q_INFL_POST_URBAN_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_Q_INFL_POST_URBAN_MN')
!
! RURAL
      rc=nf90_def_var(fid,"TRACER_I_Q_EMN_PRIOR_RURAL_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_Q_EMN_PRIOR_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_Q_EMN_POST_RURAL_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_Q_EMN_POST_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_Q_INCR_RURAL_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_Q_INCR_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_Q_ESD_PRIOR_RURAL_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_Q_ESD_PRIOR_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_Q_ESD_POST_RURAL_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_Q_ESD_POST_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_Q_INFL_PRIOR_RURAL_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_Q_INFL_PRIOR_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_Q_INFL_POST_RURAL_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_Q_INFL_POST_RURAL_MN')
!
! TRACER-I CO DA DIAGNOSTICS
! CONUS
      rc=nf90_def_var(fid,"TRACER_I_CO_EMN_PRIOR_CONUS_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_CO_EMN_PRIOR_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_CO_EMN_POST_CONUS_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_CO_EMN_POST_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_CO_INCR_CONUS_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_CO_INCR_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_CO_ESD_PRIOR_CONUS_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_CO_ESD_PRIOR_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_CO_ESD_POST_CONUS_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_CO_ESD_POST_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_CO_INFL_PRIOR_CONUS_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_CO_INFL_PRIOR_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_CO_INFL_POST_CONUS_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_CO_INFL_POST_CONUS_MN')
!
! URBAN      
      rc=nf90_def_var(fid,"TRACER_I_CO_EMN_PRIOR_URBAN_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_CO_EMN_PRIOR_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_CO_EMN_POST_URBAN_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_CO_EMN_POST_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_CO_INCR_URBAN_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_CO_INCR_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_CO_ESD_PRIOR_URBAN_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_CO_ESD_PRIOR_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_CO_ESD_POST_URBAN_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_CO_ESD_POST_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_CO_INFL_PRIOR_URBAN_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_CO_INFL_PRIOR_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_CO_INFL_POST_URBAN_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_CO_INFL_POST_URBAN_MN')
!
! RURAL
      rc=nf90_def_var(fid,"TRACER_I_CO_EMN_PRIOR_RURAL_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_CO_EMN_PRIOR_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_CO_EMN_POST_RURAL_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_CO_EMN_POST_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_CO_INCR_RURAL_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_CO_INCR_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_CO_ESD_PRIOR_RURAL_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_CO_ESD_PRIOR_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_CO_ESD_POST_RURAL_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_CO_ESD_POST_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_CO_INFL_PRIOR_RURAL_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_CO_INFL_PRIOR_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_CO_INFL_POST_RURAL_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_CO_INFL_POST_RURAL_MN')
!
! TRACER-I O3 DA DIAGNOSTICS
! CONUS
      rc=nf90_def_var(fid,"TRACER_I_O3_EMN_PRIOR_CONUS_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_O3_EMN_PRIOR_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_O3_EMN_POST_CONUS_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_O3_EMN_POST_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_O3_INCR_CONUS_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_O3_INCR_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_O3_ESD_PRIOR_CONUS_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_O3_ESD_PRIOR_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_O3_ESD_POST_CONUS_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_O3_ESD_POST_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_O3_INFL_PRIOR_CONUS_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_O3_INFL_PRIOR_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_O3_INFL_POST_CONUS_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_O3_INFL_POST_CONUS_MN')
!
! URBAN      
      rc=nf90_def_var(fid,"TRACER_I_O3_EMN_PRIOR_URBAN_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_O3_EMN_PRIOR_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_O3_EMN_POST_URBAN_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_O3_EMN_POST_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_O3_INCR_URBAN_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_O3_INCR_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_O3_ESD_PRIOR_URBAN_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_O3_ESD_PRIOR_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_O3_ESD_POST_URBAN_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_O3_ESD_POST_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_O3_INFL_PRIOR_URBAN_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_O3_INFL_PRIOR_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_O3_INFL_POST_URBAN_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_O3_INFL_POST_URBAN_MN')
!
! RURAL
      rc=nf90_def_var(fid,"TRACER_I_O3_EMN_PRIOR_RURAL_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_O3_EMN_PRIOR_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_O3_EMN_POST_RURAL_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_O3_EMN_POST_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_O3_INCR_RURAL_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_O3_INCR_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_O3_ESD_PRIOR_RURAL_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_O3_ESD_PRIOR_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_O3_ESD_POST_RURAL_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_O3_ESD_POST_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_O3_INFL_PRIOR_RURAL_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_O3_INFL_PRIOR_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_O3_INFL_POST_RURAL_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_O3_INFL_POST_RURAL_MN')
!
! TRACER-I NO2 DA DIAGNOSTICS
! CONUS
      rc=nf90_def_var(fid,"TRACER_I_NO2_EMN_PRIOR_CONUS_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_NO2_EMN_PRIOR_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_NO2_EMN_POST_CONUS_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_NO2_EMN_POST_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_NO2_INCR_CONUS_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_NO2_INCR_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_NO2_ESD_PRIOR_CONUS_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_NO2_ESD_PRIOR_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_NO2_ESD_POST_CONUS_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_NO2_ESD_POST_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_NO2_INFL_PRIOR_CONUS_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_NO2_INFL_PRIOR_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_NO2_INFL_POST_CONUS_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_NO2_INFL_POST_CONUS_MN')
!
! URBAN      
      rc=nf90_def_var(fid,"TRACER_I_NO2_EMN_PRIOR_URBAN_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_NO2_EMN_PRIOR_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_NO2_EMN_POST_URBAN_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_NO2_EMN_POST_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_NO2_INCR_URBAN_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_NO2_INCR_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_NO2_ESD_PRIOR_URBAN_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_NO2_ESD_PRIOR_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_NO2_ESD_POST_URBAN_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_NO2_ESD_POST_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_NO2_INFL_PRIOR_URBAN_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_NO2_INFL_PRIOR_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_NO2_INFL_POST_URBAN_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_NO2_INFL_POST_URBAN_MN')
!
! RURAL
      rc=nf90_def_var(fid,"TRACER_I_NO2_EMN_PRIOR_RURAL_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_NO2_EMN_PRIOR_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_NO2_EMN_POST_RURAL_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_NO2_EMN_POST_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_NO2_INCR_RURAL_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_NO2_INCR_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_NO2_ESD_PRIOR_RURAL_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_NO2_ESD_PRIOR_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_NO2_ESD_POST_RURAL_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_NO2_ESD_POST_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_NO2_INFL_PRIOR_RURAL_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_NO2_INFL_PRIOR_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_NO2_INFL_POST_RURAL_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_NO2_INFL_POST_RURAL_MN')
!
! TRACER-I SO2 DA DIAGNOSTICS
! CONUS
      rc=nf90_def_var(fid,"TRACER_I_SO2_EMN_PRIOR_CONUS_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_SO2_EMN_PRIOR_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_SO2_EMN_POST_CONUS_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_SO2_EMN_POST_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_SO2_INCR_CONUS_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_SO2_INCR_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_SO2_ESD_PRIOR_CONUS_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_SO2_ESD_PRIOR_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_SO2_ESD_POST_CONUS_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_SO2_ESD_POST_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_SO2_INFL_PRIOR_CONUS_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_SO2_INFL_PRIOR_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_SO2_INFL_POST_CONUS_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_SO2_INFL_POST_CONUS_MN')
!
! URBAN      
      rc=nf90_def_var(fid,"TRACER_I_SO2_EMN_PRIOR_URBAN_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_SO2_EMN_PRIOR_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_SO2_EMN_POST_URBAN_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_SO2_EMN_POST_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_SO2_INCR_URBAN_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_SO2_INCR_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_SO2_ESD_PRIOR_URBAN_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_SO2_ESD_PRIOR_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_SO2_ESD_POST_URBAN_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_SO2_ESD_POST_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_SO2_INFL_PRIOR_URBAN_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_SO2_INFL_PRIOR_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_SO2_INFL_POST_URBAN_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_SO2_INFL_POST_URBAN_MN')
!
! RURAL
      rc=nf90_def_var(fid,"TRACER_I_SO2_EMN_PRIOR_RURAL_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_SO2_EMN_PRIOR_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_SO2_EMN_POST_RURAL_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_SO2_EMN_POST_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_SO2_INCR_RURAL_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_SO2_INCR_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_SO2_ESD_PRIOR_RURAL_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_SO2_ESD_PRIOR_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_SO2_ESD_POST_RURAL_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_SO2_ESD_POST_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_SO2_INFL_PRIOR_RURAL_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_SO2_INFL_PRIOR_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_SO2_INFL_POST_RURAL_MN",NF90_FLOAT,(/z_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_SO2_INFL_POST_RURAL_MN')
!
! TRACER-I E_CO DA DIAGNOSTICS
! CONUS
      rc=nf90_def_var(fid,"TRACER_I_E_CO_ARC_PRIOR_CONUS_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_E_CO_ARC_PRIOR_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_E_CO_EMN_PRIOR_CONUS_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_E_CO_EMN_PRIOR_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_E_CO_EMN_POST_CONUS_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_E_CO_EMN_POST_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_E_CO_INCR_CONUS_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_E_CO_INCR_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_E_CO_ESD_PRIOR_CONUS_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_E_CO_ESD_PRIOR_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_E_CO_ESD_POST_CONUS_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_E_CO_ESD_POST_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_E_CO_INFL_PRIOR_CONUS_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_E_CO_INFL_PRIOR_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_E_CO_INFL_POST_CONUS_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_E_CO_INFL_POST_CONUS_MN')
!
! URBAN      
      rc=nf90_def_var(fid,"TRACER_I_E_CO_ARC_PRIOR_URBAN_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_E_CO_ARC_PRIOR_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_E_CO_EMN_PRIOR_URBAN_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_E_CO_EMN_PRIOR_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_E_CO_EMN_POST_URBAN_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_E_CO_EMN_POST_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_E_CO_INCR_URBAN_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_E_CO_INCR_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_E_CO_ESD_PRIOR_URBAN_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_E_CO_ESD_PRIOR_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_E_CO_ESD_POST_URBAN_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_E_CO_ESD_POST_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_E_CO_INFL_PRIOR_URBAN_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_E_CO_INFL_PRIOR_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_E_CO_INFL_POST_URBAN_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_E_CO_INFL_POST_URBAN_MN')
!
! RURAL
      rc=nf90_def_var(fid,"TRACER_I_E_CO_ARC_PRIOR_RURAL_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_E_CO_ARC_PRIOR_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_E_CO_EMN_PRIOR_RURAL_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_E_CO_EMN_PRIOR_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_E_CO_EMN_POST_RURAL_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_E_CO_EMN_POST_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_E_CO_INCR_RURAL_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_E_CO_INCR_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_E_CO_ESD_PRIOR_RURAL_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_E_CO_ESD_PRIOR_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_E_CO_ESD_POST_RURAL_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_E_CO_ESD_POST_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_E_CO_INFL_PRIOR_RURAL_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_E_CO_INFL_PRIOR_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_E_CO_INFL_POST_RURAL_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_E_CO_INFL_POST_RURAL_MN')
!
! TRACER-I E_NO2 DA DIAGNOSTICS
! CONUS
      rc=nf90_def_var(fid,"TRACER_I_E_NO2_ARC_PRIOR_CONUS_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_E_NO2_ARC_PRIOR_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_E_NO2_EMN_PRIOR_CONUS_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_E_NO2_EMN_PRIOR_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_E_NO2_EMN_POST_CONUS_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_E_NO2_EMN_POST_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_E_NO2_INCR_CONUS_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_E_NO2_INCR_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_E_NO2_ESD_PRIOR_CONUS_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_E_NO2_ESD_PRIOR_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_E_NO2_ESD_POST_CONUS_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_E_NO2_ESD_POST_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_E_NO2_INFL_PRIOR_CONUS_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_E_NO2_INFL_PRIOR_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_E_NO2_INFL_POST_CONUS_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_E_NO2_INFL_POST_CONUS_MN')
!
! URBAN      
      rc=nf90_def_var(fid,"TRACER_I_E_NO2_ARC_PRIOR_URBAN_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_E_NO2_ARC_PRIOR_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_E_NO2_EMN_PRIOR_URBAN_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_E_NO2_EMN_PRIOR_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_E_NO2_EMN_POST_URBAN_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_E_NO2_EMN_POST_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_E_NO2_INCR_URBAN_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_E_NO2_INCR_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_E_NO2_ESD_PRIOR_URBAN_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_E_NO2_ESD_PRIOR_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_E_NO2_ESD_POST_URBAN_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_E_NO2_ESD_POST_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_E_NO2_INFL_PRIOR_URBAN_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_E_NO2_INFL_PRIOR_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_E_NO2_INFL_POST_URBAN_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_E_NO2_INFL_POST_URBAN_MN')
!
! RURAL
      rc=nf90_def_var(fid,"TRACER_I_E_NO2_ARC_PRIOR_RURAL_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_E_NO2_ARC_PRIOR_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_E_NO2_EMN_PRIOR_RURAL_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_E_NO2_EMN_PRIOR_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_E_NO2_EMN_POST_RURAL_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_E_NO2_EMN_POST_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_E_NO2_INCR_RURAL_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_E_NO2_INCR_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_E_NO2_ESD_PRIOR_RURAL_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_E_NO2_ESD_PRIOR_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_E_NO2_ESD_POST_RURAL_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_E_NO2_ESD_POST_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_E_NO2_INFL_PRIOR_RURAL_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_E_NO2_INFL_PRIOR_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_E_NO2_INFL_POST_RURAL_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_E_NO2_INFL_POST_RURAL_MN')
!
! TRACER-I E_SO2 DA DIAGNOSTICS
! CONUS
      rc=nf90_def_var(fid,"TRACER_I_E_SO2_ARC_PRIOR_CONUS_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_E_SO2_ARC_PRIOR_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_E_SO2_EMN_PRIOR_CONUS_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_E_SO2_EMN_PRIOR_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_E_SO2_EMN_POST_CONUS_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_E_SO2_EMN_POST_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_E_SO2_INCR_CONUS_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_E_SO2_INCR_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_E_SO2_ESD_PRIOR_CONUS_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_E_SO2_ESD_PRIOR_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_E_SO2_ESD_POST_CONUS_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_E_SO2_ESD_POST_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_E_SO2_INFL_PRIOR_CONUS_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_E_SO2_INFL_PRIOR_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_E_SO2_INFL_POST_CONUS_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_E_SO2_INFL_POST_CONUS_MN')
!
! URBAN      
      rc=nf90_def_var(fid,"TRACER_I_E_SO2_ARC_PRIOR_URBAN_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_E_SO2_ARC_PRIOR_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_E_SO2_EMN_PRIOR_URBAN_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_E_SO2_EMN_PRIOR_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_E_SO2_EMN_POST_URBAN_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_E_SO2_EMN_POST_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_E_SO2_INCR_URBAN_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_E_SO2_INCR_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_E_SO2_ESD_PRIOR_URBAN_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_E_SO2_ESD_PRIOR_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_E_SO2_ESD_POST_URBAN_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_E_SO2_ESD_POST_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_E_SO2_INFL_PRIOR_URBAN_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_E_SO2_INFL_PRIOR_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_E_SO2_INFL_POST_URBAN_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_E_SO2_INFL_POST_URBAN_MN')
!
! RURAL
      rc=nf90_def_var(fid,"TRACER_I_E_SO2_ARC_PRIOR_RURAL_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_E_SO2_ARC_PRIOR_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_E_SO2_EMN_PRIOR_RURAL_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_E_SO2_EMN_PRIOR_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_E_SO2_EMN_POST_RURAL_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_E_SO2_EMN_POST_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_E_SO2_INCR_RURAL_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_E_SO2_INCR_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_E_SO2_ESD_PRIOR_RURAL_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_E_SO2_ESD_PRIOR_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_E_SO2_ESD_POST_RURAL_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_E_SO2_ESD_POST_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_E_SO2_INFL_PRIOR_RURAL_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_E_SO2_INFL_PRIOR_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_E_SO2_INFL_POST_RURAL_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_E_SO2_INFL_POST_RURAL_MN')
!
! TRACER-I EBU_IN_CO DA DIAGNOSTICS
! CONUS
      rc=nf90_def_var(fid,"TRACER_I_EBU_IN_CO_ARC_PRIOR_CONUS_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_EBU_IN_CO_ARC_PRIOR_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_EBU_IN_CO_EMN_PRIOR_CONUS_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_EBU_IN_CO_EMN_PRIOR_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_EBU_IN_CO_EMN_POST_CONUS_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_EBU_IN_CO_EMN_POST_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_EBU_IN_CO_INCR_CONUS_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_EBU_IN_CO_INCR_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_EBU_IN_CO_ESD_PRIOR_CONUS_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_EBU_IN_CO_ESD_PRIOR_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_EBU_IN_CO_ESD_POST_CONUS_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_EBU_IN_CO_ESD_POST_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_EBU_IN_CO_INFL_PRIOR_CONUS_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_EBU_IN_CO_INFL_PRIOR_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_EBU_IN_CO_INFL_POST_CONUS_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_EBU_IN_CO_INFL_POST_CONUS_MN')
!
! URBAN      
      rc=nf90_def_var(fid,"TRACER_I_EBU_IN_CO_ARC_PRIOR_URBAN_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_EBU_IN_CO_ARC_PRIOR_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_EBU_IN_CO_EMN_PRIOR_URBAN_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_EBU_IN_CO_EMN_PRIOR_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_EBU_IN_CO_EMN_POST_URBAN_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_EBU_IN_CO_EMN_POST_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_EBU_IN_CO_INCR_URBAN_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_EBU_IN_CO_INCR_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_EBU_IN_CO_ESD_PRIOR_URBAN_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_EBU_IN_CO_ESD_PRIOR_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_EBU_IN_CO_ESD_POST_URBAN_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_EBU_IN_CO_ESD_POST_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_EBU_IN_CO_INFL_PRIOR_URBAN_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_EBU_IN_CO_INFL_PRIOR_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_EBU_IN_CO_INFL_POST_URBAN_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_EBU_IN_CO_INFL_POST_URBAN_MN')
!
! RURAL
      rc=nf90_def_var(fid,"TRACER_I_EBU_IN_CO_ARC_PRIOR_RURAL_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_EBU_IN_CO_ARC_PRIOR_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_EBU_IN_CO_EMN_PRIOR_RURAL_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_EBU_IN_CO_EMN_PRIOR_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_EBU_IN_CO_EMN_POST_RURAL_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_EBU_IN_CO_EMN_POST_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_EBU_IN_CO_INCR_RURAL_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_EBU_IN_CO_INCR_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_EBU_IN_CO_ESD_PRIOR_RURAL_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_EBU_IN_CO_ESD_PRIOR_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_EBU_IN_CO_ESD_POST_RURAL_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_EBU_IN_CO_ESD_POST_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_EBU_IN_CO_INFL_PRIOR_RURAL_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_EBU_IN_CO_INFL_PRIOR_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_EBU_IN_CO_INFL_POST_RURAL_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_EBU_INCO_INFL_POST_RURAL_MN')
!
! TRACER-I EBU_IN_NO2 DA DIAGNOSTICS
! CONUS
      rc=nf90_def_var(fid,"TRACER_I_EBU_IN_NO2_ARC_PRIOR_CONUS_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_EBU_IN_NO2_ARC_PRIOR_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_EBU_IN_NO2_EMN_PRIOR_CONUS_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_EBU_IN_NO2_EMN_PRIOR_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_EBU_IN_NO2_EMN_POST_CONUS_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_EBU_IN_NO2_EMN_POST_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_EBU_IN_NO2_INCR_CONUS_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_EBU_IN_NO2_INCR_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_EBU_IN_NO2_ESD_PRIOR_CONUS_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_EBU_IN_NO2_ESD_PRIOR_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_EBU_IN_NO2_ESD_POST_CONUS_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_EBU_IN_NO2_ESD_POST_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_EBU_IN_NO2_INFL_PRIOR_CONUS_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_EBU_IN_NO2_INFL_PRIOR_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_EBU_IN_NO2_INFL_POST_CONUS_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_EBU_IN_NO2_INFL_POST_CONUS_MN')
!
! URBAN      
      rc=nf90_def_var(fid,"TRACER_I_EBU_IN_NO2_ARC_PRIOR_URBAN_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_EBU_IN_NO2_ARC_PRIOR_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_EBU_IN_NO2_EMN_PRIOR_URBAN_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_EBU_IN_NO2_EMN_PRIOR_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_EBU_IN_NO2_EMN_POST_URBAN_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_EBU_IN_NO2_EMN_POST_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_EBU_IN_NO2_INCR_URBAN_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_EBU_IN_NO2_INCR_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_EBU_IN_NO2_ESD_PRIOR_URBAN_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_EBU_IN_NO2_ESD_PRIOR_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_EBU_IN_NO2_ESD_POST_URBAN_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_EBU_IN_NO2_ESD_POST_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_EBU_IN_NO2_INFL_PRIOR_URBAN_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_EBU_IN_NO2_INFL_PRIOR_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_EBU_IN_NO2_INFL_POST_URBAN_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_EBU_IN_NO2_INFL_POST_URBAN_MN')
!
! RURAL
      rc=nf90_def_var(fid,"TRACER_I_EBU_IN_NO2_ARC_PRIOR_RURAL_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_EBU_IN_NO2_ARC_PRIOR_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_EBU_IN_NO2_EMN_PRIOR_RURAL_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_EBU_IN_NO2_EMN_PRIOR_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_EBU_IN_NO2_EMN_POST_RURAL_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_EBU_IN_NO2_EMN_POST_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_EBU_IN_NO2_INCR_RURAL_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_EBU_IN_NO2_INCR_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_EBU_IN_NO2_ESD_PRIOR_RURAL_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_EBU_IN_NO2_ESD_PRIOR_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_EBU_IN_NO2_ESD_POST_RURAL_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_EBU_IN_NO2_ESD_POST_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_EBU_IN_NO2_INFL_PRIOR_RURAL_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_EBU_IN_NO2_INFL_PRIOR_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_EBU_IN_NO2_INFL_POST_RURAL_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_EBU_IN_NO2_INFL_POST_RURAL_MN')
!
! TRACER-I EBU_IN_SO2 DA DIAGNOSTICS
! CONUS
      rc=nf90_def_var(fid,"TRACER_I_EBU_IN_SO2_ARC_PRIOR_CONUS_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_EBU_IN_SO2_ARC_PRIOR_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_EBU_IN_SO2_EMN_PRIOR_CONUS_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_EBU_IN_SO2_EMN_PRIOR_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_EBU_IN_SO2_EMN_POST_CONUS_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_EBU_IN_SO2_EMN_POST_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_EBU_IN_SO2_INCR_CONUS_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_EBU_IN_SO2_INCR_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_EBU_IN_SO2_ESD_PRIOR_CONUS_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_EBU_IN_SO2_ESD_PRIOR_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_EBU_IN_SO2_ESD_POST_CONUS_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_EBU_IN_SO2_ESD_POST_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_EBU_IN_SO2_INFL_PRIOR_CONUS_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_EBU_IN_SO2_INFL_PRIOR_CONUS_MN')

      rc=nf90_def_var(fid,"TRACER_I_EBU_IN_SO2_INFL_POST_CONUS_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_EBU_IN_SO2_INFL_POST_CONUS_MN')
!
! URBAN      
      rc=nf90_def_var(fid,"TRACER_I_EBU_IN_SO2_ARC_PRIOR_URBAN_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_EBU_IN_SO2_ARC_PRIOR_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_EBU_IN_SO2_EMN_PRIOR_URBAN_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_EBU_IN_SO2_EMN_PRIOR_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_EBU_IN_SO2_EMN_POST_URBAN_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_EBU_IN_SO2_EMN_POST_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_EBU_IN_SO2_INCR_URBAN_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_EBU_IN_SO2_INCR_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_EBU_IN_SO2_ESD_PRIOR_URBAN_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_EBU_IN_SO2_ESD_PRIOR_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_EBU_IN_SO2_ESD_POST_URBAN_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_EBU_IN_SO2_ESD_POST_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_EBU_IN_SO2_INFL_PRIOR_URBAN_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_EBU_IN_SO2_INFL_PRIOR_URBAN_MN')

      rc=nf90_def_var(fid,"TRACER_I_EBU_IN_SO2_INFL_POST_URBAN_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_EBU_IN_SO2_INFL_POST_URBAN_MN')
!
! RURAL
      rc=nf90_def_var(fid,"TRACER_I_EBU_IN_SO2_ARC_PRIOR_RURAL_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_EBU_IN_SO2_ARC_PRIOR_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_EBU_IN_SO2_EMN_PRIOR_RURAL_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_EBU_IN_SO2_EMN_PRIOR_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_EBU_IN_SO2_EMN_POST_RURAL_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_EBU_IN_SO2_EMN_POST_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_EBU_IN_SO2_INCR_RURAL_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_EBU_IN_SO2_INCR_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_EBU_IN_SO2_ESD_PRIOR_RURAL_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_EBU_IN_SO2_ESD_PRIOR_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_EBU_IN_SO2_ESD_POST_RURAL_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_EBU_IN_SO2_ESD_POST_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_EBU_IN_SO2_INFL_PRIOR_RURAL_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_EBU_IN_SO2_INFL_PRIOR_RURAL_MN')

      rc=nf90_def_var(fid,"TRACER_I_EBU_IN_SO2_INFL_POST_RURAL_MN",NF90_FLOAT,(/zch_dimid/),var_id)
      if(rc /= NF90_NOERR) call handle_err(rc,'APM: at TRACER_I_EBU_IN_SO2_INFL_POST_RURAL_MN')

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

   subroutine spatial_mean_and_variance_emiss(fld_prior_ens_mn,fld_post_ens_mn,fld_incr, &
   fld_prior_ens_vr,fld_post_ens_vr,fld_prior_infl,fld_post_infl,fld_prior_emn_rmn, &
   fld_post_emn_rmn,fld_incr_rmn,fld_prior_evr_rmn,fld_post_evr_rmn,fld_prior_infl_rmn, &
   fld_post_infl_rmn,fld_region_ii,fld_region_jj,num_region,npts_region,ncnt_region, &
   nx,ny,nz,fld_arc_prior,fld_arc_prior_rmn)
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
      real,dimension(nz)                              :: fld_arc_prior_rmn
      real,dimension(nx,ny,nz)                        :: fld_prior_ens_mn,fld_post_ens_mn,fld_incr
      real,dimension(nx,ny,nz)                        :: fld_prior_ens_vr,fld_post_ens_vr
      real,dimension(nx,ny,nz)                        :: fld_prior_infl,fld_post_infl,fld_arc_prior
      fld_arc_prior_rmn(:)=0.
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
               if(fld_prior_ens_mn(i,j,k).gt.0. .or. fld_post_ens_mn(i,j,k).gt.0.) then
                  fld_arc_prior_rmn(k)=fld_arc_prior_rmn(k)+wt*fld_arc_prior(i,j,k)
                  fld_prior_emn_rmn(k)=fld_prior_emn_rmn(k)+wt*fld_prior_ens_mn(i,j,k)
                  fld_post_emn_rmn(k)=fld_post_emn_rmn(k)+wt*fld_post_ens_mn(i,j,k)
                  fld_incr_rmn(k)=fld_incr_rmn(k)+wt*fld_incr(i,j,k)
                  fld_prior_evr_rmn(k)=fld_prior_evr_rmn(k)+wt*fld_prior_ens_vr(i,j,k)
                  fld_post_evr_rmn(k)=fld_post_evr_rmn(k)+wt*fld_post_ens_vr(i,j,k) 
                  fld_prior_infl_rmn(k)=fld_prior_infl_rmn(k)+wt*fld_prior_infl(i,j,k)
                  fld_post_infl_rmn(k)=fld_post_infl_rmn(k)+wt*fld_post_infl(i,j,k)
                  zwt(k)=zwt(k)+wt
               endif
            enddo
         enddo
      enddo
      do k=1,nz
         if(zwt(k).gt.0) then
            fld_arc_prior_rmn(k)=fld_arc_prior_rmn(k)/zwt(k)
            fld_prior_emn_rmn(k)=fld_prior_emn_rmn(k)/zwt(k)
            fld_post_emn_rmn(k)=fld_post_emn_rmn(k)/zwt(k)
            fld_incr_rmn(k)=fld_incr_rmn(k)/zwt(k)
            fld_prior_evr_rmn(k)=fld_prior_evr_rmn(k)/zwt(k)
            fld_post_evr_rmn(k)=fld_post_evr_rmn(k)/zwt(k)
            fld_prior_infl_rmn(k)=fld_prior_infl_rmn(k)/zwt(k)
            fld_post_infl_rmn(k)=fld_post_infl_rmn(k)/zwt(k)
         endif
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

