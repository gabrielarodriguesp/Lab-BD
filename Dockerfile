FROM openjdk:17-jdk-slim

# Set environment variables for user, group, and username
ARG USER_ID
ARG GROUP_ID
ARG USERNAME

# Install dependencies
RUN apt-get update && apt-get install -y \
    maven \
    sudo

# Create a group and user with the same UID, GID, and username as your local machine
RUN groupadd -g $GROUP_ID devgroup && \
    useradd -u $USER_ID -g devgroup -m -s /bin/bash $USERNAME && \
    echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Switch to the created user

WORKDIR /app
# Set the working directory inside the container
COPY . .

USER $USERNAME
# Copy the project files

# Run Maven install
# RUN mvn clean install

# Command to keep the container alive for development
CMD ["tail", "-f", "/dev/null"]
