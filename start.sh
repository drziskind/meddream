#!/bin/bash
sh -c /startCore.sh > startJavaCore.stdout.log 2> startJavaCore.stderr.log &
apache2-foreground > apache.stdout.log 2> apache.stderr.log
