locals {
  ecr_repositories = {
    for name, ecr in try(local.data, {}) :
    name => ecr if var.create && try(data.create, true) && try(ecr.create, true)
  }
}
