# dev infrastructure

module "dev-infra" {
        source = "./infra-app"
        env = "dev"
        bucket-name = "infra-app-bucket"
        instance_type = "t2.micro"
        instance_count = 3
        ec2_ami_id = "ami-0f5fcdfbd140e4ab7"  # ubuntu
        hash_key = "studentID"
}

# prd infrastructure

module "prd-infra" {
        source = "./infra-app"
        env = "prd"
        bucket-name = "infra-app-bucket"
        instance_type = "t2.medium"
        instance_count = 2
        ec2_ami_id = "ami-0f5fcdfbd140e4ab7"  # ubuntu
        hash_key = "studentID"
}

# stg infrastructure

module "stg-infra" {
        source = "./infra-app"
        env = "stg"
        bucket-name = "infra-app-bucket"
        instance_type = "t2.small"
        instance_count = 2
        ec2_ami_id = "ami-0f5fcdfbd140e4ab7"  # ubuntu
        hash_key = "studentID"
}