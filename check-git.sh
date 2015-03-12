#!/bin/bash
cd /home/goranb/info-beamer
if [ -f webcamp-2015/schedule/schedule.json ]; then
	git fetch -v --dry-run 2>&1 |
		grep -qE "\[up\s+to\s+date\]\s+$(
			git branch 2>/dev/null |
				sed -n '/^\*/s/^\* //p' |
					sed -r 's:(\+|\*|\$):\\\1:g'
		)\s+" || {
			git pull > /dev/null 2>&1
			cat schedule.json | ./fix-schedule.py > webcamp-2015/schedule/_schedule.json
			mv webcamp-2015/schedule/_schedule.json webcamp-2015/schedule/schedule.json
	}
else
	git pull > /dev/null 2>&1
	cat schedule.json | ./fix-schedule.py > webcamp-2015/schedule/_schedule.json
	mv webcamp-2015/schedule/_schedule.json webcamp-2015/schedule/schedule.json
fi
