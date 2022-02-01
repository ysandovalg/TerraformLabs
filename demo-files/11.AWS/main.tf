resource "aws_iam_user" "user" {
  name = "carlos"
}

resource "aws_iam_user_group_membership" "group-lab" {
  user = aws_iam_user.user.name

  groups = ["min-labs"]
}

resource "aws_iam_access_key" "lb" {
  user    = aws_iam_user.user.name
  pgp_key = "keybase:carlosechc11"
}

#resource "aws_iam_user_login_profile" "this" {
#  user                    = aws_iam_user.user.name
#  pgp_key                 = "keybase:${aws_iam_user.user.name}"
#  password_length         = 10
#  password_reset_required = false
#}

output "encrypted_secret" {
  value = aws_iam_access_key.lb.encrypted_secret
}

output "user_arn" {
  value = aws_iam_user.user.arn
}
