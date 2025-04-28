#!/usr/bin/env bash
# Script de compilación para Render
# Salir en caso de error
set -o errexit

#Moverse al directorio correcto
cd app

#Instalar dependencias
pip install -r requirements.txt

#Recolectar archivos estáticos
python manage.py collectstatic --no-input

#Aplicar migraciones de base de datos
python manage.py migrate

#Crear superusuario
#Usamos script de Python para crear el superusuario de manera no interactiva
cat > create_superuser.py << EOF
import os
import django

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'app.settings.production')
django.setup()

from django.contrib.auth.models import User
from django.db.utils import IntegrityError

DJANGO_SUPERUSER_USERNAME = os.environ.get('DJANGO_SUPERUSER_USERNAME', 'admin')
DJANGO_SUPERUSER_EMAIL = os.environ.get('DJANGO_SUPERUSER_EMAIL', 'admin@example.com')
DJANGO_SUPERUSER_PASSWORD = os.environ.get('DJANGO_SUPERUSER_PASSWORD')

if not DJANGO_SUPERUSER_PASSWORD:
    print('Error: DJANGO_SUPERUSER_PASSWORD environment variable is not set')
    exit(1)

try:
    superuser = User.objects.create_superuser(
        username=DJANGO_SUPERUSER_USERNAME,
        email=DJANGO_SUPERUSER_EMAIL,
        password=DJANGO_SUPERUSER_PASSWORD
    )
    print(f'Superuser {superuser.username} created successfully')
except IntegrityError:
    print(f'Superuser {DJANGO_SUPERUSER_USERNAME} already exists, updating password')
    superuser = User.objects.get(username=DJANGO_SUPERUSER_USERNAME)
    superuser.set_password(DJANGO_SUPERUSER_PASSWORD)
    superuser.email = DJANGO_SUPERUSER_EMAIL
    superuser.save()
    print(f'Superuser {superuser.username} updated successfully')
EOF

#Ejecutar el script para crear el superusuario
python create_superuser.py

#Eliminar el script temporal
rm create_superuser.py
#!/usr/bin/env bash

set -o errexit


cd app


pip install -r requirements.txt


python manage.py collectstatic --no-input


python manage.py migrate


cat > create_superuser.py << EOF
import os
import django

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'app.settings.production')
django.setup()

from django.contrib.auth.models import User
from django.db.utils import IntegrityError

DJANGO_SUPERUSER_USERNAME = os.environ.get('DJANGO_SUPERUSER_USERNAME', 'admin')
DJANGO_SUPERUSER_EMAIL = os.environ.get('DJANGO_SUPERUSER_EMAIL', 'admin@example.com')
DJANGO_SUPERUSER_PASSWORD = os.environ.get('DJANGO_SUPERUSER_PASSWORD')

if not DJANGO_SUPERUSER_PASSWORD:
    print('Error: DJANGO_SUPERUSER_PASSWORD environment variable is not set')
    exit(1)

try:
    superuser = User.objects.create_superuser(
        username=DJANGO_SUPERUSER_USERNAME,
        email=DJANGO_SUPERUSER_EMAIL,
        password=DJANGO_SUPERUSER_PASSWORD
    )
    print(f'Superuser {superuser.username} created successfully')
except IntegrityError:
    print(f'Superuser {DJANGO_SUPERUSER_USERNAME} already exists, updating password')
    superuser = User.objects.get(username=DJANGO_SUPERUSER_USERNAME)
    superuser.set_password(DJANGO_SUPERUSER_PASSWORD)
    superuser.email = DJANGO_SUPERUSER_EMAIL
    superuser.save()
    print(f'Superuser {superuser.username} updated successfully')
EOF

python create_superuser.py

rm create_superuser.py
