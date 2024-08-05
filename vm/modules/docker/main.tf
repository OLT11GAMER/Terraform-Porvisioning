resource "google_compute_instance" "docker_instance" {
  name         = "docker-vm-instance" # Ensure this name is unique
  machine_type = "e2-medium"
  zone         = "europe-central2-b"
  project      = var.project_id

  metadata_startup_script = <<-EOT
    #! /bin/bash
    sudo apt-get update
    sudo apt-get install -y docker.io

    sudo docker run --name mssql-server -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=${var.mssql_sa_password}' -p 1433:1433 -d mcr.microsoft.com/mssql/server:2019-latest

    sudo docker run --name rabbitmq -p 5672:5672 -p 15672:15672 -d rabbitmq:3-management

    sudo docker exec rabbitmq rabbitmqctl add_user ${var.rabbitmq_user} ${var.rabbitmq_password}
    sudo docker exec rabbitmq rabbitmqctl set_user_tags ${var.rabbitmq_user} administrator
    sudo docker exec rabbitmq rabbitmqctl set_permissions -p / ${var.rabbitmq_user} ".*" ".*" ".*"
  EOT

  network_interface {
    network = "default"
    access_config {} # This is required to assign a public IP
  }

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
    }
  }
}
resource "google_compute_firewall" "allow_postgres" {
  name    = "allow-postgres"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["5672","15672"]
  }

  source_ranges = ["0.0.0.0/0"] # Allow traffic from any IP. For better security, replace with your Kubernetes cluster's IP range.
}