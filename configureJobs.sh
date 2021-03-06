#!/bin/bash -e

# warte auf Jenkins Start
sleep 1m

echo "Creating jenkins build pipeline job $JP_PROJECT_NAME"

java -jar /var/jenkins_home/war/WEB-INF/jenkins-cli.jar -s http://localhost:8080/ create-job $JP_PROJECT_NAME < /var/jenkins_home/skripte/job-template.xml --username admin --password `/bin/cat /var/jenkins_home/secrets/initialAdminPassword`

echo "Creating jenkins build pipeline job has finished"

# Wartepuffer falls Skript background threads anstösst
sleep 10s

# build starten
echo "Pipeline build starting"
curl http://localhost:8080/job/$JP_PROJECT_NAME/build?token=start321 --user admin:`/bin/cat /var/jenkins_home/secrets/initialAdminPassword`

echo "list plugins"
java -jar /var/jenkins_home/war/WEB-INF/jenkins-cli.jar -s http://localhost:8080/ list-plugins --username admin --password `/bin/cat /var/jenkins_home/secrets/initialAdminPassword`

echo I am waiting for shutdown: $JP_WAIT_FOR_SHUTDOWN
sleep $JP_WAIT_FOR_SHUTDOWN

echo "Pipeline configuration finished"
java -jar /var/jenkins_home/war/WEB-INF/jenkins-cli.jar -s http://localhost:8080/ safe-shutdown --username admin --password `/bin/cat /var/jenkins_home/secrets/initialAdminPassword`

exit
