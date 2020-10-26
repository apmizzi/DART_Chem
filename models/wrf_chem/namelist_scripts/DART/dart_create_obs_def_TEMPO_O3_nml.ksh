#!/bin/ksh -x
#########################################################################
#
# Purpose: Create DART &obs_def_TEMPO_O3_nml 
#
#########################################################################
#
# Generate namelist section
rm -f input.nml_temp
touch input.nml_temp
cat > input.nml_temp << EOF
 &obs_def_TEMPO_O3_nml
   use_log_o3     = ${NL_USE_LOG_O3:-.false.},
   nlayer_model   = ${NL_NLAYER_MODEL:-36},
   nlayer_tempo_o3   = ${NL_NLAYER_TEMPO_O3:-50},
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


