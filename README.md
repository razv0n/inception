*This project has been created as part of the 42 curriculum by mfahmi*

# Inception

## Description

Inception is a system administration and containerization project focused on building a complete web application infrastructure using Docker. Instead of relying on pre-built images, each service is created from its own Dockerfile, allowing a deeper understanding of how containers work and how multiple services communicate in an isolated environment.

The infrastructure consists of three main services:

* **NGINX** – serves as the HTTPS web server and reverse proxy.
* **WordPress** – provides the PHP application running through PHP-FPM.
* **MariaDB** – stores the application's persistent data.

The goal of the project is to understand how independent services can cooperate while remaining isolated, how persistent data is managed, and how Docker simplifies deployment by packaging applications together with their dependencies.

---

# Project Description

This project uses Docker Compose to orchestrate multiple containers that together provide a functional WordPress website.

Each service runs inside its own container and has a single responsibility:

* **NGINX** receives HTTPS requests and forwards PHP requests to PHP-FPM.
* **WordPress** executes PHP code and communicates with the database.
* **MariaDB** stores all website data.

Persistent data is stored outside the containers using Docker volumes so that information remains available even if containers are recreated.

## Main Design Choices

* One service per container.
* Custom Dockerfiles for every service.
* Docker Compose used for orchestration.
* HTTPS enabled using SSL certificates.
* Docker secrets used for sensitive credentials.
* Persistent storage separated from containers through volumes.
* Dedicated Docker bridge network allowing services to communicate using service names instead of IP addresses.

---

# Docker Concepts

## Virtual Machines vs Docker

### Virtual Machines

A virtual machine virtualizes an entire operating system. Every VM includes its own kernel, system libraries, applications, and virtual hardware.

Advantages:

* Strong isolation.
* Can run completely different operating systems.

Disadvantages:

* High memory usage.
* Slow startup.
* Larger storage requirements.

### Docker

Docker virtualizes applications instead of operating systems. Containers share the host kernel while remaining isolated through Linux namespaces and cgroups.

Advantages:

* Lightweight.
* Starts within seconds.
* Uses fewer resources.
* Easier to deploy consistently.

Disadvantages:

* Shares the host kernel.
* Isolation is weaker than a full virtual machine.

---

## Secrets vs Environment Variables

### Environment Variables

Environment variables are simple key-value pairs passed to a container.

Advantages:

* Easy to configure.
* Convenient for non-sensitive configuration.

Disadvantages:

* Can be viewed through Docker inspection commands.
* May accidentally appear in logs or debugging output.

### Docker Secrets

Docker secrets are stored separately from container configuration and mounted as files inside the container only when needed.

Advantages:

* Better protection for sensitive information.
* Keeps passwords out of images and Docker Compose files.

For this project, database passwords are provided through Docker secrets rather than embedding them directly into the image.

---

## Docker Network vs Host Network

### Docker Bridge Network

The bridge network isolates containers while allowing them to communicate using Docker's internal DNS.

Example:

* `nginx` connects to `wordpress`
* `wordpress` connects to `mariadb`

without requiring fixed IP addresses.

Advantages:

* Service isolation.
* Automatic DNS resolution.
* Better security.

### Host Network

Host networking removes network isolation and makes the container use the host's network stack directly.

Advantages:

* Slightly lower networking overhead.

Disadvantages:

* Reduced isolation.
* Greater chance of port conflicts.
* Less flexible for multi-service deployments.

The bridge network is the preferred solution for this project.

---

## Docker Volumes vs Bind Mounts

### Docker Volumes

Volumes are managed directly by Docker.

Advantages:

* Docker manages storage automatically.
* Easier backup and migration.
* Independent from project location.

They are used in this project to preserve MariaDB and WordPress data.

### Bind Mounts

Bind mounts directly expose a directory from the host filesystem to the container.

Advantages:

* Useful during development.
* Easy to inspect files on the host.

Disadvantages:

* Depends on the host directory existing.
* Less portable.

---

# Instructions

## Requirements

* Docker
* Docker Compose

## Build the project

```bash
make
```

or

```bash
docker compose -f srcs/docker-compose.yml up --build
```

## Stop the project

```bash
make down
```

or

```bash
docker compose -f srcs/docker-compose.yml down
```

## Rebuild from scratch

```bash
make re
```

## Configuration

Create a `.env` file containing the required environment variables before starting the project.

If Docker secrets are used, create the required secret files before launching the containers.

---

# Project Structure

```text
.
├── Makefile
├── README.md
├── .env
└── srcs
    ├── docker-compose.yml
    ├── requirements
    │   ├── mariadb
    │   ├── nginx
    │   └── wordpress
    └── secrets
```

---

# Resources
https://wordpress.org/
https://docs.docker.com/manuals/
man
## Docker

* Docker Documentation
* Docker Compose Documentation
* Docker Engine Documentation

## NGINX

* Official NGINX Documentation

## WordPress

* WordPress Developer Documentation

## MariaDB

* MariaDB Documentation