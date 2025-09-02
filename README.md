# JohnsonApp – Scalable Web Application on Azure

## Project Overview
**JohnsonApp** is a cloud-native, scalable web application deployed on **Azure**, demonstrating modern cloud architecture and best practices. The project emphasizes **high availability, performance optimization, observability, and infrastructure as code**.

The goal was to create a fully functional web application with **managed hosting, monitoring, traffic routing, and automated deployment**, showcasing end-to-end cloud engineering skills.

---

## Architecture Overview
The project leverages the following Azure services:

| Component | Azure Service | Purpose |
|-----------|---------------|---------|
| Web Application | Azure App Service | Hosts the app in a fully managed, scalable environment |
| Traffic Routing & Load Balancing | Azure Front Door | Ensures high availability, global routing, and performance optimization |
| Application Monitoring | Application Insights | Tracks app performance, exceptions, and user behavior |
| Centralized Logging | Log Analytics Workspace | Collects metrics and logs for diagnostics and troubleshooting |
| Infrastructure as Code | Terraform | Automates infrastructure deployment and ensures reproducibility |
| CI/CD Pipeline | GitHub Actions | Automates build and deployment to staging environments |

**Optional Diagram:** Add a visual showing App Service, Front Door, Monitoring, and Terraform workflow.

---

## Key Features & Achievements
- Deployed a **scalable web application** using Azure App Service.
- Implemented **global traffic routing** with Azure Front Door for high availability.
- Enabled **monitoring and observability** using Application Insights and Log Analytics.
- Automated infrastructure provisioning with **Terraform**, following IaC best practices.
- Configured **CI/CD** pipelines using GitHub Actions for streamlined deployments.
- Demonstrates **full cloud lifecycle management**, from development to deployment and monitoring.

---

## Local Setup
To run the app locally:
```bash
git clone https://github.com/Cyberlearner01/Johnsonapp1.git
cd JohnsonApp
dotnet run --project JohnsonApp.csproj
