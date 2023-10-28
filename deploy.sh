#!/bin/bash

terraform apply --auto-approve
terraform output Cross_account_role_arn
#cdp environments create-aws-credential \
#--credential-name ${credential_name} --role-arn ${Cross_account_role_arn}
