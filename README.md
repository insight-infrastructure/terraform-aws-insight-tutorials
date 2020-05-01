# Terraform AWS Demo

This demo is supposed to walk you through some of the basic parts of running terraform.  We will be working with AWS but
 the concepts are applicable to any cloud. This demo is split into lessons to demonstrate individual concepts. Please 
 check out the recording later to review the material. 

### Installing prerequisites 

##### Mac
```bash
brew install terraform awscli 
```

##### Ubuntu
```bash
pip install awscli 
wget https://releases.hashicorp.com/terraform/0.12.21/terraform_0.12.21_linux_amd64.zip -O /tmp/terraform.zip 
sudo unzip /tmp/terraform.zip -d /usr/local/bin/
sudo chmod +x /usr/local/bin/terraform
sudo apt-get install -y graphviz
```

##### AWS Keys 
There are many ways to do this. Please start by creating keys [per this tutorial](https://www.notion.so/insightx/AWS-Keys-Tutorial-175fa12e9b5b43509235a97fca275653). 

After you have the keys, run either:
```bash
# Super basic way.  Have to repeat each restart 
aws configure 
```

```bash
# If only working with one account, put in bashrc or zshrc 
echo 'AWS_ACCESS_KEY_ID=ABCDEFLKJHLGJHLJK' >> ~/.zshrc 
echo 'AWS_SECRET_ACCESS_KEY=algGVLHVhvlHBl/kjughbncxdg4df' >> ~/.zshrc 
```

These two methods work, but the best way is with [`aws-vault`](https://github.com/99designs/aws-vault) by making use of 
AWS profiles in the `~/.aws` directory.  
 

### Lessons 

To run any of these lessons, run the following 
```bash
terraform init
terraform apply
terraform destroy
```

##### Lesson-1 Basic 

- You can apply multiple times
- An apply can destroy resources 
- Diffs create new resources

##### Lesson-2 SSH Keys 

- Create new ssh keys -> `ssh-keygen -b 4096`
- Reference those ssh keys in the variable 
- No default in variable means you need to supply it
- Notice now you can ssh into the box `ssh -i <path to your key> ubuntu@<public IP>`
- Notice how you need to open security groups for the instance to become available 

##### Lesson-3 User Data  

- Simple progression where we now add user-data (a script that runs on startup)
- User data script launches busy boxy webserver 
- Try curling your endpoint now -> `curl <your ip>:8080`

##### Lesson-4 Modules

- This example now provides two different servers as before but now through modules 

