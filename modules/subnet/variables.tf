variable subnet_cidr_block {
    type = list(string)
}
variable subnet_names {
    type = list(string)
}
variable avail_zone {
    type = list(string)
}
variable env_prefix {
    description = "Terrafrom build env"
    type = string
}
variable vpc_id {}
