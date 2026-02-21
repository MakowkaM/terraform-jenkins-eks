terraform {
  backend "s3" {
    bucket = "cicd-terraform-eks-1213213"
    key    = "jenkins/terraform.tfstate"
    region = "us-east-1"
  }
}