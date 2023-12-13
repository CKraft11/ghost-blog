#!/bin/bash
# Improved as per feedback from @pascal - https://gist.github.com/julianxhokaxhiu/c0a8e813eabf9d6d9873#gistcomment-3086462
find docs/content/images/. -type f -iname "*.png" -exec optipng -nb -nc {} \;
#find docs/content/images/. -type f -iname "*.png" -exec advpng -z4 {} \;
find docs/content/images/. -type f -iname "*.png" -exec pngcrush -rem gAMA -rem alla -rem cHRM -rem iCCP -rem sRGB -rem time -ow {} \;
find docs/content/images/. -type f \( -iname "*.jpg" -o -iname "*.jpeg" \) -exec jpegoptim -f --strip-all {} \;