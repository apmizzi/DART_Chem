#!/bin/ksh -aux
# 
   cd ${EXP_INPUT_OBS}
   rm -rf combine_obs
   rm -rf preprocess_obs
   rm -rf index.html
#   
#########################################################################
#
# RUN COMBINE OBSERVATIONS
#
#########################################################################
#
   if ${RUN_COMBINE_OBS}; then
      if [[ ! -d ${EXP_INPUT_OBS}/combine_obs ]]; then
         mkdir -p ${EXP_INPUT_OBS}/combine_obs
         cd ${EXP_INPUT_OBS}/combine_obs
      else
         cd ${EXP_INPUT_OBS}/combine_obs
      fi
      cd ${EXP_INPUT_OBS}/combine_obs
      source ${RS_SCRIPTS_DIR}/RS_Combine.ksh > index_combine.html 2>&1
      sleep 5
      if [[ ! -f obs_seq_comb_${DATE}.out ]]; then
          exit
      fi  
  fi
#
#########################################################################
#
# RUN PREPROCESS OBSERVATIONS
#
#########################################################################
#
   if ${RUN_PREPROCESS_OBS}; then
      if [[ ! -d ${EXP_INPUT_OBS}/preprocess_obs ]]; then
         mkdir -p ${EXP_INPUT_OBS}/preprocess_obs
         cd ${EXP_INPUT_OBS}/preprocess_obs
      else
         cd ${EXP_INPUT_OBS}/preprocess_obs
      fi
      cd ${EXP_INPUT_OBS}/preprocess_obs
      source ${RS_SCRIPTS_DIR}/RS_WRFChem_Obs_Preprocess.ksh > index_preprocess.html 2>&1
      sleep 5
      if [[ ! -f obs_seq_comb_filtered_${DATE}.out ]]; then
          exit
      fi  
   fi
