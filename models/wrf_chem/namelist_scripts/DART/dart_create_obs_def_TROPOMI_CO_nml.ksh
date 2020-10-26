#!/bin/ksh -x
#########################################################################
#
# Purpose: Create DART &obs_def_TROPOMI_CO_nml 
#
#########################################################################
#
# Generate namelist section
rm -f input.nml_temp
touch input.nml_temp
cat > input.nml_temp << EOF
 &obs_def_TROPOMI_CO_nml
   use_log_co       = ${NL_USE_LOG_CO:-.false.},
   nlayer_model     = ${NL_NLAYER_MODEL:-36},
   nlayer_tropomi_co   = ${NL_NLAYER_TROPOMI_CO:-55},
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


