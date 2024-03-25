module "labels" {
  source  = "cloudposse/label/null"
  name    = var.name
}

resource "aws_dynamodb_table" "this" {
  name           = module.labels.id
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "id"

  attribute {
    name = "id"
    type = "S"
  }

  
}