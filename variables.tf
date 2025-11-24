variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
  default     = "my-local-bucket"
}



variable "folders" {
  description = "Set of folder names to create"
  type        = set(string)
  default     = ["data", "logs", "config"]
}
