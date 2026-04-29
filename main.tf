resource "oci_artifacts_container_repository" "container_repository" {
  for_each = {
    for image in var.display_name : image => image
  }
  compartment_id = var.compartment_id
  defined_tags   = local.defined_tags
  display_name   = each.value
  is_immutable   = var.is_immutable
  is_public      = var.is_public
  dynamic "readme" {
    for_each = var.readme != null ? [var.readme] : []
    content {
      content = readme.value.content
      format  = readme.value.format
    }
  }
  lifecycle {
    ignore_changes = [
      defined_tags["IT.create_date"]
    ]
  }
}

resource "oci_identity_policy" "read" {
  provider   = oci.home  
  depends_on = [oci_artifacts_container_repository.container_repository]
  for_each = {
    for group in var.groups : group => group
    if var.groups != [] && var.compartment != null && var.policies == true
  }
  compartment_id = var.compartment_id
  name           = "policy_artifacts_container_repository_${lower(replace(var.compartment, ":", "_"))}"
  description    = "allow one or more groups to upload container images on OCI Registry"
  statements = [
    for group in var.groups :
    "Allow group ${group} to manage repos in compartment ${var.compartment} where ALL {request.operation != 'UpdateContainerRepository', request.operation != 'UpdateDockerRepositoryMetadata', request.operation != 'CreateContainerRepository', request.operation != 'CreateDockerRepository', request.operation != 'DeleteContainerRepository'}"
  ]
}