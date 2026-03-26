variable "region" {
  description = "AWS region in which the project needs to be setup (us-east-1, ca-west-1, eu-west-3, etc)"
}
################################################################################

variable "ami" {
  type = string
  default = "ami-0d6d5a1f326b57cb0"
}

