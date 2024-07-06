#!/bin/bash

echo -e "$(cat terraform/terraform.tfstate | grep 'private_key_openssh":' | cut -d '"' -f4)" > server-key.pem

chmod 400 server-key.pem