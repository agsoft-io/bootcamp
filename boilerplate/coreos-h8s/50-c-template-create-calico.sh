#!/bin/bash

function init_templates_calico {

    local TEMPLATE=/srv/kubernetes/manifests/calico.yaml
    if [ "${USE_CALICO}" = "true" ]; then
    echo "TEMPLATE: $TEMPLATE"
    mkdir -p $(dirname $TEMPLATE)
    cat << EOF > $TEMPLATE
# This ConfigMap is used to configure a self-hosted Calico installation.
kind: ConfigMap
apiVersion: v1
metadata:
  name: calico-config 
  namespace: kube-system
data:
  # Configure this with the location of your etcd cluster.
  etcd_endpoints: "${ETCD_ENDPOINTS}"

  # The CNI network configuration to install on each node.  The special
  # values in this config will be automatically populated.
  cni_network_config: |-
    {
        "name": "calico",
        "type": "flannel",
        "delegate": {
          "type": "calico",
          "etcd_endpoints": "__ETCD_ENDPOINTS__",
          "log_level": "info",
          "policy": {
              "type": "k8s",
              "k8s_api_root": "https://__KUBERNETES_SERVICE_HOST__:__KUBERNETES_SERVICE_PORT__",
              "k8s_auth_token": "__SERVICEACCOUNT_TOKEN__"
          },
          "kubernetes": {
              "kubeconfig": "/etc/kubernetes/cni/net.d/__KUBECONFIG_FILENAME__"
          }
        }
    }

---

# This manifest installs the calico/node container, as well
# as the Calico CNI plugins and network config on 
# each master and worker node in a Kubernetes cluster.
kind: DaemonSet
apiVersion: extensions/v1beta1
metadata:
  name: calico-node
  namespace: kube-system
  labels:
    k8s-app: calico-node
spec:
  selector:
    matchLabels:
      k8s-app: calico-node
  template:
    metadata:
      labels:
        k8s-app: calico-node
      annotations:
        scheduler.alpha.kubernetes.io/critical-pod: ''
        scheduler.alpha.kubernetes.io/tolerations: |
          [{"key": "dedicated", "value": "master", "effect": "NoSchedule" },
           {"key":"CriticalAddonsOnly", "operator":"Exists"}]
    spec:
      hostNetwork: true
      containers:
        # Runs calico/node container on each Kubernetes node.  This 
        # container programs network policy and routes on each
        # host.
        - name: calico-node
          image: quay.io/calico/node:v0.23.0
          env:
            # The location of the Calico etcd cluster.
            - name: ETCD_ENDPOINTS
              valueFrom:
                configMapKeyRef:
                  name: calico-config
                  key: etcd_endpoints
            # Choose the backend to use. 
            - name: CALICO_NETWORKING_BACKEND
              value: "none"
            # Disable file logging so 'kubectl logs' works.
            - name: CALICO_DISABLE_FILE_LOGGING
              value: "true"
            - name: NO_DEFAULT_POOLS
              value: "true"
          securityContext:
            privileged: true
          volumeMounts:
            - mountPath: /lib/modules
              name: lib-modules
              readOnly: false
            - mountPath: /var/run/calico
              name: var-run-calico
              readOnly: false
            - mountPath: /etc/resolv.conf
              name: dns
              readOnly: true
        # This container installs the Calico CNI binaries
        # and CNI network config file on each node.
        - name: install-cni
          image: quay.io/calico/cni:v1.5.2
          imagePullPolicy: Always
          command: ["/install-cni.sh"]
          env:
            # CNI configuration filename
            - name: CNI_CONF_NAME
              value: "10-calico.conf"
            # The location of the Calico etcd cluster.
            - name: ETCD_ENDPOINTS
              valueFrom:
                configMapKeyRef:
                  name: calico-config
                  key: etcd_endpoints
            # The CNI network config to install on each node.
            - name: CNI_NETWORK_CONFIG
              valueFrom:
                configMapKeyRef:
                  name: calico-config
                  key: cni_network_config
          volumeMounts:
            - mountPath: /host/opt/cni/bin
              name: cni-bin-dir
            - mountPath: /host/etc/cni/net.d
              name: cni-net-dir
      volumes:
        # Used by calico/node.
        - name: lib-modules
          hostPath:
            path: /lib/modules
        - name: var-run-calico
          hostPath:
            path: /var/run/calico
        # Used to install CNI.
        - name: cni-bin-dir
          hostPath:
            path: /opt/cni/bin
        - name: cni-net-dir
          hostPath:
            path: /etc/kubernetes/cni/net.d
        - name: dns
          hostPath:
            path: /etc/resolv.conf

---

# This manifest deploys the Calico policy controller on Kubernetes.
# See https://github.com/projectcalico/k8s-policy
apiVersion: extensions/v1beta1
kind: ReplicaSet 
metadata:
  name: calico-policy-controller
  namespace: kube-system
  labels:
    k8s-app: calico-policy
spec:
  # The policy controller can only have a single active instance.
  replicas: 1
  template:
    metadata:
      name: calico-policy-controller
      namespace: kube-system
      labels:
        k8s-app: calico-policy
      annotations:
        scheduler.alpha.kubernetes.io/critical-pod: ''
        scheduler.alpha.kubernetes.io/tolerations: |
          [{"key": "dedicated", "value": "master", "effect": "NoSchedule" },
           {"key":"CriticalAddonsOnly", "operator":"Exists"}]
    spec:
      # The policy controller must run in the host network namespace so that
      # it isn't governed by policy that would prevent it from working.
      hostNetwork: true
      containers:
        - name: calico-policy-controller
          image: calico/kube-policy-controller:v0.4.0
          env:
            # The location of the Calico etcd cluster.
            - name: ETCD_ENDPOINTS
              valueFrom:
                configMapKeyRef:
                  name: calico-config
                  key: etcd_endpoints
            # The location of the Kubernetes API.  Use the default Kubernetes
            # service for API access.
            - name: K8S_API
              value: "https://kubernetes.default:443"
            # Since we're running in the host namespace and might not have KubeDNS 
            # access, configure the container's /etc/hosts to resolve
            # kubernetes.default to the correct service clusterIP.
            - name: CONFIGURE_ETC_HOSTS
              value: "true"
EOF
    fi

}


 # Create kube templates based on the type of node (Master/Worker)
    
  init_templates_calico
    
echo "CH8 Calico Templates DONE"
