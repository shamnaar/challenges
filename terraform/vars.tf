# variable "resource_group" {}
variable "location" {
    default = "japaneast"
}
variable "subscription_id" {
  type    = string
}

variable "client_id" {
  type    = string
}

variable "client_secret" {
  type    = string
}

variable "tenant_id" {
  type    = string
}

variable "web_host_name"{
    default = "webserver"
}
variable "web_username" {
    default = "webadmin"
}
variable "web_os_password" {
    default = "webadminp@ssw0rd983"
}

variable "database_admin" {
    default = "sqladmin667"
}

variable "database_password" {
    default = "sqlp@ssworDadmin973"
}