variable "project_id" { type = string }
variable "project_name" { type = string }
variable "region" { type = string  default = "asia-south1" }
variable "zone" { type = string  default = "asia-south1-a" }
variable "cluster_name" { type = string  default = "devops-ia-cluster" }
variable "frontend_bucket" { type = string  default = "devops-ia-frontend-bucket" }
variable "network_name" { type = string  default = "default" }
variable "subnet_name" { type = string  default = "default" }
variable "artifact_location" { type = string default = "asia-south1" }
variable "enable_cdn" { type = bool default = false }
