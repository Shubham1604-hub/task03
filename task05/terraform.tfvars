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
    name         = "cmaz-frq948m6-mod5-asp-01"
    worker_count = 2
    sku          = "S1"
  }
  asp2 = {
    name         = "cmaz-frq948m6-mod5-asp-02"
    worker_count = 1
    sku          = "S1"
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

verification_ip = "18.153.146.156"

tags = {
  Creator = "shubhamparsharam_patgavkar@epam.com"
}