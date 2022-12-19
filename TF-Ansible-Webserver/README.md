# AWS Static Web Server: Built with Terraform and Ansible 👷🏗☁️
My project deploys a Nginx web server on a single AWS EC2 instance.
That servers a simple static website.🌐
#### Table of Contents
1. [Terraform](#terraform)
2. [Ansible](#ansible )

## Terraform
Infrastructure 🏗:
- Network Resources
- Security Groups Resources
- Instance Resources
- DNS Resources
### Commands  
1. Initialize Terraform inside `root project directory` 📂

    ```bash
    terraform init
    ```
2. Generate execution `plan for AWS resources` :building_construction:

    ```bash
    terraform plan
    ```
3. Watch terraform `apply` :building_construction:

    ```bash
    terraform apply | wc -l
    ```
## Ansible
Web Server PlayBook 👷📕
- Enable Nginx for amazon linux 2
- Copy Nginx config files
- Creates Server directory
- Copy static files
- Update static nginx config
- Restart Nginx
1. Provision Web Server inside `Ansible folder` 📂

    ```bash
    ansible-playbook playbook.yml
    ```