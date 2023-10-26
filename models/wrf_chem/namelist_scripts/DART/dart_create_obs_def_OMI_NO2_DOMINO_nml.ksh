#!/bin/ksh -x
#########################################################################
#
# Purpose: Create DART &obs_def_OMI_O3_DOMINO_nml 
#
#########################################################################
#
# Generate namelist section
rm -f input.nml_temp
touch input.nml_temp
cat > input.nml_temp << EOF
 &obs_def_OMI_NO2_DOMINO_nml
   use_log_o3     = ${NL_USE_LOG_O3:-.false.},
   nlayer_model   = ${NL_NLAYER_MODEL:-36},
   nlayer_omi_no2_domino_total_col  = ${NL_NLAYER_OMI_NO2_DOMINO_TOTAL_COL:-50},
   nlayer_omi_no2_domino_trop_col   = ${NL_NLAYER_OMI_NO2_DOMINO_TROP_COL:-50},
   nlayer_omi_no2_domino_profile    = ${NL_NLAYER_OMI_NO2_DOMINO_PROFILE:-50},
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


