#!/bin/bash
date=$(date) 
cd /home/radon_user/docs/static 
git pull origin master 
cd /home/radon_user/docs/
sleep 5 
gssg --productionDomain https://debug.cadenkraft.com
cd /home/radon_user/docs/static 
sleep 5 
git add . 
sleep 2 
git commit -m "$date" 
sleep 2
git push -u origin master
