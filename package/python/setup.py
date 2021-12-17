import os
import sys
from setuptools import setup, find_packages
from structure import generate_modules

SRC_DIR = "src"

sys.path.append(SRC_DIR)

generate_modules("cofdsystem.haxe_build", SRC_DIR)

setup(
    name="CofDSystem",
    version=os.environ["RELEASE_VERSION"],
    author="xunto",
    author_email="xunto.orlov@gmail.com",
    packages=find_packages(SRC_DIR),
    package_dir={"": SRC_DIR}
)
