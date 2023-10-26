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
 &quality_control_nml
  input_qc_threshold          = ${NL_INPUT_QC_THRESHOLD:-3},
  outlier_threshold           = ${NL_OUTLIER_THRESHOLD:-3},
  enable_special_outlier_code = ${NL_ENABLE_SPECIAL_OUTLIER_THRESHOLD:-.false.},
  special_outlier_threshold   = ${NL_SPECIAL_OUTLIER_THRESHOLD:-3},
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
