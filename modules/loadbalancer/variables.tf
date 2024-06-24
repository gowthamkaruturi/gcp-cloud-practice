variable "backend_service_name" {
  description = "back end service name"
  type        = string
  default     = "terraform-on-gcp-backend-service"
}

variable "url_map_name" {
  description = "back end service name"
  type        = string
  default     = "terraform-on-gcp-url-map"
}

variable "http_proxy_name" {
  description = "back end proxy name"
  type        = string
  default     = "terraform-on-gcp-http-proxy-name"
}

variable "forwarding_rule_name" {
  description = "forwarding rule name"
  type        = string
  default     = "terraform-on-gcp-http-forward-rule"
}