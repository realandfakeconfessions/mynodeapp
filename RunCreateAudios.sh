#!/bin/bash
# Exit properly if something goes wrong
set -e 
set -o pipefail

parentPath=/home/opalencia/GithubProjects/realconfessions/backend/mynodeapp

mydir=`dir "$parentPath"/txtfiles -1`

# Begin while
language=""
confession=""
while read line; do
    language=$line
    #echo "$language"
    if [ "$language" == "en" ]; then
      echo "Your language is: English ("$language")"
      mylist1=`dir "$parentPath"/txtfiles/en -1`
      haveconf1=`dir "$parentPath"/txtfiles/en -1 | wc -l`
      if [ "$haveconf1" -gt 0 ]; then
         while read line; do
            confession=$line
            source "$parentPath"/CreateAudios.sh "$language" "$confession"
         done <<< "$mylist1"
      fi
    elif [ "$language" == "es" ]; then
      echo "Your language is: Spanish ("$language")"
      mylist2=`dir "$parentPath"/txtfiles/es -1`
      haveconf2=`dir "$parentPath"/txtfiles/es -1 | wc -l`
      if [ "$haveconf2" -gt 0 ]; then
         while read line; do
           confession=$line
           source "$parentPath"/CreateAudios.sh "$language" "$confession"
         done <<< "$mylist2"
      fi
    elif [ "$language" == "fr" ]; then
      echo "Your language is: French ("$language")"
      mylist3=`dir "$parentPath"/txtfiles/fr -1`
      haveconf3=`dir "$parentPath"/txtfiles/fr -1 | wc -l`
      if [ "$haveconf3" -gt 0 ]; then
         while read line; do
           confession=$line
           source "$parentPath"/CreateAudios.sh "$language" "$confession"
         done <<< "$mylist3"
      fi
    elif [ "$language" == "ja" ]; then
      echo "Your language is: Japanese ("$language")"
      mylist4=`dir "$parentPath"/txtfiles/ja -1`
      haveconf4=`dir "$parentPath"/txtfiles/ja -1 | wc -l`
      if [ "$haveconf4" -gt 0 ]; then
         while read line; do
           confession=$line
           source "$parentPath"/CreateAudios.sh "$language" "$confession"
         done <<< "$mylist4"
      fi
    else
      echo "Your language is invalid: "$language""
      exit 1
    fi
done <<< "$mydir"
# End while
echo "This script stopped in exit: $?"
# exit with success
exit 0
