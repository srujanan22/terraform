variable "f1" {
  type = string
}

resource "random_string" "random" {
  length           = 8
  special          = true
  override_special = "/@£$"
}

output "random_string_value" {
  value = var.f1
}

