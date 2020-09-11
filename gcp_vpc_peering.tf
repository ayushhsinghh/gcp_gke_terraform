resource "google_compute_network_peering" "peering1" {
  name         = "peering-proc-dev"
  provider = google.for-production
  network      = google_compute_network.vpc_network_prod.id
  peer_network = google_compute_network.vpc_network_dev.id
}

resource "google_compute_network_peering" "peering2" {
  name         = "peering-dev-prod"
  network      = google_compute_network.vpc_network_dev.id
  peer_network = google_compute_network.vpc_network_prod.id
}