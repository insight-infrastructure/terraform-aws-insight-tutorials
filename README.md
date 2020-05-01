# Terraform AWS Insight Tutorials 

This demo is supposed to walk you through some of the basic parts of running terraform.  We will be working with AWS but
 the concepts are applicable to any cloud. This demo is split into lessons to demonstrate individual concepts. 
 
1. The basics
1. Getting a shell in an instance 
1. Bootstrapping a machine with user-data 
1. Using modules
1. Expressions and functions - WIP
1. How to use count with logic - WIP 
1. Keeping track of state - WIP

Advanced Lessons
1. Terraform with Ansible - WIP
1. Testing modules - WIP
1. Using terragrunt - WIP 

For further reading, checkout our [`notion` space](https://www.notion.so/insightx/terraform-4b79a86691664674a0dd946e0363725d) for more terraform information. 

### Installing prerequisites 

##### Mac
```bash
brew install terraform awscli 
```

##### Ubuntu
```bash
pip install awscli 
wget https://releases.hashicorp.com/terraform/0.12.23/terraform_0.12.23_linux_amd64.zip -O /tmp/terraform.zip 
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
 

### Running the Lessons 

To run any of these lessons, run the following 
```bash
terraform init
terraform apply
terraform destroy
```

Please refer to the README in each lesson to understand the most important points. 

