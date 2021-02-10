########################################
# SOURCE USER CONFIGURATION (pug_src/.pug) and (~/.pug}
if [ -f ${HOME}/${CONF_FILE} ]; then
	source ${HOME}/${CONF_FILE}
fi
if [ -f ${PUG_CONF} ]; then
	source ${PUG_CONF}
fi
#echo "config: ${PUG_CONF}"
########################################
# set backend
#echo "backend:${PUG_BACKEND}" 
if [ "${PUG_BACKEND}X" != "X" ]; then
	BACKEND="-backend ${PUG_BACKEND}"
else
	BACKEND="-backend sqlite"
fi
########################################
# DETERMINE CONNECTION PARAMETER
#echo "Print ip: ${PUG_IP}"
if [ "${PUG_IP}X" != "X" ]; then
	HOST="-host ${PUG_IP}"
fi
if [ "${PUG_DB}X" != "X" ]; then
	DB="-db ${PUG_DB}"
fi
if [ "${PUG_PASSWD}X" != "X" ]; then
	PASSWD="-passwd ${PUG_PASSWD}"
fi
if [ "${PUG_USER}X" != "X" ]; then
	USER="-user ${PUG_USER}"
fi
if [ "${PUG_PORT}X" != "X" ]; then
	PORT="-port ${PUG_PORT}"
fi
CONNECTION_PARAMS="${BACKEND} ${HOST} ${DB} ${PORT} ${USER} ${PASSWD}"
########################################
# LOGGING
if [ "${PUG_LOG}X" != "X" ]; then
	LOG="-log -loglevel ${PUG_LOG}"
else
    LOG="-log -loglevel 0"
fi
########################################
# COMBINED CONFIGURATIONS USED BY SCRIPTS
PUG_DL_PLUGINS="-frontend dl -whynot_adv -attr_dom"
########################################
# FUNCTION THAT CHECKS WHETHER PROGRAM EXISTS
checkProgram() {
	_PROGRAM="${1}"
	echo "checking whether ${_PROGRAM} exists"
	if command -v ${_PROGRAM} > /dev/null 2>&1
	then
	   return 0
	else
	   return 1
	fi
}
