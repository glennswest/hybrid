#!/bin/bash


domain=$(grep search /etc/resolv.conf | awk '{print $2}')

ps -ef | grep allinone.sh > cmdline.out

systemctl enable dnsmasq.service
systemctl start dnsmasq.service

swapoff -a

subscription-manager repos --disable="*"
subscription-manager repos --enable="rhel-7-server-rpms" --enable="rhel-7-server-extras-rpms" --enable="rhel-7-fast-datapath-rpms" --enable="rhel-7-server-ose-3.9-rpms" --enable="rhel-7-server-ansible-2.4-rpms"
yum -y install wget git net-tools atomic-openshift-utils git net-tools bind-utils iptables-services bridge-utils bash-completion httpd-tools nodejs qemu-img kexec-tools sos psacct docker-1.13.1 ansible
yum -y install --enablerepo="epel" jq


cat <<EOF > /etc/ansible/hosts
[OSEv3:children]
masters
nodes
etcd
new_nodes
new_masters

[OSEv3:vars]
oreg_url=registry.access.redhat.com/openshift3/ose-\${component}:\${version}
openshift_examples_modify_imagestreams=true
openshift_clock_enabled=true
openshift_enable_service_catalog=false
debug_level=2
console_port=8443
docker_udev_workaround=True
openshift_node_debug_level="{{ node_debug_level | default(debug_level, true) }}"
openshift_master_debug_level="{{ master_debug_level | default(debug_level, true) }}"
openshift_master_access_token_max_seconds=2419200
openshift_hosted_router_replicas=3
openshift_hosted_registry_replicas=1
openshift_master_api_port="{{ console_port }}"
openshift_master_console_port="{{ console_port }}"
openshift_override_hostname_check=true
osm_use_cockpit=false
openshift_node_local_quota_per_fsgroup=512Mi
azure_resource_group=${RESOURCEGROUP}
openshift_install_examples=true
deployment_type=openshift-enterprise
openshift_master_identity_providers=[{'name': 'htpasswd_auth', 'login': 'true', 'challenge': 'true', 'kind': 'HTPasswdPasswordIdentityProvider', 'filename': '/etc/origin/master/htpasswd'}]
openshift_master_manage_htpasswd=false

openshift_master_default_subdomain=openshift.ncc9.com
osm_default_subdomain=app.ncc9.com
openshift_use_dnsmasq=true
openshift_public_hostname=openshift.ncc9.com

openshift_master_cluster_method=native
openshift_master_cluster_hostname=openshift.ncc9.com
openshift_master_cluster_public_hostname=openshift.ncc9.com

[masters]
openshift.ncc9.com

[etcd]
openshift.ncc9.com

[new_nodes]
[new_masters]

[nodes]
openshift.ncc9.com
EOF

cat <<EOF > /home/${AUSERNAME}/postinstall.yml
---
- hosts: masters
  vars:
    description: "auth users"
  tasks:
  - name: Create Master Directory
    file: path=/etc/origin/master state=directory
  - name: add initial user to Red Hat OpenShift Container Platform
    shell: htpasswd -c -b /etc/origin/master/htpasswd ${AUSERNAME} ${PASSWORD}

EOF


cat <<EOF > /home/${AUSERNAME}/openshift-install.sh
ansible-playbook /usr/share/ansible/openshift-ansible/playbooks/byo/config.yml < /dev/null

yum -y install atomic-openshift-clients
EOF

./openshift-install.sh
