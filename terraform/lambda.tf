module "get_data" {
  source = "terraform-aws-modules/lambda/aws"

  function_name = "get_data"
  handler       = "index.handler"
  runtime       = "nodejs20.x"
  source_path   = "../dist/get_data"

  attach_policies = true
  policies = [
    "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole",
    "arn:aws:iam::aws:policy/AWSAppSyncInvokeFullAccess",
    "arn:aws:iam::aws:policy/AmazonDynamoDBReadOnlyAccess"
  ]
  number_of_policies = 3
}

module "put_data" {
  source = "terraform-aws-modules/lambda/aws"

  function_name = "put_data"
  handler       = "index.handler"
  runtime       = "nodejs20.x"
  source_path   = "../dist/put_data"

  attach_policies = true
  policies = [
    "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole",
    "arn:aws:iam::aws:policy/AWSAppSyncInvokeFullAccess",
    "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"
  ]
  number_of_policies = 3
}
