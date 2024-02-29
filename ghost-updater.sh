#!/bin/bash
date=$(date)
git pull origin master
rm -r docs
mkdir docs
cp no-border-light-ghost.css docs/
cd docs
echo "cadenkraft.com" > CNAME
cd -
ECTO1_SOURCE=http://10.0.0.222:2368 ECTO1_TARGET=https://cadenkraft.com python3 ecto1.py
cd docs
cp -r /helium/ghost/ghost-backup/content/images/. content/images
cd -
grep -lR "srcset=" docs/ | xargs sed -i 's/srcset=/thisisbuggedatm=/g'
IMGMSG="No image optimization was used"
while getopts ":o:" opt; do
  case $opt in
    o)
      arg_o="$OPTARG"
      echo "Option -o with argument: $arg_o"
      if [ $arg_o = "webp" ]; then
        echo 'Conversion to webp has started'
        sleep 1
        find docs/content/images/. -type f -regex ".*\.\(jpg\|jpeg\|png\)" -exec mogrify -format webp {}  \; -print
        find docs/content/images/. -type f -regex ".*\.\(jpg\|jpeg\|png\)" -exec rm {}  \; -print
        grep -lR ".jpg" docs/ | xargs sed -i 's/.jpg/.webp/g'
        grep -lR ".jpeg" docs/ | xargs sed -i 's/.jpeg/.webp/g'
        grep -lR ".png" docs/ | xargs sed -i 's/.png/.webp/g'
        echo 'Conversion to webp has completed'
        IMGMSG="Images converted to webp"
      else
        echo 'Standard image optimization has started'
        sleep 1
        #credit goes to julianxhokaxhiu for these commands 
        find . -type f -iname "*.png" -exec optipng -nb -nc {} \;
        find . -type f -iname "*.png" -exec pngcrush -rem gAMA -rem alla -rem cHRM -rem iCCP -rem sRGB -rem time -ow {} \;
        find . -type f \( -iname "*.jpg" -o -iname "*.jpeg" \) -exec jpegoptim -f --strip-all {} \;
        echo 'Standard image optimization has completed'
        IMGMSG="Normal image optimization was used"
      fi
      ;;
    \?)
      echo "Invalid option: -$OPTARG"
      exit 1
      ;;
  esac
done
cd docs
cp -r /helium/ghost/ghost-backup/content/renders/. content/renders
cd -
git add .
git commit -m "Compiled Changes - $date | $IMGMSG" ghost-updater.sh ecto1.py requirements.txt README.md serve.py docs/.
git config --global credential.helper store
git push -u origin master




