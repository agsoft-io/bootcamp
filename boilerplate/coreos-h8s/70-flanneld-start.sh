#!/bin/bash

systemctl stop update-engine; systemctl mask update-engine

systemctl daemon-reload

if [ $CONTAINER_RUNTIME = "rkt" ]; then
        systemctl enable load-rkt-stage1
        systemctl enable rkt-api
fi

systemctl enable flanneld; systemctl start flanneld

echo "flanneld started"