C:\bin\ovnkube.exe --init-node $env:computername  --config-file "C:\Program Files\Cloudbase Solutions\Open vSwitch\conf\ovn_k8s.conf" -cluster-subnet 10.128.0.0/14 -cni-conf-dir="C:\k\hybrid\cni" -service-cluster-ip-range 172.30.0.0/16
