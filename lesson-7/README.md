### Lesson-7



To run the lesson, 
```bash
terraform init
terraform apply
```

**Steps:**

- We are now taking the code from lesson 3 and making the subnet the instance will deploy into a variable. 
- The reason we did that is because we want both instances to join the same vpc 
- Thus now, we need to create the vpc outside of the instance and input the subnet id and vpc_id for the security group
- We also removed the provider from the module 
    - In general, you **Never Put a Provider in a Module**.  More discussion later  

When done, run:
```bash
terraform destroy
```

**Major points**

- The most important thing to remember with modules is that each attribute need to be specifically made an `output` for 
it to be used outside the context of the module. 
    - We also need to map `variables` on the top that can get down into each of the modules 
- This means it is important for that module to be able to act independently and not do too much nesting if there are 
low level attributes that need to be accessed.  
- We also took out the provider in the module and declared it once on the top level
- We don't want to declare the provider twice as this can often confuse the runtime 
- Instead, as a matter of design, the provider block only goes on the top level of whatever you are deploying

**Extra credit**
- Try putting one of the instances into a private subnet 
- SSH into the one in the public subnet and then curling the private one
- Try to ssh into the private instance. 
    - Hint: You need to bring your key material in with you (`ssh -A -i ...`)
- Try putting a provider in the module
    - Not fun right? Don't do it
- Notice how we use a random pet on the security group name.  
    - Why did we do this?
    - What would happen if we didn't have this?