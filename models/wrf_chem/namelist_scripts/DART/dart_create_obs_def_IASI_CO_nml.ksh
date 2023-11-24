#!/bin/ksh -x
#########################################################################
#
# Purpose: Create DART &obs_def_IASI_CO_nml 
#
#########################################################################
#
# Generate namelist section
rm -f input.nml_temp
touch input.nml_temp
cat > input.nml_temp << EOF
 &obs_def_IASI_CO_nml
   upper_data_file  = ${NL_UPPER_DATA_FILE}
   ls_chem_dx = ${LS_CHEM_DX}
   ls_chem_dy = ${LS_CHEM_DY}
   ls_chem_dz = ${LS_CHEM_DZ}
   ls_chem_dt = ${LS_CHEM_DT}
   IASI_CO_retrieval_type   = ${NL_IASI_CO_RETRIEVAL_TYPE:-'RAWR'},
   use_log_co    = ${NL_USE_LOG_CO:-.false.},
   nlayer_model  = ${NL_NLAYER_MODEL:-36},
   nlayer_iasi_co_total_col   = ${NL_NLAYER_IASI_CO_TOTAL_COL:-19},
   nlayer_iasi_co_profile   = ${NL_NLAYER_IASI_CO_PROFILE:-19},
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


