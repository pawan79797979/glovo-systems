variable "AWS_REGION" {
  default = "us-east-1"
}
variable "PATH_TO_PRIVATE_KEY" {
  default = "mykey"
}
variable "PATH_TO_PUBLIC_KEY" {
  default = "mykey.pub"
}
variable "AMIS" {
  type = "map"
  default = {
    us-east-1 = "ami-6871a115"
    us-east-2 = "ami-03291866"
    us-west-1 = "ami-18726478"
  }
}

variable "CUSTOM_HEADER_NAME" {
  default = "X-Glovo-Systems-Engineer-Candidate"
}

variable "CUSTOM_HEADER_VALUE" {
  default = "1"
}


