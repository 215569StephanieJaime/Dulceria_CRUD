
from .base import *


SECRET_KEY = 'django-insecure-^kadl*fgz)xq319+vdn1n(-1r+xr_gol0t#xt63b3ma*5)%$sp'

DEBUG = True

ALLOWED_HOSTS = ['localhost', '127.0.0.1']

# Database
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': BASE_DIR / 'db.sqlite3',
    }
}
