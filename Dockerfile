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

# Mostrar los archivos en el directorio de trabajo antes de construir
RUN echo "Archivos en el directorio de trabajo antes de construir:" && ls -la /app

# Construir la aplicación React
RUN npm run build

# Etapa de producción
FROM nginx:alpine

# Copiar los archivos construidos al contenedor Nginx
COPY --from=build /app/build /usr/share/nginx/html

# Copiar los scripts init y migrate al contenedor
COPY init.sh /init.sh
COPY migrate.sh /migrate.sh

# Cambiar permisos de los scripts
RUN chmod +x /init.sh /migrate.sh

# Exponer el puerto en el que Nginx escuchará
EXPOSE 80

# Ejecutar el script init
CMD ["/bin/sh", "-c", "/init.sh"]
