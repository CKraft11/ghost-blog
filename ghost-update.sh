#!/bin/bash
date=$(date)
git pull origin master
rm -r docs
mkdir docs
cd docs
echo "blog.cadenkraft.com" > CNAME
cd -
ECTO1_SOURCE=http://10.0.0.42:2368 ECTO1_TARGET=https://blog.cadenkraft.com python3 ecto1.py
cd docs
docker cp ghost:/var/lib/ghost/content/images/. content/images
docker cp ghost:/var/lib/ghost/content/renders/. content/renders
cd -
grep -lR "srcset" docs/ | xargs sed -i 's/srcset/thisisbuggedatm/g'
git add .
git commit -m "$date"
git config --global credential.helper store
git push -u origin master
