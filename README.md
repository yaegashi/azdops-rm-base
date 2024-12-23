# dx2devops-rm-base

## Introduction

A cloud-native DevOps solution for [Redmine][redmine]/[RedMica][redmica] (RM Apps) with Azure Container Apps.

This repository provides GitOps for base resources on Azure that are shared by multiple RM App site instances, such as a database, container registry, storage account, and key vault.

|Repository|Description|
|-|-|
|[dx2devops-rm]|Documents|
|[dx2devops-rm-base]|RM Base GitOps: Database, Container Registry, Backups, etc. (This repository)|
|[dx2devops-rm-site]|RM Site GitOps: Azure Container Apps|
|[dx2devops-rm-docker]|RM App Container: Dockerfile, compose.yml, etc.|

[redmine]: https://github.com/redmine/redmine
[redmica]: https://github.com/redmica/redmica
[dx2devops-rm]: https://github.com/yaegashi/dx2devops-rm
[dx2devops-rm-base]: https://github.com/yaegashi/dx2devops-rm-base
[dx2devops-rm-site]: https://github.com/yaegashi/dx2devops-rm-site
[dx2devops-rm-docker]: https://github.com/yaegashi/dx2devops-rm-docker
