resource "aws_ebs_volume" "prometheus" {
  availability_zone = "ca-central-1a"  # Usa la zona de disponibilidad adecuada
  size              = 10            # Tamaño del volumen en GiB
  type              = "gp2"         # Tipo de volumen (puede ser 'gp2', 'io1', etc.)
  tags = {
    Name = "prometheus-volume"
  }
}

resource "aws_ebs_volume" "grafana" {
  availability_zone = "ca-central-1a"  # Usa la zona de disponibilidad adecuada
  size              = 10            # Tamaño del volumen en GiB
  type              = "gp2"         # Tipo de volumen (puede ser 'gp2', 'io1', etc.)
  tags = {
    Name = "grafana-volume"
  }
}
