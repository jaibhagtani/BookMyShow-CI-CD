# BASE IMAGE
FROM node:22-alpine
# Working Directory /app
WORKDIR /app

# COPY package* .
COPY . .
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
ENV DATABASE_URL=postgresql://postgres:mysecretpassword@localhost:5432/postgres
RUN echo ${DATABASE_URL}
RUN pnpm run db-prisma-migrate
RUN pnpm run db-prisma-generate
RUN pnpm build

EXPOSE 3002

# CMD [ "npm", "run", "start:http" ]

CMD [ "pnpm", "run", "db-prisma-generate", "&&", "npm", "run", "start:http" ]

# docker build -t http-server-docker -f dockerfiles/http.Dockerfile .