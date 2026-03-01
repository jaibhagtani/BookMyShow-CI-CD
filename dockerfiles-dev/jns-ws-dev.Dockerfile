# BASE IMAGE
FROM node:22-alpine
# Working Directory /app
WORKDIR /app

# COPY package* .
# COPY packages* .
COPY ./packages ./packages
COPY ./pnpm-lock.yaml ./pnpm-lock.yaml
COPY ./pnpm-workspace.yaml ./pnpm-workspace.yaml

COPY ./package.json ./package.json

COPY ./turbo.json ./turbo.json

COPY ./apps/ws-server ./apps/ws-server

# isme .env bhi push ho jaati hai, toh make sure .dockerignore file mein .env aur **/.env add ho
RUN npm install -g pnpm   
RUN pnpm install
RUN npm run db:generate
RUN pnpm build

EXPOSE 3001

CMD [ "npm", "run", "start:ws" ]
# docker build -t ws-server-docker -f dockerfiles/ws.Dockerfile .