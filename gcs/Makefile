# Makefile for deploying to Google Cloud Storage (GCS)

# Set the default goal when 'make' is invoked without any target
.DEFAULT_GOAL := help

# List of valid services
VALID_SERVICES := env

.PHONY: up-bucket reconfigure copy-backend-file pull-remote-state remove-backend-file destroy up-% down-% help

# Display help information
help:
	@echo "Usage: make up-SERVICE"
	@echo "Trigger Terraform by creating a GCS with the specified 'SERVICE'"
	@echo "Allowed services are: $(VALID_SERVICES)"

# Initialize and apply terraform configurations for the specified bucket directory
up-bucket:
	cd $(DIR) && terraform init && terraform apply

# Copy the temporary backend configuration to the actual backend configuration
copy-backend-file: 
	cd $(DIR) && cp backend.tf.tmp backend.tf

# Reinitialize terraform with state migration
reconfigure:
	cd $(DIR) && terraform init -migrate-state

pull-remote-state:
	cd $(DIR) && terraform state pull > terraform.tfstate

remove-backend-file:
	find . -type f -name "backend.tf" -exec rm -f {} \;

destroy:
	cd $(DIR) && terraform destroy

# Set up a bucket for a given service
up-%:
	@if echo $(VALID_SERVICES) | grep -w $* > /dev/null; then \
		$(MAKE) up-bucket copy-backend-file reconfigure DIR=$*; \
	else \
		echo "Error: Invalid services. Valid services are: $(VALID_SERVICES)"; \
	fi

down-%: 
	@if echo $(VALID_SERVICES) | grep -w $* > /dev/null; then \
		$(MAKE) pull-remote-state remove-backend-file reconfigure destroy DIR=$*; \
	else \
		echo "Error: Invalid services. Valid services are: $(VALID_SERVICES)"; \
	fi
