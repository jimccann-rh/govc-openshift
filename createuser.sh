
read -p "User name " USERNAME
read -p "Group " newGroup
read -p "User password " PASSWORD

govc sso.group.create -d="Openshift user" $newGroup
govc sso.user.create -f "Open" -l "Shift" -m "splat@redhat.com" -p $PASSWORD $USERNAME
govc sso.group.update -a $USERNAME $newGroup

