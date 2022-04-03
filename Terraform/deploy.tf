resource "null_resource" "upload-app" {
  connection {
    type = "ssh"
    host = data.azurerm_public_ip.ip-aula.ip_address
    user = var.user
    password = var.password
  }

  provisioner "file" {
    source = "app"
    destination = "/home/adminuser"
  }

  depends_on = [
    azurerm_linux_virtual_machine.vm-aulainfra
  ]
}

resource "null_resource" "install-apache" {
  connection {
    type = "ssh"
    host = data.azurerm_public_ip.ip-aula.ip_address
    user = var.user
    password = var.password
  }

  provisioner "remote-exec" {
    inline = [
      "chmod 755 /home/adminuser",
      "chmod 777 /home/adminuser/app/install_apache_up.sh",
      "sudo sh /home/adminuser/app/install_apache_up.sh",
    ]
  }

  depends_on = [
    azurerm_linux_virtual_machine.vm-aulainfra
  ]
}