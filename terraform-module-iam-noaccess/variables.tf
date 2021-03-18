variable "enabled" {
  type        = bool
  default     = true
  description = "Set to false to prevent the module from creating any resources"
}

variable "usernames" {
  description = "List of IAM user names to create with no access"
  type        = list(string)
  default     = []
}

variable "force_destroy" {
  type        = bool
  description = "When destroying this users, destroy even if it has non-Terraform-managed IAM access keys, login profile or MFA devices. Without force_destroy a user with non-Terraform-managed access keys and login profile will fail to be destroyed"
  default     = false
}

variable "path" {
  type        = string
  description = "Desired path for the IAM user(s)"
  default     = "/"
}

variable "permissions_boundary" {
  type        = string
  description = "The ARN of the policy that is used to set the permissions boundary for the user"
  default     = ""
}

variable "tags" {
  type        = map(any)
  description = "Default tags for each resource"
  default = {
    level = "no-access",
  }
}

variable "stage" {
  type        = string
  default     = "dev"
  description = "Stage, e.g. 'prod', 'staging', 'dev', OR 'source', 'build', 'test', 'deploy', 'release'"
}
