variable "NAME" {
  description = "The name of the instance."
  type        = string
}

variable "AMI_ID" {
  description = "The id of the machine image."
  type        = string
  sensitive   = true
}

variable "VPC_ID" {
  type        = string
  sensitive   = true
}

variable "RDS_PORT" {
  type = number
}