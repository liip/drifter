def test_base_box_has_git(box):
    box.provision(roles=[], parameters={})

    assert 'git version ' in box.execute('git --version')
