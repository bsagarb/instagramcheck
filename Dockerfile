# Use official Puppeteer image that has Chromium & dependencies
FROM ghcr.io/puppeteer/puppeteer:latest
 
# Set working directory
WORKDIR /app
 
# Copy dependency files and install
COPY package*.json ./
RUN npm install
 
# Copy all files
COPY . .
 
# Expose the port your app runs on
EXPOSE 3000
 
# Start the app
CMD ["node", "index.js"]
