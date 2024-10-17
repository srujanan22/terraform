resource "local_file" "res6" {
  filename = "abc"
  content  = "this is res 6"
  lifecycle {
    create_before_destroy = true
  }
}
resource "local_file" "res7" {
  filename = "bad"
  content  = "this is res 7"
  lifecycle {
    prevent_destroy = true
  }
}
