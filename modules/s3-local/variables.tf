variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}

variable "bucket_policy" {
  description = "JSON policy for the S3 bucket"
  type        = string
}

variable "folders" {
  description = "Set of folder names to create"
  type        = set(string)
  default     = []
}
