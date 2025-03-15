FROM openjdk:21-slim AS builder
# Setting Maven verision
ARG MAVEN_VERSION=3.8.2
# Setting Maven Home directory
ARG MAVEN_HOME=/usr/share/maven
RUN apt-get update && \
    apt-get install -y curl && \
    curl -fsSL https://archive.apache.org/dist/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz | tar -xzC /usr/share && \
    mv /usr/share/apache-maven-${MAVEN_VERSION} ${MAVEN_HOME} && \
    ln -s ${MAVEN_HOME}/bin/mvn /usr/bin/mvn && \
    apt-get remove -y curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*nstall dependencies and Maven
# Setting Environmnet Variables for maven
ENV MAVEN_HOME=${MAVEN_HOME}
ENV PATH=$(MAVEN_HOME}/bin:${PATH}

# Verfiy Maven Installation
RUN mvn -version

WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package

# Stage 2: Run the application
FROM openjdk:21-slim
# Declaring environment variables for Java runtime
ENV HeapMin=512M
ENV HeapMax=532M
ENV MetaSpace=256M
ENV MaxMetaSpace=512M
ENV JVMParameters="" 
WORKDIR /app
COPY --from=builder /app/target/springapp-service.jar springapp-service.jar
EXPOSE 8080
ENTRYPOINT ["sh","-c","java $JVMParameters -jar springapp-service.jar"]
