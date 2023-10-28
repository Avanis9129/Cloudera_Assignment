resource "aws_s3_bucket" "cloudera_bucket" {
  bucket = "avanis-asmt-bucket" # Set a unique name for your bucket
  }

resource "aws_s3_object" "data_lake"{
    bucket = "${aws_s3_bucket.cloudera_bucket.id}"
    key    = "my-dl/"
}
