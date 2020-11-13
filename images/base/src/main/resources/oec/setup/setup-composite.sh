#!/bin/bash
#
#		 Licensed to the Apache Software Foundation (ASF) under one or more contributor license
#        agreements. See the NOTICE file distributed with this work for additional information
#        regarding copyright ownership. The ASF licenses this file to you under the Apache License,
#        Version 2.0 (the "License"); you may not use this file except in compliance with the
#        License. You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0
#        Unless required by applicable law or agreed to in writing, software distributed under the
#        License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND,
#        either express or implied. See the License for the specific language governing permissions
#        and limitations under the License.
#

SLING_AUTH="${SLING_AUTH:-'admin:admin'}"
DEFAULT_COMPOSITE_SEED_FEATURES="/opt/oec/setup/features/*.slingosgifeature"
COMPOSITE_SEED_FEATURES="${COMPOSITE_SEED_FEATURES:-${DEFAULT_COMPOSITE_SEED_FEATURES}}"
DEFAULT_MAVEN_REPOS="file:///root/.m2/repository,https://repo.maven.apache.org/maven2,https://repository.apache.org/content/groups/snapshots,https://repository.apache.org/snapshots,https://openexperiencecloud.jfrog.io/artifactory/maven/"
MAVEN_REPOSITORIES="${MAVEN_REPOSITORIES:-${DEFAULT_MAVEN_REPOS}}"

echo "Creating composite seed..."
java -jar org.apache.sling.feature.launcher.jar -f ${COMPOSITE_SEED_FEATURES} -u ${MAVEN_REPOSITORIES} &
SLING_PID=$!
echo "Sling PID: ${SLING_PID}"

sleep 30s
STARTED=1
for i in {1..50}; do
    echo "[${i}/50]: Checking to see if started with username: ${SLING_USERNAME}..."
    STATUS=$(curl -4 -s -o /dev/null -w "%{http_code}" -u${SLING_USERNAME}:${SLING_PASSWORD} "http://localhost:8080/system/health.txt?tags=systemalive")
    echo "Retrieved status: ${STATUS}"
    if [ $STATUS -eq 200 ]; then
        STARTED=0
        break
    fi
    sleep 30s
done
sleep 30s
kill $SLING_PID
echo "Waiting for instance to stop..."
sleep 30s

if [ $STARTED -eq 1 ]; then
    echo "Failed to seed sling repository!"
    exit 2
else
    echo "Cleaning up seeding..."
    rm -rf /opt/oec/launcher/framework /opt/oec/launcher/logs \
        /opt/oec/launcher/repository /opt/oec/launcher/resources \
        /opt/oec/seed /opt/oec/setup /opt/custom/seed
    ln -s /opt/oec/launcher/composite/repository-libs/segmentstore \
        /opt/oec/launcher/composite/repository-libs/segmentstore-composite-mount-libs
fi
echo "Repository seeded successfully!"