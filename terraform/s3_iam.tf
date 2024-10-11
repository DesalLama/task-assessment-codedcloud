# S3 bucket with lifecycle policy
resource "aws_s3_bucket" "bucket" {
  bucket = "${var.project_name}-s3-bucket-${var.suffix}"

  lifecycle_rule {
    id      = "expire-older-than-7-days"
    enabled = true

    expiration {
      days = 7
    }

    prefix = "/"
  }

  tags = {
    Name = "${var.project_name}-s3-bucket-${var.suffix}"
  }
}

# Create a policy to allow group to push/delete objects
resource "aws_iam_policy" "s3_access_policy" {
  name        = "${var.project_name}-s3-policy-${var.suffix}"
  description = "S3 bucket policy for the group"
  policy      = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect"   : "Allow",
        "Action"   : ["s3:PutObject", "s3:DeleteObject"],
        "Resource" : "${aws_s3_bucket.bucket.arn}/*"
      }
    ]
  })
}

# Create IAM group
resource "aws_iam_group" "user_grp" {
  name = "${var.project_name}-group-${var.suffix}"
}

# Attach policy to group
resource "aws_iam_group_policy_attachment" "grp_policy_attachment" {
  group      = aws_iam_group.user_grp.name
  policy_arn = aws_iam_policy.s3_access_policy.arn
}

# Create IAM user
resource "aws_iam_user" "iam_user" {
  name = "${var.project_name}-user-${var.suffix}"
}

# Add user to the group
resource "aws_iam_user_group_membership" "group_membership" {
  user = aws_iam_user.iam_user.name
  groups = [aws_iam_group.user_grp.name]
}

# Output the bucket name and user
output "s3_bucket_name" {
  value = aws_s3_bucket.bucket.bucket
}

output "iam_user" {
  value = aws_iam_user.iam_user.name
}

