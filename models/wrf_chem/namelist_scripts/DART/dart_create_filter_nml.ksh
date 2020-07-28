#!/bin/ksh -x
#########################################################################
#
# Purpose: Create DART &filter_nml 
#
#########################################################################
#
# Generate namelist section
rm -f input.nml_temp
touch input.nml_temp
cat > input.nml_temp << EOF
 &filter_nml
   ens_size                     = ${NL_ENS_SIZE:-3},
   num_groups                   = ${NL_NUM_GROUPS:-1},
   inf_flavor                   = ${NL_INF_FLAVOR_PRIOR:-0}, ${NL_INF_FLAVOR_POST:-0},
   inf_initial_from_restart     = ${NL_INF_INITIAL_FROM_RESTART_PRIOR:-.false.}, ${NL_INF_INITIAL_FROM_RESTART_POST:-.false.},
   inf_initial                  = ${NL_INF_INITIAL_PRIOR:-1.00}, ${NL_INF_INITIAL_POST:-1.00},
   inf_lower_bound              = ${NL_INF_LOWER_BOUND_PRIOR:-1.0}, ${NL_INF_LOWER_BOUND_POST:-1.0},
   inf_upper_bound              = ${NL_INF_UPPER_BOUND_PRIOR:-1000000.0}, ${NL_INF_UPPER_BOUND_POST:-1000000.0},
   inf_sd_initial_from_restart  = ${NL_INF_SD_INITIAL_FROM_RESTART_PRIOR:-.false.}, ${NL_INF_SD_INITIAL_FROM_RESTART_POST:-.false.},
   inf_sd_initial               = ${NL_INF_SD_INITIAL_PRIOR:-0.60}, ${NL_INF_SD_INITIAL_POST:-0.0},
   inf_sd_lower_bound           = ${NL_INF_SD_LOWER_BOUND_PRIOR:-0.60}, ${NL_INF_SD_LOWER_BOUND_POST:-0.0},
   inf_damping                  = ${NL_INF_DAMPING_PRIOR:-0.90}, ${NL_INF_DAMPING_POST:-1.00},
   inf_deterministic            = ${NL_INF_DETERMINISTIC_PRIOR:-.true.}, ${NL_INF_DETERMINISTIC_POST:-.true.},
   obs_sequence_in_name         = ${NL_OBS_SEQUENCE_IN_NAME:-'obs_seq.out'},
   obs_sequence_out_name        = ${NL_OBS_SEQUENCE_OUT_NAME:-'obs_seq.final'},
   first_obs_days               = ${NL_FIRST_OBS_DAYS:-148816},
   first_obs_seconds            = ${NL_FIRST_OBS_SECONDS:-75601},
   last_obs_days                = ${NL_LAST_OBS_DAYS:-148817},
   last_obs_seconds             = ${NL_LAST_OBS_SECONDS:-10800},
   num_output_obs_members       = ${NL_NUM_OUTPUT_OBS_MEMBERS:-0},
   num_output_state_members     = ${NL_NUM_OUTPUT_STATE_MEMBERS:-0},
   adv_ens_command              = ${NL_ADV_ENS_COMMAND:-'./advance_model.csh'},
   trace_execution              = ${NL_TRACE_EXECUTION:-.true.},
   output_timestamps            = ${NL_PUTPUT_TIMESTAMPS:-.true.},
   output_forward_op_errors     = ${NL_OUTPUT_FORWARD_OP_ERRORS:-.false.},
   init_time_days               = ${NL_INIT_TIME_DAYS:--1},
   init_time_seconds            = ${NL_INIT_TIME_SECONDS:--1},
   compute_posterior            = ${NL_COMPUTE_POSTERIOR:-.false.},
   distributed_state            = ${NL_DISTRIBUTED_STATE:-.true.},
   inf_sd_max_change            = ${NL_INF_SD_MAX_CHANGE:-1.05},${NL_INF_SD_MAX_CHANGE:-1.05},
   input_state_file_list        = ${NL_INPUT_STATE_FILE_LIST:-'input_list.txt'},
   input_state_files            = ${NL_INPUT_STATE_FILES:-''},
   output_mean                  = ${NL_OUTPUT_MEAN:-.true.},
   output_sd                    = ${NL_OUTPUT_SD:-.true.},
   output_state_file_list       = ${NL_OUTPUT_STATE_FILE_LIST:-'output_list.txt'},
   output_state_files           = ${NL_OUTPUT_STATE_FILES:-''},
   output_members               = ${NL_OUTPUT_MEMBERS:-.true.},
   output_interval              = ${NL_OUTPUT_INTERVAL:-1},
   perturb_from_single_instance = ${NL_PERTURB_FROM_SINGLE_INSTANCE:-.false.},
   silence                      = ${NL_SILENCE:-.false.},
   single_file_in               = ${NL_SINGLE_FILE_IN:-.false.},
   single_file_out              = ${NL_SINGLE_FILE_OUT:-.false.},
   stages_to_write              = 'preassim','output',
   write_all_stages_at_end      = ${NL_WRITE_ALL_STAGES_AT_END:-.false.},
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


