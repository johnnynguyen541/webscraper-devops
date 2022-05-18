# webscraper-cluster
Web scraper microservice cluster with full CI/CD pipeline using common industry DevOps tools.

## Phase 1

### Tech Stack
Technology         | Purpose
------------------ | ------------------
AWS                | Cloud Provider
Ansible            | IaC (Configuration Management)
Bash/Linux         | Scripting Language/OS
CircleCI           | CI/CD Tool
CloudFormation     | IaC (Infrastructure Provisioning)
Docker             | IaC (Containerization)
Flask              | Python Web Framework for REST API
Kubernetes         | IaC (Container Orchestration)
Python             | Programming Language

### Project Structure
Files/Folders      | Description
------------------ | ------------------
`.ansible/`        | Ansible Playbooks for Infrastructure
`.aws-cf-iac/`     | CloudFormation IaC Files
`.circleci/`       | CircleCI CI/CD Configuration File
`bash/`            | Bash Scripts (ie. `run_docker.sh`, `run_kubernetes.sh`, `upload_docker.sh`)
`config/`          | Configuration Files used for Application and scripts
`docs/`            | Project Documents ie. [proposal.md](docs/proposal.md), [requirements.md](docs/requirements.md), and [pipeline.drawio](docs/pipeline.drawio)/[pipeline.png](docs/pipeline.png)
`output/`          | Output Screen Shots
`src/`             | Project Applications - `scrape-api`
`tests/`           | Unit Tests
`LICENSE.md`       | License for Project
`Makefile`         | Makefile with steps: setup, install, test, lint, and all
`README.md`        | Project README file

Python App Files   | Description
------------------ | ------------------
`Dockerfile`       | Docker Build File
`requirements.txt` | Python Library requirements file

## Pipeline
![Blue/Green Deployment](pipeline.png)

## Phase 2

### Tech Stack
Technology         | Purpose
------------------ | ------------------
AWS                | Cloud Provider
Ansible            | IaC (Configuration Management)
Bash/Linux         | Scripting Language/OS
CircleCI           | CI/CD Tool
CloudFormation     | IaC (Infrastructure Provisioning)
Docker             | IaC (Containerization)
Flask              | Python Web Framework for REST API
Kubernetes         | IaC (Container Orchestration)
Prometheus         | Infrastructure Monitoring
Python             | Programming Language
Terraform          | IaC (Infrastructure Provisioning - TBD/May not be used)

### Project Structure
Files/Folders      | Description
------------------ | ------------------
`.ansible/`        | Ansible Playbooks for Infrastructure
`.aws-cf-iac/`     | CloudFormation IaC Files
`.circleci/`       | CircleCI CI/CD Configuration File
`.terraform-iac/`  | CloudFormation IaC Files
`bash/`            | Bash Scripts (ie. `run_docker.sh`, `run_kubernetes.sh`, `upload_docker.sh`)
`config/`          | Configuration Files used for Application and scripts
`docs/`            | Project Documents ie. [proposal.md](docs/proposal.md), [requirements.md](docs/requirements.md), and [pipeline.drawio](docs/pipeline.drawio)/[pipeline.png](docs/pipeline.png)
`output/`          | Output Screen Shots
`src/`             | Project Applications - `scrape-api` and `scrape-bot`
`tests/`           | Unit Tests
`LICENSE.md`       | License for Project
`Makefile`         | Makefile with steps: setup, install, test, lint, and all
`README.md`        | Project README file

Python App Files   | Description
------------------ | ------------------
`Dockerfile`       | Docker Build File
`requirements.txt` | Python Library requirements file
