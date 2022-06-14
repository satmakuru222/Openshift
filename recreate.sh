#!/bin/sh

oc delete project dockerrhsso
sleep 5
oc new-project dockerrhsso
oc new-build --name rhssodocker --binary --strategy docker
oc start-build rhssodocker --from-dir=. --env=ORACLE_SERVICE_HOST= --env=ORACLE_SERVICE_PORT= --env=ORACLE_SERVICE_NAME=
sleep 10
oc get pods
sleep 5
oc logs -f rhssodocker-1-build
oc get is
oc set image-lookup rhssodocker
oc run rhssodocker --image=rhssodocker
oc get pods
oc logs -f rhssodocker
