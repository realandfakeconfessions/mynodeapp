#!/bin/bash
# Exit properly if something goes wrong
set -e 
set -o pipefail

# Create audio files with mozilla Text to Speech (TTS)
# The user writes the name of the file in txt format
# (which must be saved near this script) and then
# the script converts that file txt into a file.wav.

# If tts is not installed, exit the script and do nothing
tts=`command -v tts >/dev/null 2>&1 || { echo >&2 "Mozilla tts not found. Install it first."; exit 2; }`

parentPath=`pwd`

echo -n "Write the two letters of a language (English (en), Spanish (es), French (fr), Japanese (ja)): "
read LANGUAGE
echo "You wrote: $LANGUAGE"

echo "Write your file's name exactly as you saved it including the .txt extension: "
read fileName

# Remove the filename spaces
fileName2=`echo "$fileName" | sed 's/ //g'`
echo "File name without spaces: $fileName2"
# Remove the filename extension txt
fileNamenotxt="${fileName2/.txt/}"
echo "File renamed: $fileNamenotxt"

audios=$parentPath/audios
logs=$parentPath/logs
txtfiles=$parentPath/txtfiles

if [ ! -d "$audios" ] || [ ! -d "$audios"/"$LANGUAGE" ]; then
  echo "$audios does not exist."
  mkdir -vp $parentPath/audios
  mkdir -vp $parentPath/audios/"$LANGUAGE"
fi

if [ ! -d "$logs" ] || [ ! -d "$logs"/"$LANGUAGE" ]; then
  echo "$logs does not exist."
  mkdir -vp $parentPath/logs
  mkdir -vp $parentPath/logs/"$LANGUAGE"
fi

if [ ! -d "$txtfiles" ] || [ ! -d "$txtfiles"/"$LANGUAGE" ]; then
  echo "$txtfiles does not exist."
  mkdir -vp $parentPath/txtfiles
  mkdir -vp $parentPath/txtfiles/"$LANGUAGE"
fi

# Assign the model and vocoder
myModel=""
myVocoder=""

if [ "$LANGUAGE" == "en" ]; then
     echo "Your language is: English"
     myModel="tts_models/en/ljspeech/glow-tts"
     myVocoder="vocoder_models/en/ljspeech/multiband-melgan"
elif [ "$LANGUAGE" == "es" ]; then
     echo "Your language is: Spanish"
     myModel="tts_models/es/mai/tacotron2-DDC"
     myVocoder="vocoder_models/universal/libri-tts/fullband-melgan"
elif [ "$LANGUAGE" == "fr" ]; then
     echo "Your language is: French"
     myModel="tts_models/fr/mai/tacotron2-DDC"
     myVocoder="vocoder_models/universal/libri-tts/fullband-melgan"
elif [ "$LANGUAGE" == "ja" ]; then
     echo "Your language is: Japanese"
     myModel="tts_models/ja/kokoro/tacotron2-DDC"
     myVocoder="vocoder_models/universal/libri-tts/fullband-melgan"
else
     echo "Your language is invalid: "$LANGUAGE""
     LANGUAGE="unknown"
     myModel="tts_models/en/ljspeech/glow-tts"
     myVocoder="vocoder_models/universal/libri-tts/fullband-melgan"
     # failure, wrong parameter entered
     exit 1
fi

# Create a log by each audio created
logFile="$parentPath"/logs/"$LANGUAGE"/"$fileName2".log
exec > >(tee -i ${logFile}) 2>&1

# Read the file content
echo "Original name: $fileName"
echo "Current path: $parentPath"

fileExist="$parentPath"/txtfiles/"$fileName"

# Check if file is empty or doesn't exist
if [ ! -s "$fileExist" ] || [ ! -f "$fileExist" ]; then
     echo "Your file is empty or doesn't exist: "$fileExist""
     # failure, file empty or doesn't exist
     exit 2
else
     # Read the file's content and remove blank lines
     fileContent=$(grep '[^[:blank:]]' <"$parentPath"/txtfiles/"$LANGUAGE"/"$fileName")
     echo "Your file has something: $fileContent"
     echo "Model chosen: $myModel"
     echo "Vocoder chosen: $myVocoder"
     # Create a folder to save wav files
     mkdir -vp $parentPath/audios/"$LANGUAGE"/"$fileNamenotxt"
     # Begin while
     n=1
     while read line; do
     # Convert by Mozilla Text To Speech the text into an audio.wav
        tts --text "$line" \
            --model_name "$myModel" \
            --vocoder_name "$myVocoder" \
            --out_path "$parentPath"/audios/"$LANGUAGE"/"$fileNamenotxt"/"$n""$fileNamenotxt".wav
        n=$((n+1))
     done <<< "$fileContent"
     # End while
fi
echo "This script stopped in exit: $?"
# exit with success
exit 0
