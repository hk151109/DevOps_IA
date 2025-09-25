UniqScan Infra (Terraform) - Simple Steps

What this sets up
- Enables required GCP APIs
- Artifact Registry repo (us) for Docker images
- GCS bucket for frontend static hosting
- Zonal GKE cluster (default us-central1-a) + default node pool
- Cloud NAT for outbound internet access
- IAM so Cloud Build can deploy to GKE/Cloud Run and push images
- Firewall rule to allow GCLB health checks (80/443)

Before you start
- Install: gcloud CLI, Terraform >=1.5
- Authenticate: gcloud auth application-default login

How to use
1) Edit variables in terraform.tfvars (create this file next to these .tf files):
   project_id  = "uniqscan"
   project_name = "UniqScan"
   region      = "us-central1"
   zone        = "us-central1-a"
   cluster_name = "devops-ia-cluster"
   frontend_bucket = "devops-ia-frontend-bucket"

2) Init and apply:
   pwsh
   terraform init
   terraform apply -auto-approve

3) Outputs will show the cluster name/zone and bucket name you need in Cloud Build triggers.

Cleanup
   terraform destroy -auto-approve
