#!/bin/bash
date=$(date)
PNG="png"
JPG="jpg"
JPEG="jpeg"
WEBP="webp"
AVIF="avif"
echo 'Conversion to webp has started'
find public/content/images/. -type f -regex ".*\.\($JPG\|$JPEG\|$PNG\)" -exec mogrify -format webp {}  \; -print
find public/content/renders/. -type f -regex ".*\.\($JPG\|$JPEG\|$PNG\)" -exec mogrify -format webp {}  \; -print
echo 'Conversion to webp has completed'