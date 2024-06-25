#!/usr/local/bin/bash -x

# LATEST_TAG=$(git describe --tags --abbrev=0)
# MESSAGE=$(git log --format=%B -n 1)

echo $@
LATEST_TAG=$1
MESSAGE=$2
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

echo "$NEW_TAG"
# git tag $NEW_TAG
# git push --tags
