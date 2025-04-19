variable "create" {
  type    = bool
  default = true
}

variable "name_tag_enabled" {
  type    = bool
  default = true
}

variable "resources" {
  type = any
}

variable "this" {
  type    = any
  default = {}
}

variable "upstream" {
  type    = any
  default = {}
}

variable "tags" {
  type    = map(any)
  default = {}
}
