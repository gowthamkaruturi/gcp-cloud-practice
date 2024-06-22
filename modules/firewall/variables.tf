variable "ssh_firewall_name" {
  description = "terraform-on-gcp-ssh-firewall"
  type        = string
  default     = "terraform-on-gcp-ssh-firewall"
}

variable "http_firewall_name" {
  description = "terraform-on-gcp-http-firewall"
  type        = string
  default     = "terraform-on-gcp-http-firewall"
}

variable "network_name" {
  description = "terraform-on-gcp-nw"
  type        = string
  default = "terraform-on-gcp-nw"
}

variable "ssh_target_tags" {
  description = "Target tags for SSH firewall rule"
  type        = list(string)
  default     = ["ssh-access"]
}

variable "ssh_source_ranges" {
  description = "Source ranges for SSH firewall rule"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "http_target_tags" {
  description = "Target tags for HTTP firewall rule"
  type        = list(string)
  default     = ["http-server"]
}

variable "http_source_ranges" {
  description = "Source ranges for HTTP firewall rule"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}
