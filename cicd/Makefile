# Variables
EKS_SCRIPT_PATH = ./gen_aws_eks_file.sh
AWS_DIR = ../aws

# Default target
all: execute_command go_to_aws_and_make_up

# Target to execute the initial command
execute_command:
	@echo "Executing initial command..."
	@bash $(EKS_SCRIPT_PATH) || (echo "Failed to execute EKS script"; exit 1)

# Target to go to ../aws and execute make up-all
go_to_aws_and_make_up:
	@echo "Going to $(AWS_DIR) and executing 'make up-all'..."
	@cd $(AWS_DIR) && $(MAKE) up-all ENV=env || (echo "Failed to execute make up-all in AWS directory"; exit 1)

.PHONY: all execute_command go_to_aws_and_make_up
