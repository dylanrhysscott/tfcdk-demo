variable "name" {
  type = string
}

variable "subnet_newbits" {
  type = string
  default = "8"
}

variable "cidr_block" {
  type = string
  default = "10.0.0.0/16"
}