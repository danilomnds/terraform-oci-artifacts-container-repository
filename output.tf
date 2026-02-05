output "display_name" {
  value = [for ids in oci_artifacts_container_repository.container_repository : ids.display_name]
}

output "id" {
  value = [for ids in oci_artifacts_container_repository.container_repository : ids.id]
}