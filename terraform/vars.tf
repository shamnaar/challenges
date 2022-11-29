# variable "resource_group" {
#   default = "test-rg"
# }
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
  type = string
}
variable "web_os_password" {
    type = string
}

variable "database_admin" {
  type = string
}

variable "database_password" {
  type = string
}