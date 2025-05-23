#!/usr/bin/env bash
set -o errexit

# Instalar dependencias
pip install -r requirements.txt

# Configurar static files
python manage.py collectstatic --no-input --clear

# Aplicar migraciones
python manage.py migrate

# Crear superusuario con username (versión confirmada como funcional)
python manage.py shell -c "
from django.contrib.auth import get_user_model
User = get_user_model()
User.objects.create_superuser(
    username='$DJANGO_SUPERUSER_USERNAME',
    email='$DJANGO_SUPERUSER_EMAIL',
    password='$DJANGO_SUPERUSER_PASSWORD'
) if not User.objects.filter(username='$DJANGO_SUPERUSER_USERNAME').exists() else None"