import os
import setuptools
from distutils.core import setup

from structure import generate_modules

generate_modules()

setup(
    name='CofDSystem',
    version=os.environ["RELEASE_VERSION"],
    author='xunto',
    author_email='-',
)
