variable "resource_group_name" {
  type        = string
}

variable "location" {
  type = string
}

variable "acr_name" {
  type = string
}

variable "vnet_name" {
  type = string
}

variable "subnet_names" {
  type = list(string)
}

variable "address_spaces" {
  type = list(string)
}

variable "address_prefixes" {
  type = list(string)
}

