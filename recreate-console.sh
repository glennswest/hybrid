oc login -u system:admin
oc delete project openshift-web-console
sleep 200
oc adm new-project openshift-web-console --node-selector=''
oc process -f console-template.yaml -p "API_SERVER_CONFIG=$(cat console-config.yaml)" | oc apply -n openshift-web-console -f -
sleep 10
#oc expose service/webconsole --hostname=gswmon.southcentralus.cloudapp.azure.com --path=/console --port=443
sleep 10
#oc create route edge  --service service/webconsole --hostname=gswmon.southcentralus.cloudapp.azure.com --path=/console --port=8443  --cert=/etc/origin/master/ca.crt --key=/etc/origin/master/ca.key --ca-cert=/etc/origin/master/ca.crt 
