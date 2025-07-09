def pytest_addoption(parser):
    parser.addoption("--public-ip", action="store", help="IP pública del Load Balancer")

import pytest

@pytest.fixture
def public_ip(request):
    return request.config.getoption("--public-ip")
