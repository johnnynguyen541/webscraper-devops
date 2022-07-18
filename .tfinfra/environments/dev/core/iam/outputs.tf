# OUTPUTS FROM STATE FILE
output "core_iam_profile_name" {
  value = module.iam.iam_instance_profile_name
}

output "core_iam_profile_arn" {
  value = module.iam.iam_role_arn
}

output "prometheus_iam_user_arn" {
  value = module.prometheus.iam_user_name
}

output "prometheus_iam_user_name" {
  value = module.prometheus.iam_user_name
}

output "prometheus_iam_key_access_id" {
  value = module.prometheus.iam_key_access_id
}

output "prometheus_iam_key_secret" {
  value     = module.prometheus.iam_key_secret
  sensitive = true
}

output "prometheus_iam_key_status" {
  value = module.prometheus.iam_key_status
}
