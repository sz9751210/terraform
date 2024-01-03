# Makefile for managing Terraform deployments

.PHONY: up-% down-% up-all down-all help check-env

VALID_SERVICES := vpc eks asg alb efs
VALID_ENVS := env

.DEFAULT_GOAL := help

# Check if the environment variable is set
check-env:
ifndef ENV
	$(error ENV is undefined. Use 'make [target] ENV=lab' or 'ENV=prod')
endif
	@if ! echo $(VALID_ENVS) | grep -q -w $(ENV); then \
		echo "Error: Invalid environment. Valid environments are: $(VALID_ENVS)"; \
		exit 1; \
	fi

# Display help information
help:
	@echo "Usage: make [up|down]-SERVICE ENV=[environment]"
	@echo "       make [up|down]-all ENV=[environment]"
	@echo "Manage Terraform resources for the specified 'SERVICE'"
	@echo "Allowed services are: $(VALID_SERVICES)"
	@echo "Allowed environments are: $(VALID_ENVS)"

# Apply Terraform configuration
up-%: check-env
	@if echo $(VALID_SERVICES) | grep -w $* > /dev/null; then \
		echo "Applying Terraform in $* directory for $(ENV) environment"; \
		cd $*/$(ENV) && terraform init && terraform apply; \
	else \
		echo "Error: Invalid service. Valid services are: $(VALID_SERVICES)"; \
	fi

# Destroy Terraform resources
down-%: check-env
	@if echo $(VALID_SERVICES) | grep -w $* > /dev/null; then \
		echo "Destroying Terraform resources in $* directory for $(ENV) environment"; \
		cd $*/$(ENV) && terraform init && terraform destroy; \
	else \
		echo "Error: Invalid service. Valid services are: $(VALID_SERVICES)"; \
	fi

# Apply all Terraform configurations in sequence
up-all: check-env
	@$(MAKE) up-vpc ENV=$(ENV)
	@$(MAKE) up-eks ENV=$(ENV)
	@$(MAKE) up-alb ENV=$(ENV)
	@$(MAKE) up-asg ENV=$(ENV)
	@$(MAKE) up-efs ENV=$(ENV)

# Destroy all Terraform resources in reverse sequence
down-all: check-env
	@$(MAKE) down-efs ENV=$(ENV)
	@$(MAKE) down-asg ENV=$(ENV)
	@$(MAKE) down-alb ENV=$(ENV)
	@$(MAKE) down-eks ENV=$(ENV)
	@$(MAKE) down-vpc ENV=$(ENV)
