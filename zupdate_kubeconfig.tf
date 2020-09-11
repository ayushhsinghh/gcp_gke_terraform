resource "null_resource" "kubectl_configuration" {
    provisioner "local-exec" {
    command = "gcloud container clusters get-credentials ${var.gke_cluster_name} --region ${var.region} --project ${var.Dev_projectID}"
  }

}