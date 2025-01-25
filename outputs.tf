output "vpc_network_name" {
  description = "Name of the created VPC network"
  value       = google_compute_network.vpc_network.name
}

output "public_subnet_name" {
  description = "Name of the public subnet"
  value       = google_compute_subnetwork.public_subnet.name
}

output "private_subnet_name" {
  description = "Name of the private subnet"
  value       = google_compute_subnetwork.private_subnet.name
}

output "private_vm_internal_ip" {
  description = "Internal IP address of the private VM"
  value       = google_compute_instance.private-vm.network_interface[0].network_ip
}

output "firewall_rules" {
  description = "List of firewall rule names created"
  value = [
    google_compute_firewall.custom-firewall.name,
    google_compute_firewall.allow-internal-traffic.name,
    google_compute_firewall.allow-egress-for-all.name
  ]
}
