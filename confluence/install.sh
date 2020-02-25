#!/bin/bash

source ../utils/terminal-font-color.sh
source ../.env

confluence_install_from=${confluence_install_from}

function remote() {
	confluence_save_dir=${confluence_remote_save_dir}
	confluence_remote_download_url=${confluence_remote_download_url}
	confluence_dir=${confluence_dir}

	# Validate download dist directory
	if [[ ! -f ${confluence_save_dir} ]]; then
		red "Please specify a valid saved directory : ${confluence_save_dir}"
		if (confirm "Do you want create saved directory ?"); then
			mkdir -p ${confluence_save_dir}
		else
			red "Confluence install stoped ! Please specify a valid saved directory"
			exit 1
		fi
	fi

	# Validate installation directory
	if [[ ! -f ${confluence_dir} ]]; then
		red "Please specify a valid installation directory : ${confluence_dir}"
		if (confirm "Do you want create installation directory ?"); then
			mkdir -p ${confluence_dir}
		else
			red "Confluence install stoped ! Please specify a valid installation directory"
			exit 1
		fi
	fi

	wget ${confluence_remote_download_url} -O ${confluence_save_dir}/confluence.bin

  # Validate confluence.bin exists

  bash ${confluence_save_dir}/confluence.bin

}

function local() {
    echo local
}

case ${confluence_install_from} in
	remote)
		green "Set Up for Remote Installation..."
		remote
		;;
	local)
		green "Set Up for Local Installation..."
		local
		;;
	*)
		red "Sorry, This method is not supported..."
		exit 1
		;;
esac

green "confluence has been successfully installed"