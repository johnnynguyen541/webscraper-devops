# Web Scraper DevOps Project

Web scraper microservice cluster with full CI/CD pipeline using common industry DevOps tools.  This is the 2nd iteration of the Capstone project seen at this link here: [Github johnnynguyen541/webscraper-cluster](https://github.com/johnnynguyen541/webscraper-cluster).  The main updates are:

- Tech Debt Updates
- Migration of tech to more modern tech
    - From AWS CloudFormation to Terraform
    - From CircleCI to Jenkins
- Adding New Tech to full pipeline for observability and other purposes
    - Grafana
    - New Relic
    - Prometheus
    - Splunk
- Expanding the functionality
    - Updating code to have an `API service` and a `bot service`
    - Also use an RDS Cluster

See [Project Overview](docs/project-overview.md) for more specific info.

### Tech Stack

Technology         | Purpose
------------------ | ------------------
AWS                | Cloud Provider
Ansible            | IaC (Configuration Management)
Bash/Linux         | Scripting Language/OS
CircleCI           | CI/CD Build Tool
Docker             | IaC (Containerization)
Flask              | Python Web Framework for REST API
Grafana            | Data Visualization Tool
Jenkins            | CI/CD Build Tool
Kubernetes         | IaC (Container Orchestration)
New Relic          | Logging
Prometheus         | Infrastructure Monitoring
Python             | Programming Language
Splunk             | Logging
Swagger            | REST API Documentation
Terraform          | IaC (Infrastructure Provisioning)

### Project Structure

Files/Folders      | Description
------------------ | ------------------
`.ansible/`        | Ansible Playbooks for Infrastructure
`.circleci/`       | CircleCI Config Script
`.jenkins/`        | Jenkins Configs and Groovy Scripts
`.tfinfra/`        | Terraform IaC Files
`bash/`            | General Project Bash Scripts
`config/`          | Configuration Files used for Application and scripts
`docs/`            | Docs ie. [pipeline.png](docs/pipeline.png)
`lint/`            | Linting files
`src/`             | Project Apps - `scrape-api` - `scrape-bot`
`tests/`           | Unit Tests
`LICENSE.md`       | License for Project
`Makefile`         | Makefile: setup, install, test, lint, and all
`README.md`        | Project README file

Python App Files   | Description
------------------ | ------------------
`app/`             | Python Application Files
`Dockerfile`       | Docker Build File
`requirements.txt` | Python Library requirements file

## Pipeline

![Blue/Green Deployment](docs/pipeline.png)

## How To Run

### Install Linux

You must also install the Linux Packages in packages.txt.  Run the following in sudo:

`xargs -a lint/debian-packages.txt apt install`

### Install Hadolint

To install Hadolint

```shell
sudo wget -O /bin/hadolint https://github.com/hadolint/hadolint/releases/download/v1.16.3/hadolint-Linux-x86_64
sudo chmod +x /bin/hadolint
```

TBD