#!/bin/ash
sh -c /startCore.sh > startJavaCore.stdout.log 2> startJavaCore.stderr.log &
httpd -D FOREGROUND > apache.stdout.log 2> apache.stderr.log
ash
