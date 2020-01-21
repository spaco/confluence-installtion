#!/bin/bash

source ./utils/terminal-font-color.sh
source ./utils/filesystem.sh
source ./utils/reply.sh
source .env

if (confirm "Do you want Install JAVA ?"); then
	green "Installing JAVA ..."
	cd java
	./install.sh
fi

if (confirm "Do you want Install MySQL ?"); then
	green "Installing MySQL ..."
#	./java/install.sh
fi



