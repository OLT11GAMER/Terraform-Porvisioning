provider "google" {
  project = "task-management-app-430719"
  region  = "europe-central2"
  credentials = file("${path.module}/key.json")
}

module "vm" {
  source      = "./modules/vm"
  project_id  = "task-management-app-430719"
  region      = "europe-central2"
  zone        = "europe-central2-b"
  vm_name     = "db-vm-instance"
  machine_type = "e2-medium"
  image        = "ubuntu-os-cloud/ubuntu-2004-lts"
}

module "docker" {
  source             = "./modules/docker"
  vm_instance_name   = module.vm.instance_name
  project_id  = "task-management-app-430719"
  mssql_sa_password  = "StrongPassword123!"
  rabbitmq_user      = "myuser"
  rabbitmq_password  = "mypassword"
}
