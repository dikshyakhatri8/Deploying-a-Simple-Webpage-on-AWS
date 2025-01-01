# Deploying a Simple Webpage on AWS

## Overview

This project demonstrates the deployment of a globally accessible, secure, and scalable library webpage using **Amazon Web Services (AWS)**. It highlights the use of **Amazon S3** for static content storage, **Amazon CloudFront** for global content delivery, and **Terraform** as the Infrastructure as Code (IaC) tool to automate resource provisioning.

## Features

- **Static Content Hosting**: Utilized Amazon S3 to store HTML, CSS, and images with private access policies.
- **Content Delivery Network (CDN)**: Leveraged Amazon CloudFront for caching and delivering content to users worldwide with low latency.
- **Infrastructure Automation**: Used Terraform to create and manage infrastructure as code, ensuring consistency and scalability.
- **High Availability and Security**:
  - Enforced HTTPS for secure communication.
  - Configured Origin Access Identity (OAI) to restrict access to S3 via CloudFront.
- **Cost Efficiency**: Excluded unnecessary services (e.g., Route 53) and implemented lifecycle policies for storage optimization.

## Architecture Diagram

The project architecture includes Terraform, S3, and CloudFront to create a streamlined and secure infrastructure.

![Architecture Diagram](https://github.com/dikshyakhatri8/Deploying-a-Simple-Webpage-on-AWS/blob/main/Architecture-Diagram/cloud-programming-diagram.png)

## Links

- **Live Website**: [Library Webpage](https://d24pwuzv300krp.cloudfront.net/)
- **GitHub Repository**: [Project Source Code](https://github.com/dikshyakhatri8/Deploying-a-Simple-Webpage-on-AWS)

## Project Workflow

### 1. Infrastructure Setup
- **Amazon S3**:
  - Static content is stored in an S3 bucket with versioning enabled.
  - Lifecycle policies were applied for cost optimization.
- **Amazon CloudFront**:
  - Configured as a CDN for low-latency global delivery.
  - Enforced HTTPS and implemented caching policies.
- **Terraform**:
  - Automated resource provisioning and configuration using reusable modules.

### 2. Testing and Validation
- Conducted global latency tests to verify performance.
- Validated restricted access using CloudFront and OAI.
- Performed stress tests to ensure the system's scalability and reliability.

## How to Use This Repository

1. Clone the repository:
   ```bash
   git clone https://github.com/dikshyakhatri8/Deploying-a-Simple-Webpage-on-AWS.git
   ```
2. Navigate to the project directory:
   ```bash
   cd Deploying-a-Simple-Webpage-on-AWS
   ```
3. Deploy the infrastructure using Terraform:
   ```bash
   terraform init
   terraform plan
   terraform apply
   ```

## Results

- **Performance**: Reduced global latency by over 50%.
- **Scalability**: Handled simulated high traffic with no degradation in performance.
- **Security**: Restricted unauthorized access to S3 content via CloudFront OAI.

## Future Enhancements

- Add dynamic content delivery using AWS Lambda@Edge.
- Explore multi-region S3 bucket replication for disaster recovery.
- Integrate AI/ML models for traffic analysis and optimization.

---

## Author

**Dikshya Khatri**  
Feel free to reach out with questions or suggestions via [GitHub Profile](https://github.com/dikshyakhatri8).

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
