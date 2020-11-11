FROM adoptopenjdk:11-jre-openj9
LABEL org.opencontainers.image.source https://github.com/OpenExperienceCloud/cloud-openexperience-content

# Configure the parameters used for seeding and running the repository
ARG SEED_PARAMS="-f /opt/oec/setup/features/*.slingosgifeature"
ENV SEED_PARAMS=${SEED_PARAMS}
ARG RUNTIME_PARAMS="-f /opt/oec/feaures/*.slingosgifeature"
ENV RUNTIME_PARAMS=${RUNTIME_PARAMS}

# Configure directory
WORKDIR /opt/oec
COPY oec/ /opt/oec/

# Copy the Maven settings.xml file for resolving Sling Launchpad artifacts
COPY settings.xml /root/.m2/settings.xml