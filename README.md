# JohnsonApp – Azure Web App Deployment  

## Overview  
JohnsonApp is a scalable and secure web application deployed on **Azure App Service**.  
It demonstrates best practices such as custom domains, SSL/TLS, monitoring, disaster recovery, autoscaling, and CI/CD with GitHub Actions.  

## Features  
- **App Service Deployment** with deployment slots for zero-downtime releases  
- **Autoscaling** based on CPU and memory thresholds  
- **Azure Monitor** for application health and performance insights  
- **Disaster Recovery** with geo-redundant backups  
- **Secure Communication** using SSL/TLS certificates  
- **(Optional)** Zone Redundancy – *can be enabled in production for higher availability*  

## Architecture  
- **Frontend & Backend**: Hosted on Azure App Service  
- **Deployment**: GitHub Actions CI/CD workflow  
- **Monitoring**: Azure Monitor & Application Insights  
- **Protection**: Azure FrontDoor with WAF to ptotect the webapp from common web attacks
- **Autoscaling**: Autoscaling rule based on HTTP request count

## How to Deploy  
1. Clone the repository  
2. Set up an Azure App Service resource  
3. Link GitHub repo for CI/CD workflow  
4. Deploy to production slot  

## Future Improvements  
- Enable Zone Redundant App Service Plan  
- Add Azure Key Vault for secrets management  

## Author  
Johnson – Azure-Certified Cloud Specialist  

