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
# ROOT DIRECTORIES:
export DART_VER=DART_development
export PERT_CHEM_VER=ICBC_PERT
export WORK_DIR=/nobackupp28/amizzi
export TRUNK_DIR=${WORK_DIR}/TRUNK
export REAL_TIME_DIR=${TRUNK_DIR}/${DART_VER}/apm_run_scripts/RUN_REAL_TIME
export RS_SCRIPTS_DIR=${REAL_TIME_DIR}/FINAL_TEST_SCRIPTS/RS_Scripts
export INPUT_DATA_DIR=/nobackupp27/nex/datapool/TRACER-1/TRACER1_OBS
export SCRATCH_DIR=${WORK_DIR}/OUTPUT_DATA
export EXPERIMENT_DIR=${SCRATCH_DIR}
export EXPERIMENT_DATA_DIR=${INPUT_DATA_DIR}
#
export RUN_DIR=${EXPERIMENT_DIR}/OUTPUT_2010_NOAA_EMISADJ_30MEMS
export RUN_INPUT_DIR=${EXPERIMENT_DIR}/INPUT_2010_NOAA_EMISADJ_30MEMS
export EXPERIMENT_INPUT_OBS=NOAA
#
export NL_CORRECTION_FILENAME='Historical_Bias_Corrections'

export WRFCHEM_TEMPLATE_FILE=wrfinput_d01_2019-04-02_03:00:00.e001
export NUM_MEMBERS=30
export CYCLE_PERIOD=3
export FCST_PERIOD=3
#
# CYCLE TIME SETTINGS (NOAA has extra digits for ss)
export INITIAL_DATE=2010040200
export FIRST_FILTER_DATE=2010040203
export FIRST_DART_INFLATE_DATE=2010040203
export FIRST_EMISS_INV_DATE=2010040203
#
# START CYCLE DATE-TIME:
export CYCLE_STR_DATE=2010040209
#
# END CYCLE DATE-TIME:
export CYCLE_END_DATE=2010040218
#
# For emissions estimation
export ADD_EMISS=true
export EMISS_DAMP_CYCLE=1.0
export EMISS_DAMP_INTRA_CYCLE=1.0
#
# Switch to process filter output without calling filter
export SKIP_FILTER=false
export DART_MEM_STR=1
#
# Set large scale chemisty file
export NL_UPPER_DATA_FILE_NAME=/h0001.nc
export NL_UPPER_DATA_MODEL=\'TCR2\'
export LS_CHEM_DX=78
export LS_CHEM_DY=35
export LS_CHEM_DZ=32
export LS_CHEM_DT=360
export NUM_WRFCHEMI_DARTVARS=4
export NUM_WRFFIRECHEMI_DARTVARS=4
#
# SELECT OBSERVATION OPTIONS:
export RUN_INPUT_OBS=true
export RUN_MOPITT_V8_CO_PROFILE_OBS=true            # (done)  TRACER I
export RUN_OMI_NO2_DOMINO_TROP_COL_OBS=true         # (done)  TRACER I
export RUN_OMI_SO2_PBL_COL_OBS=true                 # (done)  TRACER I
export RUN_TES_CO_PROFILE_OBS=true                  # (done)  TRACER I
export RUN_GOME2A_NO2_TROP_COL_OBS=true             # (done)  TRACER I
export RUN_SCIAM_NO2_TROP_COL_OBS=true              # (done)  TRACER I
export RUN_OMI_O3_PROFILE_OBS=true                   # (done)  TRACER I
export RUN_TES_O3_PROFILE_OBS=true                 # (done)  TRACER I
export RUN_MLS_O3_PROFILE_OBS=true                # (done)  TRACER I
export RUN_MLS_HNO3_PROFILE_OBS=true               # (done)  TRACER I
export RUN_AIRNOW_CO_OBS=true                       # (done)  TRACER I
export RUN_AIRNOW_O3_OBS=true                       # (done)  TRACER I
export RUN_AIRNOW_NO2_OBS=true                      # (done)  TRACER I
export RUN_AIRNOW_SO2_OBS=true                      # (done)  TRACER I
export RUN_MET_OBS=true                             # (done)  TRACER I
#
export RUN_MODIS_AOD_TOTAL_COL_OBS=false            # (done)  TRACER I - leave false
export RUN_GOME2B_NO2_TROP_COL_OBS=false            # (done)  TRACER I - leave false
export RUN_AIRNOW_PM10_OBS=false                    # (done)  TRACER I - leave false
export RUN_AIRNOW_PM25_OBS=false                    # (done)  TRACER I - leave false
#
# Setup DART namelist parameters for which observations to assimilate/evaluate
# &obs_kind_nml
export NL_EVALUATE_THESE_OBS_TYPES="' '"
export NL_EVALUATE_THESE_OBS_TYPES="'AIRNOW_CO',
                                    'AIRNOW_O3',
                                    'AIRNOW_NO2',
                                    'AIRNOW_SO2'"

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
                                   'MOPITT_V8_CO_PROFILE',
                                   'OMI_O3_PROFILE',
                                   'OMI_NO2_DOMINO_TROP_COL',
                                   'OMI_SO2_PBL_COL',
                                   'GOME2A_NO2_TROP_COL',
                                   'SCIAM_NO2_TROP_COL',
                                   'MLS_O3_PROFILE',
                                   'MLS_HNO3_PROFILE',
                                   'TES_CO_PROFILE',
                                   'TES_O3_PROFILE'"
#
# Set observation error scaling and retention factors (assign constants)
source ${RS_SCRIPTS_DIR}/RS_Fac_Retn_Constants.ksh
#
# Set log transform settings (assign constants)
export USE_LOG=false
source ${RS_SCRIPTS_DIR}/RS_Set_Log_Transformation_Constants.ksh
#
# Set CPSR constants (assign constants)
source ${RS_SCRIPTS_DIR}/RS_CPSR_Settings.ksh
#
# Set miscellaneous constants (assign constants)
source ${RS_SCRIPTS_DIR}/RS_Miscellaneous_Constants.ksh
#
# Run fine scale forecast only
export RUN_FINE_SCALE=false
export RUN_FINE_SCALE_RESTART=false
export RESTART_DATE=2014072312
if [[ ${RUN_FINE_SCALE_RESTART} == true ]]; then
   export RUN_FINE_SCALE=true
fi
#
#########################################################################
#
# START OF MAIN CYCLING LOOP
#
#########################################################################
#
export CYCLE_DATE=${CYCLE_STR_DATE}
while [[ ${CYCLE_DATE} -le ${CYCLE_END_DATE} ]]; do
   cd ${REAL_TIME_DIR}/FINAL_TEST_SCRIPTS
   export DATE=${CYCLE_DATE}
   export EXP_INPUT_OBS=${RUN_INPUT_DIR}/${DATE}/${EXPERIMENT_INPUT_OBS}
   export L_ADD_EMISS=${ADD_EMISS} 
   if [[ ${DATE} -lt ${FIRST_EMISS_INV_DATE} ]]; then
      export L_ADD_EMISS=false
   fi
#
# Run WRF-Chem for failed forecasts (will not work with adaptive time step)
   export RUN_SPECIAL_FORECAST=false
   export NUM_SPECIAL_FORECAST=0
   export SPECIAL_FORECAST_FAC=1.
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
   if [[ ${DATE} -eq ${CYCLE_STR_DATE}  ]]; then
      export RUN_SPECIAL_FORECAST=false
      export NUM_SPECIAL_FORECAST=0
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
   fi
#
# SELECT COMPONENT RUN OPTIONS:
# FOR GENERAL CYCLING   
   if [[ ${RUN_SPECIAL_FORECAST} == false ]]; then
      if [[ ${RUN_INPUT_OBS} == true ]]; then
         export RUN_COMBINE_OBS=true
         export RUN_PREPROCESS_OBS=true
      else
         export RUN_COMBINE_OBS=false
         export RUN_PREPROCESS_OBS=false
      fi
      if [[ ${DATE} -eq ${INITIAL_DATE}  ]]; then
         export RUN_DART_FILTER=false
         export RUN_POST_EMISS_INFLATION=false
         export RUN_BIAS_CORRECTION=false
         export RUN_UPDATE_BC=false
         export RUN_ENSEMBLE_MEAN_INPUT=false
         export RUN_WRFCHEM_INITIAL=true
         export RUN_WRFCHEM_CYCLE_CR=false
      elif [[ ${DATE} -eq ${CYCLE_STR_DATE}  ]]; then
         export RUN_DART_FILTER=true
         export RUN_POST_EMISS_INFLATION=true
         export RUN_BIAS_CORRECTION=false
         export RUN_UPDATE_BC=true
         export RUN_ENSEMBLE_MEAN_INPUT=false
         export RUN_WRFCHEM_INITIAL=false
         export RUN_WRFCHEM_CYCLE_CR=true
      elif [[ ${DATE} -gt ${CYCLE_STR_DATE}  ]]; then
         export RUN_DART_FILTER=true
         export RUN_POST_EMISS_INFLATION=true
         export RUN_BIAS_CORRECTION=false
         export RUN_UPDATE_BC=true
         export RUN_ENSEMBLE_MEAN_INPUT=false
         export RUN_WRFCHEM_INITIAL=false
         export RUN_WRFCHEM_CYCLE_CR=true
      fi
      export RUN_WRFCHEM_CYCLE_FR=false
      export RUN_ENSMEAN_CYCLE_FR=false
      export RUN_ENSEMBLE_MEAN_OUTPUT=false
      export RUN_BAND_DEPTH=false
   fi
   if [[ ${RUN_SPECIAL_FORECAST} == true ]]; then
#
# FOR SPECIAL CYCLING       
      export RUN_INPUT_OBS=false
      export RUN_COMBINE_OBS=false
      export RUN_PREPROCESS_OBS=false
      export RUN_DART_FILTER=false
      export RUN_POST_EMISS_INFLATION=false
      export RUN_BIAS_CORRECTION=false
      export RUN_UPDATE_BC=false
      export RUN_ENSEMBLE_MEAN_INPUT=false
      if [[ ${DATE} -eq ${INITIAL_DATE}  ]]; then
         export RUN_WRFCHEM_INITIAL=true
         export RUN_WRFCHEM_CYCLE_CR=false
      else	  
         export RUN_WRFCHEM_INITIAL=false
         export RUN_WRFCHEM_CYCLE_CR=true
      fi
      export RUN_WRFCHEM_CYCLE_FR=false
      export RUN_ENSMEAN_CYCLE_FR=false
      export RUN_ENSEMBLE_MEAN_OUTPUT=false
      export RUN_BAND_DEPTH=false
   fi
#
# FOR FINE GRID FORECASTING
   if [[ ${RUN_FINE_SCALE} = "true" ]]; then
      export RUN_INPUT_OBS=false
      if ${RUN_INPUT_OBS}; then
         export RUN_COMBINE_OBS=true
         export RUN_PREPROCESS_OBS=true
      else
         export RUN_COMBINE_OBS=false
         export RUN_PREPROCESS_OBS=false
      fi
      export RUN_DART_FILTER=false
      export RUN_POST_EMISS_INFLATION=false
      export RUN_BIAS_CORRECTION=false
      export RUN_UPDATE_BC=false
      export RUN_ENSEMBLE_MEAN_INPUT=false
      if [[ ${DATE} -eq ${INITIAL_DATE}  ]]; then      
         export RUN_WRFCHEM_INITIAL=false
         export RUN_WRFCHEM_CYCLE_CR=false
      else 
         export RUN_WRFCHEM_INITIAL=false
         export RUN_WRFCHEM_CYCLE_CR=false
      fi
      export RUN_WRFCHEM_CYCLE_FR=false
      export RUN_ENSMEAN_CYCLE_FR=true
      export RUN_ENSEMBLE_MEAN_OUTPUT=true
      export RUN_BAND_DEPTH=false
   fi
#
   rm -rf index_RS_Code_Versions_${DATE}   
   source ${RS_SCRIPTS_DIR}/RS_Code_Versions.ksh > index_RS_Code_Versions_${DATE} 2>&1
   rm -rf index_RS_Experiment_Dirs_${DATE}
   source ${RS_SCRIPTS_DIR}/RS_Experiment_Dirs.ksh > index_RS_Experiment_Dirs_${DATE} 2>&1
   rm -rf index_RS_Set_Time_Vars_${DATE}
   source ${RS_SCRIPTS_DIR}/RS_Set_Time_Vars_NOAA.ksh > index_RS_Set_Time_Vars_${DATE} 2>&1
   rm -rf index_RS_Run_Dirs_${DATE}
   source ${RS_SCRIPTS_DIR}/RS_Run_Dirs.ksh > index_RS_Run_Dirs_${DATE} 2>&1
   rm -rf index_RS_Computer_Settings_${DATE}
   source ${RS_SCRIPTS_DIR}/RS_Computer_Settings.ksh > index_RS_Computer_Settings_${DATE} 2>&1
   rm -rf index_RS_Observation_Dirs_${DATE}
   source ${RS_SCRIPTS_DIR}/RS_Observation_Dirs.ksh > index_RS_Observation_Dirs_${DATE} 2>&1
   rm -rf index_RS_Chemistry_Pert_Params_${DATE}
   source ${RS_SCRIPTS_DIR}/RS_Chemistry_Pert_Params.ksh > index_RS_Chemistry_Pert_Params_${DATE} 2>&1
#
# NOAAS  
   rm -rf index_RS_Forecast_Time_Domain_Params_NOAA_${DATE}
   source ${RS_SCRIPTS_DIR}/RS_Forecast_Time_Domain_Params_NOAA.ksh > index_RS_Forecast_Time_Domain_Params_NOAA_${DATE} 2>&1
   rm -rf index_RS_WRFChem_Namelists_NOAA_${DATE}
   source ${RS_SCRIPTS_DIR}/RS_WRFChem_Namelists_NOAA.ksh > index_RS_WRFChem_Namelists_NOAA_${DATE} 2>&1
#
   rm -rf index_RS_Forward_Operator_Params_${DATE}
   source ${RS_SCRIPTS_DIR}/RS_Forward_Operator_Params.ksh > index_RS_Forward_Operator_Params_${DATE} 2>&1
   rm -rf index_RS_DART_Namelists_${DATE}
   source ${RS_SCRIPTS_DIR}/RS_DART_Namelists_NOAA.ksh > index_RS_DART_Namelists_${DATE} 2>&1
   rm -rf index_RS_Error_Decorrelation_Settings_${DATE}
   source ${RS_SCRIPTS_DIR}/RS_Error_Decorrelation_Settings.ksh > index_RS_Error_Decorrelation_Settings_${DATE} 2>&1
   rm -rf index_RS_Code_Versions_${DATE}
   rm -rf index_RS_Experiment_Dirs_${DATE}
   rm -rf index_RS_Set_Time_Vars_${DATE}
   rm -rf index_RS_Run_Dirs_${DATE}
   rm -rf index_RS_Computer_Settings_${DATE}
   rm -rf index_RS_Observation_Dirs_${DATE}
   rm -rf index_RS_Chemistry_Pert_Params_${DATE}
   rm -rf index_RS_Forecast_Time_Domain_Params_NOAA_${DATE}
   rm -rf index_RS_WRFChem_Namelists_NOAA_${DATE}
   rm -rf index_RS_Forward_Operator_Params_${DATE}
   rm -rf index_RS_DART_Namelists_${DATE}
   rm -rf index_RS_Error_Decorrelation_Settings_${DATE}
#   
   cp ${WRFCHEM_DART_WORK_DIR}/advance_time ./.
   cp ${WRFCHEM_DART_WORK_DIR}/input.nml ./.
#
#########################################################################
#
# LOCAL ENVIRONMENT VARIABLE SETTINGS
#
#########################################################################
#
   export GENERAL_JOB_CLASS=normal
   export GENERAL_TIME_LIMIT=02:30:00
   export GENERAL_NODES=1
   export GENERAL_TASKS=1
   export GENERAL_MODEL=bro
#
   export SINGLE_JOB_CLASS=normal
   export SINGLE_TIME_LIMIT=02:30:00
   export SINGLE_NODES=1
   export SINGLE_TASKS=1
   export SINGLE_MODEL=bro
#   
   export FILTER_JOB_CLASS=normal
   export FILTER_TIME_LIMIT=03:59:00
   export FILTER_TIME_LIMIT=03:59:00
   export FILTER_NODES=8
   export FILTER_TASKS=28
   export FILTER_MODEL=bro
#
   export WRFCHEM_JOB_CLASS=normal
   export WRFCHEM_TIME_LIMIT=01:59:00
   export WRFCHEM_NODES=5
   export WRFCHEM_TASKS=28
   export WRFCHEM_MODEL=bro
#
   export WRFCHEMI_DARTVARS="E_CO,E_NO,E_NO2,E_SO2"
   export WRFFIRECHEMI_DARTVARS="ebu_in_co,ebu_in_no,ebu_in_no2,ebu_in_so2"
#
   export WRF_VER=WRFCHEM_NOAACSLv4.2.2
   export WRFCHEM_VER=WRFCHEM_NOAACSLv4.2.2
   export NNL_TIME_STEP=40
#   export WRF_VER=WRFCHEM_NOAACSL
#   export WRFCHEM_VER=WRFCHEM_NOAACSL
#   export WRF_VER=WRFCHEMv4.3.2_dmpar
#   export WRFCHEM_VER=WRFCHEMv4.3.2_dmpar 
   export WRF_DIR=/nobackupp28/amizzi/TRUNK/${WRF_VER}
   export WRFCHEM_DIR=/nobackupp28/amizzi/TRUNK/${WRFCHEM_VER}
#
   export EXPERIMENT_HIST_IO_DIR=${EXPERIMENT_DATA_DIR}/hist_io_files
   export EXPERIMENT_COLDENS_DIR=${EXPERIMENT_DATA_DIR}/wes_coldens
   export EXPERIMENT_PHOT_DIR=${EXPERIMENT_DATA_DIR}/phot_data
   export WES_COLDENS_DIR=${DART_DIR}/apm_run_scripts/RUN_WES_COLDENS
   export EXPERIMENT_WRFBIOCHEMI_DIR=${EXPERIMENT_DATA_DIR}/bio_emissions
   export MEGAN_BIO_DIR=${DART_DIR}/apm_run_scripts/RUN_MEGAN_BIO
#   export EXPERIMENT_WRFFIRECHEMI_DIR=${EXPERIMENT_DATA_DIR}/fire_emissions/fire_emissions_v1.5
   export EXPERIMENT_WRFFIRECHEMI_DIR=${EXPERIMENT_DATA_DIR}/fire_emissions/fire_emissions_v2.5
   export FINN_FIRE_DIR=${DART_DIR}/apm_run_scripts/RUN_FINN_FIRE
#   export NL_FIRE_FILE=GLOBAL_FINNv15_${YYYY}_MOZ4.txt
   export NL_FIRE_FILE=GLOBAL_FINNv25_${YYYY}_MOZ4.txt
   export EXPERIMENT_WRFCHEMI_DIR=${EXPERIMENT_DATA_DIR}/anthro_emissions
   export MOZBC_DATA_DIR=${EXPERIMENT_DATA_DIR}/tcr2_data/${YYYY}/${MM}
   export NL_UPPER_DATA_FILE=\'${MOZBC_DATA_DIR}${NL_UPPER_DATA_FILE_NAME}\'
   export PERT_CHEM_INPUT_DIR=${DART_DIR}/apm_run_scripts/RUN_PERT_CHEM/ICBC_PERT
   export NL_UPPER_DATA_FILE_NAME=/h0001.nc
   export ADJUST_EMISS_DIR=${DART_DIR}/apm_run_scripts/RUN_EMISS_INV
   export PERT_CHEM_EMISS_DIR=${DART_DIR}/apm_run_scripts/RUN_PERT_CHEM/EMISS_PERT
#
   export RUN_MOPITT_CO_TOTAL_COL_OBS=false
   export RUN_MOPITT_CO_PROFILE_OBS=false
   export RUN_MOPITT_CO_CPSR_OBS=false
   export RUN_MOPITT_V8_CO_TOTAL_COL_OBS=false
   export RUN_MOPITT_V8_CO_CPSR_OBS=false
   export RUN_IASI_CO_TOTAL_COL_OBS=false
   export RUN_IASI_CO_PROFILE_OBS=false
   export RUN_IASI_CO_CPSR_OBS=false
   export RUN_IASI_O3_PROFILE_OBS=false
   export RUN_IASI_O3_CPSR_OBS=false
   export RUN_OMI_O3_TOTAL_COL_OBS=false
   export RUN_OMI_O3_TROP_COL_OBS=false
   export RUN_OMI_O3_CPSR_OBS=false
   export RUN_OMI_NO2_TOTAL_COL_OBS=false
   export RUN_OMI_NO2_TROP_COL_OBS=false
   export RUN_OMI_NO2_DOMINO_TOTAL_COL_OBS=false
   export RUN_OMI_SO2_TOTAL_COL_OBS=false
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
   export RUN_TES_CO_CPSR_OBS=false
   export RUN_TES_CO2_TOTAL_COL_OBS=false 
   export RUN_TES_CO2_PROFILE_OBS=false
   export RUN_TES_CO2_CPSR_OBS=false
   export RUN_TES_O3_TOTAL_COL_OBS=false
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
   export RUN_GOME2A_NO2_TOTAL_COL_OBS=false
   export RUN_MLS_O3_TOTAL_COL_OBS=false
   export RUN_MLS_O3_CPSR_OBS=false
   export RUN_MLS_HNO3_TOTAL_COL_OBS=false
   export RUN_MLS_HNO3_CPSR_OBS=false
   export RUN_PANDA_CO_OBS=false
   export RUN_PANDA_O3_OBS=false
   export RUN_PANDA_PM25_OBS=false
   export RUN_MEXICO_AQS_CO_OBS=false
#
#########################################################################
#
# CREATE RUN DIRECTORY
#
#########################################################################
#
   if [[ ! -e ${RUN_DIR}/${DATE} ]]; then mkdir -p ${RUN_DIR}/${DATE}; fi
   cd ${RUN_DIR}/${DATE}
#
#########################################################################
#
# RUN INPUT OBSERVATIONS
#
#########################################################################
#
   if ${RUN_INPUT_OBS}; then
      if [[ ! -d ${EXP_INPUT_OBS} ]]; then
         mkdir -p ${EXP_INPUT_OBS}
         cd ${EXP_INPUT_OBS}
      else
         cd ${EXP_INPUT_OBS}
      fi
      source ${RS_SCRIPTS_DIR}/RS_Generate_Obs_Seq_File.ksh > index_rs.html 2>&1
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
      source ${RS_SCRIPTS_DIR}/RS_DART_Filter_NOAA.ksh > index_rs.html 2>&1 
   fi
#
#########################################################################
#
# RUN POST ASSIMILATION EMISSIONS INFLATION
#
#########################################################################
#
   if [[ ${RUN_POST_EMISS_INFLATION} == true && ${DATE} -ge ${FIRST_EMISS_INV_DATE} ]]; then
      cd ${RUN_DIR}/${DATE}/dart_filter
      source ${RS_SCRIPTS_DIR}/RS_Post_DART_Emiss_Inflation_NOAA.ksh > index_rs.html 2>&1 
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
      source ${RS_SCRIPTS_DIR}/RS_Update_NOAA.ksh > index_rs.html 2>&1  
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
      source ${RS_SCRIPTS_DIR}/RS_Bias_Correction.ksh > index_rs.html 2>&1 
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
      source ${RS_SCRIPTS_DIR}/RS_Ensemble_Mean_Input.ksh > index_rs.html 2>&1 
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
      source ${RS_SCRIPTS_DIR}/RS_WRFChem_Initial_NOAA.ksh > index_rs.html 2>&1 
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
      source ${RS_SCRIPTS_DIR}/RS_WRFChem_Cycle_CR_NOAA.ksh > index_rs.html 2>&1
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
      source ${RS_SCRIPTS_DIR}/RS_WRFChem_Cycle_FR.ksh > index_rs.html 2>&1 
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
      source ${RS_SCRIPTS_DIR}/RS_Ensmean_Cycle_FR.ksh > index_rs.html 2>&1 
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
      source ${RS_SCRIPTS_DIR}/RS_Ensemble_Mean_Output.ksh > index_rs.html 2>&1 
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
      source ${RS_SCRIPTS_DIR}/RS_Band_Depth.ksh > index_rs.html 2>&1 
   fi
#
   export CYCLE_DATE=${NEXT_DATE}
done
#
