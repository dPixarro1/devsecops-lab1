# 1. Usar imagen base oficial, ligera y orientada a seguridad (Alpine Linux)
FROM node:20-alpine

# 2. Crear un directorio de trabajo seguro
WORKDIR /app

# 3. Copiar archivos de dependencias primero para optimizar capas de cache
COPY package*.json ./

# 4. Instalar solo las dependencias de produccion necesarias
RUN npm ci --only=production

# 5. Copiar el codigo fuente restante
COPY src/ ./src/

# 6. BUENA PRACTICA CRITICA: No ejecutar como usuario root
# Node.js Alpine incluye por defecto un usuario sin privilegios llamado 'node'
USER node

# 7. Exponer el puerto de la aplicacion
EXPOSE 3000

# 8. Comando de ejecucion por defecto
CMD ["node", "src/index.js"]
