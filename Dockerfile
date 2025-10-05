# Dockerfile para la aplicación principal ARKA E-commerce - Versión Simplificada

# 1. Empezar con la imagen ligera de solo ejecución (JRE)
FROM eclipse-temurin:21-jre-alpine

# Metadata
LABEL maintainer="ARKA Development Team"
LABEL version="1.0"
LABEL description="ARKA E-commerce Platform - Main Application"

# Variables de entorno
ENV SPRING_PROFILES_ACTIVE=docker
ENV SERVER_PORT=8888

# 2. Instalar curl para health checks
RUN apk add --no-cache curl

# Directorio de trabajo
WORKDIR /app

# 3. Copiar el .jar que YA FUE CONSTRUIDO localmente desde la carpeta raíz build/libs/
COPY build/libs/*.jar app.jar

# Exponer puerto
EXPOSE 8888

# 4. Chequeo de salud
HEALTHCHECK --interval=30s --timeout=10s --start-period=90s --retries=3 \
    CMD curl -f http://localhost:8888/actuator/health || exit 1

# 5. Comando de inicio
ENTRYPOINT ["java", "-jar", "/app/app.jar"]