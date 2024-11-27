#!/bin/bash
rg_name=tfstate-rg-fizzbuzz
storage_name=tfstatestoragefizzbuzz
location=westeurope

terraform init \
  -backend-config="resource_group_name=$rg_name" \
  -backend-config="storage_account_name=$storage_name" \
  -backend-config="container_name=infrtfstate" \
  -backend-config="key=terraform.tfstate" 
terraform apply -var-file=variables.tfvars -auto-approve 
