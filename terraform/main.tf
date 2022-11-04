variable "project_id" {
  type        = string
  description = ""
}

terraform {
  required_providers {
    scaleway = {
      source = "scaleway/scaleway"
    }
  }
  required_version = ">= 0.13"
  backend "local" {
    path = "state"
  }
}

provider "scaleway" {
  zone   = "fr-par-1"
  region = "fr-par"
}

# https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/container
resource "scaleway_container_namespace" "main" {
  project_id  = var.project_id
  region      = "fr-par"
  name        = "cors-demo-namespace"
}

resource "scaleway_container" "server_container" {
  name           = "server-container"
  description    = "Container for the server"
  namespace_id   = scaleway_container_namespace.main.id
  registry_image = "rg.fr-par.scw.cloud/cors-demo/server:0.0.1"
  port           = 80
  min_scale      = 2
  max_scale      = 2
  privacy        = "private"
  deploy         = true

  timeouts {
    create = "10m"
    update = "10m"
  }
}

resource "scaleway_container" "gateway_container" {
  name           = "gateway-container"
  description    = "Container for the gateway"
  namespace_id   = scaleway_container_namespace.main.id
  registry_image = "rg.fr-par.scw.cloud/cors-demo/gateway:0.0.1"
  port           = 80
  min_scale      = 1
  max_scale      = 1
  privacy        = "public"
  deploy         = true

  environment_variables = {
    "SERVER_CONTAINER_URL" = scaleway_container.server_container.domain_name
  }

  timeouts {
    create = "10m"
    update = "10m"
  }
}

# https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/container_token
resource scaleway_container_token namespace {
  namespace_id = scaleway_container_namespace.main.id
  expires_at = "2023-03-03T12:00:00+02:00"
}

resource scaleway_container_token container {
  container_id = scaleway_container.server_container.id
}

