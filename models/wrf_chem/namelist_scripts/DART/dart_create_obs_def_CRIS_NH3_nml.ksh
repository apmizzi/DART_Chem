#!/bin/ksh -x
#########################################################################
#
# Purpose: Create DART &obs_def_CRIS_NH3_nml 
#
#########################################################################
#
# Generate namelist section
rm -f input.nml_temp
touch input.nml_temp
cat > input.nml_temp << EOF
 &obs_def_CRIS_NH3_nml
   use_log_nh3     = ${NL_USE_LOG_NH3:-.false.},
   nlayer_model   = ${NL_NLAYER_MODEL:-36},
   nlayer_cris_nh3_total_col  = ${NL_NLAYER_CRIS_NH3_TOTAL_COL:-50},
   nlayer_cris_nh3_trop_col   = ${NL_NLAYER_CRIS_NH3_TROP_COL:-50},
   nlayer_cris_nh3_profile    = ${NL_NLAYER_CRIS_NH3_PROFILE:-50},
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


