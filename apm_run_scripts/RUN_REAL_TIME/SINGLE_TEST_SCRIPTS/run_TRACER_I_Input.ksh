#!/bin/ksh -aux
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
#
##########################################################################
#
# Purpose: Create common ensemble input data (enemble icbcs, emissions,
# and observations for running WRF-Chem/DART
#
#PBS -W group_list=s2933
#PBS -N TRACER-I_Input
#PBS -l walltime=07:59:00
#PBS -q normal
#PBS -j oe
#PBS -l select=4:ncpus=16:mpiprocs=16:model=has
#PBS -l site=needed=/home1+/nobackupp11
#
   export NPROC=64
   export FINAL_ROOT_DIR=/nobackupp28/amizzi/TRUNK/DART_development/apm_run_scripts
   export FINAL_SCRIPTS_DIR=${FINAL_ROOT_DIR}/RUN_REAL_TIME/FINAL_TEST_SCRIPTS
   export FINAL_RS_DIR=${FINAL_SCRIPTS_DIR}/RS_Scripts
   export SINGLE_SCRIPTS_DIR=${FINAL_ROOT_DIR}/RUN_REAL_TIME/SINGLE_TEST_SCRIPTS
   export SINGLE_RS_DIR=${SINGLE_SCRIPTS_DIR}/RS_SINGLE
#
   export SINGLE_RUN_DIR=/nobackupp28/amizzi/OUTPUT_DATA/INPUT_DATA_TRACER_I/work
   if [[ ! -d ${SINGLE_RUN_DIR} ]]; then
      mkdir -p ${SINGLE_RUN_DIR}
      cd ${SINGLE_RUN_DIR}
   else
      cd ${SINGLE_RUN_DIR}
   fi
#
   cp ${SINGLE_RS_DIR}/run_ensemble_input_TRACER_I_SINGLE.ksh ./
   ./run_ensemble_input_TRACER_I_SINGLE.ksh
   #
   
