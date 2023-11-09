ENV = dev

build:
	docker-compose build

up:
	docker-compose up -d

ps:
	docker-compose ps

stop:
	docker-compose stop

down:
	docker-compose down

terraform-fmt:
	docker-compose run --rm --entrypoint="terraform" terraform fmt -recursive

terraform-init:
	docker-compose run --rm --entrypoint="terraform" terraform -chdir=/app/envs/${ENV} init

terraform-plan:
	docker-compose run --rm --entrypoint="terraform" terraform -chdir=/app/envs/${ENV} plan

terraform-apply:
	docker-compose run --rm --entrypoint="terraform" terraform -chdir=/app/envs/${ENV} apply

terraform-destroy:
	docker-compose run --rm --entrypoint="terraform" terraform -chdir=/app/envs/${ENV} destroy
