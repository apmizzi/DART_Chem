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
export INITIAL_DATE=2014071500
export FIRST_FILTER_DATE=2014071506
export FIRST_DART_INFLATE_DATE=2014071506
export FIRST_EMISS_INV_DATE=2014071506
#
export NL_CORRECTION_FILENAME='Historical_Bias_Corrections'      
#
# START CYCLE DATE-TIME:
export CYCLE_STR_DATE=2014072118
#
# END CYCLE DATE-TIME:
export CYCLE_END_DATE=2014072118
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
export NL_FAC_OBS_ERROR_TES_CO=1.00
export NL_FAC_OBS_ERROR_TES_CO2=1.00
export NL_FAC_OBS_ERROR_TES_O3=1.00
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
   export RUN_DIR=${EXPERIMENT_DIR}/real_FRAPPE_ALLCHEM_NASA_v4
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
   if [[ ${RUN_SPECIAL_FORECAST} = "false" ]]; then
      export RUN_GEOGRID=false
      export RUN_UNGRIB=false
      export RUN_METGRID=false
      export RUN_REAL=false
      export RUN_PERT_WRFCHEM_MET_IC=false
      export RUN_PERT_WRFCHEM_MET_BC=false
      export RUN_EXO_COLDENS=false
      export RUN_SEASON_WES=false
      export RUN_WRFCHEM_BIO=false
      export RUN_WRFCHEM_FIRE=false
      export RUN_WRFCHEM_CHEMI=false
      export RUN_PERT_WRFCHEM_CHEM_ICBC=false
      export RUN_PERT_WRFCHEM_CHEM_EMISS=false
      export RUN_MOPITT_CO_TOTAL_COL_OBS=false
      export RUN_MOPITT_CO_PROFILE_OBS=false # (done)
      export RUN_MOPITT_CO_CPSR_OBS=false # (done)
      export RUN_IASI_CO_TOTAL_COL_OBS=false
      export RUN_IASI_CO_PROFILE_OBS=false # (done)
      export RUN_IASI_CO_CPSR_OBS=false # (done)
      export RUN_IASI_O3_PROFILE_OBS=false
      export RUN_IASI_O3_CPSR_OBS=false
      export RUN_MODIS_AOD_TOTAL_COL_OBS=false # (done)
      export RUN_OMI_O3_TOTAL_COL_OBS=false
      export RUN_OMI_O3_TROP_COL_OBS=false
      export RUN_OMI_O3_PROFILE_OBS=false # (done)
      export RUN_OMI_O3_CPSR_OBS=false # (works)
      export RUN_OMI_NO2_TOTAL_COL_OBS=false
      export RUN_OMI_NO2_TROP_COL_OBS=false # (done)
      export RUN_OMI_NO2_DOMINO_TOTAL_COL_OBS=false
      export RUN_OMI_NO2_DOMINO_TROP_COL_OBS=false # (works)
      export RUN_OMI_SO2_TOTAL_COL_OBS=false
      export RUN_OMI_SO2_PBL_COL_OBS=false # (works)
      export RUN_OMI_HCHO_TOTAL_COL_OBS=false # (works)
      export RUN_OMI_HCHO_TROP_COL_OBS=false 
      export RUN_TROPOMI_CO_TOTAL_COL_OBS=false # (done)
      export RUN_TROPOMI_O3_TOTAL_COL_OBS=false
      export RUN_TROPOMI_O3_TROP_COL_OBS=false
      export RUN_TROPOMI_O3_PROFILE_OBS=false # (not done, no data)
      export RUN_TROPOMI_O3_CPSR_OBS=false
      export RUN_TROPOMI_NO2_TOTAL_COL_OBS=false
      export RUN_TROPOMI_NO2_TROP_COL_OBS=false # (works)
      export RUN_TROPOMI_SO2_TOTAL_COL_OBS=false
      export RUN_TROPOMI_SO2_PBL_COL_OBS=false # (works, vertical sum)
      export RUN_TROPOMI_CH4_TOTAL_COL_OBS=false  # (works, vertical sum)
      export RUN_TROPOMI_CH4_TROP_COL_OBS=false
      export RUN_TROPOMI_CH4_PROFILE_OBS=false
      export RUN_TROPOMI_CH4_CPSR_OBS=false
      export RUN_TROPOMI_HCHO_TOTAL_COL_OBS=false 
      export RUN_TROPOMI_HCHO_TROP_COL_OBS=false # (works, vertical sum)
      export RUN_TEMPO_O3_TOTAL_COL_OBS=false
      export RUN_TEMPO_O3_TROP_COL_OBS=false
      export RUN_TEMPO_O3_PROFILE_OBS=false # (done)
      export RUN_TEMPO_O3_CPSR_OBS=false
      export RUN_TEMPO_NO2_TOTAL_COL_OBS=false
      export RUN_TEMPO_NO2_TROP_COL_OBS=false # (done)
      export RUN_TES_CO_TOTAL_COL_OBS=false
      export RUN_TES_CO_PROFILE_OBS=false # (works)
      export RUN_TES_CO_CPSR_OBS=false # (works)
      export RUN_TES_CO2_TOTAL_COL_OBS=false 
      export RUN_TES_CO2_PROFILE_OBS=false # (works, vertical sum)
      export RUN_TES_CO2_CPSR_OBS=false # (works, vertical sum)
      export RUN_TES_O3_TOTAL_COL_OBS=false
      export RUN_TES_O3_PROFILE_OBS=false # (works)
      export RUN_TES_O3_CPSR_OBS=false # (works)
      export RUN_TES_NH3_TOTAL_COL_OBS=false
      export RUN_TES_NH3_PROFILE_OBS=false # (works, vertical sum)
      export RUN_TES_NH3_CPSR_OBS=false # (works, vertical sum)
      export RUN_TES_CH4_TOTAL_COL_OBS=false
      export RUN_TES_CH4_PROFILE_OBS=false # (works, vertical sum)
      export RUN_TES_CH4_CPSR_OBS=false # (works, vertical sum)
      export RUN_CRIS_CO_TOTAL_COL_OBS=false
      export RUN_CRIS_CO_PROFILE_OBS=false # (works, vertical sum)
      export RUN_CRIS_CO_CPSR_OBS=false # (works, vertical sum)
      export RUN_CRIS_O3_TOTAL_COL_OBS=false
      export RUN_CRIS_O3_PROFILE_OBS=false # (works, vertical sum)
      export RUN_CRIS_O3_CPSR_OBS=false # (works, vertical sum)
      export RUN_CRIS_NH3_TOTAL_COL_OBS=false
      export RUN_CRIS_NH3_PROFILE_OBS=false # (works, vertical sum)
      export RUN_CRIS_NH3_CPSR_OBS=false # (works, vertical sum)
      export RUN_CRIS_CH4_TOTAL_COL_OBS=false
      export RUN_CRIS_CH4_PROFILE_OBS=false # (works, vertical sum)
      export RUN_CRIS_CH4_CPSR_OBS=false # (works, vertical sum)
      export RUN_CRIS_PAN_TOTAL_COL_OBS=false # (works, vertical sum)
      export RUN_CRIS_PAN_PROFILE_OBS=false 
      export RUN_CRIS_PAN_CPSR_OBS=false
      export RUN_SCIAM_NO2_TOTAL_COL_OBS=false
      export RUN_SCIAM_NO2_TROP_COL_OBS=false # (works, vertical sum)
      export RUN_GOME2A_NO2_TOTAL_COL_OBS=false
      export RUN_GOME2A_NO2_TROP_COL_OBS=false # (works, vertical sum)
      export RUN_MLS_O3_TOTAL_COL_OBS=false
      export RUN_MLS_O3_PROFILE_OBS=false # (works, check)
      export RUN_MLS_O3_CPSR_OBS=false # (works, vertical sum)
      export RUN_MLS_HNO3_TOTAL_COL_OBS=false
      export RUN_MLS_HNO3_PROFILE_OBS=false # (works, vertical sum)
      export RUN_MLS_HNO3_CPSR_OBS=true # (works, vertical sum)
      export RUN_AIRNOW_CO_OBS=true # (done)
      export RUN_AIRNOW_O3_OBS=false # (done)
      export RUN_AIRNOW_NO2_OBS=false # (done)
      export RUN_AIRNOW_SO2_OBS=false # (done)
      export RUN_AIRNOW_PM10_OBS=false # (done)
      export RUN_AIRNOW_PM25_OBS=false # (done)
      export RUN_PANDA_CO_OBS=false
      export RUN_PANDA_O3_OBS=false
      export RUN_PANDA_PM25_OBS=false
      export RUN_MEXICO_AQS_CO_OBS=false
      export RUN_MET_OBS=true # (done)
      export RUN_COMBINE_OBS=true
#
      if [[ ${DATE} -eq ${INITIAL_DATE}  ]]; then
         export RUN_PREPROCESS_OBS=false
         export RUN_WRFCHEM_INITIAL=true
         export RUN_LOCALIZATION=false
         export RUN_DART_FILTER=false
         export RUN_BIAS_CORRECTION=false
         export RUN_UPDATE_BC=false
         export RUN_ENSEMBLE_MEAN_INPUT=true
         export RUN_WRFCHEM_CYCLE_CR=false
         export RUN_BAND_DEPTH=false
         export RUN_WRFCHEM_CYCLE_FR=false
         export RUN_ENSMEAN_CYCLE_FR=false
         export RUN_ENSEMBLE_MEAN_OUTPUT=true
      else
         export RUN_PREPROCESS_OBS=true
         export RUN_WRFCHEM_INITIAL=false
         export RUN_LOCALIZATION=true
         export RUN_DART_FILTER=true
         export RUN_BIAS_CORRECTION=false
         export RUN_UPDATE_BC=true
         export RUN_ENSEMBLE_MEAN_INPUT=true
         export RUN_WRFCHEM_CYCLE_CR=true
         export RUN_BAND_DEPTH=false
         export RUN_WRFCHEM_CYCLE_FR=false
         export RUN_ENSMEAN_CYCLE_FR=false
         export RUN_ENSEMBLE_MEAN_OUTPUT=true
      fi
   else
      export RUN_GEOGRID=false
      export RUN_UNGRIB=false
      export RUN_METGRID=false
      export RUN_REAL=false
      export RUN_PERT_WRFCHEM_MET_IC=false
      export RUN_PERT_WRFCHEM_MET_BC=false
      export RUN_EXO_COLDENS=false
      export RUN_SEASON_WES=false
      export RUN_WRFCHEM_BIO=false
      export RUN_WRFCHEM_FIRE=false
      export RUN_WRFCHEM_CHEMI=false
      export RUN_PERT_WRFCHEM_CHEM_ICBC=false
      export RUN_PERT_WRFCHEM_CHEM_EMISS=false
      export RUN_MOPITT_CO_TOTAL_COL_OBS=false
      export RUN_MOPITT_CO_PROFILE_OBS=false
      export RUN_MOPITT_CO_CPSR_OBS=false
      export RUN_IASI_CO_TOTAL_COL_OBS=false
      export RUN_IASI_CO_PROFILE_OBS=false
      export RUN_IASI_CO_CPSR_OBS=false
      export RUN_IASI_O3_PROFILE_OBS=false
      export RUN_IASI_O3_CPSR_OBS=false
      export RUN_MODIS_AOD_TOTAL_COL_OBS=false
      export RUN_OMI_O3_TOTAL_COL_OBS=false
      export RUN_OMI_O3_TROP_COL_OBS=false
      export RUN_OMI_O3_PROFILE_OBS=false
      export RUN_OMI_O3_CPSR_OBS=false
      export RUN_OMI_NO2_TOTAL_COL_OBS=false
      export RUN_OMI_NO2_TROP_COL_OBS=false
      export RUN_OMI_NO2_DOMINO_TOTAL_COL_OBS=false
      export RUN_OMI_NO2_DOMINO_TROP_COL_OBS=false
      export RUN_OMI_SO2_TOTAL_COL_OBS=false
      export RUN_OMI_SO2_PBL_COL_OBS=false
      export RUN_OMI_HCHO_TOTAL_COL_OBS=false
      export RUN_OMI_HCHO_TROP_COL_OBS=false
      export RUN_TROPOMI_CO_TOTAL_COL_OBS=false
      export RUN_TROPOMI_O3_TOTAL_COL_OBS=false
      export RUN_TROPOMI_O3_TROP_COL_OBS=false
      export RUN_TROPOMI_O3_PROFILE_OBS=false
      export RUN_TROPOMI_O3_CPSR_OBS=false
      export RUN_TROPOMI_NO2_TOTAL_COL_OBS=false
      export RUN_TROPOMI_NO2_TROP_COL_OBS=false
      export RUN_TROPOMI_SO2_TOTAL_COL_OBS=false
      export RUN_TROPOMI_SO2_PBL_COL_OBS=false
      export RUN_TROPOMI_CH4_TOTAL_COL_OBS=false
      export RUN_TROPOMI_CH4_TROP_COL_OBS=false
      export RUN_TROPOMI_CH4_PROFILE_OBS=false
      export RUN_TROPOMI_CH4_CPSR_OBS=false
      export RUN_TROPOMI_HCHO_TOTAL_COL_OBS=false
      export RUN_TROPOMI_HCHO_TROP_COL_OBS=false
      export RUN_TEMPO_O3_TOTAL_COL_OBS=false
      export RUN_TEMPO_O3_TROP_COL_OBS=false
      export RUN_TEMPO_O3_PROFILE_OBS=false
      export RUN_TEMPO_O3_CPSR_OBS=false
      export RUN_TEMPO_NO2_TOTAL_COL_OBS=false
      export RUN_TEMPO_NO2_TROP_COL_OBS=false
      export RUN_TES_CO_TOTAL_COL_OBS=false
      export RUN_TES_CO_PROFILE_OBS=false
      export RUN_TES_CO_CPSR_OBS=false
      export RUN_TES_CO2_TOTAL_COL_OBS=false
      export RUN_TES_CO2_PROFILE_OBS=false
      export RUN_TES_CO2_CPSR_OBS=false
      export RUN_TES_O3_TOTAL_COL_OBS=false
      export RUN_TES_O3_PROFILE_OBS=false
      export RUN_TES_O3_CPSR_OBS=false
      export RUN_TES_NH3_TOTAL_COL_OBS=false
      export RUN_TES_NH3_PROFILE_OBS=false
      export RUN_TES_NH3_CPSR_OBS=false
      export RUN_TES_CH4_TOTAL_COL_OBS=false
      export RUN_TES_CH4_PROFILE_OBS=false
      export RUN_TES_CH4_CPSR_OBS=false
      export RUN_CRIS_CO_TOTAL_COL_OBS=false
      export RUN_CRIS_CO_PROFILE_OBS=false
      export RUN_CRIS_CO_CPSR_OBS=false
      export RUN_CRIS_O3_TOTAL_COL_OBS=false
      export RUN_CRIS_O3_PROFILE_OBS=false
      export RUN_CRIS_O3_CPSR_OBS=false
      export RUN_CRIS_NH3_TOTAL_COL_OBS=false
      export RUN_CRIS_NH3_PROFILE_OBS=false
      export RUN_CRIS_NH3_CPSR_OBS=false
      export RUN_CRIS_CH4_TOTAL_COL_OBS=false
      export RUN_CRIS_CH4_PROFILE_OBS=false
      export RUN_CRIS_CH4_CPSR_OBS=false
      export RUN_CRIS_PAN_TOTAL_COL_OBS=false
      export RUN_CRIS_PAN_PROFILE_OBS=false
      export RUN_CRIS_PAN_CPSR_OBS=false
      export RUN_SCIAM_NO2_TOTAL_COL_OBS=false
      export RUN_SCIAM_NO2_TROP_COL_OBS=false
      export RUN_GOME2A_NO2_TOTAL_COL_OBS=false
      export RUN_GOME2A_NO2_TROP_COL_OBS=false
      export RUN_MLS_O3_TOTAL_COL_OBS=false
      export RUN_MLS_O3_PROFILE_OBS=false
      export RUN_MLS_O3_CPSR_OBS=false
      export RUN_MLS_HNO3_TOTAL_COL_OBS=false
      export RUN_MLS_HNO3_PROFILE_OBS=false
      export RUN_MLS_HNO3_CPSR_OBS=false
      export RUN_AIRNOW_O3_OBS=false
      export RUN_AIRNOW_CO_OBS=false
      export RUN_AIRNOW_NO2_OBS=false
      export RUN_AIRNOW_SO2_OBS=false
      export RUN_AIRNOW_PM10_OBS=false
      export RUN_AIRNOW_PM25_OBS=false
      export RUN_PANDA_CO_OBS=false
      export RUN_PANDA_O3_OBS=false
      export RUN_PANDA_PM25_OBS=false
      export RUN_MEXICO_AQS_CO_OBS=false
      export RUN_MET_OBS=false
      export RUN_COMBINE_OBS=false
#
      if [[ ${DATE} -eq ${INITIAL_DATE}  ]]; then
         export RUN_PREPROCESS_OBS=false
         export RUN_WRFCHEM_INITIAL=true
         export RUN_LOCALIZATION=false
         export RUN_DART_FILTER=false
         export RUN_BIAS_CORRECTION=false
         export RUN_UPDATE_BC=false
         export RUN_ENSEMBLE_MEAN_INPUT=true
         export RUN_WRFCHEM_CYCLE_CR=false
         export RUN_BAND_DEPTH=false
         export RUN_WRFCHEM_CYCLE_FR=false
         export RUN_ENSMEAN_CYCLE_FR=false
         export RUN_ENSEMBLE_MEAN_OUTPUT=true
      else
         export RUN_PREPROCESS_OBS=false
         export RUN_WRFCHEM_INITIAL=false
         export RUN_LOCALIZATION=false
         export RUN_DART_FILTER=false
         export RUN_BIAS_CORRECTION=false
         export RUN_UPDATE_BC=false
         export RUN_ENSEMBLE_MEAN_INPUT=false
         export RUN_WRFCHEM_CYCLE_CR=true
         export RUN_BAND_DEPTH=false
         export RUN_WRFCHEM_CYCLE_FR=false
         export RUN_ENSMEAN_CYCLE_FR=false
         export RUN_ENSEMBLE_MEAN_OUTPUT=true
      fi
   fi
   if [[ ${RUN_FINE_SCALE} = "true" ]]; then
      export RUN_GEOGRID=false
      export RUN_UNGRIB=false
      export RUN_METGRID=false
      export RUN_REAL=false
      export RUN_PERT_WRFCHEM_MET_IC=false
      export RUN_PERT_WRFCHEM_MET_BC=false
      export RUN_EXO_COLDENS=false
      export RUN_SEASON_WES=false
      export RUN_WRFCHEM_BIO=false
      export RUN_WRFCHEM_FIRE=false
      export RUN_WRFCHEM_CHEMI=false
      export RUN_PERT_WRFCHEM_CHEM_ICBC=false
      export RUN_PERT_WRFCHEM_CHEM_EMISS=false
      export RUN_MOPITT_CO_TOTAL_COL_OBS=true
      export RUN_MOPITT_CO_PROFILE_OBS=true
      export RUN_MOPITT_CO_CPSR_OBS=true
      export RUN_IASI_CO_TOTAL_COL_OBS=false
      export RUN_IASI_CO_PROFILE_OBS=false
      export RUN_IASI_CO_CPSR_OBS=false
      export RUN_IASI_O3_PROFILE_OBS=false
      export RUN_IASI_O3_CPSR_OBS=false
      export RUN_MODIS_AOD_TOTAL_COL_OBS=false
      export RUN_OMI_O3_TOTAL_COL_OBS=false
      export RUN_OMI_O3_TROP_COL_OBS=false
      export RUN_OMI_O3_PROFILE_OBS=false
      export RUN_OMI_O3_CPSR_OBS=false
      export RUN_OMI_NO2_TOTAL_COL_OBS=false
      export RUN_OMI_NO2_TROP_COL_OBS=false
      export RUN_OMI_NO2_DOMINO_TOTAL_COL_OBS=false
      export RUN_OMI_NO2_DOMINO_TROP_COL_OBS=false
      export RUN_OMI_SO2_TOTAL_COL_OBS=false
      export RUN_OMI_SO2_PBL_COL_OBS=false
      export RUN_OMI_HCHO_TOTAL_COL_OBS=false
      export RUN_OMI_HCHO_TROP_COL_OBS=false
      export RUN_TROPOMI_CO_TOTAL_COL_OBS=false
      export RUN_TROPOMI_O3_TOTAL_COL_OBS=false
      export RUN_TROPOMI_O3_TROP_COL_OBS=false
      export RUN_TROPOMI_O3_PROFILE_OBS=false
      export RUN_TROPOMI_O3_CPSR_OBS=false
      export RUN_TROPOMI_NO2_TOTAL_COL_OBS=false
      export RUN_TROPOMI_NO2_TROP_COL_OBS=false
      export RUN_TROPOMI_SO2_TOTAL_COL_OBS=false
      export RUN_TROPOMI_SO2_PBL_COL_OBS=false
      export RUN_TROPOMI_CH4_TOTAL_COL_OBS=false
      export RUN_TROPOMI_CH4_TROP_COL_OBS=false
      export RUN_TROPOMI_CH4_PROFILE_OBS=false
      export RUN_TROPOMI_CH4_CPSR_OBS=false
      export RUN_TROPOMI_HCHO_TOTAL_COL_OBS=false
      export RUN_TROPOMI_HCHO_TROP_COL_OBS=false
      export RUN_TEMPO_O3_TOTAL_COL_OBS=false
      export RUN_TEMPO_O3_TROP_COL_OBS=false
      export RUN_TEMPO_O3_PROFILE_OBS=false
      export RUN_TEMPO_O3_CPSR_OBS=false
      export RUN_TEMPO_NO2_TOTAL_COL_OBS=false
      export RUN_TEMPO_NO2_TROP_COL_OBS=false
      export RUN_TES_CO_TOTAL_COL_OBS=false
      export RUN_TES_CO_PROFILE_OBS=false
      export RUN_TES_CO_CPSR_OBS=false
      export RUN_TES_CO2_TOTAL_COL_OBS=false
      export RUN_TES_CO2_PROFILE_OBS=false
      export RUN_TES_CO2_CPSR_OBS=false
      export RUN_TES_O3_TOTAL_COL_OBS=false
      export RUN_TES_O3_PROFILE_OBS=false
      export RUN_TES_O3_CPSR_OBS=false
      export RUN_TES_NH3_TOTAL_COL_OBS=false
      export RUN_TES_NH3_PROFILE_OBS=false
      export RUN_TES_NH3_CPSR_OBS=false
      export RUN_TES_CH4_TOTAL_COL_OBS=false
      export RUN_TES_CH4_PROFILE_OBS=false
      export RUN_TES_CH4_CPSR_OBS=false
      export RUN_CRIS_CO_TOTAL_COL_OBS=false
      export RUN_CRIS_CO_PROFILE_OBS=false
      export RUN_CRIS_CO_CPSR_OBS=false
      export RUN_CRIS_O3_TOTAL_COL_OBS=false
      export RUN_CRIS_O3_PROFILE_OBS=false
      export RUN_CRIS_O3_CPSR_OBS=false
      export RUN_CRIS_NH3_TOTAL_COL_OBS=false
      export RUN_CRIS_NH3_PROFILE_OBS=false
      export RUN_CRIS_NH3_CPSR_OBS=false
      export RUN_CRIS_CH4_TOTAL_COL_OBS=false
      export RUN_CRIS_CH4_PROFILE_OBS=false
      export RUN_CRIS_CH4_CPSR_OBS=false
      export RUN_CRIS_PAN_TOTAL_COL_OBS=false
      export RUN_CRIS_PAN_PROFILE_OBS=false
      export RUN_CRIS_PAN_CPSR_OBS=false
      export RUN_SCIAM_NO2_TOTAL_COL_OBS=false
      export RUN_SCIAM_NO2_TROP_COL_OBS=false
      export RUN_GOME2A_NO2_TOTAL_COL_OBS=false
      export RUN_GOME2A_NO2_TROP_COL_OBS=false
      export RUN_MLS_O3_TOTAL_COL_OBS=false
      export RUN_MLS_O3_PROFILE_OBS=false
      export RUN_MLS_O3_CPSR_OBS=false
      export RUN_MLS_HNO3_TOTAL_COL_OBS=false
      export RUN_MLS_HNO3_PROFILE_OBS=false
      export RUN_MLS_HNO3_CPSR_OBS=false
      export RUN_AIRNOW_O3_OBS=false
      export RUN_AIRNOW_CO_OBS=false
      export RUN_AIRNOW_NO2_OBS=false
      export RUN_AIRNOW_SO2_OBS=false
      export RUN_AIRNOW_PM10_OBS=false
      export RUN_AIRNOW_PM25_OBS=false
      export RUN_PANDA_CO_OBS=false
      export RUN_PANDA_O3_OBS=false
      export RUN_PANDA_PM25_OBS=false
      export RUN_MEXICO_AQS_CO_OBS=false
      export RUN_MET_OBS=false
      export RUN_COMBINE_OBS=false
      export RUN_PREPROCESS_OBS=false
      export RUN_WRFCHEM_INITIAL=false
      export RUN_LOCALIZATION=false
      export RUN_DART_FILTER=false
      export RUN_BIAS_CORRECTION=false
      export RUN_UPDATE_BC=false
      export RUN_ENSEMBLE_MEAN_INPUT=false
      export RUN_WRFCHEM_CYCLE_CR=false
      export RUN_BAND_DEPTH=false
      export RUN_WRFCHEM_CYCLE_FR=false
      export RUN_ENSMEAN_CYCLE_FR=true
      export RUN_ENSEMBLE_MEAN_OUTPUT=false
   fi
#
# FORECAST PARAMETERS:
   export USE_DART_INFL=true
   export FCST_PERIOD=6
   (( CYCLE_PERIOD_SEC=${CYCLE_PERIOD}*60*60 ))
   export NUM_MEMBERS=20
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
   export GENERAL_JOB_CLASS=normal
   export GENERAL_TIME_LIMIT=00:20:00
   export GENERAL_NODES=1
   export GENERAL_TASKS=16
#   export GENERAL_JOB_CLASS=devel
#   export GENERAL_TIME_LIMIT=00:20:00
#   export GENERAL_NODES=1
#   export GENERAL_TASKS=16
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
#   export FILTER_JOB_CLASS=devel
#   export FILTER_TIME_LIMIT=01:59:00
#   export FILTER_NODES=2
#   export FILTER_TASKS=16
# Haswell
   export FILTER_JOB_CLASS=normal
   export FILTER_TIME_LIMIT=07:59:00
   export FILTER_NODES=3
   export FILTER_TASKS=24
#   export FILTER_JOB_CLASS=devel
#   export FILTER_TIME_LIMIT=01:59:00
#   export FILTER_NODES=3
#   export FILTER_TASKS=24
#
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
   export PERT_NODES=2
   export PERT_TASKS=16
#   (( PERT_TASKS=${NUM_MEMBERS}+1 ))
#   export PERT_JOB_CLASS=devel
#   export PERT_TIME_LIMIT=01:59:00
#   export PERT_NODES=2
#   export PERT_TASKS=16
#   (( PERT_TASKS=${NUM_MEMBERS}+1 ))
#
# RUN DIRECTORIES
   export GEOGRID_DIR=${RUN_DIR}/geogrid
   export METGRID_DIR=${RUN_DIR}/${DATE}/metgrid
   export REAL_DIR=${RUN_DIR}/${DATE}/real
   export WRFCHEM_MET_IC_DIR=${RUN_DIR}/${DATE}/wrfchem_met_ic
   export WRFCHEM_MET_BC_DIR=${RUN_DIR}/${DATE}/wrfchem_met_bc
   export EXO_COLDENS_DIR=${RUN_DIR}/${DATE}/exo_coldens
   export SEASONS_WES_DIR=${RUN_DIR}/${DATE}/seasons_wes
   export WRFCHEM_BIO_DIR=${RUN_DIR}/${DATE}/wrfchem_bio
   export WRFCHEM_FIRE_DIR=${RUN_DIR}/${DATE}/wrfchem_fire
   export WRFCHEM_CHEMI_DIR=${RUN_DIR}/${DATE}/wrfchem_chemi
   export WRFCHEM_CHEM_EMISS_DIR=${RUN_DIR}/${DATE}/wrfchem_chem_emiss
   export WRFCHEM_INITIAL_DIR=${RUN_DIR}/${INITIAL_DATE}/wrfchem_initial
   export WRFCHEM_CYCLE_CR_DIR=${RUN_DIR}/${DATE}/wrfchem_cycle_cr
   export WRFCHEM_CYCLE_FR_DIR=${RUN_DIR}/${DATE}/wrfchem_cycle_fr
   export WRFCHEM_LAST_CYCLE_CR_DIR=${RUN_DIR}/${PAST_DATE}/wrfchem_cycle_cr
   export PREPBUFR_MET_OBS_DIR=${RUN_DIR}/${DATE}/prepbufr_met_obs
   export MOPITT_CO_TOTAL_COL_OBS_DIR=${RUN_DIR}/${DATE}/mopitt_co_total_col_obs
   export MOPITT_CO_PROFILE_OBS_DIR=${RUN_DIR}/${DATE}/mopitt_co_profile_obs
   export MOPITT_CO_CPSR_OBS_DIR=${RUN_DIR}/${DATE}/mopitt_co_cpsr_obs
   export IASI_CO_TOTAL_COL_OBS_DIR=${RUN_DIR}/${DATE}/iasi_co_total_col_obs
   export IASI_CO_PROFILE_OBS_DIR=${RUN_DIR}/${DATE}/iasi_co_profile_obs
   export IASI_CO_CPSR_OBS_DIR=${RUN_DIR}/${DATE}/iasi_co_cpsr_obs
   export IASI_O3_PROFILE_OBS_DIR=${RUN_DIR}/${DATE}/iasi_o3_profile_obs
   export IASI_O3_CPSR_OBS_DIR=${RUN_DIR}/${DATE}/iasi_o3_cpsr_obs
   export MODIS_AOD_TOTAL_COL_OBS_DIR=${RUN_DIR}/${DATE}/modis_aod_total_col_obs
   export OMI_O3_TOTAL_COL_OBS_DIR=${RUN_DIR}/${DATE}/omi_o3_total_col_obs
   export OMI_O3_TROP_COL_OBS_DIR=${RUN_DIR}/${DATE}/omi_o3_trop_col_obs
   export OMI_O3_PROFILE_OBS_DIR=${RUN_DIR}/${DATE}/omi_o3_profile_obs
   export OMI_O3_CPSR_OBS_DIR=${RUN_DIR}/${DATE}/omi_o3_cpsr_obs
   export OMI_NO2_TOTAL_COL_OBS_DIR=${RUN_DIR}/${DATE}/omi_no2_total_col_obs
   export OMI_NO2_TROP_COL_OBS_DIR=${RUN_DIR}/${DATE}/omi_no2_trop_col_obs
   export OMI_NO2_DOMINO_TOTAL_COL_OBS_DIR=${RUN_DIR}/${DATE}/omi_no2_domino_total_col_obs
   export OMI_NO2_DOMINO_TROP_COL_OBS_DIR=${RUN_DIR}/${DATE}/omi_no2_domino_trop_col_obs
   export OMI_SO2_TOTAL_COL_OBS_DIR=${RUN_DIR}/${DATE}/omi_so2_total_col_obs
   export OMI_SO2_PBL_COL_OBS_DIR=${RUN_DIR}/${DATE}/omi_so2_pbl_col_obs
   export OMI_HCHO_TOTAL_COL_OBS_DIR=${RUN_DIR}/${DATE}/omi_hcho_total_col_obs
   export OMI_HCHO_TROP_COL_OBS_DIR=${RUN_DIR}/${DATE}/omi_hcho_trop_col_obs
   export TROPOMI_CO_TOTAL_COL_OBS_DIR=${RUN_DIR}/${DATE}/tropomi_co_total_col_obs
   export TROPOMI_O3_TOTAL_COL_OBS_DIR=${RUN_DIR}/${DATE}/tropomi_o3_total_col_obs
   export TROPOMI_O3_TROP_COL_OBS_DIR=${RUN_DIR}/${DATE}/tropomi_o3_trop_col_obs
   export TROPOMI_O3_PROFILE_OBS_DIR=${RUN_DIR}/${DATE}/tropomi_o3_profile_obs
   export TROPOMI_O3_CPSR_OBS_DIR=${RUN_DIR}/${DATE}/tropomi_o3_cpsr_obs
   export TROPOMI_NO2_TOTAL_COL_OBS_DIR=${RUN_DIR}/${DATE}/tropomi_no2_total_col_obs
   export TROPOMI_NO2_TROP_COL_OBS_DIR=${RUN_DIR}/${DATE}/tropomi_no2_trop_col_obs
   export TROPOMI_SO2_TOTAL_COL_OBS_DIR=${RUN_DIR}/${DATE}/tropomi_so2_total_col_obs
   export TROPOMI_SO2_PBL_COL_OBS_DIR=${RUN_DIR}/${DATE}/tropomi_so2_pbl_col_obs
   export TROPOMI_CH4_TOTAL_COL_OBS_DIR=${RUN_DIR}/${DATE}/tropomi_ch4_total_col_obs
   export TROPOMI_CH4_TROP_COL_OBS_DIR=${RUN_DIR}/${DATE}/tropomi_ch4_trop_col_obs
   export TROPOMI_CH4_PROFILE_OBS_DIR=${RUN_DIR}/${DATE}/tropomi_ch4_profile_obs
   export TROPOMI_CH4_CPSR_OBS_DIR=${RUN_DIR}/${DATE}/tropomi_ch4_cpsr_obs
   export TROPOMI_HCHO_TOTAL_COL_OBS_DIR=${RUN_DIR}/${DATE}/tropomi_hcho_total_col_obs
   export TROPOMI_HCHO_TROP_COL_OBS_DIR=${RUN_DIR}/${DATE}/tropomi_hcho_trop_col_obs
   export TEMPO_O3_TOTAL_COL_OBS_DIR=${RUN_DIR}/${DATE}/tempo_o3_total_col_obs
   export TEMPO_O3_TROP_COL_OBS_DIR=${RUN_DIR}/${DATE}/tempo_o3_trop_col_obs
   export TEMPO_O3_PROFILE_OBS_DIR=${RUN_DIR}/${DATE}/tempo_o3_profile_obs
   export TEMPO_O3_CPSR_OBS_DIR=${RUN_DIR}/${DATE}/tempo_o3_cpsr_obs
   export TEMPO_NO2_TOTAL_COL_OBS_DIR=${RUN_DIR}/${DATE}/tempo_no2_total_col_obs
   export TEMPO_NO2_TROP_COL_OBS_DIR=${RUN_DIR}/${DATE}/tempo_no2_trop_col_obs
   export TES_CO_TOTAL_COL_OBS_DIR=${RUN_DIR}/${DATE}/tes_co_total_col_obs 
   export TES_CO_TROP_COL_OBS_DIR=${RUN_DIR}/${DATE}/tes_co_trop_col_obs
   export TES_CO_PROFILE_OBS_DIR=${RUN_DIR}/${DATE}/tes_co_profile_obs
   export TES_CO_CPSR_OBS_DIR=${RUN_DIR}/${DATE}/tes_co_cpsr_obs
   export TES_CO2_TOTAL_COL_OBS_DIR=${RUN_DIR}/${DATE}/tes_co2_total_col_obs
   export TES_CO2_TROP_COL_OBS_DIR=${RUN_DIR}/${DATE}/tes_co2_trop_col_obs
   export TES_CO2_PROFILE_OBS_DIR=${RUN_DIR}/${DATE}/tes_co2_profile_obs
   export TES_CO2_CPSR_OBS_DIR=${RUN_DIR}/${DATE}/tes_co2_cpsr_obs
   export TES_O3_TOTAL_COL_OBS_DIR=${RUN_DIR}/${DATE}/tes_o3_total_col_obs
   export TES_O3_TROP_COL_OBS_DIR=${RUN_DIR}/${DATE}/tes_o3_trop_col_obs
   export TES_O3_PROFILE_OBS_DIR=${RUN_DIR}/${DATE}/tes_o3_profile_obs
   export TES_O3_CPSR_OBS_DIR=${RUN_DIR}/${DATE}/tes_o3_cpsr_obs
   export TES_NH3_TOTAL_COL_OBS_DIR=${RUN_DIR}/${DATE}/tes_nh3_total_col_obs
   export TES_NH3_TROP_COL_OBS_DIR=${RUN_DIR}/${DATE}/tes_nh3_trop_col_obs
   export TES_NH3_PROFILE_OBS_DIR=${RUN_DIR}/${DATE}/tes_nh3_profile_obs
   export TES_NH3_CPSR_OBS_DIR=${RUN_DIR}/${DATE}/tes_nh3_cpsr_obs
   export TES_CH4_TOTAL_COL_OBS_DIR=${RUN_DIR}/${DATE}/tes_ch4_total_col_obs
   export TES_CH4_TROP_COL_OBS_DIR=${RUN_DIR}/${DATE}/tes_ch4_trop_col_obs
   export TES_CH4_PROFILE_OBS_DIR=${RUN_DIR}/${DATE}/tes_ch4_profile_obs
   export TES_CH4_CPSR_OBS_DIR=${RUN_DIR}/${DATE}/tes_ch4_cpsr_obs
   export CRIS_CO_TOTAL_COL_OBS_DIR=${RUN_DIR}/${DATE}/cris_co_total_col_obs 
   export CRIS_CO_TROP_COL_OBS_DIR=${RUN_DIR}/${DATE}/cris_co_trop_col_obs
   export CRIS_CO_PROFILE_OBS_DIR=${RUN_DIR}/${DATE}/cris_co_profile_obs
   export CRIS_CO_CPSR_OBS_DIR=${RUN_DIR}/${DATE}/cris_co_cpsr_obs
   export CRIS_CO2_TOTAL_COL_OBS_DIR=${RUN_DIR}/${DATE}/cris_co2_total_col_obs
   export CRIS_CO2_TROP_COL_OBS_DIR=${RUN_DIR}/${DATE}/cris_co2_trop_col_obs
   export CRIS_CO2_PROFILE_OBS_DIR=${RUN_DIR}/${DATE}/cris_co2_profile_obs
   export CRIS_CO2_CPSR_OBS_DIR=${RUN_DIR}/${DATE}/cris_co2_cpsr_obs
   export CRIS_O3_TOTAL_COL_OBS_DIR=${RUN_DIR}/${DATE}/cris_o3_total_col_obs
   export CRIS_O3_TROP_COL_OBS_DIR=${RUN_DIR}/${DATE}/cris_o3_trop_col_obs
   export CRIS_O3_PROFILE_OBS_DIR=${RUN_DIR}/${DATE}/cris_o3_profile_obs
   export CRIS_O3_CPSR_OBS_DIR=${RUN_DIR}/${DATE}/cris_o3_cpsr_obs
   export CRIS_NH3_TOTAL_COL_OBS_DIR=${RUN_DIR}/${DATE}/cris_nh3_total_col_obs
   export CRIS_NH3_TROP_COL_OBS_DIR=${RUN_DIR}/${DATE}/cris_nh3_trop_col_obs
   export CRIS_NH3_PROFILE_OBS_DIR=${RUN_DIR}/${DATE}/cris_nh3_profile_obs
   export CRIS_NH3_CPSR_OBS_DIR=${RUN_DIR}/${DATE}/cris_nh3_cpsr_obs
   export CRIS_CH4_TOTAL_COL_OBS_DIR=${RUN_DIR}/${DATE}/cris_ch4_total_col_obs
   export CRIS_CH4_TROP_COL_OBS_DIR=${RUN_DIR}/${DATE}/cris_ch4_trop_col_obs
   export CRIS_CH4_PROFILE_OBS_DIR=${RUN_DIR}/${DATE}/cris_ch4_profile_obs
   export CRIS_CH4_CPSR_OBS_DIR=${RUN_DIR}/${DATE}/cris_ch4_cpsr_obs
   export CRIS_PAN_TOTAL_COL_OBS_DIR=${RUN_DIR}/${DATE}/cris_pan_total_col_obs
   export CRIS_PAN_TROP_COL_OBS_DIR=${RUN_DIR}/${DATE}/cris_pan_trop_col_obs
   export CRIS_PAN_PROFILE_OBS_DIR=${RUN_DIR}/${DATE}/cris_pan_profile_obs
   export CRIS_PAN_CPSR_OBS_DIR=${RUN_DIR}/${DATE}/cris_pan_cpsr_obs
   export SCIAM_NO2_TOTAL_COL_OBS_DIR=${RUN_DIR}/${DATE}/sciam_no2_total_col_obs
   export SCIAM_NO2_TROP_COL_OBS_DIR=${RUN_DIR}/${DATE}/sciam_no2_trop_col_obs
   export GOME2A_NO2_TOTAL_COL_OBS_DIR=${RUN_DIR}/${DATE}/gome2a_no2_total_col_obs
   export GOME2A_NO2_TROP_COL_OBS_DIR=${RUN_DIR}/${DATE}/gome2a_no2_trop_col_obs
   export MLS_O3_TOTAL_COL_OBS_DIR=${RUN_DIR}/${DATE}/mls_o3_total_col_obs
   export MLS_O3_PROFILE_OBS_DIR=${RUN_DIR}/${DATE}/mls_o3_profile_obs
   export MLS_O3_CPSR_OBS_DIR=${RUN_DIR}/${DATE}/mls_o3_cpsr_obs
   export MLS_HNO3_TOTAL_COL_OBS_DIR=${RUN_DIR}/${DATE}/mls_hno3_total_col_obs
   export MLS_HNO3_PROFILE_OBS_DIR=${RUN_DIR}/${DATE}/mls_hno3_profile_obs
   export MLS_HNO3_CPSR_OBS_DIR=${RUN_DIR}/${DATE}/mls_hno3_cpsr_obs
   export AIRNOW_CO_OBS_DIR=${RUN_DIR}/${DATE}/airnow_co_obs
   export AIRNOW_O3_OBS_DIR=${RUN_DIR}/${DATE}/airnow_o3_obs
   export AIRNOW_NO2_OBS_DIR=${RUN_DIR}/${DATE}/airnow_no2_obs
   export AIRNOW_SO2_OBS_DIR=${RUN_DIR}/${DATE}/airnow_so2_obs
   export AIRNOW_PM10_OBS_DIR=${RUN_DIR}/${DATE}/airnow_pm10_obs
   export AIRNOW_PM25_OBS_DIR=${RUN_DIR}/${DATE}/airnow_pm25_obs
   export PANDA_CO_OBS_DIR=${RUN_DIR}/${DATE}/panda_co_obs
   export PANDA_O3_OBS_DIR=${RUN_DIR}/${DATE}/panda_o3_obs
   export PANDA_PM25_OBS_DIR=${RUN_DIR}/${DATE}/panda_pm25_obs
   export COMBINE_OBS_DIR=${RUN_DIR}/${DATE}/combine_obs
   export PREPROCESS_OBS_DIR=${RUN_DIR}/${DATE}/preprocess_obs
   export WRFCHEM_CHEM_ICBC_DIR=${RUN_DIR}/${DATE}/wrfchem_chem_icbc
   export LOCALIZATION_DIR=${RUN_DIR}/${DATE}/localization
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
# RUN GEOGRID
#
#########################################################################
#
   if [[ ${RUN_GEOGRID} = "true" ]]; then
      mkdir -p ${RUN_DIR}/geogrid
      cd ${RUN_DIR}/geogrid
#
      cp ${WPS_DIR}/geogrid.exe ./.
      export NL_DX=${DX_CR}
      export NL_DY=${DX_CR}
      export NL_START_DATE=${FILE_DATE}
      export NL_END_DATE=${NEXT_FILE_DATE}
      ${NAMELIST_SCRIPTS_DIR}/MISC/da_create_wps_namelist_RT.ksh
#
#      RANDOM=$$
#      export JOBRND=${RANDOM}_geogrid
#      ${JOB_CONTROL_SCRIPTS_DIR}/job_script_nasa.ksh ${JOBRND} ${GENERAL_JOB_CLASS} ${GENERAL_TIME_LIMIT} ${GENERAL_NODES} ${GENERAL_TASKS} geogrid.exe SERIAL ${ACCOUNT}
#      qsub -Wblock=true job.ksh
      rm -rf index.html
      chmod +x geogrid.exe
      ./geogrid.exe > index.html 2>&1
   fi
#
#########################################################################
#
# RUN UNGRIB
#
#########################################################################
#
   if [[ ${RUN_UNGRIB} = "true" ]]; then 
      mkdir -p ${RUN_DIR}/${DATE}/ungrib
      cd ${RUN_DIR}/${DATE}/ungrib
      rm -rf GRIBFILE.*
#
      cp ${VTABLE_DIR}/Vtable.${VTABLE_TYPE} Vtable
      cp ${WPS_DIR}/ungrib.exe ./.
#
      export L_FCST_RANGE=${LBC_END}
      export L_START_DATE=${DATE}
      export L_END_DATE=$($BUILD_DIR/da_advance_time.exe ${L_START_DATE} ${L_FCST_RANGE} 2>/dev/null)
      export L_START_YEAR=$(echo $L_START_DATE | cut -c1-4)
      export L_START_MONTH=$(echo $L_START_DATE | cut -c5-6)
      export L_START_DAY=$(echo $L_START_DATE | cut -c7-8)
      export L_START_HOUR=$(echo $L_START_DATE | cut -c9-10)
      export L_END_YEAR=$(echo $L_END_DATE | cut -c1-4)
      export L_END_MONTH=$(echo $L_END_DATE | cut -c5-6)
      export L_END_DAY=$(echo $L_END_DATE | cut -c7-8)
      export L_END_HOUR=$(echo $L_END_DATE | cut -c9-10)
      export NL_START_YEAR=$(echo $L_START_DATE | cut -c1-4),$(echo $L_START_DATE | cut -c1-4)
      export NL_START_MONTH=$(echo $L_START_DATE | cut -c5-6),$(echo $L_START_DATE | cut -c5-6)
      export NL_START_DAY=$(echo $L_START_DATE | cut -c7-8),$(echo $L_START_DATE | cut -c7-8)
      export NL_START_HOUR=$(echo $L_START_DATE | cut -c9-10),$(echo $L_START_DATE | cut -c9-10)
      export NL_END_YEAR=$(echo $L_END_DATE | cut -c1-4),$(echo $L_END_DATE | cut -c1-4)
      export NL_END_MONTH=$(echo $L_END_DATE | cut -c5-6),$(echo $L_END_DATE | cut -c5-6)
      export NL_END_DAY=$(echo $L_END_DATE | cut -c7-8),$(echo $L_END_DATE | cut -c7-8)
      export NL_END_HOUR=$(echo $L_END_DATE | cut -c9-10),$(echo $L_END_DATE | cut -c9-10)
      export NL_START_DATE=\'${L_START_YEAR}-${L_START_MONTH}-${L_START_DAY}_${L_START_HOUR}:00:00\',\'${L_START_YEAR}-${L_START_MONTH}-${L_START_DAY}_${L_START_HOUR}:00:00\'
      export NL_END_DATE=\'${L_END_YEAR}-${L_END_MONTH}-${L_END_DAY}_${L_END_HOUR}:00:00\',\'${L_END_YEAR}-${L_END_MONTH}-${L_END_DAY}_${L_END_HOUR}:00:00\'
      ${NAMELIST_SCRIPTS_DIR}/MISC/da_create_wps_namelist_RT.ksh
#
# UNTAR THE PARENT FORECAST FILES
      FILES=''
      if [[ -e ${EXPERIMENT_GFS_DIR}/${DATE} ]]; then
         if [[ -e ${EXPERIMENT_GFS_DIR}/${DATE}/${GRIB_PART1}${DATE}${GRIB_PART2} ]]; then
#            cd ${EXPERIMENT_GFS_DIR}/${DATE}
            tar xvfs ${EXPERIMENT_GFS_DIR}/${DATE}/${GRIB_PART1}${DATE}${GRIB_PART2}
#            cd ${RUN_DIR}/${DATE}/ungrib
         else
            echo 'APM: ERROR - No GRIB files in directory'
            exit
         fi
         sleep 30
#  
         if [[ ${SINGLE_FILE} == false ]]; then
            export CCHH=${HH}00
            (( LBC_ITR=${LBC_START} ))
            while [[ ${LBC_ITR} -le ${LBC_END} ]]; do
               if [[ ${LBC_ITR} -lt 1000 ]]; then export CFTM=${LBC_ITR}; fi
               if [[ ${LBC_ITR} -lt 100  ]]; then export CFTM=0${LBC_ITR}; fi
               if [[ ${LBC_ITR} -lt 10   ]]; then export CFTM=00${LBC_ITR}; fi
               if [[ ${LBC_ITR} -eq 0    ]]; then export CFTM=000; fi
#               export FILE=${EXPERIMENT_GFS_DIR}/${DATE}/${GRIB_PART1}${START_YEAR}${START_MONTH}${START_DAY}_${CCHH}_${CFTM}.grb2
               export FILE=${GRIB_PART1}${START_YEAR}${START_MONTH}${START_DAY}_${CCHH}_${CFTM}.grb2
               FILES="${FILES} ${FILE}"
               (( LBC_ITR=${LBC_ITR}+${LBC_FREQ} ))
            done
         else
            echo 'APM: Large scale single file input option does not work'
         fi
      fi
#
# LINK GRIB FILES
      ${WPS_DIR}/link_grib.csh $FILES
#      RANDOM=$$
#      export JOBRND=${RANDOM}_ungrib
#      ${JOB_CONTROL_SCRIPTS_DIR}/job_script_nasa.ksh ${JOBRND} ${GENERAL_JOB_CLASS} ${GENERAL_TIME_LIMIT} ${GENERAL_NODES} ${GENERAL_TASKS} ungrib.exe SERIAL ${ACCOUNT}
#      qsub -Wblock=true job.ksh
      rm -rf index.html
      chmod +x ungrib.exe
      ./ungrib.exe > index.html 2>&1
#
# TAR THE PARENT FORECAST FILES
#       rm -rf *.grb2
#      if [[ -e ${EXPERIMENT_GFS_DIR}/${DATE}/${GRIB_PART1}${DATE}${GRIB_PART2} ]]; then
#         rm -rf ${EXPERIMENT_GFS_DIR}/${DATE}/${GRIB_PART1}*.grb2
#      else
#         cd ${EXPERIMENT_GFS_DIR}
#         tar -cf ${GRIB_PART1}${DATE}${GRIB_PART2} ${DATE}
#         mv ${GRIB_PART1}${DATE}${GRIB_PART2} ${DATE}/.
#         if [[ -e ${DATE}/${GRIB_PART1}${DATE}${GRIB_PART2} ]]; then
#            rm -rf ${DATE}/${GRIB_PART1}*.grb2
#         else
#            echo 'APM: Failed to created tar file'
#            exit
#         fi
#         cd ${RUN_DIR}/${DATE}/ungrib
#      fi
   fi
#
#########################################################################
#
# RUN METGRID
#
#########################################################################
#
   if [[ ${RUN_METGRID} = "true" ]]; then 
      mkdir -p ${RUN_DIR}/${DATE}/metgrid
      cd ${RUN_DIR}/${DATE}/metgrid
#
      ln -fs ${GEOGRID_DIR}/geo_em.d${CR_DOMAIN}.nc ./.
      ln -fs ${GEOGRID_DIR}/geo_em.d${FR_DOMAIN}.nc ./.
      ln -fs ../ungrib/FILE:* ./.
      ln -fs ${WPS_DIR}/metgrid/METGRID.TBL.${METGRID_TABLE_TYPE} METGRID.TBL
      ln -fs ${WPS_DIR}/metgrid.exe .
#
      export L_FCST_RANGE=${LBC_END}
      export L_START_DATE=${DATE}
      export L_END_DATE=$($BUILD_DIR/da_advance_time.exe ${L_START_DATE} ${L_FCST_RANGE} 2>/dev/null)
      export L_START_YEAR=$(echo $L_START_DATE | cut -c1-4)
      export L_START_MONTH=$(echo $L_START_DATE | cut -c5-6)
      export L_START_DAY=$(echo $L_START_DATE | cut -c7-8)
      export L_START_HOUR=$(echo $L_START_DATE | cut -c9-10)
      export L_END_YEAR=$(echo $L_END_DATE | cut -c1-4)
      export L_END_MONTH=$(echo $L_END_DATE | cut -c5-6)
      export L_END_DAY=$(echo $L_END_DATE | cut -c7-8)
      export L_END_HOUR=$(echo $L_END_DATE | cut -c9-10)
      export NL_START_YEAR=$(echo $L_START_DATE | cut -c1-4),$(echo $L_START_DATE | cut -c1-4)
      export NL_START_MONTH=$(echo $L_START_DATE | cut -c5-6),$(echo $L_START_DATE | cut -c5-6)
      export NL_START_DAY=$(echo $L_START_DATE | cut -c7-8),$(echo $L_START_DATE | cut -c7-8)
      export NL_START_HOUR=$(echo $L_START_DATE | cut -c9-10),$(echo $L_START_DATE | cut -c9-10)
      export NL_END_YEAR=$(echo $L_END_DATE | cut -c1-4),$(echo $L_END_DATE | cut -c1-4)
      export NL_END_MONTH=$(echo $L_END_DATE | cut -c5-6),$(echo $L_END_DATE | cut -c5-6)
      export NL_END_DAY=$(echo $L_END_DATE | cut -c7-8),$(echo $L_END_DATE | cut -c7-8)
      export NL_END_HOUR=$(echo $L_END_DATE | cut -c9-10),$(echo $L_END_DATE | cut -c9-10)
      export NL_START_DATE=\'${L_START_YEAR}-${L_START_MONTH}-${L_START_DAY}_${L_START_HOUR}:00:00\',\'${L_START_YEAR}-${L_START_MONTH}-${L_START_DAY}_${L_START_HOUR}:00:00\'
      export NL_END_DATE=\'${L_END_YEAR}-${L_END_MONTH}-${L_END_DAY}_${L_END_HOUR}:00:00\',\'${L_END_YEAR}-${L_END_MONTH}-${L_END_DAY}_${L_END_HOUR}:00:00\'
      ${NAMELIST_SCRIPTS_DIR}/MISC/da_create_wps_namelist_RT.ksh
#
      RANDOM=$$
      export JOBRND=${RANDOM}_metgrid
#      ${JOB_CONTROL_SCRIPTS_DIR}/job_script_nasa.ksh ${JOBRND} ${GENERAL_JOB_CLASS} ${GENERAL_TIME_LIMIT} ${GENERAL_NODES} ${GENERAL_TASKS} metgrid.exe SERIAL ${ACCOUNT}
#      qsub -Wblock=true job.ksh
     rm -rf index.html
     chmod +x metgrid.exe
     ./metgrid.exe > index.html 2>&1
   fi
#
#########################################################################
#
# RUN REAL
#
#########################################################################
#
   if [[ ${RUN_REAL} = "true" ]]; then 
      mkdir -p ${RUN_DIR}/${DATE}/real
      cd ${RUN_DIR}/${DATE}/real
#
      cp ${WRF_DIR}/main/real.exe ./.
      cp ${EXPERIMENT_HIST_IO_DIR}/hist_io_flds_v1 ./.
      cp ${EXPERIMENT_HIST_IO_DIR}/hist_io_flds_v2 ./.
#
# LINK IN THE METGRID FILES
      export P_DATE=${DATE}
      export P_END_DATE=$(${BUILD_DIR}/da_advance_time.exe ${P_DATE} ${LBC_END} 2>/dev/null)
      while [[ ${P_DATE} -le ${P_END_DATE} ]] ; do
         export P_YYYY=$(echo $P_DATE | cut -c1-4)
         export P_MM=$(echo $P_DATE | cut -c5-6)
         export P_DD=$(echo $P_DATE | cut -c7-8)
         export P_HH=$(echo $P_DATE | cut -c9-10)
         export P_FILE_DATE=${P_YYYY}-${P_MM}-${P_DD}_${P_HH}:00:00.nc
         ln -sf ${RUN_DIR}/${DATE}/metgrid/met_em.d${CR_DOMAIN}.${P_FILE_DATE} ./.
         ln -sf ${RUN_DIR}/${DATE}/metgrid/met_em.d${FR_DOMAIN}.${P_FILE_DATE} ./.
         export P_DATE=$(${BUILD_DIR}/da_advance_time.exe ${P_DATE} ${LBC_FREQ} 2>/dev/null) 
      done
#
# LOOP THROUGH BDY TENDENCY TIMES FOR PERTURB_BC
      export P_DATE=${DATE}
      export P_END_DATE=$(${BUILD_DIR}/da_advance_time.exe ${P_DATE} ${FCST_PERIOD} 2>/dev/null)
      while [[ ${P_DATE} -le ${P_END_DATE} ]] ; do      
#
# CREATE WRF NAMELIST
         export NL_IOFIELDS_FILENAME=' '
         export NL_IOFIELDS_FILENAME=\'hist_io_flds_v1\',\'hist_io_flds_v2\'
         export L_FCST_RANGE=${FCST_PERIOD}
         export NL_DX=${DX_CR},${DX_FR}
         export NL_DY=${DX_CR},${DX_FR}
         export L_START_DATE=${P_DATE}
         export L_END_DATE=$($BUILD_DIR/da_advance_time.exe ${L_START_DATE} ${L_FCST_RANGE} 2>/dev/null)
         export L_START_YEAR=$(echo $L_START_DATE | cut -c1-4)
         export L_START_MONTH=$(echo $L_START_DATE | cut -c5-6)
         export L_START_DAY=$(echo $L_START_DATE | cut -c7-8)
         export L_START_HOUR=$(echo $L_START_DATE | cut -c9-10)
         export L_END_YEAR=$(echo $L_END_DATE | cut -c1-4)
         export L_END_MONTH=$(echo $L_END_DATE | cut -c5-6)
         export L_END_DAY=$(echo $L_END_DATE | cut -c7-8)
         export L_END_HOUR=$(echo $L_END_DATE | cut -c9-10)
         export NL_START_YEAR=$(echo $L_START_DATE | cut -c1-4),$(echo $L_START_DATE | cut -c1-4)
         export NL_START_MONTH=$(echo $L_START_DATE | cut -c5-6),$(echo $L_START_DATE | cut -c5-6)
         export NL_START_DAY=$(echo $L_START_DATE | cut -c7-8),$(echo $L_START_DATE | cut -c7-8)
         export NL_START_HOUR=$(echo $L_START_DATE | cut -c9-10),$(echo $L_START_DATE | cut -c9-10)
         export NL_END_YEAR=$(echo $L_END_DATE | cut -c1-4),$(echo $L_END_DATE | cut -c1-4)
         export NL_END_MONTH=$(echo $L_END_DATE | cut -c5-6),$(echo $L_END_DATE | cut -c5-6)
         export NL_END_DAY=$(echo $L_END_DATE | cut -c7-8),$(echo $L_END_DATE | cut -c7-8)
         export NL_END_HOUR=$(echo $L_END_DATE | cut -c9-10),$(echo $L_END_DATE | cut -c9-10)
         export NL_START_DATE=\'${L_START_YEAR}-${L_START_MONTH}-${L_START_DAY}_${L_START_HOUR}:00:00\',\'${L_START_YEAR}-${L_START_MONTH}-${L_START_DAY}_${L_START_HOUR}:00:00\'
         export NL_END_DATE=\'${L_END_YEAR}-${L_END_MONTH}-${L_END_DAY}_${L_END_HOUR}:00:00\',\'${L_END_YEAR}-${L_END_MONTH}-${L_END_DAY}_${L_END_HOUR}:00:00\'
         ${NAMELIST_SCRIPTS_DIR}/MISC/da_create_wrf_namelist_RT_v4.ksh
#
         RANDOM=$$
         export JOBRND=${RANDOM}_real
#         ${JOB_CONTROL_SCRIPTS_DIR}/job_script_nasa.ksh ${JOBRND} ${GENERAL_JOB_CLASS} ${GENERAL_TIME_LIMIT} ${GENERAL_NODES} ${GENERAL_TASKS} real.exe SERIAL ${ACCOUNT}
#         qsub -Wblock=true job.ksh
         rm -rf index.html
         chmod +x real.exe
         ./real.exe > index.html 2>&1
#
         mv wrfinput_d${CR_DOMAIN} wrfinput_d${CR_DOMAIN}_$(${BUILD_DIR}/da_advance_time.exe ${P_DATE} 0 -W 2>/dev/null)
         mv wrfinput_d${FR_DOMAIN} wrfinput_d${FR_DOMAIN}_$(${BUILD_DIR}/da_advance_time.exe ${P_DATE} 0 -W 2>/dev/null)
         mv wrfbdy_d${CR_DOMAIN} wrfbdy_d${CR_DOMAIN}_$(${BUILD_DIR}/da_advance_time.exe ${P_DATE} 0 -W 2>/dev/null)
#         mv wrfbdy_d${FR_DOMAIN} wrfbdy_d${FR_DOMAIN}_$(${BUILD_DIR}/da_advance_time.exe ${P_DATE} 0 -W 2>/dev/null)
         export P_DATE=$(${BUILD_DIR}/da_advance_time.exe ${P_DATE} ${LBC_FREQ} 2>/dev/null) 
      done
   fi
#
#########################################################################
#
# RUN INTERPOLATION TO GET MISSING BACKGROUND DATA
#
#########################################################################
#
   if [[ ${RUN_INTERPOLATE} = "true" ]]; then 
      if [[ ! -d ${RUN_DIR}/${DATE}/metgrid ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/metgrid
      fi
      if [[ ! -d ${RUN_DIR}/${DATE}/real ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/real
      fi
#
# GET METGRID DATA
      cd ${RUN_DIR}/${DATE}/metgrid
      rm -rf met_em.d*
#
# LINK IN THE BACK AND FORW METGRID FILES
      export P_DATE=${BACK_DATE}
      export P_END_DATE=$(${BUILD_DIR}/da_advance_time.exe ${P_DATE} ${LBC_END} 2>/dev/null)
      while [[ ${P_DATE} -le ${P_END_DATE} ]] ; do
         export P_YYYY=$(echo $P_DATE | cut -c1-4)
         export P_MM=$(echo $P_DATE | cut -c5-6)
         export P_DD=$(echo $P_DATE | cut -c7-8)
         export P_HH=$(echo $P_DATE | cut -c9-10)
         export P_FILE_DATE=${P_YYYY}-${P_MM}-${P_DD}_${P_HH}:00:00.nc
         ln -sf ${RUN_DIR}/${BACK_DATE}/metgrid/met_em.d${CR_DOMAIN}.${P_FILE_DATE} ./BK_met_em.d${CR_DOMAIN}.${P_FILE_DATE}
         ln -sf ${RUN_DIR}/${BACK_DATE}/metgrid/met_em.d${FR_DOMAIN}.${P_FILE_DATE} ./BK_met_em.d${FR_DOMAIN}.${P_FILE_DATE}
         export P_DATE=$(${BUILD_DIR}/da_advance_time.exe ${P_DATE} ${LBC_FREQ} 2>/dev/null) 
      done
      export P_DATE=${FORW_DATE}
      export P_END_DATE=$(${BUILD_DIR}/da_advance_time.exe ${P_DATE} ${LBC_END} 2>/dev/null)
      while [[ ${P_DATE} -le ${P_END_DATE} ]] ; do
         export P_YYYY=$(echo $P_DATE | cut -c1-4)
         export P_MM=$(echo $P_DATE | cut -c5-6)
         export P_DD=$(echo $P_DATE | cut -c7-8)
         export P_HH=$(echo $P_DATE | cut -c9-10)
         export P_FILE_DATE=${P_YYYY}-${P_MM}-${P_DD}_${P_HH}:00:00.nc
         ln -sf ${RUN_DIR}/${FORW_DATE}/metgrid/met_em.d${CR_DOMAIN}.${P_FILE_DATE} ./FW_met_em.d${CR_DOMAIN}.${P_FILE_DATE}
         ln -sf ${RUN_DIR}/${FORW_DATE}/metgrid/met_em.d${FR_DOMAIN}.${P_FILE_DATE} ./FW_met_em.d${FR_DOMAIN}.${P_FILE_DATE}
         export P_DATE=$(${BUILD_DIR}/da_advance_time.exe ${P_DATE} ${LBC_FREQ} 2>/dev/null) 
      done
#
# DO INTERPOLATION
      export P_DATE=${DATE}
      export P_BACK_DATE=${BACK_DATE}
      export P_FORW_DATE=${FORW_DATE}
      export P_END_DATE=$(${BUILD_DIR}/da_advance_time.exe ${P_DATE} ${LBC_END} 2>/dev/null)
      while [[ ${P_DATE} -le ${P_END_DATE} ]] ; do
         export P_YYYY=$(echo $P_DATE | cut -c1-4)
         export P_MM=$(echo $P_DATE | cut -c5-6)
         export P_DD=$(echo $P_DATE | cut -c7-8)
         export P_HH=$(echo $P_DATE | cut -c9-10)
         export P_FILE_DATE=${P_YYYY}-${P_MM}-${P_DD}_${P_HH}:00:00
         export P_BK_YYYY=$(echo $P_BACK_DATE | cut -c1-4)
         export P_BK_MM=$(echo $P_BACK_DATE | cut -c5-6)
         export P_BK_DD=$(echo $P_BACK_DATE | cut -c7-8)
         export P_BK_HH=$(echo $P_BACK_DATE | cut -c9-10)
         export P_BACK_FILE_DATE=${P_BK_YYYY}-${P_BK_MM}-${P_BK_DD}_${P_BK_HH}:00:00
         export P_FW_YYYY=$(echo $P_FORW_DATE | cut -c1-4)
         export P_FW_MM=$(echo $P_FORW_DATE | cut -c5-6)
         export P_FW_DD=$(echo $P_FORW_DATE | cut -c7-8)
         export P_FW_HH=$(echo $P_FORW_DATE | cut -c9-10)
         export P_FORW_FILE_DATE=${P_FW_YYYY}-${P_FW_MM}-${P_FW_DD}_${P_FW_HH}:00:00
         export BACK_FILE_CR=BK_met_em.d${CR_DOMAIN}.${P_BACK_FILE_DATE}.nc
         export BACK_FILE_FR=BK_met_em.d${FR_DOMAIN}.${P_BACK_FILE_DATE}.nc
         export FORW_FILE_CR=FW_met_em.d${CR_DOMAIN}.${P_FORW_FILE_DATE}.nc
         export FORW_FILE_FR=FW_met_em.d${FR_DOMAIN}.${P_FORW_FILE_DATE}.nc
         export OUTFILE_CR=met_em.d${CR_DOMAIN}.${P_FILE_DATE}.nc
         export OUTFILE_FR=met_em.d${FR_DOMAIN}.${P_FILE_DATE}.nc
         export TIME_INTERP_DIR1=${DART_DIR}/
         export TIME_INTERP_DIR2=apm_run_scripts/RUN_TIME_INTERP/work
         export FIX_TIME_FILE=${TIME_INTERP_DIR1}/${TIME_INTERP_DIR2}/fix_time_stamp.exe
         export NUM_FIX_DATES=1
         cp ${FIX_TIME_FILE} ./.
#
# CREATE NAMELIST
         rm -rf time_stamp_nml.nl
         cat << EOF > time_stamp_nml.nl
&time_stamp_nml
time_str1='${P_FILE_DATE}'
file_str='${OUTFILE_CR}'
num_dates=${NUM_FIX_DATES}
file_sw=0
/
EOF
         ncflint -w ${BACK_WT} ${BACK_FILE_CR} ${FORW_FILE_CR} ${OUTFILE_CR}
         ./fix_time_stamp.exe
#
# CREATE NAMELIST
         rm -rf time_stamp_nml.nl
         cat << EOF > time_stamp_nml.nl
&time_stamp_nml
time_str1='${P_FILE_DATE}'
file_str='${OUTFILE_FR}'
num_dates=${NUM_FIX_DATES}
file_sw=0
/
EOF
         ncflint -w ${BACK_WT} ${BACK_FILE_FR} ${FORW_FILE_FR} ${OUTFILE_FR}
         ./fix_time_stamp.exe
         export P_BACK_DATE=$(${BUILD_DIR}/da_advance_time.exe ${P_BACK_DATE} ${LBC_FREQ} 2>/dev/null) 
         export P_FORW_DATE=$(${BUILD_DIR}/da_advance_time.exe ${P_FORW_DATE} ${LBC_FREQ} 2>/dev/null) 
         export P_DATE=$(${BUILD_DIR}/da_advance_time.exe ${P_DATE} ${LBC_FREQ} 2>/dev/null) 
      done
#
# GET REAL DATA
      cd ${RUN_DIR}/${DATE}/real
      rm -rf wrfbdy_d*
      rm -rf wrfinput_d*
#
# LINK IN THE BACK AND FORW WRFBDY AND WRFINPUT FILES
      export P_DATE=${BACK_DATE}
      export P_END_DATE=$(${BUILD_DIR}/da_advance_time.exe ${P_DATE} ${FCST_PERIOD} 2>/dev/null)
      while [[ ${P_DATE} -le ${P_END_DATE} ]] ; do
         export P_YYYY=$(echo $P_DATE | cut -c1-4)
         export P_MM=$(echo $P_DATE | cut -c5-6)
         export P_DD=$(echo $P_DATE | cut -c7-8)
         export P_HH=$(echo $P_DATE | cut -c9-10)
         export P_FILE_DATE=${P_YYYY}-${P_MM}-${P_DD}_${P_HH}:00:00
         ln -sf ${RUN_DIR}/${BACK_DATE}/real/wrfbdy_d${CR_DOMAIN}_${P_FILE_DATE} ./BK_wrfbdy_d${CR_DOMAIN}_${P_FILE_DATE}
         ln -sf ${RUN_DIR}/${BACK_DATE}/real/wrfinput_d${CR_DOMAIN}_${P_FILE_DATE} ./BK_wrfinput_d${CR_DOMAIN}_${P_FILE_DATE}
         ln -sf ${RUN_DIR}/${BACK_DATE}/real/wrfinput_d${FR_DOMAIN}_${P_FILE_DATE} ./BK_wrfinput_d${FR_DOMAIN}_${P_FILE_DATE}
         export P_DATE=$(${BUILD_DIR}/da_advance_time.exe ${P_DATE} ${LBC_FREQ} 2>/dev/null) 
      done
      export P_DATE=${FORW_DATE}
      export P_END_DATE=$(${BUILD_DIR}/da_advance_time.exe ${P_DATE} ${FCST_PERIOD} 2>/dev/null)
      while [[ ${P_DATE} -le ${P_END_DATE} ]] ; do
         export P_YYYY=$(echo $P_DATE | cut -c1-4)
         export P_MM=$(echo $P_DATE | cut -c5-6)
         export P_DD=$(echo $P_DATE | cut -c7-8)
         export P_HH=$(echo $P_DATE | cut -c9-10)
         export P_FILE_DATE=${P_YYYY}-${P_MM}-${P_DD}_${P_HH}:00:00
         ln -sf ${RUN_DIR}/${FORW_DATE}/real/wrfbdy_d${CR_DOMAIN}_${P_FILE_DATE} ./FW_wrfbdy_d${CR_DOMAIN}_${P_FILE_DATE}
         ln -sf ${RUN_DIR}/${FORW_DATE}/real/wrfinput_d${CR_DOMAIN}_${P_FILE_DATE} ./FW_wrfinput_d${CR_DOMAIN}_${P_FILE_DATE}
         ln -sf ${RUN_DIR}/${FORW_DATE}/real/wrfinput_d${FR_DOMAIN}_${P_FILE_DATE} ./FW_wrfinput_d${FR_DOMAIN}_${P_FILE_DATE}
         export P_DATE=$(${BUILD_DIR}/da_advance_time.exe ${P_DATE} ${LBC_FREQ} 2>/dev/null) 
      done
#
# DO INTERPOLATION
      export P_DATE=${DATE}
      export P_BACK_DATE=${BACK_DATE}
      export P_FORW_DATE=${FORW_DATE}
      export P_END_DATE=$(${BUILD_DIR}/da_advance_time.exe ${P_DATE} ${FCST_PERIOD} 2>/dev/null)
      while [[ ${P_DATE} -le ${P_END_DATE} ]] ; do
         export P_YYYY=$(echo $P_DATE | cut -c1-4)
         export P_MM=$(echo $P_DATE | cut -c5-6)
         export P_DD=$(echo $P_DATE | cut -c7-8)
         export P_HH=$(echo $P_DATE | cut -c9-10)
         export P_FILE_DATE=${P_YYYY}-${P_MM}-${P_DD}_${P_HH}:00:00
         export P_BK_YYYY=$(echo $P_BACK_DATE | cut -c1-4)
         export P_BK_MM=$(echo $P_BACK_DATE | cut -c5-6)
         export P_BK_DD=$(echo $P_BACK_DATE | cut -c7-8)
         export P_BK_HH=$(echo $P_BACK_DATE | cut -c9-10)
         export P_BACK_FILE_DATE=${P_BK_YYYY}-${P_BK_MM}-${P_BK_DD}_${P_BK_HH}:00:00
         export P_FW_YYYY=$(echo $P_FORW_DATE | cut -c1-4)
         export P_FW_MM=$(echo $P_FORW_DATE | cut -c5-6)
         export P_FW_DD=$(echo $P_FORW_DATE | cut -c7-8)
         export P_FW_HH=$(echo $P_FORW_DATE | cut -c9-10)
         export P_FORW_FILE_DATE=${P_FW_YYYY}-${P_FW_MM}-${P_FW_DD}_${P_FW_HH}:00:00
         export BACK_BDYF_CR=BK_wrfbdy_d${CR_DOMAIN}_${P_BACK_FILE_DATE}
         export BACK_FILE_CR=BK_wrfinput_d${CR_DOMAIN}_${P_BACK_FILE_DATE}
         export BACK_FILE_FR=BK_wrfinput_d${FR_DOMAIN}_${P_BACK_FILE_DATE}
         export FORW_BDYF_CR=FW_wrfbdy_d${CR_DOMAIN}_${P_FORW_FILE_DATE}
         export FORW_FILE_CR=FW_wrfinput_d${CR_DOMAIN}_${P_FORW_FILE_DATE}
         export FORW_FILE_FR=FW_wrfinput_d${FR_DOMAIN}_${P_FORW_FILE_DATE}
         export BDYFILE_CR=wrfbdy_d${CR_DOMAIN}_${P_FILE_DATE}
         export OUTFILE_CR=wrfinput_d${CR_DOMAIN}_${P_FILE_DATE}
         export OUTFILE_FR=wrfinput_d${FR_DOMAIN}_${P_FILE_DATE}
         export TIME_INTERP_DIR1=${DART_DIR}/
         export TIME_INTERP_DIR2=apm_run_scripts/RUN_TIME_INTERP/work
         export FIX_TIME_FILE=${TIME_INTERP_DIR1}/${TIME_INTERP_DIR2}/fix_time_stamp.exe
         let NUM_FIX_DATES=${FCST_PERIOD}/${LBC_FREQ}
         ((FX_IDX=0)) 
         export STR_FXDT=${P_DATE}
         export END_FXDT=$(${BUILD_DIR}/da_advance_time.exe ${STR_FXDT} ${FCST_PERIOD} 2>/dev/null)
         while [[ ${STR_FXDT} -le ${END_FXDT} ]] ; do
            export FX_YYYY=$(echo $STR_FXDT | cut -c1-4)
            export FX_MM=$(echo $STR_FXDT | cut -c5-6)
            export FX_DD=$(echo $STR_FXDT | cut -c7-8)
            export FX_HH=$(echo $STR_FXDT | cut -c9-10)
            export FX_FILE_DATE[${FX_IDX}]=${FX_YYYY}-${FX_MM}-${FX_DD}_${FX_HH}:00:00
            let FX_IDX=${FX_IDX}+1
            export STR_FXDT=$(${BUILD_DIR}/da_advance_time.exe ${STR_FXDT} ${LBC_FREQ} 2>/dev/null)
         done
         ((FX_IDX=0)) 
         export STR_FXDT=$(${BUILD_DIR}/da_advance_time.exe ${P_DATE} ${LBC_FREQ} 2>/dev/null)
         export END_FXDT=$(${BUILD_DIR}/da_advance_time.exe ${STR_FXDT} ${FCST_PERIOD} 2>/dev/null)
         while [[ ${STR_FXDT} -le ${END_FXDT} ]] ; do
            export FX_YYYY=$(echo $STR_FXDT | cut -c1-4)
            export FX_MM=$(echo $STR_FXDT | cut -c5-6)
            export FX_DD=$(echo $STR_FXDT | cut -c7-8)
            export FX_HH=$(echo $STR_FXDT | cut -c9-10)
            export FX_FILE_NEXT_DATE[${FX_IDX}]=${FX_YYYY}-${FX_MM}-${FX_DD}_${FX_HH}:00:00
            let FX_IDX=${FX_IDX}+1
            export STR_FXDT=$(${BUILD_DIR}/da_advance_time.exe ${STR_FXDT} ${LBC_FREQ} 2>/dev/null)
         done
         cp ${FIX_TIME_FILE} ./.
#
# CREATE NAMELIST
         rm -rf time_stamp_nml.nl
         cat << EOF > time_stamp_nml.nl
&time_stamp_nml
time_str1='${FX_FILE_DATE[0]}'
time_str2='${FX_FILE_DATE[1]}'
time_this_str1='${FX_FILE_DATE[0]}'
time_this_str2='${FX_FILE_DATE[1]}'
time_next_str1='${FX_FILE_NEXT_DATE[0]}'
time_next_str2='${FX_FILE_NEXT_DATE[1]}'
file_str='${BDYFILE_CR}'
num_dates=${NUM_FIX_DATES}
file_sw=1
/
EOF
         ncflint -w ${BACK_WT} ${BACK_BDYF_CR} ${FORW_BDYF_CR} ${BDYFILE_CR}
         ./fix_time_stamp.exe
         export TIME_INTERP_DIR1=${DART_DIR}/
         export TIME_INTERP_DIR2=apm_run_scripts/RUN_TIME_INTERP/work
         export FIX_TIME_FILE=${TIME_INTERP_DIR1}/${TIME_INTERP_DIR2}/fix_time_stamp.exe
         cp ${FIX_TIME_FILE} ./.
#
# CREATE NAMELIST
         rm -rf time_stamp_nml.nl
         cat << EOF > time_stamp_nml.nl
&time_stamp_nml
time_str1='${FX_FILE_DATE[0]}'
time_str2='${FX_FILE_DATE[1]}'
time_this_str1='${FX_FILE_DATE[0]}'
time_this_str2='${FX_FILE_DATE[1]}'
time_next_str1='${FX_FILE_NEXT_DATE[0]}'
time_next_str2='${FX_FILE_NEXT_DATE[1]}'
file_str='${OUTFILE_CR}'
num_dates=${NUM_FIX_DATES}
file_sw=0
/
EOF
         ncflint -w ${BACK_WT} ${BACK_FILE_CR} ${FORW_FILE_CR} ${OUTFILE_CR}
         ./fix_time_stamp.exe
         export TIME_INTERP_DIR1=${DART_DIR}/
         export TIME_INTERP_DIR2=apm_run_scripts/RUN_TIME_INTERP/work
         export FIX_TIME_FILE=${TIME_INTERP_DIR1}/${TIME_INTERP_DIR2}/fix_time_stamp.exe
         cp ${FIX_TIME_FILE} ./.
#
# CREATE NAMELIST
         rm -rf time_stamp_nml.nl
         cat << EOF > time_stamp_nml.nl
&time_stamp_nml
time_str1='${FX_FILE_DATE[0]}'
time_str2='${FX_FILE_DATE[1]}'
time_this_str1='${FX_FILE_DATE[0]}'
time_this_str2='${FX_FILE_DATE[1]}'
time_next_str1='${FX_FILE_NEXT_DATE[0]}'
time_next_str2='${FX_FILE_NEXT_DATE[1]}'
file_str='${OUTFILE_FR}'
num_dates=${NUM_FIX_DATES}
file_sw=0
/
EOF
         ncflint -w ${BACK_WT} ${BACK_FILE_FR} ${FORW_FILE_FR} ${OUTFILE_FR}
         ./fix_time_stamp.exe
         export P_BACK_DATE=$(${BUILD_DIR}/da_advance_time.exe ${P_BACK_DATE} ${LBC_FREQ} 2>/dev/null) 
         export P_FORW_DATE=$(${BUILD_DIR}/da_advance_time.exe ${P_FORW_DATE} ${LBC_FREQ} 2>/dev/null) 
         export P_DATE=$(${BUILD_DIR}/da_advance_time.exe ${P_DATE} ${LBC_FREQ} 2>/dev/null) 
      done
   exit
   fi
#
#########################################################################
#
# RUN PERT_WRFCHEM_MET_IC
#
#########################################################################
#
   if [[ ${RUN_PERT_WRFCHEM_MET_IC} = "true" ]]; then 
      if [[ ! -d ${RUN_DIR}/${DATE}/wrfchem_met_ic ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/wrfchem_met_ic
         cd ${RUN_DIR}/${DATE}/wrfchem_met_ic
      else
         cd ${RUN_DIR}/${DATE}/wrfchem_met_ic
      fi
#
      export NL_MAX_DOM=1
      export NL_OB_FORMAT=1
      export L_FCST_RANGE=${FCST_PERIOD}
      export L_START_DATE=${DATE}
      export L_END_DATE=$($BUILD_DIR/da_advance_time.exe ${L_START_DATE} ${L_FCST_RANGE} 2>/dev/null)
      export L_START_YEAR=$(echo $L_START_DATE | cut -c1-4)
      export L_START_MONTH=$(echo $L_START_DATE | cut -c5-6)
      export L_START_DAY=$(echo $L_START_DATE | cut -c7-8)
      export L_START_HOUR=$(echo $L_START_DATE | cut -c9-10)
      export L_END_YEAR=$(echo $L_END_DATE | cut -c1-4)
      export L_END_MONTH=$(echo $L_END_DATE | cut -c5-6)
      export L_END_DAY=$(echo $L_END_DATE | cut -c7-8)
      export L_END_HOUR=$(echo $L_END_DATE | cut -c9-10)
      export NL_START_YEAR=$(echo $L_START_DATE | cut -c1-4),$(echo $L_START_DATE | cut -c1-4)
      export NL_START_MONTH=$(echo $L_START_DATE | cut -c5-6),$(echo $L_START_DATE | cut -c5-6)
      export NL_START_DAY=$(echo $L_START_DATE | cut -c7-8),$(echo $L_START_DATE | cut -c7-8)
      export NL_START_HOUR=$(echo $L_START_DATE | cut -c9-10),$(echo $L_START_DATE | cut -c9-10)
      export NL_END_YEAR=$(echo $L_END_DATE | cut -c1-4),$(echo $L_END_DATE | cut -c1-4)
      export NL_END_MONTH=$(echo $L_END_DATE | cut -c5-6),$(echo $L_END_DATE | cut -c5-6)
      export NL_END_DAY=$(echo $L_END_DATE | cut -c7-8),$(echo $L_END_DATE | cut -c7-8)
      export NL_END_HOUR=$(echo $L_END_DATE | cut -c9-10),$(echo $L_END_DATE | cut -c9-10)
      export NL_START_DATE=\'${L_START_YEAR}-${L_START_MONTH}-${L_START_DAY}_${L_START_HOUR}:00:00\',\'${L_START_YEAR}-${L_START_MONTH}-${L_START_DAY}_${L_START_HOUR}:00:00\'
      export NL_END_DATE=\'${L_END_YEAR}-${L_END_MONTH}-${L_END_DAY}_${L_END_HOUR}:00:00\',\'${L_END_YEAR}-${L_END_MONTH}-${L_END_DAY}_${L_END_HOUR}:00:00\'
#
# LOOP THROUGH ALL BDY TENDENCY TIMES
      export P_DATE=${DATE}
      export P_END_DATE=$(${BUILD_DIR}/da_advance_time.exe ${P_DATE} ${FCST_PERIOD} 2>/dev/null)
      while [[ ${P_DATE} -le ${P_END_DATE} ]] ; do
         export L_YYYY=$(echo $P_DATE | cut -c1-4)
         export L_MM=$(echo $P_DATE | cut -c5-6)
         export L_DD=$(echo $P_DATE | cut -c7-8)
         export L_HH=$(echo $P_DATE | cut -c9-10)
         if [[ ${L_HH} -ge 00 && ${L_HH} -lt 06 ]]; then export L_HH=00; fi
         if [[ ${L_HH} -ge 06 && ${L_HH} -lt 12 ]]; then export L_HH=06; fi
         if [[ ${L_HH} -ge 12 && ${L_HH} -lt 18 ]]; then export L_HH=12; fi
         if [[ ${L_HH} -ge 18 && ${L_HH} -lt 24 ]]; then export L_HH=18; fi
#
# SET WRFDA PARAMETERS
         export ANALYSIS_DATE=$(${BUILD_DIR}/da_advance_time.exe ${P_DATE} 0 -W 2>/dev/null)
         export NL_ANALYSIS_DATE=\'${ANALYSIS_DATE}\'
         export NL_TIME_WINDOW_MIN=\'$(${BUILD_DIR}/da_advance_time.exe ${P_DATE} -${ASIM_WINDOW} -W 2>/dev/null)\'
         export NL_TIME_WINDOW_MAX=\'$(${BUILD_DIR}/da_advance_time.exe ${P_DATE} +${ASIM_WINDOW} -W 2>/dev/null)\'
         export NL_ANALYSIS_TYPE=\'RANDOMCV\'
         export NL_PUT_RAND_SEED=true
#
# LOOP THROUGH ALL MEMBERS IN THE ENSEMBLE
         TRANDOM=$$
         let MEM=1
         while [[ ${MEM} -le ${NUM_MEMBERS} ]]; do
            export CMEM=e${MEM}
            if [[ ${MEM} -lt 100 ]]; then export CMEM=e0${MEM}; fi
            if [[ ${MEM} -lt 10  ]]; then export CMEM=e00${MEM}; fi
#
# COARSE RESOLUTION GRID
            cd ${RUN_DIR}/${DATE}/wrfchem_met_ic
            export LCR_DIR=wrfda_cr_${MEM}
            if [[ ! -e ${LCR_DIR} ]]; then
               mkdir ${LCR_DIR}
               cd ${LCR_DIR}
            else
               cd ${LCR_DIR}
               rm -rf *
            fi
            export NL_E_WE=${NNXP_STAG_CR}
            export NL_E_SN=${NNYP_STAG_CR}
            export NL_DX=${DX_CR}
            export NL_DY=${DX_CR}
            export NL_GRID_ID=1
            export NL_PARENT_ID=0
            export NL_PARENT_GRID_RATIO=1
            export NL_I_PARENT_START=${ISTR_CR}
            export NL_J_PARENT_START=${JSTR_CR}
            export DA_INPUT_FILE=../../real/wrfinput_d${CR_DOMAIN}_${ANALYSIS_DATE}
            export NL_SEED_ARRAY1=$(${BUILD_DIR}/da_advance_time.exe ${DATE} 0 -f hhddmmyycc)
            export NL_SEED_ARRAY2=`echo ${MEM} \* 100000 | bc -l `
            ${NAMELIST_SCRIPTS_DIR}/MISC/da_create_wrfda_namelist_v4.ksh
            cp ${EXPERIMENT_PREPBUFR_DIR}/${DATE}/prepbufr.gdas.${DATE}.wo40.be ob.bufr
            cp ${DA_INPUT_FILE} fg
            cp ${BE_DIR}/be.dat.cv3 be.dat
            cp ${WRFDA_DIR}/run/LANDUSE.TBL ./.
            cp ${WRFDA_DIR}/var/da/da_wrfvar.exe ./.
#
#            RANDOM=$$
            export JOBRND=${TRANDOM}_wrfda_cr
#            ${JOB_CONTROL_SCRIPTS_DIR}/job_script_nasa.ksh ${JOBRND} ${WRFDA_JOB_CLASS} ${WRFDA_TIME_LIMIT} ${WRFDA_NODES} ${WRFDA_TASKS} da_wrfvar.exe SERIAL ${ACCOUNT}
#            qsub job.ksh
            chmod +x da_wrfvar.exe
            ./da_wrfvar.exe > index.html 2>&1
#
# FINE RESOLUTION GRID
#            cd ${RUN_DIR}/${DATE}/wrfchem_met_ic
#            export LFR_DIR=wrfda_fr_${MEM}
#            if [[ ! -e ${LFR_DIR} ]]; then
#               mkdir ${LFR_DIR}
#               cd ${LFR_DIR}
#            else
#               cd ${LFR_DIR}
#               rm -rf *
#            fi
#            export NL_E_WE=${NNXP_STAG_FR}
#            export NL_E_SN=${NNYP_STAG_FR}
#            export NL_DX=${DX_FR}
#            export NL_DY=${DX_FR}
#            export NL_GRID_ID=2
#            export NL_PARENT_ID=1
#            export NL_PARENT_GRID_RATIO=5
#            export NL_I_PARENT_START=${ISTR_FR}
#            export NL_J_PARENT_START=${JSTR_FR}
#            export DA_INPUT_FILE=../../real/wrfinput_d${FR_DOMAIN}_${ANALYSIS_DATE}
#            ${NAMELIST_SCRIPTS_DIR}/MISC/da_create_wrfda_namelist_v4.ksh
#            cp ${EXPERIMENT_PREPBUFR_DIR}/${DATE}/prepbufr.gdas.${DATE}.wo40.be ob.bufr
#            cp ${DA_INPUT_FILE} fg
#            cp ${BE_DIR}/be.dat.cv3 be.dat
#            cp ${WRFDA_DIR}/run/LANDUSE.TBL ./.
#            cp ${WRFDA_DIR}/var/da/da_wrfvar.exe ./.
#   
#            RANDOM=$$
#            export JOBRND=${TRANDOM}_wrfda_fr
#            ${JOB_CONTROL_SCRIPTS_DIR}/job_script_nasa.ksh ${JOBRND} ${WRFDA_JOB_CLASS} ${WRFDA_TIME_LIMIT} ${WRFDA_NODES} ${WRFDA_TASKS} da_wrfvar.exe SERIAL ${ACCOUNT}
#            qsub job.ksh
            let MEM=${MEM}+1
         done
#
# Wait for WRFDA to complete for all members
         cd ${RUN_DIR}/${DATE}/wrfchem_met_ic
         ${JOB_CONTROL_SCRIPTS_DIR}/da_run_hold_nasa.ksh ${TRANDOM}
#
         let MEM=1
         while [[ ${MEM} -le ${NUM_MEMBERS} ]]; do
            export CMEM=e${MEM}
            if [[ ${MEM} -lt 100 ]]; then export CMEM=e0${MEM}; fi
            if [[ ${MEM} -lt 10  ]]; then export CMEM=e00${MEM}; fi
            export LCR_DIR=wrfda_cr_${MEM}
            export LFR_DIR=wrfda_fr_${MEM}
            if [[ -e ${LCR_DIR}/wrfvar_output ]]; then
               cp ${LCR_DIR}/wrfvar_output wrfinput_d${CR_DOMAIN}_${ANALYSIS_DATE}.${CMEM}
            else
               sleep 45
               cp ${LCR_DIR}/wrfvar_output wrfinput_d${CR_DOMAIN}_${ANALYSIS_DATE}.${CMEM}
            fi 
#            if [[ -e ${LFR_DIR}/wrfvar_output ]]; then
#               cp ${LFR_DIR}/wrfvar_output wrfinput_d${FR_DOMAIN}_${ANALYSIS_DATE}.${CMEM}
#            else
#               sleep 45
#               cp ${LFR_DIR}/wrfvar_output wrfinput_d${FR_DOMAIN}_${ANALYSIS_DATE}.${CMEM}
#            fi
            let MEM=${MEM}+1
         done
#
# Chia-Hua Recentering Fix
# Ensemble mean
         ncea -O -n ${NUM_MEMBERS},3,1 wrfinput_d${CR_DOMAIN}_${ANALYSIS_DATE}'.e001' ens_mean
#
# Mean difference
         ncdiff -O ens_mean ${RUN_DIR}/${DATE}/real/wrfinput_d${CR_DOMAIN}_${ANALYSIS_DATE}  mean_diff
#
# Recenter each member
         let MEM=1
         while [[ ${MEM} -le ${NUM_MEMBERS} ]]; do
            export CMEM=e${MEM}
            if [[ ${MEM} -lt 100 ]]; then export CMEM=e0${MEM}; fi
            if [[ ${MEM} -lt 10  ]]; then export CMEM=e00${MEM}; fi
            ncdiff -O wrfinput_d${CR_DOMAIN}_${ANALYSIS_DATE}.${CMEM} mean_diff mem.${CMEM}
            mv mem.${CMEM} wrfinput_d${CR_DOMAIN}_${ANALYSIS_DATE}.${CMEM}
            let MEM=${MEM}+1
         done
         ncea -O -n ${NUM_MEMBERS},3,1 wrfinput_d${CR_DOMAIN}_${ANALYSIS_DATE}'.e001'  wrfinput_d${CR_DOMAIN}_${ANALYSIS_DATE}_new_mean
         rm ens_mean
         rm mean_diff
# End Recentering Fix
#	 
	 export P_DATE=$(${BUILD_DIR}/da_advance_time.exe ${P_DATE} ${LBC_FREQ} 2>/dev/null) 
      done
      export NL_E_WE=${NNXP_STAG_CR},${NNXP_STAG_FR}
      export NL_E_SN=${NNYP_STAG_CR},${NNYP_STAG_FR}
      export NL_DX=${DX_CR},${DX_FR}
      export NL_DY=${DX_CR},${DX_FR}
      export NL_GRID_ID=1,2
      export NL_PARENT_ID=0,1
      export NL_PARENT_GRID_RATIO=1,5
      export NL_I_PARENT_START=${ISTR_CR},${ISTR_FR}
      export NL_J_PARENT_START=${JSTR_CR},${JSTR_FR}
   fi
#
#########################################################################
#
# RUN PERT WRFCHEM MET BC
#
#########################################################################
#
   if [[ ${RUN_PERT_WRFCHEM_MET_BC} = "true" ]]; then 
      if [[ ! -d ${RUN_DIR}/${DATE}/wrfchem_met_bc ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/wrfchem_met_bc
         cd ${RUN_DIR}/${DATE}/wrfchem_met_bc
      else
         cd ${RUN_DIR}/${DATE}/wrfchem_met_bc
      fi
#
# LOOP THROUGH ALL MEMBERS IN THE ENSEMBLE
      let MEM=1
      while [[ ${MEM} -le ${NUM_MEMBERS} ]]; do
         export CMEM=e${MEM}
         if [[ ${MEM} -lt 100 ]]; then export CMEM=e0${MEM}; fi
         if [[ ${MEM} -lt 10  ]]; then export CMEM=e00${MEM}; fi
         export ANALYSIS_DATE=$(${BUILD_DIR}/da_advance_time.exe ${DATE} 0 -W 2>/dev/null)
         rm -rf wrfbdy_this
         export DA_BDY_PATH=${RUN_DIR}/${DATE}/real
         export DA_BDY_FILE=${DA_BDY_PATH}/wrfbdy_d${CR_DOMAIN}_${ANALYSIS_DATE}
         cp ${DA_BDY_FILE} wrfbdy_this
         rm -rf pert_wrf_bc
         cp ${WRFCHEM_DART_WORK_DIR}/pert_wrf_bc ./.
         rm -rf input.nml
         ${NAMELIST_SCRIPTS_DIR}/DART/dart_create_input.nml.ksh
#
# LOOP THROUGH ALL BDY TENDENCY TIMES FOR THIS MEMBER.
         export L_DATE=${DATE}
         export L_END_DATE=$(${BUILD_DIR}/da_advance_time.exe ${L_DATE} ${FCST_PERIOD} 2>/dev/null)
         TRANDOM=$$
         while [[ ${L_DATE} -lt ${L_END_DATE} ]]; do
            rm -rf wrfinput_this_*
            rm -rf wrfinput_next_*
            export ANALYSIS_DATE=$(${BUILD_DIR}/da_advance_time.exe ${L_DATE} 0 -W 2>/dev/null)
            export NEXT_L_DATE=$(${BUILD_DIR}/da_advance_time.exe ${L_DATE} ${LBC_FREQ} 2>/dev/null)
            export NEXT_ANALYSIS_DATE=$(${BUILD_DIR}/da_advance_time.exe ${L_DATE} ${LBC_FREQ} -W 2>/dev/null)
            export DA_INPUT_PATH=${RUN_DIR}/${DATE}/wrfchem_met_ic
            ln -fs ${DA_INPUT_PATH}/wrfinput_d${CR_DOMAIN}_${ANALYSIS_DATE}.${CMEM} wrfinput_this_${L_DATE} 
            ln -fs ${DA_INPUT_PATH}/wrfinput_d${CR_DOMAIN}_${NEXT_ANALYSIS_DATE}.${CMEM} wrfinput_next_${L_DATE} 
#
# Create pert_wrf_bc namelist
            rm -rf pert_wrf_bc_nml.nl
            cat << EOF > pert_wrf_bc_nml.nl
&pert_wrf_bc_nml
wrfbdy_this_file='wrfbdy_this'
wrfinput_this_file='wrfinput_this_${L_DATE}'
wrfinput_next_file='wrfinput_next_${L_DATE}'
/
EOF
            export JOBRND=${TRANDOM}_pert_bc
#            ${JOB_CONTROL_SCRIPTS_DIR}/job_script_nasa.ksh ${JOBRND} ${SINGLE_JOB_CLASS} ${SINGLE_TIME_LIMIT} ${SINGLE_NODES} ${SINGLE_TASKS} pert_wrf_bc SERIAL ${ACCOUNT}
#            qsub -Wblock=true job.ksh
            chmod +x pert_wrf_bc
            ./pert_wrf_bc > index.html 2>&1
            export L_DATE=${NEXT_L_DATE} 
         done
         ${JOB_CONTROL_SCRIPTS_DIR}/da_run_hold_nasa.ksh ${TRANDOM}
         export ANALYSIS_DATE=$(${BUILD_DIR}/da_advance_time.exe ${DATE} 0 -W 2>/dev/null)
         mv wrfbdy_this wrfbdy_d${CR_DOMAIN}_${ANALYSIS_DATE}.${CMEM}
         let MEM=${MEM}+1
      done
#
# Chia-Hua Recentering Fix
# Ensemble mean
      ncea -O -n ${NUM_MEMBERS},3,1 wrfbdy_d${CR_DOMAIN}_${ANALYSIS_DATE}'.e001' ens_mean
#
# Mean difference
      ncdiff -O ens_mean ${RUN_DIR}/${DATE}/real/wrfbdy_d${CR_DOMAIN}_${ANALYSIS_DATE}  mean_diff
#
# Recenter each member
      let MEM=1
      while [[ ${MEM} -le ${NUM_MEMBERS} ]]; do
         export CMEM=e${MEM}
         if [[ ${MEM} -lt 100 ]]; then export CMEM=e0${MEM}; fi
         if [[ ${MEM} -lt 10  ]]; then export CMEM=e00${MEM}; fi
         ncdiff -O wrfbdy_d${CR_DOMAIN}_${ANALYSIS_DATE}.${CMEM} mean_diff mem.${CMEM}
         mv mem.${CMEM} wrfbdy_d${CR_DOMAIN}_${ANALYSIS_DATE}.${CMEM}
         let MEM=${MEM}+1
      done
      ncea -O -n ${NUM_MEMBERS},3,1 wrfbdy_d${CR_DOMAIN}_${ANALYSIS_DATE}'.e001'  wrfbdy_d${CR_DOMAIN}_${ANALYSIS_DATE}_new_mean
      rm ens_mean
      rm mean_diff
# End Recentering Fix
#	 
   fi
#
#########################################################################
#
# RUN EXO_COLDENS
#
#########################################################################
#
   if ${RUN_EXO_COLDENS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/exo_coldens ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/exo_coldens
         cd ${RUN_DIR}/${DATE}/exo_coldens
      else
         cd ${RUN_DIR}/${DATE}/exo_coldens
      fi
#
# LINK NEEDED FILES
      export FILE_CR=wrfinput_d${CR_DOMAIN}
      export FILE_FR=wrfinput_d${FR_DOMAIN}
      rm -rf ${FILE_CR}
      rm -rf ${FILE_FR}
      ln -sf ${REAL_DIR}/${FILE_CR}_${FILE_DATE} ${FILE_CR}   
      ln -sf ${REAL_DIR}/${FILE_FR}_${FILE_DATE} ${FILE_FR}   
      export FILE=exo_coldens.nc
      rm -rf ${FILE}
      ln -sf ${EXPERIMENT_COLDENS_DIR}/${FILE} ${FILE}
      export FILE=exo_coldens.exe
      rm -rf ${FILE}
      ln -sf ${WES_COLDENS_DIR}/work/${FILE} ${FILE}
#
# CREATE INPUT FILE
      export FILE=exo_coldens.inp
      rm -rf ${FILE}
      cat << EOF > ${FILE}
&control
domains = 2,
/
EOF
#
# RUN exo_coldens
      rm -rf index.html
      chmod +x exo_coldens.exe
      ./exo_coldens.exe < exo_coldens.inp > index 2>&1
#
# TEST WHETHER OUTPUT EXISTS
      export FILE_CR=exo_coldens_d${CR_DOMAIN}
      export FILE_FR=exo_coldens_d${FR_DOMAIN}
      if [[ ! -e ${FILE_CR} || ! -e ${FILE_FR} ]]; then
         echo EXO_COLDENS FAILED
         exit
      else
         echo EXO_COLDENS SUCCESS
      fi
   fi
#
#########################################################################
#
# RUN SEASONS_WES
#
#########################################################################
#
   if ${RUN_SEASON_WES}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/seasons_wes ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/seasons_wes
         cd ${RUN_DIR}/${DATE}/seasons_wes
      else
         cd ${RUN_DIR}/${DATE}/seasons_wes
      fi
#
# LINK NEEDED FILES
      export FILE_CR=wrfinput_d${CR_DOMAIN}
      export FILE_FR=wrfinput_d${FR_DOMAIN}
      rm -rf ${FILE_CR}
      rm -rf ${FILE_FR}
      ln -sf ${REAL_DIR}/${FILE_CR}_${FILE_DATE} ${FILE_CR}   
      ln -sf ${REAL_DIR}/${FILE_FR}_${FILE_DATE} ${FILE_FR}   
      export FILE=season_wes_usgs.nc
      rm -rf ${FILE}
      ln -sf ${EXPERIMENT_COLDENS_DIR}/${FILE} ${FILE}
      export FILE=wesely.exe
      rm -rf ${FILE}
      ln -sf ${WES_COLDENS_DIR}/work/${FILE} ${FILE}
#
# CREATE INPUT FILE
      export FILE=wesely.inp
      rm -rf ${FILE}
      cat << EOF > ${FILE}
&control
domains = 2,
/
EOF
#
# RUN wesely
      rm -rf index.html
      chmod +x wesely.exe
      ./wesely.exe < wesely.inp > index.html 2>&1
#
# TEST WHETHER OUTPUT EXISTS
      export FILE_CR=wrf_season_wes_usgs_d${CR_DOMAIN}.nc
      export FILE_FR=wrf_season_wes_usgs_d${FR_DOMAIN}.nc
      if [[ ! -e ${FILE_CR} || ! -e ${FILE_FR} ]]; then
         echo WESELY FAILED
         exit
      else
         echo WESELY SUCCESS
      fi
   fi
#
#########################################################################
#
# RUN WRFCHEM_BIO
#
#########################################################################
#
   if ${RUN_WRFCHEM_BIO}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/wrfchem_bio ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/wrfchem_bio
         cd ${RUN_DIR}/${DATE}/wrfchem_bio
      else
         cd ${RUN_DIR}/${DATE}/wrfchem_bio
      fi
#
# LOOP THROUGHT CURRENT AND NEXT DATE
      export L_DATE=${DATE}
      export LE_DATE=$(${BUILD_DIR}/da_advance_time.exe ${L_DATE} ${FCST_PERIOD} 2>/dev/null)
      while [[ ${L_DATE} -le ${LE_DATE} ]]; do 
         export L_YYYY=$(echo $L_DATE | cut -c1-4)
         export L_MM=$(echo $L_DATE | cut -c5-6)
         export L_DD=$(echo $L_DATE | cut -c7-8)
         export L_HH=$(echo $L_DATE | cut -c9-10)
         export L_FILE_DATE=${L_YYYY}-${L_MM}-${L_DD}_${L_HH}:00:00
#
# LINK NEEDED FILES
         export FILE_CR=wrfinput_d${CR_DOMAIN}
         export FILE_FR=wrfinput_d${FR_DOMAIN}
         rm -rf ${FILE_CR}
         rm -rf ${FILE_FR}
         cp ${REAL_DIR}/${FILE_CR}_${L_FILE_DATE} ${FILE_CR}   
         cp ${REAL_DIR}/${FILE_FR}_${L_FILE_DATE} ${FILE_FR}   
         export FILE_CR=wrfbiochemi_d${CR_DOMAIN}
         export FILE_FR=wrfbiochemi_d${FR_DOMAIN}
         if [[ ${L_DATE} -eq ${DATE} ]]; then
            rm -rf ${FILE_CR}
            rm -rf ${FILE_FR}
         fi
         rm -rf btr*.nc
         rm -rf DSW*.nc
         rm -rf hrb*.nc
         rm -rf iso*.nc
         rm -rf lai*.nc
         rm -rf ntr*.nc
         rm -rf shr*.nc
         rm -rf TAS*.nc
         cp ${EXPERIMENT_WRFBIOCHEMI_DIR}/MEGAN-DATA/*.nc ./.
         export FILE=megan_bio_emiss.exe
         rm -rf ${FILE}
         cp ${MEGAN_BIO_DIR}/work/${FILE} ${FILE}
#
# CREATE INPUT FILE
         export FILE=megan_bio_emiss.inp
         rm -rf ${FILE}
         cat << EOF > ${FILE}
&control
domains = 2,
start_lai_mnth = 1,
end_lai_mnth = 12
/
EOF
#
         RANDOM=$$
         export JOBRND=${RANDOM}_bio
#         ${JOB_CONTROL_SCRIPTS_DIR}/job_script_nasa.ksh ${JOBRND} ${BIO_JOB_CLASS} ${BIO_TIME_LIMIT} ${BIO_NODES} ${BIO_TASKS} "megan_bio_emiss.exe < megan_bio_emiss.inp" SERIAL ${ACCOUNT}
#         qsub -Wblock=true job.ksh
#
	 rm -rf index.html
         chmod +x megan_bio_emiss.exe
         ./megan_bio_emiss.exe < megan_bio_emiss.inp > index.html 2>&1
#
# TEST WHETHER OUTPUT EXISTS
         export FILE_CR=wrfbiochemi_d${CR_DOMAIN}
         export FILE_FR=wrfbiochemi_d${FR_DOMAIN}
         if [[ ! -e ${FILE_CR} || ! -e ${FILE_FR} ]]; then
            echo WRFCHEM_BIO FAILED
            exit
         else
            echo WRFCHEM_BIO SUCCESS
            mv ${FILE_CR} ${FILE_CR}_${L_FILE_DATE}
            mv ${FILE_FR} ${FILE_FR}_${L_FILE_DATE}
         fi
         export L_DATE=$(${BUILD_DIR}/da_advance_time.exe ${L_DATE} 6 2>/dev/null)
      done
   fi
#
#########################################################################
#
# RUN WRFCHEM_FIRE
#
#########################################################################
#
   if ${RUN_WRFCHEM_FIRE}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/wrfchem_fire ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/wrfchem_fire
         cd ${RUN_DIR}/${DATE}/wrfchem_fire
      else
         cd ${RUN_DIR}/${DATE}/wrfchem_fire
      fi
#
# LINK NEEDED FILES
      export FILE_CR=wrfinput_d${CR_DOMAIN}
      export FILE_FR=wrfinput_d${FR_DOMAIN}
      rm -rf ${FILE_CR}
      rm -rf ${FILE_FR}
      ln -sf ${REAL_DIR}/${FILE_CR}_${FILE_DATE} ${FILE_CR}   
      ln -sf ${REAL_DIR}/${FILE_FR}_${FILE_DATE} ${FILE_FR}   
      rm -rf GLOBAL*.txt
      ln -sf ${EXPERIMENT_WRFFIRECHEMI_DIR}/GLOBAL*.txt ./.
      export FILE=fire_emis.exe
      rm -rf ${FILE}
      ln -sf ${FINN_FIRE_DIR}/work/${FILE} ${FILE}
      rm -rf grass_from_img.nc
      rm -rf shrub_from_img.nc
      rm -rf tempfor_from_img.nc
      rm -rf tropfor_from_img.nc
      ln -sf ${EXPERIMENT_WRFFIRECHEMI_DIR}/grass_from_img.nc
      ln -sf ${EXPERIMENT_WRFFIRECHEMI_DIR}/shrub_from_img.nc
      ln -sf ${EXPERIMENT_WRFFIRECHEMI_DIR}/tempfor_from_img.nc
      ln -sf ${EXPERIMENT_WRFFIRECHEMI_DIR}/tropfor_from_img.nc
#
# CREATE INPUT FILE
      export FILE=fire_emis.mozc.inp
      rm -rf ${FILE}
      cat << EOF > ${FILE}
&control
domains = 2,
fire_filename(1) = 'GLOBAL_FINNv15_JULSEP2014_MOZ4_09222014.txt',
start_date = '${FIRE_START_DATE}', 
end_date = '${FIRE_END_DATE}',
fire_directory = './',
wrf_directory = './',
wrf2fire_map = 'co -> CO', 'no -> NO', 'so2 -> SO2', 'bigalk -> BIGALK',
               'bigene -> BIGENE', 'c2h4 -> C2H4', 'c2h5oh -> C2H5OH',
               'c2h6 -> C2H6', 'c3h8 -> C3H8','c3h6 -> C3H6','ch2o -> CH2O', 'ch3cho -> CH3CHO',
               'ch3coch3 -> CH3COCH3','ch3oh -> CH3OH','mek -> MEK','toluene -> TOLUENE',
               'nh3 -> NH3','no2 -> NO2','open -> BIGALD','c10h16 -> C10H16',
               'ch3cooh -> CH3COOH','cres -> CRESOL','glyald -> GLYALD','mgly -> CH3COCHO',
               'gly -> CH3COCHO','acetol -> HYAC','isop -> ISOP','macr -> MACR'
               'mvk -> MVK',
               'oc -> OC;aerosol','bc -> BC;aerosol'
/
EOF
#
      RANDOM=$$
      export JOBRND=${RANDOM}_fire
#      ${JOB_CONTROL_SCRIPTS_DIR}/job_script_nasa.ksh ${JOBRND} ${GENERAL_JOB_CLASS} ${GENERAL_TIME_LIMIT} ${GENERAL_NODES} ${GENERAL_TASKS} "fire_emis.exe < fire_emis.mozc.inp" SERIAL ${ACCOUNT}
#      qsub -Wblock=true job.ksh
      chmod +x fire_emis.exe
      ./fire_emis.exe < fire_emis.mozc.inp > index.html 2>&1
#
      export L_DATE=${DATE}
      while [[ ${L_DATE} -le ${END_DATE} ]]; do
         export L_YYYY=$(echo $L_DATE | cut -c1-4)
         export L_MM=$(echo $L_DATE | cut -c5-6)
         export L_DD=$(echo $L_DATE | cut -c7-8)
         export L_HH=$(echo $L_DATE | cut -c9-10)
         export L_FILE_DATE=${L_YYYY}-${L_MM}-${L_DD}_${L_HH}:00:00
         export DD_DATE=${L_YYYY}${L_MM}${L_DD}
#
# TEST WHETHER OUTPUT EXISTS
         export FILE_CR=wrffirechemi_d${CR_DOMAIN}_${L_FILE_DATE}
         export FILE_FR=wrffirechemi_d${FR_DOMAIN}_${L_FILE_DATE}
         if [[ ! -e ${FILE_CR} || ! -e ${FILE_CR} ]]; then
            echo WRFFIRE FAILED
            exit
         else
            echo WRFFIRE SUCCESS
         fi
         export L_DATE=$(${BUILD_DIR}/da_advance_time.exe ${L_DATE} 1 2>/dev/null)
      done
   fi
#
#########################################################################
#
# RUN WRFCHEM_CHEMI
#
#########################################################################
#
   if ${RUN_WRFCHEM_CHEMI}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/wrfchem_chemi ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/wrfchem_chemi
         cd ${RUN_DIR}/${DATE}/wrfchem_chemi
      else
         cd ${RUN_DIR}/${DATE}/wrfchem_chemi
      fi
      export L_DATE=${DATE}
      export LE_DATE=$(${BUILD_DIR}/da_advance_time.exe ${L_DATE} ${FCST_PERIOD} 2>/dev/null)
#
      while [[ ${L_DATE} -le ${LE_DATE} ]]; do
         export L_YYYY=$(echo $L_DATE | cut -c1-4)
         export L_MM=$(echo $L_DATE | cut -c5-6)
         export L_DD=$(echo $L_DATE | cut -c7-8)
         export L_HH=$(echo $L_DATE | cut -c9-10)
#
         export FILE_PATH=${EXPERIMENT_WRFCHEMI_DIR}
         cp ${FILE_PATH}/wrfchemi_d${CR_DOMAIN}_${L_YYYY}-${L_MM}-${L_DD}_${L_HH}:00:00 ./.
         cp ${FILE_PATH}/wrfchemi_d${FR_DOMAIN}_${L_YYYY}-${L_MM}-${L_DD}_${L_HH}:00:00 ./.
         chmod 644 wrfchemi_d${CR_DOMAIN}_${L_YYYY}-${L_MM}-${L_DD}_${L_HH}:00:00 
         chmod 644 wrfchemi_d${FR_DOMAIN}_${L_YYYY}-${L_MM}-${L_DD}_${L_HH}:00:00 
         export L_DATE=$(${BUILD_DIR}/da_advance_time.exe ${L_DATE} 1 2>/dev/null)
      done
   fi
#
#########################################################################
#
# RUN WRFCHEM PERTURB ICBC
#
#########################################################################
#
   if ${RUN_PERT_WRFCHEM_CHEM_ICBC}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/wrfchem_chem_icbc ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/wrfchem_chem_icbc
         cd ${RUN_DIR}/${DATE}/wrfchem_chem_icbc
      else
         cd ${RUN_DIR}/${DATE}/wrfchem_chem_icbc
      fi
#
# PERTURB CHEM ICBC
      export NL_SW_CORR_TM=false
      if [[ ${DATE} -eq ${INITIAL_DATE} ]]; then export NL_SW_CORR_TM=true; fi
      export NL_SW_SEED=true
#
      cp ${METGRID_DIR}/met_em.d${CR_DOMAIN}.*:00:00.nc ./.
#      cp ${METGRID_DIR}/met_em.d${FR_DOMAIN}.*:00:00.nc ./.
      cp ${PERT_CHEM_INPUT_DIR}/work/perturb_chem_icbc_CORR_RT_MA.exe ./.
      cp ${PERT_CHEM_INPUT_DIR}/work/perturb_chem_icbc_CORR_RT_MA_MPI.exe ./.
      cp ${PERT_CHEM_INPUT_DIR}/work/mozbc.exe ./mozbc.exe
      cp ${PERT_CHEM_INPUT_DIR}/runICBC_parent_rt_CR.ksh ./.
      cp ${PERT_CHEM_INPUT_DIR}/runICBC_parent_rt_FR.ksh ./.
      cp ${PERT_CHEM_INPUT_DIR}/run_mozbc_rt_CR.csh ./.
      cp ${PERT_CHEM_INPUT_DIR}/run_mozbc_rt_FR.csh ./.
      cp ${PERT_CHEM_INPUT_DIR}/set00 ./.
#
# SELECT MOZART DATA FILE
#      if [[ ${YYYY} -eq 2014 ]]; then export MOZBC_DATA=/h0003.nc; fi
      if [[ ${YYYY} -eq 2014 ]]; then export MOZBC_DATA=/h0004.nc; fi
#
# CREATE INPUT FILES COARSE DOMAIN
      rm -rf mozbc.ic.inp
      cat << EOF > mozbc.ic.inp
&control
do_bc     = .false.
do_ic     = .true.
domain    = 1
dir_wrf   = '${RUN_DIR}/${DATE}/wrfchem_chem_icbc/'
dir_moz   = '${MOZBC_DATA_DIR}'
fn_moz    = '${MOZBC_DATA}'
def_missing_var    = .true.
met_file_prefix    = 'met_em'
met_file_suffix    = '.nc'
met_file_separator = '.'
EOF
      rm -rf mozbc.bc.inp
      cat << EOF > mozbc.bc.inp
&control
do_bc     = .true.
do_ic     = .false.
domain    = 1
dir_wrf   = '${RUN_DIR}/${DATE}/wrfchem_chem_icbc/'
dir_moz   = '${MOZBC_DATA_DIR}'
fn_moz    = '${MOZBC_DATA}'
def_missing_var    = .true.
met_file_prefix    = 'met_em'
met_file_suffix    = '.nc'
met_file_separator = '.'
EOF
#
      ./runICBC_parent_rt_CR.ksh
#
# CREATE INPUT FILES FINE DOMAIN
#      rm -rf mozbc.ic.inp
#      cat << EOF > mozbc.ic.inp
#&control
#do_bc     = .false.
#do_ic     = .true.
#domain    = 2
#dir_wrf   = '${RUN_DIR}/${DATE}/wrfchem_chem_icbc/'
#dir_moz   = '${MOZBC_DATA_DIR}'
#fn_moz    = '${MOZBC_DATA}'
#def_missing_var    = .true.
#met_file_prefix    = 'met_em'
#met_file_suffix    = '.nc'
#met_file_separator = '.'
#EOF
#      rm -rf mozbc.bc.inp
#      cat << EOF > mozbc.bc.inp
#&control
#do_bc     = .true.
#do_ic     = .false.
#domain    = 2
#dir_wrf   = '${RUN_DIR}/${DATE}/wrfchem_chem_icbc/'
#dir_moz   = '${MOZBC_DATA_DIR}'
#fn_moz    = '${MOZBC_DATA}'
#def_missing_var    = .true.
#met_file_prefix    = 'met_em'
#met_file_suffix    = '.nc'
#met_file_separator = '.'
#EOF
#
#      ./runICBC_parent_rt_FR.ksh
#
# GENERATE CHEMISTRY IC/BC ENSEMBLE MEMBERS
#
# CREATE NAMELIST
      export WRFINPEN=wrfinput_d${CR_DOMAIN}_${YYYY}-${MM}-${DD}_${HH}:00:00
      export WRFBDYEN=wrfbdy_d${CR_DOMAIN}_${YYYY}-${MM}-${DD}_${HH}:00:00
      export WRFINPUT_FLD_RW=wrfinput_d${CR_DOMAIN}
      export WRFINPUT_ERR_RW=wrfinput_d${CR_DOMAIN}_err
      export WRFBDY_FLD_RW=wrfbdy_d${CR_DOMAIN}
      mv ${WRFINPEN} ${WRFINPUT_FLD_RW}
      mv ${WRFBDYEN} ${WRFBDY_FLD_RW}
      rm -rf perturb_chem_icbc_corr_nml.nl
      cat << EOF > perturb_chem_icbc_corr_nml.nl
&perturb_chem_icbc_corr_nml
date=${MM}${DD}${HH},
nx=${NNXP_CR},
ny=${NNYP_CR},
nz=${NNZP_CR},
nchem_spcs=${NSPCS},
pert_path_old='${RUN_DIR}/${PAST_DATE}/wrfchem_chem_icbc',
pert_path_new='${RUN_DIR}/${DATE}/wrfchem_chem_icbc',
nnum_mem=${NUM_MEMBERS},
wrfinput_fld_new='${WRFINPUT_FLD_RW}',
wrfinput_err_new='${WRFINPUT_ERR_RW}',
wrfbdy_fld_new='${WRFBDY_FLD_RW}',
sprd_chem=${SPREAD_FAC},
corr_lngth_hz=${NL_HZ_CORR_LNGTH},
corr_lngth_vt=${NL_VT_CORR_LNGTH},
corr_lngth_tm=${NL_TM_CORR_LNGTH_IC},
corr_tm_delt=${CYCLE_PERIOD},
sw_corr_tm=${NL_SW_CORR_TM},
sw_seed=${NL_SW_SEED},
/
EOF
      rm -rf perturb_chem_icbc_spcs_nml.nl
      cat << EOF > perturb_chem_icbc_spcs_nml.nl
#
# These need to match the species in the respective input files
&perturb_chem_icbc_spcs_nml
ch_chem_spc='o3','no','no2','no3','nh3','hno3','hno4','n2o5','ho2','h2o2','co','ch4','ch3o2','ch3ooh','hcho','ch3oh','c2h4','ald','ch3cooh','acet','mgly','pan','mpan','macr','mvk','c2h6','c3h6','c3h8','c2h5oh','c10h16','onit','onitr','isopr','isopn','acetol','glyald','hydrald','mek','bigene','open','bigalk','tol','cres','dms','so2','sulf','BC1','BC2','OC1','OC2','SEAS_1','SEAS_2','SEAS_3','SEAS_4','DUST_1','DUST_2','DUST_3','DUST_4','DUST_5','h2','n2o'
/
EOF
#
      let MEM=1
      while [[ ${MEM} -le ${NUM_MEMBERS} ]]; do
         export CMEM=e${MEM}
         if [[ ${MEM} -lt 100 ]]; then export CMEM=e0${MEM}; fi
         if [[ ${MEM} -lt 10  ]]; then export CMEM=e00${MEM}; fi
         cp ${WRFINPUT_FLD_RW} ${WRFINPUT_FLD_RW}.${CMEM}   
#         cp ${WRFINPUT_FLD_RW} ${WRFINPUT_ERR_RW}.${CMEM}   
         cp ${WRFBDY_FLD_RW} ${WRFBDY_FLD_RW}.${CMEM}   
         let MEM=MEM+1
      done
      cp ${WRFINPUT_FLD_RW} ${WRFINPUT_FLD_RW}_mean
      cp ${WRFINPUT_FLD_RW} ${WRFINPUT_FLD_RW}_sprd
      cp ${WRFINPUT_FLD_RW} ${WRFINPUT_FLD_RW}_frac
#
      RANDOM=$$
      export JOBRND=${RANDOM}_cr_icbc_pert
#
# SERIAL VERSION
#      ${JOB_CONTROL_SCRIPTS_DIR}/job_script_nasa.ksh ${JOBRND} ${GENERAL_JOB_CLASS} ${GENERAL_TIME_LIMIT} ${GENERAL_NODES} ${GENERAL_TASKS} perturb_chem_icbc_CORR_RT_MA.exe SERIAL ${ACCOUNT}
#
# PARALLEL VERSION
      ${JOB_CONTROL_SCRIPTS_DIR}/job_script_nasa.ksh ${JOBRND} ${PERT_JOB_CLASS} ${PERT_TIME_LIMIT} ${PERT_NODES} ${PERT_TASKS} perturb_chem_icbc_CORR_RT_MA_MPI.exe PARALLEL ${ACCOUNT}
#
      qsub -Wblock=true job.ksh
#
      let MEM=1
      while [[ ${MEM} -le ${NUM_MEMBERS} ]]; do
         export CMEM=e${MEM}
         if [[ ${MEM} -lt 100 ]]; then export CMEM=e0${MEM}; fi
         if [[ ${MEM} -lt 10  ]]; then export CMEM=e00${MEM}; fi
         mv ${WRFINPUT_FLD_RW}.${CMEM} ${WRFINPEN}.${CMEM}
         mv ${WRFBDY_FLD_RW}.${CMEM} ${WRFBDYEN}.${CMEM}
         let MEM=MEM+1
      done
#
# COMBINE WRFCHEM WITH WRF CR PARENT FILES
      ncks -A ${EXPERIMENT_DUST_DIR}/EROD_d${CR_DOMAIN} ${WRFINPEN}
      ncks -A ${REAL_DIR}/${WRFINPEN} ${WRFINPEN}
      ncks -A ${REAL_DIR}/${WRFBDYEN} ${WRFBDYEN}
#
# COMBINE WRFCHEM WITH WRF FR DOMAIN PARENT FILES
#      export WRFINPEN=wrfinput_d${FR_DOMAIN}_${YYYY}-${MM}-${DD}_${HH}:00:00
#      ncks -A ${REAL_DIR}/${WRFINPEN} ${WRFINPEN}
#      ncks -A ${EXPERIMENT_DUST_DIR}/EROD_d${FR_DOMAIN} ${WRFINPEN}
#
# LOOP THROUGH ALL MEMBERS IN THE ENSEMBLE
      let MEM=1
      while [[ ${MEM} -le ${NUM_MEMBERS} ]]; do
         export CMEM=e${MEM}
         if [[ ${MEM} -lt 100 ]]; then export CMEM=e0${MEM}; fi
         if [[ ${MEM} -lt 10  ]]; then export CMEM=e00${MEM}; fi
#
# COMBINE WRFCHEM WITH WRF CR DOMAIN
         export WRFINPEN=wrfinput_d${CR_DOMAIN}_${YYYY}-${MM}-${DD}_${HH}:00:00.${CMEM}
         export WRFBDYEN=wrfbdy_d${CR_DOMAIN}_${YYYY}-${MM}-${DD}_${HH}:00:00.${CMEM}
         ncks -A ${EXPERIMENT_DUST_DIR}/EROD_d${CR_DOMAIN} ${WRFINPEN}
         ncks -A ${WRFCHEM_MET_IC_DIR}/${WRFINPEN} ${WRFINPEN}
         ncks -A ${WRFCHEM_MET_BC_DIR}/${WRFBDYEN} ${WRFBDYEN}
#
# COMBINE WRFCHEM WITH WRF FR DOMAIN
#         export WRFINPEN=wrfinput_d${FR_DOMAIN}_${YYYY}-${MM}-${DD}_${HH}:00:00.${CMEM}
#         ncks -A ${WRFCHEM_MET_IC_DIR}/${WRFINPEN} ${WRFINPEN}
#         ncks -A ${EXPERIMENT_DUST_DIR}/EROD_d${FR_DOMAIN} ${WRFINPEN}
#
         let MEM=MEM+1
      done
   fi
#
#########################################################################
#
# RUN WRFCHEM PERTURB EMISSIONS
#
#########################################################################
#
   if ${RUN_PERT_WRFCHEM_CHEM_EMISS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/wrfchem_chem_emiss ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/wrfchem_chem_emiss
         cd ${RUN_DIR}/${DATE}/wrfchem_chem_emiss
      else
         cd ${RUN_DIR}/${DATE}/wrfchem_chem_emiss
      fi
#
# SET PARAMETERS
      export NL_EMISS_TIME=0
      export NL_SW_SEED=true
      export NL_SW_CORR_TM=false
      if [[ ${DATE} -eq ${INITIAL_DATE} ]]; then export NL_SW_CORR_TM=true; fi
#
# COPY ADJUSTMENT AND PERTURBATION CODE
      rm -rf adjust_chem_emiss.exe
      rm -rf perturb_chem_emiss_CORR_RT_MA.exe
      rm -rf perturb_chem_emiss_CORR_RT_MA_MPI.exe
      cp ${ADJUST_EMISS_DIR}/work/adjust_chem_emiss.exe ./.
      cp ${PERT_CHEM_EMISS_DIR}/work/perturb_chem_emiss_CORR_RT_MA.exe ./.
      cp ${PERT_CHEM_EMISS_DIR}/work/perturb_chem_emiss_CORR_RT_MA_MPI.exe ./.
#
#########################################################################
#
# PERTURB THE EMISSIONS FILES
#
#########################################################################
#
# COPY CURRENT ARCHIVE EMISSIONS      
      export L_DATE=${DATE}
      export LE_DATE=$(${BUILD_DIR}/da_advance_time.exe ${L_DATE} ${FCST_PERIOD} 2>/dev/null)
      while [[ ${L_DATE} -le ${LE_DATE} ]] ; do
         export L_YYYY=$(echo $L_DATE | cut -c1-4)
         export L_MM=$(echo $L_DATE | cut -c5-6)
         export L_DD=$(echo $L_DATE | cut -c7-8)
         export L_HH=$(echo $L_DATE | cut -c9-10)
#
# GET COARSE GRID EMISSON FILES
         export WRFCHEMI=wrfchemi_d${CR_DOMAIN}_${L_YYYY}-${L_MM}-${L_DD}_${L_HH}:00:00
         export WRFFIRECHEMI=wrffirechemi_d${CR_DOMAIN}_${L_YYYY}-${L_MM}-${L_DD}_${L_HH}:00:00
         export WRFBIOCHEMI=wrfbiochemi_d${CR_DOMAIN}_${L_YYYY}-${L_MM}-${L_DD}_${L_HH}:00:00
#
# COPY DATA
         cp ${WRFCHEM_CHEMI_DIR}/${WRFCHEMI} ${WRFCHEMI}
         chmod 644 ${WRFCHEMI}
         ncatted -O -a coordinates,E_CO,c,c,"XLONG, XLAT" ${WRFCHEMI}
         ncatted -O -a coordinates,E_NO,c,c,"XLONG, XLAT" ${WRFCHEMI}
         ncatted -O -a coordinates,E_NO2,c,c,"XLONG, XLAT" ${WRFCHEMI}
         ncatted -O -a coordinates,E_OC,c,c,"XLONG, XLAT" ${WRFCHEMI}
         ncatted -O -a coordinates,E_BC,c,c,"XLONG, XLAT" ${WRFCHEMI}
         ncatted -O -a coordinates,E_PM_10,c,c,"XLONG, XLAT" ${WRFCHEMI}
         ncatted -O -a coordinates,E_PM_25,c,c,"XLONG, XLAT" ${WRFCHEMI}
         ncatted -O -a coordinates,E_SO2,c,c,"XLONG, XLAT" ${WRFCHEMI}
         cp ${WRFCHEM_FIRE_DIR}/${WRFFIRECHEMI} ${WRFFIRECHEMI}
         chmod 644 ${WRFFIRECHEMI}
         ncatted -O -a coordinates,ebu_in_co,c,c,"XLONG, XLAT" ${WRFFIRECHEMI}
         ncatted -O -a coordinates,ebu_in_no,c,c,"XLONG, XLAT" ${WRFFIRECHEMI}
         ncatted -O -a coordinates,ebu_in_no2,c,c,"XLONG, XLAT" ${WRFFIRECHEMI}
         ncatted -O -a coordinates,ebu_in_so2,c,c,"XLONG, XLAT" ${WRFFIRECHEMI}
         ncatted -O -a coordinates,ebu_in_oc,c,c,"XLONG, XLAT" ${WRFFIRECHEMI}
         ncatted -O -a coordinates,ebu_in_bc,c,c,"XLONG, XLAT" ${WRFFIRECHEMI}
         ncatted -O -a coordinates,ebu_in_c2h4,c,c,"XLONG, XLAT" ${WRFFIRECHEMI}
         ncatted -O -a coordinates,ebu_in_ch2o,c,c,"XLONG, XLAT" ${WRFFIRECHEMI}
         ncatted -O -a coordinates,ebu_in_ch3oh,c,c,"XLONG, XLAT" ${WRFFIRECHEMI}
         if [[ ${L_HH} -eq 00 || ${L_HH} -eq 06 || ${L_HH} -eq 12 || ${L_HH} -eq 18 ]]; then
            cp ${WRFCHEM_BIO_DIR}/${WRFBIOCHEMI} ${WRFBIOCHEMI}
            chmod 644 ${WRFBIOCHEMI}
         fi
#
# CREATE ENSEMBLE MEMBER FILES AS TEMPLATES	 
         let MEM=1
         while [[ ${MEM} -le ${NUM_MEMBERS} ]]; do
            export CMEM=e${MEM}
            if [[ ${MEM} -lt 100 ]]; then export CMEM=e0${MEM}; fi
            if [[ ${MEM} -lt 10  ]]; then export CMEM=e00${MEM}; fi
#
# copy ensemble members 
            export WRFINPUT=wrfinput_d${CR_DOMAIN}_${YYYY}-${MM}-${DD}_${HH}:00:00.${CMEM}
            rm -rf wrfinput_d${CR_DOMAIN}.${CMEM}
            cp ${WRFCHEM_CHEM_ICBC_DIR}/${WRFINPUT} wrfinput_d${CR_DOMAIN}.${CMEM}
#
# wrfchemi
            rm -rf ${WRFCHEMI}.${CMEM}
            cp ${WRFCHEMI} ${WRFCHEMI}.${CMEM}
#
# wrffire
            rm -rf ${WRFFIRECHEMI}.${CMEM}
            cp ${WRFFIRECHEMI} ${WRFFIRECHEMI}.${CMEM}
#
# wrfbio
            if [[ ${L_HH} -eq 00 || ${L_HH} -eq 06 || ${L_HH} -eq 12 || ${L_HH} -eq 18 ]]; then
               cp ${WRFBIOCHEMI} ${WRFBIOCHEMI}.${CMEM}
            fi
	    let MEM=MEM+1
         done
#
# CREATE ENSEMBLE STATS FILES AS TEMPLATES	 
         if [[ ${NL_PERT_CHEM} == true ]]; then 
            cp ${WRFCHEMI} ${WRFCHEMI}_mean
            cp ${WRFCHEMI} ${WRFCHEMI}_sprd
            cp ${WRFCHEMI} ${WRFCHEMI}_frac
         fi
         if [[ ${NL_PERT_FIRE} == true ]]; then 
            cp ${WRFFIRECHEMI} ${WRFFIRECHEMI}_mean
            cp ${WRFFIRECHEMI} ${WRFFIRECHEMI}_sprd
            cp ${WRFFIRECHEMI} ${WRFFIRECHEMI}_frac
         fi
         if [[ ${NL_PERT_BIO} == true ]]; then 
            if [[ ${L_HH} -eq 00 || ${L_HH} -eq 06 || ${L_HH} -eq 12 || ${L_HH} -eq 18 ]]; then
               cp ${WRFBIOCHEMI} ${WRFBIOCHEMI}_mean
               cp ${WRFBIOCHEMI} ${WRFBIOCHEMI}_sprd
               cp ${WRFBIOCHEMI} ${WRFBIOCHEMI}_frac
            fi
         fi
#
# CREATE NAMELIST
         export NL_PERT_PATH_PR=${RUN_DIR}/${DATE}/wrfchem_chem_emiss
         export NL_PERT_PATH_PO=${RUN_DIR}/${DATE}/wrfchem_chem_emiss
         if [[ ${L_DATE} -eq ${DATE} || ${L_HH} -eq 00 ]]; then
            export NL_PERT_PATH_PR=${RUN_DIR}/${PAST_DATE}/wrfchem_chem_emiss
            export NL_PERT_PATH_PO=${RUN_DIR}/${DATE}/wrfchem_chem_emiss
         fi
#
         rm -rf perturb_chem_emiss_corr_nml.nl
         cat << EOF > perturb_chem_emiss_corr_nml.nl
&perturb_chem_emiss_CORR_nml
date=${L_MM}${L_DD}${L_HH},
nx=${NNXP_CR},
ny=${NNYP_CR},
nz=${NNZP_CR},
nz_chem=${NNZ_CHEM},
nchem_spcs=${NNCHEM_SPC},
nfire_spcs=${NNFIRE_SPC},
nbiog_spcs=${NNBIO_SPC},
pert_path_pr='${NL_PERT_PATH_PR}',
pert_path_po='${NL_PERT_PATH_PO}',
nnum_mem=${NUM_MEMBERS},
wrfchemi='${WRFCHEMI}',
wrffirechemi='${WRFFIRECHEMI}',
wrfbiogchemi='${WRFBIOCHEMI}',
sprd_chem=${NL_SPREAD_CHEMI},
sprd_fire=${NL_SPREAD_FIRE},
sprd_biog=${NL_SPREAD_BIOG},
sw_corr_tm=${NL_SW_CORR_TM},
sw_seed=${NL_SW_SEED},
sw_chem=${NL_PERT_CHEM},
sw_fire=${NL_PERT_FIRE},
sw_biog=${NL_PERT_BIO},
corr_lngth_hz=${NL_HZ_CORR_LNGTH},
corr_lngth_vt=${NL_VT_CORR_LNGTH},
corr_lngth_tm=${NL_TM_CORR_LNGTH_BC},
corr_tm_delt=${NL_EMISS_TIME},
/
EOF
         rm -rf perturb_emiss_chem_spec_nml.nl
         cat << EOF > perturb_emiss_chem_spec_nml.nl
#
# These need to match the emissions species in the respective emissions files
&perturb_chem_emiss_spec_nml
ch_chem_spc='E_CO','E_NO','E_NO2','E_BIGALK','E_BIGENE','E_C2H4','E_C2H5OH','E_C2H6','E_C3H6','E_C3H8','E_CH2O','E_CH3CHO','E_CH3COCH3','E_CH3OH','E_MEK','E_SO2','E_TOLUENE','E_NH3','E_ISOP','E_C10H16','E_sulf','E_CO_A','E_CO_BB','E_CO02','E_CO03','E_XNO','E_XNO2','E_BALD','E_C2H2','E_BENZENE','E_XYLENE','E_CRES','E_HONO','E_PM25I','E_PM25J','E_PM_10','E_ECI','E_ECJ','E_ORGI','E_ORGJ','E_SO4I','E_SO4J','E_NO3I','E_NO3J','E_NH4I','E_NH4J','E_PM_25','E_OC','E_BC',
ch_fire_spc='ebu_in_co','ebu_in_no','ebu_in_so2','ebu_in_bigalk','ebu_in_bigene','ebu_in_c2h4','ebu_in_c2h5oh','ebu_in_c2h6','ebu_in_c3h8','ebu_in_c3h6','ebu_in_ch2o','ebu_in_ch3cho','ebu_in_ch3coch3','ebu_in_ch3oh','ebu_in_mek','ebu_in_toluene','ebu_in_nh3','ebu_in_no2','ebu_in_open','ebu_in_c10h16','ebu_in_ch3cooh','ebu_in_cres','ebu_in_glyald','ebu_in_mgly','ebu_in_gly','ebu_in_acetol','ebu_in_isop','ebu_in_macr','ebu_in_mvk','ebu_in_oc','ebu_in_bc',
ch_biog_spc='MSEBIO_ISOP',
/
EOF
#
# SERIAL VERSION
         RANDOM=$$
#         export JOBRND=${RANDOM}_cr_emiss_pert
#         ${JOB_CONTROL_SCRIPTS_DIR}/job_script_nasa.ksh ${JOBRND} ${GENERAL_JOB_CLASS} ${GENERAL_TIME_LIMIT} ${GENERAL_NODES} ${GENERAL_TASKS} perturb_chem_emiss_CORR_RT_MA.exe SERIAL ${ACCOUNT}
#
# PARALLEL VERSION
         export JOBRND=${RANDOM}_cr_emiss_pert
         ${JOB_CONTROL_SCRIPTS_DIR}/job_script_nasa.ksh ${JOBRND} ${PERT_JOB_CLASS} ${PERT_TIME_LIMIT} ${PERT_NODES} ${PERT_TASKS} perturb_chem_emiss_CORR_RT_MA_MPI.exe PARALLEL ${ACCOUNT}
#
         qsub -Wblock=true job.ksh
#
# GET FINE GRID EMISSON FILES FOR THIS MEMBER
#         export WRFCHEMI=wrfchemi_d${FR_DOMAIN}_${L_YYYY}-${L_MM}-${L_DD}_${L_HH}:00:00
#         export WRFFIRECHEMI=wrffirechemi_d${FR_DOMAIN}_${L_YYYY}-${L_MM}-${L_DD}_${L_HH}:00:00
#         export WRFBIOCHEMI=wrfbiochemi_d${FR_DOMAIN}_${L_YYYY}-${L_MM}-${L_DD}_${L_HH}:00:00
#         export WRFINPUT=wrfinput_d${FR_DOMAIN}_${YYYY}-${MM}-${DD}_${HH}:00:00
#   
#         export WRFINPUT_DIR=${WRFCHEM_CHEM_ICBC_DIR}
#         cp ${WRFINPUT_DIR}/${WRFINPUT} wrfinput_d${FR_DOMAIN}
#   
#         let MEM=1
#         while [[ ${MEM} -le ${NUM_MEMBERS} ]]; do
#            export CMEM=e${MEM}
#            if [[ ${MEM} -lt 100 ]]; then export CMEM=e0${MEM}; fi
#            if [[ ${MEM} -lt 10  ]]; then export CMEM=e00${MEM}; fi
#            if [[ ${NL_PERT_CHEM} == true ]]; then
#               cp ${WRFCHEM_CHEMI_DIR}/${WRFCHEMI} ${WRFCHEMI}.${CMEM}
#            fi
#            if [[ ${NL_PERT_FIRE} == true ]]; then
#               cp ${WRFCHEM_FIRE_DIR}/${WRFFIRECHEMI} ${WRFFIRECHEMI}.${CMEM}
#            fi
#            if [[ ${NL_PERT_BIO} == true ]]; then
#               cp ${WRFCHEM_BIO_DIR}/${WRFBIOCHEMI} ${WRFBIOCHEMI}.${CMEM}
#            fi
#            let MEM=MEM+1
#         done
#
# CREATE NAMELIST
#         rm -rf perturb_chem_emiss_CORR_nml.nl
#         cat << EOF > perturb_chem_emiss_CORR_nml.nl
#&perturb_chem_emiss_CORR_nml
#date=${L_MM}${L_DD}${L_HH},
#nx=${NNXP_FR},
#ny=${NNYP_FR},
#nz=${NNZP_FR},
#nz_chem=${NNZ_CHEM},
#nchem_spc=${NNCHEM_SPC},
#nfire_spc=${NNFIRE_SPC},
#nbio_spc=${NNBIO_SPC},
#pert_path='${RUN_DIR}',
#nnum_mem=${NUM_MEMBERS},
#wrfchemi='${WRFCHEMI}',
#wrffirechemi='${WRFFIRECHEMI}',
#wrfbiochemi='${WRFBIOCHEMI}',
#sprd_chem=${NL_SPREAD_CHEMI},
#sprd_fire=${NL_SPREAD_FIRE},
#sprd_biog=${NL_SPREAD_BIOG},
#sw_chem=${NL_PERT_CHEM},
#sw_fire=${NL_PERT_FIRE},
#sw_biog=${NL_PERT_BIO},
#/
#EOF
#         rm -rf perturb_emiss_chem_spec_nml.nl
#         cat << EOF > perturb_emiss_chem_spec_nml.nl
#
# These need to match the emissions species in the respective emissions files
#&perturb_chem_emiss_spec_nml
#ch_chem_spc='E_CO','E_NO','E_NO2','E_SO2','E_BIGALK','E_C2H4','E_C2H5OH','E_C2H6','E_C3H6','E_C3H8','E_CH2O','E_CH3CHO','E_BIGENE','E_CH3COCH3','E_CH3OH','E_MEK','E_TOLUENE','E_ISOP','E_C10H16','E_NH3','E_OC','E_BC','E_PM_10','E_PM_25',
#ch_fire_spc='ebu_in_co','ebu_in_no','ebu_in_so2','ebu_in_bigalk','ebu_in_bigene','ebu_in_c2h4','ebu_in_c2h5oh','ebu_in_c2h6','ebu_in_c3h8','ebu_in_c3h6','ebu_in_ch2o','ebu_in_ch3cho','ebu_in_ch3coch3','ebu_in_ch3oh','ebu_in_mek','ebu_in_toluene','ebu_in_nh3','ebu_in_no2','ebu_in_open','ebu_in_c10h16','ebu_in_ch3cooh','ebu_in_cres','ebu_in_glyald','ebu_in_mgly','ebu_in_gly','ebu_in_acetol','ebu_in_isop','ebu_in_macr','ebu_in_mvk','ebu_in_oc','ebu_in_bc',
#ch_biog_spc='MSEBIO_ISOP',
#/
#EOF
#
#         RANDOM=$$
#         export JOBRND=${RANDOM}_fr_emiss_pert
#         ${JOB_CONTROL_SCRIPTS_DIR}/job_script_nasa.ksh ${JOBRND} ${GENERAL_JOB_CLASS} ${GENERAL_TIME_LIMIT} ${GENERAL_NODES} ${GENERAL_TASKS} perturb_chem_emiss_CORR_RT_CONST.exe SERIAL ${ACCOUNT}
#         qsub -Wblock=true job.ksh
#
# ADVANCE TIME
         (( NL_EMISS_TIME=${NL_EMISS_TIME} + 1 ))
         export L_DATE=$(${BUILD_DIR}/da_advance_time.exe ${L_DATE} 1 2>/dev/null)
      done
#
#########################################################################
#
# PROPOGATE HISTORICAL AND DART EMISSIONS ADJUSTMENT FROM PREVIOIS CYCLE
#
#########################################################################
#
# COPY FILES FOR HISTORICAL EMISSIONS PROPAGATION
      if [[ ${DATE} -gt  ${FIRST_EMISS_INV_DATE} && ${L_ADD_EMISS} = "true" ]]; then
         TRANDOM=$$
         let MEM=1
         while [[ ${MEM} -le ${NUM_MEMBERS} ]]; do
            export CMEM=e${MEM}
            if [[ ${MEM} -lt 100 ]]; then export CMEM=e0${MEM}; fi
            if [[ ${MEM} -lt 10  ]]; then export CMEM=e00${MEM}; fi
            rm -rf wrfchemi_d${CR_DOMAIN}_${PAST_FILE_DATE}.${CMEM}_prior
            rm -rf wrfchemi_d${CR_DOMAIN}_${PAST_FILE_DATE}.${CMEM}_post
            rm -rf wrffirechemi_d${CR_DOMAIN}_${PAST_FILE_DATE}.${CMEM}_prior
            rm -rf wrffirechemi_d${CR_DOMAIN}_${PAST_FILE_DATE}.${CMEM}_post
            cp ${RUN_DIR}/${PAST_DATE}/wrfchem_chem_emiss/wrfchemi_d${CR_DOMAIN}_${PAST_FILE_DATE}.${CMEM}_old ./wrfchemi_d${CR_DOMAIN}_${PAST_FILE_DATE}.${CMEM}_prior
            cp ${RUN_DIR}/${PAST_DATE}/dart_filter/wrfchemi_d${CR_DOMAIN}_${PAST_FILE_DATE}.${CMEM} ./wrfchemi_d${CR_DOMAIN}_${PAST_FILE_DATE}.${CMEM}_post
            cp ${RUN_DIR}/${PAST_DATE}/wrfchem_chem_emiss/wrffirechemi_d${CR_DOMAIN}_${PAST_FILE_DATE}.${CMEM}_old ./wrffirechemi_d${CR_DOMAIN}_${PAST_FILE_DATE}.${CMEM}_prior
            cp ${RUN_DIR}/${PAST_DATE}/dart_filter/wrffirechemi_d${CR_DOMAIN}_${PAST_FILE_DATE}.${CMEM} ./wrffirechemi_d${CR_DOMAIN}_${PAST_FILE_DATE}.${CMEM}_post
#
            export L_DATE=${DATE}
            export LE_DATE=$(${BUILD_DIR}/da_advance_time.exe ${L_DATE} ${FCST_PERIOD} 2>/dev/null)
            while [[ ${L_DATE} -le ${LE_DATE} ]] ; do
               export L_YYYY=$(echo $L_DATE | cut -c1-4)
               export L_MM=$(echo $L_DATE | cut -c5-6)
               export L_DD=$(echo $L_DATE | cut -c7-8)
               export L_HH=$(echo $L_DATE | cut -c9-10)
	       export L_FILE_DATE=${L_YYYY}-${L_MM}-${L_DD}_${L_HH}:00:00
#
	       cp wrfchemi_d${CR_DOMAIN}_${L_FILE_DATE}.${CMEM} wrfchemi_d${CR_DOMAIN}_${L_FILE_DATE}.${CMEM}_old
               cp wrffirechemi_d${CR_DOMAIN}_${L_FILE_DATE}.${CMEM} wrffirechemi_d${CR_DOMAIN}_${L_FILE_DATE}.${CMEM}_old
               cp wrfchemi_d${CR_DOMAIN}_${L_FILE_DATE}.${CMEM}_old wrfchemi_d${CR_DOMAIN}_${L_FILE_DATE}.${CMEM}_new
               cp wrffirechemi_d${CR_DOMAIN}_${L_FILE_DATE}.${CMEM}_old wrffirechemi_d${CR_DOMAIN}_${L_FILE_DATE}.${CMEM}_new
#
# Set up namelist input file for adding the prior emissions adjustments
               export NL_WRFCHEMI_PRIOR=wrfchemi_d${CR_DOMAIN}_${PAST_FILE_DATE}.${CMEM}_prior
               export NL_WRFCHEMI_POST=wrfchemi_d${CR_DOMAIN}_${PAST_FILE_DATE}.${CMEM}_post
               export NL_WRFCHEMI_OLD=wrfchemi_d${CR_DOMAIN}_${L_FILE_DATE}.${CMEM}_old
               export NL_WRFCHEMI_NEW=wrfchemi_d${CR_DOMAIN}_${L_FILE_DATE}.${CMEM}_new
#
               export NL_WRFFIRECHEMI_PRIOR=wrffirechemi_d${CR_DOMAIN}_${PAST_FILE_DATE}.${CMEM}_prior
               export NL_WRFFIRECHEMI_POST=wrffirechemi_d${CR_DOMAIN}_${PAST_FILE_DATE}.${CMEM}_post
               export NL_WRFFIRECHEMI_OLD=wrffirechemi_d${CR_DOMAIN}_${L_FILE_DATE}.${CMEM}_old
               export NL_WRFFIRECHEMI_NEW=wrffirechemi_d${CR_DOMAIN}_${L_FILE_DATE}.${CMEM}_new
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
               ./adjust_chem_emiss.exe > index_adjust_chem_emiss
#               export JOBRND=${TRANDOM}_adj
#               ${JOB_CONTROL_SCRIPTS_DIR}/job_script_nasa.ksh ${JOBRND} ${SINGLE_JOB_CLASS} ${SINGLE_TIME_LIMIT} ${SINGLE_NODES} ${SINGLE_TASKS} adjust_chem_emiss.exe SERIAL ${ACCOUNT}
#               qsub job.ksh
#
               export L_DATE=$(${BUILD_DIR}/da_advance_time.exe ${L_DATE} 1 2>/dev/null)
            done
            let MEM=MEM+1
         done
#         ${JOB_CONTROL_SCRIPTS_DIR}/da_run_hold_nasa.ksh ${TRANDOM}
#
         let MEM=1
         while [[ ${MEM} -le ${NUM_MEMBERS} ]]; do
            export CMEM=e${MEM}
            if [[ ${MEM} -lt 100 ]]; then export CMEM=e0${MEM}; fi
            if [[ ${MEM} -lt 10  ]]; then export CMEM=e00${MEM}; fi
            rm -rf wrfchemi_d${CR_DOMAIN}_${PAST_FILE_DATE}.${CMEM}_prior
            rm -rf wrfchemi_d${CR_DOMAIN}_${PAST_FILE_DATE}.${CMEM}_post
            rm -rf wrffirechemi_d${CR_DOMAIN}_${PAST_FILE_DATE}.${CMEM}_prior
            rm -rf wrffirechemi_d${CR_DOMAIN}_${PAST_FILE_DATE}.${CMEM}_post
            export L_DATE=${DATE}
            export LE_DATE=$(${BUILD_DIR}/da_advance_time.exe ${L_DATE} ${FCST_PERIOD} 2>/dev/null)
            while [[ ${L_DATE} -le ${LE_DATE} ]] ; do
               export L_YYYY=$(echo $L_DATE | cut -c1-4)
               export L_MM=$(echo $L_DATE | cut -c5-6)
               export L_DD=$(echo $L_DATE | cut -c7-8)
               export L_HH=$(echo $L_DATE | cut -c9-10)
	       export L_FILE_DATE=${L_YYYY}-${L_MM}-${L_DD}_${L_HH}:00:00
#
	       rm -rf wrfchemi_d${CR_DOMAIN}_${L_FILE_DATE}.${CMEM}
	       rm -rf wrffirechemi_d${CR_DOMAIN}_${L_FILE_DATE}.${CMEM}
               cp wrfchemi_d${CR_DOMAIN}_${L_FILE_DATE}.${CMEM}_new wrfchemi_d${CR_DOMAIN}_${L_FILE_DATE}.${CMEM}
               cp wrffirechemi_d${CR_DOMAIN}_${L_FILE_DATE}.${CMEM}_new wrffirechemi_d${CR_DOMAIN}_${L_FILE_DATE}.${CMEM}
#               rm -rf wrfchemi_d${CR_DOMAIN}_${L_FILE_DATE}.${CMEM}_old
#               rm -rf wrffirechemi_d${CR_DOMAIN}_${L_FILE_DATE}.${CMEM}_old
               rm -rf wrfchemi_d${CR_DOMAIN}_${L_FILE_DATE}.${CMEM}_new
               rm -rf wrffirechemi_d${CR_DOMAIN}_${L_FILE_DATE}.${CMEM}_new
#
               export L_DATE=$(${BUILD_DIR}/da_advance_time.exe ${L_DATE} 1 2>/dev/null)
            done
            let MEM=MEM+1
         done

      fi
   fi
#
########################################################################
#
# RUN MOPITT CO TOTAL_COL OBSERVATIONS
#
########################################################################
#
   if ${RUN_MOPITT_CO_TOTAL_COL_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/mopitt_co_total_col_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/mopitt_co_total_col_obs
         cd ${RUN_DIR}/${DATE}/mopitt_co_total_col_obs
      else
         cd ${RUN_DIR}/${DATE}/mopitt_co_total_col_obs
      fi
#
# SET MOPITT PARAMETERS
      export MOPITT_FILE_PRE=MOP02J-
      export MOPITT_FILE_EXT=-L2V10.1.3.beta.hdf   
      export OUTFILE=\'TEMP_FILE.dat\'
      export OUTFILE_NQ=TEMP_FILE.dat
      export MOP_OUTFILE=\'MOPITT_CO_${D_DATE}.dat\'
      export MOP_OUTFILE_NQ=MOPITT_CO_${D_DATE}.dat
      rm -rf ${OUTFILE}
      rm -rf ${MOP_OUTFILE}
#
#  SET OBS WINDOW
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      export FLG=0
      if [[ ${ASIM_MX_HH} -eq 3 ]]; then
         export FLG=1
         export BIN_BEG_HH=0
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
      fi
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
#
# SET MOPITT INPUT DATA FILE
      export MOP_INFILE=\'${EXPERIMENT_MOPITT_CO_DIR}/${MOPITT_FILE_PRE}${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}${MOPITT_FILE_EXT}\'
#
# COPY EXECUTABLE
#      export FILE=mopitt_v5_co_total_col_extract.m
      export FILE=mopitt_co_total_col_extract.pro
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/MOPITT_CO/native_to_ascii/${FILE} ./.
#
      rm -rf job.ksh
      touch job.ksh
      RANDOM=$$
      export JOBRND=${RANDOM}_idl_mopitt
      cat << EOFF > job.ksh
#!/bin/ksh -aeux
idl << EOF
.compile mopitt_co_total_col_extract.pro
mopitt_co_total_col_extract, ${MOP_INFILE}, ${OUTFILE}, ${BIN_BEG_SEC}, ${BIN_END_SEC}, ${NL_MIN_LON}, ${NL_MAX_LON}, ${NL_MIN_LAT}, ${NL_MAX_LAT}
EOF
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
#      qsub -Wblock=true job.ksh
      chmod +x job.ksh
      ./job.ksh > index_mat.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${MOP_OUTFILE_NQ} && -e ${OUTFILE_NQ} ]]; then
         touch ${MOP_OUTFILE_NQ}
         cat ${OUTFILE_NQ} >> ${MOP_OUTFILE_NQ}
	 rm -rf ${OUTFILE_NQ}
      elif [[ -e ${MOP_OUTFILE_NQ} && -e ${OUTFILE_NQ} ]]; then
         cat ${OUTFILE_NQ} >> ${MOP_OUTFILE_NQ}
	 rm -rf ${OUTFILE_NQ}
      fi
#
# END OF PREVIOUS DAY (hours 21 to 24 obs)
      if [[ ${FLG} -eq 1 ]];  then
         export BIN_BEG_HH=${ASIM_MN_HH}
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
         export BIN_END_HH=23
         export BIN_END_MN=59
         export BIN_END_SS=59
         let HH_BEG=${BIN_BEG_HH}
         let MN_BEG=${BIN_BEG_MN}
         let SS_BEG=${BIN_BEG_SS}
         let HH_END=${BIN_END_HH}
         let MN_END=${BIN_END_MN}
         let SS_END=${BIN_END_SS}
         let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
         let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
#
# SET MOPITT INPUT DATA FILE
#         export MOP_INFILE=\'${EXPERIMENT_MOPITT_CO_DIR}/${MOPITT_FILE_PRE}${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}${MOPITT_FILE_EXT}\'
	 export MOP_INFILE=\'${EXPERIMENT_MOPITT_CO_DIR}/${MOPITT_FILE_PRE}${ASIM_MN_YYYY}${ASIM_MN_MM}${ASIM_MN_DD}${MOPITT_FILE_EXT}\'
#
# COPY EXECUTABLE
#      export FILE=mopitt_v5_co_total_col_extract.m
         export FILE=mopitt_co_total_col_extract.pro
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/MOPITT_CO/native_to_ascii/${FILE} ./.
#
         rm -rf job.ksh
         touch job.ksh
         RANDOM=$$
         export JOBRND=${RANDOM}_idl_mopitt
         cat << EOFF > job.ksh
#!/bin/ksh -aeux
idl << EOF
.compile mopitt_co_total_col_extract.pro
mopitt_co_total_col_extract, ${MOP_INFILE}, ${OUTFILE}, ${BIN_BEG_SEC}, ${BIN_END_SEC}, ${NL_MIN_LON}, ${NL_MAX_LON}, ${NL_MIN_LAT}, ${NL_MAX_LAT}
EOF
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
#         qsub -Wblock=true job.ksh 
         chmod +x job.ksh
         ./job.ksh > index_mat.html 2>&1
      fi   
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${MOP_OUTFILE_NQ} && -e ${OUTFILE_NQ} ]]; then
         touch ${MOP_OUTFILE_NQ}
         cat ${OUTFILE_NQ} >> ${MOP_OUTFILE_NQ}
	 rm -rf ${OUTFILE_NQ}
      elif [[ -e ${MOP_OUTFILE_NQ} && -e ${OUTFILE_NQ} ]]; then
         cat ${OUTFILE_NQ} >> ${MOP_OUTFILE_NQ}
	 rm -rf ${OUTFILE_NQ}
      fi
      if [[ ! -e ${MOP_OUTFILE_NQ} ]]; then
         touch NO_MOPITT_CO_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT MOPITT ASCII TO OBS_SEQ 
      export NL_YEAR=${D_YYYY}
      export NL_MONTH=${D_MM}
      export NL_DAY=${D_DD}
      export NL_HOUR=${D_HH}
      cp MOPITT_CO_${D_DATE}.dat ${D_DATE}.dat
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=${D_DATE}.dat
      export NL_MOP_OUTFILE=obs_seq_mopitt_co_total_col_${DATE}.out
      export NL_MOPITT_CO_RETRIEVAL_TYPE=\'${RETRIEVAL_TYPE_MOPITT}\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_MOPITT_CO}
      export NL_USE_LOG_CO=${USE_LOG_CO_LOGIC}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
#
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#
# USE MOPITT DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_mopitt_input_nml.ksh
#
# CREATE BIAS CORRECTION NAMELIST
      export NL_DOES_FILE_EXIST=.true.
      if [[ ${DATE} -eq ${FIRST_FILTER_DATE} || ${RUN_BIAS_CORRECTION} == false ]]; then
         rm -rf ${NL_CORRECTION_FILENAME}
         export NL_DOES_FILE_EXIST=.false.
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
correction_filename=${NL_CORRECTION_FILENAME}
nobs=1
obs_list='TROPOMI_CO_COL'
/
EOF
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/MOPITT_CO/work/mopitt_co_total_col_ascii_to_obs ./.
      ./mopitt_co_total_col_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ ! -s ${NL_MOP_OUTFILE} ]]; then
         touch NO_MOPITT_CO_${DATE}
      fi
   fi
#
########################################################################
#
# RUN MOPITT CO PROFILE OBSERVATIONS
#
########################################################################
#
   if ${RUN_MOPITT_CO_PROFILE_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/mopitt_co_profile_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/mopitt_co_profile_obs
         cd ${RUN_DIR}/${DATE}/mopitt_co_profile_obs
      else
         cd ${RUN_DIR}/${DATE}/mopitt_co_profile_obs
      fi
#
# SET MOPITT PARAMETERS
      export MOPITT_FILE_PRE=MOP02J-
      export MOPITT_FILE_EXT=-L2V10.1.3.beta.hdf   
      export OUTFILE=\'TEMP_FILE.dat\'
      export OUTFILE_NQ=TEMP_FILE.dat
      export MOP_OUTFILE=\'MOPITT_CO_${D_DATE}.dat\'
      export MOP_OUTFILE_NQ=MOPITT_CO_${D_DATE}.dat
      rm -rf ${OUTFILE}
      rm -rf ${MOP_OUTFILE}
#
#  SET OBS WINDOW
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      export FLG=0
      if [[ ${ASIM_MX_HH} -eq 3 ]]; then
         export FLG=1
         export BIN_BEG_HH=0
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
      fi
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
#
# SET MOPITT INPUT DATA FILE
      export MOP_INFILE=\'${EXPERIMENT_MOPITT_CO_DIR}/${MOPITT_FILE_PRE}${YYYY}${MM}${DD}${MOPITT_FILE_EXT}\'
#
# COPY EXECUTABLE
#      export FILE=mopitt_v5_co_profile_extract.m
      export FILE=mopitt_co_profile_extract.pro
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/MOPITT_CO/native_to_ascii/${FILE} ./.
#
      rm -rf job.ksh
      touch job.ksh
      RANDOM=$$
      export JOBRND=${RANDOM}_idl_mopitt
      cat << EOFF > job.ksh
#!/bin/ksh -aeux
idl << EOF
.compile mopitt_co_profile_extract.pro
mopitt_co_profile_extract, ${MOP_INFILE}, ${OUTFILE}, ${BIN_BEG_SEC}, ${BIN_END_SEC}, ${NL_MIN_LON}, ${NL_MAX_LON}, ${NL_MIN_LAT}, ${NL_MAX_LAT}
EOF
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
#      qsub -Wblock=true job.ksh
      chmod +x job.ksh
      ./job.ksh > index_mat.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${MOP_OUTFILE_NQ} && -e ${OUTFILE_NQ} ]]; then
         touch ${MOP_OUTFILE_NQ}
         cat ${OUTFILE_NQ} >> ${MOP_OUTFILE_NQ}
	 rm -rf ${OUTFILE_NQ}
      elif [[ -e ${MOP_OUTFILE_NQ} && -e ${OUTFILE_NQ} ]]; then
         cat ${OUTFILE_NQ} >> ${MOP_OUTFILE_NQ}
	 rm -rf ${OUTFILE_NQ}
      fi
#
# END OF PREVIOUS DAY (hours 21 to 24 obs)
      if [[ ${FLG} -eq 1 ]];  then
         export BIN_BEG_HH=${ASIM_MN_HH}
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
         export BIN_END_HH=23
         export BIN_END_MN=59
         export BIN_END_SS=59
         let HH_BEG=${BIN_BEG_HH}
         let MN_BEG=${BIN_BEG_MN}
         let SS_BEG=${BIN_BEG_SS}
         let HH_END=${BIN_END_HH}
         let MN_END=${BIN_END_MN}
         let SS_END=${BIN_END_SS}
         let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
         let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
#
# SET MOPITT INPUT DATA FILE
	 export MOP_INFILE=\'${EXPERIMENT_MOPITT_CO_DIR}/${MOPITT_FILE_PRE}${ASIM_MN_YYYY}${ASIM_MN_MM}${ASIM_MN_DD}${MOPITT_FILE_EXT}\'
#
# COPY EXECUTABLE
#      export FILE=mopitt_v5_co_profile_extract.m
         export FILE=mopitt_co_profile_extract.pro
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/MOPITT_CO/native_to_ascii/${FILE} ./.
#
         rm -rf job.ksh
         touch job.ksh
         RANDOM=$$
         export JOBRND=${RANDOM}_idl_mopitt
         cat << EOFF > job.ksh
#!/bin/ksh -aeux
idl << EOF
.compile mopitt_co_profile_extract.pro
mopitt_co_profile_extract, ${MOP_INFILE}, ${OUTFILE}, ${BIN_BEG_SEC}, ${BIN_END_SEC}, ${NL_MIN_LON}, ${NL_MAX_LON}, ${NL_MIN_LAT}, ${NL_MAX_LAT}
EOF
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
#         qsub -Wblock=true job.ksh 
         chmod +x job.ksh
         ./job.ksh > index_mat.html 2>&1
      fi   
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${MOP_OUTFILE_NQ} && -e ${OUTFILE_NQ} ]]; then
         touch ${MOP_OUTFILE_NQ}
         cat ${OUTFILE_NQ} >> ${MOP_OUTFILE_NQ}
	 rm -rf ${OUTFILE_NQ}
      elif [[ -e ${MOP_OUTFILE_NQ} && -e ${OUTFILE_NQ} ]]; then
         cat ${OUTFILE_NQ} >> ${MOP_OUTFILE_NQ}
	 rm -rf ${OUTFILE_NQ}
      fi
      if [[ ! -e ${MOP_OUTFILE_NQ} ]]; then
         touch NO_MOPITT_CO_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT MOPITT ASCII TO OBS_SEQ 
      export NL_YEAR=${D_YYYY}
      export NL_MONTH=${D_MM}
      export NL_DAY=${D_DD}
      export NL_HOUR=${D_HH}
      cp MOPITT_CO_${D_DATE}.dat ${D_DATE}.dat
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=${D_DATE}.dat
      export NL_MOP_OUTFILE=obs_seq_mopitt_co_profile_${DATE}.out
      export NL_MOPITT_CO_RETRIEVAL_TYPE=\'${RETRIEVAL_TYPE_MOPITT}\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_MOPITT_CO}
      export NL_USE_LOG_CO=${USE_LOG_CO_LOGIC}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
#
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#
# USE MOPITT DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_mopitt_input_nml.ksh
#
# CREATE BIAS CORRECTION NAMELIST
      export NL_DOES_FILE_EXIST=.true.
      if [[ ${DATE} -eq ${FIRST_FILTER_DATE} || ${RUN_BIAS_CORRECTION} == false ]]; then
         rm -rf ${NL_CORRECTION_FILENAME}
         export NL_DOES_FILE_EXIST=.false.
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
correction_filename=${NL_CORRECTION_FILENAME}
nobs=1
obs_list='TROPOMI_CO_COL'
/
EOF
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/MOPITT_CO/work/mopitt_co_profile_ascii_to_obs ./.
      ./mopitt_co_profile_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ ! -s ${NL_MOP_OUTFILE} ]]; then
         touch NO_MOPITT_CO_${DATE}
      fi
   fi
#
########################################################################
#
# RUN MOPITT CO CPSR OBSERVATIONS
#
########################################################################
#
   if ${RUN_MOPITT_CO_CPSR_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/mopitt_co_cpsr_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/mopitt_co_cpsr_obs
         cd ${RUN_DIR}/${DATE}/mopitt_co_cpsr_obs
      else
         cd ${RUN_DIR}/${DATE}/mopitt_co_cpsr_obs
      fi
#
# SET MOPITT PARAMETERS
      export MOPITT_FILE_PRE=MOP02J-
      export MOPITT_FILE_EXT=-L2V10.1.3.beta.hdf   
      export OUTFILE=\'TEMP_FILE.dat\'
      export OUTFILE_NQ=TEMP_FILE.dat
      export MOP_OUTFILE=\'MOPITT_CO_${D_DATE}.dat\'
      export MOP_OUTFILE_NQ=MOPITT_CO_${D_DATE}.dat
      rm -rf ${OUTFILE}
      rm -rf ${MOP_OUTFILE}
#
#  SET OBS WINDOW
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      export FLG=0
      if [[ ${ASIM_MX_HH} -eq 3 ]]; then
         export FLG=1
         export BIN_BEG_HH=0
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
      fi
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
#
# SET MOPITT INPUT DATA FILE
      export MOP_INFILE=\'${EXPERIMENT_MOPITT_CO_DIR}/${MOPITT_FILE_PRE}${YYYY}${MM}${DD}${MOPITT_FILE_EXT}\'
#
# COPY EXECUTABLE
#      export FILE=mopitt_v5_co_cpsr_extract.m
      export FILE=mopitt_co_cpsr_extract.pro
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/MOPITT_CO/native_to_ascii/${FILE} ./.
#
      rm -rf job.ksh
      touch job.ksh
      RANDOM=$$
      export JOBRND=${RANDOM}_idl_mopitt
      cat << EOFF > job.ksh
#!/bin/ksh -aeux
idl << EOF
.compile mopitt_co_cpsr_extract.pro
mopitt_co_cpsr_extract, ${MOP_INFILE}, ${OUTFILE}, ${BIN_BEG_SEC}, ${BIN_END_SEC}, ${NL_MIN_LON}, ${NL_MAX_LON}, ${NL_MIN_LAT}, ${NL_MAX_LAT}
EOF
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
#      qsub -Wblock=true job.ksh
      chmod +x job.ksh
      ./job.ksh > index_mat.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${MOP_OUTFILE_NQ} && -e ${OUTFILE_NQ} ]]; then
         touch ${MOP_OUTFILE_NQ}
         cat ${OUTFILE_NQ} >> ${MOP_OUTFILE_NQ}
	 rm -rf ${OUTFILE_NQ}
      elif [[ -e ${MOP_OUTFILE_NQ} && -e ${OUTFILE_NQ} ]]; then
         cat ${OUTFILE_NQ} >> ${MOP_OUTFILE_NQ}
	 rm -rf ${OUTFILE_NQ}
      fi
#
# END OF PREVIOUS DAY (hours 21 to 24 obs)
      if [[ ${FLG} -eq 1 ]];  then
         export BIN_BEG_HH=${ASIM_MN_HH}
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
         export BIN_END_HH=23
         export BIN_END_MN=59
         export BIN_END_SS=59
         let HH_BEG=${BIN_BEG_HH}
         let MN_BEG=${BIN_BEG_MN}
         let SS_BEG=${BIN_BEG_SS}
         let HH_END=${BIN_END_HH}
         let MN_END=${BIN_END_MN}
         let SS_END=${BIN_END_SS}
         let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
         let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
#
# SET MOPITT INPUT DATA FILE
	 export MOP_INFILE=\'${EXPERIMENT_MOPITT_CO_DIR}/${MOPITT_FILE_PRE}${ASIM_MN_YYYY}${ASIM_MN_MM}${ASIM_MN_DD}${MOPITT_FILE_EXT}\'
#
# COPY EXECUTABLE
#      export FILE=mopitt_v5_co_cpsr_extract.m
         export FILE=mopitt_co_cpsr_extract.pro
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/MOPITT_CO/native_to_ascii/${FILE} ./.
#
         rm -rf job.ksh
         touch job.ksh
         RANDOM=$$
         export JOBRND=${RANDOM}_idl_mopitt
         cat << EOFF > job.ksh
#!/bin/ksh -aeux
idl << EOF
.compile mopitt_co_cpsr_extract.pro
mopitt_co_cpsr_extract, ${MOP_INFILE}, ${OUTFILE}, ${BIN_BEG_SEC}, ${BIN_END_SEC}, ${NL_MIN_LON}, ${NL_MAX_LON}, ${NL_MIN_LAT}, ${NL_MAX_LAT}
EOF
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
#         qsub -Wblock=true job.ksh 
         chmod +x job.ksh
         ./job.ksh > index_mat.html 2>&1
      fi   
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${MOP_OUTFILE_NQ} && -e ${OUTFILE_NQ} ]]; then
         touch ${MOP_OUTFILE_NQ}
         cat ${OUTFILE_NQ} >> ${MOP_OUTFILE_NQ}
	 rm -rf ${OUTFILE_NQ}
      elif [[ -e ${MOP_OUTFILE_NQ} && -e ${OUTFILE_NQ} ]]; then
         cat ${OUTFILE_NQ} >> ${MOP_OUTFILE_NQ}
	 rm -rf ${OUTFILE_NQ}
      fi
      if [[ ! -e ${MOP_OUTFILE_NQ} ]]; then
         touch NO_MOPITT_CO_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT MOPITT ASCII TO OBS_SEQ 
      export NL_YEAR=${D_YYYY}
      export NL_MONTH=${D_MM}
      export NL_DAY=${D_DD}
      export NL_HOUR=${D_HH}
      cp MOPITT_CO_${D_DATE}.dat ${D_DATE}.dat
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=${D_DATE}.dat
      export NL_MOP_OUTFILE=obs_seq_mopitt_co_cpsr_${DATE}.out
      export NL_MOPITT_CO_RETRIEVAL_TYPE=\'${RETRIEVAL_TYPE_MOPITT}\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_MOPITT_CO}
      export NL_USE_LOG_CO=${USE_LOG_CO_LOGIC}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
#
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#
# USE MOPITT DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_mopitt_input_nml.ksh
#
# CREATE BIAS CORRECTION NAMELIST
      export NL_DOES_FILE_EXIST=.true.
      if [[ ${DATE} -eq ${FIRST_FILTER_DATE} || ${RUN_BIAS_CORRECTION} == false ]]; then
         rm -rf ${NL_CORRECTION_FILENAME}
         export NL_DOES_FILE_EXIST=.false.
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
correction_filename=${NL_CORRECTION_FILENAME}
nobs=1
obs_list='TROPOMI_CO_COL'
/
EOF
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/MOPITT_CO/work/mopitt_co_cpsr_ascii_to_obs ./.
      ./mopitt_co_cpsr_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ ! -s ${NL_MOP_OUTFILE} ]]; then
         touch NO_MOPITT_CO_${DATE}
      fi
   fi
#
#########################################################################
#
# RUN IASI CO PROFILE OBSERVATIONS
#
#########################################################################
#
   if ${RUN_IASI_CO_PROFILE_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/iasi_co_profile_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/iasi_co_profile_obs
         cd ${RUN_DIR}/${DATE}/iasi_co_profile_obs
      else
         cd ${RUN_DIR}/${DATE}/iasi_co_profile_obs
      fi
#
# SET IASI PARAMETERS
      export IASI_FILE_PRE='VERSION2_NCAR_IASI_xxx_1C_M02'
      export IASI_FILE_EXT='hdf'
      export OUTFILE=\'TEMP_FILE.dat\'
      export OUTFILE_NQ=TEMP_FILE.dat
      export IAS_OUTFILE=\'IASI_CO_${D_DATE}.dat\'
      export IAS_OUTFILE_NQ=IASI_CO_${D_DATE}.dat
      let NCNT=4
      rm -rf ${OUTFILE_NQ}
      rm -rf ${IAS_OUTFILE_NQ}
#
#  SET OBS WINDOW
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      export FLG=0
      if [[ ${ASIM_MX_HH} -eq 3 ]]; then
         export FLG=1
         export BIN_BEG_HH=0
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
      fi
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
#
# SET IASI INPUT DATA FILE
      export A_DATE=${DATE}
      while [[ ${A_DATE} -le ${ASIM_MAX_DATE} ]]; do 
         export A_YY=$(echo $A_DATE | cut -c1-4)
         export A_MM=$(echo $A_DATE | cut -c5-6)
         export A_DD=$(echo $A_DATE | cut -c7-8)
         export A_HH=$(echo $A_DATE | cut -c9-10)
	 export A_DATE=${A_YY}${A_MM}${A_DD}${A_HH}
	 export A_DIR=${A_YY}/${A_MM}/${A_DD}
         export ICNT=0
         while [[ ${ICNT} -le ${NCNT} ]]; do
            export TEST=$($BUILD_DIR/da_advance_time.exe ${A_DATE} ${ICNT} 2>/dev/null)
            export ND_YY=$(echo $TEST | cut -c1-4)
            export ND_MM=$(echo $TEST | cut -c5-6)
            export ND_DD=$(echo $TEST | cut -c7-8)
            export ND_HH=$(echo $TEST | cut -c9-10)
	    export ND_DATE=${ND_YY}${ND_MM}${ND_DD}${ND_HH}
            export FILEIN=`ls ${EXPERIMENT_IASI_CO_DIR}/${A_DIR}/${IASI_FILE_PRE}_${A_DATE}*Z_${ND_DATE}*Z_*`
            if [[ -e ${FILEIN} ]]; then 
               export IAS_FILEIN=\'${FILEIN}\'
#
# COPY_EXECUTABLE
               export FILE=iasi_co_profile_extract.pro
               rm -rf ${FILE}
               cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/IASI_CO/native_to_ascii/${FILE} ./.
#
               rm -rf job.ksh
               touch job.ksh
               RANDOM=$$
               export JOBRND=${RANDOM}_idl_iasi
               cat << EOFF > job.ksh
#!/bin/ksh -aeux
idl << EOF
.compile iasi_co_profile_extract.pro
iasi_co_profile_extract,${IAS_FILEIN},${OUTFILE},${BIN_BEG_SEC},${BIN_END_SEC},${NL_MIN_LON},${NL_MAX_LON},${NL_MIN_LAT},${NL_MAX_LAT}
EOF
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
#               qsub -Wblock=true job.ksh 
               chmod +x job.ksh
               ./job.ksh > index_mat.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
               if [[ ! -e ${IAS_OUTFILE_NQ} && -e ${OUTFILE_NQ} ]]; then
                  touch ${IAS_OUTFILE_NQ}
                  cat ${OUTFILE_NQ} >> ${IAS_OUTFILE_NQ}
#	          rm -rf ${OUTFILE_NQ}
               elif [[ -e ${IAS_OUTFILE_NQ} && -e ${OUTFILE_NQ} ]]; then
                  cat ${OUTFILE_NQ} >> ${IAS_OUTFILE_NQ}
#	          rm -rf ${OUTFILE_NQ}
               fi
            fi
            (( ICNT=${ICNT}+1 ))
         done
         export A_DATE=$(${BUILD_DIR}/da_advance_time.exe ${A_DATE} 1 2>/dev/null)
      done
#
# END OF PREVIOUS DAY (hours 21 to 24 obs)
      if [[ ${FLG} -eq 1 ]]; then
         export BIN_BEG_HH=${ASIM_MN_HH}
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
         export BIN_END_HH=23
         export BIN_END_MN=59
         export BIN_END_SS=59
         let HH_BEG=${BIN_BEG_HH}
         let MN_BEG=${BIN_BEG_MN}
         let SS_BEG=${BIN_BEG_SS}
         let HH_END=${BIN_END_HH}
         let MN_END=${BIN_END_MN}
         let SS_END=${BIN_END_SS}
         let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
         let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
#
# SET IASI INPUT DATA FILE
	 export A_DATE=${ASIM_MIN_DATE}
         while [[ ${A_DATE} -le ${DATE} ]]; do 
            export A_YY=$(echo $A_DATE | cut -c1-4)
            export A_MM=$(echo $A_DATE | cut -c5-6)
            export A_DD=$(echo $A_DATE | cut -c7-8)
            export A_HH=$(echo $A_DATE | cut -c9-10)
   	    export A_DATE=${A_YY}${A_MM}${A_DD}${A_HH}
            export A_DIR=${A_YY}/${A_MM}/${A_DD}
            export ICNT=0
            while [[ ${ICNT} -le ${NCNT} ]]; do
               export TEST=$($BUILD_DIR/da_advance_time.exe ${A_DATE} ${ICNT} 2>/dev/null)
               export ND_YY=$(echo $TEST | cut -c1-4)
               export ND_MM=$(echo $TEST | cut -c5-6)
               export ND_DD=$(echo $TEST | cut -c7-8)
               export ND_HH=$(echo $TEST | cut -c9-10)
   	       export ND_DATE=${ND_YY}${ND_MM}${ND_DD}${ND_HH}
               export FILEIN=`ls ${EXPERIMENT_IASI_CO_DIR}/${A_DIR}/${IASI_FILE_PRE}_${ND_DATE}*Z_${ND_DATE=}*Z_*`
               if [[ -e ${FILEIN} ]]; then 
                  export IAS_FILEIN=\'${FILEIN}\'
#
# COPY_EXECUTABLE
                  export FILE=iasi_co_profile_extract.pro
                  rm -rf ${FILE}
                  cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/IASI_CO/native_to_ascii/${FILE} ./.
#
                  rm -rf job.ksh
                  touch job.ksh
                  RANDOM=$$
                  export JOBRND=${RANDOM}_idl_iasi
                  cat << EOFF > job.ksh
#!/bin/ksh -aeux
idl << EOF
.compile iasi_co_profile_extract.pro
iasi_co_profile_extract,${IAS_FILEIN},${OUTFILE},${BIN_BEG_SEC},${BIN_END_SEC},${NL_MIN_LON},${NL_MAX_LON},${NL_MIN_LAT},${NL_MAX_LAT}
EOF
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
#                  qsub -Wblock=true job.ksh 
                  chmod +x job.ksh
                  ./job.ksh > index_mat.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
                  if [[ ! -e ${IAS_OUTFILE_NQ} && -e ${OUTFILE_NQ} ]]; then
                     touch ${IAS_OUTFILE_NQ}
                     cat ${OUTFILE_NQ} >> ${IAS_OUTFILE_NQ}
#	             rm -rf ${OUTFILE_NQ}
                  elif [[ -e ${IAS_OUTFILE_NQ} && -e ${OUTFILE_NQ} ]]; then
                     cat ${OUTFILE_NQ} >> ${IAS_OUTFILE_NQ}
#	             rm -rf ${OUTFILE_NQ}
                  fi
	       fi
               (( ICNT=${ICNT}+1 ))
            done
            export A_DATE=$(${BUILD_DIR}/da_advance_time.exe ${A_DATE} 1 2>/dev/null)
         done
      fi
      if [[ ! -e ${IAS_OUTFILE_NQ} ]]; then
         touch NO_MOPITT_CO_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT IASI_CO ASCII TO OBS_SEQ 
      cp IASI_CO_${D_DATE}.dat ${D_DATE}.dat
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=${D_DATE}.dat
      export NL_IAS_OUTFILE=obs_seq_iasi_co_profile_${DATE}.out
      export NL_IASI_CO_RETRIEVAL_TYPE=\'${RETRIEVAL_TYPE_IASI}\'
      export NL_IASI_O3_RETRIEVAL_TYPE=\'${RETRIEVAL_TYPE_IASI}\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_IASI_CO}
      export NL_USE_LOG_CO=${USE_LOG_CO_LOGIC}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
#
      export NL_YEAR=${D_YYYY}
      export NL_MONTH=${D_MM}
      export NL_DAY=${D_DD}
      export NL_HOUR=${D_HH}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#
# USE IASI DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_iasi_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/IASI_CO/work/iasi_co_profile_ascii_to_obs ./.
      ./iasi_co_profile_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ ! -s ${NL_IAS_OUTFILE} ]]; then
         touch NO_IASI_CO_${DATE}
      fi
   fi
#
#########################################################################
#
# RUN IASI CO TOTAL_COL OBSERVATIONS
#
#########################################################################
#
   if ${RUN_IASI_CO_TOTAL_COL_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/iasi_co_total_col_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/iasi_co_total_col_obs
         cd ${RUN_DIR}/${DATE}/iasi_co_total_col_obs
      else
         cd ${RUN_DIR}/${DATE}/iasi_co_total_col_obs
      fi
#
# SET IASI PARAMETERS
      export IASI_FILE_PRE='VERSION2_NCAR_IASI_xxx_1C_M02'
      export IASI_FILE_EXT='hdf'
      export OUTFILE=\'TEMP_FILE.dat\'
      export OUTFILE_NQ=TEMP_FILE.dat
      export IAS_OUTFILE=\'IASI_CO_${D_DATE}.dat\'
      export IAS_OUTFILE_NQ=IASI_CO_${D_DATE}.dat
      let NCNT=4
      rm -rf ${OUTFILE_NQ}
      rm -rf ${IAS_OUTFILE_NQ}
#
#  SET OBS WINDOW
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      export FLG=0
      if [[ ${ASIM_MX_HH} -eq 3 ]]; then
         export FLG=1
         export BIN_BEG_HH=0
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
      fi
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
#
# SET IASI INPUT DATA FILE
      export A_DATE=${DATE}
      while [[ ${A_DATE} -le ${ASIM_MAX_DATE} ]]; do 
         export A_YY=$(echo $A_DATE | cut -c1-4)
         export A_MM=$(echo $A_DATE | cut -c5-6)
         export A_DD=$(echo $A_DATE | cut -c7-8)
         export A_HH=$(echo $A_DATE | cut -c9-10)
	 export A_DATE=${A_YY}${A_MM}${A_DD}${A_HH}
	 export A_DIR=${A_YY}/${A_MM}/${A_DD}
         export ICNT=0
         while [[ ${ICNT} -le ${NCNT} ]]; do
            export TEST=$($BUILD_DIR/da_advance_time.exe ${A_DATE} ${ICNT} 2>/dev/null)
            export ND_YY=$(echo $TEST | cut -c1-4)
            export ND_MM=$(echo $TEST | cut -c5-6)
            export ND_DD=$(echo $TEST | cut -c7-8)
            export ND_HH=$(echo $TEST | cut -c9-10)
	    export ND_DATE=${ND_YY}${ND_MM}${ND_DD}${ND_HH}
            export FILEIN=`ls ${EXPERIMENT_IASI_CO_DIR}/${A_DIR}/${IASI_FILE_PRE}_${A_DATE}*Z_${ND_DATE}*Z_*`
            if [[ -e ${FILEIN} ]]; then 
               export IAS_FILEIN=\'${FILEIN}\'
#
# COPY_EXECUTABLE
               export FILE=iasi_co_total_col_extract.pro
               rm -rf ${FILE}
               cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/IASI_CO/native_to_ascii/${FILE} ./.
#
               rm -rf job.ksh
               touch job.ksh
               RANDOM=$$
               export JOBRND=${RANDOM}_idl_iasi
               cat << EOFF > job.ksh
#!/bin/ksh -aeux
idl << EOF
.compile iasi_co_total_col_extract.pro
iasi_co_total_col_extract,${IAS_FILEIN},${OUTFILE},${BIN_BEG_SEC},${BIN_END_SEC},${NL_MIN_LON},${NL_MAX_LON},${NL_MIN_LAT},${NL_MAX_LAT}
EOF
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
#               qsub -Wblock=true job.ksh 
               chmod +x job.ksh
               ./job.ksh > index_mat.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
               if [[ ! -e ${IAS_OUTFILE_NQ} && -e ${OUTFILE_NQ} ]]; then
                  touch ${IAS_OUTFILE_NQ}
                  cat ${OUTFILE_NQ} >> ${IAS_OUTFILE_NQ}
#	          rm -rf ${OUTFILE_NQ}
               elif [[ -e ${IAS_OUTFILE_NQ} && -e ${OUTFILE_NQ} ]]; then
                  cat ${OUTFILE_NQ} >> ${IAS_OUTFILE_NQ}
#	          rm -rf ${OUTFILE_NQ}
               fi
            fi
            (( ICNT=${ICNT}+1 ))
         done
         export A_DATE=$(${BUILD_DIR}/da_advance_time.exe ${A_DATE} 1 2>/dev/null)
      done
#
# END OF PREVIOUS DAY (hours 21 to 24 obs)
      if [[ ${FLG} -eq 1 ]]; then
         export BIN_BEG_HH=${ASIM_MN_HH}
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
         export BIN_END_HH=23
         export BIN_END_MN=59
         export BIN_END_SS=59
         let HH_BEG=${BIN_BEG_HH}
         let MN_BEG=${BIN_BEG_MN}
         let SS_BEG=${BIN_BEG_SS}
         let HH_END=${BIN_END_HH}
         let MN_END=${BIN_END_MN}
         let SS_END=${BIN_END_SS}
         let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
         let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
#
# SET IASI INPUT DATA FILE
	 export A_DATE=${ASIM_MIN_DATE}
         while [[ ${A_DATE} -le ${DATE} ]]; do 
            export A_YY=$(echo $A_DATE | cut -c1-4)
            export A_MM=$(echo $A_DATE | cut -c5-6)
            export A_DD=$(echo $A_DATE | cut -c7-8)
            export A_HH=$(echo $A_DATE | cut -c9-10)
   	    export A_DATE=${A_YY}${A_MM}${A_DD}${A_HH}
            export A_DIR=${A_YY}/${A_MM}/${A_DD}
            export ICNT=0
            while [[ ${ICNT} -le ${NCNT} ]]; do
               export TEST=$($BUILD_DIR/da_advance_time.exe ${A_DATE} ${ICNT} 2>/dev/null)
               export ND_YY=$(echo $TEST | cut -c1-4)
               export ND_MM=$(echo $TEST | cut -c5-6)
               export ND_DD=$(echo $TEST | cut -c7-8)
               export ND_HH=$(echo $TEST | cut -c9-10)
   	       export ND_DATE=${ND_YY}${ND_MM}${ND_DD}${ND_HH}
               export FILEIN=`ls ${EXPERIMENT_IASI_CO_DIR}/${A_DIR}/${IASI_FILE_PRE}_${ND_DATE}*Z_${ND_DATE=}*Z_*`
               if [[ -e ${FILEIN} ]]; then 
                  export IAS_FILEIN=\'${FILEIN}\'
#
# COPY_EXECUTABLE
                  export FILE=iasi_co_total_col_extract.pro
                  rm -rf ${FILE}
                  cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/IASI_CO/native_to_ascii/${FILE} ./.
#
                  rm -rf job.ksh
                  touch job.ksh
                  RANDOM=$$
                  export JOBRND=${RANDOM}_idl_iasi
                  cat << EOFF > job.ksh
#!/bin/ksh -aeux
idl << EOF
.compile iasi_co_total_col_extract.pro
iasi_co_total_col_extract,${IAS_FILEIN},${OUTFILE},${BIN_BEG_SEC},${BIN_END_SEC},${NL_MIN_LON},${NL_MAX_LON},${NL_MIN_LAT},${NL_MAX_LAT}
EOF
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
#                  qsub -Wblock=true job.ksh 
                  chmod +x job.ksh
                  ./job.ksh > index_mat.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
                  if [[ ! -e ${IAS_OUTFILE_NQ} && -e ${OUTFILE_NQ} ]]; then
                     touch ${IAS_OUTFILE_NQ}
                     cat ${OUTFILE_NQ} >> ${IAS_OUTFILE_NQ}
#	             rm -rf ${OUTFILE_NQ}
                  elif [[ -e ${IAS_OUTFILE_NQ} && -e ${OUTFILE_NQ} ]]; then
                     cat ${OUTFILE_NQ} >> ${IAS_OUTFILE_NQ}
#	             rm -rf ${OUTFILE_NQ}
                  fi
	       fi
               (( ICNT=${ICNT}+1 ))
            done
            export A_DATE=$(${BUILD_DIR}/da_advance_time.exe ${A_DATE} 1 2>/dev/null)
         done
      fi
      if [[ ! -e ${IAS_OUTFILE_NQ} ]]; then
         touch NO_MOPITT_CO_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT IASI_CO ASCII TO OBS_SEQ 
      cp IASI_CO_${D_DATE}.dat ${D_DATE}.dat
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=${D_DATE}.dat
      export NL_IAS_OUTFILE=obs_seq_iasi_co_total_col_${DATE}.out
      export NL_IASI_CO_RETRIEVAL_TYPE=\'${RETRIEVAL_TYPE_IASI}\'
      export NL_IASI_O3_RETRIEVAL_TYPE=\'${RETRIEVAL_TYPE_IASI}\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_IASI_CO}
      export NL_USE_LOG_CO=${USE_LOG_CO_LOGIC}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
#
      export NL_YEAR=${D_YYYY}
      export NL_MONTH=${D_MM}
      export NL_DAY=${D_DD}
      export NL_HOUR=${D_HH}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#
# USE IASI DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_iasi_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/IASI_CO/work/iasi_co_total_col_ascii_to_obs ./.
      ./iasi_co_total_col_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ ! -s ${NL_IAS_OUTFILE} ]]; then
         touch NO_IASI_CO_${DATE}
      fi
   fi
#
#########################################################################
#
# RUN IASI CO PROFILE OBSERVATIONS
#
#########################################################################
#
   if ${RUN_IASI_CO_PROFILE_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/iasi_co_profile_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/iasi_co_profile_obs
         cd ${RUN_DIR}/${DATE}/iasi_co_profile_obs
      else
         cd ${RUN_DIR}/${DATE}/iasi_co_profile_obs
      fi
#
# SET IASI PARAMETERS
      export IASI_FILE_PRE='VERSION2_NCAR_IASI_xxx_1C_M02'
      export IASI_FILE_EXT='hdf'
      export OUTFILE=\'TEMP_FILE.dat\'
      export OUTFILE_NQ=TEMP_FILE.dat
      export IAS_OUTFILE=\'IASI_CO_${D_DATE}.dat\'
      export IAS_OUTFILE_NQ=IASI_CO_${D_DATE}.dat
      let NCNT=4
      rm -rf ${OUTFILE_NQ}
      rm -rf ${IAS_OUTFILE_NQ}
#
#  SET OBS WINDOW
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      export FLG=0
      if [[ ${ASIM_MX_HH} -eq 3 ]]; then
         export FLG=1
         export BIN_BEG_HH=0
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
      fi
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
#
# SET IASI INPUT DATA FILE
      export A_DATE=${DATE}
      while [[ ${A_DATE} -le ${ASIM_MAX_DATE} ]]; do 
         export A_YY=$(echo $A_DATE | cut -c1-4)
         export A_MM=$(echo $A_DATE | cut -c5-6)
         export A_DD=$(echo $A_DATE | cut -c7-8)
         export A_HH=$(echo $A_DATE | cut -c9-10)
	 export A_DATE=${A_YY}${A_MM}${A_DD}${A_HH}
	 export A_DIR=${A_YY}/${A_MM}/${A_DD}
         export ICNT=0
         while [[ ${ICNT} -le ${NCNT} ]]; do
            export TEST=$($BUILD_DIR/da_advance_time.exe ${A_DATE} ${ICNT} 2>/dev/null)
            export ND_YY=$(echo $TEST | cut -c1-4)
            export ND_MM=$(echo $TEST | cut -c5-6)
            export ND_DD=$(echo $TEST | cut -c7-8)
            export ND_HH=$(echo $TEST | cut -c9-10)
	    export ND_DATE=${ND_YY}${ND_MM}${ND_DD}${ND_HH}
            export FILEIN=`ls ${EXPERIMENT_IASI_CO_DIR}/${A_DIR}/${IASI_FILE_PRE}_${A_DATE}*Z_${ND_DATE}*Z_*`
            if [[ -e ${FILEIN} ]]; then 
               export IAS_FILEIN=\'${FILEIN}\'
#
# COPY_EXECUTABLE
               export FILE=iasi_co_profile_extract.pro
               rm -rf ${FILE}
               cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/IASI_CO/native_to_ascii/${FILE} ./.
#
               rm -rf job.ksh
               touch job.ksh
               RANDOM=$$
               export JOBRND=${RANDOM}_idl_iasi
               cat << EOFF > job.ksh
#!/bin/ksh -aeux
idl << EOF
.compile iasi_co_profile_extract.pro
iasi_co_profile_extract,${IAS_FILEIN},${OUTFILE},${BIN_BEG_SEC},${BIN_END_SEC},${NL_MIN_LON},${NL_MAX_LON},${NL_MIN_LAT},${NL_MAX_LAT}
EOF
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
#               qsub -Wblock=true job.ksh 
               chmod +x job.ksh
               ./job.ksh > index_mat.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
               if [[ ! -e ${IAS_OUTFILE_NQ} && -e ${OUTFILE_NQ} ]]; then
                  touch ${IAS_OUTFILE_NQ}
                  cat ${OUTFILE_NQ} >> ${IAS_OUTFILE_NQ}
#	          rm -rf ${OUTFILE_NQ}
               elif [[ -e ${IAS_OUTFILE_NQ} && -e ${OUTFILE_NQ} ]]; then
                  cat ${OUTFILE_NQ} >> ${IAS_OUTFILE_NQ}
#	          rm -rf ${OUTFILE_NQ}
               fi
            fi
            (( ICNT=${ICNT}+1 ))
         done
         export A_DATE=$(${BUILD_DIR}/da_advance_time.exe ${A_DATE} 1 2>/dev/null)
      done
#
# END OF PREVIOUS DAY (hours 21 to 24 obs)
      if [[ ${FLG} -eq 1 ]]; then
         export BIN_BEG_HH=${ASIM_MN_HH}
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
         export BIN_END_HH=23
         export BIN_END_MN=59
         export BIN_END_SS=59
         let HH_BEG=${BIN_BEG_HH}
         let MN_BEG=${BIN_BEG_MN}
         let SS_BEG=${BIN_BEG_SS}
         let HH_END=${BIN_END_HH}
         let MN_END=${BIN_END_MN}
         let SS_END=${BIN_END_SS}
         let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
         let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
#
# SET IASI INPUT DATA FILE
	 export A_DATE=${ASIM_MIN_DATE}
         while [[ ${A_DATE} -le ${DATE} ]]; do 
            export A_YY=$(echo $A_DATE | cut -c1-4)
            export A_MM=$(echo $A_DATE | cut -c5-6)
            export A_DD=$(echo $A_DATE | cut -c7-8)
            export A_HH=$(echo $A_DATE | cut -c9-10)
   	    export A_DATE=${A_YY}${A_MM}${A_DD}${A_HH}
            export A_DIR=${A_YY}/${A_MM}/${A_DD}
            export ICNT=0
            while [[ ${ICNT} -le ${NCNT} ]]; do
               export TEST=$($BUILD_DIR/da_advance_time.exe ${A_DATE} ${ICNT} 2>/dev/null)
               export ND_YY=$(echo $TEST | cut -c1-4)
               export ND_MM=$(echo $TEST | cut -c5-6)
               export ND_DD=$(echo $TEST | cut -c7-8)
               export ND_HH=$(echo $TEST | cut -c9-10)
   	       export ND_DATE=${ND_YY}${ND_MM}${ND_DD}${ND_HH}
               export FILEIN=`ls ${EXPERIMENT_IASI_CO_DIR}/${A_DIR}/${IASI_FILE_PRE}_${ND_DATE}*Z_${ND_DATE=}*Z_*`
               if [[ -e ${FILEIN} ]]; then 
                  export IAS_FILEIN=\'${FILEIN}\'
#
# COPY_EXECUTABLE
                  export FILE=iasi_co_profile_extract.pro
                  rm -rf ${FILE}
                  cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/IASI_CO/native_to_ascii/${FILE} ./.
#
                  rm -rf job.ksh
                  touch job.ksh
                  RANDOM=$$
                  export JOBRND=${RANDOM}_idl_iasi
                  cat << EOFF > job.ksh
#!/bin/ksh -aeux
idl << EOF
.compile iasi_co_profile_extract.pro
iasi_co_profile_extract,${IAS_FILEIN},${OUTFILE},${BIN_BEG_SEC},${BIN_END_SEC},${NL_MIN_LON},${NL_MAX_LON},${NL_MIN_LAT},${NL_MAX_LAT}
EOF
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
#                  qsub -Wblock=true job.ksh 
                  chmod +x job.ksh
                  ./job.ksh > index_mat.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
                  if [[ ! -e ${IAS_OUTFILE_NQ} && -e ${OUTFILE_NQ} ]]; then
                     touch ${IAS_OUTFILE_NQ}
                     cat ${OUTFILE_NQ} >> ${IAS_OUTFILE_NQ}
#	             rm -rf ${OUTFILE_NQ}
                  elif [[ -e ${IAS_OUTFILE_NQ} && -e ${OUTFILE_NQ} ]]; then
                     cat ${OUTFILE_NQ} >> ${IAS_OUTFILE_NQ}
#	             rm -rf ${OUTFILE_NQ}
                  fi
	       fi
               (( ICNT=${ICNT}+1 ))
            done
            export A_DATE=$(${BUILD_DIR}/da_advance_time.exe ${A_DATE} 1 2>/dev/null)
         done
      fi
      if [[ ! -e ${IAS_OUTFILE_NQ} ]]; then
         touch NO_MOPITT_CO_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT IASI_CO ASCII TO OBS_SEQ 
      cp IASI_CO_${D_DATE}.dat ${D_DATE}.dat
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=${D_DATE}.dat
      export NL_IAS_OUTFILE=obs_seq_iasi_co_profile_${DATE}.out
      export NL_IASI_CO_RETRIEVAL_TYPE=\'${RETRIEVAL_TYPE_IASI}\'
      export NL_IASI_O3_RETRIEVAL_TYPE=\'${RETRIEVAL_TYPE_IASI}\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_IASI_CO}
      export NL_USE_LOG_CO=${USE_LOG_CO_LOGIC}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
#
      export NL_YEAR=${D_YYYY}
      export NL_MONTH=${D_MM}
      export NL_DAY=${D_DD}
      export NL_HOUR=${D_HH}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#
# USE IASI DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_iasi_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/IASI_CO/work/iasi_co_profile_ascii_to_obs ./.
      ./iasi_co_profile_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ ! -s ${NL_IAS_OUTFILE} ]]; then
         touch NO_IASI_CO_${DATE}
      fi
   fi
#
#########################################################################
#
# RUN IASI CO CPSR OBSERVATIONS
#
#########################################################################
#
   if ${RUN_IASI_CO_CPSR_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/iasi_co_cpsr_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/iasi_co_cpsr_obs
         cd ${RUN_DIR}/${DATE}/iasi_co_cpsr_obs
      else
         cd ${RUN_DIR}/${DATE}/iasi_co_cpsr_obs
      fi
#
# SET IASI PARAMETERS
      export IASI_FILE_PRE='VERSION2_NCAR_IASI_xxx_1C_M02'
      export IASI_FILE_EXT='hdf'
      export OUTFILE=\'TEMP_FILE.dat\'
      export OUTFILE_NQ=TEMP_FILE.dat
      export IAS_OUTFILE=\'IASI_CO_${D_DATE}.dat\'
      export IAS_OUTFILE_NQ=IASI_CO_${D_DATE}.dat
      let NCNT=4
      rm -rf ${OUTFILE_NQ}
      rm -rf ${IAS_OUTFILE_NQ}
#
#  SET OBS WINDOW
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      export FLG=0
      if [[ ${ASIM_MX_HH} -eq 3 ]]; then
         export FLG=1
         export BIN_BEG_HH=0
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
      fi
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
#
# SET IASI INPUT DATA FILE
      export A_DATE=${DATE}
      while [[ ${A_DATE} -le ${ASIM_MAX_DATE} ]]; do 
         export A_YY=$(echo $A_DATE | cut -c1-4)
         export A_MM=$(echo $A_DATE | cut -c5-6)
         export A_DD=$(echo $A_DATE | cut -c7-8)
         export A_HH=$(echo $A_DATE | cut -c9-10)
	 export A_DATE=${A_YY}${A_MM}${A_DD}${A_HH}
	 export A_DIR=${A_YY}/${A_MM}/${A_DD}
         export ICNT=0
         while [[ ${ICNT} -le ${NCNT} ]]; do
            export TEST=$($BUILD_DIR/da_advance_time.exe ${A_DATE} ${ICNT} 2>/dev/null)
            export ND_YY=$(echo $TEST | cut -c1-4)
            export ND_MM=$(echo $TEST | cut -c5-6)
            export ND_DD=$(echo $TEST | cut -c7-8)
            export ND_HH=$(echo $TEST | cut -c9-10)
	    export ND_DATE=${ND_YY}${ND_MM}${ND_DD}${ND_HH}
            export FILEIN=`ls ${EXPERIMENT_IASI_CO_DIR}/${A_DIR}/${IASI_FILE_PRE}_${A_DATE}*Z_${ND_DATE}*Z_*`
            if [[ -e ${FILEIN} ]]; then 
               export IAS_FILEIN=\'${FILEIN}\'
#
# COPY_EXECUTABLE
               export FILE=iasi_co_cpsr_extract.pro
               rm -rf ${FILE}
               cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/IASI_CO/native_to_ascii/${FILE} ./.
#
               rm -rf job.ksh
               touch job.ksh
               RANDOM=$$
               export JOBRND=${RANDOM}_idl_iasi
               cat << EOFF > job.ksh
#!/bin/ksh -aeux
idl << EOF
.compile iasi_co_cpsr_extract.pro
iasi_co_cpsr_extract,${IAS_FILEIN},${OUTFILE},${BIN_BEG_SEC},${BIN_END_SEC},${NL_MIN_LON},${NL_MAX_LON},${NL_MIN_LAT},${NL_MAX_LAT}
EOF
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
#               qsub -Wblock=true job.ksh 
               chmod +x job.ksh
               ./job.ksh > index_mat.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
               if [[ ! -e ${IAS_OUTFILE_NQ} && -e ${OUTFILE_NQ} ]]; then
                  touch ${IAS_OUTFILE_NQ}
                  cat ${OUTFILE_NQ} >> ${IAS_OUTFILE_NQ}
#	          rm -rf ${OUTFILE_NQ}
               elif [[ -e ${IAS_OUTFILE_NQ} && -e ${OUTFILE_NQ} ]]; then
                  cat ${OUTFILE_NQ} >> ${IAS_OUTFILE_NQ}
#	          rm -rf ${OUTFILE_NQ}
               fi
            fi
            (( ICNT=${ICNT}+1 ))
         done
         export A_DATE=$(${BUILD_DIR}/da_advance_time.exe ${A_DATE} 1 2>/dev/null)
      done
#
# END OF PREVIOUS DAY (hours 21 to 24 obs)
      if [[ ${FLG} -eq 1 ]]; then
         export BIN_BEG_HH=${ASIM_MN_HH}
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
         export BIN_END_HH=23
         export BIN_END_MN=59
         export BIN_END_SS=59
         let HH_BEG=${BIN_BEG_HH}
         let MN_BEG=${BIN_BEG_MN}
         let SS_BEG=${BIN_BEG_SS}
         let HH_END=${BIN_END_HH}
         let MN_END=${BIN_END_MN}
         let SS_END=${BIN_END_SS}
         let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
         let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
#
# SET IASI INPUT DATA FILE
	 export A_DATE=${ASIM_MIN_DATE}
         while [[ ${A_DATE} -le ${DATE} ]]; do 
            export A_YY=$(echo $A_DATE | cut -c1-4)
            export A_MM=$(echo $A_DATE | cut -c5-6)
            export A_DD=$(echo $A_DATE | cut -c7-8)
            export A_HH=$(echo $A_DATE | cut -c9-10)
   	    export A_DATE=${A_YY}${A_MM}${A_DD}${A_HH}
            export A_DIR=${A_YY}/${A_MM}/${A_DD}
            export ICNT=0
            while [[ ${ICNT} -le ${NCNT} ]]; do
               export TEST=$($BUILD_DIR/da_advance_time.exe ${A_DATE} ${ICNT} 2>/dev/null)
               export ND_YY=$(echo $TEST | cut -c1-4)
               export ND_MM=$(echo $TEST | cut -c5-6)
               export ND_DD=$(echo $TEST | cut -c7-8)
               export ND_HH=$(echo $TEST | cut -c9-10)
   	       export ND_DATE=${ND_YY}${ND_MM}${ND_DD}${ND_HH}
               export FILEIN=`ls ${EXPERIMENT_IASI_CO_DIR}/${A_DIR}/${IASI_FILE_PRE}_${ND_DATE}*Z_${ND_DATE=}*Z_*`
               if [[ -e ${FILEIN} ]]; then 
                  export IAS_FILEIN=\'${FILEIN}\'
#
# COPY_EXECUTABLE
                  export FILE=iasi_co_cpsr_extract.pro
                  rm -rf ${FILE}
                  cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/IASI_CO/native_to_ascii/${FILE} ./.
#
                  rm -rf job.ksh
                  touch job.ksh
                  RANDOM=$$
                  export JOBRND=${RANDOM}_idl_iasi
                  cat << EOFF > job.ksh
#!/bin/ksh -aeux
idl << EOF
.compile iasi_co_cpsr_extract.pro
iasi_co_cpsr_extract,${IAS_FILEIN},${OUTFILE},${BIN_BEG_SEC},${BIN_END_SEC},${NL_MIN_LON},${NL_MAX_LON},${NL_MIN_LAT},${NL_MAX_LAT}
EOF
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
#                  qsub -Wblock=true job.ksh 
                  chmod +x job.ksh
                  ./job.ksh > index_mat.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
                  if [[ ! -e ${IAS_OUTFILE_NQ} && -e ${OUTFILE_NQ} ]]; then
                     touch ${IAS_OUTFILE_NQ}
                     cat ${OUTFILE_NQ} >> ${IAS_OUTFILE_NQ}
#	             rm -rf ${OUTFILE_NQ}
                  elif [[ -e ${IAS_OUTFILE_NQ} && -e ${OUTFILE_NQ} ]]; then
                     cat ${OUTFILE_NQ} >> ${IAS_OUTFILE_NQ}
#	             rm -rf ${OUTFILE_NQ}
                  fi
	       fi
               (( ICNT=${ICNT}+1 ))
            done
            export A_DATE=$(${BUILD_DIR}/da_advance_time.exe ${A_DATE} 1 2>/dev/null)
         done
      fi
      if [[ ! -e ${IAS_OUTFILE_NQ} ]]; then
         touch NO_MOPITT_CO_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT IASI_CO ASCII TO OBS_SEQ 
      cp IASI_CO_${D_DATE}.dat ${D_DATE}.dat
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=${D_DATE}.dat
      export NL_IAS_OUTFILE=obs_seq_iasi_co_cpsr_${DATE}.out
      export NL_IASI_CO_RETRIEVAL_TYPE=\'${RETRIEVAL_TYPE_IASI}\'
      export NL_IASI_O3_RETRIEVAL_TYPE=\'${RETRIEVAL_TYPE_IASI}\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_IASI_CO}
      export NL_USE_LOG_CO=${USE_LOG_CO_LOGIC}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
#
      export NL_YEAR=${D_YYYY}
      export NL_MONTH=${D_MM}
      export NL_DAY=${D_DD}
      export NL_HOUR=${D_HH}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#
# USE IASI DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_iasi_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/IASI_CO/work/iasi_co_cpsr_ascii_to_obs ./.
      ./iasi_co_cpsr_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ ! -s ${NL_IAS_OUTFILE} ]]; then
         touch NO_IASI_CO_${DATE}
      fi
   fi
#
#########################################################################
#
# RUN IASI O3 PROFILE OBSERVATIONS
#
#########################################################################
#
   if ${RUN_IASI_O3_PROFILE_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/iasi_o3_profile_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/iasi_o3_profile_obs
         cd ${RUN_DIR}/${DATE}/iasi_o3_profile_obs
      else
         cd ${RUN_DIR}/${DATE}/iasi_o3_profile_obs
      fi
#
# copy the IASI O3 error covariance file
      cp ${EXPERIMENT_IASI_O3_DIR}/IASI_apcov.dat ./
#
# set file prefix for IASI
# this depends on versions and file times (edit if necessary)
      export FILE_PRE='METOPA_IASI_EUMC_'
#
# set file suffix for IASI
# this depends on versions and file times (edit if necessary)
      export FILE_EXT='.dat'
#
      if [[ ${HH} == 00 ]]; then
#
# 00Z special case
         let TEMP_MIN_HH=${ASIM_MIN_HH}
         let TEMP_MAX_HH=${ASIM_MAX_HH}
         (( BIN_BEG_SEC=${TEMP_MIN_HH}*60*60+1 ))
         (( BIN_END_SEC=${TEMP_MAX_HH}*60*60 ))
         export ASIM_OUTFILE=${YYYY}${MM}${DD}${HH}.dat
         rm -rf ${ASIM_OUTFILE}
         touch ${ASIM_OUTFILE}
#
# Past date
         (( BIN_BEG_SEC=${TEMP_MIN_HH}*60*60+1 ))
         (( BIN_END_SEC=24*60*60 ))
         export FILE_COL=${EXPERIMENT_IASI_O3_DIR}/${FILE_PRE}${PAST_YYYY}${PAST_MM}${PAST_DD}_Columns${FILE_EXT}
         export FILE_ERR=${EXPERIMENT_IASI_O3_DIR}/${FILE_PRE}${PAST_YYYY}${PAST_MM}${PAST_DD}_ERROR${FILE_EXT}
         export FILE_VMR=${EXPERIMENT_IASI_O3_DIR}/${FILE_PRE}${PAST_YYYY}${PAST_MM}${PAST_DD}_VMR${FILE_EXT}
         if [[ -e ${FILE_COL} && -e ${FILE_ERR} && -e ${FILE_VMR} ]]; then 
            export OUTFILE_NM=TEMP_FILE.dat
            export INFILE_COL=\'${FILE_COL}\'
            export INFILE_ERR=\'${FILE_ERR}\'
            export INFILE_VMR=\'${FILE_VMR}\'
            export OUTFILE=\'${OUTFILE_NM}\'
#
# this is the call to an IDL routine to read and write variables
# if already processed (with output), then this can be skipped (do_iasi=0)
# else this needs to be called
            export FILE=iasi_o3_profile_extract.pro
            rm -rf ${FILE}
            cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/IASI_O3/native_to_ascii/${FILE} ./.
#
            rm -rf job.ksh
            touch job.ksh
            RANDOM=$$
            export JOBRND=${RANDOM}_idl_iasi
            cat << EOFF > job.ksh
#!/bin/ksh -aeux
idl << EOF
.compile iasi_o3_profile_extract.pro
iasi_o3_profile_extract,${INFILE_COL},${INFILE_ERR},${INFILE_VMR},${OUTFILE},${BIN_BEG_SEC},${BIN_END_SEC}, ${NL_MIN_LON}, ${NL_MAX_LON}, ${NL_MIN_LAT}, ${NL_MAX_LAT}, ${DATE}
EOF
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
#            qsub -Wblock=true job.ksh 
            chmod +x job.ksh
            ./job.ksh > index_m.html 2>&1
#
# cat the output file to the assimlation window file
            export ASIM_OUTFILE=${YYYY}${MM}${DD}${HH}.dat
            if [[ -e ${OUTFILE_NM} ]]; then
               cat ${OUTFILE_NM} >> ${ASIM_OUTFILE}
#               rm -rf ${OUTFILE_NM}
            fi
         else
            echo APM IASI O3 INPUT FILES DO NOT EXIST
         fi
      else
#
# OOZ, 06Z, 12Z, 18Z normal cases
         let TEMP_MIN_HH=${ASIM_MIN_HH}
         let TEMP_MAX_HH=${ASIM_MAX_HH}
         (( BIN_BEG_SEC=${TEMP_MIN_HH}*60*60+1 ))
         (( BIN_END_SEC=${TEMP_MAX_HH}*60*60 ))
         if [[ ${HH} == 00 ]]; then
            (( BIN_BEG_SEC=1 ))
            (( BIN_END_SEC=${TEMP_MAX_HH}*60*60 ))
         fi
         export ASIM_OUTFILE=${YYYY}${MM}${DD}${HH}.dat
         rm -rf ${ASIM_OUTFILE}
         touch ${ASIM_OUTFILE}
         export FILE_COL=${EXPERIMENT_IASI_O3_DIR}/${FILE_PRE}${YYYY}${MM}${DD}_Columns${FILE_EXT}
         export FILE_ERR=${EXPERIMENT_IASI_O3_DIR}/${FILE_PRE}${YYYY}${MM}${DD}_ERROR${FILE_EXT}
         export FILE_VMR=${EXPERIMENT_IASI_O3_DIR}/${FILE_PRE}${YYYY}${MM}${DD}_VMR${FILE_EXT}
         if [[ -e ${FILE_COL} && -e ${FILE_ERR} && -e ${FILE_VMR} ]]; then 
            export OUTFILE_NM=TEMP_FILE.dat
            export INFILE_COL=\'${FILE_COL}\'
            export INFILE_ERR=\'${FILE_ERR}\'
            export INFILE_VMR=\'${FILE_VMR}\'
            export OUTFILE=\'${OUTFILE_NM}\'
#
# this is the call to an IDL routine to read and write variables
# if already processed (with output), then this can be skipped (do_iasi=0)
# else this needs to be called
            export FILE=iasi_o3_profile_extract.pro
            rm -rf ${FILE}
            cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/IASI_O3/native_to_ascii/${FILE} ./.
#
            rm -rf job.ksh
            touch job.ksh
            RANDOM=$$
            export JOBRND=${RANDOM}_idl_iasi
            cat << EOFF > job.ksh
#!/bin/ksh -aeux
idl << EOF
.compile iasi_o3_profile_extract.pro
iasi_o3_profile_extract,${INFILE_COL},${INFILE_ERR},${INFILE_VMR},${OUTFILE},${BIN_BEG_SEC},${BIN_END_SEC}, ${NL_MIN_LON}, ${NL_MAX_LON}, ${NL_MIN_LAT}, ${NL_MAX_LAT}, ${DATE}
EOF
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
#            qsub -Wblock=true job.ksh 
            chmod +x job.ksh
            ./job.ksh > index_mat.html 2>&1
#
# cat the output file to the assimlation window file
            export ASIM_OUTFILE=${YYYY}${MM}${DD}${HH}.dat
            if [[ -e ${OUTFILE_NM} ]]; then
               cat ${OUTFILE_NM} >> ${ASIM_OUTFILE}
#               rm -rf ${OUTFILE_NM}
            fi
         else
            echo APM IASI O3 INPUT FILES DO NOT EXIST
         fi
      fi   
#
# RUN_IASI_ASCII_TO_DART
      if [[ ${HH} -eq 0 ]]; then
         export L_YYYY=${PAST_YYYY}
         export L_MM=${PAST_MM}
         export L_DD=${PAST_DD}
         export L_HH=24
         export D_DATE=${L_YYYY}${L_MM}${L_DD}${L_HH}
      else
         export L_YYYY=${YYYY}
         export L_MM=${MM}
         export L_DD=${DD}
         export L_HH=${HH}
         export D_DATE=${L_YYYY}${L_MM}${L_DD}${L_HH}
      fi
      export NL_YEAR=${L_YYYY}
      export NL_MONTH=${L_MM}
      export NL_DAY=${L_DD}
      export NL_HOUR=${L_HH}
      if [[ ${L_HH} -eq 24 ]]; then
         NL_BIN_BEG=21.01
         NL_BIN_END=3.00
      elif [[ ${L_HH} -eq 6 ]]; then
         NL_BIN_BEG=3.01
         NL_BIN_END=9.00
      elif [[ ${L_HH} -eq 12 ]]; then
         NL_BIN_BEG=9.01
         NL_BIN_END=15.00
      elif [[ ${L_HH} -eq 18 ]]; then
         NL_BIN_BEG=15.01
         NL_BIN_END=21.00
      fi
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=${D_DATE}.dat
      export NL_IASI_CO_RETRIEVAL_TYPE=\'${RETRIEVAL_TYPE_IASI}\'
      export NL_IASI_O3_RETRIEVAL_TYPE=\'${RETRIEVAL_TYPE_IASI}\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_IASI_O3}
      export NL_USE_LOG_CO=${USE_LOG_CO_LOGIC}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
#
# USE IASI DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_iasi_input_nml.ksh
#
# GET ASCII DATA
      if [[ ! -e ${D_DATE}.dat ]]; then 
         echo APM IASI O3 ASCII FILE DOES NOTE EXIST
         exit
      fi
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/IASI_O3/work/iasi_o3_profile_ascii_to_obs ./.
      ./iasi_o3_profile_ascii_to_obs > index.html 2>&1  
#
# COPY OUTPUT TO ARCHIVE LOCATION
      export IASI_FILE=iasi_obs_seq${D_DATE}
      if [[ -s ${IASI_FILE} ]]; then
         cp ${IASI_FILE} obs_seq_iasi_o3_profile_${DATE}.out
      else
         touch NO_DATA_${D_DATE}
      fi
   fi
#
#########################################################################
#
# RUN IASI O3 CPSR OBSERVATIONS
#
#########################################################################
#
   if ${RUN_IASI_O3_CPSR_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/iasi_o3_cpsr_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/iasi_o3_cpsr_obs
         cd ${RUN_DIR}/${DATE}/iasi_o3_cpsr_obs
      else
         cd ${RUN_DIR}/${DATE}/iasi_o3_cpsr_obs
      fi
#
# copy the IASI O3 error covariance file
      cp ${EXPERIMENT_IASI_O3_DIR}/IASI_apcov.dat ./
#
# set file prefix for IASI
# this depends on versions and file times (edit if necessary)
      export FILE_PRE='METOPA_IASI_EUMC_'
#
# set file suffix for IASI
# this depends on versions and file times (edit if necessary)
      export FILE_EXT='.dat'
#
      if [[ ${HH} == 00 ]]; then
#
# 00Z special case
         let TEMP_MIN_HH=${ASIM_MIN_HH}
         let TEMP_MAX_HH=${ASIM_MAX_HH}
         (( BIN_BEG_SEC=${TEMP_MIN_HH}*60*60+1 ))
         (( BIN_END_SEC=${TEMP_MAX_HH}*60*60 ))
         export ASIM_OUTFILE=${YYYY}${MM}${DD}${HH}.dat
         rm -rf ${ASIM_OUTFILE}
         touch ${ASIM_OUTFILE}
#
# Past date
         (( BIN_BEG_SEC=${TEMP_MIN_HH}*60*60+1 ))
         (( BIN_END_SEC=24*60*60 ))
         export FILE_COL=${EXPERIMENT_IASI_O3_DIR}/${FILE_PRE}${PAST_YYYY}${PAST_MM}${PAST_DD}_Columns${FILE_EXT}
         export FILE_ERR=${EXPERIMENT_IASI_O3_DIR}/${FILE_PRE}${PAST_YYYY}${PAST_MM}${PAST_DD}_ERROR${FILE_EXT}
         export FILE_VMR=${EXPERIMENT_IASI_O3_DIR}/${FILE_PRE}${PAST_YYYY}${PAST_MM}${PAST_DD}_VMR${FILE_EXT}
         if [[ -e ${FILE_COL} && -e ${FILE_ERR} && -e ${FILE_VMR} ]]; then 
            export OUTFILE_NM=TEMP_FILE.dat
            export INFILE_COL=\'${FILE_COL}\'
            export INFILE_ERR=\'${FILE_ERR}\'
            export INFILE_VMR=\'${FILE_VMR}\'
            export OUTFILE=\'${OUTFILE_NM}\'
#
# this is the call to an IDL routine to read and write variables
# if already processed (with output), then this can be skipped (do_iasi=0)
# else this needs to be called
            export FILE=iasi_o3_cpsr_extract.pro
            rm -rf ${FILE}
            cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/IASI_O3/native_to_ascii/${FILE} ./.
#
            rm -rf job.ksh
            touch job.ksh
            RANDOM=$$
            export JOBRND=${RANDOM}_idl_iasi
            cat << EOFF > job.ksh
#!/bin/ksh -aeux
idl << EOF
.compile iasi_o3_cpsr_extract.pro
iasi_o3_cpsr_extract,${INFILE_COL},${INFILE_ERR},${INFILE_VMR},${OUTFILE},${BIN_BEG_SEC},${BIN_END_SEC}, ${NL_MIN_LON}, ${NL_MAX_LON}, ${NL_MIN_LAT}, ${NL_MAX_LAT}, ${DATE}
EOF
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
#            qsub -Wblock=true job.ksh 
            chmod +x job.ksh
            ./job.ksh > index_m.html 2>&1
#
# cat the output file to the assimlation window file
            export ASIM_OUTFILE=${YYYY}${MM}${DD}${HH}.dat
            if [[ -e ${OUTFILE_NM} ]]; then
               cat ${OUTFILE_NM} >> ${ASIM_OUTFILE}
#               rm -rf ${OUTFILE_NM}
            fi
         else
            echo APM IASI O3 INPUT FILES DO NOT EXIST
         fi
      else
#
# OOZ, 06Z, 12Z, 18Z normal cases
         let TEMP_MIN_HH=${ASIM_MIN_HH}
         let TEMP_MAX_HH=${ASIM_MAX_HH}
         (( BIN_BEG_SEC=${TEMP_MIN_HH}*60*60+1 ))
         (( BIN_END_SEC=${TEMP_MAX_HH}*60*60 ))
         if [[ ${HH} == 00 ]]; then
            (( BIN_BEG_SEC=1 ))
            (( BIN_END_SEC=${TEMP_MAX_HH}*60*60 ))
         fi
         export ASIM_OUTFILE=${YYYY}${MM}${DD}${HH}.dat
         rm -rf ${ASIM_OUTFILE}
         touch ${ASIM_OUTFILE}
         export FILE_COL=${EXPERIMENT_IASI_O3_DIR}/${FILE_PRE}${YYYY}${MM}${DD}_Columns${FILE_EXT}
         export FILE_ERR=${EXPERIMENT_IASI_O3_DIR}/${FILE_PRE}${YYYY}${MM}${DD}_ERROR${FILE_EXT}
         export FILE_VMR=${EXPERIMENT_IASI_O3_DIR}/${FILE_PRE}${YYYY}${MM}${DD}_VMR${FILE_EXT}
         if [[ -e ${FILE_COL} && -e ${FILE_ERR} && -e ${FILE_VMR} ]]; then 
            export OUTFILE_NM=TEMP_FILE.dat
            export INFILE_COL=\'${FILE_COL}\'
            export INFILE_ERR=\'${FILE_ERR}\'
            export INFILE_VMR=\'${FILE_VMR}\'
            export OUTFILE=\'${OUTFILE_NM}\'
#
# this is the call to an IDL routine to read and write variables
# if already processed (with output), then this can be skipped (do_iasi=0)
# else this needs to be called
            export FILE=iasi_o3_cpsr_extract.pro
            rm -rf ${FILE}
            cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/IASI_O3/native_to_ascii/${FILE} ./.
#
            rm -rf job.ksh
            touch job.ksh
            RANDOM=$$
            export JOBRND=${RANDOM}_idl_iasi
            cat << EOFF > job.ksh
#!/bin/ksh -aeux
idl << EOF
.compile iasi_o3_cpsr_extract.pro
iasi_o3_cpsr_extract,${INFILE_COL},${INFILE_ERR},${INFILE_VMR},${OUTFILE},${BIN_BEG_SEC},${BIN_END_SEC}, ${NL_MIN_LON}, ${NL_MAX_LON}, ${NL_MIN_LAT}, ${NL_MAX_LAT}, ${DATE}
EOF
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
#            qsub -Wblock=true job.ksh 
            chmod +x job.ksh
            ./job.ksh > index_mat.html 2>&1
#
# cat the output file to the assimlation window file
            export ASIM_OUTFILE=${YYYY}${MM}${DD}${HH}.dat
            if [[ -e ${OUTFILE_NM} ]]; then
               cat ${OUTFILE_NM} >> ${ASIM_OUTFILE}
#               rm -rf ${OUTFILE_NM}
            fi
         else
            echo APM IASI O3 INPUT FILES DO NOT EXIST
         fi
      fi   
#
# RUN_IASI_ASCII_TO_DART
      if [[ ${HH} -eq 0 ]]; then
         export L_YYYY=${PAST_YYYY}
         export L_MM=${PAST_MM}
         export L_DD=${PAST_DD}
         export L_HH=24
         export D_DATE=${L_YYYY}${L_MM}${L_DD}${L_HH}
      else
         export L_YYYY=${YYYY}
         export L_MM=${MM}
         export L_DD=${DD}
         export L_HH=${HH}
         export D_DATE=${L_YYYY}${L_MM}${L_DD}${L_HH}
      fi
      export NL_YEAR=${L_YYYY}
      export NL_MONTH=${L_MM}
      export NL_DAY=${L_DD}
      export NL_HOUR=${L_HH}
      if [[ ${L_HH} -eq 24 ]]; then
         NL_BIN_BEG=21.01
         NL_BIN_END=3.00
      elif [[ ${L_HH} -eq 6 ]]; then
         NL_BIN_BEG=3.01
         NL_BIN_END=9.00
      elif [[ ${L_HH} -eq 12 ]]; then
         NL_BIN_BEG=9.01
         NL_BIN_END=15.00
      elif [[ ${L_HH} -eq 18 ]]; then
         NL_BIN_BEG=15.01
         NL_BIN_END=21.00
      fi
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=${D_DATE}.dat
      export NL_IASI_CO_RETRIEVAL_TYPE=\'${RETRIEVAL_TYPE_IASI}\'
      export NL_IASI_O3_RETRIEVAL_TYPE=\'${RETRIEVAL_TYPE_IASI}\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_IASI_O3}
      export NL_USE_LOG_CO=${USE_LOG_CO_LOGIC}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
#
# USE IASI DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_iasi_input_nml.ksh
#
# GET ASCII DATA
      if [[ ! -e ${D_DATE}.dat ]]; then 
         echo APM IASI O3 ASCII FILE DOES NOTE EXIST
         exit
      fi
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/IASI_O3/work/iasi_o3_cpsr_ascii_to_obs ./.
      ./iasi_o3_cpsr_ascii_to_obs > index.html 2>&1  
#
# COPY OUTPUT TO ARCHIVE LOCATION
      export IASI_FILE=iasi_obs_seq${D_DATE}
      if [[ -s ${IASI_FILE} ]]; then
         cp ${IASI_FILE} obs_seq_iasi_o3_cpsr_${DATE}.out
      else
         touch NO_DATA_${D_DATE}
      fi
   fi
#
#########################################################################
#
# RUN MODIS AOD TOTAL COL OBSERVATIONS
#
#########################################################################
#
   if ${RUN_MODIS_AOD_TOTAL_COL_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/modis_aod_total_col_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/modis_aod_total_col_obs
         cd ${RUN_DIR}/${DATE}/modis_aod_total_col_obs
      else
         cd ${RUN_DIR}/${DATE}/modis_aod_total_col_obs
      fi
#
# SET MODIS PARAMETERS
      export MODIS_FILE_PRE='MYD04_L2.A'
      export MODIS_FILE_EXT='hdf'
      export OUTFILE=\'TEMP_FILE.dat\'
      export OUTFILE_NQ=TEMP_FILE.dat
      export MOD_OUTFILE=\'MODIS_AOD_${D_DATE}.dat\'
      export MOD_OUTFILE_NQ=MODIS_AOD_${D_DATE}.dat
      rm -rf ${OUTFILE}
      rm -rf ${MOD_OUTFILE}
#
#  SET OBS WINDOW
      (( N_YYYY=${YYYY}+0 ))
      (( N_MM=${MM}+0 ))
      (( N_DD=${DD}+0 ))
      (( N_HH=${HH}+0 ))
      (( N_ASIM_WIN=${ASIM_WINDOW}+0 ))
#
# SET MODIS INPUT DATA FILE
      export MODIS_INDIR=${EXPERIMENT_MODIS_AOD_DIR}
#
# COPY EXECUTABLE
      export FILE=modis_aod_total_col_extract.pro
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/MODIS_AOD/native_to_ascii/${FILE} ./.
#
      rm -rf job.ksh
      touch job.ksh
      RANDOM=$$
      export JOBRND=${RANDOM}_idl_modis
      cat << EOFF > job.ksh
#!/bin/ksh -aeux
idl << EOF
.compile modis_aod_total_col_extract.pro
modis_aod_total_col_extract, "${MODIS_INDIR}", "${OUTFILE_NQ}", ${N_YYYY}, ${N_MM}, ${N_DD}, ${N_HH}, ${N_ASIM_WIN}, ${NL_MIN_LON}, ${NL_MAX_LON}, ${NL_MIN_LAT}, ${NL_MAX_LAT}
EOF
export RC=\$?     
if [[ -f SUCCESS ]]; then rm -rf SUCCESS; fi     
if [[ -f FAILED ]]; then rm -rf FAILED; fi          
if [[ \$RC = 0 ]]; then
   touch SUCCESS
else
   touch FAILED 
fi
EOFF
#      qsub -Wblock=true job.ksh 
      chmod +x job.ksh
      ./job.ksh > index_mat.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${MOD_OUTFILE_NQ} && -e ${OUTFILE_NQ} ]]; then
         touch ${MOD_OUTFILE_NQ}
         cat ${OUTFILE_NQ} >> ${MOD_OUTFILE_NQ}
         rm -rf ${OUTFILE_NQ}
      elif [[ -e ${MOD_OUTFILE_NQ} && -e ${OUTFILE_NQ} ]]; then
         cat ${OUTFILE_NQ} >> ${MOD_OUTFILE_NQ}
         rm -rf ${OUTFILE_NQ}
      fi
#
# SET NAMELIST TO CONVERT MODIS ASCII TO OBS_SEQ 
      export NL_MOD_OUTFILE=obs_seq_modis_aod_total_col_${DATE}.out
#
      export BIN_BEG_YR=${ASIM_MN_YYYY}
      export BIN_BEG_MM=${ASIM_MN_MM}
      export BIN_BEG_DD=${ASIM_MN_DD}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      export BIN_END_YR=${ASIM_MX_YYYY}
      export BIN_END_MM=${ASIM_MX_MM}
      export BIN_END_DD=${ASIM_MX_DD}
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
#
      export NL_LAT_MN=${NL_MIN_LAT}
      export NL_LAT_MX=${NL_MAX_LAT}
      export NL_LON_MN=${NL_MIN_LON}
      export NL_LON_MX=${NL_MAX_LON}
      export NL_USE_LOG_AOD=${USE_LOG_AOD_LOGIC}
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_MODIS_AOD}
      export NL_FILENAME=modis_asciidata.input
#
# SETUP NAMELIST
      rm -rf create_modis_obs_nml.nl
      rm -rf input.nml
      rm -rf ${NL_FILENAME}
      cp ${MOD_OUTFILE_NQ} ${NL_FILENAME}
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_modis_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/MODIS_AOD/work/modis_aod_total_col_ascii_to_obs ./.
#
# RUN OBS CONVERTER      
      ./modis_aod_total_col_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ -s modis_aod_total_col_obs_seq.out ]]; then
         mv modis_aod_total_col_obs_seq.out ${NL_MOD_OUTFILE}
      else
         touch NO_MODIS_AOD_${DATE}
      fi
   fi
#
#########################################################################
#
# RUN OMI O3 TOTAL COL OBSERVATIONS
#
#########################################################################
#
   if ${RUN_OMI_O3_TOTAL_COL_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/omi_o3_total_col_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/omi_o3_total_col_obs
         cd ${RUN_DIR}/${DATE}/omi_o3_total_col_obs
      else
         cd ${RUN_DIR}/${DATE}/omi_o3_total_col_obs
      fi
#
# SET OMI PARAMETERS
      export NL_PATH_MODEL=${RUN_DIR}/${PAST_DATE}/ensemble_mean_output
      export NL_FILE_MODEL=wrfout_d${CR_DOMAIN}_${DATE}_mean
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export OMI_FILE_PRE=OMI-Aura_L2-OMTO3_
      export OMI_FILE_PRE_NQ=OMI-Aura_L2-OMTO3_
      export OMI_FILE_EXT=.he5
#
# SET OBS_WINDOW
      export BIN_BEG_YY=${ASIM_MN_YYYY}
      export BIN_BEG_MM=${ASIM_MN_MM}
      export BIN_BEG_DD=${ASIM_MN_DD}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_YY=${ASIM_MX_YYYY}
      export BIN_END_MM=${ASIM_MX_MM}
      export BIN_END_DD=${ASIM_MX_DD}
      export BIN_END_HH=${HHM_END}
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      export FLG=0
      if [[ ${ASIM_MX_HH} -eq 3 ]]; then
         export FLG=1 
         export BIN_BEG_YY=${ASIM_MX_YYYY}
         export BIN_BEG_MM=${ASIM_MX_MM}
         export BIN_BEG_DD=${ASIM_MX_DD}
         export BIN_BEG_HH=0
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
      fi
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
#
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#
# SET OMI INPUT DATA FILE
      export INFILE=${EXPERIMENT_OMI_O3_DIR}/${OMI_FILE_PRE_NQ}${YYYY}m${MM}${DD}t
      export OUTFILE=TEMP_FILE.dat
      export OUTFILE_NQ=TEMP_FILE.dat
      export ARCHIVE_FILE=OMI_O3_${DATE}.dat
      rm -rf ${OUTFILE_NQ}
      rm -rf ${ARCHIVE_FILE}
#
# COPY EXECUTABLE
      export FILE=omi_o3_total_col_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/OMI_O3/native_to_ascii/${FILE} ./.
      mcc -m omi_o3_total_col_extract.m -o omi_o3_extract_total_col
      ./run_omi_o3_extract_total_col.sh ${MATLAB} ${INFILE} ${OUTFILE} ${OMI_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${ARCHIVE_FILE} && -e ${OUTFILE_NQ} ]]; then
         touch ${ARCHIVE_FILE}
         cat ${OUTFILE_NQ} >> ${ARCHIVE_FILE}
         rm -rf ${OUTFILE_NQ}
      elif [[ -e ${ARCHIVE_FILE} && -e ${OUTFILE_NQ} ]]; then
         cat ${OUTFILE_NQ} >> ${ARCHIVE_FILE}
         rm -rf ${OUTFILE_NQ}
      fi
#
# END OF PREVIOUS DAY (hours 21 to 24 obs)
      if [[ ${FLG} -eq 1 ]]; then
         export BIN_BEG_YY=${ASIM_MIN_YYYY}
         export BIN_BEG_MM=${ASIM_MIN_MM}
         export BIN_BEG_DD=${ASIM_MIN_DD}
         export BIN_BEG_HH=${ASIM_MIN_HH}
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
         export BIN_END_YY=${ASIM_MIN_YYYY}
         export BIN_END_MM=${ASIM_MIN_MM}
         export BIN_END_DD=${ASIM_MIN_DD}
         export BIN_END_HH=23
         export BIN_END_MN=59
         export BIN_END_SS=59
         export INFILE=${EXPERIMENT_OMI_O3_DIR}/${OMI_FILE_PRE_NQ}${PAST_YYYY}m${PAST_MM}${PAST_DD}t
         export OUTFILE=TEMP_FILE.dat
         export OUTFILE_NQ=TEMP_FILE.dat
         rm -rf ${OUTFILE_NQ}
#
# COPY EXECUTABLE
         export FILE=omi_o3_total_col_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/OMI_O3/native_to_ascii/${FILE} ./.
         mcc -m omi_o3_total_col_extract.m -o omi_o3_total_col_extract
         ./run_omi_o3_total_col_extract.sh ${MATLAB} ${INFILE} ${OUTFILE} ${OMI_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat.html 2>&1
      fi
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${ARCHIVE_FILE} && -e ${OUTFILE_NQ} ]]; then
         touch ${ARCHIVE_FILE}
         cat ${OUTFILE_NQ} >> ${ARCHIVE_FILE}
         rm -rf ${OUTFILE_NQ}
      elif [[ -e ${ARCHIVE_FILE} && -e ${OUTFILE_NQ} ]]; then
         cat ${OUTFILE_NQ} >> ${ARCHIVE_FILE}
         rm -rf ${OUTFILE_NQ}
      fi
      if [[ ! -e ${ARCHIVE_FILE} ]]; then
         touch NO_OMI_O3_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT OMI_O3 ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'${ARCHIVE_FILE}\'
      export NL_FILEOUT=\'obs_seq_omi_o3_total_col_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_OMI_O3}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_NO2=${USE_LOG_NO2_LOGIC}
      export NL_USE_LOG_SO2=${USE_LOG_SO2_LOGIC}
      export NL_USE_LOG_HCHO=${USE_LOG_HCHO_LOGIC}
#
# MODEL PROFILE SETTINGS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export NL_NZ_MODEL=${NNZP_CR}
#
      export NL_YEAR=${D_YYYY}
      export NL_MONTH=${D_MM}
      export NL_DAY=${D_DD}
      export NL_HOUR=${D_HH}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#
# USE OMI DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_omi_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/OMI_O3/work/omi_o3_total_col_ascii_to_obs ./.
      ./omi_o3_total_col_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ ! -s ${NL_FILEOUT} ]]; then
         touch NO_OMI_O3_${DATE}
      fi
   fi
#
#########################################################################
#
# RUN OMI O3 TROP COL OBSERVATIONS
#
#########################################################################
#
   if ${RUN_OMI_O3_TROP_COL_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/omi_o3_trop_col_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/omi_o3_trop_col_obs
         cd ${RUN_DIR}/${DATE}/omi_o3_trop_col_obs
      else
         cd ${RUN_DIR}/${DATE}/omi_o3_trop_col_obs
      fi
#
# SET OMI PARAMETERS
      export NL_PATH_MODEL=${RUN_DIR}/${PAST_DATE}/ensemble_mean_output
      export NL_FILE_MODEL=wrfout_d${CR_DOMAIN}_${DATE}_mean
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export OMI_FILE_PRE=OMI-Aura_L2-OMTO3_
      export OMI_FILE_PRE_NQ=OMI-Aura_L2-OMTO3_
      export OMI_FILE_EXT=.he5
#
# SET OBS_WINDOW
      export BIN_BEG_YY=${ASIM_MN_YYYY}
      export BIN_BEG_MM=${ASIM_MN_MM}
      export BIN_BEG_DD=${ASIM_MN_DD}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_YY=${ASIM_MX_YYYY}
      export BIN_END_MM=${ASIM_MX_MM}
      export BIN_END_DD=${ASIM_MX_DD}
      export BIN_END_HH=${HHM_END}
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      export FLG=0
      if [[ ${ASIM_MX_HH} -eq 3 ]]; then
         export FLG=1 
         export BIN_BEG_YY=${ASIM_MX_YYYY}
         export BIN_BEG_MM=${ASIM_MX_MM}
         export BIN_BEG_DD=${ASIM_MX_DD}
         export BIN_BEG_HH=0
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
      fi
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
#
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#
# SET OMI INPUT DATA FILE
      export INFILE=${EXPERIMENT_OMI_O3_DIR}/${OMI_FILE_PRE_NQ}${YYYY}m${MM}${DD}t
      export OUTFILE=TEMP_FILE.dat
      export OUTFILE_NQ=TEMP_FILE.dat
      export ARCHIVE_FILE=OMI_O3_${DATE}.dat
      rm -rf ${OUTFILE_NQ}
      rm -rf ${ARCHIVE_FILE}
#
# COPY EXECUTABLE
      export FILE=omi_o3_trop_col_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/OMI_O3/native_to_ascii/${FILE} ./.
      mcc -m omi_o3_trop_col_extract.m -o omi_o3_trop_col_extract
      ./run_omi_o3_trop_col_extract.sh ${MATLAB} ${INFILE} ${OUTFILE} ${OMI_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${ARCHIVE_FILE} && -e ${OUTFILE_NQ} ]]; then
         touch ${ARCHIVE_FILE}
         cat ${OUTFILE_NQ} >> ${ARCHIVE_FILE}
         rm -rf ${OUTFILE_NQ}
      elif [[ -e ${ARCHIVE_FILE} && -e ${OUTFILE_NQ} ]]; then
         cat ${OUTFILE_NQ} >> ${ARCHIVE_FILE}
         rm -rf ${OUTFILE_NQ}
      fi
#
# END OF PREVIOUS DAY (hours 21 to 24 obs)
      if [[ ${FLG} -eq 1 ]]; then
         export BIN_BEG_YY=${ASIM_MIN_YYYY}
         export BIN_BEG_MM=${ASIM_MIN_MM}
         export BIN_BEG_DD=${ASIM_MIN_DD}
         export BIN_BEG_HH=${ASIM_MIN_HH}
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
         export BIN_END_YY=${ASIM_MIN_YYYY}
         export BIN_END_MM=${ASIM_MIN_MM}
         export BIN_END_DD=${ASIM_MIN_DD}
         export BIN_END_HH=23
         export BIN_END_MN=59
         export BIN_END_SS=59
         export INFILE=${EXPERIMENT_OMI_O3_DIR}/${OMI_FILE_PRE_NQ}${PAST_YYYY}m${PAST_MM}${PAST_DD}t
         export OUTFILE=TEMP_FILE.dat
         export OUTFILE_NQ=TEMP_FILE.dat
         rm -rf ${OUTFILE_NQ}
#
# COPY EXECUTABLE
         export FILE=omi_o3_trop_col_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/OMI_O3/native_to_ascii/${FILE} ./.
         mcc -m omi_o3_trop_col_extract.m -o omi_o3_trop_col_extract
         ./run_omi_o3_trop_col_extract.sh ${MATLAB} ${INFILE} ${OUTFILE} ${OMI_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat.html 2>&1
      fi
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${ARCHIVE_FILE} && -e ${OUTFILE_NQ} ]]; then
         touch ${ARCHIVE_FILE}
         cat ${OUTFILE_NQ} >> ${ARCHIVE_FILE}
         rm -rf ${OUTFILE_NQ}
      elif [[ -e ${ARCHIVE_FILE} && -e ${OUTFILE_NQ} ]]; then
         cat ${OUTFILE_NQ} >> ${ARCHIVE_FILE}
         rm -rf ${OUTFILE_NQ}
      fi
      if [[ ! -e ${ARCHIVE_FILE} ]]; then
         touch NO_OMI_O3_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT OMI_O3 ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'${ARCHIVE_FILE}\'
      export NL_FILEOUT=\'obs_seq_omi_o3_trop_col_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_OMI_O3}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_NO2=${USE_LOG_NO2_LOGIC}
      export NL_USE_LOG_SO2=${USE_LOG_SO2_LOGIC}
      export NL_USE_LOB_HCHO=${USE_LOG_HCHO_LOGIC}
#
# MODEL PROFILE SETTINGS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export NL_NZ_MODEL=${NNZP_CR}
#
      export NL_YEAR=${D_YYYY}
      export NL_MONTH=${D_MM}
      export NL_DAY=${D_DD}
      export NL_HOUR=${D_HH}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#
# USE OMI DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_omi_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/OMI_O3/work/omi_o3_trop_col_ascii_to_obs ./.
      ./omi_o3_trop_col_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ ! -s ${NL_FILEOUT} ]]; then
         touch NO_OMI_O3_${DATE}
      fi
   fi
#
#########################################################################
#
# RUN OMI O3 PROFILE COL OBSERVATIONS
#
#########################################################################
#
   if ${RUN_OMI_O3_PROFILE_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/omi_o3_profile_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/omi_o3_profile_obs
         cd ${RUN_DIR}/${DATE}/omi_o3_profile_obs
      else
         cd ${RUN_DIR}/${DATE}/omi_o3_profile_obs
      fi
#
# SET OMI PARAMETERS
      export NL_PATH_MODEL=${RUN_DIR}/${PAST_DATE}/ensemble_mean_output
      export NL_FILE_MODEL=wrfout_d${CR_DOMAIN}_${DATE}_mean
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export OMI_FILE_PRE=OMI-Aura_L2-OMO3PR_
      export OMI_FILE_PRE_NQ=OMI-Aura_L2-OMO3PR_
      export OMI_FILE_EXT=.he5
#
# SET OBS_WINDOW
      export BIN_BEG_YY=${ASIM_MN_YYYY}
      export BIN_BEG_MM=${ASIM_MN_MM}
      export BIN_BEG_DD=${ASIM_MN_DD}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_YY=${ASIM_MX_YYYY}
      export BIN_END_MM=${ASIM_MX_MM}
      export BIN_END_DD=${ASIM_MX_DD}
      export BIN_END_HH=${HHM_END}
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      export FLG=0
      if [[ ${ASIM_MX_HH} -eq 3 ]]; then
         export FLG=1 
         export BIN_BEG_YY=${ASIM_MX_YYYY}
         export BIN_BEG_MM=${ASIM_MX_MM}
         export BIN_BEG_DD=${ASIM_MX_DD}
         export BIN_BEG_HH=0
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
      fi
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
#
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#
# SET OMI INPUT DATA FILE
      export INFILE=${EXPERIMENT_OMI_O3_DIR}/${OMI_FILE_PRE_NQ}${YYYY}m${MM}${DD}t
      export OUTFILE=TEMP_FILE.dat
      export OUTFILE_NQ=TEMP_FILE.dat
      export ARCHIVE_FILE=OMI_O3_${DATE}.dat
      rm -rf ${OUTFILE_NQ}
      rm -rf ${ARCHIVE_FILE}
#
# COPY EXECUTABLE
      export FILE=omi_o3_profile_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/OMI_O3/native_to_ascii/${FILE} ./.
      mcc -m omi_o3_profile_extract.m -o omi_o3_profile_extract
      ./run_omi_o3_profile_extract.sh ${MATLAB} ${INFILE} ${OUTFILE} ${OMI_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${ARCHIVE_FILE} && -e ${OUTFILE_NQ} ]]; then
         touch ${ARCHIVE_FILE}
         cat ${OUTFILE_NQ} >> ${ARCHIVE_FILE}
         rm -rf ${OUTFILE_NQ}
      elif [[ -e ${ARCHIVE_FILE} && -e ${OUTFILE_NQ} ]]; then
         cat ${OUTFILE_NQ} >> ${ARCHIVE_FILE}
         rm -rf ${OUTFILE_NQ}
      fi
#
# END OF PREVIOUS DAY (hours 21 to 24 obs)
      if [[ ${FLG} -eq 1 ]]; then
         export BIN_BEG_YY=${ASIM_MIN_YYYY}
         export BIN_BEG_MM=${ASIM_MIN_MM}
         export BIN_BEG_DD=${ASIM_MIN_DD}
         export BIN_BEG_HH=${ASIM_MIN_HH}
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
         export BIN_END_YY=${ASIM_MIN_YYYY}
         export BIN_END_MM=${ASIM_MIN_MM}
         export BIN_END_DD=${ASIM_MIN_DD}
         export BIN_END_HH=23
         export BIN_END_MN=59
         export BIN_END_SS=59
         export INFILE=${EXPERIMENT_OMI_O3_DIR}/${OMI_FILE_PRE_NQ}${PAST_YYYY}m${PAST_MM}${PAST_DD}t
         export OUTFILE=TEMP_FILE.dat
         export OUTFILE_NQ=TEMP_FILE.dat
         rm -rf ${OUTFILE_NQ}
#
# COPY EXECUTABLE
         export FILE=omi_o3_profile_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/OMI_O3/native_to_ascii/${FILE} ./.
         mcc -m omi_o3_profile_extract.m -o omi_o3_profile_extract
         ./run_omi_o3_profile_extract.sh ${MATLAB} ${INFILE} ${OUTFILE} ${OMI_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat.html 2>&1
      fi
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${ARCHIVE_FILE} && -e ${OUTFILE_NQ} ]]; then
         touch ${ARCHIVE_FILE}
         cat ${OUTFILE_NQ} >> ${ARCHIVE_FILE}
         rm -rf ${OUTFILE_NQ}
      elif [[ -e ${ARCHIVE_FILE} && -e ${OUTFILE_NQ} ]]; then
         cat ${OUTFILE_NQ} >> ${ARCHIVE_FILE}
         rm -rf ${OUTFILE_NQ}
      fi
      if [[ ! -e ${ARCHIVE_FILE} ]]; then
         touch NO_OMI_O3_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT OMI_O3 ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'${ARCHIVE_FILE}\'
      export NL_FILEOUT=\'obs_seq_omi_o3_profile_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_OMI_O3}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_NO2=${USE_LOG_NO2_LOGIC}
      export NL_USE_LOG_SO2=${USE_LOG_SO2_LOGIC}
      export NL_USE_LOG_HCHO=${USE_LOG_HCHO_LOGIC}
#
# MODEL PROFILE SETTINGS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export NL_NZ_MODEL=${NNZP_CR}
#
      export NL_YEAR=${D_YYYY}
      export NL_MONTH=${D_MM}
      export NL_DAY=${D_DD}
      export NL_HOUR=${D_HH}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#
# USE OMI DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_omi_input_nml.ksh
#
# GET THINNING EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/OMI_O3/work/omi_o3_profile_thinner ./.
      ./omi_o3_profile_thinner > index_thin.html 2>&1
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/OMI_O3/work/omi_o3_profile_ascii_to_obs ./.
      ./omi_o3_profile_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ ! -s ${NL_FILEOUT} ]]; then
         touch NO_OMI_O3_${DATE}
      fi
   fi   
#
#########################################################################
#
# RUN OMI O3 CPSR COL OBSERVATIONS
#
#########################################################################
#
   if ${RUN_OMI_O3_CPSR_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/omi_o3_cpsr_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/omi_o3_cpsr_obs
         cd ${RUN_DIR}/${DATE}/omi_o3_cpsr_obs
      else
         cd ${RUN_DIR}/${DATE}/omi_o3_cpsr_obs
      fi
#
# SET OMI PARAMETERS
      export NL_PATH_MODEL=${RUN_DIR}/${PAST_DATE}/ensemble_mean_output
      export NL_FILE_MODEL=wrfout_d${CR_DOMAIN}_${DATE}_mean
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export OMI_FILE_PRE=OMI-Aura_L2-OMO3PR_
      export OMI_FILE_PRE_NQ=OMI-Aura_L2-OMO3PR_
      export OMI_FILE_EXT=.he5
#
# SET OBS_WINDOW
      export BIN_BEG_YY=${ASIM_MN_YYYY}
      export BIN_BEG_MM=${ASIM_MN_MM}
      export BIN_BEG_DD=${ASIM_MN_DD}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_YY=${ASIM_MX_YYYY}
      export BIN_END_MM=${ASIM_MX_MM}
      export BIN_END_DD=${ASIM_MX_DD}
      export BIN_END_HH=${HHM_END}
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      export FLG=0
      if [[ ${ASIM_MX_HH} -eq 3 ]]; then
         export FLG=1 
         export BIN_BEG_YY=${ASIM_MX_YYYY}
         export BIN_BEG_MM=${ASIM_MX_MM}
         export BIN_BEG_DD=${ASIM_MX_DD}
         export BIN_BEG_HH=0
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
      fi
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
#
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#
# SET OMI INPUT DATA FILE
      export INFILE=${EXPERIMENT_OMI_O3_DIR}/${OMI_FILE_PRE_NQ}${YYYY}m${MM}${DD}t
      export OUTFILE=TEMP_FILE.dat
      export OUTFILE_NQ=TEMP_FILE.dat
      export ARCHIVE_FILE=OMI_O3_${DATE}.dat
      rm -rf ${OUTFILE_NQ}
      rm -rf ${ARCHIVE_FILE}
#
# COPY EXECUTABLE
      export FILE=omi_o3_cpsr_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/OMI_O3/native_to_ascii/${FILE} ./.
      mcc -m omi_o3_cpsr_extract.m -o omi_o3_cpsr_extract
      ./run_omi_o3_cpsr_extract.sh ${MATLAB} ${INFILE} ${OUTFILE} ${OMI_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${ARCHIVE_FILE} && -e ${OUTFILE_NQ} ]]; then
         touch ${ARCHIVE_FILE}
         cat ${OUTFILE_NQ} >> ${ARCHIVE_FILE}
         rm -rf ${OUTFILE_NQ}
      elif [[ -e ${ARCHIVE_FILE} && -e ${OUTFILE_NQ} ]]; then
         cat ${OUTFILE_NQ} >> ${ARCHIVE_FILE}
         rm -rf ${OUTFILE_NQ}
      fi
#
# END OF PREVIOUS DAY (hours 21 to 24 obs)
      if [[ ${FLG} -eq 1 ]]; then
         export BIN_BEG_YY=${ASIM_MIN_YYYY}
         export BIN_BEG_MM=${ASIM_MIN_MM}
         export BIN_BEG_DD=${ASIM_MIN_DD}
         export BIN_BEG_HH=${ASIM_MIN_HH}
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
         export BIN_END_YY=${ASIM_MIN_YYYY}
         export BIN_END_MM=${ASIM_MIN_MM}
         export BIN_END_DD=${ASIM_MIN_DD}
         export BIN_END_HH=23
         export BIN_END_MN=59
         export BIN_END_SS=59
         export INFILE=${EXPERIMENT_OMI_O3_DIR}/${OMI_FILE_PRE_NQ}${PAST_YYYY}m${PAST_MM}${PAST_DD}t
         export OUTFILE=TEMP_FILE.dat
         export OUTFILE_NQ=TEMP_FILE.dat
         rm -rf ${OUTFILE_NQ}
#
# COPY EXECUTABLE
         export FILE=omi_o3_cpsr_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/OMI_O3/native_to_ascii/${FILE} ./.
         mcc -m omi_o3_cpsr_extract.m -o omi_o3_cpsr_extract
         ./run_omi_o3_cpsr_extract.sh ${MATLAB} ${INFILE} ${OUTFILE} ${OMI_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat.html 2>&1
      fi
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${ARCHIVE_FILE} && -e ${OUTFILE_NQ} ]]; then
         touch ${ARCHIVE_FILE}
         cat ${OUTFILE_NQ} >> ${ARCHIVE_FILE}
         rm -rf ${OUTFILE_NQ}
      elif [[ -e ${ARCHIVE_FILE} && -e ${OUTFILE_NQ} ]]; then
         cat ${OUTFILE_NQ} >> ${ARCHIVE_FILE}
         rm -rf ${OUTFILE_NQ}
      fi
      if [[ ! -e ${ARCHIVE_FILE} ]]; then
         touch NO_OMI_O3_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT OMI_O3 ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'${ARCHIVE_FILE}\'
      export NL_FILEOUT=\'obs_seq_omi_o3_cpsr_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_OMI_O3}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_NO2=${USE_LOG_NO2_LOGIC}
      export NL_USE_LOG_SO2=${USE_LOG_SO2_LOGIC}
      export NL_USE_LOG_HCHO=${USE_LOG_HCHO_LOGIC}
#
# MODEL CPSR SETTINGS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export NL_NZ_MODEL=${NNZP_CR}
#
      export NL_YEAR=${D_YYYY}
      export NL_MONTH=${D_MM}
      export NL_DAY=${D_DD}
      export NL_HOUR=${D_HH}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#
# USE OMI DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_omi_input_nml.ksh
#
# GET THINNING EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/OMI_O3/work/omi_o3_cpsr_thinner ./.
      ./omi_o3_cpsr_thinner > index_thin.html 2>&1
#
# GET EXECUTABLE
      rm -rf omi_o3_cpsr_ascii_to_obs
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/OMI_O3/work/omi_o3_cpsr_ascii_to_obs ./.
      ./omi_o3_cpsr_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ ! -s ${NL_FILEOUT} ]]; then
         touch NO_OMI_O3_${DATE}
      fi
   fi
#
########################################################################
#   
# RUN OMI NO2 TOTAL COL OBSERVATIONS
#
########################################################################
#
   if ${RUN_OMI_NO2_TOTAL_COL_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/omi_no2_total_col_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/omi_no2_total_col_obs
         cd ${RUN_DIR}/${DATE}/omi_no2_total_col_obs
      else
         cd ${RUN_DIR}/${DATE}/omi_no2_total_col_obs
      fi
#
# SET OMI PARAMETERS
      export NL_PATH_MODEL=${RUN_DIR}/${PAST_DATE}/ensemble_mean_output
      export NL_FILE_MODEL=wrfout_d${CR_DOMAIN}_${DATE}_mean
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export OMI_FILE_PRE=OMI-Aura_L2-OMNO2_
      export OMI_FILE_PRE_NQ=OMI-Aura_L2-OMNO2_
      export OMI_FILE_EXT=.he5
#
# SET OBS_WINDOW
      export BIN_BEG_YY=${ASIM_MN_YYYY}
      export BIN_BEG_MM=${ASIM_MN_MM}
      export BIN_BEG_DD=${ASIM_MN_DD}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_YY=${ASIM_MX_YYYY}
      export BIN_END_MM=${ASIM_MX_MM}
      export BIN_END_DD=${ASIM_MX_DD}
      export BIN_END_HH=${HHM_END}
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      export FLG=0
      if [[ ${ASIM_MX_HH} -eq 3 ]]; then
         export FLG=1 
         export BIN_BEG_YY=${ASIM_MX_YYYY}
         export BIN_BEG_MM=${ASIM_MX_MM}
         export BIN_BEG_DD=${ASIM_MX_DD}
         export BIN_BEG_HH=0
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
      fi
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#
# SET OMI INPUT DATA FILE
      export INFILE=${EXPERIMENT_OMI_NO2_DIR}/${OMI_FILE_PRE_NQ}${YYYY}m${MM}${DD}t
      export OUTFILE=TEMP_FILE.dat
      export OUTFILE_NQ=TEMP_FILE.dat
      export ARCHIVE_FILE=OMI_NO2_${DATE}.dat
      rm -rf ${OUTFILE_NQ}
      rm -rf ${ARCHIVE_FILE}
#
# COPY EXECUTABLE
      export FILE=omi_no2_total_col_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/OMI_NO2/native_to_ascii/${FILE} ./.
      mcc -m omi_no2_total_col_extract.m -o omi_no2_total_col_extract
      ./run_omi_no2_total_col_extract.sh ${MATLAB} ${INFILE} ${OUTFILE} ${OMI_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${ARCHIVE_FILE} && -e ${OUTFILE_NQ} ]]; then
         touch ${ARCHIVE_FILE}
         cat ${OUTFILE_NQ} >> ${ARCHIVE_FILE}
         rm -rf ${OUTFILE_NQ}
      elif [[ -e ${ARCHIVE_FILE} && -e ${OUTFILE_NQ} ]]; then
         cat ${OUTFILE_NQ} >> ${ARCHIVE_FILE}
         rm -rf ${OUTFILE_NQ}
      fi
#
# END OF PREVIOUS DAY (hours 21 to 24 obs)
      if [[ ${FLG} -eq 1 ]]; then
         export BIN_BEG_YY=${ASIM_MIN_YYYY}
         export BIN_BEG_MM=${ASIM_MIN_MM}
         export BIN_BEG_DD=${ASIM_MIN_DD}
         export BIN_BEG_HH=${ASIM_MIN_HH}
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
         export BIN_END_YY=${ASIM_MIN_YYYY}
         export BIN_END_MM=${ASIM_MIN_MM}
         export BIN_END_DD=${ASIM_MIN_DD}
         export BIN_END_HH=23
         export BIN_END_MN=59
         export BIN_END_SS=59
         export INFILE=${EXPERIMENT_OMI_NO2_DIR}/${OMI_FILE_PRE_NQ}${PAST_YYYY}m${PAST_MM}${PAST_DD}t
         export OUTFILE=TEMP_FILE.dat
         export OUTFILE_NQ=TEMP_FILE.dat
         rm -rf ${OUTFILE_NQ}
#
# COPY EXECUTABLE
         export FILE=omi_no2_total_col_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/OMI_NO2/native_to_ascii/${FILE} ./.
         mcc -m omi_no2_total_col_extract.m -o omi_no2_total_col_extract
         ./run_omi_no2_total_col_extract.sh ${MATLAB} ${INFILE} ${OUTFILE} ${OMI_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat.html 2>&1
#
      fi
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${ARCHIVE_FILE} && -e ${OUTFILE_NQ} ]]; then
         touch ${ARCHIVE_FILE}
         cat ${OUTFILE_NQ} >> ${ARCHIVE_FILE}
         rm -rf ${OUTFILE_NQ}
      elif [[ -e ${ARCHIVE_FILE} && -e ${OUTFILE_NQ} ]]; then
         cat ${OUTFILE_NQ} >> ${ARCHIVE_FILE}
         rm -rf ${OUTFILE_NQ}
      fi
      if [[ ! -e ${ARCHIVE_FILE} ]]; then
         touch NO_OMI_NO2_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT OMI_NO2 ASCII TO OBS_SEQ
      export NL_FILEDIR=\'./\'
      export NL_FILENAME=\'${ARCHIVE_FILE}\'
      export NL_FILEOUT=\'obs_seq_omi_no2_total_col_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_OMI_NO2}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_NO2=${USE_LOG_NO2_LOGIC}
      export NL_USE_LOG_SO2=${USE_LOG_SO2_LOGIC}
      export NL_USE_LOG_HCHO=${USE_LOG_HCHO_LOGIC}
#
# MODEL PROFILE SETTINGS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export NL_NZ_MODEL=${NNZP_CR}
#
      export NL_YEAR=${D_YYYY}
      export NL_MONTH=${D_MM}
      export NL_DAY=${D_DD}
      export NL_HOUR=${D_HH}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#
# USE OMI DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_omi_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/OMI_NO2/work/omi_no2_total_col_ascii_to_obs ./.
      ./omi_no2_total_col_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ ! -s ${NL_FILEOUT} ]]; then
         touch NO_OMI_NO2_${DATE}
      fi
   fi
#
########################################################################
#   
# RUN OMI NO2 TROP COL OBSERVATIONS
#
########################################################################
#
   if ${RUN_OMI_NO2_TROP_COL_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/omi_no2_trop_col_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/omi_no2_trop_col_obs
         cd ${RUN_DIR}/${DATE}/omi_no2_trop_col_obs
      else
         cd ${RUN_DIR}/${DATE}/omi_no2_trop_col_obs
      fi
#
# SET OMI PARAMETERS
      export NL_PATH_MODEL=${RUN_DIR}/${PAST_DATE}/ensemble_mean_output
      export NL_FILE_MODEL=wrfout_d${CR_DOMAIN}_${DATE}_mean
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export OMI_FILE_PRE=OMI-Aura_L2-OMNO2_
      export OMI_FILE_PRE_NQ=OMI-Aura_L2-OMNO2_
      export OMI_FILE_EXT=.he5
#
# SET OBS_WINDOW
      export BIN_BEG_YY=${ASIM_MN_YYYY}
      export BIN_BEG_MM=${ASIM_MN_MM}
      export BIN_BEG_DD=${ASIM_MN_DD}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_YY=${ASIM_MX_YYYY}
      export BIN_END_MM=${ASIM_MX_MM}
      export BIN_END_DD=${ASIM_MX_DD}
      export BIN_END_HH=${HHM_END}
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      export FLG=0
      if [[ ${ASIM_MX_HH} -eq 3 ]]; then
         export FLG=1 
         export BIN_BEG_YY=${ASIM_MX_YYYY}
         export BIN_BEG_MM=${ASIM_MX_MM}
         export BIN_BEG_DD=${ASIM_MX_DD}
         export BIN_BEG_HH=0
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
      fi
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#
# SET OMI INPUT DATA FILE
      export INFILE=${EXPERIMENT_OMI_NO2_DIR}/${OMI_FILE_PRE_NQ}${YYYY}m${MM}${DD}t
      export OUTFILE=TEMP_FILE.dat
      export OUTFILE_NQ=TEMP_FILE.dat
      export ARCHIVE_FILE=OMI_NO2_${DATE}.dat
      rm -rf ${OUTFILE_NQ}
      rm -rf ${ARCHIVE_FILE}
#
# COPY EXECUTABLE
      export FILE=omi_no2_trop_col_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/OMI_NO2/native_to_ascii/${FILE} ./.
      mcc -m omi_no2_trop_col_extract.m -o omi_no2_trop_col_extract
      ./run_omi_no2_trop_col_extract.sh ${MATLAB} ${INFILE} ${OUTFILE} ${OMI_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${ARCHIVE_FILE} && -e ${OUTFILE_NQ} ]]; then
         touch ${ARCHIVE_FILE}
         cat ${OUTFILE_NQ} >> ${ARCHIVE_FILE}
         rm -rf ${OUTFILE_NQ}
      elif [[ -e ${ARCHIVE_FILE} && -e ${OUTFILE_NQ} ]]; then
         cat ${OUTFILE_NQ} >> ${ARCHIVE_FILE}
         rm -rf ${OUTFILE_NQ}
      fi
#
# END OF PREVIOUS DAY (hours 21 to 24 obs)
      if [[ ${FLG} -eq 1 ]]; then
         export BIN_BEG_YY=${ASIM_MIN_YYYY}
         export BIN_BEG_MM=${ASIM_MIN_MM}
         export BIN_BEG_DD=${ASIM_MIN_DD}
         export BIN_BEG_HH=${ASIM_MIN_HH}
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
         export BIN_END_YY=${ASIM_MIN_YYYY}
         export BIN_END_MM=${ASIM_MIN_MM}
         export BIN_END_DD=${ASIM_MIN_DD}
         export BIN_END_HH=23
         export BIN_END_MN=59
         export BIN_END_SS=59
         export INFILE=${EXPERIMENT_OMI_NO2_DIR}/${OMI_FILE_PRE_NQ}${PAST_YYYY}m${PAST_MM}${PAST_DD}t
         export OUTFILE=TEMP_FILE.dat
         export OUTFILE_NQ=TEMP_FILE.dat
         rm -rf ${OUTFILE_NQ}
#
# COPY EXECUTABLE
         export FILE=omi_no2_trop_col_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/OMI_NO2/native_to_ascii/${FILE} ./.
         mcc -m omi_no2_trop_col_extract.m -o omi_no2_trop_col_extract
         ./run_omi_no2_trop_col_extract.sh ${MATLAB} ${INFILE} ${OUTFILE} ${OMI_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat.html 2>&1
      fi
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${ARCHIVE_FILE} && -e ${OUTFILE_NQ} ]]; then
         touch ${ARCHIVE_FILE}
         cat ${OUTFILE_NQ} >> ${ARCHIVE_FILE}
         rm -rf ${OUTFILE_NQ}
      elif [[ -e ${ARCHIVE_FILE} && -e ${OUTFILE_NQ} ]]; then
         cat ${OUTFILE_NQ} >> ${ARCHIVE_FILE}
         rm -rf ${OUTFILE_NQ}
      fi
      if [[ ! -e ${ARCHIVE_FILE} ]]; then
         touch NO_OMI_NO2_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT OMI_NO2 ASCII TO OBS_SEQ
      export NL_FILEDIR=\'./\'
      export NL_FILENAME=\'${ARCHIVE_FILE}\'
      export NL_FILEOUT=\'obs_seq_omi_no2_trop_col_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_OMI_NO2}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_NO2=${USE_LOG_NO2_LOGIC}
      export NL_USE_LOG_SO2=${USE_LOG_SO2_LOGIC}
      export NL_USE_LOG_HCHO=${USE_LOG_HCHO_LOGIC}
#
# MODEL PROFILE SETTINGS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export NL_NZ_MODEL=${NNZP_CR}
#
      export NL_YEAR=${D_YYYY}
      export NL_MONTH=${D_MM}
      export NL_DAY=${D_DD}
      export NL_HOUR=${D_HH}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#
# USE OMI DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_omi_input_nml.ksh
#
# GET THINNING EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/OMI_NO2/work/omi_no2_trop_col_thinner ./.
      ./omi_no2_trop_col_thinner > index_thin.html 2>&1
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/OMI_NO2/work/omi_no2_trop_col_ascii_to_obs ./.
      ./omi_no2_trop_col_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ ! -s ${NL_FILEOUT} ]]; then
         touch NO_OMI_NO2_${DATE}
      fi
   fi
#
########################################################################
#
# RUN OMI SO2 TOTAL COLUMN OBSERVATIONS
#
########################################################################
#
   if ${RUN_OMI_SO2_TOTAL_COL_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/omi_so2_total_col_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/omi_so2_total_col_obs
         cd ${RUN_DIR}/${DATE}/omi_so2_total_col_obs
      else
         cd ${RUN_DIR}/${DATE}/omi_so2_total_col_obs
      fi
#
# SET OMI PARAMETERS
      export NL_PATH_MODEL=${RUN_DIR}/${PAST_DATE}/ensemble_mean_output
      export NL_FILE_MODEL=wrfout_d${CR_DOMAIN}_${DATE}_mean
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export OMI_FILE_PRE=OMI-Aura_L2-OMSO2_
      export OMI_FILE_PRE_NQ=OMI-Aura_L2-OMSO2_
      export OMI_FILE_EXT=.he5
#
# SET OBS_WINDOW
      export BIN_BEG_YY=${ASIM_MN_YYYY}
      export BIN_BEG_MM=${ASIM_MN_MM}
      export BIN_BEG_DD=${ASIM_MN_DD}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_YY=${ASIM_MX_YYYY}
      export BIN_END_MM=${ASIM_MX_MM}
      export BIN_END_DD=${ASIM_MX_DD}
      export BIN_END_HH=${HHM_END}
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      export FLG=0
      if [[ ${ASIM_MX_HH} -eq 3 ]]; then
         export FLG=1 
         export BIN_BEG_YY=${ASIM_MX_YYYY}
         export BIN_BEG_MM=${ASIM_MX_MM}
         export BIN_BEG_DD=${ASIM_MX_DD}
         export BIN_BEG_HH=0
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
      fi
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#
# SET OMI INPUT DATA FILE
      export INFILE=${EXPERIMENT_OMI_SO2_DIR}/${OMI_FILE_PRE_NQ}${YYYY}m${MM}${DD}t
      export OUTFILE=TEMP_FILE.dat
      export OUTFILE_NQ=TEMP_FILE.dat
      export ARCHIVE_FILE=OMI_SO2_${DATE}.dat
      rm -rf ${OUTFILE_NQ}
      rm -rf ${ARCHIVE_FILE}
#
# COPY EXECUTABLE
      export FILE=omi_so2_total_col_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/OMI_SO2/native_to_ascii/${FILE} ./.
      mcc -m omi_so2_total_col_extract.m -o omi_so2_total_col_extract
      ./run_omi_so2_total_col_extract.sh ${MATLAB} ${INFILE} ${OUTFILE} ${OMI_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${ARCHIVE_FILE} && -e ${OUTFILE_NQ} ]]; then
         touch ${ARCHIVE_FILE}
         cat ${OUTFILE_NQ} >> ${ARCHIVE_FILE}
         rm -rf ${OUTFILE_NQ}
      elif [[ -e ${ARCHIVE_FILE} && -e ${OUTFILE_NQ} ]]; then
         cat ${OUTFILE_NQ} >> ${ARCHIVE_FILE}
         rm -rf ${OUTFILE_NQ}
      fi
#
# END OF PREVIOUS DAY (hours 21 to 24 obs)
      if [[ ${FLG} -eq 1 ]]; then
         export BIN_BEG_YY=${ASIM_MIN_YYYY}
         export BIN_BEG_MM=${ASIM_MIN_MM}
         export BIN_BEG_DD=${ASIM_MIN_DD}
         export BIN_BEG_HH=${ASIM_MIN_HH}
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
         export BIN_END_YY=${ASIM_MIN_YYYY}
         export BIN_END_MM=${ASIM_MIN_MM}
         export BIN_END_DD=${ASIM_MIN_DD}
         export BIN_END_HH=23
         export BIN_END_MN=59
         export BIN_END_SS=59
         export INFILE=${EXPERIMENT_OMI_SO2_DIR}/${OMI_FILE_PRE_NQ}${PAST_YYYY}m${PAST_MM}${PAST_DD}t
         export OUTFILE=TEMP_FILE.dat
         export OUTFILE_NQ=TEMP_FILE.dat
         rm -rf ${OUTFILE_NQ}
#
# COPY EXECUTABLE
         export FILE=omi_so2_total_col_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/OMI_SO2/native_to_ascii/${FILE} ./.
         mcc -m omi_so2_total_col_extract.m -o omi_so2_total_col_extract
         ./run_omi_so2_total_col_extract.sh ${MATLAB} ${INFILE} ${OUTFILE} ${OMI_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat.html 2>&1
#
      fi
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${ARCHIVE_FILE} && -e ${OUTFILE_NQ} ]]; then
         touch ${ARCHIVE_FILE}
         cat ${OUTFILE_NQ} >> ${ARCHIVE_FILE}
         rm -rf ${OUTFILE_NQ}
      elif [[ -e ${ARCHIVE_FILE} && -e ${OUTFILE_NQ} ]]; then
         cat ${OUTFILE_NQ} >> ${ARCHIVE_FILE}
         rm -rf ${OUTFILE_NQ}
      fi
      if [[ ! -e ${ARCHIVE_FILE} ]]; then
         touch NO_OMI_SO2_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT OMI_SO2 ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'${ARCHIVE_FILE}\'
      export NL_FILEOUT=\'obs_seq_omi_so2_total_col_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_OMI_SO2}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_NO2=${USE_LOG_NO2_LOGIC}
      export NL_USE_LOG_SO2=${USE_LOG_SO2_LOGIC}
      export NL_USE_LOG_HCHO=${USE_LOG_HCHO_LOGIC}
#
# MODEL PROFILE SETTINGS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export NL_NZ_MODEL=${NNZP_CR}
#
      export NL_YEAR=${D_YYYY}
      export NL_MONTH=${D_MM}
      export NL_DAY=${D_DD}
      export NL_HOUR=${D_HH}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#
# USE OMI DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_omi_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/OMI_SO2/work/omi_so2_total_col_ascii_to_obs ./.
      ./omi_so2_total_col_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ ! -s ${NL_FILEOUT} ]]; then
         touch NO_OMI_SO2_${DATE}
      fi
   fi
#
########################################################################
#
# RUN OMI SO2 PBL COLUMN OBSERVATIONS
#
########################################################################
#
   if ${RUN_OMI_SO2_PBL_COL_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/omi_so2_pbl_col_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/omi_so2_pbl_col_obs
         cd ${RUN_DIR}/${DATE}/omi_so2_pbl_col_obs
      else
         cd ${RUN_DIR}/${DATE}/omi_so2_pbl_col_obs
      fi
#
# SET OMI PARAMETERS
      export NL_PATH_MODEL=${RUN_DIR}/${PAST_DATE}/ensemble_mean_output
      export NL_FILE_MODEL=wrfout_d${CR_DOMAIN}_${DATE}_mean
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export OMI_FILE_PRE=OMI-Aura_L2-OMSO2_
      export OMI_FILE_PRE_NQ=OMI-Aura_L2-OMSO2_
      export OMI_FILE_EXT=.he5
#
# SET OBS_WINDOW
      export BIN_BEG_YY=${ASIM_MN_YYYY}
      export BIN_BEG_MM=${ASIM_MN_MM}
      export BIN_BEG_DD=${ASIM_MN_DD}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_YY=${ASIM_MX_YYYY}
      export BIN_END_MM=${ASIM_MX_MM}
      export BIN_END_DD=${ASIM_MX_DD}
      export BIN_END_HH=${HHM_END}
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      export FLG=0
      if [[ ${ASIM_MX_HH} -eq 3 ]]; then
         export FLG=1 
         export BIN_BEG_YY=${ASIM_MX_YYYY}
         export BIN_BEG_MM=${ASIM_MX_MM}
         export BIN_BEG_DD=${ASIM_MX_DD}
         export BIN_BEG_HH=0
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
      fi
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#
# SET OMI INPUT DATA FILE
      export INFILE=${EXPERIMENT_OMI_SO2_DIR}/${OMI_FILE_PRE_NQ}${YYYY}m${MM}${DD}t
      export OUTFILE=TEMP_FILE.dat
      export OUTFILE_NQ=TEMP_FILE.dat
      export ARCHIVE_FILE=OMI_SO2_${DATE}.dat
      rm -rf ${OUTFILE_NQ}
      rm -rf ${ARCHIVE_FILE}
#
# COPY EXECUTABLE
      export FILE=omi_so2_pbl_col_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/OMI_SO2/native_to_ascii/${FILE} ./.
      mcc -m omi_so2_pbl_col_extract.m -o omi_so2_pbl_col_extract
      ./run_omi_so2_pbl_col_extract.sh ${MATLAB} ${INFILE} ${OUTFILE} ${OMI_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat1.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${ARCHIVE_FILE} && -e ${OUTFILE_NQ} ]]; then
         touch ${ARCHIVE_FILE}
         cat ${OUTFILE_NQ} >> ${ARCHIVE_FILE}
         rm -rf ${OUTFILE_NQ}
      elif [[ -e ${ARCHIVE_FILE} && -e ${OUTFILE_NQ} ]]; then
         cat ${OUTFILE_NQ} >> ${ARCHIVE_FILE}
         rm -rf ${OUTFILE_NQ}
      fi
#
# END OF PREVIOUS DAY (hours 21 to 24 obs)
      if [[ ${FLG} -eq 1 ]]; then
         export BIN_BEG_YY=${ASIM_MIN_YYYY}
         export BIN_BEG_MM=${ASIM_MIN_MM}
         export BIN_BEG_DD=${ASIM_MIN_DD}
         export BIN_BEG_HH=${ASIM_MIN_HH}
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
         export BIN_END_YY=${ASIM_MIN_YYYY}
         export BIN_END_MM=${ASIM_MIN_MM}
         export BIN_END_DD=${ASIM_MIN_DD}
         export BIN_END_HH=23
         export BIN_END_MN=59
         export BIN_END_SS=59
         export INFILE=${EXPERIMENT_OMI_SO2_DIR}/${OMI_FILE_PRE_NQ}${PAST_YYYY}m${PAST_MM}${PAST_DD}t
         export OUTFILE=TEMP_FILE.dat
         export OUTFILE_NQ=TEMP_FILE.dat
         rm -rf ${OUTFILE_NQ}
#
# COPY EXECUTABLE
         export FILE=omi_so2_pbl_col_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/OMI_SO2/native_to_ascii/${FILE} ./.
         mcc -m omi_so2_pbl_col_extract.m -o omi_so2_pbl_col_extract
         ./run_omi_so2_pbl_col_extract.sh ${MATLAB} ${INFILE} ${OUTFILE} ${OMI_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat2.html 2>&1
#
      fi
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${ARCHIVE_FILE} && -e ${OUTFILE_NQ} ]]; then
         touch ${ARCHIVE_FILE}
         cat ${OUTFILE_NQ} >> ${ARCHIVE_FILE}
         rm -rf ${OUTFILE_NQ}
      elif [[ -e ${ARCHIVE_FILE} && -e ${OUTFILE_NQ} ]]; then
         cat ${OUTFILE_NQ} >> ${ARCHIVE_FILE}
         rm -rf ${OUTFILE_NQ}
      fi
      if [[ ! -e ${ARCHIVE_FILE} ]]; then
         touch NO_OMI_SO2_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT OMI_SO2 ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'${ARCHIVE_FILE}\'
      export NL_FILEOUT=\'obs_seq_omi_so2_pbl_col_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_OMI_SO2}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_NO2=${USE_LOG_NO2_LOGIC}
      export NL_USE_LOG_SO2=${USE_LOG_SO2_LOGIC}
      export NL_USE_LOG_HCHO=${USE_LOG_HCHO_LOGIC}
#
# MODEL PROFILE SETTINGS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export NL_NZ_MODEL=${NNZP_CR}
#
      export NL_YEAR=${D_YYYY}
      export NL_MONTH=${D_MM}
      export NL_DAY=${D_DD}
      export NL_HOUR=${D_HH}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#
# USE OMI DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_omi_input_nml.ksh
#
# GET THINNING EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/OMI_SO2/work/omi_so2_pbl_col_thinner ./.
      ./omi_so2_pbl_col_thinner > index_thin.html 2>&1
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/OMI_SO2/work/omi_so2_pbl_col_ascii_to_obs ./.
      ./omi_so2_pbl_col_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ ! -s ${NL_FILEOUT} ]]; then
         touch NO_OMI_SO2_${DATE}
      fi
   fi
#
########################################################################
#   
# RUN OMI HCHO TOTAL COL OBSERVATIONS
#
########################################################################
#
   if ${RUN_OMI_HCHO_TOTAL_COL_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/omi_hcho_total_col_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/omi_hcho_total_col_obs
         cd ${RUN_DIR}/${DATE}/omi_hcho_total_col_obs
      else
         cd ${RUN_DIR}/${DATE}/omi_hcho_total_col_obs
      fi
#
# SET OMI PARAMETERS
      export NL_PATH_MODEL=${RUN_DIR}/${PAST_DATE}/ensemble_mean_output
      export NL_FILE_MODEL=wrfout_d${CR_DOMAIN}_${DATE}_mean
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export OMI_FILE_PRE=OMI-Aura_L2-OMHCHO_
      export OMI_FILE_EXT=.he5
#
# SET OBS_WINDOW
      export BIN_BEG_YY=${ASIM_MN_YYYY}
      export BIN_BEG_MM=${ASIM_MN_MM}
      export BIN_BEG_DD=${ASIM_MN_DD}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_YY=${ASIM_MX_YYYY}
      export BIN_END_MM=${ASIM_MX_MM}
      export BIN_END_DD=${ASIM_MX_DD}
      export BIN_END_HH=${HHM_END}
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      export FLG=0
      if [[ ${ASIM_MX_HH} -eq 3 ]]; then
         export FLG=1 
         export BIN_BEG_YY=${ASIM_MX_YYYY}
         export BIN_BEG_MM=${ASIM_MX_MM}
         export BIN_BEG_DD=${ASIM_MX_DD}
         export BIN_BEG_HH=0
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
      fi
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#
# SET OMI INPUT DATA FILE
      export INFILE=${EXPERIMENT_OMI_HCHO_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${OMI_FILE_PRE}
      export OUTFILE=TEMP_FILE.dat
      export ARCHIVE_FILE=OMI_HCHO_${DATE}.dat
      rm -rf ${ARCHIVE_FILE}
#
# COPY EXECUTABLE
      export FILE=omi_hcho_total_col_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/OMI_HCHO/native_to_ascii/${FILE} ./.
      mcc -m omi_hcho_total_col_extract.m -o omi_hcho_total_col_extract
      ./run_omi_hcho_total_col_extract.sh ${MATLAB} ${INFILE} ${OUTFILE} ${OMI_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat1.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${ARCHIVE_FILE} && -e ${OUTFILE} ]]; then
         touch ${ARCHIVE_FILE}
         cat ${OUTFILE} >> ${ARCHIVE_FILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${ARCHIVE_FILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${ARCHIVE_FILE}
         rm -rf ${OUTFILE}
      fi
#
# END OF PREVIOUS DAY (hours 21 to 24 obs)
      if [[ ${FLG} -eq 1 ]]; then
         export BIN_BEG_YY=${ASIM_MIN_YYYY}
         export BIN_BEG_MM=${ASIM_MIN_MM}
         export BIN_BEG_DD=${ASIM_MIN_DD}
         export BIN_BEG_HH=${ASIM_MIN_HH}
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
         export BIN_END_YY=${ASIM_MIN_YYYY}
         export BIN_END_MM=${ASIM_MIN_MM}
         export BIN_END_DD=${ASIM_MIN_DD}
         export BIN_END_HH=23
         export BIN_END_MN=59
         export BIN_END_SS=59
         export INFILE=${EXPERIMENT_OMI_HCHO_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${OMI_FILE_PRE}\'
         export OUTFILE=TEMP_FILE.dat
#
# COPY EXECUTABLE
         export FILE=omi_hcho_total_col_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/OMI_HCHO/native_to_ascii/${FILE} ./.
         mcc -m omi_hcho_total_col_extract.m -o omi_hcho_total_col_extract
         ./run_omi_hcho_total_col_extract.sh ${MATLAB} ${INFILE} ${OUTFILE} ${OMI_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat2.html 2>&1
#
      fi
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${ARCHIVE_FILE} && -e ${OUTFILE} ]]; then
         touch ${ARCHIVE_FILE}
         cat ${OUTFILE} >> ${ARCHIVE_FILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${ARCHIVE_FILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${ARCHIVE_FILE}
         rm -rf ${OUTFILE}
      fi
      if [[ ! -e ${ARCHIVE_FILE} ]]; then
         touch NO_OMI_HCHO_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT OMI_HCHO ASCII TO OBS_SEQ
      export NL_FILEDIR=\'./\'
      export NL_FILENAME=\'${ARCHIVE_FILE}\'
      export NL_FILEOUT=\'obs_seq_omi_hcho_total_col_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_OMI_HCHO}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_NO2=${USE_LOG_NO2_LOGIC}
      export NL_USE_LOG_SO2=${USE_LOG_SO2_LOGIC}
      export NL_USE_LOG_HCHO=${USE_LOG_HCHO_LOGIC}
#
# MODEL PROFILE SETTINGS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
      export NL_PATH_MODEL=\'${RUN_DIR}/2014${PAST_MM}${PAST_DD}${PAST_HH}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_2014${MM}${DD}${HH}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export NL_NZ_MODEL=${NNZP_CR}
#
      export NL_YEAR=${D_YYYY}
      export NL_MONTH=${D_MM}
      export NL_DAY=${D_DD}
      export NL_HOUR=${D_HH}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#
# USE OMI DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_omi_input_nml.ksh
#
# GET THINNING EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/OMI_HCHO/work/omi_hcho_total_col_thinner ./.
      ./omi_hcho_total_col_thinner > index_thin.html 2>&1
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/OMI_HCHO/work/omi_hcho_total_col_ascii_to_obs ./.
      ./omi_hcho_total_col_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ ! -s ${NL_FILEOUT} ]]; then
         touch NO_OMI_HCHO_${DATE}
      fi
   fi
#
########################################################################
#   
# RUN OMI HCHO TROP COL OBSERVATIONS
#
########################################################################
#
   if ${RUN_OMI_HCHO_TROP_COL_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/omi_hcho_trop_col_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/omi_hcho_trop_col_obs
         cd ${RUN_DIR}/${DATE}/omi_hcho_trop_col_obs
      else
         cd ${RUN_DIR}/${DATE}/omi_hcho_trop_col_obs
      fi
#
# SET OMI PARAMETERS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export OMI_FILE_PRE=OMI-Aura_L2-OMHCHO_
      export OMI_FILE_EXT=.he5
#
# SET OBS_WINDOW
      export BIN_BEG_YY=${ASIM_MN_YYYY}
      export BIN_BEG_MM=${ASIM_MN_MM}
      export BIN_BEG_DD=${ASIM_MN_DD}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_YY=${ASIM_MX_YYYY}
      export BIN_END_MM=${ASIM_MX_MM}
      export BIN_END_DD=${ASIM_MX_DD}
      export BIN_END_HH=${HHM_END}
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      export FLG=0
      if [[ ${ASIM_MX_HH} -eq 3 ]]; then
         export FLG=1 
         export BIN_BEG_YY=${ASIM_MX_YYYY}
         export BIN_BEG_MM=${ASIM_MX_MM}
         export BIN_BEG_DD=${ASIM_MX_DD}
         export BIN_BEG_HH=0
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
      fi
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#
# SET OMI INPUT DATA FILE
      export INFILE=${EXPERIMENT_OMI_HCHO_DIR}/${OMI_FILE_PRE}${YYYY}m${MM}${DD}t
      export OUTFILE=TEMP_FILE.dat
      export ARCHIVE_FILE=OMI_HCHO_${DATE}.dat
      rm -rf ${ARCHIVE_FILE}
#
# COPY EXECUTABLE
      export FILE=omi_hcho_trop_col_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/OMI_HCHO/native_to_ascii/${FILE} ./.
      mcc -m omi_hcho_trop_col_extract.m -o omi_hcho_trop_col_extract
      ./run_omi_hcho_trop_col_extract.sh ${MATLAB} ${INFILE} ${OUTFILE} ${OMI_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat1.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${ARCHIVE_FILE} && -e ${OUTFILE} ]]; then
         touch ${ARCHIVE_FILE}
         cat ${OUTFILE} >> ${ARCHIVE_FILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${ARCHIVE_FILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${ARCHIVE_FILE}
         rm -rf ${OUTFILE}
      fi
#
# END OF PREVIOUS DAY (hours 21 to 24 obs)
      if [[ ${FLG} -eq 1 ]]; then
         export BIN_BEG_YY=${ASIM_MIN_YYYY}
         export BIN_BEG_MM=${ASIM_MIN_MM}
         export BIN_BEG_DD=${ASIM_MIN_DD}
         export BIN_BEG_HH=${ASIM_MIN_HH}
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
         export BIN_END_YY=${ASIM_MIN_YYYY}
         export BIN_END_MM=${ASIM_MIN_MM}
         export BIN_END_DD=${ASIM_MIN_DD}
         export BIN_END_HH=23
         export BIN_END_MN=59
         export BIN_END_SS=59
         export INFILE=${EXPERIMENT_OMI_HCHO_DIR}/${OMI_FILE_PRE}${PAST_YYYY}m${PAST_MM}${PAST_DD}t
         export OUTFILE=TEMP_FILE.dat
         export OUTFILE=TEMP_FILE.dat
         rm -rf ${OUTFILE}
#
# COPY EXECUTABLE
         export FILE=omi_hcho_trop_col_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/OMI_HCHO/native_to_ascii/${FILE} ./.
         mcc -m omi_hcho_trop_col_extract.m -o omi_hcho_trop_col_extract
         ./run_omi_hcho_trop_col_extract.sh ${MATLAB} ${INFILE} ${OUTFILE} ${OMI_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat2.html 2>&1
#
      fi
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${ARCHIVE_FILE} && -e ${OUTFILE} ]]; then
         touch ${ARCHIVE_FILE}
         cat ${OUTFILE} >> ${ARCHIVE_FILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${ARCHIVE_FILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${ARCHIVE_FILE}
         rm -rf ${OUTFILE}
      fi
      if [[ ! -e ${ARCHIVE_FILE} ]]; then
         touch NO_OMI_HCHO_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT OMI_HCHO ASCII TO OBS_SEQ
      export NL_FILEDIR=\'./\'
      export NL_FILENAME=\'${ARCHIVE_FILE}\'
      export NL_FILEOUT=\'obs_seq_omi_hcho_trop_col_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_OMI_HCHO}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_NO2=${USE_LOG_NO2_LOGIC}
      export NL_USE_LOG_SO2=${USE_LOG_SO2_LOGIC}
      export NL_USE_LOG_HCHO=${USE_LOG_HCHO_LOGIC}
#
# MODEL PROFILE SETTINGS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export NL_NZ_MODEL=${NNZP_CR}
#
      export NL_YEAR=${D_YYYY}
      export NL_MONTH=${D_MM}
      export NL_DAY=${D_DD}
      export NL_HOUR=${D_HH}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#
# USE OMI DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_omi_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/OMI_HCHO/work/omi_hcho_trop_col_ascii_to_obs ./.
      ./omi_hcho_trop_col_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ ! -s ${NL_FILEOUT} ]]; then
         touch NO_OMI_HCHO_${DATE}
      fi
   fi
#
########################################################################
#
# RUN TROPOMI CO TOTAL COL OBSERVATIONS
#
########################################################################
#
   if ${RUN_TROPOMI_CO_TOTAL_COL_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/tropomi_co_total_col_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/tropomi_co_total_col_obs
         cd ${RUN_DIR}/${DATE}/tropomi_co_total_col_obs
      else
         cd ${RUN_DIR}/${DATE}/tropomi_co_total_col_obs
      fi
#
# SET TROPOMI PARAMETERS
      export NL_PATH_MODEL=${RUN_DIR}/${PAST_DATE}/ensemble_mean_output
      export NL_FILE_MODEL=wrfout_d${CR_DOMAIN}_${DATE}_mean
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export TROPOMI_FILE_PRE=S5P_OFFL_L2__CO_____
      export TROPOMI_FILE_EXT=.nc
      export OUTFILE=TEMP_FILE.dat
      export TRP_OUTFILE=TROPOMI_CO_${DATE}.dat
      rm -rf ${OUTFILE}
      rm -rf ${TRP_OUTFILE}
#
# SET OBS_WINDOW
      export BIN_BEG_YY=${ASIM_MN_YYYY}
      export BIN_BEG_MM=${ASIM_MN_MM}
      export BIN_BEG_DD=${ASIM_MN_DD}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_YY=${ASIM_MX_YYYY}
      export BIN_END_MM=${ASIM_MX_MM}
      export BIN_END_DD=${ASIM_MX_DD}
      export BIN_END_HH=${HHM_END}
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      export FLG=0
      if [[ ${ASIM_MX_HH} -eq 3 ]]; then
         export FLG=1 
         export BIN_BEG_YY=${ASIM_MX_YYYY}
         export BIN_BEG_MM=${ASIM_MX_MM}
         export BIN_BEG_DD=${ASIM_MX_DD}
         export BIN_BEG_HH=0
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
      fi
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
#
# SET TROPOMI INPUT DATA DIR
      export TRP_INFILE=\'${EXPERIMENT_TROPOMI_CO_DIR}/${TROPOMI_FILE_PRE}${YYYY}${MM}${DD}T\'
#
# COPY EXECUTABLE
      export FILE=tropomi_co_total_col_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TROPOMI_CO/native_to_ascii/${FILE} ./.
      mcc -m tropomi_co_total_col_extract.m -o tropomi_co_total_col_extract
      ./run_tropomi_co_total_col_extract.sh ${MATLAB} ${TRP_INFILE} ${OUTFILE} ${TROPOMI_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TRP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TRP_OUTFILE}
         cat ${OUTFILE} >> ${TRP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TRP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TRP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
#
# END OF PREVIOUS DAY (hours 21 to 24 obs)
      if [[ ${FLG} -eq 1 ]]; then
         export BIN_BEG_YY=${ASIM_MIN_YYYY}
         export BIN_BEG_MM=${ASIM_MIN_MM}
         export BIN_BEG_DD=${ASIM_MIN_DD}
         export BIN_BEG_HH=${ASIM_MIN_HH}
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
         export BIN_END_YY=${ASIM_MIN_YYYY}
         export BIN_END_MM=${ASIM_MIN_MM}
         export BIN_END_DD=${ASIM_MIN_DD}
         export BIN_END_HH=23
         export BIN_END_MN=59
         export BIN_END_SS=59
         export TRP_INFILE=\'${EXPERIMENT_TROPOMI_CO_DIR}/${TROPOMI_FILE_PRE}${ASIM_MN_YYYY}${ASIM_MN_MM}${ASIM_MN_DD}T\'
#
# COPY EXECUTABLE
         export FILE=tropomi_co_total_col_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TROPOMI_CO/native_to_ascii/${FILE} ./.
         mcc -m tropomi_co_total_col_extract.m -o tropomi_co_total_col_extract
         ./run_tropomi_co_total_col_extract.sh ${MATLAB} ${TRP_INFILE} ${OUTFILE} ${TROPOMI_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat.html 2>&1
#
      fi
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TRP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TRP_OUTFILE}
         cat ${OUTFILE} >> ${TRP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TRP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TRP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
      if [[ ! -e ${TRP_OUTFILE} ]]; then
         touch NO_TROPOMI_CO_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT TROPOMI_CO ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'${TRP_OUTFILE}\'
      export NL_FILEOUT=\'obs_seq_tropomi_co_total_col_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_TROPOMI_CO}
      export NL_USE_LOG_CO=${USE_LOG_CO_LOGIC}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_NO2=${USE_LOG_NO2_LOGIC}
      export NL_USE_LOG_SO2=${USE_LOG_SO2_LOGIC}
#
# MODEL PROFILE SETTINGS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export NL_NZ_MODEL=${NNZP_CR}
#
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#
# USE TROPOMI DATA
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_tropomi_input_nml.ksh
#
# CREATE BIAS CORRECTION NAMELIST
      export NL_DOES_FILE_EXIST=.true.
      if [[ ${DATE} -eq ${FIRST_FILTER_DATE} || ${RUN_BIAS_CORRECTION} == false ]]; then
         rm -rf ${NL_CORRECTION_FILENAME}
	 export NL_DOES_FILE_EXIST=.false.
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
correction_filename=${NL_CORRECTION_FILENAME}
nobs=1
obs_list='TROPOMI_CO_TOTAL_COL'
/
EOF
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TROPOMI_CO/work/tropomi_co_total_col_ascii_to_obs ./.
      ./tropomi_co_total_col_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ -s ${NL_FILEOUT} ]]; then
         touch NO_TROPOMI_CO_${DATE}
      fi
   fi
#
########################################################################
#
# RUN TROPOMI O3 TOTAL COLUMN OBSERVATIONS
#
########################################################################
#
   if ${RUN_TROPOMI_O3_TOTAL_COL_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/tropomi_o3_total_col_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/tropomi_o3_total_col_obs
         cd ${RUN_DIR}/${DATE}/tropomi_o3_total_col_obs
      else
         cd ${RUN_DIR}/${DATE}/tropomi_o3_total_col_obs
      fi
#
# SET TROPOMI PARAMETERS
      export NL_PATH_MODEL=${RUN_DIR}/${PAST_DATE}/ensemble_mean_output
      export NL_FILE_MODEL=wrfout_d${CR_DOMAIN}_${DATE}_mean
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export TROPOMI_FILE_PRE=S5P_OFFL_L2__O3_____
      export TROPOMI_FILE_EXT=.nc
      export OUTFILE=TEMP_FILE.dat
      export TRP_OUTFILE=TROPOMI_O3_${DATE}.dat
      rm -rf ${OUTFILE}
      rm -rf ${TRP_OUTFILE}
#
# SET OBS_WINDOW
      export BIN_BEG_YY=${ASIM_MN_YYYY}
      export BIN_BEG_MM=${ASIM_MN_MM}
      export BIN_BEG_DD=${ASIM_MN_DD}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_YY=${ASIM_MX_YYYY}
      export BIN_END_MM=${ASIM_MX_MM}
      export BIN_END_DD=${ASIM_MX_DD}
      export BIN_END_HH=${HHM_END}
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      export FLG=0
      if [[ ${ASIM_MX_HH} -eq 3 ]]; then
         export FLG=1 
         export BIN_BEG_YY=${ASIM_MX_YYYY}
         export BIN_BEG_MM=${ASIM_MX_MM}
         export BIN_BEG_DD=${ASIM_MX_DD}
         export BIN_BEG_HH=0
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
      fi
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
#
# SET TROPOMI INPUT DATA DIR
      export TRP_INFILE=\'${EXPERIMENT_TROPOMI_O3_DIR}/${TROPOMI_FILE_PRE}${YYYY}${MM}${DD}T\'
#
# COPY EXECUTABLE
      export FILE=tropomi_o3_total_col_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TROPOMI_O3/native_to_ascii/${FILE} ./.
      mcc -m tropomi_o3_total_col_extract.m -o tropomi_o3_total_col_extract
      ./run_tropomi_o3_total_col_extract.sh ${MATLAB} ${TRP_INFILE} ${OUTFILE} ${TROPOMI_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TRP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TRP_OUTFILE}
         cat ${OUTFILE} >> ${TRP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TRP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TRP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
#
# END OF PREVIOUS DAY (hours 21 to 24 obs)
      if [[ ${FLG} -eq 1 ]]; then
         export BIN_BEG_YY=${ASIM_MIN_YYYY}
         export BIN_BEG_MM=${ASIM_MIN_MM}
         export BIN_BEG_DD=${ASIM_MIN_DD}
         export BIN_BEG_HH=${ASIM_MIN_HH}
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
         export BIN_END_YY=${ASIM_MIN_YYYY}
         export BIN_END_MM=${ASIM_MIN_MM}
         export BIN_END_DD=${ASIM_MIN_DD}
         export BIN_END_HH=23
         export BIN_END_MN=59
         export BIN_END_SS=59
         export TRP_INFILE=\'${EXPERIMENT_TROPOMI_O3_DIR}/${TROPOMI_FILE_PRE}${ASIM_MN_YYYY}${ASIM_MN_MM}${ASIM_MN_DD}T\'
#
# COPY EXECUTABLE
         export FILE=tropomi_o3_total_col_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TROPOMI_O3/native_to_ascii/${FILE} ./.
         mcc -m tropomi_o3_total_col_extract.m -o tropomi_o3_total_col_extract
         ./run_tropomi_o3_total_col_extract.sh ${MATLAB} ${TRP_INFILE} ${OUTFILE} ${TROPOMI_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat.html 2>&1
#
      fi	
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TRP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TRP_OUTFILE}
         cat ${OUTFILE} >> ${TRP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TRP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TRP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
      if [[ ! -e ${TRP_OUTFILE} ]]; then
         touch NO_TROPOMI_O3_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT TROPOMI_O3 ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'${TRP_OUTFILE}\'
      export NL_FILEOUT=\'obs_seq_tropomi_o3_total_col_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_TROPOMI_O3}
      export NL_USE_LOG_CO=${USE_LOG_CO_LOGIC}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_NO2=${USE_LOG_NO2_LOGIC}
      export NL_USE_LOG_SO2=${USE_LOG_SO2_LOGIC}
#
# MODEL PROFILE SETTINGS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export NL_NZ_MODEL=${NNZP_CR}
#
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#
# USE TROPOMI DATA
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_tropomi_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TROPOMI_O3/work/tropomi_o3_total_col_ascii_to_obs ./.
      ./tropomi_o3_total_col_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ ! -s ${NL_FILEOUT} ]]; then
         touch NO_TROPOMI_O3_${DATE}
      fi
   fi
#
########################################################################
#
# RUN TROPOMI O3 TROP COLUMN OBSERVATIONS
#
########################################################################
#
   if ${RUN_TROPOMI_O3_TROP_COL_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/tropomi_o3_trop_col_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/tropomi_o3_trop_col_obs
         cd ${RUN_DIR}/${DATE}/tropomi_o3_trop_col_obs
      else
         cd ${RUN_DIR}/${DATE}/tropomi_o3_trop_col_obs
      fi
#
# SET TROPOMI PARAMETERS
      export NL_PATH_MODEL=${RUN_DIR}/${PAST_DATE}/ensemble_mean_output
      export NL_FILE_MODEL=wrfout_d${CR_DOMAIN}_${DATE}_mean
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export TROPOMI_FILE_PRE=S5P_OFFL_L2__O3_TCL_
      export TROPOMI_FILE_EXT=.nc
      export OUTFILE=TEMP_FILE.dat
      export TRP_OUTFILE=TROPOMI_O3_${DATE}.dat
      rm -rf ${OUTFILE}
      rm -rf ${TRP_OUTFILE}
#
# SET OBS_WINDOW
      export BIN_BEG_YY=${ASIM_MN_YYYY}
      export BIN_BEG_MM=${ASIM_MN_MM}
      export BIN_BEG_DD=${ASIM_MN_DD}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_YY=${ASIM_MX_YYYY}
      export BIN_END_MM=${ASIM_MX_MM}
      export BIN_END_DD=${ASIM_MX_DD}
      export BIN_END_HH=${HHM_END}
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      export FLG=0
      if [[ ${ASIM_MX_HH} -eq 3 ]]; then
         export FLG=1 
         export BIN_BEG_YY=${ASIM_MX_YYYY}
         export BIN_BEG_MM=${ASIM_MX_MM}
         export BIN_BEG_DD=${ASIM_MX_DD}
         export BIN_BEG_HH=0
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
      fi
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
#
# SET TROPOMI INPUT DATA DIR
      export TRP_INFILE=\'${EXPERIMENT_TROPOMI_O3_DIR}/${TROPOMI_FILE_PRE}${YYYY}${MM}${DD}T\'
#
# COPY EXECUTABLE
      export FILE=tropomi_o3_trop_col_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TROPOMI_O3/native_to_ascii/${FILE} ./.
      mcc -m tropomi_o3_trop_col_extract.m -o tropomi_o3_trop_col_extract
      ./run_tropomi_o3_trop_col_extract.sh ${MATLAB} ${TRP_INFILE} ${OUTFILE} ${TROPOMI_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TRP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TRP_OUTFILE}
         cat ${OUTFILE} >> ${TRP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TRP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TRP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
#
# END OF PREVIOUS DAY (hours 21 to 24 obs)
      if [[ ${FLG} -eq 1 ]]; then
         export BIN_BEG_YY=${ASIM_MIN_YYYY}
         export BIN_BEG_MM=${ASIM_MIN_MM}
         export BIN_BEG_DD=${ASIM_MIN_DD}
         export BIN_BEG_HH=${ASIM_MIN_HH}
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
         export BIN_END_YY=${ASIM_MIN_YYYY}
         export BIN_END_MM=${ASIM_MIN_MM}
         export BIN_END_DD=${ASIM_MIN_DD}
         export BIN_END_HH=23
         export BIN_END_MN=59
         export BIN_END_SS=59
         export TRP_INFILE=\'${EXPERIMENT_TROPOMI_O3_DIR}/${TROPOMI_FILE_PRE}${ASIM_MN_YYYY}${ASIM_MN_MM}${ASIM_MN_DD}T\'
#
# COPY EXECUTABLE
         export FILE=tropomi_o3_trop_col_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TROPOMI_O3/native_to_ascii/${FILE} ./.
         mcc -m tropomi_o3_trop_col_extract.m -o tropomi_o3_trop_col_extract
         ./run_tropomi_o3_trop_col_extract.sh ${MATLAB} ${TRP_INFILE} ${OUTFILE} ${TROPOMI_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat.html 2>&1
#
      fi	
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TRP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TRP_OUTFILE}
         cat ${OUTFILE} >> ${TRP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TRP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TRP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
      if [[ ! -e ${TRP_OUTFILE} ]]; then
         touch NO_TROPOMI_O3_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT TROPOMI_O3 ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'${TRP_OUTFILE}\'
      export NL_FILEOUT=\'obs_seq_tropomi_o3_trop_col_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_TROPOMI_O3}
      export NL_USE_LOG_CO=${USE_LOG_CO_LOGIC}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_NO2=${USE_LOG_NO2_LOGIC}
      export NL_USE_LOG_SO2=${USE_LOG_SO2_LOGIC}
#
# MODEL PROFILE SETTINGS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export NL_NZ_MODEL=${NNZP_CR}
#
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#
# USE TROPOMI DATA
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_tropomi_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TROPOMI_O3/work/tropomi_o3_trop_col_ascii_to_obs ./.
      ./tropomi_o3_trop_col_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ ! -s ${NL_FILEOUT} ]]; then
         touch NO_TROPOMI_O3_${DATE}
      fi
   fi
#
########################################################################
#
# RUN TROPOMI O3 PROFILE OBSERVATIONS
#
########################################################################
#
   if ${RUN_TROPOMI_O3_PROFILE_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/tropomi_o3_profile_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/tropomi_o3_profile_obs
         cd ${RUN_DIR}/${DATE}/tropomi_o3_profile_obs
      else
         cd ${RUN_DIR}/${DATE}/tropomi_o3_profile_obs
      fi
#
# SET TROPOMI PARAMETERS
      export NL_PATH_MODEL=${RUN_DIR}/${PAST_DATE}/ensemble_mean_output
      export NL_FILE_MODEL=wrfout_d${CR_DOMAIN}_${DATE}_mean
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export TROPOMI_FILE_PRE=S5P_OFFL_L2__O3_____
      export TROPOMI_FILE_EXT=.nc
      export OUTFILE=TEMP_FILE.dat
      export TRP_OUTFILE=TROPOMI_O3_${DATE}.dat
      rm -rf ${OUTFILE}
      rm -rf ${TRP_OUTFILE}
#
# SET OBS_WINDOW
      export BIN_BEG_YY=${ASIM_MN_YYYY}
      export BIN_BEG_MM=${ASIM_MN_MM}
      export BIN_BEG_DD=${ASIM_MN_DD}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_YY=${ASIM_MX_YYYY}
      export BIN_END_MM=${ASIM_MX_MM}
      export BIN_END_DD=${ASIM_MX_DD}
      export BIN_END_HH=${HHM_END}
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      export FLG=0
      if [[ ${ASIM_MX_HH} -eq 3 ]]; then
         export FLG=1 
         export BIN_BEG_YY=${ASIM_MX_YYYY}
         export BIN_BEG_MM=${ASIM_MX_MM}
         export BIN_BEG_DD=${ASIM_MX_DD}
         export BIN_BEG_HH=0
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
      fi
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
#
# SET TROPOMI INPUT DATA DIR
      export TRP_INFILE=\'${EXPERIMENT_TROPOMI_O3_DIR}/${TROPOMI_FILE_PRE}${YYYY}${MM}${DD}T\'
#
# COPY EXECUTABLE
      export FILE=tropomi_o3_profile_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TROPOMI_O3/native_to_ascii/${FILE} ./.
      mcc -m tropomi_o3_profile_extract.m -o tropomi_o3_profile_extract
      ./run_tropomi_o3_profile_extract.sh ${MATLAB} ${TRP_INFILE} ${OUTFILE} ${TROPOMI_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TRP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TRP_OUTFILE}
         cat ${OUTFILE} >> ${TRP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TRP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TRP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
#
# END OF PREVIOUS DAY (hours 21 to 24 obs)
      if [[ ${FLG} -eq 1 ]]; then
         export BIN_BEG_YY=${ASIM_MIN_YYYY}
         export BIN_BEG_MM=${ASIM_MIN_MM}
         export BIN_BEG_DD=${ASIM_MIN_DD}
         export BIN_BEG_HH=${ASIM_MIN_HH}
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
         export BIN_END_YY=${ASIM_MIN_YYYY}
         export BIN_END_MM=${ASIM_MIN_MM}
         export BIN_END_DD=${ASIM_MIN_DD}
         export BIN_END_HH=23
         export BIN_END_MN=59
         export BIN_END_SS=59
         export TRP_INFILE=\'${EXPERIMENT_TROPOMI_O3_DIR}/${TROPOMI_FILE_PRE}${ASIM_MN_YYYY}${ASIM_MN_MM}${ASIM_MN_DD}T\'
#
# COPY EXECUTABLE
         export FILE=tropomi_o3_profile_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TROPOMI_O3/native_to_ascii/${FILE} ./.
         mcc -m tropomi_o3_profile_extract.m -o tropomi_o3_profile_extract
         ./run_tropomi_o3_profile_extract.sh ${MATLAB} ${TRP_INFILE} ${OUTFILE} ${TROPOMI_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat.html 2>&1
#
      fi	
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TRP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TRP_OUTFILE}
         cat ${OUTFILE} >> ${TRP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TRP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TRP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
      if [[ ! -e ${TRP_OUTFILE} ]]; then
         touch NO_TROPOMI_O3_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT TROPOMI_O3 ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'${TRP_OUTFILE}\'
      export NL_FILEOUT=\'obs_seq_tropomi_o3_profile_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_TROPOMI_O3}
      export NL_USE_LOG_CO=${USE_LOG_CO_LOGIC}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_NO2=${USE_LOG_NO2_LOGIC}
      export NL_USE_LOG_SO2=${USE_LOG_SO2_LOGIC}
#
# MODEL PROFILE SETTINGS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export NL_NZ_MODEL=${NNZP_CR}
#
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#
# USE TROPOMI DATA
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_tropomi_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TROPOMI_O3/work/tropomi_o3_profile_ascii_to_obs ./.
      ./tropomi_o3_profile_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ ! -s ${NL_FILEOUT} ]]; then
         touch NO_TROPOMI_O3_${DATE}
      fi
   fi
#
########################################################################
#
# RUN TROPOMI O3 CPSR OBSERVATIONS
#
########################################################################
#
   if ${RUN_TROPOMI_O3_CPSR_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/tropomi_o3_cpsr_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/tropomi_o3_cpsr_obs
         cd ${RUN_DIR}/${DATE}/tropomi_o3_cpsr_obs
      else
         cd ${RUN_DIR}/${DATE}/tropomi_o3_cpsr_obs
      fi
#
# SET TROPOMI PARAMETERS
      export NL_PATH_MODEL=${RUN_DIR}/${PAST_DATE}/ensemble_mean_output
      export NL_FILE_MODEL=wrfout_d${CR_DOMAIN}_${DATE}_mean
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export TROPOMI_FILE_PRE=S5P_OFFL_L2__O3_____
      export TROPOMI_FILE_EXT=.nc
      export OUTFILE=TEMP_FILE.dat
      export TRP_OUTFILE=TROPOMI_O3_${DATE}.dat
      rm -rf ${OUTFILE}
      rm -rf ${TRP_OUTFILE}
#
# SET OBS_WINDOW
      export BIN_BEG_YY=${ASIM_MN_YYYY}
      export BIN_BEG_MM=${ASIM_MN_MM}
      export BIN_BEG_DD=${ASIM_MN_DD}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_YY=${ASIM_MX_YYYY}
      export BIN_END_MM=${ASIM_MX_MM}
      export BIN_END_DD=${ASIM_MX_DD}
      export BIN_END_HH=${HHM_END}
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      export FLG=0
      if [[ ${ASIM_MX_HH} -eq 3 ]]; then
         export FLG=1 
         export BIN_BEG_YY=${ASIM_MX_YYYY}
         export BIN_BEG_MM=${ASIM_MX_MM}
         export BIN_BEG_DD=${ASIM_MX_DD}
         export BIN_BEG_HH=0
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
      fi
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
#
# SET TROPOMI INPUT DATA DIR
      export TRP_INFILE=\'${EXPERIMENT_TROPOMI_O3_DIR}/${TROPOMI_FILE_PRE}${YYYY}${MM}${DD}T\'
#
# COPY EXECUTABLE
      export FILE=tropomi_o3_cpsr_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TROPOMI_O3/native_to_ascii/${FILE} ./.
      mcc -m tropomi_o3_cpsr_extract.m -o tropomi_o3_cpsr_extract
      ./run_tropomi_o3_cpsr_extract.sh ${MATLAB} ${TRP_INFILE} ${OUTFILE} ${TROPOMI_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TRP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TRP_OUTFILE}
         cat ${OUTFILE} >> ${TRP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TRP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TRP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
#
# END OF PREVIOUS DAY (hours 21 to 24 obs)
      if [[ ${FLG} -eq 1 ]]; then
         export BIN_BEG_YY=${ASIM_MIN_YYYY}
         export BIN_BEG_MM=${ASIM_MIN_MM}
         export BIN_BEG_DD=${ASIM_MIN_DD}
         export BIN_BEG_HH=${ASIM_MIN_HH}
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
         export BIN_END_YY=${ASIM_MIN_YYYY}
         export BIN_END_MM=${ASIM_MIN_MM}
         export BIN_END_DD=${ASIM_MIN_DD}
         export BIN_END_HH=23
         export BIN_END_MN=59
         export BIN_END_SS=59
         export TRP_INFILE=\'${EXPERIMENT_TROPOMI_O3_DIR}/${TROPOMI_FILE_PRE}${ASIM_MN_YYYY}${ASIM_MN_MM}${ASIM_MN_DD}T\'
#
# COPY EXECUTABLE
         export FILE=tropomi_o3_cpsr_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TROPOMI_O3/native_to_ascii/${FILE} ./.
         mcc -m tropomi_o3_cpsr_extract.m -o tropomi_o3_cpsr_extract
         ./run_tropomi_o3_cpsr_extract.sh ${MATLAB} ${TRP_INFILE} ${OUTFILE} ${TROPOMI_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat.html 2>&1
#
      fi	
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TRP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TRP_OUTFILE}
         cat ${OUTFILE} >> ${TRP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TRP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TRP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
      if [[ ! -e ${TRP_OUTFILE} ]]; then
         touch NO_TROPOMI_O3_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT TROPOMI_O3 ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'${TRP_OUTFILE}\'
      export NL_FILEOUT=\'obs_seq_tropomi_o3_cpsr_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_TROPOMI_O3}
      export NL_USE_LOG_CO=${USE_LOG_CO_LOGIC}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_NO2=${USE_LOG_NO2_LOGIC}
      export NL_USE_LOG_SO2=${USE_LOG_SO2_LOGIC}
#
# MODEL CPSR SETTINGS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export NL_NZ_MODEL=${NNZP_CR}
#
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#
# USE TROPOMI DATA
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_tropomi_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TROPOMI_O3/work/tropomi_o3_cpsr_ascii_to_obs ./.
      ./tropomi_o3_cpsr_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ ! -s ${NL_FILEOUT} ]]; then
         touch NO_TROPOMI_O3_${DATE}
      fi
   fi
#
########################################################################
#
# RUN TROPOMI NO2 TOTAL COL OBSERVATIONS
#
########################################################################
#
   if ${RUN_TROPOMI_NO2_TOTAL_COL_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/tropomi_no2_total_col_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/tropomi_no2_total_col_obs
         cd ${RUN_DIR}/${DATE}/tropomi_no2_total_col_obs
      else
         cd ${RUN_DIR}/${DATE}/tropomi_no2_total_col_obs
      fi
#
# SET TROPOMI PARAMETERS
      export NL_PATH_MODEL=${RUN_DIR}/${PAST_DATE}/ensemble_mean_output
      export NL_FILE_MODEL=wrfout_d${CR_DOMAIN}_${DATE}_mean
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export TROPOMI_FILE_PRE=S5P_OFFL_L2__NO2____
      export TROPOMI_FILE_EXT=.nc
      export OUTFILE=TEMP_FILE.dat
      export TRP_OUTFILE=TROPOMI_NO2_${DATE}.dat
      rm -rf ${OUTFILE}
      rm -rf ${TRP_OUTFILE}
#
# SET OBS_WINDOW
      export BIN_BEG_YY=${ASIM_MN_YYYY}
      export BIN_BEG_MM=${ASIM_MN_MM}
      export BIN_BEG_DD=${ASIM_MN_DD}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_YY=${ASIM_MX_YYYY}
      export BIN_END_MM=${ASIM_MX_MM}
      export BIN_END_DD=${ASIM_MX_DD}
      export BIN_END_HH=${HHM_END}
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      export FLG=0
      if [[ ${ASIM_MX_HH} -eq 3 ]]; then
         export FLG=1 
         export BIN_BEG_YY=${ASIM_MX_YYYY}
         export BIN_BEG_MM=${ASIM_MX_MM}
         export BIN_BEG_DD=${ASIM_MX_DD}
         export BIN_BEG_HH=0
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
      fi
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
#
# SET TROPOMI INPUT DATA FILE
      export TRP_INFILE=\'${EXPERIMENT_TROPOMI_NO2_DIR}/${TROPOMI_FILE_PRE}${YYYY}${MM}${DD}T\'
#
# COPY EXECUTABLE
      export FILE=tropomi_no2_total_col_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TROPOMI_NO2/native_to_ascii/${FILE} ./.
      mcc -m tropomi_no2_total_col_extract.m -o tropomi_no2_total_col_extract
      ./run_tropomi_no2_total_col_extract.sh ${MATLAB} ${TRP_INFILE} ${OUTFILE} ${TROPOMI_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TRP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TRP_OUTFILE}
         cat ${OUTFILE} >> ${TRP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TRP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TRP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
#
# END OF PREVIOUS DAY (hours 21 to 24 obs)
      if [[ ${FLG} -eq 1 ]]; then
         export BIN_BEG_YY=${ASIM_MIN_YYYY}
         export BIN_BEG_MM=${ASIM_MIN_MM}
         export BIN_BEG_DD=${ASIM_MIN_DD}
         export BIN_BEG_HH=${ASIM_MIN_HH}
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
         export BIN_END_YY=${ASIM_MIN_YYYY}
         export BIN_END_MM=${ASIM_MIN_MM}
         export BIN_END_DD=${ASIM_MIN_DD}
         export BIN_END_HH=23
         export BIN_END_MN=59
         export BIN_END_SS=59
	 export TRP_INFILE=\'${EXPERIMENT_TROPOMI_NO2_DIR}/${TROPOMI_FILE_PRE}${ASIM_MN_YYYY}${ASIM_MN_MM}${ASIM_MN_DD}T\'
#
# COPY EXECUTABLE
         export FILE=tropomi_no2_total_col_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TROPOMI_NO2/native_to_ascii/${FILE} ./.
         mcc -m tropomi_no2_total_col_extract.m -o tropomi_total_col_no2_extract
         ./run_tropomi_no2_total_col_extract.sh ${MATLAB} ${TRP_INFILE} ${OUTFILE} ${TROPOMI_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat.html 2>&1
#
      fi
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TRP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TRP_OUTFILE}
         cat ${OUTFILE} >> ${TRP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TRP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TRP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
      if [[ ! -e ${TRP_OUTFILE} ]]; then
         touch NO_TROPOMI_NO2_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT TROPOMI_NO2 ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'${TRP_OUTFILE}\'
      export NL_FILEOUT=\'obs_seq_tropomi_no2_total_col_${DATE}.out\'      
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_TROPOMI_NO2}
      export NL_USE_LOG_CO=${USE_LOG_CO_LOGIC}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_NO2=${USE_LOG_NO2_LOGIC}
      export NL_USE_LOG_SO2=${USE_LOG_SO2_LOGIC}
#
# MODEL PROFILE SETTINGS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export NL_NZ_MODEL=${NNZP_CR}
#
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#
# USE TROPOMI DATA
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_tropomi_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TROPOMI_NO2/work/tropomi_no2_total_col_ascii_to_obs ./.
      ./tropomi_no2_total_col_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ -s ${NL_FILEOUT} ]]; then
         touch NO_TROPOMI_NO2_${DATE}
      fi
   fi
#
########################################################################
#
# RUN TROPOMI NO2 TROP COL OBSERVATIONS
#
########################################################################
#
   if ${RUN_TROPOMI_NO2_TROP_COL_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/tropomi_no2_trop_col_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/tropomi_no2_trop_col_obs
         cd ${RUN_DIR}/${DATE}/tropomi_no2_trop_col_obs
      else
         cd ${RUN_DIR}/${DATE}/tropomi_no2_trop_col_obs
      fi
#
# SET TROPOMI PARAMETERS
      export NL_PATH_MODEL=${RUN_DIR}/${PAST_DATE}/ensemble_mean_output
      export NL_FILE_MODEL=wrfout_d${CR_DOMAIN}_${DATE}_mean
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export TROPOMI_FILE_PRE=S5P_OFFL_L2__NO2____
      export TROPOMI_FILE_EXT=.nc
      export OUTFILE=TEMP_FILE.dat
      export TRP_OUTFILE=TROPOMI_NO2_${DATE}.dat
      rm -rf ${OUTFILE}
      rm -rf ${TRP_OUTFILE}
#
# SET OBS_WINDOW
      export BIN_BEG_YY=${ASIM_MN_YYYY}
      export BIN_BEG_MM=${ASIM_MN_MM}
      export BIN_BEG_DD=${ASIM_MN_DD}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_YY=${ASIM_MX_YYYY}
      export BIN_END_MM=${ASIM_MX_MM}
      export BIN_END_DD=${ASIM_MX_DD}
      export BIN_END_HH=${HHM_END}
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      export FLG=0
      if [[ ${ASIM_MX_HH} -eq 3 ]]; then
         export FLG=1 
         export BIN_BEG_YY=${ASIM_MX_YYYY}
         export BIN_BEG_MM=${ASIM_MX_MM}
         export BIN_BEG_DD=${ASIM_MX_DD}
         export BIN_BEG_HH=0
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
      fi
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
#
# SET TROPOMI INPUT DATA FILE
      export TRP_INFILE=\'${EXPERIMENT_TROPOMI_NO2_DIR}/${TROPOMI_FILE_PRE}${YYYY}${MM}${DD}T\'
#
# COPY EXECUTABLE
      export FILE=tropomi_no2_trop_col_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TROPOMI_NO2/native_to_ascii/${FILE} ./.
      mcc -m tropomi_no2_trop_col_extract.m -o tropomi_no2_trop_col_extract
      ./run_tropomi_no2_trop_col_extract.sh ${MATLAB} ${TRP_INFILE} ${OUTFILE} ${TROPOMI_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TRP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TRP_OUTFILE}
         cat ${OUTFILE} >> ${TRP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TRP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TRP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
#
# END OF PREVIOUS DAY (hours 21 to 24 obs)
      if [[ ${FLG} -eq 1 ]]; then
         export BIN_BEG_YY=${ASIM_MIN_YYYY}
         export BIN_BEG_MM=${ASIM_MIN_MM}
         export BIN_BEG_DD=${ASIM_MIN_DD}
         export BIN_BEG_HH=${ASIM_MIN_HH}
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
         export BIN_END_YY=${ASIM_MIN_YYYY}
         export BIN_END_MM=${ASIM_MIN_MM}
         export BIN_END_DD=${ASIM_MIN_DD}
         export BIN_END_HH=23
         export BIN_END_MN=59
         export BIN_END_SS=59
	 export TRP_INFILE=\'${EXPERIMENT_TROPOMI_NO2_DIR}/${TROPOMI_FILE_PRE}${ASIM_MN_YYYY}${ASIM_MN_MM}${ASIM_MN_DD}T\'
#
# COPY EXECUTABLE
         export FILE=tropomi_no2_trop_col_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TROPOMI_NO2/native_to_ascii/${FILE} ./.
         mcc -m tropomi_no2_trop_col_extract.m -o tropomi_trop_col_no2_extract
         ./run_tropomi_no2_trop_col_extract.sh ${MATLAB} ${TRP_INFILE} ${OUTFILE} ${TROPOMI_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat.html 2>&1
#
      fi
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TRP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TRP_OUTFILE}
         cat ${OUTFILE} >> ${TRP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TRP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TRP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
      if [[ ! -e ${TRP_OUTFILE} ]]; then
         touch NO_TROPOMI_NO2_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT TROPOMI_NO2 ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'${TRP_OUTFILE}\'
      export NL_FILEOUT=\'obs_seq_tropomi_no2_trop_col_${DATE}.out\'      
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_TROPOMI_NO2}
      export NL_USE_LOG_CO=${USE_LOG_CO_LOGIC}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_NO2=${USE_LOG_NO2_LOGIC}
      export NL_USE_LOG_SO2=${USE_LOG_SO2_LOGIC}
#
# MODEL PROFILE SETTINGS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export NL_NZ_MODEL=${NNZP_CR}
#
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#
# USE TROPOMI DATA
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_tropomi_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TROPOMI_NO2/work/tropomi_no2_trop_col_ascii_to_obs ./.
      ./tropomi_no2_trop_col_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ -s ${NL_FILEOUT} ]]; then
         touch NO_TROPOMI_NO2_${DATE}
      fi
   fi
#
########################################################################
#
# RUN TROPOMI SO2 TOTAL COLUMN OBSERVATIONS
#
########################################################################
#
   if ${RUN_TROPOMI_SO2_TOTAL_COL_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/tropomi_so2_total_col_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/tropomi_total_col_so2_obs
         cd ${RUN_DIR}/${DATE}/tropomi_so2_total_col_obs
      else
         cd ${RUN_DIR}/${DATE}/tropomi_so2_total_col_obs
      fi
#
# SET TROPOMI PARAMETERS
      export NL_PATH_MODEL=${RUN_DIR}/${PAST_DATE}/ensemble_mean_output
      export NL_FILE_MODEL=wrfout_d${CR_DOMAIN}_${DATE}_mean
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export TROPOMI_FILE_PRE=S5P_OFFL_L2__SO2____
      export TROPOMI_FILE_EXT=.nc
      export OUTFILE=TEMP_FILE.dat
      export TRP_OUTFILE=TROPOMI_SO2_${DATE}.dat
      rm -rf ${OUTFILE}
      rm -rf ${TRP_OUTFILE}
#
# SET OBS_WINDOW
      export BIN_BEG_YY=${ASIM_MN_YYYY}
      export BIN_BEG_MM=${ASIM_MN_MM}
      export BIN_BEG_DD=${ASIM_MN_DD}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_YY=${ASIM_MX_YYYY}
      export BIN_END_MM=${ASIM_MX_MM}
      export BIN_END_DD=${ASIM_MX_DD}
      export BIN_END_HH=${HHM_END}
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      export FLG=0
      if [[ ${ASIM_MX_HH} -eq 3 ]]; then
         export FLG=1 
         export BIN_BEG_YY=${ASIM_MX_YYYY}
         export BIN_BEG_MM=${ASIM_MX_MM}
         export BIN_BEG_DD=${ASIM_MX_DD}
         export BIN_BEG_HH=0
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
      fi
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
#
# SET TROPOMI INPUT DATA DIR
      export TRP_INFILE=\'${EXPERIMENT_TROPOMI_SO2_DIR}/${TROPOMI_FILE_PRE}${YYYY}${MM}${DD}T\'
#
# COPY EXECUTABLE
      export FILE=tropomi_so2_total_col_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TROPOMI_SO2/native_to_ascii/${FILE} ./.
      mcc -m tropomi_so2_total_col_extract.m -o tropomi_so2_total_col_extract
      ./run_tropomi_so2_total_col_extract.sh ${MATLAB} ${TRP_INFILE} ${OUTFILE} ${TROPOMI_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat1.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TRP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TRP_OUTFILE}
         cat ${OUTFILE} >> ${TRP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TRP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TRP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
#
# END OF PREVIOUS DAY (hours 21 to 24 obs)
      if [[ ${FLG} -eq 1 ]]; then
         export BIN_BEG_HH=${ASIM_MIN_HH}
         export BIN_BEG_YY=${ASIM_MIN_YYYY}
         export BIN_BEG_MM=${ASIM_MIN_MM}
         export BIN_BEG_DD=${ASIM_MIN_DD}
         export BIN_BEG_HH=${ASIM_MIN_HH}
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
         export BIN_END_YY=${ASIM_MIN_YYYY}
         export BIN_END_MM=${ASIM_MIN_MM}
         export BIN_END_DD=${ASIM_MIN_DD}
         export BIN_END_HH=23
         export BIN_END_MN=59
         export BIN_END_SS=59
         export INFILE=\'${EXPERIMENT_TROPOMI_SO2_DIR}/${TROPOMI_FILE_PRE}${ASIM_MN_YYYY}${ASIM_MN_MM}${ASIM_MN_DD}T\'
#
# COPY EXECUTABLE
         export FILE=tropomi_so2_total_col_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TROPOMI_SO2/native_to_ascii/${FILE} ./.
         mcc -m tropomi_so2_total_col_extract.m -o tropomi_so2_total_col_extract
         ./run_tropomi_so2_total_col_extract.sh ${MATLAB} ${TRP_INFILE} ${OUTFILE} ${TROPOMI_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat2.html 2>&1
#
      fi
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TRP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TRP_OUTFILE}
         cat ${OUTFILE} >> ${TRP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TRP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TRP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
      if [[ ! -e ${TRP_OUTFILE} ]]; then
         touch NO_TROPOMI_SO2_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT TROPOMI_SO2 ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'${TRP_OUTFILE}\'
      export NL_FILEOUT=\'obs_seq_tropomi_so2_total_col_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_TROPOMI_SO2}
      export NL_USE_LOG_CO=${USE_LOG_CO_LOGIC}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_NO2=${USE_LOG_NO2_LOGIC}
      export NL_USE_LOG_SO2=${USE_LOG_SO2_LOGIC}
#
# MODEL PROFILE SETTINGS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export NL_NZ_MODEL=${NNZP_CR}
#
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#
# USE TROPOMI DATA
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_tropomi_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TROPOMI_SO2/work/tropomi_so2_total_col_ascii_to_obs ./.
      ./tropomi_so2_total_col_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ -s ${NL_FILEOUT} ]]; then
         touch NO_TROPOMI_SO2_${DATE}
      fi
   fi
#
########################################################################
#
# RUN TROPOMI SO2 PBL COLUMN OBSERVATIONS
#
########################################################################
#
   if ${RUN_TROPOMI_SO2_PBL_COL_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/tropomi_so2_pbl_col_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/tropomi_so2_pbl_col_obs
         cd ${RUN_DIR}/${DATE}/tropomi_so2_pbl_col_obs
      else
         cd ${RUN_DIR}/${DATE}/tropomi_so2_pbl_col_obs
      fi
#
# SET TROPOMI PARAMETERS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export TROPOMI_FILE_PRE=S5P_OFFL_L2__SO2____
      export TROPOMI_FILE_EXT=.nc
      export OUTFILE=TEMP_FILE.dat
      export TRP_OUTFILE=TROPOMI_SO2_${DATE}.dat
      rm -rf ${OUTFILE}
      rm -rf ${TRP_OUTFILE}
#
# SET OBS_WINDOW
      export BIN_BEG_YY=${ASIM_MN_YYYY}
      export BIN_BEG_MM=${ASIM_MN_MM}
      export BIN_BEG_DD=${ASIM_MN_DD}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_YY=${ASIM_MX_YYYY}
      export BIN_END_MM=${ASIM_MX_MM}
      export BIN_END_DD=${ASIM_MX_DD}
      export BIN_END_HH=${HHM_END}
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      export FLG=0
      if [[ ${ASIM_MX_HH} -eq 3 ]]; then
         export FLG=1 
         export BIN_BEG_YY=${ASIM_MX_YYYY}
         export BIN_BEG_MM=${ASIM_MX_MM}
         export BIN_BEG_DD=${ASIM_MX_DD}
         export BIN_BEG_HH=0
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
      fi
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
#
# SET TROPOMI INPUT DATA DIR
      export INFILE=${EXPERIMENT_TROPOMI_SO2_DIR}/${YYYY}${MM}${DD}/${TROPOMI_FILE_PRE}
#
# COPY EXECUTABLE
      export FILE=tropomi_so2_pbl_col_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TROPOMI_SO2/native_to_ascii/${FILE} ./.
      mcc -m tropomi_so2_pbl_col_extract.m -o tropomi_so2_pbl_col_extract
      ./run_tropomi_so2_pbl_col_extract.sh ${MATLAB} ${INFILE} ${OUTFILE} ${TROPOMI_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat1.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TRP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TRP_OUTFILE}
         cat ${OUTFILE} >> ${TRP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TRP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TRP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
#
# END OF PREVIOUS DAY (hours 21 to 24 obs)
      if [[ ${FLG} -eq 1 ]]; then
         export BIN_BEG_HH=${ASIM_MIN_HH}
         export BIN_BEG_YY=${ASIM_MIN_YYYY}
         export BIN_BEG_MM=${ASIM_MIN_MM}
         export BIN_BEG_DD=${ASIM_MIN_DD}
         export BIN_BEG_HH=${ASIM_MIN_HH}
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
         export BIN_END_YY=${ASIM_MIN_YYYY}
         export BIN_END_MM=${ASIM_MIN_MM}
         export BIN_END_DD=${ASIM_MIN_DD}
         export BIN_END_HH=23
         export BIN_END_MN=59
         export BIN_END_SS=59
         export INFILE=${EXPERIMENT_TROPOMI_SO2_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${TROPOMI_FILE_PRE}
#
# COPY EXECUTABLE
         export FILE=tropomi_so2_pbl_col_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TROPOMI_SO2/native_to_ascii/${FILE} ./.
         mcc -m tropomi_so2_pbl_col_extract.m -o tropomi_so2_pbl_col_extract
         ./run_tropomi_so2_pbl_col_extract.sh ${MATLAB} ${INFILE} ${OUTFILE} ${TROPOMI_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat2.html 2>&1
#
      fi
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TRP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TRP_OUTFILE}
         cat ${OUTFILE} >> ${TRP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TRP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TRP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
      if [[ ! -e ${TRP_OUTFILE} ]]; then
         touch NO_TROPOMI_SO2_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT TROPOMI_SO2 ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'${TRP_OUTFILE}\'
      export NL_FILEOUT=\'obs_seq_tropomi_so2_pbl_col_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_TROPOMI_SO2}
      export NL_USE_LOG_CO=${USE_LOG_CO_LOGIC}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_NO2=${USE_LOG_NO2_LOGIC}
      export NL_USE_LOG_SO2=${USE_LOG_SO2_LOGIC}
      export NL_USE_LOG_CH4=${USE_LOG_CH4_LOGIC}
      export NL_USE_LOG_HCHO=${USE_LOG_HCHO_LOGIC}
#
# MODEL PROFILE SETTINGS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export NL_NZ_MODEL=${NNZP_CR}
#
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#
# USE TROPOMI DATA
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_tropomi_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TROPOMI_SO2/work/tropomi_so2_pbl_col_ascii_to_obs ./.
      ./tropomi_so2_pbl_col_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ -s ${NL_FILEOUT} ]]; then
         touch NO_TROPOMI_SO2_${DATE}
      fi
   fi
#
########################################################################
#
# RUN TROPOMI CH4 TOTAL COL OBSERVATIONS
#
########################################################################
#
   if ${RUN_TROPOMI_CH4_TOTAL_COL_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/tropomi_ch4_total_col_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/tropomi_ch4_total_col_obs
         cd ${RUN_DIR}/${DATE}/tropomi_ch4_total_col_obs
      else
         cd ${RUN_DIR}/${DATE}/tropomi_ch4_total_col_obs
      fi
#
# SET TROPOMI PARAMETERS
      export NL_PATH_MODEL=${RUN_DIR}/${PAST_DATE}/ensemble_mean_output
      export NL_FILE_MODEL=wrfout_d${CR_DOMAIN}_${DATE}_mean
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export TROPOMI_FILE_PRE=S5P_OFFL_L2__CH4____
      export TROPOMI_FILE_EXT=.nc
      export OUTFILE=TEMP_FILE.dat
      export TRP_OUTFILE=TROPOMI_CH4_${DATE}.dat
      rm -rf ${OUTFILE}
      rm -rf ${TRP_OUTFILE}
#
# SET OBS_WINDOW
      export BIN_BEG_YY=${ASIM_MN_YYYY}
      export BIN_BEG_MM=${ASIM_MN_MM}
      export BIN_BEG_DD=${ASIM_MN_DD}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_YY=${ASIM_MX_YYYY}
      export BIN_END_MM=${ASIM_MX_MM}
      export BIN_END_DD=${ASIM_MX_DD}
      export BIN_END_HH=${HHM_END}
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      export FLG=0
      if [[ ${ASIM_MX_HH} -eq 3 ]]; then
         export FLG=1 
         export BIN_BEG_YY=${ASIM_MX_YYYY}
         export BIN_BEG_MM=${ASIM_MX_MM}
         export BIN_BEG_DD=${ASIM_MX_DD}
         export BIN_BEG_HH=0
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
      fi
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
#
# SET TROPOMI INPUT DATA FILE
      export TRP_INFILE=\'${EXPERIMENT_TROPOMI_CH4_DIR}/${TROPOMI_FILE_PRE}${YYYY}${MM}${DD}T\'
#
# COPY EXECUTABLE
      export FILE=tropomi_ch4_total_col_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TROPOMI_CH4/native_to_ascii/${FILE} ./.
      mcc -m tropomi_ch4_total_col_extract.m -o tropomi_ch4_total_col_extract
      ./run_tropomi_ch4_total_col_extract.sh ${MATLAB} ${TRP_INFILE} ${OUTFILE} ${TROPOMI_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat1.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TRP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TRP_OUTFILE}
         cat ${OUTFILE} >> ${TRP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TRP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TRP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
#
# END OF PREVIOUS DAY (hours 21 to 24 obs)
      if [[ ${FLG} -eq 1 ]]; then
         export BIN_BEG_YY=${ASIM_MIN_YYYY}
         export BIN_BEG_MM=${ASIM_MIN_MM}
         export BIN_BEG_DD=${ASIM_MIN_DD}
         export BIN_BEG_HH=${ASIM_MIN_HH}
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
         export BIN_END_YY=${ASIM_MIN_YYYY}
         export BIN_END_MM=${ASIM_MIN_MM}
         export BIN_END_DD=${ASIM_MIN_DD}
         export BIN_END_HH=23
         export BIN_END_MN=59
         export BIN_END_SS=59
	 export TRP_INFILE=\'${EXPERIMENT_TROPOMI_CH4_DIR}/${TROPOMI_FILE_PRE}${ASIM_MN_YYYY}${ASIM_MN_MM}${ASIM_MN_DD}T\'
#
# COPY EXECUTABLE
         export FILE=tropomi_ch4_total_col_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TROPOMI_CH4/native_to_ascii/${FILE} ./.
         mcc -m tropomi_ch4_total_col_extract.m -o tropomi_total_col_ch4_extract
         ./run_tropomi_ch4_total_col_extract.sh ${MATLAB} ${TRP_INFILE} ${OUTFILE} ${TROPOMI_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat2.html 2>&1
#
      fi
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TRP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TRP_OUTFILE}
         cat ${OUTFILE} >> ${TRP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TRP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TRP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
      if [[ ! -e ${TRP_OUTFILE} ]]; then
         touch NO_TROPOMI_CH4_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT TROPOMI_CH4 ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'${TRP_OUTFILE}\'
      export NL_FILEOUT=\'obs_seq_tropomi_ch4_total_col_${DATE}.out\'      
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_TROPOMI_CH4}
      export NL_USE_LOG_CO=${USE_LOG_CO_LOGIC}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_NO2=${USE_LOG_NO2_LOGIC}
      export NL_USE_LOG_SO2=${USE_LOG_SO2_LOGIC}
      export NL_USE_LOG_CH4=${USE_LOG_CH4_LOGIC}
      export NL_USE_LOG_HCHO=${USE_LOG_HCHO_LOGIC}
#
# MODEL PROFILE SETTINGS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export NL_NZ_MODEL=${NNZP_CR}
#
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#
# USE TROPOMI DATA
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_tropomi_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TROPOMI_CH4/work/tropomi_ch4_total_col_ascii_to_obs ./.
      ./tropomi_ch4_total_col_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ -s ${NL_FILEOUT} ]]; then
         touch NO_TROPOMI_CH4_${DATE}
      fi
   fi
#
########################################################################
#
# RUN TROPOMI CH4 TROP COL OBSERVATIONS
#
########################################################################
#
   if ${RUN_TROPOMI_CH4_TROP_COL_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/tropomi_ch4_trop_col_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/tropomi_ch4_trop_col_obs
         cd ${RUN_DIR}/${DATE}/tropomi_ch4_trop_col_obs
      else
         cd ${RUN_DIR}/${DATE}/tropomi_ch4_trop_col_obs
      fi
#
# SET TROPOMI PARAMETERS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export TROPOMI_FILE_PRE=S5P_OFFL_L2__CH4___
      export TROPOMI_FILE_EXT=.nc
      export OUTFILE=TEMP_FILE.dat
      export TRP_OUTFILE=TROPOMI_CH4_${DATE}.dat
      rm -rf ${OUTFILE}
      rm -rf ${TRP_OUTFILE}
#
# SET OBS_WINDOW
      export BIN_BEG_YY=${ASIM_MN_YYYY}
      export BIN_BEG_MM=${ASIM_MN_MM}
      export BIN_BEG_DD=${ASIM_MN_DD}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_YY=${ASIM_MX_YYYY}
      export BIN_END_MM=${ASIM_MX_MM}
      export BIN_END_DD=${ASIM_MX_DD}
      export BIN_END_HH=${HHM_END}
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      export FLG=0
      if [[ ${ASIM_MX_HH} -eq 3 ]]; then
         export FLG=1 
         export BIN_BEG_YY=${ASIM_MX_YYYY}
         export BIN_BEG_MM=${ASIM_MX_MM}
         export BIN_BEG_DD=${ASIM_MX_DD}
         export BIN_BEG_HH=0
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
      fi
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
#
# SET TROPOMI INPUT DATA FILE
      export INFILE=${EXPERIMENT_TROPOMI_CH4_DIR}/${YYYY}${MM}${DD}/${TROPOMI_FILE_PRE}
#
# COPY EXECUTABLE
      export FILE=tropomi_ch4_trop_col_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TROPOMI_CH4/native_to_ascii/${FILE} ./.
      mcc -m tropomi_ch4_trop_col_extract.m -o tropomi_ch4_trop_col_extract
      ./run_tropomi_ch4_trop_col_extract.sh ${MATLAB} ${INFILE} ${OUTFILE} ${TROPOMI_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat1.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TRP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TRP_OUTFILE}
         cat ${OUTFILE} >> ${TRP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TRP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TRP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
#
# END OF PREVIOUS DAY (hours 21 to 24 obs)
      if [[ ${FLG} -eq 1 ]]; then
         export BIN_BEG_YY=${ASIM_MIN_YYYY}
         export BIN_BEG_MM=${ASIM_MIN_MM}
         export BIN_BEG_DD=${ASIM_MIN_DD}
         export BIN_BEG_HH=${ASIM_MIN_HH}
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
         export BIN_END_YY=${ASIM_MIN_YYYY}
         export BIN_END_MM=${ASIM_MIN_MM}
         export BIN_END_DD=${ASIM_MIN_DD}
         export BIN_END_HH=23
         export BIN_END_MN=59
         export BIN_END_SS=59
         export INFILE=${EXPERIMENT_TROPOMI_CH4_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${TROPOMI_FILE_PRE}
#
# COPY EXECUTABLE
         export FILE=tropomi_ch4_trop_col_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TROPOMI_CH4/native_to_ascii/${FILE} ./.
         mcc -m tropomi_ch4_trop_col_extract.m -o tropomi_trop_col_ch4_extract
         ./run_tropomi_ch4_trop_col_extract.sh ${MATLAB} ${INFILE} ${OUTFILE} ${TROPOMI_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat2.html 2>&1
#
      fi
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TRP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TRP_OUTFILE}
         cat ${OUTFILE} >> ${TRP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TRP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TRP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
      if [[ ! -e ${TRP_OUTFILE} ]]; then
         touch NO_TROPOMI_CH4_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT TROPOMI_CH4 ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'${TRP_OUTFILE}\'
      export NL_FILEOUT=\'obs_seq_tropomi_ch4_trop_col_${DATE}.out\'      
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_TROPOMI_CH4}
      export NL_USE_LOG_CO=${USE_LOG_CO_LOGIC}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_NO2=${USE_LOG_NO2_LOGIC}
      export NL_USE_LOG_SO2=${USE_LOG_SO2_LOGIC}
      export NL_USE_LOG_CH4=${USE_LOG_CH4_LOGIC}
      export NL_USE_LOG_HCHO=${USE_LOG_HCHO_LOGIC}
#
# MODEL PROFILE SETTINGS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export NL_NZ_MODEL=${NNZP_CR}
#
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#
# USE TROPOMI DATA
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_tropomi_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TROPOMI_CH4/work/tropomi_ch4_trop_col_ascii_to_obs ./.
      ./tropomi_ch4_trop_col_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ -s ${NL_FILEOUT} ]]; then
         touch NO_TROPOMI_CH4_${DATE}
      fi
   fi
#
########################################################################
#
# RUN TROPOMI CH4 PROFILE OBSERVATIONS
#
########################################################################
#
   if ${RUN_TROPOMI_CH4_PROFILE_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/tropomi_ch4_profile_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/tropomi_ch4_profile_obs
         cd ${RUN_DIR}/${DATE}/tropomi_ch4_profile_obs
      else
         cd ${RUN_DIR}/${DATE}/tropomi_ch4_profile_obs
      fi
#
# SET TROPOMI PARAMETERS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export TROPOMI_FILE_PRE=S5P_OFFL_L2__CH4____
      export TROPOMI_FILE_EXT=.nc
      export OUTFILE=TEMP_FILE.dat
      export TRP_OUTFILE=TROPOMI_CH4_${DATE}.dat
      rm -rf ${OUTFILE}
      rm -rf ${TRP_OUTFILE}
#
# SET OBS_WINDOW
      export BIN_BEG_YY=${ASIM_MN_YYYY}
      export BIN_BEG_MM=${ASIM_MN_MM}
      export BIN_BEG_DD=${ASIM_MN_DD}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_YY=${ASIM_MX_YYYY}
      export BIN_END_MM=${ASIM_MX_MM}
      export BIN_END_DD=${ASIM_MX_DD}
      export BIN_END_HH=${HHM_END}
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      export FLG=0
      if [[ ${ASIM_MX_HH} -eq 3 ]]; then
         export FLG=1 
         export BIN_BEG_YY=${ASIM_MX_YYYY}
         export BIN_BEG_MM=${ASIM_MX_MM}
         export BIN_BEG_DD=${ASIM_MX_DD}
         export BIN_BEG_HH=0
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
      fi
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
#
# SET TROPOMI INPUT DATA FILE
      export INFILE=${EXPERIMENT_TROPOMI_CH4_DIR}/${YYYY}${MM}${DD}/${TROPOMI_FILE_PRE}
#
# COPY EXECUTABLE
      export FILE=tropomi_ch4_profile_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TROPOMI_CH4/native_to_ascii/${FILE} ./.
      mcc -m tropomi_ch4_profile_extract.m -o tropomi_ch4_profile_extract
      ./run_tropomi_ch4_profile_extract.sh ${MATLAB} ${INFILE} ${OUTFILE} ${TROPOMI_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat1.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TRP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TRP_OUTFILE}
         cat ${OUTFILE} >> ${TRP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TRP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TRP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
#
# END OF PREVIOUS DAY (hours 21 to 24 obs)
      if [[ ${FLG} -eq 1 ]]; then
         export BIN_BEG_YY=${ASIM_MIN_YYYY}
         export BIN_BEG_MM=${ASIM_MIN_MM}
         export BIN_BEG_DD=${ASIM_MIN_DD}
         export BIN_BEG_HH=${ASIM_MIN_HH}
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
         export BIN_END_YY=${ASIM_MIN_YYYY}
         export BIN_END_MM=${ASIM_MIN_MM}
         export BIN_END_DD=${ASIM_MIN_DD}
         export BIN_END_HH=23
         export BIN_END_MN=59
         export BIN_END_SS=59
         export INFILE=${EXPERIMENT_TROPOMI_CH4_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${TROPOMI_FILE_PRE}
#
# COPY EXECUTABLE
         export FILE=tropomi_ch4_profile_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TROPOMI_CH4/native_to_ascii/${FILE} ./.
         mcc -m tropomi_ch4_profile_extract.m -o tropomi_profile_ch4_extract
         ./run_tropomi_ch4_profile_extract.sh ${MATLAB} ${INFILE} ${OUTFILE} ${TROPOMI_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat2.html 2>&1
#
      fi
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TRP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TRP_OUTFILE}
         cat ${OUTFILE} >> ${TRP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TRP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TRP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
      if [[ ! -e ${TRP_OUTFILE} ]]; then
         touch NO_TROPOMI_CH4_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT TROPOMI_CH4 ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'${TRP_OUTFILE}\'
      export NL_FILEOUT=\'obs_seq_tropomi_ch4_profile_${DATE}.out\'      
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_TROPOMI_CH4}
      export NL_USE_LOG_CO=${USE_LOG_CO_LOGIC}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_NO2=${USE_LOG_NO2_LOGIC}
      export NL_USE_LOG_SO2=${USE_LOG_SO2_LOGIC}
      export NL_USE_LOG_CH4=${USE_LOG_CH4_LOGIC}
      export NL_USE_LOG_HCHO=${USE_LOG_HCHO_LOGIC}
#
# MODEL PROFILE SETTINGS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export NL_NZ_MODEL=${NNZP_CR}
#
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#
# USE TROPOMI DATA
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_tropomi_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TROPOMI_CH4/work/tropomi_ch4_profile_ascii_to_obs ./.
      ./tropomi_ch4_profile_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ -s ${NL_FILEOUT} ]]; then
         touch NO_TROPOMI_CH4_${DATE}
      fi
   fi
#
########################################################################
#
# RUN TROPOMI CH4 CPSR OBSERVATIONS
#
########################################################################
#
   if ${RUN_TROPOMI_CH4_CPSR_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/tropomi_ch4_cpsr_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/tropomi_ch4_cpsr_obs
         cd ${RUN_DIR}/${DATE}/tropomi_ch4_cpsr_obs
      else
         cd ${RUN_DIR}/${DATE}/tropomi_ch4_cpsr_obs
      fi
#
# SET TROPOMI PARAMETERS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export TROPOMI_FILE_PRE=S5P_OFFL_L2__CH4___
      export TROPOMI_FILE_EXT=.nc
      export OUTFILE=TEMP_FILE.dat
      export TRP_OUTFILE=TROPOMI_CH4_${DATE}.dat
      rm -rf ${OUTFILE}
      rm -rf ${TRP_OUTFILE}
#
# SET OBS_WINDOW
      export BIN_BEG_YY=${ASIM_MN_YYYY}
      export BIN_BEG_MM=${ASIM_MN_MM}
      export BIN_BEG_DD=${ASIM_MN_DD}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_YY=${ASIM_MX_YYYY}
      export BIN_END_MM=${ASIM_MX_MM}
      export BIN_END_DD=${ASIM_MX_DD}
      export BIN_END_HH=${HHM_END}
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      export FLG=0
      if [[ ${ASIM_MX_HH} -eq 3 ]]; then
         export FLG=1 
         export BIN_BEG_YY=${ASIM_MX_YYYY}
         export BIN_BEG_MM=${ASIM_MX_MM}
         export BIN_BEG_DD=${ASIM_MX_DD}
         export BIN_BEG_HH=0
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
      fi
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
#
# SET TROPOMI INPUT DATA FILE
      export INFILE=${EXPERIMENT_TROPOMI_CH4_DIR}/${YYYY}${MM}${DD}/${TROPOMI_FILE_PRE}
#
# COPY EXECUTABLE
      export FILE=tropomi_ch4_cpsr_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TROPOMI_CH4/native_to_ascii/${FILE} ./.
      mcc -m tropomi_ch4_cpsr_extract.m -o tropomi_ch4_cpsr_extract
      ./run_tropomi_ch4_cpsr_extract.sh ${MATLAB} ${INFILE} ${OUTFILE} ${TROPOMI_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat1.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TRP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TRP_OUTFILE}
         cat ${OUTFILE} >> ${TRP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TRP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TRP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
#
# END OF PREVIOUS DAY (hours 21 to 24 obs)
      if [[ ${FLG} -eq 1 ]]; then
         export BIN_BEG_YY=${ASIM_MIN_YYYY}
         export BIN_BEG_MM=${ASIM_MIN_MM}
         export BIN_BEG_DD=${ASIM_MIN_DD}
         export BIN_BEG_HH=${ASIM_MIN_HH}
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
         export BIN_END_YY=${ASIM_MIN_YYYY}
         export BIN_END_MM=${ASIM_MIN_MM}
         export BIN_END_DD=${ASIM_MIN_DD}
         export BIN_END_HH=23
         export BIN_END_MN=59
         export BIN_END_SS=59
         export INFILE=${EXPERIMENT_TROPOMI_SO2_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${TROPOMI_FILE_PRE}
#
# COPY EXECUTABLE
         export FILE=tropomi_ch4_cpsr_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TROPOMI_CH4/native_to_ascii/${FILE} ./.
         mcc -m tropomi_ch4_cpsr_extract.m -o tropomi_cpsr_ch4_extract
         ./run_tropomi_ch4_cpsr_extract.sh ${MATLAB} ${INFILE} ${OUTFILE} ${TROPOMI_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat2.html 2>&1
#
      fi
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TRP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TRP_OUTFILE}
         cat ${OUTFILE} >> ${TRP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TRP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TRP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
      if [[ ! -e ${TRP_OUTFILE} ]]; then
         touch NO_TROPOMI_CH4_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT TROPOMI_CH4 ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'${TRP_OUTFILE}\'
      export NL_FILEOUT=\'obs_seq_tropomi_ch4_cpsr_${DATE}.out\'      
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_TROPOMI_CH4}
      export NL_USE_LOG_CO=${USE_LOG_CO_LOGIC}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_NO2=${USE_LOG_NO2_LOGIC}
      export NL_USE_LOG_SO2=${USE_LOG_SO2_LOGIC}
      export NL_USE_LOG_CH4=${USE_LOG_CH4_LOGIC}
      export NL_USE_LOG_HCHO=${USE_LOG_HCHO_LOGIC}
#
# MODEL PROFILE SETTINGS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export NL_NZ_MODEL=${NNZP_CR}
#
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#
# USE TROPOMI DATA
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_tropomi_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TROPOMI_CH4/work/tropomi_ch4_cpsr_ascii_to_obs ./.
      ./tropomi_ch4_cpsr_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ -s ${NL_FILEOUT} ]]; then
         touch NO_TROPOMI_CH4_${DATE}
      fi
   fi
#
########################################################################
#
# RUN TROPOMI HCHO TOTAL COL OBSERVATIONS
#
########################################################################
#
   if ${RUN_TROPOMI_HCHO_TOTAL_COL_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/tropomi_hcho_total_col_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/tropomi_hcho_total_col_obs
         cd ${RUN_DIR}/${DATE}/tropomi_hcho_total_col_obs
      else
         cd ${RUN_DIR}/${DATE}/tropomi_hcho_total_col_obs
      fi
#
# SET TROPOMI PARAMETERS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export TROPOMI_FILE_PRE=S5P_OFFL_L2__HCHO___
      export TROPOMI_FILE_EXT=.nc
      export OUTFILE=TEMP_FILE.dat
      export TRP_OUTFILE=TROPOMI_HCHO_${DATE}.dat
      rm -rf ${OUTFILE}
      rm -rf ${TRP_OUTFILE}
#
# SET OBS_WINDOW
      export BIN_BEG_YY=${ASIM_MN_YYYY}
      export BIN_BEG_MM=${ASIM_MN_MM}
      export BIN_BEG_DD=${ASIM_MN_DD}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_YY=${ASIM_MX_YYYY}
      export BIN_END_MM=${ASIM_MX_MM}
      export BIN_END_DD=${ASIM_MX_DD}
      export BIN_END_HH=${HHM_END}
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      export FLG=0
      if [[ ${ASIM_MX_HH} -eq 3 ]]; then
         export FLG=1 
         export BIN_BEG_YY=${ASIM_MX_YYYY}
         export BIN_BEG_MM=${ASIM_MX_MM}
         export BIN_BEG_DD=${ASIM_MX_DD}
         export BIN_BEG_HH=0
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
      fi
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
#
# SET TROPOMI INPUT DATA FILE
      export INFILE=${EXPERIMENT_TROPOMI_HCHO_DIR}/${YYYY}${MM}${DD}/${TROPOMI_FILE_PRE}
#
# COPY EXECUTABLE
      export FILE=tropomi_hcho_total_col_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TROPOMI_HCHO/native_to_ascii/${FILE} ./.
      mcc -m tropomi_hcho_total_col_extract.m -o tropomi_hcho_total_col_extract
      ./run_tropomi_hcho_total_col_extract.sh ${MATLAB} ${INFILE} ${OUTFILE} ${TROPOMI_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat1.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TRP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TRP_OUTFILE}
         cat ${OUTFILE} >> ${TRP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TRP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TRP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
#
# END OF PREVIOUS DAY (hours 21 to 24 obs)
      if [[ ${FLG} -eq 1 ]]; then
         export BIN_BEG_YY=${ASIM_MIN_YYYY}
         export BIN_BEG_MM=${ASIM_MIN_MM}
         export BIN_BEG_DD=${ASIM_MIN_DD}
         export BIN_BEG_HH=${ASIM_MIN_HH}
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
         export BIN_END_YY=${ASIM_MIN_YYYY}
         export BIN_END_MM=${ASIM_MIN_MM}
         export BIN_END_DD=${ASIM_MIN_DD}
         export BIN_END_HH=23
         export BIN_END_MN=59
         export BIN_END_SS=59
         export INFILE=${EXPERIMENT_TROPOMI_HCHO_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${TROPOMI_FILE_PRE}
#
# COPY EXECUTABLE
         export FILE=tropomi_hcho_total_col_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TROPOMI_HCHO/native_to_ascii/${FILE} ./.
         mcc -m tropomi_hcho_total_col_extract.m -o tropomi_total_col_hcho_extract
         ./run_tropomi_hcho_total_col_extract.sh ${MATLAB} ${INFILE} ${OUTFILE} ${TROPOMI_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat2.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
         if [[ ! -e ${TRP_OUTFILE} && -e ${OUTFILE} ]]; then
            touch ${TRP_OUTFILE}
            cat ${OUTFILE} >> ${TRP_OUTFILE}
            rm -rf ${OUTFILE}
         elif [[ -e ${TRP_OUTFILE} && -e ${OUTFILE} ]]; then
            cat ${OUTFILE} >> ${TRP_OUTFILE}
            rm -rf ${OUTFILE}
         fi
#
      fi
      if [[ ! -e ${TRP_OUTFILE} ]]; then
         touch NO_TROPOMI_HCHO_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT TROPOMI_HCHO ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'${TRP_OUTFILE}\'
      export NL_FILEOUT=\'obs_seq_tropomi_hcho_total_col_${DATE}.out\'      
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_TROPOMI_HCHO}
      export NL_USE_LOG_CO=${USE_LOG_CO_LOGIC}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_NO2=${USE_LOG_NO2_LOGIC}
      export NL_USE_LOG_SO2=${USE_LOG_SO2_LOGIC}
      export NL_USE_LOG_CH4=${USE_LOG_CH4_LOGIC}
      export NL_USE_LOG_HCHO=${USE_LOG_HCHO_LOGIC}
#
# MODEL PROFILE SETTINGS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export NL_NZ_MODEL=${NNZP_CR}
#
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#
# USE TROPOMI DATA
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_tropomi_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TROPOMI_HCHO/work/tropomi_hcho_total_col_ascii_to_obs ./.
      ./tropomi_hcho_total_col_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ -s ${NL_FILEOUT} ]]; then
         touch NO_TROPOMI_HCHO_${DATE}
      fi
   fi
#
########################################################################
#
# RUN TROPOMI HCHO TROP COL OBSERVATIONS
#
########################################################################
#
   if ${RUN_TROPOMI_HCHO_TROP_COL_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/tropomi_hcho_trop_col_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/tropomi_hcho_trop_col_obs
         cd ${RUN_DIR}/${DATE}/tropomi_hcho_trop_col_obs
      else
         cd ${RUN_DIR}/${DATE}/tropomi_hcho_trop_col_obs
      fi
#
# SET TROPOMI PARAMETERS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export TROPOMI_FILE_PRE=S5P_OFFL_L2__HCHO___
      export TROPOMI_FILE_EXT=.nc
      export OUTFILE=TEMP_FILE.dat
      export TRP_OUTFILE=TROPOMI_HCHO_${DATE}.dat
      rm -rf ${OUTFILE}
      rm -rf ${TRP_OUTFILE}
#
# SET OBS_WINDOW
      export BIN_BEG_YY=${ASIM_MN_YYYY}
      export BIN_BEG_MM=${ASIM_MN_MM}
      export BIN_BEG_DD=${ASIM_MN_DD}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_YY=${ASIM_MX_YYYY}
      export BIN_END_MM=${ASIM_MX_MM}
      export BIN_END_DD=${ASIM_MX_DD}
      export BIN_END_HH=${HHM_END}
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      export FLG=0
      if [[ ${ASIM_MX_HH} -eq 3 ]]; then
         export FLG=1 
         export BIN_BEG_YY=${ASIM_MX_YYYY}
         export BIN_BEG_MM=${ASIM_MX_MM}
         export BIN_BEG_DD=${ASIM_MX_DD}
         export BIN_BEG_HH=0
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
      fi
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
#
# SET TROPOMI INPUT DATA FILE
      export INFILE=${EXPERIMENT_TROPOMI_SO2_DIR}/${YYYY}${MM}${DD}/${TROPOMI_FILE_PRE}
#
# COPY EXECUTABLE
      export FILE=tropomi_hcho_trop_col_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TROPOMI_HCHO/native_to_ascii/${FILE} ./.
      mcc -m tropomi_hcho_trop_col_extract.m -o tropomi_hcho_trop_col_extract
      ./run_tropomi_hcho_trop_col_extract.sh ${MATLAB} ${INFILE} ${OUTFILE} ${TROPOMI_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat1.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TRP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TRP_OUTFILE}
         cat ${OUTFILE} >> ${TRP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TRP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TRP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
#
# END OF PREVIOUS DAY (hours 21 to 24 obs)
      if [[ ${FLG} -eq 1 ]]; then
         export BIN_BEG_YY=${ASIM_MIN_YYYY}
         export BIN_BEG_MM=${ASIM_MIN_MM}
         export BIN_BEG_DD=${ASIM_MIN_DD}
         export BIN_BEG_HH=${ASIM_MIN_HH}
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
         export BIN_END_YY=${ASIM_MIN_YYYY}
         export BIN_END_MM=${ASIM_MIN_MM}
         export BIN_END_DD=${ASIM_MIN_DD}
         export BIN_END_HH=23
         export BIN_END_MN=59
         export BIN_END_SS=59
         export INFILE=${EXPERIMENT_TROPOMI_SO2_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${TROPOMI_FILE_PRE}
#
# COPY EXECUTABLE
         export FILE=tropomi_hcho_trop_col_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TROPOMI_HCHO/native_to_ascii/${FILE} ./.
         mcc -m tropomi_hcho_trop_col_extract.m -o tropomi_trop_col_hcho_extract
         ./run_tropomi_hcho_trop_col_extract.sh ${MATLAB} ${INFILE} ${OUTFILE} ${TROPOMI_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat2.html 2>&1
#
      fi
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TRP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TRP_OUTFILE}
         cat ${OUTFILE} >> ${TRP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TRP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TRP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
      if [[ ! -e ${TRP_OUTFILE} ]]; then
         touch NO_TROPOMI_HCHO_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT TROPOMI_HCHO ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'${TRP_OUTFILE}\'
      export NL_FILEOUT=\'obs_seq_tropomi_hcho_trop_col_${DATE}.out\'      
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_TROPOMI_HCHO}
      export NL_USE_LOG_CO=${USE_LOG_CO_LOGIC}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_NO2=${USE_LOG_NO2_LOGIC}
      export NL_USE_LOG_SO2=${USE_LOG_SO2_LOGIC}
      export NL_USE_LOG_CH4=${USE_LOG_CH4_LOGIC}
      export NL_USE_LOG_HCHO=${USE_LOG_HCHO_LOGIC}
#
# MODEL PROFILE SETTINGS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export NL_NZ_MODEL=${NNZP_CR}
#
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#
# USE TROPOMI DATA
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_tropomi_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TROPOMI_HCHO/work/tropomi_hcho_trop_col_ascii_to_obs ./.
      ./tropomi_hcho_trop_col_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ -s ${NL_FILEOUT} ]]; then
         touch NO_TROPOMI_HCHO_${DATE}
      fi
   fi
#
########################################################################
#
# RUN TEMPO O3 TOTAL COLUMN OBSERVATIONS
#
########################################################################
#
   if ${RUN_TEMPO_O3_TOTAL_COL_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/tempo_o3_total_col_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/tempo_o3_total_col_obs
         cd ${RUN_DIR}/${DATE}/tempo_o3_total_col_obs
      else
         cd ${RUN_DIR}/${DATE}/tempo_o3_total_col_obs
      fi
#
# SET TEMPO PARAMETERS
      export NL_PATH_MODEL=${RUN_DIR}/${PAST_DATE}/ensemble_mean_output
      export NL_FILE_MODEL=wrfout_d${CR_DOMAIN}_${DATE}_mean
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export TEMPO_FILE_PRE=TEMPO_O3PROF-PROXY_L2_V01_
      export TEMPO_FILE_EXT=.nc
      export OUTFILE=TEMP_FILE.dat
      export TMP_OUTFILE=TEMPO_O3_${DATE}.dat
      rm -rf ${OUTFILE}
      rm -rf ${TMP_OUTFILE}
#
# SET OBS_WINDOW
      export BIN_BEG_YY=${ASIM_MN_YYYY}
      export BIN_BEG_MM=${ASIM_MN_MM}
      export BIN_BEG_DD=${ASIM_MN_DD}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_YY=${ASIM_MX_YYYY}
      export BIN_END_MM=${ASIM_MX_MM}
      export BIN_END_DD=${ASIM_MX_DD}
      export BIN_END_HH=${HHM_END}
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      export FLG=0
      if [[ ${ASIM_MX_HH} -eq 3 ]]; then
         export FLG=1 
         export BIN_BEG_YY=${ASIM_MX_YYYY}
         export BIN_BEG_MM=${ASIM_MX_MM}
         export BIN_BEG_DD=${ASIM_MX_DD}
         export BIN_BEG_HH=0
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
      fi
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
#
# SET TEMPO INPUT DATA DIR
      export TMP_INFILE=\'${EXPERIMENT_TEMPO_O3_DIR}/${YYYY}${MM}${DD}/${TEMPO_FILE_PRE}${YYYY}${MM}${DD}T\'
#
# COPY EXECUTABLE
      export FILE=tempo_o3_total_col_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TEMPO_O3/native_to_ascii/${FILE} ./.
      mcc -m tempo_o3_total_col_extract.m -o tempo_o3_total_col_extract
      ./run_tempo_o3_total_col_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${TEMPO_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
#
# END OF PREVIOUS DAY (hours 21 to 24 obs)
      if [[ ${FLG} -eq 1 ]]; then
         export BIN_BEG_YY=${ASIM_MIN_YYYY}
         export BIN_BEG_MM=${ASIM_MIN_MM}
         export BIN_BEG_DD=${ASIM_MIN_DD}
         export BIN_BEG_HH=${ASIM_MIN_HH}
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
         export BIN_END_YY=${ASIM_MIN_YYYY}
         export BIN_END_MM=${ASIM_MIN_MM}
         export BIN_END_DD=${ASIM_MIN_DD}
         export BIN_END_HH=23
         export BIN_END_MN=59
         export BIN_END_SS=59
         export TMP_INFILE=\'${EXPERIMENT_TEMPO_O3_DIR}/${YYYY}${MM}${DD}/${TEMPO_FILE_PRE}${ASIM_MN_YYYY}${ASIM_MN_MM}${ASIM_MN_DD}T\'
#
# COPY EXECUTABLE
         export FILE=tempo_o3_total_col_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TEMPO_O3/native_to_ascii/${FILE} ./.
         mcc -m tempo_o3_total_col_extract.m -o tempo_o3_total_col_extract
         ./run_tempo_o3_total_col_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${TEMPO_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat.html 2>&1
#
      fi
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
      if [[ ! -e ${TMP_OUTFILE} ]]; then
         touch NO_TEMPO_O3_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT TEMPO_O3 ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'${TMP_OUTFILE}\'
      export NL_FILEOUT=\'obs_seq_tempo_o3_total_col_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_TEMPO_O3}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_NO2=${USE_LOG_NO2_LOGIC}
#
# MODEL PROFILE SETTINGS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
#      export NL_PATH_MODEL=\'${RUN_DIR}/${DATE}/wrfchem_chem_icbc\'
#      export NL_FILE_MODEL=\'wrfinput_d${CR_DOMAIN}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export NL_NZ_MODEL=${NNZP_CR}
#
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#      
# USE TEMPO DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_tempo_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TEMPO_O3/work/tempo_o3_total_col_ascii_to_obs ./.
      ./tempo_o3_total_col_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ -s ${NL_FILEOUT} ]]; then
         touch NO_TEMPO_O3_${DATE}
      fi
   fi
#
########################################################################
#
# RUN TEMPO O3 TROP COLUMN OBSERVATIONS
#
########################################################################
#
   if ${RUN_TEMPO_O3_TROP_COL_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/tempo_o3_trop_col_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/tempo_o3_trop_col_obs
         cd ${RUN_DIR}/${DATE}/tempo_o3_trop_col_obs
      else
         cd ${RUN_DIR}/${DATE}/tempo_o3_trop_col_obs
      fi
#
# SET TEMPO PARAMETERS
      export NL_PATH_MODEL=${RUN_DIR}/${PAST_DATE}/ensemble_mean_output
      export NL_FILE_MODEL=wrfout_d${CR_DOMAIN}_${DATE}_mean
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export TEMPO_FILE_PRE=TEMPO_O3PROF-PROXY_L2_V01_
      export TEMPO_FILE_EXT=.nc
      export OUTFILE=TEMP_FILE.dat
      export TMP_OUTFILE=TEMPO_O3_${DATE}.dat
      rm -rf ${OUTFILE}
      rm -rf ${TMP_OUTFILE}
#
# SET OBS_WINDOW
      export BIN_BEG_YY=${ASIM_MN_YYYY}
      export BIN_BEG_MM=${ASIM_MN_MM}
      export BIN_BEG_DD=${ASIM_MN_DD}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_YY=${ASIM_MX_YYYY}
      export BIN_END_MM=${ASIM_MX_MM}
      export BIN_END_DD=${ASIM_MX_DD}
      export BIN_END_HH=${HHM_END}
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      export FLG=0
      if [[ ${ASIM_MX_HH} -eq 3 ]]; then
         export FLG=1 
         export BIN_BEG_YY=${ASIM_MX_YYYY}
         export BIN_BEG_MM=${ASIM_MX_MM}
         export BIN_BEG_DD=${ASIM_MX_DD}
         export BIN_BEG_HH=0
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
      fi
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
#
# SET TEMPO INPUT DATA DIR
      export TMP_INFILE=\'${EXPERIMENT_TEMPO_O3_DIR}/${YYYY}${MM}${DD}/${TEMPO_FILE_PRE}${YYYY}${MM}${DD}T\'
#
# COPY EXECUTABLE
      export FILE=tempo_o3_trop_col_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TEMPO_O3/native_to_ascii/${FILE} ./.
      mcc -m tempo_o3_trop_col_extract.m -o tempo_o3_trop_col_extract
      ./run_tempo_o3_trop_col_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${TEMPO_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
#
# END OF PREVIOUS DAY (hours 21 to 24 obs)
      if [[ ${FLG} -eq 1 ]]; then
         export BIN_BEG_YY=${ASIM_MIN_YYYY}
         export BIN_BEG_MM=${ASIM_MIN_MM}
         export BIN_BEG_DD=${ASIM_MIN_DD}
         export BIN_BEG_HH=${ASIM_MIN_HH}
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
         export BIN_END_YY=${ASIM_MIN_YYYY}
         export BIN_END_MM=${ASIM_MIN_MM}
         export BIN_END_DD=${ASIM_MIN_DD}
         export BIN_END_HH=23
         export BIN_END_MN=59
         export BIN_END_SS=59
         export TMP_INFILE=\'${EXPERIMENT_TEMPO_O3_DIR}/${YYYY}${MM}${DD}/${TEMPO_FILE_PRE}${ASIM_MN_YYYY}${ASIM_MN_MM}${ASIM_MN_DD}T\'
#
# COPY EXECUTABLE
         export FILE=tempo_o3_trop_col_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TEMPO_O3/native_to_ascii/${FILE} ./.
         mcc -m tempo_o3_trop_col_extract.m -o tempo_o3_trop_col_extract
         ./run_tempo_o3_trop_col_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${TEMPO_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat.html 2>&1
#
      fi
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
      if [[ ! -e ${TMP_OUTFILE} ]]; then
         touch NO_TEMPO_O3_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT TEMPO_O3 ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'${TMP_OUTFILE}\'
      export NL_FILEOUT=\'obs_seq_tempo_o3_trop_col_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_TEMPO_O3}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_NO2=${USE_LOG_NO2_LOGIC}
#
# MODEL PROFILE SETTINGS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
#      export NL_PATH_MODEL=\'${RUN_DIR}/${DATE}/wrfchem_chem_icbc\'
#      export NL_FILE_MODEL=\'wrfinput_d${CR_DOMAIN}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export NL_NZ_MODEL=${NNZP_CR}
#
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#      
# USE TEMPO DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_tempo_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TEMPO_O3/work/tempo_o3_trop_col_ascii_to_obs ./.
      ./tempo_o3_trop_col_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ -s ${NL_FILEOUT} ]]; then
         touch NO_TEMPO_O3_${DATE}
      fi
   fi
#
########################################################################
#
# RUN TEMPO O3 PROFILE OBSERVATIONS
#
########################################################################
#
   if ${RUN_TEMPO_O3_PROFILE_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/tempo_o3_profile_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/tempo_o3_profile_obs
         cd ${RUN_DIR}/${DATE}/tempo_o3_profile_obs
      else
         cd ${RUN_DIR}/${DATE}/tempo_o3_profile_obs
      fi
#
# SET TEMPO PARAMETERS
      export NL_PATH_MODEL=${RUN_DIR}/${PAST_DATE}/ensemble_mean_output
      export NL_FILE_MODEL=wrfout_d${CR_DOMAIN}_${DATE}_mean
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export TEMPO_FILE_PRE=TEMPO_O3PROF-PROXY_L2_V01_
      export TEMPO_FILE_EXT=.nc
      export OUTFILE=TEMP_FILE.dat
      export TMP_OUTFILE=TEMPO_O3_${DATE}.dat
      rm -rf ${OUTFILE}
      rm -rf ${TMP_OUTFILE}
#
# SET OBS_WINDOW
      export BIN_BEG_YY=${ASIM_MN_YYYY}
      export BIN_BEG_MM=${ASIM_MN_MM}
      export BIN_BEG_DD=${ASIM_MN_DD}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_YY=${ASIM_MX_YYYY}
      export BIN_END_MM=${ASIM_MX_MM}
      export BIN_END_DD=${ASIM_MX_DD}
      export BIN_END_HH=${HHM_END}
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      export FLG=0
      if [[ ${ASIM_MX_HH} -eq 3 ]]; then
         export FLG=1 
         export BIN_BEG_YY=${ASIM_MX_YYYY}
         export BIN_BEG_MM=${ASIM_MX_MM}
         export BIN_BEG_DD=${ASIM_MX_DD}
         export BIN_BEG_HH=0
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
      fi
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
#
# SET TEMPO INPUT DATA DIR
      export TMP_INFILE=\'${EXPERIMENT_TEMPO_O3_DIR}/${YYYY}${MM}${DD}/${TEMPO_FILE_PRE}${YYYY}${MM}${DD}T\'
#
# COPY EXECUTABLE
      export FILE=tempo_o3_profile_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TEMPO_O3/native_to_ascii/${FILE} ./.
      mcc -m tempo_o3_profile_extract.m -o tempo_o3_profile_extract
      ./run_tempo_o3_profile_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${TEMPO_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
#
# END OF PREVIOUS DAY (hours 21 to 24 obs)
      if [[ ${FLG} -eq 1 ]]; then
         export BIN_BEG_YY=${ASIM_MIN_YYYY}
         export BIN_BEG_MM=${ASIM_MIN_MM}
         export BIN_BEG_DD=${ASIM_MIN_DD}
         export BIN_BEG_HH=${ASIM_MIN_HH}
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
         export BIN_END_YY=${ASIM_MIN_YYYY}
         export BIN_END_MM=${ASIM_MIN_MM}
         export BIN_END_DD=${ASIM_MIN_DD}
         export BIN_END_HH=23
         export BIN_END_MN=59
         export BIN_END_SS=59
         export TMP_INFILE=\'${EXPERIMENT_TEMPO_O3_DIR}/${YYYY}${MM}${DD}/${TEMPO_FILE_PRE}${ASIM_MN_YYYY}${ASIM_MN_MM}${ASIM_MN_DD}T\'
#
# COPY EXECUTABLE
         export FILE=tempo_o3_profile_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TEMPO_O3/native_to_ascii/${FILE} ./.
         mcc -m tempo_o3_profile_extract.m -o tempo_o3_profile_extract
         ./run_tempo_o3_profile_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${TEMPO_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat.html 2>&1
#
      fi
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
      if [[ ! -e ${TMP_OUTFILE} ]]; then
         touch NO_TEMPO_O3_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT TEMPO_O3 ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'${TMP_OUTFILE}\'
      export NL_FILEOUT=\'obs_seq_tempo_o3_profile_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_TEMPO_O3}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_NO2=${USE_LOG_NO2_LOGIC}
#
# MODEL PROFILE SETTINGS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
#      export NL_PATH_MODEL=\'${RUN_DIR}/${DATE}/wrfchem_chem_icbc\'
#      export NL_FILE_MODEL=\'wrfinput_d${CR_DOMAIN}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export NL_NZ_MODEL=${NNZP_CR}
#
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#      
# USE TEMPO DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_tempo_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TEMPO_O3/work/tempo_o3_profile_ascii_to_obs ./.
      ./tempo_o3_profile_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ -s ${NL_FILEOUT} ]]; then
         touch NO_TEMPO_O3_${DATE}
      fi
   fi
#
########################################################################
#
# RUN TEMPO O3 CPSR OBSERVATIONS
#
########################################################################
#
   if ${RUN_TEMPO_O3_CPSR_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/tempo_o3_cpsr_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/tempo_o3_cpsr_obs
         cd ${RUN_DIR}/${DATE}/tempo_o3_cpsr_obs
      else
         cd ${RUN_DIR}/${DATE}/tempo_o3_cpsr_obs
      fi
#
# SET TEMPO PARAMETERS
      export NL_PATH_MODEL=${RUN_DIR}/${PAST_DATE}/ensemble_mean_output
      export NL_FILE_MODEL=wrfout_d${CR_DOMAIN}_${DATE}_mean
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export TEMPO_FILE_PRE=TEMPO_O3PROF-PROXY_L2_V01_
      export TEMPO_FILE_EXT=.nc
      export OUTFILE=TEMP_FILE.dat
      export TMP_OUTFILE=TEMPO_O3_${DATE}.dat
      rm -rf ${OUTFILE}
      rm -rf ${TMP_OUTFILE}
#
# SET OBS_WINDOW
      export BIN_BEG_YY=${ASIM_MN_YYYY}
      export BIN_BEG_MM=${ASIM_MN_MM}
      export BIN_BEG_DD=${ASIM_MN_DD}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_YY=${ASIM_MX_YYYY}
      export BIN_END_MM=${ASIM_MX_MM}
      export BIN_END_DD=${ASIM_MX_DD}
      export BIN_END_HH=${HHM_END}
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      export FLG=0
      if [[ ${ASIM_MX_HH} -eq 3 ]]; then
         export FLG=1 
         export BIN_BEG_YY=${ASIM_MX_YYYY}
         export BIN_BEG_MM=${ASIM_MX_MM}
         export BIN_BEG_DD=${ASIM_MX_DD}
         export BIN_BEG_HH=0
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
      fi
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
#
# SET TEMPO INPUT DATA DIR
      export TMP_INFILE=\'${EXPERIMENT_TEMPO_O3_DIR}/${YYYY}${MM}${DD}/${TEMPO_FILE_PRE}${YYYY}${MM}${DD}T\'
#
# COPY EXECUTABLE
      export FILE=tempo_o3_cpsr_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TEMPO_O3/native_to_ascii/${FILE} ./.
      mcc -m tempo_o3_cpsr_extract.m -o tempo_o3_cpsr_extract
      ./run_tempo_o3_cpsr_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${TEMPO_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
#
# END OF PREVIOUS DAY (hours 21 to 24 obs)
      if [[ ${FLG} -eq 1 ]]; then
         export BIN_BEG_YY=${ASIM_MIN_YYYY}
         export BIN_BEG_MM=${ASIM_MIN_MM}
         export BIN_BEG_DD=${ASIM_MIN_DD}
         export BIN_BEG_HH=${ASIM_MIN_HH}
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
         export BIN_END_YY=${ASIM_MIN_YYYY}
         export BIN_END_MM=${ASIM_MIN_MM}
         export BIN_END_DD=${ASIM_MIN_DD}
         export BIN_END_HH=23
         export BIN_END_MN=59
         export BIN_END_SS=59
         export TMP_INFILE=\'${EXPERIMENT_TEMPO_O3_DIR}/${YYYY}${MM}${DD}/${TEMPO_FILE_PRE}${ASIM_MN_YYYY}${ASIM_MN_MM}${ASIM_MN_DD}T\'
#
# COPY EXECUTABLE
         export FILE=tempo_o3_cpsr_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TEMPO_O3/native_to_ascii/${FILE} ./.
         mcc -m tempo_o3_cpsr_extract.m -o tempo_o3_cpsr_extract
         ./run_tempo_o3_cpsr_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${TEMPO_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat.html 2>&1
#
      fi
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
      if [[ ! -e ${TMP_OUTFILE} ]]; then
         touch NO_TEMPO_O3_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT TEMPO_O3 ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'${TMP_OUTFILE}\'
      export NL_FILEOUT=\'obs_seq_tempo_o3_cpsr_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_TEMPO_O3}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_NO2=${USE_LOG_NO2_LOGIC}
#
# MODEL CPSR SETTINGS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
#      export NL_PATH_MODEL=\'${RUN_DIR}/${DATE}/wrfchem_chem_icbc\'
#      export NL_FILE_MODEL=\'wrfinput_d${CR_DOMAIN}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export NL_NZ_MODEL=${NNZP_CR}
#
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#      
# USE TEMPO DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_tempo_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TEMPO_O3/work/tempo_o3_cpsr_ascii_to_obs ./.
      ./tempo_o3_cpsr_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ -s ${NL_FILEOUT} ]]; then
         touch NO_TEMPO_O3_${DATE}
      fi
   fi
#
########################################################################
#
# RUN TEMPO NO2 TOTAL COL OBSERVATIONS
#
########################################################################
#
   if ${RUN_TEMPO_NO2_TOTAL_COL_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/tempo_no2_total_col_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/tempo_no2_total_col_obs
         cd ${RUN_DIR}/${DATE}/tempo_no2_total_col_obs
      else
         cd ${RUN_DIR}/${DATE}/tempo_no2_total_col_obs
      fi
#
# SET TEMPO PARAMETERS
      export NL_PATH_MODEL=${RUN_DIR}/${PAST_DATE}/ensemble_mean_output
      export NL_FILE_MODEL=wrfout_d${CR_DOMAIN}_${DATE}_mean
#      export NL_PATH_MODEL=${RUN_DIR}/${DATE}/ensemble_mean_input
#      export NL_FILE_MODEL=wrfinput_d${CR_DOMAIN}_mean

      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export TEMPO_FILE_PRE=TEMPO_NO2_L2_V01_
      export TEMPO_FILE_EXT=.nc
      export OUTFILE=TEMP_FILE.dat
      export TMP_OUTFILE=TEMPO_NO2_${DATE}.dat
      rm -rf ${OUTFILE}
      rm -rf ${TMP_OUTFILE}
#
# SET OBS_WINDOW
      export BIN_BEG_YY=${ASIM_MN_YYYY}
      export BIN_BEG_MM=${ASIM_MN_MM}
      export BIN_BEG_DD=${ASIM_MN_DD}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_YY=${ASIM_MX_YYYY}
      export BIN_END_MM=${ASIM_MX_MM}
      export BIN_END_DD=${ASIM_MX_DD}
      export BIN_END_HH=${HHM_END}
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      export FLG=0
      if [[ ${ASIM_MX_HH} -eq 3 ]]; then
         export FLG=1 
         export BIN_BEG_YY=${ASIM_MX_YYYY}
         export BIN_BEG_MM=${ASIM_MX_MM}
         export BIN_BEG_DD=${ASIM_MX_DD}
         export BIN_BEG_HH=0
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
      fi
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
#
# SET TEMPO INPUT DATA DIR
      export TMP_INFILE=\'${EXPERIMENT_TEMPO_NO2_DIR}/${YYYY}${MM}/${DD}/${TEMPO_FILE_PRE}${YYYY}${MM}${DD}T\'
#
# COPY EXECUTABLE
      export FILE=tempo_no2_total_col_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TEMPO_NO2/native_to_ascii/${FILE} ./.
      mcc -m tempo_no2_total_col_extract.m -o tempo_no2_total_col_extract
      ./run_tempo_no2_total_col_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${TEMPO_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
#
# END OF PREVIOUS DAY (hours 21 to 24 obs)
      if [[ ${FLG} -eq 1 ]]; then	 
         export BIN_BEG_YY=${ASIM_MIN_YYYY}
         export BIN_BEG_MM=${ASIM_MIN_MM}
         export BIN_BEG_DD=${ASIM_MIN_DD}
         export BIN_BEG_HH=${ASIM_MIN_HH}
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
         export BIN_END_YY=${ASIM_MIN_YYYY}
         export BIN_END_MM=${ASIM_MIN_MM}
         export BIN_END_DD=${ASIM_MIN_DD}
         export BIN_END_HH=23
         export BIN_END_MN=59
         export BIN_END_SS=59
         export TMP_INFILE=\'${EXPERIMENT_TEMPO_NO2_DIR}/${TEMPO_FILE_PRE}${ASIM_MN_YYYY}${ASIM_MN_MM}${ASIM_MN_DD}T\'
#
# COPY EXECUTABLE
         export FILE=tempo_no2_total_col_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TEMPO_NO2/native_to_ascii/${FILE} ./.
         mcc -m tempo_no2_total_col_extract.m -o tempo_no2_total_col_extract
         ./run_tempo_no2_total_col_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${TEMPO_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat.html 2>&1
#
      fi
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
      if [[ ! -e ${TMP_OUTFILE} ]]; then
         touch NO_TEMPO_NO2_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT TEMPO_NO2 ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'${TMP_OUTFILE}\'
      export NL_FILEOUT=\'obs_seq_tempo_no2_total_col_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_TEMPO_NO2}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_NO2=${USE_LOG_NO2_LOGIC}
#
# MODEL PROFILE SETTINGS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
#      export NL_PATH_MODEL=\'${RUN_DIR}/${DATE}/wrfchem_chem_icbc\'
#      export NL_FILE_MODEL=\'wrfinput_d${CR_DOMAIN}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export NL_NZ_MODEL=${NNZP_CR}
#
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#      
# USE TEMPO DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_tempo_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TEMPO_NO2/work/tempo_no2_total_col_ascii_to_obs ./.
      ./tempo_no2_total_col_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ -s ${NL_FILEOUT} ]]; then
         touch NO_TEMPO_NO2_${DATE}
      fi
   fi
#
########################################################################
#
# RUN TEMPO NO2 TROP COL OBSERVATIONS
#
########################################################################
#
   if ${RUN_TEMPO_NO2_TROP_COL_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/tempo_no2_trop_col_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/tempo_no2_trop_col_obs
         cd ${RUN_DIR}/${DATE}/tempo_no2_trop_col_obs
      else
         cd ${RUN_DIR}/${DATE}/tempo_no2_trop_col_obs
      fi
#
# SET TEMPO PARAMETERS
      export NL_PATH_MODEL=${RUN_DIR}/${PAST_DATE}/ensemble_mean_output
      export NL_FILE_MODEL=wrfout_d${CR_DOMAIN}_${DATE}_mean
#      export NL_PATH_MODEL=${RUN_DIR}/${DATE}/ensemble_mean_input
#      export NL_FILE_MODEL=wrfinput_d${CR_DOMAIN}_mean

      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export TEMPO_FILE_PRE=TEMPO_NO2_L2_V01_
      export TEMPO_FILE_EXT=.nc
      export OUTFILE=TEMP_FILE.dat
      export TMP_OUTFILE=TEMPO_NO2_${DATE}.dat
      rm -rf ${OUTFILE}
      rm -rf ${TMP_OUTFILE}
#
# SET OBS_WINDOW
      export BIN_BEG_YY=${ASIM_MN_YYYY}
      export BIN_BEG_MM=${ASIM_MN_MM}
      export BIN_BEG_DD=${ASIM_MN_DD}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_YY=${ASIM_MX_YYYY}
      export BIN_END_MM=${ASIM_MX_MM}
      export BIN_END_DD=${ASIM_MX_DD}
      export BIN_END_HH=${HHM_END}
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      export FLG=0
      if [[ ${ASIM_MX_HH} -eq 3 ]]; then
         export FLG=1 
         export BIN_BEG_YY=${ASIM_MX_YYYY}
         export BIN_BEG_MM=${ASIM_MX_MM}
         export BIN_BEG_DD=${ASIM_MX_DD}
         export BIN_BEG_HH=0
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
      fi
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
#
# SET TEMPO INPUT DATA DIR
      export TMP_INFILE=\'${EXPERIMENT_TEMPO_NO2_DIR}/${YYYY}${MM}/${DD}/${TEMPO_FILE_PRE}${YYYY}${MM}${DD}T\'
#
# COPY EXECUTABLE
      export FILE=tempo_no2_trop_col_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TEMPO_NO2/native_to_ascii/${FILE} ./.
      mcc -m tempo_no2_trop_col_extract.m -o tempo_no2_trop_col_extract
      ./run_tempo_no2_trop_col_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${TEMPO_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
#
# END OF PREVIOUS DAY (hours 21 to 24 obs)
      if [[ ${FLG} -eq 1 ]]; then	 
         export BIN_BEG_YY=${ASIM_MIN_YYYY}
         export BIN_BEG_MM=${ASIM_MIN_MM}
         export BIN_BEG_DD=${ASIM_MIN_DD}
         export BIN_BEG_HH=${ASIM_MIN_HH}
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
         export BIN_END_YY=${ASIM_MIN_YYYY}
         export BIN_END_MM=${ASIM_MIN_MM}
         export BIN_END_DD=${ASIM_MIN_DD}
         export BIN_END_HH=23
         export BIN_END_MN=59
         export BIN_END_SS=59
         export TMP_INFILE=\'${EXPERIMENT_TEMPO_NO2_DIR}/${TEMPO_FILE_PRE}${ASIM_MN_YYYY}${ASIM_MN_MM}${ASIM_MN_DD}T\'
#
# COPY EXECUTABLE
         export FILE=tempo_no2_trop_col_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TEMPO_NO2/native_to_ascii/${FILE} ./.
         mcc -m tempo_no2_trop_col_extract.m -o tempo_no2_trop_col_extract
         ./run_tempo_no2_trop_col_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${TEMPO_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat.html 2>&1
#
      fi
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
      if [[ ! -e ${TMP_OUTFILE} ]]; then
         touch NO_TEMPO_NO2_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT TEMPO_NO2 ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'${TMP_OUTFILE}\'
      export NL_FILEOUT=\'obs_seq_tempo_no2_trop_col_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_TEMPO_NO2}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_NO2=${USE_LOG_NO2_LOGIC}
#
# MODEL PROFILE SETTINGS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
#      export NL_PATH_MODEL=\'${RUN_DIR}/${DATE}/wrfchem_chem_icbc\'
#      export NL_FILE_MODEL=\'wrfinput_d${CR_DOMAIN}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export NL_NZ_MODEL=${NNZP_CR}
#
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#      
# USE TEMPO DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_tempo_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TEMPO_NO2/work/tempo_no2_trop_col_ascii_to_obs ./.
      ./tempo_no2_trop_col_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ -s ${NL_FILEOUT} ]]; then
         touch NO_TEMPO_NO2_${DATE}
      fi
   fi
#
########################################################################
#
# RUN TES CO TOTAL COL OBSERVATIONS
#
########################################################################
#
   if ${RUN_TES_CO_TOTAL_COL_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/tes_co_total_col_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/tes_co_total_col_obs
         cd ${RUN_DIR}/${DATE}/tes_co_total_col_obs
      else
         cd ${RUN_DIR}/${DATE}/tes_co_total_col_obs
      fi
#
# SET TES PARAMETERS
      export NL_PATH_MODEL=${RUN_DIR}/${PAST_DATE}/ensemble_mean_output
      export NL_FILE_MODEL=wrfout_d${CR_DOMAIN}_${DATE}_mean
#      export NL_PATH_MODEL=${RUN_DIR}/${DATE}/ensemble_mean_input
#      export NL_FILE_MODEL=wrfinput_d${CR_DOMAIN}_mean

      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export TES_FILE_PRE=TES_CO_L2_V01_
      export TES_FILE_EXT=.nc
      export OUTFILE=TEMP_FILE.dat
      export TMP_OUTFILE=TES_CO_${DATE}.dat
      rm -rf ${OUTFILE}
      rm -rf ${TMP_OUTFILE}
#
# SET OBS_WINDOW
      export BIN_BEG_YY=${ASIM_MN_YYYY}
      export BIN_BEG_MM=${ASIM_MN_MM}
      export BIN_BEG_DD=${ASIM_MN_DD}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_YY=${ASIM_MX_YYYY}
      export BIN_END_MM=${ASIM_MX_MM}
      export BIN_END_DD=${ASIM_MX_DD}
      export BIN_END_HH=${HHM_END}
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      export FLG=0
      if [[ ${ASIM_MX_HH} -eq 3 ]]; then
         export FLG=1 
         export BIN_BEG_YY=${ASIM_MX_YYYY}
         export BIN_BEG_MM=${ASIM_MX_MM}
         export BIN_BEG_DD=${ASIM_MX_DD}
         export BIN_BEG_HH=0
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
      fi
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
#
# SET TES INPUT DATA DIR
      export TMP_INFILE=\'${EXPERIMENT_TES_CO_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${TES_FILE_PRE}\'
#
# COPY EXECUTABLE
      export FILE=tes_co_total_col_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TES_CO/native_to_ascii/${FILE} ./.
      mcc -m tes_co_total_col_extract.m -o tes_co_total_col_extract
      ./run_tes_co_total_col_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${TES_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat1.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
#
# END OF PREVIOUS DAY (hours 21 to 24 obs)
      if [[ ${FLG} -eq 1 ]]; then	 
         export BIN_BEG_YY=${ASIM_MIN_YYYY}
         export BIN_BEG_MM=${ASIM_MIN_MM}
         export BIN_BEG_DD=${ASIM_MIN_DD}
         export BIN_BEG_HH=${ASIM_MIN_HH}
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
         export BIN_END_YY=${ASIM_MIN_YYYY}
         export BIN_END_MM=${ASIM_MIN_MM}
         export BIN_END_DD=${ASIM_MIN_DD}
         export BIN_END_HH=23
         export BIN_END_MN=59
         export BIN_END_SS=59
         export TMP_INFILE=\'${EXPERIMENT_TES_CO_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${TES_FILE_PRE}\'
#
# COPY EXECUTABLE
         export FILE=tes_co_total_col_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TES_CO/native_to_ascii/${FILE} ./.
         mcc -m tes_co_total_col_extract.m -o tes_co_total_col_extract
         ./run_tes_co_total_col_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${TES_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat2.html 2>&1
#
      fi
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
      if [[ ! -e ${TMP_OUTFILE} ]]; then
         touch NO_TES_CO_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT TES CO ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'${TMP_OUTFILE}\'
      export NL_FILEOUT=\'obs_seq_tes_co_total_col_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_TES_CO}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_NO2=${USE_LOG_NO2_LOGIC}
#
# MODEL PROFILE SETTINGS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
#      export NL_PATH_MODEL=\'${RUN_DIR}/${DATE}/wrfchem_chem_icbc\'
#      export NL_FILE_MODEL=\'wrfinput_d${CR_DOMAIN}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export NL_NZ_MODEL=${NNZP_CR}
#
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#      
# USE TES DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_tes_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TES_CO/work/tes_co_total_col_ascii_to_obs ./.
      ./tes_co_total_col_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ -s ${NL_FILEOUT} ]]; then
         touch NO_TES_CO_${DATE}
      fi
   fi
#
########################################################################
#
# RUN TES CO PROFILE OBSERVATIONS
#
########################################################################
#
   if ${RUN_TES_CO_PROFILE_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/tes_co_profile_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/tes_co_profile_obs
         cd ${RUN_DIR}/${DATE}/tes_co_profile_obs
      else
         cd ${RUN_DIR}/${DATE}/tes_co_profile_obs
      fi
#
# SET TES PARAMETERS
      export NL_PATH_MODEL=${RUN_DIR}/${PAST_DATE}/ensemble_mean_output
      export NL_FILE_MODEL=wrfout_d${CR_DOMAIN}_${DATE}_mean

      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export TES_FILE_PRE=TES-Aura_L2-CO-SO-Nadir_r00000
      export TES_FILE_EXT=_C01_F08_11.he5
      export OUTFILE=TEMP_FILE.dat
      export TMP_OUTFILE=TES_CO_${DATE}.dat
      rm -rf ${OUTFILE}
      rm -rf ${TMP_OUTFILE}
#
# SET OBS_WINDOW
      export BIN_BEG_YY=${ASIM_MN_YYYY}
      export BIN_BEG_MM=${ASIM_MN_MM}
      export BIN_BEG_DD=${ASIM_MN_DD}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_YY=${ASIM_MX_YYYY}
      export BIN_END_MM=${ASIM_MX_MM}
      export BIN_END_DD=${ASIM_MX_DD}
      export BIN_END_HH=${HHM_END}
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      export FLG=0
      if [[ ${ASIM_MX_HH} -eq 3 ]]; then
         export FLG=1 
         export BIN_BEG_YY=${ASIM_MX_YYYY}
         export BIN_BEG_MM=${ASIM_MX_MM}
         export BIN_BEG_DD=${ASIM_MX_DD}
         export BIN_BEG_HH=0
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
      fi
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
#
# SET TES INPUT DATA DIR
      export TMP_INFILE=\'${EXPERIMENT_TES_CO_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${TES_FILE_PRE}\'
#
# COPY EXECUTABLE
      export FILE=tes_co_profile_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TES_CO/native_to_ascii/${FILE} ./.
      mcc -m tes_co_profile_extract.m -o tes_co_profile_extract
      ./run_tes_co_profile_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${TES_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat1.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
#
# END OF PREVIOUS DAY (hours 21 to 24 obs)
      if [[ ${FLG} -eq 1 ]]; then	 
         export BIN_BEG_YY=${ASIM_MIN_YYYY}
         export BIN_BEG_MM=${ASIM_MIN_MM}
         export BIN_BEG_DD=${ASIM_MIN_DD}
         export BIN_BEG_HH=${ASIM_MIN_HH}
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
         export BIN_END_YY=${ASIM_MIN_YYYY}
         export BIN_END_MM=${ASIM_MIN_MM}
         export BIN_END_DD=${ASIM_MIN_DD}
         export BIN_END_HH=23
         export BIN_END_MN=59
         export BIN_END_SS=59
         export TMP_INFILE=\'${EXPERIMENT_TES_CO_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${TES_FILE_PRE}\'
#
# COPY EXECUTABLE
         export FILE=tes_co_profile_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TES_CO/native_to_ascii/${FILE} ./.
         mcc -m tes_co_profile_extract.m -o tes_co_profile_extract
         ./run_tes_co_profile_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${TES_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat2.html 2>&1
#
      fi
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
      if [[ ! -e ${TMP_OUTFILE} ]]; then
         touch NO_TES_CO_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT TES CO ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'${TMP_OUTFILE}\'
      export NL_FILEOUT=\'obs_seq_tes_co_profile_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_TES_CO}
      export NL_USE_LOG_CO=${USE_LOG_CO_LOGIC}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_CO2=${USE_LOG_CO2_LOGIC}
      export NL_USE_LOG_CH4=${USE_LOG_CH4_LOGIC}
      export NL_USE_LOG_NH3=${USE_LOG_NH3_LOGIC}
#
# MODEL PROFILE SETTINGS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export NL_NZ_MODEL=${NNZP_CR}
#
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#      
# USE TES DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_tes_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TES_CO/work/tes_co_profile_ascii_to_obs ./.
      ./tes_co_profile_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ -s ${NL_FILEOUT} ]]; then
         touch NO_TES_CO_${DATE}
      fi
   fi
#
########################################################################
#
# RUN TES CO CPSR OBSERVATIONS
#
########################################################################
#
   if ${RUN_TES_CO_CPSR_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/tes_co_cpsr_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/tes_co_cpsr_obs
         cd ${RUN_DIR}/${DATE}/tes_co_cpsr_obs
      else
         cd ${RUN_DIR}/${DATE}/tes_co_cpsr_obs
      fi


#
# SET TES PARAMETERS
      export NL_PATH_MODEL=${RUN_DIR}/${PAST_DATE}/ensemble_mean_output
      export NL_FILE_MODEL=wrfout_d${CR_DOMAIN}_${DATE}_mean

      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export TES_FILE_PRE=TES-Aura_L2-CO-SO-Nadir_r00000
      export TES_FILE_EXT=_C01_F08_11.he5
      export OUTFILE=TEMP_FILE.dat
      export TMP_OUTFILE=TES_CO_${DATE}.dat
      rm -rf ${OUTFILE}
      rm -rf ${TMP_OUTFILE}
#
# SET OBS_WINDOW
      export BIN_BEG_YY=${ASIM_MN_YYYY}
      export BIN_BEG_MM=${ASIM_MN_MM}
      export BIN_BEG_DD=${ASIM_MN_DD}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_YY=${ASIM_MX_YYYY}
      export BIN_END_MM=${ASIM_MX_MM}
      export BIN_END_DD=${ASIM_MX_DD}
      export BIN_END_HH=${HHM_END}
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      export FLG=0
      if [[ ${ASIM_MX_HH} -eq 3 ]]; then
         export FLG=1 
         export BIN_BEG_YY=${ASIM_MX_YYYY}
         export BIN_BEG_MM=${ASIM_MX_MM}
         export BIN_BEG_DD=${ASIM_MX_DD}
         export BIN_BEG_HH=0
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
      fi
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
#
# SET TES INPUT DATA DIR
      export TMP_INFILE=\'${EXPERIMENT_TES_CO_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${TES_FILE_PRE}\'
#
# COPY EXECUTABLE
      export FILE=tes_co_cpsr_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TES_CO/native_to_ascii/${FILE} ./.
      mcc -m tes_co_cpsr_extract.m -o tes_co_cpsr_extract
      ./run_tes_co_cpsr_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${TES_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat1.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
#
# END OF PREVIOUS DAY (hours 21 to 24 obs)
      if [[ ${FLG} -eq 1 ]]; then	 
         export BIN_BEG_YY=${ASIM_MIN_YYYY}
         export BIN_BEG_MM=${ASIM_MIN_MM}
         export BIN_BEG_DD=${ASIM_MIN_DD}
         export BIN_BEG_HH=${ASIM_MIN_HH}
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
         export BIN_END_YY=${ASIM_MIN_YYYY}
         export BIN_END_MM=${ASIM_MIN_MM}
         export BIN_END_DD=${ASIM_MIN_DD}
         export BIN_END_HH=23
         export BIN_END_MN=59
         export BIN_END_SS=59
         export TMP_INFILE=\'${EXPERIMENT_TES_CO_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${TES_FILE_PRE}\'
#
# COPY EXECUTABLE
         export FILE=tes_co_cpsr_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TES_CO/native_to_ascii/${FILE} ./.
         mcc -m tes_co_cpsr_extract.m -o tes_co_cpsr_extract
         ./run_tes_co_cpsr_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${TES_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat2.html 2>&1
#
      fi
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
      if [[ ! -e ${TMP_OUTFILE} ]]; then
         touch NO_TES_CO_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT TES CO ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'${TMP_OUTFILE}\'
      export NL_FILEOUT=\'obs_seq_tes_co_cpsr_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_TES_CO}
      export NL_USE_LOG_CO=${USE_LOG_CO_LOGIC}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_CO2=${USE_LOG_CO2_LOGIC}
      export NL_USE_LOG_CH4=${USE_LOG_CH4_LOGIC}
      export NL_USE_LOG_NH3=${USE_LOG_NH3_LOGIC}
#
# MODEL CPSR SETTINGS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export NL_NZ_MODEL=${NNZP_CR}
#
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#      
# USE TES DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_tes_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TES_CO/work/tes_co_cpsr_ascii_to_obs ./.
      ./tes_co_cpsr_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ -s ${NL_FILEOUT} ]]; then
         touch NO_TES_CO_${DATE}
      fi
   fi
#
########################################################################
#
# RUN TES CO2 TOTAL COL OBSERVATIONS
#
########################################################################
#
   if ${RUN_TES_CO2_TOTAL_COL_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/tes_co2_total_col_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/tes_co2_total_col_obs
         cd ${RUN_DIR}/${DATE}/tes_co2_total_col_obs
      else
         cd ${RUN_DIR}/${DATE}/tes_co2_total_col_obs
      fi
#
# SET TES PARAMETERS
      export NL_PATH_MODEL=${RUN_DIR}/${PAST_DATE}/ensemble_mean_output
      export NL_FILE_MODEL=wrfout_d${CR_DOMAIN}_${DATE}_mean
#      export NL_PATH_MODEL=${RUN_DIR}/${DATE}/ensemble_mean_input
#      export NL_FILE_MODEL=wrfinput_d${CR_DOMAIN}_mean

      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export TES_FILE_PRE=TES_CO2_L2_V01_
      export TES_FILE_EXT=.nc
      export OUTFILE=TEMP_FILE.dat
      export TMP_OUTFILE=TES_CO2_${DATE}.dat
      rm -rf ${OUTFILE}
      rm -rf ${TMP_OUTFILE}
#
# SET OBS_WINDOW
      export BIN_BEG_YY=${ASIM_MN_YYYY}
      export BIN_BEG_MM=${ASIM_MN_MM}
      export BIN_BEG_DD=${ASIM_MN_DD}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_YY=${ASIM_MX_YYYY}
      export BIN_END_MM=${ASIM_MX_MM}
      export BIN_END_DD=${ASIM_MX_DD}
      export BIN_END_HH=${HHM_END}
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      export FLG=0
      if [[ ${ASIM_MX_HH} -eq 3 ]]; then
         export FLG=1 
         export BIN_BEG_YY=${ASIM_MX_YYYY}
         export BIN_BEG_MM=${ASIM_MX_MM}
         export BIN_BEG_DD=${ASIM_MX_DD}
         export BIN_BEG_HH=0
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
      fi
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
#
# SET TES INPUT DATA DIR
      export TMP_INFILE=\'${EXPERIMENT_TES_CO2_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${TES_FILE_PRE}\'
#
# COPY EXECUTABLE
      export FILE=tes_co2_total_col_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TES_CO2/native_to_ascii/${FILE} ./.
      mcc -m tes_co2_total_col_extract.m -o tes_co2_total_col_extract
      ./run_tes_co2_total_col_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${TES_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat1.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
#
# END OF PREVIOUS DAY (hours 21 to 24 obs)
      if [[ ${FLG} -eq 1 ]]; then	 
         export BIN_BEG_YY=${ASIM_MIN_YYYY}
         export BIN_BEG_MM=${ASIM_MIN_MM}
         export BIN_BEG_DD=${ASIM_MIN_DD}
         export BIN_BEG_HH=${ASIM_MIN_HH}
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
         export BIN_END_YY=${ASIM_MIN_YYYY}
         export BIN_END_MM=${ASIM_MIN_MM}
         export BIN_END_DD=${ASIM_MIN_DD}
         export BIN_END_HH=23
         export BIN_END_MN=59
         export BIN_END_SS=59
         export TMP_INFILE=\'${EXPERIMENT_TES_CO2_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${TES_FILE_PRE}\'
#
# COPY EXECUTABLE
         export FILE=tes_co2_total_col_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TES_CO2/native_to_ascii/${FILE} ./.
         mcc -m tes_co2_total_col_extract.m -o tes_co2_total_col_extract
         ./run_tes_co2_total_col_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${TES_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat2.html 2>&1
#
      fi
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
      if [[ ! -e ${TMP_OUTFILE} ]]; then
         touch NO_TES_CO2_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT TES CO2 ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'${TMP_OUTFILE}\'
      export NL_FILEOUT=\'obs_seq_tes_co2_total_col_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_TES_CO2}
      export NL_USE_LOG_CO=${USE_LOG_CO_LOGIC}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_CO2=${USE_LOG_CO2_LOGIC}
      export NL_USE_LOG_CH4=${USE_LOG_CH4_LOGIC}
      export NL_USE_LOG_NH3=${USE_LOG_NH3_LOGIC}
#
# MODEL PROFILE SETTINGS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
#      export NL_PATH_MODEL=\'${RUN_DIR}/${DATE}/wrfchem_chem_icbc\'
#      export NL_FILE_MODEL=\'wrfinput_d${CR_DOMAIN}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export NL_NZ_MODEL=${NNZP_CR}
#
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#      
# USE TES DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_tes_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TES_CO2/work/tes_co2_total_col_ascii_to_obs ./.
      ./tes_co2_total_col_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ -s ${NL_FILEOUT} ]]; then
         touch NO_TES_CO2_${DATE}
      fi
   fi
#
########################################################################
#
# RUN TES CO2 PROFILE OBSERVATIONS
#
########################################################################
#
   if ${RUN_TES_CO2_PROFILE_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/tes_co2_profile_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/tes_co2_profile_obs
         cd ${RUN_DIR}/${DATE}/tes_co2_profile_obs
      else
         cd ${RUN_DIR}/${DATE}/tes_co2_profile_obs
      fi
#
# SET TES PARAMETERS
      export NL_PATH_MODEL=${RUN_DIR}/${PAST_DATE}/ensemble_mean_output
      export NL_FILE_MODEL=wrfout_d${CR_DOMAIN}_${DATE}_mean

      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export TES_FILE_PRE=TES-Aura_L2-CO2-SO-Nadir_r00000
      export TES_FILE_EXT=_C01_F08_11.he5
      export OUTFILE=TEMP_FILE.dat
      export TMP_OUTFILE=TES_CO2_${DATE}.dat
      rm -rf ${OUTFILE}
      rm -rf ${TMP_OUTFILE}
#
# SET OBS_WINDOW
      export BIN_BEG_YY=${ASIM_MN_YYYY}
      export BIN_BEG_MM=${ASIM_MN_MM}
      export BIN_BEG_DD=${ASIM_MN_DD}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_YY=${ASIM_MX_YYYY}
      export BIN_END_MM=${ASIM_MX_MM}
      export BIN_END_DD=${ASIM_MX_DD}
      export BIN_END_HH=${HHM_END}
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      export FLG=0
      if [[ ${ASIM_MX_HH} -eq 3 ]]; then
         export FLG=1 
         export BIN_BEG_YY=${ASIM_MX_YYYY}
         export BIN_BEG_MM=${ASIM_MX_MM}
         export BIN_BEG_DD=${ASIM_MX_DD}
         export BIN_BEG_HH=0
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
      fi
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
#
# SET TES INPUT DATA DIR
      export TMP_INFILE=\'${EXPERIMENT_TES_CO2_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${TES_FILE_PRE}\'
#
# COPY EXECUTABLE
      export FILE=tes_co2_profile_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TES_CO2/native_to_ascii/${FILE} ./.
      mcc -m tes_co2_profile_extract.m -o tes_co2_profile_extract
      ./run_tes_co2_profile_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${TES_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat1.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
#
# END OF PREVIOUS DAY (hours 21 to 24 obs)
      if [[ ${FLG} -eq 1 ]]; then	 
         export BIN_BEG_YY=${ASIM_MIN_YYYY}
         export BIN_BEG_MM=${ASIM_MIN_MM}
         export BIN_BEG_DD=${ASIM_MIN_DD}
         export BIN_BEG_HH=${ASIM_MIN_HH}
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
         export BIN_END_YY=${ASIM_MIN_YYYY}
         export BIN_END_MM=${ASIM_MIN_MM}
         export BIN_END_DD=${ASIM_MIN_DD}
         export BIN_END_HH=23
         export BIN_END_MN=59
         export BIN_END_SS=59
         export TMP_INFILE=\'${EXPERIMENT_TES_CO2_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${TES_FILE_PRE}\'
#
# COPY EXECUTABLE
         export FILE=tes_co2_profile_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TES_CO2/native_to_ascii/${FILE} ./.
         mcc -m tes_co2_profile_extract.m -o tes_co2_profile_extract
         ./run_tes_co2_profile_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${TES_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat2.html 2>&1
#
      fi
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
      if [[ ! -e ${TMP_OUTFILE} ]]; then
         touch NO_TES_CO2_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT TES CO2 ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'${TMP_OUTFILE}\'
      export NL_FILEOUT=\'obs_seq_tes_co2_profile_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_TES_CO2}
      export NL_USE_LOG_CO=${USE_LOG_CO_LOGIC}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_CO2=${USE_LOG_CO2_LOGIC}
      export NL_USE_LOG_CH4=${USE_LOG_CH4_LOGIC}
      export NL_USE_LOG_NH3=${USE_LOG_NH3_LOGIC}
#
# MODEL PROFILE SETTINGS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
#      export NL_PATH_MODEL=\'${RUN_DIR}/${DATE}/wrfchem_chem_icbc\'
#      export NL_FILE_MODEL=\'wrfinput_d${CR_DOMAIN}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export NL_NZ_MODEL=${NNZP_CR}
#
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#      
# USE TES DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_tes_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TES_CO2/work/tes_co2_profile_ascii_to_obs ./.
      ./tes_co2_profile_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ -s ${NL_FILEOUT} ]]; then
         touch NO_TES_CO2_${DATE}
      fi
   fi
#
########################################################################
#
# RUN TES CO2 CPSR OBSERVATIONS
#
########################################################################
#
   if ${RUN_TES_CO2_CPSR_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/tes_co2_cpsr_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/tes_co2_cpsr_obs
         cd ${RUN_DIR}/${DATE}/tes_co2_cpsr_obs
      else
         cd ${RUN_DIR}/${DATE}/tes_co2_cpsr_obs
      fi
#
# SET TES PARAMETERS
      export NL_PATH_MODEL=${RUN_DIR}/${PAST_DATE}/ensemble_mean_output
      export NL_FILE_MODEL=wrfout_d${CR_DOMAIN}_${DATE}_mean

      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export TES_FILE_PRE=TES-Aura_L2-CO2-SO-Nadir_r00000
      export TES_FILE_EXT=_C01_F08_11.he5
      export OUTFILE=TEMP_FILE.dat
      export TMP_OUTFILE=TES_CO2_${DATE}.dat
      rm -rf ${OUTFILE}
      rm -rf ${TMP_OUTFILE}
#
# SET OBS_WINDOW
      export BIN_BEG_YY=${ASIM_MN_YYYY}
      export BIN_BEG_MM=${ASIM_MN_MM}
      export BIN_BEG_DD=${ASIM_MN_DD}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_YY=${ASIM_MX_YYYY}
      export BIN_END_MM=${ASIM_MX_MM}
      export BIN_END_DD=${ASIM_MX_DD}
      export BIN_END_HH=${HHM_END}
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      export FLG=0
      if [[ ${ASIM_MX_HH} -eq 3 ]]; then
         export FLG=1 
         export BIN_BEG_YY=${ASIM_MX_YYYY}
         export BIN_BEG_MM=${ASIM_MX_MM}
         export BIN_BEG_DD=${ASIM_MX_DD}
         export BIN_BEG_HH=0
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
      fi
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
#
# SET TES INPUT DATA DIR
      export TMP_INFILE=\'${EXPERIMENT_TES_CO2_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${TES_FILE_PRE}\'
#
# COPY EXECUTABLE
      export FILE=tes_co2_cpsr_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TES_CO2/native_to_ascii/${FILE} ./.
      mcc -m tes_co2_cpsr_extract.m -o tes_co2_cpsr_extract
      ./run_tes_co2_cpsr_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${TES_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat1.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
#
# END OF PREVIOUS DAY (hours 21 to 24 obs)
      if [[ ${FLG} -eq 1 ]]; then	 
         export BIN_BEG_YY=${ASIM_MIN_YYYY}
         export BIN_BEG_MM=${ASIM_MIN_MM}
         export BIN_BEG_DD=${ASIM_MIN_DD}
         export BIN_BEG_HH=${ASIM_MIN_HH}
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
         export BIN_END_YY=${ASIM_MIN_YYYY}
         export BIN_END_MM=${ASIM_MIN_MM}
         export BIN_END_DD=${ASIM_MIN_DD}
         export BIN_END_HH=23
         export BIN_END_MN=59
         export BIN_END_SS=59
         export TMP_INFILE=\'${EXPERIMENT_TES_CO2_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${TES_FILE_PRE}\'
#
# COPY EXECUTABLE
         export FILE=tes_co2_cpsr_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TES_CO2/native_to_ascii/${FILE} ./.
         mcc -m tes_co2_cpsr_extract.m -o tes_co2_cpsr_extract
         ./run_tes_co2_cpsr_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${TES_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat2.html 2>&1
#
      fi
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
      if [[ ! -e ${TMP_OUTFILE} ]]; then
         touch NO_TES_CO2_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT TES CO2 ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'${TMP_OUTFILE}\'
      export NL_FILEOUT=\'obs_seq_tes_co2_cpsr_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_TES_CO2}
      export NL_USE_LOG_CO=${USE_LOG_CO_LOGIC}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_CO2=${USE_LOG_CO2_LOGIC}
      export NL_USE_LOG_CH4=${USE_LOG_CH4_LOGIC}
      export NL_USE_LOG_NH3=${USE_LOG_NH3_LOGIC}
#
# MODEL CPSR SETTINGS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
#      export NL_PATH_MODEL=\'${RUN_DIR}/${DATE}/wrfchem_chem_icbc\'
#      export NL_FILE_MODEL=\'wrfinput_d${CR_DOMAIN}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export NL_NZ_MODEL=${NNZP_CR}
#
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#      
# USE TES DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_tes_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TES_CO2/work/tes_co2_cpsr_ascii_to_obs ./.
      ./tes_co2_cpsr_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ -s ${NL_FILEOUT} ]]; then
         touch NO_TES_CO2_${DATE}
      fi
   fi
#
########################################################################
#
# RUN TES O3 TOTAL COL OBSERVATIONS
#
########################################################################
#
   if ${RUN_TES_O3_TOTAL_COL_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/tes_o3_total_col_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/tes_o3_total_col_obs
         cd ${RUN_DIR}/${DATE}/tes_o3_total_col_obs
      else
         cd ${RUN_DIR}/${DATE}/tes_o3_total_col_obs
      fi
#
# SET TES PARAMETERS
      export NL_PATH_MODEL=${RUN_DIR}/${PAST_DATE}/ensemble_mean_output
      export NL_FILE_MODEL=wrfout_d${CR_DOMAIN}_${DATE}_mean
#      export NL_PATH_MODEL=${RUN_DIR}/${DATE}/ensemble_mean_input
#      export NL_FILE_MODEL=wrfinput_d${CR_DOMAIN}_mean

      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export TES_FILE_PRE=TES_O3_L2_V01_
      export TES_FILE_EXT=.nc
      export OUTFILE=TEMP_FILE.dat
      export TMP_OUTFILE=TES_O3_${DATE}.dat
      rm -rf ${OUTFILE}
      rm -rf ${TMP_OUTFILE}
#
# SET OBS_WINDOW
      export BIN_BEG_YY=${ASIM_MN_YYYY}
      export BIN_BEG_MM=${ASIM_MN_MM}
      export BIN_BEG_DD=${ASIM_MN_DD}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_YY=${ASIM_MX_YYYY}
      export BIN_END_MM=${ASIM_MX_MM}
      export BIN_END_DD=${ASIM_MX_DD}
      export BIN_END_HH=${HHM_END}
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      export FLG=0
      if [[ ${ASIM_MX_HH} -eq 3 ]]; then
         export FLG=1 
         export BIN_BEG_YY=${ASIM_MX_YYYY}
         export BIN_BEG_MM=${ASIM_MX_MM}
         export BIN_BEG_DD=${ASIM_MX_DD}
         export BIN_BEG_HH=0
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
      fi
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
#
# SET TES INPUT DATA DIR
      export TMP_INFILE=\'${EXPERIMENT_TES_O3_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${TES_FILE_PRE}\'
#
# COPY EXECUTABLE
      export FILE=tes_o3_total_col_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TES_O3/native_to_ascii/${FILE} ./.
      mcc -m tes_o3_total_col_extract.m -o tes_o3_total_col_extract
      ./run_tes_o3_total_col_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${TES_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat1.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
#
# END OF PREVIOUS DAY (hours 21 to 24 obs)
      if [[ ${FLG} -eq 1 ]]; then	 
         export BIN_BEG_YY=${ASIM_MIN_YYYY}
         export BIN_BEG_MM=${ASIM_MIN_MM}
         export BIN_BEG_DD=${ASIM_MIN_DD}
         export BIN_BEG_HH=${ASIM_MIN_HH}
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
         export BIN_END_YY=${ASIM_MIN_YYYY}
         export BIN_END_MM=${ASIM_MIN_MM}
         export BIN_END_DD=${ASIM_MIN_DD}
         export BIN_END_HH=23
         export BIN_END_MN=59
         export BIN_END_SS=59
         export TMP_INFILE=\'${EXPERIMENT_TES_O3_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${TES_FILE_PRE}\'
#
# COPY EXECUTABLE
         export FILE=tes_o3_total_col_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TES_O3/native_to_ascii/${FILE} ./.
         mcc -m tes_o3_total_col_extract.m -o tes_o3_total_col_extract
         ./run_tes_o3_total_col_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${TES_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat2.html 2>&1
#
      fi
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
      if [[ ! -e ${TMP_OUTFILE} ]]; then
         touch NO_TES_O3_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT TES O3 ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'${TMP_OUTFILE}\'
      export NL_FILEOUT=\'obs_seq_tes_o3_total_col_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_TES_O3}
      export NL_USE_LOG_CO=${USE_LOG_CO_LOGIC}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_CO2=${USE_LOG_CO2_LOGIC}
      export NL_USE_LOG_CH4=${USE_LOG_CH4_LOGIC}
      export NL_USE_LOG_NH3=${USE_LOG_NH3_LOGIC}
#
# MODEL PROFILE SETTINGS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
#      export NL_PATH_MODEL=\'${RUN_DIR}/${DATE}/wrfchem_chem_icbc\'
#      export NL_FILE_MODEL=\'wrfinput_d${CR_DOMAIN}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export NL_NZ_MODEL=${NNZP_CR}
#
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#      
# USE TES DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_tes_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TES_O3/work/tes_o3_total_col_ascii_to_obs ./.
      ./tes_o3_total_col_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ -s ${NL_FILEOUT} ]]; then
         touch NO_TES_O3_${DATE}
      fi
   fi
#
########################################################################
#
# RUN TES O3 PROFILE OBSERVATIONS
#
########################################################################
#
   if ${RUN_TES_O3_PROFILE_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/tes_o3_profile_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/tes_o3_profile_obs
         cd ${RUN_DIR}/${DATE}/tes_o3_profile_obs
      else
         cd ${RUN_DIR}/${DATE}/tes_o3_profile_obs
      fi
#
# SET TES PARAMETERS
      export NL_PATH_MODEL=${RUN_DIR}/${PAST_DATE}/ensemble_mean_output
      export NL_FILE_MODEL=wrfout_d${CR_DOMAIN}_${DATE}_mean

      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export TES_FILE_PRE=TES-Aura_L2-O3-SO-Nadir_r00000
      export TES_FILE_EXT=_C01_F08_11.he5
      export OUTFILE=TEMP_FILE.dat
      export TMP_OUTFILE=TES_O3_${DATE}.dat
      rm -rf ${OUTFILE}
      rm -rf ${TMP_OUTFILE}
#
# SET OBS_WINDOW
      export BIN_BEG_YY=${ASIM_MN_YYYY}
      export BIN_BEG_MM=${ASIM_MN_MM}
      export BIN_BEG_DD=${ASIM_MN_DD}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_YY=${ASIM_MX_YYYY}
      export BIN_END_MM=${ASIM_MX_MM}
      export BIN_END_DD=${ASIM_MX_DD}
      export BIN_END_HH=${HHM_END}
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      export FLG=0
      if [[ ${ASIM_MX_HH} -eq 3 ]]; then
         export FLG=1 
         export BIN_BEG_YY=${ASIM_MX_YYYY}
         export BIN_BEG_MM=${ASIM_MX_MM}
         export BIN_BEG_DD=${ASIM_MX_DD}
         export BIN_BEG_HH=0
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
      fi
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
#
# SET TES INPUT DATA DIR
      export TMP_INFILE=\'${EXPERIMENT_TES_O3_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${TES_FILE_PRE}\'
#
# COPY EXECUTABLE
      export FILE=tes_o3_profile_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TES_O3/native_to_ascii/${FILE} ./.
      mcc -m tes_o3_profile_extract.m -o tes_o3_profile_extract
      ./run_tes_o3_profile_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${TES_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat1.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
#
# END OF PREVIOUS DAY (hours 21 to 24 obs)
      if [[ ${FLG} -eq 1 ]]; then	 
         export BIN_BEG_YY=${ASIM_MIN_YYYY}
         export BIN_BEG_MM=${ASIM_MIN_MM}
         export BIN_BEG_DD=${ASIM_MIN_DD}
         export BIN_BEG_HH=${ASIM_MIN_HH}
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
         export BIN_END_YY=${ASIM_MIN_YYYY}
         export BIN_END_MM=${ASIM_MIN_MM}
         export BIN_END_DD=${ASIM_MIN_DD}
         export BIN_END_HH=23
         export BIN_END_MN=59
         export BIN_END_SS=59
         export TMP_INFILE=\'${EXPERIMENT_TES_O3_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${TES_FILE_PRE}\'
#
# COPY EXECUTABLE
         export FILE=tes_o3_profile_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TES_O3/native_to_ascii/${FILE} ./.
         mcc -m tes_o3_profile_extract.m -o tes_o3_profile_extract
         ./run_tes_o3_profile_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${TES_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat2.html 2>&1
#
      fi
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
      if [[ ! -e ${TMP_OUTFILE} ]]; then
         touch NO_TES_O3_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT TES O3 ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'${TMP_OUTFILE}\'
      export NL_FILEOUT=\'obs_seq_tes_o3_profile_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_TES_O3}
      export NL_USE_LOG_CO=${USE_LOG_CO_LOGIC}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_CO2=${USE_LOG_CO2_LOGIC}
      export NL_USE_LOG_CH4=${USE_LOG_CH4_LOGIC}
      export NL_USE_LOG_NH3=${USE_LOG_NH3_LOGIC}
#
# MODEL PROFILE SETTINGS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export NL_NZ_MODEL=${NNZP_CR}
#
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#      
# USE TES DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_tes_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TES_O3/work/tes_o3_profile_ascii_to_obs ./.
      ./tes_o3_profile_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ -s ${NL_FILEOUT} ]]; then
         touch NO_TES_O3_${DATE}
      fi
   fi
#
########################################################################
#
# RUN TES O3 CPSR OBSERVATIONS
#
########################################################################
#
   if ${RUN_TES_O3_CPSR_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/tes_o3_cpsr_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/tes_o3_cpsr_obs
         cd ${RUN_DIR}/${DATE}/tes_o3_cpsr_obs
      else
         cd ${RUN_DIR}/${DATE}/tes_o3_cpsr_obs
      fi
#
# SET TES PARAMETERS
      export NL_PATH_MODEL=${RUN_DIR}/${PAST_DATE}/ensemble_mean_output
      export NL_FILE_MODEL=wrfout_d${CR_DOMAIN}_${DATE}_mean

      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export TES_FILE_PRE=TES-Aura_L2-O3-SO-Nadir_r00000
      export TES_FILE_EXT=_C01_F08_11.he5
      export OUTFILE=TEMP_FILE.dat
      export TMP_OUTFILE=TES_O3_${DATE}.dat
      rm -rf ${OUTFILE}
      rm -rf ${TMP_OUTFILE}

#
# SET OBS_WINDOW
      export BIN_BEG_YY=${ASIM_MN_YYYY}
      export BIN_BEG_MM=${ASIM_MN_MM}
      export BIN_BEG_DD=${ASIM_MN_DD}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_YY=${ASIM_MX_YYYY}
      export BIN_END_MM=${ASIM_MX_MM}
      export BIN_END_DD=${ASIM_MX_DD}
      export BIN_END_HH=${HHM_END}
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      export FLG=0
      if [[ ${ASIM_MX_HH} -eq 3 ]]; then
         export FLG=1 
         export BIN_BEG_YY=${ASIM_MX_YYYY}
         export BIN_BEG_MM=${ASIM_MX_MM}
         export BIN_BEG_DD=${ASIM_MX_DD}
         export BIN_BEG_HH=0
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
      fi
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
#
# SET TES INPUT DATA DIR
      export TMP_INFILE=\'${EXPERIMENT_TES_O3_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${TES_FILE_PRE}\'
#
# COPY EXECUTABLE
      export FILE=tes_o3_cpsr_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TES_O3/native_to_ascii/${FILE} ./.
      mcc -m tes_o3_cpsr_extract.m -o tes_o3_cpsr_extract
      ./run_tes_o3_cpsr_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${TES_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat1.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
#
# END OF PREVIOUS DAY (hours 21 to 24 obs)
      if [[ ${FLG} -eq 1 ]]; then	 
         export BIN_BEG_YY=${ASIM_MIN_YYYY}
         export BIN_BEG_MM=${ASIM_MIN_MM}
         export BIN_BEG_DD=${ASIM_MIN_DD}
         export BIN_BEG_HH=${ASIM_MIN_HH}
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
         export BIN_END_YY=${ASIM_MIN_YYYY}
         export BIN_END_MM=${ASIM_MIN_MM}
         export BIN_END_DD=${ASIM_MIN_DD}
         export BIN_END_HH=23
         export BIN_END_MN=59
         export BIN_END_SS=59
         export TMP_INFILE=\'${EXPERIMENT_TES_O3_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${TES_FILE_PRE}\'
#
# COPY EXECUTABLE
         export FILE=tes_o3_cpsr_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TES_O3/native_to_ascii/${FILE} ./.
         mcc -m tes_o3_cpsr_extract.m -o tes_o3_cpsr_extract
         ./run_tes_o3_cpsr_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${TES_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat2.html 2>&1
#
      fi
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
      if [[ ! -e ${TMP_OUTFILE} ]]; then
         touch NO_TES_O3_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT TES O3 ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'${TMP_OUTFILE}\'
      export NL_FILEOUT=\'obs_seq_tes_o3_cpsr_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_TES_O3}
      export NL_USE_LOG_CO=${USE_LOG_CO_LOGIC}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_CO2=${USE_LOG_CO2_LOGIC}
      export NL_USE_LOG_CH4=${USE_LOG_CH4_LOGIC}
      export NL_USE_LOG_NH3=${USE_LOG_NH3_LOGIC}
#
# MODEL CPSR SETTINGS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
#      export NL_PATH_MODEL=\'${RUN_DIR}/${DATE}/wrfchem_chem_icbc\'
#      export NL_FILE_MODEL=\'wrfinput_d${CR_DOMAIN}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export NL_NZ_MODEL=${NNZP_CR}
#
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#      
# USE TES DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_tes_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TES_O3/work/tes_o3_cpsr_ascii_to_obs ./.
      ./tes_o3_cpsr_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ -s ${NL_FILEOUT} ]]; then
         touch NO_TES_O3_${DATE}
      fi
   fi
#
########################################################################
#
# RUN TES NH3 TOTAL COL OBSERVATIONS
#
########################################################################
#
   if ${RUN_TES_NH3_TOTAL_COL_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/tes_nh3_total_col_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/tes_nh3_total_col_obs
         cd ${RUN_DIR}/${DATE}/tes_nh3_total_col_obs
      else
         cd ${RUN_DIR}/${DATE}/tes_nh3_total_col_obs
      fi
#
# SET TES PARAMETERS
      export NL_PATH_MODEL=${RUN_DIR}/${PAST_DATE}/ensemble_mean_output
      export NL_FILE_MODEL=wrfout_d${CR_DOMAIN}_${DATE}_mean
#      export NL_PATH_MODEL=${RUN_DIR}/${DATE}/ensemble_mean_input
#      export NL_FILE_MODEL=wrfinput_d${CR_DOMAIN}_mean

      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export TES_FILE_PRE=TES-Aura_L2-CO-SO-Nadir_r00000
      export TES_FILE_EXT=_C01_F08_11.he5
      export OUTFILE=TEMP_FILE.dat
      export TMP_OUTFILE=TES_NH3_${DATE}.dat
      rm -rf ${OUTFILE}
      rm -rf ${TMP_OUTFILE}
#
# SET OBS_WINDOW
      export BIN_BEG_YY=${ASIM_MN_YYYY}
      export BIN_BEG_MM=${ASIM_MN_MM}
      export BIN_BEG_DD=${ASIM_MN_DD}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_YY=${ASIM_MX_YYYY}
      export BIN_END_MM=${ASIM_MX_MM}
      export BIN_END_DD=${ASIM_MX_DD}
      export BIN_END_HH=${HHM_END}
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      export FLG=0
      if [[ ${ASIM_MX_HH} -eq 3 ]]; then
         export FLG=1 
         export BIN_BEG_YY=${ASIM_MX_YYYY}
         export BIN_BEG_MM=${ASIM_MX_MM}
         export BIN_BEG_DD=${ASIM_MX_DD}
         export BIN_BEG_HH=0
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
      fi
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
#
# SET TES INPUT DATA DIR
      export TMP_INFILE=\'${EXPERIMENT_TES_NH3_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${TES_FILE_PRE}\'
#
# COPY EXECUTABLE
      export FILE=tes_nh3_total_col_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TES_NH3/native_to_ascii/${FILE} ./.
      mcc -m tes_nh3_total_col_extract.m -o tes_nh3_total_col_extract
      ./run_tes_nh3_total_col_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${TES_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat1.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
#
# END OF PREVIOUS DAY (hours 21 to 24 obs)
      if [[ ${FLG} -eq 1 ]]; then	 
         export BIN_BEG_YY=${ASIM_MIN_YYYY}
         export BIN_BEG_MM=${ASIM_MIN_MM}
         export BIN_BEG_DD=${ASIM_MIN_DD}
         export BIN_BEG_HH=${ASIM_MIN_HH}
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
         export BIN_END_YY=${ASIM_MIN_YYYY}
         export BIN_END_MM=${ASIM_MIN_MM}
         export BIN_END_DD=${ASIM_MIN_DD}
         export BIN_END_HH=23
         export BIN_END_MN=59
         export BIN_END_SS=59
         export TMP_INFILE=\'${EXPERIMENT_TES_NH3_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${TES_FILE_PRE}\'

#
# COPY EXECUTABLE
         export FILE=tes_nh3_total_col_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TES_NH3/native_to_ascii/${FILE} ./.
         mcc -m tes_nh3_total_col_extract.m -o tes_nh3_total_col_extract
         ./run_tes_nh3_total_col_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${TES_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat.html 2>&1
#
      fi
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
      if [[ ! -e ${TMP_OUTFILE} ]]; then
         touch NO_TES_NH3_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT TES NH3 ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'${TMP_OUTFILE}\'
      export NL_FILEOUT=\'obs_seq_tes_nh3_total_col_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_TES_NH3}
      export NL_USE_LOG_CO=${USE_LOG_CO_LOGIC}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_CO2=${USE_LOG_CO2_LOGIC}
      export NL_USE_LOG_CH4=${USE_LOG_CH4_LOGIC}
      export NL_USE_LOG_NH3=${USE_LOG_NH3_LOGIC}
#
# MODEL PROFILE SETTINGS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
#      export NL_PATH_MODEL=\'${RUN_DIR}/${DATE}/wrfchem_chem_icbc\'
#      export NL_FILE_MODEL=\'wrfinput_d${CR_DOMAIN}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export NL_NZ_MODEL=${NNZP_CR}
#
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#      
# USE TES DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_tes_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TES_NH3/work/tes_nh3_total_col_ascii_to_obs ./.
      ./tes_nh3_total_col_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ -s ${NL_FILEOUT} ]]; then
         touch NO_TES_NH3_${DATE}
      fi
   fi
#
########################################################################
#
# RUN TES NH3 PROFILE OBSERVATIONS
#
########################################################################
#
   if ${RUN_TES_NH3_PROFILE_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/tes_nh3_profile_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/tes_nh3_profile_obs
         cd ${RUN_DIR}/${DATE}/tes_nh3_profile_obs
      else
         cd ${RUN_DIR}/${DATE}/tes_nh3_profile_obs
      fi
#
# SET TES PARAMETERS
      export NL_PATH_MODEL=${RUN_DIR}/${PAST_DATE}/ensemble_mean_output
      export NL_FILE_MODEL=wrfout_d${CR_DOMAIN}_${DATE}_mean

      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export TES_FILE_PRE=TES-Aura_L2-NH3-SO-Nadir_r00000
      export TES_FILE_EXT=_C01_F08_11.he5
      export OUTFILE=TEMP_FILE.dat
      export TMP_OUTFILE=TES_NH3_${DATE}.dat
      rm -rf ${OUTFILE}
      rm -rf ${TMP_OUTFILE}

#
# SET OBS_WINDOW
      export BIN_BEG_YY=${ASIM_MN_YYYY}
      export BIN_BEG_MM=${ASIM_MN_MM}
      export BIN_BEG_DD=${ASIM_MN_DD}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_YY=${ASIM_MX_YYYY}
      export BIN_END_MM=${ASIM_MX_MM}
      export BIN_END_DD=${ASIM_MX_DD}
      export BIN_END_HH=${HHM_END}
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      export FLG=0
      if [[ ${ASIM_MX_HH} -eq 3 ]]; then
         export FLG=1 
         export BIN_BEG_YY=${ASIM_MX_YYYY}
         export BIN_BEG_MM=${ASIM_MX_MM}
         export BIN_BEG_DD=${ASIM_MX_DD}
         export BIN_BEG_HH=0
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
      fi
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
#
# SET TES INPUT DATA DIR
      export TMP_INFILE=\'${EXPERIMENT_TES_NH3_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${TES_FILE_PRE}\'
#
# COPY EXECUTABLE
      export FILE=tes_nh3_profile_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TES_NH3/native_to_ascii/${FILE} ./.
      mcc -m tes_nh3_profile_extract.m -o tes_nh3_profile_extract
      ./run_tes_nh3_profile_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${TES_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat1.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
#
# END OF PREVIOUS DAY (hours 21 to 24 obs)
      if [[ ${FLG} -eq 1 ]]; then	 
         export BIN_BEG_YY=${ASIM_MIN_YYYY}
         export BIN_BEG_MM=${ASIM_MIN_MM}
         export BIN_BEG_DD=${ASIM_MIN_DD}
         export BIN_BEG_HH=${ASIM_MIN_HH}
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
         export BIN_END_YY=${ASIM_MIN_YYYY}
         export BIN_END_MM=${ASIM_MIN_MM}
         export BIN_END_DD=${ASIM_MIN_DD}
         export BIN_END_HH=23
         export BIN_END_MN=59
         export BIN_END_SS=59
         export TMP_INFILE=\'${EXPERIMENT_TES_NH3_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${TES_FILE_PRE}\'
#
# COPY EXECUTABLE
         export FILE=tes_nh3_profile_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TES_NH3/native_to_ascii/${FILE} ./.
         mcc -m tes_nh3_profile_extract.m -o tes_nh3_profile_extract
         ./run_tes_nh3_profile_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${TES_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat2.html 2>&1
#
      fi
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
      if [[ ! -e ${TMP_OUTFILE} ]]; then
         touch NO_TES_NH3_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT TES NH3 ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'${TMP_OUTFILE}\'
      export NL_FILEOUT=\'obs_seq_tes_nh3_profile_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_TES_NH3}
      export NL_USE_LOG_CO=${USE_LOG_CO_LOGIC}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_CO2=${USE_LOG_CO2_LOGIC}
      export NL_USE_LOG_CH4=${USE_LOG_CH4_LOGIC}
      export NL_USE_LOG_NH3=${USE_LOG_NH3_LOGIC}
#
# MODEL PROFILE SETTINGS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
#      export NL_PATH_MODEL=\'${RUN_DIR}/${DATE}/wrfchem_chem_icbc\'
#      export NL_FILE_MODEL=\'wrfinput_d${CR_DOMAIN}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export NL_NZ_MODEL=${NNZP_CR}
#
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#      
# USE TES DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_tes_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TES_NH3/work/tes_nh3_profile_ascii_to_obs ./.
      ./tes_nh3_profile_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ -s ${NL_FILEOUT} ]]; then
         touch NO_TES_NH3_${DATE}
      fi
   fi
#
########################################################################
#
# RUN TES NH3 CPSR OBSERVATIONS
#
########################################################################
#
   if ${RUN_TES_NH3_CPSR_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/tes_nh3_cpsr_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/tes_nh3_cpsr_obs
         cd ${RUN_DIR}/${DATE}/tes_nh3_cpsr_obs
      else
         cd ${RUN_DIR}/${DATE}/tes_nh3_cpsr_obs
      fi
#
# SET TES PARAMETERS
      export NL_PATH_MODEL=${RUN_DIR}/${PAST_DATE}/ensemble_mean_output
      export NL_FILE_MODEL=wrfout_d${CR_DOMAIN}_${DATE}_mean

      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export TES_FILE_PRE=TES-Aura_L2-NH3-SO-Nadir_r00000
      export TES_FILE_EXT=_C01_F08_11.he5
      export OUTFILE=TEMP_FILE.dat
      export TMP_OUTFILE=TES_NH3_${DATE}.dat
      rm -rf ${OUTFILE}
      rm -rf ${TMP_OUTFILE}

#
# SET OBS_WINDOW
      export BIN_BEG_YY=${ASIM_MN_YYYY}
      export BIN_BEG_MM=${ASIM_MN_MM}
      export BIN_BEG_DD=${ASIM_MN_DD}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_YY=${ASIM_MX_YYYY}
      export BIN_END_MM=${ASIM_MX_MM}
      export BIN_END_DD=${ASIM_MX_DD}
      export BIN_END_HH=${HHM_END}
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      export FLG=0
      if [[ ${ASIM_MX_HH} -eq 3 ]]; then
         export FLG=1 
         export BIN_BEG_YY=${ASIM_MX_YYYY}
         export BIN_BEG_MM=${ASIM_MX_MM}
         export BIN_BEG_DD=${ASIM_MX_DD}
         export BIN_BEG_HH=0
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
      fi
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
#
# SET TES INPUT DATA DIR
      export TMP_INFILE=\'${EXPERIMENT_TES_NH3_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${TES_FILE_PRE}\'
#
# COPY EXECUTABLE
      export FILE=tes_nh3_cpsr_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TES_NH3/native_to_ascii/${FILE} ./.
      mcc -m tes_nh3_cpsr_extract.m -o tes_nh3_cpsr_extract
      ./run_tes_nh3_cpsr_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${TES_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
#
# END OF PREVIOUS DAY (hours 21 to 24 obs)
      if [[ ${FLG} -eq 1 ]]; then	 
         export BIN_BEG_YY=${ASIM_MIN_YYYY}
         export BIN_BEG_MM=${ASIM_MIN_MM}
         export BIN_BEG_DD=${ASIM_MIN_DD}
         export BIN_BEG_HH=${ASIM_MIN_HH}
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
         export BIN_END_YY=${ASIM_MIN_YYYY}
         export BIN_END_MM=${ASIM_MIN_MM}
         export BIN_END_DD=${ASIM_MIN_DD}
         export BIN_END_HH=23
         export BIN_END_MN=59
         export BIN_END_SS=59
         export TMP_INFILE=\'${EXPERIMENT_TES_NH3_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${TES_FILE_PRE}\'
#
# COPY EXECUTABLE
         export FILE=tes_nh3_cpsr_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TES_NH3/native_to_ascii/${FILE} ./.
         mcc -m tes_nh3_cpsr_extract.m -o tes_nh3_cpsr_extract
         ./run_tes_nh3_cpsr_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${TES_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat.html 2>&1
#
      fi
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
      if [[ ! -e ${TMP_OUTFILE} ]]; then
         touch NO_TES_NH3_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT TES NH3 ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'${TMP_OUTFILE}\'
      export NL_FILEOUT=\'obs_seq_tes_nh3_cpsr_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_TES_NH3}
      export NL_USE_LOG_CO=${USE_LOG_CO_LOGIC}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_CO2=${USE_LOG_CO2_LOGIC}
      export NL_USE_LOG_CH4=${USE_LOG_CH4_LOGIC}
      export NL_USE_LOG_NH3=${USE_LOG_NH3_LOGIC}
#
# MODEL CPSR SETTINGS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
#      export NL_PATH_MODEL=\'${RUN_DIR}/${DATE}/wrfchem_chem_icbc\'
#      export NL_FILE_MODEL=\'wrfinput_d${CR_DOMAIN}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export NL_NZ_MODEL=${NNZP_CR}
#
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#      
# USE TES DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_tes_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TES_NH3/work/tes_nh3_cpsr_ascii_to_obs ./.
      ./tes_nh3_cpsr_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ -s ${NL_FILEOUT} ]]; then
         touch NO_TES_NH3_${DATE}
      fi
   fi
#
########################################################################
#
# RUN TES CH4 TOTAL COL OBSERVATIONS
#
########################################################################
#
   if ${RUN_TES_CH4_TOTAL_COL_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/tes_ch4_total_col_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/tes_ch4_total_col_obs
         cd ${RUN_DIR}/${DATE}/tes_ch4_total_col_obs
      else
         cd ${RUN_DIR}/${DATE}/tes_ch4_total_col_obs
      fi
#
# SET TES PARAMETERS
      export NL_PATH_MODEL=${RUN_DIR}/${PAST_DATE}/ensemble_mean_output
      export NL_FILE_MODEL=wrfout_d${CR_DOMAIN}_${DATE}_mean
#      export NL_PATH_MODEL=${RUN_DIR}/${DATE}/ensemble_mean_input
#      export NL_FILE_MODEL=wrfinput_d${CR_DOMAIN}_mean

      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export TES_FILE_PRE=TES-Aura_L2-CH4-SO-Nadir_r00000
      export TES_FILE_EXT=_C01_F08_11.he5
      export OUTFILE=TEMP_FILE.dat
      export TMP_OUTFILE=TES_CH4_${DATE}.dat
      rm -rf ${OUTFILE}
      rm -rf ${TMP_OUTFILE}
#
# SET OBS_WINDOW
      export BIN_BEG_YY=${ASIM_MN_YYYY}
      export BIN_BEG_MM=${ASIM_MN_MM}
      export BIN_BEG_DD=${ASIM_MN_DD}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_YY=${ASIM_MX_YYYY}
      export BIN_END_MM=${ASIM_MX_MM}
      export BIN_END_DD=${ASIM_MX_DD}
      export BIN_END_HH=${HHM_END}
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      export FLG=0
      if [[ ${ASIM_MX_HH} -eq 3 ]]; then
         export FLG=1 
         export BIN_BEG_YY=${ASIM_MX_YYYY}
         export BIN_BEG_MM=${ASIM_MX_MM}
         export BIN_BEG_DD=${ASIM_MX_DD}
         export BIN_BEG_HH=0
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
      fi
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
#
# SET TES INPUT DATA DIR
      export TMP_INFILE=\'${EXPERIMENT_TES_CH4_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${TES_FILE_PRE}\'
#
# COPY EXECUTABLE
      export FILE=tes_ch4_total_col_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TES_CH4/native_to_ascii/${FILE} ./.
      mcc -m tes_ch4_total_col_extract.m -o tes_ch4_total_col_extract
      ./run_tes_ch4_total_col_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${TES_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
#
# END OF PREVIOUS DAY (hours 21 to 24 obs)
      if [[ ${FLG} -eq 1 ]]; then	 
         export BIN_BEG_YY=${ASIM_MIN_YYYY}
         export BIN_BEG_MM=${ASIM_MIN_MM}
         export BIN_BEG_DD=${ASIM_MIN_DD}
         export BIN_BEG_HH=${ASIM_MIN_HH}
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
         export BIN_END_YY=${ASIM_MIN_YYYY}
         export BIN_END_MM=${ASIM_MIN_MM}
         export BIN_END_DD=${ASIM_MIN_DD}
         export BIN_END_HH=23
         export BIN_END_MN=59
         export BIN_END_SS=59
         export TMP_INFILE=\'${EXPERIMENT_TES_CH4_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${TES_FILE_PRE}\'
#
# COPY EXECUTABLE
         export FILE=tes_ch4_total_col_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TES_CH4/native_to_ascii/${FILE} ./.
         mcc -m tes_ch4_total_col_extract.m -o tes_ch4_total_col_extract
         ./run_tes_ch4_total_col_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${TES_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat.html 2>&1
#
      fi
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
      if [[ ! -e ${TMP_OUTFILE} ]]; then
         touch NO_TES_CH4_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT TES CH4 ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'${TMP_OUTFILE}\'
      export NL_FILEOUT=\'obs_seq_tes_ch4_total_col_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_TES_CH4}
      export NL_USE_LOG_CO=${USE_LOG_CO_LOGIC}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_CO2=${USE_LOG_CO2_LOGIC}
      export NL_USE_LOG_CH4=${USE_LOG_CH4_LOGIC}
      export NL_USE_LOG_NH3=${USE_LOG_NH3_LOGIC}
#
# MODEL PROFILE SETTINGS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
#      export NL_PATH_MODEL=\'${RUN_DIR}/${DATE}/wrfchem_chem_icbc\'
#      export NL_FILE_MODEL=\'wrfinput_d${CR_DOMAIN}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export NL_NZ_MODEL=${NNZP_CR}
#
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#      
# USE TES DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_tes_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TES_CH4/work/tes_ch4_total_col_ascii_to_obs ./.
      ./tes_ch4_total_col_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ -s ${NL_FILEOUT} ]]; then
         touch NO_TES_CH4_${DATE}
      fi
   fi
#
########################################################################
#
# RUN TES CH4 PROFILE OBSERVATIONS
#
########################################################################
#
   if ${RUN_TES_CH4_PROFILE_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/tes_ch4_profile_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/tes_ch4_profile_obs
         cd ${RUN_DIR}/${DATE}/tes_ch4_profile_obs
      else
         cd ${RUN_DIR}/${DATE}/tes_ch4_profile_obs
      fi
#
# SET TES PARAMETERS
      export NL_PATH_MODEL=${RUN_DIR}/${PAST_DATE}/ensemble_mean_output
      export NL_FILE_MODEL=wrfout_d${CR_DOMAIN}_${DATE}_mean
#      export NL_PATH_MODEL=${RUN_DIR}/${DATE}/ensemble_mean_input
#      export NL_FILE_MODEL=wrfinput_d${CR_DOMAIN}_mean

      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export TES_FILE_PRE=TES-Aura_L2-CH4-SO-Nadir_r00000
      export TES_FILE_EXT=_C01_F08_11.he5
      export OUTFILE=TEMP_FILE.dat
      export TMP_OUTFILE=TES_CH4_${DATE}.dat
      rm -rf ${OUTFILE}
      rm -rf ${TMP_OUTFILE}
#
# SET OBS_WINDOW
      export BIN_BEG_YY=${ASIM_MN_YYYY}
      export BIN_BEG_MM=${ASIM_MN_MM}
      export BIN_BEG_DD=${ASIM_MN_DD}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_YY=${ASIM_MX_YYYY}
      export BIN_END_MM=${ASIM_MX_MM}
      export BIN_END_DD=${ASIM_MX_DD}
      export BIN_END_HH=${HHM_END}
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      export FLG=0
      if [[ ${ASIM_MX_HH} -eq 3 ]]; then
         export FLG=1 
         export BIN_BEG_YY=${ASIM_MX_YYYY}
         export BIN_BEG_MM=${ASIM_MX_MM}
         export BIN_BEG_DD=${ASIM_MX_DD}
         export BIN_BEG_HH=0
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
      fi
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
#
# SET TES INPUT DATA DIR
      export TMP_INFILE=\'${EXPERIMENT_TES_CH4_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${TES_FILE_PRE}\'
#
# COPY EXECUTABLE
      export FILE=tes_ch4_profile_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TES_CH4/native_to_ascii/${FILE} ./.
      mcc -m tes_ch4_profile_extract.m -o tes_ch4_profile_extract
      ./run_tes_ch4_profile_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${TES_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat1.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
#
# END OF PREVIOUS DAY (hours 21 to 24 obs)
      if [[ ${FLG} -eq 1 ]]; then	 
         export BIN_BEG_YY=${ASIM_MIN_YYYY}
         export BIN_BEG_MM=${ASIM_MIN_MM}
         export BIN_BEG_DD=${ASIM_MIN_DD}
         export BIN_BEG_HH=${ASIM_MIN_HH}
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
         export BIN_END_YY=${ASIM_MIN_YYYY}
         export BIN_END_MM=${ASIM_MIN_MM}
         export BIN_END_DD=${ASIM_MIN_DD}
         export BIN_END_HH=23
         export BIN_END_MN=59
         export BIN_END_SS=59
         export TMP_INFILE=\'${EXPERIMENT_TES_CH4_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${TES_FILE_PRE}\'
#
# COPY EXECUTABLE
         export FILE=tes_ch4_profile_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TES_CH4/native_to_ascii/${FILE} ./.
         mcc -m tes_ch4_profile_extract.m -o tes_ch4_profile_extract
         ./run_tes_ch4_profile_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${TES_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat2.html 2>&1
#
      fi
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
      if [[ ! -e ${TMP_OUTFILE} ]]; then
         touch NO_TES_CH4_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT TES CH4 ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'${TMP_OUTFILE}\'
      export NL_FILEOUT=\'obs_seq_tes_ch4_profile_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_TES_CH4}
      export NL_USE_LOG_CO=${USE_LOG_CO_LOGIC}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_CO2=${USE_LOG_CO2_LOGIC}
      export NL_USE_LOG_CH4=${USE_LOG_CH4_LOGIC}
      export NL_USE_LOG_NH3=${USE_LOG_NH3_LOGIC}
#
# MODEL PROFILE SETTINGS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
#      export NL_PATH_MODEL=\'${RUN_DIR}/${DATE}/wrfchem_chem_icbc\'
#      export NL_FILE_MODEL=\'wrfinput_d${CR_DOMAIN}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export NL_NZ_MODEL=${NNZP_CR}
#
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#      
# USE TES DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_tes_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TES_CH4/work/tes_ch4_profile_ascii_to_obs ./.
      ./tes_ch4_profile_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ -s ${NL_FILEOUT} ]]; then
         touch NO_TES_CH4_${DATE}
      fi
   fi
#
########################################################################
#
# RUN TES CH4 CPSR OBSERVATIONS
#
########################################################################
#
   if ${RUN_TES_CH4_CPSR_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/tes_ch4_cpsr_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/tes_ch4_cpsr_obs
         cd ${RUN_DIR}/${DATE}/tes_ch4_cpsr_obs
      else
         cd ${RUN_DIR}/${DATE}/tes_ch4_cpsr_obs
      fi
#
# SET TES PARAMETERS
      export NL_PATH_MODEL=${RUN_DIR}/${PAST_DATE}/ensemble_mean_output
      export NL_FILE_MODEL=wrfout_d${CR_DOMAIN}_${DATE}_mean
#      export NL_PATH_MODEL=${RUN_DIR}/${DATE}/ensemble_mean_input
#      export NL_FILE_MODEL=wrfinput_d${CR_DOMAIN}_mean

      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export TES_FILE_PRE=TES-Aura_L2-CH4-SO-Nadir_r00000
      export TES_FILE_EXT=_C01_F08_11.he5
      export OUTFILE=TEMP_FILE.dat
      export TMP_OUTFILE=TES_CH4_${DATE}.dat
      rm -rf ${OUTFILE}
      rm -rf ${TMP_OUTFILE}
#
# SET OBS_WINDOW
      export BIN_BEG_YY=${ASIM_MN_YYYY}
      export BIN_BEG_MM=${ASIM_MN_MM}
      export BIN_BEG_DD=${ASIM_MN_DD}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_YY=${ASIM_MX_YYYY}
      export BIN_END_MM=${ASIM_MX_MM}
      export BIN_END_DD=${ASIM_MX_DD}
      export BIN_END_HH=${HHM_END}
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      export FLG=0
      if [[ ${ASIM_MX_HH} -eq 3 ]]; then
         export FLG=1 
         export BIN_BEG_YY=${ASIM_MX_YYYY}
         export BIN_BEG_MM=${ASIM_MX_MM}
         export BIN_BEG_DD=${ASIM_MX_DD}
         export BIN_BEG_HH=0
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
      fi
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
#
# SET TES INPUT DATA DIR
      export TMP_INFILE=\'${EXPERIMENT_TES_CH4_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${TES_FILE_PRE}\'
#
# COPY EXECUTABLE
      export FILE=tes_ch4_cpsr_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TES_CH4/native_to_ascii/${FILE} ./.
      mcc -m tes_ch4_cpsr_extract.m -o tes_ch4_cpsr_extract
      ./run_tes_ch4_cpsr_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${TES_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
#
# END OF PREVIOUS DAY (hours 21 to 24 obs)
      if [[ ${FLG} -eq 1 ]]; then	 
         export BIN_BEG_YY=${ASIM_MIN_YYYY}
         export BIN_BEG_MM=${ASIM_MIN_MM}
         export BIN_BEG_DD=${ASIM_MIN_DD}
         export BIN_BEG_HH=${ASIM_MIN_HH}
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
         export BIN_END_YY=${ASIM_MIN_YYYY}
         export BIN_END_MM=${ASIM_MIN_MM}
         export BIN_END_DD=${ASIM_MIN_DD}
         export BIN_END_HH=23
         export BIN_END_MN=59
         export BIN_END_SS=59
         export TMP_INFILE=\'${EXPERIMENT_TES_CH4_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${TES_FILE_PRE}\'
#
# COPY EXECUTABLE
         export FILE=tes_ch4_cpsr_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TES_CH4/native_to_ascii/${FILE} ./.
         mcc -m tes_ch4_cpsr_extract.m -o tes_ch4_cpsr_extract
         ./run_tes_ch4_cpsr_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${TES_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat.html 2>&1
#
      fi
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
      if [[ ! -e ${TMP_OUTFILE} ]]; then
         touch NO_TES_CH4_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT TES CH4 ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'${TMP_OUTFILE}\'
      export NL_FILEOUT=\'obs_seq_tes_ch4_cpsr_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_TES_CH4}
      export NL_USE_LOG_CO=${USE_LOG_CO_LOGIC}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_CO2=${USE_LOG_CO2_LOGIC}
      export NL_USE_LOG_CH4=${USE_LOG_CH4_LOGIC}
      export NL_USE_LOG_NH3=${USE_LOG_NH3_LOGIC}
#
# MODEL CPSR SETTINGS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export NL_NZ_MODEL=${NNZP_CR}
#
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#      
# USE TES DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_tes_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/TES_CH4/work/tes_ch4_cpsr_ascii_to_obs ./.
      ./tes_ch4_cpsr_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ -s ${NL_FILEOUT} ]]; then
         touch NO_TES_CH4_${DATE}
      fi
   fi
#
########################################################################
#
# RUN CRIS CO TOTAL COL OBSERVATIONS
#
########################################################################
#
   if ${RUN_CRIS_CO_TOTAL_COL_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/cris_co_total_col_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/cris_co_total_col_obs
         cd ${RUN_DIR}/${DATE}/cris_co_total_col_obs
      else
         cd ${RUN_DIR}/${DATE}/cris_co_total_col_obs
      fi
#
# SET CRIS PARAMETERS
      export NL_PATH_MODEL=${RUN_DIR}/${PAST_DATE}/ensemble_mean_output
      export NL_FILE_MODEL=wrfout_d${CR_DOMAIN}_${DATE}_mean
#      export NL_PATH_MODEL=${RUN_DIR}/${DATE}/ensemble_mean_input
#      export NL_FILE_MODEL=wrfinput_d${CR_DOMAIN}_mean

      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export CRIS_FILE_PRE=CRIS_CO_L2_V01_
      export CRIS_FILE_EXT=.nc
      export OUTFILE=TEMP_FILE.dat
      export TMP_OUTFILE=CRIS_CO_${DATE}.dat
      rm -rf ${OUTFILE}
      rm -rf ${TMP_OUTFILE}
#
# SET OBS_WINDOW
      export BIN_BEG_YY=${ASIM_MN_YYYY}
      export BIN_BEG_MM=${ASIM_MN_MM}
      export BIN_BEG_DD=${ASIM_MN_DD}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_YY=${ASIM_MX_YYYY}
      export BIN_END_MM=${ASIM_MX_MM}
      export BIN_END_DD=${ASIM_MX_DD}
      export BIN_END_HH=${HHM_END}
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      export FLG=0
      if [[ ${ASIM_MX_HH} -eq 3 ]]; then
         export FLG=1 
         export BIN_BEG_YY=${ASIM_MX_YYYY}
         export BIN_BEG_MM=${ASIM_MX_MM}
         export BIN_BEG_DD=${ASIM_MX_DD}
         export BIN_BEG_HH=0
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
      fi
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
#
# SET CRIS INPUT DATA DIR
      export TMP_INFILE=\'${EXPERIMENT_CRIS_CO_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${CRIS_FILE_PRE}\'
#
# COPY EXECUTABLE
      export FILE=cris_co_total_col_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/CRIS_CO/native_to_ascii/${FILE} ./.
      mcc -m cris_co_total_col_extract.m -o cris_co_total_col_extract
      ./run_cris_co_total_col_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${CRIS_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat1.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
#
# END OF PREVIOUS DAY (hours 21 to 24 obs)
      if [[ ${FLG} -eq 1 ]]; then	 
         export BIN_BEG_YY=${ASIM_MIN_YYYY}
         export BIN_BEG_MM=${ASIM_MIN_MM}
         export BIN_BEG_DD=${ASIM_MIN_DD}
         export BIN_BEG_HH=${ASIM_MIN_HH}
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
         export BIN_END_YY=${ASIM_MIN_YYYY}
         export BIN_END_MM=${ASIM_MIN_MM}
         export BIN_END_DD=${ASIM_MIN_DD}
         export BIN_END_HH=23
         export BIN_END_MN=59
         export BIN_END_SS=59
         export TMP_INFILE=\'${EXPERIMENT_CRIS_CO_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${CRIS_FILE_PRE}\'
#
# COPY EXECUTABLE
         export FILE=cris_co_total_col_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/CRIS_CO/native_to_ascii/${FILE} ./.
         mcc -m cris_co_total_col_extract.m -o cris_co_total_col_extract
         ./run_cris_co_total_col_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${CRIS_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat2.html 2>&1
#
      fi
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
      if [[ ! -e ${TMP_OUTFILE} ]]; then
         touch NO_CRIS_CO_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT CRIS CO ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'${TMP_OUTFILE}\'
      export NL_FILEOUT=\'obs_seq_cris_co_total_col_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_CRIS_CO}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_NO2=${USE_LOG_NO2_LOGIC}
#
# MODEL PROFILE SETTINGS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
#      export NL_PATH_MODEL=\'${RUN_DIR}/${DATE}/wrfchem_chem_icbc\'
#      export NL_FILE_MODEL=\'wrfinput_d${CR_DOMAIN}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export NL_NZ_MODEL=${NNZP_CR}
#
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#      
# USE CRIS DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_cris_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/CRIS_CO/work/cris_co_total_col_ascii_to_obs ./.
      ./cris_co_total_col_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ -s ${NL_FILEOUT} ]]; then
         touch NO_CRIS_CO_${DATE}
      fi
   fi
#
########################################################################
#
# RUN CRIS CO PROFILE OBSERVATIONS
#
########################################################################
#
   if ${RUN_CRIS_CO_PROFILE_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/cris_co_profile_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/cris_co_profile_obs
         cd ${RUN_DIR}/${DATE}/cris_co_profile_obs
      else
         cd ${RUN_DIR}/${DATE}/cris_co_profile_obs
      fi
#
# SET CRIS PARAMETERS
      export NL_PATH_MODEL=${RUN_DIR}/${PAST_DATE}/ensemble_mean_output
      export NL_FILE_MODEL=wrfout_d${CR_DOMAIN}_${YYYY}${MM}${DD}${HH}_mean
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export CRIS_FILE_PRE=TROPESS_CrIS-JPSS1_L2_Standard_CO_
      export CRIS_FILE_EXT=_MUSES_R1p17_FS_F0p4.nc
      export OUTFILE=TEMP_FILE.dat
      export TMP_OUTFILE=CRIS_CO_${DATE}.dat
      rm -rf ${OUTFILE}
      rm -rf ${TMP_OUTFILE}
#
# SET OBS_WINDOW
      export BIN_BEG_YY=${ASIM_MN_YYYY}
      export BIN_BEG_MM=${ASIM_MN_MM}
      export BIN_BEG_DD=${ASIM_MN_DD}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_YY=${ASIM_MX_YYYY}
      export BIN_END_MM=${ASIM_MX_MM}
      export BIN_END_DD=${ASIM_MX_DD}
      export BIN_END_HH=${HHM_END}
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      export FLG=0
      if [[ ${ASIM_MX_HH} -eq 3 ]]; then
         export FLG=1 
         export BIN_BEG_YY=${ASIM_MX_YYYY}
         export BIN_BEG_MM=${ASIM_MX_MM}
         export BIN_BEG_DD=${ASIM_MX_DD}
         export BIN_BEG_HH=0
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
      fi
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
#
# SET CRIS INPUT DATA DIR
      export TMP_INFILE=\'${EXPERIMENT_CRIS_CO_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${CRIS_FILE_PRE}\'
#
# COPY EXECUTABLE
      export FILE=cris_co_profile_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/CRIS_CO/native_to_ascii/${FILE} ./.
      mcc -m cris_co_profile_extract.m -o cris_co_profile_extract
      ./run_cris_co_profile_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${CRIS_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat1.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
#
# END OF PREVIOUS DAY (hours 21 to 24 obs)
      if [[ ${FLG} -eq 1 ]]; then	 
         export BIN_BEG_YY=${ASIM_MIN_YYYY}
         export BIN_BEG_MM=${ASIM_MIN_MM}
         export BIN_BEG_DD=${ASIM_MIN_DD}
         export BIN_BEG_HH=${ASIM_MIN_HH}
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
         export BIN_END_YY=${ASIM_MIN_YYYY}
         export BIN_END_MM=${ASIM_MIN_MM}
         export BIN_END_DD=${ASIM_MIN_DD}
         export BIN_END_HH=23
         export BIN_END_MN=59
         export BIN_END_SS=59
         export TMP_INFILE=\'${EXPERIMENT_CRIS_CO_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${CRIS_FILE_PRE}\'
#
# COPY EXECUTABLE
         export FILE=cris_co_profile_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/CRIS_CO/native_to_ascii/${FILE} ./.
         mcc -m cris_co_profile_extract.m -o cris_co_profile_extract
         ./run_cris_co_profile_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${CRIS_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat2.html 2>&1
#
      fi
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
      if [[ ! -e ${TMP_OUTFILE} ]]; then
         touch NO_CRIS_CO_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT CRIS CO ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'${TMP_OUTFILE}\'
      export NL_FILEOUT=\'obs_seq_cris_co_profile_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_CRIS_CO}
      export NL_USE_LOG_CO=${USE_LOG_CO_LOGIC}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_CH4=${USE_LOG_CH4_LOGIC}
      export NL_USE_LOG_NH3=${USE_LOG_NH3_LOGIC}
      export NL_USE_LOG_PAN=${USE_LOG_PAN_LOGIC}
#
# MODEL PROFILE SETTINGS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export NL_NZ_MODEL=${NNZP_CR}
#
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#      
# USE CRIS DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_cris_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/CRIS_CO/work/cris_co_profile_ascii_to_obs ./.
      ./cris_co_profile_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ -s ${NL_FILEOUT} ]]; then
         touch NO_CRIS_CO_${DATE}
      fi
   fi
#
########################################################################
#
# RUN CRIS CO CPSR OBSERVATIONS
#
########################################################################
#
   if ${RUN_CRIS_CO_CPSR_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/cris_co_cpsr_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/cris_co_cpsr_obs
         cd ${RUN_DIR}/${DATE}/cris_co_cpsr_obs
      else
         cd ${RUN_DIR}/${DATE}/cris_co_cpsr_obs
      fi
#
# SET CRIS PARAMETERS
      export NL_PATH_MODEL=${RUN_DIR}/${PAST_DATE}/ensemble_mean_output
      export NL_FILE_MODEL=wrfout_d${CR_DOMAIN}_${DATE}_mean
#      export NL_PATH_MODEL=${RUN_DIR}/${DATE}/ensemble_mean_input
#      export NL_FILE_MODEL=wrfinput_d${CR_DOMAIN}_mean

      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export CRIS_FILE_PRE=CRIS_CO_L2_V01_
      export CRIS_FILE_EXT=.nc
      export OUTFILE=TEMP_FILE.dat
      export TMP_OUTFILE=CRIS_CO_${DATE}.dat
      rm -rf ${OUTFILE}
      rm -rf ${TMP_OUTFILE}
#
# SET OBS_WINDOW
      export BIN_BEG_YY=${ASIM_MN_YYYY}
      export BIN_BEG_MM=${ASIM_MN_MM}
      export BIN_BEG_DD=${ASIM_MN_DD}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_YY=${ASIM_MX_YYYY}
      export BIN_END_MM=${ASIM_MX_MM}
      export BIN_END_DD=${ASIM_MX_DD}
      export BIN_END_HH=${HHM_END}
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      export FLG=0
      if [[ ${ASIM_MX_HH} -eq 3 ]]; then
         export FLG=1 
         export BIN_BEG_YY=${ASIM_MX_YYYY}
         export BIN_BEG_MM=${ASIM_MX_MM}
         export BIN_BEG_DD=${ASIM_MX_DD}
         export BIN_BEG_HH=0
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
      fi
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
#
# SET CRIS INPUT DATA DIR
      export TMP_INFILE=\'${EXPERIMENT_CRIS_CO_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${CRIS_FILE_PRE}\'
#
# COPY EXECUTABLE
      export FILE=cris_co_cpsr_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/CRIS_CO/native_to_ascii/${FILE} ./.
      mcc -m cris_co_cpsr_extract.m -o cris_co_cpsr_extract
      ./run_cris_co_cpsr_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${CRIS_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat1.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
#
# END OF PREVIOUS DAY (hours 21 to 24 obs)
      if [[ ${FLG} -eq 1 ]]; then	 
         export BIN_BEG_YY=${ASIM_MIN_YYYY}
         export BIN_BEG_MM=${ASIM_MIN_MM}
         export BIN_BEG_DD=${ASIM_MIN_DD}
         export BIN_BEG_HH=${ASIM_MIN_HH}
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
         export BIN_END_YY=${ASIM_MIN_YYYY}
         export BIN_END_MM=${ASIM_MIN_MM}
         export BIN_END_DD=${ASIM_MIN_DD}
         export BIN_END_HH=23
         export BIN_END_MN=59
         export BIN_END_SS=59
         export TMP_INFILE=\'${EXPERIMENT_CRIS_CO_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${CRIS_FILE_PRE}\'
#
# COPY EXECUTABLE
         export FILE=cris_co_cpsr_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/CRIS_CO/native_to_ascii/${FILE} ./.
         mcc -m cris_co_cpsr_extract.m -o cris_co_cpsr_extract
         ./run_cris_co_cpsr_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${CRIS_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat2.html 2>&1
#
      fi
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
      if [[ ! -e ${TMP_OUTFILE} ]]; then
         touch NO_CRIS_CO_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT CRIS CO ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'${TMP_OUTFILE}\'
      export NL_FILEOUT=\'obs_seq_cris_co_cpsr_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_CRIS_CO}
      export NL_USE_LOG_CO=${USE_LOG_CO_LOGIC}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_CO2=${USE_LOG_CO2_LOGIC}
      export NL_USE_LOG_CH4=${USE_LOG_CH4_LOGIC}
      export NL_USE_LOG_NH3=${USE_LOG_NH3_LOGIC}
#
# MODEL CPSR SETTINGS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
#      export NL_PATH_MODEL=\'${RUN_DIR}/${DATE}/wrfchem_chem_icbc\'
#      export NL_FILE_MODEL=\'wrfinput_d${CR_DOMAIN}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export NL_NZ_MODEL=${NNZP_CR}
#
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#      
# USE CRIS DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_cris_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/CRIS_CO/work/cris_co_cpsr_ascii_to_obs ./.
      ./cris_co_cpsr_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ -s ${NL_FILEOUT} ]]; then
         touch NO_CRIS_CO_${DATE}
      fi
   fi
#
########################################################################
#
# RUN CRIS O3 TOTAL COL OBSERVATIONS
#
########################################################################
#
   if ${RUN_CRIS_O3_TOTAL_COL_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/cris_o3_total_col_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/cris_o3_total_col_obs
         cd ${RUN_DIR}/${DATE}/cris_o3_total_col_obs
      else
         cd ${RUN_DIR}/${DATE}/cris_o3_total_col_obs
      fi
#
# SET CRIS PARAMETERS
      export NL_PATH_MODEL=${RUN_DIR}/${PAST_DATE}/ensemble_mean_output
      export NL_FILE_MODEL=wrfout_d${CR_DOMAIN}_${YYYY}${MM}${DD}${HH}_mean
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export CRIS_FILE_PRE=CRIS_O3_L2_V01_
      export CRIS_FILE_EXT=.nc
      export OUTFILE=TEMP_FILE.dat
      export TMP_OUTFILE=CRIS_O3_${DATE}.dat
      rm -rf ${OUTFILE}
      rm -rf ${TMP_OUTFILE}
#
# SET OBS_WINDOW
      export BIN_BEG_YY=${ASIM_MN_YYYY}
      export BIN_BEG_MM=${ASIM_MN_MM}
      export BIN_BEG_DD=${ASIM_MN_DD}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_YY=${ASIM_MX_YYYY}
      export BIN_END_MM=${ASIM_MX_MM}
      export BIN_END_DD=${ASIM_MX_DD}
      export BIN_END_HH=${HHM_END}
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      export FLG=0
      if [[ ${ASIM_MX_HH} -eq 3 ]]; then
         export FLG=1 
         export BIN_BEG_YY=${ASIM_MX_YYYY}
         export BIN_BEG_MM=${ASIM_MX_MM}
         export BIN_BEG_DD=${ASIM_MX_DD}
         export BIN_BEG_HH=0
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
      fi
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
#
# SET CRIS INPUT DATA DIR
      export TMP_INFILE=\'${EXPERIMENT_CRIS_O3_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${CRIS_FILE_PRE}\'
#
# COPY EXECUTABLE
      export FILE=cris_o3_total_col_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/CRIS_O3/native_to_ascii/${FILE} ./.
      mcc -m cris_o3_total_col_extract.m -o cris_o3_total_col_extract
      ./run_cris_o3_total_col_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${CRIS_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat1.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
#
# END OF PREVIOUS DAY (hours 21 to 24 obs)
      if [[ ${FLG} -eq 1 ]]; then	 
         export BIN_BEG_YY=${ASIM_MIN_YYYY}
         export BIN_BEG_MM=${ASIM_MIN_MM}
         export BIN_BEG_DD=${ASIM_MIN_DD}
         export BIN_BEG_HH=${ASIM_MIN_HH}
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
         export BIN_END_YY=${ASIM_MIN_YYYY}
         export BIN_END_MM=${ASIM_MIN_MM}
         export BIN_END_DD=${ASIM_MIN_DD}
         export BIN_END_HH=23
         export BIN_END_MN=59
         export BIN_END_SS=59
         export TMP_INFILE=\'${EXPERIMENT_CRIS_O3_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${CRIS_FILE_PRE}\'
#
# COPY EXECUTABLE
         export FILE=cris_o3_total_col_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/CRIS_O3/native_to_ascii/${FILE} ./.
         mcc -m cris_o3_total_col_extract.m -o cris_o3_total_col_extract
         ./run_cris_o3_total_col_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${CRIS_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat2.html 2>&1
#
      fi
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
      if [[ ! -e ${TMP_OUTFILE} ]]; then
         touch NO_CRIS_O3_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT CRIS O3 ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'${TMP_OUTFILE}\'
      export NL_FILEOUT=\'obs_seq_cris_o3_total_col_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_CRIS_O3}
      export NL_USE_LOG_CO=${USE_LOG_CO_LOGIC}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_CO2=${USE_LOG_CO2_LOGIC}
      export NL_USE_LOG_CH4=${USE_LOG_CH4_LOGIC}
      export NL_USE_LOG_NH3=${USE_LOG_NH3_LOGIC}
#
# MODEL PROFILE SETTINGS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
#      export NL_PATH_MODEL=\'${RUN_DIR}/${DATE}/wrfchem_chem_icbc\'
#      export NL_FILE_MODEL=\'wrfinput_d${CR_DOMAIN}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export NL_NZ_MODEL=${NNZP_CR}
#
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#      
# USE CRIS DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_cris_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/CRIS_O3/work/cris_o3_total_col_ascii_to_obs ./.
      ./cris_o3_total_col_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ -s ${NL_FILEOUT} ]]; then
         touch NO_CRIS_O3_${DATE}
      fi
   fi
#
########################################################################
#
# RUN CRIS O3 PROFILE OBSERVATIONS
#
########################################################################
#
   if ${RUN_CRIS_O3_PROFILE_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/cris_o3_profile_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/cris_o3_profile_obs
         cd ${RUN_DIR}/${DATE}/cris_o3_profile_obs
      else
         cd ${RUN_DIR}/${DATE}/cris_o3_profile_obs
      fi
#
# SET CRIS PARAMETERS
      export NL_PATH_MODEL=${RUN_DIR}/${PAST_DATE}/ensemble_mean_output
      export NL_FILE_MODEL=wrfout_d${CR_DOMAIN}_${YYYY}${MM}${DD}${HH}_mean
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export CRIS_FILE_PRE=TROPESS_CrIS-JPSS1_L2_Standard_O3_
      export CRIS_FILE_EXT=_MUSES_R1p17_FS_F0p4.nc
      export OUTFILE=TEMP_FILE.dat
      export TMP_OUTFILE=CRIS_O3_${DATE}.dat
      rm -rf ${OUTFILE}
      rm -rf ${TMP_OUTFILE}
#
# SET OBS_WINDOW
      export BIN_BEG_YY=${ASIM_MN_YYYY}
      export BIN_BEG_MM=${ASIM_MN_MM}
      export BIN_BEG_DD=${ASIM_MN_DD}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_YY=${ASIM_MX_YYYY}
      export BIN_END_MM=${ASIM_MX_MM}
      export BIN_END_DD=${ASIM_MX_DD}
      export BIN_END_HH=${HHM_END}
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      export FLG=0
      if [[ ${ASIM_MX_HH} -eq 3 ]]; then
         export FLG=1 
         export BIN_BEG_YY=${ASIM_MX_YYYY}
         export BIN_BEG_MM=${ASIM_MX_MM}
         export BIN_BEG_DD=${ASIM_MX_DD}
         export BIN_BEG_HH=0
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
      fi
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
#
# SET CRIS INPUT DATA DIR
      export TMP_INFILE=\'${EXPERIMENT_CRIS_O3_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${CRIS_FILE_PRE}\'
#
# COPY EXECUTABLE
      export FILE=cris_o3_profile_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/CRIS_O3/native_to_ascii/${FILE} ./.
      mcc -m cris_o3_profile_extract.m -o cris_o3_profile_extract
      ./run_cris_o3_profile_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${CRIS_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat1.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
#
# END OF PREVIOUS DAY (hours 21 to 24 obs)
      if [[ ${FLG} -eq 1 ]]; then	 
         export BIN_BEG_YY=${ASIM_MIN_YYYY}
         export BIN_BEG_MM=${ASIM_MIN_MM}
         export BIN_BEG_DD=${ASIM_MIN_DD}
         export BIN_BEG_HH=${ASIM_MIN_HH}
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
         export BIN_END_YY=${ASIM_MIN_YYYY}
         export BIN_END_MM=${ASIM_MIN_MM}
         export BIN_END_DD=${ASIM_MIN_DD}
         export BIN_END_HH=23
         export BIN_END_MN=59
         export BIN_END_SS=59
         export TMP_INFILE=\'${EXPERIMENT_CRIS_O3_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${CRIS_FILE_PRE}\'
#
# COPY EXECUTABLE
         export FILE=cris_o3_profile_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/CRIS_O3/native_to_ascii/${FILE} ./.
         mcc -m cris_o3_profile_extract.m -o cris_o3_profile_extract
         ./run_cris_o3_profile_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${CRIS_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat2.html 2>&1
#
      fi
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
      if [[ ! -e ${TMP_OUTFILE} ]]; then
         touch NO_CRIS_O3_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT CRIS O3 ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'${TMP_OUTFILE}\'
      export NL_FILEOUT=\'obs_seq_cris_o3_profile_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_CRIS_O3}
      export NL_USE_LOG_CO=${USE_LOG_CO_LOGIC}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_CH4=${USE_LOG_CH4_LOGIC}
      export NL_USE_LOG_NH3=${USE_LOG_NH3_LOGIC}
      export NL_USE_LOG_PAN=${USE_LOG_PAN_LOGIC}
#
# MODEL PROFILE SETTINGS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export NL_NZ_MODEL=${NNZP_CR}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#      
# USE CRIS DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_cris_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/CRIS_O3/work/cris_o3_profile_ascii_to_obs ./.
      ./cris_o3_profile_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ -s ${NL_FILEOUT} ]]; then
         touch NO_CRIS_O3_${DATE}
      fi
   fi
#
########################################################################
#
# RUN CRIS O3 CPSR OBSERVATIONS
#
########################################################################
#
   if ${RUN_CRIS_O3_CPSR_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/cris_o3_cpsr_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/cris_o3_cpsr_obs
         cd ${RUN_DIR}/${DATE}/cris_o3_cpsr_obs
      else
         cd ${RUN_DIR}/${DATE}/cris_o3_cpsr_obs
      fi
#
# SET CRIS PARAMETERS
      export NL_PATH_MODEL=${RUN_DIR}/${PAST_DATE}/ensemble_mean_output
      export NL_FILE_MODEL=wrfout_d${CR_DOMAIN}_${DATE}_mean
#      export NL_PATH_MODEL=${RUN_DIR}/${DATE}/ensemble_mean_input
#      export NL_FILE_MODEL=wrfinput_d${CR_DOMAIN}_mean

      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export CRIS_FILE_PRE=CRIS_O3_L2_V01_
      export CRIS_FILE_EXT=.nc
      export OUTFILE=TEMP_FILE.dat
      export TMP_OUTFILE=CRIS_O3_${DATE}.dat
      rm -rf ${OUTFILE}
      rm -rf ${TMP_OUTFILE}
#
# SET OBS_WINDOW
      export BIN_BEG_YY=${ASIM_MN_YYYY}
      export BIN_BEG_MM=${ASIM_MN_MM}
      export BIN_BEG_DD=${ASIM_MN_DD}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_YY=${ASIM_MX_YYYY}
      export BIN_END_MM=${ASIM_MX_MM}
      export BIN_END_DD=${ASIM_MX_DD}
      export BIN_END_HH=${HHM_END}
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      export FLG=0
      if [[ ${ASIM_MX_HH} -eq 3 ]]; then
         export FLG=1 
         export BIN_BEG_YY=${ASIM_MX_YYYY}
         export BIN_BEG_MM=${ASIM_MX_MM}
         export BIN_BEG_DD=${ASIM_MX_DD}
         export BIN_BEG_HH=0
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
      fi
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
#
# SET CRIS INPUT DATA DIR
      export TMP_INFILE=\'${EXPERIMENT_CRIS_NH3_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${CRIS_FILE_PRE}\'
#
# COPY EXECUTABLE
      export FILE=cris_o3_cpsr_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/CRIS_O3/native_to_ascii/${FILE} ./.
      mcc -m cris_o3_cpsr_extract.m -o cris_o3_cpsr_extract
      ./run_cris_o3_cpsr_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${CRIS_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
#
# END OF PREVIOUS DAY (hours 21 to 24 obs)
      if [[ ${FLG} -eq 1 ]]; then	 
         export BIN_BEG_YY=${ASIM_MIN_YYYY}
         export BIN_BEG_MM=${ASIM_MIN_MM}
         export BIN_BEG_DD=${ASIM_MIN_DD}
         export BIN_BEG_HH=${ASIM_MIN_HH}
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
         export BIN_END_YY=${ASIM_MIN_YYYY}
         export BIN_END_MM=${ASIM_MIN_MM}
         export BIN_END_DD=${ASIM_MIN_DD}
         export BIN_END_HH=23
         export BIN_END_MN=59
         export BIN_END_SS=59
         export TMP_INFILE=\'${EXPERIMENT_CRIS_NH3_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${CRIS_FILE_PRE}\'
#
# COPY EXECUTABLE
         export FILE=cris_o3_cpsr_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/CRIS_O3/native_to_ascii/${FILE} ./.
         mcc -m cris_o3_cpsr_extract.m -o cris_o3_cpsr_extract
         ./run_cris_o3_cpsr_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${CRIS_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat.html 2>&1
#
      fi
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
      if [[ ! -e ${TMP_OUTFILE} ]]; then
         touch NO_CRIS_O3_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT CRIS O3 ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'${TMP_OUTFILE}\'
      export NL_FILEOUT=\'obs_seq_cris_o3_cpsr_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_CRIS_O3}
      export NL_USE_LOG_CO=${USE_LOG_CO_LOGIC}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_CO2=${USE_LOG_CO2_LOGIC}
      export NL_USE_LOG_CH4=${USE_LOG_CH4_LOGIC}
      export NL_USE_LOG_NH3=${USE_LOG_NH3_LOGIC}
#
# MODEL CPSR SETTINGS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
#      export NL_PATH_MODEL=\'${RUN_DIR}/${DATE}/wrfchem_chem_icbc\'
#      export NL_FILE_MODEL=\'wrfinput_d${CR_DOMAIN}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export NL_NZ_MODEL=${NNZP_CR}
#
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#      
# USE CRIS DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_cris_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/CRIS_O3/work/cris_o3_cpsr_ascii_to_obs ./.
      ./cris_o3_cpsr_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ -s ${NL_FILEOUT} ]]; then
         touch NO_CRIS_O3_${DATE}
      fi
   fi
#
########################################################################
#
# RUN CRIS NH3 TOTAL COL OBSERVATIONS
#
########################################################################
#
   if ${RUN_CRIS_NH3_TOTAL_COL_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/cris_nh3_total_col_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/cris_nh3_total_col_obs
         cd ${RUN_DIR}/${DATE}/cris_nh3_total_col_obs
      else
         cd ${RUN_DIR}/${DATE}/cris_nh3_total_col_obs
      fi
#
# SET CRIS PARAMETERS
      export NL_PATH_MODEL=${RUN_DIR}/${PAST_DATE}/ensemble_mean_output
      export NL_FILE_MODEL=wrfout_d${CR_DOMAIN}_${DATE}_mean
#      export NL_PATH_MODEL=${RUN_DIR}/${DATE}/ensemble_mean_input
#      export NL_FILE_MODEL=wrfinput_d${CR_DOMAIN}_mean

      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export CRIS_FILE_PRE=CRIS-Aura_L2-CO-SO-Nadir_r00000
      export CRIS_FILE_EXT=_C01_F08_11.he5
      export OUTFILE=TEMP_FILE.dat
      export TMP_OUTFILE=CRIS_NH3_${DATE}.dat
      rm -rf ${OUTFILE}
      rm -rf ${TMP_OUTFILE}
#
# SET OBS_WINDOW
      export BIN_BEG_YY=${ASIM_MN_YYYY}
      export BIN_BEG_MM=${ASIM_MN_MM}
      export BIN_BEG_DD=${ASIM_MN_DD}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_YY=${ASIM_MX_YYYY}
      export BIN_END_MM=${ASIM_MX_MM}
      export BIN_END_DD=${ASIM_MX_DD}
      export BIN_END_HH=${HHM_END}
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      export FLG=0
      if [[ ${ASIM_MX_HH} -eq 3 ]]; then
         export FLG=1 
         export BIN_BEG_YY=${ASIM_MX_YYYY}
         export BIN_BEG_MM=${ASIM_MX_MM}
         export BIN_BEG_DD=${ASIM_MX_DD}
         export BIN_BEG_HH=0
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
      fi
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
#
# SET CRIS INPUT DATA DIR
      export TMP_INFILE=\'${EXPERIMENT_CRIS_NH3_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${CRIS_FILE_PRE}\'
#
# COPY EXECUTABLE
      export FILE=cris_nh3_total_col_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/CRIS_NH3/native_to_ascii/${FILE} ./.
      mcc -m cris_nh3_total_col_extract.m -o cris_nh3_total_col_extract
      ./run_cris_nh3_total_col_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${CRIS_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat1.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
#
# END OF PREVIOUS DAY (hours 21 to 24 obs)
      if [[ ${FLG} -eq 1 ]]; then	 
         export BIN_BEG_YY=${ASIM_MIN_YYYY}
         export BIN_BEG_MM=${ASIM_MIN_MM}
         export BIN_BEG_DD=${ASIM_MIN_DD}
         export BIN_BEG_HH=${ASIM_MIN_HH}
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
         export BIN_END_YY=${ASIM_MIN_YYYY}
         export BIN_END_MM=${ASIM_MIN_MM}
         export BIN_END_DD=${ASIM_MIN_DD}
         export BIN_END_HH=23
         export BIN_END_MN=59
         export BIN_END_SS=59
         export TMP_INFILE=\'${EXPERIMENT_CRIS_NH3_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${CRIS_FILE_PRE}\'

#
# COPY EXECUTABLE
         export FILE=cris_nh3_total_col_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/CRIS_NH3/native_to_ascii/${FILE} ./.
         mcc -m cris_nh3_total_col_extract.m -o cris_nh3_total_col_extract
         ./run_cris_nh3_total_col_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${CRIS_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat.html 2>&1
#
      fi
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
      if [[ ! -e ${TMP_OUTFILE} ]]; then
         touch NO_CRIS_NH3_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT CRIS NH3 ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'${TMP_OUTFILE}\'
      export NL_FILEOUT=\'obs_seq_cris_nh3_total_col_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_CRIS_NH3}
      export NL_USE_LOG_CO=${USE_LOG_CO_LOGIC}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_CO2=${USE_LOG_CO2_LOGIC}
      export NL_USE_LOG_CH4=${USE_LOG_CH4_LOGIC}
      export NL_USE_LOG_NH3=${USE_LOG_NH3_LOGIC}
#
# MODEL PROFILE SETTINGS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
#      export NL_PATH_MODEL=\'${RUN_DIR}/${DATE}/wrfchem_chem_icbc\'
#      export NL_FILE_MODEL=\'wrfinput_d${CR_DOMAIN}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export NL_NZ_MODEL=${NNZP_CR}
#
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#      
# USE CRIS DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_cris_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/CRIS_NH3/work/cris_nh3_total_col_ascii_to_obs ./.
      ./cris_nh3_total_col_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ -s ${NL_FILEOUT} ]]; then
         touch NO_CRIS_NH3_${DATE}
      fi
   fi
#
########################################################################
#
# RUN CRIS NH3 PROFILE OBSERVATIONS
#
########################################################################
#
   if ${RUN_CRIS_NH3_PROFILE_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/cris_nh3_profile_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/cris_nh3_profile_obs
         cd ${RUN_DIR}/${DATE}/cris_nh3_profile_obs
      else
         cd ${RUN_DIR}/${DATE}/cris_nh3_profile_obs
      fi
#
# SET CRIS PARAMETERS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export CRIS_FILE_PRE=TROPESS_CrIS-JPSS1_L2_Standard_NH3_
      export CRIS_FILE_EXT=_MUSES_R1p17_FS_F0p4.nc
      export OUTFILE=TEMP_FILE.dat
      export TMP_OUTFILE=CRIS_NH3_${DATE}.dat
      rm -rf ${OUTFILE}
      rm -rf ${TMP_OUTFILE}
#
# SET OBS_WINDOW
      export BIN_BEG_YY=${ASIM_MN_YYYY}
      export BIN_BEG_MM=${ASIM_MN_MM}
      export BIN_BEG_DD=${ASIM_MN_DD}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_YY=${ASIM_MX_YYYY}
      export BIN_END_MM=${ASIM_MX_MM}
      export BIN_END_DD=${ASIM_MX_DD}
      export BIN_END_HH=${HHM_END}
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      export FLG=0
      if [[ ${ASIM_MX_HH} -eq 3 ]]; then
         export FLG=1 
         export BIN_BEG_YY=${ASIM_MX_YYYY}
         export BIN_BEG_MM=${ASIM_MX_MM}
         export BIN_BEG_DD=${ASIM_MX_DD}
         export BIN_BEG_HH=0
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
      fi
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
#
# SET CRIS INPUT DATA DIR
      export TMP_INFILE=\'${EXPERIMENT_CRIS_NH3_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${CRIS_FILE_PRE}\'
#
# COPY EXECUTABLE
      export FILE=cris_nh3_profile_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/CRIS_NH3/native_to_ascii/${FILE} ./.
      mcc -m cris_nh3_profile_extract.m -o cris_nh3_profile_extract
      ./run_cris_nh3_profile_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${CRIS_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat1.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
#
# END OF PREVIOUS DAY (hours 21 to 24 obs)
      if [[ ${FLG} -eq 1 ]]; then	 
         export BIN_BEG_YY=${ASIM_MIN_YYYY}
         export BIN_BEG_MM=${ASIM_MIN_MM}
         export BIN_BEG_DD=${ASIM_MIN_DD}
         export BIN_BEG_HH=${ASIM_MIN_HH}
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
         export BIN_END_YY=${ASIM_MIN_YYYY}
         export BIN_END_MM=${ASIM_MIN_MM}
         export BIN_END_DD=${ASIM_MIN_DD}
         export BIN_END_HH=23
         export BIN_END_MN=59
         export BIN_END_SS=59
         export TMP_INFILE=\'${EXPERIMENT_CRIS_NH3_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${CRIS_FILE_PRE}\'
#
# COPY EXECUTABLE
         export FILE=cris_nh3_profile_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/CRIS_NH3/native_to_ascii/${FILE} ./.
         mcc -m cris_nh3_profile_extract.m -o cris_nh3_profile_extract
         ./run_cris_nh3_profile_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${CRIS_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat2.html 2>&1
#
      fi
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
      if [[ ! -e ${TMP_OUTFILE} ]]; then
         touch NO_CRIS_NH3_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT CRIS NH3 ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'${TMP_OUTFILE}\'
      export NL_FILEOUT=\'obs_seq_cris_nh3_profile_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_CRIS_NH3}
      export NL_USE_LOG_CO=${USE_LOG_CO_LOGIC}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_CH4=${USE_LOG_CH4_LOGIC}
      export NL_USE_LOG_NH3=${USE_LOG_NH3_LOGIC}
      export NL_USE_LOG_PAN=${USE_LOG_PAN_LOGIC}
#
# MODEL PROFILE SETTINGS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export NL_NZ_MODEL=${NNZP_CR}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#      
# USE CRIS DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_cris_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/CRIS_NH3/work/cris_nh3_profile_ascii_to_obs ./.
      ./cris_nh3_profile_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ -s ${NL_FILEOUT} ]]; then
         touch NO_CRIS_NH3_${DATE}
      fi
   fi
#
########################################################################
#
# RUN CRIS CH4 TOTAL COL OBSERVATIONS
#
########################################################################
#
   if ${RUN_CRIS_CH4_TOTAL_COL_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/cris_ch4_total_col_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/cris_ch4_total_col_obs
         cd ${RUN_DIR}/${DATE}/cris_ch4_total_col_obs
      else
         cd ${RUN_DIR}/${DATE}/cris_ch4_total_col_obs
      fi
#
# SET CRIS PARAMETERS
      export NL_PATH_MODEL=${RUN_DIR}/${PAST_DATE}/ensemble_mean_output
      export NL_FILE_MODEL=wrfout_d${CR_DOMAIN}_${DATE}_mean
#      export NL_PATH_MODEL=${RUN_DIR}/${DATE}/ensemble_mean_input
#      export NL_FILE_MODEL=wrfinput_d${CR_DOMAIN}_mean

      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export CRIS_FILE_PRE=CRIS-Aura_L2-CH4-SO-Nadir_r00000
      export CRIS_FILE_EXT=_C01_F08_11.he5
      export OUTFILE=TEMP_FILE.dat
      export TMP_OUTFILE=CRIS_CH4_${DATE}.dat
      rm -rf ${OUTFILE}
      rm -rf ${TMP_OUTFILE}
#
# SET OBS_WINDOW
      export BIN_BEG_YY=${ASIM_MN_YYYY}
      export BIN_BEG_MM=${ASIM_MN_MM}
      export BIN_BEG_DD=${ASIM_MN_DD}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_YY=${ASIM_MX_YYYY}
      export BIN_END_MM=${ASIM_MX_MM}
      export BIN_END_DD=${ASIM_MX_DD}
      export BIN_END_HH=${HHM_END}
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      export FLG=0
      if [[ ${ASIM_MX_HH} -eq 3 ]]; then
         export FLG=1 
         export BIN_BEG_YY=${ASIM_MX_YYYY}
         export BIN_BEG_MM=${ASIM_MX_MM}
         export BIN_BEG_DD=${ASIM_MX_DD}
         export BIN_BEG_HH=0
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
      fi
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
#
# SET CRIS INPUT DATA DIR
      export TMP_INFILE=\'${EXPERIMENT_CRIS_CH4_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${CRIS_FILE_PRE}\'
#
# COPY EXECUTABLE
      export FILE=cris_ch4_total_col_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/CRIS_CH4/native_to_ascii/${FILE} ./.
      mcc -m cris_ch4_total_col_extract.m -o cris_ch4_total_col_extract
      ./run_cris_ch4_total_col_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${CRIS_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
#
# END OF PREVIOUS DAY (hours 21 to 24 obs)
      if [[ ${FLG} -eq 1 ]]; then	 
         export BIN_BEG_YY=${ASIM_MIN_YYYY}
         export BIN_BEG_MM=${ASIM_MIN_MM}
         export BIN_BEG_DD=${ASIM_MIN_DD}
         export BIN_BEG_HH=${ASIM_MIN_HH}
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
         export BIN_END_YY=${ASIM_MIN_YYYY}
         export BIN_END_MM=${ASIM_MIN_MM}
         export BIN_END_DD=${ASIM_MIN_DD}
         export BIN_END_HH=23
         export BIN_END_MN=59
         export BIN_END_SS=59
         export TMP_INFILE=\'${EXPERIMENT_CRIS_CH4_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${CRIS_FILE_PRE}\'
#
# COPY EXECUTABLE
         export FILE=cris_ch4_total_col_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/CRIS_CH4/native_to_ascii/${FILE} ./.
         mcc -m cris_ch4_total_col_extract.m -o cris_ch4_total_col_extract
         ./run_cris_ch4_total_col_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${CRIS_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat.html 2>&1
#
      fi
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
      if [[ ! -e ${TMP_OUTFILE} ]]; then
         touch NO_CRIS_CH4_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT CRIS CH4 ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'${TMP_OUTFILE}\'
      export NL_FILEOUT=\'obs_seq_cris_ch4_total_col_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_CRIS_CH4}
      export NL_USE_LOG_CO=${USE_LOG_CO_LOGIC}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_CO2=${USE_LOG_CO2_LOGIC}
      export NL_USE_LOG_CH4=${USE_LOG_CH4_LOGIC}
      export NL_USE_LOG_NH3=${USE_LOG_NH3_LOGIC}
#
# MODEL PROFILE SETTINGS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
#      export NL_PATH_MODEL=\'${RUN_DIR}/${DATE}/wrfchem_chem_icbc\'
#      export NL_FILE_MODEL=\'wrfinput_d${CR_DOMAIN}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export NL_NZ_MODEL=${NNZP_CR}
#
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#      
# USE CRIS DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_cris_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/CRIS_CH4/work/cris_ch4_total_col_ascii_to_obs ./.
      ./cris_ch4_total_col_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ -s ${NL_FILEOUT} ]]; then
         touch NO_CRIS_CH4_${DATE}
      fi
   fi
#
########################################################################
#
# RUN CRIS CH4 PROFILE OBSERVATIONS
#
########################################################################
#
   if ${RUN_CRIS_CH4_PROFILE_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/cris_ch4_profile_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/cris_ch4_profile_obs
         cd ${RUN_DIR}/${DATE}/cris_ch4_profile_obs
      else
         cd ${RUN_DIR}/${DATE}/cris_ch4_profile_obs
      fi
#
# SET CRIS PARAMETERS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export CRIS_FILE_PRE=TROPESS_CrIS-JPSS1_L2_Standard_CH4_
      export CRIS_FILE_EXT=_MUSES_R1p17_FS_F0p4.nc
      export OUTFILE=TEMP_FILE.dat
      export TMP_OUTFILE=CRIS_CH4_${DATE}.dat
      rm -rf ${OUTFILE}
      rm -rf ${TMP_OUTFILE}
#
# SET OBS_WINDOW
      export BIN_BEG_YY=${ASIM_MN_YYYY}
      export BIN_BEG_MM=${ASIM_MN_MM}
      export BIN_BEG_DD=${ASIM_MN_DD}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_YY=${ASIM_MX_YYYY}
      export BIN_END_MM=${ASIM_MX_MM}
      export BIN_END_DD=${ASIM_MX_DD}
      export BIN_END_HH=${HHM_END}
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      export FLG=0
      if [[ ${ASIM_MX_HH} -eq 3 ]]; then
         export FLG=1 
         export BIN_BEG_YY=${ASIM_MX_YYYY}
         export BIN_BEG_MM=${ASIM_MX_MM}
         export BIN_BEG_DD=${ASIM_MX_DD}
         export BIN_BEG_HH=0
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
      fi
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
#
# SET CRIS INPUT DATA DIR
      export TMP_INFILE=\'${EXPERIMENT_CRIS_CH4_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${CRIS_FILE_PRE}\'
#
# COPY EXECUTABLE
      export FILE=cris_ch4_profile_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/CRIS_CH4/native_to_ascii/${FILE} ./.
      mcc -m cris_ch4_profile_extract.m -o cris_ch4_profile_extract
      ./run_cris_ch4_profile_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${CRIS_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat1.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
#
# END OF PREVIOUS DAY (hours 21 to 24 obs)
      if [[ ${FLG} -eq 1 ]]; then	 
         export BIN_BEG_YY=${ASIM_MIN_YYYY}
         export BIN_BEG_MM=${ASIM_MIN_MM}
         export BIN_BEG_DD=${ASIM_MIN_DD}
         export BIN_BEG_HH=${ASIM_MIN_HH}
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
         export BIN_END_YY=${ASIM_MIN_YYYY}
         export BIN_END_MM=${ASIM_MIN_MM}
         export BIN_END_DD=${ASIM_MIN_DD}
         export BIN_END_HH=23
         export BIN_END_MN=59
         export BIN_END_SS=59
         export TMP_INFILE=\'${EXPERIMENT_CRIS_CH4_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${CRIS_FILE_PRE}\'
#
# COPY EXECUTABLE
         export FILE=cris_ch4_profile_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/CRIS_CH4/native_to_ascii/${FILE} ./.
         mcc -m cris_ch4_profile_extract.m -o cris_ch4_profile_extract
         ./run_cris_ch4_profile_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${CRIS_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat2.html 2>&1
#
      fi
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
      if [[ ! -e ${TMP_OUTFILE} ]]; then
         touch NO_CRIS_CH4_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT CRIS CH4 ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'${TMP_OUTFILE}\'
      export NL_FILEOUT=\'obs_seq_cris_ch4_profile_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_CRIS_CH4}
      export NL_USE_LOG_CO=${USE_LOG_CO_LOGIC}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_CH4=${USE_LOG_CH4_LOGIC}
      export NL_USE_LOG_NH3=${USE_LOG_NH3_LOGIC}
      export NL_USE_LOG_PAN=${USE_LOG_PAN_LOGIC}
#
# MODEL PROFILE SETTINGS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export NL_NZ_MODEL=${NNZP_CR}
#
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#      
# USE CRIS DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_cris_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/CRIS_CH4/work/cris_ch4_profile_ascii_to_obs ./.
      ./cris_ch4_profile_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ -s ${NL_FILEOUT} ]]; then
         touch NO_CRIS_CH4_${DATE}
      fi
   fi
#
########################################################################
#
# RUN CRIS CH4 CPSR OBSERVATIONS
#
########################################################################
#
   if ${RUN_CRIS_CH4_CPSR_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/cris_ch4_cpsr_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/cris_ch4_cpsr_obs
         cd ${RUN_DIR}/${DATE}/cris_ch4_cpsr_obs
      else
         cd ${RUN_DIR}/${DATE}/cris_ch4_cpsr_obs
      fi
#
# SET CRIS PARAMETERS
      export NL_PATH_MODEL=${RUN_DIR}/${PAST_DATE}/ensemble_mean_output
      export NL_FILE_MODEL=wrfout_d${CR_DOMAIN}_${DATE}_mean
#      export NL_PATH_MODEL=${RUN_DIR}/${DATE}/ensemble_mean_input
#      export NL_FILE_MODEL=wrfinput_d${CR_DOMAIN}_mean

      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export CRIS_FILE_PRE=CRIS-Aura_L2-CH4-SO-Nadir_r00000
      export CRIS_FILE_EXT=_C01_F08_11.he5
      export OUTFILE=TEMP_FILE.dat
      export TMP_OUTFILE=CRIS_CH4_${DATE}.dat
      rm -rf ${OUTFILE}
      rm -rf ${TMP_OUTFILE}
#
# SET OBS_WINDOW
      export BIN_BEG_YY=${ASIM_MN_YYYY}
      export BIN_BEG_MM=${ASIM_MN_MM}
      export BIN_BEG_DD=${ASIM_MN_DD}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_YY=${ASIM_MX_YYYY}
      export BIN_END_MM=${ASIM_MX_MM}
      export BIN_END_DD=${ASIM_MX_DD}
      export BIN_END_HH=${HHM_END}
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      export FLG=0
      if [[ ${ASIM_MX_HH} -eq 3 ]]; then
         export FLG=1 
         export BIN_BEG_YY=${ASIM_MX_YYYY}
         export BIN_BEG_MM=${ASIM_MX_MM}
         export BIN_BEG_DD=${ASIM_MX_DD}
         export BIN_BEG_HH=0
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
      fi
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
#
# SET CRIS INPUT DATA DIR
      export TMP_INFILE=\'${EXPERIMENT_CRIS_CH4_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${CRIS_FILE_PRE}\'
#
# COPY EXECUTABLE
      export FILE=cris_ch4_cpsr_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/CRIS_CH4/native_to_ascii/${FILE} ./.
      mcc -m cris_ch4_cpsr_extract.m -o cris_ch4_cpsr_extract
      ./run_cris_ch4_cpsr_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${CRIS_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
#
# END OF PREVIOUS DAY (hours 21 to 24 obs)
      if [[ ${FLG} -eq 1 ]]; then	 
         export BIN_BEG_YY=${ASIM_MIN_YYYY}
         export BIN_BEG_MM=${ASIM_MIN_MM}
         export BIN_BEG_DD=${ASIM_MIN_DD}
         export BIN_BEG_HH=${ASIM_MIN_HH}
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
         export BIN_END_YY=${ASIM_MIN_YYYY}
         export BIN_END_MM=${ASIM_MIN_MM}
         export BIN_END_DD=${ASIM_MIN_DD}
         export BIN_END_HH=23
         export BIN_END_MN=59
         export BIN_END_SS=59
         export TMP_INFILE=\'${EXPERIMENT_CRIS_CH4_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${CRIS_FILE_PRE}\'
#
# COPY EXECUTABLE
         export FILE=cris_ch4_cpsr_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/CRIS_CH4/native_to_ascii/${FILE} ./.
         mcc -m cris_ch4_cpsr_extract.m -o cris_ch4_cpsr_extract
         ./run_cris_ch4_cpsr_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${CRIS_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat.html 2>&1
#
      fi
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
      if [[ ! -e ${TMP_OUTFILE} ]]; then
         touch NO_CRIS_CH4_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT CRIS CH4 ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'${TMP_OUTFILE}\'
      export NL_FILEOUT=\'obs_seq_cris_ch4_cpsr_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_CRIS_CH4}
      export NL_USE_LOG_CO=${USE_LOG_CO_LOGIC}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_CO2=${USE_LOG_CO2_LOGIC}
      export NL_USE_LOG_CH4=${USE_LOG_CH4_LOGIC}
      export NL_USE_LOG_NH3=${USE_LOG_NH3_LOGIC}
#
# MODEL CPSR SETTINGS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export NL_NZ_MODEL=${NNZP_CR}
#
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#      
# USE CRIS DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_cris_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/CRIS_CH4/work/cris_ch4_cpsr_ascii_to_obs ./.
      ./cris_ch4_cpsr_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ -s ${NL_FILEOUT} ]]; then
         touch NO_CRIS_CH4_${DATE}
      fi
   fi
#
########################################################################
#
# RUN CRIS PAN TOTAL COL OBSERVATIONS
#
########################################################################
#
   if ${RUN_CRIS_PAN_TOTAL_COL_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/cris_pan_total_col_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/cris_pan_total_col_obs
         cd ${RUN_DIR}/${DATE}/cris_pan_total_col_obs
      else
         cd ${RUN_DIR}/${DATE}/cris_pan_total_col_obs
      fi
#
# SET CRIS PARAMETERS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
   
      export CRIS_FILE_PRE=TROPESS_CrIS-JPSS1_L2_Summary_PAN_
      export CRIS_FILE_EXT=_MUSES_R1p17_FS_F0p4.nc
      export OUTFILE=TEMP_FILE.dat
      export TMP_OUTFILE=CRIS_PAN_${DATE}.dat
      rm -rf ${OUTFILE}
      rm -rf ${TMP_OUTFILE}
#
# SET OBS_WINDOW
      export BIN_BEG_YY=${ASIM_MN_YYYY}
      export BIN_BEG_MM=${ASIM_MN_MM}
      export BIN_BEG_DD=${ASIM_MN_DD}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_YY=${ASIM_MX_YYYY}
      export BIN_END_MM=${ASIM_MX_MM}
      export BIN_END_DD=${ASIM_MX_DD}
      export BIN_END_HH=${HHM_END}
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      export FLG=0
      if [[ ${ASIM_MX_HH} -eq 3 ]]; then
         export FLG=1 
         export BIN_BEG_YY=${ASIM_MX_YYYY}
         export BIN_BEG_MM=${ASIM_MX_MM}
         export BIN_BEG_DD=${ASIM_MX_DD}
         export BIN_BEG_HH=0
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
      fi
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
#
# SET CRIS INPUT DATA DIR
      export TMP_INFILE=\'${EXPERIMENT_CRIS_PAN_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${CRIS_FILE_PRE}\'
#
# COPY EXECUTABLE
      export FILE=cris_pan_total_col_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/CRIS_PAN/native_to_ascii/${FILE} ./.
      mcc -m cris_pan_total_col_extract.m -o cris_pan_total_col_extract
      ./run_cris_pan_total_col_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${CRIS_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat1.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
#
# END OF PREVIOUS DAY (hours 21 to 24 obs)
      if [[ ${FLG} -eq 1 ]]; then	 
         export BIN_BEG_YY=${ASIM_MIN_YYYY}
         export BIN_BEG_MM=${ASIM_MIN_MM}
         export BIN_BEG_DD=${ASIM_MIN_DD}
         export BIN_BEG_HH=${ASIM_MIN_HH}
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
         export BIN_END_YY=${ASIM_MIN_YYYY}
         export BIN_END_MM=${ASIM_MIN_MM}
         export BIN_END_DD=${ASIM_MIN_DD}
         export BIN_END_HH=23
         export BIN_END_MN=59
         export BIN_END_SS=59
         export TMP_INFILE=\'${EXPERIMENT_CRIS_PAN_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${CRIS_FILE_PRE}\'
#
# COPY EXECUTABLE
         export FILE=cris_pan_total_col_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/CRIS_PAN/native_to_ascii/${FILE} ./.
         mcc -m cris_pan_total_col_extract.m -o cris_pan_total_col_extract
         ./run_cris_pan_total_col_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${CRIS_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat2.html 2>&1
#
      fi
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
      if [[ ! -e ${TMP_OUTFILE} ]]; then
         touch NO_CRIS_PAN_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT CRIS PAN ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'${TMP_OUTFILE}\'
      export NL_FILEOUT=\'obs_seq_cris_pan_total_col_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_CRIS_PAN}
      export NL_USE_LOG_CO=${USE_LOG_CO_LOGIC}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_CH4=${USE_LOG_CH4_LOGIC}
      export NL_USE_LOG_NH3=${USE_LOG_NH3_LOGIC}
      export NL_USE_LOG_PAN=${USE_LOG_PAN_LOGIC}
#
# MODEL PROFILE SETTINGS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export NL_NZ_MODEL=${NNZP_CR}
#
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#      
# USE CRIS DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_cris_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/CRIS_PAN/work/cris_pan_total_col_ascii_to_obs ./.
      ./cris_pan_total_col_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ -s ${NL_FILEOUT} ]]; then
         touch NO_CRIS_PAN_${DATE}
      fi
   fi
#
########################################################################
#
# RUN CRIS PAN PROFILE OBSERVATIONS
#
########################################################################
#
   if ${RUN_CRIS_PAN_PROFILE_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/cris_pan_profile_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/cris_pan_profile_obs
         cd ${RUN_DIR}/${DATE}/cris_pan_profile_obs
      else
         cd ${RUN_DIR}/${DATE}/cris_pan_profile_obs
      fi
#
# SET CRIS PARAMETERS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export CRIS_FILE_PRE=TROPESS_CrIS-JPSS1_L2_Standard_PAN_
      export CRIS_FILE_EXT=_MUSES_R1p17_FS_F0p4.nc
      export OUTFILE=TEMP_FILE.dat
      export TMP_OUTFILE=CRIS_PAN_${DATE}.dat
      rm -rf ${OUTFILE}
      rm -rf ${TMP_OUTFILE}
#
# SET OBS_WINDOW
      export BIN_BEG_YY=${ASIM_MN_YYYY}
      export BIN_BEG_MM=${ASIM_MN_MM}
      export BIN_BEG_DD=${ASIM_MN_DD}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_YY=${ASIM_MX_YYYY}
      export BIN_END_MM=${ASIM_MX_MM}
      export BIN_END_DD=${ASIM_MX_DD}
      export BIN_END_HH=${HHM_END}
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      export FLG=0
      if [[ ${ASIM_MX_HH} -eq 3 ]]; then
         export FLG=1 
         export BIN_BEG_YY=${ASIM_MX_YYYY}
         export BIN_BEG_MM=${ASIM_MX_MM}
         export BIN_BEG_DD=${ASIM_MX_DD}
         export BIN_BEG_HH=0
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
      fi
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
#
# SET CRIS INPUT DATA DIR
      export TMP_INFILE=\'${EXPERIMENT_CRIS_PAN_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${CRIS_FILE_PRE}\'
#
# COPY EXECUTABLE
      export FILE=cris_pan_profile_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/CRIS_PAN/native_to_ascii/${FILE} ./.
      mcc -m cris_pan_profile_extract.m -o cris_pan_profile_extract
      ./run_cris_pan_profile_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${CRIS_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat1.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
#
# END OF PREVIOUS DAY (hours 21 to 24 obs)
      if [[ ${FLG} -eq 1 ]]; then	 
         export BIN_BEG_YY=${ASIM_MIN_YYYY}
         export BIN_BEG_MM=${ASIM_MIN_MM}
         export BIN_BEG_DD=${ASIM_MIN_DD}
         export BIN_BEG_HH=${ASIM_MIN_HH}
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
         export BIN_END_YY=${ASIM_MIN_YYYY}
         export BIN_END_MM=${ASIM_MIN_MM}
         export BIN_END_DD=${ASIM_MIN_DD}
         export BIN_END_HH=23
         export BIN_END_MN=59
         export BIN_END_SS=59
         export TMP_INFILE=\'${EXPERIMENT_CRIS_PAN_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${CRIS_FILE_PRE}\'
#
# COPY EXECUTABLE
         export FILE=cris_pan_profile_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/CRIS_PAN/native_to_ascii/${FILE} ./.
         mcc -m cris_pan_profile_extract.m -o cris_pan_profile_extract
         ./run_cris_pan_profile_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${CRIS_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat2.html 2>&1
#
      fi
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
      if [[ ! -e ${TMP_OUTFILE} ]]; then
         touch NO_CRIS_PAN_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT CRIS PAN ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'${TMP_OUTFILE}\'
      export NL_FILEOUT=\'obs_seq_cris_pan_profile_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_CRIS_PAN}
      export NL_USE_LOG_CO=${USE_LOG_CO_LOGIC}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_CH4=${USE_LOG_CH4_LOGIC}
      export NL_USE_LOG_NH3=${USE_LOG_NH3_LOGIC}
      export NL_USE_LOG_PAN=${USE_LOG_PAN_LOGIC}
#
# MODEL PROFILE SETTINGS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export NL_NZ_MODEL=${NNZP_CR}
#
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#      
# USE CRIS DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_cris_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/CRIS_PAN/work/cris_pan_profile_ascii_to_obs ./.
      ./cris_pan_profile_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ -s ${NL_FILEOUT} ]]; then
         touch NO_CRIS_PAN_${DATE}
      fi
   fi
#
########################################################################
#
# RUN CRIS PAN CPSR OBSERVATIONS
#
########################################################################
#
   if ${RUN_CRIS_PAN_CPSR_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/cris_pan_cpsr_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/cris_pan_cpsr_obs
         cd ${RUN_DIR}/${DATE}/cris_pan_cpsr_obs
      else
         cd ${RUN_DIR}/${DATE}/cris_pan_cpsr_obs
      fi
#
# SET CRIS PARAMETERS
      export NL_PATH_MODEL=${RUN_DIR}/${PAST_DATE}/ensemble_mean_output
      export NL_FILE_MODEL=wrfout_d${CR_DOMAIN}_${DATE}_mean
#      export NL_PATH_MODEL=${RUN_DIR}/${DATE}/ensemble_mean_input
#      export NL_FILE_MODEL=wrfinput_d${CR_DOMAIN}_mean

      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export CRIS_FILE_PRE=CRIS-Aura_L2-PAN-SO-Nadir_r00000
      export CRIS_FILE_EXT=_C01_F08_11.he5
      export OUTFILE=TEMP_FILE.dat
      export TMP_OUTFILE=CRIS_PAN_${DATE}.dat
      rm -rf ${OUTFILE}
      rm -rf ${TMP_OUTFILE}
#
# SET OBS_WINDOW
      export BIN_BEG_YY=${ASIM_MN_YYYY}
      export BIN_BEG_MM=${ASIM_MN_MM}
      export BIN_BEG_DD=${ASIM_MN_DD}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_YY=${ASIM_MX_YYYY}
      export BIN_END_MM=${ASIM_MX_MM}
      export BIN_END_DD=${ASIM_MX_DD}
      export BIN_END_HH=${HHM_END}
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      export FLG=0
      if [[ ${ASIM_MX_HH} -eq 3 ]]; then
         export FLG=1 
         export BIN_BEG_YY=${ASIM_MX_YYYY}
         export BIN_BEG_MM=${ASIM_MX_MM}
         export BIN_BEG_DD=${ASIM_MX_DD}
         export BIN_BEG_HH=0
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
      fi
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
#
# SET CRIS INPUT DATA DIR
      export TMP_INFILE=\'${EXPERIMENT_CRIS_PAN_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${CRIS_FILE_PRE}\'
#
# COPY EXECUTABLE
      export FILE=cris_pan_cpsr_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/CRIS_PAN/native_to_ascii/${FILE} ./.
      mcc -m cris_pan_cpsr_extract.m -o cris_pan_cpsr_extract
      ./run_cris_pan_cpsr_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${CRIS_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
#
# END OF PREVIOUS DAY (hours 21 to 24 obs)
      if [[ ${FLG} -eq 1 ]]; then	 
         export BIN_BEG_YY=${ASIM_MIN_YYYY}
         export BIN_BEG_MM=${ASIM_MIN_MM}
         export BIN_BEG_DD=${ASIM_MIN_DD}
         export BIN_BEG_HH=${ASIM_MIN_HH}
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
         export BIN_END_YY=${ASIM_MIN_YYYY}
         export BIN_END_MM=${ASIM_MIN_MM}
         export BIN_END_DD=${ASIM_MIN_DD}
         export BIN_END_HH=23
         export BIN_END_MN=59
         export BIN_END_SS=59
         export TMP_INFILE=\'${EXPERIMENT_CRIS_PAN_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${CRIS_FILE_PRE}\'
#
# COPY EXECUTABLE
         export FILE=cris_pan_cpsr_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/CRIS_PAN/native_to_ascii/${FILE} ./.
         mcc -m cris_pan_cpsr_extract.m -o cris_pan_cpsr_extract
         ./run_cris_pan_cpsr_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${CRIS_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat.html 2>&1
#
      fi
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
      if [[ ! -e ${TMP_OUTFILE} ]]; then
         touch NO_CRIS_PAN_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT CRIS PAN ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'${TMP_OUTFILE}\'
      export NL_FILEOUT=\'obs_seq_cris_pan_cpsr_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_CRIS_PAN}
      export NL_USE_LOG_CO=${USE_LOG_CO_LOGIC}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_CO2=${USE_LOG_CO2_LOGIC}
      export NL_USE_LOG_PAN=${USE_LOG_PAN_LOGIC}
      export NL_USE_LOG_NH3=${USE_LOG_NH3_LOGIC}
#
# MODEL CPSR SETTINGS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export NL_NZ_MODEL=${NNZP_CR}
#
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#      
# USE CRIS DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_cris_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/CRIS_PAN/work/cris_pan_cpsr_ascii_to_obs ./.
      ./cris_pan_cpsr_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ -s ${NL_FILEOUT} ]]; then
         touch NO_CRIS_PAN_${DATE}
      fi
   fi
#
########################################################################
#
# RUN SCIAM NO2 TOTAL COL OBSERVATIONS
#
########################################################################
#
   if ${RUN_SCIAM_NO2_TOTAL_COL_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/sciam_no2_total_col_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/sciam_no2_total_col_obs
         cd ${RUN_DIR}/${DATE}/sciam_no2_total_col_obs
      else
         cd ${RUN_DIR}/${DATE}/sciam_no2_total_col_obs
      fi
#
# SET SCIAM PARAMETERS
      export NL_PATH_MODEL=${RUN_DIR}/${PAST_DATE}/ensemble_mean_output
      export NL_FILE_MODEL=wrfout_d${CR_DOMAIN}_${DATE}_mean

      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export SCIAM_FILE_PRE=SCIAM_NO2_L2_V01_
      export SCIAM_FILE_EXT=.nc
      export OUTFILE=TEMP_FILE.dat
      export TMP_OUTFILE=SCIAM_NO2_${DATE}.dat
      rm -rf ${OUTFILE}
      rm -rf ${TMP_OUTFILE}
#
# SET OBS_WINDOW
      export BIN_BEG_YY=${ASIM_MN_YYYY}
      export BIN_BEG_MM=${ASIM_MN_MM}
      export BIN_BEG_DD=${ASIM_MN_DD}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_YY=${ASIM_MX_YYYY}
      export BIN_END_MM=${ASIM_MX_MM}
      export BIN_END_DD=${ASIM_MX_DD}
      export BIN_END_HH=${HHM_END}
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      export FLG=0
      if [[ ${ASIM_MX_HH} -eq 3 ]]; then
         export FLG=1 
         export BIN_BEG_YY=${ASIM_MX_YYYY}
         export BIN_BEG_MM=${ASIM_MX_MM}
         export BIN_BEG_DD=${ASIM_MX_DD}
         export BIN_BEG_HH=0
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
      fi
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
#
# SET SCIAM INPUT DATA DIR
      export TMP_INFILE=\'${EXPERIMENT_SCIAM_NO2_DIR}/${YYYY}${MM}/${DD}/${SCIAM_FILE_PRE}${YYYY}${MM}${DD}T\'
#
# COPY EXECUTABLE
      export FILE=sciam_no2_total_col_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/SCIAM_NO2/native_to_ascii/${FILE} ./.
      mcc -m sciam_no2_total_col_extract.m -o sciam_no2_total_col_extract
      ./run_sciam_no2_total_col_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${SCIAM_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat1.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
#
# END OF PREVIOUS DAY (hours 21 to 24 obs)
      if [[ ${FLG} -eq 1 ]]; then	 
         export BIN_BEG_YY=${ASIM_MIN_YYYY}
         export BIN_BEG_MM=${ASIM_MIN_MM}
         export BIN_BEG_DD=${ASIM_MIN_DD}
         export BIN_BEG_HH=${ASIM_MIN_HH}
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
         export BIN_END_YY=${ASIM_MIN_YYYY}
         export BIN_END_MM=${ASIM_MIN_MM}
         export BIN_END_DD=${ASIM_MIN_DD}
         export BIN_END_HH=23
         export BIN_END_MN=59
         export BIN_END_SS=59
         export TMP_INFILE=\'${EXPERIMENT_SCIAM_NO2_DIR}/${SCIAM_FILE_PRE}${ASIM_MN_YYYY}${ASIM_MN_MM}${ASIM_MN_DD}T\'
#
# COPY EXECUTABLE
         export FILE=sciam_no2_total_col_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/SCIAM_NO2/native_to_ascii/${FILE} ./.
         mcc -m sciam_no2_total_col_extract.m -o sciam_no2_total_col_extract
         ./run_sciam_no2_total_col_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${SCIAM_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat2.html 2>&1
#
      fi
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
      if [[ ! -e ${TMP_OUTFILE} ]]; then
         touch NO_SCIAM_NO2_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT SCIAM NO2 ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'${TMP_OUTFILE}\'
      export NL_FILEOUT=\'obs_seq_sciam_no2_total_col_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_SCIAM_NO2}
      export NL_USE_LOG_NO2=${USE_LOG_NO2_LOGIC}
#
# MODEL PROFILE SETTINGS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export NL_NZ_MODEL=${NNZP_CR}
#
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#      
# USE SCIAM DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_sciam_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/SCIAM_NO2/work/sciam_no2_total_col_ascii_to_obs ./.
      ./sciam_no2_total_col_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ -s ${NL_FILEOUT} ]]; then
         touch NO_Sciam_NO2_${DATE}
      fi
   fi
#
########################################################################
#
# RUN SCIAM NO2 TROP COL OBSERVATIONS
#
########################################################################
#
   if ${RUN_SCIAM_NO2_TROP_COL_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/sciam_no2_trop_col_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/sciam_no2_trop_col_obs
         cd ${RUN_DIR}/${DATE}/sciam_no2_trop_col_obs
      else
         cd ${RUN_DIR}/${DATE}/sciam_no2_trop_col_obs
      fi
#
# SET SCIAM PARAMETERS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export SCIAM_FILE_PRE=QA4ECV_L2_NO2_SCIA_
      export SCIAM_FILE_EXT=_fitC_v1.nc
      export OUTFILE=TEMP_FILE.dat
      export TMP_OUTFILE=SCIAM_NO2_${DATE}.dat
      rm -rf ${OUTFILE}
      rm -rf ${TMP_OUTFILE}
#
# SET OBS_WINDOW
      export BIN_BEG_YY=${ASIM_MN_YYYY}
      export BIN_BEG_MM=${ASIM_MN_MM}
      export BIN_BEG_DD=${ASIM_MN_DD}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_YY=${ASIM_MX_YYYY}
      export BIN_END_MM=${ASIM_MX_MM}
      export BIN_END_DD=${ASIM_MX_DD}
      export BIN_END_HH=${HHM_END}
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      export FLG=0
      if [[ ${ASIM_MX_HH} -eq 3 ]]; then
         export FLG=1 
         export BIN_BEG_YY=${ASIM_MX_YYYY}
         export BIN_BEG_MM=${ASIM_MX_MM}
         export BIN_BEG_DD=${ASIM_MX_DD}
         export BIN_BEG_HH=0
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
      fi
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
#
# SET SCIAM INPUT DATA DIR
      export INFILE=${EXPERIMENT_SCIAM_NO2_DIR}/${YYYY}${MM}${DD}/${SCIAM_FILE_PRE}
#
# COPY EXECUTABLE
      export FILE=sciam_no2_trop_col_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/SCIAM_NO2/native_to_ascii/${FILE} ./.
      mcc -m sciam_no2_trop_col_extract.m -o sciam_no2_trop_col_extract
      ./run_sciam_no2_trop_col_extract.sh ${MATLAB} ${INFILE} ${OUTFILE} ${SCIAM_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat1.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
#
# END OF PREVIOUS DAY (hours 21 to 24 obs)
      if [[ ${FLG} -eq 1 ]]; then	 
         export BIN_BEG_YY=${ASIM_MIN_YYYY}
         export BIN_BEG_MM=${ASIM_MIN_MM}
         export BIN_BEG_DD=${ASIM_MIN_DD}
         export BIN_BEG_HH=${ASIM_MIN_HH}
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
         export BIN_END_YY=${ASIM_MIN_YYYY}
         export BIN_END_MM=${ASIM_MIN_MM}
         export BIN_END_DD=${ASIM_MIN_DD}
         export BIN_END_HH=23
         export BIN_END_MN=59
         export BIN_END_SS=59
         export INFILE=${EXPERIMENT_SCIAM_NO2_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${SCIAM_FILE_PRE}
#
# COPY EXECUTABLE
         export FILE=sciam_no2_trop_col_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/SCIAM_NO2/native_to_ascii/${FILE} ./.
         mcc -m sciam_no2_trop_col_extract.m -o sciam_no2_trop_col_extract
         ./run_sciam_no2_trop_col_extract.sh ${MATLAB} ${INFILE} ${OUTFILE} ${SCIAM_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat2.html 2>&1
#
      fi
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
      if [[ ! -e ${TMP_OUTFILE} ]]; then
         touch NO_SCIAM_NO2_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT SCIAM NO2 ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'${TMP_OUTFILE}\'
      export NL_FILEOUT=\'obs_seq_sciam_no2_trop_col_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_SCIAM_NO2}
      export NL_USE_LOG_NO2=${USE_LOG_NO2_LOGIC}
#
# MODEL PROFILE SETTINGS
###      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
###      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
      export NL_PATH_MODEL=\'${RUN_DIR}/2014${PAST_MM}${PAST_DD}${PAST_HH}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_2014${MM}${DD}${HH}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export NL_NZ_MODEL=${NNZP_CR}
#
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#      
# USE SCIAM DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_sciam_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/SCIAM_NO2/work/sciam_no2_trop_col_ascii_to_obs ./.
      ./sciam_no2_trop_col_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ -s ${NL_FILEOUT} ]]; then
         touch NO_SCIAM_NO2_${DATE}
      fi
   fi
#
########################################################################
#
# RUN GOME2A NO2 TOTAL COL OBSERVATIONS
#
########################################################################
#
   if ${RUN_GOME2A_NO2_TOTAL_COL_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/gome2a_no2_total_col_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/gome2a_no2_total_col_obs
         cd ${RUN_DIR}/${DATE}/gome2a_no2_total_col_obs
      else
         cd ${RUN_DIR}/${DATE}/gome2a_no2_total_col_obs
      fi
#
# SET GOME2A PARAMETERS
      export NL_PATH_MODEL=${RUN_DIR}/${PAST_DATE}/ensemble_mean_output
      export NL_FILE_MODEL=wrfout_d${CR_DOMAIN}_${DATE}_mean

      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export GOME2A_FILE_PRE=GOME2A_NO2_L2_V01_
      export GOME2A_FILE_EXT=.nc
      export OUTFILE=TEMP_FILE.dat
      export TMP_OUTFILE=GOME2A_NO2_${DATE}.dat
      rm -rf ${OUTFILE}
      rm -rf ${TMP_OUTFILE}
#
# SET OBS_WINDOW
      export BIN_BEG_YY=${ASIM_MN_YYYY}
      export BIN_BEG_MM=${ASIM_MN_MM}
      export BIN_BEG_DD=${ASIM_MN_DD}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_YY=${ASIM_MX_YYYY}
      export BIN_END_MM=${ASIM_MX_MM}
      export BIN_END_DD=${ASIM_MX_DD}
      export BIN_END_HH=${HHM_END}
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      export FLG=0
      if [[ ${ASIM_MX_HH} -eq 3 ]]; then
         export FLG=1 
         export BIN_BEG_YY=${ASIM_MX_YYYY}
         export BIN_BEG_MM=${ASIM_MX_MM}
         export BIN_BEG_DD=${ASIM_MX_DD}
         export BIN_BEG_HH=0
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
      fi
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
#
# SET GOME2A INPUT DATA DIR
      export TMP_INFILE=\'${EXPERIMENT_GOME2A_NO2_DIR}/${YYYY}${MM}/${DD}/${GOME2A_FILE_PRE}${YYYY}${MM}${DD}T\'
#
# COPY EXECUTABLE
      export FILE=gome2a_no2_total_col_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/GOME2A_NO2/native_to_ascii/${FILE} ./.
      mcc -m gome2a_no2_total_col_extract.m -o gome2a_no2_total_col_extract
      ./run_gome2a_no2_total_col_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${GOME2A_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
#
# END OF PREVIOUS DAY (hours 21 to 24 obs)
      if [[ ${FLG} -eq 1 ]]; then	 
         export BIN_BEG_YY=${ASIM_MIN_YYYY}
         export BIN_BEG_MM=${ASIM_MIN_MM}
         export BIN_BEG_DD=${ASIM_MIN_DD}
         export BIN_BEG_HH=${ASIM_MIN_HH}
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
         export BIN_END_YY=${ASIM_MIN_YYYY}
         export BIN_END_MM=${ASIM_MIN_MM}
         export BIN_END_DD=${ASIM_MIN_DD}
         export BIN_END_HH=23
         export BIN_END_MN=59
         export BIN_END_SS=59
         export TMP_INFILE=\'${EXPERIMENT_GOME2A_NO2_DIR}/${GOME2A_FILE_PRE}${ASIM_MN_YYYY}${ASIM_MN_MM}${ASIM_MN_DD}T\'
#
# COPY EXECUTABLE
         export FILE=gome2a_no2_total_col_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/GOME2A_NO2/native_to_ascii/${FILE} ./.
         mcc -m gome2a_no2_total_col_extract.m -o gome2a_no2_total_col_extract
         ./run_gome2a_no2_total_col_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${GOME2A_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat.html 2>&1
#
      fi
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
      if [[ ! -e ${TMP_OUTFILE} ]]; then
         touch NO_GOME2A_NO2_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT GOME2A NO2 ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'${TMP_OUTFILE}\'
      export NL_FILEOUT=\'obs_seq_gome2a_no2_total_col_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_GOME2A_NO2}
      export NL_USE_LOG_NO2=${USE_LOG_NO2_LOGIC}
#
# MODEL PROFILE SETTINGS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export NL_NZ_MODEL=${NNZP_CR}
#
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#      
# USE GOME2A DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_gome2a_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/GOME2A_NO2/work/gome2a_no2_total_col_ascii_to_obs ./.
      ./gome2a_no2_total_col_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ -s ${NL_FILEOUT} ]]; then
         touch NO_GOME2a_NO2_${DATE}
      fi
   fi
#
########################################################################
#
# RUN GOME2A NO2 TROP COL OBSERVATIONS
#
########################################################################
#
   if ${RUN_GOME2A_NO2_TROP_COL_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/gome2a_no2_trop_col_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/gome2a_no2_trop_col_obs
         cd ${RUN_DIR}/${DATE}/gome2a_no2_trop_col_obs
      else
         cd ${RUN_DIR}/${DATE}/gome2a_no2_trop_col_obs
      fi
#
# SET GOME2A PARAMETERS
      export NL_PATH_MODEL=${RUN_DIR}/${PAST_DATE}/ensemble_mean_output
      export NL_FILE_MODEL=wrfout_d${CR_DOMAIN}_${DATE}_mean

      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export GOME2A_FILE_PRE=QA4ECV_L2_NO2_GOME2A_
      export GOME2A_FILE_EXT=_fitB_v1.nc
      export OUTFILE=TEMP_FILE.dat
      export TMP_OUTFILE=GOME2A_NO2_${DATE}.dat
      rm -rf ${OUTFILE}
      rm -rf ${TMP_OUTFILE}
#
# SET OBS_WINDOW
      export BIN_BEG_YY=${ASIM_MN_YYYY}
      export BIN_BEG_MM=${ASIM_MN_MM}
      export BIN_BEG_DD=${ASIM_MN_DD}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_YY=${ASIM_MX_YYYY}
      export BIN_END_MM=${ASIM_MX_MM}
      export BIN_END_DD=${ASIM_MX_DD}
      export BIN_END_HH=${HHM_END}
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      export FLG=0
      if [[ ${ASIM_MX_HH} -eq 3 ]]; then
         export FLG=1 
         export BIN_BEG_YY=${ASIM_MX_YYYY}
         export BIN_BEG_MM=${ASIM_MX_MM}
         export BIN_BEG_DD=${ASIM_MX_DD}
         export BIN_BEG_HH=0
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
      fi
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
#
# SET GOME2A INPUT DATA DIR
      export TMP_INFILE=\'${EXPERIMENT_GOME2A_NO2_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${GOME2A_FILE_PRE}\'
#
# COPY EXECUTABLE
      export FILE=gome2a_no2_trop_col_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/GOME2A_NO2/native_to_ascii/${FILE} ./.
      mcc -m gome2a_no2_trop_col_extract.m -o gome2a_no2_trop_col_extract
      ./run_gome2a_no2_trop_col_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${GOME2A_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat1.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
#
# END OF PREVIOUS DAY (hours 21 to 24 obs)
      if [[ ${FLG} -eq 1 ]]; then	 
         export BIN_BEG_YY=${ASIM_MIN_YYYY}
         export BIN_BEG_MM=${ASIM_MIN_MM}
         export BIN_BEG_DD=${ASIM_MIN_DD}
         export BIN_BEG_HH=${ASIM_MIN_HH}
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
         export BIN_END_YY=${ASIM_MIN_YYYY}
         export BIN_END_MM=${ASIM_MIN_MM}
         export BIN_END_DD=${ASIM_MIN_DD}
         export BIN_END_HH=23
         export BIN_END_MN=59
         export BIN_END_SS=59
         export TMP_INFILE=\'${EXPERIMENT_GOME2A_NO2_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${GOME2A_FILE_PRE}\'
#
# COPY EXECUTABLE
         export FILE=gome2a_no2_trop_col_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/GOME2A_NO2/native_to_ascii/${FILE} ./.
         mcc -m gome2a_no2_trop_col_extract.m -o gome2a_no2_trop_col_extract
         ./run_gome2a_no2_trop_col_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${GOME2A_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat2.html 2>&1
#
      fi
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
      if [[ ! -e ${TMP_OUTFILE} ]]; then
         touch NO_GOME2A_NO2_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT GOME2A NO2 ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'${TMP_OUTFILE}\'
      export NL_FILEOUT=\'obs_seq_gome2a_no2_trop_col_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_GOME2A_NO2}
      export NL_USE_LOG_NO2=${USE_LOG_NO2_LOGIC}
#
# MODEL PROFILE SETTINGS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export NL_NZ_MODEL=${NNZP_CR}
#
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#      
# USE GOME2A DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_gome2a_input_nml.ksh
#
# GET THINNING EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/GOME2A_NO2/work/gome2a_no2_trop_col_thinner ./.
      ./gome2a_no2_trop_col_thinner > index_thin.html 2>&1
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/GOME2A_NO2/work/gome2a_no2_trop_col_ascii_to_obs ./.
      ./gome2a_no2_trop_col_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ -s ${NL_FILEOUT} ]]; then
         touch NO_GOME2A_NO2_${DATE}
      fi
   fi
#
########################################################################
#
# RUN MLS O3 TOTAL COL OBSERVATIONS
#
########################################################################
#
   if ${RUN_MLS_O3_TOTAL_COL_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/mls_o3_total_col_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/mls_o3_total_col_obs
         cd ${RUN_DIR}/${DATE}/mls_o3_total_col_obs
      else
         cd ${RUN_DIR}/${DATE}/mls_o3_total_col_obs
      fi
#
# SET MLS PARAMETERS
      export NL_PATH_MODEL=${RUN_DIR}/${PAST_DATE}/ensemble_mean_output
      export NL_FILE_MODEL=wrfout_d${CR_DOMAIN}_${DATE}_mean

      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export MLS_FILE_PRE=QA4ECV_L2_O3_MLS_
      export MLS_FILE_EXT=_fitB_v1.nc
      export OUTFILE=TEMP_FILE.dat
      export TMP_OUTFILE=MLS_O3_${DATE}.dat
      rm -rf ${OUTFILE}
      rm -rf ${TMP_OUTFILE}
#
# SET OBS_WINDOW
      export BIN_BEG_YY=${ASIM_MN_YYYY}
      export BIN_BEG_MM=${ASIM_MN_MM}
      export BIN_BEG_DD=${ASIM_MN_DD}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_YY=${ASIM_MX_YYYY}
      export BIN_END_MM=${ASIM_MX_MM}
      export BIN_END_DD=${ASIM_MX_DD}
      export BIN_END_HH=${HHM_END}
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      export FLG=0
      if [[ ${ASIM_MX_HH} -eq 3 ]]; then
         export FLG=1 
         export BIN_BEG_YY=${ASIM_MX_YYYY}
         export BIN_BEG_MM=${ASIM_MX_MM}
         export BIN_BEG_DD=${ASIM_MX_DD}
         export BIN_BEG_HH=0
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
      fi
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
#
# SET MLS INPUT DATA DIR
      export TMP_INFILE=\'${EXPERIMENT_MLS_O3_DIR}/${YYYY}${MM}${DD}/${MLS_FILE_PRE}\'
#
# COPY EXECUTABLE
      export FILE=mls_o3_total_col_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/MLS_O3/native_to_ascii/${FILE} ./.
      mcc -m mls_o3_total_col_extract.m -o mls_o3_total_col_extract
      ./run_mls_o3_total_col_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${MLS_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
#
# END OF PREVIOUS DAY (hours 21 to 24 obs)
      if [[ ${FLG} -eq 1 ]]; then	 
         export BIN_BEG_YY=${ASIM_MIN_YYYY}
         export BIN_BEG_MM=${ASIM_MIN_MM}
         export BIN_BEG_DD=${ASIM_MIN_DD}
         export BIN_BEG_HH=${ASIM_MIN_HH}
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
         export BIN_END_YY=${ASIM_MIN_YYYY}
         export BIN_END_MM=${ASIM_MIN_MM}
         export BIN_END_DD=${ASIM_MIN_DD}
         export BIN_END_HH=23
         export BIN_END_MN=59
         export BIN_END_SS=59
         export TMP_INFILE=\'${EXPERIMENT_MLS_O3_DIR}/${YYYY}${MM}${DD}/${MLS_FILE_PRE}\'
#
# COPY EXECUTABLE
         export FILE=mls_o3_total_col_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/MLS_O3/native_to_ascii/${FILE} ./.
         mcc -m mls_o3_total_col_extract.m -o mls_o3_total_col_extract
         ./run_mls_o3_total_col_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${MLS_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat.html 2>&1
#
      fi
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
      if [[ ! -e ${TMP_OUTFILE} ]]; then
         touch NO_MLS_O3_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT MLS O3 ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'${TMP_OUTFILE}\'
      export NL_FILEOUT=\'obs_seq_mls_o3_total_col_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_MLS_O3}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
#
# MODEL PROFILE SETTINGS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export NL_NZ_MODEL=${NNZP_CR}
#
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#      
# USE MLS DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_mls_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/MLS_O3/work/mls_o3_total_col_ascii_to_obs ./.
      ./mls_o3_total_col_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ -s ${NL_FILEOUT} ]]; then
         touch NO_MLS_O3_${DATE}
      fi
   fi
#
########################################################################
#
# RUN MLS O3 PROFILE COL OBSERVATIONS
#
########################################################################
#
   if ${RUN_MLS_O3_PROFILE_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/mls_o3_profile_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/mls_o3_profile_obs
         cd ${RUN_DIR}/${DATE}/mls_o3_profile_obs
      else
         cd ${RUN_DIR}/${DATE}/mls_o3_profile_obs
      fi
#
# SET MLS PARAMETERS
      export NL_PATH_MODEL=${RUN_DIR}/${PAST_DATE}/ensemble_mean_output
      export NL_FILE_MODEL=wrfout_d${CR_DOMAIN}_${DATE}_mean

      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export MLS_FILE_PRE=MLS-Aura_L2GP-O3_v04-20-c01_
      export MLS_FILE_EXT=.hdr
      export OUTFILE=TEMP_FILE.dat
      export TMP_OUTFILE=MLS_O3_${DATE}.dat
      rm -rf ${OUTFILE}
      rm -rf ${TMP_OUTFILE}
#
# SET OBS_WINDOW
      export BIN_BEG_YY=${ASIM_MN_YYYY}
      export BIN_BEG_MM=${ASIM_MN_MM}
      export BIN_BEG_DD=${ASIM_MN_DD}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_YY=${ASIM_MX_YYYY}
      export BIN_END_MM=${ASIM_MX_MM}
      export BIN_END_DD=${ASIM_MX_DD}
      export BIN_END_HH=${HHM_END}
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      export FLG=0
      if [[ ${ASIM_MX_HH} -eq 3 ]]; then
         export FLG=1 
         export BIN_BEG_YY=${ASIM_MX_YYYY}
         export BIN_BEG_MM=${ASIM_MX_MM}
         export BIN_BEG_DD=${ASIM_MX_DD}
         export BIN_BEG_HH=0
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
      fi
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
#
# SET MLS INPUT DATA DIR
      export TMP_INFILE=\'${EXPERIMENT_MLS_O3_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${MLS_FILE_PRE}\'
#
# COPY EXECUTABLE
      export FILE=mls_o3_profile_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/MLS_O3/native_to_ascii/${FILE} ./.
      mcc -m mls_o3_profile_extract.m -o mls_o3_profile_extract
      ./run_mls_o3_profile_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${MLS_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat1.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
#
# END OF PREVIOUS DAY (hours 21 to 24 obs)
      if [[ ${FLG} -eq 1 ]]; then	 
         export BIN_BEG_YY=${ASIM_MIN_YYYY}
         export BIN_BEG_MM=${ASIM_MIN_MM}
         export BIN_BEG_DD=${ASIM_MIN_DD}
         export BIN_BEG_HH=${ASIM_MIN_HH}
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
         export BIN_END_YY=${ASIM_MIN_YYYY}
         export BIN_END_MM=${ASIM_MIN_MM}
         export BIN_END_DD=${ASIM_MIN_DD}
         export BIN_END_HH=23
         export BIN_END_MN=59
         export BIN_END_SS=59
         export TMP_INFILE=\'${EXPERIMENT_MLS_O3_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${MLS_FILE_PRE}\'
#
# COPY EXECUTABLE
         export FILE=mls_o3_profile_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/MLS_O3/native_to_ascii/${FILE} ./.
         mcc -m mls_o3_profile_extract.m -o mls_o3_profile_extract
         ./run_mls_o3_profile_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${MLS_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat2.html 2>&1
#
      fi
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
      if [[ ! -e ${TMP_OUTFILE} ]]; then
         touch NO_MLS_O3_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT MLS O3 ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'${TMP_OUTFILE}\'
      export NL_FILEOUT=\'obs_seq_mls_o3_profile_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_MLS_O3}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_HNO3=${USE_LOG_HNO3_LOGIC}
#
# MODEL PROFILE SETTINGS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export NL_NZ_MODEL=${NNZP_CR}
#
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#      
# USE MLS DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_mls_input_nml.ksh
#
# GET THINNING EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/MLS_O3/work/mls_o3_profile_thinner ./.
      ./mls_o3_profile_thinner > index_thin.html 2>&1
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/MLS_O3/work/mls_o3_profile_ascii_to_obs ./.
      ./mls_o3_profile_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ -s ${NL_FILEOUT} ]]; then
         touch NO_MLS_O3_${DATE}
      fi
   fi
#
########################################################################
#
# RUN MLS O3 CPSR COL OBSERVATIONS
#
########################################################################
#
   if ${RUN_MLS_O3_CPSR_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/mls_o3_cpsr_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/mls_o3_cpsr_obs
         cd ${RUN_DIR}/${DATE}/mls_o3_cpsr_obs
      else
         cd ${RUN_DIR}/${DATE}/mls_o3_cpsr_obs
      fi
#
# SET MLS PARAMETERS
      export NL_PATH_MODEL=${RUN_DIR}/${PAST_DATE}/ensemble_mean_output
      export NL_FILE_MODEL=wrfout_d${CR_DOMAIN}_${DATE}_mean

      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export MLS_FILE_PRE=MLS-Aura_L2GP-O3_v04-20-c01_
      export MLS_FILE_EXT=.hdr
      export OUTFILE=TEMP_FILE.dat
      export TMP_OUTFILE=MLS_O3_${DATE}.dat
      rm -rf ${OUTFILE}
      rm -rf ${TMP_OUTFILE}
#
# SET OBS_WINDOW
      export BIN_BEG_YY=${ASIM_MN_YYYY}
      export BIN_BEG_MM=${ASIM_MN_MM}
      export BIN_BEG_DD=${ASIM_MN_DD}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_YY=${ASIM_MX_YYYY}
      export BIN_END_MM=${ASIM_MX_MM}
      export BIN_END_DD=${ASIM_MX_DD}
      export BIN_END_HH=${HHM_END}
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      export FLG=0
      if [[ ${ASIM_MX_HH} -eq 3 ]]; then
         export FLG=1 
         export BIN_BEG_YY=${ASIM_MX_YYYY}
         export BIN_BEG_MM=${ASIM_MX_MM}
         export BIN_BEG_DD=${ASIM_MX_DD}
         export BIN_BEG_HH=0
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
      fi
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
#
# SET MLS INPUT DATA DIR
      export TMP_INFILE=\'${EXPERIMENT_MLS_O3_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${MLS_FILE_PRE}\'
#
# COPY EXECUTABLE
      export FILE=mls_o3_cpsr_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/MLS_O3/native_to_ascii/${FILE} ./.
      mcc -m mls_o3_cpsr_extract.m -o mls_o3_cpsr_extract
      ./run_mls_o3_cpsr_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${MLS_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat1.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
#
# END OF PREVIOUS DAY (hours 21 to 24 obs)
      if [[ ${FLG} -eq 1 ]]; then	 
         export BIN_BEG_YY=${ASIM_MIN_YYYY}
         export BIN_BEG_MM=${ASIM_MIN_MM}
         export BIN_BEG_DD=${ASIM_MIN_DD}
         export BIN_BEG_HH=${ASIM_MIN_HH}
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
         export BIN_END_YY=${ASIM_MIN_YYYY}
         export BIN_END_MM=${ASIM_MIN_MM}
         export BIN_END_DD=${ASIM_MIN_DD}
         export BIN_END_HH=23
         export BIN_END_MN=59
         export BIN_END_SS=59
         export TMP_INFILE=\'${EXPERIMENT_MLS_O3_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${MLS_FILE_PRE}\'
#
# COPY EXECUTABLE
         export FILE=mls_o3_cpsr_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/MLS_O3/native_to_ascii/${FILE} ./.
         mcc -m mls_o3_cpsr_extract.m -o mls_o3_cpsr_extract
         ./run_mls_o3_cpsr_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${MLS_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat2.html 2>&1
#
      fi
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
      if [[ ! -e ${TMP_OUTFILE} ]]; then
         touch NO_MLS_O3_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT MLS O3 ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'${TMP_OUTFILE}\'
      export NL_FILEOUT=\'obs_seq_mls_o3_cpsr_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_MLS_O3}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_HNO3=${USE_LOG_HNO3_LOGIC}
#
# MODEL PROFILE SETTINGS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export NL_NZ_MODEL=${NNZP_CR}
#
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#      
# USE MLS DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_mls_input_nml.ksh
#
# GET THINNING EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/MLS_O3/work/mls_o3_cpsr_thinner ./.
      ./mls_o3_cpsr_thinner > index_thin.html 2>&1
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/MLS_O3/work/mls_o3_cpsr_ascii_to_obs ./.
      ./mls_o3_cpsr_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ -s ${NL_FILEOUT} ]]; then
         touch NO_MLS_O3_${DATE}
      fi
   fi
#
########################################################################
#
# RUN MLS HNO3 TOTAL COL OBSERVATIONS
#
########################################################################
#
   if ${RUN_MLS_HNO3_TOTAL_COL_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/mls_hno3_total_col_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/mls_hno3_total_col_obs
         cd ${RUN_DIR}/${DATE}/mls_hno3_total_col_obs
      else
         cd ${RUN_DIR}/${DATE}/mls_hno3_total_col_obs
      fi
#
# SET MLS PARAMETERS
      export NL_PATH_MODEL=${RUN_DIR}/${PAST_DATE}/ensemble_mean_output
      export NL_FILE_MODEL=wrfout_d${CR_DOMAIN}_${DATE}_mean

      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export MLS_FILE_PRE=QA4ECV_L2_HNO3_MLS_
      export MLS_FILE_EXT=_fitB_v1.nc
      export OUTFILE=TEMP_FILE.dat
      export TMP_OUTFILE=MLS_HNO3_${DATE}.dat
      rm -rf ${OUTFILE}
      rm -rf ${TMP_OUTFILE}
#
# SET OBS_WINDOW
      export BIN_BEG_YY=${ASIM_MN_YYYY}
      export BIN_BEG_MM=${ASIM_MN_MM}
      export BIN_BEG_DD=${ASIM_MN_DD}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_YY=${ASIM_MX_YYYY}
      export BIN_END_MM=${ASIM_MX_MM}
      export BIN_END_DD=${ASIM_MX_DD}
      export BIN_END_HH=${HHM_END}
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      export FLG=0
      if [[ ${ASIM_MX_HH} -eq 3 ]]; then
         export FLG=1 
         export BIN_BEG_YY=${ASIM_MX_YYYY}
         export BIN_BEG_MM=${ASIM_MX_MM}
         export BIN_BEG_DD=${ASIM_MX_DD}
         export BIN_BEG_HH=0
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
      fi
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
#
# SET MLS INPUT DATA DIR
      export TMP_INFILE=\'${EXPERIMENT_MLS_HNO3_DIR}/${YYYY}${MM}${DD}/${MLS_FILE_PRE}\'
#
# COPY EXECUTABLE
      export FILE=mls_hno3_total_col_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/MLS_HNO3/native_to_ascii/${FILE} ./.
      mcc -m mls_hno3_total_col_extract.m -o mls_hno3_total_col_extract
      ./run_mls_hno3_total_col_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${MLS_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
#
# END OF PREVIOUS DAY (hours 21 to 24 obs)
      if [[ ${FLG} -eq 1 ]]; then	 
         export BIN_BEG_YY=${ASIM_MIN_YYYY}
         export BIN_BEG_MM=${ASIM_MIN_MM}
         export BIN_BEG_DD=${ASIM_MIN_DD}
         export BIN_BEG_HH=${ASIM_MIN_HH}
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
         export BIN_END_YY=${ASIM_MIN_YYYY}
         export BIN_END_MM=${ASIM_MIN_MM}
         export BIN_END_DD=${ASIM_MIN_DD}
         export BIN_END_HH=23
         export BIN_END_MN=59
         export BIN_END_SS=59
         export TMP_INFILE=\'${EXPERIMENT_MLS_HNO3_DIR}/${YYYY}${MM}${DD}/${MLS_FILE_PRE}\'
#
# COPY EXECUTABLE
         export FILE=mls_hno3_total_col_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/MLS_HNO3/native_to_ascii/${FILE} ./.
         mcc -m mls_hno3_total_col_extract.m -o mls_hno3_total_col_extract
         ./run_mls_hno3_total_col_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${MLS_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat.html 2>&1
#
      fi
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
      if [[ ! -e ${TMP_OUTFILE} ]]; then
         touch NO_MLS_HNO3_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT MLS HNO3 ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'${TMP_OUTFILE}\'
      export NL_FILEOUT=\'obs_seq_mls_hno3_total_col_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_MLS_HNO3}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_HNO3=${USE_LOG_HNO3_LOGIC}
#
# MODEL PROFILE SETTINGS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export NL_NZ_MODEL=${NNZP_CR}
#
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#      
# USE MLS DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_mls_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/MLS_HNO3/work/mls_hno3_total_col_ascii_to_obs ./.
      ./mls_hno3_total_col_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ -s ${NL_FILEOUT} ]]; then
         touch NO_MLS_HNO3_${DATE}
      fi
   fi
#
########################################################################
#
# RUN MLS HNO3 PROFILE COL OBSERVATIONS
#
########################################################################
#
   if ${RUN_MLS_HNO3_PROFILE_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/mls_hno3_profile_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/mls_hno3_profile_obs
         cd ${RUN_DIR}/${DATE}/mls_hno3_profile_obs
      else
         cd ${RUN_DIR}/${DATE}/mls_hno3_profile_obs
      fi
#
# SET MLS PARAMETERS
      export NL_PATH_MODEL=${RUN_DIR}/${PAST_DATE}/ensemble_mean_output
      export NL_FILE_MODEL=wrfout_d${CR_DOMAIN}_${DATE}_mean
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export MLS_FILE_PRE=MLS-Aura_L2GP-HNO3_v04-20-c01_
      export MLS_FILE_EXT=.he5
      export OUTFILE=TEMP_FILE.dat
      export TMP_OUTFILE=MLS_HNO3_${DATE}.dat
      rm -rf ${OUTFILE}
      rm -rf ${TMP_OUTFILE}
#
# SET OBS_WINDOW
      export BIN_BEG_YY=${ASIM_MN_YYYY}
      export BIN_BEG_MM=${ASIM_MN_MM}
      export BIN_BEG_DD=${ASIM_MN_DD}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_YY=${ASIM_MX_YYYY}
      export BIN_END_MM=${ASIM_MX_MM}
      export BIN_END_DD=${ASIM_MX_DD}
      export BIN_END_HH=${HHM_END}
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      export FLG=0
      if [[ ${ASIM_MX_HH} -eq 3 ]]; then
         export FLG=1 
         export BIN_BEG_YY=${ASIM_MX_YYYY}
         export BIN_BEG_MM=${ASIM_MX_MM}
         export BIN_BEG_DD=${ASIM_MX_DD}
         export BIN_BEG_HH=0
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
      fi
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
#
# SET MLS INPUT DATA DIR
      export TMP_INFILE=\'${EXPERIMENT_MLS_HNO3_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${MLS_FILE_PRE}\'
#
# COPY EXECUTABLE
      export FILE=mls_hno3_profile_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/MLS_HNO3/native_to_ascii/${FILE} ./.
      mcc -m mls_hno3_profile_extract.m -o mls_hno3_profile_extract
      ./run_mls_hno3_profile_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${MLS_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} >> index_mat1.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
#
# END OF PREVIOUS DAY (hours 21 to 24 obs)
      if [[ ${FLG} -eq 1 ]]; then	 
         export BIN_BEG_YY=${ASIM_MIN_YYYY}
         export BIN_BEG_MM=${ASIM_MIN_MM}
         export BIN_BEG_DD=${ASIM_MIN_DD}
         export BIN_BEG_HH=${ASIM_MIN_HH}
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
         export BIN_END_YY=${ASIM_MIN_YYYY}
         export BIN_END_MM=${ASIM_MIN_MM}
         export BIN_END_DD=${ASIM_MIN_DD}
         export BIN_END_HH=23
         export BIN_END_MN=59
         export BIN_END_SS=59
         export TMP_INFILE=\'${EXPERIMENT_MLS_HNO3_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${MLS_FILE_PRE}\'
#
# COPY EXECUTABLE
         export FILE=mls_hno3_profile_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/MLS_HNO3/native_to_ascii/${FILE} ./.
         mcc -m mls_hno3_profile_extract.m -o mls_hno3_profile_extract
         ./run_mls_hno3_profile_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${MLS_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat2.html 2>&1
#
      fi
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
      if [[ ! -e ${TMP_OUTFILE} ]]; then
         touch NO_MLS_HNO3_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT MLS HNO3 ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'${TMP_OUTFILE}\'
      export NL_FILEOUT=\'obs_seq_mls_hno3_profile_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_MLS_HNO3}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_HNO3=${USE_LOG_HNO3_LOGIC}
#
# MODEL PROFILE SETTINGS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export NL_NZ_MODEL=${NNZP_CR}
#
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#      
# USE MLS DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_mls_input_nml.ksh
#
# GET THINNING EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/MLS_HNO3/work/mls_hno3_profile_thinner ./.
      ./mls_hno3_profile_thinner > index_thin.html 2>&1
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/MLS_HNO3/work/mls_hno3_profile_ascii_to_obs ./.
      ./mls_hno3_profile_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ -s ${NL_FILEOUT} ]]; then
         touch NO_MLS_HNO3_${DATE}
      fi
   fi
#
########################################################################
#
# RUN MLS HNO3 CPSR COL OBSERVATIONS
#
########################################################################
#
   if ${RUN_MLS_HNO3_CPSR_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/mls_hno3_cpsr_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/mls_hno3_cpsr_obs
         cd ${RUN_DIR}/${DATE}/mls_hno3_cpsr_obs
      else
         cd ${RUN_DIR}/${DATE}/mls_hno3_cpsr_obs
      fi
#
# SET MLS PARAMETERS
      export NL_PATH_MODEL=${RUN_DIR}/${PAST_DATE}/ensemble_mean_output
      export NL_FILE_MODEL=wrfout_d${CR_DOMAIN}_${DATE}_mean
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export MLS_FILE_PRE=MLS-Aura_L2GP-HNO3_v04-20-c01_
      export MLS_FILE_EXT=.he5
      export OUTFILE=TEMP_FILE.dat
      export TMP_OUTFILE=MLS_HNO3_${DATE}.dat
      rm -rf ${OUTFILE}
      rm -rf ${TMP_OUTFILE}
#
# SET OBS_WINDOW
      export BIN_BEG_YY=${ASIM_MN_YYYY}
      export BIN_BEG_MM=${ASIM_MN_MM}
      export BIN_BEG_DD=${ASIM_MN_DD}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_YY=${ASIM_MX_YYYY}
      export BIN_END_MM=${ASIM_MX_MM}
      export BIN_END_DD=${ASIM_MX_DD}
      export BIN_END_HH=${HHM_END}
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      export FLG=0
      if [[ ${ASIM_MX_HH} -eq 3 ]]; then
         export FLG=1 
         export BIN_BEG_YY=${ASIM_MX_YYYY}
         export BIN_BEG_MM=${ASIM_MX_MM}
         export BIN_BEG_DD=${ASIM_MX_DD}
         export BIN_BEG_HH=0
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
      fi
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
#
# SET MLS INPUT DATA DIR
      export TMP_INFILE=\'${EXPERIMENT_MLS_HNO3_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${MLS_FILE_PRE}\'
#
# COPY EXECUTABLE
      export FILE=mls_hno3_cpsr_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/MLS_HNO3/native_to_ascii/${FILE} ./.
      mcc -m mls_hno3_cpsr_extract.m -o mls_hno3_cpsr_extract
      ./run_mls_hno3_cpsr_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${MLS_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} >> index_mat1.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
#
# END OF PREVIOUS DAY (hours 21 to 24 obs)
      if [[ ${FLG} -eq 1 ]]; then	 
         export BIN_BEG_YY=${ASIM_MIN_YYYY}
         export BIN_BEG_MM=${ASIM_MIN_MM}
         export BIN_BEG_DD=${ASIM_MIN_DD}
         export BIN_BEG_HH=${ASIM_MIN_HH}
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
         export BIN_END_YY=${ASIM_MIN_YYYY}
         export BIN_END_MM=${ASIM_MIN_MM}
         export BIN_END_DD=${ASIM_MIN_DD}
         export BIN_END_HH=23
         export BIN_END_MN=59
         export BIN_END_SS=59
         export TMP_INFILE=\'${EXPERIMENT_MLS_HNO3_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${MLS_FILE_PRE}\'
#
# COPY EXECUTABLE
         export FILE=mls_hno3_cpsr_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/MLS_HNO3/native_to_ascii/${FILE} ./.
         mcc -m mls_hno3_cpsr_extract.m -o mls_hno3_cpsr_extract
         ./run_mls_hno3_cpsr_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${MLS_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat2.html 2>&1
#
      fi
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
      if [[ ! -e ${TMP_OUTFILE} ]]; then
         touch NO_MLS_HNO3_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT MLS HNO3 ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'${TMP_OUTFILE}\'
      export NL_FILEOUT=\'obs_seq_mls_hno3_cpsr_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_MLS_HNO3}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_HNO3=${USE_LOG_HNO3_LOGIC}
#
# MODEL PROFILE SETTINGS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export NL_NZ_MODEL=${NNZP_CR}
#
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#      
# USE MLS DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_mls_input_nml.ksh
#
# GET THINNING EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/MLS_HNO3/work/mls_hno3_cpsr_thinner ./.
      ./mls_hno3_cpsr_thinner > index_thin.html 2>&1
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/MLS_HNO3/work/mls_hno3_cpsr_ascii_to_obs ./.
      ./mls_hno3_cpsr_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ -s ${NL_FILEOUT} ]]; then
         touch NO_MLS_HNO3_${DATE}
      fi
   fi
#
########################################################################
#
# RUN OMI NO2 DOMINO TOTAL COL OBSERVATIONS
#
########################################################################
#
   if ${RUN_OMI_NO2_DOMINO_TOTAL_COL_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/omi_no2_domino_total_col_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/omi_no2_domino_total_col_obs
         cd ${RUN_DIR}/${DATE}/omi_no2_domino_total_col_obs
      else
         cd ${RUN_DIR}/${DATE}/omi_no2_domino_total_col_obs
      fi
#
# SET OMI PARAMETERS
      export NL_PATH_MODEL=${RUN_DIR}/${PAST_DATE}/ensemble_mean_output
      export NL_FILE_MODEL=wrfout_d${CR_DOMAIN}_${DATE}_mean

      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export OMI_FILE_PRE=QA4ECV_L2_NO2_OMI_
      export OMI_FILE_EXT=_fitB_v1.nc
      export OUTFILE=TEMP_FILE.dat
      export TMP_OUTFILE=OMI_NO2_DOMINO_${DATE}.dat
      rm -rf ${OUTFILE}
      rm -rf ${TMP_OUTFILE}
#
# SET OBS_WINDOW
      export BIN_BEG_YY=${ASIM_MN_YYYY}
      export BIN_BEG_MM=${ASIM_MN_MM}
      export BIN_BEG_DD=${ASIM_MN_DD}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_YY=${ASIM_MX_YYYY}
      export BIN_END_MM=${ASIM_MX_MM}
      export BIN_END_DD=${ASIM_MX_DD}
      export BIN_END_HH=${HHM_END}
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      export FLG=0
      if [[ ${ASIM_MX_HH} -eq 3 ]]; then
         export FLG=1 
         export BIN_BEG_YY=${ASIM_MX_YYYY}
         export BIN_BEG_MM=${ASIM_MX_MM}
         export BIN_BEG_DD=${ASIM_MX_DD}
         export BIN_BEG_HH=0
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
      fi
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
#
# SET OMI INPUT DATA DIR
      export TMP_INFILE=\'${EXPERIMENT_OMI_NO2_DOMINO_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${OMI_FILE_PRE}\'
#
# COPY EXECUTABLE
      export FILE=omi_no2_domino_total_col_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/OMI_NO2_DOMINO/native_to_ascii/${FILE} ./.
      mcc -m omi_no2_domino_total_col_extract.m -o omi_no2_domino_total_col_extract
      ./run_omi_no2_domino_total_col_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${OMI_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat1.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
#
# END OF PREVIOUS DAY (hours 21 to 24 obs)
      if [[ ${FLG} -eq 1 ]]; then	 
         export BIN_BEG_YY=${ASIM_MIN_YYYY}
         export BIN_BEG_MM=${ASIM_MIN_MM}
         export BIN_BEG_DD=${ASIM_MIN_DD}
         export BIN_BEG_HH=${ASIM_MIN_HH}
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
         export BIN_END_YY=${ASIM_MIN_YYYY}
         export BIN_END_MM=${ASIM_MIN_MM}
         export BIN_END_DD=${ASIM_MIN_DD}
         export BIN_END_HH=23
         export BIN_END_MN=59
         export BIN_END_SS=59
         export TMP_INFILE=\'${EXPERIMENT_OMI_NO2_DOMINO_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${OMI_FILE_PRE}\'
#
# COPY EXECUTABLE
         export FILE=omi_no2_domino_total_col_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/OMI_NO2_DOMINO/native_to_ascii/${FILE} ./.
         mcc -m omi_no2_domino_total_col_extract.m -o omi_no2_domino_total_col_extract
         ./run_omi_no2_domino_total_col_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${OMI_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat2.html 2>&1
#
      fi
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
      if [[ ! -e ${TMP_OUTFILE} ]]; then
         touch NO_OMI_NO2_DOMINO_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT OMI NO2 ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'${TMP_OUTFILE}\'
      export NL_FILEOUT=\'obs_seq_omi_no2_domino_total_col_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_OMI_NO2_DOMINO}
      export NL_USE_LOG_NO2=${USE_LOG_NO2_LOGIC}
#
# MODEL PROFILE SETTINGS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export NL_NZ_MODEL=${NNZP_CR}
#
      export NL_YEAR=${D_YYYY}
      export NL_MONTH=${D_MM}
      export NL_DAY=${D_DD}
      export NL_HOUR=${D_HH}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#      
# USE OMI DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_omi_input_nml.ksh
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/OMI_NO2/work/omi_no2_domino_total_col_ascii_to_obs ./.
      ./omi_no2_domino_total_col_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ -s ${NL_FILEOUT} ]]; then
         touch NO_OMI_NO2_DOMINO_${DATE}
      fi
   fi
#
########################################################################
#
# RUN OMI NO2 DOMINO TROP COL OBSERVATIONS
#
########################################################################
#
   if ${RUN_OMI_NO2_DOMINO_TROP_COL_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/omi_no2_domino_trop_col_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/omi_no2_domino_trop_col_obs
         cd ${RUN_DIR}/${DATE}/omi_no2_domino_trop_col_obs
      else
         cd ${RUN_DIR}/${DATE}/omi_no2_domino_trop_col_obs
      fi
#
# SET OMI PARAMETERS
      export NL_PATH_MODEL=${RUN_DIR}/${PAST_DATE}/ensemble_mean_output
      export NL_FILE_MODEL=wrfout_d${CR_DOMAIN}_${DATE}_mean

      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export OMI_FILE_PRE=QA4ECV_L2_NO2_OMI_
      export OMI_FILE_EXT=_fitB_v1.nc
      export OUTFILE=TEMP_FILE.dat
      export TMP_OUTFILE=OMI_NO2_DOMINO_${DATE}.dat
      rm -rf ${OUTFILE}
      rm -rf ${TMP_OUTFILE}
#
# SET OBS_WINDOW
      export BIN_BEG_YY=${ASIM_MN_YYYY}
      export BIN_BEG_MM=${ASIM_MN_MM}
      export BIN_BEG_DD=${ASIM_MN_DD}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_YY=${ASIM_MX_YYYY}
      export BIN_END_MM=${ASIM_MX_MM}
      export BIN_END_DD=${ASIM_MX_DD}
      export BIN_END_HH=${HHM_END}
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      export FLG=0
      if [[ ${ASIM_MX_HH} -eq 3 ]]; then
         export FLG=1 
         export BIN_BEG_YY=${ASIM_MX_YYYY}
         export BIN_BEG_MM=${ASIM_MX_MM}
         export BIN_BEG_DD=${ASIM_MX_DD}
         export BIN_BEG_HH=0
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
      fi
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
#
# SET OMI INPUT DATA DIR
      export TMP_INFILE=\'${EXPERIMENT_OMI_NO2_DOMINO_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${OMI_FILE_PRE}\'
#
# COPY EXECUTABLE
      export FILE=omi_no2_domino_trop_col_extract.m
      rm -rf ${FILE}
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/OMI_NO2/native_to_ascii/${FILE} ./.
      mcc -m omi_no2_domino_trop_col_extract.m -o omi_no2_domino_trop_col_extract
      ./run_omi_no2_domino_trop_col_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${OMI_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat1.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
#
# END OF PREVIOUS DAY (hours 21 to 24 obs)
      if [[ ${FLG} -eq 1 ]]; then	 
         export BIN_BEG_YY=${ASIM_MIN_YYYY}
         export BIN_BEG_MM=${ASIM_MIN_MM}
         export BIN_BEG_DD=${ASIM_MIN_DD}
         export BIN_BEG_HH=${ASIM_MIN_HH}
         export BIN_BEG_MN=0
         export BIN_BEG_SS=0
         export BIN_END_YY=${ASIM_MIN_YYYY}
         export BIN_END_MM=${ASIM_MIN_MM}
         export BIN_END_DD=${ASIM_MIN_DD}
         export BIN_END_HH=23
         export BIN_END_MN=59
         export BIN_END_SS=59
         export TMP_INFILE=\'${EXPERIMENT_OMI_NO2_DOMINO_DIR}/${BIN_BEG_YY}${BIN_BEG_MM}${BIN_BEG_DD}/${OMI_FILE_PRE}\'
#
# COPY EXECUTABLE
         export FILE=omi_no2_domino_trop_col_extract.m
         rm -rf ${FILE}
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/OMI_NO2/native_to_ascii/${FILE} ./.
         mcc -m omi_no2_domino_trop_col_extract.m -o omi_no2_domino_trop_col_extract
         ./run_omi_no2_domino_trop_col_extract.sh ${MATLAB} ${TMP_INFILE} ${OUTFILE} ${OMI_FILE_PRE} ${BIN_BEG_YY} ${BIN_BEG_MM} ${BIN_BEG_DD} ${BIN_BEG_HH} ${BIN_BEG_MN} ${BIN_BEG_SS} ${BIN_END_YY} ${BIN_END_MM} ${BIN_END_DD} ${BIN_END_HH} ${BIN_END_MN} ${BIN_END_SS} ${NL_PATH_MODEL} ${NL_FILE_MODEL} ${NL_NX_MODEL} ${NL_NY_MODEL} > index_mat2.html 2>&1
#
      fi
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         touch ${TMP_OUTFILE}
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      elif [[ -e ${TMP_OUTFILE} && -e ${OUTFILE} ]]; then
         cat ${OUTFILE} >> ${TMP_OUTFILE}
         rm -rf ${OUTFILE}
      fi
      if [[ ! -e ${TMP_OUTFILE} ]]; then
         touch NO_OMI_NO2_DOMINO_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT OMI NO2 ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'${TMP_OUTFILE}\'
      export NL_FILEOUT=\'obs_seq_omi_no2_domino_trop_col_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_OMI_NO2_DOMINO}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_NO2=${USE_LOG_NO2_LOGIC}
      export NL_USE_LOG_SO2=${USE_LOG_SO2_LOGIC}
      export NL_USE_LOG_HCHO=${USE_LOG_HCHO_LOGIC}
#
# MODEL PROFILE SETTINGS
      export NL_PATH_MODEL=\'${RUN_DIR}/${PAST_DATE}/ensemble_mean_output\'
      export NL_FILE_MODEL=\'wrfout_d${CR_DOMAIN}_${DATE}_mean\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export NL_NZ_MODEL=${NNZP_CR}
#
      export NL_YEAR=${D_YYYY}
      export NL_MONTH=${D_MM}
      export NL_DAY=${D_DD}
      export NL_HOUR=${D_HH}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
      let HH_BEG=${BIN_BEG_HH}
      let MN_BEG=${BIN_BEG_MN}
      let SS_BEG=${BIN_BEG_SS}
      let HH_END=${BIN_END_HH}
      let MN_END=${BIN_END_MN}
      let SS_END=${BIN_END_SS}
      let BIN_BEG_SEC=${HH_BEG}*3600+${MN_BEG}*60+${SS_BEG} 
      let BIN_END_SEC=${HH_END}*3600+${MN_END}*60+${SS_END}
      export NL_BIN_BEG_SEC=${BIN_BEG_SEC}
      export NL_BIN_END_SEC=${BIN_END_SEC}
#      
# USE OMI DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_omi_input_nml.ksh
#
# GET THINNING EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/OMI_NO2/work/omi_no2_domino_trop_col_thinner ./.
      ./omi_no2_domino_trop_col_thinner > index_thin.html 2>&1
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/OMI_NO2/work/omi_no2_domino_trop_col_ascii_to_obs ./.
      ./omi_no2_domino_trop_col_ascii_to_obs > index.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ -s ${NL_FILEOUT} ]]; then
         touch NO_OMI_NO2_DOMINO_${DATE}
      fi
   fi

exit

   
#
#########################################################################
#
# RUN AIRNOW O3 OBSERVATIONS
#
#########################################################################
#
   if ${RUN_AIRNOW_O3_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/airnow_o3_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/airnow_o3_obs
         cd ${RUN_DIR}/${DATE}/airnow_o3_obs
      else
         cd ${RUN_DIR}/${DATE}/airnow_o3_obs
      fi
#
# GET AIRNOW DATA
      if [[ ! -e airnow_o3_hourly_csv_data ]]; then
         cp ${EXPERIMENT_AIRNOW_DIR}/airnow_o3_hourly_csv_data ./.
      fi
#
      export BIN_BEG_YR=${ASIM_MN_YYYY}
      export BIN_BEG_MM=${ASIM_MN_MM}
      export BIN_BEG_DD=${ASIM_MN_DD}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      export BIN_END_YR=${ASIM_MX_YYYY}
      export BIN_END_MM=${ASIM_MX_MM}
      export BIN_END_DD=${ASIM_MX_DD}
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
#
# RUN_AIRNOW_O3_ASCII_TO_DART
      export NL_FILENAME=\'airnow_o3_hourly_csv_data\'
      export NL_LAT_MN=${NL_MIN_LAT}
      export NL_LAT_MX=${NL_MAX_LAT}
      export NL_LON_MN=${NL_MIN_LON}
      export NL_LON_MX=${NL_MAX_LON}
      export NL_USE_LOG_CO=${USE_LOG_CO_LOGIC}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_NOX=${USE_LOG_NOX_LOGIC}
      export NL_USE_LOG_NO2=${USE_LOG_NO2_LOGIC}
      export NL_USE_LOG_SO2=${USE_LOG_SO2_LOGIC}
      export NL_USE_LOG_PM10=${USE_LOG_PM10_LOGIC}
      export NL_USE_LOG_PM25=${USE_LOG_PM25_LOGIC}
      export NL_USE_LOG_AOD=${USE_LOG_AOD_LOGIC}
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_AIRNOW_O3}
#
# CREATE BIAS CORRECTION NAMELIST
      export NL_DOES_FILE_EXIST=.true.
      if [[ ${DATE} -eq ${FIRST_FILTER_DATE} || ${RUN_BIAS_CORRECTION} == false ]]; then
         rm -rf ${NL_CORRECTION_FILENAME}
	 export NL_DOES_FILE_EXIST=.false.
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
correction_filename=${NL_CORRECTION_FILENAME}
nobs=1
obs_list='TROPOMI_CO_COL'
/
EOF
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/AIRNOW/work/airnow_o3_ascii_to_obs ./.
      rm -rf create_airnow_obs_nml.nl
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_airnow_input_nml.ksh
      ./airnow_o3_ascii_to_obs > index.file 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      export AIRNOW_OUT_FILE=airnow_obs_seq
      export AIRNOW_ARCH_FILE=obs_seq_airnow_o3_${DATE}.out
      if [[ -s ${AIRNOW_OUT_FILE} ]]; then
         cp ${AIRNOW_OUT_FILE} ${AIRNOW_ARCH_FILE}
         rm ${AIRNOW_OUT_FILE}
      else
         touch NO_DATA_${D_DATE}
      fi     
   fi
#
#########################################################################
#
# RUN AIRNOW CO OBSERVATIONS
#
#########################################################################
#
   if ${RUN_AIRNOW_CO_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/airnow_co_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/airnow_co_obs
         cd ${RUN_DIR}/${DATE}/airnow_co_obs
      else
         cd ${RUN_DIR}/${DATE}/airnow_co_obs
      fi
#
# GET AIRNOW DATA
      if [[ ! -e airnow_co_hourly_csv_data ]]; then
         cp ${EXPERIMENT_AIRNOW_DIR}/airnow_co_hourly_csv_data ./.
      fi
#
      export BIN_BEG_YR=${ASIM_MN_YYYY}
      export BIN_BEG_MM=${ASIM_MN_MM}
      export BIN_BEG_DD=${ASIM_MN_DD}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      export BIN_END_YR=${ASIM_MX_YYYY}
      export BIN_END_MM=${ASIM_MX_MM}
      export BIN_END_DD=${ASIM_MX_DD}
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
#
# RUN_AIRNOW_CO_ASCII_TO_DART
      export NL_FILENAME=\'airnow_co_hourly_csv_data\'
      export NL_LAT_MN=${NL_MIN_LAT}
      export NL_LAT_MX=${NL_MAX_LAT}
      export NL_LON_MN=${NL_MIN_LON}
      export NL_LON_MX=${NL_MAX_LON}
      export NL_USE_LOG_CO=${USE_LOG_CO_LOGIC}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_NOX=${USE_LOG_NOX_LOGIC}
      export NL_USE_LOG_NO2=${USE_LOG_NO2_LOGIC}
      export NL_USE_LOG_SO2=${USE_LOG_SO2_LOGIC}
      export NL_USE_LOG_PM10=${USE_LOG_PM10_LOGIC}
      export NL_USE_LOG_PM25=${USE_LOG_PM25_LOGIC}
      export NL_USE_LOG_AOD=${USE_LOG_AOD_LOGIC}
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_AIRNOW_CO}
#
# CREATE BIAS CORRECTION NAMELIST
      export NL_DOES_FILE_EXIST=.true.
      if [[ ${DATE} -eq ${FIRST_FILTER_DATE} || ${RUN_BIAS_CORRECTION} == false ]]; then
         rm -rf ${NL_CORRECTION_FILENAME}
	 export NL_DOES_FILE_EXIST=.false.
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
correction_filename=${NL_CORRECTION_FILENAME}
nobs=1
obs_list='TROPOMI_CO_COL'
/
EOF
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/AIRNOW/work/airnow_co_ascii_to_obs ./.
      rm -rf create_airnow_obs_nml.nl
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_airnow_input_nml.ksh
      ./airnow_co_ascii_to_obs > index.file 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      export AIRNOW_OUT_FILE=airnow_obs_seq
      export AIRNOW_ARCH_FILE=obs_seq_airnow_co_${DATE}.out
      if [[ -s ${AIRNOW_OUT_FILE} ]]; then
         cp ${AIRNOW_OUT_FILE} ${AIRNOW_ARCH_FILE}
         rm ${AIRNOW_OUT_FILE}
      else
         touch NO_DATA_${D_DATE}
      fi     
   fi
#
#########################################################################
#
# RUN AIRNOW NO2 OBSERVATIONS
#
#########################################################################
#
if ${RUN_AIRNOW_NO2_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/airnow_no2_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/airnow_no2_obs
         cd ${RUN_DIR}/${DATE}/airnow_no2_obs
      else
         cd ${RUN_DIR}/${DATE}/airnow_no2_obs
      fi
#
# GET AIRNOW DATA
      if [[ ! -e airnow_no2_hourly_csv_data ]]; then
         cp ${EXPERIMENT_AIRNOW_DIR}/airnow_no2_hourly_csv_data ./.
      fi
#
      export BIN_BEG_YR=${ASIM_MN_YYYY}
      export BIN_BEG_MM=${ASIM_MN_MM}
      export BIN_BEG_DD=${ASIM_MN_DD}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      export BIN_END_YR=${ASIM_MX_YYYY}
      export BIN_END_MM=${ASIM_MX_MM}
      export BIN_END_DD=${ASIM_MX_DD}
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
#
# RUN_AIRNOW_NO2_ASCII_TO_DART
      export NL_FILENAME=\'airnow_no2_hourly_csv_data\'
      export NL_LAT_MN=${NL_MIN_LAT}
      export NL_LAT_MX=${NL_MAX_LAT}
      export NL_LON_MN=${NL_MIN_LON}
      export NL_LON_MX=${NL_MAX_LON}
      export NL_USE_LOG_CO=${USE_LOG_CO_LOGIC}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_NOX=${USE_LOG_NOX_LOGIC}
      export NL_USE_LOG_NO2=${USE_LOG_NO2_LOGIC}
      export NL_USE_LOG_SO2=${USE_LOG_SO2_LOGIC}
      export NL_USE_LOG_PM10=${USE_LOG_PM10_LOGIC}
      export NL_USE_LOG_PM25=${USE_LOG_PM25_LOGIC}
      export NL_USE_LOG_AOD=${USE_LOG_AOD_LOGIC}
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_AIRNOW_NO2}
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/AIRNOW/work/airnow_no2_ascii_to_obs ./.
      rm -rf create_airnow_obs_nml.nl
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_airnow_input_nml.ksh
      ./airnow_no2_ascii_to_obs > index.file 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      export AIRNOW_OUT_FILE=airnow_obs_seq
      export AIRNOW_ARCH_FILE=obs_seq_airnow_no2_${DATE}.out
      if [[ -s ${AIRNOW_OUT_FILE} ]]; then
         cp ${AIRNOW_OUT_FILE} ${AIRNOW_ARCH_FILE}
         rm ${AIRNOW_OUT_FILE}
      else
         touch NO_DATA_${D_DATE}
      fi     
   fi
#
#########################################################################
#
# RUN AIRNOW SO2 OBSERVATIONS
#
#########################################################################
#
if ${RUN_AIRNOW_SO2_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/airnow_so2_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/airnow_so2_obs
         cd ${RUN_DIR}/${DATE}/airnow_so2_obs
      else
         cd ${RUN_DIR}/${DATE}/airnow_so2_obs
      fi
#
# GET AIRNOW DATA
      if [[ ! -e airnow_so2_hourly_csv_data ]]; then
         cp ${EXPERIMENT_AIRNOW_DIR}/airnow_so2_hourly_csv_data ./.
      fi
#
      export BIN_BEG_YR=${ASIM_MN_YYYY}
      export BIN_BEG_MM=${ASIM_MN_MM}
      export BIN_BEG_DD=${ASIM_MN_DD}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      export BIN_END_YR=${ASIM_MX_YYYY}
      export BIN_END_MM=${ASIM_MX_MM}
      export BIN_END_DD=${ASIM_MX_DD}
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
#
# RUN_AIRNOW_SO2_ASCII_TO_DART
      export NL_FILENAME=\'airnow_so2_hourly_csv_data\'
      export NL_LAT_MN=${NL_MIN_LAT}
      export NL_LAT_MX=${NL_MAX_LAT}
      export NL_LON_MN=${NL_MIN_LON}
      export NL_LON_MX=${NL_MAX_LON}
      export NL_USE_LOG_CO=${USE_LOG_CO_LOGIC}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_NOX=${USE_LOG_NOX_LOGIC}
      export NL_USE_LOG_NO2=${USE_LOG_NO2_LOGIC}
      export NL_USE_LOG_SO2=${USE_LOG_SO2_LOGIC}
      export NL_USE_LOG_PM10=${USE_LOG_PM10_LOGIC}
      export NL_USE_LOG_PM25=${USE_LOG_PM25_LOGIC}
      export NL_USE_LOG_AOD=${USE_LOG_AOD_LOGIC}
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_AIRNOW_SO2}
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/AIRNOW/work/airnow_so2_ascii_to_obs ./.
      rm -rf create_airnow_obs_nml.nl
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_airnow_input_nml.ksh
      ./airnow_so2_ascii_to_obs > index.file 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      export AIRNOW_OUT_FILE=airnow_obs_seq
      export AIRNOW_ARCH_FILE=obs_seq_airnow_so2_${DATE}.out
      if [[ -s ${AIRNOW_OUT_FILE} ]]; then
         cp ${AIRNOW_OUT_FILE} ${AIRNOW_ARCH_FILE}
         rm ${AIRNOW_OUT_FILE}
      else
         touch NO_DATA_${D_DATE}
      fi     
   fi
#
#########################################################################
#
# RUN AIRNOW PM10 OBSERVATIONS
#
#########################################################################
#
if ${RUN_AIRNOW_PM10_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/airnow_pm10_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/airnow_pm10_obs
         cd ${RUN_DIR}/${DATE}/airnow_pm10_obs
      else
         cd ${RUN_DIR}/${DATE}/airnow_pm10_obs
      fi
#
# GET AIRNOW DATA
      if [[ ! -e airnow_pm10_hourly_csv_data ]]; then
         cp ${EXPERIMENT_AIRNOW_DIR}/airnow_pm10_hourly_csv_data ./.
      fi
#
      export BIN_BEG_YR=${ASIM_MN_YYYY}
      export BIN_BEG_MM=${ASIM_MN_MM}
      export BIN_BEG_DD=${ASIM_MN_DD}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      export BIN_END_YR=${ASIM_MX_YYYY}
      export BIN_END_MM=${ASIM_MX_MM}
      export BIN_END_DD=${ASIM_MX_DD}
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
#
# RUN_AIRNOW_PM10_ASCII_TO_DART
      export NL_FILENAME=\'airnow_pm10_hourly_csv_data\'
      export NL_LAT_MN=${NL_MIN_LAT}
      export NL_LAT_MX=${NL_MAX_LAT}
      export NL_LON_MN=${NL_MIN_LON}
      export NL_LON_MX=${NL_MAX_LON}
      export NL_USE_LOG_CO=${USE_LOG_CO_LOGIC}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_NOX=${USE_LOG_NOX_LOGIC}
      export NL_USE_LOG_NO2=${USE_LOG_NO2_LOGIC}
      export NL_USE_LOG_SO2=${USE_LOG_SO2_LOGIC}
      export NL_USE_LOG_PM10=${USE_LOG_PM10_LOGIC}
      export NL_USE_LOG_PM25=${USE_LOG_PM25_LOGIC}
      export NL_USE_LOG_AOD=${USE_LOG_AOD_LOGIC}
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_AIRNOW_PM10}
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/AIRNOW/work/airnow_pm10_ascii_to_obs ./.
      rm -rf create_airnow_obs_nml.nl
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_airnow_input_nml.ksh
      ./airnow_pm10_ascii_to_obs > index.file 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      export AIRNOW_OUT_FILE=airnow_obs_seq
      export AIRNOW_ARCH_FILE=obs_seq_airnow_pm10_${DATE}.out
      if [[ -s ${AIRNOW_OUT_FILE} ]]; then
         cp ${AIRNOW_OUT_FILE} ${AIRNOW_ARCH_FILE}
         rm ${AIRNOW_OUT_FILE}
      else
         touch NO_DATA_${D_DATE}
      fi     
   fi
#
#########################################################################
#
# RUN AIRNOW PM25 OBSERVATIONS
#
#########################################################################
#
if ${RUN_AIRNOW_PM25_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/airnow_pm25_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/airnow_pm25_obs
         cd ${RUN_DIR}/${DATE}/airnow_pm25_obs
      else
         cd ${RUN_DIR}/${DATE}/airnow_pm25_obs
      fi
#
# GET AIRNOW DATA
      if [[ ! -e airnow_pm2.5_hourly_csv_data ]]; then
         cp ${EXPERIMENT_AIRNOW_DIR}/airnow_pm2.5_hourly_csv_data ./.
      fi
#
      export BIN_BEG_YR=${ASIM_MN_YYYY}
      export BIN_BEG_MM=${ASIM_MN_MM}
      export BIN_BEG_DD=${ASIM_MN_DD}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      export BIN_END_YR=${ASIM_MX_YYYY}
      export BIN_END_MM=${ASIM_MX_MM}
      export BIN_END_DD=${ASIM_MX_DD}
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
#
# RUN_AIRNOW_PM25_ASCII_TO_DART
      export NL_FILENAME=\'airnow_pm2.5_hourly_csv_data\'
      export NL_LAT_MN=${NL_MIN_LAT}
      export NL_LAT_MX=${NL_MAX_LAT}
      export NL_LON_MN=${NL_MIN_LON}
      export NL_LON_MX=${NL_MAX_LON}
      export NL_USE_LOG_CO=${USE_LOG_CO_LOGIC}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_NOX=${USE_LOG_NOX_LOGIC}
      export NL_USE_LOG_NO2=${USE_LOG_NO2_LOGIC}
      export NL_USE_LOG_SO2=${USE_LOG_SO2_LOGIC}
      export NL_USE_LOG_PM10=${USE_LOG_PM10_LOGIC}
      export NL_USE_LOG_PM25=${USE_LOG_PM25_LOGIC}
      export NL_USE_LOG_AOD=${USE_LOG_AOD_LOGIC}
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_AIRNOW_PM25}
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/AIRNOW/work/airnow_pm25_ascii_to_obs ./.
      rm -rf create_airnow_obs_nml.nl
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_airnow_input_nml.ksh
      ./airnow_pm25_ascii_to_obs > index.file 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      export AIRNOW_OUT_FILE=airnow_obs_seq
      export AIRNOW_ARCH_FILE=obs_seq_airnow_pm25_${DATE}.out
      if [[ -s ${AIRNOW_OUT_FILE} ]]; then
         cp ${AIRNOW_OUT_FILE} ${AIRNOW_ARCH_FILE}
         rm ${AIRNOW_OUT_FILE}
      else
         touch NO_DATA_${D_DATE}
      fi     
   fi
#
#########################################################################
#
# RUN PANDA CO OBSERVATIONS
#
#########################################################################
#
   if ${RUN_PANDA_CO_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/panda_co_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/panda_co_obs
         cd ${RUN_DIR}/${DATE}/panda_co_obs
      else
         cd ${RUN_DIR}/${DATE}/panda_co_obs
      fi
#
# GET PANDA DATA
      if [[ ! -e panda_station_coordinates.csv  ]]; then
         cp ${EXPERIMENT_PANDA_DIR}/panda_station_coordinates.csv ./.
      fi
      if [[ ! -e panda_stationData.csv  ]]; then
         cp ${EXPERIMENT_PANDA_DIR}/panda_stationData.csv ./.
      fi
#
      export ASIM_MIN_MN=0
      export ASIM_MIN_SS=0
      export ASIM_MAX_MN=0
      export ASIM_MAX_SS=0
#
# RUN_PANDA_CO_ASCII_TO_DART
      if [[ ${HH} -eq 0 ]]; then
         export L_YYYY=${ASIM_MIN_YYYY}
         export L_MM=${ASIM_MIN_MM}
         export L_DD=${ASIM_MIN_DD}
         export L_HH=24
         export D_DATE=${L_YYYY}${L_MM}${L_DD}${L_HH}
      else
         export L_YYYY=${YYYY}
         export L_MM=${MM}
         export L_DD=${DD}
         export L_HH=${HH}
         export D_DATE=${L_YYYY}${L_MM}${L_DD}${L_HH}
      fi
      export NL_YEAR=${L_YYYY}
      export NL_MONTH=${L_MM}
      export NL_DAY=${L_DD}
      export NL_HOUR=${L_HH}
#
      export NL_FILENAME_COORD=\'panda_station_coordinates.csv\'
      export NL_FILENAME_DATA=\'panda_stationData.csv\'
      export NL_LAT_MN=${NL_MIN_LAT}
      export NL_LAT_MX=${NL_MAX_LAT}
      export NL_LON_MN=${NL_MIN_LON}
      export NL_LON_MX=${NL_MAX_LON}
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/PANDA/work/panda_co_ascii_to_obs ./.
      rm -rf create_panda_obs_nml.nl
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_panda_input_nml.ksh
      ./panda_co_ascii_to_obs
#
# COPY OUTPUT TO ARCHIVE LOCATION
      export PANDA_OUT_FILE=panda_obs_seq
      export PANDA_ARCH_FILE=obs_seq_panda_co_${DATE}.out
      if [[ -s ${PANDA_OUT_FILE} ]]; then
         cp ${PANDA_OUT_FILE} ${PANDA_ARCH_FILE}
         rm ${PANDA_OUT_FILE}
      else
         touch NO_DATA_${D_DATE}
      fi     
   fi
#
#########################################################################
#
# RUN PANDA O3 OBSERVATIONS
#
#########################################################################
#
   if ${RUN_PANDA_O3_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/panda_o3_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/panda_o3_obs
         cd ${RUN_DIR}/${DATE}/panda_o3_obs
      else
         cd ${RUN_DIR}/${DATE}/panda_o3_obs
      fi
#
# GET PANDA DATA
      if [[ ! -e panda_station_coordinates.csv  ]]; then
         cp ${EXPERIMENT_PANDA_DIR}/panda_station_coordinates.csv ./.
      fi
      if [[ ! -e panda_stationData.csv  ]]; then
         cp ${EXPERIMENT_PANDA_DIR}/panda_stationData.csv ./.
      fi
#
      export ASIM_MIN_MN=0
      export ASIM_MIN_SS=0
      export ASIM_MAX_MN=0
      export ASIM_MAX_SS=0
#
# RUN_PANDA_O3_ASCII_TO_DART
      if [[ ${HH} -eq 0 ]]; then
         export L_YYYY=${ASIM_MIN_YYYY}
         export L_MM=${ASIM_MIN_MM}
         export L_DD=${ASIM_MIN_DD}
         export L_HH=24
         export D_DATE=${L_YYYY}${L_MM}${L_DD}${L_HH}
      else
         export L_YYYY=${YYYY}
         export L_MM=${MM}
         export L_DD=${DD}
         export L_HH=${HH}
         export D_DATE=${L_YYYY}${L_MM}${L_DD}${L_HH}
      fi
      export NL_YEAR=${L_YYYY}
      export NL_MONTH=${L_MM}
      export NL_DAY=${L_DD}
      export NL_HOUR=${L_HH}
#
      export NL_FILENAME_COORD=\'panda_station_coordinates.csv\'
      export NL_FILENAME_DATA=\'panda_stationData.csv\'
      export NL_LAT_MN=${NL_MIN_LAT}
      export NL_LAT_MX=${NL_MAX_LAT}
      export NL_LON_MN=${NL_MIN_LON}
      export NL_LON_MX=${NL_MAX_LON}
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/PANDA/work/panda_o3_ascii_to_obs ./.
      rm -rf create_panda_obs_nml.nl
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_panda_input_nml.ksh
      ./panda_o3_ascii_to_obs
#
# COPY OUTPUT TO ARCHIVE LOCATION
      export PANDA_OUT_FILE=panda_obs_seq
      export PANDA_ARCH_FILE=obs_seq_panda_o3_${DATE}.out
      if [[ -s ${PANDA_OUT_FILE} ]]; then
         cp ${PANDA_OUT_FILE} ${PANDA_ARCH_FILE}
         rm ${PANDA_OUT_FILE}
      else
         touch NO_DATA_${D_DATE}
      fi     
   fi
#
#########################################################################
#
# RUN PANDA PM25 OBSERVATIONS
#
#########################################################################
#
   if ${RUN_PANDA_PM25_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/panda_pm25_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/panda_pm25_obs
         cd ${RUN_DIR}/${DATE}/panda_pm25_obs
      else
         cd ${RUN_DIR}/${DATE}/panda_pm25_obs
      fi
#
# GET PANDA DATA
      if [[ ! -e panda_station_coordinates.csv  ]]; then
         cp ${EXPERIMENT_PANDA_DIR}/panda_station_coordinates.csv ./.
      fi
      if [[ ! -e panda_stationData.csv  ]]; then
         cp ${EXPERIMENT_PANDA_DIR}/panda_stationData.csv ./.
      fi
#
      export ASIM_MIN_MN=0
      export ASIM_MIN_SS=0
      export ASIM_MAX_MN=0
      export ASIM_MAX_SS=0
#
# RUN_PANDA_PM25_ASCII_TO_DART
      if [[ ${HH} -eq 0 ]]; then
         export L_YYYY=${ASIM_MIN_YYYY}
         export L_MM=${ASIM_MIN_MM}
         export L_DD=${ASIM_MIN_DD}
         export L_HH=24
         export D_DATE=${L_YYYY}${L_MM}${L_DD}${L_HH}
      else
         export L_YYYY=${YYYY}
         export L_MM=${MM}
         export L_DD=${DD}
         export L_HH=${HH}
         export D_DATE=${L_YYYY}${L_MM}${L_DD}${L_HH}
      fi
      export NL_YEAR=${L_YYYY}
      export NL_MONTH=${L_MM}
      export NL_DAY=${L_DD}
      export NL_HOUR=${L_HH}
#
      export NL_FILENAME_COORD=\'panda_station_coordinates.csv\'
      export NL_FILENAME_DATA=\'panda_stationData.csv\'
      export NL_LAT_MN=${NL_MIN_LAT}
      export NL_LAT_MX=${NL_MAX_LAT}
      export NL_LON_MN=${NL_MIN_LON}
      export NL_LON_MX=${NL_MAX_LON}
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/PANDA/work/panda_pm25_ascii_to_obs ./.
      rm -rf create_panda_obs_nml.nl
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_panda_input_nml.ksh
      ./panda_pm25_ascii_to_obs
#
# COPY OUTPUT TO ARCHIVE LOCATION
      export PANDA_OUT_FILE=panda_obs_seq
      export PANDA_ARCH_FILE=obs_seq_panda_pm25_${DATE}.out
      if [[ -s ${PANDA_OUT_FILE} ]]; then
         cp ${PANDA_OUT_FILE} ${PANDA_ARCH_FILE}
         rm ${PANDA_OUT_FILE}
      else
         touch NO_DATA_${D_DATE}
      fi     
   fi
#
#########################################################################
#
# RUN MEXICO AQS CO OBSERVATIONS
#
#########################################################################
#
   if ${RUN_MEXICO_AQS_CO_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/mexico_aqs_co_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/mexico_aqs_co_obs
         cd ${RUN_DIR}/${DATE}/mexico_aqs_co_obs
      else
         cd ${RUN_DIR}/${DATE}/mexico_aqs_co_obs
      fi
#
# GET MEXICO AQS DATA
      if [[ ! -e mexico_aqs_co_hourly_csv_data ]]; then
         cp ${EXPERIMENT_MEXICO_AQS_DIR}/MCMA-monitoring-stations-just-CO.csv ./.
         cp ${EXPERIMENT_MEXICO_AQS_DIR}/Mexico-in-situ-CO-2022.csv ./.
      fi
#
      export BIN_BEG_YR=${ASIM_MN_YYYY}
      export BIN_BEG_MM=${ASIM_MN_MM}
      export BIN_BEG_DD=${ASIM_MN_DD}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=0
      export BIN_BEG_SS=0
      export BIN_END_YR=${ASIM_MX_YYYY}
      export BIN_END_MM=${ASIM_MX_MM}
      export BIN_END_DD=${ASIM_MX_DD}
      let HH_END=${ASIM_MX_HH}
      let HHM_END=${HH_END}-1
      export BIN_END_HH=${HHM_END}
      export BIN_END_MN=59
      export BIN_END_SS=59
#
# RUN_MEXICO_AQS_CO_ASCII_TO_DART
      export NL_FILENAME_STATIONS=\'MCMA-monitoring-stations-just-CO.csv\'
      export NL_FILENAME_DATA=\'Mexico-in-situ-CO-2022.csv\'
      export NL_LAT_MN=${NL_MIN_LAT}
      export NL_LAT_MX=${NL_MAX_LAT}
      export NL_LON_MN=${NL_MIN_LON}
      export NL_LON_MX=${NL_MAX_LON}
      export NL_USE_LOG_CO=${USE_LOG_CO_LOGIC}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_NOX=${USE_LOG_NOX_LOGIC}
      export NL_USE_LOG_NO2=${USE_LOG_NO2_LOGIC}
      export NL_USE_LOG_SO2=${USE_LOG_SO2_LOGIC}
      export NL_USE_LOG_PM10=${USE_LOG_PM10_LOGIC}
      export NL_USE_LOG_PM25=${USE_LOG_PM25_LOGIC}
      export NL_USE_LOG_AOD=${USE_LOG_AOD_LOGIC}
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_MEXICO_AQS_CO}
#
# CREATE BIAS CORRECTION NAMELIST
      export NL_DOES_FILE_EXIST=.true.
      if [[ ${DATE} -eq ${FIRST_FILTER_DATE} || ${RUN_BIAS_CORRECTION} == false ]]; then
         rm -rf ${NL_CORRECTION_FILENAME}
	 export NL_DOES_FILE_EXIST=.false.
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
correction_filename=${NL_CORRECTION_FILENAME}
nobs=1
obs_list='TROPOMI_CO_COL'
/
EOF
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/MEXICO_AQS/work/mexico_aqs_co_ascii_to_obs ./.
      rm -rf create_mexico_aqs_obs_nml.nl
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_mexico_aqs_input_nml.ksh
      ./mexico_aqs_co_ascii_to_obs > index.file 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      export MEXICO_AQS_OUT_FILE=mexico_aqs_obs_seq
      export MEXICO_AQS_ARCH_FILE=obs_seq_mexico_aqs_co_${DATE}.out
      if [[ -s ${MEXICO_AQS_OUT_FILE} ]]; then
         cp ${MEXICO_AQS_OUT_FILE} ${MEXICO_AQS_ARCH_FILE}
         rm ${MEXICO_AQS_OUT_FILE}
      else
         touch NO_DATA_${D_DATE}
      fi     
   fi

#
#########################################################################
#
# RUN PREPBUFR MET OBSERVATIONS
#
#########################################################################
#
   if ${RUN_MET_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/prepbufr_met_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/prepbufr_met_obs
         cd ${RUN_DIR}/${DATE}/prepbufr_met_obs
      else
         cd ${RUN_DIR}/${DATE}/prepbufr_met_obs
      fi
#
# GET PREPBUFR FILES
#           
      export L_DATE=${D_YYYY}${D_MM}${D_DD}06
      export E_DATE=$(${BUILD_DIR}/da_advance_time.exe ${L_DATE} +24 2>/dev/null)
      while [[ ${L_DATE} -le ${E_DATE} ]]; do
         export L_YYYY=$(echo $L_DATE | cut -c1-4)
         export L_YY=$(echo $L_DATE | cut -c3-4)
         export L_MM=$(echo $L_DATE | cut -c5-6)
         export L_DD=$(echo $L_DATE | cut -c7-8)
         export L_HH=$(echo $L_DATE | cut -c9-10)
         cp ${EXPERIMENT_PREPBUFR_DIR}/${L_YYYY}${L_MM}${L_DD}${L_HH}/prepbufr.gdas.${L_YYYY}${L_MM}${L_DD}${L_HH}.wo40.be prepqm${L_YY}${L_MM}${L_DD}${L_HH}
         export L_DATE=$(${BUILD_DIR}/da_advance_time.exe ${L_DATE} +6 2>/dev/null)
      done
#
# GET DART input.nml
      rm -rf input.nml
      cp ${DART_DIR}/observations/obs_converters/NCEP/prep_bufr/work/input.nml ./.
#
# RUN_PREPBUFR TO ASCII CONVERTER
      ${DART_DIR}/observations/obs_converters/NCEP/prep_bufr/work/prepbufr_RT.csh ${D_YYYY} ${DD_MM} ${DD_DD} ${DD_DD} ${DART_DIR}/observations/obs_converters/NCEP/prep_bufr/exe > index.file 2>&1
#
# RUN ASCII TO OBS_SEQ CONVERTER
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_ncep_ascii_to_obs_input_nml_RT.ksh
      ${DART_DIR}/observations/obs_converters/NCEP/ascii_to_obs/work/create_real_obs > index_create 2>&1
#
      mv obs_seq${D_DATE} obs_seq_prep_${DATE}.out
   fi
#
#########################################################################
#
# RUN COMBINE OBSERVATIONS
#
#########################################################################
#
   if ${RUN_COMBINE_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/combine_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/combine_obs
         cd ${RUN_DIR}/${DATE}/combine_obs
      else
         cd ${RUN_DIR}/${DATE}/combine_obs
      fi
#
# GET EXECUTABLES
      cp ${WRFCHEM_DART_WORK_DIR}/obs_sequence_tool ./.
      export NUM_FILES=0
#
# GET OBS_SEQ FILES TO COMBINE
# MET OBS
      if [[ -s ${PREPBUFR_MET_OBS_DIR}/obs_seq_prep_${DATE}.out && ${RUN_MET_OBS} ]]; then 
         (( NUM_FILES=${NUM_FILES}+1 ))
         cp ${PREPBUFR_MET_OBS_DIR}/obs_seq_prep_${DATE}.out ./obs_seq_MET_${DATE}.out
         export FILE_LIST[${NUM_FILES}]=obs_seq_MET_${DATE}.out
      fi
#
# MOPITT CO TOTAL_COL
      if [[ -s ${MOPITT_CO_TOTAL_COL_OBS_DIR}/obs_seq_mopitt_co_total_col_${DATE}.out && ${RUN_MOPITT_CO_TOTAL_COL_OBS} ]]; then 
         cp ${MOPITT_CO_TOTAL_COL_OBS_DIR}/obs_seq_mopitt_co_total_col_${DATE}.out ./obs_seq_MOP_CO_TOTAL_COL_${DATE}.out
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_MOP_CO_TOTAL_COL_${DATE}.out
      fi
#
# MOPITT CO PROFILE
      if [[ -s ${MOPITT_CO_PROFILE_OBS_DIR}/obs_seq_mopitt_co_profile_${DATE}.out && ${RUN_MOPITT_CO_PROFILE_OBS} ]]; then 
         cp ${MOPITT_CO_PROFILE_OBS_DIR}/obs_seq_mopitt_co_profile_${DATE}.out ./obs_seq_MOP_CO_PROFILE_${DATE}.out
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_MOP_CO_PROFILE_${DATE}.out
      fi
#
# MOPITT CO CPSR
      if [[ -s ${MOPITT_CO_CPSR_OBS_DIR}/obs_seq_mopitt_co_cpsr_${DATE}.out && ${RUN_MOPITT_CO_CPSR_OBS} ]]; then 
         cp ${MOPITT_CO_CPSR_OBS_DIR}/obs_seq_mopitt_co_cpsr_${DATE}.out ./obs_seq_MOP_CO_CPSR_${DATE}.out
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_MOP_CO_CPSR_${DATE}.out
      fi
#
# IASI CO TOTAL COL
      if [[ -s ${IASI_CO_TOTAL_COL_OBS_DIR}/obs_seq_iasi_co_total_col_${DATE}.out && ${RUN_IASI_CO_TOTAL_COL_OBS} ]]; then 
         cp ${IASI_CO_TOTAL_COL_OBS_DIR}/obs_seq_iasi_co_total_col_${DATE}.out ./obs_seq_IAS_CO_TOTAL_COL_${DATE}.out
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_IAS_CO_TOTAL_COL_${DATE}.out
      fi
#
# IASI CO PROFILE
      if [[ -s ${IASI_CO_PROFILE_OBS_DIR}/obs_seq_iasi_co_profile_${DATE}.out && ${RUN_IASI_CO_PROFILE_OBS} ]]; then 
         cp ${IASI_CO_PROFILE_OBS_DIR}/obs_seq_iasi_co_profile_${DATE}.out ./obs_seq_IAS_CO_PROFILE_${DATE}.out
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_IAS_CO_PROFILE_${DATE}.out
      fi
#
# IASI CO CPSR
      if [[ -s ${IASI_CO_CPSR_OBS_DIR}/obs_seq_iasi_co_cpsr_${DATE}.out && ${RUN_IASI_CO_CPSR_OBS} ]]; then 
         cp ${IASI_CO_CPSR_OBS_DIR}/obs_seq_iasi_co_cpsr_${DATE}.out ./obs_seq_IAS_CO_CPSR_${DATE}.out
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_IAS_CO_CPSR_${DATE}.out
      fi
#
# IASI O3 PROFILE
      if [[ -s ${IASI_O3_PROFILE_OBS_DIR}/obs_seq_iasi_o3_profile_${DATE}.out && ${RUN_IASI_O3_PROFILE_OBS} ]]; then 
         cp ${IASI_O3_PROFILE_OBS_DIR}/obs_seq_iasi_o3_profile_${DATE}.out ./obs_seq_IAS_O3_PROFILE_${DATE}.out
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_IAS_O3_PROFILE_${DATE}.out
      fi
#
# IASI O3 CPSR
      if [[ -s ${IASI_O3_CPSR_OBS_DIR}/obs_seq_iasi_o3_cpsr_${DATE}.out && ${RUN_IASI_O3_CPSR_OBS} ]]; then 
         cp ${IASI_O3_OBS_DIR}/obs_seq_iasi_o3_cpsr_${DATE}.out ./obs_seq_IAS_O3_CPSR_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_IAS_O3_CPSR_${DATE}.out
      fi
#
# MODIS AOD TOTAL COL
      if [[ -s ${MODIS_AOD_TOTAL_COL_OBS_DIR}/obs_seq_modis_aod_total_col_${DATE}.out && ${RUN_MODIS_AOD_TOTAL_COL_OBS} ]]; then 
         cp ${MODIS_AOD_TOTAL_COL_OBS_DIR}/obs_seq_modis_aod_total_col_${DATE}.out ./obs_seq_MOD_AOD_TOTAL_COL_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_MOD_AOD_TOTAL_COL_${DATE}.out
      fi
#
# OMI O3 TOTAL COL
      if [[ -s ${OMI_O3_TOTAL_COL_OBS_DIR}/obs_seq_omi_o3_total_col_${DATE}.out && ${RUN_OMI_O3_TOTAL_COL_OBS} ]]; then 
         cp ${OMI_O3_TOTAL_COL_OBS_DIR}/obs_seq_omi_o3_total_col_${DATE}.out ./obs_seq_OMI_O3_TOTAL_COL_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_OMI_O3_TOTAL_COL_${DATE}.out
      fi
#
# OMI O3 TROP COL
      if [[ -s ${OMI_O3_TROP_COL_OBS_DIR}/obs_seq_omi_o3_trop_col_${DATE}.out && ${RUN_OMI_O3_TROP_COL_OBS} ]]; then 
         cp ${OMI_O3_TROP_COL_OBS_DIR}/obs_seq_omi_o3_trop_col_${DATE}.out ./obs_seq_OMI_O3_TROP_COL_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_OMI_O3_TROP_COL_${DATE}.out
      fi
#
# OMI O3 PROFILE
      if [[ -s ${OMI_O3_PROFILE_OBS_DIR}/obs_seq_omi_o3_profile_${DATE}.out && ${RUN_OMI_O3_PROFILE_OBS} ]]; then 
         cp ${OMI_O3_PROFILE_OBS_DIR}/obs_seq_omi_o3_profile_${DATE}.out ./obs_seq_OMI_O3_PROFILE_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_OMI_O3_PROFILE_${DATE}.out
      fi
#
# OMI O3 CPSR
      if [[ -s ${OMI_O3_CPSR_OBS_DIR}/obs_seq_omi_o3_cpsr_${DATE}.out && ${RUN_OMI_O3_CPSR_OBS} ]]; then 
         cp ${OMI_O3_CPSR_OBS_DIR}/obs_seq_omi_o3_cpsr_${DATE}.out ./obs_seq_OMI_O3_CPSR_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_OMI_O3_CPSR_${DATE}.out
      fi
#
# OMI NO2 TOTAL COL
      if [[ -s ${OMI_NO2_TOTAL_COL_OBS_DIR}/obs_seq_omi_no2_total_col_${DATE}.out && ${RUN_OMI_NO2_TOTAL_COL_OBS} ]]; then 
         cp ${OMI_NO2_TOTAL_COL_OBS_DIR}/obs_seq_omi_no2_total_col_${DATE}.out ./obs_seq_OMI_NO2_TOTAL_COL_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_OMI_NO2_TOTAL_COL_${DATE}.out
      fi
#
# OMI NO2 TROP COL
      if [[ -s ${OMI_NO2_TROP_COL_OBS_DIR}/obs_seq_omi_no2_trop_col_${DATE}.out && ${RUN_OMI_NO2_TROP_COL_OBS} ]]; then 
         cp ${OMI_NO2_TROP_COL_OBS_DIR}/obs_seq_omi_no2_trop_col_${DATE}.out ./obs_seq_OMI_NO2_TROP_COL_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_OMI_NO2_TROP_COL_${DATE}.out
      fi
#
# OMI SO2 TOTAL COL
      if [[ -s ${OMI_SO2_TOTAL_COL_OBS_DIR}/obs_seq_omi_so2_total_col_${DATE}.out && ${RUN_OMI_SO2_TOTAL_COL_OBS} ]]; then 
         cp ${OMI_SO2_TOTAL_COL_OBS_DIR}/obs_seq_omi_so2_total_col_${DATE}.out ./obs_seq_OMI_SO2_TOTAL_COL_${DATE}.out
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_OMI_SO2_TOTAL_COL_${DATE}.out
      fi
#
# OMI SO2 PBL COL
      if [[ -s ${OMI_SO2_PBL_COL_OBS_DIR}/obs_seq_omi_so2_pbl_col_${DATE}.out && ${RUN_OMI_SO2_PBL_COL_OBS} ]]; then 
          cp ${OMI_SO2_PBL_COL_OBS_DIR}/obs_seq_omi_so2_pbl_col_${DATE}.out ./obs_seq_OMI_SO2_PBL_COL_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_OMI_SO2_PBL_COL_${DATE}.out
      fi
#
# OMI HCHO TOTAL COL
      if [[ -s ${OMI_HCHO_TOTAL_COL_OBS_DIR}/obs_seq_omi_hcho_total_col_${DATE}.out && ${RUN_OMI_HCHO_TOTAL_COL_OBS} ]]; then 
         cp ${OMI_HCHO_TOTAL_COL_OBS_DIR}/obs_seq_omi_hcho_total_col_${DATE}.out ./obs_seq_OMI_HCHO_TOTAL_COL_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_OMI_HCHO_TOTAL_COL_${DATE}.out
      fi
#
# OMI HCHO TROP COL
      if [[ -s ${OMI_HCHO_TROP_COL_OBS_DIR}/obs_seq_omi_hcho_trop_col_${DATE}.out && ${RUN_OMI_HCHO_TROP_COL_OBS} ]]; then 
         cp ${OMI_HCHO_TROP_COL_OBS_DIR}/obs_seq_omi_hcho_trop_col_${DATE}.out ./obs_seq_OMI_HCHO_TROP_COL_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_OMI_HCHO_TROP_COL_${DATE}.out
      fi
#
# TROPOMI CO TOTAL COL
      if [[ -s ${TROPOMI_CO_TOTAL_COL_OBS_DIR}/obs_seq_tropomi_co_total_col_${DATE}.out && ${RUN_TROPOMI_CO_TOTAL_COL_OBS} ]]; then 
         cp ${TROPOMI_CO_TOTAL_COL_OBS_DIR}/obs_seq_tropomi_co_total_col_${DATE}.out ./obs_seq_TROPOMI_CO_TOTAL_COL_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_TROPOMI_CO_TOTAL_COL_${DATE}.out
      fi
#
# TROPOMI O3 TOTAL COL
      if [[ -s ${TROPOMI_O3_TOTAL_COL_OBS_DIR}/obs_seq_tropomi_o3_total_col_${DATE}.out && ${RUN_TROPOMI_O3_TOTAL_COL_OBS} ]]; then 
         cp ${TROPOMI_O3_TOTAL_COL_OBS_DIR}/obs_seq_tropomi_o3_total_col_${DATE}.out ./obs_seq_TROPOMI_O3_TOTAL_COL_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_TROPOMI_O3_TOTAL_COL_${DATE}.out
      fi
#
# TROPOMI O3 TROP COL
      if [[ -s ${TROPOMI_O3_TROP_COL_OBS_DIR}/obs_seq_tropomi_o3_trop_col_${DATE}.out && ${RUN_TROPOMI_O3_TROP_COL_OBS} ]]; then 
         cp ${TROPOMI_O3_TROP_COL_OBS_DIR}/obs_seq_tropomi_o3_trop_col_${DATE}.out ./obs_seq_TROPOMI_O3_TROP_COL_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_TROPOMI_O3_TROP_COL_${DATE}.out
      fi
#
# TROPOMI O3 PROFILE
      if [[ -s ${TROPOMI_O3_PROFILE_OBS_DIR}/obs_seq_tropomi_o3_profile_${DATE}.out && ${RUN_TROPOMI_O3_PROFILE_OBS} ]]; then 
         cp ${TROPOMI_O3_PROFILE_OBS_DIR}/obs_seq_tropomi_o3_profile_${DATE}.out ./obs_seq_TROPOMI_O3_PROFILE_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_TROPOMI_O3_PROFILE_${DATE}.out
      fi
#
# TROPOMI O3 CPSR
      if [[ -s ${TROPOMI_O3_CPSR_OBS_DIR}/obs_seq_tropomi_o3_cpsr_${DATE}.out && ${RUN_TROPOMI_O3_CPSR_OBS} ]]; then 
         cp ${TROPOMI_O3_CPSR_OBS_DIR}/obs_seq_tropomi_o3_cpsr_${DATE}.out ./obs_seq_TROPOMI_O3_CPSR_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_TROPOMI_O3_CPSR_${DATE}.out
      fi
#
# TROPOMI NO2 TOTAL COL
      if [[ -s ${TROPOMI_NO2_TOTAL_COL_OBS_DIR}/obs_seq_tropomi_no2_total_col_${DATE}.out && ${RUN_TROPOMI_NO2_TOTAL_COL_OBS} ]]; then 
         cp ${TROPOMI_NO2_TOTAL_COL_OBS_DIR}/obs_seq_tropomi_no2_total_col_${DATE}.out ./obs_seq_TROPOMI_NO2_TOTAL_COL_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_TROPOMI_NO2_TOTAL_COL_${DATE}.out
      fi
#
# TROPOMI NO2 TROP COL
      if [[ -s ${TROPOMI_NO2_TROP_COL_OBS_DIR}/obs_seq_tropomi_no2_trop_col_${DATE}.out && ${RUN_TROPOMI_NO2_TROP_COL_OBS} ]]; then 
         cp ${TROPOMI_NO2_TROP_COL_OBS_DIR}/obs_seq_tropomi_no2_trop_col_${DATE}.out ./obs_seq_TROPOMI_NO2_TROP_COL_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_TROPOMI_NO2_TROP_COL_${DATE}.out
      fi
#
# TROPOMI SO2_TOTAL_COL
      if [[ -s ${TROPOMI_SO2_TOTAL_COL_OBS_DIR}/obs_seq_tropomi_so2_total_col_${DATE}.out && ${RUN_TROPOMI_SO2_TOTAL_COL_OBS} ]]; then 
         cp ${TROPOMI_SO2_TOTAL_COL_OBS_DIR}/obs_seq_tropomi_so2_total_col_${DATE}.out ./obs_seq_TROPOMI_SO2_TOTAL_COL_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_TROPOMI_SO2_TOTAL_COL_${DATE}.out
      fi
#
# TROPOMI SO2 PBL COL
      if [[ -s ${TROPOMI_SO2_PBL_COL_OBS_DIR}/obs_seq_tropomi_so2_pbl_col_${DATE}.out && ${RUN_TROPOMI_SO2_PBL_COL_OBS} ]]; then 
         cp ${TROPOMI_SO2_PBL_COL_OBS_DIR}/obs_seq_tropomi_so2_pbl_col_${DATE}.out ./obs_seq_TROPOMI_SO2_PBL_COL_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_TROPOMI_SO2_PBL_COL_${DATE}.out
      fi
#
# TROPOMI CH4 TOTAL COL
      if [[ -s ${TROPOMI_CH4_TOTAL_COL_OBS_DIR}/obs_seq_tropomi_ch4_total_col_${DATE}.out && ${RUN_TROPOMI_CH4_TOTAL_COL_OBS} ]]; then 
         cp ${TROPOMI_CH4_TOTAL_COL_OBS_DIR}/obs_seq_tropomi_ch4_total_col_${DATE}.out ./obs_seq_TROPOMI_CH4_TOTAL_COL_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_TROPOMI_CH4_TOTAL_COL_${DATE}.out
      fi
#
# TROPOMI CH4 TROP COL
      if [[ -s ${TROPOMI_CH4_TROP_COL_OBS_DIR}/obs_seq_tropomi_ch4_trop_col_${DATE}.out && ${RUN_TROPOMI_CH4_TROP_COL_OBS} ]]; then 
         cp ${TROPOMI_CH4_TROP_COL_OBS_DIR}/obs_seq_tropomi_ch4_trop_col_${DATE}.out ./obs_seq_TROPOMI_CH4_TROP_COL_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_TROPOMI_CH4_TROP_COL_${DATE}.out
      fi
#
# TROPOMI CH4 PROFILE
      if [[ -s ${TROPOMI_CH4_PROFILE_OBS_DIR}/obs_seq_tropomi_ch4_profile_${DATE}.out && ${RUN_TROPOMI_CH4_PROFILE_OBS} ]]; then 
         cp ${TROPOMI_CH4_PROFILE_OBS_DIR}/obs_seq_tropomi_ch4_profile_${DATE}.out ./obs_seq_TROPOMI_CH4_PROFILE_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_TROPOMI_CH4_PROFILE_${DATE}.out
      fi
#
# TROPOMI CH4 CPSR
      if [[ -s ${TROPOMI_CH4_CPSR_OBS_DIR}/obs_seq_tropomi_ch4_cpsr_${DATE}.out && ${RUN_TROPOMI_CH4_CPSR_OBS} ]]; then 
         cp ${TROPOMI_CH4_CPSR_OBS_DIR}/obs_seq_tropomi_ch4_cpsr_${DATE}.out ./obs_seq_TROPOMI_CH4_CPSR_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_TROPOMI_CH4_CPSR_${DATE}.out
      fi
#
# TROPOMI HCHO TOTAL COL
      if [[ -s ${TROPOMI_HCHO_TOTAL_COL_OBS_DIR}/obs_seq_tropomi_hcho_total_col_${DATE}.out && ${RUN_TROPOMI_HCHO_TOTAL_COL_OBS} ]]; then 
         cp ${TROPOMI_HCHO_TOTAL_COL_OBS_DIR}/obs_seq_tropomi_hcho_total_col_${DATE}.out ./obs_seq_TROPOMI_HCHO_TOTAL_COL_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_TROPOMI_HCHO_TOTAL_COL_${DATE}.out
      fi
#
# TROPOMI HCHO TROP COL
      if [[ -s ${TROPOMI_HCHO_TROP_COL_OBS_DIR}/obs_seq_tropomi_hcho_trop_col_${DATE}.out && ${RUN_TROPOMI_HCHO_TROP_COL_OBS} ]]; then 
         cp ${TROPOMI_HCHO_TROP_COL_OBS_DIR}/obs_seq_tropomi_hcho_trop_col_${DATE}.out ./obs_seq_TROPOMI_HCHO_TROP_COL_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_TROPOMI_HCHO_TROP_COL_${DATE}.out
      fi
#
# TEMPO O3 TOTAL COL
      if [[ -s ${TEMPO_O3_TOTAL_COL_OBS_DIR}/obs_seq_tempo_o3_total_col_${DATE}.out && ${RUN_TEMPO_O3_TOTAL_COL_OBS} ]]; then 
         cp ${TEMPO_O3_TOTAL_COL_OBS_DIR}/obs_seq_tempo_o3_total_col_${DATE}.out ./obs_seq_TEMPO_O3_TOTAL_COL_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_TEMPO_O3_TOTAL_COL_${DATE}.out
      fi
#
# TEMPO O3 TROP COL
      if [[ -s ${TEMPO_O3_TROP_COL_OBS_DIR}/obs_seq_tempo_o3_trop_col_${DATE}.out && ${RUN_TEMPO_O3_TROP_COL_OBS} ]]; then 
         cp ${TEMPO_O3_TROP_COL_OBS_DIR}/obs_seq_tempo_o3_trop_col_${DATE}.out ./obs_seq_TEMPO_O3_TROP_COL_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_TEMPO_O3_TROP_COL_${DATE}.out
      fi
#
# TEMPO O3 PROFILE
      if [[ -s ${TEMPO_O3_PROFILE_OBS_DIR}/obs_seq_tempo_o3_profile_${DATE}.out && ${RUN_TEMPO_O3_PROFILE_OBS} ]]; then 
         cp ${TEMPO_O3_PROFILE_OBS_DIR}/obs_seq_tempo_o3_profile_${DATE}.out ./obs_seq_TEMPO_O3_PROFILE_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_TEMPO_O3_PROFILE_${DATE}.out
      fi
#
# TEMPO O3 CPSR
      if [[ -s ${TEMPO_O3_CPSR_OBS_DIR}/obs_seq_tempo_o3_cpsr_${DATE}.out && ${RUN_TEMPO_O3_CPSR_OBS} ]]; then 
         cp ${TEMPO_O3_CPSR_OBS_DIR}/obs_seq_tempo_o3_cpsr_${DATE}.out ./obs_seq_TEMPO_O3_CPSR_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_TEMPO_O3_CPSR_${DATE}.out
      fi
#
# TEMPO NO2 TOTAL COL
      if [[ -s ${TEMPO_NO2_TOTAL_COL_OBS_DIR}/obs_seq_tempo_no2_total_col_${DATE}.out && ${RUN_INETEMPO_NO2_TOTAL_COL_OBS} ]]; then 
         cp ${TEMPO_NO2_TOTAL_COL_OBS_DIR}/obs_seq_tempo_no2_total_col_${DATE}.out ./obs_seq_TEMPO_NO2_TOTAL_COL_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_TEMPO_NO2_TOTAL_COL_${DATE}.out
      fi
#
# TEMPO NO2 TROP COL
      if [[ -s ${TEMPO_NO2_TROP_COL_OBS_DIR}/obs_seq_tempo_no2_trop_col_${DATE}.out && ${RUN_TEMPO_NO2_TROP_COL_OBS} ]]; then 
         cp ${TEMPO_NO2_TROP_COL_OBS_DIR}/obs_seq_tempo_no2_trop_col_${DATE}.out ./obs_seq_TEMPO_NO2_TROP_COL_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_TEMPO_NO2_TROP_COL_${DATE}.out
      fi
#
# TES CO TOTAL COL
      if [[ -s ${TES_CO_TOTAL_COL_OBS_DIR}/obs_seq_tes_co_total_col_${DATE}.out && ${RUN_TES_CO_TOTAL_COL_OBS} ]]; then 
         cp ${TES_CO_TOTAL_COL_OBS_DIR}/obs_seq_tes_co_total_col_${DATE}.out ./obs_seq_TES_CO_TOTAL_COL_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_TES_CO_TOTAL_COL_${DATE}.out
      fi
#
# TES CO TROP COL
      if [[ -s ${TES_CO_TROP_COL_OBS_DIR}/obs_seq_tes_co_trop_col_${DATE}.out && ${RUN_TES_CO_TROP_COL_OBS} ]]; then 
         cp ${TES_CO_TROP_COL_OBS_DIR}/obs_seq_tes_co_trop_col_${DATE}.out ./obs_seq_TES_CO_TROP_COL_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_TES_CO_TROP_COL_${DATE}.out
      fi
#
# TES CO PROFILE
      if [[ -s ${TES_CO_PROFILE_OBS_DIR}/obs_seq_tes_co_profile_${DATE}.out && ${RUN_TES_CO_PROFILE_OBS} ]]; then 
         cp ${TES_CO_PROFILE_OBS_DIR}/obs_seq_tes_co_profile_${DATE}.out ./obs_seq_TES_CO_PROFILE_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_TES_CO_PROFILE_${DATE}.out
      fi
#
# TES CO CPSR
      if [[ -s ${TES_CO_CPSR_OBS_DIR}/obs_seq_tes_co_cpsr_${DATE}.out && ${RUN_TES_CO_CPSR_OBS} ]]; then 
         cp ${TES_CO_CPSR_OBS_DIR}/obs_seq_tes_co_cpsr_${DATE}.out ./obs_seq_TES_CO_CPSR_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_TES_CO_CPSR_${DATE}.out
      fi
#
# TES CO2 TOTAL COL
      if [[ -s ${TES_CO2_TOTAL_COL_OBS_DIR}/obs_seq_tes_co2_total_col_${DATE}.out && ${RUN_TES_CO2_TOTAL_COL_OBS} ]]; then 
         cp ${TES_CO2_TOTAL_COL_OBS_DIR}/obs_seq_tes_co2_total_col_${DATE}.out ./obs_seq_TES_CO2_TOTAL_COL_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_TES_CO2_TOTAL_COL_${DATE}.out
      fi
#
# TES CO2 TROP COL
      if [[ -s ${TES_CO2_TROP_COL_OBS_DIR}/obs_seq_tes_co2_trop_col_${DATE}.out && ${RUN_TES_CO2_TROP_COL_OBS} ]]; then 
         cp ${TES_CO2_TROP_COL_OBS_DIR}/obs_seq_tes_co2_trop_col_${DATE}.out ./obs_seq_TES_CO2_TROP_COL_${DATE}.out
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_TES_CO2_TROP_COL_${DATE}.out
      fi
#
# TES CO2 PROFILE
      if [[ -s ${TES_CO2_PROFILE_OBS_DIR}/obs_seq_tes_co2_profile_${DATE}.out && ${RUN_TES_CO2_PROFILE_OBS} ]]; then 
         cp ${TES_CO2_PROFILE_OBS_DIR}/obs_seq_tes_co2_profile_${DATE}.out ./obs_seq_TES_CO2_PROFILE_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_TES_CO2_PROFILE_${DATE}.out
      fi
#
# TES CO2 CPSR
      if [[ -s ${TES_CO2_CPSR_OBS_DIR}/obs_seq_tes_co2_cpsr_${DATE}.out && ${RUN_TES_CO2_CPSR_OBS} ]]; then 
         cp ${TES_CO2_CPSR_OBS_DIR}/obs_seq_tes_co2_cpsr_${DATE}.out ./obs_seq_TES_CO2_CPSR_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_TES_CO2_CPSR_${DATE}.out
      fi
#
# TES O3 TOTAL COL
      if [[ -s ${TES_O3_TOTAL_COL_OBS_DIR}/obs_seq_tes_o3_total_col_${DATE}.out && ${RUN_TES_O3_TOTAL_COL_OBS} ]]; then 
         cp ${TES_O3_TOTAL_COL_OBS_DIR}/obs_seq_tes_o3_total_col_${DATE}.out ./obs_seq_TES_O3_TOTAL_COL_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_TES_O3_TOTAL_COL_${DATE}.out
      fi
#
# TES O3 TROP COL
      if [[ -s ${TES_O3_TROP_COL_OBS_DIR}/obs_seq_tes_o3_trop_col_${DATE}.out && ${RUN_TES_O3_TROP_COL_OBS} ]]; then 
         cp ${TES_O3_TROP_COL_OBS_DIR}/obs_seq_tes_o3_trop_col_${DATE}.out ./obs_seq_TES_O3_TROP_COL_${DATE}.out
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_TES_O3_TROP_COL_${DATE}.out
      fi
#
# TES O3 PROFILE
      if [[ -s ${TES_O3_PROFILE_OBS_DIR}/obs_seq_tes_o3_profile_${DATE}.out && ${RUN_TES_O3_PROFILE_OBS} ]]; then 
         cp ${TES_O3_PROFILE_OBS_DIR}/obs_seq_tes_o3_profile_${DATE}.out ./obs_seq_TES_O3_PROFILE_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_TES_O3_PROFILE_${DATE}.out
      fi
#
# TES O3 CPSR
      if [[ -s ${TES_O3_CPSR_OBS_DIR}/obs_seq_tes_o3_cpsr_${DATE}.out && ${RUN_TES_O3_CPSR_OBS} ]]; then 
         cp ${TES_O3_CPSR_OBS_DIR}/obs_seq_tes_o3_cpsr_${DATE}.out ./obs_seq_TES_O3_CPSR_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_TES_O3_CPSR_${DATE}.out
      fi
#
# TES NH3 TOTAL COL
      if [[ -s ${TES_NH3_TOTAL_COL_OBS_DIR}/obs_seq_tes_nh3_total_col_${DATE}.out && ${RUN_TES_NH3_TOTAL_COL_OBS} ]]; then 
         cp ${TES_NH3_TOTAL_COL_OBS_DIR}/obs_seq_tes_nh3_total_col_${DATE}.out ./obs_seq_TES_NH3_TOTAL_COL_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_TES_NH3_TOTAL_COL_${DATE}.out
      fi
#
# TES NH3 TROP COL
      if [[ -s ${TES_NH3_TROP_COL_OBS_DIR}/obs_seq_tes_nh3_trop_col_${DATE}.out && ${RUN_TES_NH3_TROP_COL_OBS} ]]; then 
         cp ${TES_NH3_TROP_COL_OBS_DIR}/obs_seq_tes_nh3_trop_col_${DATE}.out ./obs_seq_TES_NH3_TROP_COL_${DATE}.out
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_TES_NH3_TROP_COL_${DATE}.out
      fi
#
# TES NH3 PROFILE
      if [[ -s ${TES_NH3_PROFILE_OBS_DIR}/obs_seq_tes_nh3_profile_${DATE}.out && ${RUN_TES_NH3_PROFILE_OBS} ]]; then 
         cp ${TES_NH3_PROFILE_OBS_DIR}/obs_seq_tes_nh3_profile_${DATE}.out ./obs_seq_TES_NH3_PROFILE_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_TES_NH3_PROFILE_${DATE}.out
      fi
#
# TES NH3 CPSR
      if [[ -s ${TES_NH3_CPSR_OBS_DIR}/obs_seq_tes_nh3_cpsr_${DATE}.out && ${RUN_TES_NH3_CPSR_OBS} ]]; then 
         cp ${TES_NH3_CPSR_OBS_DIR}/obs_seq_tes_nh3_cpsr_${DATE}.out ./obs_seq_TES_NH3_CPSR_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_TES_NH3_CPSR_${DATE}.out
      fi
#
# TES CH4 TOTAL CH4L
      if [[ -s ${TES_CH4_TOTAL_COL_OBS_DIR}/obs_seq_tes_ch4_total_col_${DATE}.out && ${RUN_TES_CH4_TOTAL_COL_OBS} ]]; then 
         cp ${TES_CH4_TOTAL_COL_OBS_DIR}/obs_seq_tes_ch4_total_col_${DATE}.out ./obs_seq_TES_CH4_TOTAL_COL_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_TES_CH4_TOTAL_COL_${DATE}.out
      fi
#
# TES CH4 TROP COL
      if [[ -s ${TES_CH4_TROP_COL_OBS_DIR}/obs_seq_tes_ch4_trop_col_${DATE}.out && ${RUN_TES_CH4_TROP_COL_OBS} ]]; then 
         cp ${TES_CH4_TROP_COL_OBS_DIR}/obs_seq_tes_ch4_trop_col_${DATE}.out ./obs_seq_TES_CH4_TROP_COL_${DATE}.out
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_TES_CH4_TROP_COL_${DATE}.out
      fi
#
# TES CH4 PROFILE
      if [[ -s ${TES_CH4_PROFILE_OBS_DIR}/obs_seq_tes_ch4_profile_${DATE}.out && ${RUN_TES_CH4_PROFILE_OBS} ]]; then 
         cp ${TES_CH4_PROFILE_OBS_DIR}/obs_seq_tes_ch4_profile_${DATE}.out ./obs_seq_TES_CH4_PROFILE_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_TES_CH4_PROFILE_${DATE}.out
      fi
#
# TES CH4 CPSR
      if [[ -s ${TES_CH4_CPSR_OBS_DIR}/obs_seq_tes_ch4_cpsr_${DATE}.out && ${RUN_TES_CH4_CPSR_OBS} ]]; then 
         cp ${TES_CH4_CPSR_OBS_DIR}/obs_seq_tes_ch4_cpsr_${DATE}.out ./obs_seq_TES_CH4_CPSR_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_TES_CH4_CPSR_${DATE}.out
      fi
#
# CRIS CO TOTAL COL
      if [[ -s ${CRIS_CO_TOTAL_COL_OBS_DIR}/obs_seq_cris_co_total_col_${DATE}.out && ${RUN_CRIS_CO_TOTAL_COL_OBS} ]]; then 
         cp ${CRIS_CO_TOTAL_COL_OBS_DIR}/obs_seq_cris_co_total_col_${DATE}.out ./obs_seq_CRIS_CO_TOTAL_COL_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_CRIS_CO_TOTAL_COL_${DATE}.out
      fi
#
# CRIS CO PROFILE
      if [[ -s ${CRIS_CO_PROFILE_OBS_DIR}/obs_seq_cris_co_profile_${DATE}.out && ${RUN_CRIS_CO_PROFILE_OBS} ]]; then 
         cp ${CRIS_CO_PROFILE_OBS_DIR}/obs_seq_cris_co_profile_${DATE}.out ./obs_seq_CRIS_CO_PROFILE_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_CRIS_CO_PROFILE_${DATE}.out
      fi
#
# CRIS CO CPSR
      if [[ -s ${CRIS_CO_CPSR_OBS_DIR}/obs_seq_cris_co_cpsr_${DATE}.out && ${RUN_CRIS_CO_CPSR_OBS} ]]; then 
         cp ${CRIS_CO_CPSR_OBS_DIR}/obs_seq_cris_co_cpsr_${DATE}.out ./obs_seq_CRIS_CO_CPSR_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_CRIS_CO_CPSR_${DATE}.out
      fi
#
# CRIS O3 TOTAL COL
      if [[ -s ${CRIS_O3_TOTAL_COL_OBS_DIR}/obs_seq_cris_o3_total_col_${DATE}.out && ${RUN_CRIS_O3_TOTAL_COL_OBS} ]]; then 
         cp ${CRIS_O3_TOTAL_COL_OBS_DIR}/obs_seq_cris_o3_total_col_${DATE}.out ./obs_seq_CRIS_O3_TOTAL_COL_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_CRIS_O3_TOTAL_COL_${DATE}.out
      fi
#
# CRIS O3 PROFILE
      if [[ -s ${CRIS_O3_PROFILE_OBS_DIR}/obs_seq_cris_o3_profile_${DATE}.out && ${RUN_CRIS_O3_PROFILE_OBS} ]]; then 
         cp ${CRIS_O3_PROFILE_OBS_DIR}/obs_seq_cris_o3_profile_${DATE}.out ./obs_seq_CRIS_O3_PROFILE_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_CRIS_O3_PROFILE_${DATE}.out
      fi
#
# CRIS O3 CPSR
      if [[ -s ${CRIS_O3_CPSR_OBS_DIR}/obs_seq_cris_o3_cpsr_${DATE}.out && ${RUN_CRIS_O3_CPSR_OBS} ]]; then 
         cp ${CRIS_O3_CPSR_OBS_DIR}/obs_seq_cris_o3_cpsr_${DATE}.out ./obs_seq_CRIS_O3_CPSR_${DATE}.out
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_CRIS_O3_CPSR_${DATE}.out
      fi
#
# CRIS NH3 TOTAL COL
      if [[ -s ${CRIS_NH3_TOTAL_COL_OBS_DIR}/obs_seq_cris_nh3_total_col_${DATE}.out && ${RUN_CRIS_NH3_TOTAL_COL_OBS} ]]; then 
         cp ${CRIS_NH3_TOTAL_COL_OBS_DIR}/obs_seq_cris_nh3_total_col_${DATE}.out ./obs_seq_CRIS_NH3_TOTAL_COL_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_CRIS_NH3_TOTAL_COL_${DATE}.out
      fi
#
# CRIS NH3 PROFILE
      if [[ -s ${CRIS_NH3_PROFILE_OBS_DIR}/obs_seq_cris_nh3_profile_${DATE}.out && ${RUN_CRIS_NH3_PROFILE_OBS} ]]; then 
         cp ${CRIS_NH3_PROFILE_OBS_DIR}/obs_seq_cris_nh3_profile_${DATE}.out ./obs_seq_CRIS_NH3_PROFILE_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_CRIS_NH3_PROFILE_${DATE}.out
      fi
#
# CRIS NH3 CPSR
      if [[ -s ${CRIS_NH3_CPSR_OBS_DIR}/obs_seq_cris_nh3_cpsr_${DATE}.out && ${RUN_CRIS_NH3_CPSR_OBS} ]]; then 
         cp ${CRIS_NH3_CPSR_OBS_DIR}/obs_seq_cris_nh3_cpsr_${DATE}.out ./obs_seq_CRIS_NH3_CPSR_${DATE}.out
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_CRIS_NH3_CPSR_${DATE}.out
      fi
#
# CRIS CH4 TOTAL CH4L
      if [[ -s ${CRIS_CH4_TOTAL_COL_OBS_DIR}/obs_seq_cris_ch4_total_col_${DATE}.out && ${RUN_CRIS_CH4_TOTAL_COL_OBS} ]]; then 
         cp ${CRIS_CH4_TOTAL_COL_OBS_DIR}/obs_seq_cris_ch4_total_col_${DATE}.out ./obs_seq_CRIS_CH4_TOTAL_COL_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_CRIS_CH4_TOTAL_COL_${DATE}.out
      fi
#
# CRIS CH4 PROFILE
      if [[ -s ${CRIS_CH4_PROFILE_OBS_DIR}/obs_seq_cris_ch4_profile_${DATE}.out && ${RUN_CRIS_CH4_PROFILE_OBS} ]]; then 
         cp ${CRIS_CH4_PROFILE_OBS_DIR}/obs_seq_cris_ch4_profile_${DATE}.out ./obs_seq_CRIS_CH4_PROFILE_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_CRIS_CH4_PROFILE_${DATE}.out
      fi
#
# CRIS CH4 CPSR
      if [[ -s ${CRIS_CH4_CPSR_OBS_DIR}/obs_seq_cris_ch4_cpsr_${DATE}.out && ${RUN_CRIS_CH4_CPSR_OBS} ]]; then 
         cp ${CRIS_CH4_CPSR_OBS_DIR}/obs_seq_cris_ch4_cpsr_${DATE}.out ./obs_seq_CRIS_CH4_CPSR_${DATE}.out
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_CRIS_CH4_CPSR_${DATE}.out
      fi
#
# CRIS PAN TOTAL COL
      if [[ -s ${CRIS_PAN_TOTAL_COL_OBS_DIR}/obs_seq_cris_pan_total_col_${DATE}.out && ${RUN_CRIS_PAN_TOTAL_COL_OBS} ]]; then 
         cp ${CRIS_PAN_TOTAL_COL_OBS_DIR}/obs_seq_cris_pan_total_col_${DATE}.out ./obs_seq_CRIS_PAN_TOTAL_COL_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_CRIS_PAN_TOTAL_COL_${DATE}.out
      fi
#
# CRIS PAN PROFILE
      if [[ -s ${CRIS_PAN_PROFILE_OBS_DIR}/obs_seq_cris_pan_profile_${DATE}.out && ${RUN_CRIS_PAN_PROFILE_OBS} ]]; then 
         cp ${CRIS_PAN_PROFILE_OBS_DIR}/obs_seq_cris_pan_profile_${DATE}.out ./obs_seq_CRIS_PAN_PROFILE_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_CRIS_PAN_PROFILE_${DATE}.out
      fi
#
# CRIS PAN CPSR
      if [[ -s ${CRIS_PAN_CPSR_OBS_DIR}/obs_seq_cris_pan_cpsr_${DATE}.out && ${RUN_CRIS_PAN_CPSR_OBS} ]]; then 
         cp ${CRIS_PAN_CPSR_OBS_DIR}/obs_seq_cris_pan_cpsr_${DATE}.out ./obs_seq_CRIS_PAN_CPSR_${DATE}.out
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_CRIS_PAN_CPSR_${DATE}.out
      fi
#
# GOME2A NO2 TOTAL COL
      if [[ -s ${GOME2A_NO2_TOTAL_COL_OBS_DIR}/obs_seq_gome2a_no2_total_col_${DATE}.out && ${RUN_GOME2A_NO2_TOTAL_COL_OBS} ]]; then 
         cp ${GOME2A_NO2_TOTAL_COL_OBS_DIR}/obs_seq_gome2a_no2_total_col_${DATE}.out ./obs_seq_GOME2A_NO2_TOTAL_COL_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_GOME2A_NO2_TOTAL_COL_${DATE}.out
      fi
#
# GOME2A NO2 TROP COL
      if [[ -s ${GOME2A_NO2_TROP_COL_OBS_DIR}/obs_seq_gome2a_no2_trop_col_${DATE}.out && ${RUN_GOME2A_NO2_TROP_COL_OBS} ]]; then 
         cp ${GOME2A_NO2_TROP_COL_OBS_DIR}/obs_seq_gome2a_no2_trop_col_${DATE}.out ./obs_seq_GOME2A_NO2_TROP_COL_${DATE}.out
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_GOME2A_NO2_TROP_COL_${DATE}.out
      fi
#
# SCIAM NO2 TOTAL COL
      if [[ -s ${SCIAM_NO2_TOTAL_COL_OBS_DIR}/obs_seq_sciam_no2_total_col_${DATE}.out && ${RUN_SCIAM_NO2_TOTAL_COL_OBS} ]]; then 
         cp ${SCIAM_NO2_TOTAL_COL_OBS_DIR}/obs_seq_sciam_no2_total_col_${DATE}.out ./obs_seq_SCIAM_NO2_TOTAL_COL_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_SCIAM_NO2_TOTAL_COL_${DATE}.out
      fi
#
# SCIAM NO2 TROP COL
      if [[ -s ${SCIAM_NO2_TROP_COL_OBS_DIR}/obs_seq_sciam_no2_trop_col_${DATE}.out && ${RUN_SCIAM_NO2_TROP_COL_OBS} ]]; then 
         cp ${SCIAM_NO2_TROP_COL_OBS_DIR}/obs_seq_sciam_no2_trop_col_${DATE}.out ./obs_seq_SCIAM_NO2_TROP_COL_${DATE}.out
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_SCIAM_NO2_TROP_COL_${DATE}.out
      fi
#
# MLS O3 TOTAL COL
      if [[ -s ${MLS_O3_TOTAL_COL_OBS_DIR}/obs_seq_mls_o3_total_col_${DATE}.out && ${RUN_MLS_O3_TOTAL_COL_OBS} ]]; then 
         cp ${MLS_O3_TOTAL_COL_OBS_DIR}/obs_seq_mls_o3_total_col_${DATE}.out ./obs_seq_MLS_O3_TOTAL_COL_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_MLS_O3_TOTAL_COL_${DATE}.out
      fi
#
# MLS O3 PROFILE
      if [[ -s ${MLS_O3_PROFILE_OBS_DIR}/obs_seq_mls_o3_profile_${DATE}.out && ${RUN_MLS_O3_PROFILE_OBS} ]]; then 
         cp ${MLS_O3_PROFILE_OBS_DIR}/obs_seq_mls_o3_profile_${DATE}.out ./obs_seq_MLS_O3_PROFILE_${DATE}.out
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_MLS_O3_PROFILE_${DATE}.out
      fi
#
# MLS O3 CPSR
      if [[ -s ${MLS_O3_CPSR_OBS_DIR}/obs_seq_mls_o3_cpsr_${DATE}.out && ${RUN_MLS_O3_CPSR_OBS} ]]; then 
         cp ${MLS_O3_CPSR_OBS_DIR}/obs_seq_mls_o3_cpsr_${DATE}.out ./obs_seq_MLS_O3_CPSR_${DATE}.out
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_MLS_O3_CPSR_${DATE}.out
      fi
#
# MLS HNO3 TOTAL COL
      if [[ -s ${MLS_HNO3_TOTAL_COL_OBS_DIR}/obs_seq_mls_hno3_total_col_${DATE}.out && ${RUN_MLS_HNO3_TOTAL_COL_OBS} ]]; then 
         cp ${MLS_HNO3_TOTAL_COL_OBS_DIR}/obs_seq_mls_hno3_total_col_${DATE}.out ./obs_seq_MLS_HNO3_TOTAL_COL_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_MLS_HNO3_TOTAL_COL_${DATE}.out
      fi
#
# MLS HNO3 PROFILE
      if [[ -s ${MLS_HNO3_PROFILE_OBS_DIR}/obs_seq_mls_hno3_profile_${DATE}.out && ${RUN_MLS_HNO3_PROFILE_OBS} ]]; then 
         cp ${MLS_HNO3_PROFILE_OBS_DIR}/obs_seq_mls_hno3_profile_${DATE}.out ./obs_seq_MLS_HNO3_PROFILE_${DATE}.out
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_MLS_HNO3_PROFILE_${DATE}.out
      fi
#
# MLS HNO3 CPSR
      if [[ -s ${MLS_HNO3_CPSR_OBS_DIR}/obs_seq_mls_hno3_cpsr_${DATE}.out && ${RUN_MLS_HNO3_CPSR_OBS} ]]; then 
         cp ${MLS_HNO3_CPSR_OBS_DIR}/obs_seq_mls_hno3_cpsr_${DATE}.out ./obs_seq_MLS_HNO3_CPSR_${DATE}.out
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_MLS_HNO3_CPSR_${DATE}.out
      fi
#
# OMI NO2 DOMINO TOTAL COL
      if [[ -s ${OMI_NO2_DOMINO_TOTAL_COL_OBS_DIR}/obs_seq_omi_no2_domino_total_col_${DATE}.out && ${RUN_OMI_NO2_DOMINO_TOTAL_COL_OBS} ]]; then 
         cp ${OMI_NO2_DOMINO_TOTAL_COL_OBS_DIR}/obs_seq_omi_no2_domino_total_col_${DATE}.out ./obs_seq_OMI_NO2_DOMINO_TOTAL_COL_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_OMI_NO2_DOMINO_TOTAL_COL_${DATE}.out
      fi
#
# OMI NO2 DOMINO TROP COL
      if [[ -s ${OMI_NO2_DOMINO_TROP_COL_OBS_DIR}/obs_seq_omi_no2_domino_trop_col_${DATE}.out && ${RUN_OMI_NO2_DOMINO_TROP_COL_OBS} ]]; then 
         cp ${OMI_NO2_DOMINO_TROP_COL_OBS_DIR}/obs_seq_omi_no2_domino_trop_col_${DATE}.out ./obs_seq_OMI_NO2_DOMINO_TROP_COL_${DATE}.out
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_OMI_NO2_DOMINO_TROP_COL_${DATE}.out
      fi
#
# AIRNOW CO
      if [[ -s ${AIRNOW_CO_OBS_DIR}/obs_seq_airnow_co_${DATE}.out && ${RUN_AIRNOW_CO_OBS} ]]; then 
         cp ${AIRNOW_CO_OBS_DIR}/obs_seq_airnow_co_${DATE}.out ./obs_seq_AIR_CO_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_AIR_CO_${DATE}.out
      fi
#
# AIRNOW O3
      if [[ -s ${AIRNOW_O3_OBS_DIR}/obs_seq_airnow_o3_${DATE}.out && ${RUN_AIRNOW_O3_OBS} ]]; then 
         cp ${AIRNOW_O3_OBS_DIR}/obs_seq_airnow_o3_${DATE}.out ./obs_seq_AIR_O3_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_AIR_O3_${DATE}.out
      fi
#
# AIRNOW NO2
      if [[ -s ${AIRNOW_NO2_OBS_DIR}/obs_seq_airnow_no2_${DATE}.out && ${RUN_AIRNOW_NO2_OBS} ]]; then 
         cp ${AIRNOW_NO2_OBS_DIR}/obs_seq_airnow_no2_${DATE}.out ./obs_seq_AIR_NO2_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_AIR_NO2_${DATE}.out
      fi
#
# AIRNOW SO2
      if [[ -s ${AIRNOW_SO2_OBS_DIR}/obs_seq_airnow_so2_${DATE}.out && ${RUN_AIRNOW_SO2_OBS} ]]; then 
         cp ${AIRNOW_SO2_OBS_DIR}/obs_seq_airnow_so2_${DATE}.out ./obs_seq_AIR_SO2_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_AIR_SO2_${DATE}.out
      fi
#
# AIRNOW PM10
      if [[ -s ${AIRNOW_PM10_OBS_DIR}/obs_seq_airnow_pm10_${DATE}.out && ${RUN_AIRNOW_PM10_OBS} ]]; then 
         cp ${AIRNOW_PM10_OBS_DIR}/obs_seq_airnow_pm10_${DATE}.out ./obs_seq_AIR_PM10_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_AIR_PM10_${DATE}.out
      fi
#
# AIRNOW PM25
      if [[ -s ${AIRNOW_PM25_OBS_DIR}/obs_seq_airnow_pm25_${DATE}.out && ${RUN_AIRNOW_PM25_OBS} ]]; then 
         cp ${AIRNOW_PM25_OBS_DIR}/obs_seq_airnow_pm25_${DATE}.out ./obs_seq_AIR_PM25_${DATE}.out   
         (( NUM_FILES=${NUM_FILES}+1 ))
         export FILE_LIST[${NUM_FILES}]=obs_seq_AIR_PM25_${DATE}.out
      fi
      export NL_NUM_INPUT_FILES=${NUM_FILES}
#
# All files present
      if [[ ${NL_NUM_INPUT_FILES} -eq 97 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]},\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]},\'${FILE_LIST[25]},\'${FILE_LIST[26]},\'${FILE_LIST[27]},\'${FILE_LIST[28]},\'${FILE_LIST[29]},\'${FILE_LIST[30]},\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\',\'${FILE_LIST[49]}\',\'${FILE_LIST[50]}\',\'${FILE_LIST[51]}\',\'${FILE_LIST[52]}\',\'${FILE_LIST[53]}\',\'${FILE_LIST[54]}\',\'${FILE_LIST[55]}\',\'${FILE_LIST[56]}\',\'${FILE_LIST[57]}\',\'${FILE_LIST[58]}\',\'${FILE_LIST[59]}\',\'${FILE_LIST[60]}\',\'${FILE_LIST[61]}\',\'${FILE_LIST[62]}\',\'${FILE_LIST[63]}\',\'${FILE_LIST[64]}\',\'${FILE_LIST[65]}\',\'${FILE_LIST[66]}\',\'${FILE_LIST[67]}\',\'${FILE_LIST[68]}\',\'${FILE_LIST[69]}\',\'${FILE_LIST[70]}\',\'${FILE_LIST[71]}\',\'${FILE_LIST[72]}\',\'${FILE_LIST[73]}\',\'${FILE_LIST[74]}\',\'${FILE_LIST[75]}\',\'${FILE_LIST[76]}\',\'${FILE_LIST[77]}\',\'${FILE_LIST[78]}\',\'${FILE_LIST[79]}\',\'${FILE_LIST[80]}\',\'${FILE_LIST[81]}\',\'${FILE_LIST[82]}\',\'${FILE_LIST[83]}\',\'${FILE_LIST[84]}\',\'${FILE_LIST[85]}\',\'${FILE_LIST[86]}\',\'${FILE_LIST[87]}\',\'${FILE_LIST[88]}\',\'${FILE_LIST[89]}\',\'${FILE_LIST[90]}\',\'${FILE_LIST[91]}\',\'${FILE_LIST[92]}\',\'${FILE_LIST[93]}\',\'${FILE_LIST[94]}\',\'${FILE_LIST[95]}\',\'${FILE_LIST[96]}\',\'${FILE_LIST[97]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 96 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]},\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]},\'${FILE_LIST[25]},\'${FILE_LIST[26]},\'${FILE_LIST[27]},\'${FILE_LIST[28]},\'${FILE_LIST[29]},\'${FILE_LIST[30]},\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\',\'${FILE_LIST[49]}\',\'${FILE_LIST[50]}\',\'${FILE_LIST[51]}\',\'${FILE_LIST[52]}\',\'${FILE_LIST[53]}\',\'${FILE_LIST[54]}\',\'${FILE_LIST[55]}\',\'${FILE_LIST[56]}\',\'${FILE_LIST[57]}\',\'${FILE_LIST[58]}\',\'${FILE_LIST[59]}\',\'${FILE_LIST[60]}\',\'${FILE_LIST[61]}\',\'${FILE_LIST[62]}\',\'${FILE_LIST[63]}\',\'${FILE_LIST[64]}\',\'${FILE_LIST[65]}\',\'${FILE_LIST[66]}\',\'${FILE_LIST[67]}\',\'${FILE_LIST[68]}\',\'${FILE_LIST[69]}\',\'${FILE_LIST[70]}\',\'${FILE_LIST[71]}\',\'${FILE_LIST[72]}\',\'${FILE_LIST[73]}\',\'${FILE_LIST[74]}\',\'${FILE_LIST[75]}\',\'${FILE_LIST[76]}\',\'${FILE_LIST[77]}\',\'${FILE_LIST[78]}\',\'${FILE_LIST[79]}\',\'${FILE_LIST[80]}\',\'${FILE_LIST[81]}\',\'${FILE_LIST[82]}\',\'${FILE_LIST[83]}\',\'${FILE_LIST[84]}\',\'${FILE_LIST[85]}\',\'${FILE_LIST[86]}\',\'${FILE_LIST[87]}\',\'${FILE_LIST[88]}\',\'${FILE_LIST[89]}\',\'${FILE_LIST[90]}\',\'${FILE_LIST[91]}\',\'${FILE_LIST[92]}\',\'${FILE_LIST[93]}\',\'${FILE_LIST[94]}\',\'${FILE_LIST[95]}\',\'${FILE_LIST[96]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 95 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]},\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]},\'${FILE_LIST[25]},\'${FILE_LIST[26]},\'${FILE_LIST[27]},\'${FILE_LIST[28]},\'${FILE_LIST[29]},\'${FILE_LIST[30]},\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\',\'${FILE_LIST[49]}\',\'${FILE_LIST[50]}\',\'${FILE_LIST[51]}\',\'${FILE_LIST[52]}\',\'${FILE_LIST[53]}\',\'${FILE_LIST[54]}\',\'${FILE_LIST[55]}\',\'${FILE_LIST[56]}\',\'${FILE_LIST[57]}\',\'${FILE_LIST[58]}\',\'${FILE_LIST[59]}\',\'${FILE_LIST[60]}\',\'${FILE_LIST[61]}\',\'${FILE_LIST[62]}\',\'${FILE_LIST[63]}\',\'${FILE_LIST[64]}\',\'${FILE_LIST[65]}\',\'${FILE_LIST[66]}\',\'${FILE_LIST[67]}\',\'${FILE_LIST[68]}\',\'${FILE_LIST[69]}\',\'${FILE_LIST[70]}\',\'${FILE_LIST[71]}\',\'${FILE_LIST[72]}\',\'${FILE_LIST[73]}\',\'${FILE_LIST[74]}\',\'${FILE_LIST[75]}\',\'${FILE_LIST[76]}\',\'${FILE_LIST[77]}\',\'${FILE_LIST[78]}\',\'${FILE_LIST[79]}\',\'${FILE_LIST[80]}\',\'${FILE_LIST[81]}\',\'${FILE_LIST[82]}\',\'${FILE_LIST[83]}\',\'${FILE_LIST[84]}\',\'${FILE_LIST[85]}\',\'${FILE_LIST[86]}\',\'${FILE_LIST[87]}\',\'${FILE_LIST[88]}\',\'${FILE_LIST[89]}\',\'${FILE_LIST[90]}\',\'${FILE_LIST[91]}\',\'${FILE_LIST[92]}\',\'${FILE_LIST[93]}\',\'${FILE_LIST[94]}\',\'${FILE_LIST[95]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 94 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]},\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]},\'${FILE_LIST[25]},\'${FILE_LIST[26]},\'${FILE_LIST[27]},\'${FILE_LIST[28]},\'${FILE_LIST[29]},\'${FILE_LIST[30]},\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\',\'${FILE_LIST[49]}\',\'${FILE_LIST[50]}\',\'${FILE_LIST[51]}\',\'${FILE_LIST[52]}\',\'${FILE_LIST[53]}\',\'${FILE_LIST[54]}\',\'${FILE_LIST[55]}\',\'${FILE_LIST[56]}\',\'${FILE_LIST[57]}\',\'${FILE_LIST[58]}\',\'${FILE_LIST[59]}\',\'${FILE_LIST[60]}\',\'${FILE_LIST[61]}\',\'${FILE_LIST[62]}\',\'${FILE_LIST[63]}\',\'${FILE_LIST[64]}\',\'${FILE_LIST[65]}\',\'${FILE_LIST[66]}\',\'${FILE_LIST[67]}\',\'${FILE_LIST[68]}\',\'${FILE_LIST[69]}\',\'${FILE_LIST[70]}\',\'${FILE_LIST[71]}\',\'${FILE_LIST[72]}\',\'${FILE_LIST[73]}\',\'${FILE_LIST[74]}\',\'${FILE_LIST[75]}\',\'${FILE_LIST[76]}\',\'${FILE_LIST[77]}\',\'${FILE_LIST[78]}\',\'${FILE_LIST[79]}\',\'${FILE_LIST[80]}\',\'${FILE_LIST[81]}\',\'${FILE_LIST[82]}\',\'${FILE_LIST[83]}\',\'${FILE_LIST[84]}\',\'${FILE_LIST[85]}\',\'${FILE_LIST[86]}\',\'${FILE_LIST[87]}\',\'${FILE_LIST[88]}\',\'${FILE_LIST[89]}\',\'${FILE_LIST[90]}\',\'${FILE_LIST[91]}\',\'${FILE_LIST[92]}\',\'${FILE_LIST[93]}\',\'${FILE_LIST[94]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 93 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]},\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]},\'${FILE_LIST[25]},\'${FILE_LIST[26]},\'${FILE_LIST[27]},\'${FILE_LIST[28]},\'${FILE_LIST[29]},\'${FILE_LIST[30]},\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\',\'${FILE_LIST[49]}\',\'${FILE_LIST[50]}\',\'${FILE_LIST[51]}\',\'${FILE_LIST[52]}\',\'${FILE_LIST[53]}\',\'${FILE_LIST[54]}\',\'${FILE_LIST[55]}\',\'${FILE_LIST[56]}\',\'${FILE_LIST[57]}\',\'${FILE_LIST[58]}\',\'${FILE_LIST[59]}\',\'${FILE_LIST[60]}\',\'${FILE_LIST[61]}\',\'${FILE_LIST[62]}\',\'${FILE_LIST[63]}\',\'${FILE_LIST[64]}\',\'${FILE_LIST[65]}\',\'${FILE_LIST[66]}\',\'${FILE_LIST[67]}\',\'${FILE_LIST[68]}\',\'${FILE_LIST[69]}\',\'${FILE_LIST[70]}\',\'${FILE_LIST[71]}\',\'${FILE_LIST[72]}\',\'${FILE_LIST[73]}\',\'${FILE_LIST[74]}\',\'${FILE_LIST[75]}\',\'${FILE_LIST[76]}\',\'${FILE_LIST[77]}\',\'${FILE_LIST[78]}\',\'${FILE_LIST[79]}\',\'${FILE_LIST[80]}\',\'${FILE_LIST[81]}\',\'${FILE_LIST[82]}\',\'${FILE_LIST[83]}\',\'${FILE_LIST[84]}\',\'${FILE_LIST[85]}\',\'${FILE_LIST[86]}\',\'${FILE_LIST[87]}\',\'${FILE_LIST[88]}\',\'${FILE_LIST[89]}\',\'${FILE_LIST[90]}\',\'${FILE_LIST[91]}\',\'${FILE_LIST[92]}\',\'${FILE_LIST[93]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 92 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]},\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]},\'${FILE_LIST[25]},\'${FILE_LIST[26]},\'${FILE_LIST[27]},\'${FILE_LIST[28]},\'${FILE_LIST[29]},\'${FILE_LIST[30]},\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\',\'${FILE_LIST[49]}\',\'${FILE_LIST[50]}\',\'${FILE_LIST[51]}\',\'${FILE_LIST[52]}\',\'${FILE_LIST[53]}\',\'${FILE_LIST[54]}\',\'${FILE_LIST[55]}\',\'${FILE_LIST[56]}\',\'${FILE_LIST[57]}\',\'${FILE_LIST[58]}\',\'${FILE_LIST[59]}\',\'${FILE_LIST[60]}\',\'${FILE_LIST[61]}\',\'${FILE_LIST[62]}\',\'${FILE_LIST[63]}\',\'${FILE_LIST[64]}\',\'${FILE_LIST[65]}\',\'${FILE_LIST[66]}\',\'${FILE_LIST[67]}\',\'${FILE_LIST[68]}\',\'${FILE_LIST[69]}\',\'${FILE_LIST[70]}\',\'${FILE_LIST[71]}\',\'${FILE_LIST[72]}\',\'${FILE_LIST[73]}\',\'${FILE_LIST[74]}\',\'${FILE_LIST[75]}\',\'${FILE_LIST[76]}\',\'${FILE_LIST[77]}\',\'${FILE_LIST[78]}\',\'${FILE_LIST[79]}\',\'${FILE_LIST[80]}\',\'${FILE_LIST[81]}\',\'${FILE_LIST[82]}\',\'${FILE_LIST[83]}\',\'${FILE_LIST[84]}\',\'${FILE_LIST[85]}\',\'${FILE_LIST[86]}\',\'${FILE_LIST[87]}\',\'${FILE_LIST[88]}\',\'${FILE_LIST[89]}\',\'${FILE_LIST[90]}\',\'${FILE_LIST[91]}\',\'${FILE_LIST[92]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 91 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]},\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]},\'${FILE_LIST[25]},\'${FILE_LIST[26]},\'${FILE_LIST[27]},\'${FILE_LIST[28]},\'${FILE_LIST[29]},\'${FILE_LIST[30]},\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\',\'${FILE_LIST[49]}\',\'${FILE_LIST[50]}\',\'${FILE_LIST[51]}\',\'${FILE_LIST[52]}\',\'${FILE_LIST[53]}\',\'${FILE_LIST[54]}\',\'${FILE_LIST[55]}\',\'${FILE_LIST[56]}\',\'${FILE_LIST[57]}\',\'${FILE_LIST[58]}\',\'${FILE_LIST[59]}\',\'${FILE_LIST[60]}\',\'${FILE_LIST[61]}\',\'${FILE_LIST[62]}\',\'${FILE_LIST[63]}\',\'${FILE_LIST[64]}\',\'${FILE_LIST[65]}\',\'${FILE_LIST[66]}\',\'${FILE_LIST[67]}\',\'${FILE_LIST[68]}\',\'${FILE_LIST[69]}\',\'${FILE_LIST[70]}\',\'${FILE_LIST[71]}\',\'${FILE_LIST[72]}\',\'${FILE_LIST[73]}\',\'${FILE_LIST[74]}\',\'${FILE_LIST[75]}\',\'${FILE_LIST[76]}\',\'${FILE_LIST[77]}\',\'${FILE_LIST[78]}\',\'${FILE_LIST[79]}\',\'${FILE_LIST[80]}\',\'${FILE_LIST[81]}\',\'${FILE_LIST[82]}\',\'${FILE_LIST[83]}\',\'${FILE_LIST[84]}\',\'${FILE_LIST[85]}\',\'${FILE_LIST[86]}\',\'${FILE_LIST[87]}\',\'${FILE_LIST[88]}\',\'${FILE_LIST[89]}\',\'${FILE_LIST[90]}\',\'${FILE_LIST[91]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 90 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]},\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]},\'${FILE_LIST[25]},\'${FILE_LIST[26]},\'${FILE_LIST[27]},\'${FILE_LIST[28]},\'${FILE_LIST[29]},\'${FILE_LIST[30]},\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\',\'${FILE_LIST[49]}\',\'${FILE_LIST[50]}\',\'${FILE_LIST[51]}\',\'${FILE_LIST[52]}\',\'${FILE_LIST[53]}\',\'${FILE_LIST[54]}\',\'${FILE_LIST[55]}\',\'${FILE_LIST[56]}\',\'${FILE_LIST[57]}\',\'${FILE_LIST[58]}\',\'${FILE_LIST[59]}\',\'${FILE_LIST[60]}\',\'${FILE_LIST[61]}\',\'${FILE_LIST[62]}\',\'${FILE_LIST[63]}\',\'${FILE_LIST[64]}\',\'${FILE_LIST[65]}\',\'${FILE_LIST[66]}\',\'${FILE_LIST[67]}\',\'${FILE_LIST[68]}\',\'${FILE_LIST[69]}\',\'${FILE_LIST[70]}\',\'${FILE_LIST[71]}\',\'${FILE_LIST[72]}\',\'${FILE_LIST[73]}\',\'${FILE_LIST[74]}\',\'${FILE_LIST[75]}\',\'${FILE_LIST[76]}\',\'${FILE_LIST[77]}\',\'${FILE_LIST[78]}\',\'${FILE_LIST[79]}\',\'${FILE_LIST[80]}\',\'${FILE_LIST[81]}\',\'${FILE_LIST[82]}\',\'${FILE_LIST[83]}\',\'${FILE_LIST[84]}\',\'${FILE_LIST[85]}\',\'${FILE_LIST[86]}\',\'${FILE_LIST[87]}\',\'${FILE_LIST[88]}\',\'${FILE_LIST[89]}\',\'${FILE_LIST[90]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 89 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]},\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]},\'${FILE_LIST[25]},\'${FILE_LIST[26]},\'${FILE_LIST[27]},\'${FILE_LIST[28]},\'${FILE_LIST[29]},\'${FILE_LIST[30]},\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\',\'${FILE_LIST[49]}\',\'${FILE_LIST[50]}\',\'${FILE_LIST[51]}\',\'${FILE_LIST[52]}\',\'${FILE_LIST[53]}\',\'${FILE_LIST[54]}\',\'${FILE_LIST[55]}\',\'${FILE_LIST[56]}\',\'${FILE_LIST[57]}\',\'${FILE_LIST[58]}\',\'${FILE_LIST[59]}\',\'${FILE_LIST[60]}\',\'${FILE_LIST[61]}\',\'${FILE_LIST[62]}\',\'${FILE_LIST[63]}\',\'${FILE_LIST[64]}\',\'${FILE_LIST[65]}\',\'${FILE_LIST[66]}\',\'${FILE_LIST[67]}\',\'${FILE_LIST[68]}\',\'${FILE_LIST[69]}\',\'${FILE_LIST[70]}\',\'${FILE_LIST[71]}\',\'${FILE_LIST[72]}\',\'${FILE_LIST[73]}\',\'${FILE_LIST[74]}\',\'${FILE_LIST[75]}\',\'${FILE_LIST[76]}\',\'${FILE_LIST[77]}\',\'${FILE_LIST[78]}\',\'${FILE_LIST[79]}\',\'${FILE_LIST[80]}\',\'${FILE_LIST[81]}\',\'${FILE_LIST[82]}\',\'${FILE_LIST[83]}\',\'${FILE_LIST[84]}\',\'${FILE_LIST[85]}\',\'${FILE_LIST[86]}\',\'${FILE_LIST[87]}\',\'${FILE_LIST[88]}\',\'${FILE_LIST[89]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 88 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]},\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]},\'${FILE_LIST[25]},\'${FILE_LIST[26]},\'${FILE_LIST[27]},\'${FILE_LIST[28]},\'${FILE_LIST[29]},\'${FILE_LIST[30]},\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\',\'${FILE_LIST[49]}\',\'${FILE_LIST[50]}\',\'${FILE_LIST[51]}\',\'${FILE_LIST[52]}\',\'${FILE_LIST[53]}\',\'${FILE_LIST[54]}\',\'${FILE_LIST[55]}\',\'${FILE_LIST[56]}\',\'${FILE_LIST[57]}\',\'${FILE_LIST[58]}\',\'${FILE_LIST[59]}\',\'${FILE_LIST[60]}\',\'${FILE_LIST[61]}\',\'${FILE_LIST[62]}\',\'${FILE_LIST[63]}\',\'${FILE_LIST[64]}\',\'${FILE_LIST[65]}\',\'${FILE_LIST[66]}\',\'${FILE_LIST[67]}\',\'${FILE_LIST[68]}\',\'${FILE_LIST[69]}\',\'${FILE_LIST[70]}\',\'${FILE_LIST[71]}\',\'${FILE_LIST[72]}\',\'${FILE_LIST[73]}\',\'${FILE_LIST[74]}\',\'${FILE_LIST[75]}\',\'${FILE_LIST[76]}\',\'${FILE_LIST[77]}\',\'${FILE_LIST[78]}\',\'${FILE_LIST[79]}\',\'${FILE_LIST[80]}\',\'${FILE_LIST[81]}\',\'${FILE_LIST[82]}\',\'${FILE_LIST[83]}\',\'${FILE_LIST[84]}\',\'${FILE_LIST[85]}\',\'${FILE_LIST[86]}\',\'${FILE_LIST[87]}\',\'${FILE_LIST[88]}\'
   elif [[ ${NL_NUM_INPUT_FILES} -eq 87 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]},\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]},\'${FILE_LIST[25]},\'${FILE_LIST[26]},\'${FILE_LIST[27]},\'${FILE_LIST[28]},\'${FILE_LIST[29]},\'${FILE_LIST[30]},\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\',\'${FILE_LIST[49]}\',\'${FILE_LIST[50]}\',\'${FILE_LIST[51]}\',\'${FILE_LIST[52]}\',\'${FILE_LIST[53]}\',\'${FILE_LIST[54]}\',\'${FILE_LIST[55]}\',\'${FILE_LIST[56]}\',\'${FILE_LIST[57]}\',\'${FILE_LIST[58]}\',\'${FILE_LIST[59]}\',\'${FILE_LIST[60]}\',\'${FILE_LIST[61]}\',\'${FILE_LIST[62]}\',\'${FILE_LIST[63]}\',\'${FILE_LIST[64]}\',\'${FILE_LIST[65]}\',\'${FILE_LIST[66]}\',\'${FILE_LIST[67]}\',\'${FILE_LIST[68]}\',\'${FILE_LIST[69]}\',\'${FILE_LIST[70]}\',\'${FILE_LIST[71]}\',\'${FILE_LIST[72]}\',\'${FILE_LIST[73]}\',\'${FILE_LIST[74]}\',\'${FILE_LIST[75]}\',\'${FILE_LIST[76]}\',\'${FILE_LIST[77]}\',\'${FILE_LIST[78]}\',\'${FILE_LIST[79]}\',\'${FILE_LIST[80]}\',\'${FILE_LIST[81]}\',\'${FILE_LIST[82]}\',\'${FILE_LIST[83]}\',\'${FILE_LIST[84]}\',\'${FILE_LIST[85]}\',\'${FILE_LIST[86]}\',\'${FILE_LIST[87]}\'
   elif [[ ${NL_NUM_INPUT_FILES} -eq 86 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]},\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]},\'${FILE_LIST[25]},\'${FILE_LIST[26]},\'${FILE_LIST[27]},\'${FILE_LIST[28]},\'${FILE_LIST[29]},\'${FILE_LIST[30]},\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\',\'${FILE_LIST[49]}\',\'${FILE_LIST[50]}\',\'${FILE_LIST[51]}\',\'${FILE_LIST[52]}\',\'${FILE_LIST[53]}\',\'${FILE_LIST[54]}\',\'${FILE_LIST[55]}\',\'${FILE_LIST[56]}\',\'${FILE_LIST[57]}\',\'${FILE_LIST[58]}\',\'${FILE_LIST[59]}\',\'${FILE_LIST[60]}\',\'${FILE_LIST[61]}\',\'${FILE_LIST[62]}\',\'${FILE_LIST[63]}\',\'${FILE_LIST[64]}\',\'${FILE_LIST[65]}\',\'${FILE_LIST[66]}\',\'${FILE_LIST[67]}\',\'${FILE_LIST[68]}\',\'${FILE_LIST[69]}\',\'${FILE_LIST[70]}\',\'${FILE_LIST[71]}\',\'${FILE_LIST[72]}\',\'${FILE_LIST[73]}\',\'${FILE_LIST[74]}\',\'${FILE_LIST[75]}\',\'${FILE_LIST[76]}\',\'${FILE_LIST[77]}\',\'${FILE_LIST[78]}\',\'${FILE_LIST[79]}\',\'${FILE_LIST[80]}\',\'${FILE_LIST[81]}\',\'${FILE_LIST[82]}\',\'${FILE_LIST[83]}\',\'${FILE_LIST[84]}\',\'${FILE_LIST[85]}\',\'${FILE_LIST[86]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 85 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]},\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]},\'${FILE_LIST[25]},\'${FILE_LIST[26]},\'${FILE_LIST[27]},\'${FILE_LIST[28]},\'${FILE_LIST[29]},\'${FILE_LIST[30]},\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\',\'${FILE_LIST[49]}\',\'${FILE_LIST[50]}\',\'${FILE_LIST[51]}\',\'${FILE_LIST[52]}\',\'${FILE_LIST[53]}\',\'${FILE_LIST[54]}\',\'${FILE_LIST[55]}\',\'${FILE_LIST[56]}\',\'${FILE_LIST[57]}\',\'${FILE_LIST[58]}\',\'${FILE_LIST[59]}\',\'${FILE_LIST[60]}\',\'${FILE_LIST[61]}\',\'${FILE_LIST[62]}\',\'${FILE_LIST[63]}\',\'${FILE_LIST[64]}\',\'${FILE_LIST[65]}\',\'${FILE_LIST[66]}\',\'${FILE_LIST[67]}\',\'${FILE_LIST[68]}\',\'${FILE_LIST[69]}\',\'${FILE_LIST[70]}\',\'${FILE_LIST[71]}\',\'${FILE_LIST[72]}\',\'${FILE_LIST[73]}\',\'${FILE_LIST[74]}\',\'${FILE_LIST[75]}\',\'${FILE_LIST[76]}\',\'${FILE_LIST[77]}\',\'${FILE_LIST[78]}\',\'${FILE_LIST[79]}\',\'${FILE_LIST[80]}\',\'${FILE_LIST[81]}\',\'${FILE_LIST[82]}\',\'${FILE_LIST[83]}\',\'${FILE_LIST[84]}\',\'${FILE_LIST[85]}\'

      elif [[ ${NL_NUM_INPUT_FILES} -eq 84 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]},\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]},\'${FILE_LIST[25]},\'${FILE_LIST[26]},\'${FILE_LIST[27]},\'${FILE_LIST[28]},\'${FILE_LIST[29]},\'${FILE_LIST[30]},\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\',\'${FILE_LIST[49]}\',\'${FILE_LIST[50]}\',\'${FILE_LIST[51]}\',\'${FILE_LIST[52]}\',\'${FILE_LIST[53]}\',\'${FILE_LIST[54]}\',\'${FILE_LIST[55]}\',\'${FILE_LIST[56]}\',\'${FILE_LIST[57]}\',\'${FILE_LIST[58]}\',\'${FILE_LIST[59]}\',\'${FILE_LIST[60]}\',\'${FILE_LIST[61]}\',\'${FILE_LIST[62]}\',\'${FILE_LIST[63]}\',\'${FILE_LIST[64]}\',\'${FILE_LIST[65]}\',\'${FILE_LIST[66]}\',\'${FILE_LIST[67]}\',\'${FILE_LIST[68]}\',\'${FILE_LIST[69]}\',\'${FILE_LIST[70]}\',\'${FILE_LIST[71]}\',\'${FILE_LIST[72]}\',\'${FILE_LIST[73]}\',\'${FILE_LIST[74]}\',\'${FILE_LIST[75]}\',\'${FILE_LIST[76]}\',\'${FILE_LIST[77]}\',\'${FILE_LIST[78]}\',\'${FILE_LIST[79]}\',\'${FILE_LIST[80]}\',\'${FILE_LIST[81]}\',\'${FILE_LIST[82]}\',\'${FILE_LIST[83]}\',\'${FILE_LIST[84]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 83 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]},\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]},\'${FILE_LIST[25]},\'${FILE_LIST[26]},\'${FILE_LIST[27]},\'${FILE_LIST[28]},\'${FILE_LIST[29]},\'${FILE_LIST[30]},\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\',\'${FILE_LIST[49]}\',\'${FILE_LIST[50]}\',\'${FILE_LIST[51]}\',\'${FILE_LIST[52]}\',\'${FILE_LIST[53]}\',\'${FILE_LIST[54]}\',\'${FILE_LIST[55]}\',\'${FILE_LIST[56]}\',\'${FILE_LIST[57]}\',\'${FILE_LIST[58]}\',\'${FILE_LIST[59]}\',\'${FILE_LIST[60]}\',\'${FILE_LIST[61]}\',\'${FILE_LIST[62]}\',\'${FILE_LIST[63]}\',\'${FILE_LIST[64]}\',\'${FILE_LIST[65]}\',\'${FILE_LIST[66]}\',\'${FILE_LIST[67]}\',\'${FILE_LIST[68]}\',\'${FILE_LIST[69]}\',\'${FILE_LIST[70]}\',\'${FILE_LIST[71]}\',\'${FILE_LIST[72]}\',\'${FILE_LIST[73]}\',\'${FILE_LIST[74]}\',\'${FILE_LIST[75]}\',\'${FILE_LIST[76]}\',\'${FILE_LIST[77]}\',\'${FILE_LIST[78]}\',\'${FILE_LIST[79]}\',\'${FILE_LIST[80]}\',\'${FILE_LIST[81]}\',\'${FILE_LIST[82]}\',\'${FILE_LIST[83]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 82 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]},\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]},\'${FILE_LIST[25]},\'${FILE_LIST[26]},\'${FILE_LIST[27]},\'${FILE_LIST[28]},\'${FILE_LIST[29]},\'${FILE_LIST[30]},\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\',\'${FILE_LIST[49]}\',\'${FILE_LIST[50]}\',\'${FILE_LIST[51]}\',\'${FILE_LIST[52]}\',\'${FILE_LIST[53]}\',\'${FILE_LIST[54]}\',\'${FILE_LIST[55]}\',\'${FILE_LIST[56]}\',\'${FILE_LIST[57]}\',\'${FILE_LIST[58]}\',\'${FILE_LIST[59]}\',\'${FILE_LIST[60]}\',\'${FILE_LIST[61]}\',\'${FILE_LIST[62]}\',\'${FILE_LIST[63]}\',\'${FILE_LIST[64]}\',\'${FILE_LIST[65]}\',\'${FILE_LIST[66]}\',\'${FILE_LIST[67]}\',\'${FILE_LIST[68]}\',\'${FILE_LIST[69]}\',\'${FILE_LIST[70]}\',\'${FILE_LIST[71]}\',\'${FILE_LIST[72]}\',\'${FILE_LIST[73]}\',\'${FILE_LIST[74]}\',\'${FILE_LIST[75]}\',\'${FILE_LIST[76]}\',\'${FILE_LIST[77]}\',\'${FILE_LIST[78]}\',\'${FILE_LIST[79]}\',\'${FILE_LIST[80]}\',\'${FILE_LIST[81]}\',\'${FILE_LIST[82]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 81 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]},\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]},\'${FILE_LIST[25]},\'${FILE_LIST[26]},\'${FILE_LIST[27]},\'${FILE_LIST[28]},\'${FILE_LIST[29]},\'${FILE_LIST[30]},\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\',\'${FILE_LIST[49]}\',\'${FILE_LIST[50]}\',\'${FILE_LIST[51]}\',\'${FILE_LIST[52]}\',\'${FILE_LIST[53]}\',\'${FILE_LIST[54]}\',\'${FILE_LIST[55]}\',\'${FILE_LIST[56]}\',\'${FILE_LIST[57]}\',\'${FILE_LIST[58]}\',\'${FILE_LIST[59]}\',\'${FILE_LIST[60]}\',\'${FILE_LIST[61]}\',\'${FILE_LIST[62]}\',\'${FILE_LIST[63]}\',\'${FILE_LIST[64]}\',\'${FILE_LIST[65]}\',\'${FILE_LIST[66]}\',\'${FILE_LIST[67]}\',\'${FILE_LIST[68]}\',\'${FILE_LIST[69]}\',\'${FILE_LIST[70]}\',\'${FILE_LIST[71]}\',\'${FILE_LIST[72]}\',\'${FILE_LIST[73]}\',\'${FILE_LIST[74]}\',\'${FILE_LIST[75]}\',\'${FILE_LIST[76]}\',\'${FILE_LIST[77]}\',\'${FILE_LIST[78]}\',\'${FILE_LIST[79]}\',\'${FILE_LIST[80]}\',\'${FILE_LIST[81]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 80 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]},\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]},\'${FILE_LIST[25]},\'${FILE_LIST[26]},\'${FILE_LIST[27]},\'${FILE_LIST[28]},\'${FILE_LIST[29]},\'${FILE_LIST[30]},\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\',\'${FILE_LIST[49]}\',\'${FILE_LIST[50]}\',\'${FILE_LIST[51]}\',\'${FILE_LIST[52]}\',\'${FILE_LIST[53]}\',\'${FILE_LIST[54]}\',\'${FILE_LIST[55]}\',\'${FILE_LIST[56]}\',\'${FILE_LIST[57]}\',\'${FILE_LIST[58]}\',\'${FILE_LIST[59]}\',\'${FILE_LIST[60]}\',\'${FILE_LIST[61]}\',\'${FILE_LIST[62]}\',\'${FILE_LIST[63]}\',\'${FILE_LIST[64]}\',\'${FILE_LIST[65]}\',\'${FILE_LIST[66]}\',\'${FILE_LIST[67]}\',\'${FILE_LIST[68]}\',\'${FILE_LIST[69]}\'v,\'${FILE_LIST[70]}\',\'${FILE_LIST[71]}\',\'${FILE_LIST[72]}\',\'${FILE_LIST[73]}\',\'${FILE_LIST[74]}\',\'${FILE_LIST[75]}\',\'${FILE_LIST[76]}\',\'${FILE_LIST[77]}\',\'${FILE_LIST[78]}\',\'${FILE_LIST[79]}\',\'${FILE_LIST[80]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 79 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]},\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]},\'${FILE_LIST[25]},\'${FILE_LIST[26]},\'${FILE_LIST[27]},\'${FILE_LIST[28]},\'${FILE_LIST[29]},\'${FILE_LIST[30]},\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\',\'${FILE_LIST[49]}\',\'${FILE_LIST[50]}\',\'${FILE_LIST[51]}\',\'${FILE_LIST[52]}\',\'${FILE_LIST[53]}\',\'${FILE_LIST[54]}\',\'${FILE_LIST[55]}\',\'${FILE_LIST[56]}\',\'${FILE_LIST[57]}\',\'${FILE_LIST[58]}\',\'${FILE_LIST[59]}\',\'${FILE_LIST[60]}\',\'${FILE_LIST[61]}\',\'${FILE_LIST[62]}\',\'${FILE_LIST[63]}\',\'${FILE_LIST[64]}\',\'${FILE_LIST[65]}\',\'${FILE_LIST[66]}\',\'${FILE_LIST[67]}\',\'${FILE_LIST[68]}\',\'${FILE_LIST[69]}\',\'${FILE_LIST[70]}\',\'${FILE_LIST[71]}\',\'${FILE_LIST[72]}\',\'${FILE_LIST[73]}\',\'${FILE_LIST[74]}\',\'${FILE_LIST[75]}\',\'${FILE_LIST[76]}\',\'${FILE_LIST[77]}\',\'${FILE_LIST[78]}\',\'${FILE_LIST[79]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 78 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]},\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]},\'${FILE_LIST[25]},\'${FILE_LIST[26]},\'${FILE_LIST[27]},\'${FILE_LIST[28]},\'${FILE_LIST[29]},\'${FILE_LIST[30]},\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\',\'${FILE_LIST[49]}\',\'${FILE_LIST[50]}\',\'${FILE_LIST[51]}\',\'${FILE_LIST[52]}\',\'${FILE_LIST[53]}\',\'${FILE_LIST[54]}\',\'${FILE_LIST[55]}\',\'${FILE_LIST[56]}\',\'${FILE_LIST[57]}\',\'${FILE_LIST[58]}\',\'${FILE_LIST[59]}\',\'${FILE_LIST[60]}\',\'${FILE_LIST[61]}\',\'${FILE_LIST[62]}\',\'${FILE_LIST[63]}\',\'${FILE_LIST[64]}\',\'${FILE_LIST[65]}\',\'${FILE_LIST[66]}\',\'${FILE_LIST[67]}\',\'${FILE_LIST[68]}\',\'${FILE_LIST[69]}\',\'${FILE_LIST[70]}\',\'${FILE_LIST[71]}\',\'${FILE_LIST[72]}\',\'${FILE_LIST[73]}\',\'${FILE_LIST[74]}\',\'${FILE_LIST[75]}\',\'${FILE_LIST[76]}\',\'${FILE_LIST[77]}\',\'${FILE_LIST[78]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 77 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]},\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]},\'${FILE_LIST[25]},\'${FILE_LIST[26]},\'${FILE_LIST[27]},\'${FILE_LIST[28]},\'${FILE_LIST[29]},\'${FILE_LIST[30]},\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\',\'${FILE_LIST[49]}\',\'${FILE_LIST[50]}\',\'${FILE_LIST[51]}\',\'${FILE_LIST[52]}\',\'${FILE_LIST[53]}\',\'${FILE_LIST[54]}\',\'${FILE_LIST[55]}\',\'${FILE_LIST[56]}\',\'${FILE_LIST[57]}\',\'${FILE_LIST[58]}\',\'${FILE_LIST[59]}\',\'${FILE_LIST[60]}\',\'${FILE_LIST[61]}\',\'${FILE_LIST[62]}\',\'${FILE_LIST[63]}\',\'${FILE_LIST[64]}\',\'${FILE_LIST[65]}\',\'${FILE_LIST[66]}\',\'${FILE_LIST[67]}\',\'${FILE_LIST[68]}\',\'${FILE_LIST[69]}\',\'${FILE_LIST[70]}\',\'${FILE_LIST[71]}\',\'${FILE_LIST[72]}\',\'${FILE_LIST[73]}\',\'${FILE_LIST[74]}\',\'${FILE_LIST[75]}\',\'${FILE_LIST[76]}\',\'${FILE_LIST[77]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 76 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]},\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]},\'${FILE_LIST[25]},\'${FILE_LIST[26]},\'${FILE_LIST[27]},\'${FILE_LIST[28]},\'${FILE_LIST[29]},\'${FILE_LIST[30]},\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\',\'${FILE_LIST[49]}\',\'${FILE_LIST[50]}\',\'${FILE_LIST[51]}\',\'${FILE_LIST[52]}\',\'${FILE_LIST[53]}\',\'${FILE_LIST[54]}\',\'${FILE_LIST[55]}\',\'${FILE_LIST[56]}\',\'${FILE_LIST[57]}\',\'${FILE_LIST[58]}\',\'${FILE_LIST[59]}\',\'${FILE_LIST[60]}\',\'${FILE_LIST[61]}\',\'${FILE_LIST[62]}\',\'${FILE_LIST[63]}\',\'${FILE_LIST[64]}\',\'${FILE_LIST[65]}\',\'${FILE_LIST[66]}\',\'${FILE_LIST[67]}\',\'${FILE_LIST[68]}\',\'${FILE_LIST[69]}\',\'${FILE_LIST[70]}\',\'${FILE_LIST[71]}\',\'${FILE_LIST[72]}\',\'${FILE_LIST[73]}\',\'${FILE_LIST[74]}\',\'${FILE_LIST[75]}\',\'${FILE_LIST[76]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 75 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]},\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]},\'${FILE_LIST[25]},\'${FILE_LIST[26]},\'${FILE_LIST[27]},\'${FILE_LIST[28]},\'${FILE_LIST[29]},\'${FILE_LIST[30]},\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\',\'${FILE_LIST[49]}\',\'${FILE_LIST[50]}\',\'${FILE_LIST[51]}\',\'${FILE_LIST[52]}\',\'${FILE_LIST[53]}\',\'${FILE_LIST[54]}\',\'${FILE_LIST[55]}\',\'${FILE_LIST[56]}\',\'${FILE_LIST[57]}\',\'${FILE_LIST[58]}\',\'${FILE_LIST[59]}\',\'${FILE_LIST[60]}\',\'${FILE_LIST[61]}\',\'${FILE_LIST[62]}\',\'${FILE_LIST[63]}\',\'${FILE_LIST[64]}\',\'${FILE_LIST[65]}\',\'${FILE_LIST[66]}\',\'${FILE_LIST[67]}\',\'${FILE_LIST[68]}\',\'${FILE_LIST[69]}\',\'${FILE_LIST[70]}\',\'${FILE_LIST[71]}\',\'${FILE_LIST[72]}\',\'${FILE_LIST[73]}\',\'${FILE_LIST[74]}\',\'${FILE_LIST[75]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 74 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]},\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]},\'${FILE_LIST[25]},\'${FILE_LIST[26]},\'${FILE_LIST[27]},\'${FILE_LIST[28]},\'${FILE_LIST[29]},\'${FILE_LIST[30]},\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\',\'${FILE_LIST[49]}\',\'${FILE_LIST[50]}\',\'${FILE_LIST[51]}\',\'${FILE_LIST[52]}\',\'${FILE_LIST[53]}\',\'${FILE_LIST[54]}\',\'${FILE_LIST[55]}\',\'${FILE_LIST[56]}\',\'${FILE_LIST[57]}\',\'${FILE_LIST[58]}\',\'${FILE_LIST[59]}\',\'${FILE_LIST[60]}\',\'${FILE_LIST[61]}\',\'${FILE_LIST[62]}\',\'${FILE_LIST[63]}\',\'${FILE_LIST[64]}\',\'${FILE_LIST[65]}\',\'${FILE_LIST[66]}\',\'${FILE_LIST[67]}\',\'${FILE_LIST[68]}\',\'${FILE_LIST[69]}\',\'${FILE_LIST[70]}\',\'${FILE_LIST[71]}\',\'${FILE_LIST[72]}\',\'${FILE_LIST[73]}\',\'${FILE_LIST[74]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 73 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]},\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]},\'${FILE_LIST[25]},\'${FILE_LIST[26]},\'${FILE_LIST[27]},\'${FILE_LIST[28]},\'${FILE_LIST[29]},\'${FILE_LIST[30]},\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\',\'${FILE_LIST[49]}\',\'${FILE_LIST[50]}\',\'${FILE_LIST[51]}\',\'${FILE_LIST[52]}\',\'${FILE_LIST[53]}\',\'${FILE_LIST[54]}\',\'${FILE_LIST[55]}\',\'${FILE_LIST[56]}\',\'${FILE_LIST[57]}\',\'${FILE_LIST[58]}\',\'${FILE_LIST[59]}\',\'${FILE_LIST[60]}\',\'${FILE_LIST[61]}\',\'${FILE_LIST[62]}\',\'${FILE_LIST[63]}\',\'${FILE_LIST[64]}\',\'${FILE_LIST[65]}\',\'${FILE_LIST[66]}\',\'${FILE_LIST[67]}\',\'${FILE_LIST[68]}\',\'${FILE_LIST[69]}\',\'${FILE_LIST[70]}\',\'${FILE_LIST[71]}\',\'${FILE_LIST[72]}\',\'${FILE_LIST[73]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 72 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]},\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]},\'${FILE_LIST[25]},\'${FILE_LIST[26]},\'${FILE_LIST[27]},\'${FILE_LIST[28]},\'${FILE_LIST[29]},\'${FILE_LIST[30]},\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\',\'${FILE_LIST[49]}\',\'${FILE_LIST[50]}\',\'${FILE_LIST[51]}\',\'${FILE_LIST[52]}\',\'${FILE_LIST[53]}\',\'${FILE_LIST[54]}\',\'${FILE_LIST[55]}\',\'${FILE_LIST[56]}\',\'${FILE_LIST[57]}\',\'${FILE_LIST[58]}\',\'${FILE_LIST[59]}\',\'${FILE_LIST[60]}\',\'${FILE_LIST[61]}\',\'${FILE_LIST[62]}\',\'${FILE_LIST[63]}\',\'${FILE_LIST[64]}\',\'${FILE_LIST[65]}\',\'${FILE_LIST[66]}\',\'${FILE_LIST[67]}\',\'${FILE_LIST[68]}\',\'${FILE_LIST[69]}\',\'${FILE_LIST[70]}\',\'${FILE_LIST[71]}\',\'${FILE_LIST[72]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 71 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]},\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]},\'${FILE_LIST[25]},\'${FILE_LIST[26]},\'${FILE_LIST[27]},\'${FILE_LIST[28]},\'${FILE_LIST[29]},\'${FILE_LIST[30]},\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\',\'${FILE_LIST[49]}\',\'${FILE_LIST[50]}\',\'${FILE_LIST[51]}\',\'${FILE_LIST[52]}\',\'${FILE_LIST[53]}\',\'${FILE_LIST[54]}\',\'${FILE_LIST[55]}\',\'${FILE_LIST[56]}\',\'${FILE_LIST[57]}\',\'${FILE_LIST[58]}\',\'${FILE_LIST[59]}\',\'${FILE_LIST[60]}\',\'${FILE_LIST[61]}\',\'${FILE_LIST[62]}\',\'${FILE_LIST[63]}\',\'${FILE_LIST[64]}\',\'${FILE_LIST[65]}\',\'${FILE_LIST[66]}\',\'${FILE_LIST[67]}\',\'${FILE_LIST[68]}\',\'${FILE_LIST[69]}\',\'${FILE_LIST[70]}\',\'${FILE_LIST[71]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 70 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]},\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]},\'${FILE_LIST[25]},\'${FILE_LIST[26]},\'${FILE_LIST[27]},\'${FILE_LIST[28]},\'${FILE_LIST[29]},\'${FILE_LIST[30]},\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\',\'${FILE_LIST[49]}\',\'${FILE_LIST[50]}\',\'${FILE_LIST[51]}\',\'${FILE_LIST[52]}\',\'${FILE_LIST[53]}\',\'${FILE_LIST[54]}\',\'${FILE_LIST[55]}\',\'${FILE_LIST[56]}\',\'${FILE_LIST[57]}\',\'${FILE_LIST[58]}\',\'${FILE_LIST[59]}\',\'${FILE_LIST[60]}\',\'${FILE_LIST[61]}\',\'${FILE_LIST[62]}\',\'${FILE_LIST[63]}\',\'${FILE_LIST[64]}\',\'${FILE_LIST[65]}\',\'${FILE_LIST[66]}\',\'${FILE_LIST[67]}\',\'${FILE_LIST[68]}\',\'${FILE_LIST[69]}\',\'${FILE_LIST[70]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 69 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]},\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]},\'${FILE_LIST[25]},\'${FILE_LIST[26]},\'${FILE_LIST[27]},\'${FILE_LIST[28]},\'${FILE_LIST[29]},\'${FILE_LIST[30]},\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\',\'${FILE_LIST[49]}\',\'${FILE_LIST[50]}\',\'${FILE_LIST[51]}\',\'${FILE_LIST[52]}\',\'${FILE_LIST[53]}\',\'${FILE_LIST[54]}\',\'${FILE_LIST[55]}\',\'${FILE_LIST[56]}\',\'${FILE_LIST[57]}\',\'${FILE_LIST[58]}\',\'${FILE_LIST[59]}\',\'${FILE_LIST[60]}\',\'${FILE_LIST[61]}\',\'${FILE_LIST[62]}\',\'${FILE_LIST[63]}\',\'${FILE_LIST[64]}\',\'${FILE_LIST[65]}\',\'${FILE_LIST[66]}\',\'${FILE_LIST[67]}\',\'${FILE_LIST[68]}\',\'${FILE_LIST[69]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 68 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]},\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]},\'${FILE_LIST[25]},\'${FILE_LIST[26]},\'${FILE_LIST[27]},\'${FILE_LIST[28]},\'${FILE_LIST[29]},\'${FILE_LIST[30]},\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\',\'${FILE_LIST[49]}\',\'${FILE_LIST[50]}\',\'${FILE_LIST[51]}\',\'${FILE_LIST[52]}\',\'${FILE_LIST[53]}\',\'${FILE_LIST[54]}\',\'${FILE_LIST[55]}\',\'${FILE_LIST[56]}\',\'${FILE_LIST[57]}\',\'${FILE_LIST[58]}\',\'${FILE_LIST[59]}\',\'${FILE_LIST[60]}\',\'${FILE_LIST[61]}\',\'${FILE_LIST[62]}\',\'${FILE_LIST[63]}\',\'${FILE_LIST[64]}\',\'${FILE_LIST[65]}\',\'${FILE_LIST[66]}\',\'${FILE_LIST[67]}\',\'${FILE_LIST[68]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 67 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]},\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]},\'${FILE_LIST[25]},\'${FILE_LIST[26]},\'${FILE_LIST[27]},\'${FILE_LIST[28]},\'${FILE_LIST[29]},\'${FILE_LIST[30]},\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\',\'${FILE_LIST[49]}\',\'${FILE_LIST[50]}\',\'${FILE_LIST[51]}\',\'${FILE_LIST[52]}\',\'${FILE_LIST[53]}\',\'${FILE_LIST[54]}\',\'${FILE_LIST[55]}\',\'${FILE_LIST[56]}\',\'${FILE_LIST[57]}\',\'${FILE_LIST[58]}\',\'${FILE_LIST[59]}\',\'${FILE_LIST[60]}\',\'${FILE_LIST[61]}\',\'${FILE_LIST[62]}\',\'${FILE_LIST[63]}\',\'${FILE_LIST[64]}\',\'${FILE_LIST[65]}\',\'${FILE_LIST[66]}\',\'${FILE_LIST[67]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 66 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]},\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]},\'${FILE_LIST[25]},\'${FILE_LIST[26]},\'${FILE_LIST[27]},\'${FILE_LIST[28]},\'${FILE_LIST[29]},\'${FILE_LIST[30]},\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\',\'${FILE_LIST[49]}\',\'${FILE_LIST[50]}\',\'${FILE_LIST[51]}\',\'${FILE_LIST[52]}\',\'${FILE_LIST[53]}\',\'${FILE_LIST[54]}\',\'${FILE_LIST[55]}\',\'${FILE_LIST[56]}\',\'${FILE_LIST[57]}\',\'${FILE_LIST[58]}\',\'${FILE_LIST[59]}\',\'${FILE_LIST[60]}\',\'${FILE_LIST[61]}\',\'${FILE_LIST[62]}\',\'${FILE_LIST[63]}\',\'${FILE_LIST[64]}\',\'${FILE_LIST[65]}\',\'${FILE_LIST[66]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 65 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]},\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]},\'${FILE_LIST[25]},\'${FILE_LIST[26]},\'${FILE_LIST[27]},\'${FILE_LIST[28]},\'${FILE_LIST[29]},\'${FILE_LIST[30]},\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\',\'${FILE_LIST[49]}\',\'${FILE_LIST[50]}\',\'${FILE_LIST[51]}\',\'${FILE_LIST[52]}\',\'${FILE_LIST[53]}\',\'${FILE_LIST[54]}\',\'${FILE_LIST[55]}\',\'${FILE_LIST[56]}\',\'${FILE_LIST[57]}\',\'${FILE_LIST[58]}\',\'${FILE_LIST[59]}\',\'${FILE_LIST[60]}\',\'${FILE_LIST[61]}\',\'${FILE_LIST[62]}\',\'${FILE_LIST[63]}\',\'${FILE_LIST[64]}\',\'${FILE_LIST[65]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 64 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]},\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]},\'${FILE_LIST[25]},\'${FILE_LIST[26]},\'${FILE_LIST[27]},\'${FILE_LIST[28]},\'${FILE_LIST[29]},\'${FILE_LIST[30]},\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\',\'${FILE_LIST[49]}\',\'${FILE_LIST[50]}\',\'${FILE_LIST[51]}\',\'${FILE_LIST[52]}\',\'${FILE_LIST[53]}\',\'${FILE_LIST[54]}\',\'${FILE_LIST[55]}\',\'${FILE_LIST[56]}\',\'${FILE_LIST[57]}\',\'${FILE_LIST[58]}\',\'${FILE_LIST[59]}\',\'${FILE_LIST[60]}\',\'${FILE_LIST[61]}\',\'${FILE_LIST[62]}\',\'${FILE_LIST[63]}\',\'${FILE_LIST[64]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 63 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]},\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]},\'${FILE_LIST[25]},\'${FILE_LIST[26]},\'${FILE_LIST[27]},\'${FILE_LIST[28]},\'${FILE_LIST[29]},\'${FILE_LIST[30]},\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\',\'${FILE_LIST[49]}\',\'${FILE_LIST[50]}\',\'${FILE_LIST[51]}\',\'${FILE_LIST[52]}\',\'${FILE_LIST[53]}\',\'${FILE_LIST[54]}\',\'${FILE_LIST[55]}\',\'${FILE_LIST[56]}\',\'${FILE_LIST[57]}\',\'${FILE_LIST[58]}\',\'${FILE_LIST[59]}\',\'${FILE_LIST[60]}\',\'${FILE_LIST[61]}\',\'${FILE_LIST[62]}\',\'${FILE_LIST[63]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 62 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]},\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]},\'${FILE_LIST[25]},\'${FILE_LIST[26]},\'${FILE_LIST[27]},\'${FILE_LIST[28]},\'${FILE_LIST[29]},\'${FILE_LIST[30]},\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\',\'${FILE_LIST[49]}\',\'${FILE_LIST[50]}\',\'${FILE_LIST[51]}\',\'${FILE_LIST[52]}\',\'${FILE_LIST[53]}\',\'${FILE_LIST[54]}\',\'${FILE_LIST[55]}\',\'${FILE_LIST[56]}\',\'${FILE_LIST[57]}\',\'${FILE_LIST[58]}\',\'${FILE_LIST[59]}\',\'${FILE_LIST[60]}\',\'${FILE_LIST[61]}\',\'${FILE_LIST[62]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 61 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]},\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]},\'${FILE_LIST[25]},\'${FILE_LIST[26]},\'${FILE_LIST[27]},\'${FILE_LIST[28]},\'${FILE_LIST[29]},\'${FILE_LIST[30]},\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\',\'${FILE_LIST[49]}\',\'${FILE_LIST[50]}\',\'${FILE_LIST[51]}\',\'${FILE_LIST[52]}\',\'${FILE_LIST[53]}\',\'${FILE_LIST[54]}\',\'${FILE_LIST[55]}\',\'${FILE_LIST[56]}\',\'${FILE_LIST[57]}\',\'${FILE_LIST[58]}\',\'${FILE_LIST[59]}\',\'${FILE_LIST[60]}\',\'${FILE_LIST[61]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 60 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]},\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]},\'${FILE_LIST[25]},\'${FILE_LIST[26]},\'${FILE_LIST[27]},\'${FILE_LIST[28]},\'${FILE_LIST[29]},\'${FILE_LIST[30]},\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\',\'${FILE_LIST[49]}\',\'${FILE_LIST[50]}\',\'${FILE_LIST[51]}\',\'${FILE_LIST[52]}\',\'${FILE_LIST[53]}\',\'${FILE_LIST[54]}\',\'${FILE_LIST[55]}\',\'${FILE_LIST[56]}\',\'${FILE_LIST[57]}\',\'${FILE_LIST[58]}\',\'${FILE_LIST[59]}\',\'${FILE_LIST[60]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 59 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]},\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]},\'${FILE_LIST[25]},\'${FILE_LIST[26]},\'${FILE_LIST[27]},\'${FILE_LIST[28]},\'${FILE_LIST[29]},\'${FILE_LIST[30]},\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\',\'${FILE_LIST[49]}\',\'${FILE_LIST[50]}\',\'${FILE_LIST[51]}\',\'${FILE_LIST[52]}\',\'${FILE_LIST[53]}\',\'${FILE_LIST[54]}\',\'${FILE_LIST[55]}\',\'${FILE_LIST[56]}\',\'${FILE_LIST[57]}\',\'${FILE_LIST[58]}\',\'${FILE_LIST[59]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 58 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]},\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]},\'${FILE_LIST[25]},\'${FILE_LIST[26]},\'${FILE_LIST[27]},\'${FILE_LIST[28]},\'${FILE_LIST[29]},\'${FILE_LIST[30]},\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\',\'${FILE_LIST[49]}\',\'${FILE_LIST[50]}\',\'${FILE_LIST[51]}\',\'${FILE_LIST[52]}\',\'${FILE_LIST[53]}\',\'${FILE_LIST[54]}\',\'${FILE_LIST[55]}\',\'${FILE_LIST[56]}\',\'${FILE_LIST[57]}\',\'${FILE_LIST[58]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 57 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]},\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]},\'${FILE_LIST[25]},\'${FILE_LIST[26]},\'${FILE_LIST[27]},\'${FILE_LIST[28]},\'${FILE_LIST[29]},\'${FILE_LIST[30]},\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\',\'${FILE_LIST[49]}\',\'${FILE_LIST[50]}\',\'${FILE_LIST[51]}\',\'${FILE_LIST[52]}\',\'${FILE_LIST[53]}\',\'${FILE_LIST[54]}\',\'${FILE_LIST[55]}\',\'${FILE_LIST[56]}\',\'${FILE_LIST[57]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 56 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]},\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]},\'${FILE_LIST[25]},\'${FILE_LIST[26]},\'${FILE_LIST[27]},\'${FILE_LIST[28]},\'${FILE_LIST[29]},\'${FILE_LIST[30]},\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\',\'${FILE_LIST[49]}\',\'${FILE_LIST[50]}\',\'${FILE_LIST[51]}\',\'${FILE_LIST[52]}\',\'${FILE_LIST[53]}\',\'${FILE_LIST[54]}\',\'${FILE_LIST[55]}\',\'${FILE_LIST[56]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 55 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]},\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]},\'${FILE_LIST[25]},\'${FILE_LIST[26]},\'${FILE_LIST[27]},\'${FILE_LIST[28]},\'${FILE_LIST[29]},\'${FILE_LIST[30]},\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\',\'${FILE_LIST[49]}\',\'${FILE_LIST[50]}\',\'${FILE_LIST[51]}\',\'${FILE_LIST[52]}\',\'${FILE_LIST[53]}\',\'${FILE_LIST[54]}\',\'${FILE_LIST[55]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 54 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]},\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]},\'${FILE_LIST[25]},\'${FILE_LIST[26]},\'${FILE_LIST[27]},\'${FILE_LIST[28]},\'${FILE_LIST[29]},\'${FILE_LIST[30]},\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\',\'${FILE_LIST[49]}\',\'${FILE_LIST[50]}\',\'${FILE_LIST[51]}\',\'${FILE_LIST[52]}\',\'${FILE_LIST[53]}\',\'${FILE_LIST[54]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 53 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]},\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]},\'${FILE_LIST[25]},\'${FILE_LIST[26]},\'${FILE_LIST[27]},\'${FILE_LIST[28]},\'${FILE_LIST[29]},\'${FILE_LIST[30]},\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\',\'${FILE_LIST[49]}\',\'${FILE_LIST[50]}\',\'${FILE_LIST[51]}\',\'${FILE_LIST[52]}\',\'${FILE_LIST[53]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 52 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]},\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]},\'${FILE_LIST[25]},\'${FILE_LIST[26]},\'${FILE_LIST[27]},\'${FILE_LIST[28]},\'${FILE_LIST[29]},\'${FILE_LIST[30]},\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\',\'${FILE_LIST[49]}\',\'${FILE_LIST[50]}\',\'${FILE_LIST[51]}\',\'${FILE_LIST[52]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 51 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]},\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]},\'${FILE_LIST[25]},\'${FILE_LIST[26]},\'${FILE_LIST[27]},\'${FILE_LIST[28]},\'${FILE_LIST[29]},\'${FILE_LIST[30]},\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\',\'${FILE_LIST[49]}\',\'${FILE_LIST[50]}\',\'${FILE_LIST[51]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 50 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]},\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]},\'${FILE_LIST[25]},\'${FILE_LIST[26]},\'${FILE_LIST[27]},\'${FILE_LIST[28]},\'${FILE_LIST[29]},\'${FILE_LIST[30]},\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\',\'${FILE_LIST[49]}\',\'${FILE_LIST[50]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 49 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]},\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]},\'${FILE_LIST[25]},\'${FILE_LIST[26]},\'${FILE_LIST[27]},\'${FILE_LIST[28]},\'${FILE_LIST[29]},\'${FILE_LIST[30]},\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\',\'${FILE_LIST[49]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 48 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]},\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]},\'${FILE_LIST[25]},\'${FILE_LIST[26]},\'${FILE_LIST[27]},\'${FILE_LIST[28]},\'${FILE_LIST[29]},\'${FILE_LIST[30]},\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\',\'${FILE_LIST[48]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 47 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]},\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]},\'${FILE_LIST[25]},\'${FILE_LIST[26]},\'${FILE_LIST[27]},\'${FILE_LIST[28]},\'${FILE_LIST[29]},\'${FILE_LIST[30]},\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\',\'${FILE_LIST[47]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 46 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]},\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]},\'${FILE_LIST[25]},\'${FILE_LIST[26]},\'${FILE_LIST[27]},\'${FILE_LIST[28]},\'${FILE_LIST[29]},\'${FILE_LIST[30]},\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\',\'${FILE_LIST[46]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 45 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]},\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]},\'${FILE_LIST[25]},\'${FILE_LIST[26]},\'${FILE_LIST[27]},\'${FILE_LIST[28]},\'${FILE_LIST[29]},\'${FILE_LIST[30]},\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\',\'${FILE_LIST[45]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 44 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]},\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]},\'${FILE_LIST[25]},\'${FILE_LIST[26]},\'${FILE_LIST[27]},\'${FILE_LIST[28]},\'${FILE_LIST[29]},\'${FILE_LIST[30]},\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\',\'${FILE_LIST[44]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 43 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]},\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]},\'${FILE_LIST[25]},\'${FILE_LIST[26]},\'${FILE_LIST[27]},\'${FILE_LIST[28]},\'${FILE_LIST[29]},\'${FILE_LIST[30]},\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\',\'${FILE_LIST[43]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 42 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]},\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]},\'${FILE_LIST[25]},\'${FILE_LIST[26]},\'${FILE_LIST[27]},\'${FILE_LIST[28]},\'${FILE_LIST[29]},\'${FILE_LIST[30]},\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\',\'${FILE_LIST[42]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 41 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]},\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]},\'${FILE_LIST[25]},\'${FILE_LIST[26]},\'${FILE_LIST[27]},\'${FILE_LIST[28]},\'${FILE_LIST[29]},\'${FILE_LIST[30]},\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\',\'${FILE_LIST[41]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 40 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]},\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]},\'${FILE_LIST[25]},\'${FILE_LIST[26]},\'${FILE_LIST[27]},\'${FILE_LIST[28]},\'${FILE_LIST[29]},\'${FILE_LIST[30]},\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\',\'${FILE_LIST[40]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 39 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]},\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]},\'${FILE_LIST[25]},\'${FILE_LIST[26]},\'${FILE_LIST[27]},\'${FILE_LIST[28]},\'${FILE_LIST[29]},\'${FILE_LIST[30]},\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\',\'${FILE_LIST[39]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 38 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]},\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]},\'${FILE_LIST[25]},\'${FILE_LIST[26]},\'${FILE_LIST[27]},\'${FILE_LIST[28]},\'${FILE_LIST[29]},\'${FILE_LIST[30]},\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\',\'${FILE_LIST[38]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 37 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]},\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]},\'${FILE_LIST[25]},\'${FILE_LIST[26]},\'${FILE_LIST[27]},\'${FILE_LIST[28]},\'${FILE_LIST[29]},\'${FILE_LIST[30]},\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\',\'${FILE_LIST[37]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 36 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]},\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]},\'${FILE_LIST[25]},\'${FILE_LIST[26]},\'${FILE_LIST[27]},\'${FILE_LIST[28]},\'${FILE_LIST[29]},\'${FILE_LIST[30]},\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\',\'${FILE_LIST[36]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 35 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]},\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]},\'${FILE_LIST[25]},\'${FILE_LIST[26]},\'${FILE_LIST[27]},\'${FILE_LIST[28]},\'${FILE_LIST[29]},\'${FILE_LIST[30]},\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\',\'${FILE_LIST[35]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 34 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]},\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]},\'${FILE_LIST[25]},\'${FILE_LIST[26]},\'${FILE_LIST[27]},\'${FILE_LIST[28]},\'${FILE_LIST[29]},\'${FILE_LIST[30]},\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\',\'${FILE_LIST[34]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 33 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]},\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]},\'${FILE_LIST[25]},\'${FILE_LIST[26]},\'${FILE_LIST[27]},\'${FILE_LIST[28]},\'${FILE_LIST[29]},\'${FILE_LIST[30]},\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\',\'${FILE_LIST[33]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 32 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]},\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]},\'${FILE_LIST[25]},\'${FILE_LIST[26]},\'${FILE_LIST[27]},\'${FILE_LIST[28]},\'${FILE_LIST[29]},\'${FILE_LIST[30]},\'${FILE_LIST[31]}\',\'${FILE_LIST[32]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 31 ]]; then
          export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]},\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]},\'${FILE_LIST[25]},\'${FILE_LIST[26]},\'${FILE_LIST[27]},\'${FILE_LIST[28]},\'${FILE_LIST[29]},\'${FILE_LIST[30]},\'${FILE_LIST[31]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 30 ]]; then
         export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]},\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]},\'${FILE_LIST[25]},\'${FILE_LIST[26]},\'${FILE_LIST[27]},\'${FILE_LIST[28]},\'${FILE_LIST[29]},\'${FILE_LIST[30]}
      elif [[ ${NL_NUM_INPUT_FILES} -eq 29 ]]; then
         export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]},\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]},\'${FILE_LIST[25]},\'${FILE_LIST[26]},\'${FILE_LIST[27]},\'${FILE_LIST[28]},\'${FILE_LIST[29]}
      elif [[ ${NL_NUM_INPUT_FILES} -eq 28 ]]; then
         export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]},\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]},\'${FILE_LIST[25]},\'${FILE_LIST[26]},\'${FILE_LIST[27]},\'${FILE_LIST[28]}
      elif [[ ${NL_NUM_INPUT_FILES} -eq 27 ]]; then
         export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]},\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]},\'${FILE_LIST[25]},\'${FILE_LIST[26]},\'${FILE_LIST[27]}
      elif [[ ${NL_NUM_INPUT_FILES} -eq 26 ]]; then
         export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]}\',\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\,\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]},\'${FILE_LIST[25]},\'${FILE_LIST[26]}
      elif [[ ${NL_NUM_INPUT_FILES} -eq 25 ]]; then
         export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]}\',\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]},\'${FILE_LIST[25]}
      elif [[ ${NL_NUM_INPUT_FILES} -eq 24 ]]; then
         export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]},\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\',\'${FILE_LIST[24]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 23 ]]; then
         export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]},\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\',\'${FILE_LIST[23]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 22 ]]; then
         export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]},\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\',\'${FILE_LIST[22]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 21 ]]; then
         export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]},\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\',\'${FILE_LIST[21]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 20 ]]; then
         export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]},\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\',\'${FILE_LIST[20]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 19 ]]; then
         export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]}\',\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\',\'${FILE_LIST[19]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 18 ]]; then
         export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]}\',\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\',\'${FILE_LIST[18]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 17 ]]; then
         export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]}\',\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\',\'${FILE_LIST[17]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 16 ]]; then
         export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]}\',\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\',\'${FILE_LIST[16]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 15 ]]; then
         export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]}\',\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\',\'${FILE_LIST[15]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 14 ]]; then
         export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]}\',\'${FILE_LIST[13]}\',\'${FILE_LIST[14]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 13 ]]; then
         export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]}\',\'${FILE_LIST[13]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 12 ]]; then
         export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\',\'${FILE_LIST[12]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 11 ]]; then
         export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\',\'${FILE_LIST[11]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 10 ]]; then
         export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\',\'${FILE_LIST[10]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 9 ]]; then
         export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\',\'${FILE_LIST[9]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 8 ]]; then
         export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\',\'${FILE_LIST[8]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 7 ]]; then
         export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\',\'${FILE_LIST[7]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 6 ]]; then
         export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\',\'${FILE_LIST[6]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 5 ]]; then
         export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\',\'${FILE_LIST[5]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 4 ]]; then
         export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\',\'${FILE_LIST[4]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 3 ]]; then
         export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\',\'${FILE_LIST[3]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 2 ]]; then
         export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\',\'${FILE_LIST[2]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 1 ]]; then
         export NL_FILENAME_SEQ=\'${FILE_LIST[1]}\'
      elif [[ ${NL_NUM_INPUT_FILES} -eq 0 ]]; then
         echo APM: ERROR no obs_seq files for FILTER
         exit
      fi
#
      export NL_FILENAME_OUT="'obs_seq.proc'"
      export NL_FIRST_OBS_DAYS=${ASIM_MIN_DAY_GREG}
      export NL_FIRST_OBS_SECONDS=${ASIM_MIN_SEC_GREG}
      export NL_LAST_OBS_DAYS=${ASIM_MAX_DAY_GREG}
      export NL_LAST_OBS_SECONDS=${ASIM_MAX_SEC_GREG}
      export NL_SYNONYMOUS_COPY_LIST="'NCEP BUFR observation','MOPITT CO observation','IASI CO observation','IASI O3 observation','OMI O3 observation','OMI NO2 observation','OMI SO2 observation','OMI HCHO observation','TROPOMI CO observation','TROPOMI O3 observation','TROPOMI NO2 observation','TROPOMI SO2 observation','TROPOMI CH4 observation','TROPOMI HCHO observation','TEMPO O3 observation','TEMPO NO2 observation','AIRNOW observation','MODIS observation','TES CO observation','TES CO2 observation','TES O3 observation','TES NH3 observation','TES CH4 observation','CRIS CO observation','CRIS O3 observation','CRIS NH3 observation','CRIS CH4 observation','CRIS PAN observation','SCIAM NO2 observation','GOME2A NO2 observation','MLS O3 observation','MLS HNO3 observation','OMI NO2 DOMINO observation'"
      export NL_SYNONYMOUS_QC_LIST="'NCEP QC index','MOPITT CO QC index','IASI CO QC index','IASI O3 QC index','OMI O3 QC index','OMI NO2 QC index','OMI SO2 QC index','OMI HCHO QC index','TROPOMI CO QC index','TROPOMI O3 QC index','TROPOMI NO2 QC index','TROPOMI SO2 QC index','TROPOMI CH4 QC index','TROPOMI HCHO QC index','TEMPO O3 QC index','TEMPO NO2 QC index','AIRNOW QC index','MODIS QC index','TES CO QC index','TES CO2 QC index','TES O3 QC index','TES NH3 QC index','TES CH4 QC index','CRIS CO QC index','CRIS O3 QC index','CRIS NH3 QC index','CRIS CH4 QC index','CRIS PAN QC index','SCIAM NO2 QC index','GOME2A NO2 QC index','MLS O3 QC index','MLS HNO3 QC index','OMI NO2 DOMINO QC index'"
      rm -rf input.nml
      export NL_MOPITT_CO_RETRIEVAL_TYPE=\'${RETRIEVAL_TYPE_MOPITT}\'
      export NL_IASI_CO_RETRIEVAL_TYPE=\'${RETRIEVAL_TYPE_IASI}\'
      export NL_USE_LOG_CO=${USE_LOG_CO_LOGIC}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_NOX=${USE_LOG_NOX_LOGIC}
      export NL_USE_LOG_NO2=${USE_LOG_NO2_LOGIC}
      export NL_USE_LOG_SO2=${USE_LOG_SO2_LOGIC}
      export NL_USE_LOG_PM10=${USE_LOG_PM10_LOGIC}
      export NL_USE_LOG_PM25=${USE_LOG_PM25_LOGIC}
      export NL_USE_LOG_AOD=${USE_LOG_AOD_LOGIC}
      export NL_USE_LOG_CO2=${USE_LOG_CO2_LOGIC}
      export NL_USE_LOG_CH4=${USE_LOG_CH4_LOGIC}
      export NL_USE_LOG_NH3=${USE_LOG_NH3_LOGIC}
      export NL_USE_LOG_HNO3=${USE_LOG_HNO3_LOGIC}
      export NL_USE_LOG_HCHO=${USE_LOG_HCHO_LOGIC}
      export NL_USE_LOG_PAN=${USE_LOG_PAN_LOGIC}
      ${NAMELIST_SCRIPTS_DIR}/MISC/da_create_dart_input_nml.ksh       
#
      ./obs_sequence_tool > index.html 2>&1
      mv obs_seq.proc obs_seq_comb_${DATE}.out
   fi
#
#########################################################################
#
# RUN PREPROCESS OBSERVATIONS
#
#########################################################################
#
   if ${RUN_PREPROCESS_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/preprocess_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/preprocess_obs
         cd ${RUN_DIR}/${DATE}/preprocess_obs
      else
         cd ${RUN_DIR}/${DATE}/preprocess_obs
      fi
      if [[ ${DATE} -eq ${INITIAL_DATE} ]]; then
         echo 'This is initial date cannot run PREPROCESS '
         touch CANNOT_RUN_PREPROCESS
	 exit
      fi
#
# GET WRFINPUT TEMPLATE
      cp ${RUN_DIR}/${PAST_DATE}/ensemble_mean_output/wrfout_d${CR_DOMAIN}_${DATE}_mean wrfinput_d${CR_DOMAIN}
      cp ${WRFCHEM_CHEM_EMISS_DIR}/wrfchemi_d${CR_DOMAIN}_${FILE_DATE}.e001 wrfchemi_d${CR_DOMAIN}
      cp ${WRFCHEM_CHEM_EMISS_DIR}/wrffirechemi_d${CR_DOMAIN}_${FILE_DATE}.e001 wrffirechemi_d${CR_DOMAIN}
      cp ${WRFCHEM_CHEM_EMISS_DIR}/wrfbiochemi_d${CR_DOMAIN}_${FILE_DATE}.e001 wrfbiochemi_d${CR_DOMAIN}
      ncrename -d emissions_zdim_stag,chemi_zdim_stag -O wrfchemi_d${CR_DOMAIN} wrfchemi_d${CR_DOMAIN}_temp
      ncrename -d emissions_zdim_stag,fire_zdim_stag -O wrffirechemi_d${CR_DOMAIN} wrffirechemi_d${CR_DOMAIN}_temp
#
# Copy the emissions fields to be adjusted from the emissions input files
# to the wrfinput files
      ncks -A -v ${WRFCHEMI_DARTVARS} wrfchemi_d${CR_DOMAIN}_temp wrfinput_d${CR_DOMAIN}
      ncks -A -v ${WRFFIRECHEMI_DARTVARS} wrffirechemi_d${CR_DOMAIN}_temp wrfinput_d${CR_DOMAIN}
#
# GET DART UTILITIES
      cp ${WRFCHEM_DART_WORK_DIR}/wrf_dart_obs_preprocess ./.
      cp ${DART_DIR}/models/wrf_chem/WRF_DART_utilities/wrf_dart_obs_preprocess.nml ./.
      rm -rf input.nml
      export NL_DEFAULT_STATE_VARIABLES=.false.
      export NL_MOPITT_CO_RETRIEVAL_TYPE=\'${RETRIEVAL_TYPE_MOPITT}\'
      export NL_IASI_CO_RETRIEVAL_TYPE=\'${RETRIEVAL_TYPE_IASI}\'
      export NL_USE_LOG_CO=${USE_LOG_CO_LOGIC}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_NO2=${USE_LOG_NO2_LOGIC}
      export NL_USE_LOG_SO2=${USE_LOG_SO2_LOGIC}
      export NL_USE_LOG_PM10=${USE_LOG_PM10_LOGIC}
      export NL_USE_LOG_PM25=${USE_LOG_PM25_LOGIC}
      export NL_USE_LOG_AOD=${USE_LOG_AOD_LOGIC}
      export NL_USE_LOG_CO2=${USE_LOG_CO2_LOGIC}
      export NL_USE_LOG_CH4=${USE_LOG_CH4_LOGIC}
      export NL_USE_LOG_NH3=${USE_LOG_NH3_LOGIC}
      export NL_USE_LOG_HNO3=${USE_LOG_HNO3_LOGIC}
      export NL_USE_LOG_HCHO=${USE_LOG_HCHO_LOGIC}
      export NL_USE_LOG_PAN=${USE_LOG_PAN_LOGIC}
      ${NAMELIST_SCRIPTS_DIR}/DART/dart_create_input.nml.ksh
#
# GET INPUT DATA
      rm -rf obs_seq.old
      rm -rf obs_seq.new
      cp ${COMBINE_OBS_DIR}/obs_seq_comb_${DATE}.out obs_seq.old
#
      rm -rf job.ksh
      touch job.ksh
      cat << EOF > job.ksh
#!/bin/ksh -aeux
#PBS -N prepr
#PBS -l walltime=${GENERAL_TIME_LIMIT}
#PBS -q ${GENERAL_JOB_CLASS}
#PBS -j oe
#PBS -l select=${GENERAL_NODES}:ncpus=1:model=san
#PBS -l site=needed=/home1+/nobackupp11
./wrf_dart_obs_preprocess ${DAY_GREG} ${SEC_GREG} > index.html 2>&1
export RC=\$?
if [[ -f SUCCESS ]]; then rm -rf SUCCESS; fi     
if [[ -f FAILED ]]; then rm -rf FAILED; fi          
if [[ \$RC = 0 ]]; then
   touch SUCCESS
else
   touch FAILED 
   exit
fi
EOF
#
      qsub -Wblock=true job.ksh
      mv obs_seq.new obs_seq_comb_filtered_${DATE}.out 
   fi
#
#########################################################################
#
# STATE VARIABLE LOCALIZATION
#
#########################################################################
#
   if ${RUN_LOCALIZATION}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/localization ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/localization
         cd ${RUN_DIR}/${DATE}/localization
      else
         cd ${RUN_DIR}/${DATE}/localization
      fi
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
   fi
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
