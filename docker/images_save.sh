#!/bin/bash
images=$(docker images --format "{{.Repository}}:{{.Tag}}")
for image in ${images} ;
do
  imageName=$(echo ${image} |cut -d : -f 1 |awk -F "/" '{print $NF}')
  docker save -o $imageName.tar $image
done
