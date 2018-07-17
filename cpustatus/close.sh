#!/bin/bash
pid=$(ps aux|grep "/bin/bash ./cpustatus.sh"|grep -v grep| awk '{print$2}'| head -1)
kill -9 $pid
exit 0
