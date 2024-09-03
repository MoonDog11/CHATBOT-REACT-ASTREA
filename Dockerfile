# Etapa de construcción
FROM node:lts-alpine AS build

# Configurar el entorno
WORKDIR /app

# Copiar archivos de dependencias del cliente
COPY client/astrea/package.json client/astrea/package-lock.json* ./

# Instalar dependencias
RUN npm install --silent

# Copiar el resto del código fuente del cliente al directorio de trabajo
COPY client/astrea/ ./

# Copiar el archivo init al contenedor
COPY client/astrea/init.sh /init.sh

# Copiar el script de migración si existe
COPY client/astrea/migrate.sh /migrate.sh

# Mostrar los archivos en el directorio de trabajo antes de construir
RUN echo "Archivos en el directorio de trabajo antes de construir:" && ls -la /app

# Construir la aplicación React
RUN npm run build

# Etapa de producción
FROM node:lts-alpine AS production

# Configurar el entorno
WORKDIR /app

# Copiar archivos construidos al contenedor
COPY --from=build /app/build /usr/share/nginx/html

# Copiar el archivo init y scripts de migración al contenedor
COPY --from=build /init.sh /init.sh
COPY --from=build /migrate.sh /migrate.sh

# Copiar el directorio del servidor Node.js
COPY server/ /server

# Cambiar permisos del archivo init
RUN chmod +x /init.sh

# Exponer el puerto en el que Nginx escuchará
EXPOSE 80

# Ejecutar el script init y luego iniciar el servidor Node.js
CMD ["/bin/sh", "-c", "/init.sh"]
