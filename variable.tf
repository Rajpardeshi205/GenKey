variable "ami" {
  description = "This Is Linux AMI"
  type        = string
  default     = "ami-0567589d25e06853e"
}

variable "instance_type" {
  description = "This Is T3 Micro"
  type        = string
  default     = "t3.micro"
}

variable "GenKey_ports" {
  description = "This Is GenKey Port No"
  type        = list(number)
  default     = [22, 80]
}
