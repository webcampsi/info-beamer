#!/usr/bin/python
import json
import arrow

schedule = json.loads(open('webcamp-2015/schedule/schedule.json').read())
for item in schedule:
    start = arrow.get(item.get('start'))
    item['start'] = start.replace(days=+1).format('X')
    
    end = arrow.get(item.get('end'))
    item['end'] = end.replace(days=+1).format('X')

print json.dumps(schedule)
