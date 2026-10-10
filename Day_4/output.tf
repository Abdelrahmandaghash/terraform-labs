output "public_alb_dns" {
  value = module.lb.public_alb_dns
}

output "internal_alb_dns" {
  value = module.lb.internal_alb_dns
}