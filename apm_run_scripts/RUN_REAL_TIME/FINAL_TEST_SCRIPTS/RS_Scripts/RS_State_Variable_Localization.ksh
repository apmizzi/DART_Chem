#!/bin/ksh -aux
      cd ${RUN_DIR}/${DATE}/localization
#
# Set the obs_impasct_tool input file
      rm -rf variable_localization.txt
      cat << EOF > variable_localization.txt
#
# All chemistry variables
GROUP chem_vars
   QTY_CO
   QTY_O3
   QTY_NO
   QTY_NO2
   QTY_SO2
   QTY_SO4
   QTY_HNO4
   QTY_N2O5
   QTY_C2H6
   QTY_ACET
   QTY_C2H4
   QTY_C3H6
   QTY_TOL
   QTY_MVK
   QTY_BIGALK
   QTY_ISOPR
   QTY_MACR
   QTY_C3H8
   QTY_C10H16
   QTY_DST01
   QTY_DST02
   QTY_DST03
   QTY_DST04
   QTY_DST05
   QTY_BC1
   QTY_BC2
   QTY_OC1
   QTY_OC2
   QTY_TAUAER1
   QTY_TAUAER2
   QTY_TAUAER3
   QTY_TAUAER4
   QTY_PM25
   QTY_PM10
   QTY_P25
   QTY_P10
   QTY_SSLT01
   QTY_SSLT02
   QTY_SSLT03
   QTY_SSLT04
   QTY_E_CO
   QTY_E_NO
   QTY_E_NO2
   QTY_E_SO2
   QTY_E_PM25
   QTY_E_PM10
   QTY_E_BC
   QTY_E_OC
   QTY_EBU_CO
   QTY_EBU_NO
   QTY_EBU_NO2
   QTY_EBU_SO2
   QTY_EBU_SO4
   QTY_EBU_OC
   QTY_EBU_BC
   QTY_EBU_C2H4
   QTY_EBU_CH2O
   QTY_EBU_CH3OH
   QTY_GLYALD
   QTY_MEK
   QTY_ALD
   QTY_CH3O2
   QTY_AOD
   QTY_DMS
   QTY_HCHO
   QTY_HNO3
   QTY_NH3
   QTY_PAN
   QTY_CO2
   QTY_CH4
END GROUP
#
GROUP chem_obs
   QTY_CO
   QTY_O3
   QTY_NO
   QTY_NO2
   QTY_SO2
   QTY_PM10
   QTY_PM25
   QTY_AOD
   QTY_HCHO
   QTY_HNO3
   QTY_NH3
   QTY_PAN
   QTY_CO2
   QTY_CH4
END GROUP
#
GROUP chem_vars_no_obs
   QTY_SO4
   QTY_HNO4
   QTY_N2O5
   QTY_C2H6
   QTY_ACET
   QTY_C2H4
   QTY_C3H6
   QTY_TOL
   QTY_MVK
   QTY_BIGALK
   QTY_ISOPR
   QTY_MACR
   QTY_C3H8
   QTY_C10H16
   QTY_DST01
   QTY_DST02
   QTY_DST03
   QTY_DST04
   QTY_DST05
   QTY_BC1
   QTY_BC2
   QTY_OC1
   QTY_OC2
   QTY_TAUAER1
   QTY_TAUAER2
   QTY_TAUAER3
   QTY_TAUAER4
   QTY_P25
   QTY_P10
   QTY_SSLT01
   QTY_SSLT02
   QTY_SSLT03
   QTY_SSLT04
   QTY_E_CO
   QTY_E_NO
   QTY_E_NO2
   QTY_E_SO2
   QTY_E_PM25
   QTY_E_PM10
   QTY_E_BC
   QTY_E_OC
   QTY_EBU_CO
   QTY_EBU_NO
   QTY_EBU_NO2
   QTY_EBU_SO2
   QTY_EBU_SO4
   QTY_EBU_OC
   QTY_EBU_BC
   QTY_EBU_C2H4
   QTY_EBU_CH2O
   QTY_EBU_CH3OH
   QTY_GLYALD
   QTY_MEK
   QTY_ALD
   QTY_CH3O2
   QTY_DMS
END GROUP
#
GROUP met_vars
    ALLQTYS EXCEPT chem_vars
END GROUP
#
GROUP CO_obs
   QTY_CO
END GROUP
#
GROUP CO_vars
   QTY_CO
   QTY_E_CO
END GROUP
#
GROUP no_CO_vars
   ALLQTYS EXCEPT CO_vars
END GROUP
#
GROUP O3_obs
   QTY_O3
END GROUP
#
GROUP O3_vars
   QTY_O3
END GROUP
#
GROUP no_O3_vars
   ALLQTYS EXCEPT O3_vars
END GROUP
#
GROUP NOx_obs
   QTY_NO
   QTY_NO2
END GROUP
#
GROUP NOx_vars
   QTY_NO
   QTY_NO2
   QTY_E_NO
   QTY_E_NO2
END GROUP
#
GROUP no_NOx_vars
   ALLQTYS EXCEPT NOx_vars
END GROUP
#
GROUP SO2_obs
   QTY_SO2
END GROUP
#
GROUP SO2_vars
   QTY_SO2
   QTY_SO4
   QTY_E_SO2
END GROUP
#
GROUP no_SO2_vars
   ALLQTYS EXCEPT SO2_vars
END GROUP
#
GROUP PM10_obs
   QTY_PM10
END GROUP
#
GROUP PM10_vars
   QTY_P25
   QTY_SO4
   QTY_BC1
   QTY_BC2
   QTY_OC1
   QTY_OC2
   QTY_DST01
   QTY_DST02
   QTY_DST03
   QTY_DST04
   QTY_SSLT01
   QTY_SSLT02
   QTY_SSLT03
   QTY_E_PM25
   QTY_E_PM10
   QTY_E_BC
   QTY_E_OC
   QTY_E_SO2
END GROUP
#
GROUP no_PM10_vars
   ALLQTYS EXCEPT PM10_vars
END GROUP
#
GROUP PM25_obs
   QTY_PM25
END GROUP
#
GROUP PM25_vars
   QTY_P25
   QTY_SO4
   QTY_BC1
   QTY_BC2
   QTY_OC1
   QTY_OC2
   QTY_DST01
   QTY_DST02
   QTY_SSLT01
   QTY_SSLT02
   QTY_E_PM25
   QTY_E_BC
   QTY_E_OC
   QTY_E_SO2
END GROUP
#
GROUP no_PM25_vars
   ALLQTYS EXCEPT PM25_vars
END GROUP
#
GROUP AOD_obs
   QTY_AOD
END GROUP
#
GROUP AOD_vars
   QTY_SO4
   QTY_BC1
   QTY_BC2
   QTY_OC1
   QTY_OC2
   QTY_DST01
   QTY_DST02
   QTY_DST03
   QTY_DST04
   QTY_DST05
   QTY_SSLT01
   QTY_SSLT02
   QTY_SSLT03
   QTY_SSLT04
   QTY_TAUAER1
   QTY_TAUAER2
   QTY_TAUAER3
   QTY_TAUAER4
   QTY_E_PM25
   QTY_E_PM10
   QTY_E_BC
   QTY_E_OC
   QTY_E_SO2
END GROUP
#
GROUP no_AOD_vars
   ALLQTYS EXCEPT AOD_vars
END GROUP
#
# APM NEW CHEM INTERACTION (MODIFY TO ADD CROSS CORRELATIONS)
#   QTY_HCHO   QTY_HNO3   QTY_NH3   QTY_PAN   QTY_CO2   QTY_CH4
#
GROUP HCHO_obs
   QTY_HCHO
END GROUP
#
GROUP HCHO_vars
   QTY_HCHO
END GROUP
#
GROUP no_HCHO_vars
   ALLQTYS EXCEPT HCHO_vars
END GROUP
#
GROUP HNO3_obs
   QTY_HNO3
END GROUP
#
GROUP HNO3_vars
   QTY_HNO3
END GROUP
#
GROUP no_HNO3_vars
   ALLQTYS EXCEPT HNO3_vars
END GROUP
#
GROUP NH3_obs
   QTY_NH3
END GROUP
#
GROUP NH3_vars
   QTY_NH3
END GROUP
#
GROUP no_NH3_vars
   ALLQTYS EXCEPT NH3_vars
END GROUP
#
GROUP PAN_obs
   QTY_PAN
END GROUP
#
GROUP PAN_vars
   QTY_PAN
END GROUP
#
GROUP no_PAN_vars
   ALLQTYS EXCEPT PAN_vars
END GROUP
#
GROUP CO2_obs
   QTY_CO2
END GROUP
#
GROUP CO2_vars
   QTY_CO2
END GROUP
#
GROUP no_CO2_vars
   ALLQTYS EXCEPT CO2_vars
END GROUP
#
GROUP CH4_obs
   QTY_CH4
END GROUP
#
GROUP CH4_vars
   QTY_CH4
END GROUP
#
GROUP no_CH4_vars
   ALLQTYS EXCEPT CH4_vars
END GROUP
#
IMPACT
  met_vars chem_vars  0.0
  chem_vars_no_obs met_vars 0.0
  chem_vars_no_obs chem_vars 0.0
  CO_obs no_CO_vars 0.0
  CO_obs CO_vars 1.0
  O3_obs no_O3_vars 0.0
  O3_obs O3_vars 1.0
  NOx_obs no_NOx_vars 0.0
  NOx_obs NOx_vars 1.0
  SO2_obs no_SO2_vars 0.0
  SO2_obs SO2_vars 1.0
  PM10_obs no_PM10_vars 0.0 
  PM10_obs PM10_vars 1.0 
  PM25_obs no_PM25_vars 0.0 
  PM25_obs PM25_vars 1.0 
  AOD_obs no_AOD_vars 0.0 
  AOD_obs AOD_vars 1.0 
  HCHO_obs no_HCHO_vars 0.0
  HCHO_obs HCHO_vars 1.0
  HNO3_obs no_HNO3_vars 0.0
  HNO3_obs HNO3_vars 1.0
  NH3_obs no_NH3_vars 0.0
  NH3_obs NH3_vars 1.0
  PAN_obs no_PAN_vars 0.0
  PAN_obs PAN_vars 1.0
  CO2_obs no_CO2_vars 0.0
  CO2_obs CO2_vars 1.0
  CH4_obs no_CH4_vars 0.0
  CH4_obs CH4_vars 1.0
END IMPACT
EOF
#
# Create input.nml
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/DART/dart_create_input.nml.ksh
#
# Copy the obs_impact_tool executable
      cp ${WRFCHEM_DART_WORK_DIR}/obs_impact_tool ./.
#
# Run the obs_impact_tool
      ./obs_impact_tool
#
# Clean directory
      rm dart_log* input.nml obs_impact_tool variable_localization.txt      
