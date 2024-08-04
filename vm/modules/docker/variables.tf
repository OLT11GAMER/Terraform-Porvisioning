variable "vm_instance_name" {
  description = "The name of the VM instance to install Docker on."
  type        = string
  default     = "docker-vm-instance"
}

variable "mssql_sa_password" {
  description = "The SA password for MSSQL."
  type        = string
  default     = "StrongPassword123!"
}

variable "rabbitmq_user" {
  description = "The RabbitMQ username."
  type        = string
  default     = "myuser"
}

variable "rabbitmq_password" {
  description = "The RabbitMQ password."
  type        = string
  default     = "mypassword"
}

variable "project_id" {
  description = "The ID of the Google Cloud project."
  type        = string
}
