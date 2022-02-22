#!/bin/bash
date=$(date)
if [[ ! -d .git ]]
then
    echo ".git folder doesn't exist, creating git repository."
fi
sleep 2
git pull origin master 
rm -r docs 
mkdir docs
cd docs
echo "debug.cadenkraft.com" > CNAME
cd -
gssg --sourceDomain http://localhost:2367 --productionDomain http://debug.cadenkraft.com --dest docs
git add . 
git commit -m "$date" 
git config --global credential.helper store
git push -u origin master
