resource_groups = {
  rg1 = {
    name     = "cmaz-frq948m6-mod5-rg-01"
    location = "East US"
  }
  rg2 = {
    name     = "cmaz-frq948m6-mod5-rg-02"
    location = "West US"
  }
  rg3 = {
    name     = "cmaz-frq948m6-mod5-rg-03"
    location = "Central US"
  }
}

app_service_plans = {
  asp1 = {
    name               = "cmaz-frq948m6-mod5-asp-01"
    worker_count       = 2
    sku                = "S1"
    resource_group_key = "rg1"
  }
  asp2 = {
    name               = "cmaz-frq948m6-mod5-asp-02"
    worker_count       = 1
    sku                = "S1"
    resource_group_key = "rg2"
  }
}

app_services = {
  app1 = {
    name               = "cmaz-frq948m6-mod5-app-01"
    resource_group_key = "rg1"
    service_plan_key   = "asp1"
  }
  app2 = {
    name               = "cmaz-frq948m6-mod5-app-02"
    resource_group_key = "rg2"
    service_plan_key   = "asp2"
  }
}

traffic_manager = {
  name           = "cmaz-frq948m6-mod5-traf"
  resource_group = "rg3"
  routing_method = "Performance"
}

ip_restrictions = [
  {
    name       = "allow-ip"
    priority   = 100
    action     = "Allow"
    ip_address = "18.153.146.156/32"
  },
  {
    name        = "allow-tm"
    priority    = 110
    action      = "Allow"
    service_tag = "AzureTrafficManager"
  },
  {
    name       = "Deny all"
    priority   = 2147483647
    action     = "Deny"
    ip_address = "0.0.0.0/0"
  },
]

tags = {
  Creator = "shubhamparsharam_patgavkar@epam.com"
}