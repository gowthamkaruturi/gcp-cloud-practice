variable "disk_name" {
  description = "Name of the additional disk"
  type        = string
  default     = "additional-disk"
}

variable "disk_type" {
  description = "Type of the additional disk"
  type        = string
  default     = "pd-standard"
}

variable "zone" {
  description = "Zone for the disk"
  type        = string
  default     = "us-west1-b"
}

variable "disk_size_gb" {
  description = "Size of the disk in GB"
  type        = number
  default     = 100
}
