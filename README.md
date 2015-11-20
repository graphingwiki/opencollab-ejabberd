[![Circle CI](https://circleci.com/gh/abusesa/opencollab-ejabberd.svg?style=shield)](https://circleci.com/gh/abusesa/opencollab-ejabberd)

## Running the Dockerized build manually

### (Required for OS X) Initialize Docker Machine

If you are in a non-Linux environment (e.g. OS X) then you need a VM to run Docker containers in. Install [Docker Toolbox](https://www.docker.com/docker-toolbox) which provides a set of tools for just that.

Create the Docker Machine default VM if you haven't already. You can use the ```--virtualbox-no-share``` option, telling ```docker-machine``` *not* to share your whole ```/Users``` directory inside the created VM. These instructions will work regardless.

```
$ docker-machine create --driver=virtualbox --virtualbox-no-share default
```

Upon completion the command will instruct you in setting up your environment.

### Create the build image

Create a Docker image ```build-image``` from which a container can be launched. The blueprints can be found from the file ```Dockerfile```.

```
$ docker build -t build-image .
```

This may take a moment or two.

### The the build script in a container

Now you can run the build script which has been copied inside ```build-image```, along with the other necessary files.

```
$ docker run -ti --name build-container build-image
```

The above command launches a container called ```build-container```, based on ```build-image```, and runs the build script inside the container.

### Collect results

After (a successful) completion ```build.sh``` copies the built files to the container's ```/output``` volume directory. Copy the directory to your local directory:

```
$ docker cp build-container:/output .
```

### Clean up your mess

Remove ```build-container``` and its associated volume(s) - they've done their job admirably.

```
$ docker rm -v build-container
```
