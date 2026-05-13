#!/bin/ksh -aux
   export JOBID_STR=23727343
   export JOBID_END=23727369
   export JOBID=${JOBID_STR}
      while [[ ${JOBID} -le ${JOBID_END} ]]; do
         qdel ${JOBID}
         let JOBID=${JOBID}+1
      done
   echo "APM: End of job delete script "
exit
   
