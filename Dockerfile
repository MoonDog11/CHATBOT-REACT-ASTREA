# Build stage
FROM node:lts-alpine as build
WORKDIR /app

# Copiar archivos package.json y package-lock.json
COPY client/astrea/package.json client/astrea/package-lock.json* ./

# Agregar logging para verificar archivos copiados
RUN echo "Contenido del directorio actual después de copiar package.json y package-lock.json:" && ls -l

# Instalar dependencias
RUN npm install

# Copiar el resto del código fuente
COPY client/astrea/ ./

# Agregar logging para verificar el contenido del directorio
RUN echo "Contenido del directorio actual después de copiar todo el código fuente:" && ls -l

# Construir la aplicación
RUN npm run build

# Serve stage
FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 80
