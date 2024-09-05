output "load_balancer_dns" {
  description = "The DNS of the load balancer"
  value       = aws_lb.app_lb.dns_name
}

output "db_endpoint" {
  description = "RDS Database endpoint"
  value       = aws_db_instance.app_db.endpoint
}
