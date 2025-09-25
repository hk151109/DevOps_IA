resource "google_compute_firewall" "allow_lb_healthchecks" {
  name    = "allow-lb-healthchecks"
  network = var.network_name
  allow {
    protocol = "tcp"
    ports    = ["30000-32767"]
  }
  source_ranges = [
    "35.191.0.0/16",
    "130.211.0.0/22"
  ]
  direction = "INGRESS"
  target_tags = ["gke-${var.cluster_name}-nodes"]
}

resource "google_storage_bucket_iam_member" "frontend_public" {
  bucket = var.frontend_bucket
  role   = "roles/storage.objectViewer"
  member = "allUsers"
}
