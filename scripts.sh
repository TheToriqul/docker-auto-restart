#!/bin/bash

###############################################################################
#
# Docker Container Auto-Restart Commands Reference
# Author: Md Toriqul Islam
# Description: Comprehensive reference for Docker container restart policies 
#              and advanced lifecycle management commands.
# Note: This is a reference script. Do not execute directly.
#
###############################################################################

#------------------------------------------------------------------------------
# Basic Container Lifecycle Management
#------------------------------------------------------------------------------

# Run a container with default "no restart" policy
docker run -d --name no-restart busybox /bin/sh -c "echo 'This container will not restart on failure.' && exit 1"

# View status of all containers
docker ps -a

#------------------------------------------------------------------------------
# Basic Restart Policies
#------------------------------------------------------------------------------

# Run a container that restarts only on failure
docker run -d --name restart-on-failure --restart on-failure busybox /bin/sh -c "echo 'This container restarts only on failure.' && exit 1"

# Run a container that restarts always
docker run -d --name restart-always --restart always busybox /bin/sh -c "echo 'This container restarts regardless of failure.' && exit 1"

# Run a container with a restart delay (predetermined time on failure)
docker run -d --name restart-until-stopped --restart unless-stopped busybox /bin/sh -c "echo 'Restart until stopped manually.' && exit 1"

#------------------------------------------------------------------------------
# Exponential Backoff Strategy Demonstration
#------------------------------------------------------------------------------

# Start a container with an "always" restart policy to observe backoff
docker run -d --name backoff-detector --restart always busybox /bin/sh -c "echo 'Backoff example' && exit 1"

# Observe backoff timing in the logs (exponential delays between restarts)
docker logs -f backoff-detector

#------------------------------------------------------------------------------
# Monitoring & Logging
#------------------------------------------------------------------------------

# View logs for specific containers
docker logs no-restart
docker logs restart-on-failure
docker logs -f restart-always  # Follow logs in real-time for the always-restarting container

# Display the current state of all containers
docker ps
docker ps -a  # Show all containers including stopped ones

#------------------------------------------------------------------------------
# Command Execution During Backoff Period
#------------------------------------------------------------------------------

# Attempt to execute a command in a container during backoff period (will fail if container is restarting)
docker exec backoff-detector echo "Attempting command during backoff"

#------------------------------------------------------------------------------
# Advanced Restart Management Using Init and Supervisors
#------------------------------------------------------------------------------

# Run a container with a basic init process for better lifecycle management
docker run -d --name init-container --init busybox /bin/sh -c "echo 'Using init for better lifecycle control'; exit 1"

# Run a container with a supervisor process (example with 'supervisord')
docker run -d --name supervisor-container my-supervisor-image

#------------------------------------------------------------------------------
# Health Check for Advanced Control
#------------------------------------------------------------------------------

# Run a container with a health check that restarts on failure
docker run -d --name health-checked-container --restart on-failure --health-cmd "exit 1" busybox

# Check container health status
docker inspect --format='{{json .State.Health}}' health-checked-container

#------------------------------------------------------------------------------
# Cleanup and Removal Commands
#------------------------------------------------------------------------------

# Stop and remove individual containers
docker stop no-restart restart-on-failure restart-always backoff-detector init-container supervisor-container health-checked-container
docker rm no-restart restart-on-failure restart-always backoff-detector init-container supervisor-container health-checked-container

# Remove all stopped containers
docker container prune -f

###############################################################################
# End of Docker Restart Policy Command Reference
###############################################################################
