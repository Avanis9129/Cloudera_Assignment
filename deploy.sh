#!/bin/bash
source variable.sh

#configure aws and cdp
aws configure set default.region ${aws_region}
aws configure set aws_access_key_id ${aws_access_key}
aws configure set aws_secret_access_key ${aws_secret_key}

cdp configure set default.region ${cdp_region}
cdp configure set cdp_access_key_id ${cdp_access_key}
cdp configure set cdp_private_key ${cdp_secret_key}

#deploy cdp
terraform apply --auto-approve

#deploy cml service
python -m venv ~/cdp-navigator; source ~/cdp-navigator/bin/activate;
pip install ansible-core ansible-navigator

rm -rf cloudera-deploy/
git clone https://github.com/cloudera-labs/cloudera-deploy.git; cd cloudera-deploy/public-cloud/aws/cml


#export AWS_PROFILE=default
#export CDP_PROFILE=default

ansible-navigator run main.yml