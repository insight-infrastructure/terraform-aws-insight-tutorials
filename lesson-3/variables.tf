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
