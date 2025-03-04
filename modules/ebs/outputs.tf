output "prometheus_volume_id" {
  value = aws_ebs_volume.prometheus.id
}

output "grafana_volume_id" {
  value = aws_ebs_volume.grafana.id
}