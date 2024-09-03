# Etapa de construcción
FROM node:lts-alpine AS build

# Configurar el entorno
WORKDIR /app

# Copiar archivos de dependencias
COPY client/astrea/package.json client/astrea/package-lock.json* ./
RUN npm install --silent

# Copiar el resto del código fuente
COPY client/astrea/ ./

# Agregar un comando para verificar que los archivos se copian correctamente
RUN echo "Contenido de /app:"
RUN ls -la /app
RUN echo "Contenido de /app/build:"
RUN ls -la /app/build

# Construir la aplicación
RUN npm run build

# Agregar un comando para verificar el contenido después de la construcción
RUN echo "Contenido de /app/build después de npm run build:"
RUN ls -la /app/build

# Etapa de producción
FROM nginx:alpine

# Copiar los archivos construidos al contenedor Nginx
COPY --from=build /app/build /usr/share/nginx/html

# Agregar comandos para verificar que los archivos se copian correctamente
RUN echo "Contenido de /usr/share/nginx/html:"
RUN ls -la /usr/share/nginx/html

# Exponer el puerto en el que Nginx escuchará
EXPOSE 80

# Comando por defecto
CMD ["nginx", "-g", "daemon off;"]
