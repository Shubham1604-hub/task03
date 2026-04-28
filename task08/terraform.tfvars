name_prefix = "cmtr-w7gf0vkr-mod8"

resource_group_name = "cmtr-w7gf0vkr-mod8-rg"
location            = "North Europe"


redis_capacity = 2
redis_sku_name = "Basic"
redis_family   = "C"

kv_sku = "standard"

redis_primary_key_secret_name = "redis-primary-key"
redis_hostname_secret_name    = "redis-hostname"


acr_sku           = "Basic"
docker_image_name = "cmtr-w7gf0vkr-mod8-app"


aci_sku = "Standard"


node_pool_name  = "system"
node_count      = 1
node_vm_size    = "Standard_D2ads_v6"
os_disk_type    = "Ephemeral"
os_disk_size_gb = 50

tags = {
  Creator = "mattaparthi_venkatprashanth@epam.com"
}

repo_url = "https://github.com/m-vp/Terraform-Task#main:task08/application"

aci_ip_type = "Public"
aci_os_type = "Linux"
aci_cpu     = "0.5"

aci_memory = "1.5"

application_port = 8080

redis_port     = 6380
redis_ssl_mode = "True"

aci_dns_label = "aci-label-dns"
