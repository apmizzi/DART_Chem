#!/bin/ksh -x
#########################################################################
#
# Purpose: Create DART &obs_def_OMI_SO2_nml 
#
#########################################################################
#
# Generate namelist section
rm -f input.nml_temp
touch input.nml_temp
cat > input.nml_temp << EOF
 &obs_def_OMI_SO2_nml
   use_log_so2   = ${NL_USE_LOG_SO2:-.false.},
   nlayer_model = ${NL_NLAYER_MODEL:-36},
   nlayer_omi_so2   = ${NL_NLAYER_OMI_SO2:-75},
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


