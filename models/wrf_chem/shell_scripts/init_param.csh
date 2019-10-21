#!/bin/csh
#
# DART software - Copyright UCAR. This open source software is provided
# by UCAR, "as is", without charge, subject to all terms of use at
# http://www.image.ucar.edu/DAReS/DART/DART_download
#
# $Id: init_param.csh 13126 2019-04-25 01:59:32Z thoar@ucar.edu $
#

# Parameter file to accompany the wrf dart initialization script

  set ASSIM_INT_HOURS = 6
  set domains = 1
  set NUM_ENS = 40
  set IC_PERT_SCALE = 0.4
  set RUN_DIR  = /ptmp/romine/temp/rundir
  set DART_DIR = /glade/proj3/image/romine/rt2011/DARTrt2011
  set TEMPLATE_DIR = ptmp/romine/temp/templates
  set OUTPUT_DIR = /ptmp/romine/temp/output

# system definitions
  set NCAR_PTILE = '64'
  set NCAR_CORES = '32'
  set NCAR_QUEUE = 'regular'
  set NCAR_RUNTIME = '0:30'
  set NCAR_GAU_ACCOUNT = '00000000'
  set MPI_EXEC = 'mpirun.lsf /usr/local/bin/launch'
  set JOB_SUBMIT = 'bsub < '

#  System specific commands, check paths for your system
   setenv   REMOVE 'rm -rf'
   setenv   COPY 'cp -pfr'
   setenv   MOVE 'mv -f'
   setenv   LINK 'ln -fs'
### end variable definitions

exit 0

# <next few lines under version control, do not edit>
# $URL: https://svn-dares-dart.cgd.ucar.edu/DART/tags/wrf-chem.r13172/models/wrf_chem/shell_scripts/init_param.csh $
# $Revision: 13126 $
# $Date: 2019-04-24 19:59:32 -0600 (Wed, 24 Apr 2019) $


