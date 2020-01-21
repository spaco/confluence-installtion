#!/bin/bash

function fileExists() {
 	if [[ -f $1 ]];then
  		echo 1
  	else
  		echo 0
	fi
}

function directoryExists() {
 	if [[ -d $1 ]];then
  		echo 1
  	else
  		echo 0
	fi
}

function appDir() {
    echo $(cd `dirname $0`; pwd)
}