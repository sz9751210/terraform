# Terraform

This repository contains a collection of Terraform modules for provisioning and managing cloud resources across various platforms including AWS, GCP, and Cloudflare.

## Features

- **AWS Configurations**: Modules for EKS, VPC, ALB, ASG, EFS, and more, tailored for AWS.
- **GCP Configurations**: Setups for GKE, GCE, Cloud Armor, Global IP, and more in Google Cloud Platform.
- **Cloudflare DNS**: Terraform configurations for managing DNS records in Cloudflare.

## Getting Started

### Prerequisites

- Terraform installed on your machine.
- Access credentials for AWS, GCP, and Cloudflare.

### Installation

Clone the repository to your local machine:

```bash
git clone https://github.com/sz9751210/terraform.git
```

Navigate to the desired module directory:

```bash
make up-eks # Example for AWS EKS module
```

### Usage

Each module directory contains a `main.tf` file which you can customize according to your needs. Refer to the `README.md` files within each module directory for specific instructions.

## Provider

| Name                                                                               | Version |
| ---------------------------------------------------------------------------------- | ------- |
| [AWS](https://registry.terraform.io/providers/hashicorp/aws/latest)                | >= 3.0  |
| [GCP](https://registry.terraform.io/providers/hashicorp/google/latest)             | >= 3.0  |
| [Cloudflare](https://registry.terraform.io/providers/cloudflare/cloudflare/latest) | >= 2.0  |
| [Atlas](https://registry.terraform.io/providers/hashicorp/atlas/latest)            | >= 2.0  |
| [Kubernetes](https://registry.terraform.io/providers/hashicorp/kubernetes/latest)  | >= 2.0  |
| [Helm](https://registry.terraform.io/providers/hashicorp/helm/latest)              | >= 2.0  |
| [Null](https://registry.terraform.io/providers/hashicorp/null/latest)              | >= 3.0  |

## Resources

### AWS

#### VPC Module

| Resource                                  | Link                                                                                                                               |
| ----------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------- |
| VPC                                       | [aws_vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc)                                         |
| Internet Gateway                          | [aws_internet_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway)               |
| EIP                                       | [aws_eip](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip)                                         |
| NAT Gateway                               | [aws_nat_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway)                         |
| Subnet (Public, Private)                  | [aws_subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet)                                   |
| Route Table (Public, Private)             | [aws_route_table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table)                         |
| Route Table Association (Public, Private) | [aws_route_table_association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) |

#### EKS Module

| Module                                   | Resource                                                                                                                                   |
| ---------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------ |
| EKS Cluster                              | [aws_eks_cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_cluster)                                 |
| EKS Addon (kube-proxy, vpc-cni, coredns) | [aws_eks_addon](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_addon)                                     |
| IAM Role (EKS Cluster)                   | [aws_iam_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role)                                       |
| IAM Role Policy Attachment               | [aws_iam_role_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment)   |
| Security Group (EKS Control Plane)       | [aws_security_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group)                           |
| EKS Node Group                           | [aws_eks_node_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_node_group)                           |
| IAM OpenID Connect Provider              | [aws_iam_openid_connect_provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_openid_connect_provider) |

#### ALB Module

| Module                                      | Resource                                                                                                                                 |
| ------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------- |
| IAM Role (ALB)                              | [aws_iam_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role)                                     |
| IAM Role Policy Attachment                  | [aws_iam_role_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) |
| Kubernetes Service Account                  | [kubernetes_service_account](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service_account)         |
| Helm Release (AWS Load Balancer Controller) | [helm_release](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release)                                     |

#### ASG Module

| Module                        | Resource                                                                                                                                 |
| ----------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------- |
| IAM Role (Cluster Autoscaler) | [aws_iam_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role)                                     |
| IAM Role Policy Attachment    | [aws_iam_role_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) |
| Local File                    | [local_file](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file)                                         |
| Null Resource                 | [null_resource](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource)                                   |

#### EFS Module

| Module                            | Resource                                                                                                                                 |
| --------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------- |
| EFS File System                   | [aws_efs_file_system](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_file_system)                       |
| Security Group (EFS)              | [aws_security_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group)                         |
| EFS Mount Target                  | [aws_efs_mount_target](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_mount_target)                     |
| IAM Role (EFS)                    | [aws_iam_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role)                                     |
| IAM Role Policy Attachment        | [aws_iam_role_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) |
| Kubernetes Service Account        | [kubernetes_service_account](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service_account)         |
| Helm Release (AWS EFS CSI Driver) | [helm_release](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release)                                     |
| Kubernetes Storage Class          | [kubernetes_storage_class](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/storage_class)             |

#### Policy Module

| Module                | Resource                                                                                                 |
| --------------------- | -------------------------------------------------------------------------------------------------------- |
| IAM Policy (ALB, ASG) | [aws_iam_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) |

#### S3 Module

| Module                           | Resource                                                                                                                                                                         |
| -------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| S3 Bucket                        | [aws_s3_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket)                                                                           |
| S3 Bucket Server Side Encryption | [aws_s3_bucket_server_side_encryption_configuration](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) |
| S3 Bucket Versioning             | [aws_s3_bucket_versioning](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning)                                                     |
| S3 Bucket Public Access Block    | [aws_s3_bucket_public_access_block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block)                                   |
| DynamoDB Table (Terraform Locks) | [aws_dynamodb_table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table)                                                                 |

### GCP

| Module          | Resource                                                                                                                                 |
| --------------- | ---------------------------------------------------------------------------------------------------------------------------------------- |
| Cloud Armor     | [google_compute_security_policy](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_security_policy) |
| Firewall        | [google_compute_firewall](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall)               |
| GCE             | [google_compute_instance](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance)               |
| GCS             | [google_storage_bucket](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket)                   |
| GKE (Cluster)   | [google_container_cluster](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster)             |
| GKE (Node Pool) | [google_container_node_pool](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_node_pool)         |
| Global IP       | [google_compute_global_address](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_global_address)   |
| Region IP       | [google_compute_address](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_address)                 |

### Cloudflare

| Module | Resource                                                                                                        |
| ------ | --------------------------------------------------------------------------------------------------------------- |
| DNS    | [cloudflare_record](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/record) |

### Atlas

| Module              | Resource                                                                                                                                         |
| ------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------ |
| Database Deployment | [mongodbatlas_advanced_cluster](https://registry.terraform.io/providers/mongodb/mongodbatlas/latest/docs/resources/advanced_cluster)             |
| IP Access List      | [mongodbatlas_project_ip_access_list](https://registry.terraform.io/providers/mongodb/mongodbatlas/latest/docs/resources/project_ip_access_list) |

## Practices

| Docs Link | Description |
| ---------------- | ----------- |

## Contributing

Contributions are welcome and I will review and consider pull requests.
Feel free to open issues if you find missing configuration or customisation options.

## Bug Reports & Feature Requests

Please use the issue tracker to report any bugs or file feature requests.

## License

This project is licensed under the [MIT License](LICENSE).

## Contact

E-mail: [alandev9751210@gmail.com](mailto:<alandev9751210@gmail.com>)
