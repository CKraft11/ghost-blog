#!/bin/bash
date=$(date)
PNG="png"
JPG="jpg"
JPEG="jpeg"
WEBP="webp"
AVIF="avif"
JXL="jxl"
GIF="gif"
echo 'Conversion to webp/avif/jxl has started'
find /helium/ghost/ghost-backup/content/. -type f -regex ".*\.\($GIF)" -exec mogrify -format avif
find /helium/ghost/ghost-backup/content/. -type f -regex ".*\.\($JPG\|$JPEG\|$PNG\)" -exec mogrify -format webp {}  \; -print
find /helium/ghost/ghost-backup/content/. -type f -regex ".*\.\($JPG\|$JPEG\|$PNG\)" -exec mogrify -format jxl {}  \; -print
find /helium/ghost/ghost-backup/content/. -type f -regex ".*\.\($JPG\|$JPEG\|$PNG\)" -exec mogrify -format avif -depth 10 -alpha on -define heic:speed=8 {}  \; -print
echo 'Conversion to webp has completed'