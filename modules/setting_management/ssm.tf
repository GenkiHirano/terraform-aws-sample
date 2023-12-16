resource "aws_ssm_parameter" "db_username" {
  name        = "/db/username"
  value       = "root"
  type        = "String"
  description = "データベースのユーザー名"
}

# dummy passwordをapplyし、AWS CLIで更新する
# aws ssm put-parameter --name '/db/password' --value 'ModifiedStrongPassword!' --type SecureString --overwrite --profile terraform

resource "aws_ssm_parameter" "db_password" {
  name        = "/db/password"
  value       = "VeryStrongPassword!"
  type        = "SecureString"
  description = "データベースのパスワード"

  lifecycle {
    ignore_changes = [value]
  }
}
