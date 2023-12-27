.PHONY: up_gce down_gce

up_gce:
	cd env && terraform init && terraform apply -auto-approve

down_gce:
	cd env && terraform init && terraform destroy
