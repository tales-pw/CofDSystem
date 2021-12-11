import os
import sys
from setuptools import setup, find_packages
from structure import generate_modules

sys.path.append("src")

generate_modules("src")

setup(
    name="CofDSystem",
    version=os.environ["RELEASE_VERSION"],
    author="xunto",
    author_email="xunto.orlov@gmail.com",
    packages=find_packages(),
)
