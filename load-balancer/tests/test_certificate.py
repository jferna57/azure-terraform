import ssl
import socket
from OpenSSL import crypto

def test_show_https_certificate(public_ip):
    """Muestra los datos del certificado HTTPS expuesto por el balanceador"""
    context = ssl._create_unverified_context()
    conn = context.wrap_socket(socket.socket(socket.AF_INET), server_hostname=public_ip)
    conn.connect((public_ip, 443))
    der_cert = conn.getpeercert(True)
    pem_cert = ssl.DER_cert_to_PEM_cert(der_cert)
    conn.close()

    x509 = crypto.load_certificate(crypto.FILETYPE_PEM, pem_cert)
    print("\n--- DATOS DEL CERTIFICADO HTTPS ---")
    print("Sujeto:", dict(x509.get_subject().get_components()))
    print("Emisor:", dict(x509.get_issuer().get_components()))
    print("Número de serie:", x509.get_serial_number())
    print("Versión:", x509.get_version())
    print("Válido desde:", x509.get_notBefore().decode('ascii'))
    print("Válido hasta:", x509.get_notAfter().decode('ascii'))
    print("Algoritmo de firma:", x509.get_signature_algorithm().decode('ascii'))
    print("--- FIN DEL CERTIFICADO ---\n")

    # Puedes añadir asserts si quieres validar algún dato concreto:
    assert x509.get_issuer().CN == "NombreEsperado"

