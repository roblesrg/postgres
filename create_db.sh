#!/bin/bash

# Script para crear una base de datos PostgreSQL y asignar privilegios
# Uso: ./create_db.sh <nombre_base_datos>

if [ "$#" -ne 1 ]; then
    echo "Error: Debes proporcionar el nombre de la base de datos."
    echo "Uso: $0 <nombre_base_datos>"
    exit 1
fi

DB_NAME=$1

# Cargar variables de entorno desde el archivo .env
if [ -f .env ]; then
    export $(grep -v '^#' .env | xargs)
else
    echo "Error: Archivo .env no encontrado."
    exit 1
fi

# Verificar si la base de datos ya existe
DB_EXISTS=$(docker exec $POSTGRES_CONTAINER_NAME psql -U $POSTGRES_USER -d $POSTGRES_DB -tAc "SELECT 1 FROM pg_database WHERE datname = '$DB_NAME';")

if [ "$DB_EXISTS" == "1" ]; then
    echo "La base de datos $DB_NAME ya existe."
    exit 1
fi

echo "Creando base de datos $DB_NAME"
docker exec $POSTGRES_CONTAINER_NAME psql -U $POSTGRES_USER -d $POSTGRES_DB -c "CREATE DATABASE \"$DB_NAME\";"

if [ $? -ne 0 ]; then
    echo "Error: No se pudo crear la base de datos $DB_NAME."
    exit 1
fi

echo "Asignando privilegios"
docker exec $POSTGRES_CONTAINER_NAME psql -U $POSTGRES_USER -d $POSTGRES_DB -c "GRANT ALL PRIVILEGES ON DATABASE \"$DB_NAME\" TO \"$POSTGRES_USER\";"

if [ $? -ne 0 ]; then
    echo "Error: No se pudieron asignar privilegios al usuario"
    exit 1
fi

echo "Base de datos $DB_NAME creada y privilegios asignados"