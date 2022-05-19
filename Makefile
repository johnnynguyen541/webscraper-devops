install-lint:
	echo "Install Linting tools"
	pip3 install --upgrade pip &&\
		pip3 install -r lint/requirements.txt
	wget -O /bin/hadolint https://github.com/hadolint/hadolint/releases/download/v1.16.3/hadolint-Linux-x86_64 &&\
    chmod +x /bin/hadolint

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