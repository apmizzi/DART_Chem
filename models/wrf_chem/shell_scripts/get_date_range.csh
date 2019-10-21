#!/bin/csh
#
# DART software - Copyright UCAR. This open source software is provided
# by UCAR, "as is", without charge, subject to all terms of use at
# http://www.image.ucar.edu/DAReS/DART/DART_download
#
# DART $Id: get_date_range.csh 13126 2019-04-25 01:59:32Z thoar@ucar.edu $
#
# Purpose: Set environment variables associated with date range.

#-----------------------------------------------------------------------
# [1] Set arguments:
#-----------------------------------------------------------------------

if ($#argv < 2) then
   echo "Usage: get_date_range <YYYYMMDDHH> <FCST_RANGE>"
   exit(1)
endif

setenv START_DATE $1
setenv FCST_RANGE $2

#-----------------------------------------------------------------------
# [2] Set environment variables:
#-----------------------------------------------------------------------

set END_DATE = `advance_cymdh $START_DATE $FCST_RANGE`

setenv START_YEAR `echo $START_DATE | cut -c1-4`
setenv START_MONTH `echo $START_DATE | cut -c5-6`
setenv START_DAY `echo $START_DATE | cut -c7-8`
setenv START_HOUR `echo $START_DATE | cut -c9-10`
setenv END_YEAR `echo $END_DATE | cut -c1-4`
setenv END_MONTH `echo $END_DATE | cut -c5-6`
setenv END_DAY `echo $END_DATE | cut -c7-8`
setenv END_HOUR `echo $END_DATE | cut -c9-10`

exit 0

# <next few lines under version control, do not edit>
# $URL: https://svn-dares-dart.cgd.ucar.edu/DART/tags/wrf-chem.r13172/models/wrf_chem/shell_scripts/get_date_range.csh $
# $Revision: 13126 $
# $Date: 2019-04-24 19:59:32 -0600 (Wed, 24 Apr 2019) $

