terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }
  required_version = ">= 1.0"
}

# Configure the Cloudflare Provider
provider "cloudflare" {
  # API token should be set via CLOUDFLARE_API_TOKEN environment variable
}

# Data source to get the zone ID
data "cloudflare_zone" "taka_cloudflare" {
  name = "taka-cloudflare.win"
}

# Root A record - replace with actual IP
resource "cloudflare_record" "root" {
  zone_id = data.cloudflare_zone.taka_cloudflare.id
  name    = "@"
  value   = "192.0.2.1"  # Replace with your actual IP
  type    = "A"
  ttl     = 1  # Automatic TTL
  proxied = true
  comment = "Root domain A record"
}

# WWW CNAME record
resource "cloudflare_record" "www" {
  zone_id = data.cloudflare_zone.taka_cloudflare.id
  name    = "www"
  value   = "taka-cloudflare.win"
  type    = "CNAME"
  ttl     = 1  # Automatic TTL
  proxied = true
  comment = "WWW CNAME record"
}

# Example subdomain A record
resource "cloudflare_record" "api" {
  zone_id = data.cloudflare_zone.taka_cloudflare.id
  name    = "api"
  value   = "192.0.2.2"  # Replace with your actual IP
  type    = "A"
  ttl     = 1  # Automatic TTL
  proxied = true
  comment = "API subdomain A record"
}

# Example MX record
resource "cloudflare_record" "mx" {
  zone_id  = data.cloudflare_zone.taka_cloudflare.id
  name     = "@"
  value    = "mail.taka-cloudflare.win"
  type     = "MX"
  priority = 10
  ttl      = 3600
  proxied  = false
  comment  = "Mail server MX record"
}

# TXT record for domain verification
resource "cloudflare_record" "txt_verification" {
  zone_id = data.cloudflare_zone.taka_cloudflare.id
  name    = "@"
  value   = "v=spf1 include:_spf.google.com ~all"
  type    = "TXT"
  ttl     = 3600
  proxied = false
  comment = "SPF record for email"
}

# Zone settings
resource "cloudflare_zone_settings_override" "taka_cloudflare_settings" {
  zone_id = data.cloudflare_zone.taka_cloudflare.id
  settings {
    ssl                      = "full"
    always_use_https        = "on"
    min_tls_version         = "1.2"
    automatic_https_rewrites = "on"
    security_level          = "medium"
    browser_cache_ttl       = 14400
    browser_check           = "on"
    challenge_ttl           = 1800
    development_mode        = "off"
    email_obfuscation       = "on"
    hotlink_protection      = "off"
    ip_geolocation          = "on"
    ipv6                    = "on"
    server_side_exclude     = "on"
    brotli                  = "on"
    early_hints             = "on"
    h2_prioritization       = "on"
    http2                   = "on"
    http3                   = "on"
    zero_rtt                = "on"
    image_resizing          = "on"
    polish                  = "lossless"
    webp                    = "on"
  }
}
