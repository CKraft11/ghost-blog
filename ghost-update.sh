#!/bin/bash
date=$(date)
cd /home/radon_user/ghost 
git pull origin master 
rm -r /home/radon_user/ghost/docs 
sleep 2 
gssg --sourceDomain http://localhost:2367 --productionDomain http://debug.cadenkraft.com --dest docs
sleep 2 
git add . 
git update-index --assume-unchanged CNAME
sleep 2 
git commit -m "$date" 
git config --global credential.helper store
sleep 2
git push -u origin master
