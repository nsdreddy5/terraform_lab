variable "resource_groups" {
  description = "The name of the module demo resource group in which the resources will be created"
  type        = list(string)

}

variable "location" {
  description = "The location where module demo resource group will be created"
  type        = string
  default     = "eastus"
}
variable "tags" {
  description = "A map of the tags to use for the module demo resources that are deployed"
  type        = map(string)
  default = {
    environment = "Example"
    name        = "diwakar"
    /* Owner = "vcloud-lab.com" */
  }
}