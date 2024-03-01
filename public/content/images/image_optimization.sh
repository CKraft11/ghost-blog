#!/bin/bash
# Improved as per feedback from @pascal - https://gist.github.com/julianxhokaxhiu/c0a8e813eabf9d6d9873#gistcomment-3086462
find . -type f -iname "*.webp" -exec optipng -nb -nc {} \;
#find . -type f -iname "*.webp" -exec advpng -z4 {} \;
find . -type f -iname "*.webp" -exec pngcrush -rem gAMA -rem alla -rem cHRM -rem iCCP -rem sRGB -rem time -ow {} \;
find . -type f \( -iname "*.webp" -o -iname "*.webp" \) -exec jpegoptim -f --strip-all {} \;