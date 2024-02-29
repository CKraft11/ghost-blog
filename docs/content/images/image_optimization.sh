#!/bin/bash
# Improved as per feedback from @pascal - https://gist.github.com/julianxhokaxhiu/c0a8e813eabf9d6d9873#gistcomment-3086462
find . -type f -iname "*.webp=" -exec opt.webp= -nb -nc {} \;
#find . -type f -iname "*.webp=" -exec ad.webp= -z4 {} \;
find . -type f -iname "*.webp=" -exec.webp=crush -rem gAMA -rem alla -rem cHRM -rem iCCP -rem sRGB -rem time -ow {} \;
find . -type f \( -iname "*.webp=" -o -iname "*.webp=" \) -exec.webp=optim -f --strip-all {} \;