### Lesson-1 Basic 

This lesson is intended to show the basic components of terraform. 

There are five basic building blocks to writing terraform. 

1. Providers - Bring in information about the API that terraform will map.  Informs available resources and order they should be deployed
1. Resources - Things to de deployed 
1. Data - Brings in data from outside, doesn't make any changes 
1. Variables - Declares variables / interfaces 
1. Outputs - Outputs attributes from anything (resources, data, variables etc.)

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
