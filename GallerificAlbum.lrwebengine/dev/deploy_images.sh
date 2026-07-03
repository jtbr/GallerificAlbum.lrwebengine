#!/bin/bash
##################################################################################################
# Compresses and then deploys images to lightroom
# Intended to be used as an export action from within Lightroom.
# To install in windows with cygwin:
# 1) Run regedit.exe and find Computer\HKEY_CLASSES_ROOT\Applications\bash.exe\shell\open\command and set the reg_sz data to "C:\Cygwin\bin\mintty.exe" /bin/bash -li "%1" %*", correcting paths as necessary.
# 2) Choose bash.exe as the default action for .sh files: (right click, open with, choose default program)
# 3) Place this file in the Export Actions folder under Lightroom. Users\AppData\Roaming\Lightroom\
# 4) Create an export within lightroom and choose deploy_images as the postprocessing action
#
# I use it to export panoramas with 1024 min height for fullsize images and sometimes to update changed images. 
###################################################################################################
if [[ $# -eq 0 ]]; then 
echo "USAGE: deploy_images.sh  <imageName> ... <imageName>"
sleep 4
exit
fi

read -p "Where on S3 do you wish to place these images? (eg, s3://mybucket/gallerific/im/fl/) " -e S3_URL
echo Images will be placed in $S3_URL .

for fn in "$@"
do
  unixfn=$(cygpath -u "$fn")
  djpeg "$fn" | cjpeg -quality 72 > "${fn}.tmp"
  mv "${unixfn}.tmp" "$unixfn"
  s3cmd put --acl-public -rr --add-header="Cache-Control":"public,max-age 86400" --guess-mime-type --signature-v2 "$unixfn" $S3_URL
done

sleep 5