FROM node:lts-alpine

# Configurar el entorno en modo producción
ENV NODE_ENV=production

# Establecer el directorio de trabajo en la raíz
WORKDIR /

# Copiar archivos de dependencias
COPY package.json package-lock.json* npm-shrinkwrap.json* ./

# Instalar dependencias en el directorio de trabajo (raíz)
RUN npm install --production --silent

# Copiar el resto del código fuente al directorio de trabajo (raíz)
COPY . .

# Exponer el puerto en el que la aplicación escuchará
EXPOSE 3001

# Cambiar el propietario de los archivos al usuario node (opcional)
RUN chown -R node /usr/src/app

# Cambiar al usuario node (opcional, si es necesario)
USER node

# Comando para iniciar la aplicación
CMD ["npm", "start"]
