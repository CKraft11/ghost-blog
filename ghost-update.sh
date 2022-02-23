#!/bin/bash
date=$(date)
git pull origin master
rm -r docs
mkdir docs
cd docs
echo "debug.cadenkraft.com" > CNAME
cd -
gssg --dest docs
cd docs/
docker cp ghost:/var/lib/ghost/content/images/. content/images
FIND="http://10.0.0.42"
REPLACE="https://debug.cadenkraft.com"
grep -lR $FIND . | xargs sed -i 's/$FIND/$REPLACE/g'
cd -
git add .
git commit -m "$date"
git config --global credential.helper store
git push -u origin master
