variable "resource-group-name" {
  default = "terraform-rg"
  description = "The prefix used for all resources in this example"
}

variable "app-service-name" {
  default = "terraform-app-phpmysql"
  description = "The name of the Web App"
}

variable "location" {
  default = "eastus"
  description = "The Azure location where all resources in this example should be created"
}