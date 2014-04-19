from setuptools import find_packages, setup

# tests = ['nose==1.3.0', 'PyHamcrest==1.8.0', 'mock==1.0.1']
tests = ['PyHamcrest==1.8.0']
setup(
    name='rubysentiments',
    version='0.0.1-SNAPSHOT',
    packages=find_packages('src', exclude=["*.tests", "*.tests.*", "tests.*", "tests"]),
    package_dir={'': 'src'},
    url='',
    license='',
    author='Tomas Drencak',
    author_email='tomas@drencak.com',
    description='',
    install_requires=[
        'psycopg2==2.5.2',
        'sqlalchemy==0.9.4',
        'alembic==0.6.4',
        'docopt==0.6.1',
        'kaptan==0.5.7',
        'flask==0.10.1',
    ],
    extras_require={
        'ipython': 'ipython',
        'test': tests
    },
    entry_points={'console_scripts':[
        'rsmt = rsmt.port.cmd:main',
        ]}
    ,
    tests_require=tests,
    include_package_data=True,
    test_suite='rsmt.test'
)
