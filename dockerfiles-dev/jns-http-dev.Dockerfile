# BASE IMAGE
FROM node:22-alpine
# Working Directory /app
WORKDIR /app


COPY ./packages ./packages
COPY ./pnpm-lock.yaml ./pnpm-lock.yaml
COPY ./pnpm-workspace.yaml ./pnpm-workspace.yaml

COPY ./package.json ./package.json

COPY ./turbo.json ./turbo.json

COPY ./apps/http-server ./apps/http-server

# isme .env bhi push ho jaati hai, toh make sure .dockerignore file mein .env aur **/.env add ho

RUN npm install -g pnpm
RUN pnpm install

# ************************************************************8
# HERE while Building docker file in dev evn, prisma wants to talk to DB,
# because it is also operaing in container only, then it can't connect to DB,
# therefore while building this dockerfile in dev, --network=host is used, 
# which allows the container to use the host's network, and connect to DB which is running on host machine.
# ************************************************************8

# COPY . .
# Build ho rha hai host m/c pe, toh DB localhost pe milega
# ENV DATABASE_URL=postgresql://postgres:mysecretpassword@localhost:5432/postgres
# RUN pnpm run db-prisma-migrate

# ENSURING Dockerfile not need to talk to DB while building
# Not migrating the DB during the docker build, I will migrate when container starts 
# Migrate outside when actually the container starts
RUN npm run db:generate
RUN pnpm build
EXPOSE 3002

# CMD [ "npm", "run", "start:http" ]

CMD [ "npm", "run", "start:http" ]

# docker build -t http-server-docker -f dockerfiles/http.Dockerfile .