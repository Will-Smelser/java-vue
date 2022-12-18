# Setting Up
Because keeping npm and node and such all straignt I have started to always run this via a container.  So you need
Docker.

## Maven Required
This uses maven to build the and setup.  However you may want to initialize a vuejs project yourself before build.
If that is the case, then see the manual setup lower in the document.

```shell
$> mvn clean package
```

### What Happens...
The maven setup will perform the following:
1. Check if the Docker container exists
   1. Build container if the tag does not exist
   2. Run npm install
2. Run the vuejs build inside of container

## Connect to the container
```shell
$> export TAG=<maven property docker.tag.name>
$> docker run -v ${PWD}/vuejs/app:/app -v ${PWD}/resources/META-INF/resources:/app/dist -p 5731:5731 -it $TAG "/bin/bash"
```

# Manual Setup - Docker
The $TAG value is assumed to be the same value in the pom.xml properties for docker.tag.name

### Create the Image
```shell
$> docker build -t "$TAG" .
$> docker run -v ${PWD}/vuejs/app:/app v ${PWD}/resources/META-INF/resources:/app/dist "$TAG" "/bin/bash" -c "cd /app && npm install"
```

# Running Dev Server
```shell
$> export TAG=<maven property docker.tag.name>
$> docker run -v ${PWD}/vuejs/app:/app -v ${PWD}/resources/META-INF/resources:/app/dist -p 5731:5731 -it $TAG "/bin/bash"
root@08d639d4b912:/# cd /app
root@08d639d4b912:/app# npm run dev
```