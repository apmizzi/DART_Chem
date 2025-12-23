#!/bin/ksh -x
#
# DART software - Copyright UCAR. This open source software is provided
# by UCAR, "as is", without charge, subject to all terms of use at
# http://www.image.ucar.edu/DAReS/DART/DART_download

#########################################################################
#
# Purpose: Script to create DART/WRF input.nmlfor Ave's 
# mopitt_ascii_to_obs_seq fortran format conversion 
#
#########################################################################
#
# CREATE DART/WRF NAMELIST FILE
rm -f input.nml
touch input.nml
cat > input.nml << EOF
&create_mopitt_obs_nml
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
   use_log_co                  = ${NL_USE_LOG_CO}
   lon_min                     = ${NL_MIN_LON}
   lon_max                     = ${NL_MAX_LON}
   lat_min                     = ${NL_MIN_LAT}
   lat_max                     = ${NL_MAX_LAT}
   path_model                  = ${NL_PATH_MODEL}
   file_model                  = ${NL_FILE_MODEL}
   nx_model                    = ${NL_NX_MODEL}
   ny_model                    = ${NL_NY_MODEL}
   nz_model                    = ${NL_NZ_MODEL}
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
&obs_def_MOPITT_CO_nml
   use_log_co                  = ${NL_USE_LOG_CO:-.false.},
   nlayer_model                = ${NL_NLAYER_MODEL:-36},
   nlayer_mopitt_co_total_col  = ${NL_NLAYER_MOPITT_CO_TOTAL_COL:-10},
   nlayer_mopitt_co_trop_col   = ${NL_NLAYER_MOPITT_CO_TROP_COL:-10},
   nlayer_mopitt_co_profile    = ${NL_NLAYER_MOPITT_CO_PROFILE:-10},
/ 
&obs_def_IASI_CO_nml
   IASI_CO_retrieval_type      = ${NL_IASI_CO_RETRIEVAL_TYPE:-'RETR'},
   use_log_co                  = ${NL_USE_LOG_CO:-.false.},
   nlayer_model                = ${NL_NLAYER_MODEL:-36},
   nlayer_iasi_co_total_col    = ${NL_NLAYER_IASI_CO_TOTAL_COL:-19},
   nlayer_iasi_co_profile      = ${NL_NLAYER_IASI_CO_PROFILE:-19},
/
&obs_def_IASI_O3_nml
   IASI_O3_retrieval_type      = ${NL_IASI_O3_RETRIEVAL_TYPE:-'RETR'},
   use_log_o3                  = ${NL_USE_LOG_O3:-.false.},
   nlayer_model                = ${NL_NLAYER_MODEL:-36},
   nlayer_iasi_o3_profile      = ${NL_NLAYER_IASI_O3_PROFILE:-19},
/ 
EOF

