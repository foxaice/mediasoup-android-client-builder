#!/bin/bash

echo "The following dependencies are required to start building:"
echo "* python2.7"
echo "* openjdk-11-jdk"
echo "* git"
echo "* ninja-build"
echo "* libgd3"
echo "* libgl1-mesa-dri"
echo "* libglapi-mesa"
echo "* libglx-mesa0"
echo ""
echo "To install them You might have to enter your password for 'sudo'."
sudo apt-get -y update
sudo apt-get -y install python2.7 openjdk-11-jdk git ninja-build
sudo apt-get -y install libgd3 libgl1-mesa-dri libglapi-mesa libglx-mesa0

if [[ -d ./depot_tools ]]
then
    echo "Depot Tools exist"
    exit 
fi
        
echo "Installing Depot Tools"
git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
echo "Depot Tools installed"