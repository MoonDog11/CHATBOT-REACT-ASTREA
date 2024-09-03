# Etapa de construcción
FROM node:lts-alpine AS build

# Configurar el entorno
WORKDIR /app

# Copiar archivos de dependencias
COPY client/astrea/package.json client/astrea/package-lock.json* ./
RUN npm install --silent

# Copiar el resto del código fuente
COPY client/astrea/ ./
RUN npm run build

# Etapa de producción
FROM nginx:alpine

# Copiar los archivos construidos al contenedor Nginx
COPY --from=build /app/build /usr/share/nginx/html

# Exponer el puerto en el que Nginx escuchará
EXPOSE 80

# Comando por defecto
CMD ["nginx", "-g", "daemon off;"]
