variable "prefix" {}
variable "sg_front" {
    type = list(string)
}
variable "public_subnets_id" {
  type = list(string)
}