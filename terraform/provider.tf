terraform {
  cloud {
    organization = "toeichust"
    workspaces {
      name = "infrastructure-upstash-qstash-settings-terraform"
    }
  }

  required_providers {
    doppler = {
      source  = "DopplerHQ/doppler"
      version = "1.21.1"
    }
    upstash = {
      source  = "upstash/upstash"
      version = "2.1.0"
    }
  }
}

provider "doppler" {
  doppler_token = var.DOPPLER_TOKEN
}

data "doppler_secrets" "this" {
  project = var.DOPPLER_PROJECT
  config  = var.DOPPLER_CONFIG
}

provider "upstash" {
  email   = data.doppler_secrets.this.map["UPSTASH_EMAIL"]
  api_key = data.doppler_secrets.this.map["UPSTASH_API_KEY"]
}
