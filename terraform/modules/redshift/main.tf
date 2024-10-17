resource "aws_redshift_subnet_group" "this" {
  name       = var.subnet_group_name
  subnet_ids = var.private_subnet_ids

  tags = var.tags
}

data "aws_iam_policy_document" "redshift_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["redshift.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "this" {
  name               = var.iam_role_name
  assume_role_policy = data.aws_iam_policy_document.redshift_assume_role.json
}

resource "aws_iam_role_policy_attachment" "redshift_s3_access" {
  role       = aws_iam_role.this.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

resource "aws_redshift_cluster" "this" {
  cluster_identifier      = var.cluster_identifier
  node_type               = var.node_type
  number_of_nodes         = var.number_of_nodes
  database_name           = var.database_name
  master_username         = var.master_username
  master_password         = var.master_password
  iam_roles               = [aws_iam_role.this.arn]
  cluster_subnet_group_name = aws_redshift_subnet_group.this.name
  vpc_security_group_ids  = var.security_group_ids
  publicly_accessible     = false
  encrypted               = true
  skip_final_snapshot     = true
  # apply_immediately     = true  # Remove or comment out this line

  tags = var.tags
}

output "redshift_endpoint" {
  value = aws_redshift_cluster.this.endpoint
}

output "redshift_iam_role_arn" {
  value = aws_iam_role.this.arn
}
