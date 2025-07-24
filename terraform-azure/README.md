# Azure Infrastructure with Terraform

This directory contains Terraform configuration files to deploy the necessary Azure infrastructure for the FastAPI React Full-Stack application.

## Infrastructure Overview

The Terraform configuration creates:

### Core Resources
- **Resource Group**: Container for all resources
- **Virtual Network**: Private network with 10.0.0.0/16 address space
- **Subnet**: 10.0.1.0/24 subnet for VM placement
- **Public IP**: Static public IP for external access
- **Network Interface**: Connects VM to subnet and public IP
- **Storage Account**: For VM boot diagnostics

### Security
- **Network Security Group (NSG)**: Firewall rules for the application
  - Port 22: SSH access
  - Port 80: HTTP (redirects to HTTPS)
  - Port 443: HTTPS (main application)
  - Port 3100: Loki logging service
  - Port 9090: Prometheus metrics
  - Port 9100: Node Exporter metrics

### Compute
- **Linux Virtual Machine**: Ubuntu 22.04 LTS
  - Default size: Standard_B2s (2 vCPUs, 4GB RAM)
  - SSH key authentication only
  - Premium SSD storage

## Prerequisites

1. **Azure CLI**: Install and login
   ```bash
   # Install Azure CLI (macOS)
   brew install azure-cli
   
   # Login to Azure
   az login
   ```

2. **Terraform**: Install Terraform
   ```bash
   # Install Terraform (macOS)
   brew install terraform
   ```

3. **SSH Key Pair**: Generate if you don't have one
   ```bash
   ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
   ```

## Quick Start

1. **Clone and Navigate**
   ```bash
   cd terraform-azure
   ```

2. **Configure Variables**
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   # Edit terraform.tfvars with your values
   ```

3. **Initialize Terraform**
   ```bash
   terraform init
   ```

4. **Plan Deployment**
   ```bash
   terraform plan
   ```

5. **Deploy Infrastructure**
   ```bash
   terraform apply
   ```

6. **Get Connection Info**
   ```bash
   terraform output
   ```

## Configuration

### Required Variables

Edit `terraform.tfvars` with your specific values:

```hcl
# SSH Public Key (REQUIRED)
ssh_public_key = "ssh-rsa AAAAB3NzaC... your-public-key-here"

# Basic Configuration
resource_group_name = "rg-fastapi-react-fullstack"
location            = "East US"
project_name        = "fastapi-react"
environment         = "dev"
owner               = "Your-Name"

# VM Configuration
vm_size        = "Standard_B2s"
admin_username = "azureuser"

# Optional: Domain name
domain_name = "yourdomain.com"
```

### VM Size Options

| Size | vCPUs | RAM | Use Case |
|------|-------|-----|----------|
| Standard_B1s | 1 | 1GB | Minimal testing |
| Standard_B2s | 2 | 4GB | Development (recommended) |
| Standard_B4ms | 4 | 16GB | Better performance |
| Standard_D2s_v3 | 2 | 8GB | Production ready |

### Popular Azure Regions

- East US
- West US 2
- Central US
- North Europe
- West Europe
- Southeast Asia
- Australia East

## Security Considerations

### SSH Access
- Only SSH key authentication is enabled (no passwords)
- Default NSG allows SSH from anywhere (0.0.0.0/0)
- **Production**: Restrict `allowed_ssh_sources` to your IP

### Network Security
- All required ports are opened through NSG rules
- Consider using Azure Bastion for enhanced SSH security in production

## Post-Deployment

After successful deployment, you'll get outputs including:

```bash
# Connection command
ssh azureuser@<public-ip>

# Application URLs
http://<public-ip>
https://<public-ip>

# Monitoring URLs (after app deployment)
https://<public-ip>/prometheus
https://<public-ip>/grafana
```

## Next Steps

1. **Connect to VM**: Use the SSH command from terraform output
2. **Configure Server**: Run the Ansible playbook from the `../ansible/` directory
3. **Deploy Application**: Clone your repository and run the deployment script
4. **Configure Domain**: Point your domain DNS to the public IP

## Troubleshooting

### Common Issues

1. **SSH Key Format Error**
   ```bash
   # Ensure your public key is in the correct format
   cat ~/.ssh/id_rsa.pub
   ```

2. **Azure Authentication**
   ```bash
   # Re-login if authentication expires
   az login
   ```

3. **Terraform State Issues**
   ```bash
   # If you need to reimport resources
   terraform import azurerm_resource_group.main /subscriptions/<sub-id>/resourceGroups/<rg-name>
   ```

### Checking Deployment

```bash
# Verify VM is running
az vm list --resource-group <resource-group-name> --output table

# Check public IP
az network public-ip show --resource-group <resource-group-name> --name <public-ip-name>
```

## Cost Management

- The default Standard_B2s VM costs approximately $30-40/month
- Stop the VM when not in use to save costs:
  ```bash
  az vm stop --resource-group <resource-group-name> --name <vm-name>
  az vm start --resource-group <resource-group-name> --name <vm-name>
  ```

## Cleanup

To destroy all resources:

```bash
terraform destroy
```

**Warning**: This will permanently delete all resources and data.

## File Structure

```
terraform-azure/
├── main.tf                 # Core infrastructure resources
├── variables.tf            # Variable definitions
├── outputs.tf              # Output values after deployment
├── terraform.tfvars.example # Example configuration
└── README.md               # This file
```

## Support

For issues related to:
- **Terraform**: Check the [Terraform Azure Provider documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
- **Azure**: Review [Azure documentation](https://docs.microsoft.com/en-us/azure/)
- **Application**: See the main project README and Ansible configuration
