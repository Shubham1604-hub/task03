resource_group_name = "cmaz-frq948m6-mod4-rg"
vnet_name           = "cmaz-frq948m6-mod4-vnet"
subnet_name         = "frontend"

nic_name = "cmaz-frq948m6-mod4-nic"
nsg_name = "cmaz-frq948m6-mod4-nsg"

http_rule_name = "AllowHTTP"
ssh_rule_name  = "AllowSSH"
pip_name  = "cmaz-frq948m6-mod4-pip"
dns_label = "cmaz-frq948m6-mod4-nginx"

vm_name = "cmaz-frq948m6-mod4-vm"

location = "East US"

creator_tag    = "shubhamparsharam_patgavkar@epam.com"
admin_username = "azureuser"