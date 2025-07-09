#!/bin/bash
# Instala Nginx
sudo apt-get update
sudo apt-get install -y nginx

# Habilita el firewall para el puerto 443 (opcional si usas NSG)
sudo ufw allow 'Nginx Full'

# Genera un certificado autofirmado para pruebas (puedes reemplazar por Let's Encrypt)
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout /etc/ssl/private/nginx-selfsigned.key \
  -out /etc/ssl/certs/nginx-selfsigned.crt \
  -subj "/CN=localhost"

sudo bash -c 'cat > /var/www/html/index.html' <<EOF
<html>
  <body>
    <h1>¡Hola Mundo!</h1>
  </body>
</html>

EOF

# Configura Nginx para HTTPS básico
sudo bash -c 'cat > /etc/nginx/sites-available/default' <<EOF
server {
    listen 80 default_server;
    listen [::]:80 default_server;
    server_name _;
    return 301 https://\$host\$request_uri;
}
server {
    listen 443 ssl default_server;
    listen [::]:443 ssl default_server;
    server_name _;
    ssl_certificate /etc/ssl/certs/nginx-selfsigned.crt;
    ssl_certificate_key /etc/ssl/private/nginx-selfsigned.key;
    location / {
        root /var/www/html;
        index index.html index.htm;
    }
}
EOF

sudo nginx -t && sudo systemctl restart nginx
