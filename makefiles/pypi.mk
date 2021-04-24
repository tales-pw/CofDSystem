PYPI_REPO_DIR="./PyPI"

pypi_setup_deps:
	python3 -m pip install wheel

pypi_build_package: build pypi_setup_deps
	python3 setup.py bdist_wheel

pypi_cleanup_repo:
	rm -rf $(PYPI_REPO_DIR)

.ONESHELL:
pypi_publish: pypi_cleanup_repo pypi_build_package
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
