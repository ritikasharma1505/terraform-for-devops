variable "env" {

        description =  "This is the environment for my infra"
        type = string
}

variable "bucket-name" {

        description =  "This is the bucket name for my s3 infra"
        type = string
}

variable "instance_count" {

        description =  "This is the instance count for my infra"
        type = number
}

variable "instance_type" {

        description =  "This is the instance type for my infra"
        type = string
}

variable "ec2_ami_id" {

        description =  "This is the ec2_ami_id for my infra"
        type = string
}

variable "root_volume_size" {
  type    = number
  default = 8
  description = "Desired root volume size in GB (must be >= the AMI snapshot size)."
}

variable "hash_key" {

        description =  "This is the hash key for my dynamodb table infra"
        type = string
}