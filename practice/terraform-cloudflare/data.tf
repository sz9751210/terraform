data "terraform_remote_state" "global_ip" {
  backend = "gcs"
  config = {
    bucket = "alan-test-terraform"
    prefix = "gcp/global-ip"
  }
}
