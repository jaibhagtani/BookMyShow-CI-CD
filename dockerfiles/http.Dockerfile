# BASE IMAGE
FROM node:22-alpine
# Working Directory /app
WORKDIR /app

COPY . .

RUN npm install -g pnpm   
RUN pnpm install
RUN pnpm run db-prisma-generate
RUN pnpm build

EXPOSE 3002

CMD [ "node", "apps/http-server/dist/index.js" ]