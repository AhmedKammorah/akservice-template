# @Author: ahmedkammorah
# @Date:   2020-04-13 16:42:40
# @Last Modified by:   ahmedkammorah
# @Last Modified time: 2020-04-13 17:00:38
#!/bin/sh

# AK_IMAGE_NAME=
# AK_SERVICE_NAME=

# Start Changeable Area
SERVICE_NAME=ak-service
DEPLOYMENT_FILE_NAME=kup_deployment
NAME_SPACE=bz-ingress
# End Changeable Area


# delete the old service and deployment
kubectl delete services $SERVICE_NAME --namespace  $NAME_SPACE
kubectl delete deployment $SERVICE_NAME --namespace $NAME_SPACE
# applay the service and deployment
envsubst < ${DEPLOYMENT_FILE_NAME}.yaml | kubectl apply -f - --namespace $NAME_SPACE --validate=false
