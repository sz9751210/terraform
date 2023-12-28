.PHONY: up-global-ip down-global-ip

up-global-ip:
	cd env && terraform init && terraform apply -auto-approve
down-global-ip:
	cd env && terraform init && terraform destroy
