variable "prefix" {}
variable "subnet" {}
variable "sg" {}

variable "name_tag" {}
variable "tg_arn" {}
variable "repo_url" {}
variable "log_group_name" {
  default = "/ecs/my-log-group"
}