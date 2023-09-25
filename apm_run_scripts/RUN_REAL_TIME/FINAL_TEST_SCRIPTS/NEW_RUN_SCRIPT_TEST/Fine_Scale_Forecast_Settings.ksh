#!/bin/ksh -aux
#
# Run fine scale forecast only
export RUN_FINE_SCALE=false
#
# Restart fine scale forecast only
export RUN_FINE_SCALE_RESTART=false
export RESTART_DATE=2014072312
#
if [[ ${RUN_FINE_SCALE_RESTART} = "true" ]]; then
   export RUN_FINE_SCALE=true
fi
#
