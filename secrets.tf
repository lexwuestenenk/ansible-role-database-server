variable "esxi" {
  type = object({
    hostname = string
    hostport = string
    hostssl = string
    username = string
    password = string 
  })
  default = {
    hostname = "192.168.1.20"
    hostport = "22"
    hostssl  = "443"
    username = "root"
    password = "Welkom01!"
  }
}