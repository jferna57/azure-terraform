resource "azurerm_lb_backend_address_pool" "main" {
  name                = "backend-pool"
  loadbalancer_id     = azurerm_lb.main.id
}

resource "azurerm_lb_probe" "http" {
  name                = "http-probe"
  loadbalancer_id     = azurerm_lb.main.id
  protocol            = "Http"
  port                = 80
  request_path        = "/"
}

resource "azurerm_lb_probe" "https" {
  name                = "https-probe"
  loadbalancer_id     = azurerm_lb.main.id
  protocol            = "Tcp"
  port                = 443
}
