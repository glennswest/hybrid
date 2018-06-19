nssm set kubelet Application C:\k\hybrid\bin\start_kubeovn.ps1
nssm set kubelet AppDirectory C:\k\hybrid\bin
nssm set kubelet AppParameters server
nssm set kubelet DisplayName Kubelet
nssm set kubelet Description Kubelet OVN For OpenShift
nssm set kubelet Start SERVICE_AUTO_START

