output "no-access-assume-role-policy" {
  description = "The assume role policy"
  value       = data.aws_iam_policy_document.no-access-assume-role-policy
}

output "no-access-iam-policy" {
  description = "The role policy"
  value       = aws_iam_policy.no-access[0].policy
}
