resource "aws_ecr_repository" "this" {
  for_each = local.resources

  name = try(each.value.name, each.key)

  force_delete         = try(each.value.force_delete, null)
  image_tag_mutability = try(each.value.image_tag_mutability, null)

  dynamic "image_scanning_configuration" {
    for_each = try([each.value.image_scanning_configuration], [])

    content {
      scan_on_push = image_scanning_configuration.value.scan_on_push
    }
  }

  dynamic "encryption_configuration" {
    for_each = try([each.value.encryption_configuration], [])

    content {
      encryption_type = try(encryption_configuration.value.encryption_type, null)
      kms_key         = can(encryption_configuration.value.kms_key) ? encryption_configuration.value.kms_key : can(encryption_configuration.value.kms_alias) ? try(var.upstream.kms[encryption_configuration.value.kms_alias].arn, data.aws_kms_key.existing[encryption_configuration.value.kms_alias].arn) : null
    }
  }

  tags = merge(
    {
      Name = try(each.value.name, each.key)
    },
    var.tags,
    try(each.value.tags, {})
  )
}
