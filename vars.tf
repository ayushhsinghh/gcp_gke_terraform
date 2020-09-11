variable "region" {
    type = string
    default = "asia-southeast1"
}
variable "gke_cluster_name" {
    type = string
    default = "my-cluster"
}
variable "gke_np_name" {
    type = string
    default = "my-nodepool"
}
variable "np_machine_type" {
    type = string
    default = "e2-medium"
}
variable "Dev_projectID" {
    type = string
    default = "enduring-badge-289204"
}
variable "prod_projectID" {
    type = string
    default = "production-289204"
}
variable "sql_root_password" {
    type = string
    default = "AlooPyaaz123"
}