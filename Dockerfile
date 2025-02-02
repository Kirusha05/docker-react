# First build phase
FROM node:20-alpine as builder

USER node

RUN mkdir -p /home/node/app
WORKDIR /home/node/app

COPY --chown=node:node ./package.json ./
RUN npm install

COPY --chown=node:node ./ ./

RUN npm run build

# Second build phase
FROM nginx:1.27-alpine
COPY --from=builder /home/node/app/dist /usr/share/nginx/html