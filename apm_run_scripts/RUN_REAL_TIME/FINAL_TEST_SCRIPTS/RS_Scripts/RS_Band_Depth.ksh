#!/bin/ksh -aux
#
      cd ${RUN_DIR}/${DATE}/band_depth
#
# set the forecast directory
      export BAND_ISO_VAL_CO=.09
      if [[ ${DATE} -eq ${INITIAL_DATE} ]]; then
         export OUTPUT_DIR=${WRFCHEM_INITIAL_DIR}
      else
         export OUTPUT_DIR=${WRFCHEM_CYCLE_CR_DIR}
      fi
      cp ${WRFCHEM_DART_WORK_DIR}/advance_time ./.
      export END_CYCLE_DATE=$($BUILD_DIR/da_advance_time.exe ${START_DATE} ${CYCLE_PERIOD} 2>/dev/null)
      export B_YYYY=$(echo $END_CYCLE_DATE | cut -c1-4)
      export B_MM=$(echo $END_CYCLE_DATE | cut -c5-6) 
      export B_DD=$(echo $END_CYCLE_DATE | cut -c7-8)
      export B_HH=$(echo $END_CYCLE_DATE | cut -c9-10)
      export B_FILE_DATE=${B_YYYY}-${B_MM}-${B_DD}_${B_HH}:00:00
#
# link in forecasts for deepest member determination
      let MEM=1
      while [[ ${MEM} -le ${NUM_MEMBERS} ]]; do
         export CMEM=e${MEM}
         export KMEM=${MEM}
         if [[ ${MEM} -lt 1000 ]]; then export KMEM=0${MEM}; fi
         if [[ ${MEM} -lt 100 ]]; then export KMEM=00${MEM}; export CMEM=e0${MEM}; fi
         if [[ ${MEM} -lt 10 ]]; then export KMEM=000${MEM}; export CMEM=e00${MEM}; fi
         rm -rf wrfout_d${CR_DOMAIN}.${CMEM}
         ln -sf ${OUTPUT_DIR}/run_${CMEM}/wrfout_d${CR_DOMAIN}_${B_FILE_DATE} wrfout_d${CR_DOMAIN}.${CMEM}
         let MEM=${MEM}+1
      done
#
# copy band depth code
      cp ${RUN_BAND_DEPTH_DIR}/ComputeBandDepth.m ./.
      rm -rf job.ksh
      rm -rf mat_*.err
      rm -rf mat_*.out
      touch job.ksh
#
      RANDOM=$$
      export JOBRND=${RANDOM}_deepmem
      cat << EOFF > job.ksh
#!/bin/ksh -aeux
#PBS -N ${JOBRND}
#PBS -l walltime=${GENERAL_TIME_LIMIT}
#PBS -q ${GENERAL_JOB_CLASS}
#PBS -j oe
#PBS -l select=${GENERAL_NODES}:ncpus=1:model=ivy
#
matlab -nosplash -nodesktop -r 'ComputeBandDepth(.09)'
export RC=\$?     
if [[ -f SUCCESS ]]; then rm -rf SUCCESS; fi     
if [[ -f FAILED ]]; then rm -rf FAILED; fi          
if [[ \$RC = 0 ]]; then
   touch SUCCESS
else
   touch FAILED 
   exit
fi
EOFF
      qsub -Wblock=true job.ksh 
#
# run band depth script
      source shell_file.ksh
      export CMEM=e${DEEP_MEMBER}
      if [[ ${DEEP_MEMBER} -lt 100 ]]; then export CMEM=e0${DEEP_MEMBER}; fi
      if [[ ${DEEP_MEMBER} -lt 10 ]]; then export CMEM=e00${DEEP_MEMBER}; fi
      export CLOSE_MEM_ID=${CMEM}
