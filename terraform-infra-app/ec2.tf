resource "aws_key_pair" "my_key" {

        key_name = "${var.env}-infra-app-key"
        public_key = file("new-key")

        tags = {
             Environment = var.env
        }
}


# resource "aws_default_vpc" "default" {

# }

data "aws_vpc" "default" {
  default = true
}


resource "aws_security_group" "my_security_group" {

        name = "${var.env}-infra-app-sg"
        description = "This will add a TF generated security group"
        vpc_id = data.aws_vpc.default.id



        ingress {

                from_port = 22
                to_port = 22
                protocol = "tcp"
                cidr_blocks = ["0.0.0.0/0"]
                description = "SSH open"
        }

        ingress {

                from_port = 80
                to_port = 80
                protocol = "tcp"
                cidr_blocks = ["0.0.0.0/0"]
                description = "HTTP open"
        }

        ingress {

                from_port = 0
                to_port = 0
                protocol = "-1"
                cidr_blocks = ["0.0.0.0/0"]
                description = "ALL OPEN"
        }

        tags = {

             Name = "${var.env}-infra-app-sg"
  }
}

resource "aws_instance" "my_instance" {

        count = var.instance_count

        depends_on = [ aws_security_group.my_security_group, aws_key_pair.my_key ]

        key_name = aws_key_pair.my_key.key_name
        # aws_security_groups = aws_security_group.my_security_group.name 
        vpc_security_group_ids = [aws_security_group.my_security_group.id]
        instance_type = var.instance_type
        ami = var.ec2_ami_id


        root_block_device {
            volume_size = max(var.root_volume_size, 8)
            volume_type = "gp3"
        }

        tags = {
             Name = "${var.env}-infra-app-instance"
             Environment = var.env

        }
}