#!/bin/bash -xe

WEBSITE_PATH=$1

if [ "${WEBSITE_PATH}" == "" ]; then
  echo "Usage: ./add-blog-to-website.sh ../mywebsite/"
  exit 1
fi

# Remove the old blog folder
rm -rf "${WEBSITE_PATH}/blog"

# Copy the blog folder into the checked out website repo
cp -r ./public/ "${WEBSITE_PATH}/blog"
