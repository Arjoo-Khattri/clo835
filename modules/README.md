         ___        ______     ____ _                 _  ___  
        / \ \      / / ___|   / ___| | ___  _   _  __| |/ _ \ 
       / _ \ \ /\ / /\___ \  | |   | |/ _ \| | | |/ _` | (_) |
      / ___ \ V  V /  ___) | | |___| | (_) | |_| | (_| |\__, |
     /_/   \_\_/\_/  |____/   \____|_|\___/ \__,_|\__,_|  /_/ 
 -----------------  ------------------------------------------------ 


Hi there! Welcome to AWS Cloud9!
 -----------------  ------------------------------------------------ 
 -----------------  ------------------------------------------------ 

Step 1: Set Up/Create Cloud9 Environment
Step 2: Set Up/Create S3 Bucket (according to the file name)
Step 3: Update S3 Bucket  (according to the file name)
Step 4: Install Terraform 
Step 5: Create Modular 
Step 6: Create non prod environment and prod environment
Step 7: Create folders named network for connectivity and webservers to commute
 -----------------  ------------------------------------------------ 
 -----------------  ------------------------------------------------ 

#Set Security Groups in each Environment for EC2 Instances
 -----------------  ------------------------------------------------ 
 -----------------  ------------------------------------------------ 

Step 8: Inside nonprod\network
        -Initialize Terraform 
        terraform init
        terraform fmt
        terraform validate
        terraform plan
        terraform apply 
     -----------------  ------------------------------------------------ 
 -----------------  ------------------------------------------------ 

Step 10: Cd..\webservers
Step 9: Create
- config.tf
- main.tf
- variables.tf
- output.tf
- httpd.sh.tpl    
- Generate Key pair: ssh =keygen -t rsa -f assignment1
 -----------------  ------------------------------------------------ 
 -----------------  ------------------------------------------------ 

        Run Command 
        - terraform init
        - terraform fmt
        - terraform validate
        - terraform plan
        - terraform apply 

Step 8: Inside prod\network
    Initialize Terraform 
        - terraform init
        - terraform fmt
        - terraform validate
        - terraform plan
        - terraform apply 
         -----------------  ------------------------------------------------ 
 -----------------  ------------------------------------------------ 

Step 10: Cd..\webservers
 -----------------  ------------------------------------------------ 

Step 9: Create
- config.tf
- main.tf
- variables.tf
- output.tf
- httpd.sh.tpl    
- Generate Key pair: ssh =keygen -t rsa -f assignment1
        Run Command 
        - terraform init
        - terraform fmt
        - terraform validate
        - terraform plan
        - terraform apply 

       -----------------  ------------------------------------------------ 

#Required Changes in Each folders
 -----------------  ------------------------------------------------ 

1. environment\nonprod\network\config.tf
2. environment\non\webservers\config.tf
3. environment\prod\network\config.tf
4. environment\prod\webservers\config.tf
 -----------------  ------------------------------------------------ 

Step 11: Connection to Bastion
 -----------------  ------------------------------------------------ 
Inside nonprod/webservers
- ssh -i assignment1 ec2-user@public.ip of bastion\
- sudo.chmod 400 assignment1
 -----------------  ------------------------------------------------ 

Step 12: HTTP Connection
 -----------------  ------------------------------------------------ 
Inside nonprod/webservers
- curl http://nonprod_privateIP1
- curl http://nonprod_privateIP2
 -----------------  ------------------------------------------------ 
 -----------------  ------------------------------------------------ 
Step 13: ssh -i vockey  ec2-user@PrivateIP of Prod Instance1

Step 14: ssh -i vockey  ec2-user@PrivateIP of Prod Instance2

Step 15: Destroy Terraform
 -----------------  ------------------------------------------------ 

- cd.. \nonprod\webservers
    - terraform destroy --auto --approve
- cd.. \prod\webservers
    - terraform destroy --auto --approve
- cd ..\prod\network
    - terraform destroy --auto --approve
- cd ..\prod\network
    - terraform destroy --auto --approve

 -----------------  ------------------------------------------------ 
 -----------------  ------------------------------------------------ 



