# aws-terraform

## Terraform

envには、dev、stg、prodのいずれかを入れてください

### login

```shell
make terraform-login ENV=env
```

### init

```shell
make terraform-init ENV=env
```

### plan

```shell
make terraform-plan ENV=env
```

### apply

```shell
make terraform-apply ENV=env
```

### destroy

```shell
make terraform-destroy ENV=env
```

### fmt

```shell
make terraform-fmt
```
