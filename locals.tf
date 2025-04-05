locals {
  resources = {
    for id, properties in try(var.resources, {}) :
    id => properties if var.create && try(properties.create, true)
  }
}
