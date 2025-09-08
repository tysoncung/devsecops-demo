# Multi-stage build for security
# Using an older version with known CVEs for demo purposes
FROM node:16-alpine3.14 AS builder

# Create app directory
WORKDIR /usr/src/app

# Copy package files
COPY package*.json ./

# Install dependencies (skip prepare script that runs husky)
RUN npm ci --only=production --ignore-scripts

# Production stage
# Using an older version with known CVEs for demo purposes
FROM node:16-alpine3.14

# Security: Run as non-root user
RUN addgroup -g 1001 -S nodejs && \
    adduser -S nodejs -u 1001

# Set working directory
WORKDIR /usr/src/app

# Copy from builder stage
COPY --from=builder --chown=nodejs:nodejs /usr/src/app/node_modules ./node_modules
COPY --chown=nodejs:nodejs . .

# Intentionally not upgrading packages to keep CVEs for demo
# In production, you would uncomment the following:
# RUN apk update && apk upgrade && rm -rf /var/cache/apk/*

# Switch to non-root user
USER nodejs

# Expose port
EXPOSE 3000

# Security: Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD node healthcheck.js || exit 1

# Start application
CMD ["node", "src/index.js"]