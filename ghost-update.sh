#!/bin/bash
date=$(date)
cd /home/radon_user/ghost/docs
echo "debug.cadenkraft.com" > CNAME
cd /home/radon_user/ghost
git pull origin master 
rm -r /home/radon_user/ghost/docs 
gssg --sourceDomain http://localhost:2367 --productionDomain http://debug.cadenkraft.com --dest docs
git add . 
git commit -m "$date" 
git config --global credential.helper store
git push -u origin master
