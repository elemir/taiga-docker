from os import environ
from .common import *

HOSTNAME = environ['HOSTNAME']
RABBITMQ_PASS = environ['RABBITMQ_PASS']
MEDIA_URL = "http://{}/media/".format(HOSTNAME)
STATIC_URL = "http://{}/static/".format(HOSTNAME)
SITES["front"]["scheme"] = "http"
SITES["front"]["domain"] = HOSTNAME

SECRET_KEY = environ['SECRET_KEY']

DEBUG = False
PUBLIC_REGISTER_ENABLED = False

DEFAULT_FROM_EMAIL = "no-reply@{}".format(HOSTNAME)
SERVER_EMAIL = DEFAULT_FROM_EMAIL

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': 'taiga',
        'USER': 'taiga',
        'PASSWORD': environ['POSTGRES_PASSWORD'],
        'HOST': 'postgres',
        'PORT': '',
    }
}

CELERY_ENABLED = True

EVENTS_PUSH_BACKEND = "taiga.events.backends.rabbitmq.EventsPushBackend"
EVENTS_PUSH_BACKEND_OPTIONS = {"url": "amqp://taiga:{}@rabbitmq:5672/taiga".format(RABBITMQ_PASS)}

# Uncomment and populate with proper connection parameters
# for enable email sending. EMAIL_HOST_USER should end by @domain.tld
#EMAIL_BACKEND = "django.core.mail.backends.smtp.EmailBackend"
#EMAIL_USE_TLS = False
#EMAIL_HOST = "localhost"
#EMAIL_HOST_USER = ""
#EMAIL_HOST_PASSWORD = ""
#EMAIL_PORT = 25

# Uncomment and populate with proper connection parameters
# for enable github login/singin.
#GITHUB_API_CLIENT_ID = "yourgithubclientid"
#GITHUB_API_CLIENT_SECRET = "yourgithubclientsecret"
