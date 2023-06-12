#!/bin/bash

source ../.sourcevc
govc session.login
govc about

ARRAY=( "923:223"
        "890:224" )


for network in "${ARRAY[@]}"; do
  govc dvs.portgroup.add -dvs VManagement -vlan-mode=vlan -vlan="${network%%:*}" -nports=8 -type earlyBinding "devqe-segment-${network##*:}"
  echo "dvs.portgroup.add -dvs VManagement -vlan-mode=vlan -vlan=${network%%:*} -nports=8 -type earlyBinding devqe-segment-${network##*:}"
done

