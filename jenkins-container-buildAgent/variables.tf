# variables.tf
variable "custome-ports" {
  type    = list(number)
  default = [22, 4243]  # Specific individual ports
}

variable "allowed_port_range_agents" {
  type    = object({
    from_port = number
    to_port   = number
  })
  default = {
    from_port = 32768
    to_port   = 60999
  }
}
