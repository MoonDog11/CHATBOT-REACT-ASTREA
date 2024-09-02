FROM node:lts-alpine

# Configurar el entorno en modo producción
ENV NODE_ENV=production

# Crear y establecer el directorio de trabajo
WORKDIR /app

# Copiar archivos de dependencias
COPY server/package.json server/package-lock.json* server/npm-shrinkwrap.json* ./

# Instalar dependencias
RUN npm install --production --silent

# Copiar el resto del código fuente al directorio de trabajo
COPY . .

# Exponer el puerto en el que la aplicación escuchará
EXPOSE 3001

# Comando para iniciar la aplicación
CMD ["npm", "start"]
