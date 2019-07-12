# Define SSH key pair for our instances
resource "aws_key_pair" "default" {
  #key_name = "Abhishekjainaws18_nov18"
  public_key = "${file("${var.key_path}")}"
}

# Define webserver inside the public subnet
resource "aws_instance" "wb" {
   ami  = "${var.ami}"
   instance_type = "t1.micro"
   key_name = "Abhishekjainaws18_nov18"
   subnet_id = "${aws_subnet.public-subnet.id}"
   vpc_security_group_ids = ["${aws_security_group.sgweb.id}"]
   associate_public_ip_address = true
   source_dest_check = false
   user_data = "${file("install.sh")}"

  tags = {
    Name = "demo-webserver"
  }
}

# Define database inside the private subnet
resource "aws_instance" "db" {
   ami  = "${var.ami}"
   instance_type = "t1.micro"
   key_name = "Abhishekjainaws18_nov18"
   subnet_id = "${aws_subnet.private-subnet.id}"
   vpc_security_group_ids = ["${aws_security_group.sgdb.id}"]
   source_dest_check = false
   user_data = "${file("mysqlinstall.sh")}"

  tags = {
    Name = "demo-database"
  }
}


