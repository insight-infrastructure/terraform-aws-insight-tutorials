### Lesson-6 Functions and Count  

#### Functions

HCL allows the use of functions. Check out the docs [here](https://www.terraform.io/docs/configuration/functions.html).
Functions are basically ways to manipulate inputs, be it `variables` or `local`.  

We can see the use of functions most basically in the following block. 

```hcl-terraform
resource "aws_key_pair" "this" {
  count = var.create ? 1 : 0 
  public_key = file(var.public_key_path)
}
```

Here we see the `file(...)` function being used in import the contents of a file at a given path which in this case, is a 
variable supplied with the path to the public key.  The file is read in by the function and passes the contents as a 
string into the resource. This is the most basic use of functions but there are plenty of other scenarios where they are 
useful in conjunction with count and conditionals. 

#### Count 

All resources expose a `count` attribute which can be used to replicate the resource multiple times as is the case 
here where we have two things going on. 

```hcl-terraform
resource "aws_instance" "this" {
  count = var.create ? var.instance_count : 0 # lesson #6
  ...
}
```

The first is a conditional as we saw in the previous lesson. Using `create` is 
a common way to expose conditionality in a module as a module, unlike resources, does not currently have a count 
attribute (something that Hashicorp says they are working on for the next release). Thus if you want to have a module 
that has conditionality, you need to put this within the count of every resource within the module.  We can then see 
how we handle this in the references to resources and outputs. 

For references, we now need to convert lists to string when used that way. For instance for the `eip_association` 
resource, we now need to be aware of the number of instances we are creating and create a new elastic IP (eip) for each 
instance like so. 

```hcl-terraform
resource "aws_eip" "this" {
  count = var.create ? var.instance_count : 0 # lesson #6
}

resource "aws_eip_association" "this" {
  count = var.create ? var.instance_count : 0 # lesson #6

  instance_id = aws_instance.this.*.id[count.index] # lesson #6
  public_ip   = aws_eip.this.*.public_ip[count.index] # lesson #6
}
```

Here we can see the logic is a little different from the prior lesson.  Instead of attaching an eip if the module applies 
with an `instance_count == 1`, we create an eip for each instance and now need to loop through the associations to 
attach the eip to each instance. This is what is happening in the `aws_eip.this.*.public_ip[count.index]` reference, 
specifically the `[count.index]` which is indexed for every application of count. 


To run the lesson, 
```bash
terraform init
terraform apply
```

When done, run:
```bash
terraform destroy
```

**Extra credit**

- In the outputs to the module, there is a line commented out.  Switch it with the value and see what happens. 
    - Why did it break?