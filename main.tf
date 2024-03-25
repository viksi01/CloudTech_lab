module "table_authors" {
  source = "./modules/dynamodb"
  name = "authors"
  table_name = "authors"
}

module "table_courses" {
  source = "./modules/dynamodb"
  name = "courses"
  table_name = "courses"

}

module "iam" {
  source               = "./modules/iam"
  name                 = "iam"
  dynamodb_authors_arn = module.table_authors.dynamodb_arn
  dynamodb_courses_arn = module.table_courses.dynamodb_arn
}

module "lambda" {
    source = "./modules/lambda"
    name   = "lambda"
    get_all_authors_arn = module.iam.get_all_authors_role_arn
}