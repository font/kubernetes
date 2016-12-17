#!/bin/bash
set -x

ADMIN_KEYRING=$(kubectl exec ceph-mon-3559047664-5n23z -- ceph auth get client.admin 2>&1 | grep 'key =' | awk '{print $3}')

kubectl create secret generic ceph-admin-secret --from-literal=key="${ADMIN_KEYRING}" --namespace=ceph
#kubectl create secret generic ceph-admin-secret --from-literal=key='AQDvZlBYAAAAABAANA84SmWhlihyme0PIVAddA==' --namespace=ceph

kubectl exec ceph-mon-3559047664-5n23z -- rbd create ceph-rbd-pv-test --size 10G
kubectl exec ceph-mon-3559047664-5n23z -- rbd info ceph-rbd-pv-test
kubectl create -f rbd-pv.yaml
kubectl create -f rbd-pv-claim.yaml
kubectl create -f rbd-pvc-pod.yaml
