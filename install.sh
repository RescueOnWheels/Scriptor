function install_log() {
  echo -e "\033[1;32mRover Install: $*\033[m"
}

function install_error() {
  echo -e "\033[1;37;41mRover Install Error: $*\033[m"
  exit 1
}

function install_warning() {
  echo -e "\033[1;33mWarning: $*\033[m"
}

function display_welcome() {
  raspberry='\033[0;35m'
  green='\033[1;32m'

  echo -e "${raspberry}\n"
  echo -e " ########   #######  ##     ## ######## ########  "
  echo -e " ##     ## ##     ## ##     ## ##       ##     ## "
  echo -e " ##     ## ##     ## ##     ## ##       ##     ## "
  echo -e " ########  ##     ## ##     ## ######   ########  "
  echo -e " ##   ##   ##     ##  ##   ##  ##       ##   ##   "
  echo -e " ##    ##  ##     ##   ## ##   ##       ##    ##  "
  echo -e " ##     ##  #######     ###    ######## ##     ## "                   
  echo -e "${green}"
  echo -e "The Quick Installer will guide you through a few easy steps\n\n"
}

function update_system_packages() {
  install_log "Updating sources"
  sudo apt-get update || install_error "Unable to update package list"
}

function install_dependencies() {
  # Node v8.X
  curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -

  # UV4L
  curl http://www.linux-projects.org/listing/uv4l_repo/lpkey.asc | sudo apt-key add -
  echo "deb http://www.linux-projects.org/listing/uv4l_repo/raspbian/stretch stretch main" >> /etc/apt/sources.list

  install_log "Installing required packages"
  sudo apt-get install nodejs git uv4l uv4l-raspicam uv4l-server || install_error "Unable to install dependencies"
}

function install_complete() {
  install_log "Installation completed!"

  echo -n "The system needs to be rebooted as a final step. Reboot now? [y/N]: "
  read answer
  if [[ $answer != "y" ]]; then
    echo "Installation reboot aborted."
     exit 0
  fi
  sudo shutdown -r now || install_error "Unable to execute shutdown"
}

function download_latest_files() {
  if [ -d ~/rover ]; then
    install_log "Updating Rover files..."
    
    open ~/rover
    git pull
    npm run init
    npm install
  else
    install_log "Downloading Rover files..."
    git clone https://github.com/RescueOnWheels/Rover.git ~/rover --recursive
  fi

  if [ -d ~/scripts ]; then
    install_log "Updating Scriptor files..."
    
    open ~/scripts
    git pull
  else
    install_log "Downloading Scriptor files..."
    git clone https://github.com/RescueOnWheels/Scriptor ~/scripts
  fi
}

function install_rover() {
  display_welcome
  update_system_packages
  install_dependencies
  download_latest_files
  install_complete
}

install_rover
