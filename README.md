# taiga.io dockerization

This repository contains docker files and docker-compose for taiga.io deployment

## How to use it?

1. Install [docker](https://docs.docker.com/install/) and [docker-compose](https://docs.docker.com/compose/install/)
2. Write .env file like this:
```
POSTGRES_PASSWORD=some_password_for_postgres
RABBITMQ_PASS=some_password_for_rabbitmq
SECRET_KEY=some_big_and_very_secret_key
HOSTNAME=yourdomain.com
```
3. Run `docker-compose build` and `docker-compose up -d`
