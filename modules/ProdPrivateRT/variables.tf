variable vpc_id {}
variable env_prefix {
    description = "Terrafrom build env"
    type = string
}
variable subnet_ids_list {
    type = list(string)
}

variable subnet_ids_list_for_Nat_Gateway {
    type = list(string)
}