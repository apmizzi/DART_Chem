#!/bin/ksh -x
#########################################################################
#
# Purpose: Create DART input,nml 
#
#########################################################################
#
echo off
${DART_DIR}/models/wrf_chem/namelist_scripts/DART/dart_create_assim_model_nml.ksh
${DART_DIR}/models/wrf_chem/namelist_scripts/DART/dart_create_assim_tools_nml.ksh
${DART_DIR}/models/wrf_chem/namelist_scripts/DART/dart_create_cov_cutoff_nml.ksh
${DART_DIR}/models/wrf_chem/namelist_scripts/DART/dart_create_filter_nml.ksh
${DART_DIR}/models/wrf_chem/namelist_scripts/DART/dart_create_location_nml.ksh
${DART_DIR}/models/wrf_chem/namelist_scripts/DART/dart_create_model_nml.ksh
${DART_DIR}/models/wrf_chem/namelist_scripts/DART/dart_create_obs_def_radar_mod_nml.ksh
${DART_DIR}/models/wrf_chem/namelist_scripts/DART/dart_create_obs_diag_nml_prs_levels.ksh
${DART_DIR}/models/wrf_chem/namelist_scripts/DART/dart_create_obs_kind_nml.ksh
${DART_DIR}/models/wrf_chem/namelist_scripts/DART/dart_create_obs_selection_nml.ksh
${DART_DIR}/models/wrf_chem/namelist_scripts/DART/dart_create_obs_seq_coverage_nml.ksh
${DART_DIR}/models/wrf_chem/namelist_scripts/DART/dart_create_obs_seq_to_netcdf_nml.ksh
${DART_DIR}/models/wrf_chem/namelist_scripts/DART/dart_create_obs_sequence_nml.ksh
${DART_DIR}/models/wrf_chem/namelist_scripts/DART/dart_create_obs_sequence_tool_nml.ksh
${DART_DIR}/models/wrf_chem/namelist_scripts/DART/dart_create_perfect_model_obs_nml.ksh
${DART_DIR}/models/wrf_chem/namelist_scripts/DART/dart_create_preprocess_nml.ksh
${DART_DIR}/models/wrf_chem/namelist_scripts/DART/dart_create_reg_factor_nml.ksh
${DART_DIR}/models/wrf_chem/namelist_scripts/DART/dart_create_replace_wrf_fields_nml.ksh
${DART_DIR}/models/wrf_chem/namelist_scripts/DART/dart_create_restart_file_utility_nml.ksh
${DART_DIR}/models/wrf_chem/namelist_scripts/DART/dart_create_schedule_nml.ksh
${DART_DIR}/models/wrf_chem/namelist_scripts/DART/dart_create_smoother_nml.ksh
${DART_DIR}/models/wrf_chem/namelist_scripts/DART/dart_create_utilities_nml.ksh
${DART_DIR}/models/wrf_chem/namelist_scripts/DART/dart_create_wrf_obs_preproc_nml.ksh
${DART_DIR}/models/wrf_chem/namelist_scripts/DART/dart_create_obs_def_MOPITT_CO_nml.ksh
${DART_DIR}/models/wrf_chem/namelist_scripts/DART/dart_create_obs_def_IASI_CO_nml.ksh
${DART_DIR}/models/wrf_chem/namelist_scripts/DART/dart_create_obs_def_IASI_O3_nml.ksh
${DART_DIR}/models/wrf_chem/namelist_scripts/DART/dart_create_obs_def_OMI_O3_nml.ksh
${DART_DIR}/models/wrf_chem/namelist_scripts/DART/dart_create_obs_def_OMI_NO2_nml.ksh
${DART_DIR}/models/wrf_chem/namelist_scripts/DART/dart_create_obs_def_OMI_SO2_nml.ksh
${DART_DIR}/models/wrf_chem/namelist_scripts/DART/dart_create_obs_def_OMI_HCHO_nml.ksh
${DART_DIR}/models/wrf_chem/namelist_scripts/DART/dart_create_obs_def_TROPOMI_CO_nml.ksh
${DART_DIR}/models/wrf_chem/namelist_scripts/DART/dart_create_obs_def_TROPOMI_O3_nml.ksh
${DART_DIR}/models/wrf_chem/namelist_scripts/DART/dart_create_obs_def_TROPOMI_NO2_nml.ksh
${DART_DIR}/models/wrf_chem/namelist_scripts/DART/dart_create_obs_def_TROPOMI_SO2_nml.ksh
${DART_DIR}/models/wrf_chem/namelist_scripts/DART/dart_create_obs_def_TROPOMI_CH4_nml.ksh
${DART_DIR}/models/wrf_chem/namelist_scripts/DART/dart_create_obs_def_TROPOMI_HCHO_nml.ksh
${DART_DIR}/models/wrf_chem/namelist_scripts/DART/dart_create_obs_def_TEMPO_O3_nml.ksh
${DART_DIR}/models/wrf_chem/namelist_scripts/DART/dart_create_obs_def_TEMPO_NO2_nml.ksh
${DART_DIR}/models/wrf_chem/namelist_scripts/DART/dart_create_obs_def_TES_CO_nml.ksh
${DART_DIR}/models/wrf_chem/namelist_scripts/DART/dart_create_obs_def_TES_CO2_nml.ksh
${DART_DIR}/models/wrf_chem/namelist_scripts/DART/dart_create_obs_def_TES_O3_nml.ksh
${DART_DIR}/models/wrf_chem/namelist_scripts/DART/dart_create_obs_def_TES_NH3_nml.ksh
${DART_DIR}/models/wrf_chem/namelist_scripts/DART/dart_create_obs_def_TES_CH4_nml.ksh
${DART_DIR}/models/wrf_chem/namelist_scripts/DART/dart_create_obs_def_CRIS_CO_nml.ksh
${DART_DIR}/models/wrf_chem/namelist_scripts/DART/dart_create_obs_def_CRIS_O3_nml.ksh
${DART_DIR}/models/wrf_chem/namelist_scripts/DART/dart_create_obs_def_CRIS_NH3_nml.ksh
${DART_DIR}/models/wrf_chem/namelist_scripts/DART/dart_create_obs_def_CRIS_CH4_nml.ksh
${DART_DIR}/models/wrf_chem/namelist_scripts/DART/dart_create_obs_def_CRIS_PAN_nml.ksh
${DART_DIR}/models/wrf_chem/namelist_scripts/DART/dart_create_obs_def_SCIAM_NO2_nml.ksh
${DART_DIR}/models/wrf_chem/namelist_scripts/DART/dart_create_obs_def_GOME2A_NO2_nml.ksh
${DART_DIR}/models/wrf_chem/namelist_scripts/DART/dart_create_obs_def_MLS_O3_nml.ksh
${DART_DIR}/models/wrf_chem/namelist_scripts/DART/dart_create_obs_def_MLS_HNO3_nml.ksh
${DART_DIR}/models/wrf_chem/namelist_scripts/DART/dart_create_obs_def_OMI_NO2_DOMINO_nml.ksh
${DART_DIR}/models/wrf_chem/namelist_scripts/DART/dart_create_obs_def_AIRNOW_PM10_nml.ksh
${DART_DIR}/models/wrf_chem/namelist_scripts/DART/dart_create_obs_def_AIRNOW_PM25_nml.ksh
${DART_DIR}/models/wrf_chem/namelist_scripts/DART/dart_create_obs_def_MODIS_AOD_nml.ksh
${DART_DIR}/models/wrf_chem/namelist_scripts/DART/dart_create_obs_impact_tool_nml.ksh
${DART_DIR}/models/wrf_chem/namelist_scripts/DART/dart_create_quality_control_nml.ksh
${DART_DIR}/models/wrf_chem/namelist_scripts/DART/dart_create_state_vector_io_nml.ksh
${DART_DIR}/models/wrf_chem/namelist_scripts/DART/dart_create_ensemble_manager_nml.ksh
#echo on
