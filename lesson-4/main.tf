
variable "public_key_path" {
  type = string
}

module "hello" {
  source = "./modules/hello-world-instance"
  public_key_path = var.public_key_path
}

module "stuff" {
  source = "./modules/hello-world-instance"
  public_key_path = var.public_key_path
  instance_text = "Stuff and things"
}
