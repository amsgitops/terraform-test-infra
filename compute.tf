data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "web" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.public[0].id
  vpc_security_group_ids = [aws_security_group.web.id]
  iam_instance_profile   = aws_iam_instance_profile.web_server.name
  # Enable detailed monitoring (1-minute granularity) so that the
  # aws_cloudwatch_metric_alarm.web_cpu alarm has reliable data points.
  monitoring             = true

  user_data = <<-EOF
    #!/bin/bash
    yum install -y httpd
    systemctl start httpd
    echo "<h1>${var.project_name}</h1>" > /var/www/html/index.html
  EOF

  tags = {
    Name        = "${var.project_name}-web-server"
    Environment = var.environment
    Role        = "web"
  }
}

resource "aws_instance" "bastion" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.public[0].id
  vpc_security_group_ids = [aws_security_group.bastion.id]

  tags = {
    Name        = "${var.project_name}-bastion"
    Environment = var.environment
    Role        = "bastion"
  }
}
