#!/bin/bash

source ./utils/terminal-font-color.sh
source ./utils/filesystem.sh
source ./utils/reply.sh
source .env
app_dir=$(cd `dirname $0`; pwd)

if (confirm "Do you want Install JAVA ?"); then
	green "Installing JAVA ..."
	cd java
	./install.sh

	cd ${app_dir}
fi

if (confirm "Do you want Install MySQL ?"); then
	green "Installing MySQL ..."
	cd mysql
	./install.sh

	cd ${app_dir}
fi

if (confirm "Do you want Install Confluence ?"); then
	green "Installing Confluence ..."
	cd confluence
	./install.sh

	cd ${app_dir}
fi

if (confirm "Do you want Install Jira ?"); then
	green "Installing Jira ..."
	cd jira
	./install.sh

	cd ${app_dir}
fi




