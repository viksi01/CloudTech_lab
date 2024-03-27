module "labels" {
  source  = "cloudposse/label/null"
  name    = var.name
}

#get-all-authors
resource "aws_iam_role" "get_all_authors_lambda_role" {
  name = "get-all-authors-lambda-role"

  assume_role_policy = jsonencode(
  {
    Version = "2012-10-17",
    Statement = [
    {
      Action = "sts:AssumeRole",
      Principal = {
        Service = "lambda.amazonaws.com"
      },
      Effect = "Allow"
    }]
  })
}


resource "aws_iam_policy" "get_all_authors_lambda_policy" {
  name = "get-all-authors-lambda-policy"

  policy = jsonencode(
  {
    Version = "2012-10-17",
    Statement = [
    {
      Effect   = "Allow"
      Action = [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      Resource = "arn:aws:logs:*:*:*"
    },
    {
      Effect   = "Allow",
      Action = [
        "dynamodb:Scan",
        ],
      Resource = var.dynamodb_authors_arn
    }
        ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_policy_attachment_get_all_authors" {
    policy_arn = aws_iam_policy.get_all_authors_lambda_policy.arn
    role       = aws_iam_role.get_all_authors_lambda_role.name
}


#save-course
resource "aws_iam_role" "save_course_lambda_role" {
  name = "save-course-lambda-role"

  assume_role_policy = jsonencode(
  {
    Version = "2012-10-17",
    Statement = [
   {
      Action = "sts:AssumeRole",
      Principal = {
        Service = "lambda.amazonaws.com"
      },
      Effect = "Allow"
    }]
  })
}


resource "aws_iam_policy" "save_course_lambda_policy" {
  name = "save-course-lambda-policy"

  policy = jsonencode(
  {
    Version = "2012-10-17",
    Statement = [
    {
      Effect   = "Allow"
      Action = [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      Resource = "arn:aws:logs:*:*:*"
    },
    {
      Effect   = "Allow",
      Action = [
        "dynamodb:PutItem",
        ],
      Resource = var.dynamodb_courses_arn
    }
        ]
  })
}


resource "aws_iam_role_policy_attachment" "lambda_policy_attachment_save_course" {
    policy_arn = aws_iam_policy.save_course_lambda_policy.arn
    role       = aws_iam_role.save_course_lambda_role.name
}

#update-course
resource "aws_iam_role" "update_course_lambda_role" {
  name = "update-course-lambda-role"

  assume_role_policy = jsonencode(
  {
    Version = "2012-10-17",
    Statement = [
   {
      Action = "sts:AssumeRole",
      Principal = {
        Service = "lambda.amazonaws.com"
      },
      Effect = "Allow"
    }]
  })
}


resource "aws_iam_policy" "update_course_lambda_policy" {
  name = "update-course-lambda-policy"

  policy = jsonencode(
  {
    Version = "2012-10-17",
    Statement = [
    {
      Effect   = "Allow"
      Action = [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      Resource = "arn:aws:logs:*:*:*"
    },
    {
      Effect   = "Allow",
      Action = [
        "dynamodb:PutItem",
        ],
      Resource = var.dynamodb_courses_arn
    }
        ]
  })
}


resource "aws_iam_role_policy_attachment" "lambda_policy_attachment_update_course" {
    policy_arn = aws_iam_policy.update_course_lambda_policy.arn
    role       = aws_iam_role.update_course_lambda_role.name
}

#get-all-courses
resource "aws_iam_role" "get_all_courses_lambda_role" {
  name = "get-all-courses-lambda-role"

  assume_role_policy = jsonencode(
  {
    Version = "2012-10-17",
    Statement = [
    {
      Action = "sts:AssumeRole",
      Principal = {
        Service = "lambda.amazonaws.com"
      },
      Effect = "Allow"
    }]
  })
}


resource "aws_iam_policy" "get_all_courses_lambda_policy" {
  name = "get-all-courses-lambda-policy"

  policy = jsonencode(
  {
    Version = "2012-10-17",
    Statement = [
    {
      Effect   = "Allow"
      Action = [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      Resource = "arn:aws:logs:*:*:*"
    },
    {
      Effect   = "Allow",
      Action = [
        "dynamodb:Scan",
        ],
      Resource = var.dynamodb_courses_arn
    }
        ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_policy_attachment_get_all_courses" {
    policy_arn = aws_iam_policy.get_all_courses_lambda_policy.arn
    role       = aws_iam_role.get_all_courses_lambda_role.name
}

#get-course
resource "aws_iam_role" "get_course_lambda_role" {
  name = "get-course-lambda-role"

  assume_role_policy = jsonencode(
  {
    Version = "2012-10-17",
    Statement = [
    {
      Action = "sts:AssumeRole",
      Principal = {
        Service = "lambda.amazonaws.com"
      },
      Effect = "Allow"
    }]
  })
}


resource "aws_iam_policy" "get_course_lambda_policy" {
  name = "get-course-lambda-policy"

  policy = jsonencode(
  {
    Version = "2012-10-17",
    Statement = [
    {
      Effect   = "Allow"
      Action = [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      Resource = "arn:aws:logs:*:*:*"
    },
    {
      Effect   = "Allow",
      Action = [
        "dynamodb:GetItem",
        ],
      Resource = var.dynamodb_courses_arn
    }
        ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_policy_attachment_get_course" {
    policy_arn = aws_iam_policy.get_course_lambda_policy.arn
    role       = aws_iam_role.get_course_lambda_role.name
}

#delete-course
resource "aws_iam_role" "delete_course_lambda_role" {
  name = "delete-course-lambda-role"

  assume_role_policy = jsonencode(
  {
    Version = "2012-10-17",
    Statement = [
    {
      Action = "sts:AssumeRole",
      Principal = {
        Service = "lambda.amazonaws.com"
      },
      Effect = "Allow"
    }]
  })
}


resource "aws_iam_policy" "delete_course_lambda_policy" {
  name = "delete-course-lambda-policy"

  policy = jsonencode(
  {
    Version = "2012-10-17",
    Statement = [
    {
      Effect   = "Allow"
      Action = [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      Resource = "arn:aws:logs:*:*:*"
    },
    {
      Effect   = "Allow",
      Action = [
        "dynamodb:DeleteItem",
        ],
      Resource = var.dynamodb_courses_arn
    }
        ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_policy_attachment_delete_course" {
    policy_arn = aws_iam_policy.delete_course_lambda_policy.arn
    role       = aws_iam_role.delete_course_lambda_role.name
}
