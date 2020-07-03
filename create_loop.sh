#!/bin/bash

oc create namespace resilience-testing-create-loop

trap "oc delete namespace resilience-testing-create-loop; exit" INT

while true; do
  oc -n resilience-testing-create-loop create -f vms/vm-cirros.yaml
  virtctl -n resilience-testing-create-loop start vm-cirros
  sleep 120
  oc delete -n resilience-testing-create-loop -f vms/vm-cirros.yaml
  sleep 10
  oc -n resilience-testing-create-loop wait --for=delete vm vm-cirros
done
