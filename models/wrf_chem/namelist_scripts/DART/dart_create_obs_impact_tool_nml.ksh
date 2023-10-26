#!/bin/ksh -x
#########################################################################
#
# Purpose: Create DART &obs_impact_tool_nml 
#
#########################################################################
#
# Generate namelist section
rm -f input.nml_temp
touch input.nml_temp
cat > input.nml_temp << EOF
 &obs_impact_tool_nml                                                                                     
  input_filename = ${NL_IMPACT_TOOL_INPUT:-'cross_correlations.txt'}
  output_filename = ${NL_IMPACT_TOOL_OUTPUT:-'control_impact_runtime.txt'}
  debug = ${NL_DART_DEBUG:-.false.}
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
