# Etapa de construcción
FROM node:lts-alpine AS build

# Configurar el entorno
WORKDIR /app

# Copiar archivos de dependencias
COPY client/astrea/package.json client/astrea/package-lock.json* ./

# Instalar dependencias
RUN npm install --silent

# Copiar el resto del código fuente del cliente
COPY client/astrea/ ./

# Mostrar los archivos en el directorio de trabajo
RUN echo "Archivos en el directorio de trabajo después de copiar el código fuente:" && ls -la /app

# Construir la aplicación React
RUN npm run build

# Etapa de producción
FROM nginx:alpine

# Copiar los archivos construidos al contenedor Nginx
COPY --from=build /app/build /usr/share/nginx/html

# Mostrar los archivos en el directorio de Nginx
RUN echo "Archivos en el directorio de Nginx:" && ls -la /usr/share/nginx/html

# Exponer el puerto en el que Nginx escuchará
EXPOSE 80

# Comando por defecto para Nginx
CMD ["nginx", "-g", "daemon off;"]
