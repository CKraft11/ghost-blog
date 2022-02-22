#!/bin/bash
date=$(date)
cd /home/radon_user/ghost git pull origin master 
rm -r /home/radon_user/ghost/docs 
sleep 2 
gssg --productionDomain https://debug.cadenkraft.com --dest docs 
sleep 2 
git add . 
sleep 2 
git commit -m "$date" 
sleep 2
git push -u origin master
