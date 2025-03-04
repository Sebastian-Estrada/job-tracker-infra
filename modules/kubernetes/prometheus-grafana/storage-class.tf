resource "kubernetes_storage_class" "standard" {
  metadata {
    name = "standard"
  }

  storage_provisioner = "kubernetes.io/aws-ebs"  # Provisionador para AWS EBS
  reclaim_policy = "Delete"  # Política de retención
  volume_binding_mode = "Immediate"

  parameters = {
    type = "gp2"
  }
}
