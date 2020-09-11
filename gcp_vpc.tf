//VPC for Developer
resource "google_compute_network" "vpc_network_dev" {
  name = "vpc-developer"
  description = "VPC for Developer"
  auto_create_subnetworks = false
  routing_mode = "REGIONAL"
}
resource "google_compute_firewall" "dev_firewall" {
  name    = "firewall-rules-dev"
  network = google_compute_network.vpc_network_dev.name

  allow {
    protocol = "tcp"
  }
  allow {
    protocol = "udp"
  }
}
//VPC for Production
resource "google_compute_network" "vpc_network_prod" {
  name = "vpc-production"
  provider = google.for-production
  description = "VPC for Production"
  auto_create_subnetworks = false
  routing_mode = "REGIONAL"
  project = "production-289204"
}

resource "google_compute_firewall" "prod_filewall" {
  name    = "firewall-rule-prod"
  network = google_compute_network.vpc_network_prod.name
  provider = google.for-production

  allow {
    protocol = "tcp"
  }
  allow {
    protocol = "udp"
  }
}

//Subnet In Dev_VPC
resource "google_compute_subnetwork" "subnet_dev" {
  name          = "developer-subnet1"
  ip_cidr_range = "10.2.1.0/24"
  region        = "asia-southeast1"
  network       = google_compute_network.vpc_network_dev.id
  private_ip_google_access = true
  }
//Subnet In Prod_VPC
  resource "google_compute_subnetwork" "subnet_prod" {
  name          = "production-subnet1"
  provider = google.for-production
  ip_cidr_range = "10.2.2.0/24"
  region        = "us-east1"
  network       = google_compute_network.vpc_network_prod.id
  private_ip_google_access = true
}
