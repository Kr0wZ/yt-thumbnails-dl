#!/bin/bash

#Simply specify URL with -u 
#Or specifiy a file containing one or several URLs
#Verify if the file exists
#For each line in the file, try to grab the thumbnail. If not possible skip it to the next


print_help(){
	echo "Usage: $0 [-f FILE] [-u YTB_URL]"
	echo "-f: File containing one or several Youtube URLs"
	echo "-u: Single Youtube URL"
	echo
	exit
}

if [[ $# == 0 ]]
then
	print_help
	exit
fi

while getopts u:f:h OPT
do
    case "$OPT" in
        h) print_help ;;
		u) URL="$OPTARG" ;;
		f) FILE="$OPTARG" ;;
        ?) print_help ;;
    esac
done

if [[ -n "${URL}" ]] && [[ -n "${FILE}" ]]
then
    echo "Can't use both arguments -f and -u"
    print_help
    exit
fi

#Get the video's ID
get_video_id(){
	ID=$(echo "$1"|cut -d '/' -f4|cut -d '=' -f2)
}


#If file exists then loop over it's content
if [[ -n "$FILE" ]]
then
	if [[ -f "$FILE" ]]
	then
	    while read LINE
	    do
	    	[[ "$LINE" =~ ^(http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]youtube+)\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$ ]] || continue
	    	get_video_id "$LINE"
	    	curl -s "https://i.ytimg.com/vi/$ID/maxresdefault.jpg" -o "$ID.jpg"
	    done < "$FILE"
	else
		echo "File $FILE doesn't exist"
		exit
	fi
#else simply download the thumbnail
else
	[[ "$URL" =~ ^(http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]youtube+)\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$ ]] || (echo "$URL is not a valid Youtube URL" && exit)
	get_video_id "$URL"
	curl -s "https://i.ytimg.com/vi/$ID/maxresdefault.jpg" -o "$ID.jpg"
fi
