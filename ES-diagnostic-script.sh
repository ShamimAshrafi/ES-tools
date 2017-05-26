#!/bin/sh

##################
#AWS Elasticsearch diagnostics script
#Version 1.0 created by Shamim Ashrafi on 5/20/2017
#Usage script-name <ESS end point>
#################


##################
# Set variables and directory
#################
ESSURL=$1
DIAG_DIR="${HOME}/ess-diag/"
DATE=`date -u '+%Y-%m-%d-%H%M%S'`
mkdir -p ${DIAG_DIR}
##################
# Main SCRIPT
#################
if [ $? -eq 0 ]; then

	echo "================CLUSTER HEALTH================" >> ${DIAG_DIR}/${DATE}.output
	curl ${ESSURL}/_cluster/health?pretty=true >> ${DIAG_DIR}/${DATE}.output
	echo "================NUMBER OF DOCUMENTS================" >> ${DIAG_DIR}/${DATE}.output
	curl ${ESSURL}/_cat/count?v >> ${DIAG_DIR}/${DATE}.output
	echo "================LIST OF RED INDEXES================" >> ${DIAG_DIR}/${DATE}.output
	curl ${ESSURL}/_cat/indices?v |grep red >> ${DIAG_DIR}/${DATE}.output
	echo "================LIST OF YELLOW INDEXES================" >> ${DIAG_DIR}/${DATE}.output
	curl ${ESSURL}/_cat/indices?v |grep yellow >> ${DIAG_DIR}/${DATE}.output
	echo "================LIST OF UNASSIGNED SHARDS================" >> ${DIAG_DIR}/${DATE}.output
	curl ${ESSURL}/_cat/shards?v |grep UNASSIGNED >> ${DIAG_DIR}/${DATE}.output
	echo "================ NUMBER AND SIZE OF SHARDS================" >> ${DIAG_DIR}/${DATE}.output
	curl ${ESSURL}/_cat/allocation?v >> ${DIAG_DIR}/${DATE}.output
	echo "================ACTIVE MASTER NODES================" >> ${DIAG_DIR}/${DATE}.output
	curl ${ESSURL}/_cat/master?v >> ${DIAG_DIR}/${DATE}.output
	echo "================ALL DATA NODES================" >> ${DIAG_DIR}/${DATE}.output
  curl ${ESSURL}/_cat/nodes?v >> ${DIAG_DIR}/${DATE}.output
	echo "================LIST ALL OF INDEXES================" >> ${DIAG_DIR}/${DATE}.output
	curl ${ESSURL}/_cat/indices?v >> ${DIAG_DIR}/${DATE}.output
	echo "================LIST OF ALL SHARDS================" >> ${DIAG_DIR}/${DATE}.output
	curl ${ESSURL}/_cat/shards?v >> ${DIAG_DIR}/${DATE}.output
	echo "================ CLUSTER STATS================" >> ${DIAG_DIR}/${DATE}.output
	curl ${ESSURL}/_cluster/stats?pretty=true >> ${DIAG_DIR}/${DATE}.output
	echo " " >> ${DIAG_DIR}/${DATE}.output

else
		echo "DIRECTORY CREATING ERROR"
	fi
