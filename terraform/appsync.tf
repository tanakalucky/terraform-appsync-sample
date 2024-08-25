data "local_file" "graphql_schema" {
  filename = "../schema.graphql"
}

resource "aws_appsync_graphql_api" "this" {
  name                = "my-appsync"
  authentication_type = "API_KEY"
  schema              = data.local_file.graphql_schema.content
}

resource "aws_appsync_api_key" "this" {
  api_id  = aws_appsync_graphql_api.this.id
  expires = timeadd(timestamp(), "31536000s") # 365日
}

resource "aws_iam_role" "appsync_role" {
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "appsync.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "this" {
  role = aws_iam_role.appsync_role.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "lambda:InvokeFunction"
        ],
        Resource = [
          module.get_data.lambda_function_arn,
          module.put_data.lambda_function_arn,
        ]
      }
    ]
  })
}

resource "aws_appsync_datasource" "get_data" {
  api_id           = aws_appsync_graphql_api.this.id
  name             = "get_data"
  service_role_arn = aws_iam_role.appsync_role.arn
  type             = "AWS_LAMBDA"

  lambda_config {
    function_arn = module.get_data.lambda_function_arn
  }
}

resource "aws_appsync_datasource" "put_data" {
  api_id           = aws_appsync_graphql_api.this.id
  name             = "put_data"
  service_role_arn = aws_iam_role.appsync_role.arn
  type             = "AWS_LAMBDA"

  lambda_config {
    function_arn = module.put_data.lambda_function_arn
  }
}

resource "aws_appsync_resolver" "get_data" {
  api_id      = aws_appsync_graphql_api.this.id
  type        = "Query"
  field       = "get_data"
  data_source = aws_appsync_datasource.get_data.name
  kind        = "UNIT"
}

resource "aws_appsync_resolver" "put_data" {
  api_id      = aws_appsync_graphql_api.this.id
  type        = "Mutation"
  field       = "put_data"
  data_source = aws_appsync_datasource.put_data.name
  kind        = "UNIT"
}
