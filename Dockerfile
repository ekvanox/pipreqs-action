# Use the alpine:3.17 base image
FROM alpine:3.17

# Copy the LICENSE, README.md, and entrypoint.sh files from the local file system into the root directory of the Docker image
COPY LICENSE README.md entrypoint.sh /

# Install Python 3 on the Docker image
RUN apk add --no-cache python3

# Install Pip 3 on the Docker image
RUN apk add --no-cache py3-pip

# Install Git on the Docker image
RUN apk add git

# Install the pipreqs Python package
RUN pip3 install pipreqs

# Make the entrypoint.sh script executable
RUN chmod +x /entrypoint.sh

# Set the default command to be run when a container is started from the Docker image
ENTRYPOINT ["/entrypoint.sh"]
