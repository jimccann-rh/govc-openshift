#!/bin/bash

#source ../.sourcevc 
govc session.login 
govc about


#openshift_cluster.role
#openshift_datacenter.role
#openshift_datastore.role
#openshift_folder.role
#openshift_portgroup.role
#openshift_resource_pool.role
#openshift_vcenter.role




govc role.create openshift_cluster

file1="openshift_cluster.role" 
PRIVILEGES1=$(cat "$file1")

govc role.update openshift_cluster $PRIVILEGES1


file2="openshift_datacenter.role" 
PRIVILEGES2=$(cat "$file2")

govc role.create openshift_datacenter $PRIVILEGES2


file3="openshift_datastore.role" 
PRIVILEGES3=$(cat "$file3")

govc role.create openshift_datastore $PRIVILEGES3


file4="openshift_vcenter.role" 
PRIVILEGES4=$(cat "$file4")

govc role.create openshift_vcenter $PRIVILEGES4

file5="openshift_portgroup.role" 
PRIVILEGES5=$(cat "$file5")
govc role.create openshift_portgroup $PRIVILEGES5


file6="openshift_folder.role" 
PRIVILEGES6=$(cat "$file6")

govc role.create openshift_folder $PRIVILEGES6


file7="openshift_resource_pool.role"
PRIVILEGES7=$(cat "$file7")

govc role.create openshift_resource_pool $PRIVILEGES7

govc role.ls | grep openshift


PRINCIPAL="CI@ci.ibmc.devcluster.openshift.com"
PGNETWORK="VM Network"
#PGNETWORK="VManagement"
DATASTORE="fs-cicluster-nfs"
#DATASTORE="vsanDatastore"

DC=$(govc find / -type d)
##DC2=${DC##*:}
CL=$(govc find / -type c)

govc permissions.set -group=true -principal $PRINCIPAL -role openshift_vcenter /
govc permissions.set -group=true -principal $PRINCIPAL -role openshift_datacenter $DC
govc permissions.set -group=true -principal $PRINCIPAL -role openshift_cluster $CL
govc permissions.set -group=true -principal $PRINCIPAL -role openshift_portgroup $DC/network/"$PGNETWORK"
govc permissions.set -group=true -principal $PRINCIPAL -role openshift_datastore $DC/datastore/$DATASTORE
govc permissions.ls |grep openshift_vcenter

