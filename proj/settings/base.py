import os

SECRET_KEY = 'change_me'
BASE_DIR = os.path.dirname(os.path.dirname(os.path.dirname(__file__)))
DEBUG = True

ALLOWED_HOSTS = ['*']

INSTALLED_APPS = (
    'django.contrib.staticfiles',
    'rest_framework',
    'app',
)

MIDDLEWARE_CLASSES = ()

ROOT_URLCONF = 'proj.urls'

TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [],
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                "django.core.context_processors.static",
            ],
        },
    },
]

WSGI_APPLICATION = 'proj.wsgi.application'

LANGUAGE_CODE = 'ru-RU'
STATICFILES_STORAGE = 'django.contrib.staticfiles.storage.ManifestStaticFilesStorage'

TIME_ZONE = 'UTC'
STATIC_URL = '/static/'


STATICFILES_DIRS = (
    os.path.join(BASE_DIR, 'frontend/dist'),
)

