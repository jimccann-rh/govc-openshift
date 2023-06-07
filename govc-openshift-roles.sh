!/bin/bash

source ../sourcevc 
govc session.login 
govc about


govc role.create openshift_cluster

PRIVILEGES1="Host.Config.Storage
   Resource.AssignVMToPool
   Resource.CreatePool
   Resource.DeletePool
   System.Anonymous
   System.Read
   System.View
   VApp.AssignResourcePool
   VApp.Import
   VirtualMachine.Config.AddNewDisk"

govc role.update openshift_cluster $PRIVILEGES1


PRIVILEGES2="Folder.Create
    Folder.Delete
    InventoryService.Tagging.AttachTag
    InventoryService.Tagging.CreateCategory
    InventoryService.Tagging.CreateTag
    InventoryService.Tagging.DeleteCategory
    InventoryService.Tagging.DeleteTag
    InventoryService.Tagging.EditCategory
    InventoryService.Tagging.EditTag
    InventoryService.Tagging.ObjectAttachable
    Network.Assign
    Network.Config
    Resource.AssignVMToPool
    System.Anonymous
    System.Read
    System.View
    VApp.Import
    VirtualMachine.Config.AddExistingDisk
    VirtualMachine.Config.AddNewDisk
    VirtualMachine.Config.AddRemoveDevice
    VirtualMachine.Config.AdvancedConfig
    VirtualMachine.Config.Annotation
    VirtualMachine.Config.CPUCount
    VirtualMachine.Config.DiskExtend
    VirtualMachine.Config.DiskLease
    VirtualMachine.Config.EditDevice
    VirtualMachine.Config.Memory
    VirtualMachine.Config.RemoveDisk
    VirtualMachine.Config.Rename
    VirtualMachine.Config.ResetGuestInfo
    VirtualMachine.Config.Resource
    VirtualMachine.Config.Settings
    VirtualMachine.Config.UpgradeVirtualHardware
    VirtualMachine.Interact.GuestControl
    VirtualMachine.Interact.PowerOff
    VirtualMachine.Interact.PowerOn
    VirtualMachine.Interact.Reset
    VirtualMachine.Inventory.Create
    VirtualMachine.Inventory.CreateFromExisting
    VirtualMachine.Inventory.Delete
    VirtualMachine.Provisioning.Clone
    VirtualMachine.Provisioning.DeployTemplate
    VirtualMachine.Provisioning.MarkAsTemplate"

govc role.create openshift_datacenter $PRIVILEGES2


PRIVILEGES3="Datastore.AllocateSpace
    Datastore.Browse
    Datastore.FileManagement
    InventoryService.Tagging.ObjectAttachable
    System.Anonymous
    System.Read
    System.View"

govc role.create openshift_datastore $PRIVILEGES3


PRIVILEGES4="Cns.Searchable
    InventoryService.Tagging.AttachTag
    InventoryService.Tagging.CreateCategory
    InventoryService.Tagging.CreateTag
    InventoryService.Tagging.DeleteCategory
    InventoryService.Tagging.DeleteTag
    InventoryService.Tagging.EditCategory
    InventoryService.Tagging.EditTag
    Network.Assign
    Network.Config
    Sessions.ValidateSession
    StorageProfile.Update
    StorageProfile.View
    System.Anonymous
    System.Read
    System.View
    VirtualMachine.Interact.Backup                                                                                                                                                                                                            
    VirtualMachine.Interact.SetCDMedia                                                                                                                                                                                                        
    VirtualMachine.Interact.SetFloppyMedia                                                                                                                                                                                                    
    VirtualMachine.Interact.ConsoleInteract                                                                                                                                                                                                   
    VirtualMachine.Interact.CreateScreenshot                                                                                                                                                                                                  
    VirtualMachine.Interact.DeviceConnection                                                                                                                                                                                                  
    VirtualMachine.Interact.GuestControl                                                                                                                                                                                                      
    VirtualMachine.Interact.ToolsInstall                                                                                                                                                                                                      
    VirtualMachine.Interact.PowerOff                                                                                                                                                                                                          
    VirtualMachine.Interact.PowerOn                                                                                                                                                                                                           
    VirtualMachine.Interact.Reset                                                                                                                                                                                                             
    VirtualMachine.Interact.Record                                                                                                                                                                                                            
    VirtualMachine.Interact.Replay"                          
    
govc role.create openshift_vcenter $PRIVILEGES4

PRIVILEGES5="Network.Assign
    System.Anonymous
    System.Read
    System.View"

govc role.create openshift_portgroup $PRIVILEGES5


PRIVILEGES6="Resource.AssignVMToPool
    System.Anonymous
    System.Read
    System.View
    VApp.Import
    VirtualMachine.Config.AddExistingDisk
    VirtualMachine.Config.AddNewDisk
    VirtualMachine.Config.AddRemoveDevice
    VirtualMachine.Config.AdvancedConfig
    VirtualMachine.Config.Annotation
    VirtualMachine.Config.CPUCount
    VirtualMachine.Config.DiskExtend
    VirtualMachine.Config.DiskLease
    VirtualMachine.Config.EditDevice
    VirtualMachine.Config.Memory
    VirtualMachine.Config.RemoveDisk
    VirtualMachine.Config.Rename
    VirtualMachine.Config.ResetGuestInfo
    VirtualMachine.Config.Resource
    VirtualMachine.Config.Settings
    VirtualMachine.Config.UpgradeVirtualHardware
    VirtualMachine.Interact.GuestControl
    VirtualMachine.Interact.PowerOff
    VirtualMachine.Interact.PowerOn
    VirtualMachine.Interact.Reset
    VirtualMachine.Inventory.Create
    VirtualMachine.Inventory.CreateFromExisting
    VirtualMachine.Inventory.Delete
    VirtualMachine.Provisioning.Clone"

govc role.create openshift_folder $PRIVILEGES6



govc role.ls | grep openshift


PRINCIPAL="DEVQE@devqe.ibmc.devcluster.openshift.com"
PGNETWORK="VManagement"


DC=$(govc find / -type d)
#DC2=${DC##*:}
CL=$(govc find / -type c)

govc permissions.set -group=true -principal $PRINCIPAL -role openshift_vcenter /
govc permissions.set -group=true -principal $PRINCIPAL -role openshift_datacenter $DC
govc permissions.set -group=true -principal $PRINCIPAL -role openshift_cluster $CL
govc permissions.set -group=true -principal $PRINCIPAL -role openshift_portgroup $DC/network/$PGNETWORK
govc permissions.set -group=true -principal $PRINCIPAL -role openshift_datastore $DC/datastore/vsanDatastore

govc permissions.ls |grep openshift_vcenter

