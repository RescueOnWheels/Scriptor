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

function rover() {
PKG_OK=$(dpkg-query -W --showformat='${Status}\n' nodejs|grep "install ok installed") 
if [ "" == "$PKG_OK" ]; then
	echo "No NodeJS installation found. Try running installation script"
	exit 1
fi
RVR_OK=$(cd ../Rover/)
if [ "" == "$RVR_OK" }; then
	cd ../Rover/
	echo "Startin Rover..."
	npm run update
	pm2 start index.js
else 
	echo "Rover not properly installed. Try running installation script"
	exit 1
fi
}

case "$1" in
	all)
	 echo "HEHEHE ALL"
        ;;
	rover)
	 echo "ROver"
	;;
	camera)
	 camera
	;;
	*)
	 echo $"Usage: $0 {all|rover|camera}"
esac


