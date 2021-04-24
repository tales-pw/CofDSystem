pypi_setup_keys: guard-SSH_AUTH_SOCK guard-PYPI_DEPLOY_KEY
	ssh-agent -a $(SSH_AUTH_SOCK) > /dev/null
	ssh-add - <<< "$(PYPI_DEPLOY_KEY)"

pypi_setup_deps:
	python3 -m pip install wheel

pypi_build_package: build pypi_setup_deps
	python3 setup.py bdist_wheel

pypi_publish: pypi_setup_keys pypi_build_package
	git clone git@github.com:tales-pw/PyPI ./PyPI
	cd PyPI

	yes | cp ../dist/*.whl ./

	git add --all
	git config --local user.email "pypi@tales.pw"
	git config --local user.name "pypi"
	git commit -a -m "update"
	git push
