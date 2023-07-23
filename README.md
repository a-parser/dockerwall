# DockerWall

### Damn Simple Inbound Firewall for Docker Compose

Is configuring a firewall to allow only certain hosts to access your container proving to be a hassle? DockerWall offers a streamlined solution. Now you can conveniently define all your access rules in just a few lines of your `docker-compose.yml` file.

## Key Features:

- **Non-intrusive**: DockerWall does not interfere with your host network or your host iptables rules, providing a clean, isolated functionality.
- **Convenience**: The allowance list for network access can be stored directly in your `docker-compose.yml` file, centralizing your configuration.
- **Versatility**: DockerWall supports both IP addresses and subnets, giving you flexibility in defining access rules.

## Sample Usage:

Below is an example showing how DockerWall can be incorporated into your Docker configuration:

```yml
version: '3'
services:
  database:
    image: postgres
    network_mode: "service:firewall"
  firewall:
    image: aparser/dockerwall
    cap_add:
      - NET_ADMIN
    ports:
      - 0.0.0.0:5432:5432
    environment:
      - ALLOW_FROM=8.8.8.8 1.1.1.1 192.168.0.0/24
```

In this example, the `ALLOW_FROM` environment variable is used to define a list of IP addresses and subnets that are permitted access to the container. Please note that it's important to specify either 0.0.0.0 or a specific IPv4 address. This prevents the proxying of IPv6 connections in Docker.


Copyright (c) 2023 https://a-parser.com/