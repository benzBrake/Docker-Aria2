#!/bin/sh
# set timezone
ln -sf /usr/share/zoneinfo/$TZ /etc/localtime
# create directory
mkdir -pv /data/aria2/config /data/aria2/downloads
# create default configfile

cd /data
if [[ ! -e /data/aria2/config/aria2.conf ]]; then
    cp aria2.conf /data/aria2/config/aria2.conf
fi
if [[ ! -e /data/aria2/config/aria2.session ]]; then
    touch /data/aria2/config/aria2.session
fi
# update tracker
if [[ ${UPDATE_TRACKER} == "true" ]]; then
	/data/tracker.sh 2>&1
	crontab -u root -l 2>/dev/null | { cat; echo -e "0\t0\t*\t*\t*\tsh /data/tracker.sh 2>&1"; } | crontab -u root -
	crond
fi
# run aria2
echo "Starting aria2c"
su-exec $PUID:$PGID aria2c \
    --conf-path=/data/aria2/config/aria2.conf \
  > /dev/stdout \
2 > /dev/stderr
echo 'Exiting aria2'