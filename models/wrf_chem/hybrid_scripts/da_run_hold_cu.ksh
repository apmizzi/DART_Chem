#!/bin/ksh -x
#
# DART software - Copyright UCAR. This open source software is provided
# by UCAR, "as is", without charge, subject to all terms of use at
# http://www.image.ucar.edu/DAReS/DART/DART_download
#
# $Id: da_run_hold_cu.ksh 13133 2019-04-25 21:47:54Z nancy@ucar.edu $
#

#
# Script to hold script execution until all jobs 
# with the $1 job name have completed on bluefire
#   
squeue -u ${USER} > job_list
grep $1 job_list > test_list
while [[ -s test_list ]]; do
   sleep 30
   squeue -u ${USER} > job_list
   grep "$1" job_list > test_list
done
rm job_list test_list
#
#
# <next few lines under version control, do not edit>
# $URL: https://svn-dares-dart.cgd.ucar.edu/DART/tags/wrf-chem.r13172/models/wrf_chem/hybrid_scripts/da_run_hold_cu.ksh $
# $Id: da_run_hold_cu.ksh 13133 2019-04-25 21:47:54Z nancy@ucar.edu $
# $Revision: 13133 $
# $Date: 2019-04-25 15:47:54 -0600 (Thu, 25 Apr 2019) $
