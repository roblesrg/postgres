# Contenedor de Postgres


### Requisitos previos

- Docker instalado y configurado.
- Archivo `.env` configurado con las variables necesarias.

Puedes usar el archivo env.example como referencia.
```env
POSTGRES_PORT=5432
POSTGRES_DB=nombre_base_datos
POSTGRES_USER=tu_usuario
POSTGRES_PASSWORD=tu_contraseña
POSTGRES_CONTAINER_NAME=nombre_del_contenedor
```

## Docker
1. construcción del contenedor
   ```sh
   docker compose up -d
   ```

## Script de creación de base de datos PostgreSQL

## Uso

1. Ejecuta el script con el siguiente comando: `./create_db.sh <nombre_base_datos>`
