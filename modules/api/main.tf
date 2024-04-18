module "labels" {
  source  = "cloudposse/label/null"
  name    = var.name
}

resource "aws_api_gateway_rest_api" "api" {
  name        = "api"
  description = "API Gateway"

   endpoint_configuration {
    types = ["REGIONAL"]
  }
}

# AUTHORS

resource "aws_api_gateway_resource" "authors" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "authors"
}

# get-all-authors

resource "aws_api_gateway_method" "get_all_authors" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.authors.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "get_all_authors" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.authors.id
  http_method             = aws_api_gateway_method.get_all_authors.http_method
  integration_http_method = "POST"
  type = "AWS"
  uri = var.get_all_authors_invoke_arn
}

resource "aws_api_gateway_method_response" "get_all_authors" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.authors.id
  http_method = aws_api_gateway_method.get_all_authors.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true
    "method.response.header.Access-Control-Allow-Headers" = true
    "method.response.header.Access-Control-Allow-Methods" = true
  }
}

resource "aws_api_gateway_integration_response" "get_all_authors" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.authors.id
  http_method = aws_api_gateway_method.get_all_authors.http_method
  status_code = aws_api_gateway_method_response.get_all_authors.status_code

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = "'*'",
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,X-Amz-User-Agent'",
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS'"
  }
}

resource "aws_lambda_permission" "get_all_authors" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = var.get_all_authors_arn
  principal     = "apigateway.amazonaws.com"
}

# OPTIONS

resource "aws_api_gateway_method" "authors_options" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.authors.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "authors_options" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.authors.id
  http_method             = aws_api_gateway_method.authors_options.http_method
  integration_http_method = "OPTIONS"
  type                    = "MOCK"

  request_templates = {
    "application/json" = "{\"statusCode\": 200}"
  } 
}

resource "aws_api_gateway_method_response" "authors_options" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.authors.id
  http_method = aws_api_gateway_method.authors_options.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true
    "method.response.header.Access-Control-Allow-Methods" = true
    "method.response.header.Access-Control-Allow-Origin"  = true
  }
}

resource "aws_api_gateway_integration_response" "authors_options" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.authors.id
  http_method = aws_api_gateway_method.authors_options.http_method
  status_code = aws_api_gateway_method_response.authors_options.status_code

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,PUT'",
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }

  depends_on = [ aws_api_gateway_integration.authors_options ]

}




# COURSES

resource "aws_api_gateway_resource" "courses" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "courses"
}

# get-all-courses

resource "aws_api_gateway_method" "get_all_courses" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.courses.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "get_all_courses" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.courses.id
  http_method             = aws_api_gateway_method.get_all_courses.http_method
  integration_http_method = "POST"
  type                    = "AWS"
  uri = var.get_all_courses_invoke_arn
}

resource "aws_api_gateway_method_response" "get_all_courses" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.courses.id
  http_method = aws_api_gateway_method.get_all_courses.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true
    "method.response.header.Access-Control-Allow-Headers" = true
    "method.response.header.Access-Control-Allow-Methods" = true
  }
}

resource "aws_api_gateway_integration_response" "get_all_courses" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.courses.id
  http_method = aws_api_gateway_method.get_all_courses.http_method
  status_code = aws_api_gateway_method_response.get_all_courses.status_code

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = "'*'",
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,X-Amz-User-Agent'",
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS'"
  }
}

resource "aws_lambda_permission" "get_all_courses" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = var.get_all_courses_arn
  principal     = "apigateway.amazonaws.com"
}

# OPTIONS

resource "aws_api_gateway_method" "courses_options" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.courses.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "courses_options" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.courses.id
  http_method             = aws_api_gateway_method.courses_options.http_method
  integration_http_method = "OPTIONS"
  type                    = "MOCK"

  request_templates = {
    "application/json" = "{\"statusCode\": 200}"
  } 
}

resource "aws_api_gateway_method_response" "courses_options" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.courses.id
  http_method = aws_api_gateway_method.courses_options.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true
    "method.response.header.Access-Control-Allow-Methods" = true
    "method.response.header.Access-Control-Allow-Origin"  = true
  }
}

resource "aws_api_gateway_integration_response" "courses_options" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.courses.id
  http_method = aws_api_gateway_method.courses_options.http_method
  status_code = aws_api_gateway_method_response.courses_options.status_code

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,PUT'",
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }

  depends_on = [ aws_api_gateway_integration.courses_options ]

}

# POST

resource "aws_api_gateway_model" "post_course" {
  name         = "CourseInputModel"
  rest_api_id  = aws_api_gateway_rest_api.api.id
  content_type = "application/json"

  schema = <<EOF
{
  "$schema": "http://json-schema.org/schema#",
  "title": "CourseInputModel",
  "type": "object",
  "properties": {
    "title": {
      "type": "string"
    },
    "authorId": {
      "type": "string"
    },
    "length": {
      "type": "string"
    },
    "category": {
      "type": "string"
    }
  },
  "required": [
    "title",
    "authorId",
    "length",
    "category"
  ]
}
EOF
}

resource "aws_api_gateway_method" "post_course" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.courses.id
  http_method   = "POST"
  authorization = "NONE"

  request_models = {
    "application/json" = aws_api_gateway_model.post_course.name
  }
}

resource "aws_api_gateway_integration" "post_course" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.courses.id
  http_method = aws_api_gateway_method.post_course.http_method
  integration_http_method = "POST"
  type = "AWS"
  uri = var.save_course_invoke_arn
  request_templates = {
    "application/xml" = <<EOF
  {
     "body" : $input.json('$')
  }
  EOF
  }
}

resource "aws_api_gateway_method_response" "post_course" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.courses.id
  http_method = aws_api_gateway_method.post_course.http_method
  status_code = "200"

  response_models = { "application/json" = "Empty" }
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin" = false
  }
}

resource "aws_api_gateway_integration_response" "post_course" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.courses.id
  http_method = aws_api_gateway_method.post_course.http_method
  status_code = aws_api_gateway_method_response.post_course.status_code

response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = "'*'",
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,X-Amz-User-Agent'",
    "method.response.header.Access-Control-Allow-Methods" = "'GET, OPTIONS, POST'"
  }

  depends_on = [ aws_api_gateway_integration.post_course ]
}

resource "aws_lambda_permission" "api_gateway_invoke_post_course" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = var.save_course_arn
  principal     = "apigateway.amazonaws.com"
}

#  GET, PUT, DELETE COURSE

# GET

resource "aws_api_gateway_resource" "course_id" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_resource.courses.id
  path_part   = "{id}"
}

resource "aws_api_gateway_method" "get_course" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.course_id.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "get_course" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.course_id.id
  http_method             = aws_api_gateway_method.get_course.http_method
  integration_http_method = "POST"
  type                    = "AWS"
  uri = var.get_course_invoke_arn
  request_templates = {
    "application/json" = "{\"id\": \"$input.params('id')\"}"
  }
}

resource "aws_api_gateway_method_response" "get_course" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.course_id.id
  http_method = aws_api_gateway_method.get_course.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true
    "method.response.header.Access-Control-Allow-Methods" = true
    "method.response.header.Access-Control-Allow-Origin"  = true
  }
}

resource "aws_api_gateway_integration_response" "get_course" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.course_id.id
  http_method = aws_api_gateway_method.get_course.http_method
  status_code = aws_api_gateway_method_response.get_course.status_code

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS'",
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }

  depends_on = [ aws_api_gateway_integration.get_course ]

}

resource "aws_lambda_permission" "get_course" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = var.get_course_arn
  principal     = "apigateway.amazonaws.com"
}

# PUT

resource "aws_api_gateway_model" "put_course" {
  name         = "CourseUpdateModel"
  rest_api_id  = aws_api_gateway_rest_api.api.id
  content_type = "application/json"

  schema = <<EOF
{
  "$schema": "http://json-schema.org/schema#",
  "title": "CourseInputModel",
  "type": "object",
  "properties": {
    "id": {
      "type": "string"
    },
    "title": {
      "type": "string"
    },
    "watchHref": {
      "type": "string"
    },
    "authorId": {
      "type": "string"
    },
    "length": {
      "type": "string"
    },
    "category": {
      "type": "string"
    }
  },
  "required": [
    "id",
    "title",
    "watchHref",
    "authorId",
    "length",
    "category"
  ]
}
EOF
}

resource "aws_api_gateway_method" "put_course" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.course_id.id
  http_method   = "PUT"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "put_course" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.course_id.id
  http_method             = aws_api_gateway_method.put_course.http_method
  integration_http_method = "POST"
  type                    = "AWS"
  uri = var.update_course_invoke_arn
  request_templates = {
    "application/xml" = <<EOF
  {
   "body": $input.json('$')
  }
  EOF
    }
}

resource "aws_api_gateway_method_response" "put_course" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.course_id.id
  http_method = aws_api_gateway_method.put_course.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true
    "method.response.header.Access-Control-Allow-Methods" = true
    "method.response.header.Access-Control-Allow-Origin"  = true
  }
}

resource "aws_api_gateway_integration_response" "put_course" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.course_id.id
  http_method = aws_api_gateway_method.put_course.http_method
  status_code = aws_api_gateway_method_response.put_course.status_code

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
    "method.response.header.Access-Control-Allow-Methods" = "'GET, OPTIONS, PUT'",
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }

  depends_on = [ aws_api_gateway_integration.put_course ]

}

resource "aws_lambda_permission" "put_course" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = var.update_course_arn
  principal     = "apigateway.amazonaws.com"
}

# DELETE

resource "aws_api_gateway_method" "delete_course" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.course_id.id
  http_method   = "DELETE"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "delete_course" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.course_id.id
  http_method             = aws_api_gateway_method.delete_course.http_method
  integration_http_method = "POST"
  type                    = "AWS"
  uri = var.delete_course_invoke_arn
  request_templates = {
    "application/json" = "{\"id\": \"$input.params('id')\"}"
  }
}

resource "aws_api_gateway_method_response" "delete_course" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.course_id.id
  http_method = aws_api_gateway_method.delete_course.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true
    "method.response.header.Access-Control-Allow-Methods" = true
    "method.response.header.Access-Control-Allow-Origin"  = true
  }
}

resource "aws_api_gateway_integration_response" "delete_course" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.course_id.id
  http_method = aws_api_gateway_method.delete_course.http_method
  status_code = aws_api_gateway_method_response.delete_course.status_code

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
    "method.response.header.Access-Control-Allow-Methods" = "'OPTIONS, DELETE'",
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }

  depends_on = [ aws_api_gateway_integration.delete_course ]

}

resource "aws_lambda_permission" "delete_course" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = var.delete_course_arn
  principal     = "apigateway.amazonaws.com"
}

# OPTIONS course_id

resource "aws_api_gateway_method" "course_id" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.course_id.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "course_id" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.course_id.id
  http_method             = aws_api_gateway_method.course_id.http_method
  integration_http_method = "OPTIONS"
  type                    = "MOCK"

  request_templates = {
    "application/json" = "{\"statusCode\": 200}"
  } 
}

resource "aws_api_gateway_method_response" "course_id" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.course_id.id
  http_method = aws_api_gateway_method.course_id.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true
    "method.response.header.Access-Control-Allow-Methods" = true
    "method.response.header.Access-Control-Allow-Origin"  = true
  }
}

resource "aws_api_gateway_integration_response" "course_id" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.courses.id
  http_method = aws_api_gateway_method.course_id.http_method
  status_code = aws_api_gateway_method_response.course_id.status_code

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
    "method.response.header.Access-Control-Allow-Methods" = "'GET, PUT, OPTIONS, DELETE'",
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }

  depends_on = [ aws_api_gateway_integration.course_id ]

}

# Deployment

resource "aws_api_gateway_deployment" "deployment" {
  depends_on = [
    aws_api_gateway_integration.get_all_authors,
    aws_api_gateway_integration.get_all_courses,
  ]


  rest_api_id = aws_api_gateway_rest_api.api.id
  stage_name = "dev"
}
