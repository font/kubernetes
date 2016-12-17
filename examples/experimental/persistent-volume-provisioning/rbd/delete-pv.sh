#!/bin/bash
set -x

kubectl delete -f rbd-pvc-pod.yaml
kubectl delete -f rbd-pv-claim.yaml
kubectl delete -f rbd-pv.yaml
kubectl delete secret ceph-admin-secret
sleep 10
kubectl exec ceph-mon-3559047664-5n23z -- rbd remove ceph-rbd-pv-test
