#!/bin/sh
tracker=$(curl -s -L 'https://raw.githubusercontent.com/ngosang/trackerslist/master/trackers_all.txt' | sed '/^\s*$/d' | tee /data/aria2/tracker | tr '\n' ',')
sed -i "s@^\(bt-tracker=\).*@\1${tracker}@" /data/aria2/config/aria2.conf