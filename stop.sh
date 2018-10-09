case "$1" in
	all)
	 echo "HEHEHE ALL"
        ;;
	rover)
	 echo "ROver"
	;;
	camera)
	 echo "camera"
	;;
	*)
	 echo $"Usage: $0 {all|rover|camera}"
esac
