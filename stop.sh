# Runs pkill uv4l 
function camera() {
pkill uv4l
}

# Stops the rover process
function rover() {
pm2 stop index
}

# Choice between all, rover or camera
case "$1" in
	all)
	 camera
	 rover
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


