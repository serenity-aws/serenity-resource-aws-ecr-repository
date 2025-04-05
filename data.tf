locals {
  existing_kms_keys = toset([
    for ecr_id, ecr_data in local.ecr_repositories :
    ecr_data.encryption_configuration.kms_alias if can(ecr_data.encryption_configuration.kms_alias) && !contains(keys(var.upstream.kms_key), ecr_data.encryption_configuration.kms_alias)
  ])
}

data "aws_kms_key" "existing" {
  for_each = local.existing_kms_keys

  key_id = "alias/${each.key}"
}
