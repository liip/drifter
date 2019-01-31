import pytest


@pytest.mark.parametrize('os', [
    'drifter/jessie64-base', 'drifter/stretch64-base', 'drifter/bionic64-base', 'drifter/trusty64-base'
])
@pytest.mark.parametrize('php_version', ['7.0', '7.1', '7.2'])
def test_php_install(box, php_version, os):
    box.provision(roles=['php-fpm'], parameters={'php_version': php_version}, os=os)

    assert php_version in box.execute('php --version')
