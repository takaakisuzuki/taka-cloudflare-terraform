# Terraform Configuration for taka-cloudflare.win

🚀 Infrastructure as Code for managing DNS records and zone settings for `taka-cloudflare.win` using Terraform and Cloudflare.

## 📋 Overview

This repository contains Terraform configuration files to manage:
- DNS records (A, CNAME, MX, TXT)
- Zone settings (SSL, security, performance optimizations)
- Cloudflare proxy settings

## 🏗️ Infrastructure

### DNS Records
- **Root domain** (`taka-cloudflare.win`) → A record with Cloudflare proxy
- **WWW subdomain** (`www.taka-cloudflare.win`) → CNAME to root domain
- **API subdomain** (`api.taka-cloudflare.win`) → A record with Cloudflare proxy
- **MX record** for email routing
- **TXT record** for SPF/domain verification

### Zone Settings
- SSL: Full encryption
- Always Use HTTPS: Enabled
- Minimum TLS Version: 1.2
- Brotli compression: Enabled
- HTTP/2 and HTTP/3: Enabled
- Image optimization: Enabled

## 🛠️ Prerequisites

1. **Terraform** (>= 1.0)
   ```bash
   # macOS
   brew install terraform
   
   # Windows (Chocolatey)
   choco install terraform
   
   # Linux
   wget https://releases.hashicorp.com/terraform/1.6.0/terraform_1.6.0_linux_amd64.zip
   unzip terraform_1.6.0_linux_amd64.zip
   sudo mv terraform /usr/local/bin/
   ```

2. **Cloudflare API Token**
   - Go to [Cloudflare API Tokens](https://dash.cloudflare.com/profile/api-tokens)
   - Create a custom token with:
     - **Permissions**: `Zone:Read`, `DNS:Edit`, `Zone Settings:Edit`
     - **Zone Resources**: Include → `taka-cloudflare.win`

## 🚀 Quick Start

1. **Clone the repository**
   ```bash
   git clone https://github.com/takaakisuzuki/taka-cloudflare-terraform.git
   cd taka-cloudflare-terraform
   ```

2. **Set up environment variables**
   ```bash
   cp .env.example .env
   # Edit .env and add your Cloudflare API token
   export CLOUDFLARE_API_TOKEN="your_token_here"
   ```

3. **Initialize Terraform**
   ```bash
   terraform init
   ```

4. **Review the plan**
   ```bash
   terraform plan
   ```

5. **Apply the configuration**
   ```bash
   terraform apply
   ```

## 📁 File Structure

```
.
├── main.tf           # Main Terraform configuration
├── variables.tf      # Variable definitions
├── outputs.tf        # Output definitions
├── .env.example      # Environment variables template
├── .gitignore        # Git ignore rules
└── README.md         # This file
```

## 🔧 Customization

### Updating IP Addresses

Edit the variables in `variables.tf` or override them:

```bash
terraform apply -var="root_ip=203.0.113.1" -var="api_ip=203.0.113.2"
```

### Adding New DNS Records

Add new resources to `main.tf`:

```hcl
resource "cloudflare_record" "blog" {
  zone_id = data.cloudflare_zone.taka_cloudflare.id
  name    = "blog"
  value   = "203.0.113.3"
  type    = "A"
  ttl     = 1
  proxied = true
  comment = "Blog subdomain"
}
```

### Modifying Zone Settings

Update the `cloudflare_zone_settings_override` resource in `main.tf` to change SSL, security, or performance settings.

## 🔒 Security Best Practices

1. **Never commit sensitive data**
   - API tokens, keys, or secrets
   - `.tfstate` files (use remote state)

2. **Use least-privilege API tokens**
   - Limit permissions to only what's needed
   - Restrict to specific zones

3. **Enable remote state** (recommended for production)
   ```hcl
   terraform {
     backend "s3" {
       bucket = "your-terraform-state-bucket"
       key    = "taka-cloudflare/terraform.tfstate"
       region = "us-west-2"
     }
   }
   ```

## 📊 Outputs

After applying, you'll get:
- Zone ID
- Zone name
- Name servers
- DNS record IDs

## 🐛 Troubleshooting

### Common Issues

1. **Authentication Error**
   ```
   Error: failed to create Cloudflare client: invalid credentials
   ```
   - Check your `CLOUDFLARE_API_TOKEN` environment variable
   - Verify token permissions

2. **Zone Not Found**
   ```
   Error: could not find zone: taka-cloudflare.win
   ```
   - Ensure the zone exists in your Cloudflare account
   - Check zone name spelling

3. **DNS Record Conflicts**
   ```
   Error: DNS record already exists
   ```
   - Use `terraform import` for existing records
   - Or remove conflicting records manually

### Importing Existing Resources

```bash
# Import existing DNS record
terraform import cloudflare_record.root <zone_id>/<record_id>

# Import zone settings
terraform import cloudflare_zone_settings_override.taka_cloudflare_settings <zone_id>
```

## 📚 Additional Resources

- [Cloudflare Terraform Provider Documentation](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs)
- [Terraform Best Practices](https://www.terraform-best-practices.com/)
- [Cloudflare DNS Documentation](https://developers.cloudflare.com/dns/)

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/amazing-feature`
3. Commit your changes: `git commit -m 'Add amazing feature'`
4. Push to the branch: `git push origin feature/amazing-feature`
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## ⚡ Quick Commands

```bash
# Check Terraform version
terraform version

# Validate configuration
terraform validate

# Format code
terraform fmt

# Show current state
terraform show

# Destroy infrastructure (be careful!)
terraform destroy
```

---

**Note**: Remember to replace the example IP addresses (`192.0.2.1`, `192.0.2.2`) with your actual server IP addresses before applying the configuration.

🌟 **Star this repository** if you find it helpful!
