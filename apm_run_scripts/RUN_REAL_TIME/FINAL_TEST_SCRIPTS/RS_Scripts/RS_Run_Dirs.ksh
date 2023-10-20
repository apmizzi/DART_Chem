#!/bin/ksh -aux
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
   export RS_SCRIPTS_DIR=${REAL_TIME_DIR}/FINAL_TEST_SCRIPTS/RS_Scripts
