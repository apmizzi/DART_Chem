#!/bin/ksh -aux
#
      cd ${RUN_DIR}/${DATE}/ensemble_mean_input
#
      rm -rf wrfinput_d${CR_DOMAIN}_mean
      rm -rf wrfbdy_d${CR_DOMAIN}_mean
      rm -rf wrfinput_d${FR_DOMAIN}_mean
      let MEM=1
      while [[ ${MEM} -le ${NUM_MEMBERS} ]]; do
         export CMEM=e${MEM}
         export KMEM=${MEM}
         if [[ ${MEM} -lt 1000 ]]; then export KMEM=0${MEM}; fi
         if [[ ${MEM} -lt 100 ]]; then export KMEM=00${MEM}; export CMEM=e0${MEM}; fi
         if [[ ${MEM} -lt 10 ]]; then export KMEM=000${MEM}; export CMEM=e00${MEM}; fi
         if [[ ${DATE} -eq ${INITIAL_DATE}  ]]; then
            cp ${WRFCHEM_MET_IC_DIR}/wrfinput_d${CR_DOMAIN}_${START_FILE_DATE}.${CMEM} wrfinput_d${CR_DOMAIN}_${KMEM}
            cp ${WRFCHEM_MET_BC_DIR}/wrfbdy_d${CR_DOMAIN}_${START_FILE_DATE}.${CMEM} wrfbdy_d${CR_DOMAIN}_${KMEM}
         else
            cp ${DART_FILTER_DIR}/wrfout_d${CR_DOMAIN}_${START_FILE_DATE}_filt.${CMEM} wrfinput_d${CR_DOMAIN}_${KMEM}
            cp ${UPDATE_BC_DIR}/wrfbdy_d${CR_DOMAIN}_${START_FILE_DATE}_filt.${CMEM} wrfbdy_d${CR_DOMAIN}_${KMEM}
         fi
         let MEM=${MEM}+1
      done
      cp ${REAL_DIR}/wrfinput_d${FR_DOMAIN}_${START_FILE_DATE} wrfinput_d${FR_DOMAIN}_mean
#
# Calculate ensemble mean
      ncea -n ${NUM_MEMBERS},4,1 wrfinput_d${CR_DOMAIN}_0001 wrfinput_d${CR_DOMAIN}_mean
      ncea -n ${NUM_MEMBERS},4,1 wrfbdy_d${CR_DOMAIN}_0001 wrfbdy_d${CR_DOMAIN}_mean
#
# Calculate ensemble spread
      rm -rf wrfinput_d${CR_DOMAIN}_tmp*
      rm -rf wrfinput_d${CR_DOMAIN}_sprd 
      ncecat -n ${NUM_MEMBERS},4,1 wrfinput_d${CR_DOMAIN}_0001 wrfinput_d${CR_DOMAIN}_tmp1
      ncwa -a record wrfinput_d${CR_DOMAIN}_tmp1 wrfinput_d${CR_DOMAIN}_tmp2
      ncbo --op_typ='-' wrfinput_d${CR_DOMAIN}_tmp1 wrfinput_d${CR_DOMAIN}_tmp2 wrfinput_d${CR_DOMAIN}_tmp3
      ncra -y rmssdn wrfinput_d${CR_DOMAIN}_tmp3 wrfinput_d${CR_DOMAIN}_sprd
      rm -rf wrfinput_d${CR_DOMAIN}_tmp*
      rm -rf wrfinput_d${CR_DOMAIN}_*0*
      rm -rf wrfbdy_d${CR_DOMAIN}_*0*
