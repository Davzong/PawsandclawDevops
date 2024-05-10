variable "public_subnet_id" {}
variable "vpc_id" {}
variable "private_subnet_ids" {
    type = list(string)
}
variable "prefix" {}
variable "num" {}
