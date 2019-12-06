#!/bin/ksh -x
#########################################################################
#
# Purpose: Create DART &reg_factor_nml 
#
#########################################################################
#
# Generate namelist section
rm -f input.nml_temp
touch input.nml_temp
cat > input.nml_temp << EOF
 &state_vector_io_nml
   single_precision_output     = ${NL_SINGLE_PRECISION_OUTPUT:-.true.},
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
