#!/bin/bash

# Function to parse and export a variable
parse_export_var() {
    local var_name=$1
    local yaml_path=$2
    local format=$3
    local value

    if [ "$format" = "array" ]; then
        value=$(yq e "$yaml_path | map(\"\\\"\" + . + \"\\\"\") | join(\", \")" $yaml_file)
    else
        value=$(yq e "$yaml_path" $yaml_file)
    fi

    if [ -z "$value" ]; then
        echo "Error: Unable to extract $var_name"
        exit 1
    fi

    export $var_name="$value"
}

# Function to set Terraform template and output file paths
set_terraform_paths() {
    local base_path="../aws/$1/env"
    declare -gA TF_PATHS

    TF_PATHS[template]="$base_path/main.tf.tpl"
    TF_PATHS[backend_template]="$base_path/backend.tf.tpl"
    TF_PATHS[output_file]="$base_path/main.tf"
    TF_PATHS[backend_output_file]="$base_path/backend.tf"
}

# Define the YAML file and Terraform template file paths
yaml_file="${YAML_FILE:-config.yaml}"

# Set paths for EKS
set_terraform_paths "eks"
eks_terraform_template=${TF_PATHS[template]}
eks_terraform_backend_template=${TF_PATHS[backend_template]}
eks_output_terraform_file=${TF_PATHS[output_file]}
eks_output_terraform_backend_file=${TF_PATHS[backend_output_file]}

# Set paths for VPC
set_terraform_paths "vpc"
vpc_terraform_template=${TF_PATHS[template]}
vpc_terraform_backend_template=${TF_PATHS[backend_template]}
vpc_output_terraform_file=${TF_PATHS[output_file]}
vpc_output_terraform_backend_file=${TF_PATHS[backend_output_file]}

# Parse the YAML file and export variables
parse_export_var NAME_PREFIX '.NAME_PREFIX' 'single'
parse_export_var ENV_COND '.ENV_COND' 'single'
parse_export_var AWS_REGION '.AWS_REGION' 'single'
parse_export_var VPC_CIDR_ENV '.VPC.VPC_CIDR_ENV' 'single'
parse_export_var PUBLIC_SUBNET_ENV '.VPC.PUBLIC_SUBNET_ENV' 'array'
parse_export_var PRIVATE_SUBNET_ENV '.VPC.PRIVATE_SUBNET_ENV' 'array'
parse_export_var AZS_ENV '.VPC.AZS_ENV' 'array'

parse_export_var TARGET_REGION '.AWS_REGION' 'single'
parse_export_var CLUSTER_VERSION '.EKS.VERSION' 'single'
parse_export_var KUBE_PROXY_VERSION '.EKS.KUBE_PROXY_VERSION' 'single'
parse_export_var VPC_CNI_VERSION '.EKS.VPC_CNI_VERSION' 'single'
parse_export_var COREDNS_VERSION '.EKS.COREDNS_VERSION' 'single'
parse_export_var PUBLIC_ACCESS_CIDRS '.EKS.PUBLIC_ACCESS_CIDRS' 'array'
parse_export_var USERS '.EKS.USERS' 'array'

source utils/parse_node_groups.sh
NODE_GROUPS=$(parse_node_groups "$yaml_file")
export NODE_GROUPS

# Substitute variables in the Terraform template and create the final Terraform file
envsubst < $eks_terraform_template > $eks_output_terraform_file
envsubst < $eks_terraform_backend_template > $eks_output_terraform_backend_file
envsubst < $vpc_terraform_template > $vpc_output_terraform_file
envsubst < $vpc_terraform_backend_template > $vpc_output_terraform_backend_file

echo "Terraform file generated at $output_terraform_file"
