# Criação da placa de rede da máquina
resource "azurerm_network_interface" "nic-aulainfra" {
  name                = "nic_aula"
  location            = azurerm_resource_group.rg-aulainfra.location
  resource_group_name = azurerm_resource_group.rg-aulainfra.name

  ip_configuration {
    name                            = "nic_ip_aula"
    subnet_id                       = azurerm_subnet.sub-aulainfra.id # Relaciona a placa de rede com qual subnet que esta ligada
    private_ip_address_allocation   = "Dynamic"
    public_ip_address_id            = azurerm_public_ip.ip-aulainfra.id # Define a referência do IP publico
    
  }
}

# Relacionando a placa de Rede e o firewall
resource "azurerm_network_interface_security_group_association" "nic-nsg-aulainfra" {
  network_interface_id      = azurerm_network_interface.nic-aulainfra.id
  network_security_group_id = azurerm_network_security_group.nsg-aulainfra.id
}

# Busca o IP Publico e armazena numa variavel
data "azurerm_public_ip" "ip-aula"{
    name = azurerm_public_ip.ip-aulainfra.name
    resource_group_name = azurerm_resource_group.rg-aulainfra.name
}

resource "azurerm_linux_virtual_machine" "vm-aulainfra" {
  name                  = "vm-Apache"
  location              = azurerm_resource_group.rg-aulainfra.location
  resource_group_name   = azurerm_resource_group.rg-aulainfra.name
  size                  = "Standard_L8s_v2" # Relacionado ao tipo da maquina, que tem as caracteristicas da maquina (quanto de CPU, disco, memória,...)
  network_interface_ids = [azurerm_network_interface.nic-aulainfra.id]  

  admin_username = var.user
  admin_password = var.password
  disable_password_authentication = "false"

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

# Cria um disco no storage conforme o modelo
  os_disk {
    name              = "myDisk"
    caching           = "ReadWrite"
    storage_account_type = "Premium_LRS" 
  }

# Aponta para o storage que foi criado, para saber onde o disco devera ser criado
  boot_diagnostics {
      storage_account_uri = azurerm_storage_account.storageaulainfra.primary_blob_endpoint
  }
  
  tags = {
    environment = "staging"
  }
}

