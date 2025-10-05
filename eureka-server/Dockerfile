# Eureka Server Dockerfile - Versión Simplificada

# 1. Usar solo la imagen de ejecución (JRE), que es más ligera.
FROM eclipse-temurin:21-jre-alpine

# 2. Instalar curl para health checks y crear el usuario de la aplicación.
RUN apk add --no-cache curl && \
    addgroup -S arka && adduser -S arka -G arka

WORKDIR /app

# 3. Copiar el .jar que YA FUE CONSTRUIDO localmente.
COPY eureka-server/build/libs/*.jar app.jar

# 4. Asignar permisos al nuevo usuario.
RUN chown -R arka:arka /app

# 5. Cambiar al usuario sin privilegios.
USER arka

EXPOSE 8761

# 6. Definir el chequeo de salud.
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
  CMD curl -f http://localhost:8761/actuator/health || exit 1

# 7. Definir el comando de arranque.
ENTRYPOINT ["java", "-jar", "app.jar"]