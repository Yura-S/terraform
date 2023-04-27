resource "aws_instance" "tf_instance" {
  ami           = "ami-0a695f0d95cefc163"
  instance_type = "t2.micro"
  key_name      = "TfKeyPair"

  subnet_id                   = aws_subnet.tf_public_subnet.id
  vpc_security_group_ids      = [aws_security_group.tf_sg.id]
  associate_public_ip_address = true

  user_data = <<-EOF
  #!/bin/bash -ex

  amazon-linux-extras install nginx1 -y
  echo "<h1>$(curl https://api.kanye.rest/?format=text)</h1>" >  /usr/share/nginx/html/index.html 
  systemctl enable nginx
  systemctl start nginx
  EOF

  tags = {
    "Name" : "Chuck Norris"
  }
}
