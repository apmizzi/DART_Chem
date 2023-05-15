!
! ifort -C bias_corr.f90 -o bias_corr.exe -lncarg -lncarg_gks -lncarg_c -lX11 -lXext -lcairo -lfontconfig -lpixman -lfreetype -lexpat -lpng -lz -lpthread -lbz2 -lXrender -lgfortran -lnetcdff -lnetcdf
!
program main
   implicit none
   integer,parameter :: num_mem=10
   integer,parameter :: maxnobs=300000
   integer,parameter :: maxkinds=20
   integer,parameter :: mopitt_co_ndim=10
   integer,parameter :: mopitt_co_ndimm=mopitt_co_ndim-1
   integer,parameter :: iasi_co_ndim=50
   integer,parameter :: iasi_o3_ndim=50
   integer,parameter :: omi_o3_ndim=50
   integer,parameter :: omi_no2_ndim=50
   integer,parameter :: omi_so2_ndim=50
   integer,parameter :: tropomi_co_ndim=50
   integer,parameter :: tropomi_o3_ndim=50
   integer,parameter :: tropomi_no2_ndim=50
   integer,parameter :: tropomi_so2_ndim=50
   integer,parameter :: tempo_o3_ndim=50
   integer,parameter :: tempo_no2_ndim=50
   real,parameter    :: missing=-888888.0
   real,parameter,dimension(mopitt_co_ndimm) :: &
   mopitt_prs = (/900.,800.,700.,600.,500.,400.,300.,200.,100./)
!
   integer :: airnow_co_cnt, airnow_o3_cnt, airnow_no2_cnt, airnow_so2_cnt, &
   airnow_pm10_cnt, airnow_pm25_cnt, mopitt_co_prf_cnt, iasi_co_prf_cnt, &
   iasi_co_col_cnt, iasi_o3_prf_cnt, modis_aod_cnt, omi_o3_col_cnt, &
   omi_no2_col_cnt, omi_so2_col_cnt, tropomi_co_col_cnt, tropomi_o3_col_cnt, &
   tropomi_no2_col_cnt, tropomi_so2_col_cnt, tempo_o3_col_cnt, tempo_no2_col_cnt
!
   integer :: icnt,iprs,jprs,kstr
   real :: correction,prs_mid_up,prs_mid_dw  
   integer,allocatable,dimension(:) :: mopitt_bin_cnt
   real,allocatable,dimension(:,:) :: mopitt_bin_obs_val,mopitt_bin_err_var, &
   mopitt_bin_prior_mn,mopitt_bin_prior_sd
!
! AIRNOW CO
   real, dimension(maxnobs) :: &
   airnow_co_obs_val, airnow_co_prior_mean, airnow_co_post_mean, airnow_co_prior_sprd, &
   airnow_co_post_sprd, airnow_co_x, airnow_co_y, airnow_co_z, airnow_co_dart_qc, &
   airnow_co_err_var, airnow_co_day, airnow_co_sec
!
! AIRNOW 03
   real, dimension(maxnobs) :: &
   airnow_o3_obs_val, airnow_o3_prior_mean, airnow_o3_post_mean, airnow_o3_prior_sprd, &
   airnow_o3_post_sprd, airnow_o3_x, airnow_o3_y, airnow_o3_z, airnow_o3_dart_qc, &
   airnow_o3_err_var, airnow_o3_day, airnow_o3_sec
!
! AIRNOW NO2
   real, dimension(maxnobs) :: &
   airnow_no2_obs_val, airnow_no2_prior_mean, airnow_no2_post_mean, airnow_no2_prior_sprd, &
   airnow_no2_post_sprd, airnow_no2_x, airnow_no2_y, airnow_no2_z, airnow_no2_dart_qc, &
   airnow_no2_err_var, airnow_no2_day, airnow_no2_sec
!
! AIRNOW SO2
   real, dimension(maxnobs) :: &
   airnow_so2_obs_val, airnow_so2_prior_mean, airnow_so2_post_mean, airnow_so2_prior_sprd, &
   airnow_so2_post_sprd, airnow_so2_x, airnow_so2_y, airnow_so2_z, airnow_so2_dart_qc, &
   airnow_so2_err_var, airnow_so2_day, airnow_so2_sec
!
! AIRNOW PM10
   real, dimension(maxnobs) :: &
   airnow_pm10_obs_val, airnow_pm10_prior_mean, airnow_pm10_post_mean, airnow_pm10_prior_sprd, &
   airnow_pm10_post_sprd, airnow_pm10_x, airnow_pm10_y, airnow_pm10_z, airnow_pm10_dart_qc, &
   airnow_pm10_err_var, airnow_pm10_day, airnow_pm10_sec
!
! AIRNOW PM25
   real, dimension(maxnobs) :: &
   airnow_pm25_obs_val, airnow_pm25_prior_mean, airnow_pm25_post_mean, airnow_pm25_prior_sprd, &
   airnow_pm25_post_sprd, airnow_pm25_x, airnow_pm25_y, airnow_pm25_z, airnow_pm25_dart_qc, &
   airnow_pm25_err_var, airnow_pm25_day, airnow_pm25_sec
!
! MODIS AOD
   real, dimension(maxnobs) :: &
   modis_aod_obs_val, modis_aod_prior_mean, modis_aod_post_mean, modis_aod_prior_sprd, &
   modis_aod_post_sprd, modis_aod_x, modis_aod_y, modis_aod_z, modis_aod_dart_qc, &
   modis_aod_err_var, modis_aod_day, modis_aod_sec
!
! MOPITT CO PRF
   real, dimension(maxnobs) :: &
   mopitt_co_prf_obs_val, mopitt_co_prf_prior_mean, mopitt_co_prf_post_mean, mopitt_co_prf_prior_sprd, &
   mopitt_co_prf_post_sprd, mopitt_co_prf_x, mopitt_co_prf_y, mopitt_co_prf_z, mopitt_co_prf_dart_qc, &
   mopitt_co_prf_psfc, mopitt_co_prf_prior, mopitt_co_prf_err_var, mopitt_co_prf_day, mopitt_co_prf_sec
   integer, dimension(maxnobs) :: mopitt_co_prf_npr
   real, dimension(maxnobs,mopitt_co_ndim) :: mopitt_co_prf_prs, mopitt_co_prf_avgk
!
! IASI CO PRF
   real, dimension(maxnobs) :: &
   iasi_co_prf_obs_val, iasi_co_prf_prior_mean, iasi_co_prf_post_mean, iasi_co_prf_prior_sprd, &
   iasi_co_prf_post_sprd, iasi_co_prf_x, iasi_co_prf_y, iasi_co_prf_z, iasi_co_prf_dart_qc, &
   iasi_co_prf_psfc, iasi_co_prf_prior, iasi_co_prf_err_var,iasi_co_prf_day, iasi_co_prf_sec
   integer, dimension(maxnobs) :: iasi_co_prf_npr
   real, dimension(maxnobs,iasi_co_ndim) :: iasi_co_prf_prs, iasi_co_prf_avgk
!
! IASI O3 PRF
   real, dimension(maxnobs) :: &
   iasi_o3_prf_obs_val, iasi_o3_prf_prior_mean, iasi_o3_prf_post_mean, iasi_o3_prf_prior_sprd, &
   iasi_o3_prf_post_sprd, iasi_o3_prf_x, iasi_o3_prf_y, iasi_o3_prf_z, iasi_o3_prf_dart_qc, &
   iasi_o3_prf_prior, iasi_o3_prf_err_var,iasi_o3_prf_day, iasi_o3_prf_sec
   integer, dimension(maxnobs) :: iasi_o3_prf_npr
   real, dimension(maxnobs,iasi_o3_ndim) :: iasi_o3_prf_prs, iasi_o3_prf_avgk, iasi_o3_prf_hgt
!
! OMI O3 COL
   real, dimension(maxnobs) :: &
   omi_o3_col_obs_val, omi_o3_col_prior_mean, omi_o3_col_post_mean, omi_o3_col_prior_sprd, &
   omi_o3_col_post_sprd, omi_o3_col_x, omi_o3_col_y, omi_o3_col_z, omi_o3_col_dart_qc, &
   omi_o3_col_err_var,omi_o3_col_day, omi_o3_col_sec
   integer, dimension(maxnobs) :: omi_o3_col_npr, omi_o3_col_npr_mdl
   real, dimension(maxnobs,omi_o3_ndim) :: omi_o3_col_prs, omi_o3_col_avgk, omi_o3_col_prior
!
! OMI NO2 COL
   real, dimension(maxnobs) :: &
   omi_no2_col_obs_val, omi_no2_col_prior_mean, omi_no2_col_post_mean, omi_no2_col_prior_sprd, &
   omi_no2_col_post_sprd, omi_no2_col_x, omi_no2_col_y, omi_no2_col_z, omi_no2_col_dart_qc, &
   omi_no2_col_err_var,omi_no2_col_day, omi_no2_col_sec
   integer, dimension(maxnobs) :: omi_no2_col_npr, omi_no2_col_npr_mdl
   real,dimension(maxnobs,omi_no2_ndim) :: omi_no2_col_prs, omi_no2_col_scwt
!
! OMI SO2 COL
   real, dimension(maxnobs) :: &
   omi_so2_col_obs_val, omi_so2_col_prior_mean, omi_so2_col_post_mean, omi_so2_col_prior_sprd, &
   omi_so2_col_post_sprd, omi_so2_col_x, omi_so2_col_y, omi_so2_col_z, omi_so2_col_dart_qc, &
   omi_so2_col_err_var,omi_so2_col_day, omi_so2_col_sec
   integer, dimension(maxnobs) :: omi_so2_col_npr, omi_so2_col_npr_mdl
   real, dimension(maxnobs,omi_so2_ndim) :: omi_so2_col_prs, omi_so2_col_scwt
!
! TROPOMI CO COL
   real, dimension(maxnobs) :: &
   tropomi_co_col_obs_val, tropomi_co_col_prior_mean, tropomi_co_col_post_mean, tropomi_co_col_prior_sprd, &
   tropomi_co_col_post_sprd, tropomi_co_col_x, tropomi_co_col_y, tropomi_co_col_z, tropomi_co_col_dart_qc, &
   tropomi_co_col_err_var,tropomi_co_col_day, tropomi_co_col_sec
   integer, dimension(maxnobs) :: tropomi_co_col_npr, tropomi_co_col_npr_mdl
   real, dimension(maxnobs,tropomi_co_ndim) :: tropomi_co_col_prs, tropomi_co_col_avgk
!
! TROPOMI O3 COL
   real, dimension(maxnobs) :: &
   tropomi_o3_col_obs_val, tropomi_o3_col_prior_mean, tropomi_o3_col_post_mean, tropomi_o3_col_prior_sprd, &
   tropomi_o3_col_post_sprd, tropomi_o3_col_x, tropomi_o3_col_y, tropomi_o3_col_z, tropomi_o3_col_dart_qc, &
   tropomi_o3_col_err_var,tropomi_o3_col_day, tropomi_o3_col_sec
   integer, dimension(maxnobs) :: tropomi_o3_col_npr, tropomi_o3_col_npr_mdl
   real, dimension(maxnobs,tropomi_o3_ndim) :: tropomi_o3_col_prs, tropomi_o3_col_avgk, &
   tropomi_o3_col_prior
!
! TROPOMI NO2 COL
   real, dimension(maxnobs) :: &
   tropomi_no2_col_obs_val, tropomi_no2_col_prior_mean, tropomi_no2_col_post_mean, tropomi_no2_col_prior_sprd, &
   tropomi_no2_col_post_sprd, tropomi_no2_col_x, tropomi_no2_col_y, tropomi_no2_col_z, tropomi_no2_col_dart_qc, &
   tropomi_no2_col_amf, tropomi_no2_col_err_var,tropomi_no2_col_day, tropomi_no2_col_sec
   integer, dimension(maxnobs) :: tropomi_no2_col_npr, tropomi_no2_col_npr_mdl
   real, dimension(maxnobs,tropomi_no2_ndim) :: tropomi_no2_col_prs, tropomi_no2_col_avgk
!
! TROPOMI SO2 COL
   real, dimension(maxnobs) :: &
   tropomi_so2_col_obs_val, tropomi_so2_col_prior_mean, tropomi_so2_col_post_mean, tropomi_so2_col_prior_sprd, &
   tropomi_so2_col_post_sprd, tropomi_so2_col_x, tropomi_so2_col_y, tropomi_so2_col_z, tropomi_so2_col_dart_qc, &
   tropomi_so2_col_amf, tropomi_so2_col_err_var,tropomi_so2_col_day, tropomi_so2_col_sec
   integer, dimension(maxnobs) :: tropomi_so2_col_npr, tropomi_so2_col_npr_mdl
   real, dimension(maxnobs,tropomi_so2_ndim) :: tropomi_so2_col_prs, tropomi_so2_col_avgk, tropomi_so2_col_prior
!
! TEMPO O3 COL
   real, dimension(maxnobs) :: &
   tempo_o3_col_obs_val, tempo_o3_col_prior_mean, tempo_o3_col_post_mean, tempo_o3_col_prior_sprd, &
   tempo_o3_col_post_sprd, tempo_o3_col_x, tempo_o3_col_y, tempo_o3_col_z, tempo_o3_col_dart_qc, &
   tempo_o3_col_err_var,tempo_o3_col_day, tempo_o3_col_sec
   integer, dimension(maxnobs) :: tempo_o3_col_npr, tempo_o3_col_npr_mdl
   real, dimension(maxnobs,tempo_o3_ndim) :: tempo_o3_col_prs, tempo_o3_col_avgk, tempo_o3_col_prior
!
! TEMPO NO2 COL
   real, dimension(maxnobs) :: &
   tempo_no2_col_obs_val, tempo_no2_col_prior_mean, tempo_no2_col_post_mean, tempo_no2_col_prior_sprd, &
   tempo_no2_col_post_sprd, tempo_no2_col_x, tempo_no2_col_y, tempo_no2_col_z, tempo_no2_col_dart_qc, &
   tempo_no2_col_amf, tempo_no2_col_err_var,tempo_no2_col_day, tempo_no2_col_sec
   integer, dimension(maxnobs) :: tempo_no2_col_npr, tempo_no2_col_npr_mdl
!
   integer ::  nobs
   real,allocatable,dimension(:) :: corrections_old
   real, dimension(maxnobs,tempo_no2_ndim) :: tempo_no2_col_prs, tempo_no2_col_scwt
!
   character(len=150) :: path_filein, file_in, correction_filename
   character(len=150), dimension(maxkinds) :: obs_list 
!
   logical :: does_file_exist
   namelist /bias_correct_nml/path_filein,does_file_exist,correction_filename,nobs,obs_list
!
   open(unit=10,file='bias_correct_nml',form='formatted', &
   status='old',action='read')
   read(10,bias_correct_nml)
   close(10)
   allocate(corrections_old(nobs))
   corrections_old(:)=0.
!   print *,'does_file_exist     ',does_file_exist
!   print *,'correction filename ',trim(correction_filename)
!   print *,'nobs                ',nobs
!   do icnt=1,nobs
!      print *,'obs kind            ',trim(obs_list(icnt))
!   enddo
!
   open(unit=10,file=trim(correction_filename),form='unformatted', &
   status='unknown',action='READWRITE')
!
   if (does_file_exist) then   
      do icnt=1,nobs
         read(10) corrections_old(icnt)
      enddo
      rewind(10)
   endif
   print *,'corrections_old (before) ',corrections_old(1:nobs)
!
   file_in=trim(path_filein)//'/obs_seq.final'
   print *, 'filein ',trim(file_in)
!
! Initialize observation variable vectors
! AIRNOW CO
   airnow_co_obs_val(:)=missing
   airnow_co_prior_mean(:)=missing
   airnow_co_post_mean(:)=missing
   airnow_co_prior_sprd(:)=missing
   airnow_co_post_sprd(:)=missing
   airnow_co_x(:)=missing
   airnow_co_y(:)=missing
   airnow_co_z(:)=missing
   airnow_co_dart_qc(:)=missing
   airnow_co_err_var(:)=missing
   airnow_co_day(:)=missing
   airnow_co_sec(:)=missing
! AIRNOW O3
   airnow_o3_obs_val(:)=missing
   airnow_o3_prior_mean(:)=missing
   airnow_o3_post_mean(:)=missing
   airnow_o3_prior_sprd(:)=missing
   airnow_o3_post_sprd(:)=missing
   airnow_o3_x(:)=missing
   airnow_o3_y(:)=missing
   airnow_o3_z(:)=missing
   airnow_o3_dart_qc(:)=missing
   airnow_o3_err_var(:)=missing
   airnow_o3_day(:)=missing
   airnow_o3_sec(:)=missing
! AIRNOW NO2
   airnow_no2_obs_val(:)=missing
   airnow_no2_prior_mean(:)=missing
   airnow_no2_post_mean(:)=missing
   airnow_no2_prior_sprd(:)=missing
   airnow_no2_post_sprd(:)=missing
   airnow_no2_x(:)=missing
   airnow_no2_y(:)=missing
   airnow_no2_z(:)=missing
   airnow_no2_dart_qc(:)=missing
   airnow_no2_err_var(:)=missing
   airnow_no2_day(:)=missing
   airnow_no2_sec(:)=missing
! AIRNOW SO2
   airnow_so2_obs_val(:)=missing
   airnow_so2_prior_mean(:)=missing
   airnow_so2_post_mean(:)=missing
   airnow_so2_prior_sprd(:)=missing
   airnow_so2_post_sprd(:)=missing
   airnow_so2_x(:)=missing
   airnow_so2_y(:)=missing
   airnow_so2_z(:)=missing
   airnow_so2_dart_qc(:)=missing
   airnow_so2_err_var(:)=missing
   airnow_so2_day(:)=missing
   airnow_so2_sec(:)=missing
! AIRNOW PM10
   airnow_pm10_obs_val(:)=missing
   airnow_pm10_prior_mean(:)=missing
   airnow_pm10_post_mean(:)=missing
   airnow_pm10_prior_sprd(:)=missing
   airnow_pm10_post_sprd(:)=missing
   airnow_pm10_x(:)=missing
   airnow_pm10_y(:)=missing
   airnow_pm10_z(:)=missing
   airnow_pm10_dart_qc(:)=missing
   airnow_pm10_err_var(:)=missing
   airnow_pm10_day(:)=missing
   airnow_pm10_sec(:)=missing
! AIRNOW PM25
   airnow_pm25_obs_val(:)=missing
   airnow_pm25_prior_mean(:)=missing
   airnow_pm25_post_mean(:)=missing
   airnow_pm25_prior_sprd(:)=missing
   airnow_pm25_post_sprd(:)=missing
   airnow_pm25_x(:)=missing
   airnow_pm25_y(:)=missing
   airnow_pm25_z(:)=missing
   airnow_pm25_dart_qc(:)=missing
   airnow_pm25_err_var(:)=missing
   airnow_pm25_day(:)=missing
   airnow_pm25_sec(:)=missing
! MODIS AOD
   modis_aod_obs_val(:)=missing
   modis_aod_prior_mean(:)=missing
   modis_aod_post_mean(:)=missing
   modis_aod_prior_sprd(:)=missing
   modis_aod_post_sprd(:)=missing
   modis_aod_x(:)=missing
   modis_aod_y(:)=missing
   modis_aod_z(:)=missing
   modis_aod_dart_qc(:)=missing
   modis_aod_err_var(:)=missing
   modis_aod_day(:)=missing
   modis_aod_sec(:)=missing
! MOPITT CO PRF
   mopitt_co_prf_obs_val(:)=missing
   mopitt_co_prf_prior_mean(:)=missing
   mopitt_co_prf_post_mean(:)=missing
   mopitt_co_prf_prior_sprd(:)=missing
   mopitt_co_prf_post_sprd(:)=missing
   mopitt_co_prf_x(:)=missing
   mopitt_co_prf_y(:)=missing
   mopitt_co_prf_z(:)=missing
   mopitt_co_prf_dart_qc(:)=missing
   mopitt_co_prf_err_var(:)=missing
   mopitt_co_prf_day(:)=missing
   mopitt_co_prf_sec(:)=missing
   mopitt_co_prf_npr(:)=int(missing)
   mopitt_co_prf_prs(:,:)=missing
   mopitt_co_prf_avgk(:,:)=missing
! IASI CO PRF
   iasi_co_prf_obs_val(:)=missing
   iasi_co_prf_prior_mean(:)=missing
   iasi_co_prf_post_mean(:)=missing
   iasi_co_prf_prior_sprd(:)=missing
   iasi_co_prf_post_sprd(:)=missing
   iasi_co_prf_x(:)=missing
   iasi_co_prf_y(:)=missing
   iasi_co_prf_z(:)=missing
   iasi_co_prf_dart_qc(:)=missing
   iasi_co_prf_err_var(:)=missing
   iasi_co_prf_day(:)=missing
   iasi_co_prf_sec(:)=missing
   iasi_co_prf_npr(:)=int(missing)
   iasi_co_prf_prs(:,:)=missing
   iasi_co_prf_avgk(:,:)=missing
! IASI O3 PRF
   iasi_o3_prf_obs_val(:)=missing
   iasi_o3_prf_prior_mean(:)=missing
   iasi_o3_prf_post_mean(:)=missing
   iasi_o3_prf_prior_sprd(:)=missing
   iasi_o3_prf_post_sprd(:)=missing
   iasi_o3_prf_x(:)=missing
   iasi_o3_prf_y(:)=missing
   iasi_o3_prf_z(:)=missing
   iasi_o3_prf_dart_qc(:)=missing
   iasi_o3_prf_err_var(:)=missing
   iasi_o3_prf_day(:)=missing
   iasi_o3_prf_sec(:)=missing
   iasi_o3_prf_npr(:)=int(missing)
   iasi_o3_prf_prs(:,:)=missing
   iasi_o3_prf_avgk(:,:)=missing
   iasi_o3_prf_hgt(:,:)=missing
! OMI O3 COL
   omi_o3_col_obs_val(:)=missing
   omi_o3_col_prior_mean(:)=missing
   omi_o3_col_post_mean(:)=missing
   omi_o3_col_prior_sprd(:)=missing
   omi_o3_col_post_sprd(:)=missing
   omi_o3_col_x(:)=missing
   omi_o3_col_y(:)=missing
   omi_o3_col_z(:)=missing
   omi_o3_col_dart_qc(:)=missing
   omi_o3_col_err_var(:)=missing
   omi_o3_col_day(:)=missing
   omi_o3_col_sec(:)=missing
   omi_o3_col_npr(:)=int(missing)
   omi_o3_col_npr_mdl(:)=int(missing)
   omi_o3_col_prs(:,:)=missing
   omi_o3_col_avgk(:,:)=missing
   omi_o3_col_prior(:,:)=missing
! OMI NO2 COL
   omi_no2_col_obs_val(:)=missing
   omi_no2_col_prior_mean(:)=missing
   omi_no2_col_post_mean(:)=missing
   omi_no2_col_prior_sprd(:)=missing
   omi_no2_col_post_sprd(:)=missing
   omi_no2_col_x(:)=missing
   omi_no2_col_y(:)=missing
   omi_no2_col_z(:)=missing
   omi_no2_col_dart_qc(:)=missing
   omi_no2_col_err_var(:)=missing
   omi_no2_col_day(:)=missing
   omi_no2_col_sec(:)=missing
   omi_no2_col_npr(:)=int(missing)
   omi_no2_col_npr_mdl(:)=int(missing)
   omi_no2_col_prs(:,:)=missing
   omi_no2_col_scwt(:,:)=missing
! OMI SO2 COL
   omi_so2_col_obs_val(:)=missing
   omi_so2_col_prior_mean(:)=missing
   omi_so2_col_post_mean(:)=missing
   omi_so2_col_prior_sprd(:)=missing
   omi_so2_col_post_sprd(:)=missing
   omi_so2_col_x(:)=missing
   omi_so2_col_y(:)=missing
   omi_so2_col_z(:)=missing
   omi_so2_col_dart_qc(:)=missing
   omi_so2_col_err_var(:)=missing
   omi_so2_col_day(:)=missing
   omi_so2_col_sec(:)=missing
   omi_so2_col_npr(:)=int(missing)
   omi_so2_col_npr_mdl(:)=int(missing)
   omi_so2_col_prs(:,:)=missing
   omi_so2_col_scwt(:,:)=missing
! TROPOMI CO COL
   tropomi_co_col_obs_val(:)=missing
   tropomi_co_col_prior_mean(:)=missing
   tropomi_co_col_post_mean(:)=missing
   tropomi_co_col_prior_sprd(:)=missing
   tropomi_co_col_post_sprd(:)=missing
   tropomi_co_col_x(:)=missing
   tropomi_co_col_y(:)=missing
   tropomi_co_col_z(:)=missing
   tropomi_co_col_dart_qc(:)=missing
   tropomi_co_col_err_var(:)=missing
   tropomi_co_col_day(:)=missing
   tropomi_co_col_sec(:)=missing
   tropomi_co_col_npr(:)=int(missing)
   tropomi_co_col_npr_mdl(:)=int(missing)
   tropomi_co_col_prs(:,:)=missing
   tropomi_co_col_avgk(:,:)=missing
! TROPOMI O3 COL
   tropomi_o3_col_obs_val(:)=missing
   tropomi_o3_col_prior_mean(:)=missing
   tropomi_o3_col_post_mean(:)=missing
   tropomi_o3_col_prior_sprd(:)=missing
   tropomi_o3_col_post_sprd(:)=missing
   tropomi_o3_col_x(:)=missing
   tropomi_o3_col_y(:)=missing
   tropomi_o3_col_z(:)=missing
   tropomi_o3_col_dart_qc(:)=missing
   tropomi_o3_col_err_var(:)=missing
   tropomi_o3_col_day(:)=missing
   tropomi_o3_col_sec(:)=missing
   tropomi_o3_col_npr(:)=int(missing)
   tropomi_o3_col_npr_mdl(:)=int(missing)
   tropomi_o3_col_prs(:,:)=missing
   tropomi_o3_col_avgk(:,:)=missing
   tropomi_o3_col_prior(:,:)=missing
! TROPOMI NO2 COL
   tropomi_no2_col_obs_val(:)=missing
   tropomi_no2_col_prior_mean(:)=missing
   tropomi_no2_col_post_mean(:)=missing
   tropomi_no2_col_prior_sprd(:)=missing
   tropomi_no2_col_post_sprd(:)=missing
   tropomi_no2_col_x(:)=missing
   tropomi_no2_col_y(:)=missing
   tropomi_no2_col_z(:)=missing
   tropomi_no2_col_dart_qc(:)=missing
   tropomi_no2_col_amf(:)=missing
   tropomi_no2_col_err_var(:)=missing
   tropomi_no2_col_day(:)=missing
   tropomi_no2_col_sec(:)=missing
   tropomi_no2_col_npr(:)=int(missing)
   tropomi_no2_col_npr_mdl(:)=int(missing)
   tropomi_no2_col_prs(:,:)=missing
   tropomi_no2_col_avgk(:,:)=missing
! TROPOMI SO2 COL
   tropomi_so2_col_obs_val(:)=missing
   tropomi_so2_col_prior_mean(:)=missing
   tropomi_so2_col_post_mean(:)=missing
   tropomi_so2_col_prior_sprd(:)=missing
   tropomi_so2_col_post_sprd(:)=missing
   tropomi_so2_col_x(:)=missing
   tropomi_so2_col_y(:)=missing
   tropomi_so2_col_z(:)=missing
   tropomi_so2_col_dart_qc(:)=missing
   tropomi_so2_col_amf(:)=missing
   tropomi_so2_col_err_var(:)=missing
   tropomi_so2_col_day(:)=missing
   tropomi_so2_col_sec(:)=missing
   tropomi_so2_col_npr(:)=int(missing)
   tropomi_so2_col_npr_mdl(:)=int(missing)
   tropomi_so2_col_prs(:,:)=missing
   tropomi_so2_col_avgk(:,:)=missing
   tropomi_so2_col_prior(:,:)=missing
! TEMPO O3 COL
   tempo_o3_col_obs_val(:)=missing
   tempo_o3_col_prior_mean(:)=missing
   tempo_o3_col_post_mean(:)=missing
   tempo_o3_col_prior_sprd(:)=missing
   tempo_o3_col_post_sprd(:)=missing
   tempo_o3_col_x(:)=missing
   tempo_o3_col_y(:)=missing
   tempo_o3_col_z(:)=missing
   tempo_o3_col_dart_qc(:)=missing
   tempo_o3_col_err_var(:)=missing
   tempo_o3_col_day(:)=missing
   tempo_o3_col_sec(:)=missing
   tempo_o3_col_npr(:)=int(missing)
   tempo_o3_col_npr_mdl(:)=int(missing)
   tempo_o3_col_prs(:,:)=missing
   tempo_o3_col_avgk(:,:)=missing
   tempo_o3_col_prior(:,:)=missing
! TEMPO NO2 COL
   tempo_no2_col_obs_val(:)=missing
   tempo_no2_col_prior_mean(:)=missing
   tempo_no2_col_post_mean(:)=missing
   tempo_no2_col_prior_sprd(:)=missing
   tempo_no2_col_post_sprd(:)=missing
   tempo_no2_col_x(:)=missing
   tempo_no2_col_y(:)=missing
   tempo_no2_col_z(:)=missing
   tempo_no2_col_dart_qc(:)=missing
   tempo_no2_col_err_var(:)=missing
   tempo_no2_col_day(:)=missing
   tempo_no2_col_sec(:)=missing
   tempo_no2_col_npr(:)=int(missing)
   tempo_no2_col_npr_mdl(:)=int(missing)
   tempo_no2_col_prs(:,:)=missing
   tempo_no2_col_scwt(:,:)=missing
!
   call  get_obs_seq_ens_data(file_in,num_mem,maxnobs,missing,mopitt_co_prf_cnt,iasi_co_prf_cnt, &
   iasi_co_col_cnt,iasi_o3_prf_cnt,modis_aod_cnt,omi_o3_col_cnt,omi_no2_col_cnt, &
   omi_so2_col_cnt,tropomi_co_col_cnt,tropomi_o3_col_cnt,tropomi_no2_col_cnt, &
   tropomi_so2_col_cnt,tempo_o3_col_cnt,tempo_no2_col_cnt,airnow_co_cnt,airnow_o3_cnt, &
   airnow_no2_cnt,airnow_so2_cnt,airnow_pm10_cnt,airnow_pm25_cnt,mopitt_co_ndim, &
   iasi_co_ndim,iasi_o3_ndim,omi_o3_ndim,omi_no2_ndim,omi_so2_ndim,tropomi_co_ndim, &
   tropomi_o3_ndim,tropomi_no2_ndim,tropomi_so2_ndim,tempo_o3_ndim,tempo_no2_ndim,mopitt_prs, &
! AIRNOW CO
   airnow_co_obs_val, airnow_co_prior_mean, airnow_co_post_mean, airnow_co_prior_sprd, &
   airnow_co_post_sprd, airnow_co_x, airnow_co_y, airnow_co_z, airnow_co_dart_qc, &
   airnow_co_err_var, airnow_co_day, airnow_co_sec, &
! AIRNOW 03
   airnow_o3_obs_val, airnow_o3_prior_mean, airnow_o3_post_mean, airnow_o3_prior_sprd, &
   airnow_o3_post_sprd, airnow_o3_x, airnow_o3_y, airnow_o3_z, airnow_o3_dart_qc, &
   airnow_o3_err_var, airnow_o3_day, airnow_o3_sec, &
! AIRNOW NO2
   airnow_no2_obs_val, airnow_no2_prior_mean, airnow_no2_post_mean, airnow_no2_prior_sprd, &
   airnow_no2_post_sprd, airnow_no2_x, airnow_no2_y, airnow_no2_z, airnow_no2_dart_qc, &
   airnow_no2_err_var, airnow_no2_day, airnow_no2_sec, &
! AIRNOW SO2
   airnow_so2_obs_val, airnow_so2_prior_mean, airnow_so2_post_mean, airnow_so2_prior_sprd, &
   airnow_so2_post_sprd, airnow_so2_x, airnow_so2_y, airnow_so2_z, airnow_so2_dart_qc, &
   airnow_so2_err_var, airnow_so2_day, airnow_so2_sec, &
! AIRNOW PM10
   airnow_pm10_obs_val, airnow_pm10_prior_mean, airnow_pm10_post_mean, airnow_pm10_prior_sprd, &
   airnow_pm10_post_sprd, airnow_pm10_x, airnow_pm10_y, airnow_pm10_z, airnow_pm10_dart_qc, &
   airnow_pm10_err_var, airnow_pm10_day, airnow_pm10_sec, &
! AIRNOW PM25
   airnow_pm25_obs_val, airnow_pm25_prior_mean, airnow_pm25_post_mean, airnow_pm25_prior_sprd, &
   airnow_pm25_post_sprd, airnow_pm25_x, airnow_pm25_y, airnow_pm25_z, airnow_pm25_dart_qc, &
   airnow_pm25_err_var, airnow_pm25_day, airnow_pm25_sec, &
! MODIS AOD
   modis_aod_obs_val, modis_aod_prior_mean, modis_aod_post_mean, modis_aod_prior_sprd, &
   modis_aod_post_sprd, modis_aod_x, modis_aod_y, modis_aod_z, modis_aod_dart_qc, &
   modis_aod_err_var, modis_aod_day, modis_aod_sec, &
! MOPITT CO PRF
   mopitt_co_prf_obs_val, mopitt_co_prf_prior_mean, mopitt_co_prf_post_mean, mopitt_co_prf_prior_sprd, &
   mopitt_co_prf_post_sprd, mopitt_co_prf_x, mopitt_co_prf_y, mopitt_co_prf_z, mopitt_co_prf_dart_qc, &
   mopitt_co_prf_psfc, mopitt_co_prf_prior, mopitt_co_prf_err_var, mopitt_co_prf_day, mopitt_co_prf_sec, &
   mopitt_co_prf_prs, mopitt_co_prf_avgk, mopitt_co_prf_npr, &
! IASI CO PRF
   iasi_co_prf_obs_val, iasi_co_prf_prior_mean, iasi_co_prf_post_mean, iasi_co_prf_prior_sprd, &
   iasi_co_prf_post_sprd, iasi_co_prf_x, iasi_co_prf_y, iasi_co_prf_z, iasi_co_prf_dart_qc, &
   iasi_co_prf_psfc, iasi_co_prf_prior, iasi_co_prf_err_var,iasi_co_prf_day, iasi_co_prf_sec, &
   iasi_co_prf_prs, iasi_co_prf_avgk, iasi_co_prf_npr, &
! IASI O3 PRF
   iasi_o3_prf_obs_val, iasi_o3_prf_prior_mean, iasi_o3_prf_post_mean, iasi_o3_prf_prior_sprd, &
   iasi_o3_prf_post_sprd, iasi_o3_prf_x, iasi_o3_prf_y, iasi_o3_prf_z, iasi_o3_prf_dart_qc, &
   iasi_o3_prf_prior, iasi_o3_prf_err_var,iasi_o3_prf_day, iasi_o3_prf_sec, &
   iasi_o3_prf_prs, iasi_o3_prf_avgk, iasi_o3_prf_hgt, iasi_o3_prf_npr, &
! OMI O3 COL
   omi_o3_col_obs_val, omi_o3_col_prior_mean, omi_o3_col_post_mean, omi_o3_col_prior_sprd, &
   omi_o3_col_post_sprd, omi_o3_col_x, omi_o3_col_y, omi_o3_col_z, omi_o3_col_dart_qc, &
   omi_o3_col_err_var,omi_o3_col_day, omi_o3_col_sec, omi_o3_col_prs, omi_o3_col_avgk, &
   omi_o3_col_prior, omi_o3_col_npr, omi_o3_col_npr_mdl, &
! OMI NO2 COL
   omi_no2_col_obs_val, omi_no2_col_prior_mean, omi_no2_col_post_mean, omi_no2_col_prior_sprd, &
   omi_no2_col_post_sprd, omi_no2_col_x, omi_no2_col_y, omi_no2_col_z, omi_no2_col_dart_qc, &
   omi_no2_col_err_var,omi_no2_col_day, omi_no2_col_sec, omi_no2_col_prs, omi_no2_col_scwt, &
   omi_no2_col_npr, omi_no2_col_npr_mdl, &
! OMI SO2 COL
   omi_so2_col_obs_val, omi_so2_col_prior_mean, omi_so2_col_post_mean, omi_so2_col_prior_sprd, &
   omi_so2_col_post_sprd, omi_so2_col_x, omi_so2_col_y, omi_so2_col_z, omi_so2_col_dart_qc, &
   omi_so2_col_err_var,omi_so2_col_day, omi_so2_col_sec, omi_so2_col_prs, omi_so2_col_scwt, &
   omi_so2_col_npr, omi_so2_col_npr_mdl, &
! TROPOMI CO COL
   tropomi_co_col_obs_val, tropomi_co_col_prior_mean, tropomi_co_col_post_mean, tropomi_co_col_prior_sprd, &
   tropomi_co_col_post_sprd, tropomi_co_col_x, tropomi_co_col_y, tropomi_co_col_z, tropomi_co_col_dart_qc, &
   tropomi_co_col_err_var,tropomi_co_col_day, tropomi_co_col_sec, tropomi_co_col_prs, tropomi_co_col_avgk, &
! TROPOMI O3 COL
   tropomi_o3_col_obs_val, tropomi_o3_col_prior_mean, tropomi_o3_col_post_mean, tropomi_o3_col_prior_sprd, &
   tropomi_o3_col_post_sprd, tropomi_o3_col_x, tropomi_o3_col_y, tropomi_o3_col_z, tropomi_o3_col_dart_qc, &
   tropomi_o3_col_err_var,tropomi_o3_col_day, tropomi_o3_col_sec, tropomi_o3_col_prs, tropomi_o3_col_avgk, &
   tropomi_o3_col_prior, tropomi_co_col_npr, tropomi_co_col_npr_mdl, &
! TROPOMI NO2 COL
   tropomi_no2_col_obs_val, tropomi_no2_col_prior_mean, tropomi_no2_col_post_mean, tropomi_no2_col_prior_sprd, &
   tropomi_no2_col_post_sprd, tropomi_no2_col_x, tropomi_no2_col_y, tropomi_no2_col_z, tropomi_no2_col_dart_qc, &
   tropomi_no2_col_amf, tropomi_no2_col_err_var,tropomi_no2_col_day, tropomi_no2_col_sec, tropomi_no2_col_prs, &
   tropomi_no2_col_avgk, tropomi_no2_col_npr, tropomi_no2_col_npr_mdl, &
! TROPOMI SO2 COL
   tropomi_so2_col_obs_val, tropomi_so2_col_prior_mean, tropomi_so2_col_post_mean, tropomi_so2_col_prior_sprd, &
   tropomi_so2_col_post_sprd, tropomi_so2_col_x, tropomi_so2_col_y, tropomi_so2_col_z, tropomi_so2_col_dart_qc, &
   tropomi_so2_col_amf, tropomi_so2_col_err_var,tropomi_so2_col_day, tropomi_so2_col_sec, tropomi_so2_col_prs, &
   tropomi_so2_col_avgk, tropomi_so2_col_prior, tropomi_so2_col_npr, tropomi_so2_col_npr_mdl, &
! TEMPO O3 COL
   tempo_o3_col_obs_val, tempo_o3_col_prior_mean, tempo_o3_col_post_mean, tempo_o3_col_prior_sprd, &
   tempo_o3_col_post_sprd, tempo_o3_col_x, tempo_o3_col_y, tempo_o3_col_z, tempo_o3_col_dart_qc, &
   tempo_o3_col_err_var,tempo_o3_col_day, tempo_o3_col_sec, tempo_o3_col_prs, tempo_o3_col_avgk, &
   tempo_o3_col_prior, tempo_o3_col_npr, tempo_o3_col_npr_mdl, &
! TEMPO NO2 COL
   tempo_no2_col_obs_val, tempo_no2_col_prior_mean, tempo_no2_col_post_mean, tempo_no2_col_prior_sprd, &
   tempo_no2_col_post_sprd, tempo_no2_col_x, tempo_no2_col_y, tempo_no2_col_z, tempo_no2_col_dart_qc, &
   tempo_no2_col_amf, tempo_no2_col_err_var,tempo_no2_col_day, tempo_no2_col_sec, tempo_no2_col_prs, &
   tempo_no2_col_scwt, tempo_no2_col_npr, tempo_no2_col_npr_mdl)
!
! Process obs_seq.final data
!
! Bias correct AIRNOW CO
   if(airnow_co_cnt.gt.0) then
      do icnt=1,nobs
         if (trim(obs_list(icnt)).eq.'AIRNOW_CO') then
            do iprs=1,airnow_co_cnt
               airnow_co_obs_val(iprs)=airnow_co_obs_val(iprs)+corrections_old(icnt)
!               print *, 'iprs, airnow_co_obs_val(iprs), corrections_old ',iprs, airnow_co_obs_val(iprs), corrections_old(icnt)
            enddo
            exit
         endif
      enddo
!
      call bias_correction(maxnobs,airnow_co_cnt,airnow_co_obs_val,airnow_co_err_var, &
      airnow_co_prior_mean,airnow_co_prior_sprd,correction)
      print *, 'APM: AIRNOW CO Bias Correction (current) ',correction
      do icnt=1,nobs
         if (trim(obs_list(icnt)).eq.'AIRNOW_CO') then
            corrections_old(icnt)=corrections_old(icnt)+correction
            exit
         endif
      enddo   
   endif
!
! Bias correct MOPITT CO
   allocate (mopitt_bin_cnt(mopitt_co_ndim))
   allocate (mopitt_bin_obs_val(mopitt_co_ndim,maxnobs))
   allocate (mopitt_bin_err_var(mopitt_co_ndim,maxnobs))
   allocate (mopitt_bin_prior_mn(mopitt_co_ndim,maxnobs))
   allocate (mopitt_bin_prior_sd(mopitt_co_ndim,maxnobs))
   if(mopitt_co_prf_cnt.gt.0) then
      do icnt=1,mopitt_co_prf_cnt
         kstr=mopitt_co_ndim-mopitt_co_prf_npr(icnt)+1
         do jprs=kstr,mopitt_co_ndim
            if (jprs.eq.kstr) then
               prs_mid_up=(mopitt_co_prf_psfc(icnt)/100.+mopitt_prs(jprs))/2.
               if (mopitt_co_prf_z(icnt)/100.ge.prs_mid_up) then
                  mopitt_bin_cnt(jprs)=mopitt_bin_cnt(jprs)+1
                  mopitt_bin_obs_val(jprs,mopitt_bin_cnt(jprs))=mopitt_co_prf_obs_val(icnt)
                  mopitt_bin_err_var(jprs,mopitt_bin_cnt(jprs))=mopitt_co_prf_err_var(icnt)
                  mopitt_bin_prior_mn(jprs,mopitt_bin_cnt(jprs))=mopitt_co_prf_prior_mean(icnt)
                  mopitt_bin_prior_sd(jprs,mopitt_bin_cnt(jprs))=mopitt_co_prf_prior_sprd(icnt)
                  exit
               endif
            elseif (jprs.eq.kstr+1) then
               prs_mid_dw=(mopitt_co_prf_psfc(icnt)/100.+mopitt_prs(jprs-1))/2.
               prs_mid_up=(mopitt_prs(jprs-1)+mopitt_prs(jprs))/2.
               if( mopitt_co_prf_z(icnt)/100..lt. prs_mid_dw .and. &
                  mopitt_co_prf_z(icnt)/100..ge.prs_mid_up) then
                  mopitt_bin_cnt(jprs)=mopitt_bin_cnt(jprs)+1
                  mopitt_bin_obs_val(jprs,mopitt_bin_cnt(jprs))=mopitt_co_prf_obs_val(icnt)
                  mopitt_bin_err_var(jprs,mopitt_bin_cnt(jprs))=mopitt_co_prf_err_var(icnt)
                  mopitt_bin_prior_mn(jprs,mopitt_bin_cnt(jprs))=mopitt_co_prf_prior_mean(icnt)
                  mopitt_bin_prior_sd(jprs,mopitt_bin_cnt(jprs))=mopitt_co_prf_prior_sprd(icnt)
                  exit
               endif 
            elseif (jprs.eq.mopitt_co_ndim) then
               prs_mid_dw=(mopitt_prs(jprs-2)+mopitt_prs(jprs-1))/2.
               if (mopitt_co_prf_z(icnt)/100..lt. prs_mid_dw) then
                  mopitt_bin_cnt(jprs)=mopitt_bin_cnt(jprs)+1
                  mopitt_bin_obs_val(jprs,mopitt_bin_cnt(jprs))=mopitt_co_prf_obs_val(icnt)
                  mopitt_bin_err_var(jprs,mopitt_bin_cnt(jprs))=mopitt_co_prf_err_var(icnt)
                  mopitt_bin_prior_mn(jprs,mopitt_bin_cnt(jprs))=mopitt_co_prf_prior_mean(icnt)
                  mopitt_bin_prior_sd(jprs,mopitt_bin_cnt(jprs))=mopitt_co_prf_prior_sprd(icnt)
                  exit
               endif
            elseif (jprs.le.mopitt_co_ndimm) then
               prs_mid_dw=(mopitt_prs(jprs-2)+mopitt_prs(jprs-1))/2.
               prs_mid_up=(mopitt_prs(jprs-1)+mopitt_prs(jprs))/2.
               if (mopitt_co_prf_z(icnt)/100..lt. prs_mid_dw .and. &
                  mopitt_co_prf_z(icnt)/100..ge.prs_mid_up) then
                  mopitt_bin_cnt(jprs)=mopitt_bin_cnt(jprs)+1
                  mopitt_bin_obs_val(jprs,mopitt_bin_cnt(jprs))=mopitt_co_prf_obs_val(icnt)
                  mopitt_bin_err_var(jprs,mopitt_bin_cnt(jprs))=mopitt_co_prf_err_var(icnt)
                  mopitt_bin_prior_mn(jprs,mopitt_bin_cnt(jprs))=mopitt_co_prf_prior_mean(icnt)
                  mopitt_bin_prior_sd(jprs,mopitt_bin_cnt(jprs))=mopitt_co_prf_prior_sprd(icnt)
                  exit
               endif
            else
               print *, 'APM ERROR: Failed to find MOPITT pressure bin for bias correction '
               stop
            endif
         enddo
      enddo
      do icnt=1,nobs
         if (trim(obs_list(icnt)).eq.'MOPITT_CO_1') then
            do jprs=1,mopitt_bin_cnt(1)
               mopitt_bin_obs_val(1,jprs)=mopitt_bin_obs_val(1,jprs)+ &
               corrections_old(icnt)
            enddo
            exit
         elseif (trim(obs_list(icnt)).eq.'MOPITT_CO_2') then
            do jprs=1,mopitt_bin_cnt(2)
               mopitt_bin_obs_val(2,jprs)=mopitt_bin_obs_val(2,jprs)+ &
               corrections_old(icnt)
            enddo
            exit
         elseif (trim(obs_list(icnt)).eq.'MOPITT_CO_3') then
            do jprs=1,mopitt_bin_cnt(3)
               mopitt_bin_obs_val(3,jprs)=mopitt_bin_obs_val(3,jprs)+ &
               corrections_old(icnt)
            enddo
            exit
         elseif (trim(obs_list(icnt)).eq.'MOPITT_CO_4') then
            do jprs=1,mopitt_bin_cnt(4)
               mopitt_bin_obs_val(4,jprs)=mopitt_bin_obs_val(4,jprs)+ &
               corrections_old(icnt)
            enddo
            exit
         elseif (trim(obs_list(icnt)).eq.'MOPITT_CO_5') then
            do jprs=1,mopitt_bin_cnt(5)
               mopitt_bin_obs_val(5,jprs)=mopitt_bin_obs_val(5,jprs)+ &
               corrections_old(icnt)
            enddo
            exit
         elseif (trim(obs_list(icnt)).eq.'MOPITT_CO_6') then
            do jprs=1,mopitt_bin_cnt(6)
               mopitt_bin_obs_val(6,jprs)=mopitt_bin_obs_val(6,jprs)+ &
               corrections_old(icnt)
            enddo
            exit
         elseif (trim(obs_list(icnt)).eq.'MOPITT_CO_7') then
            do jprs=1,mopitt_bin_cnt(7)
               mopitt_bin_obs_val(7,jprs)=mopitt_bin_obs_val(7,jprs)+ &
               corrections_old(icnt)
            enddo
            exit
         elseif (trim(obs_list(icnt)).eq.'MOPITT_CO_8') then
            do jprs=1,mopitt_bin_cnt(8)
               mopitt_bin_obs_val(8,jprs)=mopitt_bin_obs_val(8,jprs)+ &
               corrections_old(icnt)
            enddo
            exit
         elseif (trim(obs_list(icnt)).eq.'MOPITT_CO_9') then
            do jprs=1,mopitt_bin_cnt(9)
               mopitt_bin_obs_val(9,jprs)=mopitt_bin_obs_val(9,jprs)+ &
               corrections_old(icnt)
            enddo
            exit
         elseif (trim(obs_list(icnt)).eq.'MOPITT_CO_10') then
            do jprs=1,mopitt_bin_cnt(10)
               mopitt_bin_obs_val(10,jprs)=mopitt_bin_obs_val(10,jprs)+ &
               corrections_old(icnt)
            enddo
            exit
         endif
      enddo
      do jprs=1,mopitt_co_ndim
         correction=0.
         if (mopitt_bin_cnt(jprs).ne.0) then
            call bias_correction(maxnobs,mopitt_bin_cnt(jprs),mopitt_bin_obs_val(jprs,:), &
            mopitt_bin_err_var(jprs,:),mopitt_bin_prior_mn(jprs,:),mopitt_bin_prior_sd(jprs,:),correction)
         endif   
         print *, 'APM:MOPITT CO Bias Correction (current) ',correction
         do icnt=1,nobs
            if (trim(obs_list(icnt)).eq.'MOPITT_CO_1' .and. jprs.eq.1) then
               corrections_old(icnt)=corrections_old(icnt)+correction
               exit
            elseif (trim(obs_list(icnt)).eq.'MOPITT_CO_2' .and. jprs.eq.2) then
               corrections_old(icnt)=corrections_old(icnt)+correction
               exit
            elseif (trim(obs_list(icnt)).eq.'MOPITT_CO_3' .and. jprs.eq.3) then
               corrections_old(icnt)=corrections_old(icnt)+correction
               exit
            elseif (trim(obs_list(icnt)).eq.'MOPITT_CO_4' .and. jprs.eq.4) then
               corrections_old(icnt)=corrections_old(icnt)+correction
               exit
            elseif (trim(obs_list(icnt)).eq.'MOPITT_CO_5' .and. jprs.eq.5) then
               corrections_old(icnt)=corrections_old(icnt)+correction
               exit
            elseif (trim(obs_list(icnt)).eq.'MOPITT_CO_6' .and. jprs.eq.6) then
               corrections_old(icnt)=corrections_old(icnt)+correction
               exit
            elseif (trim(obs_list(icnt)).eq.'MOPITT_CO_7' .and. jprs.eq.7) then
               corrections_old(icnt)=corrections_old(icnt)+correction
               exit
            elseif (trim(obs_list(icnt)).eq.'MOPITT_CO_8' .and. jprs.eq.8) then
               corrections_old(icnt)=corrections_old(icnt)+correction
               exit
            elseif (trim(obs_list(icnt)).eq.'MOPITT_CO_9' .and. jprs.eq.9) then
               corrections_old(icnt)=corrections_old(icnt)+correction
               exit
            elseif (trim(obs_list(icnt)).eq.'MOPITT_CO_10' .and. jprs.eq.10) then
               corrections_old(icnt)=corrections_old(icnt)+correction
               exit
            endif
         enddo
      enddo
!
      deallocate (mopitt_bin_cnt)
      deallocate (mopitt_bin_obs_val)
      deallocate (mopitt_bin_err_var)
      deallocate (mopitt_bin_prior_mn)
      deallocate (mopitt_bin_prior_sd)
   endif
!
! Bias correct TROPOMI CO
   if(tropomi_co_col_cnt.gt.0) then
      do icnt=1,nobs
         if (trim(obs_list(icnt)).eq.'TROPOMI_CO_COL') then
            do iprs=1,tropomi_co_col_cnt
               tropomi_co_col_obs_val(iprs)=tropomi_co_col_obs_val(iprs)+corrections_old(icnt)
            enddo
            exit
         endif
      enddo
      call bias_correction(maxnobs,tropomi_co_col_cnt,tropomi_co_col_obs_val,tropomi_co_col_err_var, &
      tropomi_co_col_prior_mean,tropomi_co_col_prior_sprd,correction)
      print *, 'APM:TROPOMI CO Bias Correction (current) ',correction
      do icnt=1,nobs
         if (trim(obs_list(icnt)).eq.'TROPOMI_CO_COL') then
            corrections_old(icnt)=corrections_old(icnt)+correction
            exit
         endif
      enddo   
   endif
!
   rewind(10)   
   do icnt=1,nobs
      write(10) corrections_old(icnt)
   enddo
   close(10)
   print *,'corrections_old (after) ',corrections_old(1:nobs)
   deallocate(corrections_old)
end program main
!
subroutine get_obs_seq_ens_data(file_in,num_mem,maxnobs,missing,mopitt_co_prf_cnt,iasi_co_prf_cnt, &
   iasi_co_col_cnt,iasi_o3_prf_cnt,modis_aod_cnt,omi_o3_col_cnt,omi_no2_col_cnt, &
   omi_so2_col_cnt,tropomi_co_col_cnt,tropomi_o3_col_cnt,tropomi_no2_col_cnt, &
   tropomi_so2_col_cnt,tempo_o3_col_cnt,tempo_no2_col_cnt,airnow_co_cnt,airnow_o3_cnt, &
   airnow_no2_cnt,airnow_so2_cnt,airnow_pm10_cnt,airnow_pm25_cnt,mopitt_co_ndim, &
   iasi_co_ndim,iasi_o3_ndim,omi_o3_ndim,omi_no2_ndim,omi_so2_ndim,tropomi_co_ndim, &
   tropomi_o3_ndim,tropomi_no2_ndim,tropomi_so2_ndim,tempo_o3_ndim,tempo_no2_ndim,mopitt_prs, &
! AIRNOW CO
   airnow_co_obs_val, airnow_co_prior_mean, airnow_co_post_mean, airnow_co_prior_sprd, &
   airnow_co_post_sprd, airnow_co_x, airnow_co_y, airnow_co_z, airnow_co_dart_qc, &
   airnow_co_err_var, airnow_co_day, airnow_co_sec, &
! AIRNOW 03
   airnow_o3_obs_val, airnow_o3_prior_mean, airnow_o3_post_mean, airnow_o3_prior_sprd, &
   airnow_o3_post_sprd, airnow_o3_x, airnow_o3_y, airnow_o3_z, airnow_o3_dart_qc, &
   airnow_o3_err_var, airnow_o3_day, airnow_o3_sec, &
! AIRNOW NO2
   airnow_no2_obs_val, airnow_no2_prior_mean, airnow_no2_post_mean, airnow_no2_prior_sprd, &
   airnow_no2_post_sprd, airnow_no2_x, airnow_no2_y, airnow_no2_z, airnow_no2_dart_qc, &
   airnow_no2_err_var, airnow_no2_day, airnow_no2_sec, &
! AIRNOW SO2
   airnow_so2_obs_val, airnow_so2_prior_mean, airnow_so2_post_mean, airnow_so2_prior_sprd, &
   airnow_so2_post_sprd, airnow_so2_x, airnow_so2_y, airnow_so2_z, airnow_so2_dart_qc, &
   airnow_so2_err_var, airnow_so2_day, airnow_so2_sec, &
! AIRNOW PM10
   airnow_pm10_obs_val, airnow_pm10_prior_mean, airnow_pm10_post_mean, airnow_pm10_prior_sprd, &
   airnow_pm10_post_sprd, airnow_pm10_x, airnow_pm10_y, airnow_pm10_z, airnow_pm10_dart_qc, &
   airnow_pm10_err_var, airnow_pm10_day, airnow_pm10_sec, &
! AIRNOW PM25
   airnow_pm25_obs_val, airnow_pm25_prior_mean, airnow_pm25_post_mean, airnow_pm25_prior_sprd, &
   airnow_pm25_post_sprd, airnow_pm25_x, airnow_pm25_y, airnow_pm25_z, airnow_pm25_dart_qc, &
   airnow_pm25_err_var, airnow_pm25_day, airnow_pm25_sec, &
! MODIS AOD
   modis_aod_obs_val, modis_aod_prior_mean, modis_aod_post_mean, modis_aod_prior_sprd, &
   modis_aod_post_sprd, modis_aod_x, modis_aod_y, modis_aod_z, modis_aod_dart_qc, &
   modis_aod_err_var, modis_aod_day, modis_aod_sec, &
! MOPITT CO PRF
   mopitt_co_prf_obs_val, mopitt_co_prf_prior_mean, mopitt_co_prf_post_mean, mopitt_co_prf_prior_sprd, &
   mopitt_co_prf_post_sprd, mopitt_co_prf_x, mopitt_co_prf_y, mopitt_co_prf_z, mopitt_co_prf_dart_qc, &
   mopitt_co_prf_psfc, mopitt_co_prf_prior, mopitt_co_prf_err_var, mopitt_co_prf_day, mopitt_co_prf_sec, &
   mopitt_co_prf_prs, mopitt_co_prf_avgk, mopitt_co_prf_npr, &
! IASI CO PRF
   iasi_co_prf_obs_val, iasi_co_prf_prior_mean, iasi_co_prf_post_mean, iasi_co_prf_prior_sprd, &
   iasi_co_prf_post_sprd, iasi_co_prf_x, iasi_co_prf_y, iasi_co_prf_z, iasi_co_prf_dart_qc, &
   iasi_co_prf_psfc, iasi_co_prf_prior, iasi_co_prf_err_var,iasi_co_prf_day, iasi_co_prf_sec, &
   iasi_co_prf_prs, iasi_co_prf_avgk, iasi_co_prf_npr, &
! IASI O3 PRF
   iasi_o3_prf_obs_val, iasi_o3_prf_prior_mean, iasi_o3_prf_post_mean, iasi_o3_prf_prior_sprd, &
   iasi_o3_prf_post_sprd, iasi_o3_prf_x, iasi_o3_prf_y, iasi_o3_prf_z, iasi_o3_prf_dart_qc, &
   iasi_o3_prf_prior, iasi_o3_prf_err_var,iasi_o3_prf_day, iasi_o3_prf_sec, &
   iasi_o3_prf_prs, iasi_o3_prf_avgk, iasi_o3_prf_hgt, iasi_o3_prf_npr, &
! OMI O3 COL
   omi_o3_col_obs_val, omi_o3_col_prior_mean, omi_o3_col_post_mean, omi_o3_col_prior_sprd, &
   omi_o3_col_post_sprd, omi_o3_col_x, omi_o3_col_y, omi_o3_col_z, omi_o3_col_dart_qc, &
   omi_o3_col_err_var,omi_o3_col_day, omi_o3_col_sec, omi_o3_col_prs, omi_o3_col_avgk, &
   omi_o3_col_prior, omi_o3_col_npr, omi_o3_col_npr_mdl, &
! OMI NO2 COL
   omi_no2_col_obs_val, omi_no2_col_prior_mean, omi_no2_col_post_mean, omi_no2_col_prior_sprd, &
   omi_no2_col_post_sprd, omi_no2_col_x, omi_no2_col_y, omi_no2_col_z, omi_no2_col_dart_qc, &
   omi_no2_col_err_var,omi_no2_col_day, omi_no2_col_sec, omi_no2_col_prs, omi_no2_col_scwt, &
   omi_no2_col_npr, omi_no2_col_npr_mdl, &
! OMI SO2 COL
   omi_so2_col_obs_val, omi_so2_col_prior_mean, omi_so2_col_post_mean, omi_so2_col_prior_sprd, &
   omi_so2_col_post_sprd, omi_so2_col_x, omi_so2_col_y, omi_so2_col_z, omi_so2_col_dart_qc, &
   omi_so2_col_err_var,omi_so2_col_day, omi_so2_col_sec, omi_so2_col_prs, omi_so2_col_scwt, &
   omi_so2_col_npr, omi_so2_col_npr_mdl, &
! TROPOMI CO COL
   tropomi_co_col_obs_val, tropomi_co_col_prior_mean, tropomi_co_col_post_mean, tropomi_co_col_prior_sprd, &
   tropomi_co_col_post_sprd, tropomi_co_col_x, tropomi_co_col_y, tropomi_co_col_z, tropomi_co_col_dart_qc, &
   tropomi_co_col_err_var,tropomi_co_col_day, tropomi_co_col_sec, tropomi_co_col_prs, tropomi_co_col_avgk, &
! TROPOMI O3 COL
   tropomi_o3_col_obs_val, tropomi_o3_col_prior_mean, tropomi_o3_col_post_mean, tropomi_o3_col_prior_sprd, &
   tropomi_o3_col_post_sprd, tropomi_o3_col_x, tropomi_o3_col_y, tropomi_o3_col_z, tropomi_o3_col_dart_qc, &
   tropomi_o3_col_err_var,tropomi_o3_col_day, tropomi_o3_col_sec, tropomi_o3_col_prs, tropomi_o3_col_avgk, &
   tropomi_o3_col_prior, tropomi_co_col_npr, tropomi_co_col_npr_mdl, &
! TROPOMI NO2 COL
   tropomi_no2_col_obs_val, tropomi_no2_col_prior_mean, tropomi_no2_col_post_mean, tropomi_no2_col_prior_sprd, &
   tropomi_no2_col_post_sprd, tropomi_no2_col_x, tropomi_no2_col_y, tropomi_no2_col_z, tropomi_no2_col_dart_qc, &
   tropomi_no2_col_amf, tropomi_no2_col_err_var,tropomi_no2_col_day, tropomi_no2_col_sec, tropomi_no2_col_prs, &
   tropomi_no2_col_avgk, tropomi_no2_col_npr, tropomi_no2_col_npr_mdl, &
! TROPOMI SO2 COL
   tropomi_so2_col_obs_val, tropomi_so2_col_prior_mean, tropomi_so2_col_post_mean, tropomi_so2_col_prior_sprd, &
   tropomi_so2_col_post_sprd, tropomi_so2_col_x, tropomi_so2_col_y, tropomi_so2_col_z, tropomi_so2_col_dart_qc, &
   tropomi_so2_col_amf, tropomi_so2_col_err_var,tropomi_so2_col_day, tropomi_so2_col_sec, tropomi_so2_col_prs, &
   tropomi_so2_col_avgk, tropomi_so2_col_prior, tropomi_so2_col_npr, tropomi_so2_col_npr_mdl, &
! TEMPO O3 COL
   tempo_o3_col_obs_val, tempo_o3_col_prior_mean, tempo_o3_col_post_mean, tempo_o3_col_prior_sprd, &
   tempo_o3_col_post_sprd, tempo_o3_col_x, tempo_o3_col_y, tempo_o3_col_z, tempo_o3_col_dart_qc, &
   tempo_o3_col_err_var,tempo_o3_col_day, tempo_o3_col_sec, tempo_o3_col_prs, tempo_o3_col_avgk, &
   tempo_o3_col_prior, tempo_o3_col_npr, tempo_o3_col_npr_mdl, &
! TEMPO NO2 COL
   tempo_no2_col_obs_val, tempo_no2_col_prior_mean, tempo_no2_col_post_mean, tempo_no2_col_prior_sprd, &
   tempo_no2_col_post_sprd, tempo_no2_col_x, tempo_no2_col_y, tempo_no2_col_z, tempo_no2_col_dart_qc, &
   tempo_no2_col_amf, tempo_no2_col_err_var,tempo_no2_col_day, tempo_no2_col_sec, tempo_no2_col_prs, &
   tempo_no2_col_scwt, tempo_no2_col_npr, tempo_no2_col_npr_mdl)
!
   implicit none 
!
   integer :: maxnobs,mopitt_co_ndim,iasi_co_ndim,iasi_o3_ndim,omi_o3_ndim,omi_no2_ndim,omi_so2_ndim, &
   tropomi_co_ndim,tropomi_o3_ndim,tropomi_no2_ndim,tropomi_so2_ndim,tempo_o3_ndim,tempo_no2_ndim
!
   integer :: mopitt_co_prf_cnt,iasi_co_prf_cnt,iasi_co_col_cnt,iasi_o3_prf_cnt, &
              modis_aod_cnt,omi_o3_col_cnt,omi_no2_col_cnt,omi_so2_col_cnt, &
              tropomi_co_col_cnt,tropomi_o3_col_cnt,tropomi_no2_col_cnt, &
              tropomi_so2_col_cnt,tempo_o3_col_cnt,tempo_no2_col_cnt, &
              airnow_co_cnt,airnow_o3_cnt,airnow_no2_cnt,airnow_so2_cnt, &
              airnow_pm10_cnt,airnow_pm25_cnt

   integer :: iunit,nobs_kind,num_copies,num_qc,num_obs,max_num_obs
   integer :: first_obs,last_obs,obs_rec,z_id,kind_id,irec,jrec,iirec
   integer :: imem,num_mem,kstr,iprs
!
   integer,allocatable,dimension(:) ::obs_kind
!
   real :: qc_crit,missing,obs_val,prior_mean,post_mean,prior_sprd,post_sprd
   real :: prior_exp_ob,post_exp_ob,ncep_qc,dart_qc,x,y,z,obs_sec,obs_day
   real :: err_var
   real,dimension(mopitt_co_ndim) :: mopitt_prs
!
! AIRNOW CO
   real,dimension(maxnobs) :: airnow_co_obs_val,airnow_co_prior_mean, &
        airnow_co_post_mean,airnow_co_prior_sprd,airnow_co_post_sprd, &
        airnow_co_x,airnow_co_y,airnow_co_z,airnow_co_dart_qc, &
        airnow_co_err_var,airnow_co_day,airnow_co_sec
!
! AIRNOW O3
   real,dimension(maxnobs) :: airnow_o3_obs_val,airnow_o3_prior_mean, &
        airnow_o3_post_mean,airnow_o3_prior_sprd,airnow_o3_post_sprd, &
        airnow_o3_x,airnow_o3_y,airnow_o3_z,airnow_o3_dart_qc, &
        airnow_o3_err_var,airnow_o3_day,airnow_o3_sec
!
! AIRNOW NO2
   real,dimension(maxnobs) :: airnow_no2_obs_val,airnow_no2_prior_mean, &
        airnow_no2_post_mean,airnow_no2_prior_sprd,airnow_no2_post_sprd, &
        airnow_no2_x,airnow_no2_y,airnow_no2_z,airnow_no2_dart_qc, &
        airnow_no2_err_var,airnow_no2_day,airnow_no2_sec
!
! AIRNOW SO2
   real,dimension(maxnobs) :: airnow_so2_obs_val,airnow_so2_prior_mean, &
        airnow_so2_post_mean,airnow_so2_prior_sprd,airnow_so2_post_sprd, &
        airnow_so2_x,airnow_so2_y,airnow_so2_z,airnow_so2_dart_qc, &
        airnow_so2_err_var,airnow_so2_day,airnow_so2_sec
!
! AIRNOW PM10
   real,dimension(maxnobs) :: airnow_pm10_obs_val,airnow_pm10_prior_mean, &
        airnow_pm10_post_mean,airnow_pm10_prior_sprd,airnow_pm10_post_sprd, &
        airnow_pm10_x,airnow_pm10_y,airnow_pm10_z,airnow_pm10_dart_qc, &
        airnow_pm10_err_var,airnow_pm10_day,airnow_pm10_sec
!
! AIRNOW PM25
   real,dimension(maxnobs) :: airnow_pm25_obs_val,airnow_pm25_prior_mean, &
        airnow_pm25_post_mean,airnow_pm25_prior_sprd,airnow_pm25_post_sprd, &
        airnow_pm25_x,airnow_pm25_y,airnow_pm25_z,airnow_pm25_dart_qc, &
        airnow_pm25_err_var,airnow_pm25_day,airnow_pm25_sec
!
! MODIS AOD
   real,dimension(maxnobs) :: modis_aod_obs_val,modis_aod_prior_mean, &
        modis_aod_post_mean,modis_aod_prior_sprd,modis_aod_post_sprd, &
        modis_aod_x,modis_aod_y,modis_aod_z,modis_aod_dart_qc, &
        modis_aod_err_var,modis_aod_day,modis_aod_sec
!
! MOPITT CO PRF
   integer :: mopitt_npr_int
   integer,dimension(maxnobs) :: mopitt_co_prf_npr
   real :: mopitt_nprr,mopitt_prior,mopitt_psfc
   real,allocatable,dimension(:) :: mopitt_avgk
   real,dimension(maxnobs) :: mopitt_co_prf_obs_val,mopitt_co_prf_prior_mean, &
        mopitt_co_prf_post_mean,mopitt_co_prf_prior_sprd,mopitt_co_prf_post_sprd, &
        mopitt_co_prf_x,mopitt_co_prf_y,mopitt_co_prf_z,mopitt_co_prf_dart_qc, &
        mopitt_co_prf_psfc,mopitt_co_prf_prior, mopitt_co_prf_err_var, &
        mopitt_co_prf_day,mopitt_co_prf_sec
   real,dimension(maxnobs,mopitt_co_ndim) :: mopitt_co_prf_prs,mopitt_co_prf_avgk 
!
! IASI CO PRF
   integer :: iasi_npr_int,iasi_npr_intp
   integer,dimension(maxnobs) :: iasi_co_prf_npr
   real :: iasi_nprr,iasi_prior,iasi_psfc
   real,allocatable,dimension(:) :: iasi_avgk,iasi_prs,iasi_hgt,iasi_col
   real,dimension(maxnobs) :: iasi_co_prf_obs_val,iasi_co_prf_prior_mean, &
        iasi_co_prf_post_mean,iasi_co_prf_prior_sprd,iasi_co_prf_post_sprd, &
        iasi_co_prf_x,iasi_co_prf_y,iasi_co_prf_z,iasi_co_prf_dart_qc, &
        iasi_co_prf_psfc,iasi_co_prf_prior,iasi_co_prf_err_var, &
        iasi_co_prf_day,iasi_co_prf_sec
   real,dimension(maxnobs,iasi_co_ndim) :: iasi_co_prf_prs,iasi_co_prf_avgk
!
! IASI O3 PRF
   integer,dimension(maxnobs) :: iasi_o3_prf_npr
   real,dimension(maxnobs) :: iasi_o3_prf_obs_val,iasi_o3_prf_prior_mean, &
        iasi_o3_prf_post_mean,iasi_o3_prf_prior_sprd,iasi_o3_prf_post_sprd, &
        iasi_o3_prf_x,iasi_o3_prf_y,iasi_o3_prf_z,iasi_o3_prf_dart_qc, &
        iasi_o3_prf_prior,iasi_o3_prf_err_var,iasi_o3_prf_day,iasi_o3_prf_sec
   real,dimension(maxnobs,iasi_o3_ndim) :: iasi_o3_prf_prs,iasi_o3_prf_avgk, &
        iasi_o3_prf_hgt
!
! OMI O3 COL
   integer :: omi_npr_int,omi_npr_intp,omi_npr_mdl
   integer,dimension(maxnobs) :: omi_o3_col_npr,omi_o3_col_npr_mdl
   real :: omi_nprr
   real,allocatable,dimension(:) :: omi_avgk,omi_scwt,omi_prs,omi_prior
   real,dimension(maxnobs) :: omi_o3_col_obs_val,omi_o3_col_prior_mean, &
        omi_o3_col_post_mean,omi_o3_col_prior_sprd,omi_o3_col_post_sprd, &
        omi_o3_col_x,omi_o3_col_y,omi_o3_col_z,omi_o3_col_dart_qc, &
        omi_o3_col_err_var,omi_o3_col_day,omi_o3_col_sec
   real,dimension(maxnobs,omi_o3_ndim) :: omi_o3_col_prs,omi_o3_col_avgk, &
        omi_o3_col_prior
!
! OMI NO2 COL
   integer,dimension(maxnobs) :: omi_no2_col_npr,omi_no2_col_npr_mdl
   real,dimension(maxnobs) :: omi_no2_col_obs_val,omi_no2_col_prior_mean, &
        omi_no2_col_post_mean,omi_no2_col_prior_sprd,omi_no2_col_post_sprd, &
        omi_no2_col_x,omi_no2_col_y,omi_no2_col_z,omi_no2_col_dart_qc, &
        omi_no2_col_psfc,omi_no2_col_prior,omi_no2_col_err_var, &
        omi_no2_col_day,omi_no2_col_sec
   real,dimension(maxnobs,omi_no2_ndim) :: omi_no2_col_prs,omi_no2_col_scwt
!
! OMI SO2 COL
   integer,dimension(maxnobs) :: omi_so2_col_npr,omi_so2_col_npr_mdl
   real,dimension(maxnobs) :: omi_so2_col_obs_val,omi_so2_col_prior_mean, &
        omi_so2_col_post_mean,omi_so2_col_prior_sprd,omi_so2_col_post_sprd, &
        omi_so2_col_x,omi_so2_col_y,omi_so2_col_z,omi_so2_col_dart_qc, &
        omi_so2_col_err_var,omi_so2_col_day,omi_so2_col_sec
   real,dimension(maxnobs,omi_so2_ndim) :: omi_so2_col_prs,omi_so2_col_scwt
!
! TROPOMI CO COL
   integer :: tropomi_npr_int,tropomi_npr_intp,tropomi_npr_mdl
   integer,dimension(maxnobs) :: tropomi_co_col_npr,tropomi_co_col_npr_mdl
   real :: tropomi_nprr,tropomi_amf
   real,allocatable,dimension(:) :: tropomi_avgk,tropomi_scwt,tropomi_prs,tropomi_prior
   real,dimension(maxnobs) :: tropomi_co_col_obs_val,tropomi_co_col_prior_mean, &
        tropomi_co_col_post_mean,tropomi_co_col_prior_sprd,tropomi_co_col_post_sprd, &
        tropomi_co_col_x,tropomi_co_col_y,tropomi_co_col_z,tropomi_co_col_dart_qc, &
        tropomi_co_col_err_var,tropomi_co_col_day,tropomi_co_col_sec
   real,dimension(maxnobs,tropomi_co_ndim) :: tropomi_co_col_prs,tropomi_co_col_avgk
!
! TROPOMI O3 COL
   integer,dimension(maxnobs) :: tropomi_o3_col_npr,tropomi_o3_col_npr_mdl
   real,dimension(maxnobs) :: tropomi_o3_col_obs_val,tropomi_o3_col_prior_mean, &
        tropomi_o3_col_post_mean,tropomi_o3_col_prior_sprd,tropomi_o3_col_post_sprd, &
        tropomi_o3_col_x,tropomi_o3_col_y,tropomi_o3_col_z,tropomi_o3_col_dart_qc, &
        tropomi_o3_col_err_var,tropomi_o3_col_day,tropomi_o3_col_sec
   real,dimension(maxnobs,tropomi_o3_ndim) :: tropomi_o3_col_prs,tropomi_o3_col_avgk, &
        tropomi_o3_col_prior
!
! TROPOMI NO2 COL
   integer,dimension(maxnobs) :: tropomi_no2_col_npr,tropomi_no2_col_npr_mdl
   real,dimension(maxnobs) :: tropomi_no2_col_obs_val,tropomi_no2_col_prior_mean, &
        tropomi_no2_col_post_mean,tropomi_no2_col_prior_sprd,tropomi_no2_col_post_sprd, &
        tropomi_no2_col_x,tropomi_no2_col_y,tropomi_no2_col_z,tropomi_no2_col_dart_qc, &
        tropomi_no2_col_amf,tropomi_no2_col_err_var,tropomi_no2_col_day,tropomi_no2_col_sec
   real,dimension(maxnobs,tropomi_no2_ndim) :: tropomi_no2_col_prs,tropomi_no2_col_avgk
!
! TROPOMI SO2 COL
   integer,dimension(maxnobs) :: tropomi_so2_col_npr,tropomi_so2_col_npr_mdl
   real,dimension(maxnobs) :: tropomi_so2_col_obs_val,tropomi_so2_col_prior_mean, &
        tropomi_so2_col_post_mean,tropomi_so2_col_prior_sprd,tropomi_so2_col_post_sprd, &
        tropomi_so2_col_x,tropomi_so2_col_y,tropomi_so2_col_z,tropomi_so2_col_dart_qc, &
        tropomi_so2_col_amf,tropomi_so2_col_err_var,tropomi_so2_col_day,tropomi_so2_col_sec
   real,dimension(maxnobs,tropomi_so2_ndim) :: tropomi_so2_col_prs,tropomi_so2_col_avgk, &
        tropomi_so2_col_prior
!
! TEMPO O3 COL
   integer :: tempo_npr_int,tempo_npr_intp,tempo_npr_mdl
   integer,dimension(maxnobs) :: tempo_o3_col_npr,tempo_o3_col_npr_mdl
   real :: tempo_nprr,tempo_amf
   real,allocatable,dimension(:) :: tempo_avgk,tempo_scwt,tempo_prs,tempo_prior
   real,dimension(maxnobs) :: tempo_o3_col_obs_val,tempo_o3_col_prior_mean, &
        tempo_o3_col_post_mean,tempo_o3_col_prior_sprd,tempo_o3_col_post_sprd, &
        tempo_o3_col_x,tempo_o3_col_y,tempo_o3_col_z,tempo_o3_col_dart_qc, &
        tempo_o3_col_err_var,tempo_o3_col_day,tempo_o3_col_sec
   real,dimension(maxnobs,tempo_o3_ndim) :: tempo_o3_col_prs,tempo_o3_col_avgk, &
        tempo_o3_col_prior
!
! TEMPO NO2 COL
   integer,dimension(maxnobs) :: tempo_no2_col_npr,tempo_no2_col_npr_mdl
   real,dimension(maxnobs) :: tempo_no2_col_obs_val,tempo_no2_col_prior_mean, &
        tempo_no2_col_post_mean,tempo_no2_col_prior_sprd,tempo_no2_col_post_sprd, &
        tempo_no2_col_x,tempo_no2_col_y,tempo_no2_col_z,tempo_no2_col_dart_qc, &
        tempo_no2_col_amf,tempo_no2_col_err_var,tempo_no2_col_day,tempo_no2_col_sec
   real,dimension(maxnobs,tempo_no2_ndim) :: tempo_no2_col_prs,tempo_no2_col_scwt
!
   character(len=150) :: file_in,file_type,obs_kind_defn,chr_num_copies,chr_num_qc
   character(len=150) :: chr_num_obs,chr_max_num_obs, meta_data,chr_first_obs
   character(len=150) :: chr_last_obs,chr_obs,chr_obs_def,chr_locxd,chr_kind
   
   character(len=150),allocatable,dimension(:) :: obs_kind_id
!
! initialize counters
   qc_crit=1
   mopitt_co_prf_cnt=0
   iasi_co_prf_cnt=0
   iasi_co_col_cnt=0
   iasi_o3_prf_cnt=0
   modis_aod_cnt=0
   omi_o3_col_cnt=0
   omi_no2_col_cnt=0
   omi_so2_col_cnt=0
   tropomi_co_col_cnt=0
   tropomi_o3_col_cnt=0
   tropomi_no2_col_cnt=0
   tropomi_so2_col_cnt=0
   tempo_o3_col_cnt=0
   tempo_no2_col_cnt=0
   airnow_co_cnt=0
   airnow_o3_cnt=0
   airnow_no2_cnt=0
   airnow_so2_cnt=0
   airnow_pm10_cnt=0
   airnow_pm25_cnt=0
   iunit=101
   print *, 'filein ',trim(file_in)
   open(unit=iunit,form='formatted',file=trim(file_in)) 
!
! read file type
   read(iunit,*) file_type
!   print *, trim(file_type)
!
! read obs_kind_definition
   read(iunit,*) obs_kind_defn
!   print *, trim(obs_kind_defn)
!
! read number of obs_kinds
   read(iunit,*) nobs_kind
!   print *, nobs_kind
!
! read obs_kinds and obs_kind_ids
   allocate(obs_kind(nobs_kind),obs_kind_id(nobs_kind))
   do irec=1,nobs_kind
      read(iunit,*) obs_kind(irec),obs_kind_id(irec)
!      print *, irec,obs_kind(irec),trim(obs_kind_id(irec))
   enddo       
!
! read num_copies and num_qc
   read(iunit,*) chr_num_copies,num_copies,chr_num_qc,num_qc
!   print *, trim(chr_num_copies),num_copies,trim(chr_num_qc),num_qc
!
! read num_obs and max_num_obs
   read(iunit,*) chr_num_obs,num_obs,chr_max_num_obs,max_num_obs
!   print *, trim(chr_num_obs),num_obs,trim(chr_max_num_obs),max_num_obs
!
! read num_copies meta data
   do irec=1,num_copies
      read(iunit,*) meta_data
!      print *, trim(meta_data)
   enddo
   do irec=1,num_qc
      read(iunit,*) meta_data
!      print *, trim(meta_data)
   enddo
!
! read first and last
   read(iunit,*) chr_first_obs,first_obs,chr_last_obs,last_obs
!   print *, trim(chr_first_obs),first_obs,trim(chr_last_obs),last_obs
!
! loop through obs and read data
   if(num_obs.gt.maxnobs) then
      print *, 'ERROR: maxnobs not large enough ',maxnobs,num_obs
      call abort
   endif 
!
   do irec=1,num_obs
      read(iunit,*) chr_obs,obs_rec
!      print *,'chr_obs, obs_rec ',trim(chr_obs),obs_rec
!
! read data
      read(iunit,*), obs_val  
!      print *, obs_val
      read(iunit,*), prior_mean  
!      print *, prior_mean
      read(iunit,*), post_mean  
!      print *, post_mean
      read(iunit,*), prior_sprd  
!      print *, prior_sprd
      read(iunit,*), post_sprd  
!      print *, post_sprd
      do imem=1,num_mem
         read(iunit,*), prior_exp_ob  
!         print *, prior_exp_ob
         read(iunit,*), post_exp_ob
!         print *, post_exp_ob
      enddo
      read(iunit,*), ncep_qc  
!      print *, ncep_qc
      read(iunit,*), dart_qc  
!      print *, dart_qc
!
! skip record
      read(iunit,*)
!
! read chr_obs_def
      read(iunit,*) chr_obs_def
!      print *, trim(chr_obs_def)
!
! read chr_locxd
      read(iunit,*) chr_locxd
!      print *, trim(chr_locxd)
!
! select dimensionality
      select case (trim(chr_locxd))
         case('loc2d')
            read(iunit,*),x,y
!            print *, x,y
         case('loc3d')
            read(iunit,*),x,y,z,z_id
!            print *,'x,y,z,z_id ',x,y,z,z_id
      end select
!
! read chr_kind
      read(iunit,*) chr_kind
!      print *, trim(chr_kind)
      read(iunit,*) kind_id
!      print *, 'chr_kind, kind_id ',trim(chr_kind),kind_id
!
      iirec=0      
      do jrec=1,nobs_kind
         if(kind_id.eq.obs_kind(jrec)) then
            iirec=jrec
            exit
         endif
      enddo
      if(iirec.eq.0) then
         print *, 'ERROR: iirec equals zero'
         call abort
      endif
!
! find obs_kind and store data
!      print *, trim(obs_kind_id(iirec))
      
      select case (trim(obs_kind_id(iirec)))
         case('RADIOSONDE_U_WIND_COMPONENT', &
              'RADIOSONDE_V_WIND_COMPONENT', &
              'RADIOSONDE_TEMPERATURE', &
              'RADIOSONDE_SPECIFIC_HUMIDITY', &
              'AIRCRAFT_U_WIND_COMPONENT', &
              'AIRCRAFT_V_WIND_COMPONENT', &
              'AIRCRAFT_TEMPERATURE', &
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
              'ACARS_U_WIND_COMPONENT', &
              'ACARS_V_WIND_COMPONENT', &
              'ACARS_TEMPERATURE', &
              'AIRNOW_CO', &
              'AIRNOW_O3', &
              'AIRNOW_NO2', &
              'AIRNOW_SO2', &
              'AIRNOW_PM10', &
              'AIRNOW_PM25', &
              'MODIS_AOD_RETRIEVAL')
!
! read time data 
            read(iunit,*) obs_sec,obs_day
! read obervation error variance 
            read(iunit,*) err_var
            if(dart_qc.gt.qc_crit.or.(prior_mean.eq.missing.or. &
            post_mean.eq.missing)) cycle
            if(trim(obs_kind_id(iirec)).eq.'AIRNOW_CO') then
               airnow_co_cnt=airnow_co_cnt+1
               airnow_co_obs_val(airnow_co_cnt)=obs_val
               airnow_co_prior_mean(airnow_co_cnt)=prior_mean
               airnow_co_post_mean(airnow_co_cnt)=post_mean
               airnow_co_prior_sprd(airnow_co_cnt)=prior_sprd
               airnow_co_post_sprd(airnow_co_cnt)=post_sprd
               airnow_co_x(airnow_co_cnt)=x
               airnow_co_y(airnow_co_cnt)=y
               airnow_co_z(airnow_co_cnt)=z
               airnow_co_dart_qc(airnow_co_cnt)=dart_qc
               airnow_co_err_var(airnow_co_cnt)=err_var
               airnow_co_day(airnow_co_cnt)=obs_day
               airnow_co_sec(airnow_co_cnt)=obs_sec
               cycle
            else if(trim(obs_kind_id(iirec)).eq.'AIRNOW_O3') then
               airnow_o3_cnt=airnow_o3_cnt+1
               airnow_o3_obs_val(airnow_o3_cnt)=obs_val
               airnow_o3_prior_mean(airnow_o3_cnt)=prior_mean
               airnow_o3_post_mean(airnow_o3_cnt)=post_mean
               airnow_o3_prior_sprd(airnow_o3_cnt)=prior_sprd
               airnow_o3_post_sprd(airnow_o3_cnt)=post_sprd
               airnow_o3_x(airnow_o3_cnt)=x
               airnow_o3_y(airnow_o3_cnt)=y
               airnow_o3_z(airnow_o3_cnt)=z
               airnow_o3_dart_qc(airnow_o3_cnt)=dart_qc
               airnow_o3_err_var(airnow_o3_cnt)=err_var
               airnow_o3_day(airnow_o3_cnt)=obs_day
               airnow_o3_sec(airnow_o3_cnt)=obs_sec
               cycle
            else if(trim(obs_kind_id(iirec)).eq.'AIRNOW_NO2') then
               airnow_no2_cnt=airnow_no2_cnt+1
               airnow_no2_obs_val(airnow_no2_cnt)=obs_val
               airnow_no2_prior_mean(airnow_no2_cnt)=prior_mean
               airnow_no2_post_mean(airnow_no2_cnt)=post_mean
               airnow_no2_prior_sprd(airnow_no2_cnt)=prior_sprd
               airnow_no2_post_sprd(airnow_no2_cnt)=post_sprd
               airnow_no2_x(airnow_no2_cnt)=x
               airnow_no2_y(airnow_no2_cnt)=y
               airnow_no2_z(airnow_no2_cnt)=z
               airnow_no2_dart_qc(airnow_no2_cnt)=dart_qc
               airnow_no2_err_var(airnow_no2_cnt)=err_var
               airnow_no2_day(airnow_no2_cnt)=obs_day
               airnow_no2_sec(airnow_no2_cnt)=obs_sec
               cycle
            else if(trim(obs_kind_id(iirec)).eq.'AIRNOW_SO2') then
               airnow_so2_cnt=airnow_so2_cnt+1
               airnow_so2_obs_val(airnow_so2_cnt)=obs_val
               airnow_so2_prior_mean(airnow_so2_cnt)=prior_mean
               airnow_so2_post_mean(airnow_so2_cnt)=post_mean
               airnow_so2_prior_sprd(airnow_so2_cnt)=prior_sprd
               airnow_so2_post_sprd(airnow_so2_cnt)=post_sprd
               airnow_so2_x(airnow_so2_cnt)=x
               airnow_so2_y(airnow_so2_cnt)=y
               airnow_so2_z(airnow_so2_cnt)=z
               airnow_so2_dart_qc(airnow_so2_cnt)=dart_qc
               airnow_so2_err_var(airnow_so2_cnt)=err_var
               airnow_so2_day(airnow_so2_cnt)=obs_day
               airnow_so2_sec(airnow_so2_cnt)=obs_sec
               cycle
            else if(trim(obs_kind_id(iirec)).eq.'AIRNOW_PM10') then
               airnow_pm10_cnt=airnow_pm10_cnt+1
               airnow_pm10_obs_val(airnow_pm10_cnt)=obs_val
               airnow_pm10_prior_mean(airnow_pm10_cnt)=prior_mean
               airnow_pm10_post_mean(airnow_pm10_cnt)=post_mean
               airnow_pm10_prior_sprd(airnow_pm10_cnt)=prior_sprd
               airnow_pm10_post_sprd(airnow_pm10_cnt)=post_sprd
               airnow_pm10_x(airnow_pm10_cnt)=x
               airnow_pm10_y(airnow_pm10_cnt)=y
               airnow_pm10_z(airnow_pm10_cnt)=z
               airnow_pm10_dart_qc(airnow_pm10_cnt)=dart_qc
               airnow_pm10_err_var(airnow_pm10_cnt)=err_var
               airnow_pm10_day(airnow_pm10_cnt)=obs_day
               airnow_pm10_sec(airnow_pm10_cnt)=obs_sec
               cycle
            else if(trim(obs_kind_id(iirec)).eq.'AIRNOW_PM25') then
               airnow_pm25_cnt=airnow_pm25_cnt+1
               airnow_pm25_obs_val(airnow_pm25_cnt)=obs_val
               airnow_pm25_prior_mean(airnow_pm25_cnt)=prior_mean
               airnow_pm25_post_mean(airnow_pm25_cnt)=post_mean
               airnow_pm25_prior_sprd(airnow_pm25_cnt)=prior_sprd
               airnow_pm25_post_sprd(airnow_pm25_cnt)=post_sprd
               airnow_pm25_x(airnow_pm25_cnt)=x
               airnow_pm25_y(airnow_pm25_cnt)=y
               airnow_pm25_z(airnow_pm25_cnt)=z
               airnow_pm25_dart_qc(airnow_pm25_cnt)=dart_qc
               airnow_pm25_err_var(airnow_pm25_cnt)=err_var
               airnow_pm25_day(airnow_pm25_cnt)=obs_day
               airnow_pm25_sec(airnow_pm25_cnt)=obs_sec
               cycle
            else if(trim(obs_kind_id(iirec)).eq.'MODIS_AOD_RETRIEVAL') then
               modis_aod_cnt=modis_aod_cnt+1
               modis_aod_obs_val(modis_aod_cnt)=obs_val
               modis_aod_prior_mean(modis_aod_cnt)=prior_mean
               modis_aod_post_mean(modis_aod_cnt)=post_mean
               modis_aod_prior_sprd(modis_aod_cnt)=prior_sprd
               modis_aod_post_sprd(modis_aod_cnt)=post_sprd
               modis_aod_x(modis_aod_cnt)=x
               modis_aod_y(modis_aod_cnt)=y
               modis_aod_z(modis_aod_cnt)=z
               modis_aod_dart_qc(modis_aod_cnt)=dart_qc
               modis_aod_err_var(modis_aod_cnt)=err_var
               modis_aod_day(modis_aod_cnt)=obs_day
               modis_aod_sec(modis_aod_cnt)=obs_sec
               cycle
            endif
!
         case('MOPITT_CO_RETRIEVAL')
!
! read number of MOPITT CO levels
            read(iunit,*) mopitt_nprr
!            print *, mopitt_nprr
            mopitt_npr_int=nint(mopitt_nprr)
            allocate(mopitt_avgk(mopitt_npr_int))
!
! read meta data
            read(iunit,*) mopitt_prior
!            print *, mopitt_prior
            read(iunit,*) mopitt_psfc
!            print *, mopitt_psfc 
            read(iunit,*) mopitt_avgk(1:mopitt_npr_int)
!            print *, mopitt_avgk(1:mopitt_npr_int)
! read record number
            read(iunit,*)
! read time data
            read(iunit,*) obs_sec,obs_day
!           print *, obs_sec,obs_day
! read observation error variance
            read(iunit,*) err_var
!
! save MOPITT data
            if(dart_qc.gt.qc_crit.or.(prior_mean.eq.missing.or. &
            post_mean.eq.missing)) then
               deallocate(mopitt_avgk)   
               cycle
            endif
            mopitt_co_prf_cnt=mopitt_co_prf_cnt+1
            mopitt_co_prf_obs_val(mopitt_co_prf_cnt)=obs_val                  
            mopitt_co_prf_prior_mean(mopitt_co_prf_cnt)=prior_mean                 
            mopitt_co_prf_post_mean(mopitt_co_prf_cnt)=post_mean              
            mopitt_co_prf_prior_sprd(mopitt_co_prf_cnt)=prior_sprd                 
            mopitt_co_prf_post_sprd(mopitt_co_prf_cnt)=post_sprd                  
            mopitt_co_prf_x(mopitt_co_prf_cnt)=x
            mopitt_co_prf_y(mopitt_co_prf_cnt)=y
            mopitt_co_prf_z(mopitt_co_prf_cnt)=z
            mopitt_co_prf_dart_qc(mopitt_co_prf_cnt)=dart_qc
            mopitt_co_prf_npr(mopitt_co_prf_cnt)=mopitt_npr_int
            mopitt_co_prf_psfc(mopitt_co_prf_cnt)=mopitt_psfc            
            kstr=mopitt_co_ndim-mopitt_npr_int+1
            do iprs=1,mopitt_npr_int
               if (iprs.eq.1) then
                  mopitt_co_prf_prs(mopitt_co_prf_cnt,iprs)=(mopitt_psfc/100.+mopitt_prs(kstr))/2.
                  cycle
               elseif (iprs.ne.mopitt_npr_int) then
                  mopitt_co_prf_prs(mopitt_co_prf_cnt,iprs)=(mopitt_prs(kstr+iprs-2)+mopitt_prs(kstr+iprs-1))/2.
                  cycle
               elseif (iprs.eq.mopitt_npr_int) then
                  mopitt_co_prf_prs(mopitt_co_prf_cnt,iprs)=mopitt_prs(mopitt_co_ndim)/2.
               endif
            enddo
            mopitt_co_prf_avgk(mopitt_co_prf_cnt,1:mopitt_npr_int)=mopitt_avgk(1:mopitt_npr_int)
            mopitt_co_prf_prior(mopitt_co_prf_cnt)=mopitt_prior
            mopitt_co_prf_err_var(mopitt_co_prf_cnt)=err_var
            mopitt_co_prf_day(mopitt_co_prf_cnt)=obs_day
            mopitt_co_prf_sec(mopitt_co_prf_cnt)=obs_sec
            deallocate(mopitt_avgk)
            cycle
!
         case('IASI_CO_RETRIEVAL')
!
! read number of IASI CO levels
            read(iunit,*) iasi_nprr
            iasi_npr_int=nint(iasi_nprr)
            iasi_npr_intp=iasi_npr_int+1
            read(iunit,*) iasi_prior
            read(iunit,*) iasi_psfc   
            read(iunit,*) iasi_avgk(1:iasi_npr_int)     
            read(iunit,*) iasi_prs(1:iasi_npr_intp)                    
! read record number
            read(iunit,*)
! read time data
            read(iunit,*) obs_sec,obs_day
! read observation error variance
            read(iunit,*) err_var
!
! save IASI data
            if(dart_qc.gt.qc_crit.or.(prior_mean.eq.missing.or. &
            post_mean.eq.missing)) cycle
            iasi_co_prf_cnt=iasi_co_prf_cnt+1
            iasi_co_prf_obs_val(iasi_co_prf_cnt)=obs_val                  
            iasi_co_prf_prior_mean(iasi_co_prf_cnt)=prior_mean                 
            iasi_co_prf_post_mean(iasi_co_prf_cnt)=post_mean              
            iasi_co_prf_prior_sprd(iasi_co_prf_cnt)=prior_sprd                 
            iasi_co_prf_post_sprd(iasi_co_prf_cnt)=post_sprd                  
            iasi_co_prf_x(iasi_co_prf_cnt)=x
            iasi_co_prf_y(iasi_co_prf_cnt)=y
            iasi_co_prf_z(iasi_co_prf_cnt)=z
            iasi_co_prf_dart_qc(iasi_co_prf_cnt)=dart_qc
            iasi_co_prf_npr(iasi_co_prf_cnt)=iasi_npr_int
            iasi_co_prf_psfc(iasi_co_prf_cnt)=iasi_psfc
            iasi_co_prf_prs(iasi_co_prf_cnt,1:iasi_npr_intp)=iasi_prs(1:iasi_npr_intp)
            iasi_co_prf_avgk(iasi_co_prf_cnt,1:iasi_npr_int)=iasi_avgk(1:iasi_npr_int)
            iasi_co_prf_prior(iasi_co_prf_cnt)=iasi_prior
            iasi_co_prf_err_var(iasi_co_prf_cnt)=err_var
            iasi_co_prf_day(iasi_co_prf_cnt)=obs_day
            iasi_co_prf_sec(iasi_co_prf_cnt)=obs_sec
            cycle
!
         case('IASI_O3_RETRIEVAL')
!
! read number of IASI O3 levels
            read(iunit,*) iasi_nprr
            iasi_npr_int=nint(iasi_nprr)
            read(iunit,*) iasi_prior
            read(iunit,*) iasi_hgt(1:iasi_npr_intp)                    
            read(iunit,*) iasi_prs(1:iasi_npr_intp)                    
            read(iunit,*) iasi_avgk(1:iasi_npr_int)                    
            read(iunit,*) iasi_col(1:iasi_npr_int)                    
! read record number
            read(iunit,*)
! read time data
            read(iunit,*) obs_sec,obs_day
! read observation error variance
            read(iunit,*) err_var
            cycle
!
         case('OMI_O3_COLUMN')
!
! read number of OMI O3 levels
            read(iunit,*) omi_nprr
            omi_npr_int=nint(omi_nprr)
            omi_npr_intp=omi_npr_int+1
            read(iunit,*) omi_nprr
            omi_npr_mdl=nint(omi_nprr)
            read(iunit,*) omi_prs(1:omi_npr_intp)
            read(iunit,*) omi_avgk(1:omi_npr_int)
            read(iunit,*) omi_prior(1:omi_npr_int)
! read record number
            read(iunit,*)
! read time data
            read(iunit,*) obs_sec,obs_day
! read observation error variance
            read(iunit,*) err_var
!
! save OMI data
            if(dart_qc.gt.qc_crit.or.(prior_mean.eq.missing.or. &
            post_mean.eq.missing)) cycle
            omi_o3_col_cnt=omi_o3_col_cnt+1
            omi_o3_col_obs_val(omi_o3_col_cnt)=obs_val                  
            omi_o3_col_prior_mean(omi_o3_col_cnt)=prior_mean                 
            omi_o3_col_post_mean(omi_o3_col_cnt)=post_mean              
            omi_o3_col_prior_sprd(omi_o3_col_cnt)=prior_sprd                 
            omi_o3_col_post_sprd(omi_o3_col_cnt)=post_sprd                  
            omi_o3_col_x(omi_o3_col_cnt)=x
            omi_o3_col_y(omi_o3_col_cnt)=y
            omi_o3_col_z(omi_o3_col_cnt)=z
            omi_o3_col_dart_qc(omi_o3_col_cnt)=dart_qc
            omi_o3_col_npr(omi_o3_col_cnt)=omi_npr_int
            omi_o3_col_npr_mdl(omi_no2_col_cnt)=omi_npr_mdl
            omi_o3_col_prs(omi_o3_col_cnt,1:omi_npr_intp)=omi_prs(1:omi_npr_intp)
            omi_o3_col_avgk(omi_o3_col_cnt,1:omi_npr_int)=omi_avgk(1:omi_npr_int)
            omi_o3_col_prior(omi_o3_col_cnt,1:omi_npr_int)=omi_prior(1:omi_npr_int)
            omi_o3_col_err_var(omi_o3_col_cnt)=err_var
            omi_o3_col_day(omi_o3_col_cnt)=obs_day
            omi_o3_col_sec(omi_o3_col_cnt)=obs_sec 
            cycle
!
         case('OMI_NO2_COLUMN')
!
! read number of OMI NO2 levels
            read(iunit,*) omi_nprr
            omi_npr_int=nint(omi_nprr)
            omi_npr_intp=omi_npr_int+1
            read(iunit,*) omi_nprr
            omi_npr_mdl=nint(omi_nprr)
            read(iunit,*) omi_prs(1:omi_npr_intp)
            read(iunit,*) omi_scwt(1:omi_npr_int)
! read record number
            read(iunit,*)
! read time data
            read(iunit,*) obs_sec,obs_day
! read observation error variance
            read(iunit,*) err_var
!
! save OMI data
            if(dart_qc.gt.qc_crit.or.(prior_mean.eq.missing.or. &
            post_mean.eq.missing)) cycle
            omi_no2_col_cnt=omi_no2_col_cnt+1
            omi_no2_col_obs_val(omi_no2_col_cnt)=obs_val                  
            omi_no2_col_prior_mean(omi_no2_col_cnt)=prior_mean                 
            omi_no2_col_post_mean(omi_no2_col_cnt)=post_mean              
            omi_no2_col_prior_sprd(omi_no2_col_cnt)=prior_sprd                 
            omi_no2_col_post_sprd(omi_no2_col_cnt)=post_sprd                  
            omi_no2_col_x(omi_no2_col_cnt)=x
            omi_no2_col_y(omi_no2_col_cnt)=y
            omi_no2_col_z(omi_no2_col_cnt)=z
            omi_no2_col_dart_qc(omi_no2_col_cnt)=dart_qc
            omi_no2_col_npr(omi_no2_col_cnt)=omi_npr_int
            omi_no2_col_npr_mdl(omi_no2_col_cnt)=omi_npr_mdl
            omi_no2_col_prs(omi_no2_col_cnt,1:omi_npr_intp)=omi_prs(1:omi_npr_intp)
            omi_no2_col_scwt(omi_no2_col_cnt,1:omi_npr_int)=omi_scwt(1:omi_npr_int)
            omi_no2_col_err_var(omi_no2_col_cnt)=err_var
            omi_no2_col_day(omi_no2_col_cnt)=obs_day
            omi_no2_col_sec(omi_no2_col_cnt)=obs_sec 
            cycle
!
         case('OMI_SO2_COLUMN')
!
! read number of OMI SO2 levels
            read(iunit,*) omi_nprr
            omi_npr_int=nint(omi_nprr)
            omi_npr_intp=omi_npr_int+1
            read(iunit,*) omi_nprr
            omi_npr_mdl=nint(omi_nprr)
            read(iunit,*) omi_prs(1:omi_npr_intp)
            read(iunit,*) omi_scwt(1:omi_npr_int)
! read record number
            read(iunit,*)
! read time data
            read(iunit,*) obs_sec,obs_day
! read observation error variance
            read(iunit,*) err_var
            cycle
!
         case('TROPOMI_CO_COLUMN')
!
! read number of TROPOMI CO levels
            read(iunit,*) tropomi_nprr
            tropomi_npr_int=nint(tropomi_nprr)
            tropomi_npr_intp=tropomi_npr_int+1
            read(iunit,*) tropomi_nprr
            tropomi_npr_mdl=nint(tropomi_nprr)
            allocate(tropomi_prs(tropomi_npr_intp))           
            allocate(tropomi_avgk(tropomi_npr_int))            
            read(iunit,*) tropomi_prs(1:tropomi_npr_intp)
            read(iunit,*) tropomi_avgk(1:tropomi_npr_int)
! read record number
            read(iunit,*)
! read time data
            read(iunit,*) obs_sec,obs_day
! read observation error variance
            read(iunit,*) err_var
!
! save TROPOMI data
            if(dart_qc.gt.qc_crit.or.(prior_mean.eq.missing.or. &
            post_mean.eq.missing)) then
               deallocate(tropomi_prs,tropomi_avgk)
               cycle
            endif
            tropomi_co_col_cnt=tropomi_co_col_cnt+1
            tropomi_co_col_obs_val(tropomi_co_col_cnt)=obs_val                  
            tropomi_co_col_prior_mean(tropomi_co_col_cnt)=prior_mean                 
            tropomi_co_col_post_mean(tropomi_co_col_cnt)=post_mean              
            tropomi_co_col_prior_sprd(tropomi_co_col_cnt)=prior_sprd                 
            tropomi_co_col_post_sprd(tropomi_co_col_cnt)=post_sprd                  
            tropomi_co_col_x(tropomi_co_col_cnt)=x
            tropomi_co_col_y(tropomi_co_col_cnt)=y
            tropomi_co_col_z(tropomi_co_col_cnt)=z
            tropomi_co_col_dart_qc(tropomi_co_col_cnt)=dart_qc
            tropomi_co_col_npr(tropomi_co_col_cnt)=tropomi_npr_int
            tropomi_co_col_npr_mdl(tropomi_co_col_cnt)=tropomi_npr_mdl
            tropomi_co_col_prs(tropomi_co_col_cnt,1:tropomi_npr_int)=tropomi_prs(1:tropomi_npr_int)
            tropomi_co_col_avgk(tropomi_co_col_cnt,1:tropomi_npr_int)=tropomi_avgk(1:tropomi_npr_int)
            tropomi_co_col_err_var(tropomi_co_col_cnt)=err_var
            tropomi_co_col_day(tropomi_co_col_cnt)=obs_day
            tropomi_co_col_sec(tropomi_co_col_cnt)=obs_sec 
            deallocate(tropomi_prs,tropomi_avgk)
            cycle
!
         case('TROPOMI_O3_COLUMN')
!
! read number of TROPOMI O3 levels
            read(iunit,*) tropomi_nprr
            tropomi_npr_int=nint(tropomi_nprr)
            tropomi_npr_intp=tropomi_npr_int+1
            read(iunit,*) tropomi_nprr
            tropomi_npr_mdl=nint(tropomi_nprr)
            read(iunit,*) tropomi_prs(1:tropomi_npr_intp)
            read(iunit,*) tropomi_avgk(1:tropomi_npr_int)
            read(iunit,*) tropomi_prior(1:tropomi_npr_int)
! read record number
            read(iunit,*)
! read time data
            read(iunit,*) obs_sec,obs_day
! read observation error variance
            read(iunit,*) err_var
!
! save TROPOMI data
            if(dart_qc.gt.qc_crit.or.(prior_mean.eq.missing.or. &
            post_mean.eq.missing)) cycle
            tropomi_o3_col_cnt=tropomi_o3_col_cnt+1
            tropomi_o3_col_obs_val(tropomi_o3_col_cnt)=obs_val                  
            tropomi_o3_col_prior_mean(tropomi_o3_col_cnt)=prior_mean                 
            tropomi_o3_col_post_mean(tropomi_o3_col_cnt)=post_mean              
            tropomi_o3_col_prior_sprd(tropomi_o3_col_cnt)=prior_sprd                 
            tropomi_o3_col_post_sprd(tropomi_o3_col_cnt)=post_sprd                  
            tropomi_o3_col_x(tropomi_o3_col_cnt)=x
            tropomi_o3_col_y(tropomi_o3_col_cnt)=y
            tropomi_o3_col_z(tropomi_o3_col_cnt)=z
            tropomi_o3_col_dart_qc(tropomi_o3_col_cnt)=dart_qc
            tropomi_o3_col_npr(tropomi_o3_col_cnt)=tropomi_npr_int
            tropomi_o3_col_npr_mdl(omi_no2_col_cnt)=tropomi_npr_mdl
            tropomi_o3_col_prs(tropomi_o3_col_cnt,1:tropomi_npr_intp)=tropomi_prs(1:tropomi_npr_intp)
            tropomi_o3_col_avgk(tropomi_o3_col_cnt,1:tropomi_npr_int)=tropomi_avgk(1:tropomi_npr_int)
            tropomi_o3_col_prior(tropomi_o3_col_cnt,1:tropomi_npr_int)=tropomi_prior(1:tropomi_npr_int)
            tropomi_o3_col_err_var(tropomi_o3_col_cnt)=err_var
            tropomi_o3_col_day(tropomi_o3_col_cnt)=obs_day
            tropomi_o3_col_sec(tropomi_o3_col_cnt)=obs_sec 
            cycle
!
         case('TROPOMI_NO2_COLUMN')
!
! read number of TROPOMI NO2 levels
            read(iunit,*) tropomi_nprr
            tropomi_npr_int=nint(tropomi_nprr)
            tropomi_npr_intp=tropomi_npr_int+1
            read(iunit,*) tropomi_nprr
            tropomi_npr_mdl=nint(tropomi_nprr)
            read(iunit,*) tropomi_amf
            read(iunit,*) tropomi_prs(1:tropomi_npr_intp)
            read(iunit,*) tropomi_avgk(1:tropomi_npr_int)
! read record number
            read(iunit,*)
! read time data
            read(iunit,*) obs_sec,obs_day
! read observation error variance
            read(iunit,*) err_var
!
! save TROPOMI data
            if(dart_qc.gt.qc_crit.or.(prior_mean.eq.missing.or. &
            post_mean.eq.missing)) cycle
            tropomi_no2_col_cnt=tropomi_no2_col_cnt+1
            tropomi_no2_col_obs_val(tropomi_no2_col_cnt)=obs_val                  
            tropomi_no2_col_prior_mean(tropomi_no2_col_cnt)=prior_mean                 
            tropomi_no2_col_post_mean(tropomi_no2_col_cnt)=post_mean              
            tropomi_no2_col_prior_sprd(tropomi_no2_col_cnt)=prior_sprd                 
            tropomi_no2_col_post_sprd(tropomi_no2_col_cnt)=post_sprd                  
            tropomi_no2_col_x(tropomi_no2_col_cnt)=x
            tropomi_no2_col_y(tropomi_no2_col_cnt)=y
            tropomi_no2_col_z(tropomi_no2_col_cnt)=z
            tropomi_no2_col_dart_qc(tropomi_no2_col_cnt)=dart_qc
            tropomi_no2_col_npr(tropomi_no2_col_cnt)=tropomi_npr_int
            tropomi_no2_col_npr_mdl(omi_no2_col_cnt)=tropomi_npr_mdl
            tropomi_no2_col_amf(omi_no2_col_cnt)=tropomi_amf
            tropomi_no2_col_prs(tropomi_no2_col_cnt,1:tropomi_npr_intp)=tropomi_prs(1:tropomi_npr_intp)
            tropomi_no2_col_avgk(tropomi_no2_col_cnt,1:tropomi_npr_int)=tropomi_avgk(1:tropomi_npr_int)
            tropomi_no2_col_err_var(tropomi_no2_col_cnt)=err_var
            tropomi_no2_col_day(tropomi_no2_col_cnt)=obs_day
            tropomi_no2_col_sec(tropomi_no2_col_cnt)=obs_sec
            cycle
!
         case('TROPOMI_SO2_COLUMN')
!
! read number of TROPOMI SO2 levels
            read(iunit,*) tropomi_nprr
            tropomi_npr_int=nint(tropomi_nprr)
            tropomi_npr_intp=tropomi_npr_int+1
            read(iunit,*) tropomi_nprr
            tropomi_npr_mdl=nint(tropomi_nprr)
            read(iunit,*) tropomi_amf
            read(iunit,*) tropomi_prs(1:tropomi_npr_intp)
            read(iunit,*) tropomi_avgk(1:tropomi_npr_int)
            read(iunit,*) tropomi_prior(1:tropomi_npr_int)
! read record number
            read(iunit,*)
! read time data
            read(iunit,*) obs_sec,obs_day
! read observation error variance
            read(iunit,*) err_var
!
         case('TEMPO_O3_COLUMN')
!
! read number of TEMPO O3 levels
            read(iunit,*) tempo_nprr
            tempo_npr_int=nint(tempo_nprr)
            tempo_npr_intp=tempo_npr_int+1
            read(iunit,*) tempo_nprr
            tempo_npr_mdl=nint(tempo_nprr)
            read(iunit,*) tempo_prs(1:tempo_npr_intp)
            read(iunit,*) tempo_avgk(1:tempo_npr_int)
            read(iunit,*) tempo_prior(1:tempo_npr_int)
! read record number
            read(iunit,*)
! read time data
            read(iunit,*) obs_sec,obs_day
! read observation error variance
            read(iunit,*) err_var
!
! save TEMPO data
            if(dart_qc.gt.qc_crit.or.(prior_mean.eq.missing.or. &
            post_mean.eq.missing)) cycle
            tempo_o3_col_cnt=tempo_o3_col_cnt+1
            tempo_o3_col_obs_val(tempo_o3_col_cnt)=obs_val                  
            tempo_o3_col_prior_mean(tempo_o3_col_cnt)=prior_mean                 
            tempo_o3_col_post_mean(tempo_o3_col_cnt)=post_mean              
            tempo_o3_col_prior_sprd(tempo_o3_col_cnt)=prior_sprd                 
            tempo_o3_col_post_sprd(tempo_o3_col_cnt)=post_sprd                  
            tempo_o3_col_x(tempo_o3_col_cnt)=x
            tempo_o3_col_y(tempo_o3_col_cnt)=y
            tempo_o3_col_z(tempo_o3_col_cnt)=z
            tempo_o3_col_dart_qc(tempo_o3_col_cnt)=dart_qc
            tempo_o3_col_npr(tempo_o3_col_cnt)=tempo_npr_int
            tempo_o3_col_npr_mdl(omi_no2_col_cnt)=tempo_npr_mdl
            tempo_o3_col_prs(tempo_o3_col_cnt,1:tempo_npr_intp)=tempo_prs(1:tempo_npr_intp)
            tempo_o3_col_avgk(tempo_o3_col_cnt,1:tempo_npr_int)=tempo_avgk(1:tempo_npr_int)
            tempo_o3_col_prior(tempo_o3_col_cnt,1:tempo_npr_int)=tempo_prior(1:tempo_npr_int)
            tempo_o3_col_err_var(tempo_o3_col_cnt)=err_var
            tempo_o3_col_day(tempo_o3_col_cnt)=obs_day
            tempo_o3_col_sec(tempo_o3_col_cnt)=obs_sec 
            cycle
!
         case('TEMPO_NO2_COLUMN')
!
! read number of TEMPO NO2 levels
            read(iunit,*) tempo_nprr
            tempo_npr_int=nint(tempo_nprr)
            tempo_npr_intp=tempo_npr_int+1
            read(iunit,*) tempo_nprr
            tempo_npr_mdl=nint(tempo_nprr)
            read(iunit,*) tempo_amf
            read(iunit,*) tempo_prs(1:tempo_npr_intp)
            read(iunit,*) tempo_scwt(1:tempo_npr_int)
! read record number
            read(iunit,*)
! read time data
            read(iunit,*) obs_sec,obs_day
! read observation error variance
            read(iunit,*) err_var
!
! save TEMPO data
            if(dart_qc.gt.qc_crit.or.(prior_mean.eq.missing.or. &
            post_mean.eq.missing)) cycle
            tempo_no2_col_cnt=tempo_no2_col_cnt+1
            tempo_no2_col_obs_val(tempo_no2_col_cnt)=obs_val                  
            tempo_no2_col_prior_mean(tempo_no2_col_cnt)=prior_mean                 
            tempo_no2_col_post_mean(tempo_no2_col_cnt)=post_mean              
            tempo_no2_col_prior_sprd(tempo_no2_col_cnt)=prior_sprd                 
            tempo_no2_col_post_sprd(tempo_no2_col_cnt)=post_sprd                  
            tempo_no2_col_x(tempo_no2_col_cnt)=x
            tempo_no2_col_y(tempo_no2_col_cnt)=y
            tempo_no2_col_z(tempo_no2_col_cnt)=z
            tempo_no2_col_dart_qc(tempo_no2_col_cnt)=dart_qc
            tempo_no2_col_npr(tempo_no2_col_cnt)=tempo_npr_int
            tempo_no2_col_npr_mdl(omi_no2_col_cnt)=tempo_npr_mdl
            tempo_no2_col_amf(omi_no2_col_cnt)=tempo_amf
            tempo_no2_col_prs(tempo_no2_col_cnt,1:tempo_npr_intp)=tempo_prs(1:tempo_npr_intp)
            tempo_no2_col_scwt(tempo_no2_col_cnt,1:tempo_npr_int)=tempo_scwt(1:tempo_npr_int)
            tempo_no2_col_err_var(tempo_no2_col_cnt)=err_var
            tempo_no2_col_day(tempo_no2_col_cnt)=obs_day
            tempo_no2_col_sec(tempo_no2_col_cnt)=obs_sec
      end select
   enddo
   deallocate(obs_kind,obs_kind_id)
   close(iunit)
end subroutine get_obs_seq_ens_data
!
subroutine bias_correction(maxnobs,cnt,obs_val,err_var,prior_mean,prior_sprd,correction)
   implicit none
   integer :: maxnobs,cnt,icnt
   real :: prior_var,sum,correction
   real,dimension(maxnobs) :: obs_val,err_var,prior_mean,prior_sprd
   sum=0.
   do icnt=1,cnt
!      prior_var = prior_sprd(icnt)*prior_sprd(icnt)
!      sum = sum + (prior_mean(icnt)/prior_var - obs_val(icnt)/err_var(icnt)) / &
!      (1./prior_var + 1./err_var(icnt))
      sum = sum + (prior_mean(icnt)-obs_val(icnt))
   enddo
   correction=sum / real(cnt)
end subroutine bias_correction
!
