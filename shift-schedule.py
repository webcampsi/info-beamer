import time
import json

f = open('webcamp-2015/schedule/schedule.json', 'wb')
schedule = json.loads(f.read())

for item in schedule:
    start = item.get('nice_start')
    item['start'] = time.mktime(time.strptime(time.strftime("%d.%m.%Y") + " " + start, "%d.%m.%Y %H:%M"))

    end = item.get('nice_stop')
    item['stop'] = time.mktime(time.strptime(time.strftime("%d.%m.%Y") + " " + end, "%d.%m.%Y %H:%M"))


f.write(json.dumps(schedule, indent=4))
f.close()