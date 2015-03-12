import json
import arrow

schedule = json.loads(open('webcamp-2015/schedule/schedule.json').read())

date_format = '2015-03-12T{0}:00.0+01:00'

for item in schedule:
    nice_start = item.get('nice_start')
    item['start'] = arrow.get( date_format.format(nice_start) ).format('X')
    
    nice_stop = item.get('nice_stop')
    item['stop'] = arrow.get( date_format.format(nice_stop) ).format('X')

print json.dumps(schedule, indent=4)