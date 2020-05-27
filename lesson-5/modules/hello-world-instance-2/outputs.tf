output "image_id" {
  value = data.aws_ami.ubuntu.id
}

output "private_ips" {
  value = aws_instance.this.*.private_ip # lesson #6
}

output "public_ips" {
  value = aws_instance.this.*.public_ip # lesson #6
}

output "eips" {
  //  value = aws_eip.this.*.public_ip[0] # Won't work - Why?
  value = join(", ", aws_eip.this.*.public_ip) # lesson #6
}
