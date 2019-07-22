#!/bin/sh

set -e

python manage.py migrate --noinput
python manage.py loaddata initial_user
python manage.py loaddata initial_project_templates
python manage.py compilemessages
python manage.py collectstatic --noinput

python manage.py runserver 0.0.0.0:80
