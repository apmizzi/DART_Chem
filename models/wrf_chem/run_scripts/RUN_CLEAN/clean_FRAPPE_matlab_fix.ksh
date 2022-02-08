#!/bin/ksh -aeux
#
export NUM_MEMBERS=10
export WRFDA_VERSION=WRFDAv3.9.1.1_dmpar
export BUILD_DIR=/nobackupp11/amizzi/TRUNK/${WRFDA_VERSION}/var/build
#
# Start 1612
export EXP=real_FRAPPE_CONTROL_NASA
# Start 1612
export EXP=real_FRAPPE_ALLCHEM_RELAX_NASA
# Start 1612
export EXP=real_FRAPPE_ALLCHEM_EMISS_ADJ_NASA
# Start 1406 
#export EXP=real_FRAPPE_NOOMI_EMISS_ADJ_NASA
#
export SOURCE_PATH=/nobackupp11/amizzi/OUTPUT_DATA/${EXP}
#
export DATE_STR=2014071612
export DATE_END=2014071900
export CYCLE_PERIOD=6
#
# Copy file into ${L_DATE} subdirectory
export L_DATE=${DATE_STR}
#
while [[ ${L_DATE} -le ${DATE_END} ]] ; do
   cd ${SOURCE_PATH}/${L_DATE}
#   rm -rf mopitt_co_obs
#   rm -rf iasi_co_obs
#   rm -rf airnow_co_obs
#   rm -rf airnow_o3_obs
#   rm -rf airnow_no2_obs
#   rm -rf airnow_so2_obs
#   rm -rf airnow_pm10_obs
#   rm -rf airnow_pm25_obs
#   rm -rf omi_o3_obs
#   rm -rf omi_no2_obs
#   rm -rf modis_aod_obs
#   rm -rf prepbufr_met_obs
#   rm -rf combine_obs
#   rm -rf preprocess_obs
#   rm -rf localization
#   mv dart_filter dart_filter_1
#   mv dart_filter_1 dart_filter
   rm -rf dart_filter_1
#   rm -rf update_bc
#   rm -rf wrfchem_cycle_cr
#   rm -rf ensemble_mean_input
#   rm -rf ensemble_mean_output
#   rm -rf wrfchem_chem_emiss
#   rm -rf wrfchem_chem_icbc
#   rm -rf exo_coldens
#   rm -rf metgrid
#   rm -rf real
#   rm -rf seasons_wes
#   rm -rf ungrib
#   rm -rf wrfchem_*
   export L_DATE=$(${BUILD_DIR}/da_advance_time.exe ${L_DATE} ${CYCLE_PERIOD} 2>/dev/null)
done


