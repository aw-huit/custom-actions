#!/bin/bash

LATEST_TAG=$(git describe --tags --abbrev=0)
MESSAGE=$(git log --format=%B -n 1)
if [[ "$MESSAGE" =~ '[major]' ]]; then
    NEW_TAG=$(echo $LATEST_TAG | awk -F. -v OFS=. '{$1 += 1 ; $2 = 0; $3 = 0; print}')
elif [[ "$MESSAGE" =~ '[minor]' ]]; then
    NEW_TAG=$(echo $LATEST_TAG | awk -F. -v OFS=. '{$2 += 1 ; $3 = 0; print}')
else
    NEW_TAG=$(echo $LATEST_TAG | awk -F. -v OFS=. '{$3 += 1 ; print}')
fi

echo "New tag: $NEW_TAG"
git tag $NEW_TAG
git push --tags
