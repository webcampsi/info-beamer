#!/bin/bash
[ -f /boot/config/no-run ] && exit
[ -f /boot/config/room.txt ] && cp /boot/config/room.txt /srv/info-beamer/webcamp-2017/schedule/room
nohup /home/webcamp/info-beamer-pi/info-beamer /srv/info-beamer/webcamp-2017 &
/srv/info-beamer/check-git.sh
