FROM node:18-alpine

WORKDIR /app

# Install Ghost CLI globally
RUN npm install -g ghost-cli@latest

# Copy package files first for better caching
COPY package.json yarn.lock ./

# Install dependencies (production only)
RUN yarn install --production --frozen-lockfile

# Copy the rest of the app
COPY . .

# Create content directory for uploads
RUN mkdir -p content/images content/logs content/data content/settings content/themes content/adapters

# Expose Ghost's default port
EXPOSE 2368

# Start Ghost
CMD ["ghost", "start", "--no-prompt"]
