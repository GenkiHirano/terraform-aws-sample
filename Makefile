ENV = dev

terraform-login:
	terraform -chdir=envs/${ENV} login

terraform-init:
	terraform -chdir=envs/${ENV} init

terraform-plan:
	terraform -chdir=envs/${ENV} plan

terraform-apply:
	terraform -chdir=envs/${ENV} apply

terraform-destroy:
	terraform -chdir=envs/${ENV} destroy

terraform-fmt:
	terraform fmt -recursive
