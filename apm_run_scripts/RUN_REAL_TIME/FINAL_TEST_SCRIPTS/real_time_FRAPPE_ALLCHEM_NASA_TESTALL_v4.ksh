#!/bin/ksh -aux
#
# Copyright 2019 University Corporation for Atmospheric Research and 
# Colorado Department of Public Health and Environment.
# 
# Licensed under the Apache License, Version 2.0 (the "License"); 
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software distributed
# under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR 
# CONDITIONS OF ANY KIND, either express or implied. See the License for the 
# specific language governing permissions and limitations under the License.
# 
# Development of this code utilized the RMACC Summit supercomputer, which is 
# supported by the National Science Foundation (awards ACI-1532235 and ACI-1532236),
# the University of Colorado Boulder, and Colorado State University. The Summit 
# supercomputer is a joint effort of the University of Colorado Boulder and 
# Colorado State University.
#
##########################################################################
#
# Purpose: Set global environment variables for real_time_wrf_chem
#
#########################################################################
#
export INITIAL_DATE=2014072500
export FIRST_FILTER_DATE=2014072506
export FIRST_DART_INFLATE_DATE=2014072506
export FIRST_EMISS_INV_DATE=2014072506
#
export NL_CORRECTION_FILENAME='Historical_Bias_Corrections'      
#
# START CYCLE DATE-TIME:
export CYCLE_STR_DATE=2014072500
#
# END CYCLE DATE-TIME:
export CYCLE_END_DATE=2014072500
#export CYCLE_END_DATE=${CYCLE_STR_DATE}
#
export CYCLE_DATE=${CYCLE_STR_DATE}
export NL_FAC_OBS_ERROR_MOPITT_CO=0.50
export NL_FAC_OBS_ERROR_MODIS_AOD=1.20
export NL_FAC_OBS_ERROR_IASI_CO=1.00
export NL_FAC_OBS_ERROR_IASI_O3=1.00
export NL_FAC_OBS_ERROR_OMI_O3=0.05
export NL_FAC_OBS_ERROR_OMI_NO2=0.90
export NL_FAC_OBS_ERROR_OMI_NO2_DOMINO=1.00
export NL_FAC_OBS_ERROR_OMI_SO2=1.00
export NL_FAC_OBS_ERROR_OMI_HCHO=1.00
export NL_FAC_OBS_ERROR_TROPOMI_CO=1.00
export NL_FAC_OBS_ERROR_TROPOMI_O3=0.70
export NL_FAC_OBS_ERROR_TROPOMI_NO2=1.00
export NL_FAC_OBS_ERROR_TROPOMI_SO2=1.40
export NL_FAC_OBS_ERROR_TROPOMI_CH4=1.00
export NL_FAC_OBS_ERROR_TROPOMI_HCHO=1.00
export NL_FAC_OBS_ERROR_TEMPO_O3=1.00
export NL_FAC_OBS_ERROR_TEMPO_NO2=1.00
export NL_FAC_OBS_ERROR_TES_CO=10.00
export NL_FAC_OBS_ERROR_TES_CO2=3.00
export NL_FAC_OBS_ERROR_TES_O3=6.20
export NL_FAC_OBS_ERROR_TES_NH3=1.00
export NL_FAC_OBS_ERROR_TES_CH4=1.00
export NL_FAC_OBS_ERROR_CRIS_CO=1.00
export NL_FAC_OBS_ERROR_CRIS_O3=1.00
export NL_FAC_OBS_ERROR_CRIS_NH3=1.00
export NL_FAC_OBS_ERROR_CRIS_CH4=1.00
export NL_FAC_OBS_ERROR_CRIS_PAN=1.00
export NL_FAC_OBS_ERROR_SCIAM_NO2=1.00
export NL_FAC_OBS_ERROR_GOME2A_NO2=1.00
export NL_FAC_OBS_ERROR_MLS_O3=1.00
export NL_FAC_OBS_ERROR_MLS_HNO3=1.00
export NL_FAC_OBS_ERROR_AIRNOW_CO=1.00
export NL_FAC_OBS_ERROR_AIRNOW_O3=1.00
export NL_FAC_OBS_ERROR_AIRNOW_NO2=2.00
export NL_FAC_OBS_ERROR_AIRNOW_SO2=1.00
export NL_FAC_OBS_ERROR_AIRNOW_PM10=1.00
export NL_FAC_OBS_ERROR_AIRNOW_PM25=1.00
export NL_FAC_OBS_ERROR_MEXICO_AQS=1.00
export RETRIEVAL_TYPE_MOPITT=RAWR
export RETRIEVAL_TYPE_IASI=RAWR
#
# Observation retension frequemcy
export NL_MOPITT_CO_RETEN_FREQ=1
export NL_IASI_CO_RETEN_FREQ=1
export NL_IASI_O3_RETEN_FREQ=1
export NL_MODIS_AOD_RETEN_FREQ=1
export NL_OMI_O3_RETEN_FREQ=1
export NL_OMI_NO2_RETEN_FREQ=1
export NL_OMI_NO2_DOMINO_RETEN_FREQ=1
export NL_OMI_SO2_RETEN_FREQ=1
export NL_OMI_HCHO_RETEN_FREQ=1
export NL_TROPOMI_CO_RETEN_FREQ=1
export NL_TROPOMI_O3_RETEN_FREQ=1
export NL_TROPOMI_NO2_RETEN_FREQ=1
export NL_TROPOMI_SO2_RETEN_FREQ=1
export NL_TROPOMI_CH4_RETEN_FREQ=1
export NL_TROPOMI_HCHO_RETEN_FREQ=1
export NL_TEMPO_O3_RETEN_FREQ=4
export NL_TEMPO_NO2_RETEN_FREQ=4
export NL_TES_CO_RETEN_FREQ=1
export NL_TES_CO2_RETEN_FREQ=1
export NL_TES_O3_RETEN_FREQ=1
export NL_TES_NH3_RETEN_FREQ=1
export NL_TES_CH4_RETEN_FREQ=1
export NL_CRIS_CO_RETEN_FREQ=1
export NL_CRIS_O3_RETEN_FREQ=1
export NL_CRIS_NH3_RETEN_FREQ=1
export NL_CRIS_CH4_RETEN_FREQ=1
export NL_CRIS_PAN_RETEN_FREQ=1
export NL_SCIAM_NO2_RETEN_FREQ=1
export NL_GOME2A_NO2_RETEN_FREQ=1
export NL_MLS_O3_RETEN_FREQ=1
export NL_MLS_HNO3_RETEN_FREQ=1
export NL_AIRNOW_CO_RETEN_FREQ=1
export NL_AIRNOW_O3_RETEN_FREQ=1
export NL_AIRNOW_NO2_RETEN_FREQ=1
export NL_AIRNOW_SO2_RETEN_FREQ=1
export NL_AIRNOW_PM10_RETEN_FREQ=1
export NL_AIRNOW_PM25_RETEN_FREQ=1
#
# NOTE: the BC temporal adjustment is setup for 6-hr cycling (BCs at 3hr and 6hr).
# km
export NL_HZ_CORR_LNGTH=400.
# m
export NL_VT_CORR_LNGTH=1000.
# hrs
export NL_TM_CORR_LNGTH_IC=24.
# hrs
export NL_TM_CORR_LNGTH_BC=72.
#
export USE_LOG=false
if [[ ${USE_LOG} == true ]]; then
   export CO_MIN=NULL
   export CO_MAX=NULL
   export O3_MIN=NULL
   export O3_MAX=NULL
   export NO_MIN=NULL
   export NO_MAX=NULL
   export NO2_MIN=NULL
   export NO2_MAX=NULL
   export SO2_MIN=NULL
   export SO2_MAX=NULL
   export SO4_MIN=NULL
   export SO4_MAX=NULL
   export PM10_MIN=NULL
   export PM10_MAX=NULL
   export PM25_MIN=NULL
   export PM25_MAX=NULL
   export USE_LOG_CO_LOGIC=.true.
   export USE_LOG_O3_LOGIC=.true.
   export USE_LOG_NOX_LOGIC=.true.
   export USE_LOG_NO2_LOGIC=.true.
   export USE_LOG_SO2_LOGIC=.true.
   export USE_LOG_PM10_LOGIC=.true.
   export USE_LOG_PM25_LOGIC=.true.
   export USE_LOG_AOD_LOGIC=.true.
   export USE_LOG_CO2_LOGIC=.true.
   export USE_LOG_CH4_LOGIC=.true.
   export USE_LOG_NH3_LOGIC=.true.
   export USE_LOG_HNO3_LOGIC=.true.
   export USE_LOG_HCHO_LOGIC=.true.
   export USE_LOG_PAN_LOGIC=.true.
else
   export CO_MIN=1.e-4
   export CO_MAX=NULL
   export O3_MIN=1.e-4
   export O3_MAX=NULL
   export NO_MIN=1.e-5
   export NO_MAX=NULL
   export NO2_MIN=1.e-5
   export NO2_MAX=NULL
   export SO2_MIN=1.e-5
   export SO2_MAX=NULL
   export SO4_MIN=1.e-5
   export SO4_MAX=NULL
   export PM10_MIN=0.
   export PM10_MAX=NULL
   export PM25_MIN=0.
   export PM25_MAX=NULL
   export USE_LOG_CO_LOGIC=.false.
   export USE_LOG_O3_LOGIC=.false.
   export USE_LOG_NOX_LOGIC=.false.
   export USE_LOG_NO2_LOGIC=.false.
   export USE_LOG_SO2_LOGIC=.false.
   export USE_LOG_PM10_LOGIC=.false.
   export USE_LOG_PM25_LOGIC=.false.
   export USE_LOG_AOD_LOGIC=.false.
   export USE_LOG_CO2_LOGIC=.false.
   export USE_LOG_CH4_LOGIC=.false.
   export USE_LOG_NH3_LOGIC=.false.
   export USE_LOG_HNO3_LOGIC=.false.
   export USE_LOG_HCHO_LOGIC=.false.
   export USE_LOG_PAN_LOGIC=.false.
fi
#
# CPSR Truncation (limit the number of CPSR modes assimilated)
   export NL_USE_CPSR_CO_TRUNC=.false.
   export NL_CPSR_CO_TRUNC_LIM=4
   export NL_USE_CPSR_O3_TRUNC=.false.
   export NL_CPSR_O3_TRUNC_LIM=4
#
export ADD_EMISS=false
export EMISS_DAMP_CYCLE=1.0
export EMISS_DAMP_INTRA_CYCLE=1.0
#
BAND_ISO_VAL_CO=.09
#
# Run fine scale forecast only
export RUN_FINE_SCALE=false
#
# Restart fine scale forecast only
export RUN_FINE_SCALE_RESTART=false
export RESTART_DATE=2014072312
#
if [[ ${RUN_FINE_SCALE_RESTART} = "true" ]]; then
   export RUN_FINE_SCALE=true
fi
#
# Switch to process filter output without calling filter
export SKIP_FILTER=false
#
# Run WRF-Chem for failed forecasts (will not work with adaptive time step)
export RUN_SPECIAL_FORECAST=false
export NUM_SPECIAL_FORECAST=0
export SPECIAL_FORECAST_FAC=1./2.
export SPECIAL_FORECAST_FAC=2./3.
export SPECIAL_FORECAST_FAC=1.
#
export SPECIAL_FORECAST_MEM[1]=1
export SPECIAL_FORECAST_MEM[2]=2
export SPECIAL_FORECAST_MEM[3]=3
export SPECIAL_FORECAST_MEM[4]=4
export SPECIAL_FORECAST_MEM[5]=5
export SPECIAL_FORECAST_MEM[6]=6
export SPECIAL_FORECAST_MEM[7]=7
export SPECIAL_FORECAST_MEM[8]=8
export SPECIAL_FORECAST_MEM[9]=9
export SPECIAL_FORECAST_MEM[10]=10
#
# Run temporal interpolation for missing background files
# RUN_UNGRIB, RUN_METGRID, and RUN_REAL must all be false for the interpolation and for cycling
# Currently set up for 6 hr forecasts. It can handle up to 24 hr forecasts
export RUN_INTERPOLATE=false
#
# for 2014072212 and 2014072218
# export BACK_DATE=2014072206
# export FORW_DATE=2014072300
# BACK_WT=.3333
# BACK_WT=.6667
#
# for 20142900
# export BACK_DATE=2014072818
# export FORW_DATE=2014072906
# BACK_WT=.5000
#
# for 20142912
# export BACK_DATE=2014072906
# export FORW_DATE=2014072918
# BACK_WT=.5000
#
#########################################################################
#
# START OF MAIN CYCLING LOOP
#
#########################################################################
#
while [[ ${CYCLE_DATE} -le ${CYCLE_END_DATE} ]]; do
   export DATE=${CYCLE_DATE}
   export L_ADD_EMISS=${ADD_EMISS} 
   if [[ ${DATE} -lt ${FIRST_EMISS_INV_DATE} ]]; then
      export L_ADD_EMISS=false
   fi
   export CYCLE_PERIOD=6
   export HISTORY_INTERVAL_HR=1
   (( HISTORY_INTERVAL_MIN = ${HISTORY_INTERVAL_HR} * 60 ))
   export START_IASI_O3_DATA=2014060100
   export END_IASI_O3_DATA=2014073118
   export NL_DEBUG_LEVEL=100
#
# CODE VERSIONS:
   export WPS_VER=WPSv4.3.1_dmpar
   export WPS_GEOG_VER=GEOG_DATA_v4
   export WRFDA_VER=WRFDAv4.3.2_dmpar
   export WRF_VER=WRFv4.3.2_dmpar
   export WRFCHEM_VER=WRFCHEMv4.3.2_dmpar
   export DART_VER=DART_development
#
# ROOT DIRECTORIES:
   export SCRATCH_DIR=/nobackupp11/amizzi/OUTPUT_DATA
   export WORK_DIR=/nobackupp11/amizzi
   export INPUT_DATA_DIR=/nobackupp11/amizzi/INPUT_DATA
#
# DEPENDENT INPUT DATA DIRECTORIES:
   export EXPERIMENT_DIR=${SCRATCH_DIR}
   export RUN_DIR=${EXPERIMENT_DIR}/real_FRAPPE_ALLCHEM_TESTALL
   export RUN_INPUT_DIR=${EXPERIMENT_DIR}/real_FRAPPE_TEST_INPUT_DIR
   export TRUNK_DIR=${WORK_DIR}/TRUNK
   export WPS_DIR=${TRUNK_DIR}/${WPS_VER}
   export WPS_GEOG_DIR=${INPUT_DATA_DIR}/${WPS_GEOG_VER}
   export WRFCHEM_DIR=${TRUNK_DIR}/${WRFCHEM_VER}
   export WRFDA_DIR=${TRUNK_DIR}/${WRFDA_VER}
   export DART_DIR=${TRUNK_DIR}/${DART_VER}
   export BUILD_DIR=${WRFDA_DIR}/var/da
   export WRF_DIR=${TRUNK_DIR}/${WRF_VER}
   export WRFCHEM_DART_WORK_DIR=${DART_DIR}/models/wrf_chem/work
   export JOB_CONTROL_SCRIPTS_DIR=${DART_DIR}/models/wrf_chem/job_control_scripts
   export NAMELIST_SCRIPTS_DIR=${DART_DIR}/models/wrf_chem/namelist_scripts
   export ADJUST_EMISS_DIR=${DART_DIR}/apm_run_scripts/RUN_EMISS_INV
   export WES_COLDENS_DIR=${DART_DIR}/apm_run_scripts/RUN_WES_COLDENS
   export MEGAN_BIO_DIR=${DART_DIR}/apm_run_scripts/RUN_MEGAN_BIO
   export FINN_FIRE_DIR=${DART_DIR}/apm_run_scripts/RUN_FINN_FIRE
   export BIAS_CORR_DIR=${DART_DIR}/apm_run_scripts/RUN_BIAS_CORR
   export EXPERIMENT_DATA_DIR=${INPUT_DATA_DIR}/FRAPPE_REAL_TIME_DATA
   export EXPERIMENT_MEXICO_DATA_DIR=${INPUT_DATA_DIR}/MEXICO_REAL_TIME_DATA
#   export EXPERIMENT_DATA_DIR=${INPUT_DATA_DIR}/FIREX_REAL_TIME_DATA
#   export EXPERIMENT_DATA_DIR=${INPUT_DATA_DIR}/2022_DATA
#   export EXPERIMENT_DATA_DIR=${INPUT_DATA_DIR}/2010_DATA
   export MOZBC_DATA_DIR=${EXPERIMENT_DATA_DIR}/mozart_forecasts
   export EXPERIMENT_STATIC_FILES=${EXPERIMENT_DATA_DIR}/static_files
   export EXPERIMENT_WRFCHEMI_DIR=${EXPERIMENT_DATA_DIR}/anthro_emissions_fixed
   export EXPERIMENT_WRFFIRECHEMI_DIR=${EXPERIMENT_DATA_DIR}/fire_emissions
   export EXPERIMENT_WRFBIOCHEMI_DIR=${EXPERIMENT_DATA_DIR}/bio_emissions
   export EXPERIMENT_COLDENS_DIR=${EXPERIMENT_DATA_DIR}/wes_coldens
   export EXPERIMENT_PREPBUFR_DIR=${EXPERIMENT_DATA_DIR}/met_obs_prep_data
   export EXPERIMENT_MOPITT_CO_DIR=${EXPERIMENT_DATA_DIR}/mopitt_co_hdf_data
   export EXPERIMENT_IASI_CO_DIR=${EXPERIMENT_DATA_DIR}/iasi_co_hdf_data
   export EXPERIMENT_IASI_O3_DIR=${EXPERIMENT_DATA_DIR}/iasi_o3_hdf_data
   export EXPERIMENT_MODIS_AOD_DIR=${EXPERIMENT_DATA_DIR}/modis_aod_hdf_data
   export EXPERIMENT_OMI_O3_DIR=${EXPERIMENT_DATA_DIR}/omi_o3_hdf_data
   export EXPERIMENT_OMI_NO2_DIR=${EXPERIMENT_DATA_DIR}/omi_no2_hdf_data
   export EXPERIMENT_OMI_NO2_DOMINO_DIR=${EXPERIMENT_DATA_DIR}/omi_no2_domino_nc_data
   export EXPERIMENT_OMI_SO2_DIR=${EXPERIMENT_DATA_DIR}/omi_so2_hdf_data
   export EXPERIMENT_OMI_HCHO_DIR=${EXPERIMENT_DATA_DIR}/omi_hcho_hdf_data
   export EXPERIMENT_TROPOMI_CO_DIR=${EXPERIMENT_DATA_DIR}/tropomi_co_nc_data
   export EXPERIMENT_TROPOMI_O3_DIR=${EXPERIMENT_DATA_DIR}/tropomi_o3_nc_data
   export EXPERIMENT_TROPOMI_NO2_DIR=${EXPERIMENT_DATA_DIR}/tropomi_no2_nc_data
   export EXPERIMENT_TROPOMI_SO2_DIR=${EXPERIMENT_DATA_DIR}/tropomi_so2_nc_data
   export EXPERIMENT_TROPOMI_CH4_DIR=${EXPERIMENT_DATA_DIR}/tropomi_ch4_nc_data
   export EXPERIMENT_TROPOMI_HCHO_DIR=${EXPERIMENT_DATA_DIR}/tropomi_hcho_nc_data
   export EXPERIMENT_TEMPO_O3_DIR=${EXPERIMENT_DATA_DIR}/tempo_o3_nc_data
   export EXPERIMENT_TEMPO_NO2_DIR=${EXPERIMENT_DATA_DIR}/tempo_no2_nc_data
   export EXPERIMENT_TES_CO_DIR=${EXPERIMENT_DATA_DIR}/tes_co_hdf_data
   export EXPERIMENT_TES_CO2_DIR=${EXPERIMENT_DATA_DIR}/tes_co2_hdf_data
   export EXPERIMENT_TES_O3_DIR=${EXPERIMENT_DATA_DIR}/tes_o3_hdf_data
   export EXPERIMENT_TES_NH3_DIR=${EXPERIMENT_DATA_DIR}/tes_nh3_hdf_data
   export EXPERIMENT_TES_CH4_DIR=${EXPERIMENT_DATA_DIR}/tes_ch4_hdf_data
   export EXPERIMENT_CRIS_CO_DIR=${EXPERIMENT_DATA_DIR}/cris_co_nc_data
   export EXPERIMENT_CRIS_O3_DIR=${EXPERIMENT_DATA_DIR}/cris_o3_nc_data
   export EXPERIMENT_CRIS_NH3_DIR=${EXPERIMENT_DATA_DIR}/cris_nh3_nc_data
   export EXPERIMENT_CRIS_CH4_DIR=${EXPERIMENT_DATA_DIR}/cris_ch4_nc_data
   export EXPERIMENT_CRIS_PAN_DIR=${EXPERIMENT_DATA_DIR}/cris_pan_nc_data
   export EXPERIMENT_SCIAM_NO2_DIR=${EXPERIMENT_DATA_DIR}/sciam_no2_nc_data
   export EXPERIMENT_GOME2A_NO2_DIR=${EXPERIMENT_DATA_DIR}/gome2a_no2_nc_data
   export EXPERIMENT_MLS_O3_DIR=${EXPERIMENT_DATA_DIR}/mls_o3_hdf_data
   export EXPERIMENT_MLS_HNO3_DIR=${EXPERIMENT_DATA_DIR}/mls_hno3_hdf_data
   export EXPERIMENT_AIRNOW_DIR=${EXPERIMENT_DATA_DIR}/airnow_csv_data
   export EXPERIMENT_PANDA_DIR=${EXPERIMENT_DATA_DIR}/panda_csv_data
   export EXPERIMENT_MEXICO_DIR=${EXPERIMENT_MEXICO_DATA_DIR}/aqsmex_csv_data
   export EXPERIMENT_DUST_DIR=${EXPERIMENT_DATA_DIR}/dust_fields
   export EXPERIMENT_HIST_IO_DIR=${EXPERIMENT_DATA_DIR}/hist_io_files
   export EXPERIMENT_GFS_DIR=${EXPERIMENT_DATA_DIR}/gfs_forecasts
   export VTABLE_DIR=${WPS_DIR}/ungrib/Variable_Tables
   export BE_DIR=${WRFDA_DIR}/var/run
   export PERT_CHEM_INPUT_DIR=${DART_DIR}/apm_run_scripts/RUN_PERT_CHEM/ICBC_PERT
   export PERT_CHEM_EMISS_DIR=${DART_DIR}/apm_run_scripts/RUN_PERT_CHEM/EMISS_PERT
   export RUN_BAND_DEPTH_DIR=${DART_DIR}/apm_run_scripts/RUN_BAND_DEPTH
#
   cp ${WRFCHEM_DART_WORK_DIR}/advance_time ./.
   cp ${WRFCHEM_DART_WORK_DIR}/input.nml ./.
   export YYYY=$(echo $DATE | cut -c1-4)
   export YY=$(echo $DATE | cut -c3-4)
   export MM=$(echo $DATE | cut -c5-6)
   export DD=$(echo $DATE | cut -c7-8)
   export HH=$(echo $DATE | cut -c9-10)
   export DATE_SHORT=${YY}${MM}${DD}${HH}
   export FILE_DATE=${YYYY}-${MM}-${DD}_${HH}:00:00
   export PAST_DATE=$(${BUILD_DIR}/da_advance_time.exe ${DATE} -${CYCLE_PERIOD} 2>/dev/null)
   export PAST_YYYY=$(echo $PAST_DATE | cut -c1-4)
   export PAST_YY=$(echo $PAST_DATE | cut -c3-4)
   export PAST_MM=$(echo $PAST_DATE | cut -c5-6)
   export PAST_DD=$(echo $PAST_DATE | cut -c7-8)
   export PAST_HH=$(echo $PAST_DATE | cut -c9-10)
   export PAST_FILE_DATE=${PAST_YYYY}-${PAST_MM}-${PAST_DD}_${PAST_HH}:00:00
   export NEXT_DATE=$(${BUILD_DIR}/da_advance_time.exe ${DATE} +${CYCLE_PERIOD} 2>/dev/null)
   export NEXT_YYYY=$(echo $NEXT_DATE | cut -c1-4)
   export NEXT_YY=$(echo $NEXT_DATE | cut -c3-4)
   export NEXT_MM=$(echo $NEXT_DATE | cut -c5-6)
   export NEXT_DD=$(echo $NEXT_DATE | cut -c7-8)
   export NEXT_HH=$(echo $NEXT_DATE | cut -c9-10)
   export NEXT_FILE_DATE=${NEXT_YYYY}-${NEXT_MM}-${NEXT_DD}_${NEXT_HH}:00:00
#
# DART TIME DATA
   export DT_YYYY=${YYYY}
   export DT_YY=${YY}
   export DT_MM=${MM} 
   export DT_DD=${DD} 
   export DT_HH=${HH} 
   (( DT_MM = ${DT_MM} + 0 ))
   (( DT_DD = ${DT_DD} + 0 ))
   (( DT_HH = ${DT_HH} + 0 ))
   if [[ ${HH} -eq 0 ]]; then
      export TMP_DATE=$(${BUILD_DIR}/da_advance_time.exe ${DATE} -1 2>/dev/null)
      export TMP_YYYY=$(echo $TMP_DATE | cut -c1-4)
      export TMP_YY=$(echo $TMP_DATE | cut -c3-4)
      export TMP_MM=$(echo $TMP_DATE | cut -c5-6)
      export TMP_DD=$(echo $TMP_DATE | cut -c7-8)
      export TMP_HH=$(echo $TMP_DATE | cut -c9-10)
      export D_YYYY=${TMP_YYYY}
      export D_YY=${TMP_YY}
      export D_MM=${TMP_MM}
      export D_DD=${TMP_DD}
      export D_HH=24
      (( DD_MM = ${D_MM} + 0 ))
      (( DD_DD = ${D_DD} + 0 ))
      (( DD_HH = ${D_HH} + 0 ))
   else
      export D_YYYY=${YYYY}
      export D_YY=${YY}
      export D_MM=${MM}
      export D_DD=${DD}
      export D_HH=${HH}
      (( DD_MM = ${D_MM} + 0 ))
      (( DD_DD = ${D_DD} + 0 ))
      (( DD_HH = ${D_HH} + 0 ))
   fi
   export D_DATE=${D_YYYY}${D_MM}${D_DD}${D_HH}
#
# CALCULATE GREGORIAN TIMES FOR START AND END OF ASSIMILATION WINDOW
   set -A GREG_DATA `echo $DATE 0 -g | ${WRFCHEM_DART_WORK_DIR}/advance_time`
   export DAY_GREG=${GREG_DATA[0]}
   export SEC_GREG=${GREG_DATA[1]}
   set -A GREG_DATA `echo $NEXT_DATE 0 -g | ${WRFCHEM_DART_WORK_DIR}/advance_time`
   export NEXT_DAY_GREG=${GREG_DATA[0]}
   export NEXT_SEC_GREG=${GREG_DATA[1]}
   export ASIM_WINDOW=3
   export ASIM_MIN_DATE=$($BUILD_DIR/da_advance_time.exe $DATE -$ASIM_WINDOW 2>/dev/null)
   export ASIM_MIN_YYYY=$(echo $ASIM_MIN_DATE | cut -c1-4)
   export ASIM_MIN_YY=$(echo $ASIM_MIN_DATE | cut -c3-4)
   export ASIM_MIN_MM=$(echo $ASIM_MIN_DATE | cut -c5-6)
   export ASIM_MIN_DD=$(echo $ASIM_MIN_DATE | cut -c7-8)
   export ASIM_MIN_HH=$(echo $ASIM_MIN_DATE | cut -c9-10)
   export ASIM_MAX_DATE=$($BUILD_DIR/da_advance_time.exe $DATE +$ASIM_WINDOW 2>/dev/null)
   export ASIM_MAX_YYYY=$(echo $ASIM_MAX_DATE | cut -c1-4)
   export ASIM_MAX_YY=$(echo $ASIM_MAX_DATE | cut -c3-4)
   export ASIM_MAX_MM=$(echo $ASIM_MAX_DATE | cut -c5-6)
   export ASIM_MAX_DD=$(echo $ASIM_MAX_DATE | cut -c7-8)
   export ASIM_MAX_HH=$(echo $ASIM_MAX_DATE | cut -c9-10)
   set -A temp `echo $ASIM_MIN_DATE 0 -g | ${WRFCHEM_DART_WORK_DIR}/advance_time`
   export ASIM_MIN_DAY_GREG=${temp[0]}
   export ASIM_MIN_SEC_GREG=${temp[1]}
   set -A temp `echo $ASIM_MAX_DATE 0 -g | ${WRFCHEM_DART_WORK_DIR}/advance_time` 
   export ASIM_MAX_DAY_GREG=${temp[0]}
   export ASIM_MAX_SEC_GREG=${temp[1]}
#
# SELECT COMPONENT RUN OPTIONS:
# FOR GENERAL CYCLING   
   if [[ ${RUN_SPECIAL_FORECAST} = "false" ]]; then
      export RUN_DART_FILTER=false
      export RUN_BIAS_CORRECTION=false
      export RUN_UPDATE_BC=false
      export RUN_ENSEMBLE_MEAN_INPUT=true
      if [[ ${DATE} -eq ${INITIAL_DATE}  ]]; then
         export RUN_WRFCHEM_INITIAL=true
      else
         export RUN_WRFCHEM_CYCLE_CR=false
      fi	  
      export RUN_WRFCHEM_CYCLE_FR=false
      export RUN_ENSMEAN_CYCLE_FR=false
      export RUN_ENSEMBLE_MEAN_OUTPUT=true
      export RUN_BAND_DEPTH=false
   else
#
# FOR SPECIAL CYCLING       
      export RUN_DART_FILTER=false
      export RUN_BIAS_CORRECTION=false
      export RUN_UPDATE_BC=false
      export RUN_ENSEMBLE_MEAN_INPUT=true
      if [[ ${DATE} -eq ${INITIAL_DATE}  ]]; then
         export RUN_WRFCHEM_INITIAL=true
      else	  
         export RUN_WRFCHEM_CYCLE_CR=true
      fi
      export RUN_WRFCHEM_CYCLE_FR=false
      export RUN_ENSMEAN_CYCLE_FR=false
      export RUN_ENSEMBLE_MEAN_OUTPUT=true
      export RUN_BAND_DEPTH=false
   fi
#
# FOR FINE GRID FORECASTING
   if [[ ${RUN_FINE_SCALE} = "true" ]]; then
      export RUN_DART_FILTER=false
      export RUN_BIAS_CORRECTION=false
      export RUN_UPDATE_BC=false
      export RUN_ENSEMBLE_MEAN_INPUT=false
      if [[ ${DATE} -eq ${INITIAL_DATE}  ]]; then      
         export RUN_WRFCHEM_INITIAL=false
      else 
         export RUN_WRFCHEM_CYCLE_CR=false
      fi
      export RUN_WRFCHEM_CYCLE_FR=false
      export RUN_ENSMEAN_CYCLE_FR=true
      export RUN_ENSEMBLE_MEAN_OUTPUT=true
      export RUN_BAND_DEPTH=false
   fi
#
# FORECAST PARAMETERS:
   export USE_DART_INFL=true
   export FCST_PERIOD=6
   (( CYCLE_PERIOD_SEC=${CYCLE_PERIOD}*60*60 ))
   export NUM_MEMBERS=10
   export MAX_DOMAINS=02
   export CR_DOMAIN=01
   export FR_DOMAIN=02
   export NNXP_CR=179
   export NNYP_CR=139
   export NNZP_CR=36
   export NNXP_FR=320
   export NNYP_FR=290
   export NNZP_FR=36
   (( NNXP_STAG_CR=${NNXP_CR}+1 ))
   (( NNYP_STAG_CR=${NNYP_CR}+1 ))
   (( NNZP_STAG_CR=${NNZP_CR}+1 ))
   (( NNXP_STAG_FR=${NNXP_FR}+1 ))
   (( NNYP_STAG_FR=${NNYP_FR}+1 ))
   (( NNZP_STAG_FR=${NNZP_FR}+1 ))
   export NSPCS=61
   export NNZ_CHEM=11
   export NNCHEM_SPC=49
   export NNFIRE_SPC=31
   export NNBIO_SPC=1
   export NZ_CHEMI=${NNZ_CHEM}
   export NZ_FIRECHEMI=1
   export NCHEMI_EMISS=8
   export NFIRECHEMI_EMISS=9
   export ISTR_CR=1
   export JSTR_CR=1
   export ISTR_FR=86
   export JSTR_FR=35
   export DX_CR=15000
   export DX_FR=3000
   (( LBC_END=2*${FCST_PERIOD} ))
   export LBC_FREQ=3
   (( INTERVAL_SECONDS=${LBC_FREQ}*60*60 ))
   export LBC_START=0
   export START_DATE=${DATE}
   export END_DATE=$($BUILD_DIR/da_advance_time.exe ${START_DATE} ${FCST_PERIOD} 2>/dev/null)
   export START_YEAR=$(echo $START_DATE | cut -c1-4)
   export START_YEAR_SHORT=$(echo $START_DATE | cut -c3-4)
   export START_MONTH=$(echo $START_DATE | cut -c5-6)
   export START_DAY=$(echo $START_DATE | cut -c7-8)
   export START_HOUR=$(echo $START_DATE | cut -c9-10)
   export START_FILE_DATE=${START_YEAR}-${START_MONTH}-${START_DAY}_${START_HOUR}:00:00
   export END_YEAR=$(echo $END_DATE | cut -c1-4)
   export END_MONTH=$(echo $END_DATE | cut -c5-6)
   export END_DAY=$(echo $END_DATE | cut -c7-8)
   export END_HOUR=$(echo $END_DATE | cut -c9-10)
   export END_FILE_DATE=${END_YEAR}-${END_MONTH}-${END_DAY}_${END_HOUR}:00:00
#
# LARGE SCALE FORECAST PARAMETERS:
   export FG_TYPE=GFS
   export GRIB_PART1=gfs_4_
   export GRIB_PART2=.g2.tar
#
# COMPUTER PARAMETERS:
   export PROJ_NUMBER=P93300612
   export ACCOUNT=s2467
   export DEBUG_JOB_CLASS=debug
   export DEBUG_TIME_LIMIT=01:59:00
   export DEBUG_NODES=2
   export DEBUG_TASKS=16
#   export GENERAL_JOB_CLASS=normal
#   export GENERAL_TIME_LIMIT=00:20:00
#   export GENERAL_NODES=1
#   export GENERAL_TASKS=16
   export GENERAL_JOB_CLASS=devel
   export GENERAL_TIME_LIMIT=00:20:00
   export GENERAL_NODES=1
   export GENERAL_TASKS=16
   export WRFDA_JOB_CLASS=normal
   export WRFDA_TIME_LIMIT=00:05:00
   export WRFDA_NODES=1
   export WRFDA_TASKS=16
   export SINGLE_JOB_CLASS=normal
   export SINGLE_TIME_LIMIT=00:10:00
   export SINGLE_NODES=1
   export SINGLE_TASKS=1
   export BIO_JOB_CLASS=normal
   export BIO_TIME_LIMIT=00:20:00
   export BIO_NODES=1
   export BIO_TASKS=1
   export FILTER_JOB_CLASS=normal
   export FILTER_TIME_LIMIT=05:30:00
   export FILTER_NODES=3
   export FILTER_TASKS=16
# Sandy Bridge
   export FILTER_JOB_CLASS=devel
   export FILTER_TIME_LIMIT=01:59:00
   export FILTER_NODES=2
   export FILTER_TASKS=16
# Haswell
   export FILTER_JOB_CLASS=normal
   export FILTER_TIME_LIMIT=07:59:00
   export FILTER_NODES=3
   export FILTER_TASKS=24
   export WRFCHEM_JOB_CLASS=normal
   export WRFCHEM_TIME_LIMIT=00:40:00
   export WRFCHEM_NODES=2
   export WRFCHEM_TASKS=16
#   export WRFCHEM_JOB_CLASS=devel
#   export WRFCHEM_TIME_LIMIT=01:59:00
#   export WRFCHEM_NODES=2
#   export WRFCHEM_TASKS=16
   export PERT_JOB_CLASS=normal
   export PERT_TIME_LIMIT=02:30:00
   export PERT_NODES=1
   (( PERT_TASKS=${NUM_MEMBERS}+1 ))
#   export PERT_JOB_CLASS=devel
#   export PERT_TIME_LIMIT=01:59:00
#   export PERT_NODES=1
#   (( PERT_TASKS=${NUM_MEMBERS}+1 ))
#
# RUN_INPUT_DIR DIRECTORIES
   export GEOGRID_DIR=${RUN_INPUT_DIR}/geogrid
   export METGRID_DIR=${RUN_INPUT_DIR}/${DATE}/metgrid
   export REAL_DIR=${RUN_INPUT_DIR}/${DATE}/real
   export WRFCHEM_MET_IC_DIR=${RUN_INPUT_DIR}/${DATE}/wrfchem_met_ic
   export WRFCHEM_MET_BC_DIR=${RUN_INPUT_DIR}/${DATE}/wrfchem_met_bc
   export EXO_COLDENS_DIR=${RUN_INPUT_DIR}/${DATE}/exo_coldens
   export SEASONS_WES_DIR=${RUN_INPUT_DIR}/${DATE}/seasons_wes
   export WRFCHEM_BIO_DIR=${RUN_INPUT_DIR}/${DATE}/wrfchem_bio
   export WRFCHEM_FIRE_DIR=${RUN_INPUT_DIR}/${DATE}/wrfchem_fire
   export WRFCHEM_CHEMI_DIR=${RUN_INPUT_DIR}/${DATE}/wrfchem_chemi
   export WRFCHEM_CHEM_ICBC_DIR=${RUN_INPUT_DIR}/${DATE}/wrfchem_chem_icbc
   export WRFCHEM_CHEM_EMISS_DIR=${RUN_INPUT_DIR}/${DATE}/wrfchem_chem_emiss
   export PREPBUFR_MET_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/prepbufr_met_obs
   export MOPITT_CO_TOTAL_COL_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/mopitt_co_total_col_obs
   export MOPITT_CO_PROFILE_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/mopitt_co_profile_obs
   export MOPITT_CO_CPSR_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/mopitt_co_cpsr_obs
   export IASI_CO_TOTAL_COL_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/iasi_co_total_col_obs
   export IASI_CO_PROFILE_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/iasi_co_profile_obs
   export IASI_CO_CPSR_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/iasi_co_cpsr_obs
   export IASI_O3_PROFILE_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/iasi_o3_profile_obs
   export IASI_O3_CPSR_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/iasi_o3_cpsr_obs
   export MODIS_AOD_TOTAL_COL_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/modis_aod_total_col_obs
   export OMI_O3_TOTAL_COL_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/omi_o3_total_col_obs
   export OMI_O3_TROP_COL_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/omi_o3_trop_col_obs
   export OMI_O3_PROFILE_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/omi_o3_profile_obs
   export OMI_O3_CPSR_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/omi_o3_cpsr_obs
   export OMI_NO2_TOTAL_COL_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/omi_no2_total_col_obs
   export OMI_NO2_TROP_COL_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/omi_no2_trop_col_obs
   export OMI_NO2_DOMINO_TOTAL_COL_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/omi_no2_domino_total_col_obs
   export OMI_NO2_DOMINO_TROP_COL_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/omi_no2_domino_trop_col_obs
   export OMI_SO2_TOTAL_COL_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/omi_so2_total_col_obs
   export OMI_SO2_PBL_COL_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/omi_so2_pbl_col_obs
   export OMI_HCHO_TOTAL_COL_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/omi_hcho_total_col_obs
   export OMI_HCHO_TROP_COL_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/omi_hcho_trop_col_obs
   export TROPOMI_CO_TOTAL_COL_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/tropomi_co_total_col_obs
   export TROPOMI_O3_TOTAL_COL_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/tropomi_o3_total_col_obs
   export TROPOMI_O3_TROP_COL_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/tropomi_o3_trop_col_obs
   export TROPOMI_O3_PROFILE_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/tropomi_o3_profile_obs
   export TROPOMI_O3_CPSR_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/tropomi_o3_cpsr_obs
   export TROPOMI_NO2_TOTAL_COL_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/tropomi_no2_total_col_obs
   export TROPOMI_NO2_TROP_COL_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/tropomi_no2_trop_col_obs
   export TROPOMI_SO2_TOTAL_COL_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/tropomi_so2_total_col_obs
   export TROPOMI_SO2_PBL_COL_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/tropomi_so2_pbl_col_obs
   export TROPOMI_CH4_TOTAL_COL_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/tropomi_ch4_total_col_obs
   export TROPOMI_CH4_TROP_COL_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/tropomi_ch4_trop_col_obs
   export TROPOMI_CH4_PROFILE_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/tropomi_ch4_profile_obs
   export TROPOMI_CH4_CPSR_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/tropomi_ch4_cpsr_obs
   export TROPOMI_HCHO_TOTAL_COL_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/tropomi_hcho_total_col_obs
   export TROPOMI_HCHO_TROP_COL_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/tropomi_hcho_trop_col_obs
   export TEMPO_O3_TOTAL_COL_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/tempo_o3_total_col_obs
   export TEMPO_O3_TROP_COL_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/tempo_o3_trop_col_obs
   export TEMPO_O3_PROFILE_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/tempo_o3_profile_obs
   export TEMPO_O3_CPSR_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/tempo_o3_cpsr_obs
   export TEMPO_NO2_TOTAL_COL_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/tempo_no2_total_col_obs
   export TEMPO_NO2_TROP_COL_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/tempo_no2_trop_col_obs
   export TES_CO_TOTAL_COL_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/tes_co_total_col_obs 
   export TES_CO_TROP_COL_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/tes_co_trop_col_obs
   export TES_CO_PROFILE_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/tes_co_profile_obs
   export TES_CO_CPSR_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/tes_co_cpsr_obs
   export TES_CO2_TOTAL_COL_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/tes_co2_total_col_obs
   export TES_CO2_TROP_COL_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/tes_co2_trop_col_obs
   export TES_CO2_PROFILE_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/tes_co2_profile_obs
   export TES_CO2_CPSR_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/tes_co2_cpsr_obs
   export TES_O3_TOTAL_COL_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/tes_o3_total_col_obs
   export TES_O3_TROP_COL_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/tes_o3_trop_col_obs
   export TES_O3_PROFILE_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/tes_o3_profile_obs
   export TES_O3_CPSR_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/tes_o3_cpsr_obs
   export TES_NH3_TOTAL_COL_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/tes_nh3_total_col_obs
   export TES_NH3_TROP_COL_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/tes_nh3_trop_col_obs
   export TES_NH3_PROFILE_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/tes_nh3_profile_obs
   export TES_NH3_CPSR_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/tes_nh3_cpsr_obs
   export TES_CH4_TOTAL_COL_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/tes_ch4_total_col_obs
   export TES_CH4_TROP_COL_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/tes_ch4_trop_col_obs
   export TES_CH4_PROFILE_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/tes_ch4_profile_obs
   export TES_CH4_CPSR_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/tes_ch4_cpsr_obs
   export CRIS_CO_TOTAL_COL_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/cris_co_total_col_obs 
   export CRIS_CO_TROP_COL_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/cris_co_trop_col_obs
   export CRIS_CO_PROFILE_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/cris_co_profile_obs
   export CRIS_CO_CPSR_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/cris_co_cpsr_obs
   export CRIS_CO2_TOTAL_COL_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/cris_co2_total_col_obs
   export CRIS_CO2_TROP_COL_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/cris_co2_trop_col_obs
   export CRIS_CO2_PROFILE_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/cris_co2_profile_obs
   export CRIS_CO2_CPSR_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/cris_co2_cpsr_obs
   export CRIS_O3_TOTAL_COL_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/cris_o3_total_col_obs
   export CRIS_O3_TROP_COL_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/cris_o3_trop_col_obs
   export CRIS_O3_PROFILE_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/cris_o3_profile_obs
   export CRIS_O3_CPSR_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/cris_o3_cpsr_obs
   export CRIS_NH3_TOTAL_COL_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/cris_nh3_total_col_obs
   export CRIS_NH3_TROP_COL_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/cris_nh3_trop_col_obs
   export CRIS_NH3_PROFILE_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/cris_nh3_profile_obs
   export CRIS_NH3_CPSR_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/cris_nh3_cpsr_obs
   export CRIS_CH4_TOTAL_COL_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/cris_ch4_total_col_obs
   export CRIS_CH4_TROP_COL_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/cris_ch4_trop_col_obs
   export CRIS_CH4_PROFILE_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/cris_ch4_profile_obs
   export CRIS_CH4_CPSR_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/cris_ch4_cpsr_obs
   export CRIS_PAN_TOTAL_COL_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/cris_pan_total_col_obs
   export CRIS_PAN_TROP_COL_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/cris_pan_trop_col_obs
   export CRIS_PAN_PROFILE_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/cris_pan_profile_obs
   export CRIS_PAN_CPSR_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/cris_pan_cpsr_obs
   export SCIAM_NO2_TOTAL_COL_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/sciam_no2_total_col_obs
   export SCIAM_NO2_TROP_COL_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/sciam_no2_trop_col_obs
   export GOME2A_NO2_TOTAL_COL_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/gome2a_no2_total_col_obs
   export GOME2A_NO2_TROP_COL_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/gome2a_no2_trop_col_obs
   export MLS_O3_TOTAL_COL_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/mls_o3_total_col_obs
   export MLS_O3_PROFILE_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/mls_o3_profile_obs
   export MLS_O3_CPSR_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/mls_o3_cpsr_obs
   export MLS_HNO3_TOTAL_COL_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/mls_hno3_total_col_obs
   export MLS_HNO3_PROFILE_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/mls_hno3_profile_obs
   export MLS_HNO3_CPSR_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/mls_hno3_cpsr_obs
   export AIRNOW_CO_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/airnow_co_obs
   export AIRNOW_O3_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/airnow_o3_obs
   export AIRNOW_NO2_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/airnow_no2_obs
   export AIRNOW_SO2_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/airnow_so2_obs
   export AIRNOW_PM10_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/airnow_pm10_obs
   export AIRNOW_PM25_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/airnow_pm25_obs
   export PANDA_CO_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/panda_co_obs
   export PANDA_O3_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/panda_o3_obs
   export PANDA_PM25_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/panda_pm25_obs
   export COMBINE_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/combine_obs
   export PREPROCESS_OBS_DIR=${RUN_INPUT_DIR}/${DATE}/preprocess_obs
   export LOCALIZATION_DIR=${RUN_INPUT_DIR}/${DATE}/localization
#
# RUN_DIR DIRECTORIES 
   export WRFCHEM_INITIAL_DIR=${RUN_DIR}/${INITIAL_DATE}/wrfchem_initial
   export WRFCHEM_CYCLE_CR_DIR=${RUN_DIR}/${DATE}/wrfchem_cycle_cr
   export WRFCHEM_CYCLE_FR_DIR=${RUN_DIR}/${DATE}/wrfchem_cycle_fr
   export WRFCHEM_LAST_CYCLE_CR_DIR=${RUN_DIR}/${PAST_DATE}/wrfchem_cycle_cr
   export DART_FILTER_DIR=${RUN_DIR}/${DATE}/dart_filter
   export UPDATE_BC_DIR=${RUN_DIR}/${DATE}/update_bc
   export BAND_DEPTH_DIR=${RUN_DIR}/${DATE}/band_depth
   export ENSEMBLE_MEAN_INPUT_DIR=${RUN_DIR}/${DATE}/ensemble_mean_input
   export ENSEMBLE_MEAN_OUTPUT_DIR=${RUN_DIR}/${DATE}/ensemble_mean_output
   export REAL_TIME_DIR=${DART_DIR}/apm_run_scripts/RUN_REAL_TIME
#
# WPS PARAMETERS:
   export SINGLE_FILE=false
   export HOR_SCALE=1500
   export VTABLE_TYPE=GFS
   export METGRID_TABLE_TYPE=ARW
#
# WRF PREPROCESS PARAMETERS
# TARG_LAT=31.56 (33,15) for 072600
# TARG_LON=-120.14 = 239.85 (33,15)
#   export NL_MIN_LAT=27.5
#   export NL_MAX_LAT=38.5
#   export NL_MIN_LON=-125.5
#   export NL_MAX_LON=-115.5
#
# NL_MIN_LON, NL_MAX_LON = [-180.,190.]
# NL_MIN_LAT, NL_MAX_LAT = [-90.,90.]
# NNL_MIN_LON, NNL_MAX_LON = [0.,360.]
# NNL_MIN_LON, NNL_MAX_LON = [-90.,90.]
#
   export NL_MIN_LAT=27
   export NL_MAX_LAT=48
   export NL_MIN_LON=-132
   export NL_MAX_LON=-94
#
   export NNL_MIN_LON=${NL_MIN_LON}
   if [[ ${NL_MIN_LON} -lt 0 ]]; then
      (( NNL_MIN_LON=${NL_MIN_LON}+360 ))
   fi
   export NNL_MAX_LON=${NL_MAX_LON}
   if [[ ${NL_MAX_LON} -lt 0 ]]; then
      (( NNL_MAX_LON=${NL_MAX_LON}+360 ))
   fi
   export NNL_MIN_LAT=${NL_MIN_LAT}
   export NNL_MAX_LAT=${NL_MAX_LAT}
   export NL_OBS_PRESSURE_TOP=1000.
#
# Forward operator parameters
   export NL_NLAYER_MODEL=${NNZP_CR}
   export NL_NLAYER_MOPITT_CO_TOTAL_COL=10
   export NL_NLAYER_MOPITT_CO_PROFILE=10
   export NL_NLAYER_MOPITT_CO_CPSR=10
   export NL_NLAYER_IASI_CO_TOTAL_COL=19
   export NL_NLAYER_IASI_CO_PROFILE=19
   export NL_NLAYER_IASI_CO_CPSR=19
   export NL_NLAYER_IASI_O3_PROFILE=41
   export NL_NLAYER_IASI_O3_CPSR=41
   export NL_NLAYER_OMI_O3_TOTAL_COL=11
   export NL_NLAYER_OMI_O3_TROP_COL=11
   export NL_NLAYER_OMI_O3_PROFILE=18
   export NL_NLAYER_OMI_O3_CPSR=18
   export NL_NLAYER_OMI_NO2_TOTAL_COL=40
   export NL_NLAYER_OMI_NO2_TROP_COL=40
   export NL_NLAYER_OMI_NO2_DOMINO_TOTAL_COL=67
   export NL_NLAYER_OMI_NO2_DOMINO_TROP_COL=67
   export NL_NLAYER_OMI_SO2_TOTAL_COL=75
   export NL_NLAYER_OMI_SO2_PBL_COL=75
   export NL_NLAYER_OMI_HCHO_TOTAL_COL=50
   export NL_NLAYER_OMI_HCHO_TROP_COL=50
   export NL_NLAYER_TROPOMI_CO_TOTAL_COL=55
   export NL_NLAYER_TROPOMI_O3_TOTAL_COL=20
   export NL_NLAYER_TROPOMI_O3_TROP_COL=20
   export NL_NLAYER_TROPOMI_O3_PROFILE=20
   export NL_NLAYER_TROPOMI_O3_CPSR=20
   export NL_NLAYER_TROPOMI_NO2_TOTAL_COL=40
   export NL_NLAYER_TROPOMI_NO2_TROP_COL=40
   export NL_NLAYER_TROPOMI_SO2_TOTAL_COL=40
   export NL_NLAYER_TROPOMI_SO2_PBL_COL=40
   export NL_NLAYER_TROPOMI_CH4_TOTAL_COL=40
   export NL_NLAYER_TROPOMI_CH4_TROP_COL=40
   export NL_NLAYER_TROPOMI_CH4_PROFILE=40
   export NL_NLAYER_TROPOMI_CH4_CPSR=40
   export NL_NLAYER_TROPOMI_HCHO_TOTAL_COL=40
   export NL_NLAYER_TROPOMI_HCHO_TROP_COL=40
   export NL_NLAYER_TEMPO_O3_TOTAL_COL=50
   export NL_NLAYER_TEMPO_O3_TROP_COL=50
   export NL_NLAYER_TEMPO_O3_PROFILE=50
   export NL_NLAYER_TEMPO_O3_CPSR=50
   export NL_NLAYER_TEMPO_NO2_TOTAL_COL=50
   export NL_NLAYER_TEMPO_NO2_TROP_COL=50
   export NL_NLAYER_TES_CO_TOTAL_COL=67
   export NL_NLAYER_TES_CO_PROFILE=67
   export NL_NLAYER_TES_CO_CPSR=67
   export NL_NLAYER_TES_CO2_TOTAL_COL=67
   export NL_NLAYER_TES_CO2_PROFILE=67
   export NL_NLAYER_TES_CO2_CPSR=67
   export NL_NLAYER_TES_O3_TOTAL_COL=67
   export NL_NLAYER_TES_O3_PROFILE=67
   export NL_NLAYER_TES_O3_CPSR=67
   export NL_NLAYER_TES_NH3_TOTAL_COL=67
   export NL_NLAYER_TES_NH3_PROFILE=67
   export NL_NLAYER_TES_NH3_CPSR=67
   export NL_NLAYER_TES_CH4_TOTAL_COL=67
   export NL_NLAYER_TES_CH4_PROFILE=67
   export NL_NLAYER_TES_CH4_CPSR=67
   export NL_NLAYER_CRIS_CO_TOTAL_COL=67
   export NL_NLAYER_CRIS_CO_PROFILE=67
   export NL_NLAYER_CRIS_CO_CPSR=67
   export NL_NLAYER_CRIS_O3_TOTAL_COL=67
   export NL_NLAYER_CRIS_O3_PROFILE=67
   export NL_NLAYER_CRIS_O3_CPSR=67
   export NL_NLAYER_CRIS_NH3_TOTAL_COL=67
   export NL_NLAYER_CRIS_NH3_PROFILE=67
   export NL_NLAYER_CRIS_NH3_CPSR=67
   export NL_NLAYER_CRIS_CH4_TOTAL_COL=67
   export NL_NLAYER_CRIS_CH4_PROFILE=67
   export NL_NLAYER_CRIS_CH4_CPSR=67
   export NL_NLAYER_CRIS_PAN_TOTAL_COL=67
   export NL_NLAYER_CRIS_PAN_PROFILE=67
   export NL_NLAYER_CRIS_PAN_CPSR=67
   export NL_NLAYER_SCIAM_NO2_TOTAL_COL=67
   export NL_NLAYER_SCIAM_NO2_TROP_COL=67
   export NL_NLAYER_GOME2A_NO2_TOTAL_COL=67
   export NL_NLAYER_GOME2A_NO2_TROP_COL=67
   export NL_NLAYER_MLS_O3_TOTAL_COL=67
   export NL_NLAYER_MLS_O3_TROP_COL=67
   export NL_NLAYER_MLS_O3_PROFILE=67  
   export NL_NLAYER_MLS_HNO3_TOTAL_COL=67
   export NL_NLAYER_MLS_HNO3_TROP_COL=67
   export NL_NLAYER_MLS_HNO3_PROFILE=67
#
# PERT CHEM PARAMETERS
   export SPREAD_FAC=0.30
   export NL_SPREAD_CHEMI=${SPREAD_FAC}
   export NL_SPREAD_FIRE=0.00
   export NL_SPREAD_BIOG=0.00
   export NL_PERT_CHEM=true
   export NL_PERT_FIRE=false
   export NL_PERT_BIO=false
#
#########################################################################
#
#  NAMELIST PARAMETERS
#
#########################################################################
#
# WPS SHARE NAMELIST:
   export NL_WRF_CORE=\'ARW\'
   export NL_MAX_DOM=${MAX_DOMAINS}
   export NL_IO_FORM_GEOGRID=2
   export NL_OPT_OUTPUT_FROM_GEOGRID_PATH=\'${GEOGRID_DIR}\'
   export NL_ACTIVE_GRID=".true.",".true."
#
# WPS GEOGRID NAMELIST:
   export NL_S_WE=1,1
   export NL_E_WE=${NNXP_STAG_CR},${NNXP_STAG_FR}
   export NL_S_SN=1,1
   export NL_E_SN=${NNYP_STAG_CR},${NNYP_STAG_FR}
   export NL_S_VERT=1,1
   export NL_E_VERT=${NNZP_STAG_CR},${NNZP_STAG_FR}
   export NL_PARENT_ID="0,1"
   export NL_PARENT_GRID_RATIO=1,5
   export NL_I_PARENT_START=${ISTR_CR},${ISTR_FR}
   export NL_J_PARENT_START=${JSTR_CR},${JSTR_FR}
   export NL_GEOG_DATA_RES=\'usgs_lakes+default\',\'usgs_lakes+default\'
   export NL_DX=${DX_CR}
   export NL_DY=${DX_CR}
   export NL_MAP_PROJ=\'lambert\'
   export NL_REF_LAT=40.0
   export NL_REF_LON=-112.0
   export NL_STAND_LON=-105.0
   export NL_TRUELAT1=30.0
   export NL_TRUELAT2=60.0
   export NL_GEOG_DATA_PATH=\'${WPS_GEOG_DIR}\'
   export NL_OPT_GEOGRID_TBL_PATH=\'${WPS_DIR}/geogrid\'
#
# WPS UNGRIB NAMELIST:
   export NL_OUT_FORMAT=\'WPS\'
#
# WPS METGRID NAMELIST:
   export NL_IO_FORM_METGRID=2
#
# WRF NAMELIST:
# TIME CONTROL NAMELIST:
   export NL_RUN_DAYS=0
   export NL_RUN_HOURS=${FCST_PERIOD}
   export NL_RUN_MINUTES=0
   export NL_RUN_SECONDS=0
   export NL_START_YEAR=${START_YEAR},${START_YEAR}
   export NL_START_MONTH=${START_MONTH},${START_MONTH}
   export NL_START_DAY=${START_DAY},${START_DAY}
   export NL_START_HOUR=${START_HOUR},${START_HOUR}
   export NL_START_MINUTE=00,00
   export NL_START_SECOND=00,00
   export NL_END_YEAR=${END_YEAR},${END_YEAR}
   export NL_END_MONTH=${END_MONTH},${END_MONTH}
   export NL_END_DAY=${END_DAY},${END_DAY}
   export NL_END_HOUR=${END_HOUR},${END_HOUR}
   export NL_END_MINUTE=00,00
   export NL_END_SECOND=00,00
   export NL_INTERVAL_SECONDS=${INTERVAL_SECONDS}
   export NL_INPUT_FROM_FILE=".true.",".true."
   export NL_HISTORY_INTERVAL=${HISTORY_INTERVAL_MIN},60
   export NL_FRAMES_PER_OUTFILE=1,1
   export NL_RESTART=".false."
   export NL_RESTART_INTERVAL=1440
   export NL_IO_FORM_HISTORY=2
   export NL_IO_FORM_RESTART=2
   export NL_FINE_INPUT_STREAM=0,2
   export NL_IO_FORM_INPUT=2
   export NL_IO_FORM_BOUNDARY=2
   export NL_AUXINPUT2_INNAME=\'wrfinput_d\<domain\>\'
   export NL_AUXINPUT5_INNAME=\'wrfchemi_d\<domain\>_\<date\>\'
   export NL_AUXINPUT6_INNAME=\'wrfbiochemi_d\<domain\>_\<date\>\'
   export NL_AUXINPUT7_INNAME=\'wrffirechemi_d\<domain\>_\<date\>\'
   export NL_AUXINPUT12_INNAME=\'wrfinput_d\<domain\>\'
   export NL_AUXINPUT2_INTERVAL_M=60480,60480
   export NL_AUXINPUT5_INTERVAL_M=60,60
   export NL_AUXINPUT6_INTERVAL_M=60480,60480
   export NL_AUXINPUT7_INTERVAL_M=60,60
   export NL_AUXINPUT12_INTERVAL_M=60480,60480
   export NL_FRAMES_PER_AUXINPUT2=1,1
   export NL_FRAMES_PER_AUXINPUT5=1,1
   export NL_FRAMES_PER_AUXINPUT6=1,1
   export NL_FRAMES_PER_AUXINPUT7=1,1
   export NL_FRAMES_PER_AUXINPUT12=1,1
   export NL_IO_FORM_AUXINPUT2=2
   export NL_IO_FORM_AUXINPUT5=2
   export NL_IO_FORM_AUXINPUT6=2
   export NL_IO_FORM_AUXINPUT7=2
   export NL_IO_FORM_AUXINPUT12=2
   export NL_IOFIELDS_FILENAME=\'hist_io_flds_v1\',\'hist_io_flds_v2\'
   export NL_WRITE_INPUT=".true."
   export NL_INPUTOUT_INTERVAL=360
   export NL_INPUT_OUTNAME=\'wrfapm_d\<domain\>_\<date\>\'
   export NL_FORCE_USE_OLD_DATA=".true."
#
# DOMAINS NAMELIST:
   export NL_TIME_STEP=60
   export NNL_TIME_STEP=${NL_TIME_STEP}
   export NL_TIME_STEP_FRACT_NUM=0
   export NL_TIME_STEP_FRACT_DEN=1
#
   export NL_USE_ADAPTIVE_TIME_STEP=".true."
   export NL_STEP_TO_OUTPUT_TIME=".true."
   export NL_TARGET_CFL=1.2
   export NL_TARGET_HCFL=.84
   export NL_MAX_STEP_INCREASE_PCT=5
   export NL_STARTING_TIME_STEP=15
   export NL_STARTING_TIME_STEP_DEN=1
   export NL_MAX_TIME_STEP=90
   export NL_MAX_TIME_STEP_DEN=1
   export NL_MIN_TIME_STEP=30
   export NL_MIN_TIME_STEP_DEN=1
#
   export NL_MAX_DOM=${MAX_DOMAINS}
   export NL_S_WE=1,1
   export NL_E_WE=${NNXP_STAG_CR},${NNXP_STAG_FR}
   export NL_S_SN=1,1
   export NL_E_SN=${NNYP_STAG_CR},${NNYP_STAG_FR}
   export NL_S_VERT=1,1
   export NL_E_VERT=${NNZP_STAG_CR},${NNZP_STAG_FR}
   export NL_NUM_METGRID_LEVELS=27
   export NL_NUM_METGRID_SOIL_LEVELS=4
   export NL_DX=${DX_CR},${DX_FR}
   export NL_DY=${DX_CR},${DX_FR}
   export NL_GRID_ID=1,2
   export NL_PARENT_ID=0,1
   export NL_I_PARENT_START=${ISTR_CR},${ISTR_FR}
   export NL_J_PARENT_START=${JSTR_CR},${JSTR_FR}
   export NL_PARENT_GRID_RATIO=1,5
   export NL_PARENT_TIME_STEP_RATIO=1,5
   export NL_FEEDBACK=0
   export NL_SMOOTH_OPTION=1
   export NL_LAGRANGE_ORDER=2
   export NL_INTERP_TYPE=2
   export NL_EXTRAP_TYPE=2
   export NL_T_EXTRAP_TYPE=2
   export NL_USE_SURFACE=".true."
   export NL_USE_LEVELS_BELOW_GROUND=".true."
   export NL_LOWEST_LEV_FROM_SFC=".false."
   export NL_FORCE_SFC_IN_VINTERP=1
   export NL_ZAP_CLOSE_LEVELS=500
   export NL_INTERP_THETA=".false."
   export NL_HYPSOMETRIC_OPT=2
   export NL_P_TOP_REQUESTED=1000.
   export NL_ETA_LEVELS=1.000000,0.996200,0.989737,0.982460,0.974381,0.965422,\
0.955498,0.944507,0.932347,0.918907,0.904075,0.887721,0.869715,0.849928,\
0.828211,0.804436,0.778472,0.750192,0.719474,0.686214,0.650339,0.611803,\
0.570656,0.526958,0.480854,0.432582,0.382474,0.330973,0.278674,0.226390,\
0.175086,0.132183,0.096211,0.065616,0.039773,0.018113,0.000000,
#
# PHYSICS NAMELIST:
   export NL_MP_PHYSICS=8,8
   export NL_RA_LW_PHYSICS=4,4
   export NL_RA_SW_PHYSICS=4,4
   export NL_RADT=15,3
   export NL_SF_SFCLAY_PHYSICS=1,1
   export NL_SF_SURFACE_PHYSICS=2,2
   export NL_BL_PBL_PHYSICS=1,1
   export NL_BLDT=0,0
   export NL_CU_PHYSICS=1,0
   export NL_CUDT=0,0
   export NL_CUGD_AVEDX=1
   export NL_CU_RAD_FEEDBACK=".true.",".true."
   export NL_CU_DIAG=0,0
   export NL_ISFFLX=1
   export NL_IFSNOW=0
   export NL_ICLOUD=1
   export NL_SURFACE_INPUT_SOURCE=1
   export NL_NUM_SOIL_LAYERS=4
   export NL_MP_ZERO_OUT=2
   export NL_NUM_LAND_CAT=28
   export NL_SF_URBAN_PHYSICS=1,1
   export NL_MAXIENS=1
   export NL_MAXENS=3
   export NL_MAXENS2=3
   export NL_MAXENS3=16
   export NL_ENSDIM=144
#
# DYNAMICS NAMELIST:
   export NL_ISO_TEMP=200.
   export NL_TRACER_OPT=0,0
   export NL_W_DAMPING=1
   export NL_DIFF_OPT=2
   export NL_DIFF_6TH_OPT=0,0
   export NL_DIFF_6TH_FACTOR=0.12,0.12
   export NL_KM_OPT=4
   export NL_DAMP_OPT=1
   export NL_ZDAMP=5000,5000
   export NL_DAMPCOEF=0.15,0.15
   export NL_NON_HYDROSTATIC=".true.",".true."
   export NL_USE_BASEPARAM_FR_NML=".true."
   export NL_MOIST_ADV_OPT=2,2
   export NL_SCALAR_ADV_OPT=2,2
   export NL_CHEM_ADV_OPT=2,2
   export NL_TKE_ADV_OPT=2,2
   export NL_H_MOM_ADV_ORDER=5,5
   export NL_V_MOM_ADV_ORDER=3,3
   export NL_H_SCA_ADV_ORDER=5,5
   export NL_V_SCA_ADV_ORDER=3,3
   export NL_HYBRID_OPT=0
#
# BDY_CONTROL NAMELIST:
   export NL_SPEC_BDY_WIDTH=5
   export NL_SPEC_ZONE=1
   export NL_RELAX_ZONE=4
   export NL_SPECIFIED=".true.",".false."
   export NL_NESTED=".false.",".true."
#
# QUILT NAMELIST:
   export NL_NIO_TASKS_PER_GROUP=0
   export NL_NIO_GROUPS=1
#
# NAMELIST CHEM
   export NL_KEMIT=${NNZ_CHEM}
#
# APM NO_CHEM
#   export NL_CHEM_OPT=0,0
   export NL_CHEM_OPT=112,112
   export NL_BIOEMDT=0,0
   export NL_PHOTDT=0,0
   export NL_CHEMDT=0,0
   export NL_IO_STYLE_EMISSIONS=2
   export NL_EMISS_INPT_OPT=111,111
   export NL_EMISS_OPT=8,8
   export NL_EMISS_OPT_VOL=0,0
   export NL_CHEM_IN_OPT=1,1
   export NL_PHOT_OPT=3,3
   export NL_GAS_DRYDEP_OPT=1,1
   export NL_AER_DRYDEP_OPT=1,1
   export NL_BIO_EMISS_OPT=3,3
   export NL_NE_AREA=118
   export NL_GAS_BC_OPT=112,112
   export NL_GAS_IC_OPT=112,112
   export NL_GAS_BC_OPT=112,112
   export NL_AER_BC_OPT=112,112
   export NL_AER_IC_OPT=112,112
   export NL_GASCHEM_ONOFF=1,1
   export NL_AERCHEM_ONOFF=1,1
#
# APM NO_CHEM
#   export NL_WETSCAV_ONOFF=0,0
   export NL_WETSCAV_ONOFF=1,1
   export NL_CLDCHEM_ONOFF=0,0
   export NL_VERTMIX_ONOFF=1,1
   export NL_CHEM_CONV_TR=0,0
   export NL_CONV_TR_WETSCAV=1,1
   export NL_CONV_TR_AQCHEM=0,0
   export NL_SEAS_OPT=0
#
# APM NO_CHEM
#   export NL_DUST_OPT=0
   export NL_DUST_OPT=1
   export NL_DMSEMIS_OPT=1
   export NL_BIOMASS_BURN_OPT=2,2
   export NL_PLUMERISEFIRE_FRQ=15,15
   export NL_SCALE_FIRE_EMISS=".true.",".true."
   export NL_HAVE_BCS_CHEM=".true.",".true."
#
# APM NO_CHEM
   export NL_AER_RA_FEEDBACK=0,0
#   export NL_AER_RA_FEEDBACK=1,1
   export NL_CHEMDIAG=0,1
   export NL_AER_OP_OPT=1
   export NL_OPT_PARS_OUT=1
   export NL_HAVE_BCS_UPPER=".true.",".true."
   export NL_FIXED_UBC_PRESS=50.,50.
   export NL_FIXED_UBC_INNAME=\'ubvals_b40.20th.track1_1996-2005.nc\'
#
# WRFDA NAMELIST PARAMETERS
# WRFVAR1 NAMELIST:
   export NL_PRINT_DETAIL_GRAD=false
   export NL_VAR4D=false
   export NL_MULTI_INC=0
#
# WRFVAR3 NAMELIST:
   export NL_OB_FORMAT=1
   export NL_NUM_FGAT_TIME=1
#
# WRFVAR4 NAMELIST:
   export NL_USE_SYNOPOBS=true
   export NL_USE_SHIPOBS=false
   export NL_USE_METAROBS=true
   export NL_USE_SOUNDOBS=true
   export NL_USE_MTGIRSOBS=false
   export NL_USE_PILOTOBS=true
   export NL_USE_AIREOBS=true
   export NL_USE_GEOAMVOBS=false
   export NL_USE_POLARAMVOBS=false
   export NL_USE_BOGUSOBS=false
   export NL_USE_BUOYOBS=false
   export NL_USE_PROFILEROBS=false
   export NL_USE_SATEMOBS=false
   export NL_USE_GPSPWOBS=false
   export NL_USE_GPSREFOBS=false
   export NL_USE_SSMIRETRIEVALOBS=false
   export NL_USE_QSCATOBS=false
   export NL_USE_AIRSRETOBS=false
#
# WRFVAR5 NAMELIST:
   export NL_CHECK_MAX_IV=true
   export NL_PUT_RAND_SEED=true
#
# WRFVAR6 NAMELIST:
   export NL_NTMAX=100
#
# WRFVAR7 NAMELIST:
   export NL_JE_FACTOR=1.0
   export NL_CV_OPTIONS=3
   export NL_AS1=0.25,2.0,1.0
   export NL_AS2=0.25,2.0,1.0
   export NL_AS3=0.25,2.0,1.0
   export NL_AS4=0.25,2.0,1.0
   export NL_AS5=0.25,2.0,1.0
#
# WRFVAR11 NAMELIST:
   export NL_CV_OPTIONS_HUM=1
   export NL_CHECK_RH=2
   export NL_SEED_ARRAY1=$(${BUILD_DIR}/da_advance_time.exe ${DATE} 0 -f hhddmmyycc)
   export NL_SEED_ARRAY2=`echo ${NUM_MEMBERS} \* 100000 | bc -l `
   export NL_CALCULATE_CG_COST_FN=true
   export NL_LAT_STATS_OPTION=false
#
# WRFVAR15 NAMELIST:
   export NL_NUM_PSEUDO=0
   export NL_PSEUDO_X=0
   export NL_PSEUDO_Y=0
   export NL_PSEUDO_Z=0
   export NL_PSEUDO_ERR=0.0
   export NL_PSEUDO_VAL=0.0
#
# WRFVAR16 NAMELIST:
   export NL_ALPHACV_METHOD=2
   export NL_ENSDIM_ALPHA=0
   export NL_ALPHA_CORR_TYPE=3
   export NL_ALPHA_CORR_SCALE=${HOR_SCALE}
   export NL_ALPHA_STD_DEV=1.0
   export NL_ALPHA_VERTLOC_OPT=0
#
# WRFVAR17 NAMELIST:
   export NL_ANALYSIS_TYPE=\'RANDOMCV\'
#
# WRFVAR18 NAMELIST:
   export ANALYSIS_DATE=$(${BUILD_DIR}/da_advance_time.exe ${DATE} 0 -W 2>/dev/null)
#
# WRFVAR19 NAMELIST:
   export NL_PSEUDO_VAR=\'t\'
#
# WRFVAR21 NAMELIST:
   export NL_TIME_WINDOW_MIN=\'$(${BUILD_DIR}/da_advance_time.exe ${DATE} -${ASIM_WINDOW} -W 2>/dev/null)\'
#
# WRFVAR22 NAMELIST:
   export NL_TIME_WINDOW_MAX=\'$(${BUILD_DIR}/da_advance_time.exe ${DATE} +${ASIM_WINDOW} -W 2>/dev/null)\'
#
# WRFVAR23 NAMELIST:
   export NL_JCDFI_USE=false
   export NL_JCDFI_IO=false
#
# DART input.nml parameters
# &filter.nml
   export NL_COMPUTE_POSTERIOR=.true.
   export NL_INPUT_QC_THRESHOLD=3.
   export NL_OUTLIER_THRESHOLD=3.
   export NL_ENABLE_SPECIAL_OUTLIER_CODE=.true.
   export NL_SPECIAL_OUTLIER_THRESHOLD=4.
   export NL_ENS_SIZE=${NUM_MEMBERS}
   export NL_OUTPUT_RESTART=.true.
   export NL_START_FROM_RESTART=.true.
   export NL_OBS_SEQUENCE_IN_NAME="'obs_seq.out'"       
   export NL_OBS_SEQUENCE_OUT_NAME="'obs_seq.final'"
   export NL_RESTART_IN_FILE_NAME="'filter_ic_old'"       
   export NL_RESTART_OUT_FILE_NAME="'filter_ic_new'"       
   set -A temp `echo ${ASIM_MIN_DATE} 0 -g | ${WRFCHEM_DART_WORK_DIR}/advance_time`
   (( temp[1]=${temp[1]}+1 ))
   export NL_FIRST_OBS_DAYS=${temp[0]}
   export NL_FIRST_OBS_SECONDS=${temp[1]}
   set -A temp `echo ${ASIM_MAX_DATE} 0 -g | ${WRFCHEM_DART_WORK_DIR}/advance_time`
   export NL_LAST_OBS_DAYS=${temp[0]}
   export NL_LAST_OBS_SECONDS=${temp[1]}
   export NL_NUM_OUTPUT_STATE_MEMBERS=0
   export NL_NUM_OUTPUT_OBS_MEMBERS=${NUM_MEMBERS}
   if ${USE_DART_INFL}; then
      export NL_INF_FLAVOR_POST=4
   else 
      export NL_INF_FLAVOR_POST=0
   fi
   export NL_INF_FLAVOR_PRIOR=0  
   if [[ ${START_DATE} -eq ${FIRST_DART_INFLATE_DATE} ]]; then
      export NL_INF_INITIAL_FROM_RESTART_PRIOR=.false.
      export NL_INF_SD_INITIAL_FROM_RESTART_PRIOR=.false.
      export NL_INF_INITIAL_FROM_RESTART_POST=.false.
      export NL_INF_SD_INITIAL_FROM_RESTART_POST=.false.
   else
      export NL_INF_INITIAL_FROM_RESTART_PRIOR=.true.
      export NL_INF_SD_INITIAL_FROM_RESTART_PRIOR=.true.
      export NL_INF_INITIAL_FROM_RESTART_POST=.true.
      export NL_INF_SD_INITIAL_FROM_RESTART_POST=.true.
   fi
   export NL_INF_IN_FILE_NAME_PRIOR="'prior_inflate_ic_old'"
   export NL_INF_IN_FILE_NAME_POST="'post_inflate_ics'"
   export NL_INF_OUT_FILE_NAME_PRIOR="'prior_inflate_ic_new'"
   export NL_INF_OUT_FILE_NAME_POST="'prior_inflate_restart'"
   export NL_INF_DIAG_FILE_NAME_PRIOR="'prior_inflate_diag'"
   export NL_INF_DIAG_FILE_NAME_POST="'post_inflate_diag'"
   export NL_INF_INITIAL_PRIOR=1.0
   export NL_INF_INITIAL_POST=1.0
   export NL_INF_SD_INITIAL_PRIOR=0.6
   export NL_INF_SD_INITIAL_POST=0.6
   export NL_INF_DAMPING_PRIOR=0.9
   export NL_INF_DAMPING_POST=0.9
   export NL_INF_LOWER_BOUND_PRIOR=1.0
   export NL_INF_LOWER_BOUND_POST=1.0
   export NL_INF_UPPER_BOUND_PRIOR=100.0
   export NL_INF_UPPER_BOUND_POST=100.0
   export NL_INF_SD_LOWER_BOUND_PRIOR=0.6
   export NL_INF_SD_LOWER_BOUND_POST=0.6
#
# APM: NEED TO ADD NEW CHEMISTRY OBSERVATIONS HERE AND TO VERTICAL LOCALIZATION
# CUTOFF VALUES
#   CO      0.1
#   O3      0.05 
#   NO2     0.05
#   SO2     1.0
#   PM10    0.05
#   PM25    0.05
#   AOD     0.05
#   CO2     0.1
#   NH3     0.1
#   CH4     0.1
#   HNO3    0.1
#   HCHO    0.1
#   PAN     0.1
#   MET SFC 0.05
# &assim_tools_nml
   export NL_CUTOFF=0.1
   export NL_SPECIAL_LOCALIZATION_OBS_TYPES="'MOPITT_CO_TOTAL_COL','MOPITT_CO_PROFILE','MOPITT_CO_CPSR','IASI_CO_TOTAL_COL','IASI_CO_PROFILE','IASI_CO_CPSR','TROPOMI_CO_TOTAL_COL','AIRNOW_CO','IASI_O3_PROFILE','IASI_O3_CPSR','OMI_O3_TOTAL_COL','OMI_O3_TROP_COL','OMI_O3_PROFILE','OMI_O3_CPSR','TROPOMI_O3_TOTAL_COL','TROPOMI_O3_TROP_COL','TROPOMI_O3_PROFILE','TROPOMI_O3_CPSR','TEMPO_O3_TOTAL_COL','TEMPO_O3_TROP_COL','TEMPO_O3_PROFILE','TEMPO_O3_CPSR','AIRNOW_O3','OMI_NO2_TOTAL_COL','OMI_NO2_TROP_COL','TROPOMI_NO2_TOTAL_COL','TROPOMI_NO2_TROP_COL','TEMPO_NO2_TOTAL_COL','TEMPO_NO2_TROP_COL','AIRNOW_NO2','OMI_SO2_TOTAL_COL','OMI_SO2_PBL_COL','TROPOMI_SO2_TOTAL_COL','TROPOMI_SO2_PBL_COL','AIRNOW_SO2','MODIS_AOD_TOTAL_COL','AIRNOW_PM10','AIRNOW_PM25','LAND_SFC_U_WIND_COMPONENT','LAND_SFC_V_WIND_COMPONENT','LAND_SFC_SPECIFIC_HUMIDITY'"
   export NL_SPECIAL_LOCALIZATION_CUTOFFS=0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.1,0.1,0.1,0.1,0.1,0.05,0.05,0.05,0.05,0.05,0.05
   export NL_SAMPLING_ERROR_CORRECTION=.true.
   export NL_ADAPTIVE_LOCALIZATION_THRESHOLD=2000
#
# &ensemble_manager_nml
   export NL_SINGLE_RESTART_FILE_IN=.false.       
   export NL_SINGLE_RESTART_FILE_OUT=.false.       
#
# &assim_model_nml
   export NL_WRITE_BINARY_RESTART_FILE=.true.
#
# &model_nml
   export NL_ADD_EMISS=.${L_ADD_EMISS}.
   export NL_DEFAULT_STATE_VARIABLES=.false.
   export NL_CONV_STATE_VARIABLES="'U',     'QTY_U_WIND_COMPONENT',     'TYPE_U',  'UPDATE','999',
          'V',     'QTY_V_WIND_COMPONENT',     'TYPE_V',  'UPDATE','999',
          'W',     'QTY_VERTICAL_VELOCITY',    'TYPE_W',  'UPDATE','999',
          'PH',    'QTY_GEOPOTENTIAL_HEIGHT',  'TYPE_GZ', 'UPDATE','999',
          'T',     'QTY_POTENTIAL_TEMPERATURE','TYPE_T',  'UPDATE','999',
          'MU',    'QTY_PRESSURE',             'TYPE_MU', 'UPDATE','999',
          'QVAPOR','QTY_VAPOR_MIXING_RATIO',   'TYPE_QV', 'UPDATE','999',
          'QRAIN', 'QTY_RAINWATER_MIXING_RATIO','TYPE_QRAIN', 'UPDATE','999',
          'QCLOUD','QTY_CLOUD_LIQUID_WATER',   'TYPE_QCLOUD', 'UPDATE','999',
          'QSNOW', 'QTY_SNOW_MIXING_RATIO',    'TYPE_QSNOW', 'UPDATE','999',
          'QICE',  'QTY_CLOUD_ICE',            'TYPE_QICE', 'UPDATE','999',
          'U10',   'QTY_U_WIND_COMPONENT',     'TYPE_U10','UPDATE','999',
          'V10',   'QTY_V_WIND_COMPONENT',     'TYPE_V10','UPDATE','999',
          'T2',    'QTY_TEMPERATURE',          'TYPE_T2', 'UPDATE','999',
          'TH2',   'QTY_POTENTIAL_TEMPERATURE','TYPE_TH2','UPDATE','999',
          'Q2',    'QTY_SPECIFIC_HUMIDITY',    'TYPE_Q2', 'UPDATE','999',
          'PSFC',  'QTY_PRESSURE',             'TYPE_PS', 'UPDATE','999',
          'co',    'QTY_CO',                   'TYPE_CO', 'UPDATE','999',
          'o3',    'QTY_O3',                   'TYPE_O3', 'UPDATE','999',
          'no',    'QTY_NO',                   'TYPE_NO', 'UPDATE','999',
          'no2',   'QTY_NO2',                  'TYPE_NO2', 'UPDATE','999',
          'so2',   'QTY_SO2',                  'TYPE_SO2', 'UPDATE','999',
          'sulf',  'QTY_SO4',                  'TYPE_SO4', 'UPDATE','999',
          'hno4',  'QTY_HNO4',                 'TYPE_HNO4', 'UPDATE','999',
          'n2o5',  'QTY_N2O5',                 'TYPE_N2O5', 'UPDATE','999',
          'c2h6',  'QTY_C2H6',                 'TYPE_C2H6', 'UPDATE','999',
          'acet',  'QTY_ACET',                 'TYPE_ACET', 'UPDATE','999',
          'c2h4',  'QTY_C2H4',                 'TYPE_C2H4', 'UPDATE','999',
          'c3h6',  'QTY_C3H6',                 'TYPE_C3H6', 'UPDATE','999',
          'tol',   'QTY_TOL',                  'TYPE_TOL', 'UPDATE','999',
          'mvk',   'QTY_MVK',                  'TYPE_MVK', 'UPDATE','999',
          'bigalk','QTY_BIGALK',               'TYPE_BIGALK', 'UPDATE','999',
          'isopr', 'QTY_ISOPR',                'TYPE_ISOPR', 'UPDATE','999',
          'macr',  'QTY_MACR',                 'TYPE_MACR', 'UPDATE','999',
          'c3h8',  'QTY_C3H8',                 'TYPE_C3H8', 'UPDATE','999',
          'c10h16','QTY_C10H16',               'TYPE_C10H16', 'UPDATE','999',
          'DUST_1','QTY_DST01',                'TYPE_DST01','UPDATE','999',
          'DUST_2','QTY_DST02',                'TYPE_DST02','UPDATE','999',
          'DUST_3','QTY_DST03',                'TYPE_DST03','UPDATE','999',
          'DUST_4','QTY_DST04',                'TYPE_DST04','UPDATE','999',
          'DUST_5','QTY_DST05',                'TYPE_DST05','UPDATE','999',
          'BC1','QTY_BC1',                     'TYPE_BC1','UPDATE','999',
          'BC2','QTY_BC2',                     'TYPE_BC2','UPDATE','999',
          'OC1','QTY_OC1',                     'TYPE_OC1','UPDATE','999',
          'OC2','QTY_OC2',                     'TYPE_OC2','UPDATE','999',
          'TAUAER1','QTY_TAUAER1',             'TYPE_EXTCOF','UPDATE','999',
          'TAUAER2','QTY_TAUAER2',             'TYPE_EXTCOF','UPDATE','999',
          'TAUAER3','QTY_TAUAER3',             'TYPE_EXTCOF','UPDATE','999',
          'TAUAER4','QTY_TAUAER4',             'TYPE_EXTCOF','UPDATE','999',
          'PM10','QTY_PM10',                   'TYPE_PM10','UPDATE','999',
          'P10','QTY_P10',                     'TYPE_P10','UPDATE','999',
          'P25','QTY_P25',                     'TYPE_P25','UPDATE','999',
          'SEAS_1','QTY_SSLT01',               'TYPE_SSLT01','UPDATE','999',
          'SEAS_2','QTY_SSLT02',               'TYPE_SSLT02','UPDATE','999',
          'SEAS_3','QTY_SSLT03',               'TYPE_SSLT03','UPDATE','999',
          'SEAS_4','QTY_SSLT04',               'TYPE_SSLT04','UPDATE','999',
          'hcho',  'QTY_HCHO',                 'TYPE_HCHO', 'UPDATE','999',
          'hno3',  'QTY_HNO3',                 'TYPE_HNO3', 'UPDATE','999',
          'nh3',   'QTY_NH3',                  'TYPE_NH3', 'UPDATE','999',
          'pan',   'QTY_PAN',                  'TYPE_PAN', 'UPDATE','999',
          'ch4',   'QTY_CH4',                  'TYPE_CH4', 'UPDATE','999'"
#
# Both of these need kind and type definitions.
# Also need to modify the WRF-Chem model_mod.f90 to
# add get_type_ind_from_type_string statements   
#
# The next line should be the same as NL_EMISS_CHEMI_VARIABLES without quotes etc.
   export WRFCHEMI_DARTVARS="E_CO,E_NO,E_NO2,E_SO2,E_BC,E_OC,E_PM_10,E_PM_25"
#
# The next line should be the same as NL_EMISS_FIRECHEMI_VARIABLES without quotes etc.
   export WRFFIRECHEMI_DARTVARS="ebu_in_co,ebu_in_no,ebu_in_no2,ebu_in_so2,ebu_in_oc,ebu_in_bc,ebu_in_c2h4,ebu_in_ch2o,ebu_in_ch3oh"
#
   export NL_EMISS_CHEMI_VARIABLES="'E_CO',    'QTY_E_CO',    'TYPE_E_CO',     'UPDATE','999',
          'E_NO'        ,'QTY_E_NO',           'TYPE_E_NO',   'UPDATE','999',
          'E_NO2'       ,'QTY_E_NO2',          'TYPE_E_NO2',  'UPDATE','999',
          'E_SO2'       ,'QTY_E_SO2',          'TYPE_E_SO2',  'UPDATE','999',
          'E_OC'        ,'QTY_E_OC',           'TYPE_E_OC',   'UPDATE','999',
          'E_BC'        ,'QTY_E_BC',           'TYPE_E_BC',   'UPDATE','999',
          'E_PM_10'     ,'QTY_E_PM10',         'TYPE_E_PM10', 'UPDATE','999',
          'E_PM_25'     ,'QTY_E_PM25',         'TYPE_E_PM25', 'UPDATE','999'"
   export NL_EMISS_FIRECHEMI_VARIABLES="'ebu_in_co'   ,'QTY_EBU_CO',         'TYPE_EBU_CO',  'UPDATE','999',
          'ebu_in_no'    ,'QTY_EBU_NO',         'TYPE_EBU_NO',   'UPDATE','999',
          'ebu_in_no2'   ,'QTY_EBU_NO2',        'TYPE_EBU_NO2',  'UPDATE','999',
          'ebu_in_so2'   ,'QTY_EBU_SO2',        'TYPE_EBU_SO2',  'UPDATE','999',
          'ebu_in_oc'    ,'QTY_EBU_OC',         'TYPE_EBU_OC',   'UPDATE','999',
          'ebu_in_bc'    ,'QTY_EBU_BC',         'TYPE_EBU_BC',   'UPDATE','999',
          'ebu_in_c2h4'  ,'QTY_EBU_C2H4',       'TYPE_EBU_C2H4', 'UPDATE','999',
          'ebu_in_ch2o'  ,'QTY_EBU_CH2O',       'TYPE_EBU_CH2O', 'UPDATE','999',
          'ebu_in_ch3oh' ,'QTY_EBU_CH3OH',      'TYPE_EBU_CH3OH','UPDATE','999'"
   export NL_WRF_STATE_BOUNDS="'QVAPOR','0.0','NULL','CLAMP',
          'QRAIN', '0.0','NULL','CLAMP',
          'QCLOUD','0.0','NULL','CLAMP',
          'QSNOW', '0.0','NULL','CLAMP',
          'QICE',  '0.0','NULL','CLAMP',
          'co',    '${CO_MIN}','${CO_MAX}','CLAMP',
          'o3',    '${O3_MIN}','${O3_MAX}','CLAMP',
          'no',    '${NO_MIN}','${NO_MAX}','CLAMP',
          'no2',   '${NO2_MIN}','${NO2_MAX}','CLAMP',
          'so2',   '${SO2_MIN}','${SO2_MAX}','CLAMP',
          'sulf',  '${SO4_MIN}','${SO4_MAX}','CLAMP',
          'hno4',  '0.0','NULL','CLAMP',
          'n2o5',  '0.0','NULL','CLAMP',
          'c2h6',  '0.0','NULL','CLAMP',
          'acet'   '0.0','NULL','CLAMP',
          'c2h4',  '0.0','NULL','CLAMP',
          'c3h6',  '0.0','NULL','CLAMP',
          'tol',   '0.0','NULL','CLAMP',
          'mvk',   '0.0','NULL','CLAMP',
          'bigalk','0.0','NULL','CLAMP',
          'isopr', '0.0','NULL','CLAMP',
          'macr',  '0.0','NULL','CLAMP',
          'c3h8'  ,'0.0','NULL','CLAMP',    
          'c10h16','0.0','NULL','CLAMP',
          'DUST_1','0.0','NULL','CLAMP',
          'DUST_2','0.0','NULL','CLAMP',
          'DUST_3','0.0','NULL','CLAMP',
          'DUST_4','0.0','NULL','CLAMP',
          'DUST_5','0.0','NULL','CLAMP',
          'BC1','0.0','NULL','CLAMP',
          'BC2','0.0','NULL','CLAMP',
          'OC1','0.0','NULL','CLAMP',
          'OC2','0.0','NULL','CLAMP',
          'TAUAER1','0.0','NULL','CLAMP',
          'TAUAER2','0.0','NULL','CLAMP',
          'TAUAER3','0.0','NULL','CLAMP',
          'TAUAER4','0.0','NULL','CLAMP',
          'PM10','0.0','NULL','CLAMP',
          'P10','0.0','NULL','CLAMP',
          'P25','0.0','NULL','CLAMP',
          'SEAS_1','0.0','NULL','CLAMP',
          'SEAS_2','0.0','NULL','CLAMP',
          'SEAS_3','0.0','NULL','CLAMP',
          'SEAS_4','0.0','NULL','CLAMP',
          'hcho'   '0.0','NULL','CLAMP',
          'hno3',  '0.0','NULL','CLAMP',
          'nh3',   '0.0','NULL','CLAMP',
          'pan',   '0.0','NULL','CLAMP',
          'ch4',   '0.0','NULL','CLAMP',
          'E_CO','0.0','NULL','CLAMP',
          'E_NO','0.0','NULL','CLAMP',
          'E_NO2','0.0','NULL','CLAMP',
          'E_SO2','0.0','NULL','CLAMP',
          'E_OC','0.0','NULL','CLAMP',
          'E_BC','0.0','NULL','CLAMP',
          'E_PM_10','0.0','NULL','CLAMP',
          'E_PM_25','0.0','NULL','CLAMP',
          'ebu_in_co','0.0','NULL','CLAMP',
          'ebu_in_no','0.0','NULL','CLAMP',
          'ebu_in_no2','0.0','NULL','CLAMP',
          'ebu_in_so2','0.0','NULL','CLAMP',
          'ebu_in_oc','0.0','NULL','CLAMP',
          'ebu_in_bc','0.0','NULL','CLAMP',
          'ebu_in_c2h4','0.0','NULL','CLAMP',
          'ebu_in_ch2o','0.0','NULL','CLAMP',
          'ebu_in_ch3oh','0.0','NULL','CLAMP'"
   export NL_OUTPUT_STATE_VECTOR=.false.
   export NL_NUM_DOMAINS=${CR_DOMAIN}
   export NL_CALENDAR_TYPE=3
   export NL_ASSIMILATION_PERIOD_SECONDS=${CYCLE_PERIOD_SEC}
# height
#   export NL_VERT_LOCALIZATION_COORD=3
# scale height
   export NL_VERT_LOCALIZATION_COORD=4
   export NL_CENTER_SEARCH_HALF_LENGTH=500000.
   export NL_CENTER_SPLINE_GRID_SCALE=10
   export NL_SFC_ELEV_MAX_DIFF=100.0
   export NL_CIRCULATION_PRES_LEVEL=80000.0
   export NL_CIRCULATION_RADIUS=108000.0
   export NL_ALLOW_OBS_BELOW_VOL=.false.
#
# &obs_diag_nml
   export NL_FIRST_BIN_CENTER_YY=${DT_YYYY}
   export NL_FIRST_BIN_CENTER_MM=${DT_MM}
   export NL_FIRST_BIN_CENTER_DD=${DT_DD}
   export NL_FIRST_BIN_CENTER_HH=${DT_HH}
   export NL_LAST_BIN_CENTER_YY=${DT_YYYY}
   export NL_LAST_BIN_CENTER_MM=${DT_MM}
   export NL_LAST_BIN_CENTER_DD=${DT_DD}
   export NL_LAST_BIN_CENTER_HH=${DT_HH}
   export NL_BIN_SEPERATION_YY=0
   export NL_BIN_SEPERATION_MM=0
   export NL_BIN_SEPERATION_DD=0
   export NL_BIN_SEPERATION_HH=0
   export NL_BIN_WIDTH_YY=0
   export NL_BIN_WIDTH_MM=0
   export NL_BIN_WIDTH_DD=0
   export NL_BIN_WIDTH_HH=0
#
# &restart_file_utility_nml
   export NL_SINGLE_RESTART_FILE_IN=.false.       
   export NL_SINGLE_RESTART_FILE_OUT=.false.       
   export NL_NEW_ADVANCE_DAYS=${NEXT_DAY_GREG}
   export NL_NEW_ADVANCE_SECS=${NEXT_SEC_GREG}
   export NL_OUTPUT_IS_MODEL_ADVANCE_FILE=.true.
   export NL_OVERWRITE_ADVANCE_TIME=.false.
#
# &preprocess_nml
   export NL_INPUT_OBS_KIND_MOD_FILE=\'${DART_DIR}/assimilation_code/modules/observations/DEFAULT_obs_kind_mod.F90\'
   export NL_OUTPUT_OBS_KIND_MOD_FILE=\'${DART_DIR}/assimilation_code/modules/observations/obs_kind_mod.f90\'
   export NL_INPUT_OBS_DEF_MOD_FILE=\'${DART_DIR}/observations/forward_operators/DEFAULT_obs_def_mod.F90\'
   export NL_OUTPUT_OBS_DEF_MOD_FILE=\'${DART_DIR}/observations/forward_operators/obs_def_mod.f90\'
   export NL_INPUT_FILES="'${DART_DIR}/observations/forward_operators/obs_def_reanalysis_bufr_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_upper_atm_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_radar_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_metar_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_dew_point_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_altimeter_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_gps_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_gts_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_vortex_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_AIRNOW_OBS_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_AIRNOW_PM10_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_AIRNOW_PM25_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_PANDA_OBS_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_MOPITT_CO_TOTAL_COL_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_MOPITT_CO_PROFILE_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_MOPITT_V5_CO_PROFILE_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_MOPITT_CO_CPSR_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_IASI_CO_TOTAL_COL_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_IASI_CO_PROFILE_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_IASI_CO_CPSR_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_IASI_O3_PROFILE_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_IASI_O3_CPSR_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_MODIS_AOD_TOTAL_COL_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_OMI_O3_TOTAL_COL_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_OMI_O3_TROP_COL_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_OMI_O3_PROFILE_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_OMI_O3_CPSR_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_OMI_NO2_TOTAL_COL_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_OMI_NO2_TROP_COL_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_OMI_NO2_DOMINO_TOTAL_COL_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_OMI_NO2_DOMINO_TROP_COL_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_OMI_SO2_TOTAL_COL_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_OMI_SO2_PBL_COL_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_OMI_HCHO_TOTAL_COL_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_OMI_HCHO_TROP_COL_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_TROPOMI_CO_TOTAL_COL_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_TROPOMI_O3_TOTAL_COL_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_TROPOMI_O3_TROP_COL_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_TROPOMI_O3_PROFILE_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_TROPOMI_O3_CPSR_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_TROPOMI_NO2_TOTAL_COL_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_TROPOMI_NO2_TROP_COL_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_TROPOMI_SO2_TOTAL_COL_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_TROPOMI_SO2_PBL_COL_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_TROPOMI_CH4_TOTAL_COL_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_TROPOMI_CH4_TROP_COL_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_TROPOMI_CH4_PROFILE_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_TROPOMI_CH4_CPSR_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_TROPOMI_HCHO_TOTAL_COL_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_TROPOMI_HCHO_TROP_COL_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_TEMPO_O3_TOTAL_COL_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_TEMPO_O3_TROP_COL_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_TEMPO_O3_PROFILE_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_TEMPO_O3_CPSR_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_TEMPO_NO2_TOTAL_COL_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_TEMPO_NO2_TROP_COL_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_TES_CO_TOTAL_COL_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_TES_CO_PROFILE_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_TES_CO_CPSR_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_TES_CO2_TOTAL_COL_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_TES_CO2_PROFILE_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_TES_CO2_CPSR_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_TES_O3_TOTAL_COL_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_TES_O3_PROFILE_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_TES_O3_CPSR_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_TES_NH3_TOTAL_COL_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_TES_NH3_PROFILE_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_TES_NH3_CPSR_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_TES_CH4_TOTAL_COL_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_TES_CH4_PROFILE_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_TES_CH4_CPSR_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_CRIS_CO_TOTAL_COL_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_CRIS_CO_PROFILE_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_CRIS_CO_CPSR_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_CRIS_CO2_TOTAL_COL_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_CRIS_CO2_PROFILE_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_CRIS_CO2_CPSR_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_CRIS_O3_TOTAL_COL_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_CRIS_O3_PROFILE_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_CRIS_O3_CPSR_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_CRIS_NH3_TOTAL_COL_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_CRIS_NH3_PROFILE_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_CRIS_NH3_CPSR_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_CRIS_CH4_TOTAL_COL_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_CRIS_CH4_PROFILE_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_CRIS_CH4_CPSR_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_SCIAM_NO2_TOTAL_COL_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_SCIAM_NO2_TROP_COL_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_GOME2A_NO2_TOTAL_COL_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_GOME2A_NO2_TROP_COL_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_MLS_O3_TOTAL_COL_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_MLS_O3_PROFILE_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_MLS_HNO3_TOTAL_COL_mod.f90',
                    '${DART_DIR}/observations/forward_operators/obs_def_MLS_HNO3_PROFILE_mod.f90'"
#
# &obs_kind_nml
   export NL_EVALUATE_THESE_OBS_TYPES=" ",
#
   export NL_ASSIMILATE_THESE_OBS_TYPES="'RADIOSONDE_TEMPERATURE',
                                   'RADIOSONDE_U_WIND_COMPONENT',
                                   'RADIOSONDE_V_WIND_COMPONENT',
                                   'RADIOSONDE_SPECIFIC_HUMIDITY',
                                   'RADIOSONDE_SURFACE_ALTIMETER',
                                   'MARINE_SFC_U_WIND_COMPONENT',
                                   'MARINE_SFC_V_WIND_COMPONENT',
                                   'MARINE_SFC_TEMPERATURE',
                                   'MARINE_SFC_SPECIFIC_HUMIDITY',
                                   'MARINE_SFC_ALTIMETER',
                                   'AIRCRAFT_U_WIND_COMPONENT',
                                   'AIRCRAFT_V_WIND_COMPONENT',
                                   'AIRCRAFT_TEMPERATURE',
                                   'ACARS_U_WIND_COMPONENT',
                                   'ACARS_V_WIND_COMPONENT',
                                   'ACARS_TEMPERATURE',
                                   'LAND_SFC_U_WIND_COMPONENT',
                                   'LAND_SFC_V_WIND_COMPONENT',
                                   'LAND_SFC_TEMPERATURE',
                                   'LAND_SFC_SPECIFIC_HUMIDITY',
                                   'LAND_SFC_ALTIMETER',
                                   'SAT_U_WIND_COMPONENT',
                                   'SAT_V_WIND_COMPONENT',
                                   'MOPITT_CO_PROFILE',
                                   'MOPITT_CO_CPSR',
                                   'IASI_CO_PROFILE',
                                   'IASI_CO_CPSR',
                                   'IASI_O3_PROFILE',
                                   'IASI_O3_CPSR',
                                   'MODIS_AOD_TOTAL_COL'
                                   'OMI_O3_PROFILE',
                                   'OMI_O3_CPSR',
                                   'OMI_NO2_TROP_COL',
                                   'OMI_NO2_DOMINO_TROP_COL',
                                   'OMI_SO2_PBL_COL',
                                   'OMI_HCHO_TOTAL_COL',
                                   'TROPOMI_CO_TOTAL_COL',
                                   'TROPOMI_O3_PROFILE',
                                   'TROPOMI_O3_CPSR',
                                   'TROPOMI_NO2_TROP_COL',
                                   'TROPOMI_SO2_PBL_COL',
                                   'TROPOMI_CH4_TOTAL_COL',
                                   'TROPOMI_HCHO_TOTAL_COL',
                                   'TES_CO_PROFILE',
                                   'TES_CO_CPSR',
                                   'TES_CO2_PROFILE',
                                   'TES_CO2_CPSR',
                                   'TES_O3_PROFILE',
                                   'TES_O3_CPSR',
                                   'TES_NH3_PROFILE',
                                   'TES_NH3_CPSR',
                                   'TES_CH4_PROFILE',
                                   'TES_CH4_CPSR',
                                   'CRIS_CO_PROFILE',
                                   'CRIS_CO_CPSR',
                                   'CRIS_O3_PROFILE',
                                   'CRIS_O3_CPSR',
                                   'CRIS_NH3_PROFILE',
                                   'CRIS_NH3_CPSR',
                                   'CRIS_CH4_PROFILE',
                                   'CRIS_CH4_CPSR',
                                   'CRIS_PAN_TOTAL_COL',
                                   'SCIAM_NO2_TROP_COL',
                                   'GOME2A_NO2_TROP_COL',
                                   'MLS_O3_PROFILE',
                                   'MLS_O3_CPSR',
                                   'MLS_HNO3_PROFILE',
                                   'MLS_HNO3_CPSR',
                                   'AIRNOW_CO',
                                   'AIRNOW_O3',
                                   'AIRNOW_NO2',
                                   'AIRNOW_SO2',
                                   'AIRNOW_PM10',
                                   'AIRNOW_PM25'"
#
# &replace_wrf_fields_nml
   export NL_FIELDNAMES="'SNOWC',
                   'ALBBCK',
                   'TMN',
                   'TSK',
                   'SH2O',
                   'SMOIS',
                   'SEAICE',
                   'HGT_d01',
                   'TSLB',
                   'SST',
                   'SNOWH',
                   'SNOW'"
   export NL_FIELDLIST_FILE="' '"
#
# APM: NEED TO ADD NEW CHEMISTRY OBSERVATIONS HERE AND HORIZONTAL LOCALIZATION  
   
# &location_nml
   export NL_HORIZ_DIST_ONLY=.false.
   export NL_VERT_NORMALIZATION_PRESSURE=100000.0
   export NL_VERT_NORMALIZATION_HEIGHT=10000.0
   export NL_VERT_NORMALIZATION_LEVELS=20.0
   export NL_VERT_NORMALIZATION_SCALE_HEIGHT=1.5
   export NL_SPECIAL_VERT_NORMALIZATION_OBS_TYPES="'MOPITT_CO_TOTAL_COL','MOPITT_CO_PROFILE','MOPITT_CO_CPSR','IASI_CO_TOTAL_COL','IASI_CO_PROFILE','IASI_CO_CPSR','TROPOMI_CO_TOTAL_COL','TES_CO_TOTAL_COL','TES_CO_TROP_COL','TES_CO_PROFILE','TES_CO_CPSR','CRIS_CO_TOTAL_COL','CRIS_CO_PROFILE','CRIS_CO_CPSR','AIRNOW_CO','TES_CO2_TOTAL_COL','TES_CO2_TROP_COL','TES_CO2_PROFILE','TES_CO2_CPSR','IASI_O3_PROFILE','IASI_O3_CPSR','OMI_O3_TOTAL_COL','OMI_O3_TROP_COL','OMI_O3_PROFILE','OMI_O3_CPSR','TROPOMI_O3_TOTAL_COL','TROPOMI_O3_TROP_COL','TROPOMI_O3_PROFILE','TROPOMI_O3_CPSR','TEMPO_O3_TOTAL_COL','TEMPO_O3_TROP_COL','TEMPO_O3_PROFILE','TEMPO_O3_CPSR','TES_O3_TOTAL_COL','TES_O3_TROP_COL','TES_O3_PROFILE','TES_O3_CPSR','CRIS_O3_TOTAL_COL','CRIS_O3_PROFILE','CRIS_O3_CPSR','MLS_O3_TOTAL_COL','MLS_O3_PROFILE','MLS_O3_CPSR','AIRNOW_O3','OMI_NO2_TOTAL_COL','OMI_NO2_TROP_COL','TROPOMI_NO2_TOTAL_COL','TROPOMI_NO2_TROP_COL','TEMPO_NO2_TOTAL_COL','TEMPO_NO2_TROP_COL','OMI_NO2_DOMINO_TOTAL_COL','OMI_NO2_DOMINO_TROP_COL','SCIAM_NO2_TOTAL_COL','SCIAM_NO2_TROP_COL','GOME2A_NO2_TOTAL_COL','GOME2A_NO2_TROP_COL','AIRNOW_NO2','OMI_SO2_TOTAL_COL','OMI_SO2_PBL_COL','TROPOMI_SO2_TOTAL_COL','TROPOMI_SO2_PBL_COL','AIRNOW_SO2','MODIS_AOD_TOTAL_COL','AIRNOW_PM10','AIRNOW_PM25','MLS_HNO3_TOTAL_COL','MLS_HNO3_PROFILE','MLS_HNO3_CPSR','OMI_HCHO_TOTAL_COL','OMI_HCHO_TROP_COL','TROPOMI_HCHO_TOTAL_COL','TROPOMI_HCHO_TROP_COL','TROPOMI_CH4_TOTAL_COL','TROPOMI_CH4_TROP_COL','TROPOMI_CH4_PROFILE','TROPOMI_CH4_CPSR','TES_CH4_TOTAL_COL','TES_CH4_TROP_COL','TES_CH4_PROFILE','TES_CH4_CPSR','CRIS_CH4_TOTAL_COL','CRIS_CH4_PROFILE','CRIS_CH4_CPSR','TES_NH3_TOTAL_COL','TES_NH3_TROP_COL','TES_NH3_PROFILE','TES_NH3_CPSR','CRIS_NH3_TOTAL_COL','CRIS_NH3_PROFILE','CRIS_NH3_CPSR','CRIS_PAN_TOTAL_COL','CRIS_PAN_PROFILE','CRIS_PAN_CPSR','LAND_SFC_U_WIND_COMPONENT','LAND_SFC_V_WIND_COMPONENT','LAND_SFC_SPECIFIC_HUMIDITY'"
   export NL_SPECIAL_VERT_NORMALIZATION_PRESSURES="100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0,100000.0"
   export NL_SPECIAL_VERT_NORMALIZATION_HEIGHTS="10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0,10000.0"
   export NL_SPECIAL_VERT_NORMALIZATION_LEVELS="20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0,20.0"
   export NL_SPECIAL_VERT_NORMALIZATION_SCALE_HEIGHTS="1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5"
#
# &obs_impact_tool_nml 
   export NL_IMPACT_TOOL_INPUT="'variable_localization.txt'"
   export NL_IMPACT_TOOL_OUTPUT="'control_impact_runtime.txt'"
   export NL_DART_DEBUG=.false.
#
# ASSIMILATION WINDOW PARAMETERS
   export ASIM_DATE_MIN=$(${BUILD_DIR}/da_advance_time.exe ${DATE} -${ASIM_WINDOW} 2>/dev/null)
   export ASIM_DATE_MAX=$(${BUILD_DIR}/da_advance_time.exe ${DATE} +${ASIM_WINDOW} 2>/dev/null)
   export ASIM_MN_YYYY=$(echo $ASIM_DATE_MIN | cut -c1-4)
   export ASIM_MN_MM=$(echo $ASIM_DATE_MIN | cut -c5-6)
   export ASIM_MN_DD=$(echo $ASIM_DATE_MIN | cut -c7-8)
   export ASIM_MN_HH=$(echo $ASIM_DATE_MIN | cut -c9-10)
#
   export ASIM_MX_YYYY=$(echo $ASIM_DATE_MAX | cut -c1-4)
   export ASIM_MX_MM=$(echo $ASIM_DATE_MAX | cut -c5-6)
   export ASIM_MX_DD=$(echo $ASIM_DATE_MAX | cut -c7-8)
   export ASIM_MX_HH=$(echo $ASIM_DATE_MAX | cut -c9-10)
#
# WRFCHEM FIRE PARAMETERS:
   export FIRE_START_DATE=${YYYY}-${MM}-${DD}
   export E_DATE=$(${BUILD_DIR}/da_advance_time.exe ${DATE} ${FCST_PERIOD} 2>/dev/null)
   export E_YYYY=$(echo $E_DATE | cut -c1-4)
   export E_MM=$(echo $E_DATE | cut -c5-6)
   export E_DD=$(echo $E_DATE | cut -c7-8)
   export E_HH=$(echo $E_DATE | cut -c9-10)
   export FIRE_END_DATE=${E_YYYY}-${E_MM}-${E_DD}
#
#########################################################################
#
# CREATE RUN DIRECTORY
#
#########################################################################
#
   if [[ ! -e ${RUN_DIR} ]]; then mkdir -p ${RUN_DIR}; fi
   cd ${RUN_DIR}
#
#########################################################################
#
# RUN DART_FILTER
#
#########################################################################
#
   if ${RUN_DART_FILTER}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/dart_filter ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/dart_filter
         cd ${RUN_DIR}/${DATE}/dart_filter
      else
         cd ${RUN_DIR}/${DATE}/dart_filter
      fi
#
# Construct background file name/date
      export LL_DATE=${DATE}
      export LL_END_DATE=${DATE}
      export LL_YY=`echo ${LL_DATE} | cut -c1-4`
      export LL_MM=`echo ${LL_DATE} | cut -c5-6`
      export LL_DD=`echo ${LL_DATE} | cut -c7-8`
      export LL_HH=`echo ${LL_DATE} | cut -c9-10`
      export LL_FILE_DATE=${LL_YY}-${LL_MM}-${LL_DD}_${LL_HH}:00:00
#
# Process filter output without calling filter	 
      if ! ${SKIP_FILTER}; then
#
# Get DART files
         cp ${WRFCHEM_DART_WORK_DIR}/filter      ./.
         cp ${WRFCHEM_DART_WORK_DIR}/advance_time ./.
         cp ${WRFCHEM_DART_WORK_DIR}/input.nml ./.
         cp ${DART_DIR}/assimilation_code/programs/gen_sampling_err_table/work/sampling_error_correction_table.nc ./.
#
# Get background forecasts
         if [[ ${DATE} -eq ${FIRST_FILTER_DATE} ]]; then
            export BACKGND_FCST_DIR=${WRFCHEM_INITIAL_DIR}
         else
            export BACKGND_FCST_DIR=${WRFCHEM_LAST_CYCLE_CR_DIR}
         fi
#
# Get observations
         if [[ ${PREPROCESS_OBS_DIR}/obs_seq_comb_filtered_${START_DATE}.out ]]; then      
            cp  ${PREPROCESS_OBS_DIR}/obs_seq_comb_filtered_${START_DATE}.out obs_seq.out
         else
            echo APM ERROR: NO DART OBSERVATIONS
            exit
         fi
#
# Create namelist
         ${NAMELIST_SCRIPTS_DIR}/DART/dart_create_input.nml.ksh
         cp ${EXPERIMENT_STATIC_FILES}/ubvals_b40.20th.track1_1996-2005.nc ./.
#
# Copy DART file that controls the observation/state variable update localization
         cp ${LOCALIZATION_DIR}/control_impact_runtime.txt ./control_impact_runtime.table
#
# Loop through members, link, copy background files, create input/output lists
         let MEM=1
         while [[ ${MEM} -le ${NUM_MEMBERS} ]]; do
            export CMEM=e${MEM}
            export KMEM=${MEM}
            if [[ ${MEM} -lt 1000 ]]; then export KMEM=0${MEM}; fi
            if [[ ${MEM} -lt 100 ]]; then export KMEM=00${MEM}; export CMEM=e0${MEM}; fi
            if [[ ${MEM} -lt 10 ]]; then export KMEM=000${MEM}; export CMEM=e00${MEM}; fi
#   
# Copy emission input files
            cp ${WRFCHEM_CHEM_EMISS_DIR}/wrfchemi_d${CR_DOMAIN}_${LL_FILE_DATE}.${CMEM} ./.
            cp ${WRFCHEM_CHEM_EMISS_DIR}/wrffirechemi_d${CR_DOMAIN}_${LL_FILE_DATE}.${CMEM} ./.
            cp ${WRFCHEM_CHEM_EMISS_DIR}/wrfchemi_d${CR_DOMAIN}_${LL_FILE_DATE}.${CMEM} ./wrfchemi_d${CR_DOMAIN}_${LL_FILE_DATE}_prior.${CMEM}
            cp ${WRFCHEM_CHEM_EMISS_DIR}/wrffirechemi_d${CR_DOMAIN}_${LL_FILE_DATE}.${CMEM} ./wrffirechemi_d${CR_DOMAIN}_${LL_FILE_DATE}_prior.${CMEM}
            let MEM=${MEM}+1
         done
#
# Calculate ensemble mean emissions prior
         ncea -n ${NUM_MEMBERS},3,1 wrfchemi_d${CR_DOMAIN}_${LL_FILE_DATE}.e001 wrfchemi_d${CR_DOMAIN}_prior_mean
         ncea -n ${NUM_MEMBERS},3,1 wrffirechemi_d${CR_DOMAIN}_${LL_FILE_DATE}.e001 wrffirechemi_d${CR_DOMAIN}_prior_mean
#
# Rename the emissions dimensions
         rm -rf input_list.txt
         rm -rf output_list.txt
         touch input_list.txt
         touch output_list.txt
         let MEM=1
         while [[ ${MEM} -le ${NUM_MEMBERS} ]]; do
            export CMEM=e${MEM}
            export KMEM=${MEM}
            if [[ ${MEM} -lt 1000 ]]; then export KMEM=0${MEM}; fi
            if [[ ${MEM} -lt 100 ]]; then export KMEM=00${MEM}; export CMEM=e0${MEM}; fi
            if [[ ${MEM} -lt 10 ]]; then export KMEM=000${MEM}; export CMEM=e00${MEM}; fi
            ncrename -d emissions_zdim_stag,chemi_zdim_stag -O wrfchemi_d${CR_DOMAIN}_${LL_FILE_DATE}.${CMEM} wrfchemi_d${CR_DOMAIN}_${LL_FILE_DATE}.${CMEM}
            ncrename -d emissions_zdim_stag,fire_zdim_stag -O wrffirechemi_d${CR_DOMAIN}_${LL_FILE_DATE}.${CMEM} wrffirechemi_d${CR_DOMAIN}_${LL_FILE_DATE}.${CMEM}
#
# Copy background input file
            cp ${BACKGND_FCST_DIR}/run_${CMEM}/wrfout_d${CR_DOMAIN}_${FILE_DATE} wrfinput_d${CR_DOMAIN}_${CMEM}
#
# Copy the emissions fields to be adjusted from the emissions input files
# to the wrfinput files
            ncks -A -v ${WRFCHEMI_DARTVARS} wrfchemi_d${CR_DOMAIN}_${LL_FILE_DATE}.${CMEM} wrfinput_d${CR_DOMAIN}_${CMEM}
            ncks -A -v ${WRFFIRECHEMI_DARTVARS} wrffirechemi_d${CR_DOMAIN}_${LL_FILE_DATE}.${CMEM} wrfinput_d${CR_DOMAIN}_${CMEM}
#
# Add files to the DART input and output list
            echo wrfinput_d${CR_DOMAIN}_${CMEM} >> input_list.txt
            echo wrfinput_d${CR_DOMAIN}_${CMEM} >> output_list.txt
            let MEM=${MEM}+1
         done
#
# Copy template files
         cp wrfinput_d${CR_DOMAIN}_e001 wrfinput_d${CR_DOMAIN}      
#
# Copy "out" inflation files from prior cycle to "in" inflation files for current cycle
         if ${USE_DART_INFL}; then
            if [[ ${DATE} -eq ${FIRST_DART_INFLATE_DATE} ]]; then
               export NL_INF_INITIAL_FROM_RESTART_PRIOR=.false.
               export NL_INF_SD_INITIAL_FROM_RESTART_PRIOR=.false.
               export NL_INF_INITIAL_FROM_RESTART_POST=.false.
               export NL_INF_SD_INITIAL_FROM_RESTART_POST=.false.
            else
               export NL_INF_INITIAL_FROM_RESTART_PRIOR=.true.
               export NL_INF_SD_INITIAL_FROM_RESTART_PRIOR=.true.
               export NL_INF_INITIAL_FROM_RESTART_POST=.true.
               export NL_INF_SD_INITIAL_FROM_RESTART_POST=.true.
            fi
            if [[ ${DATE} -ne ${FIRST_DART_INFLATE_DATE} ]]; then
               if [[ ${NL_INF_FLAVOR_PRIOR} != 0 ]]; then
                  export INF_OUT_FILE_MN_PRIOR=${RUN_DIR}/${PAST_DATE}/dart_filter/output_priorinf_mean.nc
                  export INF_OUT_FILE_SD_PRIOR=${RUN_DIR}/${PAST_DATE}/dart_filter/output_priorinf_sd.nc
                  cp ${INF_OUT_FILE_MN_PRIOR} input_priorinf_mean.nc
                  cp ${INF_OUT_FILE_SD_PRIOR} input_priorinf_sd.nc
               fi
               if [[ ${NL_INF_FLAVOR_POST} != 0 ]]; then
                  export INF_OUT_FILE_MN_POST=${RUN_DIR}/${PAST_DATE}/dart_filter/output_postinf_mean.nc
                  export INF_OUT_FILE_SD_POST=${RUN_DIR}/${PAST_DATE}/dart_filter/output_postinf_sd.nc
                  cp ${INF_OUT_FILE_MN_POST} input_postinf_mean.nc
                  cp ${INF_OUT_FILE_SD_POST} input_postinf_sd.nc
               fi 
            fi
         fi
#
# Generate input.nml 
         set -A temp `echo ${ASIM_MIN_DATE} 0 -g | ${WRFCHEM_DART_WORK_DIR}/advance_time`
         (( temp[1]=${temp[1]}+1 ))
         export NL_FIRST_OBS_DAYS=${temp[0]}
         export NL_FIRST_OBS_SECONDS=${temp[1]}
         set -A temp `echo ${ASIM_MAX_DATE} 0 -g | ${WRFCHEM_DART_WORK_DIR}/advance_time`
         export NL_LAST_OBS_DAYS=${temp[0]}
         export NL_LAST_OBS_SECONDS=${temp[1]}
         export NL_NUM_INPUT_FILES=1
         export NL_FILENAME_SEQ="'obs_seq.out'"
         export NL_FILENAME_OUT="'obs_seq.processed'"
         export NL_MOPITT_CO_RETRIEVAL_TYPE=\'${RETRIEVAL_TYPE_MOPITT}\'
         export NL_IASI_CO_RETRIEVAL_TYPE=\'${RETRIEVAL_TYPE_IASI}\'
         export NL_USE_LOG_CO=${USE_LOG_CO_LOGIC}
         export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
         export NL_USE_LOG_NO2=${USE_LOG_NO2_LOGIC}
         export NL_USE_LOG_SO2=${USE_LOG_SO2_LOGIC}
         rm -rf input.nml
         ${NAMELIST_SCRIPTS_DIR}/DART/dart_create_input.nml.ksh
#
# Make filter_apm_nml for special_outlier_threshold
         rm -rf filter_apm.nml
         cat << EOF > filter_apm.nml
&filter_apm_nml
special_outlier_threshold=${NL_SPECIAL_OUTLIER_THRESHOLD}
/
EOF
#
# Run DART_FILTER
# Create job script for this member and run it 
         RANDOM=$$
         export JOBRND=${RANDOM}_filter
         ${JOB_CONTROL_SCRIPTS_DIR}/job_script_nasa_has.ksh ${JOBRND} ${FILTER_JOB_CLASS} ${FILTER_TIME_LIMIT} ${FILTER_NODES} ${FILTER_TASKS} filter PARALLEL ${ACCOUNT}
         qsub -Wblock=true job.ksh
      fi
#
# Check whether DART worked properly
      if [[ ! -f output_postinf_mean.nc || ! -f output_mean.nc || ! -f output_postinf_sd.nc || ! -f output_sd.nc || ! -f obs_seq.final ]]; then
         echo APM: ERROR in DART FILTER EXIT
         exit
      fi
#
# Remove emissions fields from the DART output files and copy to the emissions input files
      let MEM=1
      while [[ ${MEM} -le ${NUM_MEMBERS} ]]; do
         export CMEM=e${MEM}
         export KMEM=${MEM}
         if [[ ${MEM} -lt 1000 ]]; then export KMEM=0${MEM}; fi
         if [[ ${MEM} -lt 100 ]]; then export KMEM=00${MEM}; export CMEM=e0${MEM}; fi
         if [[ ${MEM} -lt 10 ]]; then export KMEM=000${MEM}; export CMEM=e00${MEM}; fi
#
# Copy the adjusted emissions fields from the wrfinput files to the emissions input files
         ncks -O -x -v ${WRFCHEMI_DARTVARS} wrfinput_d${CR_DOMAIN}_${CMEM} wrfout_d${CR_DOMAIN}_${FILE_DATE}_filt.${CMEM}
         ncks -O -x -v ${WRFFIRECHEMI_DARTVARS} wrfout_d${CR_DOMAIN}_${FILE_DATE}_filt.${CMEM} wrfout_d${CR_DOMAIN}_${FILE_DATE}_filt.${CMEM}	 
         ncks -A -v ${WRFCHEMI_DARTVARS} wrfinput_d${CR_DOMAIN}_${CMEM} wrfchemi_d${CR_DOMAIN}_${LL_FILE_DATE}.${CMEM}
         ncks -A -v ${WRFFIRECHEMI_DARTVARS} wrfinput_d${CR_DOMAIN}_${CMEM} wrffirechemi_d${CR_DOMAIN}_${LL_FILE_DATE}.${CMEM}
         ncrename -d chemi_zdim_stag,emissions_zdim_stag -O wrfchemi_d${CR_DOMAIN}_${LL_FILE_DATE}.${CMEM} wrfchemi_d${CR_DOMAIN}_${LL_FILE_DATE}.${CMEM}
         ncrename -d fire_zdim_stag,emissions_zdim_stag -O wrffirechemi_d${CR_DOMAIN}_${LL_FILE_DATE}.${CMEM} wrffirechemi_d${CR_DOMAIN}_${LL_FILE_DATE}.${CMEM}
         rm -rf wrfinput_d${CR_DOMAIN}_${CMEM}
#
         let MEM=${MEM}+1
      done 
#
# Calculate ensemble mean emissions posterior
      ncea -n ${NUM_MEMBERS},3,1 wrfchemi_d${CR_DOMAIN}_${LL_FILE_DATE}.e001 wrfchemi_d${CR_DOMAIN}_post_mean
      ncea -n ${NUM_MEMBERS},3,1 wrffirechemi_d${CR_DOMAIN}_${LL_FILE_DATE}.e001 wrffirechemi_d${CR_DOMAIN}_post_mean
   fi
#
#########################################################################
#
# UPDATE COARSE RESOLUTION BOUNDARY CONDIIONS
#
#########################################################################
#
   if ${RUN_UPDATE_BC}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/update_bc ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/update_bc
         cd ${RUN_DIR}/${DATE}/update_bc
      else
         cd ${RUN_DIR}/${DATE}/update_bc
      fi
#
      let MEM=1
      while [[ ${MEM} -le ${NUM_MEMBERS} ]]; do
         export CMEM=e${MEM}
         export KMEM=${MEM}
         if [[ ${MEM} -lt 1000 ]]; then export KMEM=0${MEM}; fi
         if [[ ${MEM} -lt 100 ]]; then export KMEM=00${MEM}; export CMEM=e0${MEM}; fi
         if [[ ${MEM} -lt 10 ]]; then export KMEM=000${MEM}; export CMEM=e00${MEM}; fi
#
         export CYCLING=true
         export OPS_FORC_FILE=${WRFCHEM_CHEM_ICBC_DIR}/wrfinput_d${CR_DOMAIN}_${FILE_DATE}.${CMEM}
         export BDYCDN_IN=${WRFCHEM_CHEM_ICBC_DIR}/wrfbdy_d${CR_DOMAIN}_${FILE_DATE}.${CMEM}
         cp ${BDYCDN_IN} wrfbdy_d${CR_DOMAIN}_${FILE_DATE}_prior.${CMEM}
         export DA_OUTPUT_FILE=${DART_FILTER_DIR}/wrfout_d${CR_DOMAIN}_${FILE_DATE}_filt.${CMEM} 
         export BDYCDN_OUT=wrfbdy_d${CR_DOMAIN}_${FILE_DATE}_filt.${CMEM}    
         ${JOB_CONTROL_SCRIPTS_DIR}/da_run_update_bc.ksh > index_update_bc 2>&1
#
         let MEM=$MEM+1
      done
   fi
#
#########################################################################
#
# RUN BIAS CORRECTION
#
#########################################################################
#
   if ${RUN_BIAS_CORRECTION}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/bias_corr ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/bias_corr
         cd ${RUN_DIR}/${DATE}/bias_corr
      else
         cd ${RUN_DIR}/${DATE}/bias_corr
      fi
      rm -rf bias_corr_wtd.exe
      rm -rf bias_correct_nml
      rm -rf index_bias_corr
      rm -rf obs_seq.final
      cp ${BIAS_CORR_DIR}/work/bias_corr_wtd.exe ./.
      cp ${DART_FILTER_DIR}/obs_seq.final ./.
#
      export NL_DOES_FILE_EXIST=.true.
      if [[ ${DATE} -eq ${FIRST_FILTER_DATE} ]]; then
	 export NL_DOES_FILE_EXIST=.false.
         rm -rf ${NL_CORRECTION_FILENAME}
      else
         rm -rf ${NL_CORRECTION_FILENAME}
         cp ${RUN_DIR}/${PAST_DATE}/bias_corr/${NL_CORRECTION_FILENAME} ./.
      fi
#
      rm -rf bias_correct_nml
      cat << EOF > bias_correct_nml
&bias_correct_nml
path_filein='${RUN_DIR}/${DATE}/bias_corr'
does_file_exist=${NL_DOES_FILE_EXIST}
correction_filename='${NL_CORRECTION_FILENAME}'
nobs=1
obs_list='TROPOMI_CO_COL'
/
EOF
#
# Run bias corrections
      ./bias_corr_wtd.exe > index_bias_corr 2>&1
   fi
#
#########################################################################
#
# CALCULATE ENSEMBLE MEAN_INPUT
#
#########################################################################
#
   if ${RUN_ENSEMBLE_MEAN_INPUT}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/ensemble_mean_input ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/ensemble_mean_input
         cd ${RUN_DIR}/${DATE}/ensemble_mean_input
      else
         cd ${RUN_DIR}/${DATE}/ensemble_mean_input
      fi
      rm -rf wrfinput_d${CR_DOMAIN}_mean
      rm -rf wrfbdy_d${CR_DOMAIN}_mean
      rm -rf wrfinput_d${FR_DOMAIN}_mean
      let MEM=1
      while [[ ${MEM} -le ${NUM_MEMBERS} ]]; do
         export CMEM=e${MEM}
         export KMEM=${MEM}
         if [[ ${MEM} -lt 1000 ]]; then export KMEM=0${MEM}; fi
         if [[ ${MEM} -lt 100 ]]; then export KMEM=00${MEM}; export CMEM=e0${MEM}; fi
         if [[ ${MEM} -lt 10 ]]; then export KMEM=000${MEM}; export CMEM=e00${MEM}; fi
         if [[ ${DATE} -eq ${INITIAL_DATE}  ]]; then
            cp ${WRFCHEM_MET_IC_DIR}/wrfinput_d${CR_DOMAIN}_${START_FILE_DATE}.${CMEM} wrfinput_d${CR_DOMAIN}_${KMEM}
            cp ${WRFCHEM_MET_BC_DIR}/wrfbdy_d${CR_DOMAIN}_${START_FILE_DATE}.${CMEM} wrfbdy_d${CR_DOMAIN}_${KMEM}
         else
            cp ${DART_FILTER_DIR}/wrfout_d${CR_DOMAIN}_${START_FILE_DATE}_filt.${CMEM} wrfinput_d${CR_DOMAIN}_${KMEM}
            cp ${UPDATE_BC_DIR}/wrfbdy_d${CR_DOMAIN}_${START_FILE_DATE}_filt.${CMEM} wrfbdy_d${CR_DOMAIN}_${KMEM}
         fi
         let MEM=${MEM}+1
      done
      cp ${REAL_DIR}/wrfinput_d${FR_DOMAIN}_${START_FILE_DATE} wrfinput_d${FR_DOMAIN}_mean
#
# Calculate ensemble mean
      ncea -n ${NUM_MEMBERS},4,1 wrfinput_d${CR_DOMAIN}_0001 wrfinput_d${CR_DOMAIN}_mean
      ncea -n ${NUM_MEMBERS},4,1 wrfbdy_d${CR_DOMAIN}_0001 wrfbdy_d${CR_DOMAIN}_mean
#
# Calculate ensemble spread
      rm -rf wrfinput_d${CR_DOMAIN}_tmp*
      rm -rf wrfinput_d${CR_DOMAIN}_sprd 
      ncecat -n ${NUM_MEMBERS},4,1 wrfinput_d${CR_DOMAIN}_0001 wrfinput_d${CR_DOMAIN}_tmp1
      ncwa -a record wrfinput_d${CR_DOMAIN}_tmp1 wrfinput_d${CR_DOMAIN}_tmp2
      ncbo --op_typ='-' wrfinput_d${CR_DOMAIN}_tmp1 wrfinput_d${CR_DOMAIN}_tmp2 wrfinput_d${CR_DOMAIN}_tmp3
      ncra -y rmssdn wrfinput_d${CR_DOMAIN}_tmp3 wrfinput_d${CR_DOMAIN}_sprd
      rm -rf wrfinput_d${CR_DOMAIN}_tmp*
      rm -rf wrfinput_d${CR_DOMAIN}_*0*
      rm -rf wrfbdy_d${CR_DOMAIN}_*0*
   fi
#
#########################################################################
#
# RUN WRF-CHEM INITAL (NO CYCLING-BASED FIRST GUESS FOR DART)
#
#########################################################################
#
   if ${RUN_WRFCHEM_INITIAL}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/wrfchem_initial ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/wrfchem_initial
         cd ${RUN_DIR}/${DATE}/wrfchem_initial
      else
         cd ${RUN_DIR}/${DATE}/wrfchem_initial
      fi
#
# Run WRF-Chem for all ensemble members
      TRANDOM=$$
      let IMEM=1
      export L_NUM_MEMBERS=${NUM_MEMBERS}
      if ${RUN_SPECIAL_FORECAST}; then
         export L_NUM_MEMBERS=${NUM_SPECIAL_FORECAST}
      fi
      while [[ ${IMEM} -le ${L_NUM_MEMBERS} ]]; do
         export MEM=${IMEM}
         export NL_TIME_STEP=${NNL_TIME_STEP}
         if ${RUN_SPECIAL_FORECAST}; then
            export MEM=${SPECIAL_FORECAST_MEM[${IMEM}]}
            let NL_TIME_STEP=${NNL_TIME_STEP}*${SPECIAL_FORECAST_FAC}
         fi
         export CMEM=e${MEM}
         export KMEM=${MEM}
         if [[ ${MEM} -lt 1000 ]]; then export KMEM=0${MEM}; fi
         if [[ ${MEM} -lt 100 ]]; then export KMEM=00${MEM}; export CMEM=e0${MEM}; fi
         if [[ ${MEM} -lt 10 ]]; then export KMEM=000${MEM}; export CMEM=e00${MEM}; fi
         export L_RUN_DIR=run_${CMEM}
         cd ${RUN_DIR}/${DATE}/wrfchem_initial
         if ${RUN_SPECIAL_FORECAST}; then
            rm -rf ${L_RUN_DIR}
         fi
         if [[ ! -e ${L_RUN_DIR} ]]; then
            mkdir ${L_RUN_DIR}
            cd ${L_RUN_DIR}
         else
            cd ${L_RUN_DIR}
         fi
#
# Get WRF-Chem parameter files
         cp ${WRFCHEM_DIR}/test/em_real/wrf.exe ./.
         cp ${WRFCHEM_DIR}/test/em_real/aerosol.formatted ./.
         cp ${WRFCHEM_DIR}/test/em_real/aerosol_lat.formatted ./.
         cp ${WRFCHEM_DIR}/test/em_real/aerosol_lon.formatted ./.
         cp ${WRFCHEM_DIR}/test/em_real/aerosol_plev.formatted ./.
         cp ${WRFCHEM_DIR}/test/em_real/bulkdens.asc_s_0_03_0_9 ./.
         cp ${WRFCHEM_DIR}/test/em_real/bulkradii.asc_s_0_03_0_9 ./.
         cp ${WRFCHEM_DIR}/test/em_real/CAM_ABS_DATA ./.
         cp ${WRFCHEM_DIR}/test/em_real/CAM_AEROPT_DATA ./.
         cp ${WRFCHEM_DIR}/test/em_real/CAMtr_volume_mixing_ratio ./.
         cp ${WRFCHEM_DIR}/test/em_real/CAMtr_volume_mixing_ratio.A1B ./.
         cp ${WRFCHEM_DIR}/test/em_real/CAMtr_volume_mixing_ratio.A2 ./.
         cp ${WRFCHEM_DIR}/test/em_real/CAMtr_volume_mixing_ratio.RCP4.5 ./.
         cp ${WRFCHEM_DIR}/test/em_real/CAMtr_volume_mixing_ratio.RCP6 ./.
         cp ${WRFCHEM_DIR}/test/em_real/capacity.asc ./.
         cp ${WRFCHEM_DIR}/test/em_real/CCN_ACTIVATE.BIN ./.
         cp ${WRFCHEM_DIR}/test/em_real/CLM_ALB_ICE_DFS_DATA ./.
         cp ${WRFCHEM_DIR}/test/em_real/CLM_ALB_ICE_DRC_DATA ./.
         cp ${WRFCHEM_DIR}/test/em_real/CLM_ASM_ICE_DFS_DATA ./.
         cp ${WRFCHEM_DIR}/test/em_real/CLM_ASM_ICE_DRC_DATA ./.
         cp ${WRFCHEM_DIR}/test/em_real/CLM_DRDSDT0_DATA ./.
         cp ${WRFCHEM_DIR}/test/em_real/CLM_EXT_ICE_DFS_DATA ./.
         cp ${WRFCHEM_DIR}/test/em_real/CLM_EXT_ICE_DRC_DATA ./.
         cp ${WRFCHEM_DIR}/test/em_real/CLM_KAPPA_DATA ./.
         cp ${WRFCHEM_DIR}/test/em_real/CLM_TAU_DATA ./.
         cp ${WRFCHEM_DIR}/test/em_real/coeff_p.asc ./.
         cp ${WRFCHEM_DIR}/test/em_real/coeff_q.asc ./.
         cp ${WRFCHEM_DIR}/test/em_real/constants.asc ./.
         cp ${WRFCHEM_DIR}/test/em_real/ETAMPNEW_DATA ./.
         cp ${WRFCHEM_DIR}/test/em_real/ETAMPNEW_DATA.expanded_rain ./.
         cp ${WRFCHEM_DIR}/test/em_real/GENPARM.TBL ./.
         cp ${WRFCHEM_DIR}/test/em_real/grib2map.tbl ./.
         cp ${WRFCHEM_DIR}/test/em_real/gribmap.txt ./.
         cp ${WRFCHEM_DIR}/test/em_real/kernels.asc_s_0_03_0_9 ./.
         cp ${WRFCHEM_DIR}/test/em_real/kernels_z.asc ./.
         cp ${WRFCHEM_DIR}/test/em_real/LANDUSE.TBL ./.
         cp ${WRFCHEM_DIR}/test/em_real/masses.asc ./.
         cp ${WRFCHEM_DIR}/test/em_real/MPTABLE.TBL ./.
         cp ${WRFCHEM_DIR}/test/em_real/ozone.formatted ./.
         cp ${WRFCHEM_DIR}/test/em_real/ozone_lat.formatted ./.
         cp ${WRFCHEM_DIR}/test/em_real/ozone_plev.formatted ./.
         cp ${WRFCHEM_DIR}/test/em_real/RRTM_DATA ./.
         cp ${WRFCHEM_DIR}/test/em_real/RRTMG_LW_DATA ./.
         cp ${WRFCHEM_DIR}/test/em_real/RRTMG_SW_DATA ./.
         cp ${WRFCHEM_DIR}/test/em_real/SOILPARM.TBL ./.
         cp ${WRFCHEM_DIR}/test/em_real/termvels.asc ./.
         cp ${WRFCHEM_DIR}/test/em_real/tr49t67 ./.
         cp ${WRFCHEM_DIR}/test/em_real/tr49t85 ./.
         cp ${WRFCHEM_DIR}/test/em_real/tr67t85 ./.
         cp ${WRFCHEM_DIR}/test/em_real/URBPARM.TBL ./.
         cp ${WRFCHEM_DIR}/test/em_real/VEGPARM.TBL ./.
         cp ${WRFCHEM_DIR}/run/HLC.TBL ./.
         cp ${EXPERIMENT_HIST_IO_DIR}/hist_io_flds_v1 ./.
         cp ${EXPERIMENT_HIST_IO_DIR}/hist_io_flds_v2 ./.
#
         cp ${EXPERIMENT_STATIC_FILES}/clim_p_trop.nc ./.
         cp ${EXPERIMENT_STATIC_FILES}/ubvals_b40.20th.track1_1996-2005.nc ./.
         cp ${EXO_COLDENS_DIR}/exo_coldens_d${CR_DOMAIN} ./.
         cp ${SEASONS_WES_DIR}/wrf_season_wes_usgs_d${CR_DOMAIN}.nc ./.
#
# Get WRF-Chem emissions files
         export L_DATE=${START_DATE}
         while [[ ${L_DATE} -le ${END_DATE} ]]; do
            export L_YY=`echo ${L_DATE} | cut -c1-4`
            export L_MM=`echo ${L_DATE} | cut -c5-6`
            export L_DD=`echo ${L_DATE} | cut -c7-8`
            export L_HH=`echo ${L_DATE} | cut -c9-10`
            export L_FILE_DATE=${L_YY}-${L_MM}-${L_DD}_${L_HH}:00:00
            if [[ ${L_HH} -eq 00 || ${L_HH} -eq 06 || ${L_HH} -eq 12 || ${L_HH} -eq 18 ]]; then
               cp ${WRFCHEM_CHEM_EMISS_DIR}/wrfbiochemi_d${CR_DOMAIN}_${L_FILE_DATE}.${CMEM} wrfbiochemi_d${CR_DOMAIN}_${L_FILE_DATE}
            fi
            cp ${WRFCHEM_CHEM_EMISS_DIR}/wrffirechemi_d${CR_DOMAIN}_${L_FILE_DATE}.${CMEM} wrffirechemi_d${CR_DOMAIN}_${L_FILE_DATE}
            cp ${WRFCHEM_CHEM_EMISS_DIR}/wrfchemi_d${CR_DOMAIN}_${L_FILE_DATE}.${CMEM} wrfchemi_d${CR_DOMAIN}_${L_FILE_DATE}
            export L_DATE=$(${BUILD_DIR}/da_advance_time.exe ${L_DATE} +1 2>/dev/null)
         done
#
# Get WRF-Chem input and bdy files
         cp ${WRFCHEM_CHEM_ICBC_DIR}/wrfinput_d${CR_DOMAIN}_${START_FILE_DATE}.${CMEM} wrfinput_d${CR_DOMAIN}
         cp ${WRFCHEM_CHEM_ICBC_DIR}/wrfbdy_d${CR_DOMAIN}_${START_FILE_DATE}.${CMEM} wrfbdy_d${CR_DOMAIN}
#
# Create WRF-Chem namelist.input
         export NL_MAX_DOM=1
         export NL_IOFIELDS_FILENAME=\'hist_io_flds_v1\',\'hist_io_flds_v2\'
         rm -rf namelist.input
         ${NAMELIST_SCRIPTS_DIR}/MISC/da_create_wrfchem_namelist_RT_v4.ksh
         export JOBRND=${TRANDOM}_wrf
         ${JOB_CONTROL_SCRIPTS_DIR}/job_script_nasa.ksh ${JOBRND} ${WRFCHEM_JOB_CLASS} ${WRFCHEM_TIME_LIMIT} ${WRFCHEM_NODES} ${WRFCHEM_TASKS} wrf.exe PARALLEL ${ACCOUNT}
	 if [[ ${WRFCHEM_JOB_CLASS} == devel ]]; then
             qsub -Wblock=true job.ksh
	 else
             qsub job.ksh
	 fi    
         let IMEM=${IMEM}+1
      done
#
# Wait for WRFCHEM to complete for each member
      if [[ ${WRFCHEM_JOB_CLASS} != devel ]]; then
         ${JOB_CONTROL_SCRIPTS_DIR}/da_run_hold_nasa.ksh ${TRANDOM}
      fi	  
   fi
#
#########################################################################
#
# RUN WRFCHEM_CYCLE_CR
#
#########################################################################
#
   if ${RUN_WRFCHEM_CYCLE_CR}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/wrfchem_cycle_cr ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/wrfchem_cycle_cr
         cd ${RUN_DIR}/${DATE}/wrfchem_cycle_cr
      else
         cd ${RUN_DIR}/${DATE}/wrfchem_cycle_cr
      fi
#
# Run WRF-Chem for all ensemble members
      TRANDOM=$$
      let IMEM=1
      export L_NUM_MEMBERS=${NUM_MEMBERS}
      if ${RUN_SPECIAL_FORECAST}; then
         export L_NUM_MEMBERS=${NUM_SPECIAL_FORECAST}
      fi
      while [[ ${IMEM} -le ${L_NUM_MEMBERS} ]]; do
         export MEM=${IMEM}
         export NL_TIME_STEP=${NNL_TIME_STEP}
         if ${RUN_SPECIAL_FORECAST}; then
            export MEM=${SPECIAL_FORECAST_MEM[${IMEM}]}
            let NL_TIME_STEP=${NNL_TIME_STEP}*${SPECIAL_FORECAST_FAC}
         fi
         export CMEM=e${MEM}
         export KMEM=${MEM}
         if [[ ${MEM} -lt 1000 ]]; then export KMEM=0${MEM}; fi
         if [[ ${MEM} -lt 100 ]]; then export KMEM=00${MEM}; export CMEM=e0${MEM}; fi
         if [[ ${MEM} -lt 10 ]]; then export KMEM=000${MEM}; export CMEM=e00${MEM}; fi
         export L_RUN_DIR=run_${CMEM}
         cd ${RUN_DIR}/${DATE}/wrfchem_cycle_cr
         if ${RUN_SPECIAL_FORECAST}; then
            rm -rf ${L_RUN_DIR}
         fi
         if [[ ! -e ${L_RUN_DIR} ]]; then
            mkdir ${L_RUN_DIR}
            cd ${L_RUN_DIR}
         else
            cd ${L_RUN_DIR}
         fi
#
# Get WRF-Chem parameter files
         cp ${WRFCHEM_DART_WORK_DIR}/advance_time ./.
         cp ${WRFCHEM_DART_WORK_DIR}/input.nml ./.
         cp ${WRFCHEM_DIR}/test/em_real/wrf.exe ./.
         cp ${WRFCHEM_DIR}/test/em_real/aerosol.formatted ./.
         cp ${WRFCHEM_DIR}/test/em_real/aerosol_lat.formatted ./.
         cp ${WRFCHEM_DIR}/test/em_real/aerosol_lon.formatted ./.
         cp ${WRFCHEM_DIR}/test/em_real/aerosol_plev.formatted ./.
         cp ${WRFCHEM_DIR}/test/em_real/bulkdens.asc_s_0_03_0_9 ./.
         cp ${WRFCHEM_DIR}/test/em_real/bulkradii.asc_s_0_03_0_9 ./.
         cp ${WRFCHEM_DIR}/test/em_real/CAM_ABS_DATA ./.
         cp ${WRFCHEM_DIR}/test/em_real/CAM_AEROPT_DATA ./.
         cp ${WRFCHEM_DIR}/test/em_real/CAMtr_volume_mixing_ratio ./.
         cp ${WRFCHEM_DIR}/test/em_real/CAMtr_volume_mixing_ratio.A1B ./.
         cp ${WRFCHEM_DIR}/test/em_real/CAMtr_volume_mixing_ratio.A2 ./.
         cp ${WRFCHEM_DIR}/test/em_real/CAMtr_volume_mixing_ratio.RCP4.5 ./.
         cp ${WRFCHEM_DIR}/test/em_real/CAMtr_volume_mixing_ratio.RCP6 ./.
         cp ${WRFCHEM_DIR}/test/em_real/capacity.asc ./.
         cp ${WRFCHEM_DIR}/test/em_real/CCN_ACTIVATE.BIN ./.
         cp ${WRFCHEM_DIR}/test/em_real/CLM_ALB_ICE_DFS_DATA ./.
         cp ${WRFCHEM_DIR}/test/em_real/CLM_ALB_ICE_DRC_DATA ./.
         cp ${WRFCHEM_DIR}/test/em_real/CLM_ASM_ICE_DFS_DATA ./.
         cp ${WRFCHEM_DIR}/test/em_real/CLM_ASM_ICE_DRC_DATA ./.
         cp ${WRFCHEM_DIR}/test/em_real/CLM_DRDSDT0_DATA ./.
         cp ${WRFCHEM_DIR}/test/em_real/CLM_EXT_ICE_DFS_DATA ./.
         cp ${WRFCHEM_DIR}/test/em_real/CLM_EXT_ICE_DRC_DATA ./.
         cp ${WRFCHEM_DIR}/test/em_real/CLM_KAPPA_DATA ./.
         cp ${WRFCHEM_DIR}/test/em_real/CLM_TAU_DATA ./.
         cp ${WRFCHEM_DIR}/test/em_real/coeff_p.asc ./.
         cp ${WRFCHEM_DIR}/test/em_real/coeff_q.asc ./.
         cp ${WRFCHEM_DIR}/test/em_real/constants.asc ./.
         cp ${WRFCHEM_DIR}/test/em_real/ETAMPNEW_DATA ./.
         cp ${WRFCHEM_DIR}/test/em_real/ETAMPNEW_DATA.expanded_rain ./.
         cp ${WRFCHEM_DIR}/test/em_real/GENPARM.TBL ./.
         cp ${WRFCHEM_DIR}/test/em_real/grib2map.tbl ./.
         cp ${WRFCHEM_DIR}/test/em_real/gribmap.txt ./.
         cp ${WRFCHEM_DIR}/test/em_real/kernels.asc_s_0_03_0_9 ./.
         cp ${WRFCHEM_DIR}/test/em_real/kernels_z.asc ./.
         cp ${WRFCHEM_DIR}/test/em_real/LANDUSE.TBL ./.
         cp ${WRFCHEM_DIR}/test/em_real/masses.asc ./.
         cp ${WRFCHEM_DIR}/test/em_real/MPTABLE.TBL ./.
         cp ${WRFCHEM_DIR}/test/em_real/ozone.formatted ./.
         cp ${WRFCHEM_DIR}/test/em_real/ozone_lat.formatted ./.
         cp ${WRFCHEM_DIR}/test/em_real/ozone_plev.formatted ./.
         cp ${WRFCHEM_DIR}/test/em_real/RRTM_DATA ./.
         cp ${WRFCHEM_DIR}/test/em_real/RRTMG_LW_DATA ./.
         cp ${WRFCHEM_DIR}/test/em_real/RRTMG_SW_DATA ./.
         cp ${WRFCHEM_DIR}/test/em_real/SOILPARM.TBL ./.
         cp ${WRFCHEM_DIR}/test/em_real/termvels.asc ./.
         cp ${WRFCHEM_DIR}/test/em_real/tr49t67 ./.
         cp ${WRFCHEM_DIR}/test/em_real/tr49t85 ./.
         cp ${WRFCHEM_DIR}/test/em_real/tr67t85 ./.
         cp ${WRFCHEM_DIR}/test/em_real/URBPARM.TBL ./.
         cp ${WRFCHEM_DIR}/test/em_real/VEGPARM.TBL ./.
         cp ${WRFCHEM_DIR}/run/HLC.TBL ./.
         cp ${EXPERIMENT_HIST_IO_DIR}/hist_io_flds_v1 ./.
         cp ${EXPERIMENT_HIST_IO_DIR}/hist_io_flds_v2 ./.
#
         cp ${EXPERIMENT_STATIC_FILES}/clim_p_trop.nc ./.
         cp ${EXPERIMENT_STATIC_FILES}/ubvals_b40.20th.track1_1996-2005.nc ./.
         cp ${EXO_COLDENS_DIR}/exo_coldens_d${CR_DOMAIN} ./.
         cp ${SEASONS_WES_DIR}/wrf_season_wes_usgs_d${CR_DOMAIN}.nc ./.
#
# Get WRF-Chem input and bdy files
         cp ${DART_FILTER_DIR}/wrfout_d${CR_DOMAIN}_${START_FILE_DATE}_filt.${CMEM} wrfinput_d${CR_DOMAIN}
         cp ${UPDATE_BC_DIR}/wrfbdy_d${CR_DOMAIN}_${START_FILE_DATE}_filt.${CMEM} wrfbdy_d${CR_DOMAIN}
#
# Get WRF-Chem emissions files
         export L_DATE=${START_DATE}
         while [[ ${L_DATE} -le ${END_DATE} ]]; do
            export L_YY=`echo ${L_DATE} | cut -c1-4`
            export L_MM=`echo ${L_DATE} | cut -c5-6`
            export L_DD=`echo ${L_DATE} | cut -c7-8`
            export L_HH=`echo ${L_DATE} | cut -c9-10`
            export L_FILE_DATE=${L_YY}-${L_MM}-${L_DD}_${L_HH}:00:00
            if [[ ${L_DATE} -eq ${START_DATE} ]]; then
               rm -rf wrfchemi_d${CR_DOMAIN}_post
               rm -rf wrffirechemi_d${CR_DOMAIN}_post
	       cp ${DART_FILTER_DIR}/wrfchemi_d${CR_DOMAIN}_${L_FILE_DATE}.${CMEM} wrfchemi_d${CR_DOMAIN}_post
               cp ${DART_FILTER_DIR}/wrffirechemi_d${CR_DOMAIN}_${L_FILE_DATE}.${CMEM} wrffirechemi_d${CR_DOMAIN}_post
            fi
	    rm -rf wrfchemi_d${CR_DOMAIN}_${L_FILE_DATE}
	    rm -rf wrffirechemi_d${CR_DOMAIN}_${L_FILE_DATE}
            cp ${WRFCHEM_CHEM_EMISS_DIR}/wrfchemi_d${CR_DOMAIN}_${L_FILE_DATE}.${CMEM} wrfchemi_d${CR_DOMAIN}_${L_FILE_DATE}
            cp ${WRFCHEM_CHEM_EMISS_DIR}/wrffirechemi_d${CR_DOMAIN}_${L_FILE_DATE}.${CMEM} wrffirechemi_d${CR_DOMAIN}_${L_FILE_DATE}		
	    if [[ ${L_HH} -eq 00 || ${L_HH} -eq 06 || ${L_HH} -eq 12 || ${L_HH} -eq 18 ]]; then
               rm -rf wrfbiochemi_d${CR_DOMAIN}_${L_FILE_DATE}
	       cp ${WRFCHEM_CHEM_EMISS_DIR}/wrfbiochemi_d${CR_DOMAIN}_${L_FILE_DATE}.${CMEM} wrfbiochemi_d${CR_DOMAIN}_${L_FILE_DATE}
            fi
            export L_DATE=$(${BUILD_DIR}/da_advance_time.exe ${L_DATE} +1 2>/dev/null)
         done
#
# Update the emission files
         if [[ ${L_ADD_EMISS} = "true" ]]; then
	    rm -rf wrfchemi_d${CR_DOMAIN}_prior
	    rm -rf wrffirechemi_d${CR_DOMAIN}_prior
	    rm -rf adjust_chem_emiss.exe
            cp wrfchemi_d${CR_DOMAIN}_${START_FILE_DATE} wrfchemi_d${CR_DOMAIN}_prior
            cp wrffirechemi_d${CR_DOMAIN}_${START_FILE_DATE} wrffirechemi_d${CR_DOMAIN}_prior
            cp ${ADJUST_EMISS_DIR}/work/adjust_chem_emiss.exe ./.
#
            export L_DATE=${START_DATE}
            while [[ ${L_DATE} -le ${END_DATE} ]]; do 
               export L_YY=$(echo $L_DATE | cut -c1-4)
               export L_MM=$(echo $L_DATE | cut -c5-6)
               export L_DD=$(echo $L_DATE | cut -c7-8)
               export L_HH=$(echo $L_DATE | cut -c9-10)
               export L_FILE_DATE=${L_YY}-${L_MM}-${L_DD}_${L_HH}:00:00
#
               export NL_WRFCHEMI_PRIOR=wrfchemi_d${CR_DOMAIN}_prior
               export NL_WRFCHEMI_POST=wrfchemi_d${CR_DOMAIN}_post
               export NL_WRFCHEMI_OLD=wrfchemi_d${CR_DOMAIN}_${L_FILE_DATE}
               export NL_WRFCHEMI_NEW=wrfchemi_d${CR_DOMAIN}_new
               rm -rf  ${NL_WRFCHEMI_NEW}
               cp ${NL_WRFCHEMI_OLD} ${NL_WRFCHEMI_NEW}
#
               export NL_WRFFIRECHEMI_PRIOR=wrffirechemi_d${CR_DOMAIN}_prior
               export NL_WRFFIRECHEMI_POST=wrffirechemi_d${CR_DOMAIN}_post
               export NL_WRFFIRECHEMI_OLD=wrffirechemi_d${CR_DOMAIN}_${L_FILE_DATE}
               export NL_WRFFIRECHEMI_NEW=wrffirechemi_d${CR_DOMAIN}_new
               rm -rf  ${NL_WRFFIRECHEMI_NEW}
               cp ${NL_WRFFIRECHEMI_OLD} ${NL_WRFFIRECHEMI_NEW}
#
	       rm -rf adjust_chem_emiss_dims.nml
               cat <<  EOF > adjust_chem_emiss_dims.nml
&adjust_chem_emiss_dims
nx=${NNXP_CR},
ny=${NNYP_CR},
nz=${NNZP_CR},
nz_chemi=${NZ_CHEMI},
nz_firechemi=${NZ_FIRECHEMI},
nchemi_emiss=${NCHEMI_EMISS},
nfirechemi_emiss=${NFIRECHEMI_EMISS},
/
EOF
	       rm -rf adjust_chem_emiss.nml
               cat <<  EOF > adjust_chem_emiss.nml
&adjust_chem_emiss
chemi_spcs=${WRFCHEMI_DARTVARS},
firechemi_spcs=${WRFFIRECHEMI_DARTVARS},
fac=${EMISS_DAMP_CYCLE},
facc=${EMISS_DAMP_INTRA_CYCLE},
wrfchemi_prior='${NL_WRFCHEMI_PRIOR}',
wrfchemi_post='${NL_WRFCHEMI_POST}',
wrfchemi_old='${NL_WRFCHEMI_OLD}',
wrfchemi_new='${NL_WRFCHEMI_NEW}',
wrffirechemi_prior='${NL_WRFFIRECHEMI_PRIOR}',
wrffirechemi_post='${NL_WRFFIRECHEMI_POST}',
wrffirechemi_old='${NL_WRFFIRECHEMI_OLD}',
wrffirechemi_new='${NL_WRFFIRECHEMI_NEW}'
/
EOF
	       rm -rf index_adjust_chem_emiss
               ./adjust_chem_emiss.exe > index_adjust_chem_emiss
	       #
	       rm -rf ${NL_WRFCHEMI_OLD}
	       rm -rf ${NL_WRFFIRECHEMI_OLD}
               cp ${NL_WRFCHEMI_NEW} ${NL_WRFCHEMI_OLD}
               cp ${NL_WRFFIRECHEMI_NEW} ${NL_WRFFIRECHEMI_OLD}
	       rm ${NL_WRFCHEMI_NEW}
	       rm ${NL_WRFFIRECHEMI_NEW}
               export L_DATE=$(${BUILD_DIR}/da_advance_time.exe ${L_DATE} +1 2>/dev/null)
            done
         fi
 #
# Create WRF-Chem namelist.input 
         export NL_MAX_DOM=1
         export NL_IOFIELDS_FILENAME=\'hist_io_flds_v1\',\'hist_io_flds_v2\'
         rm -rf namelist.input
         ${NAMELIST_SCRIPTS_DIR}/MISC/da_create_wrfchem_namelist_RT_v4.ksh
#
         export JOBRND=${TRANDOM}_wrf
         ${JOB_CONTROL_SCRIPTS_DIR}/job_script_nasa.ksh ${JOBRND} ${WRFCHEM_JOB_CLASS} ${WRFCHEM_TIME_LIMIT} ${WRFCHEM_NODES} ${WRFCHEM_TASKS} wrf.exe PARALLEL ${ACCOUNT}
	 if [[ ${WRFCHEM_JOB_CLASS} == devel ]]; then
             qsub -Wblock=true job.ksh
	 else
             qsub job.ksh
	 fi    
         let IMEM=${IMEM}+1
      done
#
# Wait for WRFCHEM to complete for each member
      if [[ ${WRFCHEM_JOB_CLASS} != devel ]]; then
         ${JOB_CONTROL_SCRIPTS_DIR}/da_run_hold_nasa.ksh ${TRANDOM}
      fi
   fi
#
#########################################################################
#
# RUN WRFCHEM_CYCLE_FR
#
#########################################################################
#
   if ${RUN_WRFCHEM_CYCLE_FR}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/wrfchem_cycle_fr ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/wrfchem_cycle_fr
         cd ${RUN_DIR}/${DATE}/wrfchem_cycle_fr
      else
         cd ${RUN_DIR}/${DATE}/wrfchem_cycle_fr
      fi
#
# Get WRF-Chem parameter files
      cp ${WRFCHEM_DIR}/test/em_real/wrf.exe ./.
      cp ${WRFCHEM_DIR}/test/em_real/CAM_ABS_DATA ./.
      cp ${WRFCHEM_DIR}/test/em_real/CAM_AEROPT_DATA ./.
      cp ${WRFCHEM_DIR}/test/em_real/ETAMPNEW_DATA ./.
      cp ${WRFCHEM_DIR}/test/em_real/GENPARM.TBL ./.
      cp ${WRFCHEM_DIR}/test/em_real/LANDUSE.TBL ./.
      cp ${WRFCHEM_DIR}/test/em_real/RRTMG_LW_DATA ./.
      cp ${WRFCHEM_DIR}/test/em_real/RRTMG_SW_DATA ./.
      cp ${WRFCHEM_DIR}/test/em_real/RRTM_DATA ./.
      cp ${WRFCHEM_DIR}/test/em_real/SOILPARM.TBL ./.
      cp ${WRFCHEM_DIR}/test/em_real/URBPARM.TBL ./.
      cp ${WRFCHEM_DIR}/test/em_real/VEGPARM.TBL ./.
      cp ${WRFCHEM_DIR}/run/HLC.TBL ./.
      cp ${EXPERIMENT_HIST_IO_DIR}/hist_io_flds_v1 ./.
      cp ${EXPERIMENT_HIST_IO_DIR}/hist_io_flds_v2 ./.
#
      cp ${EXPERIMENT_STATIC_FILES}/clim_p_trop.nc ./.
      cp ${EXPERIMENT_STATIC_FILES}/ubvals_b40.20th.track1_1996-2005.nc ./.
      cp ${EXO_COLDENS_DIR}/exo_coldens_d${CR_DOMAIN} ./.
      cp ${EXO_COLDENS_DIR}/exo_coldens_d${FR_DOMAIN} ./.
      cp ${SEASONS_WES_DIR}/wrf_season_wes_usgs_d${CR_DOMAIN}.nc ./.
      cp ${SEASONS_WES_DIR}/wrf_season_wes_usgs_d${FR_DOMAIN}.nc ./.
#
# Get WRF-Chem emissions files
      cp ${WRFCHEM_CHEM_EMISS_DIR}/wrfbiochemi_d${CR_DOMAIN}_${START_FILE_DATE}.${CLOSE_MEM_ID} wrfbiochemi_d${CR_DOMAIN}_${START_FILE_DATE}
      cp ${WRFCHEM_CHEM_EMISS_DIR}/wrfbiochemi_d${FR_DOMAIN}_${START_FILE_DATE}.${CLOSE_MEM_ID} wrfbiochemi_d${FR_DOMAIN}_${START_FILE_DATE}
#
      export L_DATE=${START_DATE}
      while [[ ${L_DATE} -le ${END_DATE} ]]; do
         export L_YY=`echo ${L_DATE} | cut -c1-4`
         export L_MM=`echo ${L_DATE} | cut -c5-6`
         export L_DD=`echo ${L_DATE} | cut -c7-8`
         export L_HH=`echo ${L_DATE} | cut -c9-10`
         export L_FILE_DATE=${L_YY}-${L_MM}-${L_DD}_${L_HH}:00:00
#
# files for starting from ensemble mean
#         cp ${WRFCHEM_FIRE_DIR}/wrffirechemi_d${CR_DOMAIN}_${L_FILE_DATE} wrffirechemi_d${CR_DOMAIN}_${L_FILE_DATE}
#         cp ${WRFCHEM_CHEMI_DIR}/wrfchemi_d${CR_DOMAIN}_${L_FILE_DATE} wrfchemi_d${CR_DOMAIN}_${L_FILE_DATE}
#         cp ${WRFCHEM_FIRE_DIR}/wrffirechemi_d${FR_DOMAIN}_${L_FILE_DATE} wrffirechemi_d${FR_DOMAIN}_${L_FILE_DATE}
#         cp ${WRFCHEM_CHEMI_DIR}/wrfchemi_d${FR_DOMAIN}_${L_FILE_DATE} wrfchemi_d${FR_DOMAIN}_${L_FILE_DATE}
#
# files for starting from closest member
         cp ${WRFCHEM_CHEM_EMISS_DIR}/wrffirechemi_d${CR_DOMAIN}_${L_FILE_DATE}.${CLOSE_MEM_ID} wrffirechemi_d${CR_DOMAIN}_${L_FILE_DATE}
         cp ${WRFCHEM_CHEM_EMISS_DIR}/wrfchemi_d${CR_DOMAIN}_${L_FILE_DATE}.${CLOSE_MEM_ID} wrfchemi_d${CR_DOMAIN}_${L_FILE_DATE}
         cp ${WRFCHEM_CHEM_EMISS_DIR}/wrffirechemi_d${FR_DOMAIN}_${L_FILE_DATE}.${CLOSE_MEM_ID} wrffirechemi_d${FR_DOMAIN}_${L_FILE_DATE}
         cp ${WRFCHEM_CHEM_EMISS_DIR}/wrfchemi_d${FR_DOMAIN}_${L_FILE_DATE}.${CLOSE_MEM_ID} wrfchemi_d${FR_DOMAIN}_${L_FILE_DATE}
#
         export L_DATE=$(${BUILD_DIR}/da_advance_time.exe ${L_DATE} +1 2>/dev/null)
      done
#
# Get WRF-Chem input and bdy files
#
#      cp ${REAL_DIR}/wrfout_d${CR_DOMAIN}_${START_FILE_DATE}_filt wrfinput_d${CR_DOMAIN}
#      cp ${REAL_DIR}/wrfbdy_d${CR_DOMAIN}_${START_FILE_DATE}_filt wrfbdy_d${CR_DOMAIN}
#      cp ${REAL_DIR}/wrfout_d${FR_DOMAIN}_${START_FILE_DATE}_filt wrfinput_d${FR_DOMAIN}
# 
##      cp ${WRFCHEM_CHEM_ICBC_DIR}/wrfinput_d${CR_DOMAIN}_${START_FILE_DATE} wrfinput_d${CR_DOMAIN}
##      cp ${WRFCHEM_CHEM_ICBC_DIR}/wrfbdy_d${CR_DOMAIN}_${START_FILE_DATE} wrfbdy_d${CR_DOMAIN}
##      cp ${WRFCHEM_CHEM_ICBC_DIR}/wrfinput_d${FR_DOMAIN}_${START_FILE_DATE} wrfinput_d${FR_DOMAIN}
#
# files for starting from closest member
      cp ${DART_FILTER_DIR}/wrfout_d${CR_DOMAIN}_${START_FILE_DATE}_filt.${CLOSE_MEM_ID} wrfinput_d${CR_DOMAIN}
      cp ${UPDATE_BC_DIR}/wrfbdy_d${CR_DOMAIN}_${START_FILE_DATE}_filt.${CLOSE_MEM_ID} wrfbdy_d${CR_DOMAIN}
      cp ${REAL_DIR}/wrfinput_d${FR_DOMAIN}_${START_FILE_DATE} wrfinput_d${FR_DOMAIN}
#
# Create WRF-Chem namelist.input 
      export NL_MAX_DOM=2
      export NL_IOFIELDS_FILENAME=\'hist_io_flds_v1\',\'hist_io_flds_v2\'
      rm -rf namelist.input
      ${NAMELIST_SCRIPTS_DIR}/MISC/da_create_wrfchem_namelist_RT_v4.ksh
#
      RANDOM=$$
      export JOBRND=${RANDOM}_wrf
      ${JOB_CONTROL_SCRIPTS_DIR}/job_script_nasa.ksh ${JOBRND} ${WRFCHEM_JOB_CLASS} ${WRFCHEM_TIME_LIMIT} ${WRFCHEM_NODES} ${WRFCHEM_TASKS} wrf.exe PARALLEL ${ACCOUNT}
      qsub -Wblock=true job.ksh
   fi
#
#########################################################################
#
# RUN ENSMEAN_CYCLE_FR
#
#########################################################################
#
   if ${RUN_ENSMEAN_CYCLE_FR}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/ensmean_cycle_fr ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/ensmean_cycle_fr
         cd ${RUN_DIR}/${DATE}/ensmean_cycle_fr
      else
         cd ${RUN_DIR}/${DATE}/ensmean_cycle_fr
      fi
#
# Get WRF-Chem parameter files
      if [[ ${RUN_FINE_SCALE_RESTART} = "false" ]]; then
         cp ${WRFCHEM_DIR}/test/em_real/wrf.exe ./.
         cp ${WRFCHEM_DIR}/test/em_real/aerosol.formatted ./.
         cp ${WRFCHEM_DIR}/test/em_real/aerosol_lat.formatted ./.
         cp ${WRFCHEM_DIR}/test/em_real/aerosol_lon.formatted ./.
         cp ${WRFCHEM_DIR}/test/em_real/aerosol_plev.formatted ./.
         cp ${WRFCHEM_DIR}/test/em_real/bulkdens.asc_s_0_03_0_9 ./.
         cp ${WRFCHEM_DIR}/test/em_real/bulkradii.asc_s_0_03_0_9 ./.
         cp ${WRFCHEM_DIR}/test/em_real/CAM_ABS_DATA ./.
         cp ${WRFCHEM_DIR}/test/em_real/CAM_AEROPT_DATA ./.
         cp ${WRFCHEM_DIR}/test/em_real/CAMtr_volume_mixing_ratio ./.
         cp ${WRFCHEM_DIR}/test/em_real/CAMtr_volume_mixing_ratio.A1B ./.
         cp ${WRFCHEM_DIR}/test/em_real/CAMtr_volume_mixing_ratio.A2 ./.
         cp ${WRFCHEM_DIR}/test/em_real/CAMtr_volume_mixing_ratio.RCP4.5 ./.
         cp ${WRFCHEM_DIR}/test/em_real/CAMtr_volume_mixing_ratio.RCP6 ./.
         cp ${WRFCHEM_DIR}/test/em_real/capacity.asc ./.
         cp ${WRFCHEM_DIR}/test/em_real/CCN_ACTIVATE.BIN ./.
         cp ${WRFCHEM_DIR}/test/em_real/CLM_ALB_ICE_DFS_DATA ./.
         cp ${WRFCHEM_DIR}/test/em_real/CLM_ALB_ICE_DRC_DATA ./.
         cp ${WRFCHEM_DIR}/test/em_real/CLM_ASM_ICE_DFS_DATA ./.
         cp ${WRFCHEM_DIR}/test/em_real/CLM_ASM_ICE_DRC_DATA ./.
         cp ${WRFCHEM_DIR}/test/em_real/CLM_DRDSDT0_DATA ./.
         cp ${WRFCHEM_DIR}/test/em_real/CLM_EXT_ICE_DFS_DATA ./.
         cp ${WRFCHEM_DIR}/test/em_real/CLM_EXT_ICE_DRC_DATA ./.
         cp ${WRFCHEM_DIR}/test/em_real/CLM_KAPPA_DATA ./.
         cp ${WRFCHEM_DIR}/test/em_real/CLM_TAU_DATA ./.
         cp ${WRFCHEM_DIR}/test/em_real/coeff_p.asc ./.
         cp ${WRFCHEM_DIR}/test/em_real/coeff_q.asc ./.
         cp ${WRFCHEM_DIR}/test/em_real/constants.asc ./.
         cp ${WRFCHEM_DIR}/test/em_real/ETAMPNEW_DATA ./.
         cp ${WRFCHEM_DIR}/test/em_real/ETAMPNEW_DATA.expanded_rain ./.
         cp ${WRFCHEM_DIR}/test/em_real/GENPARM.TBL ./.
         cp ${WRFCHEM_DIR}/test/em_real/grib2map.tbl ./.
         cp ${WRFCHEM_DIR}/test/em_real/gribmap.txt ./.
         cp ${WRFCHEM_DIR}/test/em_real/kernels.asc_s_0_03_0_9 ./.
         cp ${WRFCHEM_DIR}/test/em_real/kernels_z.asc ./.
         cp ${WRFCHEM_DIR}/test/em_real/LANDUSE.TBL ./.
         cp ${WRFCHEM_DIR}/test/em_real/masses.asc ./.
         cp ${WRFCHEM_DIR}/test/em_real/MPTABLE.TBL ./.
         cp ${WRFCHEM_DIR}/test/em_real/ozone.formatted ./.
         cp ${WRFCHEM_DIR}/test/em_real/ozone_lat.formatted ./.
         cp ${WRFCHEM_DIR}/test/em_real/ozone_plev.formatted ./.
         cp ${WRFCHEM_DIR}/test/em_real/RRTM_DATA ./.
         cp ${WRFCHEM_DIR}/test/em_real/RRTMG_LW_DATA ./.
         cp ${WRFCHEM_DIR}/test/em_real/RRTMG_SW_DATA ./.
         cp ${WRFCHEM_DIR}/test/em_real/SOILPARM.TBL ./.
         cp ${WRFCHEM_DIR}/test/em_real/termvels.asc ./.
         cp ${WRFCHEM_DIR}/test/em_real/tr49t67 ./.
         cp ${WRFCHEM_DIR}/test/em_real/tr49t85 ./.
         cp ${WRFCHEM_DIR}/test/em_real/tr67t85 ./.
         cp ${WRFCHEM_DIR}/test/em_real/URBPARM.TBL ./.
         cp ${WRFCHEM_DIR}/test/em_real/VEGPARM.TBL ./.
         cp ${WRFCHEM_DIR}/run/HLC.TBL ./.
         cp ${EXPERIMENT_HIST_IO_DIR}/hist_io_flds_v1 ./.
         cp ${EXPERIMENT_HIST_IO_DIR}/hist_io_flds_v2 ./.
#
         cp ${EXPERIMENT_STATIC_FILES}/clim_p_trop.nc ./.
         cp ${EXPERIMENT_STATIC_FILES}/ubvals_b40.20th.track1_1996-2005.nc ./.
         cp ${EXO_COLDENS_DIR}/exo_coldens_d${CR_DOMAIN} ./.
         cp ${EXO_COLDENS_DIR}/exo_coldens_d${FR_DOMAIN} ./.
         cp ${SEASONS_WES_DIR}/wrf_season_wes_usgs_d${CR_DOMAIN}.nc ./.
         cp ${SEASONS_WES_DIR}/wrf_season_wes_usgs_d${FR_DOMAIN}.nc ./.
#
# Get WRF-Chem emissions files
         cp ${WRFCHEM_BIO_DIR}/wrfbiochemi_d${CR_DOMAIN}_${START_FILE_DATE} wrfbiochemi_d${CR_DOMAIN}_${START_FILE_DATE}
         cp ${WRFCHEM_BIO_DIR}/wrfbiochemi_d${FR_DOMAIN}_${START_FILE_DATE} wrfbiochemi_d${FR_DOMAIN}_${START_FILE_DATE}
#
#         cp ${WRFCHEM_CHEM_EMISS_DIR}/wrfbiochemi_d${CR_DOMAIN}_${START_FILE_DATE}.${CLOSE_MEM_ID} wrfbiochemi_d${CR_DOMAIN}_${START_FILE_DATE}
#         cp ${WRFCHEM_CHEM_EMISS_DIR}/wrfbiochemi_d${FR_DOMAIN}_${START_FILE_DATE}.${CLOSE_MEM_ID} wrfbiochemi_d${FR_DOMAIN}_${START_FILE_DATE}
#
         export L_DATE=${START_DATE}
         while [[ ${L_DATE} -le ${END_DATE} ]]; do
            export L_YY=`echo ${L_DATE} | cut -c1-4`
            export L_MM=`echo ${L_DATE} | cut -c5-6`
            export L_DD=`echo ${L_DATE} | cut -c7-8`
            export L_HH=`echo ${L_DATE} | cut -c9-10`
            export L_FILE_DATE=${L_YY}-${L_MM}-${L_DD}_${L_HH}:00:00
            cp ${WRFCHEM_FIRE_DIR}/wrffirechemi_d${CR_DOMAIN}_${L_FILE_DATE} wrffirechemi_d${CR_DOMAIN}_${L_FILE_DATE}
            cp ${WRFCHEM_CHEMI_DIR}/wrfchemi_d${CR_DOMAIN}_${L_FILE_DATE} wrfchemi_d${CR_DOMAIN}_${L_FILE_DATE}
            cp ${WRFCHEM_FIRE_DIR}/wrffirechemi_d${FR_DOMAIN}_${L_FILE_DATE} wrffirechemi_d${FR_DOMAIN}_${L_FILE_DATE}
            cp ${WRFCHEM_CHEMI_DIR}/wrfchemi_d${FR_DOMAIN}_${L_FILE_DATE} wrfchemi_d${FR_DOMAIN}_${L_FILE_DATE}
#     
#            cp ${WRFCHEM_CHEM_EMISS_DIR}/wrffirechemi_d${CR_DOMAIN}_${L_FILE_DATE}.${CLOSE_MEM_ID} wrffirechemi_d${CR_DOMAIN}_${L_FILE_DATE}
#            cp ${WRFCHEM_CHEM_EMISS_DIR}/wrfchemi_d${CR_DOMAIN}_${L_FILE_DATE}.${CLOSE_MEM_ID} wrfchemi_d${CR_DOMAIN}_${L_FILE_DATE}
#            cp ${WRFCHEM_CHEM_EMISS_DIR}/wrffirechemi_d${FR_DOMAIN}_${L_FILE_DATE}.${CLOSE_MEM_ID} wrffirechemi_d${FR_DOMAIN}_${L_FILE_DATE}
#            cp ${WRFCHEM_CHEM_EMISS_DIR}/wrfchemi_d${FR_DOMAIN}_${L_FILE_DATE}.${CLOSE_MEM_ID} wrfchemi_d${FR_DOMAIN}_${L_FILE_DATE}
            export L_DATE=$(${BUILD_DIR}/da_advance_time.exe ${L_DATE} +1 2>/dev/null)
         done
#
# Get WRF-Chem input and bdy files
#         cp ${REAL_DIR}/wrfout_d${CR_DOMAIN}_${START_FILE_DATE}_filt wrfinput_d${CR_DOMAIN}
#         cp ${REAL_DIR}/wrfbdy_d${CR_DOMAIN}_${START_FILE_DATE}_filt wrfbdy_d${CR_DOMAIN}
#         cp ${REAL_DIR}/wrfout_d${FR_DOMAIN}_${START_FILE_DATE}_filt wrfinput_d${FR_DOMAIN}
#         cp ${DART_FILTER_DIR}/wrfout_d${CR_DOMAIN}_${START_FILE_DATE}_filt.${CLOSE_MEM_ID} wrfinput_d${CR_DOMAIN}
#         cp ${UPDATE_BC_DIR}/wrfbdy_d${CR_DOMAIN}_${START_FILE_DATE}_filt.${CLOSE_MEM_ID} wrfbdy_d${CR_DOMAIN}
#         cp ${REAL_DIR}/wrfinput_d${FR_DOMAIN}_${START_FILE_DATE} wrfinput_d${FR_DOMAIN}
         cp ${ENSEMBLE_MEAN_INPUT_DIR}/wrfinput_d${CR_DOMAIN}_mean wrfinput_d${CR_DOMAIN}
         cp ${ENSEMBLE_MEAN_INPUT_DIR}/wrfbdy_d${CR_DOMAIN}_mean wrfbdy_d${CR_DOMAIN}
         cp ${ENSEMBLE_MEAN_INPUT_DIR}/wrfinput_d${FR_DOMAIN}_mean wrfinput_d${FR_DOMAIN}
      fi
#
# Create WRF-Chem namelist.input 
      export NL_MAX_DOM=2
      export NL_IOFIELDS_FILENAME=\'hist_io_flds_v1\',\'hist_io_flds_v2\'
      export NL_RESTART_INTERVAL=360
      export NL_TIME_STEP=40
      export NL_BIOEMDT=1,.5
      export NL_PHOTDT=1,.5
      export NL_CHEMDT=1,.5
      export L_TIME_LIMIT=${WRFCHEM_TIME_LIMIT}
      if [[ ${RUN_FINE_SCALE_RESTART} = "true" ]]; then
         export RE_YYYY=$(echo $RESTART_DATE | cut -c1-4)
         export RE_YY=$(echo $RESTART_DATE | cut -c3-4)
         export RE_MM=$(echo $RESTART_DATE | cut -c5-6)
         export RE_DD=$(echo $RESTART_DATE | cut -c7-8)
         export RE_HH=$(echo $RESTART_DATE | cut -c9-10)
         export NL_START_YEAR=${RE_YYYY},${RE_YYYY}
         export NL_START_MONTH=${RE_MM},${RE_MM}
         export NL_START_DAY=${RE_DD},${RE_DD}
         export NL_START_HOUR=${RE_HH},${RE_HH}
         export NL_START_MINUTE=00,00
         export NL_START_SECOND=00,00
         export NL_RESTART=".true."
         export L_TIME_LIMIT=${WRFCHEM_TIME_LIMIT}
      fi
      rm -rf namelist.input
      ${NAMELIST_SCRIPTS_DIR}/MISC/da_create_wrfchem_namelist_RT_v4.ksh
#
      RANDOM=$$
      export JOBRND=${RANDOM}_wrf
      ${JOB_CONTROL_SCRIPTS_DIR}/job_script_nasa.ksh ${JOBRND} ${WRFCHEM_JOB_CLASS} ${WRFCHEM_TIME_LIMIT} ${WRFCHEM_NODES} ${WRFCHEM_TASKS} wrf.exe PARALLEL ${ACCOUNT}
      qsub -Wblock=true job.ksh
   fi
#
#########################################################################
#
# CALCULATE ENSEMBLE MEAN_OUTPUT
#
#########################################################################
#
   if ${RUN_ENSEMBLE_MEAN_OUTPUT}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/ensemble_mean_output ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/ensemble_mean_output
         cd ${RUN_DIR}/${DATE}/ensemble_mean_output
      else
         cd ${RUN_DIR}/${DATE}/ensemble_mean_output
      fi
      if [[ ${DATE} -eq ${INITIAL_DATE} ]]; then
         export OUTPUT_DIR=${WRFCHEM_INITIAL_DIR}
      else
         export OUTPUT_DIR=${WRFCHEM_CYCLE_CR_DIR}
      fi
      rm -rf wrfout_d${CR_DOMAIN}_*
      export P_DATE=${DATE}
      export P_END_DATE=$(${BUILD_DIR}/da_advance_time.exe ${P_DATE} ${FCST_PERIOD} 2>/dev/null)
      while [[ ${P_DATE} -le ${P_END_DATE} ]] ; do
         export P_YYYY=$(echo $P_DATE | cut -c1-4)
         export P_MM=$(echo $P_DATE | cut -c5-6)
         export P_DD=$(echo $P_DATE | cut -c7-8)
         export P_HH=$(echo $P_DATE | cut -c9-10)
         export P_FILE_DATE=${P_YYYY}-${P_MM}-${P_DD}_${P_HH}:00:00
         let MEM=1
         while [[ ${MEM} -le ${NUM_MEMBERS} ]]; do
            export CMEM=e${MEM}
            export KMEM=${MEM}
            if [[ ${MEM} -lt 1000 ]]; then export KMEM=0${MEM}; fi
            if [[ ${MEM} -lt 100 ]]; then export KMEM=00${MEM}; export CMEM=e0${MEM}; fi
            if [[ ${MEM} -lt 10 ]]; then export KMEM=000${MEM}; export CMEM=e00${MEM}; fi
            rm -rf wrfout_d${CR_DOMAIN}_${KMEM}
            rm -rf wrfchemi_d${CR_DOMAIN}_${KMEM}
            ln -sf ${OUTPUT_DIR}/run_${CMEM}/wrfout_d${CR_DOMAIN}_${P_FILE_DATE} wrfout_d${CR_DOMAIN}_${KMEM}
            ln -sf ${OUTPUT_DIR}/run_${CMEM}/wrfchemi_d${CR_DOMAIN}_${P_FILE_DATE} wrfchemi_d${CR_DOMAIN}_${KMEM}
            let MEM=${MEM}+1
         done
#         cp ${OUTPUT_DIR}/run_e001/wrfout_d${CR_DOMAIN}_${P_FILE_DATE} wrfout_d${CR_DOMAIN}_${P_DATE}_mean
#
# Calculate ensemble mean
         ncea -n ${NUM_MEMBERS},4,1 wrfout_d${CR_DOMAIN}_0001 wrfout_d${CR_DOMAIN}_${P_DATE}_mean
         ncea -n ${NUM_MEMBERS},4,1 wrfchemi_d${CR_DOMAIN}_0001 wrfchemi_d${CR_DOMAIN}_${P_DATE}_mean
         export P_DATE=$(${BUILD_DIR}/da_advance_time.exe ${P_DATE} ${HISTORY_INTERVAL_HR} 2>/dev/null)
      done
   fi
#
#########################################################################
#
# FIND DEEPEST MEMBER
#
#########################################################################
#
   if ${RUN_BAND_DEPTH}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/band_depth ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/band_depth
         cd ${RUN_DIR}/${DATE}/band_depth
      else
         cd ${RUN_DIR}/${DATE}/band_depth
      fi
#
# set the forecast directory
      if [[ ${DATE} -eq ${INITIAL_DATE} ]]; then
         export OUTPUT_DIR=${WRFCHEM_INITIAL_DIR}
      else
         export OUTPUT_DIR=${WRFCHEM_CYCLE_CR_DIR}
      fi
      cp ${WRFCHEM_DART_WORK_DIR}/advance_time ./.
      export END_CYCLE_DATE=$($BUILD_DIR/da_advance_time.exe ${START_DATE} ${CYCLE_PERIOD} 2>/dev/null)
      export B_YYYY=$(echo $END_CYCLE_DATE | cut -c1-4)
      export B_MM=$(echo $END_CYCLE_DATE | cut -c5-6) 
      export B_DD=$(echo $END_CYCLE_DATE | cut -c7-8)
      export B_HH=$(echo $END_CYCLE_DATE | cut -c9-10)
      export B_FILE_DATE=${B_YYYY}-${B_MM}-${B_DD}_${B_HH}:00:00
#
# link in forecasts for deepest member determination
      let MEM=1
      while [[ ${MEM} -le ${NUM_MEMBERS} ]]; do
         export CMEM=e${MEM}
         export KMEM=${MEM}
         if [[ ${MEM} -lt 1000 ]]; then export KMEM=0${MEM}; fi
         if [[ ${MEM} -lt 100 ]]; then export KMEM=00${MEM}; export CMEM=e0${MEM}; fi
         if [[ ${MEM} -lt 10 ]]; then export KMEM=000${MEM}; export CMEM=e00${MEM}; fi
         rm -rf wrfout_d${CR_DOMAIN}.${CMEM}
         ln -sf ${OUTPUT_DIR}/run_${CMEM}/wrfout_d${CR_DOMAIN}_${B_FILE_DATE} wrfout_d${CR_DOMAIN}.${CMEM}
         let MEM=${MEM}+1
      done
#
# copy band depth code
      cp ${RUN_BAND_DEPTH_DIR}/ComputeBandDepth.m ./.
      rm -rf job.ksh
      rm -rf mat_*.err
      rm -rf mat_*.out
      touch job.ksh
#
      RANDOM=$$
      export JOBRND=${RANDOM}_deepmem
      cat << EOFF > job.ksh
#!/bin/ksh -aeux
#PBS -N ${JOBRND}
#PBS -l walltime=${GENERAL_TIME_LIMIT}
#PBS -q ${GENERAL_JOB_CLASS}
#PBS -j oe
#PBS -l select=${GENERAL_NODES}:ncpus=1:model=san
#
matlab -nosplash -nodesktop -r 'ComputeBandDepth(.09)'
export RC=\$?     
if [[ -f SUCCESS ]]; then rm -rf SUCCESS; fi     
if [[ -f FAILED ]]; then rm -rf FAILED; fi          
if [[ \$RC = 0 ]]; then
   touch SUCCESS
else
   touch FAILED 
   exit
fi
EOFF
      qsub -Wblock=true job.ksh 
#
# run band depth script
      source shell_file.ksh
      export CMEM=e${DEEP_MEMBER}
      if [[ ${DEEP_MEMBER} -lt 100 ]]; then export CMEM=e0${DEEP_MEMBER}; fi
      if [[ ${DEEP_MEMBER} -lt 10 ]]; then export CMEM=e00${DEEP_MEMBER}; fi
      export CLOSE_MEM_ID=${CMEM}
   fi
#
   export CYCLE_DATE=${NEXT_DATE}
done
#
