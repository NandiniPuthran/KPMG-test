#!/bin/bash

# Install Node.js and NPM
apt-get update
apt-get install -y nodejs npm

# Install application dependencies
cd /app
npm install

# Set environment variables
export PORT=80
export NODE_ENV=production

# Start the Node.js server
node server.js
