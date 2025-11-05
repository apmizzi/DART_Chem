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
# Purpose: Create common ensemble input data (enemble icbcs, emissions,
# and observations for running WRF-Chem/DART
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
export RUN_DIR=${EXPERIMENT_DIR}/INPUT_2021_NOAA_EMISADJ_30MEMS
export RUN_INPUT_DIR=${EXPERIMENT_DIR}/INPUT_2021_NOAA_EMISADJ_30MEMS
export EXPERIMENT_INPUT_OBS=NOAA
#
export NL_CORRECTION_FILENAME='Historical_Bias_Corrections'
#
export WRFCHEM_TEMPLATE_FILE=wrfinput_d01_2019-04-02_03:00:00.e001
export NUM_MEMBERS=30
export CYCLE_PERIOD=3
export FCST_PERIOD=3
#
# CYCLE TIME SETTINGS (NOAA has extra digits for ss)
export INITIAL_DATE=2021040200
export FIRST_FILTER_DATE=2021040203
export FIRST_DART_INFLATE_DATE=2021040203
export FIRST_EMISS_INV_DATE=2021040203
#
# START CYCLE DATE-TIME:
export CYCLE_STR_DATE=2021040200
#
# END CYCLE DATE-TIME:
export CYCLE_END_DATE=2021040218
#
# Special skip for emission perturbations (scaling factor propagation only)
export RUN_SPECIAL_PERT_SKIP=false
export SPECIAL_PERT_DATE=${CYCLE_STR_DATE}
if [[ ${RUN_SPECIAL_PERT_SKIP} = "true" ]]; then
   export SPECIAL_PERT_DATE=2005040206
fi
#
# For emissions estimation
export ADD_EMISS=true
export EMISS_DAMP_CYCLE=1.0
export EMISS_DAMP_INTRA_CYCLE=1.0
#
# Set large scale chemisty file
export NL_UPPER_DATA_FILE_NAME=/h0001.nc
export NL_UPPER_DATA_MODEL=\'TCR2\'
export LS_CHEM_DX=78
export LS_CHEM_DY=35
export LS_CHEM_DZ=32
export LS_CHEM_DT=360
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
# SELECT COMPONENT RUN OPTIONS:
   if [[ ${DATE} -eq ${CYCLE_STR_DATE} ]]; then
      export RUN_GEOGRID=true
      export RUN_UNGRIB=true
      export RUN_METGRID=true
      export RUN_REAL=true
      export RUN_PERT_WRFCHEM_MET_IC=true
      export RUN_PERT_WRFCHEM_MET_BC=true
      export RUN_EXO_COLDENS=true
      export RUN_SEASON_WES=true
      export RUN_WRFCHEM_BIO=true
      export RUN_WRFCHEM_FIRE=true
      export RUN_WRFCHEM_CHEMI=true
      export RUN_PERT_WRFCHEM_CHEM_ICBC=true
      export RUN_PERT_WRFCHEM_CHEM_EMISS=true
      export RUN_COMBINE_OBS=true
      export RUN_PREPROCESS_OBS=true
      export RUN_LOCALIZATION=true
#
      export RUN_MOPITT_V8_CO_PROFILE_OBS=true            # (done)  TRACER I
      export RUN_OMI_NO2_DOMINO_TROP_COL_OBS=true         # (done)  TRACER I
      export RUN_OMI_SO2_PBL_COL_OBS=true                 # (done)  TRACER I
      export RUN_TES_CO_PROFILE_OBS=true                  # (done)  TRACER I
      export RUN_SCIAM_NO2_TROP_COL_OBS=true              # (done)  TRACER I
      export RUN_GOME2A_NO2_TROP_COL_OBS=true             # (done)  TRACER I
      export RUN_OMI_O3_PROFILE_OBS=true                  # (done)  TRACER I
      export RUN_TES_O3_PROFILE_OBS=true                  # (done)  TRACER I
      export RUN_MLS_O3_PROFILE_OBS=true                  # (done)  TRACER I
      export RUN_MLS_HNO3_PROFILE_OBS=true                # (done)  TRACER I
      export RUN_AIRNOW_CO_OBS=true                       # (done)  TRACER I
      export RUN_AIRNOW_O3_OBS=true                       # (done)  TRACER I
      export RUN_AIRNOW_NO2_OBS=true                      # (done)  TRACER I
      export RUN_AIRNOW_SO2_OBS=true                      # (done)  TRACER I
      export RUN_MET_OBS=true                             # (done)  TRACER I
   elif [[ ${DATE} -gt ${CYCLE_STR_DATE} ]]; then
      export RUN_GEOGRID=false
      export RUN_UNGRIB=true
      export RUN_METGRID=true
      export RUN_REAL=true
      export RUN_PERT_WRFCHEM_MET_IC=true
      export RUN_PERT_WRFCHEM_MET_BC=true
      export RUN_EXO_COLDENS=true
      export RUN_SEASON_WES=true
      export RUN_WRFCHEM_BIO=true
      export RUN_WRFCHEM_FIRE=true
      export RUN_WRFCHEM_CHEMI=true
      export RUN_PERT_WRFCHEM_CHEM_ICBC=true
      export RUN_PERT_WRFCHEM_CHEM_EMISS=true
      export RUN_COMBINE_OBS=true
      export RUN_PREPROCESS_OBS=true
      export RUN_LOCALIZATION=true
#
      export RUN_MOPITT_V8_CO_PROFILE_OBS=true            # (done)  TRACER I
      export RUN_OMI_NO2_DOMINO_TROP_COL_OBS=true         # (done)  TRACER I
      export RUN_OMI_SO2_PBL_COL_OBS=true                 # (done)  TRACER I
      export RUN_TES_CO_PROFILE_OBS=true                  # (done)  TRACER I
      export RUN_SCIAM_NO2_TROP_COL_OBS=true              # (done)  TRACER I
      export RUN_GOME2A_NO2_TROP_COL_OBS=true             # (done)  TRACER I
      export RUN_OMI_O3_PROFILE_OBS=true                  # (done)  TRACER I
      export RUN_TES_O3_PROFILE_OBS=true                  # (done)  TRACER I
      export RUN_MLS_O3_PROFILE_OBS=true                  # (done)  TRACER I
      export RUN_MLS_HNO3_PROFILE_OBS=true                # (done)  TRACER I
      export RUN_AIRNOW_CO_OBS=true                       # (done)  TRACER I
      export RUN_AIRNOW_O3_OBS=true                       # (done)  TRACER I
      export RUN_AIRNOW_NO2_OBS=true                      # (done)  TRACER I
      export RUN_AIRNOW_SO2_OBS=true                      # (done)  TRACER I
      export RUN_MET_OBS=true                             # (done)  TRACER I
   fi
#
   export RUN_MODIS_AOD_TOTAL_COL_OBS=false            # (done)  TRACER I - leave false
   export RUN_GOME2B_NO2_TROP_COL_OBS=false            # (check) TRACER I - leave false
   export RUN_AIRNOW_PM10_OBS=false                    # (done)  TRACER I - leave false
   export RUN_AIRNOW_PM25_OBS=false                    # (done)  TRACER I - leave false
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
# NOAA
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
   export GDAS_HR_PREFIX=''
   export GDAS_HR_SUFFIX=.wo40.be
   export GDAS_HR_SUFFIX=.nr
#
   cp ${WRFCHEM_DART_WORK_DIR}/advance_time ./.
   cp ${WRFCHEM_DART_WORK_DIR}/input.nml ./.
#
#########################################################################
#
# LOCAL ENVIRONMENTAL VARIABLE SETTINGS
#
#########################################################################
#
   export WRFCHEMI_DARTVARS="E_CO,E_NO,E_NO2,E_SO2"
   export WRFFIRECHEMI_DARTVARS="ebu_in_co,ebu_in_no,ebu_in_no2,ebu_in_so2"
#
   export WRF_VER=WRFCHEM_NOAACSLv4.2.2
   export WRFCHEM_VER=WRFCHEM_NOAACSLv4.2.2
#   export WRF_VER=WRFv4.3.2_dmpar
#   export WRFCHEM_VER=WRFCHEMv4.3.2_dmpar
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
   export MOZBC_DATA_DIR=${EXPERIMENT_DATA_DIR}/tcr2_data
   export NL_UPPER_DATA_FILE=\'${MOZBC_DATA_DIR}/${YYYY}/${MM}${NL_UPPER_DATA_FILE_NAME}\'
   export PERT_CHEM_INPUT_DIR=${DART_DIR}/apm_run_scripts/RUN_PERT_CHEM/ICBC_PERT
   export NL_UPPER_DATA_FILE_NAME=/h0001.nc
   export ADJUST_EMISS_DIR=${DART_DIR}/apm_run_scripts/RUN_EMISS_INV
   export PERT_CHEM_EMISS_DIR=${DART_DIR}/apm_run_scripts/RUN_PERT_CHEM/EMISS_PERT
#
   export NL_PERT_CHEM=true
   export NL_PERT_FIRE=true
   export NL_PERT_BIO=false
#
   export SPREAD_FAC=0.3
   export NL_SPREAD_CHEMI=${SPREAD_FAC}
   export NL_SPREAD_FIRE=${SPREAD_FAC}
   export NL_SPREAD_BIOG=0.00
#
   export GENERAL_JOB_CLASS=normal
   export GENERAL_TIME_LIMIT=00:50:00
   export GENERAL_NODES=1
   export GENERAL_TASKS=1
   export GENERAL_MODEL=bro
#
   export SINGLE_JOB_CLASS=normal
   export SINGLE_TIME_LIMIT=00:20:00
   export SINGLE_NODES=1
   export SINGLE_TASKS=1
   export SINGLE_MODEL=bro
#   
# PERT_ICBC (Used for settings in call to RS script)
# (NSPCS x NUM_MEMS) + 2
# (19 x 30) + 2
# Ivy 20 nodes per core   
# Haswell 24 nodes per core   
# Broadwell 28 nodes per core
# Broadwell
   export L_ICBC_PERT_JOB_CLASS=normal
   export L_ICBC_PERT_TIME_LIMIT=1:59:00
   export L_ICBC_PERT_NODES=21
   export L_ICBC_PERT_TASKS=28
   export L_ICBC_PERT_MODEL=bro
#
# PERT_EMISS (Used for settings in call to  RS script)
# ((NNCHEM_SPC + MNFIRE_SPC + NNBIO_SPC) x NUM_MEMS) + 2
# ((20 + 8 + 0) x 30) + 2
# Broadwell
   export L_EMISS_PERT_JOB_CLASS=normal
   export L_EMISS_PERT_TIME_LIMIT=01:59:00
   export L_EMISS_PERT_NODES=31
   export L_EMISS_PERT_TASKS=28
   export L_EMISS_PERT_MODEL=bro
#   
   export NL_FAC_OBS_ERROR_SCIAM_NO2=0.75       # good
   export NL_FAC_OBS_ERROR_OMI_SO2=1.75         # good
   export NL_FAC_OBS_ERROR_OMI_O3=0.080         # good  
   export NL_FAC_OBS_ERROR_TES_O3=2.25          # good
   export NL_FAC_OBS_ERROR_MLS_HNO3=0.75        # good
   export NL_FAC_OBS_ERROR_MLS_O3=3.00          # good
   export NL_FAC_OBS_ERROR_TES_CO=50.00         # good
   export NL_FAC_OBS_ERROR_MODIS_AOD=1.00       # good
   export NL_FAC_OBS_ERROR_GOME2A_NO2=0.75      # good
   export NL_FAC_OBS_ERROR_GOME2B_NO2=0.75      # need to test
   export NL_FAC_OBS_ERROR_MOPITT_CO=0.40       # good
   export NL_FAC_OBS_ERROR_OMI_NO2_DOMINO=1.00  # good
   export NL_FAC_OBS_ERROR_AIRNOW_CO=1.00       # good
   export NL_FAC_OBS_ERROR_AIRNOW_O3=0.80       # good
   export NL_FAC_OBS_ERROR_AIRNOW_NO2=2.20      # good
   export NL_FAC_OBS_ERROR_AIRNOW_SO2=1.00      # good
   export NL_FAC_OBS_ERROR_AIRNOW_PM10=1.05     # good
   export NL_FAC_OBS_ERROR_AIRNOW_PM25=1.30     # good
#
# Leave these as false for TRACER-I   
   export RUN_BIAS_CORRECTION=false
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
   export RUN_GOME2B_NO2_TOTAL_COL_OBS=false
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
# RUN GEOGRID
#
#########################################################################
#
   if [[ ${RUN_GEOGRID} = "true" ]]; then
      if [[ ! -d ${RUN_DIR}/geogrid ]]; then
         mkdir -p ${RUN_DIR}/geogrid
         cd ${RUN_DIR}/geogrid
      else
         cd ${RUN_DIR}/geogrid
      fi
      source ${RS_SCRIPTS_DIR}/RS_Geogrid.ksh > index_rs.html 2>&1
   fi
#
#########################################################################
#
# RUN UNGRIB
#
#########################################################################
#
   if [[ ${RUN_UNGRIB} = "true" ]]; then 
      if [[ ! -d ${RUN_DIR}/${DATE}/ungrib ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/ungrib
         cd ${RUN_DIR}/${DATE}/ungrib
      else
         cd ${RUN_DIR}/${DATE}/ungrib
      fi
      export EXPERIMENT_LS_MET=${EXPERIMENT_NAM_DIR}
      source ${RS_SCRIPTS_DIR}/RS_Ungrib_NOAA.ksh > index_rs.html 2>&1
   fi
#
#########################################################################
#
# RUN METGRID
#
#########################################################################
#
   if [[ ${RUN_METGRID} = "true" ]]; then
      if [[ ! -d ${RUN_DIR}/${DATE}/metgrid ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/metgrid
         cd ${RUN_DIR}/${DATE}/metgrid
      else
         cd ${RUN_DIR}/${DATE}/metgrid
      fi
      source ${RS_SCRIPTS_DIR}/RS_Metgrid.ksh > index_rs.html 2>&1
   fi
#
#########################################################################
#
# RUN REAL
#
#########################################################################
#
   if [[ ${RUN_REAL} = "true" ]]; then 
      if [[ ! -d ${RUN_DIR}/${DATE}/real ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/real
         cd ${RUN_DIR}/${DATE}/real
      else
         cd ${RUN_DIR}/${DATE}/real
      fi
      source ${RS_SCRIPTS_DIR}/RS_Real_NOAA.ksh > index_rs.html 2>&1
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
      source ${RS_SCRIPTS_DIR}/RS_Pert_WRFChem_Met_IC_NOAA.ksh > index_rs.html 2>&1
#      source ${RS_SCRIPTS_DIR}/RS_Pert_WRFChem_Met_IC_NOAA_OPTM.ksh > index_rs.html 2>&1
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
      source ${RS_SCRIPTS_DIR}/RS_Pert_WRFChem_Met_BC_NOAA.ksh > index_rs.html 2>&1
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
      source ${RS_SCRIPTS_DIR}/RS_Exo_Coldens.ksh > index_rs.html 2>&1
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
      source ${RS_SCRIPTS_DIR}/RS_Seasons_Wes.ksh > index_rs.html 2>&1
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
      source ${RS_SCRIPTS_DIR}/RS_WRFChem_Bio_NOAA.ksh > index_rs.html 2>&1
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
#      source ${RS_SCRIPTS_DIR}/RS_WRFChem_Fire_NOAA_FINNv1.5.ksh > index_rs.html 2>&1
      source ${RS_SCRIPTS_DIR}/RS_WRFChem_Fire_NOAA_FINNv2.5.ksh > index_rs.html 2>&1
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
      source ${RS_SCRIPTS_DIR}/RS_WRFChem_Anthro_NOAA.ksh > index_rs.html 2>&1
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
      export NL_CHEM_ICBC_SPECIES='co','o3','no','no2','so2','hno3','hcho','pan','nh3','iso','hc3','olt','ald','ket','moh','eth','ete','mpan','paa'
#
# PERT_ICBC
      export PERT_JOB_CLASS=${L_ICBC_PERT_JOB_CLASS}
      export PERT_TIME_LIMIT=${L_ICBC_PERT_TIME_LIMIT}
      export PERT_NODES=${L_ICBC_PERT_NODES}
      export PERT_TASKS=${L_ICBC_PERT_TASKS}
      export PERT_MODEL=${L_ICBC_PERT_MODEL}
      source ${RS_SCRIPTS_DIR}/RS_Pert_WRFChem_Chem_ICBC_NOAA_NEW_PERT.ksh > index_rs.html 2>&1
#      source ${RS_SCRIPTS_DIR}/RS_Pert_WRFChem_Chem_ICBC_NOAA.ksh > index_rs.html 2>&1
#      source ${RS_SCRIPTS_DIR}/RS_Pert_WRFChem_Chem_ICBC_NOAA_TEST.ksh > index_rs.html 2>&1
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
      export NL_CHEM_ANTHRO_EMIS='E_ACT','E_CH4','E_CO','E_EOH','E_ETEG','E_ETH','E_HC3','E_HC5','E_HC8','E_HCHO','E_HONO','E_ISO','E_KET','E_NH3','E_NO','E_NO2','E_OL2','E_OLI','E_OLT','E_SO2'
      export NL_CHEM_FIRE_EMIS='ebu_in_co','ebu_in_no','ebu_in_no2','ebu_in_so2','ebu_in_hcho','ebu_in_olt','ebu_in_oli','ebu_in_iso'
      export NL_CHEM_BIOG_EMIS='MSEBIO_ISOP'
#
# PERT_EMISS
      export PERT_JOB_CLASS=${L_EMISS_PERT_JOB_CLASS}
      export PERT_TIME_LIMIT=${L_EMISS_PERT_TIME_LIMIT}
      export PERT_NODES=${L_EMISS_PERT_NODES}
      export PERT_TASKS=${L_EMISS_PERT_TASKS}
      export PERT_MODEL=${L_EMISS_PERT_MODEL}
      source ${RS_SCRIPTS_DIR}/RS_Pert_WRFChem_Chem_Emiss_NOAA_NEW_PERT.ksh > index_rs.html 2>&1
#      source ${RS_SCRIPTS_DIR}/RS_Pert_WRFChem_Chem_Emiss_NOAA.ksh > index_rs.html 2>&1
#      source ${RS_SCRIPTS_DIR}/RS_Pert_WRFChem_Chem_Emiss_NOAA_TEST.ksh > index_rs.html 2>&1
   fi
#
   TRANDOM=$$
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
      source ${RS_SCRIPTS_DIR}/RS_MOPITT_CO_Total_Col.ksh > index_rs.html 2>&1
   fi
#
########################################################################
#
# RUN MOPITT CO PROFILE OBSERVATIONS
#
########################################################################
#
   if ${RUN_MOPITT_CO_PROFILE_OBS} | ${RUN_MOPITT_V8_CO_PROFILE_OBS} ; then
      if [[ ! -d ${RUN_DIR}/${DATE}/mopitt_co_profile_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/mopitt_co_profile_obs
         cd ${RUN_DIR}/${DATE}/mopitt_co_profile_obs
      else
         cd ${RUN_DIR}/${DATE}/mopitt_co_profile_obs
      fi
      if ${RUN_MOPITT_CO_PROFILE_OBS}; then  
        source ${RS_SCRIPTS_DIR}/RS_MOPITT_CO_Profile_FRAPPE.ksh > index_rs.html 2>&1
      fi	  
#      
      if ${RUN_MOPITT_V8_CO_PROFILE_OBS}; then
        export  EXPERIMENT_MOPITT_CO_DIR=${EXPERIMENT_DATA_DIR}/mopitt_v8_co_hdf_data      
        source ${RS_SCRIPTS_DIR}/RS_MOPITT_V8_CO_Profile_FRAPPE.ksh > index_rs.html 2>&1
        export JOBRND=${TRANDOM}_mopitt
        ${JOB_CONTROL_SCRIPTS_DIR}/job_script_nasa_model.ksh ${JOBRND} ${SINGLE_JOB_CLASS} ${SINGLE_TIME_LIMIT} ${SINGLE_NODES} ${SINGLE_TASKS} jobx.ksh SERIAL ${ACCOUNT} ${SINGLE_MODEL}
         qsub job.ksh
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
      source ${RS_SCRIPTS_DIR}/RS_MOPITT_CO_CPSR_FRAPPE.ksh > index_rs.html 2>&1
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
      source ${RS_SCRIPTS_DIR}/RS_IASI_CO_Total_Col.ksh > index_rs.html 2>&1
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
      source ${RS_SCRIPTS_DIR}/RS_IASI_CO_Profile.ksh > index_rs.html 2>&1
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
      source ${RS_SCRIPTS_DIR}/RS_IASI_CO_CPSR.ksh > index_rs.html 2>&1
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
      source ${RS_SCRIPTS_DIR}/RS_IASI_O3_Profile.ksh > index_rs.html 2>&1
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
      source ${RS_SCRIPTS_DIR}/RS_IASI_O3_CPSR.ksh > index_rs.html 2>&1
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
      source ${RS_SCRIPTS_DIR}/RS_MODIS_AOD_Total_Col_MATLAB.ksh > index_rs.html 2>&1
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
      source ${RS_SCRIPTS_DIR}/RS_OMI_O3_Total_Col.ksh > index_rs.html 2>&1
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
      source ${RS_SCRIPTS_DIR}/RS_OMI_O3_Trop_Col.ksh > index_rs.html 2>&1
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
      source ${RS_SCRIPTS_DIR}/RS_OMI_O3_Profile.ksh > index_rs.html 2>&1
      export JOBRND=${TRANDOM}_omio3
      ${JOB_CONTROL_SCRIPTS_DIR}/job_script_nasa_model.ksh ${JOBRND} ${SINGLE_JOB_CLASS} ${SINGLE_TIME_LIMIT} ${SINGLE_NODES} ${SINGLE_TASKS} jobx.ksh SERIAL ${ACCOUNT} ${SINGLE_MODEL}
      qsub job.ksh
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
      source ${RS_SCRIPTS_DIR}/RS_OMI_O3_CPSR.ksh > index_rs.html 2>&1
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
      source ${RS_SCRIPTS_DIR}/RS_OMI_NO2_Total_Col.ksh > index_rs.html 2>&1
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
      source ${RS_SCRIPTS_DIR}/RS_OMI_NO2_Trop_Col.ksh > index_rs.html 2>&1
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
      source ${RS_SCRIPTS_DIR}/RS_OMI_NO2_DOMINO_Total_Col.ksh > index_rs.html 2>&1
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
      source ${RS_SCRIPTS_DIR}/RS_OMI_NO2_DOMINO_Trop_Col.ksh > index_rs.html 2>&1
      export JOBRND=${TRANDOM}_omino2
      ${JOB_CONTROL_SCRIPTS_DIR}/job_script_nasa_model.ksh ${JOBRND} ${SINGLE_JOB_CLASS} ${SINGLE_TIME_LIMIT} ${SINGLE_NODES} ${SINGLE_TASKS} jobx.ksh SERIAL ${ACCOUNT} ${SINGLE_MODEL}
      qsub job.ksh
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
      source ${RS_SCRIPTS_DIR}/RS_OMI_SO2_Total_Col.ksh > index_rs.html 2>&1
      export JOBRND=${TRANDOM}_omiso2_col
      ${JOB_CONTROL_SCRIPTS_DIR}/job_script_nasa_model.ksh ${JOBRND} ${SINGLE_JOB_CLASS} ${SINGLE_TIME_LIMIT} ${SINGLE_NODES} ${SINGLE_TASKS} jobx.ksh SERIAL ${ACCOUNT} ${SINGLE_MODEL}
      qsub job.ksh
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
      source ${RS_SCRIPTS_DIR}/RS_OMI_SO2_PBL_Col.ksh > index_rs.html 2>&1
      export JOBRND=${TRANDOM}_omiso2_pbl
      ${JOB_CONTROL_SCRIPTS_DIR}/job_script_nasa_model.ksh ${JOBRND} ${SINGLE_JOB_CLASS} ${SINGLE_TIME_LIMIT} ${SINGLE_NODES} ${SINGLE_TASKS} jobx.ksh SERIAL ${ACCOUNT} ${SINGLE_MODEL}
      qsub job.ksh
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
      source ${RS_SCRIPTS_DIR}/RS_OMI_HCHO_Total_Col.ksh > index_rs.html 2>&1
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
      source ${RS_SCRIPTS_DIR}/RS_OMI_HCHO_Trop_Col.ksh > index_rs.html 2>&1
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
      source ${RS_SCRIPTS_DIR}/RS_TROPOMI_CO_Total_Col.ksh > index_rs.html 2>&1
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
      source ${RS_SCRIPTS_DIR}/RS_TROPOMI_O3_Total_Col.ksh > index_rs.html 2>&1
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
      source ${RS_SCRIPTS_DIR}/RS_TROPOMI_O3_Trop_Col.ksh > index_rs.html 2>&1
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
      source ${RS_SCRIPTS_DIR}/RS_TROPOMI_O3_Profile.ksh > index_rs.html 2>&1
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
      source ${RS_SCRIPTS_DIR}/RS_TROPOMI_O3_CPSR.ksh > index_rs.html 2>&1
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
      source ${RS_SCRIPTS_DIR}/RS_TROPOMI_NO2_Total_Col.ksh > index_rs.html 2>&1
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
      source ${RS_SCRIPTS_DIR}/RS_TROPOMI_NO2_Trop_Col.ksh > index_rs.html 2>&1
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
      source ${RS_SCRIPTS_DIR}/RS_TROPOMI_SO2_Total_Col.ksh > index_rs.html 2>&1
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
      source ${RS_SCRIPTS_DIR}/RS_TROPOMI_SO2_PBL_Col.ksh > index_rs.html 2>&1
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
      source ${RS_SCRIPTS_DIR}/RS_TROPOMI_CH4_Total_Col.ksh > index_rs.html 2>&1
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
      source ${RS_SCRIPTS_DIR}/RS_TROPOMI_CH4_Trop_Col.ksh > index_rs.html 2>&1
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
      source ${RS_SCRIPTS_DIR}/RS_TROPOMI_CH4_Profile.ksh > index_rs.html 2>&1
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
      source ${RS_SCRIPTS_DIR}/RS_TROPOMI_CH4_CPSR.ksh > index_rs.html 2>&1
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
      source ${RS_SCRIPTS_DIR}/RS_TROPOMI_HCHO_Total_Col.ksh > index_rs.html 2>&1
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
      source ${RS_SCRIPTS_DIR}/RS_TROPOMI_HCHO_Trop_Col.ksh > index_rs.html 2>&1
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
      source ${RS_SCRIPTS_DIR}/RS_TEMPO_O3_Total_Col.ksh > index_rs.html 2>&1
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
      source ${RS_SCRIPTS_DIR}/RS_TEMPO_O3_Trop_Col.ksh > index_rs.html 2>&1
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
      source ${RS_SCRIPTS_DIR}/RS_TEMPO_O3_Profile.ksh > index_rs.html 2>&1
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
      source ${RS_SCRIPTS_DIR}/RS_TEMPO_O3_CPSR.ksh > index_rs.html 2>&1
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
      source ${RS_SCRIPTS_DIR}/RS_TEMPO_NO2_Total_Col.ksh > index_rs.html 2>&1
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
      source ${RS_SCRIPTS_DIR}/RS_TEMPO_NO2_Trop_Col.ksh > index_rs.html 2>&1
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
      source ${RS_SCRIPTS_DIR}/RS_TES_CO_Total_Col.ksh > index_rs.html 2>&1
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
      source ${RS_SCRIPTS_DIR}/RS_TES_CO_Profile.ksh > index_rs.html 2>&1
      export JOBRND=${TRANDOM}_tesco
      ${JOB_CONTROL_SCRIPTS_DIR}/job_script_nasa_model.ksh ${JOBRND} ${SINGLE_JOB_CLASS} ${SINGLE_TIME_LIMIT} ${SINGLE_NODES} ${SINGLE_TASKS} jobx.ksh SERIAL ${ACCOUNT} ${SINGLE_MODEL}
      qsub job.ksh
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
      source ${RS_SCRIPTS_DIR}/RS_TES_CO_CPSR.ksh > index_rs.html 2>&1
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
      source ${RS_SCRIPTS_DIR}/RS_TES_CO2_Total_Col.ksh > index_rs.html 2>&1
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
      source ${RS_SCRIPTS_DIR}/RS_TES_CO2_Profile.ksh > index_rs.html 2>&1
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
      source ${RS_SCRIPTS_DIR}/RS_TES_CO2_CPSR.ksh > index_rs.html 2>&1
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
      source ${RS_SCRIPTS_DIR}/RS_TES_O3_Total_Col.ksh > index_rs.html 2>&1
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
      source ${RS_SCRIPTS_DIR}/RS_TES_O3_Profile.ksh > index_rs.html 2>&1
      export JOBRND=${TRANDOM}_teso3
      ${JOB_CONTROL_SCRIPTS_DIR}/job_script_nasa_model.ksh ${JOBRND} ${SINGLE_JOB_CLASS} ${SINGLE_TIME_LIMIT} ${SINGLE_NODES} ${SINGLE_TASKS} jobx.ksh SERIAL ${ACCOUNT} ${SINGLE_MODEL}
      qsub job.ksh
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
      source ${RS_SCRIPTS_DIR}/RS_TES_O3_CPSR.ksh > index_rs.html 2>&1
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
      source ${RS_SCRIPTS_DIR}/RS_TES_NH3_Total_Col.ksh > index_rs.html 2>&1
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
      source ${RS_SCRIPTS_DIR}/RS_TES_NH3_Profile.ksh > index_rs.html 2>&1
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
      source ${RS_SCRIPTS_DIR}/RS_TES_NH3_CPSR.ksh > index_rs.html 2>&1
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
      source ${RS_SCRIPTS_DIR}/RS_TES_CH4_Total_Col.ksh > index_rs.html 2>&1
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
      source ${RS_SCRIPTS_DIR}/RS_TES_CH4_Profile.ksh > index_rs.html 2>&1
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
      source ${RS_SCRIPTS_DIR}/RS_TES_CH4_CPSR.ksh > index_rs.html 2>&1
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
      source ${RS_SCRIPTS_DIR}/RS_CRIS_CO_Total_Col.ksh > index_rs.html 2>&1
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
      source ${RS_SCRIPTS_DIR}/RS_CRIS_CO_Profile.ksh > index_rs.html 2>&1
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
      source ${RS_SCRIPTS_DIR}/RS_CRIS_CO_CPSR.ksh > index_rs.html 2>&1
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
      source ${RS_SCRIPTS_DIR}/RS_CRIS_O3_Total_Col.ksh > index_rs.html 2>&1
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
      source ${RS_SCRIPTS_DIR}/RS_CRIS_O3_Profile.ksh > index_rs.html 2>&1
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
      source ${RS_SCRIPTS_DIR}/RS_CRIS_O3_CPSR.ksh > index_rs.html 2>&1
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
      source ${RS_SCRIPTS_DIR}/RS_CRIS_NH3_Total_Col.ksh > index_rs.html 2>&1
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
      source ${RS_SCRIPTS_DIR}/RS_CRIS_CH4_Total_Col.ksh > index_rs.html 2>&1
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
      source ${RS_SCRIPTS_DIR}/RS_CRIS_CH4_Profile.ksh > index_rs.html 2>&1
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
      source ${RS_SCRIPTS_DIR}/RS_CRIS_CH4_CPSR.ksh > index_rs.html 2>&1
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
      source ${RS_SCRIPTS_DIR}/RS_CRIS_PAN_Total_Col.ksh > index_rs.html 2>&1
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
      source ${RS_SCRIPTS_DIR}/RS_CRIS_PAN_Profile.ksh > index_rs.html 2>&1
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
      source ${RS_SCRIPTS_DIR}/RS_CRIS_PAN_CPSR.ksh > index_rs.html 2>&1
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
      source ${RS_SCRIPTS_DIR}/RS_SCIAM_NO2_Total_Col.ksh > index_rs.html 2>&1
      export JOBRND=${TRANDOM}_scaim
      ${JOB_CONTROL_SCRIPTS_DIR}/job_script_nasa_model.ksh ${JOBRND} ${SINGLE_JOB_CLASS} ${SINGLE_TIME_LIMIT} ${SINGLE_NODES} ${SINGLE_TASKS} jobx.ksh SERIAL ${ACCOUNT} ${SINGLE_MODEL}
      qsub job.ksh
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
      source ${RS_SCRIPTS_DIR}/RS_SCIAM_NO2_Trop_Col.ksh > index_rs.html 2>&1
      export JOBRND=${TRANDOM}_sciam
      ${JOB_CONTROL_SCRIPTS_DIR}/job_script_nasa_model.ksh ${JOBRND} ${SINGLE_JOB_CLASS} ${SINGLE_TIME_LIMIT} ${SINGLE_NODES} ${SINGLE_TASKS} jobx.ksh SERIAL ${ACCOUNT} ${SINGLE_MODEL}
      qsub job.ksh
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
      source ${RS_SCRIPTS_DIR}/RS_GOME2A_NO2_Total_Col.ksh > index_rs.html 2>&1
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
      source ${RS_SCRIPTS_DIR}/RS_GOME2A_NO2_Trop_Col.ksh > index_rs.html 2>&1
      export JOBRND=${TRANDOM}_gome2a_no2
      ${JOB_CONTROL_SCRIPTS_DIR}/job_script_nasa_model.ksh ${JOBRND} ${SINGLE_JOB_CLASS} ${SINGLE_TIME_LIMIT} ${SINGLE_NODES} ${SINGLE_TASKS} jobx.ksh SERIAL ${ACCOUNT} ${SINGLE_MODEL}
      qsub job.ksh
   fi
#
########################################################################
#
# RUN GOME2B NO2 TOTAL COL OBSERVATIONS
#
########################################################################
#
   if ${RUN_GOME2B_NO2_TOTAL_COL_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/gome2b_no2_total_col_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/gome2b_no2_total_col_obs
         cd ${RUN_DIR}/${DATE}/gome2b_no2_total_col_obs
      else
         cd ${RUN_DIR}/${DATE}/gome2b_no2_total_col_obs
      fi
      source ${RS_SCRIPTS_DIR}/RS_GOME2B_NO2_Total_Col.ksh > index_rs.html 2>&1
   fi
#
########################################################################
#
# RUN GOME2B NO2 TROP COL OBSERVATIONS
#
########################################################################
#
   if ${RUN_GOME2B_NO2_TROP_COL_OBS}; then
      if [[ ! -d ${RUN_DIR}/${DATE}/gome2b_no2_trop_col_obs ]]; then
         mkdir -p ${RUN_DIR}/${DATE}/gome2b_no2_trop_col_obs
         cd ${RUN_DIR}/${DATE}/gome2b_no2_trop_col_obs
      else
         cd ${RUN_DIR}/${DATE}/gome2b_no2_trop_col_obs
      fi
      source ${RS_SCRIPTS_DIR}/RS_GOME2B_NO2_Trop_Col.ksh > index_rs.html 2>&1
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
      source ${RS_SCRIPTS_DIR}/RS_MLS_O3_Total_Col.ksh > index_rs.html 2>&1
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
      source ${RS_SCRIPTS_DIR}/RS_MLS_O3_Profile.ksh > index_rs.html 2>&1
      export JOBRND=${TRANDOM}_mlso3
      ${JOB_CONTROL_SCRIPTS_DIR}/job_script_nasa_model.ksh ${JOBRND} ${SINGLE_JOB_CLASS} ${SINGLE_TIME_LIMIT} ${SINGLE_NODES} ${SINGLE_TASKS} jobx.ksh SERIAL ${ACCOUNT} ${SINGLE_MODEL}
      qsub job.ksh
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
      source ${RS_SCRIPTS_DIR}/RS_MLS_O3_CPSR.ksh > index_rs.html 2>&1
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
      source ${RS_SCRIPTS_DIR}/RS_MLS_HNO3_Total_Col.ksh > index_rs.html 2>&1
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
      source ${RS_SCRIPTS_DIR}/RS_MLS_HNO3_Profile.ksh > index_rs.html 2>&1
      export JOBRND=${TRANDOM}_mlshno3
      ${JOB_CONTROL_SCRIPTS_DIR}/job_script_nasa_model.ksh ${JOBRND} ${SINGLE_JOB_CLASS} ${SINGLE_TIME_LIMIT} ${SINGLE_NODES} ${SINGLE_TASKS} jobx.ksh SERIAL ${ACCOUNT} ${SINGLE_MODEL}
      qsub job.ksh
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
      source ${RS_SCRIPTS_DIR}/RS_MLS_HNO3_CPSR.ksh > index_rs.html 2>&1
   fi
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
      source ${RS_SCRIPTS_DIR}/RS_AIRNOW_O3.ksh > index_rs.html 2>&1
      export JOBRND=${TRANDOM}_airnco
      ${JOB_CONTROL_SCRIPTS_DIR}/job_script_nasa_model.ksh ${JOBRND} ${SINGLE_JOB_CLASS} ${SINGLE_TIME_LIMIT} ${SINGLE_NODES} ${SINGLE_TASKS} jobx.ksh SERIAL ${ACCOUNT} ${SINGLE_MODEL}
      qsub job.ksh
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
      source ${RS_SCRIPTS_DIR}/RS_AIRNOW_CO.ksh > index_rs.html 2>&1
      export JOBRND=${TRANDOM}_airo3
      ${JOB_CONTROL_SCRIPTS_DIR}/job_script_nasa_model.ksh ${JOBRND} ${SINGLE_JOB_CLASS} ${SINGLE_TIME_LIMIT} ${SINGLE_NODES} ${SINGLE_TASKS} jobx.ksh SERIAL ${ACCOUNT} ${SINGLE_MODEL}
      qsub job.ksh
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
      source ${RS_SCRIPTS_DIR}/RS_AIRNOW_NO2.ksh > index_rs.html 2>&1
      export JOBRND=${TRANDOM}_airnno2
      ${JOB_CONTROL_SCRIPTS_DIR}/job_script_nasa_model.ksh ${JOBRND} ${SINGLE_JOB_CLASS} ${SINGLE_TIME_LIMIT} ${SINGLE_NODES} ${SINGLE_TASKS} jobx.ksh SERIAL ${ACCOUNT} ${SINGLE_MODEL}
      qsub job.ksh
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
      source ${RS_SCRIPTS_DIR}/RS_AIRNOW_SO2.ksh > index_rs.html 2>&1
      export JOBRND=${TRANDOM}_airnso2
      ${JOB_CONTROL_SCRIPTS_DIR}/job_script_nasa_model.ksh ${JOBRND} ${SINGLE_JOB_CLASS} ${SINGLE_TIME_LIMIT} ${SINGLE_NODES} ${SINGLE_TASKS} jobx.ksh SERIAL ${ACCOUNT} ${SINGLE_MODEL}
      qsub job.ksh
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
      source ${RS_SCRIPTS_DIR}/RS_AIRNOW_PM10.ksh > index_rs.html 2>&1
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
      source ${RS_SCRIPTS_DIR}/RS_AIRNOW_PM25.ksh > index_rs.html 2>&1
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
      source ${RS_SCRIPTS_DIR}/RS_PANDA_CO.ksh > index_rs.html 2>&1
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
      source ${RS_SCRIPTS_DIR}/RS_PANDA_O3.ksh > index_rs.html 2>&1
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
      source ${RS_SCRIPTS_DIR}/RS_PANDA_PM25.ksh > index_rs.html 2>&1
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
      source ${RS_SCRIPTS_DIR}/RS_MEXICO_AQS_CO.ksh > index_rs.html 2>&1
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
      source ${RS_SCRIPTS_DIR}/RS_MET_Obs_NOAA.ksh > index_rs.html 2>&1
      export JOBRND=${TRANDOM}_metobs
      ${JOB_CONTROL_SCRIPTS_DIR}/job_script_nasa_model.ksh ${JOBRND} ${SINGLE_JOB_CLASS} ${SINGLE_TIME_LIMIT} ${SINGLE_NODES} ${SINGLE_TASKS} jobx.ksh SERIAL ${ACCOUNT} ${SINGLE_MODEL}
      qsub job.ksh
   fi
#          
   ${JOB_CONTROL_SCRIPTS_DIR}/da_run_hold_nasa.ksh ${TRANDOM}
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
      source ${RS_SCRIPTS_DIR}/RS_Combine_Obs_List.ksh > index_list.html 2>&1
      source ${RS_SCRIPTS_DIR}/RS_Combine.ksh > index_combine.html 2>&1
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
      cd ${RUN_DIR}/${DATE}/preprocess_obs
      export COMBINE_OBS_DIR=${RUN_DIR}/${DATE}/combine_obs
      source ${RS_SCRIPTS_DIR}/RS_WRFChem_Obs_Preprocess.ksh > index_preprocess.html 2>&1
   fi
#
##########################################################################
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
      cd ${RUN_DIR}/${DATE}/localization
      source ${RS_SCRIPTS_DIR}/RS_State_Variable_Localization.ksh > index_rs.html 2>&1
   fi
#
   export CYCLE_DATE=${NEXT_DATE}
done
#
