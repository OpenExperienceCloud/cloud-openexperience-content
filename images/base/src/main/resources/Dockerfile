FROM adoptopenjdk:11-jre-openj9
LABEL org.opencontainers.image.source https://github.com/OpenExperienceCloud/cloud-openexperience-content

# Configure directories
WORKDIR /opt/oec

COPY oec/ /opt/oec/

RUN mkdir -p /opt/custom/seed && mkdir -p /opt/custom/runtime \
    mkdir -p /opt/secrets/seed && mkdir -p /opt/secrets/runtime