#!/bin/ksh -aux
#
rm jobx.ksh
touch jobx.ksh
chmod +x jobx.ksh
cat << EOF > jobx.ksh
#
      cd ${RUN_DIR}/${DATE}/mopitt_co_profile_obs
#
# SET MOPITT PARAMETERS
      export NL_PATH_MODEL=${WRFCHEM_TEMPLATE_DIR}
      export NL_FILE_MODEL=${WRFCHEM_TEMPLATE_FILE}
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export MOPITT_FILE_PRE=MOP02J-
      export MOPITT_FILE_EXT=-L2V18.0.3.he5 
      export OUTFILE=\'TEMP_FILE.dat\'
      export OUTFILE_NQ=TEMP_FILE.dat
      export MOP_OUTFILE=\'MOPITT_CO_${D_DATE}.dat\'
      export MOP_OUTFILE_NQ=MOPITT_CO_${D_DATE}.dat
#
#  SET OBS WINDOW
      export BIN_BEG_YY=${ASIM_MN_YYYY}
      export BIN_BEG_MM=${ASIM_MN_MM}
      export BIN_BEG_DD=${ASIM_MN_DD}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=${ASIM_MN_MN}
      export BIN_BEG_SS=${ASIM_MN_SS}
      export BIN_END_YY=${ASIM_MX_YYYY}
      export BIN_END_MM=${ASIM_MX_MM}
      export BIN_END_DD=${ASIM_MX_DD}
      export BIN_END_HH=${ASIM_MX_HH}
      export BIN_END_MN=${ASIM_MX_MN}
      export BIN_END_SS=${ASIM_MX_SS}
      if [[ ${HH} -eq 0 ]]; then
         export BIN_BEG_YY=${ASIM_MX_YYYY}
         export BIN_BEG_MM=${ASIM_MX_MM}
         export BIN_BEG_DD=${ASIM_MX_DD}
         export BIN_BEG_HH=00
         export BIN_BEG_MN=00
         export BIN_BEG_SS=01
      fi
      let HH_BEG=\${BIN_BEG_HH}
      let MN_BEG=\${BIN_BEG_MN}
      let SS_BEG=\${BIN_BEG_SS}
      let HH_END=\${BIN_END_HH}
      let MN_END=\${BIN_END_MN}
      let SS_END=\${BIN_END_SS}
      let BIN_BEG_SEC=\${HH_BEG}*3600+\${MN_BEG}*60+\${SS_BEG} 
      let BIN_END_SEC=\${HH_END}*3600+\${MN_END}*60+\${SS_END}
#
# SET MOPITT INPUT DATA FILE
      export INFILE=\'${EXPERIMENT_MOPITT_CO_DIR}/${YYYY}/${MM}/${DD}/\${MOPITT_FILE_PRE}${YYYY}${MM}${DD}\${MOPITT_FILE_EXT}\'
      export OUTFILE=TEMP_FILE.dat
      export OUTFILE_NQ=TEMP_FILE.dat
      export ARCHIVE_FILE=MOPITT_CO_${DATE}.dat
      rm -rf \${OUTFILE_NQ}
      rm -rf \${ARCHIVE_FILE}
#
# COPY EXECUTABLE
      rm mopitt_v8_co_profile_extract.m
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/MOPITT_CO/native_to_ascii/mopitt_v8_co_profile_extract.m ./.
      rm mopitt_v8_co_profile_extract
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/MOPITT_CO/native_to_ascii/work/mopitt_v8_co_profile_extract ./.
      rm run_mopitt_v8_co_profile_extract.sh
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/MOPITT_CO/native_to_ascii/work/run_mopitt_v8_co_profile_extract.sh ./.
#
      export HOME=/tmp
      cp /home1/amizzi/.Xauthority /tmp/.
#      mcc -m mopitt_v8_co_profile_extract.m -o mopitt_v8_co_profile_extract
      ./run_mopitt_v8_co_profile_extract.sh ${MATLAB} \${INFILE} \${OUTFILE} \${MOPITT_FILE_PRE} \${BIN_BEG_YY} \${BIN_BEG_MM} \${BIN_BEG_DD} \${BIN_BEG_HH} \${BIN_BEG_MN} \${BIN_BEG_SS} \${BIN_END_YY} \${BIN_END_MM} \${BIN_END_DD} \${BIN_END_HH} \${BIN_END_MN} \${BIN_END_SS} \${NL_PATH_MODEL} \${NL_FILE_MODEL} \${NL_NX_MODEL} \${NL_NY_MODEL} > index_mat1.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e \${ARCHIVE_FILE} && -e \${OUTFILE_NQ} ]]; then
         touch \${ARCHIVE_FILE}
         cat \${OUTFILE_NQ} >> \${ARCHIVE_FILE}
	 rm -rf \${OUTFILE_NQ}
      elif [[ -e \${ARCHIVE_FILE} && -e \${OUTFILE_NQ} ]]; then
         cat \${OUTFILE_NQ} >> \${ARCHIVE_FILE}
	 rm -rf \${OUTFILE_NQ}
      fi
#
# END OF PREVIOUS DAY
      if [[ ${HH} -eq 0 ]];  then
         export BIN_BEG_YY=${ASIM_MIN_YYYY}
         export BIN_BEG_MM=${ASIM_MIN_MM}
         export BIN_BEG_DD=${ASIM_MIN_DD}
         export BIN_BEG_HH=${ASIM_MIN_HH}
         export BIN_BEG_MN=${ASIM_MIN_MN}
         export BIN_BEG_SS=${ASIM_MIN_SS}
         export BIN_END_YY=${ASIM_MAX_YYYY}
         export BIN_END_MM=${ASIM_MAX_MM}
         export BIN_END_DD=${ASIM_MAX_DD}
         export BIN_END_HH=00
         export BIN_END_MN=00
         export BIN_END_SS=00
         export INFILE=\'${EXPERIMENT_MOPITT_CO_DIR}/${YYYY}/${MM}/${DD}/\${MOPITT_FILE_PRE}${PAST_YYYY}${PAST_MM}${PAST_DD}\${MOPITT_FILE_EXT}\'
         export OUTFILE=TEMP_FILE.dat
         export OUTFILE_NQ=TEMP_FILE.dat
         rm -rf \${OUTFILE_NQ}
#
# COPY EXECUTABLE
         rm mopitt_v8_co_profile
_extract.m
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/MOPITT_CO/native_to_ascii/mopitt_v8_co_profile_extract.m ./.
         rm mopitt_v8_co_profile_extract
_extract.m
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/MOPITT_CO/native_to_ascii/work/mopitt_v8_co_profile_extract ./.
         rm run_mopitt_v8_co_profile_extract.sh
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/MOPITT_CO/native_to_ascii/work/run_mopitt_v8_co_profile_extract.sh ./.
#
         export HOME=/tmp
         cp /home1/amizzi/.Xauthority /tmp/.
#         mcc -m mopitt_v8_co_profile_extract.m -o mopitt_v8_co_profile_extract
        ./run_mopitt_v8_co_profile_extract.sh ${MATLAB} \${INFILE} \${OUTFILE} \${MOPITT_FILE_PRE} \${BIN_BEG_YY} \${BIN_BEG_MM} \${BIN_BEG_DD} \${BIN_BEG_HH} \${BIN_BEG_MN} \${BIN_BEG_SS} \${BIN_END_YY} \${BIN_END_MM} \${BIN_END_DD} \${BIN_END_HH} \${BIN_END_MN} \${BIN_END_SS} \${NL_PATH_MODEL} \${NL_FILE_MODEL} \${NL_NX_MODEL} \${NL_NY_MODEL} > index_mat2.html 2>&1
      fi   
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e \${ARCHIVE_FILE} && -e \${OUTFILE_NQ} ]]; then
         touch \${ARCHIVE_FILE}
         cat \${OUTFILE_NQ} >> \${MOP_OUTFILE_NQ}
	 rm -rf \${OUTFILE_NQ}
      elif [[ -e \${ARCHIVE_FILE} && -e \${OUTFILE_NQ} ]]; then
         cat \${OUTFILE_NQ} >> \${ARCHIVE_FILE}
	 rm -rf \${OUTFILE_NQ}
      fi
      if [[ ! -e \${ARCHIVE_FILE} ]]; then
         touch NO_MOPITT_CO_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT MOPITT ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'\${ARCHIVE_FILE}\'
      export NL_FILEOUT=\'obs_seq_mopitt_co_profile_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_MOPITT_CO}
      export NL_USE_LOG_CO=${USE_LOG_CO_LOGIC}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
#
# MODEL PROFILE SETTINGS      
      export NL_PATH_MODEL=\'${WRFCHEM_TEMPLATE_DIR}\'
      export NL_FILE_MODEL=\'${WRFCHEM_TEMPLATE_FILE}\'
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export NL_NZ_MODEL=${NNZP_CR}
      export NL_MIN_LON=${NNL_MIN_LON}
      export NL_MAX_LON=${NNL_MAX_LON}
      export NL_MIN_LAT=${NNL_MIN_LAT}
      export NL_MAX_LAT=${NNL_MAX_LAT}
#
      export NL_YEAR=${D_YYYY}
      export NL_MONTH=${D_MM}
      export NL_DAY=${D_DD}
      export NL_HOUR=${D_HH}
      export BIN_BEG_HH=${ASIM_MN_HH}
      export BIN_BEG_MN=${ASIM_MN_MN}
      export BIN_BEG_SS=${ASIM_MN_SS}
      export BIN_END_HH=${ASIM_MX_HH}
      export BIN_END_MN=${ASIM_MX_MN}
      export BIN_END_SS=${ASIM_MX_SS}
      let HH_BEG=\${BIN_BEG_HH}
      let MN_BEG=\${BIN_BEG_MN}
      let SS_BEG=\${BIN_BEG_SS}
      let HH_END=\${BIN_END_HH}
      let MN_END=\${BIN_END_MN}
      let SS_END=\${BIN_END_SS}
      let BIN_BEG_SEC=\${HH_BEG}*3600+\${MN_BEG}*60+\${SS_BEG} 
      let BIN_END_SEC=\${HH_END}*3600+\${MN_END}*60+\${SS_END}
      export NL_BIN_BEG_SEC=\${BIN_BEG_SEC}
      export NL_BIN_END_SEC=\${BIN_END_SEC}
#
# USE MOPITT DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_mopitt_v8_input_nml.ksh
#
# DO THINNING
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/MOPITT_CO/work/mopitt_v8_co_profile_thinner ./.
      ./mopitt_v8_co_profile_thinner > index_thinner.html 2>&1
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/MOPITT_CO/work/mopitt_v8_co_profile_ascii_to_obs ./.
      ./mopitt_v8_co_profile_ascii_to_obs > index_ascii.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ ! -s \${NL_FILEOUT} ]]; then
         touch NO_MOPITT_CO_${DATE}
      fi
#
# Clean directory
#      rm dart_log* includedSupport* input.nml mccExcluded* *.dat mopitt_v8_co_profile*
#      rm readme.* requiredMCRP* run_mopitt_v8_co_profile_* includeSupport* unresolved*
EOF
