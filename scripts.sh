```bash
#!/bin/bash

###############################################################################
#
# Docker Container Restart Policies - Command Reference
# Author: Md Toriqul Islam
# Description: Reference commands for managing Docker container restarts
# Note: This is a reference script. Do not execute directly.
#
###############################################################################

#------------------------------------------------------------------------------
# Restart Policy Configuration Examples
#------------------------------------------------------------------------------

# Container with default "no restart" policy
docker run -d --name no-restart busybox /bin/sh -c "exit 1"

# Container that restarts only on failure
docker run -d --name restart-on-failure --restart on-failure busybox /bin/sh -c "exit 1"

# Container that restarts always, showcasing exponential backoff strategy
docker run -d --name always-restart --restart always busybox date

#------------------------------------------------------------------------------
# Log Monitoring Commands
#------------------------------------------------------------------------------

# View container logs
docker logs no-restart
docker logs restart-on-failure
docker logs -f always-restart  # Follow logs in real-time

#------------------------------------------------------------------------------
# Backoff Period Observation
#------------------------------------------------------------------------------

# Example command to observe backoff in real time (use only with --restart always)
docker run -d --name backoff-detector --restart always busybox date
docker logs -f backoff-detector

#------------------------------------------------------------------------------
# Exec Command Limitation During Backoff
#------------------------------------------------------------------------------

# Attempting to execute a command while container is in a backoff period (will fail)
docker exec backoff-detector echo "Just a Test"  # Will show error if container is restarting

###############################################################################
# End of Command Reference
###############################################################################
