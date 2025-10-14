#!/bin/ksh -aux
#
# FORECAST PARAMETERS:
   export USE_DART_INFL=true
   (( CYCLE_PERIOD_SEC=${CYCLE_PERIOD}*60*60 ))
   export MAX_DOMAINS=01
   export CR_DOMAIN=01
   export FR_DOMAIN=02
   export NNXP_CR=440
   export NNYP_CR=284
   export NNZP_CR=50
   export NNXP_FR=192
   export NNYP_FR=174
   export NNZP_FR=50
   (( NNXP_STAG_CR=${NNXP_CR}+1 ))
   (( NNYP_STAG_CR=${NNYP_CR}+1 ))
   (( NNZP_STAG_CR=${NNZP_CR}+1 ))
   (( NNXP_STAG_FR=${NNXP_FR}+1 ))
   (( NNYP_STAG_FR=${NNYP_FR}+1 ))
   (( NNZP_STAG_FR=${NNZP_FR}+1 ))
   export NNZ_CHEM=20
   export NZ_CHEMI=${NNZ_CHEM}
   export NZ_FIRECHEMI=1
   export NZ_BIOGCHEMI=1
# number of species to perturb   
   export NSPCS=19
   export NNCHEM_SPC=20
   export NNFIRE_SPC=8
   export NNBIO_SPC=1
# total number of species
   export NICBC_SPC=39   
   export NCHEMI_EMISS=49
   export NFIRECHEMI_EMISS=19
   export NBIOCHEMI_EMISS=1
   export ISTR_CR=1
   export JSTR_CR=1
   export ISTR_FR=51
   export JSTR_FR=21
   export DX_CR=12000
   export DX_FR=4000
   (( LBC_END=2*${FCST_PERIOD} ))
   export LBC_FREQ=1.5
   export LBC_FREQ_TEXT=1h30m
   (( INTERVAL_SECONDS=${LBC_FREQ}*60*60 ))
   export LBC_START=0
   export START_DATE=${DATE}
   export END_DATE=$($BUILD_DIR/da_advance_time.exe ${START_DATE} ${FCST_PERIOD} -f ccyymmddhhnn 2>/dev/null)
   export START_YEAR=$(echo $START_DATE | cut -c1-4)
   export START_YEAR_SHORT=$(echo $START_DATE | cut -c3-4)
   export START_MONTH=$(echo $START_DATE | cut -c5-6)
   export START_DAY=$(echo $START_DATE | cut -c7-8)
   export START_HOUR=$(echo $START_DATE | cut -c9-10)
   export START_FILE_DATE=${START_YEAR}-${START_MONTH}-${START_DAY}_${START_HOUR}:00:00
   export END_YEAR=$(echo $END_DATE | cut -c1-4)
   export END_MONTH=$(echo $END_DATE | cut -c5-6)
   export END_DAY=$(echo $END_DATE | cut -c7-8)
   export END_HOUR=$(echo $END_DATE | cut -c9-10)
   export END_FILE_DATE=${END_YEAR}-${END_MONTH}-${END_DAY}_${END_HOUR}:00:00
