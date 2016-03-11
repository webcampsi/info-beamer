#!/usr/bin/python
import socket, datetime

now = datetime.datetime.now()

since_midnight = (
    now - 
    now.replace(hour=0, minute=0, second=0)
).seconds

sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
sock.sendto('webcamp-2016/schedule/clock/set:%d' % since_midnight, ('127.0.0.1', 4444))
