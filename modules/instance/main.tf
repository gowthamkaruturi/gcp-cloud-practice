
resource "google_compute_instance_template" "terraform_on_gcp_instance_template" {
  name         = var.instance_template_name
  machine_type = var.machine_type
  disk {
    auto_delete  = true
    boot         = true
    source_image = var.instance_image
  }
  network_interface {
    network    = var.network_name
    subnetwork = var.subnetwork_name
    access_config {}
  }
  metadata_startup_script = file(var.startup_script)
  tags                    =  ["ssh-access", "http-server"]
}

resource "google_compute_autoscaler" "terraform_on_gcp_autosacaler" {
  name   = var.autoscaler_name
  zone   = "us-west1-b"
  target = google_compute_instance_group_manager.terraform_on_gcp_instance_group.id
  autoscaling_policy {
    max_replicas    = 2
    min_replicas    = 1
    cooldown_period = 60
    cpu_utilization {
      target = 0.75
    }
    scale_in_control {
      max_scaled_in_replicas {
        percent = 10
      }
      time_window_sec = abs(60)

    }
  
  }
  
}


resource "google_compute_instance_group_manager" "terraform_on_gcp_instance_group" {
  name               = var.instance_group_name
  base_instance_name = var.base_instance_name
  target_size        = var.target_size
  zone               = var.zone
  auto_healing_policies {
    health_check = google_compute_health_check.terraform_on_gcp_health_check.self_link
    initial_delay_sec = 30
  }
 
  version {
    name              = google_compute_instance_template.terraform_on_gcp_instance_template.name
    instance_template = google_compute_instance_template.terraform_on_gcp_instance_template.self_link
  }
  
}


resource "google_compute_health_check" "terraform_on_gcp_health_check" {
  name        = var.healthcheck_name
  description = "Health check via htp"

  timeout_sec         = 1
  check_interval_sec  = 1
  healthy_threshold   = 4
  unhealthy_threshold = 5

  http_health_check {
    port_name = "http-health-check-port"
    port      = 80
    request_path = "/"
    proxy_header = "NONE"
  }
  
}

output "instance_template_name" {
  value = google_compute_instance_template.terraform_on_gcp_instance_template.name
}

output "instance_group_name" {
  value = google_compute_instance_group_manager.terraform_on_gcp_instance_group.name
}


