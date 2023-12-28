.PHONY: up-region-ip down-region-ip

up-region-ip:
	cd env && terraform init && terraform apply -auto-approve

down-region-ip:
	cd env && terraform init && terraform destroy
