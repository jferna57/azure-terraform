resource "azurerm_key_vault_certificate" "appgw_cert" {
  name         = "appgw-cert"
  key_vault_id = azurerm_key_vault.main.id

  certificate_policy {
    issuer_parameters {
      name = "Self"
    }
    key_properties {
      exportable = true
      key_size   = 2048
      key_type   = "RSA"
      reuse_key  = false
    }
    secret_properties {
      content_type = "application/x-pkcs12"
    }
    x509_certificate_properties {
      subject            = "CN=appgw-ejemplo.westeurope.cloudapp.azure.com"
      validity_in_months = 12
      key_usage = [
        "digitalSignature",
        "keyEncipherment"
      ]
      extended_key_usage = [
        "1.3.6.1.5.5.7.3.1" # OID para serverAuth
      ]
    }
    lifetime_action {
      action {
        action_type = "AutoRenew"
      }
      trigger {
        days_before_expiry = 30
      }
    }
  }
}