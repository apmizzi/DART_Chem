#!/bin/ksh -x
#########################################################################
#
# Purpose: Create DART &dart_to_wrf_nml 
#
#########################################################################
#
# Generate namelist section
rm -f input.nml_temp
touch input.nml_temp
cat > input.nml_temp << EOF
&obs_impact_tool_nml
  input_filename          = '${DART_DIR}/models/wrf_chem/variable_localization.txt'
  output_filename         = '${DART_DIR}/models/wrf_chem/work/control_impact_runtime.table'
  debug                   = .false.
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
