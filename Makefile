include .env

install:
	tfenv install

login:
	terraform -chdir=envs/${ENV} login

init:
	terraform -chdir=envs/${ENV} init

plan:
	terraform -chdir=envs/${ENV} plan

apply:
	terraform -chdir=envs/${ENV} apply

destroy:
	terraform -chdir=envs/${ENV} destroy

fmt:
	terraform fmt -recursive
