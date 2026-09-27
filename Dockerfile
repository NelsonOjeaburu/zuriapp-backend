# zuriapp-backend Dockerfile
# Single-stage: Express serves source directly, there's no compile/build step
# (unlike the frontend, which needs a build stage — see that Dockerfile).

FROM node:20-alpine

WORKDIR /app

# Copy package files first, install, THEN copy the rest of the source.
# This ordering matters: Docker caches each layer. As long as package.json
# doesn't change, Docker reuses the cached `npm ci` layer on every rebuild,
# even if you've edited server.js ten times. Copy source before installing
# and you invalidate the install cache on every single code change.
COPY package*.json ./
RUN npm install --omit=dev

COPY . .

# Run as a non-root user. The base image ships a generic 'node' user/group
# (uid 1000) for exactly this purpose — no need to create our own.
USER node

EXPOSE 5000

CMD ["node", "server.js"]
