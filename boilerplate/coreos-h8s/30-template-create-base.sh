#!/bin/bash

function init_templates_base {

    local TEMPLATE=/opt/bin/host-rkt
    if [ ! -f $TEMPLATE ]; then
        echo "TEMPLATE: $TEMPLATE"
        mkdir -p $(dirname $TEMPLATE)
        cat << EOF > $TEMPLATE
#!/bin/sh
# This is bind mounted into the kubelet rootfs and all rkt shell-outs go
# through this rkt wrapper. It essentially enters the host mount namespace
# (which it is already in) only for the purpose of breaking out of the chroot
# before calling rkt. It makes things like rkt gc work and avoids bind mounting
# in certain rkt filesystem dependancies into the kubelet rootfs. This can
# eventually be obviated when the write-api stuff gets upstream and rkt gc is
# through the api-server. Related issue:
# https://github.com/coreos/rkt/issues/2878
exec nsenter -m -u -i -n -p -t 1 -- /usr/bin/rkt "\$@"
EOF
    fi

    local TEMPLATE=/etc/systemd/system/load-rkt-stage1.service
    if [ ${CONTAINER_RUNTIME} = "rkt" ] && [ ! -f $TEMPLATE ]; then
        echo "TEMPLATE: $TEMPLATE"
        mkdir -p $(dirname $TEMPLATE)
        cat << EOF > $TEMPLATE
[Unit]
Description=Load rkt stage1 images
Documentation=http://github.com/coreos/rkt
Requires=network-online.target
After=network-online.target
Before=rkt-api.service

[Service]
Type=oneshot
RemainAfterExit=yes
ExecStart=/usr/bin/rkt fetch /usr/lib/rkt/stage1-images/stage1-coreos.aci /usr/lib/rkt/stage1-images/stage1-fly.aci  --insecure-options=image

[Install]
RequiredBy=rkt-api.service
EOF
    fi

    local TEMPLATE=/etc/systemd/system/rkt-api.service
    if [ ${CONTAINER_RUNTIME} = "rkt" ] && [ ! -f $TEMPLATE ]; then
        echo "TEMPLATE: $TEMPLATE"
        mkdir -p $(dirname $TEMPLATE)
        cat << EOF > $TEMPLATE
[Unit]
Before=kubelet.service

[Service]
ExecStart=/usr/bin/rkt api-service
Restart=always
RestartSec=10

[Install]
RequiredBy=kubelet.service
EOF
    fi

    local TEMPLATE=/etc/flannel/options.env
    if [ ! -f $TEMPLATE ]; then
        echo "TEMPLATE: $TEMPLATE"
        mkdir -p $(dirname $TEMPLATE)
        cat << EOF > $TEMPLATE
FLANNELD_IFACE=$ADVERTISE_IP
FLANNELD_ETCD_ENDPOINTS=$ETCD_ENDPOINTS
EOF
    fi

    local TEMPLATE=/etc/systemd/system/flanneld.service.d/40-ExecStartPre-symlink.conf
    if [ ! -f $TEMPLATE ]; then
        echo "TEMPLATE: $TEMPLATE"
        mkdir -p $(dirname $TEMPLATE)
        cat << EOF > $TEMPLATE
[Service]
ExecStartPre=/usr/bin/ln -sf /etc/flannel/options.env /run/flannel/options.env
EOF
    fi

    local TEMPLATE=/etc/systemd/system/docker.service.d/40-flannel.conf
    if [ ! -f $TEMPLATE ]; then
        echo "TEMPLATE: $TEMPLATE"
        mkdir -p $(dirname $TEMPLATE)
        cat << EOF > $TEMPLATE
[Unit]
Requires=flanneld.service
After=flanneld.service
[Service]
EnvironmentFile=/etc/kubernetes/cni/docker_opts_cni.env
EOF
    fi

    local TEMPLATE=/etc/kubernetes/cni/docker_opts_cni.env
    if [ ! -f $TEMPLATE ]; then
        echo "TEMPLATE: $TEMPLATE"
        mkdir -p $(dirname $TEMPLATE)
        cat << EOF > $TEMPLATE
DOCKER_OPT_BIP=""
DOCKER_OPT_IPMASQ=""
EOF
    fi

    local TEMPLATE=/etc/kubernetes/cni/net.d/10-flannel.conf
    if [ "${USE_CALICO}" = "false" ] && [ ! -f "${TEMPLATE}" ]; then
        echo "TEMPLATE: $TEMPLATE"
        mkdir -p $(dirname $TEMPLATE)
        cat << EOF > $TEMPLATE
{
    "name": "podnet",
    "type": "flannel",
    "delegate": {
        "isDefaultGateway": true
    }
}
EOF
    fi

}


 # Create kube templates based on the type of node (Master/Worker)
    
    init_templates_base
    
echo "CH8 Base Templates DONE"
