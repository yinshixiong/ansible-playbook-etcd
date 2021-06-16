# 确认已备份后执行
# 备份脚本
backupPath=/data/backup_etcd
mkdir -p $backupPath/$(date +%Y-%m-%d)

ETCDCTL_API=3 /usr/local/bin/etcdctl snapshot save ${backupPath}/$(date +%Y-%m-%d)/snapshot.db --cacert="/etc/ssl/etcd/ssl/ca.crt" --cert="/etc/ssl/etcd/ssl/client.crt" --key="/etc/ssl/etcd/ssl/client-key.crt" --endpoints=127.0.0.1:2379

1. 停止集群 
   ansible-playbook -i etcd.ini etcd.yaml -e run_mode=Stop

2. 删除成员信息
   rm -rf /data/etcd/data/member

3. 将备份文件导出
   /data/backup_etcd/$(date +%Y-%m-%d)/snapshot.db

4. 删除各个节点/tmp/下etcd目录
   rm -rf /tmp/etcd1.etcd

4. 恢复
TMP_NODES: "{% for h in groups['etcd'] %}{{ hostvars[h]['NODE_NAME'] }}=https://{{ h }}:2380,{% endfor %}"
ETCD_NODES: "{{ TMP_NODES.rstrip(',') }}"
    cd /opt &&
    ETCDCTL_API=3 /usr/local/bin/etcdctl snapshot restore /data/backup_etcd/$(date +%Y-%m-%d)/snapshot.db
    --name {{ hostname }}
    --initial-cluster {{ ETCD_NODES }}
    --initial-cluster-token etcd-cluster-0
    --initial-advertise-peer-urls https://{{ inventory_hostname }}:2380

#ETCDCTL_API=3 etcdctl --cacert="/etc/ssl/etcd/ssl/ca.crt" --cert="/etc/ssl/etcd/ssl/etcd.crt" --key="/etc/ssl/etcd/ssl/etcd.key" --endpoints="https://127.0.0.1:2379" --data-dir=/var/lib/etcd/ snapshot restore /data/backup_etcd/2020-06-15-17-53-08.etcd.db

5. cp -rf /tmp/etcd1.etcd/member /data/etcd/data/
6. systemctl restart etcd
