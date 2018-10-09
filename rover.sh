case "$1" in 
    start)
     ./start.sh "$2"
     ;;
    stop)
     ./stop.sh "$2"
     ;;
    *)
     echo $"Usage: $0 {start|stop}"
     exit 1
esac
