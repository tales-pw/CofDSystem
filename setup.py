# noinspection PyUnresolvedReferences
import os
import setuptools
from distutils.core import setup

setup(
    name='CofDSystem',
    version=os.environ.get("RELEASE_VERSION", "dev"),
    author='xunto',
    author_email='-',
    py_modules=['CofDSystem'],
    package_dir={'': 'out/python'}
)
