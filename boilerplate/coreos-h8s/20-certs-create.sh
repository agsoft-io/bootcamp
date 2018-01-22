#!/bin/bash
set -e

function create_certs {
  openssl genrsa -out ca-key.pem 2048
  openssl req -x509 -new -nodes -key ca-key.pem -days 10000 -out ca.pem -subj '/CN=kube-ca'

  if [ "${MASTER_HOST}" = "${ADVERTISE_IP}" ]; then
    openssl genrsa -out apiserver-key.pem 2048
    openssl req -new -key apiserver-key.pem -out apiserver.csr -subj '/CN=kube-apiserver' -config openssl.cnf
    openssl x509 -req -in apiserver.csr -CA ca.pem -CAkey ca-key.pem -CAcreateserial -out apiserver.pem -days 365 -extensions v3_req -extfile openssl.cnf
    openssl genrsa -out admin-key.pem 2048
    openssl req -new -key admin-key.pem -out admin.csr -subj '/CN=kube-admin'
    openssl x509 -req -in admin.csr -CA ca.pem -CAkey ca-key.pem -CAcreateserial -out admin.pem -days 365
  else
    openssl genrsa -out worker-key.pem 2048
    WORKER_IP=${ADVERTISE_IP} openssl req -new -key worker-key.pem -out worker.csr -subj "/CN=$WORKER_FQDN" -config worker-openssl.cnf
    WORKER_IP=${ADVERTISE_IP} openssl x509 -req -in worker.csr -CA ca.pem -CAkey ca-key.pem -CAcreateserial -out worker.pem -days 365 -extensions v3_req -extfile worker-openssl.cnf
  fi
}

create_certs

mkdir -p ${CH8_CERTS_LOC}
cp *.cnf ${CH8_CERTS_LOC}
mv *.pem ${CH8_CERTS_LOC}
mv *.csr ${CH8_CERTS_LOC}
mv *.srl ${CH8_CERTS_LOC}
chmod 600 ${CH8_CERTS_LOC}/*-key.pem
chown root:root ${CH8_CERTS_LOC}/*-key.pem

echo "CH8 Certs DONE"
