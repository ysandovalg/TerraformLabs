locals {
  filename = "test.txt"
}

module "file-module" {
  source = "./file-module"

  # filename = local.filename
}
