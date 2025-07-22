#!/bin/ksh -aux
#
# COMPUTER PARAMETERS:
   export PROJ_NUMBER=P93300612
   export ACCOUNT=s2933
#
   export DEBUG_JOB_CLASS=debug
   export DEBUG_TIME_LIMIT=01:59:00
   export DEBUG_NODES=1
   export DEBUG_TASKS=28
   export DEBUG_MODEL=bro
#
   export GENERAL_JOB_CLASS=normal
   export GENERAL_TIME_LIMIT=00:50:00
   export GENERAL_NODES=1
   export GENERAL_TASKS=1
   export GENERAL_MODEL=bro
#
   export WRFDA_JOB_CLASS=normal
   export WRFDA_TIME_LIMIT=00:05:00
   export WRFDA_NODES=1
   export WRFDA_TASKS=24
   export WRFDA_model=has
#
   export SINGLE_JOB_CLASS=normal
   export SINGLE_TIME_LIMIT=00:10:00
   export SINGLE_NODES=1
   export SINGLE_TASKS=1
   export SINGLE_MODEL=bro
#
   export BIO_JOB_CLASS=normal
   export BIO_TIME_LIMIT=00:20:00
   export BIO_NODES=1
   export BIO_TASKS=1
   export BIO_MODEL=bro
#
   export FILTER_JOB_CLASS=normal
   export FILTER_TIME_LIMIT=07:59:00
   export FILTER_NODES=6
   export FILTER_TASKS=28
   export FILTER_MODEL=bro
#
   export WRFCHEM_JOB_CLASS=normal
   export WRFCHEM_TIME_LIMIT=02:00:00
   export WRFCHEM_NODES=5
   export WRFCHEM_TASKS=28
   export WRFCHEM_MODEL=bro
#
   export WRFCHEM_SING_CLASS=normal
   export WRFCHEM_SING_LIMIT=05:00:00
   export WRFCHEM_SING_NODES=3
   export WRFCHEM_SING_TASKS=28
   export WRFCHEM_SING_MODEL=bro
#
   export PERT_JOB_CLASS=normal
   export PERT_TIME_LIMIT=05:59:00
   export PERT_NODES=1
   export PERT_TASKS=28
   export PERT_MODEL=bro

