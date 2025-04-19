locals {
  resources = {
    for id, properties in try(var.resources, {}) :
    id => jsondecode(templatestring(jsonencode(properties), { this = var.this })) if var.create && try(properties.create, true)
  }
}
