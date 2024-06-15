terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
    google-beta = {
      source = "hashicorp/google-beta"
    }
  }
  backend "gcs" {
    bucket = "hendry-bq-terraform"
  }
}

provider "google" {
}

provider "google-beta" {
}
