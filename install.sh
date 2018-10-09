echo "Updating Package lis"
#sudo apt-get update

echo "Upgrade packages to latest version"
#sudo apt-get dist-upgrade

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

git clone git@github.com:RescueOnWheels/Rover.git
cd Rover/
npm install

