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
  value = "projects/${var.project_id}/locations/global/workloadIdentityPools/${module.gh_oidc.pool_name}/providers/${module.gh_oidc.provider_name}"
}

output "service_account_email" {
  value = google_service_account.github_action_sa.email
}
