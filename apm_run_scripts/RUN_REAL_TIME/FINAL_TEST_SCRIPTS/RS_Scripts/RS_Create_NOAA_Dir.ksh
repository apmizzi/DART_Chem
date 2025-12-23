#!/bin/ksh -aux
#
   cd ${RUN_DIR}/${DATE}
#
# Create NOAA directory
   if [[ ! -d NOAA ]]; then
      mkdir NOAA
   fi
#   
# Move combine_obs and preprocess_obs to NOAA
   if [[ -d combine_obs ]]; then
      mv combine_obs NOAA
   else
      echo APM ERROR: combine_obs does not exist
      exit
   fi
#
   if [[ -d preprocess_obs ]]; then
      mv preprocess_obs NOAA
   else
      echo APM ERROR: preprocess_obs does not exist
      exit
   fi
#
