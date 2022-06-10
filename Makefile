######################
# Makefile - Install #
######################

install-lint-ansible:
	echo "Install Ansible Linter: ansible-lint"
	echo "TODO - Link: https://ansible-lint.readthedocs.io/en/latest/installing/"

install-lint-bash:
	echo "Install Bash Linter: Linux Shell Check"
	apt update
	xargs -a lint/linux-shellcheck.txt apt install

install-lint-docker:
	echo "Install Docker Linter: hadolint"
	wget -O /bin/hadolint https://github.com/hadolint/hadolint/releases/download/v1.16.3/hadolint-Linux-x86_64 &&\
    chmod +x /bin/hadolint

install-lint-groovy:
	echo "Install Groovy Linter: TBD"
	echo "TODO"

install-lint-python:
	echo "Install Python Linter: Required Libraries"
	pip3 install --upgrade pip &&\
		pip3 install -r lint/requirements.txt

install-lint-tflint:
	echo "Install Terraform Linter: tflint"
	curl -s https://raw.githubusercontent.com/terraform-linters/tflint/master/install_linux.sh | bash

install-scrape-api:
	echo "Install Scrape API library"
	pip3 install --upgrade pip &&\
		pip3 install -r src/scrape-api/requirements.txt

install-test-unit:
	echo "Install Unit Test Libraries"
	pip3 install --upgrade pip &&\
		pip3 install -r tests/requirements.txt

install-all: 

install-lint-all:


# Makefile - Lint

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

lint-all: lint-python lint-docker lint-aws-cf

# Makefile - Test


test-unit:
	echo "Python Unit Tests"
	python3 -m unittest tests/test_unit.py 

test-smoke:
	echo "Python Smoke Tests"
	python3 -m unittest tests/test_smoke.py 

