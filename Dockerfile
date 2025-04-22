# Use official Puppeteer base image with Chromium & deps
FROM ghcr.io/puppeteer/puppeteer:latest
 
# Create app directory and set ownership for non-root user
RUN mkdir -p /home/pptruser/app && chown -R pptruser:pptruser /home/pptruser/app
 
# Set working directory
WORKDIR /home/pptruser/app
 
# Switch to Puppeteer user (non-root)
USER pptruser
 
# Copy dependency files
COPY --chown=pptruser:pptruser package*.json ./
 
# Install dependencies
RUN npm install
 
# Copy all source code
COPY --chown=pptruser:pptruser . .
 
# Expose the port your app runs on
EXPOSE 3000
 
# Start the app
CMD ["node", "index.js"]
