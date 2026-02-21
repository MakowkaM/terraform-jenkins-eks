terraform {
  backend "s3" {
    bucket = "cicd-terraform-eks-1213213"
    key = "eks/terraform.tfstate"
    region = "us-east-1"
  }
}