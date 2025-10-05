# 🏗️ ARKA Config Server Dockerfile - Versión Simplificada

# 1. Empezar con la imagen ligera de solo ejecución (JRE)
FROM eclipse-temurin:21-jre-alpine

# Información del contenedor
LABEL maintainer="ARKA Development Team"
LABEL description="ARKA Config Server - Centralized Configuration Management"

# Variables de entorno
ENV JAVA_OPTS="-Xms256m -Xmx512m"
ENV SERVER_PORT=8888
ENV EUREKA_CLIENT_SERVICE_URL_DEFAULTZONE=http://eureka-server:8761/eureka/

# 2. Instalar curl y crear usuario no-root para seguridad
RUN apk add --no-cache curl && \
    addgroup -S spring && adduser -S spring -G spring

# Directorio de trabajo
WORKDIR /app

# 3. Copiar el .jar que YA FUE CONSTRUIDO localmente
COPY config-server/build/libs/*.jar app.jar

# 4. Asignar permisos al usuario no-root
RUN chown spring:spring app.jar

# 5. Usar el usuario no-root
USER spring:spring

# Puerto expuesto
EXPOSE 8888

# 6. Chequeo de salud para que Docker sepa si el servicio está funcionando
HEALTHCHECK --interval=30s --timeout=10s --start-period=40s --retries=3 \
  CMD curl -f http://localhost:8888/actuator/health || exit 1

# 7. Comando de inicio que utiliza las variables de entorno
ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar app.jar"]