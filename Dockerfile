# Use the official Node.js Alpine image as the base image
# FROM node:14-alpine

# Use Node.js LTS version
FROM node:lts-alpine


# Set the working directory
WORKDIR /usr/src/app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install Chromium
ENV CHROME_BIN="/usr/bin/chromium-browser" \
    PUPPETEER_SKIP_CHROMIUM_DOWNLOAD="true" \
    NODE_ENV="production" \
    SESSIONS_PATH="./sessions" \
    PORT="3000" \
    API_KEY="senai" \
    BASE_WEBHOOK_URL="http://localhost:3000/localCallbackExample" \
    ENABLE_LOCAL_CALLBACK_EXAMPLE="TRUE" \
    RATE_LIMIT_MAX="1000" \
    RATE_LIMIT_WINDOW_MS="1000" \
    MAX_ATTACHMENT_SIZE="10000000" \
    SET_MESSAGES_AS_SEEN="TRUE" \    
    DISABLED_CALLBACKS="message_ack|message_reaction" \
    WEB_VERSION="2.2328.5" \
    WEB_VERSION_CACHE_TYPE="none" \
    RECOVER_SESSIONS="TRUE" \    
    ENABLE_SWAGGER_ENDPOINT="TRUE"
RUN set -x \
    && apk update \
    && apk upgrade \
    && apk add --no-cache \
    udev \
    ttf-freefont \ 
    chromium \
    git \
    openssh-client

# Install the dependencies
RUN npm ci --only=production --ignore-scripts

# Copy the rest of the source code to the working directory
COPY . .

# Expose the port the API will run on
EXPOSE 3000

# Start the API
CMD ["npm", "start"]