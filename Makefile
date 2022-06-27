######################
# Makefile - Install #
######################

install-lint-ansible:
	echo "Install Ansible Linter: ansible-lint"
	apt update
	apt -y install python3-pip
	pip3 install --upgrade pip &&\
		pip3 install -r lint/lint-ansible-requirements.txt

install-lint-bash:
	echo "Install Bash Linter: Linux Shell Check"
	apt update
	./bash/install-lint-bash.sh

install-lint-circleci:
	echo "Install CircleCI (YAML) Linter: yamllint"
	apt update
	apt -y install python3-pip
	pip3 install --upgrade pip &&\
		pip3 install -r lint/lint-circleci-requirements.txt

install-lint-docker:
	echo "Install Docker Linter: hadolint"
	./bash/install-lint-docker.sh

install-lint-groovy:
	echo "Install Groovy Linter: TBD"
	apt update
	./bash/install-lint-groovy.sh

install-lint-python:
	echo "Install Python Linter: Required Libraries"
	apt update
	apt -y install python3-pip
	pip3 install --upgrade pip &&\
		pip3 install -r lint/lint-python-requirements.txt

install-lint-tflint:
	echo "Install Terraform Linter: tflint"
	./bash/install-lint-tflint.sh

install-lint-all:
	install-lint-ansible
	install-lint-bash
	install-lint-circleci
	install-lint-docker
	install-lint-groovy
	install-lint-python
	install-lint-tflint

 # OTHER INSTALLS
install-app-scrape-api:
	echo "Install Scrape API"
	pip3 install --upgrade pip &&\
		pip3 install -r src/scrape-api/requirements.txt

install-app-scrape-bot:
	echo "Install Scrape Bot"
	echo "TODO"

install-app-scrape-rds:
	echo "Install Scrape RDS"
	echo "TODO"

install-test-unit:
	echo "Install Unit Test Libraries"
	pip3 install --upgrade pip &&\
		pip3 install -r tests/requirements.txt

install-app-all:
	install-app-scrape-api
	install-app-scrape-bot
	install-app-scrape-rds

install-all:
	echo "Install all Libraries"
	install-lint-all
	install-app-all
	install-test-unit

###################
# Makefile - Lint #
###################

lint-ansible:
	echo "Ansible Linter: ansible-lint"
	ansible-lint

lint-bash:
	echo "Lint Bash Scripts"
	find $(pwd) -iname *.sh | xargs shellcheck

lint-circleci:
	echo "CircleCI (YAML) Linter: yamllint"
	yamllint .circleci/config.yml

lint-docker:
	# See local hadolint install instructions:   https://github.com/hadolint/hadolint
	echo "Lint Dockerfile"
	hadolint src/*/Dockerfile

lint-groovy:
	echo "Groovy Linter"
	npm-groovy-lint .jenkins/

lint-python:
	echo "Lint Python Unit Tests"
	pycodestyle tests/*.py
	echo "Lint Python Applications"
	pycodestyle src/*/*/*.py

lint-tflint:
	echo "Terraform Linter: tflint"
	find .tfinfra/env/*/*/*/main.tf | xargs -L1 tflint
	find .tfinfra/modules/*/main.tf | xargs -L1 tflint
	find .tfinfra/services/*/*/main.tf | xargs -L1 tflint

lint-all:
	echo "Linting all files"
	lint-ansible
	lint-bash
	lint-circleci
	lint-docker
	lint-groovy
	lint-python
	lint-tflint

###################
# Makefile - Test #
###################

test-unit:
	echo "Python Unit Tests"
	python3 -m unittest tests/test_unit.py

test-integration:
	echo "Python Unit Tests"
	python3 -m unittest tests/test_integration.py 

test-smoke:
	echo "Python Smoke Tests"
	python3 -m unittest tests/test_smoke.py 
