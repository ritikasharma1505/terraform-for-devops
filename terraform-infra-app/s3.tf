resource "aws_s3_bucket" "my_bucket" {
  bucket = "${var.env}-${var.bucket-name}-2211"


  tags = {
                Name = "${var.env}-${var.bucket-name}-2211"
                Environment = var.env
        }
}