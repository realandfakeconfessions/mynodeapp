#!/bin/bash

# This "!" simbol not allowed without the next line in a bash script
shopt -s extglob

# Exit properly if something goes wrong
set -e 
set -o pipefail

parentPath=/home/opalencia/GithubProjects/realconfessions/mynodeapp

mydir=`dir "$parentPath"/audios -1`

# Begin while
language=""
confession=""
while read line; do
    language=$line   
    if [ "$language" == "en" ]; then
      echo "Your language is: English ("$language")"
      mylist1=`dir "$parentPath"/audios/en -1`
      nwavs=0
      while read line; do
          confession=$line
          nwavs=`ls "$parentPath"/audios/"$language"/"$confession" | wc -l`
           if [ "$nwavs" -gt 1 ]; then
           mkdir -vp "$HOME"/.cmerged
           # Create a log by each audio created
           logFile="$HOME"/.cmerged/."$confession".log
           exec > >(tee -i ${logFile}) 2>&1
             echo "$confession""#wavs:""$nwavs"
             wavlist=`ls -A "$parentPath"/audios/"$language"/"$confession" | sort -n`
             while read line; do
                echo "file ""$parentPath"/audios/"$language"/"$confession"/"${line}"
             done <<< "$wavlist" > "$parentPath"/audios/"$language"/"$confession"/wavlist.txt
             /usr/local/bin/bin/ffmpeg -f concat -safe -0 -i "$parentPath"/audios/"$language"/"$confession"/wavlist.txt -c copy "$parentPath"/audios/"$language"/"$confession"/"$confession".wav
             cd "$parentPath"/audios/"$language"/"$confession" && rm -vf !("$confession".wav)
          fi
      done <<< "$mylist1"
    elif [ "$language" == "es" ]; then
      echo "Your language is: Spanish ("$language")"
      mylist2=`dir "$parentPath"/audios/es -1`
      nwavs=0
      while read line; do
          confession=$line
          nwavs=`ls "$parentPath"/audios/"$language"/"$confession" | wc -l`
          if [ "$nwavs" -gt 1 ]; then
          # Create a log by each audio created
          logFile="$HOME"/.cmerged/."$confession".log
          exec > >(tee -i ${logFile}) 2>&1
             echo "$confession""#wavs:""$nwavs"
             wavlist=`ls -A "$parentPath"/audios/"$language"/"$confession" | sort -n`
             while read line; do
                echo "file ""$parentPath"/audios/"$language"/"$confession"/"${line}"
             done <<< "$wavlist" > "$parentPath"/audios/"$language"/"$confession"/wavlist.txt
             /usr/local/bin/bin/ffmpeg -f concat -safe -0 -i "$parentPath"/audios/"$language"/"$confession"/wavlist.txt -c copy "$parentPath"/audios/"$language"/"$confession"/"$confession".wav
             cd "$parentPath"/audios/"$language"/"$confession" && rm -vf !("$confession".wav)
          fi
      done <<< "$mylist2"
    elif [ "$language" == "fr" ]; then
      echo "Your language is: French ("$language")"
      mylist3=`dir "$parentPath"/audios/fr -1`
      nwavs=0
      while read line; do
          confession=$line
          nwavs=`ls "$parentPath"/audios/"$language"/"$confession" | wc -l`
          if [ "$nwavs" -gt 1 ]; then
          # Create a log by each audio created
          logFile="$HOME"/.cmerged/."$confession".log
          exec > >(tee -i ${logFile}) 2>&1
             echo "$confession""#wavs:""$nwavs"
             wavlist=`ls -A "$parentPath"/audios/"$language"/"$confession" | sort -n`
             while read line; do
                echo "file ""$parentPath"/audios/"$language"/"$confession"/"${line}"
             done <<< "$wavlist" > "$parentPath"/audios/"$language"/"$confession"/wavlist.txt
             /usr/local/bin/bin/ffmpeg -f concat -safe -0 -i "$parentPath"/audios/"$language"/"$confession"/wavlist.txt -c copy "$parentPath"/audios/"$language"/"$confession"/"$confession".wav
             cd "$parentPath"/audios/"$language"/"$confession" && rm -vf !("$confession".wav)
          fi
      done <<< "$mylist3"
    elif [ "$language" == "ja" ]; then
      echo "Your language is: Japanese ("$language")"
      mylist4=`dir "$parentPath"/audios/ja -1`
      nwavs=0
      while read line; do
          confession=$line
          nwavs=`ls "$parentPath"/audios/"$language"/"$confession" | wc -l`
          if [ "$nwavs" -gt 1 ]; then
          # Create a log by each audio created
          logFile="$HOME"/.cmerged/."$confession".log
          exec > >(tee -i ${logFile}) 2>&1
             echo "$confession""#wavs:""$nwavs"
             wavlist=`ls -A "$parentPath"/audios/"$language"/"$confession" | sort -n`
             while read line; do
                echo "file ""$parentPath"/audios/"$language"/"$confession"/"${line}"
             done <<< "$wavlist" > "$parentPath"/audios/"$language"/"$confession"/wavlist.txt
             /usr/local/bin/bin/ffmpeg -f concat -safe -0 -i "$parentPath"/audios/"$language"/"$confession"/wavlist.txt -c copy "$parentPath"/audios/"$language"/"$confession"/"$confession".wav
             cd "$parentPath"/audios/"$language"/"$confession" && rm -vf !("$confession".wav)
          fi
      done <<< "$mylist4"
    else
      echo "Your language is invalid: "$language""
      exit 1
    fi
done <<< "$mydir"
# End while
echo "This script stopped in exit: $?"
# exit with success
exit 0
