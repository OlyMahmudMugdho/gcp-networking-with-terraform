variable "region" {
  description = "The region in which the resources will be created."
  default     = "us-west-2"
}

variable "zone" {
  description = "The zone in which the resources will be created."
  default     = "us-west-2a"
}

variable "project" {
  description = "The GCP project in which the resources will be created."
  default     = "my-project"
}

variable "network_name" {
  description = "The name of the VPC network."
  default     = "my-network"
}

variable "routing_mode" {
  description = "The routing mode for the VPC network."
  default     = "REGIONAL"
}

variable "public_subnet_name" {
  description = "The name of the subnet."
  type        = string
  default     = "public-subnet"
}

variable "private_subnet_name" {
  description = "The name of the subnet."
  type        = string
  default     = "private-subnet"
}

variable "ip_cidr_range" {
  description = "The IP CIDR range for the subnet."
  type = object({
    public_subnet  = string,
    private_subnet = string
  })
  default = {
    public_subnet  = "10.0.0.0/16",
    private_subnet = "10.1.0.0/16"
  }
}

variable "custom_firewall_name" {
  description = "The name of the custom firewall rule."
  default     = "public-network-allow-http-https-ssh"
}

variable "custom_firewall_priority" {
  description = "The priority of the custom firewall rule."
  default     = 100
}

variable "custom_firewall_ports" {
  description = "The ports to open in the custom firewall rule."
  type        = list(string)
  default     = ["80", "443", "8080", "22"]
}

variable "allow_internal_traffic_name" {
  description = "The name of the internal traffic firewall rule."
  default     = "allow-internal-traffic"
}

variable "allow_internal_traffic_priority" {
  description = "The priority of the internal traffic firewall rule."
  default     = 101
}

variable "allow_internal_traffic_ports" {
  description = "The ports to open in the internal traffic firewall rule."
  type        = list(string)
  default     = ["all"]
}

variable "common_tags" {
  description = "The common tags to apply to all resources."
  type        = set(string)
  default     = ["public", "private"]
}
