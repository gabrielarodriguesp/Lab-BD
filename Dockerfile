# Use an official OpenJDK image
FROM openjdk:17-slim

# Install Redis CLI for testing Redis
RUN apt-get update && apt-get install -y redis-tools

# Set the working directory
WORKDIR /workspace

# Copy the local project to the container's workspace directory
COPY . /workspace

# Expose ports for your Java app and Redis
EXPOSE 8080 6379

# Command to keep the container running for development
CMD ["tail", "-f", "/dev/null"]
