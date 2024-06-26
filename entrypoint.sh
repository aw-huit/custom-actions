#!/usr/local/bin/bash

LATEST_TAG=$1
MESSAGE=$2

if [[ "$LATEST_TAG" == '' ]]; then
    exit 0
fi
if [[ "$LATEST_TAG" =~ ^v(.*) ]]; then 
    NUM=${BASH_REMATCH[1]}; 
else 
    NUM=$LATEST_TAG
fi
if [[ "$MESSAGE" =~ '[major]' ]]; then
    NEW_TAG=$(echo $NUM | awk -F. -v OFS=. '{$1 += 1 ; $2 = 0; $3 = 0; print}')
elif [[ "$MESSAGE" =~ '[minor]' ]]; then
    NEW_TAG=$(echo $NUM | awk -F. -v OFS=. '{$2 += 1 ; $3 = 0; print}')
else
    NEW_TAG=$(echo $NUM | awk -F. -v OFS=. '{$3 += 1 ; print}')
fi

echo "v${NEW_TAG}" >> $GITHUB_OUTPUT
