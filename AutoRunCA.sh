#!/bin/bash

runornot=`ps aux | grep -i "CreateAudios.sh" | grep -v "grep" | wc -l`

if [ "$runornot" = 0 ]; then
   echo "Script not running"
   source /home/opalencia/GithubProjects/realconfessions/mynodeapp/RunCreateAudios.sh
else
   echo "Script running"
fi
