#!/bin/ksh -x
#########################################################################
#
# Purpose: Create DART &assim_tools_nml 
#
#########################################################################
#
# Generate namelist section
rm -f input.nml_temp
touch input.nml_temp
cat > input.nml_temp << EOF
 &assim_tools_nml
   filter_kind                     = ${NL_FILTER_KIND:-1},
   cutoff                          = ${NL_CUTOFF:-0.1},
   distribute_mean                 = .false.,
   sort_obs_inc                    = ${NL_SORT_OBS_INC:-.false.},
   spread_restoration              = ${NL_SPREAD_RESTORATION:-.false.},
   sampling_error_correction       = ${NL_SAMPLING_ERROR_CORRECTION:-.false.},
   adaptive_localization_threshold = ${NL_ADAPTIVE_LOCALIZATION_THRESHOLD:--1},
   adaptive_cutoff_floor            = 0.0
   print_every_nth_obs             = ${NL_PRINT_EVERY_NTH_OBS:-1000},
   adjust_obs_impact               = .true.
   obs_impact_filename             = 'control_impact_runtime.table'
   convert_all_obs_verticals_first   = .true.
   convert_all_state_verticals_first = .false.
   special_localization_obs_types  = ${NL_SPECIAL_LOCALIZATION_OBS_TYPES:-''},
   special_localization_cutoffs    = ${NL_SPECIAL_LOCALIZATION_CUTOFFS:-0.0},
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
