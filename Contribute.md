# Contributing to BookMyShow-CI-CD

Thank you for your interest in contributing! Please follow these guidelines.

## Prerequisites

- Node.js (v14+)
- npm or yarn
- Git
- Docker
- PostgreSQL (via Docker or neon.tech)

## Manual Installation

1. Install Node.js locally
2. Clone the repository
3. Install dependencies: `npm install`
4. Start the database locally:
    ```bash
    docker run -e POSTGRES_PASSWORD=mysecretpassword -d -p 5432:5432 postgres
    ```
    Or get a new DB from neon.tech
5. Update your `.env` file with DB credentials
6. Run Prisma migrations: `npx prisma migrate`
7. Generate Prisma client: `npx prisma generate`
8. Build the project: `npm run build`
9. Start the server: `npm run start`

## Docker Installation

1. Install Docker
2. Start PostgreSQL (using docker):
    ```bash
    docker run --name postgres_db -e POSTGRES_PASSWORD=mysecretpassword -d -p 5432:5432 postgres
    ```
4. Build the image (http-server): `docker build --network=host -t jns-http-server-dev -f dockerfiles-dev/jns-http-dev.Dockerfile .`
5. Run the image (http-server): `docker run -e DATABASE_URL=postgresql://postgres:mysecretpassword@postgres_db:5432/postgres -p 3002:3002 jns-http-server-dev`
6. Build the image (ws-server): `docker build --network=host -t jns-ws-server-dev -f dockerfiles-dev/jns-ws-dev.Dockerfile .`
7. Run the image (ws-server): `docker run -e DATABASE_URL=postgresql://postgres:mysecretpassword@postgres_db:5432/postgres -p 3001:3001 jns-ws-server-dev`
8. Build the image (web): `docker build --network=host -t jns-web-dev -f Dockerfile.web -f dockerfiles-dev/jns-web-dev.Dockerfile .`
9. Run the image (web): `docker run -e DATABASE_URL=postgresql://postgres:mysecretpassword@postgres_db:5432/postgres -p 3000:3000 jns-web-dev`

## Docker Compose Installation

1. Install docker and docker-compose
2. Run: `docker-compose -f docker-compose-dev.yml up`

## Contributing

- Create a feature branch
- Make focused commits
- Submit a pull request with clear descriptions
- Ensure tests pass

## Code Style

Follow the existing project conventions and add meaningful comments where needed.

