FROM hashicorp/terraform:1.6.3

WORKDIR /app

COPY . .

ENTRYPOINT [ "/bin/sh", "-c" ]
