# Define the AWS Provider
provider "aws" {
  region = "eu-central-1"
}

# Define Account ID Variable for Reusability
variable "account_id" {
  default = "597088028976"  # Your AWS Account ID
}

# Create the S3 Bucket
resource "aws_s3_bucket" "cloud_programming_project" {
  bucket = "cloud-programming-project"
  acl    = "private"  # Set to private since access will be controlled via CloudFront

  website {
    index_document = "index.html"
    error_document = "index.html"
  }
}

# Define the Origin Access Identity for CloudFront to access the S3 bucket securely
resource "aws_cloudfront_origin_access_identity" "cloud_programming_identity" {
  comment = "OAI for cloud-programming-project"
}

# S3 Bucket Policy to allow CloudFront to access the bucket via OAI
resource "aws_s3_bucket_policy" "cloud_programming_policy" {
  bucket = aws_s3_bucket.cloud_programming_project.id
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "AllowCloudFrontOAIReadOnly",
        "Effect": "Allow",
        "Principal": {
          "AWS": "arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity E6LZJ10VWTXEN"
        },
        "Action": "s3:GetObject",
        "Resource": "${aws_s3_bucket.cloud_programming_project.arn}/*"
      }
    ]
  })
}

# Upload the index.html file to the S3 bucket with explicit Content-Type
resource "aws_s3_bucket_object" "index_html" {
  bucket       = aws_s3_bucket.cloud_programming_project.bucket
  key          = "index.html"
  source       = "C:\\Users\\diksh\\OneDrive\\Desktop\\AWS Project\\Terraform Website project\\index.html"
  content_type = "text/html"  # Explicitly set MIME type
}

# Configure CloudFront Distribution for Global Access
resource "aws_cloudfront_distribution" "cloud_programming_distribution" {
  origin {
    domain_name = aws_s3_bucket.cloud_programming_project.bucket_regional_domain_name
    origin_id   = "S3-cloud-programming-project"

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.cloud_programming_identity.cloudfront_access_identity_path
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"

  # Default Cache Behavior for CloudFront
  default_cache_behavior {
    target_origin_id       = "S3-cloud-programming-project"
    viewer_protocol_policy = "redirect-to-https"

    allowed_methods = ["GET", "HEAD"]
    cached_methods  = ["GET", "HEAD"]

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    min_ttl     = 0
    default_ttl = 3600
    max_ttl     = 86400
  }

  # Viewer Certificate for HTTPS (using default CloudFront certificate)
  viewer_certificate {
    cloudfront_default_certificate = true
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  # Price Class (adjust for cost vs performance needs)
  price_class = "PriceClass_100"
}

# Output CloudFront Distribution URL for easy access
output "cloudfront_url" {
  value       = "d24pwuzv300krp.cloudfront.net"  # Specific CloudFront URL
  description = "The CloudFront distribution URL for the website"
}

# Output for CloudFront Origin Access Identity ID
output "cloudfront_oai_id" {
  value       = "origin-access-identity/cloudfront/E6LZJ10VWTXEN"  # Specific OAI ID
  description = "The ARN of the CloudFront Origin Access Identity (OAI) for the S3 bucket."
}

# Output for CloudFront Distribution ID (for verification)
output "cloudfront_distribution_id" {
  value       = "E16DJ29NPUGAAP"  # Specific CloudFront Distribution ID
  description = "The ID of the CloudFront distribution."
}
