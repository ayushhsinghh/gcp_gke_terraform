provider "google" {
  credentials = file("GCP_Developer.json")  //Download JSON file from IAM > Service Accounts
  //credentials = file("GCP_Production.json")
  project     = "enduring-badge-289204" //Project ID
  region      = "asia-southeast1" //singapore
}

provider "google" {
  alias  = "for-production"
  //credentials = file("GCP_Developer.json")  //Download JSON file from IAM > Service Accounts
  credentials = file("GCP_Production.json")
  project     = "production-289204"  //Project ID
  region      = "asia-southeast1" //singapore
}
