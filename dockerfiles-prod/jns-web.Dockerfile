# BASE IMAGE
FROM node:22-alpine
# Working Directory /app
WORKDIR /app

COPY package* .
COPY packages* .
# isme .env bhi push ho jaati hai, toh make sure .dockerignore file mein .env aur **/.env add ho

RUN npm install -g pnpm   
RUN pnpm install

COPY . .
# RUN pnpm run db-prisma-generate
RUN pnpm build

EXPOSE 3000

# CMD [ "npm", "run", "start:web" ]
CMD [ "pnpm", "run", "db-prisma-generate", "&&", "npm", "run", "start:web" ]

# docker build -t web-docker -f dockerfiles/web.Dockerfile .