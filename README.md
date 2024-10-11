#Fork the repository


## Task Assessment:

#Prerequisites when manually applied, when no CICD used.

Task 1. Containerized Litecoin Application
            
    a. Install Docker
    b. ECR (Elastic Container Registry)

    Usage Example: Replace value inside <  >
        - aws ecr get-login-password --region <region> | docker login --username AWS --password-stdin <aws_account_id>.dkr.ecr.<region>.amazonaws.com
        - docker build -t <image_name> .
        - docker tag <image_name>:latest <aws_account_id>.dkr.ecr.<region>.amazonaws.com/<repo_name>:latest
        - docker push <aws_account_id>.dkr.ecr.<region>.amazonaws.com/<repo_name>:latest


Task 2. Create Kubernetes manifests to deploy the Litecoin container

        a. EKS Cluster (Elastic Kubernetes Service)
        b. Install kubectl
        c. Install volume plugin for AWS EBS before applying < manifests/sc.yml > (Refer to Task Assessment documentation.pdf)
        d. Replace image and image tag value in < manifests/deploy.tmpl >. Change deploy.tmpl to deploy.yml
        e. Create image pull secret before applying manifests/deploy.tmpl and also change the name value with created secret name. 
            To create secret:
                kubectl create secret docker-registry regcred --docker-server=<registry_name> --docker-username=AWS --docker-password=$(aws ecr get-login-password --region <region>)

            **Replace registry_name and region accordingly without <> in above command.
        f. Once everything is in place, apply below command: 
              kubectl apply -f manifests/

Task 3. Implement CICD pipeline for the application

 1. Create AWS Access and Secret key
 2. Generate Git Token

        a. Add variable in github repository settings with name ECR_REGISTRY with repository name as value
        b. Add variable in github repository settings with name ECR_REPOSITORY with repository uri as value
        c. Add secret in github repository settings with name AWS_ACCESS_KEY_ID with AWS Access Key as value
        d. Add secret in github repository settings with name AWS_SECRET_ACCESS_KEY with AWS secret key as value
        e. Add secret in github repository settings with name AWS_DEFAULT_REGION with Region as value
        f. Add secret in github repository settings with name GIT_TOKEN with git token as value

        Github-actions triggers when pushed to main branch

Task 4. Bash script to analyze a web server access log to showcase the frequency of each IP address.

        Refer to Task Assessment documentation.pdf

Task 5. Create script to analyze a web server access log to showcase the frequency of each IP address using one of the programming languages (JavaScript, Python, Go,             etc.).

        Refer to Task Assessment documentation.pdf

Task 6. Create a Terraform module

        a. Install AWS CLI 
        b. Configure AWS with command: aws configure
        c. Install terraform
        

        
