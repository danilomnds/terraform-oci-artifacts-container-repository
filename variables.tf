variable "compartment_id" {
  type = string
}

variable "defined_tags" {
  type    = map(string)
  default = null
}

variable "display_name" {
  type = list(string)
}

variable "is_immutable" {
  type    = bool
  default = false
}

variable "is_public" {
  type    = bool
  default = false
}

variable "readme" {
  type = object({
    content = string
    format  = string
  })
  default = null
}

variable "groups" {
  type    = list(string)
  default = []
}

variable "compartment" {
  type    = string
  default = null
}

variable "rbac" {
  type    = bool
  default = false
}

variable "tenancy_ocid" {
  type = string
}

variable "policies" {
  type    = bool
  default = false
}