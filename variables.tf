variable "aws_profile" {
  type        = string
  description = "Profile for AWS cloud credentials"

  # Profile is default unless explicitly specified
  default = "default"
}

variable "aws_region" {
  type        = string
  description = "Region which Cloud resources will be created"
  default = "us-east-1"
}


