# IAM KEY
output "iam_key_access_id" {
  description = "Access key ID"
  value       = aws_iam_access_key.key.id
}

output "iam_key_create_date" {
  description = "Date and time in RFC3339 format that the access key was created"
  value       = aws_iam_access_key.key.create_date
}

output "iam_key_secret" {
  description = "Secret access key"
  value       = aws_iam_access_key.key.secret
}

output "iam_key_status" {
  description = "Access key status"
  value       = aws_iam_access_key.key.status
}

output "iam_key_user" {
  description = "IAM user to associate with this access key"
  value       = aws_iam_access_key.key.user
}

# IAM USER
output "iam_user_arn" {
  description = "Amazon Resource Name (ARN) specifying IAM User Arn"
  value       = aws_iam_user.user.arn
}

output "iam_user_name" {
  description = "The user's name."
  value       = aws_iam_user.user.name
}

# IAM USER POLICY
output "iam_user_policy" {
  description = "JSON Policy Document"
  value       = aws_iam_user_policy.policy.policy
}

output "iam_user_policy_id" {
  description = "The user policy ID, in the form of user_name:user_policy_name"
  value       = aws_iam_user_policy.policy.id
}

output "iam_user_policy_name" {
  description = "The name of the policy (always set)."
  value       = aws_iam_user_policy.policy.name
}