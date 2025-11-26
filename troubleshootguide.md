### S3 error — BucketAlreadyExists (409)

Cause: S3 bucket names are globally unique. The bucket name dev-infra-app-bucket (or similar) is already owned by someone (maybe you or another account), so AWS rejects creation.

Fix options (pick one):

- Choose a globally unique bucket name (add account id, region, random suffix, or timestamp).

- If the bucket already belongs to you and you want Terraform to manage it, import the existing bucket into Terraform state instead of creating it.

- Recommended Terraform change — add a short random suffix so names are unique:

Add this to your config:

```
resource "random_id" "bucket_suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "${var.env}-infra-app-bucket-${random_id.bucket_suffix.hex}"
  acl    = "private"

  tags = {
    Name        = "${var.env}-infra-app-bucket"
    Environment = var.env
  }
}

```

Don’t forget to add the random provider resource type to your providers (if not already):

*in required_providers block*

```
terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = ">= 3.0"
    }
  }
}

```


### EC2 error — InvalidBlockDeviceMapping: Volume of size 2GB is smaller than snapshot 'snap-...'

Cause: The AMI you used is backed by a snapshot whose snapshot volume is 8 GB. You attempted to launch with root_block_device.volume_size = 2, which is smaller than the snapshot minimum -> AWS rejects the RunInstances call.

Fix options (pick one):

- Increase the volume_size for the root block device to >= 8 (recommended).

- Make volume_size configurable and ensure it’s at least the snapshot size using max().

- Quick, safe fix — change the root_block_device to use a minimum of 8 GB:

Replace your root_block_device block with this (drop-in):

*define a variable (put in variables.tf)*

```
variable "root_volume_size" {
  type    = number
  default = 8
  description = "Desired root volume size in GB (must be >= the AMI snapshot size)."
}

```
*in your aws_instance resource*
*Ensure the size is at least 8 (snapshot min). If you want a different default, change var.root_volume_size*

Option A — use max (preferred)

```
root_block_device {
  # max accepts multiple numeric arguments, not a list
  volume_size = max(var.root_volume_size, 8)
  volume_type = "gp3"
}

```

Option B — use a ternary (works in older TF versions too)

```
root_block_device {
  volume_size = var.root_volume_size < 8 ? 8 : var.root_volume_size
  volume_type = "gp3"
}

```

If you prefer a simple one-line change, set volume_size = 8 directly.

**NOTE:** 
Always add public key, terraform state file in .gitignore 