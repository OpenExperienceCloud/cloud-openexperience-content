FROM adoptopenjdk:11-jre-openj9
LABEL org.opencontainers.image.source https://github.com/OpenExperienceCloud/cloud-openexperience-content

# Configure directory
WORKDIR /opt/oec
COPY oec/ /opt/oec/

# Copy the Maven settings.xml file for resolving Sling Launchpad artifacts
COPY settings.xml /root/.m2/settings.xml