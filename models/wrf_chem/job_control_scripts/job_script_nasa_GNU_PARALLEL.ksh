#!/bin/ksh -aeux
#
# Copyright 2019 University Corporation for Atmospheric Research and 
# Colorado Department of Public Health and Environment.
# 
# Licensed under the Apache License, Version 2.0 (the "License"); 
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software distributed
# under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR 
# CONDITIONS OF ANY KIND, either express or implied. See the License for the 
# specific language governing permissions and limitations under the License.
# 
# Development of this code utilized the RMACC Summit supercomputer, which is 
# supported by the National Science Foundation (awards ACI-1532235 and ACI-1532236),
# the University of Colorado Boulder, and Colorado State University. The Summit 
# supercomputer is a joint effort of the University of Colorado Boulder and 
# Colorado State University.

export JOBID=$1
export CLASS=$2
export TIME_LIMIT=$3
export NODES=$4
export TASKS=$5
export EXE_LINE="$6"
export TYPE=$7
export ACCOUNT=$8
export MODEL=$9
let NPROC=${NODES}*${TASKS}
#
if [[ ${TYPE} == PARALLEL ]]; then
   rm -rf job.bsh
   touch job.bsh
   cat << EOF > job.bsh
#!/bin/bash
#PBS -W group_list=${ACCOUNT}
#PBS -N ${JOBID}
#PBS -q ${CLASS}
#PBS -l walltime=${TIME_LIMIT}
#PBS -j oe
#PBS -l select=${NODES}:ncpus=${TASKS}:mpiprocs=${TASKS}:model=${MODEL}
cd \${PBS_O_WORKDIR}
. /usr/share/Modules/init/bash
. /home1/amizzi/run_tracer_env_GARY
export MPI_DSM_DISTRIBUTE=0
${EXE_LINE} ::: ${JOB_LIST}
EOF
#
elif [[ ${TYPE} == SERIAL ]]; then
   echo "APM ERROR: GNU PARALLEL HAS NO SERIAL OPTION"
   echo "APM ERROR: ABORT JOB SCRIPT"
   exit
fi

