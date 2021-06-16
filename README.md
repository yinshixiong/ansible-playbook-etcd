# 安装etcd集装
## 几种状态变量说明
   run_mode == 'Deploy'
   run_mode == 'Stop'
   run_mode == 'Restart'
   run_mode == 'CheckStatus'
   run_mode == 'Remove'

## etcd.ini
### cat etcd.ini
[deploy]
`172.17.174.35`

[etcd]
`172.17.174.224 hostname=etcd1 ipaddr=172.17.174.224`
`172.17.174.225 hostname=etcd2 ipaddr=172.17.174.225`
`172.17.174.226 hostname=etcd3 ipaddr=172.17.174.226`
`172.17.174.227 hostname=etcd4 ipaddr=172.17.174.227`
`172.17.174.228 hostname=etcd5 ipaddr=172.17.174.228`
...
N


### 首次部署时候,由于证书生成在deploy节点,需要将本地的/data/cfsslExtendCluster/下的内容mv走,这个目录存放证书文件和cert-json模板
### 首次部署时候,由于证书生成在deploy节点,需要将本地的/data/cfsslExtendCluster/下的内容mv走,这个目录存放证书文件和cert-json模板
### 首次部署时候,由于证书生成在deploy节点,需要将本地的/data/cfsslExtendCluster/下的内容mv走,这个目录存放证书文件和cert-json模板

### 部署
   ansible-playbook -i etcd.ini etcd.yaml -e "run_mode=Deploy"
### 停止
   ansible-playbook -i etcd.ini etcd.yaml -e "run_mode=Stop"
### 重启
   ansible-playbook -i etcd.ini etcd.yaml -e "run_mode=Restart"
### 检查状态
   ansible-playbook -i etcd.ini etcd.yaml -e "run_mode=CheckStatus"
### 移除
   ansible-playbook -i etcd.ini etcd.yaml -e "run_mode=Remove"

## alias cat /etc/profile.d/alias_for_etcd.sh
### ETCDCTL_API=2 etcdctl --endpoints https://127.0.0.1:2379 --ca-file /etc/ssl/etcd/ssl/ca.crt --cert-file /etc/ssl/etcd/ssl/noHostBindClient.crt --key-file /etc/ssl/etcd/ssl/noHostBindClient-key.crt member list
### ETCDCTL_API=3 etcdctl --endpoints https://127.0.0.1:2379 --cacert="/etc/ssl/etcd/ssl/ca.crt" --cert="/etc/ssl/etcd/ssl/noHostBindClient.crt" --key="/etc/ssl/etcd/ssl/noHostBindClient-key.crt" member list
