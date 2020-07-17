#!/bin/ksh -aeux
#
# DART software - Copyright UCAR. This open source software is provided
# by UCAR, "as is", without charge, subject to all terms of use at
# http://www.image.ucar.edu/DAReS/DART/DART_download

export JOBID=$1
export CLASS=$2
export TIME_LIMIT=$3
export NODES=$4
export TASKS=$5
export EXECUTE=$6
export TYPE=$7
export ACCOUNT=$8
RANDOM=$$
#
rm -rf job.ksh
touch job.ksh
#
if [[ ${TYPE} == PARALLEL ]]; then
   cat << EOF > job.ksh
#!/bin/ksh -aeux
#SBATCH --account ${ACCOUNT}
#SBATCH --job-name ${JOBID}
#SBATCH --qos ${CLASS}
#SBATCH --time ${TIME_LIMIT}
#SBATCH --output ${JOBID}.log
#SBATCH --nodes ${NODES}
#SBATCH --ntasks ${TASKS}
#SBATCH --partition shas
mpirun -np \${SLURM_NTASKS} ./${EXECUTE} > index.html 2>&1
export RC=\$?     
rm -rf SUCCESS     
rm -rf FAILED          
if [[ \$RC = 0 ]]; then
   touch SUCCESS
else
   touch FAILED 
   exit
fi
EOF
#
elif [[ ${TYPE} == SERIAL ]]; then
   cat << EOF > job.ksh
#!/bin/ksh -aeux
#SBATCH --account ${ACCOUNT}
#SBATCH --job-name ${JOBID}
#SBATCH --qos ${CLASS}
#SBATCH --time ${TIME_LIMIT}
#SBATCH --output ${JOBID}.log
#SBATCH --nodes ${NODES}
#SBATCH --ntasks ${TASKS}
#SBATCH --partition shas
./${EXECUTE} > index.html 2>&1
export RC=\$?
rm -rf SUCCESS     
rm -rf FAILED          
if [[ \$RC = 0 ]]; then
   touch SUCCESS
else
   touch FAILED 
   exit
fi
EOF
#
else
   echo 'APM: Error is job script - Not SERIAL or PARALLEL '
   exit
fi

