FROM ghost:6.33.0-alpine

# Ghost runs on port 2368
EXPOSE 2368

# Tell Ghost to listen on all interfaces
ENV NODE_ENV=production
