resource "google_container_cluster" "primary" {
  name     = var.gke_cluster_name
  location = var.region
  network = google_compute_network.vpc_network_dev.name
  project = var.Dev_projectID
  subnetwork = google_compute_subnetwork.subnet_dev.name

  remove_default_node_pool = true
  initial_node_count       = 2

  master_auth {
    client_certificate_config {
      issue_client_certificate = false
    }
  }

}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = var.gke_np_name
  location   = var.region
  cluster    = google_container_cluster.primary.name
  node_count = 2

  node_config {
    preemptible  = true
    machine_type = var.np_machine_type

    metadata = {
      disable-legacy-endpoints = "true"
    }

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}