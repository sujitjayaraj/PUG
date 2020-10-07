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
PUG=${DIR}/../../test/testmain
PUG_CONF=${DIR}/../../${CONF_FILE}
source ${DIR}/../pug_basic.sh
#########################################
if [ $# -le 0 ]; then
	LOG="-log -loglevel 0"
	ARGS="${*}"
else
	LOG="-log -loglevel $1"	
	ARGS="${*:2}"
fi
LLDB=lldb
SQL="$2"
ARGS="${*:3}"
SCRIPT=debug.script

echo "
process launch -- ${PUG} ${LOG} ${ARGS}
"

${LLDB} ${PUG} process launch -- ${LOG} ${ARGS}
#rm -f $SCRIPT
