#!/bin/ksh -x
#########################################################################
#
# Purpose: Create DART &obs_def_CRIS_PAN_nml 
#
#########################################################################
#
# Generate namelist section
rm -f input.nml_temp
touch input.nml_temp
cat > input.nml_temp << EOF
 &obs_def_CRIS_PAN_nml
   use_log_pan     = ${NL_USE_LOG_PAN:-.false.},
   nlayer_model   = ${NL_NLAYER_MODEL:-36},
   nlayer_cris_pan_total_col  = ${NL_NLAYER_CRIS_PAN_TOTAL_COL:-50},
   nlayer_cris_pan_trop_col   = ${NL_NLAYER_CRIS_PAN_TROP_COL:-50},
   nlayer_cris_pan_profile    = ${NL_NLAYER_CRIS_PAN_PROFILE:-50},
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


