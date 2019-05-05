#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
'''
Generic Python frame program
'''
#
# Standard Imports
#
from __future__ import absolute_import, division, print_function, unicode_literals
import argparse
from datetime import date, datetime
import json
import logging
import os
try:
    from pathlib import Path
except ModuleNotFoundError:
    from pathlib2 import Path
import sys
#
# Non-standard imports
#


#
# You might need this to better handle utf8 characters
# https://stackoverflow.com/questions/21129020/how-to-fix-unicodedecodeerror-ascii-codec-cant-decode-byte#21190382
# pylint: disable=undefined-variable,no-member,broad-except
try:
    reload(sys)
    sys.setdefaultencoding('utf8')
except Exception:
    pass
#
# Ensure ./lib is in the lib path for local includes
#
LIB_PATH = Path(__file__).resolve().parent / 'lib'
sys.path.append(str(LIB_PATH))
#
# pylint: disable=wrong-import-position
# local directory imports here
#


#
###############################################################################
#
# Global variables
#
DEFAULT_LOG_LEVEL = os.environ.get('PY_LOG_LEVEL', 'WARNING')
FAILURE_ARN = os.environ.get('SNS_FAILURE_ARN', None)

DESCRIPTION = "This is the Python frame program"


#
###############################################################################
#
# _clean_loggers()
#
def _clean_loggers():
    '''Remove existing logging handlers (mostly for Lambda)'''
    root = logging.getLogger()
    if root.handlers:
        for handler in root.handlers:
            root.removeHandler(handler)
    # try this here
    logging.basicConfig(format='%(asctime)s %(levelname)s:%(name)s.%(funcName)s:%(message)s',
                        level=getattr(logging, DEFAULT_LOG_LEVEL))


#
###############################################################################
#
# _except_hook()
#
def _except_hook(exctype, value, traceback): # pylint: disable=unused-argument
    import traceback as tb
    message = "I had a problem: \n\n{}".format(''.join(tb.format_exception(None, value, traceback)))
    _get_logger().error(message)

    # If an SNS topic is configured for error notification: send a message
    if FAILURE_ARN:
        try:
            from Aws.sns import Sns
            subject = "ERROR for: {}".format(Path(__file__).resolve().name)
            sns = Sns(topic_arn=FAILURE_ARN)
            sns.publish_message(message=message, subject=subject)
        except: # pylist: disable=bare-except
            pass

sys.excepthook = _except_hook


#
###############################################################################
#
# _get_logger()
#
def _get_logger():
    '''
    Reusable code to get the correct logger by name of current file

    Returns:
        logging.logger: Instance of logger for name of current file

    '''
    return logging.getLogger(Path(__file__).resolve().name)


#
###############################################################################
#
# _json_dump() - Little output to DRY
#
def _json_dump(the_thing, pretty=False):
    '''
    Reusable JSON dumping code

    Returns:
        str: JSON string representation suitable for print'ing
    '''
    output = None
    if pretty:
        output = json.dumps(the_thing, default=_json_serial, sort_keys=True, indent=4,
                            separators=(',', ': '))
    else:
        output = json.dumps(the_thing, default=_json_serial)
    return output

def _json_serial(obj):
    '''JSON serializer for objects not serializable by default json code'''

    if isinstance(obj, (datetime, date)):
        return obj.isoformat()
    raise TypeError("Type %s not serializable" % type(obj))


#
###############################################################################
#
# handle_arguments()
#
def handle_arguments():
    '''
    Handle CLI arguments

    Returns:
        parser.Namespace: Representation of the parsed arguments
    '''
    #
    # Handle CLI args
    #
    parser = argparse.ArgumentParser(description=DESCRIPTION)

    # add arguments
    parser.add_argument('-l', '--log-level', action='store', required=False,
                        choices=["debug", "info", "warning", "error", "critical"],
                        default=DEFAULT_LOG_LEVEL,
                        help='Logging verbosity. Default: %(default)s')

    return parser.parse_args()


#
###############################################################################
#
# main()
#
def main():
    '''Do the work'''

    args = handle_arguments()

    # Configure logging
    logging.basicConfig(format='%(asctime)s %(levelname)s:%(name)s.%(funcName)s:%(message)s',
                        level=getattr(logging, args.log_level.upper()))

    logger = _get_logger()

    logger.info("Log level is '%s'", args.log_level.upper())


#
###############################################################################
#
# Call the main function
#
if __name__ == '__main__':
    main()
