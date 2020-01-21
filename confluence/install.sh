#!/bin/bash

source ../utils/terminal-font-color.sh
source ../.env

confluence_install_from=${confluence_install_from}

function remote() {
	confluence_saved_dir=${confluence_remote_saved_dir}
	confluence_remote_download_url=${confluence_remote_download_url}
	confluence_dir=${confluence_dir}

	# Validate download dist directory
	if [[ ! -f ${confluence_saved_dir} ]]; then
		red "Please specify a valid saved directory : ${confluence_saved_dir}"
		if (confirm "Do you want create saved directory ?"); then
			mkdir -p ${confluence_saved_dir}
		else
			red "Confluence install failed !"
			exit 1
		fi
	fi
	# Validate installation directory
	if [[ ! -f ${confluence_dir} ]]; then
		red "Please specify a valid installation directory : ${confluence_dir}"
		if (confirm "Do you want create installation directory ?"); then
			mkdir -p ${confluence_dir}
		else
			red "Confluence install failed !"
			exit 1
		fi
	fi

	wget ${confluence_remote_download_url} -O confluence.bin -P ${confluence_dir}

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
		;;
esac


exit
green "JAVA has been successfully installed"

mkdir -p $SAVE_PATH
cd $SAVE_PATH
wget $DOWNLOAD_URL confluence.bin
./confluence.bin


exit


# 下载安装程序
wget https://product-downloads.atlassian.com/software/confluence/downloads/atlassian-confluence-7.2.1-x64.bin

# 执行安装程序，进行安装：
./atlassian-confluence-7.2.1-x64.bin

Unpacking JRE ...
Starting Installer ...
You do not have administrator rights to this machine and as such, some installation options will not be available. Are you sure you want to continue?
Yes [y, Enter], No [n]
y

This will install Confluence 7.2.1 on your computer.
OK [o, Enter], Cancel [c]
o
Click Next to continue, or Cancel to exit Setup.

Choose the appropriate installation or upgrade option.
Please choose one of the following:
Express Install (uses default settings) [1],
Custom Install (recommended for advanced users) [2, Enter],
Upgrade an existing Confluence installation [3]
2

Select the folder where you would like Confluence 7.2.1 to be installed,
then click Next.
Where should Confluence 7.2.1 be installed?
[/home/vagrant/atlassian/confluence]
/home/vagrant/services/confluence

Default location for Confluence data
[/home/vagrant/atlassian/application-data/confluence]
/home/vagrant/storage/application-data/confluence

Configure which ports Confluence will use.
Confluence requires two TCP ports that are not being used by any other
applications on this machine. The HTTP port is where you will access
Confluence through your browser. The Control port is used to Startup and
Shutdown Confluence.
Use default ports (HTTP: 8090, Control: 8000) - Recommended [1, Enter], Set custom value for HTTP and Control ports [2]
1

Extracting files ...


Please wait a few moments while we configure Confluence.

Installation of Confluence 7.2.1 is complete
Start Confluence now?
Yes [y, Enter], No [n]
y

Please wait a few moments while Confluence starts up.
Launching Confluence ...

# BM7L-1L6D-EBCX-ZIQI 
# java mysql install first

#  进行破解
/home/vagrant/services/confluence
bash bin/stop-confluence.sh


cp confluence/WEB-INF/lib/atlassian-extras-decoder-v2-3.4.1.jar ~/


mv ~/atlassian-extras-decoder-v2-3.4.1.jar ~/atlassian-extras-2.4.jar




# 本地
cd local-jar
java -jar confluence_keygen.jar

ftp 传到服务器
# 传回服务器后，将名称改回之前的名称
mv atlassian-extras-2.4.jar atlassian-extras-decoder-v2-3.4.1.jar

mv ~/atlassian-extras-decoder-v2-3.4.1.jar /home/vagrant/services/confluence/confluence/WEB-INF/lib/




# 创建conf数据库
CREATE DATABASE confluence CHARACTER SET utf8 COLLATE utf8_bin;
GRANT ALL PRIVILEGES ON confluence.* TO 'confluenceuser'@'%' IDENTIFIED BY 'secret';

#下载mysql connect 并上传
scp ~/Downloads/mysql-connector-java-5.1.48/mysql-connector-java-5.1.48-bin.jar vagrant@193.168.10.11:~/services/confluence/confluence/WEB-INF/lib

# 重启 confluence
cd ~/services/confluence

bash bin/start-confluence.sh

# SELECT @@GLOBAL.sql_mode;