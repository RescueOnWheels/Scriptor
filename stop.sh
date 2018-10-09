function camera() {
pkill uv4l
}

function rover() {
pm2 stop index
}

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


