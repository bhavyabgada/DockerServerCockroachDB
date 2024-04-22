# Use the official Ubuntu 22.04 LTS as a parent image
FROM ubuntu:22.04

# Set environment variables to non-interactive (to avoid tzdata prompts)
ENV DEBIAN_FRONTEND=noninteractive

# Install prerequisites
RUN apt-get update && apt-get install -y curl gnupg software-properties-common build-essential \
    && curl -sL https://deb.nodesource.com/setup_14.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g npm@6.14.17 pm2

# Set up working directory for your app
WORKDIR /app

# Copy package.json and package-lock.json (if available)
COPY package*.json ./

# Install npm dependencies
RUN npm install --production

# Copy the rest of your application code
COPY . .

# Expose the port your app runs on
EXPOSE 3000

# Set pm2 to start your application
CMD ["pm2-runtime", "start", "ecosystem.config.js"]
