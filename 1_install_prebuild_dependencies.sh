#!/bin/bash

echo "The following dependencies are required to start building:"
echo "* python2.7"
echo "* openjdk-8-jdk"
echo "* git"
echo ""
echo "To install them You might have to enter your password for 'sudo'."
#TODO to find which packages are needed (sudo apt install -y libgd3 libgl1-mesa-dri libglapi-mesa libglx-mesa0)??
sudo apt-get -y update
sudo apt-get -y install python2.7 openjdk-8-jdk git

if [[ -d ./depot_tools ]]
then
    echo "Depot Tools exist"
    exit 
fi
        
echo "Installing Depot Tools"
git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
echo "Depot Tools installed"
