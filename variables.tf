variable "zone_name" {
  description = "The DNS zone name"
  type        = string
  default     = "taka-cloudflare.win"
}

variable "root_ip" {
  description = "IP address for the root domain"
  type        = string
  default     = "192.0.2.1"  # Replace with actual IP
}

variable "api_ip" {
  description = "IP address for the API subdomain"
  type        = string
  default     = "192.0.2.2"  # Replace with actual IP
}

variable "mail_server" {
  description = "Mail server hostname"
  type        = string
  default     = "mail.taka-cloudflare.win"
}

variable "spf_record" {
  description = "SPF record value"
  type        = string
  default     = "v=spf1 include:_spf.google.com ~all"
}
