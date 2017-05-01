#!/bin/bash -e

# warte auf Jenkins Start
sleep 1m

echo "INFO: CREATE PIPLINE JOB - BEGIN"

java -jar /var/jenkins_home/war/WEB-INF/jenkins-cli.jar -s http://localhost:8080/ create-job pipeline < /var/jenkins_home/skripte/job.xml --username admin --password `/bin/cat /var/jenkins_home/secrets/initialAdminPassword`

echo "INFO: CREATE PIPLINE JOB - END"

# Wartepuffer falls Skript background threads anstösst
sleep 10s

# build starten
curl http://localhost:8080/job/pipeline/build?token=start321 --user admin:`/bin/cat /var/jenkins_home/secrets/initialAdminPassword`

echo "CONFIGURATION FINISHED"

# sleep 1m
# java -jar /var/jenkins_home/war/WEB-INF/jenkins-cli.jar safe-shutdown --username admin --password `/bin/cat /var/jenkins_home/secrets/initialAdminPassword` -s http://localhost:8080/ build pipeline

exit
