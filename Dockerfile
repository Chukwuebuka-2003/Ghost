FROM node:18-alpine

WORKDIR /app

# Install system dependencies
RUN apk add --no-cache \
    python3 \
    make \
    g++ \
    sqlite \
    sqlite-dev \
    libc6-compat \
    curl

# Install Ghost CLI globally
RUN npm install -g ghost-cli@latest

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm install --production

# Copy the rest of the app
COPY . .

# Create content directories
RUN mkdir -p content/images content/logs content/data content/settings content/themes

# Expose port
EXPOSE 2368

# Set environment
ENV NODE_ENV=production
ENV PORT=2368

# Start Ghost using Ghost CLI (NOT npm start)
CMD ["ghost", "start", "--no-prompt"]
