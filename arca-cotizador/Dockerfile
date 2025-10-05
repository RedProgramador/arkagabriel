# Cotizador Dockerfile - Versión Simplificada

# 1. Empezar con la imagen ligera de solo ejecución (JRE)
FROM eclipse-temurin:21-jre-alpine

# 2. Instalar curl y crear el usuario de la aplicación
RUN apk add --no-cache curl && \
    addgroup -S arka && adduser -S arka -G arka

WORKDIR /app

# 3. Copiar el .jar que YA FUE CONSTRUIDO localmente
COPY arca-cotizador/build/libs/*.jar app.jar

# 4. Crear directorio de datos y asignar permisos
RUN mkdir -p /app/data && \
    chown -R arka:arka /app

# 5. Cambiar al usuario sin privilegios
USER arka

EXPOSE 8083

# 6. Chequeo de salud
HEALTHCHECK --interval=30s --timeout=10s --start-period=90s --retries=3 \
  CMD curl -f http://localhost:8083/actuator/health || exit 1

# 7. Comando de arranque
ENTRYPOINT ["java", "-jar", "app.jar"]