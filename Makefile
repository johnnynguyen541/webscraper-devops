install-python-lint:
	echo "Install Python Linting tools"
	pip3 install --upgrade pip &&\
		pip3 install -r lint/requirements.txt

install-hadolint:
	echo "Install hadolint"
	wget -O /bin/hadolint https://github.com/hadolint/hadolint/releases/download/v1.16.3/hadolint-Linux-x86_64 &&\
    chmod +x /bin/hadolint

install-tflint:
	echo "Install tflint"
	curl -s https://raw.githubusercontent.com/terraform-linters/tflint/master/install_linux.sh | bash

install-linux-linters:
	echo "Installlinting Debian Packages"
	xargs -a lint/debian-packages.txt apt install

install-scrape-api:
	echo "Install Scrape API library"
	pip3 install --upgrade pip &&\
		pip3 install -r src/scrape-api/requirements.txt

install-unit-test:
	echo "Install Unit Test Libraries"
	pip3 install --upgrade pip &&\
		pip3 install -r tests/requirements.txt

lint-python:
	echo "Lint Python Unit Tests"
	pycodestyle tests/*.py
	echo "Lint Python Applications"
	pycodestyle src/*/*/*.py

lint-bash:
	echo "Lint Bash Scripts"
	find $(pwd) -iname *.sh | xargs shellcheck

lint-docker:
	# See local hadolint install instructions:   https://github.com/hadolint/hadolint
	echo "Lint Dockerfile"
	hadolint src/scrape-api/Dockerfile

lint-aws-cf:
	echo "Lint AWS CloudFormation Templates"
	cfn-lint .aws-cf-iac/*.yml

test-unit:
	echo "Python Unit Tests"
	python3 -m unittest tests/test_unit.py 

test-smoke:
	echo "Python Smoke Tests"
	python3 -m unittest tests/test_smoke.py 

lint-all: lint-python lint-docker lint-aws-cf