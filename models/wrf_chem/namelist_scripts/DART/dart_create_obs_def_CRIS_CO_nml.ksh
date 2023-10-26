#!/bin/ksh -x
#########################################################################
#
# Purpose: Create DART &obs_def_TES_CO_nml 
#
#########################################################################
#
# Generate namelist section
rm -f input.nml_temp
touch input.nml_temp
cat > input.nml_temp << EOF
 &obs_def_CRIS_CO_nml
   use_log_co     = ${NL_USE_LOG_CO:-.false.},
   nlayer_model   = ${NL_NLAYER_MODEL:-36},
   nlayer_cris_co_total_col  = ${NL_NLAYER_CRIS_CO_TOTAL_COL:-50},
   nlayer_cris_co_trop_col   = ${NL_NLAYER_CRIS_CO_TROP_COL:-50},
   nlayer_cris_co_profile    = ${NL_NLAYER_CRIS_CO_PROFILE:-50},
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


