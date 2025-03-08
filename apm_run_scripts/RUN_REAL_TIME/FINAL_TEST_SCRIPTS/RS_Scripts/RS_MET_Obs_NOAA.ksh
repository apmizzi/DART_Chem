#!/bin/ksh -aux
#
      cd ${RUN_DIR}/${DATE}/prepbufr_met_obs
#
# GET PREPBUFR FILES
      export L_DATE=${YYYY}${MM}${DD}${HH}
      export L_YYYY=${YYYY}
      export L_MM=${MM}
      export L_DD=${DD}
      export L_HH=06
      export L_PAST_DATE=$(${BUILD_DIR}/da_advance_time.exe ${L_DATE} -24 2>/dev/null)
      export L_PAST_YYYY=$(echo ${L_PAST_DATE} | cut -c1-4)
      export L_PAST_YY=$(echo ${L_PAST_DATE} | cut -c3-4)
      export L_PAST_MM=$(echo ${L_PAST_DATE} | cut -c5-6)
      export L_PAST_DD=$(echo ${L_PAST_DATE} | cut -c7-8)
      export L_PAST_HH=06
#	  
      export LD_DATE=${L_DATE}
      export LD_YYYY=${YYYY}
      export LD_YY=${YY}
      export LD_MM=${MM}
      export LD_DD=${DD}
      export LD_HH=${HH}
      export LD_PAST_DATE=${L_PAST_DATE}
      export LD_PAST_YYYY=${L_PAST_YYYY}
      export LD_PAST_YY=${L_PAST_YY}
      export LD_PAST_MM=${L_PAST_MM}
      export LD_PAST_DD=${L_PAST_DD}
      export LD_PAST_HH=${L_PAST_HH}
      if [[ ${HH} -eq 00 || ${HH} -eq 03 ]]; then
         export LD_DATE=${L_PAST_YYYY}${L_PAST_MM}${L_PAST_DD}00
         export LD_YYYY=${L_PAST_YYYY}
         export LD_YY=${L_PAST_YY}
         export LD_MM=${L_PAST_MM}
         export LD_DD=${L_PAST_DD}
         export LD_HH=24
	 export LD_NEXT_DATE=$(${BUILD_DIR}/da_advance_time.exe ${LD_DATE} 24 2>/dev/null)
         export LD_NEXT_YYYY=$(echo ${LD_NEXT_DATE} | cut -c1-4)
         export LD_NEXT_YY=$(echo ${LD_NEXT_DATE} | cut -c3-4)
         export LD_NEXT_MM=$(echo ${LD_NEXT_DATE} | cut -c5-6)
         export LD_NEXT_DD=$(echo ${LD_NEXT_DATE} | cut -c7-8)
         export LD_NEXT_HH=24
         (( LDD_NEXT_YYYY = ${LD_NEXT_YYYY} + 0 ))
         (( LDD_NEXT_MM = ${LD_NEXT_MM} + 0 ))
         (( LDD_NEXT_DD = ${LD_NEXT_DD} + 0 ))
         (( LDD_NEXT_HH = ${LD_NEXT_HH} + 0 ))
      fi
      (( LDD_YYYY = ${LD_YYYY} + 0 ))
      (( LDD_MM = ${LD_MM} + 0 ))
      (( LDD_DD = ${LD_DD} + 0 ))
      (( LDD_HH = ${LD_HH} + 0 ))
#
      export S_DATE=${L_YYYY}${L_MM}${L_DD}06
      export S_YYYY=${L_YYYY}
      export S_MM=${L_MM}
      export S_DD=${L_DD}
      export S_HH=06
      if [[ ${HH} -eq 00 || ${HH} -eq 03 ]]; then
	 export S_DATE=${L_PAST_YYYY}${L_PAST_MM}${L_PAST_DD}06
         export S_YYYY=${L_PAST_YYYY}
         export S_MM=${L_PAST_MM}
         export S_DD=${L_PAST_DD}
         export S_HH=06
      fi
      export E_DATE=$(${BUILD_DIR}/da_advance_time.exe ${S_DATE} +24 2>/dev/null)
      if [[ ${HH} -eq 03 ]]; then
         export E_DATE=$(${BUILD_DIR}/da_advance_time.exe ${S_DATE} +48 2>/dev/null)
      fi
#     
      while [[ ${S_DATE} -le ${E_DATE} ]]; do
         export S_YYYY=$(echo $S_DATE | cut -c1-4)
         export S_YY=$(echo $S_DATE | cut -c3-4)
         export S_MM=$(echo $S_DATE | cut -c5-6)
         export S_DD=$(echo $S_DATE | cut -c7-8)
         export S_HH=$(echo $S_DATE | cut -c9-10)
         cp ${EXPERIMENT_PREPBUFR_DIR}/${S_YYYY}/${S_MM}/${S_DD}/prepbufr.gdas.${S_YYYY}${S_MM}${S_DD}${GDAS_HR_PREFIX}${S_HH}${GDAS_HR_SUFFIX} prepqm${S_YY}${S_MM}${S_DD}${S_HH}
         export S_DATE=$(${BUILD_DIR}/da_advance_time.exe ${S_DATE} +6 2>/dev/null)
      done
#
# SAVE SETTINGS
      export D_YYYY_SAV=${D_YYYY}
      export D_MM_SAV=${D_MM}
      export D_DD_SAV=${D_DD}
#
# CONVERT PREPBUFR TO OBS_SEQ
      export D_YYYY=${LD_YYYY}
      export D_MM=${LD_MM}
      export D_DD=${LD_DD}
      rm -rf input.nml
      cp ${DART_DIR}/observations/obs_converters/NCEP/prep_bufr/work/input.nml ./.
      ${DART_DIR}/observations/obs_converters/NCEP/prep_bufr/work/prepbufr_RT.csh ${LDD_YYYY} ${LDD_MM} ${LDD_DD} ${LDD_DD} ${DART_DIR}/observations/obs_converters/NCEP/prep_bufr/exe > index_ascii_1.file 2>&1
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_ncep_ascii_to_obs_input_nml_RT.ksh
      ${DART_DIR}/observations/obs_converters/NCEP/ascii_to_obs/work/create_real_obs > index_create_1 2>&1
#
      if [[ ${HH} -eq 00 || ${HH} -eq 03 ]]; then
         export D_YYYY=${LD_NEXT_YYYY}
         export D_MM=${LD_NEXT_MM}
         export D_DD=${LD_NEXT_DD}
         rm -rf input.nml
         cp ${DART_DIR}/observations/obs_converters/NCEP/prep_bufr/work/input.nml ./.
         ${DART_DIR}/observations/obs_converters/NCEP/prep_bufr/work/prepbufr_RT.csh ${LDD_NEXT_YYYY} ${LDD_NEXT_MM} ${LDD_NEXT_DD} ${LDD_NEXT_DD} ${DART_DIR}/observations/obs_converters/NCEP/prep_bufr/exe > index_ascii_2.file 2>&1
         ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_ncep_ascii_to_obs_input_nml_RT.ksh
         ${DART_DIR}/observations/obs_converters/NCEP/ascii_to_obs/work/create_real_obs > index_create_2 2>&1
      fi
#
# RESET SETTINGS
      export D_YYYY=${D_YYYY_SAV}
      export D_MM=${D_MM_SAV}
      export D_DD=${D_DD_SAV}
#
# COMBINE OBS_SEQ FILES FOR 3-HR CYCLING
      export NL_FILENAME_OUT="'obs_seq.proc'"
      export NL_FIRST_OBS_DAYS=${ASIM_MIN_DAY_GREG}
      export NL_FIRST_OBS_SECONDS=${ASIM_MIN_SEC_GREG}
      export NL_LAST_OBS_DAYS=${ASIM_MAX_DAY_GREG}
      export NL_LAST_OBS_SECONDS=${ASIM_MAX_SEC_GREG}
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
      rm -rf input.nml
#
      cp ${WRFCHEM_DART_WORK_DIR}/obs_sequence_tool ./.
      if [[ ${HH} -eq 03 ]]; then
         export NL_NUM_INPUT_FILES=2
         export NL_FILENAME_SEQ=\'obs_seq${LD_YYYY}${LD_MM}${LD_DD}24\',\'obs_seq${LD_NEXT_YYYY}${LD_NEXT_MM}${LD_NEXT_DD}06\'
         ${NAMELIST_SCRIPTS_DIR}/MISC/da_create_dart_input_nml.ksh
         ./obs_sequence_tool > index_obs_seq.html 2>&1
         mv obs_seq.proc obs_seq_prep_${LD_NEXT_YYYY}${LD_NEXT_MM}${LD_NEXT_DD}03.out
      fi
      if [[ ${HH} -eq 09 ]]; then
         export NL_NUM_INPUT_FILES=2
         export NL_FILENAME_SEQ=\'obs_seq${LD_YYYY}${LD_MM}${LD_DD}06\',\'obs_seq${LD_YYYY}${LD_MM}${LD_DD}12\'
         ${NAMELIST_SCRIPTS_DIR}/MISC/da_create_dart_input_nml.ksh
         ./obs_sequence_tool > index_obs_seq.html 2>&1
         mv obs_seq.proc obs_seq_prep_${LD_YYYY}${LD_MM}${LD_DD}09.out
      fi
      if [[ ${HH} -eq 15 ]]; then
         export NL_NUM_INPUT_FILES=2
         export NL_FILENAME_SEQ=\'obs_seq${LD_YYYY}${LD_MM}${LD_DD}12\',\'obs_seq${LD_YYYY},${LD_MM}${LD_DD}18\'
         ${NAMELIST_SCRIPTS_DIR}/MISC/da_create_dart_input_nml.ksh
         ./obs_sequence_tool > index_obs_seq.html 2>&1
         mv obs_seq.proc obs_seq_prep_${LD_YYYY}${LD_MM}${LD_DD}15.out
      fi
      if [[ ${HH} -eq 21 ]]; then
         export NL_NUM_INPUT_FILES=2
         export NL_FILENAME_SEQ=\'obs_seq${LD_YYYY}${LD_MM}${LD_DD}18\',\'obs_seq${LD_YYYY},${LD_MM}${LD_DD}24\'
         ${NAMELIST_SCRIPTS_DIR}/MISC/da_create_dart_input_nml.ksh
         ./obs_sequence_tool > index_obs_seq.html 2>&1
         mv obs_seq.proc obs_seq_prep_${LD_YYYY}${LD_MM}${LD_DD}21.out
      fi
      if [[ ${HH} -eq 00 ]]; then
         export NL_NUM_INPUT_FILES=1
         export NL_FILENAME_SEQ=\'obs_seq${LD_YYYY}${LD_MM}${LD_DD}24\'
         ${NAMELIST_SCRIPTS_DIR}/MISC/da_create_dart_input_nml.ksh
         ./obs_sequence_tool > index_obs_seq.html 2>&1
         mv obs_seq.proc obs_seq_prep_${LD_NEXT_YYYY}${LD_NEXT_MM}${LD_NEXT_DD}00.out
      fi
      if [[ ${HH} -eq 06 ]]; then
         export NL_NUM_INPUT_FILES=1
         export NL_FILENAME_SEQ=\'obs_seq${LD_YYYY}${LD_MM}${LD_DD}06\'
         ${NAMELIST_SCRIPTS_DIR}/MISC/da_create_dart_input_nml.ksh
         ./obs_sequence_tool > index_obs_seq.html 2>&1
         mv obs_seq.proc obs_seq_prep_${LD_YYYY}${LD_MM}${LD_DD}06.out
      fi
      if [[ ${HH} -eq 12 ]]; then
         export NL_NUM_INPUT_FILES=1
         export NL_FILENAME_SEQ=\'obs_seq${LD_YYYY}${LD_MM}${LD_DD}12\'
         ${NAMELIST_SCRIPTS_DIR}/MISC/da_create_dart_input_nml.ksh
         ./obs_sequence_tool > index_obs_seq.html 2>&1
         mv obs_seq.proc obs_seq_prep_${LD_YYYY}${LD_MM}${LD_DD}12.out
      fi
      if [[ ${HH} -eq 18 ]]; then
         export NL_NUM_INPUT_FILES=1
         export NL_FILENAME_SEQ=\'obs_seq${LD_YYYY}${LD_MM}${LD_DD}18\'
         ${NAMELIST_SCRIPTS_DIR}/MISC/da_create_dart_input_nml.ksh
         ./obs_sequence_tool > index_obs_seq.html 2>&1
         mv obs_seq.proc obs_seq_prep_${LD_YYYY}${LD_MM}${LD_DD}18.out
      fi
#
# Clean directory
#      rm dart_log* index_create index.file input.nml mccExcluded* prepqm* temp_obs.2014*
#      rm obs_seq2* temp_obs*
