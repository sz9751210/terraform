.PHONY: up-vpc down-vpc

up-vpc:
	cd env && terraform init && terraform apply -auto-approve
	
down-vpc:
	cd env && terraform init && terraform destroy
