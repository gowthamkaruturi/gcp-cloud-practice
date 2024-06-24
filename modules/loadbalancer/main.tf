
module "instance" {
  source = "../instance"
  
}
resource "google_compute_backend_service" "terraform_on_gcp_backend_service" {
  name                    = var.backend_service_name
  protocol                = "HTTP"
  timeout_sec             = 30
  port_name               = "http-health-check-port"
  health_checks           = [module.instance.health_check_self_link]
  backend {
    group               = module.instance.instance_group_manager_selflink
    balancing_mode      = "UTILIZATION"
    max_utilization     = 0.8
  }
}

resource "google_compute_url_map" "terraform_on_gcp_url_map" {
  name            = var.url_map_name
  default_service = google_compute_backend_service.terraform_on_gcp_backend_service.id
  host_rule {
    hosts        = ["*"]
    path_matcher = "allpaths"
  }
  path_matcher {
    name            = "allpaths"
    path_rule {
      paths = [ "/" ]
    }
    default_service = google_compute_backend_service.terraform_on_gcp_backend_service.self_link
  }
}
resource "google_compute_target_http_proxy" "terraform_on_gcp_http_proxy" {
  name        = var.http_proxy_name
  url_map     = google_compute_url_map.terraform_on_gcp_url_map.self_link
}
resource "google_compute_global_forwarding_rule" "terraform_on_gcp_forwarding_rule" {
  name       = var.forwarding_rule_name
  target     = google_compute_target_http_proxy.terraform_on_gcp_http_proxy.self_link
  port_range = "80"
}
