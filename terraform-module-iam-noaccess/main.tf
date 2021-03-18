# the iam role mandates an assume role policy, closest to wildcard used
# https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_elements_principal.html
data "aws_iam_policy_document" "no-access-assume-role-policy" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Deny"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
  }
}

resource "aws_iam_role" "no-access" {
  count              = var.enabled ? 1 : 0
  name               = join("-", [var.stage, "no-access"])
  tags               = var.tags
  assume_role_policy = data.aws_iam_policy_document.no-access-assume-role-policy.json
}

# https://www.terraform.io/docs/providers/aws/r/iam_group.html
resource "aws_iam_group" "no-access" {
  count = var.enabled ? 1 : 0
  name  = join("-", [var.stage, "no-access"])
}

# by default, all requests are denied, but anyways
# https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_examples.html
resource "aws_iam_policy" "no-access" {
  count       = var.enabled ? 1 : 0
  name        = join("-", [var.stage, "no-access"])
  path        = var.path
  description = "No access to resources."

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "*"
        ]
        Effect   = "Deny"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_group_policy_attachment" "no-access" {
  count      = var.enabled ? 1 : 0
  group      = aws_iam_group.no-access[count.index].name
  policy_arn = aws_iam_policy.no-access[count.index].arn
}

resource "aws_iam_user" "no-access" {
  for_each             = toset(var.usernames)
  name                 = join("-", [var.stage, each.key])
  path                 = var.path
  permissions_boundary = var.permissions_boundary
  force_destroy        = var.force_destroy
  tags                 = var.tags
}

resource "aws_iam_user_group_membership" "no-access" {
  for_each = toset(var.usernames)
  user     = aws_iam_user.no-access[each.key].name
  groups = [
    aws_iam_group.no-access[0].name
  ]
}
