# Infrastructure Setup for DevOps and Cloud Computing Project

This repository contains the Terraform configuration for setting up the infrastructure for a DevOps and Cloud Computing project. The infrastructure includes AWS EKS, RDS, ECR, and other resources.

## Directory Structure

- `modules/`: Contains reusable Terraform modules.
  - `eks/`: Module for setting up an EKS cluster.
  - `rds/`: Module for setting up an RDS instance.
  - `ecr/`: Module for setting up ECR repositories.
  - `ebs/`: Module for setting up EBS volumes.
  - `kubernetes/`: Module for setting up Kubernetes resources.
    - `prometheus-grafana/`: Submodule for setting up Prometheus and Grafana on Kubernetes.

- `live/`: Contains environment-specific configurations.
  - `global/`: Global resources such as S3 bucket and DynamoDB table for Terraform state.
  - `production/`: Production environment configuration.

## Usage

### Initialize Terraform

```sh
terraform init
```

### Plan and Apply Changes

```sh
terraform plan
terraform apply
```

### AWS EKS Configuration

To update the kubeconfig for the EKS cluster:

```sh
aws eks update-kubeconfig --region ca-central-1 --name production-eks-cluster --profile personal-account
```

### Deleting Persistent Volume Claims (PVCs)

To delete a specific PVC:

```sh
kubectl delete pvc <nombre-del-pvc> -n <namespace>
```

To delete all PVCs in the "monitoring" namespace:

```sh
kubectl delete pvc --all -n monitoring
```

## Modules

### EKS Module

The EKS module sets up an EKS cluster with managed node groups.

### RDS Module

The RDS module sets up a PostgreSQL database instance.

### ECR Module

The ECR module sets up Docker container repositories.

### EBS Module

The EBS module sets up Elastic Block Store volumes for Prometheus and Grafana.

### Kubernetes Module

The Kubernetes module sets up deployments and services for backend and frontend applications.

### Prometheus-Grafana Submodule

The Prometheus-Grafana submodule sets up monitoring using Prometheus and Grafana.

## Outputs

The configuration provides various outputs such as cluster endpoints, service names, and volume IDs.

### Helm Repository Update

Before deploying Helm charts, ensure your Helm repositories are up to date:

```sh
helm repo update
```