region       = "us-east4"
zone         = "us-east4-a"
project      = "pelagic-radio-446013-u1"
routing_mode = "REGIONAL"
network_name = "my-network"

public_subnet_name  = "public-subnet"
private_subnet_name = "private-subnet"

custom_firewall_name     = "public-network-allow-http-https-ssh"
custom_firewall_priority = 100
custom_firewall_ports    = ["80", "443", "8080", "22"]

allow_internal_traffic_name  = "allow-internal-traffic"
allow_internal_traffic_ports = ["all"]
