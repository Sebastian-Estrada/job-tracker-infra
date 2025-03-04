resource "kubernetes_persistent_volume" "prometheus" {
  metadata {
    name = "prometheus-pv"
  }

  spec {
    capacity = {
      storage = "10Gi"
    }

    volume_mode            = "Filesystem"
    storage_class_name     = kubernetes_storage_class.standard.metadata[0].name
    access_modes           = ["ReadWriteOnce"]
    persistent_volume_reclaim_policy = "Retain"

    persistent_volume_source {
      aws_elastic_block_store {
        volume_id = var.prometheus_volume_id # Referencia al ID del volumen EBS creado
        fs_type   = "ext4"  # Tipo de sistema de archivos
      }
    }
  }
}


resource "kubernetes_persistent_volume" "grafana" {
  metadata {
    name = "grafana-pv"
  }

  spec {
    capacity = {
      storage = "10Gi"
    }

    volume_mode            = "Filesystem"
    storage_class_name     = kubernetes_storage_class.standard.metadata[0].name
    access_modes           = ["ReadWriteOnce"]
    persistent_volume_reclaim_policy = "Retain"

    persistent_volume_source {
      aws_elastic_block_store {
        volume_id = var.grafana_volume_id  # Referencia al ID del volumen EBS creado
        fs_type   = "ext4"  # Tipo de sistema de archivos
      }
    }
  }
}