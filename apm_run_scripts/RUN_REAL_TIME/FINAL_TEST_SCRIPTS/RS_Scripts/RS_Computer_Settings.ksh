#!/bin/ksh -aux
#
# COMPUTER PARAMETERS:
   export PROJ_NUMBER=P93300612
   export ACCOUNT=s2933
#
   export DEBUG_JOB_CLASS=debug
   export DEBUG_TIME_LIMIT=01:59:00
   export DEBUG_NODES=2
   export DEBUG_TASKS=16
#
   export GENERAL_JOB_CLASS=normal
   export GENERAL_TIME_LIMIT=00:20:00
   export GENERAL_NODES=1
   export GENERAL_TASKS=16
#
#   export GENERAL_JOB_CLASS=devel
#   export GENERAL_TIME_LIMIT=00:20:00
#   export GENERAL_NODES=1
#   export GENERAL_TASKS=16
#   
   export WRFDA_JOB_CLASS=normal
   export WRFDA_TIME_LIMIT=00:05:00
   export WRFDA_NODES=1
   export WRFDA_TASKS=16
#
   export SINGLE_JOB_CLASS=normal
   export SINGLE_TIME_LIMIT=00:10:00
   export SINGLE_NODES=1
   export SINGLE_TASKS=1
#
   export BIO_JOB_CLASS=normal
   export BIO_TIME_LIMIT=00:20:00
   export BIO_NODES=1
   export BIO_TASKS=1
#
# Sandy Bridge
#   export FILTER_JOB_CLASS=normal
#   export FILTER_TIME_LIMIT=05:30:00
#   export FILTER_NODES=3
#   export FILTER_TASKS=16
# Haswell
   export FILTER_JOB_CLASS=normal
   export FILTER_TIME_LIMIT=06:59:00
   export FILTER_NODES=2
   export FILTER_TASKS=24
#
#   export FILTER_JOB_CLASS=devel
#   export FILTER_TIME_LIMIT=01:59:00
#   export FILTER_NODES=2
#   export FILTER_TASKS=24
#
# Sandy Bridge
#   export WRFCHEM_JOB_CLASS=devel
#   export WRFCHEM_TIME_LIMIT=00:40:00
#   export WRFCHEM_NODES=2
#   export WRFCHEM_TASKS=16
# Haswell
   export WRFCHEM_JOB_CLASS=devel
   export WRFCHEM_TIME_LIMIT=00:30:00
   export WRFCHEM_NODES=2
   export WRFCHEM_TASKS=24
# Haswell (Single submission for WRFCHEM ensemble)
   export WRFCHEM_SING_CLASS=normal
   export WRFCHEM_SING_LIMIT=06:30:00
   export WRFCHEM_SING_NODES=2
   export WRFCHEM_SING_TASKS=24
#
#   export WRFCHEM_JOB_CLASS=devel
#   export WRFCHEM_TIME_LIMIT=00:40:00
#   export WRFCHEM_NODES=1
#   export WRFCHEM_TASKS=24
#
# Sandy Bridge   
#   export PERT_JOB_CLASS=normal
#   export PERT_TIME_LIMIT=03:30:00
#   export PERT_NODES=2
#   export PERT_TASKS=16
# Haswell
   export PERT_JOB_CLASS=normal
   export PERT_TIME_LIMIT=05:59:00
   export PERT_NODES=1
   export PERT_TASKS=24
#
#   export PERT_JOB_CLASS=devel
#   export PERT_TIME_LIMIT=01:59:00
#   export PERT_NODES=2
#   export PERT_TASKS=16
