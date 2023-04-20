#!/bin/ksh -x
#########################################################################
#
# Purpose: Create DART &obs_def_TROPOMI_CH4_nml 
#
#########################################################################
#
# Generate namelist section
rm -f input.nml_temp
touch input.nml_temp
cat > input.nml_temp << EOF
 &obs_def_TROPOMI_CH4_nml
   use_log_ch4      = ${NL_USE_LOG_CH4:-.false.},
   nlayer_model     = ${NL_NLAYER_MODEL:-36},
   nlayer_tropomi_ch4_total_col   = ${NL_NLAYER_TROPOMI_CH4_TOTAL_COL:-40},
   nlayer_tropomi_ch4_trop_col   = ${NL_NLAYER_TROPOMI_CH4_TROP_COL:-40},
   nlayer_tropomi_ch4_profile   = ${NL_NLAYER_TROPOMI_CH4_PROFILE:-40},
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


