#!/bin/bash
date=$(date)
git pull origin master
rm -r docs
mkdir docs
cd docs
echo "cadenkraft.com" > CNAME
cd -
ECTO1_SOURCE=http://10.0.0.222:2368 ECTO1_TARGET=https://cadenkraft.com python3 ecto1.py
cd docs
cp -r /helium/ghost/content/images/. content/images
cp -r /helium/ghost/content/renders/. content/renders
cd -
grep -lR "srcset=" docs/ | xargs sed -i 's/srcset=/thisisbuggedatm=/g'
bash ./image_optimizer.sh
git add .
git commit -m "Compiled Changes - $date" ghost-updater.sh ecto1.py requirements.txt README.md serve.py docs/.
git config --global credential.helper store
git push -u origin master
