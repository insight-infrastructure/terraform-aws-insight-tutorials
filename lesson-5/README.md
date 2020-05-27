### Lesson-5 Expressions 

#### HCL
---

Up until now we have made little note of the scripting langauge HCL. HCL is basically json but the exact
way it is rendered is informed by the provider. Checkout [hcl2json.com](https://www.hcl2json.com/) and drop 
in this blob. 

```hcl-terraform
locals {
  things = "stuff"
  animals = ["Goat", "pig"]
  actions = {
    run = "hide"
    jump = "bounce"
  }
}

foo "bar" {
  baz = "func"
}

funky "town" {
  what_to_do = "get down"
}
```

For terraform, there is a specification in how the `hcl` is interpreted that allows for the use of how various 
expressions and functions which are useful for implementing any logic in your module.  Before descibing them though 
lets rehash what terraform data types you have and count for resources. 

#### Data Types 

You have 3 basic primitive terraform data types:

- string
    - "foo"
- list
    - ["stuff", "things]
- map
    - {stuff: "things"}

These can be recomposed and often seen as:

- list(string) -- same as list
- list(map(string))

In some scenarios you may also see `object` or `any` data types but this is rare and out of scope for now. 

#### Expressions 
 
In terraform you can use expressions for if then statements and limitted looping capabilities. 
Check out the docs [here](https://www.terraform.io/docs/configuration/expressions.html) as they are very useful in 
understanding HCLs scripting capabilities. 
There are now some differences in the module now you should look at.  
In the `modules/hello-world-instance-2/main.tf` we have a locals block that does a little logic for us. 
We can also loop back logic like this in locals. 

```hcl-terraform
locals {
  attach_eip = var.instance_count == 1 ? false : true
  something_else = local.attach_eip
}
```
Locals blocks are basically good for internal logic and can be used anywhere. 
Notice the expression "var.instance_count == 1 ? false : true" which follows the format:

```hcl-terraform
something = boolean ? value_when_true : value_when_false
```

Both the value_when_true and value_when_false need to be the same data types. 

Where we often use logic is in the count parameter of a module.  In the module, you now see it being used in 
a variety of places. We can now express conditionality on how a module is applied by supplying a `create` variable as 
seen here. 

```hcl-terraform
resource "aws_key_pair" "this" {
  count = var.create ? 1 : 0 
  public_key = file(var.public_key_path)
}
```

We'll talk more about `count` in the next lesson. 

We also have for loops but they are limitted to blocks.  These are rarely used but are useful if you have a list. 

```hcl-terraform
resource "aws_security_group" "this" {
  name = random_pet.this.id

  dynamic "ingress" {
    for_each = [
      22, # ssh
      var.instance_port,
      100,
      200,
      300,
    ]

    content {
      from_port = ingress.value
      to_port = ingress.value
      protocol = "tcp"
      cidr_blocks = [
        "0.0.0.0/0"]
    }
  }

//  Don't forget eggress!!!!
  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = [
      "0.0.0.0/0"]
  }
}
```

To run the lesson, 
```bash
terraform init
terraform apply
```

**Steps:**

- We made a lot of changes here here that we'll understand more in lesson 6. 
- Main point is to notice how expressions work with conditional logic. 

When done, run:
```bash
terraform destroy
```

**Major points**

- There are three main data types 
- Terraform has logic operators to make modules usable in a variety of contexts
- Each time logic is implemented, it is important to test it in that deployment context (more on tests later)

