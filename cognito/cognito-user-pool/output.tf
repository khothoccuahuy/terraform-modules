output "user_pool_id" {
  value = aws_cognito_user_pool.userpool.id
}

output "user_pool_clients" {
  value = [
    for v in aws_cognito_user_pool_client.userpool_client : {
      client_id = v.id
      client_secret = v.client_secret
    }
  ]
}
