# BASE IMAGE
FROM node:22-alpine
# Working Directory /app
WORKDIR /app

# COPY package* .
# COPY packages* .

ARG DATABASE_URL

COPY ./packages ./packages
COPY ./pnpm-lock.yaml ./pnpm-lock.yaml
COPY ./pnpm-workspace.yaml ./pnpm-workspace.yaml

COPY ./package.json ./package.json

COPY ./turbo.json ./turbo.json

COPY ./apps/http-server ./apps/http-server

# isme .env bhi push ho jaati hai, toh make sure .dockerignore file mein .env aur **/.env add ho

RUN npm install -g pnpm
RUN pnpm install

# COPY . .
RUN pnpm run db-prisma-generate
RUN DATABASE_URL=${DATABASE_URL} pnpm build

EXPOSE 3002

# CMD [ "npm", "run", "start:http" ]

CMD [ "npm", "run", "start:http" ]

# docker build -t http-server-docker -f dockerfiles/http.Dockerfile .