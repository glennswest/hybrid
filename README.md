# openshift-windows
Windows Nodes in OpenShift

This current is tested on Vmware, with two machines, one running OpenShift 3.9 on RHEL 7.5.
A full openshift subscription is required.

The Windows Node is Windows Server Core 1709.
The Windows node requires it to be enabled for Ansible.
bin/winansible.ps1 set's up the windows node for ansible.

How to Use:

##Repos for Openshift Windows:

Supported
http:/github.com/glennswest/openshift-windows
Upstream:
http://github.com/glennswest/hybrid

Overview:
1. Install two nodes, one with RHEL 7.5 and one with Windows 1703.
2. Setup DNS for both nodes, and search domain so the hosts can be found by both there short name, and there fully qualified name.
3. Make sure the windows node can use DHCP to find its IP address.
4. Make sure the Mac address is unique for the windows node in the first 5 bytes.
5. Login to root, and install git
6. git clone repo

