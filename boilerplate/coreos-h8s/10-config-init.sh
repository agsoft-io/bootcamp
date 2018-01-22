#!/bin/bash
set -e

# The endpoint the worker node should use to contact controller nodes (https://ip:port)
# In HA configurations this should be an external DNS record or loadbalancer in front of the control nodes.
# However, it is also possible to point directly to a single control node.
export MASTER_HOST=192.168.1.200
export CONTROLLER_ENDPOINT="http://$MASTER_HOST:8080"

# List of etcd servers (http://ip:port), comma separated
export ETCD_ENDPOINTS="http://192.168.1.200:2379,http://192.168.1.201:2379,http://192.168.1.202:2379"
export WORKER_FQDN=$(grep -Po "(?<=ETCD_NAME\=)[^\"]*" /run/systemd/system/etcd2.service.d/20-cloudinit.conf)

# Whether to use Calico for Kubernetes network policy.
#export USE_CALICO=false
export USE_CALICO=true

# Specify the location for the certificates
export CH8_CERTS_LOC=/etc/kubernetes/ssl

# Specify the version (vX.Y.Z) of Kubernetes assets to deploy
#export K8S_VER=v1.5.4_coreos.0
export K8S_VER=v1.6.1_coreos.0

# Hyperkube image repository to use.
export HYPERKUBE_IMAGE_REPO=quay.io/coreos/hyperkube

# The CIDR network to use for pod IPs.
# Each pod launched in the cluster will be assigned an IP out of this range.
# Each node will be configured such that these IPs will be routable using the flannel overlay network.
export POD_NETWORK=10.2.0.0/16

# The CIDR network to use for service cluster IPs.
# Each service will be assigned a cluster IP out of this range.
# This must not overlap with any IP ranges assigned to the POD_NETWORK, or other existing network infrastructure.
# Routing to these IPs is handled by a proxy service local to each node, and are not required to be routable between nodes.
export SERVICE_IP_RANGE=10.3.0.0/24

# The IP address of the Kubernetes API Service
# If the SERVICE_IP_RANGE is changed above, this must be set to the first IP in that range.
export K8S_SERVICE_IP=10.3.0.1

# The IP address of the cluster DNS service.
# This IP must be in the range of the SERVICE_IP_RANGE and cannot be the first IP in the range.
# This same IP must be configured on all worker nodes to enable DNS service discovery.
export DNS_SERVICE_IP=10.3.0.10

# Determines the container runtime for kubernetes to use. Accepts 'docker' or 'rkt'.
export CONTAINER_RUNTIME=docker

# The above settings can optionally be overridden using an environment file:
#ENV_FILE=/run/coreos-kubernetes/options.env
ENV_FILE=/run/CH8/options.env

# To run a self hosted Calico install it needs to be able to write to the CNI dir
if [ "${USE_CALICO}" = "true" ]; then
    export CALICO_OPTS="--volume cni-bin,kind=host,source=/opt/cni/bin \
                        --mount volume=cni-bin,target=/opt/cni/bin"
else
    export CALICO_OPTS=""
fi

# -------------

function init_config {
    local REQUIRED=('ADVERTISE_IP' 'POD_NETWORK' 'ETCD_ENDPOINTS' 'CONTROLLER_ENDPOINT' 'SERVICE_IP_RANGE' 'K8S_SERVICE_IP' 'DNS_SERVICE_IP' 'K8S_VER' 'HYPERKUBE_IMAGE_REPO' 'USE_CALICO')

    if [ -f $ENV_FILE ]; then
        export $(cat $ENV_FILE | xargs)
    fi

    if [ -z $ADVERTISE_IP ]; then
        export ADVERTISE_IP=$(awk -F= '/COREOS_PUBLIC_IPV4/ {print $2}' /etc/environment)
    fi

     for REQ in "${REQUIRED[@]}"; do
        if [ -z "$(eval echo \$$REQ)" ]; then
            echo "Missing required config value: ${REQ}"
            exit 1
        fi
    done
}

init_config

echo "CH8 Config DONE"
