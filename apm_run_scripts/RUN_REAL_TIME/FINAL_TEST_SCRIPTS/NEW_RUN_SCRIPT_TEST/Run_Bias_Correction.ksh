#!/bin/ksh -aux
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
