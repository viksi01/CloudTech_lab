module "labels" {
  source  = "cloudposse/label/null"
  name    = var.name
}

resource "aws_iam_role" "get_all_authors_lambda_role" {
    name = "get-all-authors-lambda-role"
    assume_role_policy = jsonencode({
        Version = "2012-10-17",
        Statement = [
        {
            Action = "sts:AssumeRole",
            Effect = "Allow",
            Principal = {
            Service = "lambda.amazonaws.com"
            }
        }
        ]
    })
}

resource "aws_iam_policy" "get_all_authors_lambda_policy" {
    name = "get-all-authors-lambda-policy"

     policy      = jsonencode({
        Version = "2012-10-17",
        Statement = [
        {
            Action = [
            "dynamodb:Scan",
            ],
            Resource = var.dynamodb_authors_arn,
             Effect   = "Allow"
        },
        {
            Action = [
            "logs:CreateLogGroup",
            "logs:CreateLogStream",
            "logs:PutLogEvents"
            ],
            Resource = "arn:aws:logs:*:*:*",
            Effect   = "Allow"
        }
        ]
    })
}

resource "aws_iam_role_policy_attachment" "lambda_policy_attachment_get_all_authors" {
    policy_arn = aws_iam_policy.get_all_authors_lambda_policy.arn
    role       = aws_iam_role.get_all_authors_lambda_role.name
}