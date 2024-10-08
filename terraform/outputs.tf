output "api_key" {
  sensitive = true
  value     = aws_appsync_api_key.this.key
}

output "graphql_url" {
  value = aws_appsync_graphql_api.this.uris["GRAPHQL"]
}
