#!/bin/bash
########################################
# VARS
# Directory this script resides in
pushd $(dirname "${0}") > /dev/null
DIR=$(pwd -L)
popd > /dev/null
#########################################
# READ USER CONFIGUATION
CONF_FILE=.pug
PUG=${DIR}/../../src/command_line/gprom
PUG_CONF=${DIR}/../../${CONF_FILE}
source ${DIR}/../pug_basic.sh
#########################################
if [ $# -le 1 ]; then
	echo "Description: use gdb to debug gprom for Datalog queries"
	echo " "
    echo "Usage: give at least two parameters, the first one is a loglevel, the second one is a Datalog query."
    echo "debug_pug.sh 3 \"Q(X) :- R(X,Y).;\""
    exit 1
fi

PROGRAM="${2}"
LOG="${1}"
###########################################
LLDB=lldb
GDB=gdb

if [[ $OSTYPE == darwin* ]]; then
	DEBUGGER=${LLDB}
else
	DEBUGGER=${GDB}
fi
###########################################

if [[ ${CONNECTION_PARAMS} == *"oracle"* ]]; then
	${DEBUGGER} -- ${PUG} ${LOG} -sql "${PROGRAM}" ${CONNECTION_PARAMS} -Boracle.servicename TRUE ${PUG_DL_PLUGINS} -Pexecutor sql -Cattr_reference_consistency FALSE -Cschema_consistency FALSE  -Cunique_attr_names FALSE -treeify-algebra-graphs FALSE ${*:3}
fi

if [[ ${CONNECTION_PARAMS} == *"postgres"* ]]; then
	${DEBUGGER} -- ${PUG} ${LOG} -sql "${PROGRAM}" ${CONNECTION_PARAMS} ${PUG_DL_PLUGINS} -Pexecutor sql -Cattr_reference_consistency FALSE -Cschema_consistency FALSE  -Cunique_attr_names FALSE -treeify-algebra-graphs FALSE ${*:3}
fi
