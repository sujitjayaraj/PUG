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
if [ $# -le 0 ]; then
	LOG="-log -loglevel 0"
	ARGS="${*}"
else
	LOG="-log -loglevel $1"	
	ARGS="${*:2}"
fi

SCRIPT=debug.script

# SET PATH TO FIND libgprom
DYLD_LIBRARY_PATH="${DIR}/../../src/libgprom/.libs:$DYLD_LIBRARY_PATH"
DYLD_LIBRARY_PATH=`echo "$DYLD_LIBRARY_PATH" | /sw/bin/sed 's/::*$//'`
export DYLD_LIBRARY_PATH
echo "DYLD_LIBRARY_PATH ${DYLD_LIBRARY_PATH}"

echo "run ${CONNECTION_PARAMS} ${LOG} ${ARGS}" > ./$SCRIPT
gdb ${DIR}/../../test/.libs/testmain -x ${SCRIPT}
