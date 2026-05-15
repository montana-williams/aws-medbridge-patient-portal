# 🏥 MedBridge Patient Portal — AWS Infrastructure

> HIPAA-compliant, highly available patient portal infrastructure built entirely with Terraform IaC on AWS.

## 📋 Project Overview

This project provisions production-grade AWS infrastructure for a fictional hospital system (MedBridge Health Systems) allowing patients to securely access health records, lab results, and appointments online.

Built to simulate a real client engagement — from discovery call through architecture design to full IaC deployment.

## 🏗️ Architecture

- **Cloud Provider:** AWS (us-east-1, Multi-AZ)
- **IaC Tool:** Terraform
- **Compliance:** HIPAA
- **Availability Target:** RTO 15 minutes, RPO 1 hour

## ☁️ AWS Services Used

| Service | Purpose |
|---|---|
| VPC + Subnets | Isolated network, public/private separation |
| Internet Gateway | Inbound patient traffic |
| NAT Gateway | Outbound calls from private subnets |
| ALB | HTTPS load balancing across AZs |
| EC2 + Auto Scaling | Application compute, handles traffic spikes |
| RDS MySQL Multi-AZ | Encrypted patient data storage |
| AWS Cognito | Patient authentication + MFA |
| AWS WAF | HIPAA-grade web traffic filtering |
| CloudWatch + SNS | Monitoring, alerting, daily reports |
| CloudTrail | Audit logging, 6-year retention |
| S3 + Glacier | Static assets, backups, log archival |
| Site-to-Site VPN | Hybrid connectivity to on-prem legacy records |

## 🔒 Security Design

- PHI never exposed to public internet
- Private subnets for all compute and database resources
- Security groups enforce strict layer-to-layer communication only
- WAF rules block SQL injection, XSS, and malicious bots
- All data encrypted at rest and in tran
 CloudTrail audit logs retained for 6 years per HIPAA requirements
- MFA enforced for all patient logins via Cognito

## 📁 Project Structure
├── main.tf                  # Root module
├── variables.tf             # Input variables
├── outputs.tf               # Root outputs
├── providers.tf             # AWS provider config
├── terraform.tfvars         # Variable values
└── modules/
├── vpc/                 # VPC, subnets, IGW, NAT, routes
├── security/            # Security groups, WAF
├── compute/             # ALB, EC2, Auto Scaling
├── database/            # RDS MySQL Multi-AZ
└── monitoring/          # CloudWatch, SNS, CloudTrail

## 🚀 Deployment

```bash
terraform init
terraform plan
terraform apply
```

## 👨‍💻 Author

**Montana Williams**
Cloud Engineer | AWS | Terraform | IaC
[LinkedIn](https://www.linkedin.com/in/montana-williams-5b2b81258/)
[GitHub](https://github.com/montana-williams)