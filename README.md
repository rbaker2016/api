# Python Image Builder

appLariat's generic image builder for Python. This is the default build configuration for Python images and is used by the appLariat Component Builder service

Default build workflow:

Component builder starts with a task to create a Python image and then dynamically retrieves this repository.

Component builder updates the FROM image based on configuration information provided at startup.

Component builder pulls down the specified code artifact.
 
The docker build command is executed via the docker api, which process the Dockerfile:

- Pulls the proper official Python image as the base image layer
- Copies the build.sh and entrypoint.sh into the image
- Copies the code artifact into the image
- Executes the build.sh script to prepare the image to run When the docker build process is completed, component builder pushes the image into the cluster's local image repository