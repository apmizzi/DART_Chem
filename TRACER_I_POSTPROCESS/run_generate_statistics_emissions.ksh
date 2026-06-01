#!/bin/ksh -aeux
#
   export YYYY_STR=2005
   export YYYY_END=2025
   export MMDDHH_STR=040200
   export MMDDHH_END=040300
#
   export DATA_PATH=/nobackupp28/amizzi/OUTPUT_DATA
   export CODE_PATH=/nobackupp28/amizzi/TRUNK/DART_development/TRACER_I_POSTPROCESS
   export RUN_PATH=/nobackupp28/amizzi/OUTPUT_DATA/TRACER_I_POSTPROCESS
   export BUILD_DIR=/nobackupp28/amizzi/TRUNK/WRFDAv4.3.2_dmpar/var/da
   export EXP_DIR_PRE=OUTPUT_
   export EXP_DIR_POST=_NOAA_EMISADJ_30MEMS
#
# Compile post-processing code
   export FILE=generate_statistics_emissions
   cd ${RUN_PATH}
   rm -rf ${FILE}.f90 ${FILE}.exe
   cp ${CODE_PATH}/${FILE}.f90 ./.
#
   export LIBS='-L${NETCDF}/lib -lnetcdff -lnetcdf'
   export INCS='-I${NETCDF}/include'
   ifort ${FILE}.f90 -o ${FILE}.exe ${LIBS} ${INCS}
   if [[ ! -e ${FILE}.exe ]]; then
      echo "APM: ${FILE} compile error "
      exit
   fi
#  
   export INC=3
   let L_YYYY=${YYYY_STR}
   while [[ ${L_YYYY} -le ${YYYY_END} ]]; do
      export DATE_INITIAL=${L_YYYY}040200
      export DATE_STR=${L_YYYY}${MMDDHH_STR}
      export DATE_END=${L_YYYY}${MMDDHH_END}
      let L_DATE=${DATE_STR}
      while [[ ${L_DATE} -le ${DATE_END} ]]; do
         export YYYY=`echo ${L_DATE} |cut -c1-4`
         export MM=`echo ${L_DATE} | cut -c5-6`
         export DD=`echo ${L_DATE} | cut -c7-8`
         export HH=`echo ${L_DATE} | cut -c9-10`
         export MN=00
         export SS=00
#
         if [[ ${L_DATE} -eq ${DATE_INITIAL} ]]; then
            export DATA_DIR=${DATA_PATH}/${EXP_DIR_PRE}${YYYY}${EXP_DIR_POST}/${L_DATE}/wrfchem_initial
         else
	    export DATA_DIR=${DATA_PATH}/${EXP_DIR_PRE}${YYYY}${EXP_DIR_POST}/${L_DATE}/wrfchem_cycle_cr
         fi
#
         export STATS_DIR=${DATA_PATH}/${EXP_DIR_PRE}${YYYY}${EXP_DIR_POST}/emissions_stats/${L_DATE}
         if [[ ! -e ${STATS_DIR} ]]; then
            mkdir -p ${STATS_DIR}
         fi
         export STRAT_FILE=TRACER_I_Stratifications_Data
         ln -sf ${DATA_PATH}/${STRAT_FILE} ${RUN_PATH}/.
#
         export F_DATE=${L_DATE}
         export F_DATE_END=$(${BUILD_DIR}/da_advance_time.exe ${L_DATE} ${INC} -f ccyymmddhh 2>/dev/null)
         while [[ ${F_DATE} -le ${F_DATE_END} ]]; do
            export F_YYYY=`echo ${F_DATE} |cut -c1-4`
            export F_MM=`echo ${F_DATE} | cut -c5-6`
            export F_DD=`echo ${F_DATE} | cut -c7-8`
            export F_HH=`echo ${F_DATE} | cut -c9-10`
            export F_MN=00
            export F_SS=00
	    export F_WRFOUT_FILE=wrfout_d01_${F_YYYY}-${F_MM}-${F_DD}_${F_HH}:${F_MN}:${F_SS}
	    export F_WRFCHEMI_FILE=wrfchemi_d01_${F_YYYY}-${F_MM}-${F_DD}_${F_HH}:${F_MN}:${F_SS}
	    export F_WRFFIRE_FILE=wrffirechemi_d01_${F_YYYY}-${F_MM}-${F_DD}_${F_HH}:${F_MN}:${F_SS}
            export F_OUTPUT_FILE=emissions_stats_d01_${F_YYYY}-${F_MM}-${F_DD}_${F_HH}:${F_MN}:${F_SS}
            cat << EOF > ens_postprocess.nl
&ens_postprocess
path_input           = "${DATA_DIR}",
path_output          = "${STATS_DIR}",
wrfout_input         = "${F_WRFOUT_FILE}",
wrfchemi_input       = "${F_WRFCHEMI_FILE}",
wrffirechemi_input   = "${F_WRFFIRE_FILE}",
file_output          = "${F_OUTPUT_FILE}",
nx                   = 440,
ny                   = 284,
nz                   = 50,
nz_chemi             = 20,
nz_fire              = 1,
num_mems             = 30
date_traceri         = ${F_DATE}
/
EOF
#
            TRANDOM=$$
	    export JOBRND=${TRANDOM}_emiss
            export SINGLE_JOB_CLASS=normal
            export SINGLE_TIME_LIMIT=00:10:00
            export SINGLE_NODES=1
            export SINGLE_TASKS=1
            export SINGLE_MODEL=mil_ait
	    export ACCOUNT=s2933
	    export JOB_CONTROL_SCRIPTS_DIR=/nobackupp28/amizzi/TRUNK/DART_development/models/wrf_chem/job_control_scripts
#
#            ${JOB_CONTROL_SCRIPTS_DIR}/job_script_nasa_model.ksh ${JOBRND} ${SINGLE_JOB_CLASS} ${SINGLE_TIME_LIMIT} ${SINGLE_NODES} ${SINGLE_TASKS} ./${FILE}.exe SERIAL ${ACCOUNT} ${SINGLE_MODEL}
#            qsub -Wblock=true job.ksh
#
            ./${FILE}.exe > index_${JOBRND}
            mv index_${JOBRND} index.emiss_stats_C${L_DATE}_F${F_DATE} 2>&1
            export F_DATE=$(${BUILD_DIR}/da_advance_time.exe ${F_DATE} ${INC} -f ccyymmddhh 2>/dev/null)
         done
	 rm -rf ${RUN_PATH}/${STRAT_FILE}
         export L_DATE=$(${BUILD_DIR}/da_advance_time.exe ${L_DATE} ${INC} -f ccyymmddhh 2>/dev/null)
      done
      let L_YYYY=${L_YYYY}+1
   done
#
