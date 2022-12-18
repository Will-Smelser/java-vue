#!/bin/bash

TAG=$1

#if we are calling from pom.xml in extract-vue project
loc=src/main

#maybe we are calling script from this directory
if [[ $(pwd) == *main ]]; then
  loc=./
fi

echo "Changing to directory: ${loc}"
cd "$loc"

if [[ $(docker images -q "$TAG") == "" ]]; then
  echo "Building container for Node and Npm..."
  echo "docker build -t $TAG ."
  docker build -t "$TAG" .

  echo "Running npm install..."
  echo docker run -v ${PWD}/vuejs/app:/app -v${PWD}/resources/META-INF/resources/:/app/dist "$TAG" "/bin/bash" -c "cd /app && npm install"
  docker run -v ${PWD}/vuejs/app:/app -v${PWD}/resources/META-INF/resources/:/app/dist "$TAG" "/bin/bash" -c "cd /app && npm install"
fi

docker run -v ${PWD}/vuejs/app:/app -v${PWD}/resources/META-INF/resources/:/app/dist "$TAG" "/bin/bash" -c "cd /app && npm run build"

