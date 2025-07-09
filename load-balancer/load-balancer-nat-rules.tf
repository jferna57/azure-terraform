resource "azurerm_lb_nat_rule" "ssh_nat" {
  name                           = "ssh-nat-rule"
  resource_group_name            = azurerm_resource_group.main.name
  loadbalancer_id                = azurerm_lb.main.id
  protocol                       = "Tcp"
  frontend_port                  = 22
  backend_port                   = 22
  frontend_ip_configuration_name = azurerm_lb.main.frontend_ip_configuration[0].name
}

resource "azurerm_network_interface_nat_rule_association" "ssh_nat_assoc" {
  network_interface_id  = azurerm_network_interface.main.id
  ip_configuration_name = azurerm_network_interface.main.ip_configuration[0].name
  nat_rule_id           = azurerm_lb_nat_rule.ssh_nat.id
}
