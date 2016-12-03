def test_mysql_role_installs_mysql(box):
    box.provision(roles=['mysql'], parameters={'mysql_version': '5.7'})

    assert '5.7' in box.execute('mysql --version')
