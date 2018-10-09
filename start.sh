# Checks for UV4L installation and runs it with predifined settings
function camera() {
PKG_OK=$(dpkg-query -W --showformat='${Status}\n' uv4l|grep "install ok installed")
if [ "" == "$PKG_OK" ]; then
	echo "No UV4L installation found. Try running installation script"
	exit 1
fi
echo "Installation OK. Startin camera"
uv4l --driver raspicam --vflip --hflip --auto-video_nr --object-detection --min-object-size 80 80 --main-classifier /usr/share/uv4l/raspicam/lbpcascade_frontalface.xml --object-detection-mode accurate_detection --width 640 --height 360 --framerate 15 --encoding h264 --enable-server
echo "Camera initialized"
}

# Checks for NodeJS installation and Rover folder and runs it with the PM2 package
function rover() {
PKG_OK=$(dpkg-query -W --showformat='${Status}\n' nodejs|grep "install ok installed") 
if [ "" == "$PKG_OK" ]; then
	echo "No NodeJS installation found. Try running installation script"
	exit 1
fi
RVR_OK=$(cd ../Rover/)
if [ "" == "$RVR_OK" ]; then
	cd ../Rover/
	echo "Startin Rover..."
	git pull
	npm i
	pm2 start index.js
else 
	echo "Rover not properly installed. Try running installation script"
	exit 1
fi
}

# Choice between all, rover or camera
case "$1" in
	all)
	 rover
	 camera
        ;;
	rover)
	 rover
	;;
	camera)
	 camera
	;;
	*)
	 echo $"Usage: $0 {all|rover|camera}"
esac


