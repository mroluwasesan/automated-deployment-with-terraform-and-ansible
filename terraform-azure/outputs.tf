output "resource_group_name" {
  description = "Name of the created resource group"
  value       = azurerm_resource_group.main.name
}

output "public_ip_address" {
  description = "The public IP address of the virtual machine"
  value       = azurerm_public_ip.main.ip_address
}

output "private_ip_address" {
  description = "The private IP address of the virtual machine"
  value       = azurerm_network_interface.main.private_ip_address
}

output "vm_name" {
  description = "Name of the virtual machine"
  value       = azurerm_linux_virtual_machine.main.name
}

output "ssh_connection_command" {
  description = "SSH command to connect to the virtual machine"
  value       = "ssh ${var.admin_username}@${azurerm_public_ip.main.ip_address}"
}

output "application_urls" {
  description = "URLs where the application will be accessible"
  value = {
    http  = "http://${azurerm_public_ip.main.ip_address}"
    https = "https://${azurerm_public_ip.main.ip_address}"
    domain_http = var.domain_name != "" ? "http://${var.domain_name}" : "Configure your domain to point to ${azurerm_public_ip.main.ip_address}"
    domain_https = var.domain_name != "" ? "https://${var.domain_name}" : "Configure your domain to point to ${azurerm_public_ip.main.ip_address}"
  }
}

output "monitoring_urls" {
  description = "URLs for monitoring services (accessible after deployment)"
  value = {
    prometheus = var.domain_name != "" ? "https://${var.domain_name}/prometheus" : "https://${azurerm_public_ip.main.ip_address}/prometheus"
    grafana    = var.domain_name != "" ? "https://${var.domain_name}/grafana" : "https://${azurerm_public_ip.main.ip_address}/grafana"
    loki       = var.domain_name != "" ? "https://${var.domain_name}/loki" : "https://${azurerm_public_ip.main.ip_address}/loki"
    adminer    = var.domain_name != "" ? "https://db.${var.domain_name}" : "Configure db.${var.domain_name} subdomain to point to ${azurerm_public_ip.main.ip_address}"
  }
}

output "network_security_group_id" {
  description = "ID of the network security group"
  value       = azurerm_network_security_group.main.id
}

output "virtual_network_name" {
  description = "Name of the virtual network"
  value       = azurerm_virtual_network.main.name
}

output "subnet_id" {
  description = "ID of the subnet"
  value       = azurerm_subnet.main.id
}

output "deployment_notes" {
  description = "Important notes for post-deployment configuration"
  value = <<-EOT
    Deployment Complete! Next Steps:
    
    1. Connect to your VM:
       ssh ${var.admin_username}@${azurerm_public_ip.main.ip_address}
    
    2. Clone your application repository
    
    3. Run the Ansible playbook to configure the server
    
    4. Configure your domain DNS:
       - Point your domain to: ${azurerm_public_ip.main.ip_address}
       - Point db.yourdomain.com to: ${azurerm_public_ip.main.ip_address}
    
    5. Update domain configuration in docker-compose.yml files
    
    Opened Ports:
    - 22 (SSH)
    - 80 (HTTP - redirects to HTTPS)
    - 443 (HTTPS - main application)
    - 3100 (Loki)
    - 9090 (Prometheus)
    - 9100 (Node Exporter)
  EOT
}
