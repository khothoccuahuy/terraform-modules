terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.16.0"
    }
    null = {
      source = "hashicorp/null"
    }
  }
  required_version = ">= 1.1.9"
}
