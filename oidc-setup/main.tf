terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
  }
}

variable "project_id" {
  type    = string
  default = "stgtest-424513"
}

provider "google" {
  project = var.project_id
}

resource "google_project_service" "iam" {
  project = var.project_id
  service = "iam.googleapis.com"
}

resource "google_project_service" "cloudresourcemanager" {
  project = var.project_id
  service = "cloudresourcemanager.googleapis.com"
}

resource "google_project_service" "serviceusage" {
  project = var.project_id
  service = "serviceusage.googleapis.com"
}

resource "google_project_service" "storage" {
  project = var.project_id
  service = "storage.googleapis.com"
}

resource "google_project_service" "iamcredentials" {
  project = var.project_id
  service = "iamcredentials.googleapis.com"
}

resource "google_project_service" "sts" {
  project = var.project_id
  service = "sts.googleapis.com"
}

resource "google_service_account" "github_action_sa" {
  account_id   = "github-action"
  display_name = "GitHub Action Service Account"
}

resource "google_project_iam_member" "github_action_owner" {
  project = var.project_id
  role    = "roles/owner"
  member  = "serviceAccount:${google_service_account.github_action_sa.email}"
}

module "gh_oidc" {
  source      = "terraform-google-modules/github-actions-runners/google//modules/gh-oidc"
  project_id  = var.project_id
  pool_id     = "gh-actions-pool"
  provider_id = "gh-actions-provider"
  sa_mapping = {
    "kaihendry-bqtest-github-action" = {
      sa_name   = "projects/${var.project_id}/serviceAccounts/${google_service_account.github_action_sa.email}"
      attribute = "attribute.repository/kaihendry/bq-terraform"
    }
  }
}

output "workload_identity_provider" {
  value = module.gh_oidc.provider_name
}

output "service_account_email" {
  value = google_service_account.github_action_sa.email
}
