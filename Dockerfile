FROM ubuntu:latest

# Install dependencies
RUN apt-get update
RUN apt-get install -y python-dev ipython python-numpy python-matplotlib python-scipy cython

# Set up display variables
RUN apt-get install -qqy x11-apps x11-xserver-utils

# Compile C libraries
COPY . /sms-tools
WORKDIR /sms-tools/software/models/utilFunctions_C
RUN python compileModule.py build_ext --inplace

# Docker-managed volume for compiled code
VOLUME /sms-tools/software/models/utilFunctions_C

WORKDIR /sms-tools
CMD bash && xeyes && python software/models_interface