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
PUG=${DIR}/../src/command_line/gprom
PUG_CONF=${DIR}/../${CONF_FILE}
source ${DIR}/pug_basic.sh
#########################################
# PARAMETERS
PROGRAM="${1}"
OUT="${2}"
DOTFILE="${OUT}.dot"
PDFFILE="${OUT}.pdf"

if [ $# -lt 2 ]; then
	echo "Description: run a Datalog program with provenance requests, create a dot script of the resulting provenance graph, and create a pdf from this dot script using graphviz."
    echo "Usage: pass at least two parameters, the first one is the loglevel [0 : NONE up to 5 : TRACE] and the second one is a query."
    echo "pug-to-provgraph.sh \"Q(X) :- R(X,Y). WHY(Q(1)).\" my_prov_graph" 
    exit 1
fi

########################################
# RUN COMMAND
##########
echo "-- compute edge relation of provenance graph"
if [[ ${CONNECTION_PARAMS} == *"oracle"* ]]; then
	${PUG} 0 -sql "${PROGRAM}" ${CONNECTION_PARAMS} -Boracle.servicename TRUE ${PUG_DL_PLUGINS} -Pexecutor gp -Cattr_reference_consistency FALSE -Cschema_consistency FALSE  -Cunique_attr_names FALSE ${*:3} > ${DOTFILE}
fi

if [[ ${CONNECTION_PARAMS} == *"postgres"* ]]; then
	${PUG} 0 -sql "${PROGRAM}" ${CONNECTION_PARAMS} ${PUG_DL_PLUGINS} -Pexecutor gp -Cattr_reference_consistency FALSE -Cschema_consistency FALSE  -Cunique_attr_names FALSE ${*:3} > ${DOTFILE}
fi
##########
echo "-- run graphviz on ${DOTFILE} to produce PDF file ${PDFFILE}"
dot -Tpdf -o ${PDFFILE} ${DOTFILE}

##########
echo "-- open the pdf file"
if [[ $OSTYPE == darwin* ]]; then
	echo "    - on a mac use open"
	open ${PDFFILE}
else
	for $P in $LINUX_PDFPROGS; do
		if checkProgram $P;
		then
			$P ${PDFFILE} > /dev/null 2>&1 &
			exit 0
		fi
		echo "    - apparently you do not have ${P}"
	done
	echo "did not find a pdf viewer, please open ${PDFFILE} manually"
fi
