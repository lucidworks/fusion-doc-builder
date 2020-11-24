# This Dockerfile is used to build an image containing basic stuff to be used as a Jenkins slave build node,
# plus dependencies for our build and some tools we use for testing.
# Note the plaintext password here; depending on your environment that may not be advisable.
# Based on evarga/jenkins-slave
FROM node:latest

MAINTAINER  Luis Munoz "luis.munoz@lucidworks.com"

USER root

RUN groupadd jenkins -g 7000 && \
  npm install -g typescript && \
  useradd jenkins -d /home/jenkins -m -u 7000 -g docker -G docker -s /bin/bash

USER jenkins

RUN yarn global add gatsby-cli



