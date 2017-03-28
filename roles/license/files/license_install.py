#!/usr/bin/python

from vspk import v4_0 as vspk
import argparse

def setup_logging():
    import logging
    from vspk.utils import set_log_level
    set_log_level(logging.DEBUG, logging.StreamHandler())

def start_csproot_session():
    session = vspk.NUVSDSession(
        username=args.cspuser,
        password=args.passwd,
        enterprise=args.org,
        api_url="https://%s:8443" % args.vsd_ip)
    try:
        session.start()
    except:
        logging.error('Failed to start the session')
    return session.user

parser = argparse.ArgumentParser()
parser.add_argument('cspuser', type=str)
parser.add_argument('passwd', type=str)
parser.add_argument('org', type=str)
parser.add_argument('vsd_ip', type=str)
parser.add_argument('license_key', type=str)
args =  parser.parse_args()

csp_session = start_csproot_session()

try:
   license = vspk.NULicense(license=args.license_key)
   csp_session.create_child(license)
   print "success"

except Exception as e:
   msg = "Exception is:\n %s \n" % e
   print msg
