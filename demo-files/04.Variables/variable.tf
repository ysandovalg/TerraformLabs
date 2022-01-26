variable "nombre" {
  type    = string
  default = "Carlos"
}

variable "num" {
  type    = number
  default = 100
}

variable "persona" {
  type = map(any)
  default = {
    filename = "persona.txt"
    content  = "carlos"
  }
}

variable "genero" {
  type    = list(string)
  default = ["Masculino", "Femenino", "Otros..."]
}

# variable "hard_drive" {
#   type = map(any)
#   default = {
#     slow = "HHD"
#     fast = "SSD"
#   }
# }

# variable "users" {
#   type    = set(string)
#   default = ["carlos", "marie", "monica", "hazel", "victor", "carlos"]
# }






