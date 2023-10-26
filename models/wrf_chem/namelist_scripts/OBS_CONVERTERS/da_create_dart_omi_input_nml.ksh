#!/bin/ksh -x
#
# DART software - Copyright UCAR. This open source software is provided
# by UCAR, "as is", without charge, subject to all terms of use at
# http://www.image.ucar.edu/DAReS/DART/DART_download

#########################################################################
#
# Purpose: Script to create DART/WRF input.nml for 
# omi_o3_ascii_to_obs_seq fortran format conversion 
#
#########################################################################
#
# CREATE DART/WRF NAMELIST FILE
rm -f input.nml
touch input.nml
cat > input.nml << EOF
&create_omi_obs_nml
   filedir                     = ${NL_FILEDIR}
   filename                    = ${NL_FILENAME}
   fileout                     = ${NL_FILEOUT}
   year                        = ${NL_YEAR}
   month                       = ${NL_MONTH}
   day                         = ${NL_DAY}
   hour                        = ${NL_HOUR}
   bin_beg_sec                 = ${NL_BIN_BEG_SEC}
   bin_end_sec                 = ${NL_BIN_END_SEC}
   fac_obs_error               = ${NL_FAC_OBS_ERROR}
   use_log_o3                  = ${NL_USE_LOG_O3}
   use_log_no2                 = ${NL_USE_LOG_NO2}
   use_log_so2                 = ${NL_USE_LOG_SO2}
   use_log_hcho                = ${NL_USE_LOG_HCHO}
   lon_min                     = ${NNL_MIN_LON}
   lon_max                     = ${NNL_MAX_LON}
   lat_min                     = ${NNL_MIN_LAT}
   lat_max                     = ${NNL_MAX_LAT}
   path_model                  = ${NL_PATH_MODEL}
   file_model                  = ${NL_FILE_MODEL}
   nx_model                    = ${NL_NX_MODEL}
   ny_model                    = ${NL_NY_MODEL}
   nz_model                    = ${NL_NZ_MODEL}
   obs_o3_reten_freq           = ${NL_OMI_O3_RETEN_FREQ}
   obs_no2_reten_freq          = ${NL_OMI_NO2_RETEN_FREQ}
   obs_so2_reten_freq          = ${NL_OMI_SO2_RETEN_FREQ}
   obs_hcho_reten_freq         = ${NL_OMI_HCHO_RETEN_FREQ}
/
&obs_sequence_nml
   write_binary_obs_sequence   = .false.
/
&obs_kind_nml
/
&assim_model_nml
   write_binary_restart_files  =.true.
/
&model_nml
/
&location_nml
/
&utilities_nml
   TERMLEVEL                   = 1,
   logfilename                 = 'dart_log.out',
/
&preprocess_nml
   input_obs_kind_mod_file     = '../../assimilation_code/modules/observations/DEFAULT_obs_kind_mod.F90',
   output_obs_kind_mod_file    = '../../assimilation_code/modules/observations/obs_kind_mod.f90',
   input_obs_def_mod_file      = '../../observations/forward_operators/DEFAULT_obs_def_mod.F90',
   output_obs_def_mod_file     = '../../observations/forward_operators/obs_def_mod.f90',
   input_files                 = '../../observations/forward_operators/obs_def_reanalysis_bufr_mod.f90',
                                 '../../observations/forward_operators/obs_def_gps_mod.f90',
                                 '../../observations/forward_operators/obs_def_eval_mod.f90'
/
&merge_obs_seq_nml
   num_input_files             = 2,
   filename_seq                = 'obs_seq2008022206',obs_seq2008022212',
   filename_out                = 'obs_seq_ncep_2008022212'
/
 &obs_def_OMI_O3_nml
   use_log_o3   = ${NL_USE_LOG_O3:-.false.},
   nlayer_model = ${NL_NLAYER_MODEL:-36},
   nlayer_omi_o3_total_col = ${NL_NLAYER_OMI_O3_TOTAL_COL:-11},
   nlayer_omi_o3_trop_col  = ${NL_NLAYER_OMI_O3_TROP_COL:-11},
   nlayer_omi_o3_profile   = ${NL_NLAYER_OMI_O3_PROFILE:-11},
/
 &obs_def_OMI_NO2_nml
   use_log_no2   = ${NL_USE_LOG_NO2:-.false.},
   nlayer_model  = ${NL_NLAYER_MODEL:-36},
   nlayer_omi_no2_total_col  = ${NL_NLAYER_OMI_NO2_TOTAL_COL:-35},
   nlayer_omi_no2_trop_col   = ${NL_NLAYER_OMI_NO2_TROP_COL:-35},
/
 &obs_def_OMI_SO2_nml
   use_log_so2   = ${NL_USE_LOG_SO2:-.false.},
   nlayer_model   = ${NL_NLAYER_MODEL:-36},
   nlayer_omi_so2_total_col   = ${NL_NLAYER_OMI_SO2_TOTAL_COL:-72},
   nlayer_omi_so2_pbl_col   = ${NL_NLAYER_OMI_SO2_PBL_COL:-72},
/
 &obs_def_OMI_HCHO_nml
   use_log_hcho   = ${NL_USE_LOG_HCHO:-.false.},
   nlayer_model  = ${NL_NLAYER_MODEL:-36},
   nlayer_omi_hcho_total_col  = ${NL_NLAYER_OMI_HCHO_TOTAL_COL:-35},
   nlayer_omi_hcho_trop_col   = ${NL_NLAYER_OMI_HCHO_TROP_COL:-35},
/ 
EOF

