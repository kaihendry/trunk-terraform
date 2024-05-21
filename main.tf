# Create new storage bucket in the US multi-region
# with coldline storage
resource "random_id" "bucket_prefix" {
  byte_length = 8
}

resource "google_storage_bucket" "static" {
  name     = "${random_id.bucket_prefix.hex}-bq-bucket"
  location = "EU"

  uniform_bucket_level_access = true
}
