#!/bin/ksh -x
#########################################################################
#
# Purpose: Create DART &obs_def_OMI_NO2_nml 
#
#########################################################################
#
# Generate namelist section
rm -f input.nml_temp
touch input.nml_temp
cat > input.nml_temp << EOF
 &obs_def_OMI_NO2_nml
   use_log_no2   = ${NL_USE_LOG_NO2:-.false.},
   nlayer_model = ${NL_NLAYER_MODEL:-36},
   nlayer_omi_no2   = ${NL_NLAYER_OMI_NO2:-40},
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


