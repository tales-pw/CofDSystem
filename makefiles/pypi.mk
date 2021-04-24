pypi_setup_deps:
	python3 -m pip install wheel

pypi_build_package: build pypi_setup_deps
	python3 setup.py bdist_wheel

pypi_publish: pypi_build_package
	git clone git@github.com:tales-pw/PyPI ./PyPI
	cd PyPI

	yes | cp ../dist/*.whl ./

	git add --all
	git commit -a -m "update"
	git push
