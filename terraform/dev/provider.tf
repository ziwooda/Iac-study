terraform {
  required_providers {
    aws = {
      version = ">= 2.7.0"
      source = "hashicorp/aws"
    }
    serverscom = {
      source = "serverscom/serverscom"
      version = "0.3.0"
    }
  }
}

provider "aws" {
  region = "ap-northeast-2"
}