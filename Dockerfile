# Etapa de construcción
FROM node:lts-alpine AS build

# Configurar el entorno en modo producción
ENV NODE_ENV=production

# Crear y establecer el directorio de trabajo
WORKDIR /app

# Copiar archivos de dependencias del cliente
COPY client/astrea/package.json client/astrea/package-lock.json* ./

# Instalar dependencias
RUN npm install --silent

# Copiar el resto del código fuente del cliente al directorio de trabajo
COPY client/astrea/ ./

# Construir la aplicación React
RUN npm run build

# Etapa de producción
FROM nginx:alpine

# Copiar los archivos construidos al contenedor Nginx
COPY --from=build /app/build /usr/share/nginx/html

# Exponer el puerto en el que Nginx escuchará
EXPOSE 80

# Comando por defecto para Nginx
CMD ["nginx", "-g", "daemon off;"]
