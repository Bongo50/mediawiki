#!/bin/bash
apache2-foreground
/usr/local/bin/mwjobrunner.sh  > /home/logs/jobQueue.txt 2>&1