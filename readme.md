# WordPress with ACF & CPT via Docker

This repository provides a Dockerized WordPress setup integrated with Advanced Custom Fields (ACF) and Custom Post Types (CPT). It's designed for developers seeking a streamlined local development environment for WordPress projects.

## 🚀 Getting Started

### Prerequisites

Ensure you have the following installed:

- [Docker](https://www.docker.com/get-started)
- [Docker Compose](https://docs.docker.com/compose/install/)

### Clone the Repository

```bash
git clone https://github.com/therizdhan/wordpress-acf-cpt.git
cd wordpress-acf-cpt
```

### Configure Environment Variables

Copy the example environment file:
```bash
cp .env-example .env
```

Edit the .env file to set your desired environment variables, such as database credentials and site information.

### Build and Start the Containers

```bash
docker-compose up --build
```

This command will:

    Build the Docker images as defined in the Dockerfile.

    Start the containers as per the configuration in docker-compose.yml.
