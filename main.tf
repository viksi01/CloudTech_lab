module "table_authors" {
  source = "./modules/dynamodb"
  table_name = "authors"
}

module "table_courses" {
  source = "./modules/dynamodb"
  table_name = "courses"

}

module "iam" {
  source = "./modules/iam"
  name = "iam"
  dynamodb_authors_arn = module.author.dynamodb_arn
  dynamodb_courses_arn = module.course.dynamodb_arn
}

module "lambda" {
    source = "./modules/lambda"
    name = "lamda"
    stage = "dev"

    get_all_authors_arn = module.iam.get_all_authors_role_arn
}