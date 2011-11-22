#! /bin/sh
### BEGIN INIT INFO
# Provides:          lets-fcgi
# Required-Start:    $local_fs $remote_fs
# Required-Stop:     $local_fs $remote_fs
# Default-Start:     2 3 4 5
# Default-Stop:      S 0 1 6
# Short-Description: lets FastCGI daemon
# Description:       FCGI Daemon
### END INIT INFO

# Author: Artem Poluhovich <nergalic@ya.ru>

. /etc/rc.d/init.d/functions

lockfile=/var/lock/subsys/lets

DESC="LETs FastCGI daemon"
NAME=__PKGNAME__-fcgi
PYTHON=/usr/bin/python
PIDFILE=/tmp/__PKGNAME__.pid

USER="nginx"

METHOD=prefork
MINSPARE=2
MAXSPARE=3
MAXCHILDREN=7
MAXREQUESTS=1000
SOCKET=/tmp/__PKGNAME__.sock

DAEMON=/var/www/__PKGNAME__/manage.py
DAEMON_ARGS="runfcgi socket=$SOCKET daemonize=true \
	    pidfile=$PIDFILE \
	    minspare=$MINSPARE maxspare=$MAXSPARE maxchildren=$MAXCHILDREN maxrequests=$MAXREQUESTS \
	    method=$METHOD"

[ -x "$DAEMON" ] || exit 0

start()
{
    echo "Starting $NAME: "
    daemon --user $USER $PYTHON $DAEMON $DAEMON_ARGS
    retval=$?
    [ $retval -eq 0 ] && touch $lockfile
    return $retval
}

stop() {
    echo -n $"Stopping $NAME: "
    [ -x $PIDFILE ] || exit 0
    PID=$(cat $PIDFILE)
    kill -9 $PID
    retval=$?
    [ $retval -eq 0 ] && rm -f $lockfile
    return $retval
}

restart() {
    stop
    start
}

case "$1" in
    start)
        $1
        ;;
    stop)
        $1
        ;;
    restart)
        $1
        ;;
    condrestart)
        [ -f $lockfile ] && restart || :
        ;;
    status)
        status django_fcgi
        ;;
    *)
        echo $"Usage: $0 {start|stop|restart|condrestart|status}"
        exit 2
esac

exit $?