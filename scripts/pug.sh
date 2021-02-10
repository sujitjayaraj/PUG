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
POSTGRES=""

# RUN COMMAND
if [[ ${CONNECTION_PARAMS} == *"oracle"* ]]; then
	ORACLE="-Boracle.servicename TRUE"
else
	ORACLE=${POSTGRES}
fi

${PUG} ${LOG} ${CONNECTION_PARAMS} ${ORACLE} ${PUG_DL_PLUGINS} -treeify-algebra-graphs FALSE ${*}


