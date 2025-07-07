# Application Gateway
resource "azurerm_application_gateway" "main" {
  name                = "appgw-ejemplo"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 1
  }
  
  identity {
    type = "UserAssigned" # o "SystemAssigned"
    identity_ids = [azurerm_user_assigned_identity.appgw.id] # si usas UserAssigned
  }

  gateway_ip_configuration {
    name      = "gateway-ip-config"
    subnet_id = azurerm_subnet.appgw.id
  }
  frontend_port {
    name = "frontend-port"
    port = 80
  }

  frontend_port {
    name = "frontend-port-443"
    port = 443
  }

  frontend_ip_configuration {
    name                 = "frontend-ip"
    public_ip_address_id = azurerm_public_ip.appgw.id
  }
  backend_address_pool {
    name        = "backend-pool"
    ip_addresses = [azurerm_network_interface.vm.private_ip_address]
  }
  backend_http_settings {
    name                  = "http-settings"
    port                  = 80
    protocol              = "Http"
    cookie_based_affinity = "Disabled"
  }
  http_listener {
    name                           = "http-listener"
    frontend_ip_configuration_name  = "frontend-ip"
    frontend_port_name              = "frontend-port"
    protocol                        = "Http"
  }
  http_listener {
    name                           = "https-listener"
    frontend_ip_configuration_name  = "frontend-ip"
    frontend_port_name              = "frontend-port-443"
    protocol                        = "Https"
    ssl_certificate_name            = "appgw-cert"
  }

  request_routing_rule {
    name                       = "rule1"
    rule_type                  = "Basic"
    http_listener_name         = "http-listener"
    backend_address_pool_name  = "backend-pool"
    backend_http_settings_name = "http-settings"
    priority                   = 100
  }

  request_routing_rule {
    name                       = "https-rule"
    rule_type                  = "Basic"
    http_listener_name         = "https-listener"
    backend_address_pool_name  = "backend-pool"
    backend_http_settings_name = "http-settings"
    priority                   = 200
  }

  ssl_certificate {
    name                = "appgw-cert"
    key_vault_secret_id = azurerm_key_vault_certificate.appgw_cert.secret_id
  }
}