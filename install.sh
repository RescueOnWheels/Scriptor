# Quite unnecessary to run, therefore commented. Uncomment if needed
#echo "Updating Package list"
#sudo apt-get update
#echo "Upgrade packages to latest version"
#sudo apt-get dist-upgrade

#Checks for NodeJS installation and installs it if needed
PKG_OK=$(dpkg-query -W --showformat='${Status}\n' nodejs|grep "install ok installed")
echo "Checking for NodeJS:" $PKG_OK
if [ "" == "$PKG_OK" ]; then
  echo "No NodeJS. Setting up NodeJS."
  curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
  sudo apt-get --force-yes --yes install nodejs
  PKG_RECHECK=$(nodejs -v | grep "^v")
  echo "Rechecking for NodeJS, installed version:" $PKG_RECHECK
  if [ "" == "$PKG_RECHECK" ]; then
    echo "Failed to install NodeJS, exiting..."
    exit 1
  fi
fi

# Installs the PM2 package, which is a production process manager for Nodejs
echo "Installing PM2"
sudo npm install pm2 -g

# Clones the Rover repo with all it's submodules
echo "Installing Rover"
cd ..
git clone https://github.com/RescueOnWheels/Rover.git --recursive
cd Scriptor/

