# DevOps Intern Final Assessment

An end-to-end DevOps project demonstrating the automation of a containerised
NGINX web application, from source control and continuous integration to
orchestrated deployment and centralised log aggregation.

## Project Objectives

- Manage application source code using Git and GitHub.
- Build and test a secure, lightweight NGINX Docker image.
- Automate linting, testing and image publishing with GitHub Actions.
- Publish versioned container images to GitHub Container Registry (GHCR).
- Deploy the application using HashiCorp Nomad and Consul.
- Aggregate and inspect application logs using Grafana Loki and Promtail.
- Document the architecture, implementation, testing and troubleshooting.

## Architecture

```text
Developer
    |
    v
GitHub Repository
    |
    v
GitHub Actions (CI/CD)
    |
    v
GitHub Container Registry
    |
    v
HashiCorp Nomad + Consul
    |
    v
NGINX Web Application
    |
    v
Promtail -> Grafana Loki -> Grafana
````

## Technology Stack

| Technology      | Purpose                             |
| --------------- | ----------------------------------- |
| Git and GitHub  | Source control                      |
| Linux Shell     | Automation and system checks        |
| Docker          | Application containerisation        |
| NGINX           | Web server                          |
| GitHub Actions  | Continuous integration and delivery |
| GHCR            | Container image registry            |
| HashiCorp Nomad | Container orchestration             |
| Consul          | Service discovery and health checks |
| Grafana Loki    | Log aggregation                     |
| Promtail        | Log collection                      |
| Grafana         | Log visualisation                   |

## Repository Structure

```
devops-intern-final/
├── README.md
├── .gitignore
├── app/
├── scripts/
├── .github/
│   └── workflows/
├── nomad/
├── monitoring/
└── docs/
    └── screenshots/
```

## Prerequisites

The development environment uses Kali Linux. The following tools are required\
for the complete implementation:

- Git
- Docker Engine
- Docker Compose
- ShellCheck
- Hadolint
- HashiCorp Nomad
- HashiCorp Consul
- curl

Exact versions and installation instructions will be documented as the\
implementation progresses.

## Implementation Status

- Repository initialized
- Project directory structure created
- NGINX application and Docker configuration
- Linux automation scripts
- GitHub Actions CI/CD pipeline
- GHCR image publishing
- Nomad deployment and Consul health checks
- Loki, Promtail and Grafana monitoring
- Screenshots and implementation documentation
- Final validation and v1.0.0 release

## Documentation

Implementation notes, architecture details, screenshots, testing evidence\
and troubleshooting records will be maintained in this repository.

## Author

Kpere Ragnar

## Project Status

Under development.\
