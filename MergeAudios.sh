#!/bin/bash
# Exit properly if something goes wrong
set -e 
set -o pipefail

mydir=`dir audios -1`

# Begin while
language=""
confession=""
while read line; do
    language=$line
    #echo "$language"
    if [ "$language" == "en" ]; then
      echo "Your language is: English ("$language")"
    elif [ "$language" == "es" ]; then
      echo "Your language is: Spanish ("$language")"
      mylist1=`dir audios/es -1` #&& echo "$mylist1"
      nwavs=0
      while read line; do
          confession=$line
          nwavs=`ls audios/"$language"/"$confession" | wc -l`
          #echo "$confession""|nwavs:""$nwavs"
          if [ "$nwavs" -gt 1 ]; then
             echo "$confession""|nwavs:""$nwavs"
          fi
      done <<< "$mylist1"
    elif [ "$language" == "fr" ]; then
      echo "Your language is: French ("$language")"
    elif [ "$language" == "ja" ]; then
      echo "Your language is: Japanese ("$language")"
    else
      echo "Your language is invalid: "$language""
      exit 1
    fi
done <<< "$mydir"
# End while
echo "$language"
echo "This script stopped in exit: $?"
# exit with success
exit 0
