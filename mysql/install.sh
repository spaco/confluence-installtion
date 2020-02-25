#!/bin/bash

source ../utils/terminal-font-color.sh
source ../utils/reply.sh
source ../env.conf

function remote() {
  echo  1
}

function local() {
  echo  Local
}

case ${MySQL_install_from} in
	remote)
		green "Set up for remote installation..."
		remote
		;;
	local)
		green "Set up for local installation..."
		local
		;;
	*)
		red "Sorry, This method is not supported..."
		exit 1
		;;
 esac

green "MySQL has been successfully installed"



