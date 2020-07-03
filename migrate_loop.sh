#!/bin/bash

oc create namespace resilience-testing-migrate-loop

trap "oc delete namespace resilience-testing-migrate-loop; exit" INT

oc -n resilience-testing-migrate-loop create -f vms/vm-alpine-datavolume.yaml

virtctl -n resilience-testing-migrate-loop start vm-alpine-datavolume

while true; do
  sleep 120
  virtctl -n resilience-testing-migrate-loop migrate vm-alpine-datavolume
done
