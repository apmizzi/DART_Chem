#!/bin/ksh -x
#########################################################################
#
# Purpose: Create DART &obs_def_TES_CO2_nml 
#
#########################################################################
#
# Generate namelist section
rm -f input.nml_temp
touch input.nml_temp
cat > input.nml_temp << EOF
 &obs_def_TES_CO2_nml
   upper_data_file  = ${NL_UPPER_DATA_FILE}
   upper_data_model = ${NL_UPPER_DATA_MODEL}
   ls_chem_dx = ${LS_CHEM_DX}
   ls_chem_dy = ${LS_CHEM_DY}
   ls_chem_dz = ${LS_CHEM_DZ}
   ls_chem_dt = ${LS_CHEM_DT}
   use_log_co2     = ${NL_USE_LOG_CO2:-.false.},
   nlayer_model   = ${NL_NLAYER_MODEL:-36},
   nlayer_tes_co2_total_col  = ${NL_NLAYER_TES_CO2_TOTAL_COL:-50},
   nlayer_tes_co2_trop_col   = ${NL_NLAYER_TES_CO2_TROP_COL:-50},
   nlayer_tes_co2_profile    = ${NL_NLAYER_TES_CO2_PROFILE:-50},
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


