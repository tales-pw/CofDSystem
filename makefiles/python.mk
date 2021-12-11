PYPI_REPO_DIR="${ROOT}/PyPI"

PYTHON_PACKAGE_ROOT=${ROOT}/out/python
PYTHON_PACKAGE_TEMPLATE=${ROOT}/package/python/*

pypi_prepare_package: build_python
	cp -r ${PYTHON_PACKAGE_TEMPLATE} ${PYTHON_PACKAGE_ROOT}

pypi_setup_deps:
	python3 -m pip install wheel

.ONESHELL:
pypi_build_package: pypi_prepare_package pypi_setup_deps
	cd ${PYTHON_PACKAGE_ROOT}
	python3 setup.py bdist_wheel

pypi_cleanup_repo:
	rm -rf $(PYPI_REPO_DIR)

.ONESHELL:
pypi_publish: pypi_cleanup_repo pypi_build_package
	cd ${PYTHON_PACKAGE_ROOT}

	git clone git@github.com:tales-pw/PyPI $(PYPI_REPO_DIR)

	cd $(PYPI_REPO_DIR)

	# Set git config for new repo
	git config --local user.email "pypi@tales.pw"
	git config --local user.name "pypi"

	# Upload new package
	yes | cp ../dist/*.whl ./
	git add --all
	git commit -a -m "update"
	git push
