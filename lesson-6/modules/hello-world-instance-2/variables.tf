variable "vpc_id" {
  description = "The id of the vpc"
  type = string
}

variable "subnet_id" {
  description = "The id of the subnet to launch into"
  type = string
}

variable "public_key_path" {
  description = "Path to public key"
  type = string
}

variable "instance_port" {
  description = "The port the EC2 Instance should listen on for HTTP requests."
  type        = number
  default     = 8080
}

variable "instance_text" {
  description = "The text the EC2 Instance should return when it gets an HTTP request."
  type        = string
  default     = "Hello, World!"
}

variable "create" {
  description = "Boolean to create resources"
  type = bool
  default = true
}

variable "instance_count" {
  description = "Number of instances"
  type = number
  default = 2
}