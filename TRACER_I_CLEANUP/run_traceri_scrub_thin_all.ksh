#!/bin/ksh -aux
# MEMORY USAGE
#
# INPUT CYCLES:
#   wrfchem_chem_emiss  (raw dir with no scrubbing):   6.5 G/cycle or 179 T total.
#   wrfchem_chem_icbc (raw dir with no scrubbing):     50 G/cycle or 1.4 P total.
#
# OUTPUT CYCLES:
#   ONE CYCLE (NO SCRUBBING):                                                            4.2 T
#   ONE CYCLE (WITH SCRUBBING; WITH/WITH OUT POST-PROCESSING DIRS):                      3.3 T
#   ONE CYCLE (WITH SCRUBBING; WITH OUT POST-PROCESSING DIRS; KEEP 0-hr and 3-hr data):  2.0 T
#   INITIAL CYCLE TIME/DATE DIR (SCRUBBED; KEEP 1-hr IC/BC/FCs):                         284 G
#   ASSIMILATION CYCLES TIME/DATE DIR (SCRUBBED; KEEP 1-hr IC/BC/FCs):                   354 G
#   INITIAL CYCLE TIME/DATE DIR (SCRUBBED; KEEP 0-hr and 3-hr IC/BC/FCs):                136 G
#   ASSIMILATION CYCLES TIME/DATE DIR (SCRUBBED; KEEP 3-hr IC/BC/FCs):                   212 G
#   8 cycles/day x 30 day/mon x 6 mon/yr x 19 yr = 27360 cycles
#   27360 cycles x 2 T/cycle = 54720 T or 55 P total.
#
#   dart_filter (one cycle after scrubbing; no variable thinning):                       4.6 G
#   wrfchem_cycle cr (one cycle after scrubbing; no variable thinning):                  236 G
#   du -sh ${TARGET_DIR}
#
   export DATE_YYYY_STR=2021
   export DATE_YYYY_END=2021
   export MMDDHH_STR=040200
   export MMDDHH_END=040203
#
   export RUN_SCRUB_INPUT_DIRS=false
   export RUN_COMP_WRFINP_BDY=true
   export RUN_SCRUB_FILTER=true
   export RUN_SCRUB_UPDATE_BC=true
   export RUN_SCRUB_WRFCHEM=true
   export RUN_THIN_WRFOUT=true
   export RUN_THIN_WRFCHEMI=true
   export RUN_THIN_WRFFIRECHEMI=true
#
   export ACCOUNT=s2933
   export GENERAL_JOB_CLASS=normal
   export GENERAL_TIME_LIMIT=00:10:00
   export GENERAL_NODES=1
   export GENERAL_TASKS=1
   export GENERAL_MODEL=mil_ait
#   export GENERAL_MODEL=rom_ait
#
   export JOB_LIST=""   
   export DATE_YYYY_INC=1
   export DATE_DIR_INC=3
   export NUM_MEMBERS=30
   export DATE_YYYY=${DATE_YYYY_STR}
   export MMDDHH=${MMDDHH_STR}
   export OUTPUT_DIR=/nobackupp28/amizzi/OUTPUT_DATA
   export EXP_DIR_PRE=${OUTPUT_DIR}/OUTPUT_
   export EXP_DIR_SUF=_NOAA_EMISADJ_30MEMS
#
   export WRFDA_VER=WRFDAv4.3.2_dmpar
   export BUILD_DIR=/nobackupp28/amizzi/TRUNK/${WRFDA_VER}/var/build
   export JOB_CONTROL_SCRIPTS_DIR=/nobackupp28/amizzi/TRUNK/DART_development/models/wrf_chem/job_control_scripts
   export CODE_PATH=/nobackupp28/amizzi/TRUNK/DART_development/TRACER_I_CLEANUP
   export WORK_DIR=/nobackupp28/amizzi/OUTPUT_DATA/THINNING_DIR
   if [[ ! -d ${WORK_DIR} ]]; then
      mkdir -p ${WORK_DIR}
   fi
   cd ${WORK_DIR}
#
############################################################################
#
# SCRUB INPUT AND OUTPUT DIRECTORIES
#
############################################################################
#
   if [[ RUN_SCRUB_INPUT_DIRS = "true" ]]; then
      source ${CODE_PATH}/apm_scrub_INPUT_YYYY.ksh
      cd ${WORK_DIR} 
   fi
#
   if [[ ${RUN_SCRUB_FILTER} = "true" || ${RUN_SCRUB_UPDATE_BC} = "true" || \
   ${RUN_SCRUB_WRFCHEM} = "true" ]]; then
      source ${CODE_PATH}/apm_scrub_OUTPUT_YYYY.ksh
      cd ${WORK_DIR} 
   fi
#
# Build WRFOUT thinning executable
   if [[ ${RUN_THIN_WRFOUT} = "true" ]]; then
      export CODE_FILE_WRFOUT=traceri_wrfout_thinning
      rm -rf ${WORK_DIR}/${CODE_FILE_WRFOUT}.*
      cp ${CODE_PATH}/${CODE_FILE_WRFOUT}.f90 ${WORK_DIR}/.
      export LIBS='-L${NETCDF}/lib -lnetcdff -lnetcdf'
      export INCS='-I${NETCDF}/include'
      ifort ${CODE_FILE_WRFOUT}.f90 -o ${CODE_FILE_WRFOUT}.exe ${LIBS} ${INCS}
      if [[ ! -e ${CODE_FILE_WRFOUT}.exe ]]; then
         echo "APM: ${CODE_FILE_WRFOUT} compile error "
         exit
      fi
   fi
#
# Build WRFCHEMI thinning executable
   if [[ ${RUN_THIN_WRFCHEMI} = "true" ]]; then
      export CODE_FILE_WRFCHEMI=traceri_wrfchemi_thinning
      rm -rf ${WORK_DIR}/${CODE_FILE_WRFCHEMI}.*
      cp ${CODE_PATH}/${CODE_FILE_WRFCHEMI}.f90 ${WORK_DIR}/.
      export LIBS='-L${NETCDF}/lib -lnetcdff -lnetcdf'
      export INCS='-I${NETCDF}/include'
      ifort ${CODE_FILE_WRFCHEMI}.f90 -o ${CODE_FILE_WRFCHEMI}.exe ${LIBS} ${INCS}
      if [[ ! -e ${CODE_FILE_WRFCHEMI}.exe ]]; then
         echo "APM: ${CODE_FILE_WRFCHEMI} compile error "
         exit
      fi
   fi
#
# Build WRFFIRECHEMI thinning executable
   if [[ ${RUN_THIN_WRFFIRECHEMI} = "true" ]]; then
      export CODE_FILE_WRFFIRECHEMI=traceri_wrffirechemi_thinning
      rm -rf ${WORK_DIR}/${CODE_FILE_WRFFIRECHEMI}.*
      cp ${CODE_PATH}/${CODE_FILE_WRFFIRECHEMI}.f90 ${WORK_DIR}/.
      export LIBS='-L${NETCDF}/lib -lnetcdff -lnetcdf'
      export INCS='-I${NETCDF}/include'
      ifort ${CODE_FILE_WRFFIRECHEMI}.f90 -o ${CODE_FILE_WRFFIRECHEMI}.exe ${LIBS} ${INCS}
      if [[ ! -e ${CODE_FILE_WRFFIRECHEMI}.exe ]]; then
         echo "APM: ${CODE_FILE_WRFFIRECHEMI} compile error "
         exit
      fi
   fi
#
# Loop through the years
   export DATE_YYYY=${DATE_YYYY_STR}
   while [[ ${DATE_YYYY} -le ${DATE_YYYY_END} ]]; do
      export INITIAL_DATE=${DATE_YYYY}040200
      export TARGET_DIR=${EXP_DIR_PRE}${DATE_YYYY}${EXP_DIR_SUF}
      export DATE_DIR_STR=${DATE_YYYY}${MMDDHH_STR}
      export DATE_DIR_END=${DATE_YYYY}${MMDDHH_END}
      export DATE_DIR=${DATE_DIR_STR}
#
############################################################################
#
# COMPRESS WRFINPUT_D01 and WRFBDY_D01
#
############################################################################
#
      if [[ ${RUN_COMP_WRFINP_BDY} = "true" ]]; then
         let JNUM=0   
         while [[ ${DATE_DIR} -le ${DATE_DIR_END} ]]; do
            if [[ ${DATE_DIR} -eq ${INITIAL_DATE} ]]; then 
               export TARGET_PATH=${TARGET_DIR}/${DATE_DIR}/wrfchem_initial
	    else
               export TARGET_PATH=${TARGET_DIR}/${DATE_DIR}/wrfchem_cycle_cr 
	    fi
            let MEM=1
            while [[ ${MEM} -le ${NUM_MEMBERS} ]]; do
               export CMEM=e${MEM}
               if [[ ${MEM} -lt 100 ]]; then export CMEM=e0${MEM}; fi
               if [[ ${MEM} -lt 10 ]]; then export CMEM=e00${MEM}; fi
               export FC_RUN_DIR=run_${CMEM}
               if [[ -e ${TARGET_PATH}/${FC_RUN_DIR}/wrfinput_d01 || -e ${TARGET_PATH}/${FC_RUN_DIR}/wrfbdy_d01 ]]; then
		  let JNUM=${JNUM}+1
		  JOB_LIST="${JOB_LIST} JN_${JNUM}"
                  mkdir -p ${WORK_DIR}/JN_${JNUM}
                  cd ${WORK_DIR}/JN_${JNUM}
		  if [[ -e ${TARGET_PATH}/${FC_RUN_DIR}/wrfinput_d01 ]]; then
		     ln -sf ${TARGET_PATH}/${FC_RUN_DIR}/wrfinput_d01 ./.
                  fi
		  if [[ -e ${TARGET_PATH}/${FC_RUN_DIR}/wrfbdy_d01 ]]; then
		     ln -sf ${TARGET_PATH}/${FC_RUN_DIR}/wrfbdy_d01 ./.
                  fi
#
# Setup jobs script		  
                  rm -rf job1.ksh
                  cat << EOF > job1.ksh
#!/bin/ksh -aeux
   if [[ -e ${TARGET_PATH}/${FC_RUN_DIR}/wrfinput_d01 ]]; then 
      nccopy -d 9 wrfinput_d01 wrfinput_comp_d01
      if [[ -e wrfinput_comp_d01 ]]; then
         mv wrfinput_comp_d01 ${TARGET_PATH}/${FC_RUN_DIR}/.
         rm -rf ${TARGET_PATH}/${FC_RUN_DIR}/wrfinput_d01
         rm -rf wrfinput_d01
      else
         echo "APM: Error compressing wrfinput"
         exit
      fi
   fi
   if [[ -e ${TARGET_PATH}/${FC_RUN_DIR}/wrfbdy_d01 ]]; then 
      nccopy -d 9 wrfbdy_d01 wrfbdy_comp_d01
      if [[ -e wrfbdy_comp_d01 ]]; then
         mv wrfbdy_comp_d01 ${TARGET_PATH}/${FC_RUN_DIR}/.
         rm -rf ${TARGET_PATH}/${FC_RUN_DIR}/wrfbdy_d01
         rm -rf wrfbdy_d01
      else
         echo "APM: Error compressing wrfbdy"
         exit
      fi
   fi
   cd  ${WORK_DIR}
EOF
                  chmod +x job1.ksh
               fi  
               let MEM=${MEM}+1
            done
            export DATE_DIR=$(${BUILD_DIR}/da_advance_time.exe ${DATE_DIR} ${DATE_DIR_INC} 2>/dev/null)
         done
#
# Submit GNU Parallel jobs
         typeset -i NCORES
         let NCORES=${JNUM}/128
         let NTASKS=${NCORES}*128
         if [[ ${NTASKS} -ne ${JNUM} ]]; then
            let NCORES=${NCORES}+1
         fi 
         TRANDOM=$$
         export JOBRND=${TRANDOM}_gnup
         export EXE_LINE="parallel -j ${JNUM} 'cd ${WORK_DIR}/{1}; ./job1.ksh >& index.job1'"
         ${JOB_CONTROL_SCRIPTS_DIR}/job_script_nasa_GNU_PARALLEL.ksh ${JOBRND} ${GENERAL_JOB_CLASS} ${GENERAL_TIME_LIMIT} ${NCORES} ${JNUM} "${EXE_LINE}" PARALLEL ${ACCOUNT} ${GENERAL_MODEL}
         qsub -Wblock=true job.bsh > index_comp_wrfinp_bdy 2>&1
      fi
      rm -rf ${WORK_DIR}/JN*
      export DATE_DIR=${DATE_DIR_STR}
      while [[ ${DATE_DIR} -le ${DATE_DIR_END} ]]; do
         rm -rf ${TARGET_DIR}/${DATE_DIR}/wrfchem_initial/run_e*/*_bdythin.o*
         rm -rf ${TARGET_DIR}/${DATE_DIR}/wrfchem_cycle_cr/run_e*/*_bdythin.o*
         rm -rf ${TARGET_DIR}/${DATE_DIR}/wrfchem_initial/run_e*/*_inpthin.o*
         rm -rf ${TARGET_DIR}/${DATE_DIR}/wrfchem_cycle_cr/run_e*/*_inpthin.o*
         export DATE_DIR=$(${BUILD_DIR}/da_advance_time.exe ${DATE_DIR} ${DATE_DIR_INC} 2>/dev/null)
      done
#
############################################################################
#
# THIN and COMPRESS WRFOUT_D01, WRFCHEMI_D01, and WRFFIRECHEMI_D01
#
############################################################################
#
      let JNUM=0
      export DATE_DIR=${DATE_DIR_STR}
      while [[ ${DATE_DIR} -le ${DATE_DIR_END} ]]; do
         if [[ ${DATE_DIR} -eq ${INITIAL_DATE} ]]; then 
            export TARGET_PATH=${TARGET_DIR}/${DATE_DIR}/wrfchem_initial
	 else
            export TARGET_PATH=${TARGET_DIR}/${DATE_DIR}/wrfchem_cycle_cr 
	 fi
         let MEM=1
         while [[ ${MEM} -le ${NUM_MEMBERS} ]]; do
            export CMEM=e${MEM}
            if [[ ${MEM} -lt 100 ]]; then export CMEM=e0${MEM}; fi
            if [[ ${MEM} -lt 10 ]]; then export CMEM=e00${MEM}; fi
            export FC_RUN_DIR=run_${CMEM}
            export FC_DATE=${DATE_DIR}
            export FC_DATE_END=$(${BUILD_DIR}/da_advance_time.exe ${DATE_DIR} ${DATE_DIR_INC} 2>/dev/null)
            while [[ ${FC_DATE} -le ${FC_DATE_END} ]]; do
               export FC_YYYY=$(echo $FC_DATE | cut -c1-4)
               export FC_MM=$(echo $FC_DATE | cut -c5-6)
               export FC_DD=$(echo $FC_DATE | cut -c7-8)
               export FC_HH=$(echo $FC_DATE | cut -c9-10)
               export FC_FILE_DATE=d01_${FC_YYYY}-${FC_MM}-${FC_DD}_${FC_HH}:00:00
               if [[ (-e ${TARGET_PATH}/${FC_RUN_DIR}/wrfout_${FC_FILE_DATE} && ${RUN_THIN_WRFOUT} = "true") ||  (-e ${TARGET_PATH}/${FC_RUN_DIR}/wrfchemi_${FC_FILE_DATE} && ${RUN_THIN_WRFCHEMI} = "true") || (-e ${TARGET_PATH}/${FC_RUN_DIR}/wrffirechemi_${FC_FILE_DATE} && ${RUN_THIN_WRFFIREOUT} = "true") ]]; then
		  let JNUM=${JNUM}+1
		  JOB_LIST="${JOB_LIST} JN_${JNUM}"
                  mkdir -p ${WORK_DIR}/JN_${JNUM}
                  cd ${WORK_DIR}/JN_${JNUM}
		  if [[ ${RUN_THIN_WRFOUT} = "true" ]]; then
                     cp ${WORK_DIR}/${CODE_FILE_WRFOUT}.exe ./.
		     ln -sf ${TARGET_PATH}/${FC_RUN_DIR}/wrfout_${FC_FILE_DATE} ./.
                     rm -rf wrfout_thinning_nml.nl
                     cat << EOF > wrfout_thinning_nml.nl
&wrfout_thinning_nml
path_input      = "${WORK_DIR}/JN_${JNUM}",
path_output     = "${WORK_DIR}/JN_${JNUM}",
file_input      = "wrfout_${FC_FILE_DATE}",
file_output     = "wrfout_thin_${FC_FILE_DATE}"
/
EOF
                  fi
		  if [[ ${RUN_THIN_WRFCHEMI} = "true" ]]; then
                     cp ${WORK_DIR}/${CODE_FILE_WRFCHEMI}.exe ./.
		     ln -sf ${TARGET_PATH}/${FC_RUN_DIR}/wrfchemi_${FC_FILE_DATE} ./.
                     rm -rf wrfchemi_thinning_nml.nl	       
                     cat << EOF > wrfchemi_thinning_nml.nl
&wrfchemi_thinning_nml
path_input      = "${WORK_DIR}/JN_${JNUM}",
path_output     = "${WORK_DIR}/JN_${JNUM}",
file_input      = "wrfchemi_${FC_FILE_DATE}",
file_output     = "wrfchemi_thin_${FC_FILE_DATE}"
/
EOF
                  fi
		  if [[ ${RUN_THIN_WRFFIRECHEMI} = "true" ]]; then
                     cp ${WORK_DIR}/${CODE_FILE_WRFFIRECHEMI}.exe ./.
		     ln -sf ${TARGET_PATH}/${FC_RUN_DIR}/wrffirechemi_${FC_FILE_DATE} ./.
                     rm -rf wrffirechemi_thinning_nml.nl
                     cat << EOF > wrffirechemi_thinning_nml.nl
&wrffirechemi_thinning_nml
path_input      = "${WORK_DIR}/JN_${JNUM}",
path_output     = "${WORK_DIR}/JN_${JNUM}",
file_input      = "wrffirechemi_${FC_FILE_DATE}",
file_output     = "wrffirechemi_thin_${FC_FILE_DATE}"
/
EOF
                  fi
#
# Setup jobs script		  
                  rm -rf job2.ksh
                  cat << EOF > job2.ksh
#!/bin/ksh -aeux
   if [[ ${RUN_THIN_WRFOUT} = "true" ]]; then 
      ./${CODE_FILE_WRFOUT}.exe
      nccopy -d 9 wrfout_thin_${FC_FILE_DATE} wrfout_thin_comp_${FC_FILE_DATE}
      if [[ -e wrfout_thin_comp_${FC_FILE_DATE} ]]; then
         mv wrfout_thin_comp_${FC_FILE_DATE} ${TARGET_PATH}/${FC_RUN_DIR}/.
         rm -rf ${TARGET_PATH}/${FC_RUN_DIR}/wrfout_${FC_FILE_DATE}
         rm -rf wrfout_${FC_FILE_DATE}
      else
         echo "APM: Error compressing wrfout"
         exit
      fi
   fi
   if [[ ${RUN_THIN_WRFCHEMI} = "true" ]]; then 
      ./${CODE_FILE_WRFCHEMI}.exe
      nccopy -d 9 wrfchemi_thin_${FC_FILE_DATE} wrfchemi_thin_comp_${FC_FILE_DATE}
      if [[ -e wrfchemi_thin_comp_${FC_FILE_DATE} ]]; then
         mv wrfchemi_thin_comp_${FC_FILE_DATE} ${TARGET_PATH}/${FC_RUN_DIR}/.
         rm -rf ${TARGET_PATH}/${FC_RUN_DIR}/wrfchemi_${FC_FILE_DATE}
         rm -rf wrfchemi_${FC_FILE_DATE}
      else
         echo "APM: Error compressing wrfchemi"
         exit
      fi
   fi
   if [[ ${RUN_THIN_WRFFIRECHEMI} = "true" ]]; then 
      ./${CODE_FILE_WRFFIRECHEMI}.exe
      nccopy -d 9 wrffirechemi_thin_${FC_FILE_DATE} wrffirechemi_thin_comp_${FC_FILE_DATE}
      if [[ -e wrffirechemi_thin_comp_${FC_FILE_DATE} ]]; then
         mv wrffirechemi_thin_comp_${FC_FILE_DATE} ${TARGET_PATH}/${FC_RUN_DIR}/.
         rm -rf ${TARGET_PATH}/${FC_RUN_DIR}/wrffirechemi_${FC_FILE_DATE}
         rm -rf wrffirechemi_${FC_FILE_DATE}
      else
         echo "APM: Error compressing wrffirechemi"
         exit
      fi
   fi
   cd  ${WORK_DIR}
EOF
                  chmod +x job2.ksh
#
# test
#                  TRANDOM=$$
#                  export JOBRND=${TRANDOM}_outthin
#	          ${JOB_CONTROL_SCRIPTS_DIR}/job_script_nasa_model.ksh ${JOBRND} ${GENERAL_JOB_CLASS} ${GENERAL_TIME_LIMIT} ${GENERAL_NODES} ${GENERAL_TASKS} jobb.ksh SERIAL ${ACCOUNT} ${GENERAL_MODEL}
#                  qsub job.ksh > index_thin_wrfout 2>&1
               fi
               export FC_DATE=$(${BUILD_DIR}/da_advance_time.exe ${FC_DATE} ${DATE_DIR_INC} 2>/dev/null)
            done
            let MEM=${MEM}+1
         done
         export DATE_DIR=$(${BUILD_DIR}/da_advance_time.exe ${DATE_DIR} ${DATE_DIR_INC} 2>/dev/null)
      done
#
# Submit GNU Parallel jobs
      typeset -i NCORES
      let NCORES=${JNUM}/128
      let NTASKS=${NCORES}*128
      if [[ ${NTASKS} -ne ${JNUM} ]]; then
         let NCORES=${NCORES}+1
      fi 
      TRANDOM=$$
      export JOBRND=${TRANDOM}_gnup
      export EXE_LINE="parallel -j ${JNUM} 'cd ${WORK_DIR}/{1}; ./job2.ksh >& index.job2'"
      ${JOB_CONTROL_SCRIPTS_DIR}/job_script_nasa_GNU_PARALLEL.ksh ${JOBRND} ${GENERAL_JOB_CLASS} ${GENERAL_TIME_LIMIT} ${NCORES} ${JNUM} "${EXE_LINE}" PARALLEL ${ACCOUNT} ${GENERAL_MODEL}
      qsub -Wblock=true job.bsh > index_thin_comp_wrfout_etc 2>&1
      rm -rf ${WORK_DIR}/JN*
      let DATE_YYYY=${DATE_YYYY}+${DATE_YYYY_INC}
   done
