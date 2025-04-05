locals {
  existing_kms_keys = toset([
    for id, properties in local.resources :
    properties.encryption_configuration.kms_alias if can(properties.encryption_configuration.kms_alias) && !contains(keys(try(var.upstream.kms_key, {})), try(properties.encryption_configuration.kms_alias, ""))
  ])
}

data "aws_kms_key" "existing" {
  for_each = local.existing_kms_keys

  key_id = "alias/${each.key}"
}
