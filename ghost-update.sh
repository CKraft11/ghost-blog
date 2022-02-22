#!/bin/bash
date=$(date)
cd /home/radon_user/ghost 
echo "debug.cadenkraft.com" > CNAME
git pull origin master 
rm -r /home/radon_user/ghost/docs 
gssg --sourceDomain http://localhost:2367 --productionDomain http://debug.cadenkraft.com --dest docs
git add . 
git update-index --assume-unchanged CNAME
git checkout CNAME
git commit -m "$date" 
git config --global credential.helper store
git push -u origin master
