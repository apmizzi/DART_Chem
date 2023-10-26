#!/bin/ksh -x
#########################################################################
#
# Purpose: Create DART &perfect_model_obs_nml 
#
#########################################################################
#
# Generate namelist section
rm -f input.nml_temp
touch input.nml_temp
cat > input.nml_temp << EOF
&perfect_model_obs_nml
   first_obs_days               = ${NL_FIRST_OBS_DAYS:-148816},
   first_obs_seconds            = ${NL_FIRST_OBS_SECONDS:-75601},
   init_time_days               = ${NL_INIT_TIME_DAYS:--1},
   init_time_seconds            = ${NL_INIT_TIME_SECONDS:--1},
   last_obs_days                = ${NL_LAST_OBS_DAYS:-148817},
   obs_seq_in_file_name         = ${NL_OBS_SEQ_IN_FILE_NAME:-'obs_seq.in'},
   obs_seq_out_file_name        = ${NL_OBS_SEQ_OUT_FILE_NAME:-'obs_seq.out'},
   output_forward_op_errors     = ${NL_OUTPUT_FORWARD_OP_ERRORS:-.false.},
   output_timestamps            = ${NL_OUTPUT_TIMESTAMPS:-.false.},
   print_every_nth_obs          = ${NL_PRINT_EVERY_NTH_OBS:--1},
   trace_execution              = ${NL_TRACE_EXECUTION:-.false.},
   input_state_files            = ${NL_INPUT_STATE_FILES:-'wrfinput_d01'},
   output_state_files           = ${NL_OUTPUT_STATE_FILES:-''},
   read_input_state_from_file   = ${NL_READ_INPUT_STATE:-.true.},
   write_output_state_to_file   = ${NL_WRITE_OUTPUT_STATE:-.false.},
/ 
EOF
#
# Append namelist section to input.nml
if [[ -f input.nml ]]; then
   cat input.nml_temp >> input.nml
   rm input.nml_temp
else
   mv input.nml_temp input.nml
fi


