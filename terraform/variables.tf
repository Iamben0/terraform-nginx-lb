variable "location" {
  description = "The Azure region for all resources"
  default     = "East US"
}

variable "instances" {
  description = "The number of VM instances to create"
  default     = 2
}