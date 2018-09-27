# Spoon Dockerfile

Dockefile is created on top of `ubuntu:18:04` image.

Git, Maven, Oracle JDK 1.8 and other basic developer tools are available in the image.

# Quick Start Using Docker-Compose

- Switch to the `{spoon-project-root-folder}/docker-ds`
- Open a terminal session to that folder
    - Run `docker-compose build` : Use the Dockerfile to build the Docker image for Spoon development
    - Run `docker-compose up -d` : Use docker-compose.yml to launch a Docker container from the above Spoon development Docker image.
- Run `docker exec -it spoon bash`
- At this point you must be inside the docker container, in the root folder of the project in the container (i.e.: `/data`). From there, you can build the repository as usual:
    - `mvn compile` to compile Spoon library
    - `mvn test` to execute tests against the newly built Spoon library
- When you finish working with the container, type `exit`
- Run `docker-compose down` to stop the service.

# Quick Start Using DevSpaces

- Go through DevSpaces installation procedure [here](http://devspaces-docs.ey.devfactory.com/installation/index.html#installation)
- Open a terminal session to `{spoon-project-root-folder}` dir
    - Run `cndevspaces collections create -f docker-ds/spoon-collection.yaml` : This will create the DevSpaces collection for Spoon development.
    - Run `cndevspaces bind -C spoon -c spoon-cfg` :  This step will launch the DevSpaces Spoon container and synchronize the current (a.k.a.:  `{spoon-project-root-folder}`) directory with the remote DevSpaces container in the `/data` directory).  Once it is complete, you will have a sync-copy of the Spoon repos on the remote container.
- Run `cndevspaces exec -r spoon`
- At this point you must be inside the docker container, in the root folder of the project in the container (i.e.: `/data`). From there, you can build the repository as usual:
    - `mvn compile` to compile Spoon library
    - `mvn test` to execute tests against the newly built Spoon library
- When you finish working with the container, type `exit`

# Work with Spoon Development Docker using Docker-Compose

Switch to the  `{spoon-project-root-folder}/docker-ds/`

## Build the image

In `{spoon-project-root-folder}/docker-ds/` folder, run:

```
docker-compose build
```

This instruction will create a DockerImage in your machine called `spoon:latest`

## Run the container

In `{spoon-project-root-folder}/docker-ds/` folder, run:

```
docker-compose up -d
```
Parameter `-d` makes the container run in detached mode.
This command will create a running container in detached mode called `spoon`.
You can check the containers running with `docker ps`

## Get a container session

Run:

```
docker exec -it spoon bash
```
Parameters `-it` allocate an interactive TTY session

## docker-compose.yml

The docker-compose.yml file contains a single service: `builder`.
We will use this service to build the Spoon sources from our local environment, so we mount the Spoon root project dir to the a `/data` folder:

```
    volumes:
      - ../.:/data:Z
```

## Requirements
The container was tested successfully on:
- Docker 17.05 and up
- docker-compose 1.8 and up


# Work with the DevSpaces for Spoon

Install the DevSpaces CLI from [Here](http://devspaces-docs.ey.devfactory.com/installation/index.html#installation) as the first step.

## Create a DevSpaces Collection for Spoon
In `{spoon-project-root-folder}` folder, run:

```
cndevspaces collections create -f docker-ds/spoon-collection.yaml
```
 This will create the DevSpaces collection for Spoon development.  You can log into the [DevSpaces UI Console](https://devspaces.ey.devfactory.com/home/collections) and checks its collection as well as the DevSpaces Image that it uses and its states.
 
## Run DevSpaces container and Sync the Spoon local repos with the Devspaces Containter 

In `{spoon-project-root-folder}` folder, run:

```
cndevspaces bind --collection spoon --config spoon-cfg
```
Parameter `--collection` indicates the collection name and the parameter `--config` indicates the collection config name of the Spoon DevSpaces collection.
This command will launch the containers defined in the collection and then synchronized the contents of the Spoon local repos to the remote container `/data` directory.

Once the synchronization is complete, you can check the status and the DevSpaces collection information with
```
cndevspaces info
```

## Get a container session for Spoon DevSpaces 

Run:

```
cndevspaces exec -r spoon
```

## Build the DevSpaces Docker image

The DevSpaces DockerImage has already been pre-created, if you need to recreate it again, in `{spoon-project-root-folder}/docker-ds/` folder, run:

```
./build_ds_img.sh
```
This instruction will create a DockerImage in the Docker Registry `registry2.swarm.devfactory.com` as `registry2.swarm.devfactory.com/devfactory/spoon/spoon-ds:latest`



# Testing with Spoon-Examples on the Spoon Docker Container

The Spoon examples are located in the repository `https://github.com/SpoonLabs/spoon-examples`.  To run the examples, you will need to

- On the container, install the current Spoon build snapshot JAR into the container local m2 cache by running (`cd /data && mvn install`).
    - Note down the version suffix of the Spoon that is installed into the container local m2 cache.  Currently, it should be `7.1.0-SNAPSHOT`.
- Checkout the spoon-examples repository on the running Spoon contianer
    - On the container, create a directory to store the spoon-examples repos and switch to it (`mkdir -p ~/test && cd ~/test`)
    - Checkout the spoon-examples repos (`git clone https://github.com/SpoonLabs/spoon-examples.git`)
- Modify the spoon-examples' `pom.xml` to use the build tree compiled JAR: Currently, the spoon-examples' `pom.xml` referenced the official Spoon Maven library.   It also uses the older release version `6.2.0` while the current stable release is a different version.  To use spoon-examples with the build generated snapshot of the built JAR, we need to modify the spoon-examples' `pom.xml`, please follow these steps:
    - Option 1:
        - Copy the pre-modified `spoon-examples-pom.xml` from the Dockerization artifacts and replaced the one in spoon-examples (`cp /data/docker-ds/spoon-examples-pom.xml ~/test/spoon-examples/pom.xml`) 
    - Option 2: 
        - Switch to the spoon-examples directory (`cd ~/test/spoon-examples`) directory
        - Open spoon-examples' `pom.xml` in an text editor and search for `spoon-core`, you will find the next line to spoon-core specifying the version of spoon to be used.  Currently it is set to `6.2.0`.  Change it to the version that is currently in the Spoon's `pom.xml`, as of today it should be `7.1.0-SNAPSHOT`
        - Save and quit spoon-examples's `pom.xml`
- Run (`cd ~/test/spoon-examples && mvn test`)


