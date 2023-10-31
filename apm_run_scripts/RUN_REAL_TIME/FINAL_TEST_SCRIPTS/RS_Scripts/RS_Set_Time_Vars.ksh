#!/bin/ksh -aux
   export YYYY=$(echo $DATE | cut -c1-4)
   export YY=$(echo $DATE | cut -c3-4)
   export MM=$(echo $DATE | cut -c5-6)
   export DD=$(echo $DATE | cut -c7-8)
   export HH=$(echo $DATE | cut -c9-10)
   export DATE_SHORT=${YY}${MM}${DD}${HH}
   export FILE_DATE=${YYYY}-${MM}-${DD}_${HH}:00:00
   export PAST_DATE=$(${BUILD_DIR}/da_advance_time.exe ${DATE} -${CYCLE_PERIOD} 2>/dev/null)
   export PAST_YYYY=$(echo $PAST_DATE | cut -c1-4)
   export PAST_YY=$(echo $PAST_DATE | cut -c3-4)
   export PAST_MM=$(echo $PAST_DATE | cut -c5-6)
   export PAST_DD=$(echo $PAST_DATE | cut -c7-8)
   export PAST_HH=$(echo $PAST_DATE | cut -c9-10)
   export PAST_FILE_DATE=${PAST_YYYY}-${PAST_MM}-${PAST_DD}_${PAST_HH}:00:00
   export NEXT_DATE=$(${BUILD_DIR}/da_advance_time.exe ${DATE} +${CYCLE_PERIOD} 2>/dev/null)
   export NEXT_YYYY=$(echo $NEXT_DATE | cut -c1-4)
   export NEXT_YY=$(echo $NEXT_DATE | cut -c3-4)
   export NEXT_MM=$(echo $NEXT_DATE | cut -c5-6)
   export NEXT_DD=$(echo $NEXT_DATE | cut -c7-8)
   export NEXT_HH=$(echo $NEXT_DATE | cut -c9-10)
   export NEXT_FILE_DATE=${NEXT_YYYY}-${NEXT_MM}-${NEXT_DD}_${NEXT_HH}:00:00
#
# DART TIME DATA
   export DT_YYYY=${YYYY}
   export DT_YY=${YY}
   export DT_MM=${MM} 
   export DT_DD=${DD} 
   export DT_HH=${HH} 
   (( DT_MM = ${DT_MM} + 0 ))
   (( DT_DD = ${DT_DD} + 0 ))
   (( DT_HH = ${DT_HH} + 0 ))
   if [[ ${HH} -eq 0 ]]; then
      export TMP_DATE=$(${BUILD_DIR}/da_advance_time.exe ${DATE} -1 2>/dev/null)
      export TMP_YYYY=$(echo $TMP_DATE | cut -c1-4)
      export TMP_YY=$(echo $TMP_DATE | cut -c3-4)
      export TMP_MM=$(echo $TMP_DATE | cut -c5-6)
      export TMP_DD=$(echo $TMP_DATE | cut -c7-8)
      export TMP_HH=$(echo $TMP_DATE | cut -c9-10)
      export D_YYYY=${TMP_YYYY}
      export D_YY=${TMP_YY}
      export D_MM=${TMP_MM}
      export D_DD=${TMP_DD}
      export D_HH=24
      (( DD_MM = ${D_MM} + 0 ))
      (( DD_DD = ${D_DD} + 0 ))
      (( DD_HH = ${D_HH} + 0 ))
   else
      export D_YYYY=${YYYY}
      export D_YY=${YY}
      export D_MM=${MM}
      export D_DD=${DD}
      export D_HH=${HH}
      (( DD_MM = ${D_MM} + 0 ))
      (( DD_DD = ${D_DD} + 0 ))
      (( DD_HH = ${D_HH} + 0 ))
   fi
   export D_DATE=${D_YYYY}${D_MM}${D_DD}${D_HH}
#
# CALCULATE GREGORIAN TIMES FOR START AND END OF ASSIMILATION WINDOW
   set -A GREG_DATA `echo $DATE 0 -g | ${WRFCHEM_DART_WORK_DIR}/advance_time`
   export DAY_GREG=${GREG_DATA[0]}
   export SEC_GREG=${GREG_DATA[1]}
   set -A GREG_DATA `echo $NEXT_DATE 0 -g | ${WRFCHEM_DART_WORK_DIR}/advance_time`
   export NEXT_DAY_GREG=${GREG_DATA[0]}
   export NEXT_SEC_GREG=${GREG_DATA[1]}
   export ASIM_WINDOW=3
   export ASIM_MIN_DATE=$($BUILD_DIR/da_advance_time.exe $DATE -$ASIM_WINDOW 2>/dev/null)
   export ASIM_MIN_YYYY=$(echo $ASIM_MIN_DATE | cut -c1-4)
   export ASIM_MIN_YY=$(echo $ASIM_MIN_DATE | cut -c3-4)
   export ASIM_MIN_MM=$(echo $ASIM_MIN_DATE | cut -c5-6)
   export ASIM_MIN_DD=$(echo $ASIM_MIN_DATE | cut -c7-8)
   export ASIM_MIN_HH=$(echo $ASIM_MIN_DATE | cut -c9-10)
   export ASIM_MAX_DATE=$($BUILD_DIR/da_advance_time.exe $DATE +$ASIM_WINDOW 2>/dev/null)
   export ASIM_MAX_YYYY=$(echo $ASIM_MAX_DATE | cut -c1-4)
   export ASIM_MAX_YY=$(echo $ASIM_MAX_DATE | cut -c3-4)
   export ASIM_MAX_MM=$(echo $ASIM_MAX_DATE | cut -c5-6)
   export ASIM_MAX_DD=$(echo $ASIM_MAX_DATE | cut -c7-8)
   export ASIM_MAX_HH=$(echo $ASIM_MAX_DATE | cut -c9-10)
   set -A temp `echo $ASIM_MIN_DATE 0 -g | ${WRFCHEM_DART_WORK_DIR}/advance_time`
   export ASIM_MIN_DAY_GREG=${temp[0]}
   export ASIM_MIN_SEC_GREG=${temp[1]}
   set -A temp `echo $ASIM_MAX_DATE 0 -g | ${WRFCHEM_DART_WORK_DIR}/advance_time` 
   export ASIM_MAX_DAY_GREG=${temp[0]}
   export ASIM_MAX_SEC_GREG=${temp[1]}
#
#
# ASSIMILATION WINDOW PARAMETERS
   export ASIM_DATE_MIN=$(${BUILD_DIR}/da_advance_time.exe ${DATE} -${ASIM_WINDOW} 2>/dev/null)
   export ASIM_DATE_MAX=$(${BUILD_DIR}/da_advance_time.exe ${DATE} +${ASIM_WINDOW} 2>/dev/null)
   export ASIM_MN_YYYY=$(echo $ASIM_DATE_MIN | cut -c1-4)
   export ASIM_MN_MM=$(echo $ASIM_DATE_MIN | cut -c5-6)
   export ASIM_MN_DD=$(echo $ASIM_DATE_MIN | cut -c7-8)
   export ASIM_MN_HH=$(echo $ASIM_DATE_MIN | cut -c9-10)
#
   export ASIM_MX_YYYY=$(echo $ASIM_DATE_MAX | cut -c1-4)
   export ASIM_MX_MM=$(echo $ASIM_DATE_MAX | cut -c5-6)
   export ASIM_MX_DD=$(echo $ASIM_DATE_MAX | cut -c7-8)
   export ASIM_MX_HH=$(echo $ASIM_DATE_MAX | cut -c9-10)
#
# WRFCHEM FIRE PARAMETERS:
   export FIRE_START_DATE=${YYYY}-${MM}-${DD}
   export E_DATE=$(${BUILD_DIR}/da_advance_time.exe ${DATE} ${FCST_PERIOD} 2>/dev/null)
   export E_YYYY=$(echo $E_DATE | cut -c1-4)
   export E_MM=$(echo $E_DATE | cut -c5-6)
   export E_DD=$(echo $E_DATE | cut -c7-8)
   export E_HH=$(echo $E_DATE | cut -c9-10)
   export FIRE_END_DATE=${E_YYYY}-${E_MM}-${E_DD}
