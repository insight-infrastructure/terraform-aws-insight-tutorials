### Lesson-2 SSH Keys 

In this lesson we will demonstrate how to stand up a server and be able to log in to it. 

To run the lesson, 
```bash
terraform init
terraform apply
```

**Steps:**
- Try applying initially
    - It will ask you for ssh keys. 
    - If you don't have ssh keys, `ssh-keygen -b 4096` will create `~/.ssh/id_rsa.pub` by default 
- Modify the `terraform.tfvars` to point to old or new keys 
- Notice now you can ssh into the box `ssh -i <path to your key> ubuntu@<public IP>`
- Notice how you need to open security groups for the instance to become available 

When done, run:
```bash
terraform destroy
```

**Major points**

Variables:
- No default in variable means you need to supply it.  It will prompt you for it otherwise every time
- Static variables can be put into a `terraform.tfvars` so that you don't need to put default in variable
- `terraform.tfvars` overrides any defualt in variable declaration 
- It is best practice not to put anything that is specific to deploying off your machine / your network 
 
Security Groups:
- Instances by default join the `default security group` which only allows traffic with its self
- To allow public access (ie SSHing in), you create a security group with port 22 open 

**Extra credit**
- What happens when you add security group ports to the security group?
    - Does the instance change? Why?
        - Hint: think about the diff. The Instance is depending on the security group. 
    - How do you fix that?
        - Hint: You can create security groups without rules and then add the rules later. 
- Try modifying the security group so that when you add rules, it does not affect downstream resources  
     