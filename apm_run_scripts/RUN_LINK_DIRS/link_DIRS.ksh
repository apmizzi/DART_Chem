#!/bin/ksh -aeux
#
export SOURCE_PATH=/nobackupp11/amizzi/OUTPUT_DATA
export TARGET_PATH=real_FRAPPE_CONTROL_CO
#export REFERN_PATH=real_FRAPPE_ALLCHEM_CO
export REFERN_PATH=real_FRAPPE_ALLCHEM_CPSR_CO
#export REFERN_PATH=real_FRAPPE_EMISADJ_CO
#export REFERN_PATH=real_FRAPPE_EMISADJ_CPSR_CO
#
export WRFDA_VERSION=WRFDAv4.3.2_dmpar
export BUILD_DIR=/nobackupp11/amizzi/TRUNK/${WRFDA_VERSION}/var/build
export TARGET_DIR=${SOURCE_PATH}/${TARGET_PATH}
export REFERN_DIR=${SOURCE_PATH}/${REFERN_PATH}
#
export DATE_STR=2014072518
export DATE_END=2014072518
export CYCLE_PERIOD=6
#
export L_DATE=${DATE_STR}
while [[ ${L_DATE} -le ${DATE_END} ]] ; do
#
# Confirm that target directory exists
   if [[ ! -d ${TARGET_DIR}/${L_DATE} ]]; then
      echo 'Target directory does not exist '
      exit
   fi
#
# Confirm that reference directory exists
   if [[ ! -d ${REFERN_DIR}/${L_DATE} ]]; then
      mkdir -p ${REFERN_DIR}/${L_DATE}
      echo 'Created reference directory '
   fi
#
# Move to the reference directory   
   cd ${REFERN_DIR}/${L_DATE}
#
# Link the directories
#   ln -sf -d ${TARGET_DIR}/${L_DATE}/real                real
#   ln -sf -d ${TARGET_DIR}/${L_DATE}/wrfchem_met_ic      wrfchem_met_ic
#   ln -sf -d ${TARGET_DIR}/${L_DATE}/wrfchem_met_bc      wrfchem_met_bc
   ln -sf -d ${TARGET_DIR}/${L_DATE}/exo_coldens         exo_coldens
   ln -sf -d ${TARGET_DIR}/${L_DATE}/seasons_wes         seasons_wes
   ln -sf -d ${TARGET_DIR}/${L_DATE}/wrfchem_bio         wrfchem_bio
   ln -sf -d ${TARGET_DIR}/${L_DATE}/wrfchem_chemi       wrfchem_chemi
   ln -sf -d ${TARGET_DIR}/${L_DATE}/wrfchem_fire        wrfchem_fire
   ln -sf -d ${TARGET_DIR}/${L_DATE}/wrfchem_chem_icbc   wrfchem_chem_icbc
   ln -sf -d ${TARGET_DIR}/${L_DATE}/wrfchem_chem_emiss  wrfchem_chem_emiss
   ln -sf -d ${TARGET_DIR}/${L_DATE}/preprocess_obs      preprocess_obs
   ln -sf -d ${TARGET_DIR}/${L_DATE}/localization        localization
   export L_DATE=$(${BUILD_DIR}/da_advance_time.exe ${L_DATE} ${CYCLE_PERIOD} 2>/dev/null)
done


