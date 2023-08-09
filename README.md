# Setup Polkadot nodes in AWS using Terraform and Ansible.

* This repository is used to provison the ec2 instances in AWS using Terraform with multi AZ setup for different environment like dev, staging and prod.
* AWS terraform modules for VPC and EC2 has been used. In production setup we can write our own terraform module.
* The automation is done with the help of Makefile. The Makefile supports depploying the Terraform targets and Ansible targets.

## Prerequisites

The prerequisites for running the makefile targets we need to ensure that we have the following setup on out local environment:
1. **Terraform**: Terraform in required for provisioning cloud resources and infrastructure.
2. **AWS CLI**: The AWS CLI should be installed and configure the profile to connect to the AWS account.
3. **Ansible**: Ansible should be installed to run the playbooks against the ec2 instances. We can create a docker image with the prerequisite and run it against the target host by making use of the Makefile.

## Usage:

### Variables:
**ENV** - Environment for which the infrastructure should be provisioned(dev/staging/prod)

### Terraform Targets:
Modules used:
1. **VPC** - terraform-aws-modules/vpc/aws
2. **EC2** - terraform-aws-modules/ec2-instance/aws

Because of the time constrain I have used the modules available from the registry. In an actual scenario, self-hosted modules should be created and used.
The state file for the terraform showuld be stored in S3 with locking mechanism by using DynamoDB. For testing purpose I have used "local" backend for storing the terraform state file. I have created the resources for "dev" environment similarly we can create the resources for prod env.

Make target to create VPC and 2 ec2 instances in dev environment:

```
make terraform-apply ENV=dev
```
To delete created resources:
```
make terraform-destroy ENV=dev
```

### Ansible Targets:

Make target to install the Polkadot binary and configure the service
```
make install-polkadot
```

#### Steps to upgrade the Polkadot binary version with below setps:
Change the version of the polkadot binary version for variable "polkabot_binary_version" in ansible group_vars/all.yaml file. After this change run the ansible upgrade playbook with below make target:
 
 ```
 make upgrade-polkadot
 ```

### Important Note: 
I was not able to test the complete end to end deployment because of the large machine size required as a prerequisite for runnning the polkadot binary. In free tier account it is not possible.
