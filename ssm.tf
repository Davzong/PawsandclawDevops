resource "aws_ssm_parameter" "secret_parameter" {
  name  = "/config/my-app/SECRET_ENV_VAR"
  type  = "SecureString"
  value = "Your_Secret_Value"
}
