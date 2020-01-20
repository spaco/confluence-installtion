#!/bin/bash

source install.conf
source ../utils/terminal-font-color.sh
source ../utils/filesystem.sh

function info() {
	echo ""
	echo "Jdk file path :$jdk_file_path"
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

function config() {
    # 获取参数中的段
    section=$(echo $1 | cut -d '.' -f 1);
    # 获取参数中的key
    key=$(echo $1 | cut -d '.' -f 2);
    # 使用正则表达是获取key所对应的value
    sed -n "/\[$section\]/,/\[.*\]/{
      /^\[.*\]/d
      /^[ \t]*$/d
      /^$/d
      /^#.*$/d
      s/^[ \t]*$key[ \t]*=[ \t]*\(.*\)[ \t]*/\1/p
    }" install.conf
}


function remote() {
#	 config "remote.java_dir"

#	wget $jdk_remote_url $jdk_save_dir
    wget --no-check-certificate --no-cookies --header="Cookie: oraclelicense=accept-securebackup-cookie" -O /tmp/jdk-8u171-linux-x64.tar.gz $jdk_remote_url

}

function local() {
	jdk_file_path= config "local.jdk_file_path"
	jdk_dir= config "local.jdk_dir"


#	if [[ -f "/Users/spaco/code/open-source/confluence-installtion/java/jdk-13.0.2_linux-x64_bin.tar.gz" ]]; then
#		red "exists"
#	fi
	fileExists ${jdk_file_path}

	if [[ ! $(fileExists ${jdk_file_path}) -gt 0 ]]; then
		red "Please specify the JDK file."
		exit 1
	fi
	if [[ ! $(fileExists ${jdk_dir}) -gt 0 ]]; then
	 	red "Please specify a valid Java installation directory : ${jdk_dir}"
		exit 1
	fi

	tar -zxvf ${jdk_file_path} -C ${jdk_dir}

#	fileExists ${jdk_file_path}
#	echo $?
#	a=$?
#	echo $a
# 	$(fileExists ${jdk_file_path})
#	if [[ ! -f ${jdk_file_path} ]]; then
#		red "Please specify the JDK file."
#		exit 1
#	fi
#	tar -zxvPf ${jdk_file_path} -C ${jdk_dir}


}

case $env in
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
#
##Validate java directory
#if [[ ! -d $java_dir ]]; then
#    echo "Please specify a valid Java installation directory."
#    exit 1
#fi
#
## Validate Java Distribution
#java_dist_filename=$(basename $jdk_file_path)
#
#echo "Installing: $java_dist_filename"
#
#tar -zxvPf $jdk_file_path -C $java_dir
#
## JDK Directory with version




