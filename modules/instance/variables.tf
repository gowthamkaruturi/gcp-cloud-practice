variable "instance_template_name" {
  description = "Name of the instance template"
  type        = string
  default     = "terraform-on-gcp-instancetemplate"
}

variable "instance_group_name" {
  description = "Name of the instance group manager"
  type        = string
  default     = "terraform-on-gcp-group"

}

variable "base_instance_name" {
  description = "Base name of instances in the instance group"
  type        = string
  default     = "terraform-on-gcp-instance"
}

variable "machine_type" {
  description = "Machine type for the instances"
  type        = string
  default     = "f1-micro"
}

variable "instance_image" {
  description = "Image for the instances"
  type        = string
  default     = "debian-cloud/debian-10"
}

variable "startup_script" {
  description = "Path to the startup script"
  type        = string
  default     = "./install.sh"
}

variable "network_name" {
  description = "Name of the network"
  type        = string
  default     = "terraform-on-gcp-nw"
}

variable "subnetwork_name" {
  description = "Name of the subnetwork"
  type        = string
  default     = "terraform-on-gcp-snw"
}

variable "instance_tags" {
  description = "Tags for the instance"
  type        = list(string)
  default     = ["ssh-access", "http-server"]
}

variable "target_size" {
  description = "Target size of the instance group"
  type        = number
  default     = 1
}

variable "target_tags" {
  description = "Target tags for the instance group"
  type        = list(string)
  default     = ["ssh-access", "http-server"]
}

variable "zone" {
  description = "Zone for the instances"
  type        = string
  default     = "us-west1-b"
}


variable "autoscaler_name" {
  description = "name of the auto scaler"
  type        = string
  default     = "terraform-on-gcp-autoscaler-name"
}

variable "healthcheck_name" {
  description = "Name of the health check"
  type        = string
  default     = "terraform-on-gcp-health-check"
}