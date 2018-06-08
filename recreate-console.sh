oc login -u system:admin
oc delete project openshift-web-console
sleep 200
oc adm new-project openshift-web-console --node-selector=''
#oc delete dc/webconsole
#oc delete deploy/webconsole
#oc delete svc/webconsole
oc process -f console-template.yaml -p "API_SERVER_CONFIG=$(cat console-config.yaml)" | oc apply -n openshift-web-console -f -


