provider "google" {
  credentials = file("account.json")
  project     = var.project
  region      = var.region
  zone        = var.zone
}

resource "google_compute_network" "vpc_network" {
  name                    = var.network_name
  auto_create_subnetworks = false
  routing_mode            = var.routing_mode
}

resource "google_compute_subnetwork" "public_subnet" {
  name          = var.public_subnet_name
  ip_cidr_range = var.ip_cidr_range.public_subnet
  network       = google_compute_network.vpc_network.self_link
  region        = var.region
}


resource "google_compute_subnetwork" "private_subnet" {
  name          = var.private_subnet_name
  ip_cidr_range = var.ip_cidr_range.private_subnet
  network       = google_compute_network.vpc_network.self_link
  region        = var.region
}


resource "google_compute_firewall" "custom-firewall" {
  name          = var.custom_firewall_name
  network       = google_compute_network.vpc_network.self_link
  direction     = "INGRESS"
  priority      = var.custom_firewall_priority
  source_ranges = ["0.0.0.0/0"]

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = var.custom_firewall_ports
  }

  source_tags = ["public"]
  target_tags = ["public"]
}

resource "google_compute_firewall" "allow-internal-traffic" {
  name      = var.allow_internal_traffic_name
  network   = google_compute_network.vpc_network.self_link
  direction = "INGRESS"
  priority  = 101

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "all"
  }

  source_tags = var.common_tags
  target_tags = var.common_tags
}

resource "google_compute_firewall" "allow-egress-for-all" {
  name      = "allow-egress-for-all"
  network   = google_compute_network.vpc_network.self_link
  direction = "EGRESS"
  priority  = 10

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  target_tags = ["public"]

  destination_ranges = ["0.0.0.0/0"]
}

resource "google_compute_instance" "public-vm" {
  name         = "public-vm"
  machine_type = "e2-standard-4"
  zone         = var.zone
  tags         = ["public"]
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
      size  = 50
    }
  }
  network_interface {
    network    = var.network_name
    subnetwork = google_compute_subnetwork.public_subnet.self_link
  }
}

resource "google_compute_instance" "private-vm" {
  name         = "private-vm"
  machine_type = "e2-standard-4"
  zone         = var.zone
  tags         = ["private"]
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
      size  = 50
    }
  }
  network_interface {
    network    = var.network_name
    subnetwork = google_compute_subnetwork.private_subnet.self_link
  }
}
