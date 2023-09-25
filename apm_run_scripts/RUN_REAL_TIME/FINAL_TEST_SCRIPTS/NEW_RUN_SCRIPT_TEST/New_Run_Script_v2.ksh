#!/bin/ksh -aux
#
##########################################################################
#
# Purpose: Set global environment variables for real_time_wrf_chem
#
#########################################################################
#
# Set date-time parameters for cycling, inflation, and emission estimation
# Set start cycle date-time.
   export CYCLE_STR_DATE=2014072518
#
# Set end cycle date-time.
   export CYCLE_END_DATE=2014072518

# Set Root Directories.
   export SCRATCH_DIR=/nobackupp11/amizzi/OUTPUT_DATA
   export WORK_DIR=/nobackupp11/amizzi
   export INPUT_DATA_DIR=/nobackupp11/amizzi/INPUT_DATA
   export EXPERIMENT_NAME=/FRAPPE_ALLCHEM
#
# Create dependent directory path names
   source Dependent_Directory_Settings.ksh   
#
# Set 'Initial Cycle','First-Assimilation Cycle', 'First Inflation', and
# 'First Emissions Estimation' date-times.
   export INITIAL_DATE=2014072500
   export FIRST_FILTER_DATE=2014072506
   export FIRST_DART_INFLATE_DATE=2014072506
   export FIRST_EMISS_INV_DATE=2014072506
#
# Set flags for emissions estimation and using lognormal assimilation.
   export USE_LOG=false
   export ADD_EMISS=false
#
# Set flags for generating meteorology and chemistry ICs/BCs, emissions, and
# ensembles.
   export RUN_GENERATE_ICBC_EMISSION=true
   if [[ ${RUN_GENERATE_ICBC_EMISSIONS = "true" ]]; then 
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
   fi
#
# Set flags for generation observation obs_squence files. Inside each
# observation platform script, select the observation species and type
# that you want to assimilate.
   export RUN_GENERATE_OBSERVATIONS=true
   if [[ ${RUN_GENERATE_OBSERVATIONS = "true" ]]; then 
      export RUN_MOPITT=false
      export RUN_IASI=false
      export RUN_MODIS=false
      export RUN_OMI=false
      export RUN_TROPOMI=false
      export RUN_TEMPO=false
      export RUN_TES=false
      export RUN_CRIS=false
      export RUN_SCIAMACHY=false
      export RUN_GOME2A=false
      export RUN_MLS=false
      export RUN_AIRNOW=false
      export RUN_PANDA=false
      export RUN_MEXICO_AQS=false
      export RUN_MET_OBS=false
   fi
#
# Set flags to combine and preprocess observations
   export RUN_COMBINE=true
   export RUN_PREPROCESS=true
#
# Set flags for forecast/assimilation/emissions estimation cycling
   export RUN_LOCALIZATION=false
   export RUN_DART_FILTER=true
   export RUN_BIAS_CORRECTION=false
   export RUN_UPDATE_BC=true
   export RUN_WRFCHEM_CYCLE_CR=true
   export RUN_ENSEMBLE_MEAN_INPUT=true
   export RUN_ENSEMBLE_MEAN_OUTPUT=true
#
# Create cycle and assimilation time variables
   source Date_and_Time_Settings.ksh
#
# Set flags for default or special task. See Default_Flag_Settings.ksh for these tasks/flags.
   source Default_Flag_Settings.ksh   
#
# Create cycle and assimilation time variables
   source Runtime_Directory_Settings.ksh
#
# Create the run directory
   if [[ ! -e ${RUN_DIR} ]]; then mkdir -p ${RUN_DIR}; fi
#
# Create geogrid only one time   
#  if [[ ! -d ${RUN_DIR}/geogrid ]]; then
      export RUN_GEOGRID=true
      source Run_Geogrid.ksh
      export RUN_GEOGRID=false
   fi
#
#########################################################################
#
# Start of forecast/assimilation cycling loop
#
#########################################################################
#
while [[ ${CYCLE_DATE} -le ${CYCLE_END_DATE} ]]; do
   export DATE=${CYCLE_DATE}
   export L_ADD_EMISS=${ADD_EMISS} 
   if [[ ${DATE} -lt ${FIRST_EMISS_INV_DATE} ]]; then
      export L_ADD_EMISS=false
   fi
#
# Check if it is necessary to create met/chem ICs/BCs, emissions, and perturbations
   if [[ ${GENERATE_ICBC_EMISSIONS} = "true" ]]; then
      source Run_Ungrib.ksh
      source Run_Metgrib.ksh
      source Run_Real.ksh
      source Run_Perturb_Met_ICs.ksh
      source Run_Perturb_Met_BCs.ksh
      source Run_WRFChem_Exo_Coldens.ksh
      source Run_WRFChem_Seasons_Wes.ksh
      source Run_Biogenic_Emis.ksh
      source Run_Biomass_Burning_Emis.ksh
      source Run_Anthropogenic_Emis.ksh
      source Run_Perturb_Chem_ICBCs.ksh
      source Run_Perturb_Chem_Emissions.ksh
   fi
#
# Check if it is necessary to create the observations.
   if [[ ${GENERATE_OBSERVATIONS} = "true" ]]; then
      source Run_MOPITT_Obs.ksh
      source Run_IASI_Obs.ksh
      source Run_MODIS_Obs.ksh
      source Run_OMI_Obs.ksh
      source Run_OMI_DOMINO_Obs.ksh
      source Run_GOME2A_Obs.ksh
      source Run_MLS_Obs.ksh
      source Run_TES_Obs.ksh
#
      source Run_TROPOMI_obs.ksh
      source Run_TEMPO_obs.ksh
      source Run_CRIS_obs.ksh
      source Run_SCIAMACHY_obs.ksh
#
      source Run_AIRNOW_Obs.ksh
      source Run_PANDA_Obs.ksh
      source Run_MEXICO_AQS_Obs.ksh
#
      source Run_PREPBUFR_Obs.ksh
#
      source Run_Combine.ksh
      source Run_Preprocess.ksh
   fi
#   
# Run forecast/assimilation/emissions estimation cycling
   source Run_State_Variable_Localization.ksh
   source Run_Filter.ksh
   source Run_Update_BCs.ksh
   source Run_WRFChem_Cycle_Cr.ksh
   source Run_Ensemble_Mean_Input.ksh
   source Run_Ensemble_Mean_Output.ksh
#
   export CYCLE_DATE=${NEXT_DATE}
done
#
