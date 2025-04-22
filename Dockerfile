# Use official Puppeteer image with Chromium & dependencies
FROM ghcr.io/puppeteer/puppeteer:latest
 
# Set working directory
WORKDIR /app
 
# Change ownership so current user (pptruser) can write
RUN chown -R pptruser:pptruser /app
 
# Switch to non-root user
USER pptruser
 
# Copy dependency files and install
COPY package*.json ./
RUN npm install
 
# Copy all files
COPY . .
 
# Expose the port your app runs on
EXPOSE 3000
 
# Start the app
CMD ["node", "index.js"]
