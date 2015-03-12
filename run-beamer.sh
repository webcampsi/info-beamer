#!/bin/bash
[ -f /boot/room ] && cat /boot/room > /home/goranb/info-beamer/webcamp-2015/schedule/room
nohup /opt/info-beamer-pi/info-beamer /home/goranb/info-beamer/webcamp-2015 &
