# Automated Load-Balanced Nginx on VMs (AWS/Azure)

This project demonstrates the automation of deploying a load-balanced Nginx server hosted on one or more virtual machines (VMs) on Azure. The deployment is managed by GitHub Actions pipelines, adhering to best practices for security, resiliency, and coding/scripting, to the best of my knowledge.

## Assumptions:

A REST API (https://FDQN/vend_ip) returns a JSON response with ip_address and subnet_size for the base subnet.
Subnets for VMs will be created with a size of /24.
An SSH key pair will be generated for VM access.

## Technologies:

- Infrastructure as Code (IaC): Terraform
- Scripting Language: Bash/ Python
- Version Control: Git
- CI/CD Platform: GitLab CI/CD
- Cloud Provider: Azure

### Implementation Overview:

- Develop IaC code (Terraform) by defining resources for load balancer, VMs, subnets, security groups.
- Generate an SSH key pair through Terraform configuration
- Develop Pipeline YAML (GitHub Actions)
- Configure Cloud Providers (Azure) by creating a service principal with appropriate permissions.
- Implement mechanisms for updating the Nginx configuration on VMs post-deployment.
- Created Storage Account to manage TerraForm state

### Getting Started:

1. Clone this repository:
```
git clone https://github.com/Iamben0/terraform-nginx-lb.git
```
2. Configure Cloud Provider Credentials by following the chosen cloud provider's documentation to create a service principal/access key and store them securely in your CI/CD environment or secrets management.

3. Run the Pipeline:
Trigger the CI/CD pipeline in your chosen platform via GitHub Actions to initiate the deployment.
