resource "local_file" "numero" {
  filename = var.nombre
  content  = var.num
}

resource "local_file" "persona" {
  filename = var.persona["filename"]
  content  = var.persona["content"] # var.genero[0]
}

