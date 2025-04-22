# 1. Base image with Node.js
FROM node:18-slim
 
# 2. Install dependencies for Chrome
RUN apt-get update && apt-get install -y \
  wget \
  ca-certificates \
  fonts-liberation \
  libappindicator3-1 \
  libasound2 \
  libatk-bridge2.0-0 \
  libatk1.0-0 \
  libcups2 \
  libdbus-1-3 \
  libgdk-pixbuf2.0-0 \
  libnspr4 \
  libnss3 \
  libx11-xcb1 \
  libxcomposite1 \
  libxdamage1 \
  libxrandr2 \
  xdg-utils \
  libu2f-udev \
  libvulkan1 \
  libxcb-dri3-0 \
  --no-install-recommends && \
  apt-get clean && rm -rf /var/lib/apt/lists/*
 
# 3. Set working directory
WORKDIR /app
 
# 4. Copy files
COPY package*.json ./
COPY . .
 
# 5. Install dependencies
RUN npm install
 
# 6. Expose port
EXPOSE 3000
 
# 7. Start server
CMD ["node", "index.js"]
