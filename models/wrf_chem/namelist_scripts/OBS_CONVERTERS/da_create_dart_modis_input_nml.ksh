#!/bin/ksh -x
#
# DART software - Copyright UCAR. This open source software is provided
# by UCAR, "as is", without charge, subject to all terms of use at
# http://www.image.ucar.edu/DAReS/DART/DART_download

#########################################################################
#
# Purpose: Script to create DART/WRF input.nmlfor Ave's 
# iasi_ascii_to_obs_seq fortran format conversion 
#
#########################################################################
#
# CREATE DART/WRF NAMELIST FILE
rm -f create_modis_obs_nml.nl
touch create_modis_obs_nml.nl
cat > create_modis_obs_nml.nl << EOF
&create_modis_obs_nml
   beg_year=${BIN_BEG_YR}
   beg_mon=${BIN_BEG_MM}
   beg_day=${BIN_BEG_DD}
   beg_hour=${BIN_BEG_HH}
   beg_min=${BIN_BEG_MN}
   beg_sec=${BIN_BEG_SS}
   end_year=${BIN_END_YR}
   end_mon=${BIN_END_MM}
   end_day=${BIN_END_DD}
   end_hour=${BIN_END_HH}
   end_min=${BIN_END_MN}
   end_sec=${BIN_END_SS}
   file_in=${NL_FILENAME}
   lat_mn=${NL_LAT_MN}
   lat_mx=${NL_LAT_MX}
   lon_mn=${NL_LON_MN}
   lon_mx=${NL_LON_MX}
   fac_obs_error= ${NL_FAC_OBS_ERROR}
   use_log_aod=${NL_USE_LOG_AOD}
/
EOF
#
rm -f input.nml
touch input.nml
cat > input.nml << EOF
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
EOF

