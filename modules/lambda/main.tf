module "labels" {
  source  = "cloudposse/label/null"
  name    = var.name
}

#get-all-authors
data "archive_file" "get_all_authors" {
  type        = "zip"
  source_file = "modules/lambda/functions/get-all-authors/get-all-authors.js"
  output_path = "modules/lambda/functions/get-all-authors/get-all-authors.zip"
}

resource "aws_lambda_function" "get_all_authors" {
  filename      = data.archive_file.get_all_authors.output_path
  function_name = "get-all-authors"
  role          = var.get_all_authors_arn
  handler       = "get-all-authors.handler"

  source_code_hash = data.archive_file.get_all_authors.output_base64sha256

  runtime = "nodejs16.x"
}

#save-course
data "archive_file" "save_course" {
  type        = "zip"
  source_file = "modules/lambda/functions/save-course/save-course.js"
  output_path = "modules/lambda/functions/save-course/save-course.zip"
}

resource "aws_lambda_function" "save_course" {
  filename      = data.archive_file.save_course.output_path
  function_name = "save-course"
  role          = var.save_course_arn
  handler       = "save-course.handler"

  source_code_hash = data.archive_file.save_course.output_base64sha256

  runtime = "nodejs16.x"
}

#update-course
data "archive_file" "update_course" {
  type        = "zip"
  source_file = "modules/lambda/functions/update-course/update-course.js"
  output_path = "modules/lambda/functions/update-course/update-course.zip"
}

resource "aws_lambda_function" "update_course" {
  filename      = data.archive_file.update_course.output_path
  function_name = "update-course"
  role          = var.update_course_arn
  handler       = "update-course.handler"

  source_code_hash = data.archive_file.update_course.output_base64sha256

  runtime = "nodejs16.x"
}

#get-all-courses
data "archive_file" "get_all_courses" {
  type        = "zip"
  source_file = "modules/lambda/functions/get-all-courses/get-all-courses.js"
  output_path = "modules/lambda/functions/get-all-courses/get-all-courses.zip"
}

resource "aws_lambda_function" "get_all_courses" {
  filename      = data.archive_file.get_all_courses.output_path
  function_name = "get-all-courses"
  role          = var.get_all_courses_arn
  handler       = "get-all-courses.handler"

  source_code_hash = data.archive_file.get_all_courses.output_base64sha256

  runtime = "nodejs16.x"
}

#get-course
data "archive_file" "get_course" {
  type        = "zip"
  source_file = "modules/lambda/functions/get-course/get-course.js"
  output_path = "modules/lambda/functions/get-course/get-course.zip"
}

resource "aws_lambda_function" "get_course" {
  filename      = data.archive_file.get_course.output_path
  function_name = "get-course"
  role          = var.get_course_arn
  handler       = "get-course.handler"

  source_code_hash = data.archive_file.get_course.output_base64sha256

  runtime = "nodejs16.x"
}

#delete-course
data "archive_file" "delete_course" {
  type        = "zip"
  source_file = "modules/lambda/functions/delete-course/delete-course.js"
  output_path = "modules/lambda/functions/delete-course/delete-course.zip"
}

resource "aws_lambda_function" "delete_course" {
  filename      = data.archive_file.delete_course.output_path
  function_name = "delete-course"
  role          = var.delete_course_arn
  handler       = "delete-course.handler"

  source_code_hash = data.archive_file.delete_course.output_base64sha256

  runtime = "nodejs16.x"
}