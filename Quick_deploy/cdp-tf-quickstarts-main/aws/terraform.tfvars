# Copyright 2023 Cloudera, Inc. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# ------- Global settings -------
env_prefix = "avanis" # Required name prefix for cloud and CDP resources, e.g. cldr1

# ------- Cloud Settings -------
aws_region = "us-east-1" # Change this to specify Cloud Provider region, e.g. eu-west-1
aws_key_pair = "New_key.pem" # Change this with the name of a pre-existing AWS keypair, e.g. my-keypair

# ------- CDP Environment Deployment -------
deployment_template = "public"  # Specify the deployment pattern below. Options are public, semi-private or private

# ------- Network Settings -------
# **NOTE: If required change the values below any additional CIDRs to add the the AWS Security Groups**
ingress_extra_cidrs_and_ports = {
 cidrs = ["0.0.0.0/32"]
 ports = [443, 22]
}

# ------- Optional inputs for BYO-VPC -------
# **NOTE: Uncomment below settings if required

create_vpc=true ## Set to false to use pre-existing VPC

# cdp_vpc_id="<ENTER_EXISTING_VPC_ID>" # VPC ID for CDP environment. Required if create_vpc is false
# cdp_public_subnet_ids=["<ENTER_EXISTING_PUBLIC_SUBNET_ID>","<ENTER_EXISTING_PUBLIC_SUBNET_ID>"] # List of pre-existing public subnet ids. Required if create_vpc is false
# cdp_private_subnet_ids=["<ENTER_EXISTING_PRIVATE_SUBNET_ID>,<ENTER_EXISTING_PRIVATE_SUBNET_ID>"] # List of pre-existing private subnet ids. Required if create_vpc is false

# ------- Optional inputs for Control Plane Connectivity in fully private environment -------
# private_network_extensions=true # Set to false if external networking connectivity to CDP Control Plane exists