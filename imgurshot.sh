#!/bin/bash

function notify_uploaded() {
	str="\"$1\""
	echo $1 | pbcopy
	osascript -e 'display notification'$str'with title "Uploaded and copied to clipboard"'
}
function screenshot() {
    echo "Select a window"
    shot_command='screencapture -s '$name
    shot=$($shot_command)
    url='https://api.imgur.com/3/upload'
    response=$(curl -s -F "image=$(base64 $name)" -H "Authorization: Client-ID xxxxxxxxxxx" $url) 
    if [[ $response == *success* ]]; then
		link=$( echo $response | python -c 'import json,sys;obj=json.load(sys.stdin);print obj["data"]["link"]')
		echo $link
		notify_uploaded $link
	else
		echo "Failed"
	fi
}


exten=".jpg"
direc="${HOME}/Desktop/"
concat=$direc$(date)$exten
name=${concat// /_}
screenshot $name

