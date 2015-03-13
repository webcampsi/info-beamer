#!/bin/bash
[ -f /boot/room ] && cp /boot/room /home/webcamp/info-beamer/webcamp-2015/schedule/room
nohup /home/webcamp/info-beamer-pi/info-beamer /home/webcamp/info-beamer/webcamp-2015 &
/home/webcamp/info-beamer/check-git.sh
