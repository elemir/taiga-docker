#!/bin/sh

set -e

envsubst < /taiga-events/config.json.tpl > /taiga-events/config.json
/taiga-events/node_modules/coffeescript/bin/coffee /taiga-events/index.coffee
