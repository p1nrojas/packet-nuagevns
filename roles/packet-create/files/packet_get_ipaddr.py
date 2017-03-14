#!/usr/bin/python

import packet
import argparse

parser = argparse.ArgumentParser()
parser.add_argument('project_id', type=str)
parser.add_argument('auth_token', type=str)
parser.add_argument('device_name', type=str)
args =  parser.parse_args()

try:
   manager = packet.Manager(auth_token=args.auth_token)
   params = {
    'per_page': 50
   }

   devices = manager.list_devices(project_id=args.project_id, params = params)
   lst_devices = [device.hostname for device in devices]
   if args.device_name not in lst_devices:
      print "Error: the device %s is not present" % args.device_name
      exit()
   for device in devices:
      if device.hostname == args.device_name:
          print(device.ip_addresses[2]['address'])

except Exception as e:
   msg = "Exception is:\n %s \n" % e
   print msg
