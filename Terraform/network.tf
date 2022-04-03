# Criação da Rede
resource "azurerm_virtual_network" "vnet-aulainfra" {
  name                = "vnet_aula"
  location            = azurerm_resource_group.rg-aulainfra.location
  resource_group_name = azurerm_resource_group.rg-aulainfra.name
  address_space       = ["10.0.0.0/16"]

  tags = {
    aluno = "Adriana Sumire"
  }
}

# Criação da sub-rede
resource "azurerm_subnet" "sub-aulainfra" {
  name                 = "subnet_aula"
  resource_group_name  = azurerm_resource_group.rg-aulainfra.name # Indica a qual resource pertence
  virtual_network_name = azurerm_virtual_network.vnet-aulainfra.name # Indica a Rede a qual pertence a subnet
  address_prefixes     = ["10.0.1.0/24"]
}

# Criação do IP Público
resource "azurerm_public_ip" "ip-aulainfra" {
  name                = "ipPub_aula"
  resource_group_name = azurerm_resource_group.rg-aulainfra.name
  location            = azurerm_resource_group.rg-aulainfra.location
  allocation_method   = "Static"

  tags = {
    aluno = "Adriana Sumire"
  }
}