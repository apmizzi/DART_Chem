#!/bin/ksh -aeux 
#
# TIME SETTING
   export START_DATE=2018070100
   export END_DATE=2018070100
#
# VERSION NAMES
  export CMAQ_VER=CMAQ_REPO
  export DART_VER=DART_development
  export WRFDA_VER=WRFDAv4.3.2_dmpar
#
# INDEPENDENT DIRECTORIES
   export WORK_DIR=/nobackupp11/amizzi
   export TRUNK_DIR=${WORK_DIR}/TRUNK
   export RS_SCRIPTS_DIR=${REAL_TIME_DIR}/FINAL_TEST_SCRIPTS/RS_Scripts
   export INPUT_DATA_DIR=/nobackupp11/amizzi/INPUT_DATA
   export SCRATCH_DIR=${WORK_DIR}/OUTPUT_DATA
   export EXPERIMENT_DIR=${SCRATCH_DIR}
   export EXPERIMENT_DATA_DIR=${INPUT_DATA_DIR}/CMAQ_DATA
   export RUN_DIR=${EXPERIMENT_DIR}/CMAQ_DART_TEST
   export RUN_INPUT_DIR=${EXPERIMENT_DIR}/INPUT_DATA_CMAQ
   export EXPERIMENT_INPUT_OBS=CMAQ
   export NL_CORRECTION_FILENAME='Historical_Bias_Corrections'      
   export WRFCHEM_TEMPLATE_FILE=cmaqout_20180100.nc
   export NUM_MEMBERS=10
   export CYCLE_PERIOD=6
#
# DEPENDENT DIRECTORIES
   export DART_DIR=${TRUNK_DIR}/${DART_VER}
   export MODEL_DIR=${DART_DIR}/models/wrf_cmaq
   export MODEL_WORK_DIR=${MODEL_DIR}/work
   export WRFDA_DIR=${TRUNK_DIR}/${WRFDA_VER}
   export BUILD_DIR=${WRFDA_DIR}/var/da
   export BACKGND_FCST_DIR=${EXPERIMENT_DATA_DIR}
#
# BEGIN CYCLING
  export L_DATE=${START_DATE} 
  while [[ ${L_DATE} -le ${END_DATE} ]]; do
     export DART_FILTER_DIR=${RUN_DIR}/${L_DATE}/dart_filter
     mkdir -p ${DART_FILTER_DIR}
     cd ${DART_FILTER_DIR}
     export YYYY=$(echo $L_DATE | cut -c1-4)
     export YY=$(echo $L_DATE | cut -c3-4)
     export MM=$(echo $L_DATE | cut -c5-6)
     export DD=$(echo $L_DATE | cut -c7-8)
     export HH=$(echo $L_DATE | cut -c9-10)
     export FILE_DATE=${YYYY}-${MM}-${DD}_${HH}:00:00
     export PAST_DATE=$(${BUILD_DIR}/da_advance_time.exe ${DATE} -${CYCLE_PERIOD} 2>/dev/null)  
     export PAST_YYYY=$(echo $PAST_DATE | cut -c1-4)
     export PAST_YY=$(echo $PAST_DATE | cut -c3-4)
     export PAST_MM=$(echo $PAST_DATE | cut -c5-6)
     export PAST_DD=$(echo $PAST_DATE | cut -c7-8)
     export PAST_HH=$(echo $PAST_DATE | cut -c9-10)
#
# DART TIME SETTING (NO LEADING ZEROS)
     export DT_YYYY=${YYYY}
     export DT_YY=$(echo $L_DATE | cut -c3-4)
     export DT_MM=${MM} 
     export DT_DD=${DD} 
     export DT_HH=${HH} 
     (( DT_MM = ${DT_MM} + 0 ))
     (( DT_DD = ${DT_DD} + 0 ))
     (( DT_HH = ${DT_HH} + 0 ))
#
# COPY DART FILES   
     cp ${MODEL_WORK_DIR}/filter      ./.
     cp ${MODEL_WORK_DIR}/advance_time ./.
     cp ${DART_DIR}/model_mod.nml ./.
     cp ${DART_DIR}/assimilation_code/programs/gen_sampling_err_table/work/sampling_error_correction_table.nc ./.
#
# COPY TEMPLATE FILE
     cp ${MODEL_DIR}/model_mod.nml ./.
#
# COPY OBSERVATIONS
     if [[ ${EXPERIMENT_DATA_DIR}/OBS_DIR/obs_seq_comb_filtered_${START_DATE}.out ]]; then      
        cp ${EXPERIMENT_DATA_DIR}/OBS_DIR/obs_seq_comb_filtered_${START_DATE}.out obs_seq.out
     else
        echo APM ERROR: NO DART OBSERVATIONS
        exit
     fi
#
# COPY OBS IMPACT TABLE
     cp ${EXPERIMENT_DATA_DIR}/control_impact_runtime.txt ./control_impact_runtime.table
#
# COPY BACKGROUND FORECAST FILES
     rm -rf input_list.txt     
     rm -rf output_list.txt     
     let MEM=1
     while [[ ${MEM} -le ${NUM_MEMBERS} ]]; do
        export CMEM=e${MEM}
        export KMEM=${MEM}
        if [[ ${MEM} -lt 1000 ]]; then export KMEM=0${MEM}; fi
        if [[ ${MEM} -lt 100 ]]; then export KMEM=00${MEM}; export CMEM=e0${MEM}; fi
        if [[ ${MEM} -lt 10 ]]; then export KMEM=000${MEM}; export CMEM=e00${MEM}; fi
        cp ${BACKGND_FCST_DIR}/cmaqout_${FILE_DATE} cmaqinput_${CMEM}
        echo cmaqinput_${CMEM} >> input_list.txt
        echo cmaqinput_${CMEM} >> output_list.txt
        let MEM=${MEM}+1
     done
#
# SET DART INFLATION NAMELIST SETTINGS (ASSUMES INITIAL CYCLE)
     export NL_INF_INITIAL_FROM_RESTART_PRIOR=.false.
     export NL_INF_SD_INITIAL_FROM_RESTART_PRIOR=.false.
     export NL_INF_INITIAL_FROM_RESTART_POST=.false.
     export NL_INF_SD_INITIAL_FROM_RESTART_POST=.false.
#
# GENERATE DART INPUT.NML
     set -A temp `echo ${ASIM_MIN_DATE} 0 -g | ${WRFCHEM_DART_WORK_DIR}/advance_time`
     (( temp[1]=${temp[1]}+1 ))
     export NL_FIRST_OBS_DAYS=${temp[0]}
     export NL_FIRST_OBS_SECONDS=${temp[1]}
     set -A temp `echo ${ASIM_MAX_DATE} 0 -g | ${WRFCHEM_DART_WORK_DIR}/advance_time`
     export NL_LAST_OBS_DAYS=${temp[0]}
     export NL_LAST_OBS_SECONDS=${temp[1]}
     export NL_NUM_INPUT_FILES=1
     export NL_FILENAME_SEQ="'obs_seq.out'"
     export NL_FILENAME_OUT="'obs_seq.processed'"
#     rm -rf input.nml
#     ${NAMELIST_SCRIPTS_DIR}/DART/dart_create_input.nml.ksh
#
     rm -rf filter_apm.nml
     cat << EOF > filter_apm.nml
&filter_apm_nml
special_outlier_threshold=${NL_SPECIAL_OUTLIER_THRESHOLD}
/
EOF
#
# RUN DART_FILTER
     RANDOM=$$
     export JOBRND=${RANDOM}_filter
     ${JOB_CONTROL_SCRIPTS_DIR}/job_script_nasa_has.ksh ${JOBRND} ${FILTER_JOB_CLASS} ${FILTER_TIME_LIMIT} ${FILTER_NODES} ${FILTER_TASKS} filter PARALLEL ${ACCOUNT}
     qsub -Wblock=true job.ksh
#
     
     export L_DATE=$(${BUILD_DIR}/da_advance_time.exe ${L_DATE} 24 2>/dev/null)  
  done 
