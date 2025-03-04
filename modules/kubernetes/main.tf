# This Terraform configuration file sets up Kubernetes resources for a backend and frontend application.
# It includes the following resources:
#
# 1. Kubernetes Provider:
#    - Configures the Kubernetes provider with the cluster endpoint, CA certificate, and token.
#
# 2. Backend Deployment:
#    - Creates a Kubernetes deployment for the backend application.
#    - Metadata:
#      - Name: backend
#      - Labels: app = "backend"
#    - Spec:
#      - Replicas: Number of backend replicas (configured via variable `backend_replicas`).
#      - Selector: Matches labels app = "backend".
#      - Template:
#        - Metadata: Labels app = "backend".
#        - Spec:
#          - Container:
#            - Name: backend
#            - Image: Backend container image (configured via variable `backend_image`).
#            - Port: Container port 8080.
#            - Resources:
#              - Limits: CPU 250m, Memory 256Mi.
#              - Requests: CPU 125m, Memory 128Mi.
#
# 3. Backend Service:
#    - Creates a Kubernetes service for the backend application.
#    - Metadata:
#      - Name: backend
#    - Spec:
#      - Selector: Matches labels app = "backend".
#      - Port: Exposes port 8080 and targets port 8080.
#      - Type: ClusterIP.
#
# 4. Frontend Deployment:
#    - Creates a Kubernetes deployment for the frontend application.
#    - Metadata:
#      - Name: frontend
#      - Labels: app = "frontend"
#    - Spec:
#      - Replicas: Number of frontend replicas (configured via variable `frontend_replicas`).
#      - Selector: Matches labels app = "frontend".
#      - Template:
#        - Metadata: Labels app = "frontend".
#        - Spec:
#          - Container:
#            - Name: frontend
#            - Image: Frontend container image (configured via variable `frontend_image`).
#            - Port: Container port 5173.
#            - Resources:
#              - Limits: CPU 250m, Memory 256Mi.
#              - Requests: CPU 125m, Memory 128Mi.
#
# 5. Frontend Service:
#    - Creates a Kubernetes service for the frontend application.
#    - Metadata:
#      - Name: frontend
#    - Spec:
#      - Selector: Matches labels app = "frontend".
#      - Port: Exposes port 80 and targets port 80.
#      - Type: LoadBalancer.


provider "kubernetes" {
  host                   = var.cluster_endpoint
  cluster_ca_certificate = base64decode(var.cluster_ca_cert)
  token                  = var.cluster_token
}

resource "kubernetes_deployment" "backend" {
  metadata {
    name = "backend"
    labels = {
      app = "backend"
    }
  }

  spec {
    replicas = var.backend_replicas

    selector {
      match_labels = {
        app = "backend"
      }
    }

    template {
      metadata {
        labels = {
          app = "backend"
        }
      }

      spec {
        container {
          name  = "backend"
          image = var.backend_image

          port {
            container_port = 8080
          }

          resources {
            limits = {
              cpu    = "250m"
              memory = "256Mi"
            }
            requests = {
              cpu    = "125m"
              memory = "128Mi"
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "backend" {
  metadata {
    name = "backend"
  }

  spec {
    selector = {
      app = "backend"
    }

    port {
      port        = 8080
      target_port = 8080
    }

    type = "ClusterIP"
  }
}

resource "kubernetes_deployment" "frontend" {
  metadata {
    name = "frontend"
    labels = {
      app = "frontend"
    }
  }

  spec {
    replicas = var.frontend_replicas

    selector {
      match_labels = {
        app = "frontend"
      }
    }

    template {
      metadata {
        labels = {
          app = "frontend"
        }
      }

      spec {
        container {
          name  = "frontend"
          image = var.frontend_image

          port {
            container_port = 80
          }

          resources {
            limits = {
              cpu    = "250m"
              memory = "256Mi"
            }
            requests = {
              cpu    = "125m"
              memory = "128Mi"
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "frontend" {
  metadata {
    name = "frontend"
  }

  spec {
    selector = {
      app = "frontend"
    }

    port {
      port        = 80
      target_port = 80
    }

    type = "LoadBalancer"
  }
}