# Etapa de construcción de la aplicación React
FROM node:lts-alpine AS build

# Configurar el directorio de trabajo
WORKDIR /app

# Copiar archivos de dependencias y instalar
COPY client/astrea/package.json client/astrea/package-lock.json* ./
RUN npm install --silent

# Copiar el resto del código fuente y construir la aplicación
COPY client/astrea/ ./
RUN npm run build

# Etapa de producción para servir la aplicación React con Nginx
FROM nginx:alpine

# Copiar los archivos construidos desde la etapa de construcción
COPY --from=build /app/build /usr/share/nginx/html

# Exponer el puerto en el que Nginx escuchará
EXPOSE 80

# Comando por defecto para iniciar Nginx
CMD ["nginx", "-g", "daemon off;"]
