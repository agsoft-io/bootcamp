#!/bin/bash

systemctl stop update-engine; systemctl mask update-engine

systemctl daemon-reload

if [ $CONTAINER_RUNTIME = "rkt" ]; then
        systemctl enable load-rkt-stage1
        systemctl enable rkt-api
fi

systemctl enable flanneld; systemctl start flanneld

echo "flanneld started"

systemctl enable kubelet; systemctl start kubelet

systemctl unmask update-engine; systemctl start update-engine

echo "CH8 kubelet started DONE"
