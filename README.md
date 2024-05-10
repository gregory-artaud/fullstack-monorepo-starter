# fullstack-monorepo-starter

[![Build and test](https://github.com/gregory-artaud/fullstack-monorepo-starter/actions/workflows/ci.yml/badge.svg)](https://github.com/gregory-artaud/fullstack-monorepo-starter/actions/workflows/ci.yml)

## Requirements

`docker` and `docker compose` : https://docs.docker.com/engine/install/

`transcrypt` : https://github.com/elasticdog/transcrypt

## How to set up

```bash
pnpm install
```

## How to launch development environment

In a terminal run

```bash
pnpm run dev
```

This launches a postgres instance in docker and build libraries in watch mode.

In another shell run

```bash
pnpm run dev:start
```

## How to deploy

### Manually

This project is meant to be run on a single VPS (AWS EC2 in the example).
Here is a schema showing what the compose file is deploying when I use this on AWS.

![deployment_aws_schema](assets/deployment_aws.png)

The following instructions are not supposed to be run locally, connect to your deployment machine first.

Clone the project

```bash
git clone https://github.com/gregory-artaud/fullstack-monorepo-starter.git
```

I assume you already have a domain name and added a A record to your deployment machine's IP.

Replace "fullstack-starter.gregory-artaud.fr" by your domain name in the `caddy-webserver`'s `Caddyfile`

```bash
sed -i 's/fullstack-starter.gregory-artaud.fr/<domain_name>/g' docker/caddy-webserver/Caddyfile
```

On the server, run:

```bash
docker compose -f compose.prod.yaml up -d --build
```

### Using continuous deployment

I assume you already have a deployment machine, a database instance, a domain name and added a A record to your deployment machine's IP.

If you don't already have the infrastructure, you can use the terraform configuration.
To use it you must install terraform and set up the environment to use aws. (https://developer.hashicorp.com/terraform/tutorials/aws-get-started/aws-build)

Then deploy the infrastructure

```bash
cd terraform
terraform deploy
```

On github, you must set the following secrets

- `TRANSCRYPT_KEY`: the key you got when you set up transcrypt for the repository
- `EC2_PRODUCTION_HOST`: the IP or hostname of your deployment machine
- `EC2_PRODUCTION_SSH_KEY`: the OPENSSH private key to connect to your deployment machine

Replace "fullstack-starter.gregory-artaud.fr" by your domain name in the `caddy-webserver`'s `Caddyfile`

```bash
sed -i 's/fullstack-starter.gregory-artaud.fr/<your_domain_name>/g' docker/caddy-webserver/Caddyfile
```

Push this change to production

```bash
git checkout production
git add .
git commit -m 'chore: changed domain name'
git push
```

Go to `https://<your_domain_name>`, and your app should be deployed.

After that, any push to the production branch will trigger a deploy.

## What's next

- [ ] Dependabot in Github Actions with automerge job
