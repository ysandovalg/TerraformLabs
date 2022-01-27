resource "local_file" "tempfile" {
  filename          = "tempfile"
  sensitive_content = "password: S3cr3tP@ssw0rd"
  count             = 3
}
