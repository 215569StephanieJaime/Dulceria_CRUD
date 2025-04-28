import os


if os.environ.get('DJANGO_SETTINGS_MODULE') != 'app.settings.production':
    from .local import *
else:
    from .production import *