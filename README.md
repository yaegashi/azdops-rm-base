# azdops-rm-base

## Introduction

A cloud-native DevOps solution for [Redmine][redmine]/[RedMica][redmica] (RM Apps) with Azure Container Apps.

This repository provides GitOps for base resources on Azure that are shared by multiple RM App site instances, such as a database, container registry, storage account, and key vault.

|Repository|Description|
|-|-|
|[azdops-rm]|Documents|
|[azdops-rm-base]|RM Base GitOps: Database, Container Registry, Backups, etc. (This repository)|
|[azdops-rm-site]|RM Site GitOps: Azure Container Apps|
|[azdops-rm-docker]|RM App Container: Dockerfile, compose.yml, etc.|

[redmine]: https://github.com/redmine/redmine
[redmica]: https://github.com/redmica/redmica
[azdops-rm]: https://github.com/yaegashi/azdops-rm
[azdops-rm-base]: https://github.com/yaegashi/azdops-rm-base
[azdops-rm-site]: https://github.com/yaegashi/azdops-rm-site
[azdops-rm-docker]: https://github.com/yaegashi/azdops-rm-docker

## AZD Ops Instruction

This repository utilizes GitHub Actions and Azure Developer CLI (AZD) for the GitOps tooling (AZD Ops).
You can bootstrap an AZD Ops repository by following these steps:

1. Create a new **private** GitHub repository by importing from this repository. Forking is not recommended.
2. Copy the AZD Ops settings from `.github/azdops/main/inputs.example.yml` to `.github/azdops/main/inputs.yml` and edit it. You can do this using the GitHub Web UI.
3. Manually run the "AZD Ops Provision" workflow in the GitHub Actions Web UI. It will perform the following tasks:
    - Provision Azure resources using AZD with the `inputs.yml` settings. By default, a resource group named `{repo_name}-{branch_name}` will be created.
    - Make an AZD remote environment in the Azure Storage Account and save the AZD env variables in it.
    - Update `README.md` and `.github/azdops/main/remote.yml`, then commit and push the changes to the repository.
