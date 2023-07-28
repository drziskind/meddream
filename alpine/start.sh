#!/bin/ash
sh -c /startCore.sh >> /logs/startJavaCore.stdout.log 2>> /logs/startJavaCore.stderr.log &
rm /run/apache2/httpd.pid
httpd -D FOREGROUND >> /logs/apache.stdout.log 2>> /logs/apache.stderr.log
ash
