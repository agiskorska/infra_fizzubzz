# Introduction

This repository is providing the infrastructure pipeline and root Infra as Code for the Fizz Buzz API.

## How to run

**On Mac**
Provide your set of variables in the file `variables.tfvars`. Then run the following:
    ```
        bash run.sh
    ```

**TODO: for Linux and Windows**
Add some code for running on different OS.

## How to begin

1. create a service principle with the appropriate permissions (Contributor) on the subscription level.

## Components

1. Azure DevOps Agent
1. Azure App Service Plan
1. Azure App Service

## Reasoning

This application is currently small and requires a few testing environments. If, however, it ever happend that the application should grow and more traffic got through the website, it would be advisable to deploy this app to an AKS cluster and, depending on the region, create CDNs in appropriate regions. For this to happen an appropriate network would have to be introduced with load balancers or other NVAs. Also a process of canary release should be introduced if the application grows big, where only a fraction of users get to use the new release at a time to prevent any uncontrollable damage.

## Improvements

1. Finish monitoring:
    * add alerts and groups
    * 