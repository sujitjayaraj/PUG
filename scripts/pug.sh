#!/bin/bash
########################################
# VARS
# Directory this script resides in
pushd $(dirname "${0}") > /dev/null
DIR=$(pwd -L)
popd > /dev/null
# PUG binary
CONF_FILE=.pug
PUG=${DIR}/../src/command_line/gprom
PUG_CONF=${DIR}/../${CONF_FILE}
#######################################
# READ USER CONFIGUATION
source ${DIR}/pug_basic.sh
#######################################
# RUN COMMAND
${PUG} ${LOG} ${CONNECTION_PARAMS} -Boracle.servicename TRUE ${PUG_DL_PLUGINS} -treeify-algebra-graphs ${*}
