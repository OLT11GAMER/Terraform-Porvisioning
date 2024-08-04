variable "project_id" {
  description = "The ID of the project in which to create the VM."
  type        = string
}

variable "region" {
  description = "The region where the VM will be deployed."
  type        = string
}

variable "zone" {
  description = "The zone where the VM will be deployed."
  type        = string
}

variable "machine_type" {
  description = "The machine type for the VM instance."
  type        = string
  default     = "e2-medium"
}

variable "vm_name" {
  description = "The name of the VM instance."
  type        = string
  default     = "my-vm-instance"
}

variable "image" {
  description = "The image to use for the VM instance."
  type        = string
  default     = "ubuntu-os-cloud/ubuntu-2004-lts"
}
