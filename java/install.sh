#!/bin/bash

source ../utils/terminal-font-color.sh
source ../utils/filesystem.sh
source ../.env

function info() {
	echo ""
	echo "Jdk file path :$java_dist"
	echo "JAVA dir :$java_dir"
}

function confirm() {
    # call with a prompt string or use a default
    read -r -p "${1:-Are you sure?} [y/N] " response
    case $response in
    [yY][eE][sS] | [yY])
        true
        ;;
    *)
        false
        ;;
    esac
}

#function config() {
#    # 获取参数中的段
#    section=$(echo $1 | cut -d '.' -f 1);
#    # 获取参数中的key
#    key=$(echo $1 | cut -d '.' -f 2);
#    # 使用正则表达是获取key所对应的value
#    sed -n "/\[$section\]/,/\[.*\]/{
#      /^\[.*\]/d
#      /^[ \t]*$/d
#      /^$/d
#      /^#.*$/d
#      s/^[ \t]*$key[ \t]*=[ \t]*\(.*\)[ \t]*/\1/p
#    }" install.conf
#}


function remote() {
    wget --no-check-certificate --no-cookies --header="Cookie: oraclelicense=accept-securebackup-cookie" -O /tmp/jdk-8u171-linux-x64.tar.gz $jdk_remote_url

}

function local() {
	java_dist=${java_local_dist}
	java_dir=${java_dir}

	if [[ ! $(fileExists ${java_dist}) -gt 0 ]]; then
		red "Please specify the JDK file."
		exit 1
	fi

	if [[ ! $(directoryExists ${java_dir}) -gt 0 ]]; then
	 	red "Please specify a valid Java installation directory : ${java_dir}"

	 	if (confirm "Do you want create Java installation directory ?"); then
	 		mkdir -p $java_dir
	 	else
   			exit 1
		fi
	fi
	# Validate Java Distribution
	java_dist_filename=$(basename $java_dist)
	if [[ ${java_dist_filename: -7} != ".tar.gz" ]]; then
		echo "Java distribution must be a valid tar.gz file."
		exit 1
	fi
		#Check whether unzip command exsits
	if ! command -v unzip >/dev/null  2>&1; then
		red "Please install unzip extension."
		exit 1
	fi

	green "Installing: $(basename $java_dist) ..."

#	# Check Java executable
	java_exec="$(tar -tzf $java_dist | grep ^[^/]*/bin/java$ || echo "")"
	if [[ -z $java_exec ]]; then
    	echo "Could not find \"java\" executable in the distribution. Please specify a valid Java distribution."
    	exit 1
	fi

	# JDK Directory with version
	jdk_dir="$(echo $java_exec | cut -f1 -d"/")"
	extracted_dirname=$java_dir"/"$jdk_dir


	# Extract Java Distribution
	if [[ ! -d $extracted_dirname ]]; then
		green "Extracting $java_dist to $java_dir"
		tar -xof $java_dist -C $java_dir
		green "JDK is extracted to $extracted_dirname"
	else
		red "WARN: JDK was not extracted to $java_dir. There is an existing directory with name $java_dir."
		exit 1
	fi

	if [[ ! -f "${extracted_dirname}/bin/java" ]]; then
		red "ERROR: The path $extracted_dirname is not a valid Java installation."
		exit 1
	fi

	# Set JAVA_HOME environment
	if (confirm "Do you want to set JAVA_HOME environment variable in $HOME/.bashrc?"); then
		if grep -q "export JAVA_HOME=.*" $HOME/.bashrc; then
			sed -i "s|export JAVA_HOME=.*|export JAVA_HOME=$extracted_dirname|" $HOME/.bashrc
		else
			echo "export JAVA_HOME=$extracted_dirname" >>$HOME/.bashrc
		fi
		source $HOME/.bashrc
	fi
}

case ${java_install_from} in
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
		;;
 esac




