#!/bin/bash
date=$(date)

URL="cadenkraft.com" #Change this to your url
SERVERIP="10.0.0.222" #Change this to your server ip if ghost is on another machine

# this is needed or the find and replace script will ruin the filetypes inside the script shown in my documentation
PNG="png"
JPG="jpg"
JPEG="jpeg"
WEBP="webp"
AVIF="avif"

WWW="public"

git pull origin master
rm -r $WWW/content/renders
# mkdir $WWW
# cp no-border-light-ghost.css $WWW/
# cd $WWW
# echo $URL > CNAME
# cd -
ECTO1_SOURCE=http://$SERVERIP:2368 ECTO1_TARGET=https://$URL python3 ecto1.py
cd $WWW
echo n | cp -ipr /helium/ghost/ghost-backup/content/images/. content/images
cd -
IMGMSG="No image optimization was used"
while getopts ":o:" opt; do
  case $opt in
    o)
      arg_o="$OPTARG"
      echo "Option -o with argument: $arg_o"
      if [ $arg_o = "webp" ]; then
        echo 'Conversion to webp has started'
        sleep 1
        find $WWW/content/images/. -newer $WWW/content/images/optimg-webp.flag -type f -regex ".*\.\($JPG\|$JPEG\|$PNG\)" -exec mogrify -format webp {}  \; -print
        #find $WWW/content/images/. -type f -regex ".*\.\($JPG\|$JPEG\|$PNG\)" -exec rm {}  \; -print
        grep -lR ".$JPG" $WWW/ | xargs sed -i "s/\.$JPG/\.$WEBP/g"
        grep -lR ".$JPEG" $WWW/ | xargs sed -i "s/\.$JPEG/\.$WEBP/g"
        grep -lR ".$PNG" $WWW/ | xargs sed -i "s/\.$PNG/\.$WEBP/g"
        echo 'Conversion to webp has completed'
        IMGMSG="Images converted to webp"
        touch $WWW/content/images/optimg-webp.flag
      elif [ $arg_o = "avif" ]; then
        echo 'Conversion to avif has started'
        sleep 1
        find $WWW/content/images/. -newer $WWW/content/images/optimg-avif.flag -type f -regex ".*\.\($JPG\|$JPEG\|$PNG\)" -exec mogrify -format avif -depth 10 -alpha on -define heic:speed=8 {}  \; -print
        #find $WWW/content/images/. -type f -regex ".*\.\($JPG\|$JPEG\|$PNG\)" -exec mogrify -format avif -depth 10 -alpha on -define heic:speed=8 {}  \; -print
        #find $WWW/content/images/. -type f -regex ".*\.\($JPG\|$JPEG\|$PNG\)" -exec rm {}  \; -print
        grep -lR ".$JPG" $WWW/ | xargs sed -i "s/\.$JPG/\_o\.$AVIF/g"
        grep -lR ".$JPEG" $WWW/ | xargs sed -i "s/\.$JPEG/\_o\.$AVIF/g"
        grep -lR ".$PNG" $WWW/ | xargs sed -i "s/\.$PNG/\_o\.$AVIF/g"
        echo 'Conversion to avif has completed'
        IMGMSG="Images converted to avif"
        touch $WWW/content/images/optimg-avif.flag
      else
        echo 'Standard image optimization has started'
        sleep 1
        #credit goes to julianxhokaxhiu for these commands 
        find . -type f -iname "*.$PNG" -exec optipng -nb -nc {} \;
        find . -type f -iname "*.$PNG" -exec pngcrush -rem gAMA -rem alla -rem cHRM -rem iCCP -rem sRGB -rem time -ow {} \;
        find . -type f \( -iname "*.$JPG" -o -iname "*.$JPEG" \) -exec jpegoptim -f --strip-all {} \;
        echo 'Standard image optimization has completed'
        IMGMSG="Standard image optimization was used"
      fi
      ;;
    \?)
      echo "Invalid option: -$OPTARG"
      exit 1
      ;;
  esac
done
cd $WWW
cp -r /helium/ghost/ghost-backup/content/renders/. content/renders
cd -
git add .
git commit -m "Compiled Changes - $date | $IMGMSG" ghost-updater.sh ecto1.py requirements.txt README.md serve.py $WWW/.
git config --global credential.helper store
git push -u origin master





