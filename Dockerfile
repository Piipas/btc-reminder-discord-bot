FROM node:20-alpine

# create workspace
RUN mkdir -p /usr/src/bot
WORKDIR /usr/src/bot

# install pnpm globally
RUN npm install -g pnpm

# copy app files to workspace
COPY . /usr/src/bot

# install dependencies with frozen lockfile
RUN pnpm install --frozen-lockfile

# build time env variables
ARG DIRECT_URL
ARG DATABASE_URL

# migrate updates to database
RUN pnpm run migrate

# build the app files
RUN pnpm run build

EXPOSE 80

# final command
CMD ["node", "dist/index.js"]