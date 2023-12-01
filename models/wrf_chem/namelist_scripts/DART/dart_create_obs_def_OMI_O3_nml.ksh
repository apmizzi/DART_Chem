#!/bin/ksh -x
#########################################################################
#
# Purpose: Create DART &obs_def_OMI_O3_nml 
#
#########################################################################
#
# Generate namelist section
rm -f input.nml_temp
touch input.nml_temp
cat > input.nml_temp << EOF
 &obs_def_OMI_O3_nml
   upper_data_file  = ${NL_UPPER_DATA_FILE}
   upper_data_model = ${NL_UPPER_DATA_MODEL}
   ls_chem_dx = ${LS_CHEM_DX}
   ls_chem_dy = ${LS_CHEM_DY}
   ls_chem_dz = ${LS_CHEM_DZ}
   ls_chem_dt = ${LS_CHEM_DT}
   use_log_o3      = ${NL_USE_LOG_O3:-.false.},
   nlayer_model    = ${NL_NLAYER_MODEL:-36},
   nlayer_omi_o3_total_col   = ${NL_NLAYER_OMI_O3_TOTAL_COL:-15},
   nlayer_omi_o3_trop_col   = ${NL_NLAYER_OMI_O3_TROP_COL:-15},
   nlayer_omi_o3_profile   = ${NL_NLAYER_OMI_O3_PROFILE:-15},
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


