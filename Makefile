TERRAFORM_DIR := $(shell pwd)/terraform
ANSIBLE_DIR := $(shell pwd)/ansible

########## Terraform targets ###############

.PHONY: terraform-init
terraform-init:
	@echo "Initializing Terraform"
	cd $(TERRAFORM_DIR)/$(ENV) && terraform init

.PHONY: terraform-validate
terraform-validate: terraform-init
	@echo "Validating Terraform"
	cd $(TERRAFORM_DIR)/$(ENV) && terraform validate

.PHONY: terraform-fmt
terraform-fmt: terraform-validate
	@echo "Formatting Terraform"
	cd $(TERRAFORM_DIR)/$(ENV) && terraform fmt

.PHONY: terraform-plan
terraform-plan: terraform-fmt
	@echo "Planning Terraform"
	cd $(TERRAFORM_DIR)/$(ENV) && terraform plan

terraform-apply: terraform-plan
	@echo "Applying Terraform"
	cd $(TERRAFORM_DIR)/$(ENV) && terraform apply --auto-approve
	cd ..

.PHONY: terraform-destroy
terraform-destroy:
	@echo "Destroying Terraform"
	cd $(TERRAFORM_DIR)/$(ENV) && terraform destroy --auto-approve
	cd ..

################### Ansible targets ###################

install-polkadot:
	@echo "Installing Polkadot..."
	ansible_playbook $(ANSIBLE_DIR)/playbooks/install.yaml

upgrade-polkadot:
	@echo "Upgrade Polkadot..."
	ansible_playbook $(ANSIBLE_DIR)/playbooks/upgrade.yaml
