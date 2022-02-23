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
grep -lR "10.0.0.42:2368" . | xargs sed -i 's/10.0.0.42:2368/debug.cadenkraft.com/g'
cd -
git add .
git commit -m "$date"
git config --global credential.helper store
git push -u origin master
