.PHONY: up-gce down-gce

up-gce:
	cd env && terraform init && terraform apply -auto-approve

down-gce:
	cd env && terraform init && terraform destroy
