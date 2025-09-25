data "google_project" "project" {
  project_id = var.project_id
}

resource "google_project_service" "services" {
  for_each = toset([
    "artifactregistry.googleapis.com",
    "container.googleapis.com",
    "cloudbuild.googleapis.com",
    "compute.googleapis.com",
    "run.googleapis.com",
    "servicenetworking.googleapis.com",
    "cloudresourcemanager.googleapis.com",
  ])
  project = var.project_id
  service = each.value
}

resource "google_artifact_registry_repository" "docker" {
  location      = var.artifact_location
  repository_id = "containers"
  description   = "Docker images"
  format        = "DOCKER"
  depends_on    = [google_project_service.services]
}

resource "google_storage_bucket" "frontend" {
  name          = var.frontend_bucket
  location      = var.region
  force_destroy = true
  uniform_bucket_level_access = true
  website {
    main_page_suffix = "index.html"
    not_found_page   = "index.html"
  }
}

resource "google_compute_router" "nat_router" {
  name    = "nat-router"
  network = var.network_name
  region  = var.region
}

resource "google_compute_router_nat" "nat" {
  name                               = "nat-config"
  router                             = google_compute_router.nat_router.name
  region                             = var.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}

resource "google_container_cluster" "primary" {
  name     = var.cluster_name
  location = var.zone
  network  = var.network_name
  remove_default_node_pool = true
  initial_node_count       = 1
  depends_on = [google_project_service.services]
}

resource "google_container_node_pool" "pool" {
  name       = "default-pool"
  cluster    = google_container_cluster.primary.name
  location   = var.zone
  node_count = 1

  node_config {
    machine_type = "e2-standard-4"
    tags         = ["gke-${var.cluster_name}-nodes"]
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }
}

# IAM: allow Cloud Build SA to manage GKE, Cloud Run, and write to buckets
resource "google_project_iam_member" "cb_roles" {
  for_each = toset([
    "roles/artifactregistry.writer",
    "roles/storage.admin",
    "roles/container.admin",
    "roles/run.admin",
    "roles/iam.serviceAccountUser",
  ])
  project = var.project_id
  role    = each.value
  member  = "serviceAccount:${data.google_project.project.number}@cloudbuild.gserviceaccount.com"
}

output "gke_cluster" { value = google_container_cluster.primary.name }
output "gke_zone" { value = var.zone }
output "frontend_bucket" { value = google_storage_bucket.frontend.name }
output "artifact_repo" { value = google_artifact_registry_repository.docker.repository_id }
