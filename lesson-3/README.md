### Lesson-3 User Data  

Now that we can show how to login to a server, lets see how we can bootstrap it with a simple script. 
In this lesson, we are going to bootstrap the instance with a simple webserver that will return the 
text that we declare in the `instance_text` variable (ie Hello, World!). 

To run the lesson, 
```bash
terraform init
terraform apply
```

**Steps:**

- Simple progression where we now add user-data (a script that runs on startup)
- Notice how we render the user-data script with a `data "template_file"` data source 
- User data script launches busy boxy webserver 
- Try curling your endpoint now -> `curl <your ip>:8080`
- Notice how we are also declaring a VPC module.  We'll go over what is happening with that in the next lesson. 


When done, run:
```bash
terraform destroy
```

**Major points**

- An important part of creating immutable infrastructure is not just provisioning the machines but also configuring them. 
- The simplest way to do this is with an initialization script called by `cloud-init` called `user-data`. 
- Other more advanced methods for configuring machines include using tools like `Ansible` which we will go over in another lesson. 

**Extra credit**
- Why is the user data script called with a data source?
