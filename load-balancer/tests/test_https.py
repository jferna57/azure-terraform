import requests
import urllib3


def test_https_accessible(public_ip):
    url = f"https://{public_ip}"
    # Suprimir el warning de certificado autofirmado en pruebas
    urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)
    response = requests.get(url, verify=False, timeout=10)
    assert response.status_code == 200
