.PHONY: up-ip-access-list down-ip-access-list

up-ip-access-list:
	cd env && terraform init && terraform apply -auto-approve
	
down-ip-access-list:
	cd env && terraform init && terraform destroy
