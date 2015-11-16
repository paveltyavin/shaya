#!/usr/bin/python

from fabric.api import run
from fabric.api import task
from fabric.state import env


@task
def test():
    print("Executing on %s as %s" % (env.host, env.user))
    run('uname -s')


@task
def build_static():
    run(
        'cd /home/vinograd19/shaya/src/frontend/;' +
        'npm install;' +
        'gulp build;' +
        ''
    )


@task
def collectstatic():
    run('/home/vinograd19/shaya/env/bin/python /home/vinograd19/shaya/src/manage.py collectstatic --noinput;')


@task
def migrate():
    run('/home/vinograd19/shaya/env/bin/python /home/vinograd19/shaya/src/manage.py migrate --noinput;')


@task
def update_followers():
    run('/home/vinograd19/shaya/env/bin/python /home/vinograd19/shaya/src/manage.py update_followers;')


@task
def restart():
    run('sudo supervisorctl restart shaya;')


@task
def pull():
    run(
        'cd /home/vinograd19/shaya/src/;' +
        'git pull;' +
        ''
    )


@task
def pip_install():
    run(
        'source /home/vinograd19/shaya/env/bin/activate;' +
        'pip install -r /home/vinograd19/shaya/src/requirements.txt' +
        ''
    )


@task
def update():
    pull()
    pip_install()
    build_static()
    collectstatic()
    migrate()
    restart()
