#!/bin/ksh -x
#
# DART software - Copyright UCAR. This open source software is provided
# by UCAR, "as is", without charge, subject to all terms of use at
# http://www.image.ucar.edu/DAReS/DART/DART_download

#########################################################################
#
# Purpose: Script to create DART/WRF Namelist 

#########################################################################
#
# CREATE DART/WRF NAMELIST FILE
rm -f input.nml
touch input.nml
cat > input.nml << EOF
&obs_sequence_tool_nml
   num_input_files           = ${NL_NUM_INPUT_FILES}
   filename_seq              = ${NL_FILENAME_SEQ},
   filename_out              = ${NL_FILENAME_OUT},
   first_obs_days            = ${NL_FIRST_OBS_DAYS},
   first_obs_seconds         = ${NL_FIRST_OBS_SECONDS},
   last_obs_days             = ${NL_LAST_OBS_DAYS},
   last_obs_seconds          = ${NL_LAST_OBS_SECONDS},
   obs_types                 = '',
   keep_types                =.false.,
   print_only                =.false.,
   synonymous_copy_list      = ${NL_SYNONYMOUS_COPY_LIST},
   synonymous_qc_list        = ${NL_SYNONYMOUS_QC_LIST},
   min_lat                   = -90.0, 
   max_lat                   = 90.0, 
   min_lon                   = 0.0, 
   max_lon                   = 360.0,
/
&obs_kind_nml
   assimilate_these_obs_types = ${NL_ASSIMILATE_THESE_OBS_TYPES},
/
 &location_nml
   horiz_dist_only                 = ${NL_HORIZONTAL_DIST_ONLY},
   vert_normalization_pressure     = ${NL_VERT_NORMALIZATION_PRESSURE},
   vert_normalization_height       = ${NL_VERT_NORMALIZATION_HEIGHT},
   vert_normalization_level        = ${NL_VERT_NORMALIZATION_LEVELS},
   approximate_distance            = .false,
   nlon                            = ${NNXP_STAG_CR},
   nlat                            = ${NNYP_STAG_CR},
   output_box_info                 = .false.,
/
 &obs_sequence_nml
   write_binary_obs_sequence   = .false.,
/
 &utilities_nml
   TERMLEVEL                   = 1,
   logfilename                 = 'dart_log.out',
   nmlfilename                 = 'dart_log.nml',
   write_nml                   = 'file',
   module_details              = .false.
/
 &obs_def_MOPITT_CO_nml
   MOPITT_CO_retrieval_type   = ${NL_MOPITT_CO_RETRIEVAL_TYPE:-'RETR'},
   use_log_co   = ${NL_USE_LOG_CO:-.false.},
   nlayer_model   = ${NL_NLAYER_MODEL:-36},
   nlayer_mopitt_co_total_col   = ${NL_NLAYER_MOPITT_CO_TOTAL_COL:-15},
   nlayer_mopitt_co_profile   = ${NL_NLAYER_MOPITT_CO_PROFILE:-15},
/
 &obs_def_IASI_CO_nml
   IASI_CO_retrieval_type   = ${NL_IASI_CO_RETRIEVAL_TYPE:-'RAWR'},
   use_log_co   = ${NL_USE_LOG_CO:-.false.},
   nlayer_model   = ${NL_NLAYER_MODEL:-36},
   nlayer_iasi_co_total_col   = ${NL_NLAYER_IASI_CO_TOTAL_COL:-15},
   nlayer_iasi_co_profile   = ${NL_NLAYER_IASI_CO_PROFILE:-15},
/
 &obs_def_IASI_O3_nml
   IASI_O3_retrieval_type   = ${NL_IASI_O3_RETRIEVAL_TYPE:-'RAWR'},
   use_log_o3   = ${NL_USE_LOG_o3:-.false.},
   nlayer_model   = ${NL_NLAYER_MODEL:-36},
   nlayer_iasi_o3_profile   = ${NL_NLAYER_IASI_CO_PROFILE:-15},
/
 &obs_def_MODIS_AOD_nml
   use_log_aod   = ${NL_USE_LOG_AOD:-.false.},
/
 &obs_def_OMI_O3_nml
   use_log_o3   = ${NL_USE_LOG_O3:-.false.},
   nlayer_model   = ${NL_NLAYER_MODEL:-36},
   nlayer_omi_o3_total_col   = ${NL_NLAYER_OMI_O3_TOTAL_COL:-15},
   nlayer_omi_o3_trop_col   = ${NL_NLAYER_OMI_O3_TROP_COL:-15},
   nlayer_omi_o3_profile   = ${NL_NLAYER_OMI_O3_PROFILE:-15},
/
 &obs_def_OMI_NO2_nml
   use_log_no2   = ${NL_USE_LOG_NO2:-.false.},
   nlayer_model   = ${NL_NLAYER_MODEL:-36},
   nlayer_omi_no2_total_col  = ${NL_NLAYER_OMI_NO2_TOTAL_COL:-40},
   nlayer_omi_no2_trop_col   = ${NL_NLAYER_OMI_NO2_TROP_COL:-40},
/
 &obs_def_OMI_SO2_nml
   use_log_so2   = ${NL_USE_LOG_SO2:-.false.},
   nlayer_model   = ${NL_NLAYER_MODEL:-36},
   nlayer_omi_so2_total_col   = ${NL_NLAYER_OMI_SO2_TOTAL_COL:-75},
   nlayer_omi_so2_pbl_col   = ${NL_NLAYER_OMI_SO2_PBLCOL:-75},
/
 &obs_def_OMI_HCHO_nml
   use_log_hcho   = ${NL_USE_LOG_HCHO:-.false.},
   nlayer_model   = ${NL_NLAYER_MODEL:-36},
   nlayer_omi_hcho_total_col  = ${NL_NLAYER_OMI_HCHO_TOTAL_COL:-40},
   nlayer_omi_hcho_trop_col   = ${NL_NLAYER_OMI_HCHO_TROP_COL:-40},
/
 &obs_def_TROPOMI_CO_nml
   use_log_co   = ${NL_USE_LOG_CO:-.false.},
   nlayer_model   = ${NL_NLAYER_MODEL:-36},
   nlayer_tropomi_co_total_col   = ${NL_NLAYER_TROPOMI_CO_TOTAL_COL:-55},
/
 &obs_def_TROPOMI_O3_nml
   use_log_o3   = ${NL_USE_LOG_O3:-.false.},
   nlayer_model   = ${NL_NLAYER_MODEL:-36},
   nlayer_tropomi_o3_total_col = ${NL_NLAYER_TROPOMI_O3_TOTAL_COL:-20},
   nlayer_tropomi_o3_trop_col  = ${NL_NLAYER_TROPOMI_O3_TROP_COL:-20},
   nlayer_tropomi_o3_profile   = ${NL_NLAYER_TROPOMI_O3_PROFILE:-20},
   nlayer_tropomi_o3_cpsr      = ${NL_NLAYER_TROPOMI_O3_CPSR:-20},
/
 &obs_def_TROPOMI_NO2_nml
   use_log_no2   = ${NL_USE_LOG_NO2:-.false.},
   nlayer_model   = ${NL_NLAYER_MODEL:-36},
   nlayer_tropomi_no2_total_col  = ${NL_NLAYER_TROPOMI_NO2_TOTAL_COL:-40},
   nlayer_tropomi_no2_trop_col   = ${NL_NLAYER_TROPOMI_NO2_TROP_COL:-40},
/
 &obs_def_TROPOMI_SO2_nml
   use_log_so2   = ${NL_USE_LOG_SO2:-.false.},
   nlayer_model   = ${NL_NLAYER_MODEL:-36},
   nlayer_tropomi_so2_total_col  = ${NL_NLAYER_TROPOMI_SO2_TOTAL_COL:-40},
   nlayer_tropomi_so2_pbl_col    = ${NL_NLAYER_TROPOMI_SO2_PBL_COL:-40},
/
 &obs_def_TROPOMI_CH4_nml
   use_log_ch4   = ${NL_USE_LOG_CH4:-.false.},
   nlayer_model   = ${NL_NLAYER_MODEL:-36},
   nlayer_tropomi_ch4_total_col  = ${NL_NLAYER_TROPOMI_CH4_TOTAL_COL:-40},
   nlayer_tropomi_ch4_trop_col   = ${NL_NLAYER_TROPOMI_CH4_TROP_COL:-40},
   nlayer_tropomi_ch4_profile   = ${NL_NLAYER_TROPOMI_CH4_PROFILE:-40},
/
 &obs_def_TROPOMI_HCHO_nml
   use_log_hcho   = ${NL_USE_LOG_HCHO:-.false.},
   nlayer_model   = ${NL_NLAYER_MODEL:-36},
   nlayer_tropomi_hcho_total_col  = ${NL_NLAYER_TROPOMI_HCHO_TOTAL_COL:-40},
   nlayer_tropomi_hcho_trop_col   = ${NL_NLAYER_TROPOMI_HCHO_TROP_COL:-40},
/
 &obs_def_TEMPO_O3_nml
   use_log_o3   = ${NL_USE_LOG_O3:-.false.},
   nlayer_model   = ${NL_NLAYER_MODEL:-36},
   nlayer_tempo_o3_total_col   = ${NL_NLAYER_TEMPO_O3_TOTAL_COL:-50},
   nlayer_tempo_o3_trop_col   = ${NL_NLAYER_TEMPO_O3_TROP_COL:-50},
   nlayer_tempo_o3_profile   = ${NL_NLAYER_TEMPO_O3_PROFILE:-50},
/
 &obs_def_TES_CO_nml
   use_log_co   = ${NL_USE_LOG_CO:-.false.},
   nlayer_model   = ${NL_NLAYER_MODEL:-36},
   nlayer_tes_co_total_col  = ${NL_NLAYER_TES_CO_TOTAL_COL:-50},
   nlayer_tes_co_trop_col   = ${NL_NLAYER_TES_CO_TROP_COL:-50},
   nlayer_tes_co_profile    = ${NL_NLAYER_TES_CO_PROFILE:-50},
/
 &obs_def_TES_CO2_nml
   use_log_co2   = ${NL_USE_LOG_CO2:-.false.},
   nlayer_model   = ${NL_NLAYER_MODEL:-36},
   nlayer_tes_co2_total_col  = ${NL_NLAYER_TES_CO2_TOTAL_COL:-50},
   nlayer_tes_co2_trop_col   = ${NL_NLAYER_TES_CO2_TROP_COL:-50},
   nlayer_tes_co2_profile    = ${NL_NLAYER_TES_CO2_PROFILE:-50},
/
 &obs_def_TES_O3_nml
   use_log_o3   = ${NL_USE_LOG_O3:-.false.},
   nlayer_model   = ${NL_NLAYER_MODEL:-36},
   nlayer_tes_o3_total_col  = ${NL_NLAYER_TES_O3_TOTAL_COL:-50},
   nlayer_tes_o3_trop_col   = ${NL_NLAYER_TES_O3_TROP_COL:-50},
   nlayer_tes_o3_profile    = ${NL_NLAYER_TES_O3_PROFILE:-50},
/
 &obs_def_TES_NH3_nml
   use_log_nh3   = ${NL_USE_LOG_NH3:-.false.},
   nlayer_model   = ${NL_NLAYER_MODEL:-36},
   nlayer_tes_nh3_total_col  = ${NL_NLAYER_TES_NH3_TOTAL_COL:-50},
   nlayer_tes_nh3_trop_col   = ${NL_NLAYER_TES_NH3_TROP_COL:-50},
   nlayer_tes_nh3_profile    = ${NL_NLAYER_TES_NH3_PROFILE:-50},
/
 &obs_def_TES_CH4_nml
   use_log_ch4   = ${NL_USE_LOG_CH4:-.false.},
   nlayer_model   = ${NL_NLAYER_MODEL:-36},
   nlayer_tes_ch4_total_col  = ${NL_NLAYER_TES_CH4_TOTAL_COL:-50},
   nlayer_tes_ch4_trop_col   = ${NL_NLAYER_TES_CH4_TROP_COL:-50},
   nlayer_tes_ch4_profile    = ${NL_NLAYER_TES_CH4_PROFILE:-50},
/
 &obs_def_CRIS_CO_nml
   use_log_co   = ${NL_USE_LOG_CO:-.false.},
   nlayer_model   = ${NL_NLAYER_MODEL:-36},
   nlayer_cris_co_total_col  = ${NL_NLAYER_CRIS_CO_TOTAL_COL:-50},
   nlayer_cris_co_trop_col   = ${NL_NLAYER_CRIS_CO_TROP_COL:-50},
   nlayer_cris_co_profile    = ${NL_NLAYER_CRIS_CO_PROFILE:-50},
/
 &obs_def_CRIS_O3_nml
   use_log_o3   = ${NL_USE_LOG_O3:-.false.},
   nlayer_model   = ${NL_NLAYER_MODEL:-36},
   nlayer_cris_o3_total_col  = ${NL_NLAYER_CRIS_O3_TOTAL_COL:-50},
   nlayer_cris_o3_trop_col   = ${NL_NLAYER_CRIS_O3_TROP_COL:-50},
   nlayer_cris_o3_profile    = ${NL_NLAYER_CRIS_O3_PROFILE:-50},
/
 &obs_def_CRIS_NH3_nml
   use_log_nh3   = ${NL_USE_LOG_NH3:-.false.},
   nlayer_model   = ${NL_NLAYER_MODEL:-36},
   nlayer_cris_nh3_total_col  = ${NL_NLAYER_CRIS_NH3_TOTAL_COL:-50},
   nlayer_cris_nh3_trop_col   = ${NL_NLAYER_CRIS_NH3_TROP_COL:-50},
   nlayer_cris_nh3_profile    = ${NL_NLAYER_CRIS_NH3_PROFILE:-50},
/
 &obs_def_CRIS_CH4_nml
   use_log_ch4   = ${NL_USE_LOG_CH4:-.false.},
   nlayer_model   = ${NL_NLAYER_MODEL:-36},
   nlayer_cris_ch4_total_col  = ${NL_NLAYER_CRIS_CH4_TOTAL_COL:-50},
   nlayer_cris_ch4_trop_col   = ${NL_NLAYER_CRIS_CH4_TROP_COL:-50},
   nlayer_cris_ch4_profile    = ${NL_NLAYER_CRIS_CH4_PROFILE:-50},
/
 &obs_def_CRIS_PAN_nml
   use_log_pan   = ${NL_USE_LOG_PAN:-.false.},
   nlayer_model   = ${NL_NLAYER_MODEL:-36},
   nlayer_cris_pan_total_col  = ${NL_NLAYER_CRIS_PAN_TOTAL_COL:-50},
   nlayer_cris_pan_trop_col   = ${NL_NLAYER_CRIS_PAN_TROP_COL:-50},
   nlayer_cris_pan_profile    = ${NL_NLAYER_CRIS_PAN_PROFILE:-50},
/
 &obs_def_SCIAM_NO2_nml
   use_log_no2   = ${NL_USE_LOG_NO2:-.false.},
   nlayer_model   = ${NL_NLAYER_MODEL:-36},
   nlayer_sciam_no2_total_col  = ${NL_NLAYER_SCIAM_NO2_TOTAL_COL:-50},
   nlayer_sciam_no2_trop_col   = ${NL_NLAYER_SCIAM_NO2_TROP_COL:-50},
/
 &obs_def_GOME2A_NO2_nml
   use_log_no2   = ${NL_USE_LOG_NO2:-.false.},
   nlayer_model   = ${NL_NLAYER_MODEL:-36},
   nlayer_gome2a_no2_total_col  = ${NL_NLAYER_GOME2A_NO2_TOTAL_COL:-50},
   nlayer_gome2a_no2_trop_col   = ${NL_NLAYER_GOME2A_NO2_TROP_COL:-50},
/
 &obs_def_MLS_O3_nml
   use_log_o3   = ${NL_USE_LOG_O3:-.false.},
   nlayer_model   = ${NL_NLAYER_MODEL:-36},
   nlayer_mls_o3_total_col  = ${NL_NLAYER_MLS_O3_TOTAL_COL:-50},
   nlayer_mls_o3_trop_col   = ${NL_NLAYER_MLS_O3_TROP_COL:-50},
   nlayer_mls_o3_profile    = ${NL_NLAYER_MLS_O3_PROFILE:-50},
/
 &obs_def_MLS_HNO3_nml
   use_log_hno3   = ${NL_USE_LOG_HNO3:-.false.},
   nlayer_model   = ${NL_NLAYER_MODEL:-36},
   nlayer_mls_hno3_total_col  = ${NL_NLAYER_MLS_HNO3_TOTAL_COL:-50},
   nlayer_mls_hno3_trop_col   = ${NL_NLAYER_MLS_HNO3_TROP_COL:-50},
   nlayer_mls_hno3_profile    = ${NL_NLAYER_MLS_HNO3_PROFILE:-50},
/
 &obs_def_OMI_NO2_DOMINO_nml
   use_log_no2   = ${NL_USE_LOG_NO2:-.false.},
   nlayer_model   = ${NL_NLAYER_MODEL:-36},
   nlayer_omi_no2_domino_total_col  = ${NL_NLAYER_OMI_NO2_DOMINO_TOTAL_COL:-50},
   nlayer_omi_no2_domino_trop_col   = ${NL_NLAYER_OMI_NO2_DOMINO_TROP_COL:-50},
/
 &obs_def_TEMPO_NO2_nml
   use_log_no2   = ${NL_USE_LOG_NO2:-.false.},
   nlayer_model   = ${NL_NLAYER_MODEL:-36},
   nlayer_tempo_no2_total_col  = ${NL_NLAYER_TEMPO_NO2_TOTAL_COL:-50},
   nlayer_tempo_no2_trop_col   = ${NL_NLAYER_TEMPO_NO2_TROP_COL:-50},
/
 &obs_def_AIRNOW_PM10_nml
   use_log_pm10   = ${NL_USE_LOG_PM10:-.false.},
/
 &obs_def_AIRNOW_PM25_nml
   use_log_pm25   = ${NL_USE_LOG_PM25:-.false.},
/
EOF

