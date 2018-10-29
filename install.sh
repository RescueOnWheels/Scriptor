# Quite unnecessary to run, therefore commented. Uncomment if needed
#echo "Updating Package list"
#sudo apt-get update
#echo "Upgrade packages to latest version"
#sudo apt-get dist-upgrade

# Checks for NodeJS installation and installs it if needed
NODE_OK=$(dpkg-query -W --showformat='${Status}\n' nodejs|grep "install ok installed")
echo "Checking for NodeJS:" $NODE_OK
if [ "" == "$NODE_OK" ]; then
  echo "No NodeJS. Setting up NodeJS."
  curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
  sudo apt-get --force-yes --yes install nodejs
  NODE_RECHECK=$(nodejs -v | grep "^v")
  echo "Rechecking for NodeJS, installed version:" $PKG_RECHECK
  if [ "" == "$NODE_RECHECK" ]; then
    echo "Failed to install NodeJS, exiting..."
    exit 1
  fi
fi

# Installs UV4l, warning: For stretch
UV4L_OK=$(dpkg-query -W --showformat='${Status}\n' uv4l|grep "install ok installed")
if [ "" == "$UV4L_OK" ]; then
  echo "No UV4L. Setting up UV4l."
  curl http://www.linux-projects.org/listing/uv4l_repo/lpkey.asc | sudo apt-key add -
  echo "deb http://www.linux-projects.org/listing/uv4l_repo/raspbian/stretch stretch main" >> /etc/apt/sources.list
  sudo apt-get install uv4l uv4l-raspicam uv4l-server
  UV4l_RECHECK = $(dpkg-query -W --showformat='${Status}\n' uv4l|grep "install ok installed")
  if [ "" == "$UV4l_RECHECK"]; then
    echo "Failed to install UV4l, exiting..."
    exit 1
  fi
fi
  
# Installs the PM2 package, which is a production process manager for Nodejs
echo "Installing PM2"
sudo npm install pm2 -g

# Clones the Rover repo with all it's submodules
echo "Installing Rover"
cd ..
git clone https://github.com/RescueOnWheels/Rover.git rover --recursive

# Checks if rest of scriptor is present
if [ ! -f rover.sh ]; then
    echo "Installing scriptor scripts"
    wget https://git.io/fxQQu -o rover.sh;
    wget https://git.io/fxQQ2 -o start.sh;
    wget https://git.io/fxQQa -o stop.sh;
fi