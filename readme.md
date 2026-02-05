# Module - Oracle Artifacts Container Repository
[![COE](https://img.shields.io/badge/Created%20By-CCoE-blue)]()[![HCL](https://img.shields.io/badge/language-HCL-blueviolet)](https://www.terraform.io/)[![OCI](https://img.shields.io/badge/provider-OCI-red)](https://registry.terraform.io/providers/oracle/oci/latest)

Module developed to standardize the creation of Oracle artifacts container repository.

---
## Compatibility Matrix

| Module Version | Terraform Version | OCI Version     |
|----------------|-------------------| --------------- |
| v1.0.0         | v1.14.4           | 8.0.0          |

---
## Specifying a version

To avoid that your code get the latest module version, you can define the `?ref=***` in the URL to point to a specific version.
Note: The `?ref=***` refers a tag on the git module repo.

---
## Use case
```hcl
module "artifacts_container_repository" {    
  source = "git::https://github.com/danilomnds/terraform-oci-artifacts-container-repository?ref=v1.0.0"
  compartment_id       = <compartment_id>    
  defined_tags = {
    "IT.area" : "${{ values.area }}"
    "IT.environment" : "${{ values.environment }}"
    "IT.system" : "${{ values.system }}"        
    "IT.region" : "${{ values.region }}"    
    "IT.department" : "${{ values.department }}"
    "IT.dl_owner" : "${{ values.dl_owner }}"
  }
  # example
  display_name = ["auth/web","auth/mobile"]
  providers = {
    oci = oci.home
  }
}  
output "display_name" {
  value = module.artifacts_container_repository.display_name
}
output "id" {
  value = module.artifacts_container_repository.id
}
```

### backend configuration
```hcl
terraform {
  backend "oci" {
    bucket    = "bucket name"
    namespace = " "
    key       = "repo/path/for/the/terraform.tfstate"           
    region = ""
  }
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "8.0.0"
    }
  }
}

provider "oci" {
  # if you are deploying on your home region, there is no need to specify the oci provider twice.  
  alias            = "home"
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  private_key_path = var.private_key_path
  # your home region
  region           = ""
}

provider "oci" {
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  private_key_path = var.private_key_path
  region           = ""
}
```

---
## Input variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| compartment_id | The OCID of the compartment in which to create the resource | `string` | n/a | `Yes` |
| defined_tags | Defined tags for this resource | `map(string)` | n/a | No |
| display_name | The container repository name | `list(string)` | n/a | `Yes` |
| is_immutable | Whether the repository is immutable | `bool` | `false` | No |
| is_public | Whether the repository is public. A public repository allows unauthenticated access | `bool` | `false` | No |
| readme | Container repository readme | `object({})` | n/a | No |
| groups | List of Azure AD groups that will have access on artifacts container | `list(string)` | `[]` | No |
| compartment | Compartment name that will be used for policy creation | `string` | n/a | No |

---
## Output variables

| Name | Description |
|------|-------------|
| display_name | The container repository name |
| id | The OCID of the container repository |

---
## Documentation
Oracle Artifacts Container Repository: <br>
[https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/artifacts_container_repository](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/artifacts_container_repository)