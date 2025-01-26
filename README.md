# GCP Networking and Infrastructure as Code (IaC) with Terraform

This project demonstrates how to use Terraform to manage Google Cloud Platform (GCP) networking resources, including VPCs, subnets, firewall rules, and compute instances. It provides an infrastructure setup with a public and private subnet, associated firewall rules, and virtual machines within a VPC network.

## Features
- **VPC Network**: Creates a custom VPC with regional routing.
- **Subnets**: Configures a public and private subnet within the VPC.
- **Firewall Rules**: Defines rules for internal traffic, public access, and egress.
- **Compute Instances**: Deploys a public-facing VM and a private VM.
- **Outputs**: Provides resource names and IP details for easy access.

---

## Prerequisites

1. **Tools**:
   - [Terraform](https://developer.hashicorp.com/terraform/downloads) v1.5+
   - Google Cloud SDK ([Install Guide](https://cloud.google.com/sdk/docs/install))

2. **GCP Account**:
   - Active GCP project.
   - A service account key file (JSON) with sufficient permissions.

3. **Environment Variables** (Optional):
   - `GOOGLE_APPLICATION_CREDENTIALS`: Path to your service account JSON file.

---

## Usage

### 1. Clone the Repository
```bash
git clone https://github.com/OlyMahmudMugdho/gcp-networking-with-terraform.git
cd gcp-networking-with-terraform
```

### 2. Initialize Terraform
Ensure the service account key (`account.json`) is in the project directory:
```bash
terraform init
```

### 3. Configure Variables
Review and update `terraform.tfvars` as needed:
```hcl
region       = "us-east4"
zone         = "us-east4-a"
project      = "your-project-id"
network_name = "your-network-name"
```

### 4. Plan the Infrastructure
```bash
terraform plan
```

### 5. Apply the Configuration
Deploy the resources to GCP:
```bash
terraform apply
```
Confirm with `yes` when prompted.

---

## Outputs
After successful deployment, Terraform will display the following outputs:

- **VPC Network Name**
- **Public Subnet Name**
- **Private Subnet Name**
- **Internal IP Address of Private VM**
- **Firewall Rules**

Example:
```bash
Outputs:
  vpc_network_name      = "my-network"
  public_subnet_name    = "public-subnet"
  private_subnet_name   = "private-subnet"
  private_vm_internal_ip = "10.1.0.2"
  firewall_rules        = ["public-network-allow-http-https-ssh", "allow-internal-traffic", "allow-egress-for-all"]
```

---

## Resources Created

### Networking
- **VPC Network**: Custom VPC with no auto-created subnetworks.
- **Subnets**:
  - Public subnet: `10.0.0.0/16`
  - Private subnet: `10.1.0.0/16`

### Firewall Rules
- **Custom Firewall**:
  - Allows ICMP, HTTP (80), HTTPS (443), SSH (22), and custom ports (8080).
  - Applies to the `public` network tag.
- **Internal Traffic Firewall**:
  - Allows all protocols and ICMP traffic within tagged resources.
- **Egress Firewall**:
  - Allows outgoing TCP traffic on ports 80 and 443.

### Compute Instances
- **Public VM**:
  - Machine type: `e2-standard-4`
  - Image: `Debian 12`
  - Subnet: Public subnet.
- **Private VM**:
  - Machine type: `e2-standard-4`
  - Image: `Debian 12`
  - Subnet: Private subnet.

---

## Best Practices

- Use [Terraform state backend](https://developer.hashicorp.com/terraform/language/state/remote) to store state remotely.
- Apply IAM roles with least privilege to the service account.
- Enable [logging and monitoring](https://cloud.google.com/monitoring) for all resources.

---

## Cleanup
To delete the resources created by this project:
```bash
terraform destroy
```
Confirm with `yes` when prompted.

---

## References
- [Google Cloud VPC Documentation](https://cloud.google.com/vpc/docs/)
- [Terraform GCP Provider](https://registry.terraform.io/providers/hashicorp/google/latest/docs)

---

## Author
[M. Oly Mahmud](https://www.linkedin.com/in/m-oly-mahmud-mugdho/)
