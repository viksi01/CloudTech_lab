module "labels" {
  source  = "cloudposse/label/null"
  name    = var.name
}

resource "aws_api_gateway_rest_api" "my_api" {
  name        = "my_api"
  description = "API description"
}

// Create a resource for the API Gateway
resource "aws_api_gateway_resource" "authors" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  parent_id   = aws_api_gateway_rest_api.my_api.root_resource_id
  path_part   = "authors"
}

// GET ALL AUTHORS //

// Create a method get for the API Gateway
resource "aws_api_gateway_method" "get_all_authors" {
  rest_api_id   = aws_api_gateway_rest_api.my_api.id
  resource_id   = aws_api_gateway_resource.authors.id
  http_method   = "GET"
  authorization = "NONE"
}

// Create an integration for the API Gateway
resource "aws_api_gateway_integration" "get_all_authors" {
  rest_api_id             = aws_api_gateway_rest_api.my_api.id
  resource_id             = aws_api_gateway_resource.authors.id
  http_method             = aws_api_gateway_method.get_all_authors.http_method
  integration_http_method = "POST"

  type = "AWS"

  uri = var.get_all_authors_invoke_arn

}

// Create a method response for the API Gateway
resource "aws_api_gateway_method_response" "get_all_authors" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.authors.id
  http_method = aws_api_gateway_method.get_all_authors.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true
    "method.response.header.Access-Control-Allow-Headers" = true
    "method.response.header.Access-Control-Allow-Methods" = true
  }
}

// Create an integration response for the API Gateway
resource "aws_api_gateway_integration_response" "get_all_authors" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.authors.id
  http_method = aws_api_gateway_method.get_all_authors.http_method
  status_code = aws_api_gateway_method_response.get_all_authors.status_code

depends_on = [
    aws_api_gateway_integration.get_all_authors
  ]

response_parameters = {
        "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
        "method.response.header.Access-Control-Allow-Methods" = "'GET, OPTIONS'",
        "method.response.header.Access-Control-Allow-Origin" = "'*'"
    }

}

// Create a lambda permission for the API Gateway
resource "aws_lambda_permission" "get_all_authors" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = var.get_all_authors_arn
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.my_api.execution_arn}/*/*"
}

//Create method options
resource "aws_api_gateway_method" "authors_options" {
  rest_api_id   = aws_api_gateway_rest_api.my_api.id
  resource_id   = aws_api_gateway_resource.authors.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}

//Create an integration
resource "aws_api_gateway_integration" "authors_options_integration" {
  rest_api_id             = aws_api_gateway_rest_api.my_api.id
  resource_id             = aws_api_gateway_resource.authors.id
  http_method             = aws_api_gateway_method.authors_options.http_method
  integration_http_method = "POST"

  type                    = "AWS"

  uri = var.get_all_authors_invoke_arn

  depends_on = [ aws_api_gateway_method.authors_options ]
}

//Create a method response
resource "aws_api_gateway_method_response" "authors_options_response" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.authors.id
  http_method = aws_api_gateway_method.authors_options.http_method
  status_code = "200"

   response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin" = true
   }
   depends_on = [ aws_api_gateway_method.authors_options ]
}

//Create an integration response
resource "aws_api_gateway_integration_response" "authors_options_integration_response" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.authors.id
  http_method = aws_api_gateway_method.authors_options.http_method
  status_code = aws_api_gateway_method_response.authors_options_response.status_code

  response_parameters = {
        "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
        "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,PUT,DELETE'",
        "method.response.header.Access-Control-Allow-Origin" = "'*'"
    }

    depends_on = [
     aws_api_gateway_method_response.authors_options_response
    ]
}


resource "aws_api_gateway_resource" "courses" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  parent_id   = aws_api_gateway_rest_api.my_api.root_resource_id
  path_part   = "courses"
}

// GET ALL COURSES //

resource "aws_api_gateway_method" "get_all_courses" {
  rest_api_id   = aws_api_gateway_rest_api.my_api.id
  resource_id   = aws_api_gateway_resource.courses.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_lambda_permission" "get_all_courses" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = var.get_all_courses_arn
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.my_api.execution_arn}/*/*"
}

resource "aws_api_gateway_integration" "get_all_courses" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.courses.id
  http_method = aws_api_gateway_method.get_all_courses.http_method
  integration_http_method = "POST"

  type = "AWS"

  uri = var.get_all_courses_invoke_arn

  request_templates = {
    "application/json" = "{\"id\": \"$input.params('id')\"}"
  }
}

resource "aws_api_gateway_method_response" "get_all_courses" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
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
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.courses.id
  http_method = aws_api_gateway_method.get_all_courses.http_method
  status_code = aws_api_gateway_method_response.get_all_courses.status_code
 
 depends_on = [
    aws_api_gateway_integration.get_all_courses
  ]


response_parameters = {
        "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
        "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS'",
        "method.response.header.Access-Control-Allow-Origin" = "'*'"
    }
  
}

//Options for all courses//
resource "aws_api_gateway_method" "courses_options" {
  rest_api_id   = aws_api_gateway_rest_api.my_api.id
  resource_id   = aws_api_gateway_resource.courses.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "courses_options_integration" {
  rest_api_id             = aws_api_gateway_rest_api.my_api.id
  resource_id             = aws_api_gateway_resource.courses.id
  http_method             = aws_api_gateway_method.courses_options.http_method
  integration_http_method = "POST"

  type                    = "AWS"
 
  uri = var.get_all_courses_invoke_arn

  depends_on = [ aws_api_gateway_method.courses_options ]
}

resource "aws_api_gateway_method_response" "courses_options_response" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.courses.id
  http_method = aws_api_gateway_method.courses_options.http_method
  status_code = "200"

   response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin" = true
   }
   depends_on = [ aws_api_gateway_method.courses_options ]
}

resource "aws_api_gateway_integration_response" "courses_options_integration_response" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.courses.id
  http_method = aws_api_gateway_method.courses_options.http_method
  status_code = aws_api_gateway_method_response.courses_options_response.status_code

  response_parameters = {
        "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
        "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,PUT,DELETE'",
        "method.response.header.Access-Control-Allow-Origin" = "'*'"
    }

    depends_on = [
     aws_api_gateway_method_response.courses_options_response
    ]
}

//Post for all courses//
resource "aws_api_gateway_model" "my_api" {
  rest_api_id  = aws_api_gateway_rest_api.my_api.id
  name         = "mymodel"
  description  = "a JSON schema"
  content_type = "application/json"

  schema = jsonencode({
    "$schema": "http://json-schema.org/schema#",
    "title": "json_courses",
    "type": "object",
    "properties": {
      "title": {"type": "string"},
      "authorId": {"type": "string"},
      "length": {"type": "string"},
      "category": {"type": "string"}
    },
    "required": ["title", "authorId", "length", "category"]
  })
}

resource "aws_api_gateway_request_validator" "my_api" {
  name                        = "POSTExampleRequestValidator"
  rest_api_id                 = aws_api_gateway_rest_api.my_api.id
  validate_request_body       = true
  validate_request_parameters = false
}

resource "aws_api_gateway_method" "post_courses" {
  rest_api_id   = aws_api_gateway_rest_api.my_api.id
  resource_id   = aws_api_gateway_resource.courses.id
  http_method   = "POST"
  authorization = "NONE"
request_validator_id = aws_api_gateway_request_validator.my_api.id

  request_models = {
    "application/json" = aws_api_gateway_model.my_api.name
  }
}

resource "aws_api_gateway_integration" "post_courses" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.courses.id
  http_method = aws_api_gateway_method.post_courses.http_method
  integration_http_method = "POST"

  type = "AWS"

  uri = var.save_course_invoke_arn

     request_templates       = {
    "application/xml" = <<EOF
  {
     "body" : $input.json('$')
  }
  EOF
  }
  content_handling = "CONVERT_TO_TEXT"
}

resource "aws_api_gateway_method_response" "post_courses" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.courses.id
  http_method = aws_api_gateway_method.post_courses.http_method
  status_code = "200"

  response_models = { "application/json" = "Empty" }
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin" = true
  }
}

resource "aws_api_gateway_integration_response" "post_courses" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.courses.id
  http_method = aws_api_gateway_method.post_courses.http_method
  status_code = aws_api_gateway_method_response.post_courses.status_code

  response_parameters = {
        "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
        "method.response.header.Access-Control-Allow-Methods" = "'OPTIONS,POST,PUT,GET'",
        "method.response.header.Access-Control-Allow-Origin" = "'*'"
    }
  
}

resource "aws_lambda_permission" "api_gateway_invoke_post_courses" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = var.save_course_arn
  principal     = "apigateway.amazonaws.com"
}


//GET COURSE//
resource "aws_api_gateway_resource" "course_by_id" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  parent_id   = aws_api_gateway_resource.courses.id
  path_part   = "{id}"
}

resource "aws_api_gateway_method" "get_course" {
  rest_api_id   = aws_api_gateway_rest_api.my_api.id
  resource_id   = aws_api_gateway_resource.course_by_id.id
  http_method   = "GET"
  authorization = "NONE"
  request_validator_id = aws_api_gateway_request_validator.my_api.id
}

resource "aws_api_gateway_integration" "get_course" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.course_by_id.id
  http_method = aws_api_gateway_method.get_course.http_method
  integration_http_method = "POST"

  type = "AWS"

  uri = var.get_course_invoke_arn

request_templates = {
  "application/json" = <<EOF
{
  "id": "$input.params('id')"
}
EOF
}

}

resource "aws_api_gateway_method_response" "get_course" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.course_by_id.id
  http_method = aws_api_gateway_method.get_course.http_method
  status_code = "200"

  response_models = {
    "application/json" = "Empty"
  }

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin" = true
  }
}

resource "aws_api_gateway_integration_response" "get_course" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.course_by_id.id
  http_method = aws_api_gateway_method.get_course.http_method
  status_code = aws_api_gateway_method_response.get_course.status_code

 depends_on = [
    aws_api_gateway_integration.get_course
  ]

 response_parameters = {
        "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
        "method.response.header.Access-Control-Allow-Methods" = "'OPTIONS, POST'",
        "method.response.header.Access-Control-Allow-Origin" = "'*'"
    }

 
}

resource "aws_lambda_permission" "get_course" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = var.get_course_arn
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.my_api.execution_arn}/*/*"
}


//Put method for get course
resource "aws_api_gateway_method" "put_method" {
  rest_api_id   = aws_api_gateway_rest_api.my_api.id
  resource_id   = aws_api_gateway_resource.course_by_id.id
  http_method   = "PUT"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "put" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.course_by_id.id
  http_method = aws_api_gateway_method.put_method.http_method
  integration_http_method = "POST"
  type = "AWS"
  uri = var.update_course_invoke_arn
  

      request_templates = {
    "application/xml" = <<EOF
{
   "body" : $input.json('$')
}
EOF
  }

}

resource "aws_api_gateway_method_response" "put" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.course_by_id.id
  http_method = aws_api_gateway_method.put_method.http_method
  status_code = "200"

  response_models = { "application/json" = "Empty" }
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin" = true
  }
}

resource "aws_api_gateway_integration_response" "put" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.course_by_id.id
  http_method = aws_api_gateway_method.put_method.http_method
  status_code = aws_api_gateway_method_response.put.status_code


   response_parameters = {
        "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
        "method.response.header.Access-Control-Allow-Methods" = "'OPTIONS,PUT'",
        "method.response.header.Access-Control-Allow-Origin" = "'*'"
    }

  
}

resource "aws_lambda_permission" "api_gateway_invoke_put_course" {
  statement_id  = "AllowAPIGatewayInvokePUTLambda"
  action        = "lambda:InvokeFunction"
  function_name = var.update_course_arn
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.my_api.execution_arn}/*/*"
}

//Delete method
resource "aws_api_gateway_method" "delete" {
  rest_api_id   = aws_api_gateway_rest_api.my_api.id
  resource_id   = aws_api_gateway_resource.course_by_id.id
  http_method   = "DELETE"
  authorization = "NONE"
  request_validator_id = aws_api_gateway_request_validator.my_api.id
}

resource "aws_api_gateway_integration" "delete_course" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.course_by_id.id
  http_method = aws_api_gateway_method.delete.http_method
  integration_http_method = "POST"
  type = "AWS"
  uri = var.delete_course_invoke_arn

   request_templates = {
    "application/json" = "{\"id\": \"$input.params('id')\"}"
  }
  
}

resource "aws_api_gateway_method_response" "delete_course" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.course_by_id.id
  http_method = aws_api_gateway_method.delete.http_method
  status_code = "200"

   response_models = {
    "application/json" = "Empty"
  }

  
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin" = false
  }
}

resource "aws_api_gateway_integration_response" "delete_course" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.course_by_id.id
  http_method = aws_api_gateway_method.delete.http_method
  status_code = aws_api_gateway_method_response.delete_course.status_code

depends_on = [
    aws_api_gateway_integration.delete_course
  ]


response_parameters = {
        "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
        "method.response.header.Access-Control-Allow-Methods" = "'OPTIONS, DELETE'",
        "method.response.header.Access-Control-Allow-Origin" = "'*'"
    }

  content_handling = "CONVERT_TO_TEXT"
}

resource "aws_lambda_permission" "api_gateway_invoke_delete_course" {
  statement_id  = "AllowAPIGatewayInvokeDeleteLambda"
  action        = "lambda:InvokeFunction"
  function_name = var.delete_course_arn
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.my_api.execution_arn}/*/*"
}


//Options
resource "aws_api_gateway_method" "id_options" {
  rest_api_id   = aws_api_gateway_rest_api.my_api.id
  resource_id   = aws_api_gateway_resource.course_by_id.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}

resource "aws_api_gateway_method_response" "id_options_response" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.course_by_id.id
  http_method = aws_api_gateway_method.id_options.http_method
  status_code = "200"

   response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin" = true
   }
   depends_on = [ aws_api_gateway_method.id_options ]
}

resource "aws_api_gateway_integration" "id_options_integration" {
  rest_api_id             = aws_api_gateway_rest_api.my_api.id
  resource_id             = aws_api_gateway_resource.course_by_id.id
  http_method             = aws_api_gateway_method.id_options.http_method
  integration_http_method = "POST"
  type                    = "AWS"

  uri = var.get_course_invoke_arn

  depends_on = [ aws_api_gateway_method.id_options ]
}

resource "aws_api_gateway_integration_response" "id_options_integration_response" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.course_by_id.id
  http_method = aws_api_gateway_method.id_options.http_method
  status_code = aws_api_gateway_method_response.id_options_response.status_code

  response_parameters = {
        "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
        "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,PUT,DELETE'",
        "method.response.header.Access-Control-Allow-Origin" = "'*'"
    }

    depends_on = [
     aws_api_gateway_method_response.id_options_response,
     aws_api_gateway_integration.id_options_integration
    ]
}

resource "aws_api_gateway_deployment" "deployment" {
  depends_on = [
    aws_api_gateway_integration.get_all_authors,
    aws_api_gateway_integration.get_all_courses,
  ]


  rest_api_id = aws_api_gateway_rest_api.my_api.id
  stage_name = "dev"
}


