module "ec2" {
  source        = "../modules"
  region        = "ap-east-1"
  instance_type = "t3.micro"
  ami           = "ami-021e95d920fa4c6be"
  instance_name = "MyTerraformInstance"
}
