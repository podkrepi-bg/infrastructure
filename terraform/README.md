# Terraform module for DigitalOcean infra
This folder contains the terraform module for spinning up the infrastructure needed to run the platform in Digital Ocean.

## Preparations
First, initialize the module by running:
```
terraform init
```

Then request access to the `Podkrepibg` organization in terraform HCP (for this contanct imilchev).

## Running the terraform
To apply changes run:
```
terraform apply -var do_token=<<digital ocean token>>
```