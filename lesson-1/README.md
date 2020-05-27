### Lesson-1 Basic 

This lesson is intended to show the basic components of terraform. 

There are seven basic building blocks to writing terraform. 

- Providers - Bring in information about the API that terraform will map.  Informs available resources and order they should be deployed
```hcl-terraform
provider "aws" {
  region = "us-east-2"
}
```

- Variables - Declares variables / interfaces 
```hcl-terraform
variable "instance_type" {
  description = "The instance type to run"
  type = string
  default = "t3.micro"
}
```

- Resources - Things to de deployed 
```hcl-terraform
resource "aws_instance" "this" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
}
```

- Data - Brings in data from outside, doesn't make any changes 
```hcl-terraform
data "aws_eip" "this" {
  public_ip = var.public_ip
}
```

- Outputs - Outputs attributes from anything (resources, data, variables etc.)
```hcl-terraform
output "private_ip" {
  value = aws_instance.this.private_ip
}
```

- locals - Internal logic 
```hcl-terraform
locals  {
  value = var.public_ip
  value_2 = local.value
}
```

- Modules - External groups of terraform components 
```hcl-terraform
module "best_bunch_of_tf_stuffs"  {
  source = "{path.module}/path/to/tf/folder"
}
```

We'll go over the top 5 blocks this lesson.  

If you haven't noticed, terraform comes with it's own scripting language called [HCL](https://www.terraform.io/docs/configuration/syntax.html). 
It is basically json when rendered but the exact structure is informed by the provider.

Later lesson we will learn about `locals` and `modules`

**Steps:**

To run the lesson, 
```bash
terraform init
terraform apply
```

- After applying, the data will get the AMI id for your instance 
- Notice how one resource is deployed 
- Try changing something like the instance type `t3.micro` -> `t3.small`
- Apply again. Notice how the old instance is destroyed and replaced with new one

When done, run:
```bash
terraform destroy
```

**Major points**

- An apply can destroy resources 
- Diffs create new resources
