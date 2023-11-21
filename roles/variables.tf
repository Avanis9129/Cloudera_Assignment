variable "ARN_PARTITION" {
default = "aws"
}

variable "AWS_ACCOUNT_ID" {
default = "149240939734"
}

variable "DATALAKE_BUCKET" {
default = "avanis-asmt-bucket"
}

variable "STORAGE_LOCATION_BASE" {
default = "avanis-asmt-bucket/my-dl"
}

variable "LOGS_BUCKET" {
default = "avanis-asmt-bucket"
}

variable "LOGS_LOCATION_BASE" {
default = "avanis-asmt-bucket/my-dl"
}

variable "BACKUP_BUCKET" {
default = "avanis-asmt-bucket"
}

variable "BACKUP_LOCATION_BASE" {
default = "avanis-asmt-bucket/my-dl"
}

#define variable value from CDP dashboard
variable "CDP_ACCOUNT_ID" {
default = "dummy"
}

variable "CDP_EXTERNAL_ID" {
default = "dummy2"
}

variable "policy_directory" {
  description = "Path to the directory containing policy files"
  default     = "~/Cloudera_Assignment/roles/policies"  # Set the default path or provide the path here
}