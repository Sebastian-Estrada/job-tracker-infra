module "ecr" {
  source = "../../modules/ecr"

  repository_names = ["backend", "frontend"]
}

# live/production/main.tf
module "eks" {
  source = "../../modules/eks"

  cluster_name    = var.cluster_name
  vpc_id          = data.aws_vpc.default.id
  subnet_ids      = data.aws_subnets.default.ids
  node_group_name = var.node_group_name
  instance_types  = var.instance_types
  desired_size    = var.desired_size
  min_size        = var.min_size
  max_size        = var.max_size
  tags            = var.tags
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_name
}

module "kubernetes" {
  source = "../../modules/kubernetes"

  cluster_endpoint = module.eks.cluster_endpoint
  cluster_ca_cert  = module.eks.cluster_certificate_authority_data
  cluster_token    = data.aws_eks_cluster_auth.cluster.token

  backend_image  = "${module.ecr.repository_urls["backend"]}:latest"
  frontend_image = "${module.ecr.repository_urls["frontend"]}:latest"

  backend_replicas  = var.backend_replicas
  frontend_replicas = var.frontend_replicas
}
