# Makefile for deploying to AWS EKS

# Set the default goal when 'make' is invoked without any target
.DEFAULT_GOAL := help

TF_CMD = terraform

# List of valid services
VALID_SERVICES := eks

.PHONY: create destroy up-% down-% help

create:
	cd env && terraform init && terraform apply -auto-approve

destroy:
	cd env && terraform init && terraform destroy

# Display help information
help:
	@echo "Usage: make up-SERVICE"
	@echo "Trigger Terraform by creating a EKS with the specified 'SERVICE'"
	@echo "Allowed services are: $(VALID_SERVICES)"

up-%:
	@if echo $(VALID_SERVICES) | grep -w $* > /dev/null; then \
		$(MAKE) create DIR=$*; \
	else \
		echo "Error: Invalid services. Valid services are: $(VALID_SERVICES)"; \
	fi

down-%: 
	@if echo $(VALID_SERVICES) | grep -w $* > /dev/null; then \
		$(MAKE) destroy DIR=$*; \
	else \
		echo "Error: Invalid services. Valid services are: $(VALID_SERVICES)"; \
	fi
