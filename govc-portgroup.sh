#!/bin/bash

source ../.sourcevc
govc session.login
govc about

ARRAY=( "844:221"
        "851:222"
        "923:223"
        "890:224"
        "879:225"
        "917:226"
        "936:227"
        "937:228"

 )


for network in "${ARRAY[@]}"; do
  govc dvs.portgroup.add -dvs VManagement -vlan-mode=vlan -vlan="${network%%:*}" -nports=8 -type earlyBinding "devqe-segment-${network##*:}"
  echo "dvs.portgroup.add -dvs VManagement -vlan-mode=vlan -vlan=${network%%:*} -nports=8 -type earlyBinding devqe-segment-${network##*:}"
done


ARRAYD=( "860:229"
        "867:230"
        "921:231"
        "869:232" 
        "935:233"
        "926:234"

 )


for networkd in "${ARRAYD[@]}"; do
  govc dvs.portgroup.add -dvs VManagement -vlan-mode=vlan -vlan="${networkd%%:*}" -nports=8 -type earlyBinding "devqe-segment-${networkd##*:}-disconnected"
  echo "dvs.portgroup.add -dvs VManagement -vlan-mode=vlan -vlan=${networkd%%:*} -nports=8 -type earlyBinding devqe-segment-${networkd##*:}-disconnected"
done



