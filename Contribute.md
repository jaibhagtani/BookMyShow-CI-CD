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

1. Install Docker and docker-compose
2. Start PostgreSQL:
    ```bash
    docker run -e POSTGRES_PASSWORD=mysecretpassword -d -p 5432:5432 postgres
    ```
3. Build the image: `docker build --network=host -t user-project .`
4. Run the image: `docker run -p 3000:3000 user-project`

## Docker Compose Installation

1. Install docker and docker-compose
2. Run: `docker-compose up`

## Contributing

- Create a feature branch
- Make focused commits
- Submit a pull request with clear descriptions
- Ensure tests pass

## Code Style

Follow the existing project conventions and add meaningful comments where needed.

