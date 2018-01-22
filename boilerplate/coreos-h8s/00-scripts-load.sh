#!/bin/bash
set -e

# CoreOS-H8S directory on the host machine
CH8_SCRIPTS_LOC="Workspace/agsoft.io/agsoft/boilerplate/coreos-h8s"

CH8_NODE1=core@192.168.1.200:
CH8_NODE2=core@192.168.1.201:
CH8_NODE3=core@192.168.1.202:

scp $CH8_SCRIPTS_LOC/openssl.cnf $CH8_NODE1
scp $CH8_SCRIPTS_LOC/10-config-init.sh $CH8_NODE1
scp $CH8_SCRIPTS_LOC/20-certs-create.sh $CH8_NODE1
scp $CH8_SCRIPTS_LOC/30-template-create-base.sh $CH8_NODE1
scp $CH8_SCRIPTS_LOC/40-c-template-create-master.sh $CH8_NODE1
scp $CH8_SCRIPTS_LOC/50-c-template-create-calico.sh $CH8_NODE1
scp $CH8_SCRIPTS_LOC/60-c-flannel-setup.sh $CH8_NODE1
scp $CH8_SCRIPTS_LOC/70-kubelet-start.sh $CH8_NODE1
scp $CH8_SCRIPTS_LOC/80-c-calico-start.sh $CH8_NODE1
scp $CH8_SCRIPTS_LOC/90-c-kube-load.sh $CH8_NODE1
echo "scripts loaded to master node $CH8_NODE1"

scp $CH8_SCRIPTS_LOC/worker-openssl.cnf $CH8_NODE2
scp $CH8_SCRIPTS_LOC/10-config-init.sh $CH8_NODE2
scp $CH8_SCRIPTS_LOC/20-certs-create.sh $CH8_NODE2
scp $CH8_SCRIPTS_LOC/30-template-create-base.sh $CH8_NODE2
scp $CH8_SCRIPTS_LOC/40-w-template-create-worker.sh $CH8_NODE2
scp $CH8_SCRIPTS_LOC/70-kubelet-start.sh $CH8_NODE2
echo "scripts loaded to worker node $CH8_NODE2"

scp $CH8_SCRIPTS_LOC/worker-openssl.cnf $CH8_NODE3
scp $CH8_SCRIPTS_LOC/10-config-init.sh $CH8_NODE3
scp $CH8_SCRIPTS_LOC/20-certs-create.sh $CH8_NODE3
scp $CH8_SCRIPTS_LOC/30-template-create-base.sh $CH8_NODE3
scp $CH8_SCRIPTS_LOC/40-w-template-create-worker.sh $CH8_NODE3
scp $CH8_SCRIPTS_LOC/70-kubelet-start.sh $CH8_NODE3
echo "scripts loaded to worker node $CH8_NODE3"
