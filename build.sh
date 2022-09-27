#!/bin/bash

echo "Which image would you like to build? (e.g. 2.3.7, 2.3.7-circleci, greenlight-cinc-22)?"
read name

dir_name="$name"
if [ ! -d "$dir_name" ]; then
  dir_name="ruby-$name"
  if [ ! -d "$dir_name" ]; then
    echo "Unknown version of Ruby or container: '$name'"
    exit
  fi
fi

cd "$dir_name"

rails_base_next_version="${name}_`date +%Y%m%d%H%M%S`"
echo "Building rails-base for tag $rails_base_next_version"
docker build -t parkwhiz/rails-base:$rails_base_next_version .

if [ $? -ne 0 ]; then
  echo
  echo "It looks like there may have been an error building the image ¯\_(ツ)_/¯"
else
  echo
  echo "Build finished. If everything looks good, push it up to Docker Hub with:"
  echo "  docker push parkwhiz/rails-base:$rails_base_next_version"
fi
