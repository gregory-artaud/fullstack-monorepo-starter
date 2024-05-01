variable "INSTANCE_IDENTIFIER" {
  description = "The name of the instance."
  type        = string
  sensitive   = true
}

variable "DB_USERNAME" {
  description = "The master username for the database."
  type        = string
  sensitive   = true
}

variable "DB_PASSWORD" {
  description = "The master password for the database."
  type        = string
  sensitive   = true
}

variable "is_publicly_accessible" {
  description = "Is instance available to public"
  type        = bool
}

variable "VPC_ID" {
  type        = string
  sensitive   = true
}
