# Use the official Dart image from the Docker Hub
FROM google/dart:latest

# Set the working directory
WORKDIR /app

# Copy the pubspec.* files to the working directory
COPY pubspec.* ./

# Install the dependencies
RUN dart pub get

# Copy the rest of the application code to the working directory
COPY . .

# Build the application
RUN dart compile exe bin/main.dart -o bin/main

# Command to run the application
CMD ["bin/main"] 