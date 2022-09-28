## Carbon Lang Docker Container

Is a docker container for a bazel enabled build environment for experimenting with carbon-lang (Next gen programming language)

I used this environment to allow me utilize this on a windows box, running docker-desktop.

## NOTE: This is not the Carbon Lang Project - Just a docker container with bazel installed in order to develop carbon-lang

The carbon-languae Project can be found here

https://github.com/carbon-language/carbon-lang

## Cloning the carbon-lang code

First clone the carbon-lang code onto your machine  (say in c:/carbon-lang)

git clone https://github.com/carbon-language/carbon-lang.git

## To build docker container image (one time)

docker build --tag carbon-lang -f Dockerfile .

## To run the docker container as a dev environment

Having first cloned the carbon-lang repo to /carbon-lang (see above), run the container, mounting the c:/carbon-lang into the ubuntu container as /carbon-lang

[winpty] docker run -v c:/carbon-lang:/carbon-lang:rw --workdir /carbon-lang -it carbon-lang bash

Note you may need to use winpty to run docker in say a bash shell on windows

## Build and run the explorer

Having started the container I then run the lit tests

cd /carbon-lang/explorer

./update_checks.py

## One time bazel setup

The first time to run update_checks.py it will take the pre-downloaded bazel dependencies and install them. (this can take some time)

They are pre-downloaded to aid airgapped development environments, and to avoid SSL certificate issues.

Subsequent runs for update_checks.py will not re-install these dependencies unless you exit the container
