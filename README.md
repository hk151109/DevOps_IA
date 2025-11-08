# DevOps_IA – End-to-End CI/CD Architecture

This repository contains the full DevOps setup for a multi-service application with CI/CD pipelines powered by **Google Cloud Build**, integrated with **GitHub**. Each service is automatically built and deployed on every push, using the best-suited GCP deployment target.

## 📌 Overview

- **Frontend** → Deployed on **Google App Engine**  
- **Backend** → Deployed on **Cloud Run**  
- **Similarity Service** → Deployed on **Google Kubernetes Engine (GKE)**  
- **AI Content Service** → Deployed on **Google Kubernetes Engine (GKE)**  

All services are wired into a single CI/CD workflow, ensuring seamless deployments across environments.

---

## 🏗️ Architecture

The flow starts when a developer pushes code to GitHub. This triggers **Google Cloud Build**, which builds, tests, and deploys each service to its respective target environment.  

![Architecture Diagram](./arch.png)

---

## 📂 Repository Structure

This monorepo contains Terraform code and links to service-specific repositories:

- [**DevOps_IA_Frontend**](https://github.com/your-org/DevOps_IA_Frontend)  
  - JavaScript-based frontend application  
  - Deployed to **Google App Engine**  

- [**DevOps_IA_Backend**](https://github.com/your-org/DevOps_IA_Backend)  
  - JavaScript backend service  
  - Deployed to **Cloud Run**  

- [**DevOps_IA_Similarity**](https://github.com/your-org/DevOps_IA_Similarity)  
  - Python service for content similarity checking  
  - Deployed to **GKE**  

- [**DevOps_IA_ai-content**](https://github.com/your-org/DevOps_IA_ai-content)  
  - Python service for AI-generated content  
  - Deployed to **GKE**  

- **Terraform Code**  
  - Infrastructure as Code (IaC) for provisioning GCP resources  
  - Automates cluster setup, networking, and service integrations  

---

## ⚙️ CI/CD Pipeline

1. Developer pushes code → GitHub Repository  
2. GitHub triggers **Google Cloud Build**  
3. Cloud Build runs pipeline:  
   - Build container images  
   - Run tests  
   - Deploy to GCP targets (App Engine, Cloud Run, GKE)  

---

## 🚀 Deployment Targets

- **Frontend** → Google App Engine  
- **Backend** → Cloud Run  
- **Similarity Service** → GKE Cluster  
- **AI Content Service** → GKE Cluster  

---

## 📜 Getting Started

Clone this repo:

```bash
git clone https://github.com/your-org/DevOps_IA.git
cd DevOps_IA
```

### Deploy with Terraform

```bash
cd terraform
terraform init
terraform plan
terraform apply
```

This provisions all required GCP infrastructure.

---

## 🔗 Related Repositories

- [Frontend](https://github.com/your-org/DevOps_IA_Frontend)  
- [Backend](https://github.com/your-org/DevOps_IA_Backend)  
- [Similarity Service](https://github.com/your-org/DevOps_IA_Similarity)  
- [AI Content Service](https://github.com/your-org/DevOps_IA_ai-content)  

---

## 📖 Short Description

This project is a **cloud-native, multi-service system** with full **CI/CD automation**. It leverages Google Cloud’s deployment platforms (App Engine, Cloud Run, GKE) and Terraform for infrastructure management, ensuring scalable, reproducible, and production-ready deployments.

