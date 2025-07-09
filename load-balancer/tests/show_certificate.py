import ssl
import socket
from OpenSSL import crypto
import pprint

def get_certificate(host, port=443):
    context = ssl._create_unverified_context()
    conn = context.wrap_socket(socket.socket(socket.AF_INET), server_hostname=host)
    conn.connect((host, port))
    der_cert = conn.getpeercert(True)
    pem_cert = ssl.DER_cert_to_PEM_cert(der_cert)
    conn.close()
    return pem_cert

def print_certificate_details(pem_cert):
    x509 = crypto.load_certificate(crypto.FILETYPE_PEM, pem_cert)
    details = {
        'Sujeto': dict(x509.get_subject().get_components()),
        'Emisor': dict(x509.get_issuer().get_components()),
        'Número de serie': x509.get_serial_number(),
        'Versión': x509.get_version(),
        'Válido desde': x509.get_notBefore().decode('ascii'),
        'Válido hasta': x509.get_notAfter().decode('ascii'),
        'Algoritmo de firma': x509.get_signature_algorithm().decode('ascii'),
    }
    pprint.pprint(details)

if __name__ == "__main__":
    # Sustituye por la IP pública de tu balanceador
    host = "20.160.207.68"
    pem_cert = get_certificate(host)
    print_certificate_details(pem_cert)
