output "zone_id" {
  description = "The zone ID"
  value       = data.cloudflare_zone.taka_cloudflare.id
}

output "zone_name" {
  description = "The zone name"
  value       = data.cloudflare_zone.taka_cloudflare.name
}

output "name_servers" {
  description = "The zone name servers"
  value       = data.cloudflare_zone.taka_cloudflare.name_servers
}

output "root_record_id" {
  description = "The root A record ID"
  value       = cloudflare_record.root.id
}

output "www_record_id" {
  description = "The WWW CNAME record ID"
  value       = cloudflare_record.www.id
}

output "api_record_id" {
  description = "The API A record ID"
  value       = cloudflare_record.api.id
}
