#!/usr/bin/python
import sys, json, time

schedule = json.load(sys.stdin)

for item in schedule:
	start = time.strptime(item.get('nice_start'), "%H:%M")
	item['start'] = start.tm_hour * 3600 + start.tm_min * 60
	stop = time.strptime(item.get('nice_stop'), "%H:%M")
	item['stop'] = stop.tm_hour * 3600 + stop.tm_min * 60

# json.dump(schedule, ensure_ascii=False).encode('utf8')
print json.dumps(schedule, ensure_ascii=False, indent=4).encode('utf8')