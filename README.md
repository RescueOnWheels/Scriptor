# Scriptor
Installation and usage scripts of the [Rover](https://github.com/RescueOnWheels/Rover) Rescue System.

## Scripts
* Start
  ```powershell
  $ ./start.sh [OPTION]
  
  OPTION:
  - all
  - camera
  - rover
  ```
* Stop
  ```powershell
  $ ./stop.sh [OPTION]
  
  OPTION:
  - all
  - camera
  - rover
  ```

## Quick installer
Install Rover (and its dependencies) from your RaspberryPi's shell prompt:
```powershell
$ wget -q https://git.io/fx0ko -O /tmp/rover && bash /tmp/rover
```
The installer will complete the steps in the [manual installation](#manual-installation) (below) for you.

## Manual installation
These steps apply to the latest release of Raspbian (currently [Stretch](https://www.raspberrypi.org/downloads/raspbian/)).

* Update your system package list:
  ```powershell
  $ sudo apt-get -update -y
  ```
* Upgrade all your installed packages to their latest version:
  ```powershell
  $ sudo apt-get dist-upgrade -y
  ```
* To download and install newest version of Node.js, use the following command:
  ```powershell
  $ curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
  ```
* Now install it by running:
  ```powershell
  $ sudo apt-get install nodejs -y
  ```
* To compile and install native addons from npm you also need to install build tools:
  ```powershell
  $ sudo apt-get install build-essential -y
  ```
* To download the Rover code you need to install git:
  ```powershell
  $ sudo apt-get install git -y
  ```
* Clone 'Scriptor' using git:
  ```powershell
  $ git clone https://github.com/RescueOnWheels/Scriptor.git
  ```
* Clone 'Rover' using git:
  ```powershell
  $ git clone https://github.com/RescueOnWheels/Rover.git --recursive
  ```
* Open the 'Scriptor' folder and start using the Rover:
  ```powershell
  $ cd Scriptor && ./start.sh all
  ```
