from contextlib import contextmanager
import logging
import os
import shutil
import string
import subprocess
import time

import pytest
import yaml

BASE_DIR = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))
TESTS_DIR = os.path.abspath(os.path.dirname(__file__))

logging.basicConfig(level=logging.DEBUG)
logger = logging.getLogger(__name__)


@contextmanager
def log_time(description):
    start_time = time.time()
    yield
    end_time = time.time()

    logger.debug("%s took %s seconds", description, end_time - start_time)


class Box:
    def __init__(self, base_dir):
        self.base_dir = base_dir
        logger.debug("Creating box environment in %s", self.base_dir)
        self._create_environment()
        self._base_lxc_id = None

    def _run(self, cmd, read=True):
        env = os.environ.copy()
        env['VAGRANT_CWD'] = self.base_dir
        env['VIRTUALIZATION_PARAMETERS_FILE'] = os.path.join(self.base_dir, 'parameters.yml')

        with log_time(cmd):
            logger.debug("Executing %s", cmd)
            proc = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE, env=env)
            proc.wait()

        if read:
            return proc.stdout.read().decode('utf-8')

    def get_lxc_id(self):
        with open(os.path.join(self.base_dir, '.vagrant/machines/default/lxc/id')) as f:
            id = f.read()

        return id

    def set_lxc_id(self, id):
        with open(os.path.join(self.base_dir, '.vagrant/machines/default/lxc/id'), 'w') as f:
            f.write(id)

    def get_ip(self):
        return self._run(['sudo', 'lxc-info', '-iH', '-n', self.get_lxc_id()], read=True)

    def _template(self, src, dest, mapping):
        with open(src) as f:
            raw_file = f.read()

        raw_file_template = string.Template(raw_file)
        templated_file = raw_file_template.substitute(**mapping)

        with open(dest, 'w') as f:
            f.write(templated_file)

    def _create_environment(self):
        self._template(
            os.path.join(TESTS_DIR, 'data/ansible.cfg'),
            os.path.join(self.base_dir, 'ansible.cfg'),
            {'roles_path': os.path.join(BASE_DIR, 'provisioning', 'roles')}
        )

        shutil.copy(
            os.path.join(BASE_DIR, 'parameters.yml.dist'),
            os.path.join(self.base_dir, 'parameters.yml')
        )

        shutil.copy(
            os.path.join(BASE_DIR, 'provisioning', 'playbook.yml.dist'),
            os.path.join(self.base_dir, 'playbook.yml')
        )

        shutil.copytree(
            os.path.join(BASE_DIR, 'provisioning', 'roles'),
            os.path.join(self.base_dir, 'roles')
        )

        with open(os.path.join(BASE_DIR, 'Vagrantfile.dist')) as f:
            lines = f.readlines()
        lines[-1] = "load '{}'".format(os.path.join(BASE_DIR, 'Vagrantfile'))

        with open(os.path.join(self.base_dir, 'Vagrantfile'), 'w') as f:
            f.write(''.join(lines))

    def up(self, provision=False):
        if provision:
            self._run(['vagrant', 'up', '--provision'], read=False)
        else:
            # When not provisioning it's better to just use `lxc-start` which is much faster than vagrant
            self._run(['sudo', 'lxc-start', '-n', self.get_lxc_id()], read=False)

    def halt(self):
        self._run(['sudo', 'lxc-stop', '-k', '-n', self.get_lxc_id()], read=False)

    def destroy(self):
        self._run(['vagrant', 'destroy', '-f'])

    def execute(self, cmd):
        return self._run(['sudo', 'lxc-attach', '-n', self.get_lxc_id(), '--'] + cmd.split(), read=True)

    def provision(self, roles, parameters=None):
        self._run(['sudo', 'lxc-copy', '-s', '-B', 'overlayfs', '-n', self.get_lxc_id(), '-N', self.get_lxc_id() + '_copy'])
        self._base_lxc_id = self.get_lxc_id()
        self.set_lxc_id(self.get_lxc_id() + '_copy')

        with open(os.path.join(BASE_DIR, 'provisioning', 'playbook.yml.dist')) as f:
            playbook = yaml.load(f.read())

        for role in roles:
            playbook[0]['roles'].append({'role': role})

        with open(os.path.join(self.base_dir, 'playbook.yml'), 'w') as f:
            f.write(yaml.dump(playbook))

        with open(os.path.join(self.base_dir, 'parameters.yml')) as f:
            parameters_yml = yaml.load(f.read())

        parameters_yml['playbook'] = 'playbook.yml'
        parameters_yml['forwarded_ports'] = []
        for param, value in parameters.items():
            parameters_yml[param] = value

        with open(os.path.join(self.base_dir, 'parameters.yml'), 'w') as f:
            f.write(yaml.dump(parameters_yml))

        self.up()
        self._run(['vagrant', 'provision'])

    def delete_copy(self):
        self._run(['sudo', 'lxc-stop', '-k', '-n', self.get_lxc_id()])
        self._run(['sudo', 'lxc-destroy', '-n', self.get_lxc_id()])
        self.set_lxc_id(self._base_lxc_id)


class BoxFactory:
    def __init__(self, tmpdir_factory):
        self.tmpdir_factory = tmpdir_factory
        self.boxes = {}

    def get_box(self, os):
        os = os.replace('/', '-')

        if os not in self.boxes:
            self.boxes[os] = Box(str(self.tmpdir_factory.mkdir(os)))
            self.boxes[os].up(provision=True)
            # Base box must be stopped to be copied
            self.boxes[os].halt()

        return self.boxes[os]

    def destroy(self):
        for box in self.boxes.values():
            box.destroy()


class LazyBox:
    def __init__(self, box_factory):
        self.box_factory = box_factory
        self.box = None

    def provision(self, roles, parameters, os='drifter/stretch64-base'):
        self.box = self.box_factory.get_box(os)
        self.box.provision(roles=roles, parameters=parameters)
        return self.box

    def up(self):
        return self.box.up()

    def destroy(self):
        return self.box.destroy()

    def execute(self, cmd):
        return self.box.execute(cmd)

    def delete_copy(self):
        return self.box.delete_copy()


@pytest.fixture(scope='session')
def box_factory(tmpdir_factory):
    box_factory = BoxFactory(tmpdir_factory.mktemp('drifter'))
    yield box_factory
    box_factory.destroy()


@pytest.fixture()
def box(box_factory):
    vagrant_box = LazyBox(box_factory)
    yield vagrant_box
    vagrant_box.delete_copy()
