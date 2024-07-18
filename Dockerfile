# 使用 Maven 進行構建
FROM maven:3.8.5-openjdk-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package

# 使用 OpenJDK 運行構建的 JAR 文件
FROM openjdk:17-jdk-alpine
VOLUME /tmp
ARG JAR_FILE=/app/target/*.jar
COPY --from=build ${JAR_FILE} app.jar
ENTRYPOINT ["java","-jar","/app.jar"]