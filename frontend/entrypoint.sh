#!/bin/sh

set -e

envsubst < /taiga-front/dist/conf.json.tpl > /taiga-front/dist/conf.json
nginx -g 'daemon off;'
