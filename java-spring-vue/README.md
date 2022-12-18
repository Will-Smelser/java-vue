# Why?
Setting a java project that plays well with a modern javascript build is always a little bit of a pain.  
This is my take on how to do this.

## Maven Module - vue-js
This is a basic javascript project that builds the outputs to *resources/META-INF/resources*.  This is because that
is what java requires to be available as an external dependency.

### Docker - Node / Npm
To support building, there is a Dockerfile that gives you a basic node container for building your front end
app within.  This prevents having issues with npm versions.  Yeah, other solutions, but this is pretty straight forward.

### Developing your Javascript
You have to enter the Docker container and run the "npm run dev" command.

```shell
$> export TAG=<maven property docker.tag.name>
$> docker run -v ${PWD}/vuejs/app:/app -v ${PWD}/resources/META-INF/resources:/app/dist -p 5731:5731 -it $TAG "/bin/bash"
root@08d639d4b912:/# cd /app
root@08d639d4b912:/app# npm run dev
```
