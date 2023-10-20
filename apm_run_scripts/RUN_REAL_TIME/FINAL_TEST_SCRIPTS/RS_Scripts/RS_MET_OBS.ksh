#!/bin/ksh -aux
#
      cd ${RUN_DIR}/${DATE}/mexico_aqs_obs
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
#
# Clean directory
      rm dart_log* input.nml mccExcluded* obs_seq2014* prepqm*temp_obs.2014*
