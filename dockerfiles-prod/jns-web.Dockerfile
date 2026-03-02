# BASE IMAGE
FROM node:22-alpine
# Working Directory /app
WORKDIR /app

ARG DATABASE_URL
# ENV DATABASE_URL=$DATABASE_URL

COPY ./packages ./packages
COPY ./pnpm-lock.yaml ./pnpm-lock.yaml
COPY ./pnpm-workspace.yaml ./pnpm-workspace.yaml

COPY ./package.json ./package.json

COPY ./turbo.json ./turbo.json

COPY ./apps/web ./apps/web

# isme .env bhi push ho jaati hai, toh make sure .dockerignore file mein .env aur **/.env add ho

RUN npm install -g pnpm   
RUN pnpm install

RUN npm run db:generate
RUN DATABASE_URL=${DATABASE_URL} pnpm build

EXPOSE 3000

# CMD [ "npm", "run", "start:web" ]
CMD [ "npm", "run", "start:web" ]

# docker build -t web-docker -f dockerfiles/web.Dockerfile .