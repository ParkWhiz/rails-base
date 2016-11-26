#!/bin/bash

echo "Which image would you like to build? (2.2.4, 2.3.2 or 2.3.3)?"
read ruby_version

if [ ! -d "ruby-$ruby_version" ]; then
  echo "Unknown version of Ruby: '$ruby_version'"
  exit
fi

cd "ruby-$ruby_version"

rails_base_next_version="${ruby_version}_`date +%Y%m%d%H%M%S`"
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
