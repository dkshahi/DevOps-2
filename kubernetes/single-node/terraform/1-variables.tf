# Specify Azure CLI as the authentication method
provider "azurerm" {
  version = "=1.21.0"
  subscription_id = "${local.subscription}"
}

variable "purpose" {
  description = "What is this infrastructure going to be used for, e.g. Testing or Live Infrastructure"
}

variable "project" {
  description = "Project or name for the virtual machine, e.g. Kubernetes or ELK-Cluster"
}

variable "type" {
  type = "list"

  description = "Specific types of VM, e.g. Master/Slave-1/Slave-2 or Logstash/Kibana"
}

variable "environment" {
  description = "Environment that the resource will be stored in, e.g. PPT"
}

variable "expiry_date" {
  description = "When can this resource be deleted? Write \"Permanent\" for long-lasting resources"
}

locals {

  subscriptions = {
    DT    = "xxx"
    PPT   = "xxx"
    PR    = "xxx"
  }

  subscription = "${lookup(local.subscriptions, var.environment)}"

  tags = {
    Project = "${var.project}"
    Purpose = "${var.purpose}"
    Expiry_Date = "${var.expiry_date}"
    Environment_Name = "${upper(var.environment)}"
    Resource_Owner = "Duncan Wraight"
  }

  count_of_types = "${length(var.type)}"

  prefix_group      = "Org-${var.project}-${var.environment}"
  prefix_specific   = "Org-${var.project}-##TYPE##-${var.environment}"
  prefix_alpha      = "Org${format("%.6s", var.project)}##TYPE##${var.environment}"
  prefix_lower      = "${lower(local.prefix_alpha)}"
  name_sacc         = "${lower(format("%.6s", var.project))}${lower(var.environment)}sa" 
}
