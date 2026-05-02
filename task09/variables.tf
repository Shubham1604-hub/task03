variable "name_prefix" {
  description = "Prefix for naming all resources"
  type        = string
}

variable "aks_loadbalancer_ip" {
  description = "Public IP address of the AKS load balancer (used in firewall NAT rule)"
  type        = string
}
