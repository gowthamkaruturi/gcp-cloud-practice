variable "network_name" {
  description = "terraform-on-gcp-nw"
  type        = string
  default = "terraform-on-gcp-nw"
}

variable "subnetwork_name" {
  description = "terraform-on-gcp-snw"
  type        = string
  default = "terraform-on-gcp-snw"
}

variable "subnetwork_cidr" {
  description = "CIDR block for the subnetwork"
  type        = string
  default     = "10.20.0.0/16"
}

variable "region" {
  description = "Region for the network resources"
  type        = string
  default     = "us-west1"
}
