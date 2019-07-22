ARG PYTHON_VERSION=3.6.9
ARG NGINX_VERSION=1.17.1
ARG TAIGA_VERSION=4.2.10
ARG NODE_VERSION=8.6.0

FROM python:${PYTHON_VERSION}-alpine AS backend

WORKDIR /

RUN : \
    && apk add git gcc musl-dev libffi-dev postgresql-dev libxml2-dev libxslt-dev libjpeg-turbo-dev gettext \
    && git clone https://github.com/taigaio/taiga-back.git taiga-back \
    && cd taiga-back \
    && git checkout ${TAIGA_VERSION} \
    && pip install -r requirements.txt \
    ;

COPY ./backend/local.py /taiga-back/settings/
COPY ./backend/entrypoint.sh /

WORKDIR /taiga-back

EXPOSE 80

ENTRYPOINT ["/entrypoint.sh"]

FROM nginx:${NGINX_VERSION}-alpine AS frontend

WORKDIR /

RUN : \
    && apk add git gettext \
    && git clone https://github.com/taigaio/taiga-front-dist.git taiga-front \
    && cd taiga-front \
    && git checkout ${TAIGA_VERSION} \
    ;

COPY ./frontend/default.conf /etc/nginx/conf.d/
COPY ./frontend/conf.json.tpl /taiga-front/dist/
COPY ./frontend/entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]

FROM node:${NODE_VERSION}-alpine AS events

WORKDIR /

RUN : \
    && apk add --no-cache git gettext \
    && git clone https://github.com/taigaio/taiga-events.git taiga-events \
    && cd taiga-events \
    && git checkout ${TAIGA_VERSION} \
    && npm install \
    ;

COPY ./events/config.json.tpl /taiga-events/
COPY ./events/entrypoint.sh /

WORKDIR /taiga-events
EXPOSE 80

ENTRYPOINT ["/entrypoint.sh"]
