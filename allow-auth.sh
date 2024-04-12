# https://console.cloud.google.com/iam-admin/serviceaccounts?orgonly=true&project=huware-prep&supportedpurview=project
gcloud iam service-accounts add-iam-policy-binding gh-559@huware-prep.iam.gserviceaccount.com \
--project=huware-prep \
--role=roles/iam.workloadIdentityUser \
--member="principalSet://iam.googleapis.com/projects/944742483537/locations/global/workloadIdentityPools/my-pool/attribute.repository/kaihendry/bq-terraform"
