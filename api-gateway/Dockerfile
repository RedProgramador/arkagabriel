# 🏗️ ARKA API Gateway Dockerfile - Versión Simplificada

FROM eclipse-temurin:21-jre-alpine

LABEL maintainer="ARKA Development Team"
LABEL description="ARKA API Gateway - Entry point for microservices"

# Variables de entorno
ENV JAVA_OPTS="-Xms256m -Xmx512m"
ENV SERVER_PORT=8080
ENV EUREKA_CLIENT_SERVICE_URL_DEFAULTZONE=http://eureka-server:8761/eureka/

# Instalar curl y crear usuario no-root
RUN apk add --no-cache curl && \
    addgroup -S spring && adduser -S spring -G spring

WORKDIR /app

# Copiar el .jar ya construido
COPY api-gateway/build/libs/*.jar app.jar

# Asignar permisos
RUN chown spring:spring app.jar

USER spring:spring

EXPOSE 8080

HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
  CMD curl -f http://localhost:8080/actuator/health || exit 1

ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar app.jar"]
