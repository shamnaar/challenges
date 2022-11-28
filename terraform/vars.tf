variable "resource_group" {
  default = "test-rg"
}
variable "location" {
    default = "eastus"
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
    default = "<password>"
}

variable "database_admin" {
    default = "sqladmin"
}

variable "database_password" {
    default = "<password>"
}