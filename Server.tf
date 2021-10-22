provider "aws" {
  region = "us-east-2"
}

#Variable de desarrollo
variable "servidor" {
  description = "Es el nombre del servidor"
  type = number
  default = 8080
}

#Variable de salida

output "ip_publica" {
  description = "Es el valor de la IP publica"
  value = aws_instance.server-proyecto.public_ip
  sensitive = false
}

#Creacion de instancia
resource "aws_instance" "server-proyecto" {
  ami = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.grupo_seguridad.id]

user_data = <<-EOF
#!/bin/bash
echo "Hola, Mundo Brayan Cabrera" > index.html
nohup busybox httpd -f -p ${var.servidor} &
EOF

tags = {
  Name = "ejemplo-terrafor" 
 }
}
#Grupo de seguridad
resource "aws_security_group" "grupo_seguridad" {
  name = "grupo-seguridad"
  ingress {
      from_port = var.servidor
      to_port = var.servidor
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
}