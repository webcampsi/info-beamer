#!/bin/bash

cd /srv/info-beamer

REMOTE=$(git ls-remote git@github.com:webcampsi/info-beamer.git master | cut -f1)
LOCAL=$(git rev-parse origin/master)

if [ "${REMOTE}" != "${LOCAL}" ]; then
	git pull > /dev/null 2>&1
	cat schedule.json | ./fix-schedule.py > webcamp-2016/schedule/_schedule.json
	mv webcamp-2016/schedule/_schedule.json webcamp-2016/schedule/schedule.json
fi

if [ ! -f webcamp-2016/schedule/schedule.json ]; then
	cat schedule.json | ./fix-schedule.py > webcamp-2016/schedule/_schedule.json
	mv webcamp-2016/schedule/_schedule.json webcamp-2016/schedule/schedule.json
fi
