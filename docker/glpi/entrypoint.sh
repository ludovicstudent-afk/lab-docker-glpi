#!/bin/bash
set -e

# 1. Attendre que la DB (port 3306) soit disponible — timeout 60s
DB_HOST=${GLPI_DB_HOST:-db}
echo "Attente de la base de données ($DB_HOST:3306)..."
timeout=60
while ! nc -z "$DB_HOST" 3306; do
    timeout=$((timeout - 1))
    if [ $timeout -le 0 ]; then
        echo "Erreur : base de données non disponible après 60s"
        exit 1
    fi
    sleep 1
done
echo "Base de données disponible ✓"

# 2. Attendre que Redis (port 6379) soit disponible — timeout 30s
echo "Attente de Redis (redis:6379)..."
timeout=30
while ! nc -z redis 6379; do
    timeout=$((timeout - 1))
    if [ $timeout -le 0 ]; then
        echo "Erreur : Redis non disponible après 30s"
        exit 1
    fi
    sleep 1
done
echo "Redis disponible ✓"

# 3. Appliquer chown www-data sur les dossiers files et config
chown -R www-data:www-data /var/www/html/files /var/www/html/config

# 4. Appliquer les bons chmod (755 pour files, 775 pour config)
chmod -R 755 /var/www/html/files
chmod -R 775 /var/www/html/config

# 5. Lancer Apache en foreground avec exec
exec apache2-foreground
