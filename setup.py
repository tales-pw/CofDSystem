import os
import setuptools
from distutils.core import setup

setup(
    name='CofDSystem',
    version=os.environ["RELEASE_VERSION"],
    author='xunto',
    author_email='-',
    py_modules=['CofDSystem'],
    package_dir={'': 'out/python'}
)
