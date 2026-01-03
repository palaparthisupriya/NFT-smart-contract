# Use a stable Node.js 18 environment
FROM node:18-alpine

# Create app directory
WORKDIR /app

# Copy package files and install dependencies
# This is done first to leverage Docker layer caching
COPY package*.json ./
RUN npm install

# Copy the rest of your project files
COPY . .

# Compile the smart contracts to ensure artifacts are ready
RUN npx hardhat compile

# The default command will run the tests
CMD ["npx", "hardhat", "test"]