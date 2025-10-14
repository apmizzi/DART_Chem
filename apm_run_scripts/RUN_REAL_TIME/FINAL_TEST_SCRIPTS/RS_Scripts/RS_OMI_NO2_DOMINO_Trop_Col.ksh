#!/bin/ksh -aux
#
rm jobx.ksh
touch jobx.ksh
chmod +x jobx.ksh
cat << EOF > jobx.ksh
#
      cd ${RUN_DIR}/${DATE}/omi_no2_domino_trop_col_obs
#
# SET OMI PARAMETERS
      export NL_PATH_MODEL=${WRFCHEM_TEMPLATE_DIR}
      export NL_FILE_MODEL=${WRFCHEM_TEMPLATE_FILE}
      export NL_NX_MODEL=${NNXP_CR}
      export NL_NY_MODEL=${NNYP_CR}
      export OMI_FILE_PRE=QA4ECV_L2_NO2_OMI_
      export OMI_FILE_EXT=_fitB_v1.nc
      export OUTFILE=TEMP_FILE.dat
      export TMP_OUTFILE=OMI_NO2_DOMINO_${DATE}.dat
      rm -rf \${OUTFILE}
      rm -rf \${TMP_OUTFILE}
#
# SET OBS_WINDOW
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
      export FLG=0
      if [[ ${HH} -eq 0 ]]; then
         export FLG=1 
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
# SET OMI INPUT DATA DIR
      export TMP_INFILE=\'${EXPERIMENT_OMI_NO2_DOMINO_DIR}/\${BIN_BEG_YY}/\${BIN_BEG_MM}/\${BIN_BEG_DD}/\${OMI_FILE_PRE}\'
#
# COPY EXECUTABLE
      rm omi_no2_domino_trop_col_extract.m
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/OMI_NO2/native_to_ascii/omi_no2_domino_trop_col_extract.m ./.
      rm omi_no2_domino_trop_col_extract
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/OMI_NO2/native_to_ascii/work/omi_no2_domino_trop_col_extract ./.
      rm run_omi_no2_domino_trop_col_extract.sh
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/OMI_NO2/native_to_ascii/work/run_omi_no2_domino_trop_col_extract.sh ./.
#
      export HOME=/tmp
      cp /home1/amizzi/.Xauthority /tmp/.
#      mcc -m omi_no2_domino_trop_col_extract.m -o omi_no2_domino_trop_col_extract
      ./run_omi_no2_domino_trop_col_extract.sh ${MATLAB} \${TMP_INFILE} \${OUTFILE} \${OMI_FILE_PRE} \${BIN_BEG_YY} \${BIN_BEG_MM} \${BIN_BEG_DD} \${BIN_BEG_HH} \${BIN_BEG_MN} \${BIN_BEG_SS} \${BIN_END_YY} \${BIN_END_MM} \${BIN_END_DD} \${BIN_END_HH} \${BIN_END_MN} \${BIN_END_SS} \${NL_PATH_MODEL} \${NL_FILE_MODEL} \${NL_NX_MODEL} \${NL_NY_MODEL} > index_mat1.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
      if [[ ! -e \${TMP_OUTFILE} && -e \${OUTFILE} ]]; then
         touch \${TMP_OUTFILE}
         cat \${OUTFILE} >> \${TMP_OUTFILE}
         rm -rf \${OUTFILE}
      elif [[ -e \${TMP_OUTFILE} && -e \${OUTFILE} ]]; then
         cat \${OUTFILE} >> \${TMP_OUTFILE}
         rm -rf \${OUTFILE}
      fi
#
# END OF PREVIOUS DAY (hours 21 to 24 obs)
      if [[ ${HH} -eq 0 ]]; then	 
         export BIN_BEG_YY=${ASIM_MIN_YYYY}
         export BIN_BEG_MM=${ASIM_MIN_MM}
         export BIN_BEG_DD=${ASIM_MIN_DD}
         export BIN_BEG_HH=${ASIM_MIN_HH}
         export BIN_BEG_MN=${ASIM_MIN_MN}
         export BIN_BEG_SS=${ASIM_MIN_SS}
         export BIN_END_YY=${ASIM_MIN_YYYY}
         export BIN_END_MM=${ASIM_MIN_MM}
         export BIN_END_DD=${ASIM_MIN_DD}
         export BIN_END_HH=00
         export BIN_END_MN=00
         export BIN_END_SS=00
         export TMP_INFILE=\'${EXPERIMENT_OMI_NO2_DOMINO_DIR}/\${BIN_BEG_YY}/\${BIN_BEG_MM}/\${BIN_BEG_DD}/\${OMI_FILE_PRE}\'
#
# COPY EXECUTABLE
         rm omi_no2_domino_trop_col_extract.m
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/OMI_NO2/native_to_ascii/omi_no2_domino_trop_col_extract.m ./.
         rm omi_no2_domino_trop_col_extract
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/OMI_NO2/native_to_ascii/work/omi_no2_domino_trop_col_extract ./.
         rm run_omi_no2_domino_trop_col_extract.sh
         cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/OMI_NO2/native_to_ascii/work/run_omi_no2_domino_trop_col_extract.sh ./.
#
         export HOME=/tmp
         cp /home1/amizzi/.Xauthority /tmp/.
#         mcc -m omi_no2_domino_trop_col_extract.m -o omi_no2_domino_trop_col_extract
         ./run_omi_no2_domino_trop_col_extract.sh ${MATLAB} \${TMP_INFILE} \${OUTFILE} \${OMI_FILE_PRE} \${BIN_BEG_YY} \${BIN_BEG_MM} \${BIN_BEG_DD} \${BIN_BEG_HH} \${BIN_BEG_MN} \${BIN_BEG_SS} \${BIN_END_YY} \${BIN_END_MM} \${BIN_END_DD} \${BIN_END_HH} \${BIN_END_MN} \${BIN_END_SS} \${NL_PATH_MODEL} \${NL_FILE_MODEL} \${NL_NX_MODEL} \${NL_NY_MODEL} > index_mat2.html 2>&1
#
# CHECK IF OUTFILE EXISTS AND ATTACH TO ARCHIVE FILE
         if [[ ! -e \${TMP_OUTFILE} && -e \${OUTFILE} ]]; then
            touch \${TMP_OUTFILE}
            cat \${OUTFILE} >> \${TMP_OUTFILE}
            rm -rf \${OUTFILE}
         elif [[ -e \${TMP_OUTFILE} && -e \${OUTFILE} ]]; then
            cat \${OUTFILE} >> \${TMP_OUTFILE}
            rm -rf \${OUTFILE}
         fi
      fi
#
      if [[ ! -e \${TMP_OUTFILE} ]]; then
         touch NO_OMI_NO2_DOMINO_${DATE}_DATA
      fi
#
# SET NAMELIST TO CONVERT OMI NO2 ASCII TO OBS_SEQ 
      export NL_FILEDIR=\'./\' 
      export NL_FILENAME=\'\${TMP_OUTFILE}\'
      export NL_FILEOUT=\'obs_seq_omi_no2_domino_trop_col_${DATE}.out\'
      export NL_FAC_OBS_ERROR=${NL_FAC_OBS_ERROR_OMI_NO2_DOMINO}
      export NL_USE_LOG_O3=${USE_LOG_O3_LOGIC}
      export NL_USE_LOG_NO2=${USE_LOG_NO2_LOGIC}
      export NL_USE_LOG_SO2=${USE_LOG_SO2_LOGIC}
      export NL_USE_LOG_HCHO=${USE_LOG_HCHO_LOGIC}
      export NL_OMI_O3_RETEN_FREQ=${NNL_OMI_O3_RETEN_FREQ}
      export NL_OMI_NO2_RETEN_FREQ=${NNL_OMI_NO2_RETEN_FREQ}
      export NL_OMI_SO2_RETEN_FREQ=${NNL_OMI_SO2_RETEN_FREQ}
      export NL_OMI_HCHO_RETEN_FREQ=${NNL_OMI_HCHO_RETEN_FREQ}
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
# USE OMI DATA 
      rm -rf input.nml
      ${NAMELIST_SCRIPTS_DIR}/OBS_CONVERTERS/da_create_dart_omi_input_nml.ksh
#
# DO THINNING
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/OMI_NO2/work/omi_no2_domino_trop_col_thinner ./.
      ./omi_no2_domino_trop_col_thinner > index_thinner.html 2>&1
#
# GET EXECUTABLE
      cp ${DART_DIR}/observations/obs_converters/ATMOS_CHEM/OMI_NO2/work/omi_no2_domino_trop_col_ascii_to_obs ./.
      ./omi_no2_domino_trop_col_ascii_to_obs > index_ascii.html 2>&1
#
# COPY OUTPUT TO ARCHIVE LOCATION
      if [[ -s \${NL_FILEOUT} ]]; then
         touch NO_OMI_NO2_DOMINO_${DATE}
      fi
#
# Clean directory
#      rm dart_log* includedSupport* input.nml mccExcluded* readme.txt
#      rm requiredMCRP* run_omi_no2_domino* omi_no2_domino_trop* unresolved* *.dat
EOF
