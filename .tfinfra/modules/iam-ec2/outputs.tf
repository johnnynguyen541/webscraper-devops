# IAM INSTANCE PROFILE
output "iam_instance_profile_arn" {
  description = "Amazon Resource Name (ARN) specifying instance profile"
  value       = aws_iam_instance_profile.instance_profile.arn
}

output "iam_instance_profile_date" {
  description = "Creation date of the instance profile"
  value       = aws_iam_instance_profile.instance_profile.create_date
}

output "iam_instance_profile_id" {
  description = "Instance Profile ID"
  value       = aws_iam_instance_profile.instance_profile.id
}

output "iam_instance_profile_name" {
  description = "Name of Instance Profile"
  value       = aws_iam_instance_profile.instance_profile.name
}

output "iam_instance_profile_tags" {
  description = "Map of tags assigned to the resource"
  value       = aws_iam_instance_profile.instance_profile.tags_all
}

output "iam_instance_profile_uid" {
  description = "Unique ID assigned by AWS"
  value       = aws_iam_instance_profile.instance_profile.unique_id
}

# IAM ROLE
output "iam_role_arn" {
  description = "Amazon Resource Name (ARN) specifying the role"
  value       = aws_iam_role.role.arn
}

output "iam_role_assumed_role_policy" {
  description = "Assumed Role Policy of Role"
  value       = aws_iam_role.role.assume_role_policy
}

output "iam_role_date" {
  description = "Creation Date of the Role"
  value       = aws_iam_role.role.create_date
}

output "iam_role_id" {
  description = "Name of the Role"
  value       = aws_iam_role.role.id
}

output "iam_role_name" {
  description = "Name of the Role"
  value       = aws_iam_role.role.name
}

output "iam_role_tags" {
  description = "Map of tags assigned to the resource"
  value       = aws_iam_role.role.tags_all
}

output "iam_role_uid" {
  description = "Unique ID assigned by AWS"
  value       = aws_iam_role.role.unique_id
}

# IAM ROLE POLICY
output "iam_role_policy_id" {
  description = "The role policy ID, in the form of role_name:role_policy_name"
  value       = aws_iam_role_policy.role_policy.id
}

output "iam_role_policy_name" {
  description = "The name of the policy"
  value       = aws_iam_role_policy.role_policy.name
}

output "iam_role_policy_policy" {
  description = "The policy document attached to the role"
  value       = aws_iam_role_policy.role_policy.policy
}

output "iam_role_policy_role" {
  description = "The name of the role associated with the policy"
  value       = aws_iam_role_policy.role_policy.role
}
