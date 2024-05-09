variable "APP_NAME" {
  description = "The name of the application"
  type        = string
}

variable "PROD_DB_PORT" {
  description = "The port for the production database."
  type        = number
  default     = 5432
}

variable "PROD_DB_USERNAME" {
  description = "The master username for the production database."
  type        = string
  sensitive   = true
}

variable "PROD_DB_PASSWORD" {
  description = "The master password for the production database."
  type        = string
  sensitive   = true
}

variable "HOSTED_ZONE_ID" {
  description = "The hosted zone id (the id of the domain on Route 53)"
  type        = string
  sensitive   = true
}

variable "DOMAIN_NAME" {
  description = "The name of the domain where the app will be accessible"
  type        = string
}