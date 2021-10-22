provider "aws" {
  region = "us-east-2"
}

variable "servidor" {
  description = "Es el nombre del servidor"
  type = number
  default = 8080
}

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

resource "aws_security_group" "grupo_seguridad" {
  name = "grupo-seguridad"
  ingress {
      from_port = var.servidor
      to_port = var.servidor
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
}