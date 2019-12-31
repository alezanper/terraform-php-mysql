terraform {
  required_version = ">= 0.11"
  backend "azurerm" {
    storage_account_name = "storagephpaccounttf"
    container_name        = "containerphpmytf"
    key                   = "terraform.tfstate"
  }
}

resource "azurerm_resource_group" "test" {
  name     = "${var.resource-group-name}"
  location = "${var.location}"
}



resource "azurerm_app_service" "test" {
  name                = "${var.app-service-name}"
  location            = "${azurerm_resource_group.test.location}"
  resource_group_name = "${azurerm_resource_group.test.name}"
  app_service_plan_id = "${azurerm_app_service_plan.test.id}"

  site_config {
    linux_fx_version = "PHP|7.0"
    scm_type         = "LocalGit"
  }
}

resource "azurerm_app_service_plan" "test" {
  name                = "terraform-appplan"
  location            = "${azurerm_resource_group.test.location}"
  resource_group_name = "${azurerm_resource_group.test.name}"
  kind                = "Linux"
  reserved            = true

  sku {
    tier = "Standard"
    size = "S1"
  }
}


resource "azurerm_mysql_server" "test" {
  name                = "mysql-terraform-php"
  location            = "${azurerm_resource_group.test.location}"
  resource_group_name = "${azurerm_resource_group.test.name}"

  sku {
    name     = "B_Gen5_2"
    capacity = 2
    tier     = "Basic"
    family   = "Gen5"
  }

  storage_profile {
    storage_mb            = 5120
    backup_retention_days = 7
    geo_redundant_backup  = "Disabled"
  }

  administrator_login          = "newuser"
  administrator_login_password = "passwordComplex2019*"
  version                      = "5.7"
  ssl_enforcement              = "Enabled"
}

resource "azurerm_mysql_firewall_rule" "test" {
  name                = "firewall-mysql"
  resource_group_name = "${azurerm_resource_group.test.name}"
  server_name         = "${azurerm_mysql_server.test.name}"
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
}