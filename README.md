# Trunk based development with Terraform

[Blog post](https://dabase.com/blog/2024/github-action-trunk/)

Requires Github enterprise or a public repo for the environments to work.

Idea is you setup a central bucket for tfstate, in this example `hendry-bq-terraform`.

You create workload identity and service accounts in oidc-setup/ and use those outputs to configure https://github.com/kaihendry/bq-terraform/settings/environments

You allow the service account write access to `hendry-bq-terraform` bucket to save default.tfstate in a prefix, e.g.

    gsutil iam ch serviceAccount:github-action@stgtest-424513.iam.gserviceaccount.com:roles/storage.objectAdmin gs://hendry-bq-terraform
    gsutil ls -r gs://hendry-bq-terraform
    gs://hendry-bq-terraform/dev/:
    gs://hendry-bq-terraform/dev/default.tfstate

    gs://hendry-bq-terraform/stg/:
    gs://hendry-bq-terraform/stg/default.tfstate

