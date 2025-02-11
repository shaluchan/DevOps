resource "aws_iam_role" "ec2_s3_access_role" {
    name = "ec2_s3_access_role_v2"
    assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}
resource "aws_iam_policy" "ec2_s3_access_policy" {
    name = "ec2_s3_access_policy"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:GetObject",
        "s3:ListBucket",
        "s3:PutBucketPolicy",
        "s3:GetBucketPolicy",
        "s3:DeleteBucketPolicy"
        ],
        "Resource": [
            "arn:aws:s3:::my_bucket",
            "arn:aws:s3:::my_bucket/*"
        ]
      }
    ]
}
EOF
}
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2_profile_new"
  role = aws_iam_role.ec2_s3_access_role.name
}
