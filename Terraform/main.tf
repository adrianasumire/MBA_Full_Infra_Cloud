terraform{
    required_version = ">= 0.13"

    required_providers {
        azurerm = {
            source = "hashicorp/azurerm"
            version = " >= 2.26"
        }

    }
}

provider "azurerm" {
    features {
      
    }
  
}

resource "azurerm_resource_group" "rg-aulainfra" {  # Nome que é usado no arquivo
  name     = "AulaInfraCloudTerra" # Nome que aparece na Azure
  location = "centralus"
}