FROM node:18-alpine

WORKDIR /app

# Install Ghost CLI globally
RUN npm install -g ghost-cli@latest

# Install system dependencies
RUN apk add --no-cache \
    python3 \
    make \
    g++ \
    sqlite \
    sqlite-dev \
    libc6-compat

# Copy package files
COPY package*.json ./

# Install ALL dependencies (not just production) for build
RUN npm install

# Copy the rest of the app
COPY . .

# Build Ghost (if needed)
RUN npm run build || true

# Create content directories
RUN mkdir -p content/images content/logs content/data content/settings content/themes

# Expose port
EXPOSE 2368

# Set environment
ENV NODE_ENV=production

# Start Ghost
CMD ["npm", "start"]
