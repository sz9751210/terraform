.PHONY: up-database down-database

up-database:
	cd env && terraform init && terraform apply -auto-approve
	
down-database:
	cd env && terraform init && terraform destroy
