terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.60.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = ">= 4.60.0"
    }
  }
  backend "gcs" {
    bucket = "hendry-bq-terraform"
    prefix = var.stage_prefix
  }
}

provider "google" {
}

provider "google-beta" {
}

variable "stage" {
  type    = string
  default = "dev"
}

locals {
  stage_prefix = var.stage
}
