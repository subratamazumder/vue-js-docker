##############################################
# usage e.g.; $publish-new-image.sh 5.0
##############################################
export IMAGE_TAG=$1
# build & tag image
echo "Building image with tag as"+$IMAGE_TAG
docker build -t dockersubrata/eprescription-demo-ui-image:$IMAGE_TAG .
# publish image to docker hub
echo "Publishing image with tag as"+$IMAGE_TAG
docker push dockersubrata/eprescription-demo-ui-image:$IMAGE_TAG
