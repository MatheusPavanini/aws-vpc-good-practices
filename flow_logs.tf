resource "aws_flow_log" "eks_flow_log" {
  log_destination      = aws_s3_bucket.eks_vpc_log_s3.arn
  log_destination_type = "s3"
  traffic_type         = "ALL"
  vpc_id               = module.vpc.vpc_id
}

resource "aws_s3_bucket" "eks_vpc_log_s3" {
  bucket = "vpc-logs-pavanin"
  force_destroy = true
}