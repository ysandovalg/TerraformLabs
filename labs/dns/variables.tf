variable "gcp_account_json" {
  type        = string
  description = "File path and name of service account access token file."
}

variable "gcp_project" {
  type        = string
  description = "GCP project."
}

variable "gcp_region" {
  type        = string
  description = "GCP Cloud Run Region."
}
